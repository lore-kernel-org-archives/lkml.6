Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 026E3C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 17:32:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2A3B21928
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 17:32:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DxdtWkDy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395095AbfBNRcV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 12:32:21 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:44309 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389941AbfBNRcV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 12:32:21 -0500
Received: by mail-lj1-f195.google.com with SMTP id q128so5940893ljb.11;
        Thu, 14 Feb 2019 09:32:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=92geEDTfwbVF9etEit3JK7B4R1n8pLeOOqnhLFkO7pw=;
        b=DxdtWkDyGEFPeGB0xPzyVR73tIymrkJ7Q2PsqqYBlKjg+7p5bT3XC+u7ptmNQlHmUu
         jJyMmPkx3MMfgw2z+NwYAypRDdXm51QjOCUeJQU2Ymcqw/kw7ktzqSd6Kwyj21sXuc/a
         SYLAeISuO58Tot34Lcmcuy28tTRrSItGJvVvloBw3lpS88X0aS7doALMg9ImNMEA7N1G
         bOyHqu67hEBIeGALeOmyOjO4jFSTQQGeGO82na4ZOkIindEUhTk0/v6CUmKph1Ia8KxB
         w6DyB4Et1eddkcdlaakCIvqiBV4CFeG8e7QUD42xOx+vrsXnemHPtMMd0+/wTicBrb47
         NzFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=92geEDTfwbVF9etEit3JK7B4R1n8pLeOOqnhLFkO7pw=;
        b=Z0Q0qL1POSDfcpc4lGAh9evzZfdLbTyZMn2frX0bzccwFp1Qo+oZPV9YNCYKusz4H/
         TocfRNbgURghvO9DPSELn+XUawoebIDrVbfCWA5aGDG/6nHVaJK3fBxTslH0mOWzBPpq
         6nOH7nJEHPdipG/J5IAGKjUJttATrUS1kxUr+okCKivVvW48NBVsLTTB1j9yttTuyXtt
         htbMxRPsOyvwfMjG8hcO0OXedWQqZMa2lL0D0e6VfK4jT3LPms5V/iW5bL440jwby2mS
         4OSdH1XAdSKXg4OWry5AvIHO3uCK5ujELQvDJSJxd/TFURXjAb+DFiBqJqbDDJFr6QuN
         vKVQ==
X-Gm-Message-State: AHQUAuZXr1bORcI4ycYXlzbrFnOAlBiO6TSiwjm1OAOM/GapRYI5g3FQ
        fGESkiY1naC4LnjW1j9MHrmTnTp5mB8=
X-Google-Smtp-Source: AHgI3IYVx7Ba0qol2R/VXDWF2UeREoeituafB03dWhHn3akevtM8OfqXoQWk5WUDeiJJOh0JWMaqJQ==
X-Received: by 2002:a2e:63cd:: with SMTP id s74-v6mr3027499lje.117.1550165537658;
        Thu, 14 Feb 2019 09:32:17 -0800 (PST)
Received: from im-mac (pool-109-191-226-91.is74.ru. [109.191.226.91])
        by smtp.gmail.com with ESMTPSA id y12sm578759lfh.32.2019.02.14.09.32.16
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 14 Feb 2019 09:32:17 -0800 (PST)
Message-ID: <6c4003a4ec2a32f662fd68cc8a6d4cc80acde5c6.camel@gmail.com>
Subject: Re: [RFC PATCH 0/2] Fix for the internal card reader and suspend on
 MacBooks
From:   Ivan Mironov <mironov.ivan@gmail.com>
To:     linux-usb@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Martin Liu <liumartin@google.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Jon Flatley <jflat@chromium.org>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Benson Leung <bleung@chromium.org>,
        Harry Pan <harry.pan@intel.com>,
        Jack Stocker <jackstocker.93@gmail.com>,
        Danilo Krummrich <danilokrummrich@dk-develop.de>,
        Samuel Sadok <samuel.sadok@bluewin.ch>
Date:   Thu, 14 Feb 2019 22:32:15 +0500
In-Reply-To: <9a13a073edd1c24636284377132bfcda8bfa945d.camel@gmail.com>
References: <20190213211323.6072-1-mironov.ivan@gmail.com>
         <9a13a073edd1c24636284377132bfcda8bfa945d.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-02-14 at 06:40 +0500, Ivan Mironov wrote:
> Unfortunately, everything broke again after yet another suspend/resume.
> Currently I'm suspecting that my patch maybe only helps to survive the
> short suspend, but not the long one.
>=20
> After this bad suspend/resume, card reader disappeared again. Debug
> logging was not enabled this time, so not too many information in the
> dmesg:
>=20
> [44013.429613] usb 2-4: Disable of device-initiated U1 failed.
> [44018.549809] usb 2-4: Disable of device-initiated U2 failed.
> [44024.182043] xhci_hcd 0000:00:14.0: Timeout while waiting for setup dev=
ice command
> [44029.814239] xhci_hcd 0000:00:14.0: Timeout while waiting for setup dev=
ice command
> [44030.022207] usb 2-4: device not accepting address 2, error -62
> [44035.446526] xhci_hcd 0000:00:14.0: Timeout while waiting for setup dev=
ice command
> [44041.078732] xhci_hcd 0000:00:14.0: Timeout while waiting for setup dev=
ice command
> [44041.286640] usb 2-4: device not accepting address 2, error -62
> [44046.710928] xhci_hcd 0000:00:14.0: Timeout while waiting for setup dev=
ice command
> [44052.343184] xhci_hcd 0000:00:14.0: Timeout while waiting for setup dev=
ice command
> [44052.551120] usb 2-4: device not accepting address 2, error -62
> [44057.975369] xhci_hcd 0000:00:14.0: Timeout while waiting for setup dev=
ice command
> [44063.607605] xhci_hcd 0000:00:14.0: Timeout while waiting for setup dev=
ice command
> [44063.815538] usb 2-4: device not accepting address 2, error -62
> [44063.882505] PM: resume devices took 55.895 seconds
> [44063.882508] ------------[ cut here ]------------
> [44063.882511] Component: resume devices, time: 55895
> [44063.882530] WARNING: CPU: 1 PID: 10887 at kernel/power/suspend_test.c:=
55 suspend_test_finish+0x6b/0x70
> [44063.882531] Modules linked in: vfat fat rfcomm fuse xt_CHECKSUM ipt_MA=
SQUERADE tun bridge stp llc devlink nf_conntrack_netbios_ns nf_conntrack_br=
oadcast xt_CT ip6t_rpfilter ip6t_REJECT nf_reject_ipv6 xt_conntrack ebtable=
_nat ip6table_nat nf_nat_ipv6 ip6table_mangle ip6table_raw ip6table_securit=
y iptable_nat nf_nat_ipv4 nf_nat iptable_mangle iptable_raw iptable_securit=
y nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 ip_set nfnetlink ebtable_filte=
r ebtables ip6table_filter ip6_tables cmac bnep sunrpc nls_utf8 hfsplus joy=
dev iTCO_wdt iTCO_vendor_support intel_rapl x86_pkg_temp_thermal btusb inte=
l_powerclamp applesmc btrtl input_polldev brcmfmac btbcm coretemp btintel b=
luetooth kvm_intel brcmutil snd_hda_codec_cirrus snd_hda_codec_generic snd_=
hda_codec_hdmi intel_cstate snd_hda_intel intel_uncore cfg80211 snd_hda_cod=
ec ecdh_generic intel_rapl_perf snd_hda_core snd_hwdep bcm5974 snd_seq snd_=
seq_device snd_pcm mmc_core rfkill thunderbolt snd_timer snd mei_me mei sou=
ndcore i2c_i801 intel_pch_thermal
> [44063.882614]  lpc_ich sbs acpi_als kfifo_buf sbshc industrialio apple_g=
mux pcc_cpufreq apple_bl binfmt_misc xfs libcrc32c dm_crypt i915 kvmgt mdev=
 vfio kvm irqbypass i2c_algo_bit drm_kms_helper crct10dif_pclmul crc32_pclm=
ul crc32c_intel drm uas ghash_clmulni_intel usb_storage video hid_apple
> [44063.882648] CPU: 1 PID: 10887 Comm: systemd-sleep Not tainted 4.20.7-2=
00.ivan3.fc29.x86_64 #1
> [44063.882651] Hardware name: Apple Inc. MacBookPro11,4/Mac-06F11FD93F032=
3C5, BIOS MBP114.88Z.0184.B00.1806051659 06/05/2018
> [44063.882656] RIP: 0010:suspend_test_finish+0x6b/0x70
> [44063.882660] Code: 06 69 c2 e8 03 00 00 29 c1 e8 df a3 00 00 81 fd 10 2=
7 00 00 77 03 5b 5d c3 89 ea 48 89 de 48 c7 c7 e9 bb 0c b3 e8 1f 56 fa ff <=
0f> 0b eb e8 90 0f 1f 44 00 00 0f b6 05 49 e5 88 01 c3 0f 1f 00 0f
> [44063.882663] RSP: 0000:ffffbad682b0fd30 EFLAGS: 00010286
> [44063.882666] RAX: 0000000000000000 RBX: ffffffffb30cb9c2 RCX: 000000000=
0000006
> [44063.882669] RDX: 0000000000000007 RSI: 0000000000000082 RDI: ffff8f70a=
f0568c0
> [44063.882671] RBP: 000000000000da57 R08: 0000000000000002 R09: 000000000=
00207c0
> [44063.882674] R10: 0000002394f2f376 R11: 000000000001cd94 R12: 000000000=
0000000
> [44063.882676] R13: ffffffffb3254210 R14: 0000000000000000 R15: ffffbad68=
2b0fd60
> [44063.882681] FS:  00007fd487426940(0000) GS:ffff8f70af040000(0000) knlG=
S:0000000000000000
> [44063.882683] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [44063.882686] CR2: 0000000000000000 CR3: 00000003fcc92002 CR4: 000000000=
01606e0
> [44063.882688] Call Trace:
> [44063.882699]  suspend_devices_and_enter+0x248/0x7f0
> [44063.882706]  pm_suspend.cold.5+0x33c/0x392
> [44063.882711]  state_store+0x80/0xe0
> [44063.882718]  kernfs_fop_write+0x116/0x190
> [44063.882728]  __vfs_write+0x36/0x1a0
> [44063.882736]  ? selinux_file_permission+0xf0/0x130
> [44063.882745]  ? security_file_permission+0x2c/0xb0
> [44063.882751]  vfs_write+0xa5/0x1a0
> [44063.882758]  ksys_write+0x4f/0xb0
> [44063.882767]  do_syscall_64+0x5b/0x160
> [44063.882776]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [44063.882781] RIP: 0033:0x7fd48816dff8
> [44063.882785] Code: 89 02 48 c7 c0 ff ff ff ff eb b3 0f 1f 80 00 00 00 0=
0 f3 0f 1e fa 48 8d 05 25 77 0d 00 8b 00 85 c0 75 17 b8 01 00 00 00 0f 05 <=
48> 3d 00 f0 ff ff 77 58 c3 0f 1f 80 00 00 00 00 41 54 49 89 d4 55
> [44063.882788] RSP: 002b:00007fff49106d48 EFLAGS: 00000246 ORIG_RAX: 0000=
000000000001
> [44063.882792] RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 00007fd48=
816dff8
> [44063.882794] RDX: 0000000000000004 RSI: 000055a1d121afe0 RDI: 000000000=
0000004
> [44063.882796] RBP: 000055a1d121afe0 R08: 000055a1d1219390 R09: 00007fd48=
7426940
> [44063.882799] R10: 000000000000000a R11: 0000000000000246 R12: 000055a1d=
12192b0
> [44063.882801] R13: 0000000000000004 R14: 00007fd48823c740 R15: 000000000=
0000004
> [44063.882805] ---[ end trace d28e1c30545cf612 ]---
> [44063.883214] OOM killer enabled.
> [44063.883216] Restarting tasks ...=20
> [44063.883683] usb 2-4: USB disconnect, device number 2
> [44063.895454] done.
>=20
> Then I tried to suspend/resume again, just to check what will happen. Sus=
pend succeed,
> but card reader did not reappear. Then I tried to unbind xhci_hcd driver =
and bind it
> again (to "reset" the host controller) and the whole USB support died com=
pletely:
>=20
> [44171.570065] xhci_hcd 0000:00:14.0: USB bus 2 deregistered
> [44171.570292] xhci_hcd 0000:00:14.0: remove, state 1
> [44171.570305] usb usb1: USB disconnect, device number 1
> [44171.570309] usb 1-8: USB disconnect, device number 2
> [44171.624668] usb 1-12: USB disconnect, device number 3
> [44171.665118] bcm5974 1-12:1.2: could not read from device
> [44171.674339] xhci_hcd 0000:00:14.0: USB bus 1 deregistered
> [44174.677453] xhci_hcd 0000:00:14.0: xHCI Host Controller
> [44174.678738] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bu=
s number 1
> [44174.679880] xhci_hcd 0000:00:14.0: hcc params 0x200077c1 hci version 0=
x100 quirks 0x0000000000009810
> [44174.679892] xhci_hcd 0000:00:14.0: cache line size of 256 is not suppo=
rted
> [44174.680861] usb usb1: New USB device found, idVendor=3D1d6b, idProduct=
=3D0002, bcdDevice=3D 4.20
> [44174.680867] usb usb1: New USB device strings: Mfr=3D3, Product=3D2, Se=
rialNumber=3D1
> [44174.680871] usb usb1: Product: xHCI Host Controller
> [44174.680875] usb usb1: Manufacturer: Linux 4.20.7-200.ivan3.fc29.x86_64=
 xhci-hcd
> [44174.680879] usb usb1: SerialNumber: 0000:00:14.0
> [44174.681804] hub 1-0:1.0: USB hub found
> [44174.681884] hub 1-0:1.0: 14 ports detected
> [44174.683892] xhci_hcd 0000:00:14.0: xHCI Host Controller
> [44174.684421] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bu=
s number 2
> [44174.684434] xhci_hcd 0000:00:14.0: Host supports USB 3.0  SuperSpeed
> [44174.684643] usb usb2: New USB device found, idVendor=3D1d6b, idProduct=
=3D0003, bcdDevice=3D 4.20
> [44174.684652] usb usb2: New USB device strings: Mfr=3D3, Product=3D2, Se=
rialNumber=3D1
> [44174.684657] usb usb2: Product: xHCI Host Controller
> [44174.684663] usb usb2: Manufacturer: Linux 4.20.7-200.ivan3.fc29.x86_64=
 xhci-hcd
> [44174.684669] usb usb2: SerialNumber: 0000:00:14.0
> [44174.685224] hub 2-0:1.0: USB hub found
> [44174.685244] hub 2-0:1.0: 6 ports detected
> [44175.003318] usb 1-8: new full-speed USB device number 2 using xhci_hcd
> [44175.132257] usb 1-8: New USB device found, idVendor=3D05ac, idProduct=
=3D8290, bcdDevice=3D 1.61
> [44175.132265] usb 1-8: New USB device strings: Mfr=3D1, Product=3D2, Ser=
ialNumber=3D0
> [44175.132269] usb 1-8: Product: Bluetooth USB Host Controller
> [44175.132273] usb 1-8: Manufacturer: Broadcom Corp.
> [44175.139274] input: Broadcom Corp. Bluetooth USB Host Controller as /de=
vices/pci0000:00/0000:00:14.0/usb1/1-8/1-8:1.0/0003:05AC:8290.0007/input/in=
put17
> [44175.192287] hid-generic 0003:05AC:8290.0007: input,hidraw0: USB HID v1=
.11 Keyboard [Broadcom Corp. Bluetooth USB Host Controller] on usb-0000:00:=
14.0-8/input0
> [44175.193365] input: Broadcom Corp. Bluetooth USB Host Controller as /de=
vices/pci0000:00/0000:00:14.0/usb1/1-8/1-8:1.1/0003:05AC:8290.0008/input/in=
put18
> [44175.194093] hid-generic 0003:05AC:8290.0008: input,hidraw1: USB HID v1=
.11 Mouse [Broadcom Corp. Bluetooth USB Host Controller] on usb-0000:00:14.=
0-8/input1
> [44175.306721] Bluetooth: hci0: BCM: chip id 102 build 0715
> [44175.307686] Bluetooth: hci0: BCM: product 05ac:8290
> [44175.308676] Bluetooth: hci0: BCM: features 0x2f
> [44175.324659] Bluetooth: hci0: im-mac
> [44180.370567] xhci_hcd 0000:00:14.0: Timeout while waiting for setup dev=
ice command
> [44186.001831] xhci_hcd 0000:00:14.0: Timeout while waiting for setup dev=
ice command
> [44186.209761] usb 2-4: device not accepting address 2, error -62
> [44186.345774] usb 1-12: new full-speed USB device number 3 using xhci_hc=
d
> [44186.474418] usb 1-12: New USB device found, idVendor=3D05ac, idProduct=
=3D0274, bcdDevice=3D 6.24
> [44186.474426] usb 1-12: New USB device strings: Mfr=3D1, Product=3D2, Se=
rialNumber=3D3
> [44186.474431] usb 1-12: Product: Apple Internal Keyboard / Trackpad
> [44186.474435] usb 1-12: Manufacturer: Apple Inc.
> [44186.474440] usb 1-12: SerialNumber: D3H61830CG1FTV4A16PF
> [44186.480463] apple 0003:05AC:0274.0009: hiddev96,hidraw2: USB HID v1.10=
 Device [Apple Inc. Apple Internal Keyboard / Trackpad] on usb-0000:00:14.0=
-12/input0
> [44186.481998] input: Apple Inc. Apple Internal Keyboard / Trackpad as /d=
evices/pci0000:00/0000:00:14.0/usb1/1-12/1-12:1.1/0003:05AC:0274.000A/input=
/input19
> [44186.534551] apple 0003:05AC:0274.000A: input,hiddev97,hidraw3: USB HID=
 v1.10 Keyboard [Apple Inc. Apple Internal Keyboard / Trackpad] on usb-0000=
:00:14.0-12/input1
> [44186.535255] input: bcm5974 as /devices/pci0000:00/0000:00:14.0/usb1/1-=
12/1-12:1.2/input/input20
> [44186.536753] apple 0003:05AC:0274.000B: hiddev98,hidraw4: USB HID v1.10=
 Device [Apple Inc. Apple Internal Keyboard / Trackpad] on usb-0000:00:14.0=
-12/input3
> [44186.538025] apple 0003:05AC:0274.000C: hiddev99,hidraw5: USB HID v1.10=
 Device [Apple Inc. Apple Internal Keyboard / Trackpad] on usb-0000:00:14.0=
-12/input4
> [44192.145867] xhci_hcd 0000:00:14.0: xHCI host not responding to stop en=
dpoint command.
> [44192.145882] xhci_hcd 0000:00:14.0: xHCI host controller not responding=
, assume dead
> [44192.145948] xhci_hcd 0000:00:14.0: Timeout while waiting for configure=
 endpoint command
> [44192.145955] xhci_hcd 0000:00:14.0: Timeout while waiting for setup dev=
ice command
> [44192.145960] usb 1-8: Not enough bandwidth for altsetting 0
> [44192.145966] Bluetooth: hci0: setting interface failed (62)
> [44192.145979] Bluetooth: hci0: urb 00000000a285970d failed to resubmit (=
22)
> [44192.145988] Bluetooth: hci0: urb 00000000e0abf065 failed to resubmit (=
22)
> [44192.145993] Bluetooth: hci0: urb 00000000cf6ab8ae failed to resubmit (=
22)
> [44192.146009] xhci_hcd 0000:00:14.0: HC died; cleaning up
> [44192.146267] usb 1-8: USB disconnect, device number 2
> [44192.201413] usb 1-12: USB disconnect, device number 3
> [44192.251930] bcm5974 1-12:1.2: could not read from device
> [44192.561908] usb 2-4: device not accepting address 3, error -108
> [44192.561958] usb usb2-port4: attempt power cycle
> [44192.873872] usb usb2-port4: couldn't allocate usb_device
>=20
> Full dmesg is here: https://raw.githubusercontent.com/im-0/investigate-ca=
rd-reader-suspend-problem-on-mbp11.4/master/test-16/dmesg
>=20
> Any ideas on how to proceed with this?
>=20
> P.S. I'll try to reproduce this again with debug enabled.
>=20

It seems that I was wrong and long suspend was not the cause of that
failure. I tried to reproduce it again, and after 4 successful
suspend/resume cycles, with last suspend lasted for ~10 hour, and
everything was fine. No suspend failures, card reader is there and
functioning.

Complete dmesg: https://raw.githubusercontent.com/im-0/investigate-card-rea=
der-suspend-problem-on-mbp11.4/master/test-17/dmesg

Maybe I forgot to add some wait somewhere in the code for something?

