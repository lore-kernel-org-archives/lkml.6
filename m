Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E2BCC43444
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:54:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D23C206B6
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:54:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho-ws.20150623.gappssmtp.com header.i=@tycho-ws.20150623.gappssmtp.com header.b="JcGQYfCr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391746AbfAKOyv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:54:51 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:50263 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390477AbfAKOyt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:54:49 -0500
Received: by mail-it1-f195.google.com with SMTP id z7so2866370iti.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jan 2019 06:54:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tycho-ws.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=uJh/pMTsGneTKaKggyvXF+Sg9B2wbRdl3/xWASaoeJw=;
        b=JcGQYfCr0JAkjBFuTWcLasw8AQZ+fTJzH8LyaRL8LAp8Zh8uneEWnO1VqaQLOAjB0r
         HMBtrlwZEzKilvHbM3I3jUn6BVPEyAh64wzW9U/YwxMxpUmcjtg1QRIgJHo++a0v2Fwa
         5cz01rN1NeWfZdn8q+LQgxhtBkyCW7rEauev9VhGi2fimSrQIPyI9sxbIJd3PPxuf1NH
         Uqa59o2TEYkxG4fDOtRajtWdH044la6qzI3LVPnCNFUEUwqNoHYw6/Lh7nlGuEJKSKvy
         mdG4WtIkXb4KuW03qGLNMCDUFjgwEN16yFKRFu38CRWlqqOiQpv1WhIysxhmchpISxMb
         G7AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uJh/pMTsGneTKaKggyvXF+Sg9B2wbRdl3/xWASaoeJw=;
        b=k+UCv3ZVGBTNoODR3ySVjqPVII/P1MfdlCgTunL1NVEOG1DmDatLyqrR5oEvupy+G5
         TDLTuyaokPRAX3JCRZNkrxAVXjiT7JNqPxTY5eonDAn5M2WGkvVe/3flv4ZzLHgSbcD+
         kHGnOELvpchghH4pNgpG4Md6rt7Z3s83wIWB56PLJASFnqEMCIJLIQ2KL/7798vpfXhd
         F7vC+fQbXA/Jcg0xexMWlN/lMpcvP+HG5n/RakL2tvCjZWREAsjrpHf6W0ZewxELUBxp
         eO7BhbHxwjVvPansHH0R357PdT/CYZhRyFb1G3JRTtjlT38msg4WpLFY4FYCqAw2t4EN
         8yBA==
X-Gm-Message-State: AJcUukeMwfNuVReLOnpgDzkxN5LlCjD5ibJeUC/ez9jBKojzYOXb5YC1
        yn/ZGroI9ghjE/6AamoCpUjVbw==
X-Google-Smtp-Source: ALg8bN6KCMZX9D782XIM0sEno9u8EK/u/rCjLFpSCEvmMj5+Pt/LjL9iF+g6YFTIunFQgkmw/L9Fjg==
X-Received: by 2002:a24:fe06:: with SMTP id w6mr1349599ith.108.1547218488492;
        Fri, 11 Jan 2019 06:54:48 -0800 (PST)
Received: from cisco ([2601:282:901:dd7b:c69:9cc7:f9cf:ff1b])
        by smtp.gmail.com with ESMTPSA id l21sm15740077ioh.42.2019.01.11.06.54.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 11 Jan 2019 06:54:47 -0800 (PST)
Date:   Fri, 11 Jan 2019 07:54:45 -0700
From:   Tycho Andersen <tycho@tycho.ws>
To:     Khalid Aziz <khalid.aziz@oracle.com>
Cc:     juergh@gmail.com, jsteckli@amazon.de, ak@linux.intel.com,
        torvalds@linux-foundation.org, liran.alon@oracle.com,
        keescook@google.com, konrad.wilk@oracle.com,
        Juerg Haefliger <juerg.haefliger@canonical.com>,
        deepa.srinivasan@oracle.com, chris.hyser@oracle.com,
        tyhicks@canonical.com, dwmw@amazon.co.uk,
        andrew.cooper3@citrix.com, jcm@redhat.com,
        boris.ostrovsky@oracle.com, kanth.ghatraju@oracle.com,
        joao.m.martins@oracle.com, jmattson@google.com,
        pradeep.vincent@oracle.com, john.haxby@oracle.com,
        tglx@linutronix.de, kirill.shutemov@linux.intel.com, hch@lst.de,
        steven.sistare@oracle.com, kernel-hardening@lists.openwall.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [RFC PATCH v7 07/16] arm64/mm, xpfo: temporarily map dcache
 regions
Message-ID: <20190111145445.GA4102@cisco>
References: <cover.1547153058.git.khalid.aziz@oracle.com>
 <eba179acbfdea5a646c5548cb82138c1c3b74aa2.1547153058.git.khalid.aziz@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eba179acbfdea5a646c5548cb82138c1c3b74aa2.1547153058.git.khalid.aziz@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 10, 2019 at 02:09:39PM -0700, Khalid Aziz wrote:
> From: Juerg Haefliger <juerg.haefliger@canonical.com>
> 
> If the page is unmapped by XPFO, a data cache flush results in a fatal
> page fault, so let's temporarily map the region, flush the cache, and then
> unmap it.
> 
> v6: actually flush in the face of xpfo, and temporarily map the underlying
>     memory so it can be flushed correctly
> 
> CC: linux-arm-kernel@lists.infradead.org
> Signed-off-by: Juerg Haefliger <juerg.haefliger@canonical.com>
> Signed-off-by: Tycho Andersen <tycho@docker.com>
> Signed-off-by: Khalid Aziz <khalid.aziz@oracle.com>
> ---
>  arch/arm64/mm/flush.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/arch/arm64/mm/flush.c b/arch/arm64/mm/flush.c
> index 30695a868107..f12f26b60319 100644
> --- a/arch/arm64/mm/flush.c
> +++ b/arch/arm64/mm/flush.c
> @@ -20,6 +20,7 @@
>  #include <linux/export.h>
>  #include <linux/mm.h>
>  #include <linux/pagemap.h>
> +#include <linux/xpfo.h>
>  
>  #include <asm/cacheflush.h>
>  #include <asm/cache.h>
> @@ -28,9 +29,15 @@
>  void sync_icache_aliases(void *kaddr, unsigned long len)
>  {
>  	unsigned long addr = (unsigned long)kaddr;
> +	unsigned long num_pages = XPFO_NUM_PAGES(addr, len);
> +	void *mapping[num_pages];

Does this still compile with -Wvla? It was a bad hack on my part, and
we should probably just drop it and come up with something else :)

Tycho

>  	if (icache_is_aliasing()) {
> +		xpfo_temp_map(kaddr, len, mapping,
> +			      sizeof(mapping[0]) * num_pages);
>  		__clean_dcache_area_pou(kaddr, len);
> +		xpfo_temp_unmap(kaddr, len, mapping,
> +			        sizeof(mapping[0]) * num_pages);
>  		__flush_icache_all();
>  	} else {
>  		flush_icache_range(addr, addr + len);
> -- 
> 2.17.1
> 
