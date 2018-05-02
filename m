Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751682AbeEBPFm (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 11:05:42 -0400
Received: from pindarots.xs4all.nl ([82.161.210.87]:54428 "EHLO
        pindarots.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751310AbeEBPFi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 11:05:38 -0400
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From: Udo van den Heuvel <udovdh@xs4all.nl>
Subject: 4.15.18 irq xx: nobody cared (try booting with the "irqpoll" option)
Organization: hierzo
Message-ID: <52727478-d8ef-8873-5545-9da465ff3339@xs4all.nl>
Date: Wed, 2 May 2018 16:46:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Ever since booting into 4.15.18 I had two incidents of 'irq xx: nobody
cared (try booting with the "irqpoll" option)'.
Before that 4.9.60 ran for months without issue.
What could be the cause?

Kind regards,
Udo

 96.747946] snd_hda_codec_hdmi hdaudioC1D0: HDMI ATI/AMD: no speaker
allocation for ELD
[   97.356950] irq 16: nobody cared (try booting with the "irqpoll" option)
[   97.356958] CPU: 1 PID: 257 Comm: irq/16-ohci_hcd Not tainted 4.15.18 #4
[   97.356960] Hardware name: To Be Filled By O.E.M. To Be Filled By
O.E.M./To be filled by O.E.M., BIOS 080015  05/04/2010
[   97.356961] Call Trace:
[   97.356966]  <IRQ>
[   97.356974]  dump_stack+0x46/0x5f
[   97.356978]  __report_bad_irq+0x3c/0xe0
[   97.356982]  note_interrupt+0x279/0x2c0
[   97.356985]  handle_irq_event_percpu+0x44/0x60
[   97.356987]  handle_irq_event+0x39/0x70
[   97.356991]  handle_fasteoi_irq+0x7d/0x160
[   97.356994]  handle_irq+0x17/0x30
[   97.356998]  do_IRQ+0x50/0xf0
[   97.357002]  common_interrupt+0x7a/0x7a
[   97.357004]  </IRQ>
[   97.357010] RIP: 0010:ohci_irq+0x39/0x26a [ohci_hcd]
[   97.357012] RSP: 0018:ffff880117bf3e70 EFLAGS: 00000217 ORIG_RAX:
ffffffffffffffda
[   97.357015] RAX: ffffffffa0012ef0 RBX: ffff880117835800 RCX:
ffff880117f76408
[   97.357017] RDX: 0000000000000004 RSI: ffff880117835800 RDI:
ffff880117835800
[   97.357019] RBP: 000000008000005a R08: 0000000000000307 R09:
ffff88011fd1f280
[   97.357020] R10: 0000000000a4798c R11: 0000000000000001 R12:
ffffc9000002a000
[   97.357022] R13: ffff880117c996a4 R14: ffff880117abbd80 R15:
ffffffff810a67f0
[   97.357024]  ? irq_thread_dtor+0x90/0x90
[   97.357028]  ? ohci_start+0x50/0x50 [ohci_hcd]
[   97.357032]  ? irq_finalize_oneshot.part.2+0x110/0x110
[   97.357036]  usb_hcd_irq+0x22/0x30
[   97.357039]  irq_forced_thread_fn+0x33/0x80
[   97.357042]  ? irq_finalize_oneshot.part.2+0x110/0x110
[   97.357044]  irq_thread+0x11c/0x170
[   97.357046]  ? wake_threads_waitq+0x30/0x30
[   97.357050]  kthread+0x109/0x120
[   97.357053]  ? kthread_create_on_node+0x40/0x40
[   97.357056]  ret_from_fork+0x22/0x40
[   97.357058] handlers:
[   97.357061] [<00000000e3d2a3a6>] irq_default_primary_handler threaded
[<000000007e876a47>] usb_hcd_irq
[   97.357066] [<00000000e3d2a3a6>] irq_default_primary_handler threaded
[<000000007e876a47>] usb_hcd_irq
[   97.357070] [<00000000e3d2a3a6>] irq_default_primary_handler threaded
[<00000000aefa1daf>] azx_interrupt [snd_hda_codec]
[   97.357079] Disabling IRQ #16
[   97.371970] snd_hda_codec_hdmi hdaudioC1D0: HDMI ATI/AMD: no speaker
allocation for ELD
[   97.695966] snd_hda_codec_hdmi hdaudioC1D0: HDMI ATI/AMD: no speaker
allocation for ELD
[   98.016032] snd_hda_codec_hdmi hdaudioC1D0: HDMI ATI/AMD: no speaker
allocation for ELD
[   98.336017] snd_hda_codec_hdmi hdaudioC1D0: HDMI ATI/AMD: no speaker
allocation for ELD
[   98.656068] snd_hda_codec_hdmi hdaudioC1D0: HDMI ATI/AMD: no speaker
allocation for ELD
[   98.976026] snd_hda_codec_hdmi hdaudioC1D0: HDMI ATI/AMD: no speaker
allocation for ELD
[   99.296030] snd_hda_codec_hdmi hdaudioC1D0: HDMI ATI/AMD: no speaker
allocation for ELD
[   99.616097] snd_hda_codec_hdmi hdaudioC1D0: HDMI ATI/AMD: no speaker
allocation for ELD
[284100.529039] irq 18: nobody cared (try booting with the "irqpoll" option)
[284100.529044] CPU: 1 PID: 278 Comm: irq/18-ohci_hcd Not tainted 4.15.18 #4
[284100.529045] Hardware name: To Be Filled By O.E.M. To Be Filled By
O.E.M./To be filled by O.E.M., BIOS 080015  05/04/2010
[284100.529047] Call Trace:
[284100.529049]  <IRQ>
[284100.529054]  dump_stack+0x46/0x5f
[284100.529058]  __report_bad_irq+0x3c/0xe0
[284100.529059]  note_interrupt+0x279/0x2c0
[284100.529061]  handle_irq_event_percpu+0x44/0x60
[284100.529063]  handle_irq_event+0x39/0x70
[284100.529064]  handle_fasteoi_irq+0x7d/0x160
[284100.529067]  handle_irq+0x17/0x30
[284100.529069]  do_IRQ+0x50/0xf0
[284100.529071]  common_interrupt+0x7a/0x7a
[284100.529072]  </IRQ>
[284100.529076] RIP: 0010:ohci_irq+0x2b/0x26a [ohci_hcd]
[284100.529078] RSP: 0018:ffff8801166b3e70 EFLAGS: 00000282 ORIG_RAX:
ffffffffffffffd8
[284100.529079] RAX: ffffffffa0012ef0 RBX: ffff880117977800 RCX:
ffff880117f1a8c0
[284100.529080] RDX: 0000000000000004 RSI: ffff880117977800 RDI:
ffff880117977800
[284100.529081] RBP: ffff880117876e00 R08: ffffffff81a0ac40 R09:
0000000000000100
[284100.529082] R10: 0000000000000000 R11: 00000000000b59b4 R12:
ffffc90000648000
[284100.529083] R13: ffff880117876ea4 R14: ffff8801166df200 R15:
ffffffff810a67f0
[284100.529084]  ? irq_thread_dtor+0x90/0x90
[284100.529086]  ? ohci_start+0x50/0x50 [ohci_hcd]
[284100.529089]  ? irq_finalize_oneshot.part.2+0x110/0x110
[284100.529091]  usb_hcd_irq+0x22/0x30
[284100.529093]  irq_forced_thread_fn+0x33/0x80
[284100.529095]  ? irq_finalize_oneshot.part.2+0x110/0x110
[284100.529096]  irq_thread+0x11c/0x170
[284100.529097]  ? wake_threads_waitq+0x30/0x30
[284100.529100]  kthread+0x109/0x120
[284100.529101]  ? kthread_create_on_node+0x40/0x40
[284100.529103]  ret_from_fork+0x22/0x40
[284100.529104] handlers:
[284100.529106] [<00000000e3d2a3a6>] irq_default_primary_handler
threaded [<000000001aa165c3>] radeon_driver_irq_handler_kms [radeon]
[284100.529127] [<00000000e3d2a3a6>] irq_default_primary_handler
threaded [<000000007e876a47>] usb_hcd_irq
[284100.529129] [<00000000e3d2a3a6>] irq_default_primary_handler
threaded [<000000007e876a47>] usb_hcd_irq
[284100.529132] [<00000000e3d2a3a6>] irq_default_primary_handler
threaded [<000000007e876a47>] usb_hcd_irq
[284100.529134] Disabling IRQ #18
