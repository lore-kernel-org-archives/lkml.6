Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64E21C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 15:54:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35B3C222DA
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 15:54:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho-ws.20150623.gappssmtp.com header.i=@tycho-ws.20150623.gappssmtp.com header.b="u3Xdu4ln"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502377AbfBNPyp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 10:54:45 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:37400 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388300AbfBNPyo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 10:54:44 -0500
Received: by mail-qk1-f194.google.com with SMTP id m9so3857949qkl.4
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 07:54:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tycho-ws.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=UxpB070xHwgFaz8ZioJlkVPdIwCn2gbKu7LNAeSS6hg=;
        b=u3Xdu4lng/T/Gddu8kOlLDHAmHcvkyWWI4olRQ6e3+63jOFKa3TrUFKCYSYyeHMLRW
         AxMWjlLusOvDFUizEOvKVSn/6JIvmVruc/v7wuL2n2UFAKcoseE925gAwNgdEsjh0FXF
         BFgZ2BSuYxU/3fXZmcfo62o9UHBBhsOBMeW+rBqgQGxuZ5/q9jkVFWuUHOeMOtadIPYa
         mKOc17H6jeF4u8pbR/3RLnuKZDP/5ctpY1/gqU4XsmU62XJ1zhJ84Qlz7rCufBIAveSY
         tsALfedeUly/vMkW63SDvnToU0I0eHJgJuBM0ntr+kO2HeiYWtBD4uOjk/K4v+K3MwIB
         iknw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UxpB070xHwgFaz8ZioJlkVPdIwCn2gbKu7LNAeSS6hg=;
        b=LcCIdg2H6z0fVe/qwoBkKTRg5TsLJsLcBit1u39igDnTvi+/6Y1uMYgeISfLMvzdYV
         5E7JxY6NDIpkh/Upxk3CyH5FW7721WFmdgs/T9WycIeNWqly1WJRyuHLWKB+webAmWez
         vkIIZW0CQALsuBNnW/MEnQLEoE0/660KNvOC4+C6VqnYpoAW1ZPlVjUpms+ci3xb3ybw
         14KzZt6LZID+PB9A9ZEqOSSSYF+kvJ5uenepiQkBXegZpxK14jjaLpjFLMEWFgUkb0PZ
         wFGg4/WJJwopsJrHrNpPC6XhA6SkohJZ3FPNz8Qy7cvqYA++HVkUxgJ2XFoG62amLcq9
         CHPw==
X-Gm-Message-State: AHQUAuZFy7snvd3TfWvmc0UzIgDOO8sX7rL267bztPyFxeXNEJiZsErg
        rmgJ4UiF2R/gJmKxofBfGOF2Iw==
X-Google-Smtp-Source: AHgI3Ia7LCGDDCLU8MkYwq8iNCqWM6Mj9BVMP6XN30zlJ0Pv4QGuWGPK3u/Aux2QKEcButsn/HeXEg==
X-Received: by 2002:a37:62c5:: with SMTP id w188mr3321934qkb.294.1550159682636;
        Thu, 14 Feb 2019 07:54:42 -0800 (PST)
Received: from cisco ([192.241.255.151])
        by smtp.gmail.com with ESMTPSA id 32sm1660511qto.55.2019.02.14.07.54.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 14 Feb 2019 07:54:41 -0800 (PST)
Date:   Thu, 14 Feb 2019 08:54:35 -0700
From:   Tycho Andersen <tycho@tycho.ws>
To:     Khalid Aziz <khalid.aziz@oracle.com>
Cc:     juergh@gmail.com, jsteckli@amazon.de, ak@linux.intel.com,
        torvalds@linux-foundation.org, liran.alon@oracle.com,
        keescook@google.com, akpm@linux-foundation.org, mhocko@suse.com,
        catalin.marinas@arm.com, will.deacon@arm.com, jmorris@namei.org,
        konrad.wilk@oracle.com,
        Juerg Haefliger <juerg.haefliger@canonical.com>,
        deepa.srinivasan@oracle.com, chris.hyser@oracle.com,
        tyhicks@canonical.com, dwmw@amazon.co.uk,
        andrew.cooper3@citrix.com, jcm@redhat.com,
        boris.ostrovsky@oracle.com, kanth.ghatraju@oracle.com,
        oao.m.martins@oracle.com, jmattson@google.com,
        pradeep.vincent@oracle.com, john.haxby@oracle.com,
        tglx@linutronix.de, kirill.shutemov@linux.intel.com, hch@lst.de,
        steven.sistare@oracle.com, labbott@redhat.com, luto@kernel.org,
        dave.hansen@intel.com, peterz@infradead.org,
        kernel-hardening@lists.openwall.com, linux-mm@kvack.org,
        x86@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v8 07/14] arm64/mm, xpfo: temporarily map dcache
 regions
Message-ID: <20190214155435.GA15694@cisco>
References: <cover.1550088114.git.khalid.aziz@oracle.com>
 <ea50404604bdbe1547601b6ea0af89e3da8886b0.1550088114.git.khalid.aziz@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ea50404604bdbe1547601b6ea0af89e3da8886b0.1550088114.git.khalid.aziz@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Feb 13, 2019 at 05:01:30PM -0700, Khalid Aziz wrote:
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
> ---
>  arch/arm64/mm/flush.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/arch/arm64/mm/flush.c b/arch/arm64/mm/flush.c
> index 30695a868107..fad09aafd9d5 100644
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

What version does this build on? Presumably -Wvla will cause an error
here, but,

>  	if (icache_is_aliasing()) {
> +		xpfo_temp_map(kaddr, len, mapping,
> +			      sizeof(mapping[0]) * num_pages);
>  		__clean_dcache_area_pou(kaddr, len);

Here, we map the pages to some random address via xpfo_temp_map(),
then pass the *original* address (which may not have been mapped) to
__clean_dcache_area_pou(). So I think this whole approach is wrong.

If we want to do it this way, it may be that we need some
xpfo_map_contiguous() type thing, but since we're just going to flush
it anyway, that seems a little crazy. Maybe someone who knows more
about arm64 knows a better way?

Tycho
