Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751270AbeBTIk7 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 03:40:59 -0500
Received: from 8bytes.org ([81.169.241.247]:52682 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750781AbeBTIk6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 03:40:58 -0500
Date: Tue, 20 Feb 2018 09:40:55 +0100
From: Joerg Roedel <joro@8bytes.org>
To: "David H. Gutteridge" <dhgutteridge@sympatico.ca>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/31 v2] PTI support for x86_32
Message-ID: <20180220084055.GL16484@8bytes.org>
References: <1519098356.2973.7.camel@sympatico.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1519098356.2973.7.camel@sympatico.ca>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

thanks a lot for your testing, much appreciated!

On Mon, Feb 19, 2018 at 10:45:56PM -0500, David H. Gutteridge wrote:
> (1) There is a regression when the QXL display driver is enabled; the
> VM hangs during boot. (QXL has been a source of similar trouble in the
> past.) I don't have an example trace for it at present.
> 
> (2) There is a regression when the VGA display driver is enabled; it
> intermittently (but reproducibly) faults, which makes it impossible
> to boot to the graphical login manager.

Can you please send me the kernel-config used and the qemu command-line
of the VM? I'll try to reproduce this here.

> [   25.439213] kernel BUG at arch/x86/mm/fault.c:268!
> [   25.439218] invalid opcode: 0000 [#1] SMP PTI
> [   25.439218] Modules linked in: bochs_drm(+) ttm snd_hda_core
> drm_kms_helper snd_hwdep drm snd_seq snd_seq_device snd_pcm snd_timer
> snd pcspkr virtio_balloon i2c_piix4 soundcore virtio_console 8139too
> crc32c_intel virtio_pci virtio_ring serio_raw virtio 8139cp ata_generic
> mii pata_acpi floppy qemu_fw_cfg
> [   25.439236] CPU: 1 PID: 545 Comm: systemd-udevd Tainted:
> G        W        4.15.0+ #1
> [   25.439237] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
> BIOS 1.10.2-1 04/01/2014
> [   25.439241] EIP: vmalloc_fault+0x1e7/0x210
> [   25.439242] EFLAGS: 00010083 CPU: 1
> [   25.439243] EAX: 02788000 EBX: d78ecdf8 ECX: 00000080 EDX: 00000000
> [   25.439244] ESI: 000fd000 EDI: fd0000f3 EBP: f3f639a0 ESP: f3f63988
> [   25.439245]  DS: 007b ES: 007b FS: 00d8 GS: 00e0 SS: 0068
> [   25.439246] CR0: 80050033 CR2: f7e00000 CR3: 33e3a000 CR4: 000006f0

This is a kernel-cr3, so that is at least not the issue.


Thanks,

	Joerg
