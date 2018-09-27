Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EEE1C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 20:57:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D342D2159D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 20:56:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PduQGoqz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D342D2159D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728300AbeI1DRH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 23:17:07 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:41990 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727295AbeI1DRH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 23:17:07 -0400
Received: by mail-ot1-f68.google.com with SMTP id h26-v6so3933738otl.9;
        Thu, 27 Sep 2018 13:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=IDiIPYXam4ZhmZJi72Oi72cSmpbNBTJOetcMUPcoyBU=;
        b=PduQGoqz9XnVb5rmbyBOkSX+tOB3tfnkKyc+IN05yuNEy2tuEIJNgBOzlsosdbCUwx
         K8nXuOWg2IqBNUIvGlXTqHRUU4IPrkCpK9psiAQuWNqRbfYMqHUfaL+hh50O923y2Rnl
         xrv9jkXJCBvCxJmQ42YZVb3L6OhYMaSw6jSwjs3BsTIgrWuxZaqmODSr8koMxdhe2H7u
         8zYvV7uj8fGrpoAhxbl4cbaKDekeOcJtaySUxzjh4uKQ4RsQoO5zs03fHtghfDgXD3Zr
         SyI5V/qmslW9MvMlE+bTWg0peuZvdPohjgB+QgC3qh18ZffoQcIsDcRDRGMBL+2Ncg6K
         feEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=IDiIPYXam4ZhmZJi72Oi72cSmpbNBTJOetcMUPcoyBU=;
        b=BL1cIfLls+dTva8bh58YndKkNxaNOAHM8g2Hy0Sm87HLMaxv6cBCbfAxFS7Vm/0mfc
         Hlrmz4aCzcW9TDoWPuKpXDBeE7N3sfeLnkksc8IZoRufoKIlEqQGhoS+5I+l9WKLt6b4
         34BOK+32+FJHreCXHbmfodvI2b4yHmBMQoYVWbO6/8iliUkVdp8aLJLzjCbt385wzhVZ
         9vU3wCSBDBCR+sRbKezz+iCHpxrhGerz+m8c1QPMPrp6Bhx0IEndea9MHvHakECGVPIA
         e2GQSooaX2r3nqpwj3p0P4EKmZPJe5z8Ds0NMTcQ3GYpW1tnSH0U3hWv142EYHPWEELt
         uJpA==
X-Gm-Message-State: ABuFfoh143E+miB4fYiYtV3ZwAE5fIp8LxGDlKaT+eIboDqzDJaXmS70
        lXvFZ9L+ua97QWqPun0FcJVfGh1jzIwpHxPUUd0=
X-Google-Smtp-Source: ACcGV63kiqc6cN5iKXJMqcooCss/W7kPrdAopXbKKDWLJwnchYYMzGbhhkeQWh03Tq1EFW72FeEauQKsBEgV+xcUAFE=
X-Received: by 2002:a9d:3886:: with SMTP id p6-v6mr8258484otc.227.1538081816818;
 Thu, 27 Sep 2018 13:56:56 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac9:59c3:0:0:0:0:0 with HTTP; Thu, 27 Sep 2018 13:56:16
 -0700 (PDT)
In-Reply-To: <20180927090249.801943776@linuxfoundation.org>
References: <20180927090249.801943776@linuxfoundation.org>
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date:   Thu, 27 Sep 2018 21:56:16 +0100
Message-ID: <CADVatmNwDEvdtpzvwo2ppCaLXgiyweLJStRBu_+ieyCz91eR1Q@mail.gmail.com>
Subject: Re: [PATCH 4.14 00/64] 4.14.73-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Shuah Khan <shuah@kernel.org>, patches@kernelci.org,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        lkft-triage@lists.linaro.org, Stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On Thu, Sep 27, 2018 at 10:03 AM, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> This is the start of the stable review cycle for the 4.14.73 release.
> There are 64 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat Sep 29 09:02:21 UTC 2018.
> Anything received after that time might be too late.

My kvm guest had this:

[    8.570020] kasan: CONFIG_KASAN_INLINE enabled
[    8.570272] kasan: GPF could be caused by NULL-ptr deref or user
memory access
[    8.570472] general protection fault: 0000 [#1] SMP KASAN PTI
[    8.570625] Modules linked in: bochs_drm(+) ppdev drm_kms_helper
ttm joydev evdev drm sg serio_raw pcspkr parport_pc parport button
ip_tables x_tables autofs4 ext4 crc32c_generic crc16 mbcache jbd2
fscrypto sr_mod cdrom sd_mod ata_generic ata_piix xhci_pci e1000
psmouse xhci_hcd libata floppy usbcore i2c_piix4 scsi_mod
[    8.571218] CPU: 0 PID: 225 Comm: systemd-udevd Not tainted 4.14.73-rc1+ #5
[    8.571394] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS rel-1.10.2-0-g5f4c7b1-prebuilt.qemu-project.org 04/01/2014
[    8.571706] task: ffff8800366db100 task.stack: ffff88002b1b8000
[    8.571875] RIP: 0010:drm_debugfs_init+0x183/0x370 [drm]
[    8.572023] RSP: 0018:ffff88002b1bf5e8 EFLAGS: 00010202
[    8.572207] RAX: dffffc0000000000 RBX: ffff880031d37000 RCX: 0000000000000000
[    8.572384] RDX: 0000000000000004 RSI: ffff880031d37020 RDI: 0000000000000020
[    8.572560] RBP: 1ffff10005637ebe R08: ffff880036380638 R09: 0000000000000000
[    8.572736] R10: ffff880036380640 R11: ffff880028586290 R12: 0000000000000000
[    8.572914] R13: ffff880028ec1540 R14: 0000000000000000 R15: 0000000000000000
[    8.573091] FS:  00007ff59b7088c0(0000) GS:ffff880034400000(0000)
knlGS:0000000000000000
[    8.573289] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    8.573441] CR2: 00007ffdf9c90000 CR3: 000000002f478000 CR4: 00000000000006f0
[    8.573685] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[    8.573927] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[    8.574227] Call Trace:
[    8.574389]  ? drm_dev_set_unique+0x44/0x90 [drm]
[    8.574591]  ? connector_write+0x2e0/0x2e0 [drm]
[    8.574795]  ? add_hole+0x33e/0x600 [drm]
[    8.574980]  ? memcpy+0x34/0x50
[    8.575152]  drm_minor_register+0xa7/0x1d0 [drm]
[    8.575356]  drm_dev_register+0x117/0x5d0 [drm]
[    8.575562]  drm_get_pci_dev+0x17b/0x4b0 [drm]
[    8.575752]  ? bochs_load+0x110/0x110 [bochs_drm]
[    8.575946]  local_pci_probe+0xde/0x1a0
[    8.576123]  pci_device_probe+0x3f0/0x550
[    8.576306]  ? pci_device_remove+0x1d0/0x1d0
[    8.576492]  ? driver_sysfs_add+0x158/0x280
[    8.576675]  driver_probe_device+0x5e2/0xc80
[    8.576862]  ? driver_probe_device+0xc80/0xc80
[    8.577053]  __driver_attach+0x194/0x1e0
[    8.577231]  bus_for_each_dev+0x111/0x1a0
[    8.577411]  ? subsys_dev_iter_exit+0x10/0x10
[    8.577600]  ? __switch_to_asm+0x24/0x60
[    8.577780]  ? __switch_to_asm+0x24/0x60
[    8.577957]  ? klist_add_tail+0x5c/0x120
[    8.578135]  bus_add_driver+0x3b8/0x6f0
[    8.578314]  driver_register+0x187/0x3a0
[    8.578495]  ? 0xffffffffc0620000
[    8.578664]  do_one_initcall+0x7f/0x1e1
[    8.578845]  ? initcall_blacklisted+0x150/0x150
[    8.579037]  ? kmem_cache_alloc_trace+0xea/0x5d0
[    8.579228]  ? kasan_unpoison_shadow+0x30/0x40
[    8.579414]  ? __asan_register_globals+0x77/0x90
[    8.579611]  do_init_module+0x1ba/0x552
[    8.579790]  ? load_module+0x6798/0x9b30
[    8.579967]  load_module+0x67a5/0x9b30
[    8.580143]  ? module_frob_arch_sections+0x20/0x20
[    8.580340]  ? vfs_read+0x24e/0x2e0
[    8.580514]  ? kernel_read+0x90/0x130
[    8.580687]  ? set_binfmt+0x120/0x120
[    8.580862]  ? SYSC_finit_module+0x14d/0x180
[    8.581049]  SYSC_finit_module+0x14d/0x180
[    8.581230]  ? SYSC_init_module+0x1c0/0x1c0
[    8.581412]  ? vfs_statx_fd+0x49/0x80
[    8.581588]  ? syscall_trace_enter+0x30f/0xb00
[    8.581848]  ? exit_to_usermode_loop+0x7a/0x100
[    8.582105]  ? SyS_init_module+0x10/0x10
[    8.582283]  do_syscall_64+0x191/0x450
[    8.582460]  ? async_page_fault+0x2f/0x50
[    8.582643]  entry_SYSCALL_64_after_hwframe+0x3d/0xa2
[    8.582840] RIP: 0033:0x7ff59a586229
[    8.583011] RSP: 002b:00007ffcad244b18 EFLAGS: 00000246 ORIG_RAX:
0000000000000139
[    8.583318] RAX: ffffffffffffffda RBX: 0000561bda7e7e90 RCX: 00007ff59a586229
[    8.583558] RDX: 0000000000000000 RSI: 00007ff59ae9f265 RDI: 0000000000000011
[    8.583780] RBP: 00007ff59ae9f265 R08: 0000000000000000 R09: 00007ffcad245090
[    8.584001] R10: 0000000000000011 R11: 0000000000000246 R12: 0000000000000000
[    8.584272] R13: 0000561bda7e7cb0 R14: 0000000000020000 R15: 0000561bd9fc4cbc
[    8.584496] Code: fa 48 c1 ea 03 80 3c 02 00 0f 85 9f 01 00 00 4d
8b b5 70 03 00 00 48 b8 00 00 00 00 00 fc ff df 49 8d 7e 20 48 89 fa
48 c1 ea 03 <80> 3c 02 00 0f 85 6f 01 00 00 49 83 7e 20 00 74 10 48 89
df e8
[    8.585076] RIP: drm_debugfs_init+0x183/0x370 [drm] RSP: ffff88002b1bf5e8
[    8.585404] ---[ end trace 62728db3ac408aba ]---

And I had to revert 7e58fe2a97bc ("drm/atomic: Use
drm_drv_uses_atomic_modeset() for debugfs creation") to make it work.
I am looking more into why it failed.

-- 
Regards
Sudip
