Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 750FDC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 14:03:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13ED920854
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 14:03:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Gb7w5oM1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13ED920854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728522AbeIJS6A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 14:58:00 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35243 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727674AbeIJS57 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 14:57:59 -0400
Received: by mail-wm0-f66.google.com with SMTP id o18-v6so21659631wmc.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Sep 2018 07:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=i7G8iUEfLLUo2MTa7fT0n1AH65ynbGeAzUGTuiMCMLE=;
        b=Gb7w5oM1zjjbop0x/3JpxvlVfftxb+Wuz1RlcoynpG+YG+HRjzsFsA0yguvpDumP8T
         yIVf69kwaT7cB+rhDNATaLHW5bNaB02yinZrxeoEPBQBoRiD24cEmm5MLKL5+S96UkJc
         ruZbw+7jNWpPVnzvk57fbqENOf1t3c0m1TnOM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=i7G8iUEfLLUo2MTa7fT0n1AH65ynbGeAzUGTuiMCMLE=;
        b=DQN3vxMeoMlMvgcsC+JghwFl6AwRlt5U9g2jGUdp/qg+6fC7H+gg0J2I+xjuczEayH
         H2uOmItNwhUGuhyfO9dxy3M3nfuMHMrgRbICjozhP01pQg/+oUQgas/Rrq675JUImbch
         cFLMslUdwrImrI2y+4f2MN8QrQfVY3/tZZINKZfAuAvviyxUz6VLG+AK+bmlijqZyMBX
         LRyAgIKbYbDHfkzD29G5HO284DG//gM+5G+KGXAYhf4G70fYnVMFq2HiYcM2ZGpw2Yqi
         VazmxCL2LGCAoCK5hRbe8eL3+GQGBwPddKdA82sVzMGp+kJP/Aq35GFQ/pZ9R9BdpLEp
         b2CQ==
X-Gm-Message-State: APzg51CKU89bygEraUMbdJo2IWEq5bXr39fMckL348NSGtP8z1kkQ9OJ
        EUSoeDcxKtMXvW6Qg0nlIdamTWRNDtUY/g==
X-Google-Smtp-Source: ANB0VdYlUtBCBrEi7IUTBTVFmM49Y2+7f7mkl50LKHzWOlVqBjkx547zjTK5+OQK0oog4YOMA5vf3w==
X-Received: by 2002:a1c:2807:: with SMTP id o7-v6mr874524wmo.60.1536588223307;
        Mon, 10 Sep 2018 07:03:43 -0700 (PDT)
Received: from dell ([2.27.167.7])
        by smtp.gmail.com with ESMTPSA id v16-v6sm16448080wrw.12.2018.09.10.07.03.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Sep 2018 07:03:42 -0700 (PDT)
Date:   Mon, 10 Sep 2018 15:03:40 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Marcel Ziswiler <marcel@ziswiler.com>
Cc:     linux-kernel@vger.kernel.org,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>
Subject: Re: [RESEND PATCH] mfd: stmpe: honor gpio interrupt probe deferral
Message-ID: <20180910140340.GR28860@dell>
References: <20180814130155.29973-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180814130155.29973-1-marcel@ziswiler.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Aug 2018, Marcel Ziswiler wrote:

> From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> 
> Actually honor probe deferral in trying to get the GPIO interrupt as
> of_get_named_gpio_flags() in stmpe_of_probe() may as well just do so.
> 
> Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> 
> ---
> 
>  drivers/mfd/stmpe.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/mfd/stmpe.c b/drivers/mfd/stmpe.c
> index 566caca4efd8..4d6ffd3ef398 100644
> --- a/drivers/mfd/stmpe.c
> +++ b/drivers/mfd/stmpe.c
> @@ -1331,6 +1331,8 @@ int stmpe_probe(struct stmpe_client_info *ci, enum stmpe_partnum partnum)
>  		return -ENOMEM;
>  
>  	stmpe_of_probe(pdata, np);
> +	if (-EPROBE_DEFER == pdata->irq_gpio)
> +		return -EPROBE_DEFER;

EPROBE_DEFER usually means "stop what you're doing and return", rather
than "do a few more things, then return".  With that in mind, I would
rather you convert stmpe_of_probe() to return and int containing the
appropriate error as soon as it is detected.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
