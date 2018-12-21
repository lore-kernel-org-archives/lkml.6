Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AAB5C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 10:15:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A342218F0
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 10:15:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="b39Cq49a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389202AbeLUKP6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 05:15:58 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45098 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731021AbeLUKP5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 05:15:57 -0500
Received: by mail-wr1-f68.google.com with SMTP id t6so4629988wrr.12
        for <linux-kernel@vger.kernel.org>; Fri, 21 Dec 2018 02:15:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=9CMCVunv5zz/w8NhpB+qFHYsYIYVKqaykMl52Z2Q6Ww=;
        b=b39Cq49aBQgzbO6s1LEw0HGuwdgkdp0njU22ECkdxSSchab+innw6t/VNGUey1uZSH
         0T8Q8InbQiuQQi0A2ZbU1ovJBQfTi8x8ZZ/tRybpHopY5GVh+XhxkM/iQUu17hmPAGp8
         31RPhTQrOr4Ip5nCIrMFnh5jZoWBlhtKfbFnE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=9CMCVunv5zz/w8NhpB+qFHYsYIYVKqaykMl52Z2Q6Ww=;
        b=C3r6UFiUW/B5w3/8pyComMDK4/7+xJVP4P/Jmcc/H0xVnAne6HPKoCUbaZygCDKnyW
         Y+Hlo4C6WzFL6qsIyDdp90xqwY6mMt6Hd8N86QGvksI/4jJIc/Y608RZ/A/Zq+pzbBsL
         4ikc2UupH4jnsm5P7uiFqgxjh/q3XDzGLBAxID2BqYQJJtSB9e3KJ9IEYMvCzlrC+lwB
         STekTBu2RT4ptY7igTSASmiyZfzKXIDeRh9qN4Fa6RIXhrVlzjQCOuKkCvlX6oJdk41Q
         FDTSNKlmG4cZ5tcnhEqHPRSK3V8Mx7U6XIGnOjGJ4DzY1d+6Jx2iVkI0DEHkCgJKwqFv
         SfNg==
X-Gm-Message-State: AJcUukeaQ9hb/9U+Zl0B7//nfpWctxBtPyY94pwLs6hzh4+9jy9+ewx0
        fUr0ctfiMGsCX8dDCb4xLHBkLpuEVpg=
X-Google-Smtp-Source: ALg8bN5tNHy80KdeM7wwN3NeCnLgx3dnLt9TyH/LyhlJCMDehPlMwgExV9eCULpf172N/JdK5YuT6Q==
X-Received: by 2002:adf:b190:: with SMTP id q16mr1914394wra.95.1545387356037;
        Fri, 21 Dec 2018 02:15:56 -0800 (PST)
Received: from dell ([95.149.164.119])
        by smtp.gmail.com with ESMTPSA id w16sm12031250wrp.1.2018.12.21.02.15.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 21 Dec 2018 02:15:55 -0800 (PST)
Date:   Fri, 21 Dec 2018 10:15:53 +0000
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
Message-ID: <20181221101553.GI13248@dell>
References: <20181214113410.22848-1-m.szyprowski@samsung.com>
 <CGME20181214113418eucas1p2bfb6f0d04010e73f6ca35c3a6664b316@eucas1p2.samsung.com>
 <20181214113410.22848-4-m.szyprowski@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181214113410.22848-4-m.szyprowski@samsung.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Dec 2018, Marek Szyprowski wrote:

> From: Seung-Woo Kim <sw0312.kim@samsung.com>
> 
> This driver can be used to communicate with Bluetooth chip in high-speed
> UART mode, so increase the maximum baudrate to 3Mbps.
> 
> Signed-off-by: Seung-Woo Kim <sw0312.kim@samsung.com>
> [mszyprow: rephrased commit message]
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  drivers/tty/serial/samsung.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/samsung.c b/drivers/tty/serial/samsung.c
> index 2a49b6d876b8..9fc3559f80d9 100644
> --- a/drivers/tty/serial/samsung.c
> +++ b/drivers/tty/serial/samsung.c
> @@ -1287,7 +1287,7 @@ static void s3c24xx_serial_set_termios(struct uart_port *port,
>  	 * Ask the core to calculate the divisor for us.
>  	 */
>  
> -	baud = uart_get_baud_rate(port, termios, old, 0, 115200*8);
> +	baud = uart_get_baud_rate(port, termios, old, 0, 3000000);

Does that mean the low speed devices will stop working?  It looks like
this should be dynamically configurable based on what device is
connected to it, no?

>  	quot = s3c24xx_serial_getclk(ourport, baud, &clk, &clk_sel);
>  	if (baud == 38400 && (port->flags & UPF_SPD_MASK) == UPF_SPD_CUST)
>  		quot = port->custom_divisor;

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
