Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC6F8C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 21:27:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 623922086D
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 21:27:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="br/Piam+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732817AbfAOV1X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 16:27:23 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:33621 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727307AbfAOV1X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 16:27:23 -0500
Received: by mail-lj1-f194.google.com with SMTP id v1-v6so3679483ljd.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jan 2019 13:27:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=LOzW4BQHACj21GeJaacrUI1fVDGcC2Y9DlPn2XzyNIE=;
        b=br/Piam+4oYviFknkDLiDq6Zy/A+2JLjEPruu922IheZ2dwLbRoMEU6hMIC0B0wwbO
         4h9D4EvqZUdgzVogbajhn4HFobXUXq9319E3Y2agWIIn8eEUiP0dyCSFMMdz5T3JLt6N
         RBX7hT8VFYsK7LQUuqIthlI+HUq0v1uoS19BV0QX8C6GVXWmfOPxffhX4j7SENkJZdrv
         0VXb7FkU7UdHvq9Kk5wlKKQCvoburYv3ONWRQYbukfNxVbEhI0DJEam91Qrdk1cOfERY
         sMYXzKWN9NqaodrjlFBukRF9TYU5hi6vt/cv2OHR2cuchaqLIFvTDhD/YCll54gwupZ1
         MZCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=LOzW4BQHACj21GeJaacrUI1fVDGcC2Y9DlPn2XzyNIE=;
        b=a7WyhSjmUK6NqfDR70nQdWUT+a9RyP4O0yT8hEb82BbcLLOxNs2zE+tClRYN4TR4wW
         CpRL+Bo0c3GqdbXQGxnGHLa1eMhkofI+3XPXsYsg7Jzme4eOQn3EfiR32y4qx08DryAB
         8K+ho+q7r1NQOC+XVdPgTJUVEv2sDnEbfHNAv/YmPJTlfhk++Y/bbaPgqtRVwRyJOicC
         R0PAhfHnsFsfbjQrbi2eJ1EcBzVIdzOCaO9rJ+qoWmpcSyNJ8diIDM5rc64S6BxByr2u
         QMHUUGY80P0iIRC+vFhe+aKCzR3WDQpiEj8eVC6VJhm6Y5PB75vwIKPqKl8OtEb8aECQ
         2zoQ==
X-Gm-Message-State: AJcUukeZngH7alv7liwqCGbsYUdLKRMqHZXLl9rO7mjkv0H8uVU5Rq8t
        JEVIWbp8P6lOY++CfPvorO7LSssUMvUivId8YJ5t4o/Z
X-Google-Smtp-Source: ALg8bN5ec6loxdUg6M/9EPpgk0y4TW0dpQ6wWNIxw1LS5Sgamaw/GsqLjkGJiUnhQwt+q0CmxdLsZa4bDSSpdbj0qOE=
X-Received: by 2002:a2e:197:: with SMTP id f23-v6mr4242002lji.144.1547587639456;
 Tue, 15 Jan 2019 13:27:19 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:ab3:7ad7:0:0:0:0:0 with HTTP; Tue, 15 Jan 2019 13:27:18
 -0800 (PST)
From:   Nathaniel Russell <naterussell83@gmail.com>
Date:   Tue, 15 Jan 2019 15:27:18 -0600
Message-ID: <CAONH+JkS-N+M2b-McnrJmVyVNeVL7GjzGKjCMyr5SV8785qtbA@mail.gmail.com>
Subject: Kernel Opppps Kernel 4.20.2
To:     linux-kernel <linux-kernel@vger.kernel.org>
Cc:     Nathaniel Russell <naterussell83@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[  300.403269] ------------[ cut here ]------------
[  300.403271] CPA: called for zero pte. vaddr = 0 cpa->vaddr = 0
[  300.403281] WARNING: CPU: 0 PID: 33 at arch/x86/mm/pageattr.c:1466
__cpa_process_fault+0x365/0x390
[  300.403282] Modules linked in: cmac cifs fscache snd_seq_dummy
snd_seq_oss snd_seq_midi_event snd_seq snd_seq_device snd_pcm_oss
snd_mixer_oss ipv6 cfg80211 8021q garp mrp stp llc joydev hid_generic
usbhid hid gpio_ich wmi_bmof hp_wmi sparse_keymap rfkill ppdev evdev
nouveau mxm_wmi video ttm drm_kms_helper drm tg3 agpgart i2c_algo_bit
fb_sys_fops syscopyarea sysfillrect libphy lpc_ich
snd_hda_codec_realtek snd_hda_codec_hdmi snd_hda_codec_generic
sysimgblt psmouse serio_raw i2c_core coretemp firewire_ohci
firewire_core hwmon wmi uhci_hcd snd_hda_intel snd_hda_codec ehci_pci
snd_hda_core ehci_hcd parport_pc parport button snd_hwdep snd_pcm
snd_timer snd soundcore pcc_cpufreq acpi_cpufreq loop
[  300.403313] CPU: 0 PID: 33 Comm: kswapd0 Tainted: G          I
 4.20.2 #1
[  300.403314] Hardware name: Hewlett-Packard HP xw4600
Workstation/0AA0h, BIOS 786F3 v01.34 07/09/2012
[  300.403316] EIP: __cpa_process_fault+0x365/0x390
[  300.403318] Code: c4 0c 85 c0 0f 88 5a fe ff ff 01 c6 e9 4b fe ff
ff 8b 7d d8 e9 64 ff ff ff 8b 03 ff 30 ff 75 f0 68 d8 9d 38 cd e8 8e
0c 01 00 <0f> 0b be f2 ff ff ff 83 c4 0c e9 e4 fc ff ff 8b 45 f0 8d b8
00 00
[  300.403319] EAX: 00000032 EBX: f4acfd78 ECX: cd509424 EDX: 00000007
[  300.403320] ESI: f4acfd78 EDI: 00000000 EBP: f4acfcc4 ESP: f4acfc88
[  300.403322] DS: 007b ES: 007b FS: 0000 GS: 00e0 SS: 0068 EFLAGS: 00010292
[  300.403323] CR0: 80050033 CR2: b1a96000 CR3: 1477b000 CR4: 000006d0
[  300.403324] Call Trace:
[  300.403328]  ? __change_page_attr_set_clr+0x575/0x880
[  300.403331]  ? invalidate_mapping_pages+0x7d/0x2f0
[  300.403333]  ? enqueue_entity+0xa2/0x2f0
[  300.403336]  ? change_page_attr_set_clr+0xf1/0x2f0
[  300.403338]  ? set_memory_wb+0x35/0x80
[  300.403344]  ? ttm_pages_put+0x4c/0x90 [ttm]
[  300.403348]  ? ttm_page_pool_free+0x104/0x170 [ttm]
[  300.403351]  ? ttm_pool_shrink_scan+0xc0/0x100 [ttm]
[  300.403354]  ? do_shrink_slab+0x155/0x2f0
[  300.403356]  ? shrink_slab+0x1cf/0x240
[  300.403358]  ? __switch_to_asm+0x26/0x50
[  300.403360]  ? shrink_node+0xe1/0x430
[  300.403362]  ? kswapd+0x375/0x630
[  300.403365]  ? kthread+0xef/0x110
[  300.403366]  ? mem_cgroup_shrink_node+0x120/0x120
[  300.403368]  ? kthread_stop+0xd0/0xd0
[  300.403369]  ? ret_from_fork+0x2e/0x40
[  300.403371] ---[ end trace 3ff74d1f7f433be3 ]---
[  300.403372] [TTM] Failed to set 1024 pages to wb!
[  300.403740] ------------[ cut here ]------------
[  300.403742] CPA: called for zero pte. vaddr = 0 cpa->vaddr = 0
[  300.403745] WARNING: CPU: 0 PID: 33 at arch/x86/mm/pageattr.c:1466
__cpa_process_fault+0x365/0x390
[  300.403746] Modules linked in: cmac cifs fscache snd_seq_dummy
snd_seq_oss snd_seq_midi_event snd_seq snd_seq_device snd_pcm_oss
snd_mixer_oss ipv6 cfg80211 8021q garp mrp stp llc joydev hid_generic
usbhid hid gpio_ich wmi_bmof hp_wmi sparse_keymap rfkill ppdev evdev
nouveau mxm_wmi video ttm drm_kms_helper drm tg3 agpgart i2c_algo_bit
fb_sys_fops syscopyarea sysfillrect libphy lpc_ich
snd_hda_codec_realtek snd_hda_codec_hdmi snd_hda_codec_generic
sysimgblt psmouse serio_raw i2c_core coretemp firewire_ohci
firewire_core hwmon wmi uhci_hcd snd_hda_intel snd_hda_codec ehci_pci
snd_hda_core ehci_hcd parport_pc parport button snd_hwdep snd_pcm
snd_timer snd soundcore pcc_cpufreq acpi_cpufreq loop
[  300.403766] CPU: 0 PID: 33 Comm: kswapd0 Tainted: G        W I
 4.20.2 #1
[  300.403767] Hardware name: Hewlett-Packard HP xw4600
Workstation/0AA0h, BIOS 786F3 v01.34 07/09/2012
[  300.403769] EIP: __cpa_process_fault+0x365/0x390
[  300.403770] Code: c4 0c 85 c0 0f 88 5a fe ff ff 01 c6 e9 4b fe ff
ff 8b 7d d8 e9 64 ff ff ff 8b 03 ff 30 ff 75 f0 68 d8 9d 38 cd e8 8e
0c 01 00 <0f> 0b be f2 ff ff ff 83 c4 0c e9 e4 fc ff ff 8b 45 f0 8d b8
00 00
[  300.403771] EAX: 00000032 EBX: f4acfd78 ECX: cd509424 EDX: 00000007
[  300.403772] ESI: f4acfd78 EDI: 00000000 EBP: f4acfcc4 ESP: f4acfc88
[  300.403773] DS: 007b ES: 007b FS: 0000 GS: 00e0 SS: 0068 EFLAGS: 00010292
[  300.403775] CR0: 80050033 CR2: b1a96000 CR3: 1477b000 CR4: 000006d0
[  300.403775] Call Trace:
[  300.403778]  ? __change_page_attr_set_clr+0x575/0x880
[  300.403780]  ? invalidate_mapping_pages+0x7d/0x2f0
[  300.403783]  ? change_page_attr_set_clr+0xf1/0x2f0
[  300.403785]  ? set_memory_wb+0x35/0x80
[  300.403789]  ? ttm_pages_put+0x4c/0x90 [ttm]
[  300.403793]  ? ttm_page_pool_free+0x104/0x170 [ttm]
[  300.403797]  ? ttm_pool_shrink_scan+0xc0/0x100 [ttm]
[  300.403799]  ? do_shrink_slab+0x155/0x2f0
[  300.403801]  ? shrink_slab+0x1cf/0x240
[  300.403802]  ? __switch_to_asm+0x26/0x50
[  300.403804]  ? shrink_node+0xe1/0x430
[  300.403806]  ? kswapd+0x375/0x630
[  300.403809]  ? kthread+0xef/0x110
[  300.403810]  ? mem_cgroup_shrink_node+0x120/0x120
[  300.403812]  ? kthread_stop+0xd0/0xd0
[  300.403813]  ? ret_from_fork+0x2e/0x40
[  300.403815] ---[ end trace 3ff74d1f7f433be4 ]---
[  300.403815] [TTM] Failed to set 1024 pages to wb!
[  325.075833] fuse init (API version 7.28)
[  330.936828] ------------[ cut here ]------------
[  330.936830] CPA: called for zero pte. vaddr = 0 cpa->vaddr = 0
[  330.936840] WARNING: CPU: 0 PID: 33 at arch/x86/mm/pageattr.c:1466
__cpa_process_fault+0x365/0x390
[  330.936841] Modules linked in: fuse cmac cifs fscache snd_seq_dummy
snd_seq_oss snd_seq_midi_event snd_seq snd_seq_device snd_pcm_oss
snd_mixer_oss ipv6 cfg80211 8021q garp mrp stp llc joydev hid_generic
usbhid hid gpio_ich wmi_bmof hp_wmi sparse_keymap rfkill ppdev evdev
nouveau mxm_wmi video ttm drm_kms_helper drm tg3 agpgart i2c_algo_bit
fb_sys_fops syscopyarea sysfillrect libphy lpc_ich
snd_hda_codec_realtek snd_hda_codec_hdmi snd_hda_codec_generic
sysimgblt psmouse serio_raw i2c_core coretemp firewire_ohci
firewire_core hwmon wmi uhci_hcd snd_hda_intel snd_hda_codec ehci_pci
snd_hda_core ehci_hcd parport_pc parport button snd_hwdep snd_pcm
snd_timer snd soundcore pcc_cpufreq acpi_cpufreq loop
[  330.936872] CPU: 0 PID: 33 Comm: kswapd0 Tainted: G        W I
 4.20.2 #1
[  330.936873] Hardware name: Hewlett-Packard HP xw4600
Workstation/0AA0h, BIOS 786F3 v01.34 07/09/2012
[  330.936875] EIP: __cpa_process_fault+0x365/0x390
[  330.936877] Code: c4 0c 85 c0 0f 88 5a fe ff ff 01 c6 e9 4b fe ff
ff 8b 7d d8 e9 64 ff ff ff 8b 03 ff 30 ff 75 f0 68 d8 9d 38 cd e8 8e
0c 01 00 <0f> 0b be f2 ff ff ff 83 c4 0c e9 e4 fc ff ff 8b 45 f0 8d b8
00 00
[  330.936878] EAX: 00000032 EBX: f4acfd78 ECX: cd509424 EDX: 00000007
[  330.936879] ESI: f4acfd78 EDI: 00000000 EBP: f4acfcc4 ESP: f4acfc88
[  330.936881] DS: 007b ES: 007b FS: 0000 GS: 00e0 SS: 0068 EFLAGS: 00010292
[  330.936882] CR0: 80050033 CR2: b115f7a0 CR3: 13513000 CR4: 000006d0
[  330.936883] Call Trace:
[  330.936888]  ? __change_page_attr_set_clr+0x575/0x880
[  330.936891]  ? __es_remove_extent+0x2c0/0x2f0
[  330.936892]  ? __es_remove_extent+0x2c0/0x2f0
[  330.936895]  ? change_page_attr_set_clr+0xf1/0x2f0
[  330.936896]  ? set_memory_wb+0x35/0x80
[  330.936896]  ? ttm_pages_put+0x4c/0x90 [ttm]
[  330.936896]  ? ttm_page_pool_free+0x104/0x170 [ttm]
[  330.936896]  ? ttm_pool_shrink_scan+0xc0/0x100 [ttm]
[  330.936896]  ? do_shrink_slab+0x155/0x2f0
[  330.936896]  ? shrink_slab+0x1cf/0x240
[  330.936896]  ? __switch_to_asm+0x26/0x50
[  330.936896]  ? shrink_node+0xe1/0x430
[  330.936896]  ? kswapd+0x375/0x630
[  330.936896]  ? kthread+0xef/0x110
[  330.936896]  ? mem_cgroup_shrink_node+0x120/0x120
[  330.936896]  ? kthread_stop+0xd0/0xd0
[  330.936896]  ? ret_from_fork+0x2e/0x40
[  330.936896] ---[ end trace 3ff74d1f7f433be5 ]---
[  330.936941] [TTM] Failed to set 1024 pages to wb!
[  330.938244] ------------[ cut here ]------------
[  330.938246] CPA: called for zero pte. vaddr = 0 cpa->vaddr = 0
[  330.938250] WARNING: CPU: 0 PID: 33 at arch/x86/mm/pageattr.c:1466
__cpa_process_fault+0x365/0x390
[  330.938251] Modules linked in: fuse cmac cifs fscache snd_seq_dummy
snd_seq_oss snd_seq_midi_event snd_seq snd_seq_device snd_pcm_oss
snd_mixer_oss ipv6 cfg80211 8021q garp mrp stp llc joydev hid_generic
usbhid hid gpio_ich wmi_bmof hp_wmi sparse_keymap rfkill ppdev evdev
nouveau mxm_wmi video ttm drm_kms_helper drm tg3 agpgart i2c_algo_bit
fb_sys_fops syscopyarea sysfillrect libphy lpc_ich
snd_hda_codec_realtek snd_hda_codec_hdmi snd_hda_codec_generic
sysimgblt psmouse serio_raw i2c_core coretemp firewire_ohci
firewire_core hwmon wmi uhci_hcd snd_hda_intel snd_hda_codec ehci_pci
snd_hda_core ehci_hcd parport_pc parport button snd_hwdep snd_pcm
snd_timer snd soundcore pcc_cpufreq acpi_cpufreq loop
[  330.938273] CPU: 0 PID: 33 Comm: kswapd0 Tainted: G        W I
 4.20.2 #1
[  330.938274] Hardware name: Hewlett-Packard HP xw4600
Workstation/0AA0h, BIOS 786F3 v01.34 07/09/2012
[  330.938276] EIP: __cpa_process_fault+0x365/0x390
[  330.938278] Code: c4 0c 85 c0 0f 88 5a fe ff ff 01 c6 e9 4b fe ff
ff 8b 7d d8 e9 64 ff ff ff 8b 03 ff 30 ff 75 f0 68 d8 9d 38 cd e8 8e
0c 01 00 <0f> 0b be f2 ff ff ff 83 c4 0c e9 e4 fc ff ff 8b 45 f0 8d b8
00 00
[  330.938279] EAX: 00000032 EBX: f4acfd78 ECX: cd509424 EDX: 00000007
[  330.938280] ESI: f4acfd78 EDI: 00000000 EBP: f4acfcc4 ESP: f4acfc88
[  330.938281] DS: 007b ES: 007b FS: 0000 GS: 00e0 SS: 0068 EFLAGS: 00010292
[  330.938283] CR0: 80050033 CR2: b115f7a0 CR3: 250b1000 CR4: 000006d0
[  330.938283] Call Trace:
[  330.938287]  ? __change_page_attr_set_clr+0x575/0x880
[  330.938288]  ? invalidate_mapping_pages+0x7d/0x2f0
[  330.938291]  ? change_page_attr_set_clr+0xf1/0x2f0
[  330.938293]  ? es_do_reclaim_extents+0x9a/0x100
[  330.938296]  ? set_memory_wb+0x35/0x80
[  330.938300]  ? ttm_pages_put+0x4c/0x90 [ttm]
[  330.938304]  ? ttm_page_pool_free+0x104/0x170 [ttm]
[  330.938308]  ? ttm_pool_shrink_scan+0xc0/0x100 [ttm]
[  330.938310]  ? do_shrink_slab+0x155/0x2f0
[  330.938312]  ? shrink_slab+0x1cf/0x240
[  330.938313]  ? __switch_to_asm+0x26/0x50
[  330.938315]  ? shrink_node+0xe1/0x430
[  330.938318]  ? kswapd+0x375/0x630
[  330.938320]  ? kthread+0xef/0x110
[  330.938322]  ? mem_cgroup_shrink_node+0x120/0x120
[  330.938323]  ? kthread_stop+0xd0/0xd0
[  330.938325]  ? ret_from_fork+0x2e/0x40
[  330.938326] ---[ end trace 3ff74d1f7f433be6 ]---
[  330.938327] [TTM] Failed to set 1024 pages to wb
