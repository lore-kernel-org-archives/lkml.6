Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 356D0C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 10:11:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCCBB21508
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 10:11:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GTVuoakl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCCBB21508
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729252AbeLFKLX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 05:11:23 -0500
Received: from mail-io1-f41.google.com ([209.85.166.41]:40992 "EHLO
        mail-io1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727996AbeLFKLX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 05:11:23 -0500
Received: by mail-io1-f41.google.com with SMTP id s22so19225630ioc.8
        for <linux-kernel@vger.kernel.org>; Thu, 06 Dec 2018 02:11:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QLEBq/mS8THcHALhDWmgO4C+ahP+JUVmTjNdYpKJeD0=;
        b=GTVuoaklnQQP84AewuyxDfaRq32HK8jvIiLIC9Z5MKyyD2Cx4FG6OaxlZILnLPCDnW
         JV/F6C6AT0B5npcj9s6o9wijgyVvt/Ydppm5VagGgt1lxvRbPDrMXLPav9+A5OJXu5H6
         4TbjwP6tUd+q4MX6kjzRDtPNz3TA74rrz8fA/IywbHYfrhTTinFeMNBE0LFL/sLy0wQ+
         /wJ6RgjQ2b774Hl60RSuXzP0bOEo6Lz/kXSY03Qpp7j1qp2Tg2qmXyviSmxPH/b6PhLc
         uNPR7HeKp6evRMZFoiutwwmICxv82NoZ3tQykoEjehsAJlTGzeSnAxmsru0nldCaoDht
         EdJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QLEBq/mS8THcHALhDWmgO4C+ahP+JUVmTjNdYpKJeD0=;
        b=Kaiq7cGwmniD5/aHcM3RGMiX4SkxK+A8+0HxagQ+yQJG9gkLhyTvBPkhpBfqGoEhSL
         e7kCwZoNo47ko9+AiqpSYw6EyoilUE8oQkHDMFNR4ge31QNzcUeqxvHLqnbwyK81cu1A
         3GdtTE0gl6gjQhRhMX/H4vyUD0N5Cbh5V/HoP+EpuhemGArb7mrD1sK6kT7TWmxq9kwT
         BJdNAixEVHKkegL676ECM6dcDZnTARn4DxKJiveeYTLa9OCiQ9rj27blDweFEa9Tkch+
         z18cFiMKPkJd21PR1VM23VJJz8QL+5ZSlJXcjOV5qYEiKeGYExemyH6YePUPmOkZrpHH
         zslg==
X-Gm-Message-State: AA+aEWaY72BcpVK4gEJX6LIsXfniTCZrCE7cO/ds2iCwy8OhO30FRoRH
        N5pTQcZbtHrb6eb6q08LIOCBHcQHo23stCtZ4/fn9Q==
X-Google-Smtp-Source: AFSGD/UBwd7TkBXzr5ohB+ax7oAstVAK8ryzBKXLN4bbLRf+pfNYr5M6nhtYPiXJundcjrVWHplqalTcakzI3DwRspo=
X-Received: by 2002:a5d:91d7:: with SMTP id k23mr25679549ior.31.1544091081873;
 Thu, 06 Dec 2018 02:11:21 -0800 (PST)
MIME-Version: 1.0
References: <20181129213822.EbBH1%akpm@linux-foundation.org> <d24875f4-f73f-3ec9-55ee-94367f797451@infradead.org>
In-Reply-To: <d24875f4-f73f-3ec9-55ee-94367f797451@infradead.org>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Thu, 6 Dec 2018 11:11:10 +0100
Message-ID: <CAAeHK+yn0_JwBwnruVNFTKL5pdnja-NmmoN2kCVt6DC4JS5=qQ@mail.gmail.com>
Subject: Re: mmotm 2018-11-29-13-37 uploaded (kasan)
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, broonie@kernel.org,
        Michal Hocko <mhocko@suse.cz>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, mm-commits@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 30, 2018 at 1:32 AM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> On 11/29/18 1:38 PM, akpm@linux-foundation.org wrote:
> > The mm-of-the-moment snapshot 2018-11-29-13-37 has been uploaded to
> >
> >    http://www.ozlabs.org/~akpm/mmotm/
> >
> > mmotm-readme.txt says
> >
> > README for mm-of-the-moment:
> >
> > http://www.ozlabs.org/~akpm/mmotm/
>
> Lots of kasan build errors on x86_64.
>
> > * kasan-mm-change-hooks-signatures.patch
> > * kasan-slub-handle-pointer-tags-in-early_kmem_cache_node_alloc.patch
> > * kasan-move-common-generic-and-tag-based-code-to-commonc.patch
> > * kasan-rename-source-files-to-reflect-the-new-naming-scheme.patch
> > * kasan-add-config_kasan_generic-and-config_kasan_sw_tags.patch
> > * kasan-arm64-adjust-shadow-size-for-tag-based-mode.patch
> > * kasan-rename-kasan_zero_page-to-kasan_early_shadow_page.patch
> > * kasan-initialize-shadow-to-0xff-for-tag-based-mode.patch
> > * arm64-move-untagged_addr-macro-from-uaccessh-to-memoryh.patch
> > * kasan-add-tag-related-helper-functions.patch
> > * kasan-arm64-untag-address-in-_virt_addr_is_linear.patch
> > * kasan-preassign-tags-to-objects-with-ctors-or-slab_typesafe_by_rcu.patch
> > * kasan-arm64-fix-up-fault-handling-logic.patch
> > * kasan-arm64-enable-top-byte-ignore-for-the-kernel.patch
> > * kasan-mm-perform-untagged-pointers-comparison-in-krealloc.patch
> > * kasan-split-out-generic_reportc-from-reportc.patch
> > * kasan-add-bug-reporting-routines-for-tag-based-mode.patch
> > * mm-move-obj_to_index-to-include-linux-slab_defh.patch
> > * kasan-add-hooks-implementation-for-tag-based-mode.patch
> > * kasan-arm64-add-brk-handler-for-inline-instrumentation.patch
> > * kasan-mm-arm64-tag-non-slab-memory-allocated-via-pagealloc.patch
> > * kasan-add-__must_check-annotations-to-kasan-hooks.patch
> > * kasan-arm64-select-have_arch_kasan_sw_tags.patch
> > * kasan-update-documentation.patch
> > * kasan-add-spdx-license-identifier-mark-to-source-files.patch
>
> The simplest error is:
> ../mm/kasan/common.c:574:17: error: 'KASAN_SHADOW_INIT' undeclared (first use in this function)
>
> when neither KASAN_GENERIC nor KASAN_SW_TAGS is set (enabled).

Will fix in v13, thanks!

>
> There there are a slew of these:
>
> ../mm/kasan/common.c: In function 'filter_irq_stacks':
> ../mm/kasan/common.c:53:12: error: dereferencing pointer to incomplete type
>   if (!trace->nr_entries)
>             ^
> ../mm/kasan/common.c:55:23: error: dereferencing pointer to incomplete type
>   for (i = 0; i < trace->nr_entries; i++)
>                        ^
> ../mm/kasan/common.c:56:29: error: dereferencing pointer to incomplete type
>    if (in_irqentry_text(trace->entries[i])) {
>                              ^
> ../mm/kasan/common.c:58:9: error: dereferencing pointer to incomplete type
>     trace->nr_entries = i + 1;
>          ^
> ../mm/kasan/common.c: In function 'save_stack':
> ../mm/kasan/common.c:66:9: error: variable 'trace' has initializer but incomplete type
>   struct stack_trace trace = {
>          ^
> ../mm/kasan/common.c:67:3: error: unknown field 'nr_entries' specified in initializer
>    .nr_entries = 0,
>    ^
> ../mm/kasan/common.c:67:3: warning: excess elements in struct initializer [enabled by default]
> ../mm/kasan/common.c:67:3: warning: (near initialization for 'trace') [enabled by default]
> ../mm/kasan/common.c:68:3: error: unknown field 'entries' specified in initializer
>    .entries = entries,
>    ^
> ../mm/kasan/common.c:68:3: warning: excess elements in struct initializer [enabled by default]
> ../mm/kasan/common.c:68:3: warning: (near initialization for 'trace') [enabled by default]
> ../mm/kasan/common.c:69:3: error: unknown field 'max_entries' specified in initializer
>    .max_entries = KASAN_STACK_DEPTH,
>    ^
> ../mm/kasan/common.c:69:3: warning: excess elements in struct initializer [enabled by default]
> ../mm/kasan/common.c:69:3: warning: (near initialization for 'trace') [enabled by default]
> ../mm/kasan/common.c:70:3: error: unknown field 'skip' specified in initializer
>    .skip = 0
>    ^
> ../mm/kasan/common.c:71:2: warning: excess elements in struct initializer [enabled by default]
>   };
>   ^
> ../mm/kasan/common.c:71:2: warning: (near initialization for 'trace') [enabled by default]
> ../mm/kasan/common.c:66:21: error: storage size of 'trace' isn't known
>   struct stack_trace trace = {
>                      ^
> ../mm/kasan/common.c:66:21: warning: unused variable 'trace' [-Wunused-variable]
> ../mm/kasan/common.c: In function 'kasan_module_alloc':
> ../mm/kasan/common.c:574:17: error: 'KASAN_SHADOW_INIT' undeclared (first use in this function)
>    __memset(ret, KASAN_SHADOW_INIT, shadow_size);
>                  ^
> ../mm/kasan/common.c:574:17: note: each undeclared identifier is reported only once for each function it appears in
> ../mm/kasan/common.c: In function 'save_stack':
> ../mm/kasan/common.c:80:1: warning: control reaches end of non-void function [-Wreturn-type]
>  }
>  ^
> ../scripts/Makefile.build:285: recipe for target 'mm/kasan/common.o' failed
>
>
> --
> ~Randy
