Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34D8CC282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 04:02:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE7012184C
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 04:02:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aWdr6EyM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727222AbfAXEC0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 23:02:26 -0500
Received: from mail-yw1-f66.google.com ([209.85.161.66]:42542 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726313AbfAXECZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 23:02:25 -0500
Received: by mail-yw1-f66.google.com with SMTP id x2so1868071ywc.9
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jan 2019 20:02:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=hUkZl4Cc7ExXhycXhu43F8Sm6HpmeGkpG+AAa8+0xk0=;
        b=aWdr6EyMtZPJpmV/AkNKufqfLyuVxeWISTJDmQMDv1NFCWJ24TOK49yFT+AJh3Mr5l
         qTk8RAi/HtILy5PeIiPb33dAUfzy9RFDjni4n301/agtQo+HWxowQZceb5sNFVsQEyFf
         aFEuY0kBXdPSdauZRF/M2yHyP+BAny98HX6orVscLBemQeW2F5c5U6zlb6bZzmuNCfaD
         mmE56bIFe79uRhVC/VEP9kqy9GKqhguJbYPPf4BPUXRnHY4sDfEALQva6WTbGTwOkify
         v5jor9yRgxLBGIud7xHfEwp5/4aRY3m1fZXQn1RUwm+mCZ/BzFGFOjMm/bdTg1DGhVVb
         1XPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=hUkZl4Cc7ExXhycXhu43F8Sm6HpmeGkpG+AAa8+0xk0=;
        b=BpPlQl3/CGertKGfKKOmUyoceWSHJbNm3cdc+agc8zj/U24URd0miIxdFa7WC2nQpM
         FGpikM0uXvJf49+Zd+CRbcVIC2q85Ppa4jt4Qvjq8mZzZXryD/qYK/9ONGmuf5rYLOg2
         j1abIrHDZ+NplP7+e8suo8QlES8nTcNTfY6ARWH5trxE8O7R8whxfoiuRUWEU7hf+M4D
         bSfrHDDVJLHqjhXGb1bL+uALbl2ONX2RHXFz9RRxAiTc4t7IGI/xawdXY6PD1pf8jWSZ
         nd7s4EGreTixrvlhPolOzn4kFhFs0nGRgi+I0+GwvO4SylCdso8Ex2+IlvzkdHd+LhQo
         Kr9Q==
X-Gm-Message-State: AJcUukeIWH+tG91cKTNV2ncR2ETyBIgZRWVRvjg9US2EiNbrf/0KYoev
        5jRZ1BnSqtjCX6YRh+FtI2I5nLggQEUhjKB6pD1mDLDq
X-Google-Smtp-Source: ALg8bN4RDsI2a2vwA0dUptqRIheCt6hmTLaX8IyblNs03Fa5GAjdOKddj1sBXK5JkCPSKqFt74B4X5FkPsi+jfPYGbs=
X-Received: by 2002:a0d:f2c5:: with SMTP id b188mr4814605ywf.341.1548302544228;
 Wed, 23 Jan 2019 20:02:24 -0800 (PST)
MIME-Version: 1.0
References: <CA+ToGPEQgJ=0eFgbS2C9BexG=Js27vUWikEHqyLE6qs3viE-5g@mail.gmail.com>
In-Reply-To: <CA+ToGPEQgJ=0eFgbS2C9BexG=Js27vUWikEHqyLE6qs3viE-5g@mail.gmail.com>
From:   Diego Viola <diego.viola@gmail.com>
Date:   Thu, 24 Jan 2019 02:02:12 -0200
Message-ID: <CA+ToGPF+Arjg=Tw4gCdJTht4p=mvZyjWa7FGUBPLqcryMJ4wQA@mail.gmail.com>
Subject: Fwd: Nested KVM is broken on a AMD Ryzen 5 2400G
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

---------- Forwarded message ---------
From: Diego Viola <diego.viola@gmail.com>
Date: Thu, Jan 24, 2019 at 1:57 AM
Subject: Nested KVM is broken on a AMD Ryzen 5 2400G
To: <pbonzini@redhat.com>, <rkrcmar@redhat.com>,
<kvm@vger.kernel.org>, <joro@8bytes.org>


Hello,

I am trying to do nested KVM on a Ryzen 5 2400G, my use case is the following:

- Arch Linux as the host OS.
- Ubuntu 18.04.1 as the guest OS.

I am using qemu 3.1.0-1 (from the extra repository) on Arch Linux.

This is the command I am using to start the VM:

qemu-system-x86_64 -enable-kvm -hda ubuntu.qcow2 -m 4G -smp 4 -vga
virtio -cpu host

The reason I need nested KVM is that I am trying to build some snap
packages on Ubuntu, and that uses an utility called "multipass" which
seems to run some VMs.

Anyway, everything works until I run "snapcraft", which then calls
multipass and I get the following on the host dmesg:

[10499.577192] WARNING: CPU: 2 PID: 3487 at arch/x86/kvm/mmu.c:2066
nonpaging_update_pte+0x5/0x10 [kvm]
[10499.577194] Modules linked in: kvm_amd fuse cfg80211 8021q garp mrp
stp llc nls_iso8859_1 nls_cp437 vfat fat amdgpu edac_mce_amd ccp
rng_core kvm irqbypass chash amd_iommu_v2 gpu_sched crct10dif_pclmul
i2c_algo_bit crc32_pclmul ghash_clmulni_intel ttm
snd_hda_codec_realtek snd_hda_codec_generic drm_kms_helper eeepc_wmi
asus_wmi sparse_keymap snd_hda_codec_hdmi rfkill drm wmi_bmof
snd_hda_intel aesni_intel snd_hda_codec snd_hda_core aes_x86_64
crypto_simd snd_hwdep cryptd r8169 glue_helper snd_pcm agpgart
syscopyarea sysfillrect snd_timer libphy sysimgblt fb_sys_fops snd
joydev mousedev input_leds soundcore sp5100_tco i2c_piix4 pcspkr
k10temp wmi evdev pinctrl_amd mac_hid gpio_amdpt pcc_cpufreq
acpi_cpufreq ip_tables x_tables ext4 crc32c_generic crc16 mbcache jbd2
fscrypto hid_generic usbhid hid sd_mod crc32c_intel ahci libahci
libata xhci_pci xhci_hcd scsi_mod [last unloaded: kvm_amd]
[10499.577229] CPU: 2 PID: 3487 Comm: qemu-system-x86 Tainted: G
 W         4.20.3-arch1-1-ARCH #1
[10499.577230] Hardware name: System manufacturer System Product
Name/PRIME A320M-K/BR, BIOS 4023 08/20/2018
[10499.577241] RIP: 0010:nonpaging_update_pte+0x5/0x10 [kvm]
[10499.577243] Code: 00 00 00 00 00 0f 1f 44 00 00 31 c0 c3 0f 1f 84
00 00 00 00 00 0f 1f 44 00 00 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f
44 00 00 <0f> 0b c3 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 31 f6 eb 16
83 68
[10499.577244] RSP: 0018:ffff99fe480c7a90 EFLAGS: 00010202
[10499.577245] RAX: ffffffffc08d4b10 RBX: 0000000000000701 RCX: ffff99fe480c7ac0
[10499.577246] RDX: ffff95480a349000 RSI: ffff954884b73460 RDI: ffff9548aef88000
[10499.577246] RBP: ffff954884b73460 R08: ffff95480a349000 R09: 0000000000000000
[10499.577247] R10: 0000000000000008 R11: 0000000000000007 R12: 0000000000000000
[10499.577248] R13: ffff95480a349000 R14: ffff9548aef88000 R15: ffff99fe480c7ac8
[10499.577249] FS:  00007f8d9c7ff700(0000) GS:ffff954997a80000(0000)
knlGS:0000000000000000
[10499.577250] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[10499.577250] CR2: 000055761b641000 CR3: 0000000121cfe000 CR4: 00000000003406e0
[10499.577251] Call Trace:
[10499.577265]  kvm_mmu_pte_write+0x487/0x4a0 [kvm]
[10499.577277]  kvm_page_track_write+0x7c/0xa0 [kvm]
[10499.577288]  emulator_write_phys+0x36/0x50 [kvm]
[10499.577299]  emulator_read_write_onepage+0xef/0x330 [kvm]
[10499.577309]  emulator_read_write+0xc8/0x180 [kvm]
[10499.577320]  segmented_write+0x5d/0x80 [kvm]
[10499.577332]  writeback+0xf4/0x260 [kvm]
[10499.577343]  ? em_in+0x13a/0x240 [kvm]
[10499.577354]  x86_emulate_insn+0x7b4/0x10a0 [kvm]
[10499.577364]  x86_emulate_instruction+0x33e/0x720 [kvm]
[10499.577374]  complete_emulated_pio+0x33/0x60 [kvm]
[10499.577384]  kvm_arch_vcpu_ioctl_run+0x1652/0x1b30 [kvm]
[10499.577387]  ? pollwake+0x74/0x90
[10499.577397]  ? kvm_vm_ioctl_irq_line+0x23/0x30 [kvm]
[10499.577404]  kvm_vcpu_ioctl+0x2b8/0x600 [kvm]
[10499.577407]  ? wake_up_q+0x70/0x70
[10499.577409]  do_vfs_ioctl+0xa4/0x630
[10499.577412]  ksys_ioctl+0x60/0x90
[10499.577413]  __x64_sys_ioctl+0x16/0x20
[10499.577416]  do_syscall_64+0x5b/0x170
[10499.577419]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[10499.577421] RIP: 0033:0x7f8da3cd380b
[10499.577422] Code: 0f 1e fa 48 8b 05 55 b6 0c 00 64 c7 00 26 00 00
00 48 c7 c0 ff ff ff ff c3 66 0f 1f 44 00 00 f3 0f 1e fa b8 10 00 00
00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 25 b6 0c 00 f7 d8 64 89
01 48
[10499.577422] RSP: 002b:00007f8d9c7fcec8 EFLAGS: 00000246 ORIG_RAX:
0000000000000010
[10499.577424] RAX: ffffffffffffffda RBX: 000000000000ae80 RCX: 00007f8da3cd380b
[10499.577424] RDX: 0000000000000000 RSI: 000000000000ae80 RDI: 0000000000000011
[10499.577425] RBP: 0000000000000000 R08: 0000559ab1460b50 R09: 0000000000000004
[10499.577425] R10: 0000000000000001 R11: 0000000000000246 R12: 00007f8d9e58d3c0
[10499.577426] R13: 00007f8da2111000 R14: 0000000000000000 R15: 00007f8d9e58d3c0
[10499.577428] ---[ end trace 4f89a414fced52ea ]---

Please let me know if you need more information. I've tried the same
thing on a broadwell laptop (T450) and nested KVM works just fine
there.

The host Arch kernel is:

[diego@ryzen ~]$ uname -a
Linux ryzen 4.20.3-arch1-1-ARCH #1 SMP PREEMPT Wed Jan 16 22:38:58 UTC
2019 x86_64 GNU/Linux
[diego@ryzen ~]$

The guest Ubuntu kernel:

diego@diego-Standard-PC-i440FX-PIIX-1996:~$ uname -a
Linux diego-Standard-PC-i440FX-PIIX-1996 4.15.0-29-generic #31-Ubuntu
SMP Tue Jul 17 15:39:52 UTC 2018 x86_64 x86_64 x86_64 GNU/Linux
diego@diego-Standard-PC-i440FX-PIIX-1996:~$

The issues I experience besides dmesg being flooded with the above
message on the host OS is that the snapcraft utility just doesn't work
on the guest, it times out, while on the T450 it works right away.
This leads me to think that nested KVM is broken on AMD.

Thanks,
Diego
