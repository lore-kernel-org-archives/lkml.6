Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FCB3C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 18:35:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C4B82075E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 18:35:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R1ZWgPd+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C4B82075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727726AbeIGXR2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 19:17:28 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42526 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726614AbeIGXR2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 19:17:28 -0400
Received: by mail-pg1-f196.google.com with SMTP id y4-v6so7386255pgp.9;
        Fri, 07 Sep 2018 11:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=OXJdNCpnPhQt4MiRGToLbyF6K1iNSNHbnQ29S8dtswg=;
        b=R1ZWgPd+hUOsyVrvnHRq9kZPispNPCNFCTaZeEwKysIqPD/4xh+HOaVspgqBnIfT2D
         a47mCOQuEwaJ6EBzNjpLWOW2+4dXFwRQErboqi+G9laD9r+oMtpnlcOyX65XzOCoElcP
         gt0gAu5Xp7vRzazGt0jdFSz5YYW7yU1Djf3SleCNvcd42uXs6UynQAk8wqqAxpW/Hfky
         FZMHNAkZGvJYpEs+fq4TMVOeuTrd1Sd6ODqwZxkPR+IuUJSFissgCpjnoi87Eim6VSDd
         KZz4SYUGbiB44rG5ep0klISMNBWKuwTAew7Y2Zug+fWQ7cl5PF3uhxgYNyZyD0cVjVvk
         wMtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OXJdNCpnPhQt4MiRGToLbyF6K1iNSNHbnQ29S8dtswg=;
        b=P1FFnrFfNrWY4SIpTalXKay0xTBKXRhv68TaFBrDK0tmEBEw//gYAxJDv8l1hgyVm+
         MPUouvIs9+c6UApdau9eCR5rJsqi0UfeDOMqA8fRivzDEDeU2gdfuhmWcZeU0adciOc4
         dlQiHP367cGD7GTjbKS+Ds1Ph2S5X/uUJ/xfilyj6A7iRnsr5x+9X3aMC5hQvkieavM4
         fA5xCRHwZmdRecwD6SLh4dfmIN6KGup/q1pFrLwlG8QTkHvO+gSEyasZmNQw9r6ez54E
         1I14povu551LBoldjSZgn8apj5vchx1+ALaxHm4kTcffj+MTyksOEYtnAbsZY7OdfYqB
         nanA==
X-Gm-Message-State: APzg51AZX1dTtBX8nM4XUhkQeIjwP1F9Y5yMdpkIL7c3RxkQf3tmy5Zc
        6XrK6ApLPgOdBIbBApl9+nk=
X-Google-Smtp-Source: ANB0VdaJcMpTMPIO8IMPSQ3xE0b+Mj/6TbbgKb0CzeHlAg7FrCYsUz9rL4QjygX3JExfXCtdIHNlAg==
X-Received: by 2002:a62:c082:: with SMTP id g2-v6mr10047383pfk.72.1536345316089;
        Fri, 07 Sep 2018 11:35:16 -0700 (PDT)
Received: from [192.168.1.70] (c-24-6-192-50.hsd1.ca.comcast.net. [24.6.192.50])
        by smtp.gmail.com with ESMTPSA id l6-v6sm12094922pfl.169.2018.09.07.11.35.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Sep 2018 11:35:15 -0700 (PDT)
Subject: Re: [PATCH] of: Split up name & type in modalias generation
To:     Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180907142247.2931-1-thierry.reding@gmail.com>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <4dcc060e-2780-d187-9c8b-1507fec7e3ef@gmail.com>
Date:   Fri, 7 Sep 2018 11:35:14 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180907142247.2931-1-thierry.reding@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/07/18 07:22, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> The kernel's vsnprintf() implementation discards all alpha-numeric
> characters following a %p conversion specifier. This is done in order to
> generically skip any of the various modifiers that the kernel supports.
> Unfortunately, the OF modalias is generated with a format string that
> violates the assumption made by vsnprintf():
> 
> 	of:N%pOFnT%s
> 
> While processing the above format string, vsnprintf() will eat the 'T'
> character, assuming that it belongs to the preceeding %p specifier. This
> results in a modalias with an incompatible format, which in turn causes
> the automatic loading of drivers based on modalias to no longer work.
> 
> To fix this, split up the generation of the name & type fields into two
> separate snprintf() calls to avoid confusing the parser.
> 
> Fixes: 73813f8483b1 ("of: Convert to using %pOFn instead of device_node.name")
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
> Note that a more elegant fix would be to make the %p format specifier
> parser report back the exact number of characters consumed. I briefly
> tried to implement it, but quickly ran into numerous special cases
> that make this solution rather involved.
> 
> I can spend some more time to improve this in general if that's what we
> ultimately want, but I think this patch is a better short-term fix to
> workaround the issue.
> ---
>  drivers/of/device.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/of/device.c b/drivers/of/device.c
> index daa075d87317..dabef9fc8538 100644
> --- a/drivers/of/device.c
> +++ b/drivers/of/device.c
> @@ -218,14 +218,20 @@ static ssize_t of_device_get_modalias(struct device *dev, char *str, ssize_t len
>  	if ((!dev) || (!dev->of_node))
>  		return -ENODEV;
>  
> -	/* Name & Type */
> -	csize = snprintf(str, len, "of:N%pOFnT%s", dev->of_node,
> -			 dev->of_node->type);
> +	/* Name */
> +	csize = snprintf(str, len, "of:N%pOFn", dev->of_node);
>  	tsize = csize;
>  	len -= csize;
>  	if (str)
>  		str += csize;
>  
> +	/* Type */
> +	csize = snprintf(str, len, "T%s", dev->of_node->type);
> +	tsize += csize;
> +	len -= csize;
> +	if (str)
> +		str += csize;
> +
>  	of_property_for_each_string(dev->of_node, "compatible", p, compat) {
>  		csize = strlen(compat) + 1;
>  		tsize += csize;
> 

Reviewed-by: Frank Rowand <frank.rowand@sony.com>
