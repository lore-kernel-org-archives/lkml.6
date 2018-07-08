Return-Path: <SRS0=ZPnh=JY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E32D2C3279B
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 21:36:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E72A208AF
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 21:36:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FwbaV+xp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E72A208AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933135AbeGHVgm (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Jul 2018 17:36:42 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:35023 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754369AbeGHVgk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jul 2018 17:36:40 -0400
Received: by mail-oi0-f67.google.com with SMTP id i12-v6so32397539oik.2
        for <linux-kernel@vger.kernel.org>; Sun, 08 Jul 2018 14:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=VdgQqWfln7ipSNgRnPuk3hCn1mGoFnE2QFTKFnzyGG0=;
        b=FwbaV+xp0ADTPxKGLvUuk8u46QbHJwH9pKtXj2wm/0Q+b8HZ2jfCh7xsSIFkaxr6eV
         mp1/zcdYFCB7xTsnBMZL4QViViCirrnfcJs6Q276nA7DHz69H+bngmNOAARsj2vEY/34
         0S0yBHD6pMzwGirPM9k5KV6bFU2GRCKjv7EQ7wDUTVElaCqF2V3/+mmc8tXAZDAlLlyI
         NLC8r3KTp6rEPCNIlEp+EM8e6IxEUmwfIfs1OSV5rbK8kcJDEIEiErgdKYQMpx+Z5AgB
         d0fxkf+Cm8QSjNNUiVIfdAkld+zM1oCgKMgJYe7166aZCECgzrHuRt74/6K6QDMtsOdh
         2A2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=VdgQqWfln7ipSNgRnPuk3hCn1mGoFnE2QFTKFnzyGG0=;
        b=XVrBG6cmkgNourwk44BxcUrwnwMU3oC2+JLnrtpnEd7csNhPcGppGAZU+QwiGhwWRu
         wbwvDqfcRBLqZFsgeHO8ygziriNarfFMtpiY1oq0aO/mWGNiR6PTNGf+Sn7AUMLP3GtV
         Bt/2k7Uy30hAmE9+3AwEoJClpm+O1qRdx+bCB8zkh+l8r8DEP1bM5/w4BKU9U26/pDXc
         c4GKqJHXScAu4yOFm2w3vwKhFKJsQobverQuMbTbEaZ4TNf7lcPduL7cqMig2NsdhSsd
         1KGw9dlfkgorXjBDKxHSy9PZqchgOXYsFvraECMYiLxXThS9iJEDuUUklMOD5YWpz49i
         Yqzw==
X-Gm-Message-State: APt69E0xeSOgCa79xReIxzjNuNWR6B279L1kYPBVM4xVQmXrmHAOBdjJ
        bkNk1CuLhrDIvuv9KEGxCwvKdtX1ydz6/wxaoKY=
X-Google-Smtp-Source: AAOMgpfAooRpr5ButZQcVqxraMs6PtCwqddNugT7OjlypJWTfyxDqs5nWGJjeMtLmckiwjPpOG1egk9izucyUIBzibc=
X-Received: by 2002:aca:ecd0:: with SMTP id k199-v6mr21848871oih.227.1531085800213;
 Sun, 08 Jul 2018 14:36:40 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4a:c984:0:0:0:0:0 with HTTP; Sun, 8 Jul 2018 14:36:39 -0700 (PDT)
From:   "H.J. Lu" <hjl.tools@gmail.com>
Date:   Sun, 8 Jul 2018 14:36:39 -0700
Message-ID: <CAMe9rOqXsQ4Onv8_-kYE_yVYVfN0Hsg81XM0sq9k2cVYE_LvaQ@mail.gmail.com>
Subject: Kernel 4.17.4 lockup
To:     "H. Peter Anvin" <hpa@zytor.com>,
        Matthew Wilcox <mawilcox@microsoft.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3 x86-64 machines, kernel 4.17.4 locked up under heavy load. 2 of them don't
have any kernel messages.  One has

Jul 05 14:33:32 gnu-hsw-1.sc.intel.com kernel: general protection
fault: 0000 [#1] SMP PTI
Jul 05 14:33:32 gnu-hsw-1.sc.intel.com kernel: Modules linked in:
rpcsec_gss_krb5 nfsv4 dns_resolver nfs fscache devlink ebtable_filter
ebtables ip6table_filter ip6_tables intel_rapl x86_pkg_temp_thermal
intel_powerclamp coretemp snd_hda_codec_hdmi snd_hda_codec_realtek
kvm_intel snd_hda_codec_generic snd_hda_intel kvm snd_hda_codec
snd_hda_core snd_hwdep irqbypass crct10dif_pclmul crc32_pclmul snd_seq
mei_wdt ghash_clmulni_intel snd_seq_device intel_cstate ppdev
intel_uncore iTCO_wdt gpio_ich iTCO_vendor_support snd_pcm
intel_rapl_perf snd_timer snd mei_me parport_pc joydev i2c_i801 mei
soundcore shpchp lpc_ich parport nfsd auth_rpcgss nfs_acl lockd grace
sunrpc i915 i2c_algo_bit drm_kms_helper r8169 drm crc32c_intel mii
video
Jul 05 14:33:32 gnu-hsw-1.sc.intel.com kernel: CPU: 7 PID: 7093 Comm:
cc1 Not tainted 4.17.4-200.0.fc28.x86_64 #1
Jul 05 14:33:32 gnu-hsw-1.sc.intel.com kernel: Hardware name: Gigabyte
Technology Co., Ltd. H87M-D3H/H87M-D3H, BIOS F11 08/18/2015
Jul 05 14:33:32 gnu-hsw-1.sc.intel.com kernel: RIP:
0010:free_pages_and_swap_cache+0x29/0xb0
Jul 05 14:33:32 gnu-hsw-1.sc.intel.com kernel: RSP:
0018:ffffb2cd83ffbd58 EFLAGS: 00010202
Jul 05 14:33:32 gnu-hsw-1.sc.intel.com kernel: RAX: 0017fffe00040068
RBX: ffff93d4abb5ec80 RCX: 0000000000000000
Jul 05 14:33:32 gnu-hsw-1.sc.intel.com kernel: RDX: 0017fffe00040068
RSI: 00000000000001fe RDI: ffff93d51e3dd2a0
Jul 05 14:33:32 gnu-hsw-1.sc.intel.com kernel: RBP: 00000000000001fe
R08: fffff0809df82d20 R09: ffff93d51e5d5000
Jul 05 14:33:32 gnu-hsw-1.sc.intel.com kernel: R10: ffff93d51e5d5e20
R11: ffff93d51e5d5d00 R12: ffff93d4abb5e010
Jul 05 14:33:32 gnu-hsw-1.sc.intel.com kernel: R13: fffbf0809e304bc0
R14: ffff93d4abb5f000 R15: ffff93d4cbcee8f0
Jul 05 14:33:32 gnu-hsw-1.sc.intel.com kernel: FS:
0000000000000000(0000) GS:ffff93d51e3c0000(0000)
knlGS:0000000000000000
Jul 05 14:33:32 gnu-hsw-1.sc.intel.com kernel: CS:  0010 DS: 0000 ES:
0000 CR0: 0000000080050033
Jul 05 14:33:32 gnu-hsw-1.sc.intel.com kernel: CR2: 00007ffb255e753c
CR3: 00000005e820a002 CR4: 00000000001606e0
Jul 05 14:33:32 gnu-hsw-1.sc.intel.com kernel: Call Trace:
Jul 05 14:33:32 gnu-hsw-1.sc.intel.com kernel:  tlb_flush_mmu_free+0x31/0x50
Jul 05 14:33:32 gnu-hsw-1.sc.intel.com kernel:  arch_tlb_finish_mmu+0x42/0x70
Jul 05 14:33:32 gnu-hsw-1.sc.intel.com kernel:  tlb_finish_mmu+0x1f/0x30
Jul 05 14:33:32 gnu-hsw-1.sc.intel.com kernel:  exit_mmap+0xca/0x190
Jul 05 14:33:32 gnu-hsw-1.sc.intel.com kernel:  mmput+0x5f/0x130
Jul 05 14:33:32 gnu-hsw-1.sc.intel.com kernel:  do_exit+0x280/0xae0
Jul 05 14:33:32 gnu-hsw-1.sc.intel.com kernel:  ? __do_page_fault+0x263/0x4e0
Jul 05 14:33:32 gnu-hsw-1.sc.intel.com kernel:  do_group_exit+0x3a/0xa0
Jul 05 14:33:32 gnu-hsw-1.sc.intel.com kernel:  __x64_sys_exit_group+0x14/0x20
Jul 05 14:33:32 gnu-hsw-1.sc.intel.com kernel:  do_syscall_64+0x65/0x160
Jul 05 14:33:32 gnu-hsw-1.sc.intel.com kernel:
entry_SYSCALL_64_after_hwframe+0x44/0xa9
Jul 05 14:33:32 gnu-hsw-1.sc.intel.com kernel: RIP: 0033:0x7ffb2542b3c6
Jul 05 14:33:32 gnu-hsw-1.sc.intel.com kernel: RSP:
002b:00007ffd9e7e33b8 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
Jul 05 14:33:32 gnu-hsw-1.sc.intel.com kernel: RAX: ffffffffffffffda
RBX: 00007ffb2551c740 RCX: 00007ffb2542b3c6
Jul 05 14:33:32 gnu-hsw-1.sc.intel.com kernel: RDX: 0000000000000000
RSI: 000000000000003c RDI: 0000000000000000
Jul 05 14:33:32 gnu-hsw-1.sc.intel.com kernel: RBP: 0000000000000000
R08: 00000000000000e7 R09: fffffffffffffe70
Jul 05 14:33:32 gnu-hsw-1.sc.intel.com kernel: R10: 00007ffd9e7e3250
R11: 0000000000000246 R12: 00007ffb2551c740
Jul 05 14:33:32 gnu-hsw-1.sc.intel.com kernel: R13: 0000000000000037
R14: 00007ffb25525708 R15: 0000000000000000
Jul 05 14:33:32 gnu-hsw-1.sc.intel.com kernel: Code: 40 00 0f 1f 44 00
00 41 56 41 55 41 54 49 89 fc 55 89 f5 53 e8 29 99 fb ff 85 ed 7e 6b
8d 45 ff 4c 89 e3 4d 8d 74 c4 08 4c 8b 2b <49> 8b 55 20 48 8d 42 ff 83
e2 01 49 0f 44 c5 48 8b 48 20 48 8d
Jul 05 14:33:32 gnu-hsw-1.sc.intel.com kernel: RIP:
free_pages_and_swap_cache+0x29/0xb0 RSP: ffffb2cd83ffbd58
Jul 05 14:33:32 gnu-hsw-1.sc.intel.com kernel: ---[ end trace
5960277fd8a3c0b5 ]---
Jul 05 14:33:32 gnu-hsw-1.sc.intel.com kernel: Fixing recursive fault
but reboot is needed!

Kernel 4.16.x is OK.  Is this a known issue?

-- 
H.J.
