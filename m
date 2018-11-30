Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9171C04EB9
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 00:32:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A05782081C
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 00:32:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TkboY525"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A05782081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727140AbeK3LkB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 06:40:01 -0500
Received: from merlin.infradead.org ([205.233.59.134]:56266 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726451AbeK3LkA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 06:40:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
        Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=5oq0o6hXSHtb1vd0lJVNl2VziMJIgX9BMe+VSPNjnF0=; b=TkboY52541Hsx2wko89KEBmfzb
        FT4ArvU9BGKRG1g1+ZjU/Bbuvex5oKsaau3DERD0Tvikm7dyh3WBVsfq8G85Ev5WbPMDu5AWCcm9B
        kYc7iiyibjGIoD9APeDoSmKFRjNF2k0AEa60KuAfUs7KmVSRoo1znRRED/ZE7El+CvAR9IfkGlyrW
        lKGOE73dUzz2o5Gb/TeBIiS0HVBslHRXSdkzO7sEHKX8bJEwbcqj6kZWOG7dWbweN4QlpNsbzy+3c
        LSuPQJ9KNrHtukSddld8ySj5Y+HdTmvyKOjMAd7j2lfG10J3+WraS0LIFmQNbhCepD7nh9xotRzz4
        eomGWK7g==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gSWjR-00073b-3S; Fri, 30 Nov 2018 00:32:33 +0000
Subject: Re: mmotm 2018-11-29-13-37 uploaded (kasan)
To:     akpm@linux-foundation.org, broonie@kernel.org, mhocko@suse.cz,
        sfr@canb.auug.org.au, linux-next@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, mm-commits@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
References: <20181129213822.EbBH1%akpm@linux-foundation.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <d24875f4-f73f-3ec9-55ee-94367f797451@infradead.org>
Date:   Thu, 29 Nov 2018 16:32:30 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181129213822.EbBH1%akpm@linux-foundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/29/18 1:38 PM, akpm@linux-foundation.org wrote:
> The mm-of-the-moment snapshot 2018-11-29-13-37 has been uploaded to
> 
>    http://www.ozlabs.org/~akpm/mmotm/
> 
> mmotm-readme.txt says
> 
> README for mm-of-the-moment:
> 
> http://www.ozlabs.org/~akpm/mmotm/

Lots of kasan build errors on x86_64.

> * kasan-mm-change-hooks-signatures.patch
> * kasan-slub-handle-pointer-tags-in-early_kmem_cache_node_alloc.patch
> * kasan-move-common-generic-and-tag-based-code-to-commonc.patch
> * kasan-rename-source-files-to-reflect-the-new-naming-scheme.patch
> * kasan-add-config_kasan_generic-and-config_kasan_sw_tags.patch
> * kasan-arm64-adjust-shadow-size-for-tag-based-mode.patch
> * kasan-rename-kasan_zero_page-to-kasan_early_shadow_page.patch
> * kasan-initialize-shadow-to-0xff-for-tag-based-mode.patch
> * arm64-move-untagged_addr-macro-from-uaccessh-to-memoryh.patch
> * kasan-add-tag-related-helper-functions.patch
> * kasan-arm64-untag-address-in-_virt_addr_is_linear.patch
> * kasan-preassign-tags-to-objects-with-ctors-or-slab_typesafe_by_rcu.patch
> * kasan-arm64-fix-up-fault-handling-logic.patch
> * kasan-arm64-enable-top-byte-ignore-for-the-kernel.patch
> * kasan-mm-perform-untagged-pointers-comparison-in-krealloc.patch
> * kasan-split-out-generic_reportc-from-reportc.patch
> * kasan-add-bug-reporting-routines-for-tag-based-mode.patch
> * mm-move-obj_to_index-to-include-linux-slab_defh.patch
> * kasan-add-hooks-implementation-for-tag-based-mode.patch
> * kasan-arm64-add-brk-handler-for-inline-instrumentation.patch
> * kasan-mm-arm64-tag-non-slab-memory-allocated-via-pagealloc.patch
> * kasan-add-__must_check-annotations-to-kasan-hooks.patch
> * kasan-arm64-select-have_arch_kasan_sw_tags.patch
> * kasan-update-documentation.patch
> * kasan-add-spdx-license-identifier-mark-to-source-files.patch

The simplest error is:
../mm/kasan/common.c:574:17: error: 'KASAN_SHADOW_INIT' undeclared (first use in this function)

when neither KASAN_GENERIC nor KASAN_SW_TAGS is set (enabled).

There there are a slew of these:

../mm/kasan/common.c: In function 'filter_irq_stacks':
../mm/kasan/common.c:53:12: error: dereferencing pointer to incomplete type
  if (!trace->nr_entries)
            ^
../mm/kasan/common.c:55:23: error: dereferencing pointer to incomplete type
  for (i = 0; i < trace->nr_entries; i++)
                       ^
../mm/kasan/common.c:56:29: error: dereferencing pointer to incomplete type
   if (in_irqentry_text(trace->entries[i])) {
                             ^
../mm/kasan/common.c:58:9: error: dereferencing pointer to incomplete type
    trace->nr_entries = i + 1;
         ^
../mm/kasan/common.c: In function 'save_stack':
../mm/kasan/common.c:66:9: error: variable 'trace' has initializer but incomplete type
  struct stack_trace trace = {
         ^
../mm/kasan/common.c:67:3: error: unknown field 'nr_entries' specified in initializer
   .nr_entries = 0,
   ^
../mm/kasan/common.c:67:3: warning: excess elements in struct initializer [enabled by default]
../mm/kasan/common.c:67:3: warning: (near initialization for 'trace') [enabled by default]
../mm/kasan/common.c:68:3: error: unknown field 'entries' specified in initializer
   .entries = entries,
   ^
../mm/kasan/common.c:68:3: warning: excess elements in struct initializer [enabled by default]
../mm/kasan/common.c:68:3: warning: (near initialization for 'trace') [enabled by default]
../mm/kasan/common.c:69:3: error: unknown field 'max_entries' specified in initializer
   .max_entries = KASAN_STACK_DEPTH,
   ^
../mm/kasan/common.c:69:3: warning: excess elements in struct initializer [enabled by default]
../mm/kasan/common.c:69:3: warning: (near initialization for 'trace') [enabled by default]
../mm/kasan/common.c:70:3: error: unknown field 'skip' specified in initializer
   .skip = 0
   ^
../mm/kasan/common.c:71:2: warning: excess elements in struct initializer [enabled by default]
  };
  ^
../mm/kasan/common.c:71:2: warning: (near initialization for 'trace') [enabled by default]
../mm/kasan/common.c:66:21: error: storage size of 'trace' isn't known
  struct stack_trace trace = {
                     ^
../mm/kasan/common.c:66:21: warning: unused variable 'trace' [-Wunused-variable]
../mm/kasan/common.c: In function 'kasan_module_alloc':
../mm/kasan/common.c:574:17: error: 'KASAN_SHADOW_INIT' undeclared (first use in this function)
   __memset(ret, KASAN_SHADOW_INIT, shadow_size);
                 ^
../mm/kasan/common.c:574:17: note: each undeclared identifier is reported only once for each function it appears in
../mm/kasan/common.c: In function 'save_stack':
../mm/kasan/common.c:80:1: warning: control reaches end of non-void function [-Wreturn-type]
 }
 ^
../scripts/Makefile.build:285: recipe for target 'mm/kasan/common.o' failed


-- 
~Randy
