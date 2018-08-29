Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A93C2C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 20:24:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F1642064E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 20:24:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j6P3xC32"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F1642064E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728508AbeH3AXJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 20:23:09 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:33573 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727444AbeH3AXJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 20:23:09 -0400
Received: by mail-pl1-f193.google.com with SMTP id 60-v6so2801511ple.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 13:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=wGDptUMTuJqRtVJ81y1oJr2KnlEHAZYhjDUjGVCJ2jA=;
        b=j6P3xC32swSjwRTCmgBP61TQkzuiq4vm60tl+i7Ef/vV2DQhJnGG1tqmbN/zNkSm0A
         JJE3EBtIpoYrf8D81WDb8zRU5WLnjZKO/UJ2OyRaFM+MytQFDp8JxsO3NkFGAx0coaZP
         r9CD+ro5WqTN27oyEvJcKhTmIax+z6mnQRS0w3mgeXKwTrxOa/6Iyc7MsjKF5/OEvMyn
         jEQ2/UEm/Gl0Z/GWfAf0ey3pVILX4Tn78P2HjKxeAAiBqmCGZyqLeD5+t83zjNXjYIB5
         jb/MpIeeQmv9k5tX0PHLIlCHrlqu7oC7wz+GK8gitNA+bG5VSb+smb/Shxqbzvy3Yr5d
         p76g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=wGDptUMTuJqRtVJ81y1oJr2KnlEHAZYhjDUjGVCJ2jA=;
        b=tplxZR3NKSMc6v122Xc/1bCcodgicENWmLzZ9bLcw3Deg8EhLAAXtl/HUnhQUFavaS
         vb03BSfrhl2LKPOXP8RtvElvwiN/EiLveHNDMjC7SSMx2RNyFmn8sFjIDwxFhX13LkrL
         hJNsbq9fawRNHsLW0YETi0a3KQtoIba8XDqHYY4gnsU/6UPJ0eitI8PhSQhKcNqXBkLF
         re6EIAAEGSan5XSThw/wVEbRVsB+nGce3E8Z4ekG/jCHuv1AVfyNzg5+z/Q9BIC1e0Dl
         Q7JydKdsinqXyY0XvYQ/qhCX3l42pDjMtEEL0cfcYZSpUJTZKIT+HLDH58VvEJ23dJI5
         fI5A==
X-Gm-Message-State: APzg51DrU9vjjMpVhnQbyesrTGj1dlK0Pnz1J4ZDBxJ2rb5HUoyCZi+x
        ZAgx0BsGXBMsbPxp3J70dAOb1uin
X-Google-Smtp-Source: ANB0VdYUUPdaOxQCj9Uvk4IXwHIM3bSvySBmmZotZbftF+KpRBL+g/DFJ7Emcdo4V20HoIaLQ57kQQ==
X-Received: by 2002:a17:902:4a0c:: with SMTP id w12-v6mr7257606pld.289.1535573822233;
        Wed, 29 Aug 2018 13:17:02 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id y4-v6sm6456640pfm.137.2018.08.29.13.17.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Aug 2018 13:17:01 -0700 (PDT)
Date:   Wed, 29 Aug 2018 13:16:59 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Michal Hocko <mhocko@suse.com>,
        Andi Kleen <ak@linux.intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
        Dave Hansen <dave.hansen@intel.com>,
        Joerg Roedel <jroedel@suse.de>, Pavel Machek <pavel@ucw.cz>
Subject: efi boot failures due to PTI with 32 bit builds and Intel CPUs
Message-ID: <20180829201659.GA29801@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I see boot failures on mainline when trying to boot x86 images with an efi
bios on Intel CPUs in qemu. Behavior is quite unusual: qemu dies silently
after the kernel displays "Run /sbin/init as init process". With debugging
enabled, qemu reports a CR3 update followed by a triple fault.
Here is the end of the log file:

----------------
IN:
0xc75f1d1a:  66 90                    nop
0xc75f1d1c:  0f 20 d8                 movl     %cr3, %eax
0xc75f1d1f:  0d 00 10 00 00           orl      $0x1000, %eax
0xc75f1d24:  0f 22 d8                 movl     %eax, %cr3

CR3 update: CR3=0e39b000
----------------
IN:
0xc75f1d27:  5b                       popl     %ebx
0xc75f1d28:  59                       popl     %ecx
0xc75f1d29:  5a                       popl     %edx
0xc75f1d2a:  5e                       popl     %esi
0xc75f1d2b:  5f                       popl     %edi
0xc75f1d2c:  5d                       popl     %ebp
0xc75f1d2d:  58                       popl     %eax
0xc75f1d2e:  1f                       popl     %ds

Triple fault

This happens with both qemu 2.12 and 3.0. More detailed logs (not really
showing anything) are at http://kerneltests.org/builders; look for x86
boot reports for master and next towards the end of the page.

Here is an example qemu command line:

qemu-system-i386 -kernel arch/x86/boot/bzImage -M q35 -cpu core2duo \
	-no-reboot -m 256 \
	-bios OVMF-pure-efi-32.fd \
	-usb -device usb-storage,drive=d0 \
	-drive file=rootfs.ext2,if=none,id=d0,format=raw \
	--append 'root=/dev/sda rw rootwait mem=256M console=ttyS0 console=tty noreboot' \
	-nographic

The problem is only seen in mainline (v4.19-rc1). It is not seen in earlier
kernels. It does not really matter what to boot from as long as the boot is
with an efi bios and an Intel CPU (AMD CPUs boot fine). Bisect was a bit
tricky (see multiple runs below), but ultimately points to commit
7757d607c6b31 ("x86/pti: Allow CONFIG_PAGE_TABLE_ISOLATION for x86_32")
as the culprit. Reverting this commit indeed fixes the problem.

Please let me know if I can help tracking down the underlying issue.

Thanks,
Guenter

---
# bad: [3f16503b7d2274ac8cbab11163047ac0b4c66cfe] Merge branch 'fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/evalenti/linux-soc-thermal
# good: [94710cac0ef4ee177a63b5227664b38c95bbf703] Linux 4.18
git bisect start 'HEAD' 'v4.18'
# bad: [54dbe75bbf1e189982516de179147208e90b5e45] Merge tag 'drm-next-2018-08-15' of git://anongit.freedesktop.org/drm/drm
git bisect bad 54dbe75bbf1e189982516de179147208e90b5e45
# bad: [0a957467c5fd46142bc9c52758ffc552d4c5e2f7] x86: i8259: Add missing include file
git bisect bad 0a957467c5fd46142bc9c52758ffc552d4c5e2f7
# bad: [958f338e96f874a0d29442396d6adf9c1e17aa2d] Merge branch 'l1tf-final' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
git bisect bad 958f338e96f874a0d29442396d6adf9c1e17aa2d
# bad: [85a0b791bc17f7a49280b33e2905d109c062a47b] Merge branch 'for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux
git bisect bad 85a0b791bc17f7a49280b33e2905d109c062a47b
# good: [8603596a327c978534f5c45db135e6c36b4b1425] Merge branch 'perf-core-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
git bisect good 8603596a327c978534f5c45db135e6c36b4b1425
# bad: [eac341194426ba7ead3444923b9eba491ae4feeb] Merge branch 'x86/pti' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
git bisect bad eac341194426ba7ead3444923b9eba491ae4feeb
# good: [30de24c7dd21348b142ee977b687afc70b392af6] Merge branch 'x86-cache-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
git bisect good 30de24c7dd21348b142ee977b687afc70b392af6
# bad: [8c934e01a7ce685d98e970880f5941d79272c654] x86/pti: Check the return value of pti_user_pagetable_walk_pmd()
git bisect bad 8c934e01a7ce685d98e970880f5941d79272c654
# bad: [fcbbd977572cfe5a3dcc97d663bf7480431a07ca] x86/pgtable: Move pti_set_user_pgtbl() to pgtable.h
git bisect bad fcbbd977572cfe5a3dcc97d663bf7480431a07ca
# bad: [e5862d0515ad970ccec6208ecf5bb0cffe291ea3] x86/entry/32: Leave the kernel via trampoline stack
git bisect bad e5862d0515ad970ccec6208ecf5bb0cffe291ea3
# bad: [a6b744f3ce9d017dd86b28355de2d8e0d36496d4] x86/entry/32: Load task stack from x86_tss.sp1 in SYSENTER handler
git bisect bad a6b744f3ce9d017dd86b28355de2d8e0d36496d4
# bad: [d9f4426c73002957be5dd39936f44a09498f7560] x86/speculation: Remove SPECTRE_V2_IBRS in enum spectre_v2_mitigation
git bisect bad d9f4426c73002957be5dd39936f44a09498f7560
# bad: [21279157efffe5e7258483809942d576cb802768] x86/pti: Make pti_set_kernel_image_nonglobal() static
git bisect bad 21279157efffe5e7258483809942d576cb802768
# first bad commit: [21279157efffe5e7258483809942d576cb802768] x86/pti: Make pti_set_kernel_image_nonglobal() static

This doesn't really mean anything: The incoming merge is already broken
due to commit e181ae0c5db9, but that should be fixed in mainline.

---
# bad: [eac341194426ba7ead3444923b9eba491ae4feeb] Merge branch 'x86/pti' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
# good: [d191c82d4d9bd0bb3b945fc458cc65053ef868a0] Merge branch 'x86-vdso-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
git bisect start 'eac341194426' 'd191c82d4d9b'
# bad: [b976690f5db26fbc7c2be413bfa0fbd270547a94] x86/mm/pti: Introduce pti_finalize()
git bisect bad b976690f5db26fbc7c2be413bfa0fbd270547a94
# bad: [b65bef400689ceee7108c2d47fb97ae91f4d1440] x86/entry/32: Add PTI CR3 switches to NMI handler code
git bisect bad b65bef400689ceee7108c2d47fb97ae91f4d1440
# bad: [8e676ced31e9d1448d3ffc4159586a259cc67f30] x86/entry/32: Unshare NMI return path
git bisect bad 8e676ced31e9d1448d3ffc4159586a259cc67f30
# bad: [9e97b73fdb235345a826519862a52a7398c89eb8] x86/asm-offsets: Move TSS_sp0 and TSS_sp1 to asm-offsets.c
git bisect bad 9e97b73fdb235345a826519862a52a7398c89eb8
# bad: [d9f4426c73002957be5dd39936f44a09498f7560] x86/speculation: Remove SPECTRE_V2_IBRS in enum spectre_v2_mitigation
git bisect bad d9f4426c73002957be5dd39936f44a09498f7560
# bad: [21279157efffe5e7258483809942d576cb802768] x86/pti: Make pti_set_kernel_image_nonglobal() static
git bisect bad 21279157efffe5e7258483809942d576cb802768
# first bad commit: [21279157efffe5e7258483809942d576cb802768] x86/pti: Make pti_set_kernel_image_nonglobal() static

---
# bad: [21279157efffe5e7258483809942d576cb802768] x86/pti: Make pti_set_kernel_image_nonglobal() static
# good: [1e4b044d22517cae7047c99038abb444423243ca] Linux 4.18-rc4
git bisect start '21279157efffe5e7258483809942d576cb802768' 'v4.18-rc4'
# good: [35a84f34cf41915a0b2d0a3688b20761580f8ce4] Merge tag 'trace-v4.18-rc3-3' of git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace
git bisect good 35a84f34cf41915a0b2d0a3688b20761580f8ce4
# good: [75adbd1386796c1234035996c6aec3ede4060eb2] Merge branch 'efi-urgent-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
git bisect good 75adbd1386796c1234035996c6aec3ede4060eb2
# good: [2db39a2f491a48ec740e0214a7dd584eefc2137d] Merge branch 'i2c/for-current' of git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux
git bisect good 2db39a2f491a48ec740e0214a7dd584eefc2137d
# good: [fe10e398e860955bac4d28ec031b701d358465e4] reiserfs: fix buffer overflow with long warning messages
git bisect good fe10e398e860955bac4d28ec031b701d358465e4
# bad: [c31496dbacc2b6352750937afc20a8dbe22b27a4] Merge tag 'for-linus-4.18-rc5-tag' of git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip
git bisect bad c31496dbacc2b6352750937afc20a8dbe22b27a4
# bad: [2da8c426d90355eef1d42d974d2dccf0f5f7f21d] Merge tag 'for-linus-20180713' of git://git.kernel.dk/linux-block
git bisect bad 2da8c426d90355eef1d42d974d2dccf0f5f7f21d
# bad: [f353078f028fbfe9acd4b747b4a19c69ef6846cd] Merge branch 'akpm' (patches from Andrew)
git bisect bad f353078f028fbfe9acd4b747b4a19c69ef6846cd
# bad: [e181ae0c5db9544de9c53239eb22bc012ce75033] mm: zero unavailable pages before memmap init
git bisect bad e181ae0c5db9544de9c53239eb22bc012ce75033
# first bad commit: [e181ae0c5db9544de9c53239eb22bc012ce75033] mm: zero unavailable pages before memmap init

This 'bad' patch created a problem with 32-bit images which was later
fixed with commit d1b47a7c9efc ("mm: don't do zero_resv_unavail if memmap
is not allocated"). Reverting those two patches in mainline does _not_
fix the problem. With that in mind, I applied commit d1b47a7c9efc on top
of 21279157efffe and ran another test. This test passed, so the above is
a false positive.

---
Another bisect run, this time applying d1b47a7c9efc if 21279157efffe
is in the image but d1b47a7c9efc isn't.

# bad: [781fca5b104693bc9242199cc47c690dcaf6a4cb] Merge tag 'xfs-4.19-merge-6' of git://git.kernel.org/pub/scm/fs/xfs/xfs-linux
# good: [94710cac0ef4ee177a63b5227664b38c95bbf703] Linux 4.18
git bisect start 'HEAD' 'v4.18'
# bad: [85a0b791bc17f7a49280b33e2905d109c062a47b] Merge branch 'for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux
git bisect bad 85a0b791bc17f7a49280b33e2905d109c062a47b
# good: [8603596a327c978534f5c45db135e6c36b4b1425] Merge branch 'perf-core-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
git bisect good 8603596a327c978534f5c45db135e6c36b4b1425
# bad: [eac341194426ba7ead3444923b9eba491ae4feeb] Merge branch 'x86/pti' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
git bisect bad eac341194426ba7ead3444923b9eba491ae4feeb
# good: [30de24c7dd21348b142ee977b687afc70b392af6] Merge branch 'x86-cache-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
git bisect good 30de24c7dd21348b142ee977b687afc70b392af6
# bad: [8c934e01a7ce685d98e970880f5941d79272c654] x86/pti: Check the return value of pti_user_pagetable_walk_pmd()
git bisect bad 8c934e01a7ce685d98e970880f5941d79272c654
# good: [fcbbd977572cfe5a3dcc97d663bf7480431a07ca] x86/pgtable: Move pti_set_user_pgtbl() to pgtable.h
git bisect good fcbbd977572cfe5a3dcc97d663bf7480431a07ca
# good: [ba0364e260ab37c02975557dbecc014a26072236] x86/mm/pti: Clone entry-text again in pti_finalize()
git bisect good ba0364e260ab37c02975557dbecc014a26072236
# good: [9bae3197e15dd5e03ce8e237db6fe4486b08a775] x86/ldt: Split out sanity check in map_ldt_struct()
git bisect good 9bae3197e15dd5e03ce8e237db6fe4486b08a775
# bad: [5e8105950a8b3e03e805299b4d05020ee4eda31a] x86/mm/pti: Add Warning when booting on a PCID capable CPU
git bisect bad 5e8105950a8b3e03e805299b4d05020ee4eda31a
# bad: [7757d607c6b31867777de42e1fb0210b9c5d8b70] x86/pti: Allow CONFIG_PAGE_TABLE_ISOLATION for x86_32
git bisect bad 7757d607c6b31867777de42e1fb0210b9c5d8b70
# good: [6df934b92a549cb3badb6d576f71aeb133e2f110] x86/ldt: Enable LDT user-mapping for PAE
git bisect good 6df934b92a549cb3badb6d576f71aeb133e2f110
# first bad commit: [7757d607c6b31867777de42e1fb0210b9c5d8b70] x86/pti: Allow CONFIG_PAGE_TABLE_ISOLATION for x86_32
