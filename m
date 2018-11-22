Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 183DFC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 08:28:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE08120864
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 08:28:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="K1cHJtMs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE08120864
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393057AbeKVTHK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 14:07:10 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:37128 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730527AbeKVTHK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 14:07:10 -0500
Received: by mail-lj1-f195.google.com with SMTP id e5-v6so7201326lja.4
        for <linux-kernel@vger.kernel.org>; Thu, 22 Nov 2018 00:28:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=UpOTJxdBjHvmAL+anlIkP8EFXqg4Q7+BI3zX6ZZdmMQ=;
        b=K1cHJtMswBtdgrILIcoteus77GDhgrt/gUliJmFOCVimuSV4VW+pLbicrSyr6zEPRL
         KC7N/GEeKcMIIN85KwkYucqT/VJtJ1xDe38B+7kSRfln3OjJtbmahNP6gVykG1v1V9mY
         HxwdlO5Fmnv91VHf/FIOYdy+40vSdiwOYWgbXD3caf9WAR12skR7af/K9iXF8FJcosMh
         AveVjSjZ2sprlgz8H7EgX4o/mQaPHhfDIIu6YQjJStaukctigYPa1hV22drEtnx9JHMb
         SRF4WyNYAKW5ccZuVwI/5h4rpLB9myXoCYN4rQUHvCCgInz9ZvyVKMEJmNi1rXVZxx8+
         /06Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UpOTJxdBjHvmAL+anlIkP8EFXqg4Q7+BI3zX6ZZdmMQ=;
        b=Y4kmcH4P4Vwg4ABDykUZxrkcFCqGJFKyl4oxZWcPTVemaOrb5ag4e7QNxCiPK6IVLg
         XBSkV3m4YnRS3EobLn0Io4dAgh/JipgwRWrKh9Is6Xem0IfMkJ5YnXkvLb8p3XVmAarU
         Fa4zakmL9UEB9tDrYOTFuhQIXlfLrL9GGoGf0UEDyywimB274wqP3VBJe3Z6q65p2urk
         aRWD5G3XhOLUD39P2/kcmBkv/sTQDKeX0WEXD02OPzE9HSc3QU/lReqVmynI90rEhgnV
         h8BUvWnB9FZmI97cUaUw9HGpKMw65MYDzhgJJA30F1fi0AXunEkns1oALd214aM+D/8i
         8Qyg==
X-Gm-Message-State: AA+aEWaaJrtx84/ymkfxqgGlsQ/B9yNWQNezbGwElkx0j5n2wPt3YBvq
        +OnuIYCWKFT2F6Pa5jWfxr4jimqeqSc=
X-Google-Smtp-Source: AFSGD/WmhCSr9eTwULx6tpUYjW+PBFU22BMTvwWoRE3U7XdLRa3PCPgfqEVCZ5Y+ZsOFAboieyLMbQ==
X-Received: by 2002:a2e:914b:: with SMTP id q11-v6mr6095042ljg.164.1542875324146;
        Thu, 22 Nov 2018 00:28:44 -0800 (PST)
Received: from [192.168.0.200] ([31.173.80.84])
        by smtp.gmail.com with ESMTPSA id p91sm6384006lfg.4.2018.11.22.00.28.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Nov 2018 00:28:43 -0800 (PST)
Subject: Re: [PATCH] net: amd: add of_node_put()
To:     Yangtao Li <tiny.windzz@gmail.com>, davem@davemloft.net,
        yuehaibing@huawei.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20181121125824.22168-1-tiny.windzz@gmail.com>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <9ec3ef0c-b931-6a1e-e1ed-5538c42df830@cogentembedded.com>
Date:   Thu, 22 Nov 2018 11:28:21 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181121125824.22168-1-tiny.windzz@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 21.11.2018 15:58, Yangtao Li wrote:

> of_find_node_by_path() acquires a reference to the node
> returned by it and that reference needs to be dropped by its caller.
> bl_idle_init() doesn't do that, so fix it.

    Again, maybe sparc_lance_probe_one() doesn't do that?

> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> ---
>   drivers/net/ethernet/amd/sunlance.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/amd/sunlance.c b/drivers/net/ethernet/amd/sunlance.c
> index b4fc0ed5bce8..9d4899826823 100644
> --- a/drivers/net/ethernet/amd/sunlance.c
> +++ b/drivers/net/ethernet/amd/sunlance.c
> @@ -1419,7 +1419,7 @@ static int sparc_lance_probe_one(struct platform_device *op,
>   
>   			prop = of_get_property(nd, "tpe-link-test?", NULL);
>   			if (!prop)
> -				goto no_link_test;
> +				goto node_put;
>   
>   			if (strcmp(prop, "true")) {
>   				printk(KERN_NOTICE "SunLance: warning: overriding option "
> @@ -1428,6 +1428,8 @@ static int sparc_lance_probe_one(struct platform_device *op,
>   				       "to ecd@skynet.be\n");
>   				auxio_set_lte(AUXIO_LTE_ON);
>   			}
> +node_put:
> +			of_node_put(nd);
>   no_link_test:
>   			lp->auto_select = 1;
>   			lp->tpe = 0;

MBR, Sergei

