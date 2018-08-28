Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58F0BC433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 04:20:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D729E208B8
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 04:20:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FEoLVu5o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D729E208B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727043AbeH1IKc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 04:10:32 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:35608 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726120AbeH1IKc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 04:10:32 -0400
Received: by mail-pf1-f195.google.com with SMTP id p12-v6so160963pfh.2;
        Mon, 27 Aug 2018 21:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding;
        bh=THDncvjRVOTfNs9yCOuYqCK4wy1HvE8gw5SL1zhzMus=;
        b=FEoLVu5ozon6hWr//OdcMXqrMHfLOGuqHBbMouRuQH1xVwlhhEOHZLsx96zd2nqnKO
         ZJbu39D4m1l/T7oPjxtRSljAt/jn74BOEymP2EHQ4AXXUTH1JKVCnXlo2sr1AW42gJCq
         OoAsL16KTNQSoOWLp49GuL0T0VK/ViX/R8edP0swR5HOr9N7lqplXV4MKK6qcizVqF92
         FmjSV5Byy8euB6sdm/uvDLy7Ckyq/i/IxzDAsGKqzAfzwX+w+pyXfuR5/MHSwsnbvqle
         kceY7JbQLpH/lDjTxMsN/p0f3jf/vbOUP/vCvOEdel2ebN1yav1VHPYANrKRIOeAWkYn
         YZiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=THDncvjRVOTfNs9yCOuYqCK4wy1HvE8gw5SL1zhzMus=;
        b=KnWExoWiXp8kkmPNDnAZCWrfonnqUsDz2PX3rn2XhuZxK8UlR6JkdZCwvmYLTbAyYB
         4nTp4bg1Uckz9/yK/qbH2wsTPdtNaS0qvXmiVFlQzjrxmEJ/piRQDHqZDBAXW7N9lNdV
         LLrz5d/MzL+myyZ4i62oSKb8hhSBKQVZDaJZJg/bqr0YZSvA26KT2PFT8QR6DzRYPu3l
         m6hc541Qxx6nclnrsyJ23hixeaDh+EEppzMaxr1xmgXny5sExAkJ7imRX37DX3gGLR4V
         SxS0dFE4k8u2wu5auo1rTMZDwjyX+D5ee/HgpBbLVp0ExYmi09yn/TIbtshESY4D3egw
         4wbw==
X-Gm-Message-State: APzg51CvQGsP/7o8K+LQ9SlLK8FvZ8QA2SyoIHa+LmQiaQroSLoTd+2Z
        GtcB5OtdpraIC8gkXNaRzvHBp6vZ
X-Google-Smtp-Source: ANB0VdbO4ORrea5rZsbxtve16pMjRClWEAK6U9t5T8M4VVcuRAR8UgtKc6iJw32GcJvyJiRTvweHuA==
X-Received: by 2002:a63:c114:: with SMTP id w20-v6mr14300268pgf.234.1535430047058;
        Mon, 27 Aug 2018 21:20:47 -0700 (PDT)
Received: from [0.0.0.0] (96.45.178.72.16clouds.com. [96.45.178.72])
        by smtp.gmail.com with ESMTPSA id y128-v6sm979069pfb.56.2018.08.27.21.20.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Aug 2018 21:20:45 -0700 (PDT)
Subject: Re: mmotm 2018-08-23-17-26 uploaded
To:     akpm@linux-foundation.org, broonie@kernel.org, mhocko@suse.cz,
        sfr@canb.auug.org.au, linux-next@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, mm-commits@vger.kernel.org
References: <20180824002731.XMNCl%akpm@linux-foundation.org>
From:   Jia He <hejianet@gmail.com>
Message-ID: <049c3fa9-f888-6a2d-413b-872992b269f9@gmail.com>
Date:   Tue, 28 Aug 2018 12:20:46 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180824002731.XMNCl%akpm@linux-foundation.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew
FYI,I watched a lockdep warning based on your mmotm master branch[1]

[    6.692731] ------------[ cut here ]------------
[    6.696391] DEBUG_LOCKS_WARN_ON(!current->hardirqs_enabled)
[    6.696404] WARNING: CPU: 3 PID: 320 at kernel/locking/lockdep.c:3845
check_flags.part.38+0x9c/0x16c
[    6.711082] Modules linked in:
[    6.714101] CPU: 3 PID: 320 Comm: modprobe Not tainted 4.18.0-rc4-mm1+ #56
[    6.720956] Hardware name: WIWYNN HXT REP-1 System H001-00001-0/HXT REP-1
CRB, BIOS 0ACJA530 03/20/2018
[    6.730332] pstate: 60400085 (nZCv daIf +PAN -UAO)
[    6.735106] pc : check_flags.part.38+0x9c/0x16c
[    6.739619] lr : check_flags.part.38+0x9c/0x16c
[    6.744133] sp : ffff80178536fbf0
[    6.747432] x29: ffff80178536fbf0 x28: ffff8017905a1b00
[    6.752727] x27: 0000000000000002 x26: 0000000000000000
[    6.758022] x25: ffff000008abeb14 x24: 0000000000000000
[    6.763317] x23: 0000000000000001 x22: 0000000000000001
[    6.768612] x21: 0000000000000001 x20: 0000000000000000
[    6.773908] x19: ffff00000a041000 x18: 0000000000000000
[    6.779202] x17: 0000000000000000 x16: 0000000000000000
[    6.784498] x15: 0000000000000000 x14: 0000000000000000
[    6.789793] x13: ffff000008d6b190 x12: 752ce9eb60de3f00
[    6.795088] x11: ffff80178536f7f0 x10: ffff80178536f7f0
[    6.800383] x9 : 00000000ffffffd0 x8 : 0000000000000000
[    6.805678] x7 : ffff00000816fe48 x6 : ffff801794ba62b8
[    6.810973] x5 : 0000000000000000 x4 : 0000000000000000
[    6.816269] x3 : ffffffffffffffff x2 : ffff0000091ed988
[    6.821564] x1 : 752ce9eb60de3f00 x0 : 752ce9eb60de3f00
[    6.826859] Call trace:
[    6.829290]  check_flags.part.38+0x9c/0x16c
[    6.833457]  lock_acquire+0x12c/0x280
[    6.837104]  down_read_trylock+0x78/0x98
[    6.841011]  do_page_fault+0x150/0x480
[    6.844742]  do_translation_fault+0x74/0x80
[    6.848909]  do_mem_abort+0x60/0x108
[    6.852467]  el0_da+0x24/0x28
[    6.855418] irq event stamp: 250
[    6.858633] hardirqs last  enabled at (249): [<ffff00000830e518>]
mem_cgroup_commit_charge+0x9c/0x13c
[    6.867833] hardirqs last disabled at (250): [<ffff000008095f40>]
el0_svc_handler+0xc4/0x16c
[    6.876252] softirqs last  enabled at (242): [<ffff000008081c48>]
__do_softirq+0x2f8/0x554
[    6.884501] softirqs last disabled at (229): [<ffff0000080f1bec>]
irq_exit+0x180/0x194
[    6.892399] ---[ end trace b45768f94a7b7d9f ]---
[    6.896998] possible reason: unannotated irqs-on.
[    6.901685] irq event stamp: 250
[    6.904898] hardirqs last  enabled at (249): [<ffff00000830e518>]
mem_cgroup_commit_charge+0x9c/0x13c
[    6.914100] hardirqs last disabled at (250): [<ffff000008095f40>]
el0_svc_handler+0xc4/0x16c
[    6.922519] softirqs last  enabled at (242): [<ffff000008081c48>]
__do_softirq+0x2f8/0x554
[    6.930766] softirqs last disabled at (229): [<ffff0000080f1bec>]
irq_exit+0x180/0x194
[    7.023827] Initialise system trusted keyrings
[    7.027414] workingset: timestamp_bits=45 max_order=25 bucket_order=0

I thought the root cause might be at [2] which seems not in your branch yet.

[1] http://git.cmpxchg.org/cgit.cgi/linux-mmotm.git
[2]
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit?id=efd112

---
Cheers,
Jia

On 8/24/2018 8:27 AM, akpm@linux-foundation.org Wrote:
> The mm-of-the-moment snapshot 2018-08-23-17-26 has been uploaded to
> 
>    http://www.ozlabs.org/~akpm/mmotm/
> 
> mmotm-readme.txt says
> 
> README for mm-of-the-moment:
> 
> http://www.ozlabs.org/~akpm/mmotm/
> 
> This is a snapshot of my -mm patch queue.  Uploaded at random hopefully
> more than once a week.
> 
> You will need quilt to apply these patches to the latest Linus release (4.x
> or 4.x-rcY).  The series file is in broken-out.tar.gz and is duplicated in
> http://ozlabs.org/~akpm/mmotm/series
> 
> The file broken-out.tar.gz contains two datestamp files: .DATE and
> .DATE-yyyy-mm-dd-hh-mm-ss.  Both contain the string yyyy-mm-dd-hh-mm-ss,
> followed by the base kernel version against which this patch series is to
> be applied.
> 
> This tree is partially included in linux-next.  To see which patches are
> included in linux-next, consult the `series' file.  Only the patches
> within the #NEXT_PATCHES_START/#NEXT_PATCHES_END markers are included in
> linux-next.
> 
> A git tree which contains the memory management portion of this tree is
> maintained at git://git.kernel.org/pub/scm/linux/kernel/git/mhocko/mm.git
> by Michal Hocko.  It contains the patches which are between the
> "#NEXT_PATCHES_START mm" and "#NEXT_PATCHES_END" markers, from the series
> file, http://www.ozlabs.org/~akpm/mmotm/series.
> 
> 
> A full copy of the full kernel tree with the linux-next and mmotm patches
> already applied is available through git within an hour of the mmotm
> release.  Individual mmotm releases are tagged.  The master branch always
> points to the latest release, so it's constantly rebasing.
> 
> http://git.cmpxchg.org/cgit.cgi/linux-mmotm.git/
> 
> To develop on top of mmotm git:
> 
>   $ git remote add mmotm git://git.kernel.org/pub/scm/linux/kernel/git/mhocko/mm.git
>   $ git remote update mmotm
>   $ git checkout -b topic mmotm/master
>   <make changes, commit>
>   $ git send-email mmotm/master.. [...]
> 
> To rebase a branch with older patches to a new mmotm release:
> 
>   $ git remote update mmotm
>   $ git rebase --onto mmotm/master <topic base> topic
> 
> 
> 
> 
> The directory http://www.ozlabs.org/~akpm/mmots/ (mm-of-the-second)
> contains daily snapshots of the -mm tree.  It is updated more frequently
> than mmotm, and is untested.
> 
> A git copy of this tree is available at
> 
> 	http://git.cmpxchg.org/cgit.cgi/linux-mmots.git/
> 
> and use of this tree is similar to
> http://git.cmpxchg.org/cgit.cgi/linux-mmotm.git/, described above.
> 
> 
> This mmotm tree contains the following patches against 4.18:
> (patches marked "*" will be included in linux-next)
> 
>   origin.patch
> * hfsplus-fix-null-dereference-in-hfsplus_lookup.patch
> * hfsplus-prevent-crash-on-exit-from-failed-search.patch
> * hfs-prevent-crash-on-exit-from-failed-search.patch
> * namei-allow-restricted-o_creat-of-fifos-and-regular-files.patch
> * mm-fix-race-on-soft-offlining-free-huge-pages.patch
> * mm-soft-offline-close-the-race-against-page-allocation.patch
> * hwtracing-intel_th-change-return-type-to-vm_fault_t.patch
> * fs-afs-adding-new-return-type-vm_fault_t.patch
> * treewide-correct-differenciate-and-instanciate-typos.patch
> * vmcore-hide-vmcoredd_mmap_dumps-for-nommu-builds.patch
> * mm-util-make-strndup_user-description-a-kernel-doc-comment.patch
> * mm-util-add-kernel-doc-for-kvfree.patch
> * docs-core-api-kill-trailing-whitespace-in-kernel-apirst.patch
> * docs-core-api-move-strmemdup-to-string-manipulation.patch
> * docs-core-api-split-memory-management-api-to-a-separate-file.patch
> * docs-mm-make-gfp-flags-descriptions-usable-as-kernel-doc.patch
> * docs-core-api-mm-api-add-section-about-gfp-flags.patch
> * gpu-drm-gma500-change-return-type-to-vm_fault_t.patch
> * treewide-convert-iso_8859-1-text-comments-to-utf-8.patch
> * s390-ebcdic-convert-comments-to-utf-8.patch
> * lib-fonts-convert-comments-to-utf-8.patch
> * mm-change-return-type-int-to-vm_fault_t-for-fault-handlers.patch
> * mm-memcontrol-print-proper-oom-header-when-no-eligible-victim-left.patch
> * mm-migration-fix-migration-of-huge-pmd-shared-pages.patch
> * hugetlb-take-pmd-sharing-into-account-when-flushing-tlb-caches.patch
> * mm-oom-fix-missing-tlb_finish_mmu-in-__oom_reap_task_mm.patch
> * mm-respect-arch_dup_mmap-return-value.patch
> * arm-arch-arm-include-asm-pageh-needs-personalityh.patch
> * ocfs2-get-rid-of-ocfs2_is_o2cb_active-function.patch
> * ocfs2-without-quota-support-try-to-avoid-calling-quota-recovery.patch
> * ocfs2-dont-use-iocb-when-eiocbqueued-returns.patch
> * ocfs2-fix-a-misuse-a-of-brelse-after-failing-ocfs2_check_dir_entry.patch
> * ocfs2-dont-put-and-assigning-null-to-bh-allocated-outside.patch
> * ocfs2-dlmglue-clean-up-timestamp-handling.patch
> * block-restore-proc-partitions-to-not-display-non-partitionable-removable-devices.patch
>   mm.patch
> * arm-arm64-introduce-config_have_memblock_pfn_valid.patch
> * mm-page_alloc-remain-memblock_next_valid_pfn-on-arm-arm64.patch
> * mm-page_alloc-reduce-unnecessary-binary-search-in-memblock_next_valid_pfn.patch
> * mm-page_alloc-reduce-unnecessary-binary-search-in-memblock_next_valid_pfn-fix.patch
> * mm-page_alloc-reduce-unnecessary-binary-search-in-memblock_next_valid_pfn-fix-fix.patch
> * mm-memblock-introduce-memblock_search_pfn_regions.patch
> * mm-memblock-introduce-memblock_search_pfn_regions-fix.patch
> * mm-memblock-introduce-pfn_valid_region.patch
> * mm-page_alloc-reduce-unnecessary-binary-search-in-early_pfn_valid.patch
> * z3fold-fix-wrong-handling-of-headless-pages.patch
> * mm-adjust-max-read-count-in-generic_file_buffered_read.patch
> * mm-make-memmap_init-a-proper-function.patch
> * mm-calculate-deferred-pages-after-skipping-mirrored-memory.patch
> * mm-calculate-deferred-pages-after-skipping-mirrored-memory-v2.patch
> * mm-calculate-deferred-pages-after-skipping-mirrored-memory-fix.patch
> * mm-move-mirrored-memory-specific-code-outside-of-memmap_init_zone.patch
> * mm-move-mirrored-memory-specific-code-outside-of-memmap_init_zone-v2.patch
> * mm-swap-fix-race-between-swapoff-and-some-swap-operations.patch
> * mm-swap-fix-race-between-swapoff-and-some-swap-operations-v6.patch
> * mm-fix-race-between-swapoff-and-mincore.patch
> * list_lru-prefetch-neighboring-list-entries-before-acquiring-lock.patch
> * list_lru-prefetch-neighboring-list-entries-before-acquiring-lock-fix.patch
> * mm-add-strictlimit-knob-v2.patch
> * mm-dont-expose-page-to-fast-gup-before-its-ready.patch
> * mm-page_owner-align-with-pageblock_nr_pages.patch
> * mm-page_owner-align-with-pageblock_nr-pages.patch
> * info-task-hung-in-generic_file_write_iter.patch
> * bfs-add-sanity-check-at-bfs_fill_super.patch
>   linux-next.patch
>   linux-next-git-rejects.patch
> * vfs-replace-current_kernel_time64-with-ktime-equivalent.patch
> * fix-read-buffer-overflow-in-delta-ipc.patch
>   make-sure-nobodys-leaking-resources.patch
>   releasing-resources-with-children.patch
>   mutex-subsystem-synchro-test-module.patch
>   kernel-forkc-export-kernel_thread-to-modules.patch
>   slab-leaks3-default-y.patch
>   workaround-for-a-pci-restoring-bug.patch
> 
> 
