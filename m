Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752077AbeDIGnt (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 02:43:49 -0400
Received: from mout.gmx.net ([212.227.15.15]:57037 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750895AbeDIGns (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 02:43:48 -0400
Message-ID: <1523256217.13367.4.camel@gmx.de>
Subject: nouveau:  swiotlb buffer is full (sz: 2097152 bytes)/swiotlb:
 coherent allocation failed, size=2097152 spam
From: Mike Galbraith <efault@gmx.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Ben Skeggs <bskeggs@redhat.com>,
        nouveau <nouveau@lists.freedesktop.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Date: Mon, 09 Apr 2018 08:43:37 +0200
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.22.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:0z3LlHqa+P+y4oJqlv12l8x+dvdKWihdMoeB8Y7Y0YFuD1ZJJRN
 nQV9LWlDWy/el6wKatc6sNgFx392AhHb2m4ADTO55mAALfeREJbS24Z7GgdsHh1rn+gbS1p
 oscjRqkstFiwDiwMbTKEVYSSYAXlFOud+W8uM31vgpyvVKLf2D7hB+Dn4bJYrq0dT3K8ird
 tVDDwtQixAsHZyFxlYPUw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Ynt705CXAUA=:Hbehr/UkeXKvoZ084c1LTN
 M/mQoQfdYNlJ0gCUajVw0HfwvNbJ13EvRKERxU1kogOyrUjDss1zyqXYi5DyOESCNQpfBRECy
 aFwS1SRJgjI1vPdMg/qvwzg96l+V6qnqvF1K9NTJlG7yG7pL/+RhJ82F0Nh8ByCyRwWsvVMr1
 s4feVijWNkHbS3KjwNqi9Oby9zkwb2meKObNGCpnq0OcdGYGEtPo8Y0XbkSQ3R65vI8Pl0RX1
 uxKslIIGT/FXkcYuwnyE2mTD1GDdcGwTvgIfnnNa12F5HfgOkRix4nSHR0zNg3N7IrGihUQre
 H2+D9KutKN9TDqPMoVazLjVyVBQs1++FoZGeV8kQrjIjwPRmqTrk9W+mTI9TyeENZa3jfkGJ4
 zY5AMbDL38KcwVF/y/NQkalpFK6zchCBC/Tuwi+LEJSfLha8J33YtVX1pg+ubFruYjNluIdlG
 Hb3V21kGwwlu9j64ZrPscf6WZOjSxr8C54ARK4uXaFueO8G7/4e8YA28TgGr7MbE0W9hCt8ZN
 Y6DNvf0PAKIfne8oCur2UanH2mhGSq99d5nZqT0cCZYbRhajFZ8ybwNL9hNbWoooPDtTxfHM9
 /2mgLFaDZR4zMr16RlMfKzqpbHkXzAwuvDWwelHn8xJ7QZoxDV2n8iuTAJB8/yiiwOVdd6kRM
 /kpoj6QuC7nB9th2u+7JhrlxoR6tgRsOXkr9WTMzaIdExg+bu6niD6B36RUqiNoESmgb91PZf
 yV5rsy9aE72A7wV9B+yYjZV6B1PLE4dasEGp7QA+3MgQ7sZxT3qbXKSwWnb7Z4TQLjmFTiq7i
 5MDyVOyye6xQnILPoSxSbm/kTB13jLspfl4fKkkT0f+SWjsafk=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

Box is i4790 w. GTX 980 running virgin master (.today).

All I have to do to trigger a slew of these warnings is to fire up
firefox, point it at a youtube clip, and let it autoplay while I do
routine kernel merge/build maintenance.  nouveau doesn't seem to care
deeply, but moans again and again and again...

 726 [    2.743823] fb: switching to nouveaufb from EFI VGA
 727 [    2.743850] Console: switching to colour dummy device 80x25
 728 [    2.743973] nouveau 0000:01:00.0: NVIDIA GM204 (124000a1)
...
 758 [    2.826604] nouveau 0000:01:00.0: bios: version 84.04.1f.00.02
 759 [    2.827479] nouveau 0000:01:00.0: fb: 4096 MiB GDDR5
 760 [    2.827506] nouveau 0000:01:00.0: bus: MMIO write of 80000195 FAULT at 10eb14 [ IBUS ]
 761 [    2.891876] [TTM] Zone  kernel: Available graphics memory: 7927764 kiB
 762 [    2.891880] [TTM] Zone   dma32: Available graphics memory: 2097152 kiB
 763 [    2.891881] [TTM] Initializing pool allocator
 764 [    2.891885] [TTM] Initializing DMA pool allocator
 765 [    2.891895] nouveau 0000:01:00.0: DRM: VRAM: 4096 MiB
 766 [    2.891897] nouveau 0000:01:00.0: DRM: GART: 1048576 MiB
 767 [    2.891900] nouveau 0000:01:00.0: DRM: TMDS table version 2.0
 768 [    2.891902] nouveau 0000:01:00.0: DRM: DCB version 4.1
 769 [    2.891904] nouveau 0000:01:00.0: DRM: DCB outp 00: 01000f02 00020030
 770 [    2.891906] nouveau 0000:01:00.0: DRM: DCB outp 01: 02000f00 00000000
 771 [    2.891908] nouveau 0000:01:00.0: DRM: DCB outp 02: 02811f76 04400020
 772 [    2.891910] nouveau 0000:01:00.0: DRM: DCB outp 03: 02011f72 00020020
 773 [    2.891912] nouveau 0000:01:00.0: DRM: DCB outp 04: 04822f86 04400010
 774 [    2.891914] nouveau 0000:01:00.0: DRM: DCB outp 05: 04022f82 00020010
 775 [    2.891916] nouveau 0000:01:00.0: DRM: DCB outp 06: 04833f96 04400020
 776 [    2.891918] nouveau 0000:01:00.0: DRM: DCB outp 07: 04033f92 00020020
 777 [    2.891920] nouveau 0000:01:00.0: DRM: DCB outp 08: 02044f62 00020010
 778 [    2.891922] nouveau 0000:01:00.0: DRM: DCB outp 15: 01df5ff8 00000000
 779 [    2.891924] nouveau 0000:01:00.0: DRM: DCB conn 00: 00001030
 780 [    2.891926] nouveau 0000:01:00.0: DRM: DCB conn 01: 00020146
 781 [    2.891928] nouveau 0000:01:00.0: DRM: DCB conn 02: 01000246
 782 [    2.891929] nouveau 0000:01:00.0: DRM: DCB conn 03: 02000346
 783 [    2.891931] nouveau 0000:01:00.0: DRM: DCB conn 04: 00010461
 784 [    2.891933] nouveau 0000:01:00.0: DRM: DCB conn 05: 00000570
 785 [    2.953898] nouveau 0000:01:00.0: DRM: failed to create encoder 1/8/0: -19
 786 [    2.953902] nouveau 0000:01:00.0: DRM: Virtual-1 has no encoders, removing
 787 [    2.953928] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
 788 [    2.953930] [drm] Driver supports precise vblank timestamp query.
 789 [    3.006557] nouveau 0000:01:00.0: DRM: MM: using COPY for buffer copies
...
 811 [    3.329981] nouveau 0000:01:00.0: DRM: allocated 1920x1080 fb: 0x80000, bo 00000000fed1a05d
 812 [    3.331002] fbcon: nouveaufb (fb0) is primary device
 813 [    3.376014] usb 3-10: new full-speed USB device number 3 using xhci_hcd
 814 [    3.376174] hid-generic 0003:0E8F:0020.0002: input,hidraw1: USB HID v1.10 Mouse [GASIA PS2toUSB Adapter] on usb-0000:00:14.0-1/input1
 815 [    3.526234] usb 3-10: New USB device found, idVendor=046d, idProduct=c52b, bcdDevice=12.01
 816 [    3.526235] usb 3-10: New USB device strings: Mfr=1, Product=2, SerialNumber=0
 817 [    3.526237] usb 3-10: Product: USB Receiver
 818 [    3.526237] usb 3-10: Manufacturer: Logitech
 819 [    3.622223] Console: switching to colour frame buffer device 240x67
 820 [    3.872710] nouveau 0000:01:00.0: fb0: nouveaufb frame buffer device
 821 [    3.892080] [drm] Initialized nouveau 1.3.1 20120801 for 0000:01:00.0 on minor 0
...
[ 6253.341530] nouveau 0000:01:00.0: swiotlb buffer is full (sz: 2097152 bytes)
[ 6253.341535] nouveau 0000:01:00.0: swiotlb: coherent allocation failed, size=2097152
[ 6253.341539] CPU: 2 PID: 3740 Comm: Xorg Kdump: loaded Tainted: G            E    4.16.0.gf8cf2f1-default #687
[ 6253.341541] Hardware name: MEDION MS-7848/MS-7848, BIOS M7848W08.20C 09/23/2013
[ 6253.341543] Call Trace:
[ 6253.341553]  dump_stack+0x78/0xb3
[ 6253.341559]  swiotlb_alloc+0x134/0x170
[ 6253.341567]  ttm_dma_pool_alloc_new_pages+0x161/0x3c0 [ttm]
[ 6253.341574]  ttm_dma_pool_get_pages+0xe0/0x1c0 [ttm]
[ 6253.341580]  ttm_dma_populate+0x250/0x310 [ttm]
[ 6253.341586]  ttm_tt_populate+0x28/0x70 [ttm]
[ 6253.341591]  ttm_tt_bind+0x26/0x60 [ttm]
[ 6253.341596]  ttm_bo_handle_move_mem+0x51a/0x580 [ttm]
[ 6253.341612]  ? drm_mm_insert_node_in_range+0x42b/0x480 [drm]
[ 6253.341617]  ttm_bo_validate+0xfa/0x110 [ttm]
[ 6253.341622]  ? _raw_write_unlock+0x12/0x30
[ 6253.341634]  ? drm_vma_offset_add+0x5c/0x70 [drm]
[ 6253.341638]  ttm_bo_init_reserved+0x296/0x450 [ttm]
[ 6253.341643]  ttm_bo_init+0x73/0xd0 [ttm]
[ 6253.341675]  ? nv10_bo_put_tile_region+0x50/0x50 [nouveau]
[ 6253.341704]  nouveau_bo_new+0x3eb/0x5c0 [nouveau]
[ 6253.341731]  ? nv10_bo_put_tile_region+0x50/0x50 [nouveau]
[ 6253.341756]  nouveau_gem_new+0x66/0x110 [nouveau]
[ 6253.341779]  ? nouveau_gem_new+0x110/0x110 [nouveau]
[ 6253.341801]  nouveau_gem_ioctl_new+0x48/0xc0 [nouveau]
[ 6253.341812]  drm_ioctl_kernel+0x66/0xb0 [drm]
[ 6253.341822]  drm_ioctl+0x2b7/0x370 [drm]
[ 6253.341844]  ? nouveau_gem_new+0x110/0x110 [nouveau]
[ 6253.341849]  ? preempt_count_sub+0x6a/0xe0
[ 6253.341872]  nouveau_drm_ioctl+0x50/0xb0 [nouveau]
[ 6253.341876]  do_vfs_ioctl+0x93/0x6a0
[ 6253.341880]  ? __sys_recvmsg+0x45/0x80
[ 6253.341882]  ksys_ioctl+0x60/0x90
[ 6253.341886]  ? trace_hardirqs_off_thunk+0x1a/0x1c
[ 6253.341888]  SyS_ioctl+0xa/0x10
[ 6253.341891]  do_syscall_64+0x76/0x130
[ 6253.341895]  entry_SYSCALL_64_after_hwframe+0x42/0xb7
[ 6253.341898] RIP: 0033:0x7f7dce046327
[ 6253.341900] RSP: 002b:00007ffd59826aa8 EFLAGS: 00003246 ORIG_RAX: 0000000000000010
[ 6253.341903] RAX: ffffffffffffffda RBX: 0000000001b2f220 RCX: 00007f7dce046327
[ 6253.341904] RDX: 00007ffd59826b00 RSI: 00000000c0306480 RDI: 000000000000000b
[ 6253.341906] RBP: 00007ffd59826b00 R08: 00000000013e2f80 R09: 00000000013e30d0
[ 6253.341908] R10: 00007f7dbe55f000 R11: 0000000000003246 R12: 00000000c0306480
[ 6253.341909] R13: 000000000000000b R14: 00007ffd59826ba8 R15: 0000000000400000
[ 6254.873179] nouveau 0000:01:00.0: swiotlb buffer is full (sz: 2097152 bytes)
