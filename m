Return-Path: <SRS0=7Uv1=PJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6295C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Jan 2019 16:50:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5517C21871
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Jan 2019 16:50:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MUWsas/q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728999AbfAAQua (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Jan 2019 11:50:30 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:46968 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728176AbfAAQua (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jan 2019 11:50:30 -0500
Received: by mail-lf1-f65.google.com with SMTP id y14so698460lfg.13
        for <linux-kernel@vger.kernel.org>; Tue, 01 Jan 2019 08:50:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=v9/EDKi2c//O+5xJnrTjcp6tKbxQg/ZMTzCU4XtWXEk=;
        b=MUWsas/qbxMNl7dSa1NUCKZyKjI8YzX4Y6XdkTnfNOeXhcoDdRYrtH/ibMTN/Gqbu5
         FJlk+jKbcsJwhv2wydDQ/GC7N9bjRHeTVJj0GNrYCl0fTyOZw9bVXSj9C8HggxLm5yrj
         U50nk3IX0yOeCi//DXiSO9XI2q0ExLXzbEVUa6CQvF7BtXI2QiNcoHej1uVjfGdcb8If
         CAhgM8BIfzyqAeuzGvdq1I1qA385k/mROuKWTQwKNmiATkuGIzlUm0EofHpSmv/Rk/2A
         cp8D6KE3mD71LZCvghKU4IguKTWvjsGFnzB56B2bPpXBTavovwiZwvWU4fo4Mwmv5bof
         3FGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=v9/EDKi2c//O+5xJnrTjcp6tKbxQg/ZMTzCU4XtWXEk=;
        b=GyRpimJBND4PjYekKtx1NC2fx5lYxiAepqXKwcj0Ll/sA8ajK7SXWSRANXA/ZQ38yY
         6lH6dKz5BhaSp8nOmeRnnmU5p6oaKPAK6t0nKnXaP9m3KPA4SX8QBcRK1OFOA/NBeu/2
         vMI0qmPH6rYY4eMCuKGnGoBjm3nZnmPte7/f6c6Ew25JVXi83+W7Qd2TeH28561kpWgH
         CbKm7jdreI91Yh3atlA3WR571HNbRYHVvIWcnfYAKTXVuDOFOvq7Jwmyc+f0ghwxawhN
         mDfcYJD/sWNWZN8PYFz573gn3UIYZXvKDNiZh5/jf2HPZXNInf4SSYzKhq5g8enV6Ll1
         kqOQ==
X-Gm-Message-State: AJcUukd4YvClAfm6nQs3/RSy6ErVTeFdSsZ4t8/OViUjb5754aVtRN0q
        CwDkfnVV01evITotzaW5Pzvl+ONQmQrrrMdSzwYLPgAi
X-Google-Smtp-Source: ALg8bN6VnNOQ5uBhmUik8ZTUf4U9PMR1YoJx+bRgFOUJENHcjxmtMP0KCs3YX0QqStgjFyWFRzXv10KdVOZk85EPn40=
X-Received: by 2002:a19:7dc2:: with SMTP id y185mr10417241lfc.27.1546361426072;
 Tue, 01 Jan 2019 08:50:26 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:ab3:7ad7:0:0:0:0:0 with HTTP; Tue, 1 Jan 2019 08:50:25 -0800 (PST)
From:   Nathaniel Russell <naterussell83@gmail.com>
Date:   Tue, 1 Jan 2019 10:50:25 -0600
Message-ID: <CAONH+J=rW_EKR5F33OHrYSznouX70=u-MGYpLJrOEAuJ5Ezv0Q@mail.gmail.com>
Subject: Kernel Opppps Kernel 4.20.0
To:     linux-kernel <linux-kernel@vger.kernel.org>
Cc:     Nathaniel Russell <naterussell83@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I got this message this morning on Kernel 4.20.0 , mind you I have not
done anything differently as the same with kernel 4.19.6. So when this
came up this morning I figured I needed to send this in.




[74011.275028] ------------[ cut here ]------------
[74011.275031] CPA: called for zero pte. vaddr = 0 cpa->vaddr = 0
[74011.275041] WARNING: CPU: 0 PID: 33 at arch/x86/mm/pageattr.c:1466
__cpa_process_fault+0x365/0x390
[74011.275041] Modules linked in: fuse cmac cifs fscache snd_seq_dummy
snd_seq_oss snd_seq_midi_event snd_seq snd_seq_device snd_pcm_oss
snd_mixer_oss ipv6 cfg80211 8021q garp mrp stp llc joydev hid_generic
usbhid hid hp_wmi sparse_keymap rfkill wmi_bmof gpio_ich ppdev evdev
coretemp snd_hda_codec_realtek snd_hda_codec_hdmi
snd_hda_codec_generic uhci_hcd psmouse serio_raw nouveau mxm_wmi video
ttm drm_kms_helper drm agpgart i2c_algo_bit lpc_ich fb_sys_fops
firewire_ohci firewire_core syscopyarea sysfillrect sysimgblt tg3
i2c_core libphy hwmon parport_pc wmi parport snd_hda_intel
snd_hda_codec snd_hda_core snd_hwdep snd_pcm snd_timer snd button
ehci_pci ehci_hcd soundcore pcc_cpufreq acpi_cpufreq loop
[74011.275074] CPU: 0 PID: 33 Comm: kswapd0 Tainted: G          I
 4.20.0 #1
[74011.275075] Hardware name: Hewlett-Packard HP xw4600
Workstation/0AA0h, BIOS 786F3 v01.34 07/09/2012
[74011.275077] EIP: __cpa_process_fault+0x365/0x390
[74011.275079] Code: c4 0c 85 c0 0f 88 5a fe ff ff 01 c6 e9 4b fe ff
ff 8b 7d d8 e9 64 ff ff ff 8b 03 ff 30 ff 75 f0 68 d4 9b 18 d8 e8 7e
0c 01 00 <0f> 0b be f2 ff ff ff 83 c4 0c e9 e4 fc ff ff 8b 45 f0 8d b8
00 00
[74011.275080] EAX: 00000032 EBX: f4acfd78 ECX: d8309424 EDX: 00000007
[74011.275081] ESI: f4acfd78 EDI: 00000000 EBP: f4acfcc4 ESP: f4acfc88
[74011.275083] DS: 007b ES: 007b FS: 0000 GS: 00e0 SS: 0068 EFLAGS: 00010292
[74011.275084] CR0: 80050033 CR2: b72c3000 CR3: 2b290000 CR4: 000006d0
[74011.275084] Call Trace:
[74011.275090]  ? __change_page_attr_set_clr+0x575/0x880
[74011.275092]  ? sched_clock+0x8/0x10
[74011.275095]  ? flush_tlb_kernel_range+0x70/0x80
[74011.275097]  ? __free_vmap_area+0x42/0xd0
[74011.275099]  ? __purge_vmap_area_lazy+0x68/0x90
[74011.275101]  ? change_page_attr_set_clr+0xf1/0x2f0
[74011.275103]  ? xas_load+0xe/0xc0
[74011.275106]  ? set_memory_wb+0x35/0x80
[74011.275111]  ? ttm_pages_put+0x4c/0x90 [ttm]
[74011.275115]  ? ttm_page_pool_free+0x104/0x170 [ttm]
[74011.275119]  ? ttm_pool_shrink_scan+0xc0/0x100 [ttm]
[74011.275122]  ? do_shrink_slab+0x155/0x2f0
[74011.275124]  ? shrink_slab+0x1cf/0x240
[74011.275126]  ? __switch_to_asm+0x26/0x50
[74011.275128]  ? shrink_node+0xe1/0x430
[74011.275130]  ? kswapd+0x375/0x630
[74011.275133]  ? kthread+0xef/0x110
[74011.275135]  ? mem_cgroup_shrink_node+0x120/0x120
[74011.275136]  ? kthread_stop+0xd0/0xd0
[74011.275138]  ? ret_from_fork+0x2e/0x40
[74011.275139] ---[ end trace 3ff74d1f7f433be3 ]---
[74011.275140] [TTM] Failed to set 1024 pages to wb!
[74011.277580] ------------[ cut here ]------------
[74011.277582] CPA: called for zero pte. vaddr = 0 cpa->vaddr = 0
[74011.277590] WARNING: CPU: 0 PID: 33 at arch/x86/mm/pageattr.c:1466
__cpa_process_fault+0x365/0x390
[74011.277590] Modules linked in: fuse cmac cifs fscache snd_seq_dummy
snd_seq_oss snd_seq_midi_event snd_seq snd_seq_device snd_pcm_oss
snd_mixer_oss ipv6 cfg80211 8021q garp mrp stp llc joydev hid_generic
usbhid hid hp_wmi sparse_keymap rfkill wmi_bmof gpio_ich ppdev evdev
coretemp snd_hda_codec_realtek snd_hda_codec_hdmi
snd_hda_codec_generic uhci_hcd psmouse serio_raw nouveau mxm_wmi video
ttm drm_kms_helper drm agpgart i2c_algo_bit lpc_ich fb_sys_fops
firewire_ohci firewire_core syscopyarea sysfillrect sysimgblt tg3
i2c_core libphy hwmon parport_pc wmi parport snd_hda_intel
snd_hda_codec snd_hda_core snd_hwdep snd_pcm snd_timer snd button
ehci_pci ehci_hcd soundcore pcc_cpufreq acpi_cpufreq loop
[74011.277619] CPU: 0 PID: 33 Comm: kswapd0 Tainted: G        W I
 4.20.0 #1
[74011.277619] Hardware name: Hewlett-Packard HP xw4600
Workstation/0AA0h, BIOS 786F3 v01.34 07/09/2012
[74011.277622] EIP: __cpa_process_fault+0x365/0x390
[74011.277623] Code: c4 0c 85 c0 0f 88 5a fe ff ff 01 c6 e9 4b fe ff
ff 8b 7d d8 e9 64 ff ff ff 8b 03 ff 30 ff 75 f0 68 d4 9b 18 d8 e8 7e
0c 01 00 <0f> 0b be f2 ff ff ff 83 c4 0c e9 e4 fc ff ff 8b 45 f0 8d b8
00 00
[74011.277625] EAX: 00000032 EBX: f4acfd78 ECX: d8309424 EDX: 00000007
[74011.277626] ESI: f4acfd78 EDI: 00000000 EBP: f4acfcc4 ESP: f4acfc88
[74011.277627] DS: 007b ES: 007b FS: 0000 GS: 00e0 SS: 0068 EFLAGS: 00010292
[74011.277628] CR0: 80050033 CR2: b72c3000 CR3: 32b74000 CR4: 000006d0
[74011.277629] Call Trace:
[74011.277633]  ? __change_page_attr_set_clr+0x575/0x880
[74011.277636]  ? sched_clock+0x8/0x10
[74011.277639]  ? enqueue_entity+0xa2/0x2f0
[74011.277641]  ? __switch_to_asm+0x32/0x50
[74011.277642]  ? __switch_to_asm+0x26/0x50
[74011.277643]  ? __switch_to_asm+0x32/0x50
[74011.277645]  ? __switch_to_asm+0x32/0x50
[74011.277646]  ? __switch_to_asm+0x26/0x50
[74011.277647]  ? __switch_to_asm+0x32/0x50
[74011.277649]  ? __switch_to_asm+0x26/0x50
[74011.277651]  ? change_page_attr_set_clr+0xf1/0x2f0
[74011.277652]  ? __switch_to_asm+0x32/0x50
[74011.277653]  ? __switch_to_asm+0x26/0x50
[74011.277656]  ? set_memory_wb+0x35/0x80
[74011.277661]  ? ttm_pages_put+0x4c/0x90 [ttm]
[74011.277665]  ? ttm_page_pool_free+0x104/0x170 [ttm]
[74011.277668]  ? ttm_pool_shrink_scan+0xc0/0x100 [ttm]
[74011.277671]  ? do_shrink_slab+0x155/0x2f0
[74011.277673]  ? shrink_slab+0x1cf/0x240
[74011.277674]  ? __switch_to_asm+0x26/0x50
[74011.277676]  ? shrink_node+0xe1/0x430
[74011.277678]  ? kswapd+0x375/0x630
[74011.277681]  ? kthread+0xef/0x110
[74011.277683]  ? mem_cgroup_shrink_node+0x120/0x120
[74011.277684]  ? kthread_stop+0xd0/0xd0
[74011.277686]  ? ret_from_fork+0x2e/0x40
[74011.277687] ---[ end trace 3ff74d1f7f433be4 ]---
[74011.277688] [TTM] Failed to set 1024 pages to wb!
[74011.280974] ------------[ cut here ]------------
[74011.280976] CPA: called for zero pte. vaddr = 0 cpa->vaddr = 0
[74011.280985] WARNING: CPU: 0 PID: 33 at arch/x86/mm/pageattr.c:1466
__cpa_process_fault+0x365/0x390
[74011.280985] Modules linked in: fuse cmac cifs fscache snd_seq_dummy
snd_seq_oss snd_seq_midi_event snd_seq snd_seq_device snd_pcm_oss
snd_mixer_oss ipv6 cfg80211 8021q garp mrp stp llc joydev hid_generic
usbhid hid hp_wmi sparse_keymap rfkill wmi_bmof gpio_ich ppdev evdev
coretemp snd_hda_codec_realtek snd_hda_codec_hdmi
snd_hda_codec_generic uhci_hcd psmouse serio_raw nouveau mxm_wmi video
ttm drm_kms_helper drm agpgart i2c_algo_bit lpc_ich fb_sys_fops
firewire_ohci firewire_core syscopyarea sysfillrect sysimgblt tg3
i2c_core libphy hwmon parport_pc wmi parport snd_hda_intel
snd_hda_codec snd_hda_core snd_hwdep snd_pcm snd_timer snd button
ehci_pci ehci_hcd soundcore pcc_cpufreq acpi_cpufreq loop
[74011.281016] CPU: 0 PID: 33 Comm: kswapd0 Tainted: G        W I
 4.20.0 #1
[74011.281017] Hardware name: Hewlett-Packard HP xw4600
Workstation/0AA0h, BIOS 786F3 v01.34 07/09/2012
[74011.281019] EIP: __cpa_process_fault+0x365/0x390
[74011.281021] Code: c4 0c 85 c0 0f 88 5a fe ff ff 01 c6 e9 4b fe ff
ff 8b 7d d8 e9 64 ff ff ff 8b 03 ff 30 ff 75 f0 68 d4 9b 18 d8 e8 7e
0c 01 00 <0f> 0b be f2 ff ff ff 83 c4 0c e9 e4 fc ff ff 8b 45 f0 8d b8
00 00
[74011.281022] EAX: 00000032 EBX: f4acfd78 ECX: d8309424 EDX: 00000007
[74011.281023] ESI: f4acfd78 EDI: 00000000 EBP: f4acfcc4 ESP: f4acfc88
[74011.281024] DS: 007b ES: 007b FS: 0000 GS: 00e0 SS: 0068 EFLAGS: 00210292
[74011.281025] CR0: 80050033 CR2: b72c3000 CR3: 292b5000 CR4: 000006d0
[74011.281026] Call Trace:
[74011.281031]  ? __change_page_attr_set_clr+0x575/0x880
[74011.281033]  ? update_curr+0xbf/0x1b0
[74011.281036]  ? sched_clock+0x8/0x10
[74011.281037]  ? enqueue_entity+0xa2/0x2f0
[74011.281040]  ? __switch_to_asm+0x32/0x50
[74011.281041]  ? __switch_to_asm+0x26/0x50
[74011.281042]  ? __switch_to_asm+0x32/0x50
[74011.281044]  ? __switch_to_asm+0x32/0x50
[74011.281045]  ? __switch_to_asm+0x26/0x50
[74011.281046]  ? __switch_to_asm+0x32/0x50
[74011.281047]  ? __switch_to_asm+0x26/0x50
[74011.281049]  ? change_page_attr_set_clr+0xf1/0x2f0
[74011.281051]  ? __switch_to_asm+0x32/0x50
[74011.281052]  ? __switch_to_asm+0x26/0x50
[74011.281054]  ? set_memory_wb+0x35/0x80
[74011.281061]  ? ttm_pages_put+0x4c/0x90 [ttm]
[74011.281064]  ? ttm_page_pool_free+0x104/0x170 [ttm]
[74011.281068]  ? ttm_pool_shrink_scan+0xc0/0x100 [ttm]
[74011.281071]  ? do_shrink_slab+0x155/0x2f0
[74011.281073]  ? shrink_slab+0x1cf/0x240
[74011.281074]  ? __switch_to_asm+0x26/0x50
[74011.281076]  ? shrink_node+0xe1/0x430
[74011.281078]  ? kswapd+0x375/0x630
[74011.281081]  ? kthread+0xef/0x110
[74011.281083]  ? mem_cgroup_shrink_node+0x120/0x120
[74011.281084]  ? kthread_stop+0xd0/0xd0
[74011.281086]  ? ret_from_fork+0x2e/0x40
[74011.281087] ---[ end trace 3ff74d1f7f433be5 ]---
[74011.281088] [TTM] Failed to set 1024 pages to wb!
[74011.283664] ------------[ cut here ]------------
[74011.283666] CPA: called for zero pte. vaddr = 0 cpa->vaddr = 0
[74011.283673] WARNING: CPU: 0 PID: 33 at arch/x86/mm/pageattr.c:1466
__cpa_process_fault+0x365/0x390
[74011.283674] Modules linked in: fuse cmac cifs fscache snd_seq_dummy
snd_seq_oss snd_seq_midi_event snd_seq snd_seq_device snd_pcm_oss
snd_mixer_oss ipv6 cfg80211 8021q garp mrp stp llc joydev hid_generic
usbhid hid hp_wmi sparse_keymap rfkill wmi_bmof gpio_ich ppdev evdev
coretemp snd_hda_codec_realtek snd_hda_codec_hdmi
snd_hda_codec_generic uhci_hcd psmouse serio_raw nouveau mxm_wmi video
ttm drm_kms_helper drm agpgart i2c_algo_bit lpc_ich fb_sys_fops
firewire_ohci firewire_core syscopyarea sysfillrect sysimgblt tg3
i2c_core libphy hwmon parport_pc wmi parport snd_hda_intel
snd_hda_codec snd_hda_core snd_hwdep snd_pcm snd_timer snd button
ehci_pci ehci_hcd soundcore pcc_cpufreq acpi_cpufreq loop
[74011.283702] CPU: 0 PID: 33 Comm: kswapd0 Tainted: G        W I
 4.20.0 #1
[74011.283702] Hardware name: Hewlett-Packard HP xw4600
Workstation/0AA0h, BIOS 786F3 v01.34 07/09/2012
[74011.283705] EIP: __cpa_process_fault+0x365/0x390
[74011.283706] Code: c4 0c 85 c0 0f 88 5a fe ff ff 01 c6 e9 4b fe ff
ff 8b 7d d8 e9 64 ff ff ff 8b 03 ff 30 ff 75 f0 68 d4 9b 18 d8 e8 7e
0c 01 00 <0f> 0b be f2 ff ff ff 83 c4 0c e9 e4 fc ff ff 8b 45 f0 8d b8
00 00
[74011.283708] EAX: 00000032 EBX: f4acfd78 ECX: d8309424 EDX: 00000007
[74011.283709] ESI: f4acfd78 EDI: 00000000 EBP: f4acfcc4 ESP: f4acfc88
[74011.283710] DS: 007b ES: 007b FS: 0000 GS: 00e0 SS: 0068 EFLAGS: 00010292
[74011.283711] CR0: 80050033 CR2: b72c3000 CR3: 32b74000 CR4: 000006d0
[74011.283712] Call Trace:
[74011.283716]  ? ktime_get+0x3f/0x120
[74011.283718]  ? __change_page_attr_set_clr+0x575/0x880
[74011.283720]  ? sched_clock+0x8/0x10
[74011.283722]  ? enqueue_entity+0xa2/0x2f0
[74011.283724]  ? __switch_to_asm+0x32/0x50
[74011.283726]  ? __switch_to_asm+0x26/0x50
[74011.283727]  ? __switch_to_asm+0x32/0x50
[74011.283728]  ? __switch_to_asm+0x32/0x50
[74011.283730]  ? __switch_to_asm+0x26/0x50
[74011.283731]  ? __switch_to_asm+0x32/0x50
[74011.283732]  ? __switch_to_asm+0x26/0x50
[74011.283734]  ? change_page_attr_set_clr+0xf1/0x2f0
[74011.283735]  ? __switch_to_asm+0x32/0x50
[74011.283737]  ? __switch_to_asm+0x26/0x50
[74011.283739]  ? set_memory_wb+0x35/0x80
[74011.283744]  ? ttm_pages_put+0x4c/0x90 [ttm]
[74011.283748]  ? ttm_page_pool_free+0x104/0x170 [ttm]
[74011.283752]  ? ttm_pool_shrink_scan+0xc0/0x100 [ttm]
[74011.283754]  ? do_shrink_slab+0x155/0x2f0
[74011.283756]  ? shrink_slab+0x1cf/0x240
[74011.283758]  ? __switch_to_asm+0x26/0x50
[74011.283760]  ? shrink_node+0xe1/0x430
[74011.283762]  ? kswapd+0x375/0x630
[74011.283764]  ? kthread+0xef/0x110
[74011.283766]  ? mem_cgroup_shrink_node+0x120/0x120
[74011.283768]  ? kthread_stop+0xd0/0xd0
[74011.283769]  ? ret_from_fork+0x2e/0x40
[74011.283770] ---[ end trace 3ff74d1f7f433be6 ]---
[74011.283771] [TTM] Failed to set 1024 pages to wb!
[74011.291409] ------------[ cut here ]------------
[74011.291412] CPA: called for zero pte. vaddr = 0 cpa->vaddr = 0
[74011.291423] WARNING: CPU: 0 PID: 33 at arch/x86/mm/pageattr.c:1466
__cpa_process_fault+0x365/0x390
[74011.291424] Modules linked in: fuse cmac cifs fscache snd_seq_dummy
snd_seq_oss snd_seq_midi_event snd_seq snd_seq_device snd_pcm_oss
snd_mixer_oss ipv6 cfg80211 8021q garp mrp stp llc joydev hid_generic
usbhid hid hp_wmi sparse_keymap rfkill wmi_bmof gpio_ich ppdev evdev
coretemp snd_hda_codec_realtek snd_hda_codec_hdmi
snd_hda_codec_generic uhci_hcd psmouse serio_raw nouveau mxm_wmi video
ttm drm_kms_helper drm agpgart i2c_algo_bit lpc_ich fb_sys_fops
firewire_ohci firewire_core syscopyarea sysfillrect sysimgblt tg3
i2c_core libphy hwmon parport_pc wmi parport snd_hda_intel
snd_hda_codec snd_hda_core snd_hwdep snd_pcm snd_timer snd button
ehci_pci ehci_hcd soundcore pcc_cpufreq acpi_cpufreq loop
[74011.291456] CPU: 0 PID: 33 Comm: kswapd0 Tainted: G        W I
 4.20.0 #1
[74011.291457] Hardware name: Hewlett-Packard HP xw4600
Workstation/0AA0h, BIOS 786F3 v01.34 07/09/2012
[74011.291459] EIP: __cpa_process_fault+0x365/0x390
[74011.291461] Code: c4 0c 85 c0 0f 88 5a fe ff ff 01 c6 e9 4b fe ff
ff 8b 7d d8 e9 64 ff ff ff 8b 03 ff 30 ff 75 f0 68 d4 9b 18 d8 e8 7e
0c 01 00 <0f> 0b be f2 ff ff ff 83 c4 0c e9 e4 fc ff ff 8b 45 f0 8d b8
00 00
[74011.291463] EAX: 00000032 EBX: f4acfd78 ECX: d8309424 EDX: 00000007
[74011.291464] ESI: f4acfd78 EDI: 00000000 EBP: f4acfcc4 ESP: f4acfc88
[74011.291465] DS: 007b ES: 007b FS: 0000 GS: 00e0 SS: 0068 EFLAGS: 00010292
[74011.291466] CR0: 80050033 CR2: b72c3000 CR3: 31c5b000 CR4: 000006d0
[74011.291467] Call Trace:
[74011.291472]  ? __change_page_attr_set_clr+0x575/0x880
[74011.291474]  ? default_inquire_remote_apic+0x10/0x10
[74011.291477]  ? lapic_next_event+0x1d/0x30
[74011.291480]  ? change_page_attr_set_clr+0xf1/0x2f0
[74011.291483]  ? es_do_reclaim_extents+0x9a/0x100
[74011.291485]  ? set_memory_wb+0x35/0x80
[74011.291491]  ? ttm_pages_put+0x4c/0x90 [ttm]
[74011.291495]  ? ttm_page_pool_free+0x104/0x170 [ttm]
[74011.291499]  ? ttm_pool_shrink_scan+0xc0/0x100 [ttm]
[74011.291502]  ? do_shrink_slab+0x155/0x2f0
[74011.291504]  ? shrink_slab+0x1cf/0x240
[74011.291506]  ? __switch_to_asm+0x26/0x50
[74011.291508]  ? shrink_node+0xe1/0x430
[74011.291510]  ? kswapd+0x375/0x630
[74011.291513]  ? kthread+0xef/0x110
[74011.291515]  ? mem_cgroup_shrink_node+0x120/0x120
[74011.291516]  ? kthread_stop+0xd0/0xd0
[74011.291518]  ? ret_from_fork+0x2e/0x40
[74011.291519] ---[ end trace 3ff74d1f7f433be7 ]---
[74011.291521] [TTM] Failed to set 1024 pages to wb!
[74011.291534] ------------[ cut here ]------------
[74011.291534] CPA: called for zero pte. vaddr = 0 cpa->vaddr = 0
[74011.291538] WARNING: CPU: 0 PID: 33 at arch/x86/mm/pageattr.c:1466
__cpa_process_fault+0x365/0x390
[74011.291538] Modules linked in: fuse cmac cifs fscache snd_seq_dummy
snd_seq_oss snd_seq_midi_event snd_seq snd_seq_device snd_pcm_oss
snd_mixer_oss ipv6 cfg80211 8021q garp mrp stp llc joydev hid_generic
usbhid hid hp_wmi sparse_keymap rfkill wmi_bmof gpio_ich ppdev evdev
coretemp snd_hda_codec_realtek snd_hda_codec_hdmi
snd_hda_codec_generic uhci_hcd psmouse serio_raw nouveau mxm_wmi video
ttm drm_kms_helper drm agpgart i2c_algo_bit lpc_ich fb_sys_fops
firewire_ohci firewire_core syscopyarea sysfillrect sysimgblt tg3
i2c_core libphy hwmon parport_pc wmi parport snd_hda_intel
snd_hda_codec snd_hda_core snd_hwdep snd_pcm snd_timer snd button
ehci_pci ehci_hcd soundcore pcc_cpufreq acpi_cpufreq loop
[74011.291558] CPU: 0 PID: 33 Comm: kswapd0 Tainted: G        W I
 4.20.0 #1
[74011.291559] Hardware name: Hewlett-Packard HP xw4600
Workstation/0AA0h, BIOS 786F3 v01.34 07/09/2012
[74011.291561] EIP: __cpa_process_fault+0x365/0x390
[74011.291562] Code: c4 0c 85 c0 0f 88 5a fe ff ff 01 c6 e9 4b fe ff
ff 8b 7d d8 e9 64 ff ff ff 8b 03 ff 30 ff 75 f0 68 d4 9b 18 d8 e8 7e
0c 01 00 <0f> 0b be f2 ff ff ff 83 c4 0c e9 e4 fc ff ff 8b 45 f0 8d b8
00 00
[74011.291563] EAX: 00000032 EBX: f4acfd78 ECX: d8309424 EDX: 00000007
[74011.291564] ESI: f4acfd78 EDI: 00000000 EBP: f4acfcc4 ESP: f4acfc88
[74011.291565] DS: 007b ES: 007b FS: 0000 GS: 00e0 SS: 0068 EFLAGS: 00010292
[74011.291567] CR0: 80050033 CR2: b72c3000 CR3: 31c5b000 CR4: 000006d0
[74011.291567] Call Trace:
[74011.291570]  ? sched_clock+0x8/0x10
[74011.291572]  ? __change_page_attr_set_clr+0x575/0x880
[74011.291575]  ? sched_clock_cpu+0xb5/0xd0
[74011.291577]  ? log_store+0x1f7/0x280
[74011.291579]  ? change_page_attr_set_clr+0xf1/0x2f0
[74011.291581]  ? set_memory_wb+0x35/0x80
[74011.291585]  ? ttm_pages_put+0x4c/0x90 [ttm]
[74011.291589]  ? ttm_page_pool_free+0x104/0x170 [ttm]
[74011.291593]  ? ttm_pool_shrink_scan+0xc0/0x100 [ttm]
[74011.291595]  ? do_shrink_slab+0x155/0x2f0
[74011.291597]  ? shrink_slab+0x1cf/0x240
[74011.291598]  ? __switch_to_asm+0x26/0x50
[74011.291600]  ? shrink_node+0xe1/0x430
[74011.291602]  ? kswapd+0x375/0x630
[74011.291604]  ? kthread+0xef/0x110
[74011.291606]  ? mem_cgroup_shrink_node+0x120/0x120
[74011.291608]  ? kthread_stop+0xd0/0xd0
[74011.291609]  ? ret_from_fork+0x2e/0x40
[74011.291610] ---[ end trace 3ff74d1f7f433be8 ]---
[74011.291611] [TTM] Failed to set 1024 pages to wb!
[74011.298088] ------------[ cut here ]------------
[74011.298091] CPA: called for zero pte. vaddr = 0 cpa->vaddr = 0
[74011.298104] WARNING: CPU: 0 PID: 33 at arch/x86/mm/pageattr.c:1466
__cpa_process_fault+0x365/0x390
[74011.298104] Modules linked in: fuse cmac cifs fscache snd_seq_dummy
snd_seq_oss snd_seq_midi_event snd_seq snd_seq_device snd_pcm_oss
snd_mixer_oss ipv6 cfg80211 8021q garp mrp stp llc joydev hid_generic
usbhid hid hp_wmi sparse_keymap rfkill wmi_bmof gpio_ich ppdev evdev
coretemp snd_hda_codec_realtek snd_hda_codec_hdmi
snd_hda_codec_generic uhci_hcd psmouse serio_raw nouveau mxm_wmi video
ttm drm_kms_helper drm agpgart i2c_algo_bit lpc_ich fb_sys_fops
firewire_ohci firewire_core syscopyarea sysfillrect sysimgblt tg3
i2c_core libphy hwmon parport_pc wmi parport snd_hda_intel
snd_hda_codec snd_hda_core snd_hwdep snd_pcm snd_timer snd button
ehci_pci ehci_hcd soundcore pcc_cpufreq acpi_cpufreq loop
[74011.298136] CPU: 0 PID: 33 Comm: kswapd0 Tainted: G        W I
 4.20.0 #1
[74011.298137] Hardware name: Hewlett-Packard HP xw4600
Workstation/0AA0h, BIOS 786F3 v01.34 07/09/2012
[74011.298140] EIP: __cpa_process_fault+0x365/0x390
[74011.298142] Code: c4 0c 85 c0 0f 88 5a fe ff ff 01 c6 e9 4b fe ff
ff 8b 7d d8 e9 64 ff ff ff 8b 03 ff 30 ff 75 f0 68 d4 9b 18 d8 e8 7e
0c 01 00 <0f> 0b be f2 ff ff ff 83 c4 0c e9 e4 fc ff ff 8b 45 f0 8d b8
00 00
[74011.298143] EAX: 00000032 EBX: f4acfd78 ECX: d8309424 EDX: 00000007
[74011.298144] ESI: f4acfd78 EDI: 00000000 EBP: f4acfcc4 ESP: f4acfc88
[74011.298145] DS: 007b ES: 007b FS: 0000 GS: 00e0 SS: 0068 EFLAGS: 00010292
[74011.298146] CR0: 80050033 CR2: b72c3000 CR3: 32b74000 CR4: 000006d0
[74011.298147] Call Trace:
[74011.298152]  ? __change_page_attr_set_clr+0x575/0x880
[74011.298155]  ? default_inquire_remote_apic+0x10/0x10
[74011.298158]  ? tick_program_event+0x3d/0x90
[74011.298160]  ? change_page_attr_set_clr+0xf1/0x2f0
[74011.298163]  ? es_do_reclaim_extents+0x9a/0x100
[74011.298166]  ? set_memory_wb+0x35/0x80
[74011.298172]  ? ttm_pages_put+0x4c/0x90 [ttm]
[74011.298176]  ? ttm_page_pool_free+0x104/0x170 [ttm]
[74011.298180]  ? ttm_pool_shrink_scan+0xc0/0x100 [ttm]
[74011.298183]  ? do_shrink_slab+0x155/0x2f0
[74011.298185]  ? shrink_slab+0x1cf/0x240
[74011.298188]  ? __switch_to_asm+0x26/0x50
[74011.298190]  ? shrink_node+0xe1/0x430
[74011.298192]  ? kswapd+0x375/0x630
[74011.298195]  ? kthread+0xef/0x110
[74011.298196]  ? mem_cgroup_shrink_node+0x120/0x120
[74011.298198]  ? kthread_stop+0xd0/0xd0
[74011.298199]  ? ret_from_fork+0x2e/0x40
[74011.298200] ---[ end trace 3ff74d1f7f433be9 ]---
[74011.298202] [TTM] Failed to set 1024 pages to wb!
[74011.298215] ------------[ cut here ]------------
[74011.298216] CPA: called for zero pte. vaddr = 0 cpa->vaddr = 0
[74011.298219] WARNING: CPU: 0 PID: 33 at arch/x86/mm/pageattr.c:1466
__cpa_process_fault+0x365/0x390
[74011.298219] Modules linked in: fuse cmac cifs fscache snd_seq_dummy
snd_seq_oss snd_seq_midi_event snd_seq snd_seq_device snd_pcm_oss
snd_mixer_oss ipv6 cfg80211 8021q garp mrp stp llc joydev hid_generic
usbhid hid hp_wmi sparse_keymap rfkill wmi_bmof gpio_ich ppdev evdev
coretemp snd_hda_codec_realtek snd_hda_codec_hdmi
snd_hda_codec_generic uhci_hcd psmouse serio_raw nouveau mxm_wmi video
ttm drm_kms_helper drm agpgart i2c_algo_bit lpc_ich fb_sys_fops
firewire_ohci firewire_core syscopyarea sysfillrect sysimgblt tg3
i2c_core libphy hwmon parport_pc wmi parport snd_hda_intel
snd_hda_codec snd_hda_core snd_hwdep snd_pcm snd_timer snd button
ehci_pci ehci_hcd soundcore pcc_cpufreq acpi_cpufreq loop
[74011.298239] CPU: 0 PID: 33 Comm: kswapd0 Tainted: G        W I
 4.20.0 #1
[74011.298240] Hardware name: Hewlett-Packard HP xw4600
Workstation/0AA0h, BIOS 786F3 v01.34 07/09/2012
[74011.298242] EIP: __cpa_process_fault+0x365/0x390
[74011.298243] Code: c4 0c 85 c0 0f 88 5a fe ff ff 01 c6 e9 4b fe ff
ff 8b 7d d8 e9 64 ff ff ff 8b 03 ff 30 ff 75 f0 68 d4 9b 18 d8 e8 7e
0c 01 00 <0f> 0b be f2 ff ff ff 83 c4 0c e9 e4 fc ff ff 8b 45 f0 8d b8
00 00
[74011.298244] EAX: 00000032 EBX: f4acfd78 ECX: d8309424 EDX: 00000007
[74011.298245] ESI: f4acfd78 EDI: 00000000 EBP: f4acfcc4 ESP: f4acfc88
[74011.298247] DS: 007b ES: 007b FS: 0000 GS: 00e0 SS: 0068 EFLAGS: 00010292
[74011.298248] CR0: 80050033 CR2: b72c3000 CR3: 32b74000 CR4: 000006d0
[74011.298248] Call Trace:
[74011.298252]  ? sched_clock+0x8/0x10
[74011.298254]  ? __change_page_attr_set_clr+0x575/0x880
[74011.298256]  ? sched_clock_cpu+0xb5/0xd0
[74011.298258]  ? log_store+0x1f7/0x280
[74011.298260]  ? change_page_attr_set_clr+0xf1/0x2f0
[74011.298263]  ? set_memory_wb+0x35/0x80
[74011.298267]  ? ttm_pages_put+0x4c/0x90 [ttm]
[74011.298270]  ? ttm_page_pool_free+0x104/0x170 [ttm]
[74011.298274]  ? ttm_pool_shrink_scan+0xc0/0x100 [ttm]
[74011.298276]  ? do_shrink_slab+0x155/0x2f0
[74011.298278]  ? shrink_slab+0x1cf/0x240
[74011.298279]  ? __switch_to_asm+0x26/0x50
[74011.298281]  ? shrink_node+0xe1/0x430
[74011.298283]  ? kswapd+0x375/0x630
[74011.298286]  ? kthread+0xef/0x110
[74011.298287]  ? mem_cgroup_shrink_node+0x120/0x120
[74011.298289]  ? kthread_stop+0xd0/0xd0
[74011.298290]  ? ret_from_fork+0x2e/0x40
[74011.298291] ---[ end trace 3ff74d1f7f433bea ]---
[74011.298292] [TTM] Failed to set 1024 pages to wb!
