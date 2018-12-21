Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55A5FC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 10:34:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A770218FD
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 10:34:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="BjPWSvQ+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389844AbeLUKei (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 05:34:38 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55921 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389775AbeLUKeh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 05:34:37 -0500
Received: by mail-wm1-f65.google.com with SMTP id y139so4786030wmc.5
        for <linux-kernel@vger.kernel.org>; Fri, 21 Dec 2018 02:34:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=5Y19zuzSqc9p2luwScoBbAjH4RpfwqJjgdh8XtxhdCM=;
        b=BjPWSvQ+t648JuNmWUC2aMJ4zTdkp8qwcZ9Df/PINusReBFK1vGuPfmNg25d4HHPcO
         ZeV7e/c0s+yXg5woVt3IpX1LZrBNFShERbNuOR5i5hxSXFxRBBDKXGWZIBJjX/9/We3a
         vtXZFZ3w3/1/nlAwa3XFV721I3WpUL/2i4QhA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=5Y19zuzSqc9p2luwScoBbAjH4RpfwqJjgdh8XtxhdCM=;
        b=qyJGMldrC74CQ+ixIxtri6Uzpx8kJ9DH585Ngn2sr1lowtQViAxqlPxIf5mSwHk4ly
         5kk9CWBuj/Rhig/G0F1lKXcwxSc9YxCctsTqNI8R/DyELQV/buxbMhsqFpiEy9lamp6P
         kwVMp/4nAmLI9MbYnnjea1S80Xcb7xz14F0d0uRJk+/pFykLphS7dnvwYxuRaDrw3tlx
         4miqOo/0eQ1jPJUfeHdGBqclr8IJzYIxmsRr6VUghtDvN0KQ+5dgVncdoWV1/LtxN9RN
         eOGq3Es0A/oEUKdSS3VD2T9ajUbOmcOCcLvLEblPfhGpe1uzJ73iY8OWKTeATEdTkj6I
         jnLg==
X-Gm-Message-State: AA+aEWYGg4tik68oyej+l/UZci4IJDIdQvDhOywpbUI/tpnVeawZQR37
        PfGi0emDh6pa82pZfCIGfppwFw==
X-Google-Smtp-Source: AFSGD/UrdFRCUTsA/ubqz+ZDYO4mWXbXgbElaOra6uReot7Lm9MnRBMHE6ws684/P/mlaDVhAec4kg==
X-Received: by 2002:a1c:7dd7:: with SMTP id y206mr2257280wmc.50.1545388475870;
        Fri, 21 Dec 2018 02:34:35 -0800 (PST)
Received: from dell ([95.149.164.119])
        by smtp.gmail.com with ESMTPSA id 60sm15526264wrb.81.2018.12.21.02.34.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 21 Dec 2018 02:34:34 -0800 (PST)
Date:   Fri, 21 Dec 2018 10:34:33 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Beomho Seo <beomho.seo@samsung.com>,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 3/4] tty: serial: samsung: Increase maximum baudrate
Message-ID: <20181221103433.GJ13248@dell>
References: <20181214113410.22848-1-m.szyprowski@samsung.com>
 <CGME20181214113418eucas1p2bfb6f0d04010e73f6ca35c3a6664b316@eucas1p2.samsung.com>
 <20181214113410.22848-4-m.szyprowski@samsung.com>
 <20181221101553.GI13248@dell>
 <9be9bcd6-5b8a-da40-b232-a650eaa88d38@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9be9bcd6-5b8a-da40-b232-a650eaa88d38@samsung.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Dec 2018, Marek Szyprowski wrote:
> On 2018-12-21 11:15, Lee Jones wrote:
> > On Fri, 14 Dec 2018, Marek Szyprowski wrote:
> >> From: Seung-Woo Kim <sw0312.kim@samsung.com>
> >>
> >> This driver can be used to communicate with Bluetooth chip in high-speed
> >> UART mode, so increase the maximum baudrate to 3Mbps.
> >>
> >> Signed-off-by: Seung-Woo Kim <sw0312.kim@samsung.com>
> >> [mszyprow: rephrased commit message]
> >> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> >> ---
> >>  drivers/tty/serial/samsung.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/tty/serial/samsung.c b/drivers/tty/serial/samsung.c
> >> index 2a49b6d876b8..9fc3559f80d9 100644
> >> --- a/drivers/tty/serial/samsung.c
> >> +++ b/drivers/tty/serial/samsung.c
> >> @@ -1287,7 +1287,7 @@ static void s3c24xx_serial_set_termios(struct uart_port *port,
> >>  	 * Ask the core to calculate the divisor for us.
> >>  	 */
> >>  
> >> -	baud = uart_get_baud_rate(port, termios, old, 0, 115200*8);
> >> +	baud = uart_get_baud_rate(port, termios, old, 0, 3000000);
> > Does that mean the low speed devices will stop working?  It looks like
> > this should be dynamically configurable based on what device is
> > connected to it, no?
> 
> The changed parameter is maximum supported rate, so this change doesn't
> affect any low speed device.

Understood.  Thanks for the explanation.

> >>  	quot = s3c24xx_serial_getclk(ourport, baud, &clk, &clk_sel);
> >>  	if (baud == 38400 && (port->flags & UPF_SPD_MASK) == UPF_SPD_CUST)
> >>  		quot = port->custom_divisor;
> 
> Best regards

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
