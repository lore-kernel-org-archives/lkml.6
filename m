Return-Path: <SRS0=Aihr=QY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8654C4360F
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 05:26:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75B3D21B69
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 05:26:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gn2XQv/e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727371AbfBQF0j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Feb 2019 00:26:39 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40620 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725372AbfBQF0i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Feb 2019 00:26:38 -0500
Received: by mail-pf1-f196.google.com with SMTP id h1so6891989pfo.7;
        Sat, 16 Feb 2019 21:26:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xfnRCat7M1mkzZzhlFs9ZZ5CDTR9Y8VW/uLrQG/qHF0=;
        b=gn2XQv/erYDPT1dJbK+jMKWSDHSRapRGVGF2ZW8pEnKT6Bb0XwABc9i5/jh0HniZmQ
         Y7jsaY6FYDOPPwxHdDViKkwkJnCFV1z2JGw0Asb9jTNXbfqKnmL1S+1LrXDxcO0Emz77
         iehBcbIFxrD+xbpHUGjRabxMkdh5uEGaFavVXAyFlHaX+BmAiX+A1dQyEOoINQzLXshj
         YGVZRRnQjY/ZisLdgV3VZoPemul/qeIGTGC0DD6pBS9grbDC0EZFXm/FQcKrLQx8VJNY
         1yHVRHfHvd/ixtvDm1464s5oWsJWWNVaVJZ1uKWV4jT4SCNzzSeNUlsJD3y82U3A1oe0
         A/cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xfnRCat7M1mkzZzhlFs9ZZ5CDTR9Y8VW/uLrQG/qHF0=;
        b=p56wYMsWzEtRaCkajM73psp04DIZsMBmsWk4HdbkaXYFYm4F/ghNDMYilLQbh1XPl7
         Tdc/69WjMUwCG7hR1r+MShzeApoMawgz1slTnWuPiBBdpiLHnfTVLeB4fiET0mzVH0MJ
         w0hU6YkW2Z4QA3QPMl3dlG8J7fSLarUYikwV0ZyqR0wqt8ClQkXUwCReXG0RiAxonocA
         Y8ODY+QZ9Dzw5zB5ks/3PvHEa5g3ZTpHmKFsCkY3UJZRcYl1U86Df1QaUuzN+ME8nXWm
         xDNzG6wYzSLuStlnXqsVIeKQky9q84OPCDVIs8t3oZV/+QbmK0AKNageUl7XK5lFH5D8
         k0yQ==
X-Gm-Message-State: AHQUAuZaXSW3Z5TBOXhMJdTCduHc8hDqJaBh5QAmfJcUS213rzW49v5O
        Wn+MK/yUhED3qL71zUzuUUo=
X-Google-Smtp-Source: AHgI3IYrlQY7K+I6VV8/JJGX/+sRRVxvoRhDe6awPZP0A4Ra4rgzOrdWJpRgeeMqc/ZBWbfB5ywzHw==
X-Received: by 2002:a62:2bc4:: with SMTP id r187mr17845355pfr.25.1550381196891;
        Sat, 16 Feb 2019 21:26:36 -0800 (PST)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id p6sm9162926pgd.69.2019.02.16.21.26.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 16 Feb 2019 21:26:36 -0800 (PST)
Date:   Sat, 16 Feb 2019 21:26:34 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     gabriel.fernandez@st.com
Cc:     linux-clk@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-input@vger.kernel.org, giuseppe.condorelli@st.com,
        Nate Drude <nate.drude@ohmlinxelectronics.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH v1] Input: st-keyscan - fix potential zalloc NULL
 dereference
Message-ID: <20190217052634.GA107793@dtor-ws>
References: <20190212153055.3925-1-gabriel.fernandez@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190212153055.3925-1-gabriel.fernandez@st.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 12, 2019 at 04:30:55PM +0100, gabriel.fernandez@st.com wrote:
> From: Gabriel Fernandez <gabriel.fernandez@st.com>
> 
> This patch fixes the following static checker warning:
> 
> drivers/input/keyboard/st-keyscan.c:156 keyscan_probe()
> error: potential zalloc NULL dereference: 'keypad_data->input_dev'
> 
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Gabriel Fernandez <gabriel.fernandez@st.com>

Applied, thank you.

> ---
>  drivers/input/keyboard/st-keyscan.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/input/keyboard/st-keyscan.c b/drivers/input/keyboard/st-keyscan.c
> index babcfb165e4f..3b85631fde91 100644
> --- a/drivers/input/keyboard/st-keyscan.c
> +++ b/drivers/input/keyboard/st-keyscan.c
> @@ -153,6 +153,8 @@ static int keyscan_probe(struct platform_device *pdev)
>  
>  	input_dev->id.bustype = BUS_HOST;
>  
> +	keypad_data->input_dev = input_dev;
> +
>  	error = keypad_matrix_key_parse_dt(keypad_data);
>  	if (error)
>  		return error;
> @@ -168,8 +170,6 @@ static int keyscan_probe(struct platform_device *pdev)
>  
>  	input_set_drvdata(input_dev, keypad_data);
>  
> -	keypad_data->input_dev = input_dev;
> -
>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	keypad_data->base = devm_ioremap_resource(&pdev->dev, res);
>  	if (IS_ERR(keypad_data->base))
> -- 
> 2.17.0
> 

-- 
Dmitry
