Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id K7JfOGidG1uWTgAAmS7hNA
	; Sat, 09 Jun 2018 09:50:42 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id C4BDC607A4; Sat,  9 Jun 2018 09:50:42 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id D1080601D2;
	Sat,  9 Jun 2018 09:50:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D1080601D2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=xs4all.nl
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753176AbeFIJuj (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Sat, 9 Jun 2018 05:50:39 -0400
Received: from pindarots.xs4all.nl ([82.161.210.87]:42986 "EHLO
        pindarots.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752272AbeFIJug (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jun 2018 05:50:36 -0400
Received: from surfplank2.hierzo (localhost.localdomain [127.0.0.1])
        by pindarots.xs4all.nl (8.15.2/8.14.5) with ESMTPS id w599oYqi012428
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO)
        for <linux-kernel@vger.kernel.org>; Sat, 9 Jun 2018 11:50:35 +0200
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From: Udo van den Heuvel <udovdh@xs4all.nl>
Subject: 4.16.14: kernel tried to execute NX-protected page [after USB device
 went to charging state]
Organization: hierzo
Message-ID: <12230457-6839-c320-c270-be4916486438@xs4all.nl>
Date: Sat, 9 Jun 2018 11:50:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

My Holus GPSport 245 was used to download a gpx track. Afterwards I 
turned the device off while it was attached to USB so it could charge.
Later I found these messages you can find below.
Is this an actual bug?

# dmesg
[213812.789603] amdgpu: [powerplay] pp_dpm_get_temperature was not 
implemented.
[213812.789620] amdgpu: [powerplay] pp_dpm_get_temperature was not 
implemented.
[223632.282418] usb 1-7: new full-speed USB device number 6 using xhci_hcd
[223632.529546] usb 1-7: New USB device found, idVendor=10c4, idProduct=ea60
[223632.529553] usb 1-7: New USB device strings: Mfr=1, Product=2, 
SerialNumber=3
[223632.529557] usb 1-7: Product: CP2102 USB to UART Bridge Controller
[223632.529561] usb 1-7: Manufacturer: Silicon Labs
[223632.529564] usb 1-7: SerialNumber: 0001
[223632.742576] usbcore: registered new interface driver usbserial_generic
[223632.742589] usbserial: USB Serial support registered for generic
[223632.755240] usbcore: registered new interface driver cp210x
[223632.755254] usbserial: USB Serial support registered for cp210x
[223632.755286] cp210x 1-7:1.0: cp210x converter detected
[223632.768623] usb 1-7: cp210x converter now attached to ttyUSB0
[225389.048501] usb 1-7: USB disconnect, device number 6
[225389.048758] cp210x ttyUSB0: cp210x converter now disconnected from 
ttyUSB0
[225389.048785] kernel tried to execute NX-protected page - exploit 
attempt? (uid: 0)
[225389.048788] BUG: unable to handle kernel paging request at 
ffffffffc08b64e0
[225389.048797] IP: usb_serial_exit+0x35df/0xff [usbserial]
[225389.048799] PGD 2ea00c067 P4D 2ea00c067 PUD 2ea00e067 PMD 408590067 
PTE 8000000109510163
[225389.048807] Oops: 0011 [#1] PREEMPT SMP NOPTI
[225389.048809] Modules linked in: cp210x usbserial it87(O) hwmon_vid 
fuse ipt_REJECT nf_reject_ipv4 xt_u32 xt_multiport iptable_filter 
ipt_MASQUERADE nf_nat_masquerade_ipv4 iptable_nat nf_conntrack_ipv4 
nf_defrag_ipv4 nf_nat_ipv4 nf_nat cpufreq_userspace 
nf_conntrack_netbios_ns nf_conntrack_broadcast ip6t_REJECT 
nf_reject_ipv6 xt_tcpudp nf_conntrack_ipv6 nf_defrag_ipv6 xt_conntrack 
msr nf_conntrack ip6table_filter ip6_tables eeprom uvcvideo 
videobuf2_vmalloc videobuf2_memops videobuf2_v4l2 snd_usb_audio videodev 
snd_hwdep videobuf2_common cdc_acm snd_usbmidi_lib snd_rawmidi amdgpu 
snd_hda_codec_realtek snd_hda_codec_generic snd_hda_intel snd_hda_codec 
snd_hda_core snd_seq snd_seq_device snd_pcm chash snd_timer gpu_sched 
backlight snd ttm i2c_piix4 evdev acpi_cpufreq k10temp nfsd auth_rpcgss 
nfs_acl
[225389.048857]  lockd grace sunrpc binfmt_misc ip_tables x_tables 
hid_generic sr_mod cdrom usbhid i2c_dev autofs4 [last unloaded: hwmon_vid]
[225389.048871] CPU: 1 PID: 5717 Comm: kworker/1:2 Tainted: G 
O     4.16.14 #5
[225389.048873] Hardware name: Gigabyte Technology Co., Ltd. X470 AORUS 
ULTRA GAMING/X470 AORUS ULTRA GAMING-CF, BIOS F3g 05/10/2018
[225389.048880] Workqueue: usb_hub_wq hub_event
[225389.048886] RIP: 0010:usb_serial_exit+0x35df/0xff [usbserial]
[225389.048889] RSP: 0018:ffff90d3c8c27be8 EFLAGS: 00010282
[225389.048892] RAX: ffffffffc08b64e0 RBX: ffff8bd5d2190ae8 RCX: 
0000000000000000
[225389.048895] RDX: 0000000080000001 RSI: 0000000000000282 RDI: 
ffff8bd5d2190ad8
[225389.048897] RBP: ffff8bd5d2190ad8 R08: 0000000000000000 R09: 
0000000000000000
[225389.048899] R10: 0000000000000000 R11: 0000000000000000 R12: 
ffff8bd392029480
[225389.048902] R13: ffff8bd64b4d4e00 R14: ffff8bd64d2fc030 R15: 
ffff8bd64d2fc030
[225389.048905] FS:  0000000000000000(0000) GS:ffff8bd65ee40000(0000) 
knlGS:0000000000000000
[225389.048908] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[225389.048910] CR2: ffffffffc08b64e0 CR3: 00000003f0b50000 CR4: 
00000000003406e0
[225389.048912] Call Trace:
[225389.048918]  ? device_release+0x39/0xa0
[225389.048924]  ? kobject_put+0xa1/0x1c0
[225389.048929]  ? usb_serial_put+0x4c/0xf0 [usbserial]
[225389.048933]  ? usb_serial_disconnect+0xdd/0x100 [usbserial]
[225389.048938]  ? usb_unbind_interface+0x66/0x1e0
[225389.048942]  ? device_release_driver_internal+0x17a/0x230
[225389.048946]  ? bus_remove_device+0xe0/0x150
[225389.048950]  ? device_del+0x129/0x330
[225389.048954]  ? usb_disable_device+0x8d/0x230
[225389.048958]  ? usb_disconnect+0xb1/0x270
[225389.048962]  ? hub_event+0x5f5/0x13b0
[225389.048967]  ? SyS_uname+0x11/0xa0
[225389.048971]  ? process_one_work+0x1a1/0x2f0
[225389.048974]  ? worker_thread+0x26/0x3f0
[225389.048978]  ? process_one_work+0x2f0/0x2f0
[225389.048982]  ? kthread+0x109/0x120
[225389.048986]  ? kthread_create_on_node+0x60/0x60
[225389.048991]  ? ret_from_fork+0x22/0x40
[225389.048994] Code: ff ff ff 29 1a 8b c0 ff ff ff ff 50 73 8b c0 ff ff 
ff ff 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
00 00 <e0> 34 8b c0 ff ff ff ff 00 00 00 00 00 00 00 00 00 65 8b c0 ff
[225389.049043] RIP: usb_serial_exit+0x35df/0xff [usbserial] RSP: 
ffff90d3c8c27be8
[225389.049045] CR2: ffffffffc08b64e0
[225389.049048] ---[ end trace 43c4e5674b0ca81f ]---
[243028.470216] usb 7-1: new high-speed USB device number 2 using xhci_hcd
[243028.625557] usb 7-1: New USB device found, idVendor=2109, idProduct=2811
[243028.625564] usb 7-1: New USB device strings: Mfr=1, Product=2, 
SerialNumber=0
[243028.625569] usb 7-1: Product: USB2.0 Hub
[243028.625573] usb 7-1: Manufacturer: VIA Labs, Inc.
[243028.638300] hub 7-1:1.0: USB hub found
[243028.638797] hub 7-1:1.0: 4 ports detected
[243028.750421] usb 8-1: new SuperSpeed USB device number 2 using xhci_hcd
[243029.009550] usb 8-1: New USB device found, idVendor=2109, idProduct=8110
[243029.009558] usb 8-1: New USB device strings: Mfr=1, Product=2, 
SerialNumber=0
[243029.009563] usb 8-1: Product: USB3.0 Hub
[243029.009567] usb 8-1: Manufacturer: VIA Labs, Inc.
[243029.022180] hub 8-1:1.0: USB hub found
[243029.022336] hub 8-1:1.0: 4 ports detected
