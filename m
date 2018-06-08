Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id d0hGI91YGlu1WQAAmS7hNA
	; Fri, 08 Jun 2018 10:22:35 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 0BF7A606FA; Fri,  8 Jun 2018 10:22:35 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="XFFeuu75"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id A54EA60590;
	Fri,  8 Jun 2018 10:22:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A54EA60590
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752734AbeFHKWb (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 06:22:31 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:41160 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751216AbeFHKW3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 06:22:29 -0400
Received: by mail-pl0-f66.google.com with SMTP id az12-v6so8051239plb.8
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jun 2018 03:22:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=9USEF2CNRAHvrdTmfb05cZukP02HwDm9ILBiKM18c4M=;
        b=XFFeuu75crYKDCVRHwt9WG86X652rybdPqMUgvei+OyyhRRY6fZk/Dq7M1shXgk3DA
         kb9UENqrhntT9GljJa1CcBZlFhqfwNkDvdd5LjxPLUDKItqDLww59TklgUAswwSjSKJw
         E+fGXRs/nna5tVC68e/6depRyWkg145aZ5e1U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=9USEF2CNRAHvrdTmfb05cZukP02HwDm9ILBiKM18c4M=;
        b=VxZ5aAcKG6u7zFBuKs9m2nWckKCmuLCr3PUn51S34AiL8XT1hf5geuRngVpmp7nROG
         mjnP54k8JSzftQwidnZdx0NgN5vKDRlEaRCm6OH1tM9kRCP56Rip+iePPMd4ylIsrmcl
         ATJlTn7GI2mV8BMy3EWCQLTuIpPIFRbMlUA/dLu8CAUPN3ouzVBJY9WgIVaZjsQh8eGq
         nsZzZTWIQ4YcCQKvuoCiR6IOmiHzbvOKxjXTJdQ2+RsXOwHogwVDdOhS3pG5tcw+9t7v
         48kv6vLZjb5A+5aYpUXYzIgq7v4X3qR+UOj2ZytOWpMbMu85/22FxcUVyzNjVbzgZBKQ
         zPNQ==
X-Gm-Message-State: APt69E3e5bcnmQVx2YIVX4l5kwl44fVl6nyXyfF6XEbP9SkJjhSCTOuF
        FsLE7ne5u5ydENRv6L7Cli1o
X-Google-Smtp-Source: ADUXVKJs/DJ6uli+5S8RJcMEiNRaHoBknxMYbFvrg1/ecN4xXJnDGIL3OpI1f/Yo7lKIkK7rDx30bA==
X-Received: by 2002:a17:902:b416:: with SMTP id x22-v6mr5999454plr.267.1528453349087;
        Fri, 08 Jun 2018 03:22:29 -0700 (PDT)
Received: from linaro.org ([103.59.133.81])
        by smtp.gmail.com with ESMTPSA id 9-v6sm36048387pfn.129.2018.06.08.03.22.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Jun 2018 03:22:28 -0700 (PDT)
Date: Fri, 8 Jun 2018 15:52:21 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pinctrl: actions: Fix uninitialized error in
 owl_pin_config_set()
Message-ID: <20180608102221.GA11497@linaro.org>
References: <1528452347-23986-1-git-send-email-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1528452347-23986-1-git-send-email-geert@linux-m68k.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 08, 2018 at 12:05:47PM +0200, Geert Uytterhoeven wrote:
> With gcc 4.1.2:
> 
>     drivers/pinctrl/actions/pinctrl-owl.c: In function ‘owl_pin_config_set’:
>     drivers/pinctrl/actions/pinctrl-owl.c:336: warning: ‘ret’ may be used uninitialized in this function
> 
> Indeed, if num_configs is zero, the uninitialized value will be returned
> as an error code.
> 
> Fix this by preinitializing it to zero.
> 
> Fixes: 2242ddfbf4d699b5 ("pinctrl: actions: Add Actions S900 pinctrl driver")
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org> 

Thanks,
Mani
> ---
>  drivers/pinctrl/actions/pinctrl-owl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pinctrl/actions/pinctrl-owl.c b/drivers/pinctrl/actions/pinctrl-owl.c
> index 76243caa08c630c0..b5c880b50bb371f5 100644
> --- a/drivers/pinctrl/actions/pinctrl-owl.c
> +++ b/drivers/pinctrl/actions/pinctrl-owl.c
> @@ -333,7 +333,7 @@ static int owl_pin_config_set(struct pinctrl_dev *pctrldev,
>  	unsigned long flags;
>  	unsigned int param;
>  	u32 reg, bit, width, arg;
> -	int ret, i;
> +	int ret = 0, i;
>  
>  	info = &pctrl->soc->padinfo[pin];
>  
> -- 
> 2.7.4
> 
