Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48FD8C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 19:27:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04E3822506
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 19:27:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=soleen.com header.i=@soleen.com header.b="jRLM9XR8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04E3822506
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=soleen.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726510AbeKMFWT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 00:22:19 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:42315 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725790AbeKMFWT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 00:22:19 -0500
Received: by mail-qk1-f195.google.com with SMTP id m5so15384422qka.9
        for <linux-kernel@vger.kernel.org>; Mon, 12 Nov 2018 11:27:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9bK+gzQLuKY79RPbvo3kKmdJhCipAQkgVnNU9Jm1Kn8=;
        b=jRLM9XR8onQUSbnerEGcxqGmWdALddDoA16gmxoEE4pu/yjB4jUxSlq5pfa4kC6unW
         wj82NAy+oPRvLXwjy0yjzy0DbftczMB1iZ7/orzO4CPsFyP54bcmyp3pOSh0gZROml+f
         XL49Gk4u8TFuO2a6zIrgJ9Bu+W+BHRRD2CZwptu0zRl580k5XI+Qp4bUxfOXRRF4rnml
         EEYfATltzvKt5DjnN8B2F+soMy+9e9xFxZ35ORP8RlDu5sw0Gh8l/EU+6h7a1s8drwGW
         mWV52xHoFGLDtNBZbKEXPE2UfkA21a5mlVsk1HZO1JVj1qyJhxg7cWk0b+/RtC/9ZkDC
         8Ufw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9bK+gzQLuKY79RPbvo3kKmdJhCipAQkgVnNU9Jm1Kn8=;
        b=gOuM1hGqHXwqb/g3PllnDha9NjyhUUzWRucHftBgmLaOUc5n6qee2khVrUZOjqvCTT
         ZXb4igrkfTP3Xbbsw75FFyCbHBVZQHKml9LptWuBUND3X6mUqQkWdU25PAacDX0klETD
         acqhZHbqGCLfIWqR9unzIzuqksroMCQ0N+EPREZJ3QSMI6NCLEv6Gwi+XqR7JZagLOC/
         q37uCYA3LpdjEPtFShYnR9ZSjh3nMIuofw0xyYRmYvvP0YgAcEB0jkLFy08lNLcSWiIp
         rpgniSlnOCp1Wjs1cR8pLKVj6PV3My9aAxejy9qJ2/1W07M1g2pXgwcD5jnN6pxVRRgX
         1qYw==
X-Gm-Message-State: AGRZ1gIWF4KEeMGBuSHKmgUbmr00mCJCnoBbQwNrB61wo/aUd+M1sIrl
        fmtW2e9PA/QwRj40keEvimdtgQ==
X-Google-Smtp-Source: AJdET5fe4oe1LywYx62/sAVCzk4ctvhE3zjihbxo18wKcOi8no/FUoqoOSbJMKOpv4Y9uenj45pkQQ==
X-Received: by 2002:ac8:36d9:: with SMTP id b25mr2229258qtc.49.1542050861754;
        Mon, 12 Nov 2018 11:27:41 -0800 (PST)
Received: from soleen.tm1wkky2jk1uhgkn0ivaxijq1c.bx.internal.cloudapp.net ([40.117.208.181])
        by smtp.gmail.com with ESMTPSA id b17sm9486891qkj.69.2018.11.12.11.27.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 12 Nov 2018 11:27:40 -0800 (PST)
Date:   Mon, 12 Nov 2018 19:27:38 +0000
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
To:     Oscar Salvador <osalvador@techadventures.net>
Cc:     akpm@linux-foundation.org, mhocko@suse.com,
        dan.j.williams@intel.com, yasu.isimatu@gmail.com,
        rppt@linux.vnet.ibm.com, malat@debian.org,
        linux-kernel@vger.kernel.org, pavel.tatashin@microsoft.com,
        jglisse@redhat.com, Jonathan.Cameron@huawei.com, rafael@kernel.org,
        david@redhat.com, dave.jiang@intel.com, linux-mm@kvack.org,
        alexander.h.duyck@linux.intel.com,
        Oscar Salvador <osalvador@suse.de>
Subject: Re: [PATCH 3/5] mm/memory_hotplug: Check for IORESOURCE_SYSRAM in
 release_mem_region_adjustable
Message-ID: <20181112192738.n3cbsgtbjokikvco@soleen.tm1wkky2jk1uhgkn0ivaxijq1c.bx.internal.cloudapp.net>
References: <20181015153034.32203-1-osalvador@techadventures.net>
 <20181015153034.32203-4-osalvador@techadventures.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181015153034.32203-4-osalvador@techadventures.net>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18-10-15 17:30:32, Oscar Salvador wrote:
> From: Oscar Salvador <osalvador@suse.de>
> 
> This is a preparation for the next patch.
> 
> Currently, we only call release_mem_region_adjustable() in __remove_pages
> if the zone is not ZONE_DEVICE, because resources that belong to
> HMM/devm are being released by themselves with devm_release_mem_region.
> 
> Since we do not want to touch any zone/page stuff during the removing
> of the memory (but during the offlining), we do not want to check for
> the zone here.
> So we need another way to tell release_mem_region_adjustable() to not
> realease the resource in case it belongs to HMM/devm.
> 
> HMM/devm acquires/releases a resource through
> devm_request_mem_region/devm_release_mem_region.
> 
> These resources have the flag IORESOURCE_MEM, while resources acquired by
> hot-add memory path (register_memory_resource()) contain
> IORESOURCE_SYSTEM_RAM.
> 
> So, we can check for this flag in release_mem_region_adjustable, and if
> the resource does not contain such flag, we know that we are dealing with
> a HMM/devm resource, so we can back off.
> 
> Signed-off-by: Oscar Salvador <osalvador@suse.de>
> ---
>  kernel/resource.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/kernel/resource.c b/kernel/resource.c
> index 81937830a42f..c45decd7d6af 100644
> --- a/kernel/resource.c
> +++ b/kernel/resource.c
> @@ -1272,6 +1272,22 @@ int release_mem_region_adjustable(struct resource *parent,
>  			continue;
>  		}
>  
> +		/*
> +		 * All memory regions added from memory-hotplug path
> +		 * have the flag IORESOURCE_SYSTEM_RAM.
> +		 * If the resource does not have this flag, we know that
> +		 * we are dealing with a resource coming from HMM/devm.
> +		 * HMM/devm use another mechanism to add/release a resource.
> +		 * This goes via devm_request_mem_region and
> +		 * devm_release_mem_region.
> +		 * HMM/devm take care to release their resources when they want,
> +		 * so if we are dealing with them, let us just back off here.
> +		 */
> +		if (!(res->flags & IORESOURCE_SYSRAM)) {
> +			ret = 0;
> +			break;
> +		}
> +
>  		if (!(res->flags & IORESOURCE_MEM))
>  			break;

Reviewed-by: Pavel Tatashin <pasha.tatashin@soleen.com>

A couple nits, re-format above comment block to fill 80-char limit:
      /*
       * All memory regions added from memory-hotplug path have the
       * flag IORESOURCE_SYSTEM_RAM.  If the resource does not have
       * this flag, we know that we are dealing with a resource coming
       * from HMM/devm.  HMM/devm use another mechanism to add/release
       * a resource.  This goes via devm_request_mem_region and
       * devm_release_mem_region.  HMM/devm take care to release their
       * resources when they want, so if we are dealing with them, let
       * us just back off here.
       */

I would set ret = 0, at the beginning instead of -EINVAL, and change
returns accordingly.


Thank you,
Pasha
