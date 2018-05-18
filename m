Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753793AbeERImK (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 04:42:10 -0400
Received: from mx2.suse.de ([195.135.220.15]:41660 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753223AbeERImG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 04:42:06 -0400
Date: Fri, 18 May 2018 10:42:03 +0200
From: Petr Mladek <pmladek@suse.com>
To: Joe Perches <joe@perches.com>
Cc: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/18] printk: Convert pr_fmt from blank define to
 KBUILD_MODNAME
Message-ID: <20180518084203.n2etqcigvwxzcanv@pathway.suse.cz>
References: <cover.1525964381.git.joe@perches.com>
 <deb55d864f0bf266e019a74456612db36f8921a9.1525964383.git.joe@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <deb55d864f0bf266e019a74456612db36f8921a9.1525964383.git.joe@perches.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2018-05-10 08:45:29, Joe Perches wrote:
> There are more than 1000 uses of #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> Make that the default define so these uses can be removed later via script.
> 
> Signed-off-by: Joe Perches <joe@perches.com>

It removes a lot of duplicates. I just hope that we will not need to
add the same amount of defines to remove/change the prefix where the
new default would look ugly.

I am not completely convinced that it is worth it. But it makes some
sense. Feel free to use:

Acked-by: Petr Mladek <pmladek@suse.com>


BTW: I tried the entire patchset and there are still many locations
even in the boot log that might need an update:

[    0.000000] main: Linux version 4.17.0-rc4-default+ (pmladek@pathway) (gcc version 7.3.1 20180226 [gcc-7-branch revision 257983] (SUSE Linux)) #4505 SMP Fri May 11 13:24:37 CEST 2018
[    0.000000] e820: BIOS-e820: [mem 0x0000000000000000-0x000000000009fbff] usable
[    0.000000] e820: BIOS-e820: [mem 0x000000000009fc00-0x000000000009ffff] reserved
[    0.000000] e820: BIOS-e820: [mem 0x00000000000f0000-0x00000000000fffff] reserved
[    0.000000] e820: BIOS-e820: [mem 0x0000000000100000-0x00000000bffdefff] usable
[    0.000000] e820: BIOS-e820: [mem 0x00000000bffdf000-0x00000000bfffffff] reserved
[    0.000000] e820: BIOS-e820: [mem 0x00000000feffc000-0x00000000feffffff] reserved
[    0.000000] e820: BIOS-e820: [mem 0x00000000fffc0000-0x00000000ffffffff] reserved
[    0.000000] e820: BIOS-e820: [mem 0x0000000100000000-0x000000013fffffff] usable
[    0.000000] dmi_scan: DMI: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.0.0-prebuilt.qemu-project.org 04/01/2014
[    0.000000] hypervisor: Hypervisor detected: KVM
[    0.000000] generic: MTRR default type: write-back
[    0.000000] generic: MTRR fixed ranges enabled:
[    0.000000] generic:   00000-9FFFF write-back
[    0.000000] generic:   A0000-BFFFF uncachable
[    0.000000] generic:   C0000-FFFFF write-protect
[    0.000000] generic: MTRR variable ranges enabled:
[    0.000000] generic:   0 base 000C0000000 mask 3FFC0000000 uncachable
[    0.000000] generic:   1 disabled
[    0.000000] generic:   2 disabled
[    0.000000] generic:   3 disabled
[    0.000000] generic:   4 disabled
[    0.000000] generic:   5 disabled
[    0.000000] generic:   6 disabled
[    0.000000] generic:   7 disabled
[    0.000000] libftrace: ftrace: allocating 40753 entries in 160 pages
[    0.004008] apic: APIC: Switch to symmetric I/O mode setup
[    0.056663] dca: dca service started, version 1.12.1
[    0.057807] hugetlb: HugeTLB registered 2.00 MiB page size, pre-allocated 0 pages
[    0.060035] cryptd: cryptd: max_cpu_qlen set to 1000
[    0.066252] acpi: ACPI: (supports S0 S3 S4 S5)
[    0.071004] acpi: ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
[    0.136057] usbcore: usbcore: registered new interface driver usbfs
[    0.136671] usbcore: usbcore: registered new interface driver hub
[    0.137389] usbcore: usbcore: registered new device driver usb
[    0.795954] key: Key type blacklist registered
[    0.796479] workingset: workingset: timestamp_bits=36 max_order=20 bucket_order=0
[    0.798899] key: Key type id_resolver registered
[    0.799347] key: Key type id_legacy registered
[    0.799790] nfs4filelayout_init: NFSv4 File Layout Driver Registering...
[    1.044458] ipmi_si: ipmi_si: Unable to find any System Interface(s)
[    1.046489] ioatdma: ioatdma: Intel(R) QuickData Technology Driver 4.00
[    1.076080] ppdev: ppdev: user-space parallel port driver
[    1.484645] ehci_pci: ehci-pci: EHCI PCI platform driver
[    1.544643] parport: parport0: cannot grant exclusive access for device pps_parport
[    1.545968] pps_parport: couldn't register with parport0
[    1.556821] usbcore: usbcore: registered new interface driver usbhid
[    1.558001] usbhid: usbhid: USB HID core driver
[    1.559213] parport: parport0: cannot grant exclusive access for device MTS64
[    1.562908] parport: parport0: cannot grant exclusive access for device portman

Best regards,
Petr
