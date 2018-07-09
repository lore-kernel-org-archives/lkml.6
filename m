Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4684C5CFE7
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 23:02:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 450DB2075B
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 23:02:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rFZKlLLN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 450DB2075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933216AbeGIXCf (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 19:02:35 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:33174 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754406AbeGIXCc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 19:02:32 -0400
Received: by mail-oi0-f65.google.com with SMTP id c6-v6so39108756oiy.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jul 2018 16:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=pB9eGs0bRfqc2jGZyplXvSRA1wE4ejm1UrD0KLNRLOg=;
        b=rFZKlLLNFBQ6AF42oQqqrYV1YP7Vhf/rjuWHrNQAtMzo7wsdTYT6RkWeCLxRXFZA6D
         LwoX1ib9HODjP3KeYqWJ3x7pyeX1xB0+qZ6keiKK6j0INYtdSvptdPsjaRkHTCQ3LkjR
         fFyNWd7m24uIEsZF6VDzYORu+ZDYddbaMEjZEHYcQ8pJiu2K6T/amNBHqSE7412zwWRl
         kgPS0g/WMMAyYRd84kUlPPskKp3hpiYUtY3bsuIuMilcfRo9MCeV4ZC0hJLRXhKwjrhQ
         JezIL/Vzwos4JTiwwbhNBfzRaM314iqMpO3WYNlDKnb5LMFvjWV01l1qRlbYXzyGz+Te
         dSJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=pB9eGs0bRfqc2jGZyplXvSRA1wE4ejm1UrD0KLNRLOg=;
        b=lvPnfefV1nne5dwI1wVqMgVVRqM93hJYcGT4LrGWWKN2FdGM1uBcOLEieowK6z6MVy
         OnHsORQBGR5VooHPSSn5RJBg4kFOYvvAKLTNd+2i3VHLEQShSglo6mZg/kpB8hOJGy03
         pHownwsP9EkD5ouPWCuMqdhsmbyC/iQGBk9thnetuVFqYY6xpUcMuT4mkrP1gBiZWYn6
         p38DrThQ4ESLMdrBaAOagE1DUO88kACeKm6ueRET/4QyWR+2t65arcJEcBfDUoNSO+Wh
         GjdSSDUmMo34RGsuDL+Qz19AjDoT/wVMwOF9V7pR1My75BF8v50UK5I/SARxBlaanr20
         q3vA==
X-Gm-Message-State: APt69E1csSvUbv7ETyOcGvazf1A/I+MHUSMLH3aM9vcj7SjaLOsrItai
        aLUe88wJK8UY0zOiLkGwEnXfyP01Bzv5vIME04A=
X-Google-Smtp-Source: AAOMgpdc0UCxJdu4zo3/84XnHJ174roVMd5XCuz9D2au0F1oegylVPy2C0Kaw3jY1Mp3kicvPaRthBcHfYfKRkGrMao=
X-Received: by 2002:aca:5754:: with SMTP id l81-v6mr26942628oib.100.1531177351554;
 Mon, 09 Jul 2018 16:02:31 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4a:c984:0:0:0:0:0 with HTTP; Mon, 9 Jul 2018 16:02:30 -0700 (PDT)
In-Reply-To: <50d6bb50-5fa4-33d1-1f88-3844d0237f16@intel.com>
References: <CAMe9rOqXsQ4Onv8_-kYE_yVYVfN0Hsg81XM0sq9k2cVYE_LvaQ@mail.gmail.com>
 <50d6bb50-5fa4-33d1-1f88-3844d0237f16@intel.com>
From:   "H.J. Lu" <hjl.tools@gmail.com>
Date:   Mon, 9 Jul 2018 16:02:30 -0700
Message-ID: <CAMe9rOoA=OoyaUfOvWuHGTp_ii9-A_ecR5tj8CefBKx_Hmi50g@mail.gmail.com>
Subject: Re: Kernel 4.17.4 lockup
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     "H. Peter Anvin" <hpa@zytor.com>,
        Matthew Wilcox <mawilcox@microsoft.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 9, 2018 at 7:54 AM, Dave Hansen <dave.hansen@intel.com> wrote:
> On 07/09/2018 06:19 AM, Lu, Hongjiu wrote:
>> On 3 x86-64 machines, kernel 4.17.4 locked up under heavy load. 2 of
> them don't  have any kernel messages.  One has
>
> Hi H.J.,
>
> It'd be really handy if you could pastebin things like this, or attach a
> text file with the oops. Your email wrapped the heck out of the oops and
> I had to go and unwrap it to read it.
>
> A full disassembly of free_pages_and_swap_cache() from the actual
> vmlinux to account for differences between toolchains would be helpful.
> It'll probably help me figure out what the loop counter was for
> instance.  It makes it a bit easier to read random oopses if you boot
> with 'nokaslr' because the pointer types (kernel text, linear map,
> vmemmap, etc...) stick out much more easily. Would you be able to boot
> with it in the future?

I will do that if it happens again.

> We've had a bit of churn in that code, but nothing between 4.16 and 4.17
> that really sticks out to me in the x86 code.
>
> The general protection fault is a bit of an oddball. If I disassembled
> right, it's trying to dereference %R13+20. That doesn't even cross a

This is correct.

> page boundary, so it's a bit hard to fathom where the #GP would come from.

(gdb) disass free_pages_and_swap_cache
Dump of assembler code for function free_pages_and_swap_cache:
   0xffffffff8124c0d0 <+0>: callq  0xffffffff81a017a0 <__fentry__>
   0xffffffff8124c0d5 <+5>: push   %r14
   0xffffffff8124c0d7 <+7>: push   %r13
   0xffffffff8124c0d9 <+9>: push   %r12
   0xffffffff8124c0db <+11>: mov    %rdi,%r12
   0xffffffff8124c0de <+14>: push   %rbp
   0xffffffff8124c0df <+15>: mov    %esi,%ebp
   0xffffffff8124c0e1 <+17>: push   %rbx
   0xffffffff8124c0e2 <+18>: callq  0xffffffff81205a10 <lru_add_drain>
   0xffffffff8124c0e7 <+23>: test   %ebp,%ebp
   0xffffffff8124c0e9 <+25>: jle    0xffffffff8124c156
<free_pages_and_swap_cache+134>
   0xffffffff8124c0eb <+27>: lea    -0x1(%rbp),%eax
   0xffffffff8124c0ee <+30>: mov    %r12,%rbx
   0xffffffff8124c0f1 <+33>: lea    0x8(%r12,%rax,8),%r14
   0xffffffff8124c0f6 <+38>: mov    (%rbx),%r13
   0xffffffff8124c0f9 <+41>: mov    0x20(%r13),%rdx
<<<<<<<<<<<<<<<<<<<< GPF here.
   0xffffffff8124c0fd <+45>: lea    -0x1(%rdx),%rax
   0xffffffff8124c101 <+49>: and    $0x1,%edx
   0xffffffff8124c104 <+52>: cmove  %r13,%rax
   0xffffffff8124c108 <+56>: mov    0x20(%rax),%rcx
   0xffffffff8124c10c <+60>: lea    -0x1(%rcx),%rdx
   0xffffffff8124c110 <+64>: and    $0x1,%ecx
   0xffffffff8124c113 <+67>: cmove  %rax,%rdx
   0xffffffff8124c117 <+71>: mov    (%rdx),%rdx
   0xffffffff8124c11a <+74>: test   $0x40000,%edx
   0xffffffff8124c120 <+80>: je     0xffffffff8124c14d
<free_pages_and_swap_cache+125>
   0xffffffff8124c122 <+82>: mov    (%rax),%rax
   0xffffffff8124c125 <+85>: test   $0x2,%ah
   0xffffffff8124c128 <+88>: je     0xffffffff8124c14d
<free_pages_and_swap_cache+125>
   0xffffffff8124c12a <+90>: mov    %r13,%rdi
   0xffffffff8124c12d <+93>: callq  0xffffffff81218260 <page_mapped>
   0xffffffff8124c132 <+98>: test   %al,%al
   0xffffffff8124c134 <+100>: jne    0xffffffff8124c14d
<free_pages_and_swap_cache+125>
   0xffffffff8124c136 <+102>: mov    0x20(%r13),%rdx
   0xffffffff8124c13a <+106>: lea    -0x1(%rdx),%rax
   0xffffffff8124c13e <+110>: and    $0x1,%edx
   0xffffffff8124c141 <+113>: cmove  %r13,%rax
   0xffffffff8124c145 <+117>: lock btsq $0x0,(%rax)
   0xffffffff8124c14b <+123>: jae    0xffffffff8124c168
<free_pages_and_swap_cache+152>
   0xffffffff8124c14d <+125>: add    $0x8,%rbx
   0xffffffff8124c151 <+129>: cmp    %rbx,%r14
   0xffffffff8124c154 <+132>: jne    0xffffffff8124c0f6
<free_pages_and_swap_cache+38>
   0xffffffff8124c156 <+134>: pop    %rbx
   0xffffffff8124c157 <+135>: mov    %ebp,%esi
   0xffffffff8124c159 <+137>: mov    %r12,%rdi
   0xffffffff8124c15c <+140>: pop    %rbp
   0xffffffff8124c15d <+141>: pop    %r12
   0xffffffff8124c15f <+143>: pop    %r13
   0xffffffff8124c161 <+145>: pop    %r14
   0xffffffff8124c163 <+147>: jmpq   0xffffffff81204600 <release_pages>
   0xffffffff8124c168 <+152>: mov    %r13,%rdi
   0xffffffff8124c16b <+155>: callq  0xffffffff81250aa0 <try_to_free_swap>
   0xffffffff8124c170 <+160>: mov    %r13,%rdi
   0xffffffff8124c173 <+163>: callq  0xffffffff811ed140 <unlock_page>
   0xffffffff8124c178 <+168>: jmp    0xffffffff8124c14d
<free_pages_and_swap_cache+125>
End of assembler dump.
(gdb)

> (mostly) unwrapped oops below.
>
>>> Jul 05 14:33:32 gnu-hsw-1.sc.intel.com kernel: general protection
>>> fault: 0000 [#1] SMP PTI
>>> Jul 05 14:33:32 gnu-hsw-1.sc.intel.com kernel: Modules linked in:
>>> rpcsec_gss_krb5 nfsv4 dns_resolver nfs fscache devlink ebtable_filter
>>> ebtables ip6table_filter ip6_tables intel_rapl x86_pkg_temp_thermal
>>> intel_powerclamp coretemp snd_hda_codec_hdmi snd_hda_codec_realtek
>>> kvm_intel snd_hda_codec_generic snd_hda_intel kvm snd_hda_codec
>>> snd_hda_core snd_hwdep irqbypass crct10dif_pclmul crc32_pclmul snd_seq
>>> mei_wdt ghash_clmulni_intel snd_seq_device intel_cstate ppdev
>>> intel_uncore iTCO_wdt gpio_ich iTCO_vendor_support snd_pcm
>>> intel_rapl_perf snd_timer snd mei_me parport_pc joydev i2c_i801 mei
>>> soundcore shpchp lpc_ich parport nfsd auth_rpcgss nfs_acl lockd grace
>>> sunrpc i915 i2c_algo_bit drm_kms_helper r8169 drm crc32c_intel mii
>>> video
>>> Jul 05 14:33:32 gnu-hsw-1.sc.intel.com kernel: CPU: 7 PID: 7093 Comm:
>>> cc1 Not tainted 4.17.4-200.0.fc28.x86_64 #1
>>> Jul 05 14:33:32 gnu-hsw-1.sc.intel.com kernel: Hardware name: Gigabyte
>>> Technology Co., Ltd. H87M-D3H/H87M-D3H, BIOS F11 08/18/2015
>>> Jul 05 14:33:32 gnu-hsw-1.sc.intel.com kernel: RIP: 0010:free_pages_and_swap_cache+0x29/0xb0
>>> Jul 05 14:33:32 gnu-hsw-1.sc.intel.com kernel: RSP: 0018:ffffb2cd83ffbd58 EFLAGS: 00010202
>>> Jul 05 14:33:32 gnu-hsw-1.sc.intel.com kernel: RAX: 0017fffe00040068 RBX: ffff93d4abb5ec80 RCX: 0000000000000000
>>> Jul 05 14:33:32 gnu-hsw-1.sc.intel.com kernel: RDX: 0017fffe00040068 RSI: 00000000000001fe RDI: ffff93d51e3dd2a0
>>> Jul 05 14:33:32 gnu-hsw-1.sc.intel.com kernel: RBP: 00000000000001fe R08: fffff0809df82d20 R09: ffff93d51e5d5000
>>> Jul 05 14:33:32 gnu-hsw-1.sc.intel.com kernel: R10: ffff93d51e5d5e20 R11: ffff93d51e5d5d00 R12: ffff93d4abb5e010
>>> Jul 05 14:33:32 gnu-hsw-1.sc.intel.com kernel: R13: fffbf0809e304bc0 R14: ffff93d4abb5f000 R15: ffff93d4cbcee8f0
>>> Jul 05 14:33:32 gnu-hsw-1.sc.intel.com kernel: FS: 0000000000000000(0000) GS:ffff93d51e3c0000(0000) knlGS:0000000000000000
>>> Jul 05 14:33:32 gnu-hsw-1.sc.intel.com kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>> Jul 05 14:33:32 gnu-hsw-1.sc.intel.com kernel: CR2: 00007ffb255e753c CR3: 00000005e820a002 CR4: 00000000001606e0
>>> Jul 05 14:33:32 gnu-hsw-1.sc.intel.com kernel: Call Trace:
>>> Jul 05 14:33:32 gnu-hsw-1.sc.intel.com kernel:  tlb_flush_mmu_free+0x31/0x50
>>> Jul 05 14:33:32 gnu-hsw-1.sc.intel.com kernel:  arch_tlb_finish_mmu+0x42/0x70
>>> Jul 05 14:33:32 gnu-hsw-1.sc.intel.com kernel:  tlb_finish_mmu+0x1f/0x30
>>> Jul 05 14:33:32 gnu-hsw-1.sc.intel.com kernel:  exit_mmap+0xca/0x190
>>> Jul 05 14:33:32 gnu-hsw-1.sc.intel.com kernel:  mmput+0x5f/0x130
>>> Jul 05 14:33:32 gnu-hsw-1.sc.intel.com kernel:  do_exit+0x280/0xae0
>>> Jul 05 14:33:32 gnu-hsw-1.sc.intel.com kernel:  ? __do_page_fault+0x263/0x4e0
>>> Jul 05 14:33:32 gnu-hsw-1.sc.intel.com kernel:  do_group_exit+0x3a/0xa0
>>> Jul 05 14:33:32 gnu-hsw-1.sc.intel.com kernel:  __x64_sys_exit_group+0x14/0x20
>>> Jul 05 14:33:32 gnu-hsw-1.sc.intel.com kernel:  do_syscall_64+0x65/0x160
>>> Jul 05 14:33:32 gnu-hsw-1.sc.intel.com kernel: entry_SYSCALL_64_after_hwframe+0x44/0xa9
>>> Jul 05 14:33:32 gnu-hsw-1.sc.intel.com kernel: RIP: 0033:0x7ffb2542b3c6
>>> Jul 05 14:33:32 gnu-hsw-1.sc.intel.com kernel: RSP: 002b:00007ffd9e7e33b8 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
>>> Jul 05 14:33:32 gnu-hsw-1.sc.intel.com kernel: RAX: ffffffffffffffda RBX: 00007ffb2551c740 RCX: 00007ffb2542b3c6
>>> Jul 05 14:33:32 gnu-hsw-1.sc.intel.com kernel: RDX: 0000000000000000 RSI: 000000000000003c RDI: 0000000000000000
>>> Jul 05 14:33:32 gnu-hsw-1.sc.intel.com kernel: RBP: 0000000000000000 R08: 00000000000000e7 R09: fffffffffffffe70
>>> Jul 05 14:33:32 gnu-hsw-1.sc.intel.com kernel: R10: 00007ffd9e7e3250 R11: 0000000000000246 R12: 00007ffb2551c740
>>> Jul 05 14:33:32 gnu-hsw-1.sc.intel.com kernel: R13: 0000000000000037 R14: 00007ffb25525708 R15: 0000000000000000
>>> Jul 05 14:33:32 gnu-hsw-1.sc.intel.com kernel: Code: 40 00 0f 1f 44 00 00 41 56 41 55 41 54 49 89 fc 55 89 f5 53 e8 29 99 fb ff 85 ed 7e 6b 8d 45 ff 4c 89 e3 4d 8d 74 c4 08 4c 8b 2b <49> 8b 55 20 48 8d 42 ff 83 e2 01 49 0f 44 c5 48 8b 48 20 48 8d
>>> Jul 05 14:33:32 gnu-hsw-1.sc.intel.com kernel: RIP: free_pages_and_swap_cache+0x29/0xb0 RSP: ffffb2cd83ffbd58
>>> Jul 05 14:33:32 gnu-hsw-1.sc.intel.com kernel: ---[ end trace 5960277fd8a3c0b5 ]---



-- 
H.J.
