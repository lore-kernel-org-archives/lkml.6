Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67B9AC43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 12:15:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AD702086B
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 12:15:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FjuUzCip"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AD702086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728955AbeIYSW0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 14:22:26 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:34664 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727507AbeIYSW0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 14:22:26 -0400
Received: by mail-pf1-f194.google.com with SMTP id k19-v6so11128638pfi.1;
        Tue, 25 Sep 2018 05:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gQtaM9eknJxnHWhohwXfKlfTu7V5+kzZCuLhwZEH/OE=;
        b=FjuUzCipu/AXBKYV7TV9In3RoeDSwuvZVvYaXWTxX1BaUl6z/+3OS/eRAE7+3ldHKF
         lu4iMcE9hu43clTeScYND8i+A6aLZkCeKEWRwEF8h65On1u2CQVKVU0i5XTxdkVmn1f3
         XoXfVjxdSph7j3WoZKdHnNEPCTgoA4fHnG5OjPON6T2NQN769q+m7mrXiiTdJBWV1RuJ
         9c7tM+8GEOMGoOBaMh41PNYAq5S1jQfppxYTHKX7/LGImT2BBNvGssA2Oqy30I+3n3y4
         MkfKS8cpzWZS2y4pG8gjuunoiSQXD39kADfbWK/lg7Qa6gTVrq3bg4H5A1jVD0GdVjVu
         2Bsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gQtaM9eknJxnHWhohwXfKlfTu7V5+kzZCuLhwZEH/OE=;
        b=QiUSgh2oQG31OJd71ZUYd52brFLBH2ShQTvmF11RXcK0ZwooC1UxGGe3/iyFxLk0dz
         E/AzGqhqIisydxwHx3fRRRACREjRTMhRqMx38ZrD9IHxptfmzOyLXfzpq1IXtQJ+8oOr
         LTbyv6V93I8zy064RKtzaSt5Hup7rEj73XIaGRGw6FmHfNWL/GjA487iOg2nlooaiNax
         0afgfH/cDYesXRTJeT9raM+RxxrZDuRFdyBdsO+hMtN852+SJ7TaB8x8pJc5cDBXq3ZY
         tMF+ZGTZORFfZLKcGIGZZXmi6u7qFcy3PcjWycxbq+FOUNw0520nqaAmPEN2+lwEeFHt
         qfgQ==
X-Gm-Message-State: ABuFfogpZ0IFcC5XzSTfWYolDHAB+Vn4lrUW3G+HIhPbmz34fSk0svaq
        abuXrhWsgE7rAOxekaQd/H0=
X-Google-Smtp-Source: ACcGV61TrZaw8pSev8G9dD7XkP4N2kB4Rn0vImS95/K4AjA8SgoaIBOURC8qjFXW9wSxMWn+8uwIiQ==
X-Received: by 2002:a65:6398:: with SMTP id h24-v6mr804943pgv.245.1537877708816;
        Tue, 25 Sep 2018 05:15:08 -0700 (PDT)
Received: from localhost (14-202-194-140.static.tpgi.com.au. [14.202.194.140])
        by smtp.gmail.com with ESMTPSA id p75-v6sm4299662pfi.22.2018.09.25.05.15.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 25 Sep 2018 05:15:08 -0700 (PDT)
Date:   Tue, 25 Sep 2018 22:15:04 +1000
From:   Balbir Singh <bsingharora@gmail.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-acpi@vger.kernel.org, xen-devel@lists.xenproject.org,
        devel@linuxdriverproject.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Rashmica Gupta <rashmica.g@gmail.com>,
        Michael Neuling <mikey@neuling.org>
Subject: Re: [PATCH v2 5/6] powerpc/powernv: hold device_hotplug_lock when
 calling memtrace_offline_pages()
Message-ID: <20180925121504.GH8537@350D>
References: <20180925091457.28651-1-david@redhat.com>
 <20180925091457.28651-6-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180925091457.28651-6-david@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 25, 2018 at 11:14:56AM +0200, David Hildenbrand wrote:
> Let's perform all checking + offlining + removing under
> device_hotplug_lock, so nobody can mess with these devices via
> sysfs concurrently.
> 
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Rashmica Gupta <rashmica.g@gmail.com>
> Cc: Balbir Singh <bsingharora@gmail.com>
> Cc: Michael Neuling <mikey@neuling.org>
> Reviewed-by: Pavel Tatashin <pavel.tatashin@microsoft.com>
> Reviewed-by: Rashmica Gupta <rashmica.g@gmail.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  arch/powerpc/platforms/powernv/memtrace.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/platforms/powernv/memtrace.c b/arch/powerpc/platforms/powernv/memtrace.c
> index fdd48f1a39f7..d84d09c56af9 100644
> --- a/arch/powerpc/platforms/powernv/memtrace.c
> +++ b/arch/powerpc/platforms/powernv/memtrace.c
> @@ -70,6 +70,7 @@ static int change_memblock_state(struct memory_block *mem, void *arg)
>  	return 0;
>  }
>  
> +/* called with device_hotplug_lock held */
>  static bool memtrace_offline_pages(u32 nid, u64 start_pfn, u64 nr_pages)
>  {
>  	u64 end_pfn = start_pfn + nr_pages - 1;
> @@ -111,6 +112,7 @@ static u64 memtrace_alloc_node(u32 nid, u64 size)
>  	end_pfn = round_down(end_pfn - nr_pages, nr_pages);
>  
>  	for (base_pfn = end_pfn; base_pfn > start_pfn; base_pfn -= nr_pages) {
> +		lock_device_hotplug();

Why not grab the lock before the for loop? That way we can avoid bad cases like a
large node being scanned for a small number of pages (nr_pages). Ideally we need
a cond_resched() in the loop, but I guess offline_pages() has one.

Acked-by: Balbir Singh <bsingharora@gmail.com>
