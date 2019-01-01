Return-Path: <SRS0=7Uv1=PJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1E8AC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Jan 2019 09:35:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B467C2080D
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Jan 2019 09:35:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uqG8RDXv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728371AbfAAJf5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Jan 2019 04:35:57 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:50623 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727063AbfAAJf5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jan 2019 04:35:57 -0500
Received: by mail-wm1-f65.google.com with SMTP id n190so24637156wmd.0;
        Tue, 01 Jan 2019 01:35:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=iI9FGjRB9GDBaZaCOaqt3gBhhI3O1IyHOXTusYRHJKo=;
        b=uqG8RDXvWNYwiCvQaC40AyUrX/Q9sclFkwT2fk/NI2Lx/xCAwm8/rpih/z9nRgMRJv
         2OptbUs7yISiy/LJ3miEE8b8Azp63j9JpIbT1MUr9JtdEVPGOsUQTQ2HBhqY1vMZ6gfN
         DRdv72EkpkxEpZ3rxVWAs5BnNNzfXeaDTGPKArTqNEw8upa9SiUW8IzbQcQtenAbDMss
         W8j66mGdeuS9FY/G52+NXsr0McqBbwBnTGNBhUApWe3b4HfkVqPnYmUKHbID+ImapgW1
         kJkWTR5ffUNBxahSi43/mofxKi4M0TFC7cl1Q8zVsfeMq1aGcNSvEDNbsEBLYWjYopZM
         tW/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=iI9FGjRB9GDBaZaCOaqt3gBhhI3O1IyHOXTusYRHJKo=;
        b=ZqPPhe3foaSO4S+cr0vhSuVIub4uGv09sTzNqul+9koZDkafGc3jEKQ3gM75LJftGk
         0DCI/u95nKxgV21kfUj0XExnzS0kS6+5g66fVK/cL/iMqX2DKuMoog+XK1o3TksZigKJ
         yTN0NFd7wvtuvW/PiMhXaUZ56gFZs00g60enLeCP+zwSpwGhhiJt23Sfb5EuamATzBUc
         RQKmwTQZijMMz3l+PtaHMEduXYz89hBduDLMzTuT066twmx0FqZjiuGX4BKUfYM7wy0x
         PbvsKM6Sqiwj1z3oB9gbhVWV/MS6KK1oxoV5m/YJkItMtFrH8uGK6ewXsQ9HE7dkH0BQ
         OrhA==
X-Gm-Message-State: AJcUukdNwD9YCjYqeB+aCFnRTDd0xrM1kMtgMMif9tUFme3t7tP7runn
        4GP51OysQq52h1YpxKPBEUjHNTy9
X-Google-Smtp-Source: ALg8bN5qPZZ4VEiUKJDqS0jm/ZghfVuCYQ0MVBgc9z4wo8OzgEaRI0xZnRiIBjhk3JEtlu5B13SmcA==
X-Received: by 2002:a1c:8acd:: with SMTP id m196mr33488210wmd.120.1546335354581;
        Tue, 01 Jan 2019 01:35:54 -0800 (PST)
Received: from ?IPv6:2003:ea:8bcf:e300:4822:3f9a:2eec:6a82? (p200300EA8BCFE30048223F9A2EEC6A82.dip0.t-ipconnect.de. [2003:ea:8bcf:e300:4822:3f9a:2eec:6a82])
        by smtp.googlemail.com with ESMTPSA id z14sm28615805wrm.48.2019.01.01.01.35.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 Jan 2019 01:35:53 -0800 (PST)
Subject: Re: [PATCH] net: core: Fix to store new mtu setting in netdevice.
To:     Murali Krishna Policharla <murali.policharla@broadcom.com>,
        davem@davemloft.net, amritha.nambiar@intel.com,
        ecree@solarflare.com, ktkhai@virtuozzo.com,
        alexander.h.duyck@intel.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1546324934-17555-1-git-send-email-murali.policharla@broadcom.com>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Message-ID: <cc6976a3-a59f-8d68-a662-75f5199a6de3@gmail.com>
Date:   Tue, 1 Jan 2019 10:35:49 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1546324934-17555-1-git-send-email-murali.policharla@broadcom.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01.01.2019 07:42, Murali Krishna Policharla wrote:
> Store newly configured mtu settings in the netdevice after mtu
> configuration is successful to the dsa switch.
> 

At first: good that this is fixed, so far each network driver
had to do the "dev->mtu = new_mtu" in its ndo_change_mtu
callback what can be removed now.

I think the commit description could be improved, the change
isn't specific to dsa switches at all.

And the patch should be annotated "net" because it's a fix.

> Fixes: 2315dc91a5 ("net: make dev_set_mtu() honor notification return code")
> Signed-off-by: Murali Krishna Policharla <murali.policharla@broadcom.com>
> Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
> ---
>  net/core/dev.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/net/core/dev.c b/net/core/dev.c
> index 722d50d..58617aa 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -7586,12 +7586,15 @@ int dev_change_flags(struct net_device *dev, unsigned int flags)
>  int __dev_set_mtu(struct net_device *dev, int new_mtu)
>  {
>  	const struct net_device_ops *ops = dev->netdev_ops;
> +	int ret = 0;
>  
>  	if (ops->ndo_change_mtu)
> -		return ops->ndo_change_mtu(dev, new_mtu);
> +		ret = ops->ndo_change_mtu(dev, new_mtu);
>  
> -	dev->mtu = new_mtu;
> -	return 0;
> +	if (ret >= 0)
> +		dev->mtu = new_mtu;
> +
> +	return ret;
>  }
>  EXPORT_SYMBOL(__dev_set_mtu);
>  
> 

