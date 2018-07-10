Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 271BAC5CFE7
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 00:45:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8D632083B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 00:45:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8D632083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933303AbeGJApU (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 20:45:20 -0400
Received: from mga17.intel.com ([192.55.52.151]:3663 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933132AbeGJApK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 20:45:10 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Jul 2018 17:45:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,332,1526367600"; 
   d="scan'208";a="70013183"
Received: from precciox-mobl.amr.corp.intel.com (HELO [10.254.107.89]) ([10.254.107.89])
  by fmsmga004.fm.intel.com with ESMTP; 09 Jul 2018 17:44:54 -0700
Subject: Re: Kernel 4.17.4 lockup
To:     "H.J. Lu" <hjl.tools@gmail.com>
References: <CAMe9rOqXsQ4Onv8_-kYE_yVYVfN0Hsg81XM0sq9k2cVYE_LvaQ@mail.gmail.com>
 <50d6bb50-5fa4-33d1-1f88-3844d0237f16@intel.com>
 <CAMe9rOoA=OoyaUfOvWuHGTp_ii9-A_ecR5tj8CefBKx_Hmi50g@mail.gmail.com>
Cc:     "H. Peter Anvin" <hpa@zytor.com>,
        Matthew Wilcox <mawilcox@microsoft.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Mel Gorman <mgorman@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Rik van Riel <riel@surriel.com>,
        Minchan Kim <minchan@kernel.org>
From:   Dave Hansen <dave.hansen@intel.com>
Openpgp: preference=signencrypt
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
 z5cecg==
Message-ID: <7db385ef-0940-8f28-87b0-828921dd2f1d@intel.com>
Date:   Mon, 9 Jul 2018 17:44:52 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CAMe9rOoA=OoyaUfOvWuHGTp_ii9-A_ecR5tj8CefBKx_Hmi50g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

...  cc'ing a few folks who I know have been looking at this code
lately.  The full oops is below if any of you want to take a look.

OK, well, annotating the disassembly a bit:

> (gdb) disass free_pages_and_swap_cache
> Dump of assembler code for function free_pages_and_swap_cache:
>    0xffffffff8124c0d0 <+0>: callq  0xffffffff81a017a0 <__fentry__>
>    0xffffffff8124c0d5 <+5>: push   %r14
>    0xffffffff8124c0d7 <+7>: push   %r13
>    0xffffffff8124c0d9 <+9>: push   %r12
>    0xffffffff8124c0db <+11>: mov    %rdi,%r12		// %r12 = pages
>    0xffffffff8124c0de <+14>: push   %rbp
>    0xffffffff8124c0df <+15>: mov    %esi,%ebp		// %ebp = nr
>    0xffffffff8124c0e1 <+17>: push   %rbx
>    0xffffffff8124c0e2 <+18>: callq  0xffffffff81205a10 <lru_add_drain>
>    0xffffffff8124c0e7 <+23>: test   %ebp,%ebp		// test nr==0
>    0xffffffff8124c0e9 <+25>: jle    0xffffffff8124c156 <free_pages_and_swap_cache+134>
>    0xffffffff8124c0eb <+27>: lea    -0x1(%rbp),%eax
>    0xffffffff8124c0ee <+30>: mov    %r12,%rbx		// %rbx = pages
>    0xffffffff8124c0f1 <+33>: lea    0x8(%r12,%rax,8),%r14 // load &pages[nr] into %r14?
>    0xffffffff8124c0f6 <+38>: mov    (%rbx),%r13 	// %r13 = pages[i]
>    0xffffffff8124c0f9 <+41>: mov    0x20(%r13),%rdx 	//<<<<<<<<<<<<<<<<<<<< GPF here.
%r13 is 64-byte aligned, so looks like a halfway reasonable 'struct page *'.

%R14 looks OK (0xffff93d4abb5f000) because it points to the end of a
dynamically-allocated (not on-stack) mmu_gather_batch page.  %RBX is
pointing 50 pages up from the start of the previous page.  That makes it
the 48th page in pages[] after a pointer and two integers in the
beginning of the structure.  That 48 is important because it's way
larger than the on-stack size of 8.

It's hard to make much sense of %R13 (pages[48] / 0xfffbf0809e304bc0)
because the vmemmap addresses get randomized.  But, I _think_ that's too
high of an address for a 4-level paging vmemmap[] entry.  Does anybody
else know offhand?

I'd really want to see this reproduced without KASLR to make the oops
easier to read.  It would also be handy to try your workload with all
the pedantic debugging: KASAN, slab debugging, DEBUG_PAGE_ALLOC, etc...
and see if it still triggers.

Some relevant functions and structures below for reference.

void free_pages_and_swap_cache(struct page **pages, int nr)
{
        for (i = 0; i < nr; i++)
                free_swap_cache(pages[i]);
}


static void tlb_flush_mmu_free(struct mmu_gather *tlb)
{
        for (batch = &tlb->local; batch && batch->nr;
	     batch = batch->next) {
                free_pages_and_swap_cache(batch->pages, batch->nr);
}

zap_pte_range()
{
	if (force_flush)
		tlb_flush_mmu_free(tlb);
}

... all the way up to the on-stack-allocated mmu_gather:

void zap_page_range(struct vm_area_struct *vma, unsigned long start,
                unsigned long size)
{
        struct mmu_gather tlb;


#define MMU_GATHER_BUNDLE       8

struct mmu_gather {
...
        struct mmu_gather_batch local;
        struct page             *__pages[MMU_GATHER_BUNDLE];
}

struct mmu_gather_batch {
        struct mmu_gather_batch *next;
        unsigned int            nr;
        unsigned int            max;
        struct page             *pages[0];
};

#define MAX_GATHER_BATCH        \
        ((PAGE_SIZE - sizeof(struct mmu_gather_batch)) / sizeof(void *))



> Jul 05 14:33:32 gnu-hsw-1.sc.intel.com kernel: general protection
> fault: 0000 [#1] SMP PTI
> Jul 05 14:33:32 gnu-hsw-1.sc.intel.com kernel: Modules linked in:
> rpcsec_gss_krb5 nfsv4 dns_resolver nfs fscache devlink ebtable_filter
> ebtables ip6table_filter ip6_tables intel_rapl x86_pkg_temp_thermal
> intel_powerclamp coretemp snd_hda_codec_hdmi snd_hda_codec_realtek
> kvm_intel snd_hda_codec_generic snd_hda_intel kvm snd_hda_codec
> snd_hda_core snd_hwdep irqbypass crct10dif_pclmul crc32_pclmul snd_seq
> mei_wdt ghash_clmulni_intel snd_seq_device intel_cstate ppdev
> intel_uncore iTCO_wdt gpio_ich iTCO_vendor_support snd_pcm
> intel_rapl_perf snd_timer snd mei_me parport_pc joydev i2c_i801 mei
> soundcore shpchp lpc_ich parport nfsd auth_rpcgss nfs_acl lockd grace
> sunrpc i915 i2c_algo_bit drm_kms_helper r8169 drm crc32c_intel mii
> video
> Jul 05 14:33:32 gnu-hsw-1.sc.intel.com kernel: CPU: 7 PID: 7093 Comm:
> cc1 Not tainted 4.17.4-200.0.fc28.x86_64 #1
> Jul 05 14:33:32 gnu-hsw-1.sc.intel.com kernel: Hardware name: Gigabyte
> Technology Co., Ltd. H87M-D3H/H87M-D3H, BIOS F11 08/18/2015
> Jul 05 14:33:32 gnu-hsw-1.sc.intel.com kernel: RIP: 0010:free_pages_and_swap_cache+0x29/0xb0
> Jul 05 14:33:32 gnu-hsw-1.sc.intel.com kernel: RSP: 0018:ffffb2cd83ffbd58 EFLAGS: 00010202
> Jul 05 14:33:32 gnu-hsw-1.sc.intel.com kernel: RAX: 0017fffe00040068 RBX: ffff93d4abb5ec80 RCX: 0000000000000000
> Jul 05 14:33:32 gnu-hsw-1.sc.intel.com kernel: RDX: 0017fffe00040068 RSI: 00000000000001fe RDI: ffff93d51e3dd2a0
> Jul 05 14:33:32 gnu-hsw-1.sc.intel.com kernel: RBP: 00000000000001fe R08: fffff0809df82d20 R09: ffff93d51e5d5000
> Jul 05 14:33:32 gnu-hsw-1.sc.intel.com kernel: R10: ffff93d51e5d5e20 R11: ffff93d51e5d5d00 R12: ffff93d4abb5e010
> Jul 05 14:33:32 gnu-hsw-1.sc.intel.com kernel: R13: fffbf0809e304bc0 R14: ffff93d4abb5f000 R15: ffff93d4cbcee8f0
> Jul 05 14:33:32 gnu-hsw-1.sc.intel.com kernel: FS: 0000000000000000(0000) GS:ffff93d51e3c0000(0000) knlGS:0000000000000000
> Jul 05 14:33:32 gnu-hsw-1.sc.intel.com kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> Jul 05 14:33:32 gnu-hsw-1.sc.intel.com kernel: CR2: 00007ffb255e753c CR3: 00000005e820a002 CR4: 00000000001606e0
> Jul 05 14:33:32 gnu-hsw-1.sc.intel.com kernel: Call Trace:
> Jul 05 14:33:32 gnu-hsw-1.sc.intel.com kernel:  tlb_flush_mmu_free+0x31/0x50
> Jul 05 14:33:32 gnu-hsw-1.sc.intel.com kernel:  arch_tlb_finish_mmu+0x42/0x70
> Jul 05 14:33:32 gnu-hsw-1.sc.intel.com kernel:  tlb_finish_mmu+0x1f/0x30
> Jul 05 14:33:32 gnu-hsw-1.sc.intel.com kernel:  exit_mmap+0xca/0x190
> Jul 05 14:33:32 gnu-hsw-1.sc.intel.com kernel:  mmput+0x5f/0x130
> Jul 05 14:33:32 gnu-hsw-1.sc.intel.com kernel:  do_exit+0x280/0xae0
> Jul 05 14:33:32 gnu-hsw-1.sc.intel.com kernel:  ? __do_page_fault+0x263/0x4e0
> Jul 05 14:33:32 gnu-hsw-1.sc.intel.com kernel:  do_group_exit+0x3a/0xa0
> Jul 05 14:33:32 gnu-hsw-1.sc.intel.com kernel:  __x64_sys_exit_group+0x14/0x20
> Jul 05 14:33:32 gnu-hsw-1.sc.intel.com kernel:  do_syscall_64+0x65/0x160
> Jul 05 14:33:32 gnu-hsw-1.sc.intel.com kernel: entry_SYSCALL_64_after_hwframe+0x44/0xa9
> Jul 05 14:33:32 gnu-hsw-1.sc.intel.com kernel: RIP: 0033:0x7ffb2542b3c6
> Jul 05 14:33:32 gnu-hsw-1.sc.intel.com kernel: RSP: 002b:00007ffd9e7e33b8 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
> Jul 05 14:33:32 gnu-hsw-1.sc.intel.com kernel: RAX: ffffffffffffffda RBX: 00007ffb2551c740 RCX: 00007ffb2542b3c6
> Jul 05 14:33:32 gnu-hsw-1.sc.intel.com kernel: RDX: 0000000000000000 RSI: 000000000000003c RDI: 0000000000000000
> Jul 05 14:33:32 gnu-hsw-1.sc.intel.com kernel: RBP: 0000000000000000 R08: 00000000000000e7 R09: fffffffffffffe70
> Jul 05 14:33:32 gnu-hsw-1.sc.intel.com kernel: R10: 00007ffd9e7e3250 R11: 0000000000000246 R12: 00007ffb2551c740
> Jul 05 14:33:32 gnu-hsw-1.sc.intel.com kernel: R13: 0000000000000037 R14: 00007ffb25525708 R15: 0000000000000000
> Jul 05 14:33:32 gnu-hsw-1.sc.intel.com kernel: Code: 40 00 0f 1f 44 00 00 41 56 41 55 41 54 49 89 fc 55 89 f5 53 e8 29 99 fb ff 85 ed 7e 6b 8d 45 ff 4c 89 e3 4d 8d 74 c4 08 4c 8b 2b <49> 8b 55 20 48 8d 42 ff 83 e2 01 49 0f 44 c5 48 8b 48 20 48 8d
> Jul 05 14:33:32 gnu-hsw-1.sc.intel.com kernel: RIP: free_pages_and_swap_cache+0x29/0xb0 RSP: ffffb2cd83ffbd58
> Jul 05 14:33:32 gnu-hsw-1.sc.intel.com kernel: ---[ end trace 5960277fd8a3c0b5 ]---
