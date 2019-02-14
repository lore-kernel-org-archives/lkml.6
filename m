Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59BFDC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 01:40:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07B8621904
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 01:40:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MHVghEDC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391175AbfBNBk4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 20:40:56 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:35599 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390921AbfBNBk4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 20:40:56 -0500
Received: by mail-lf1-f67.google.com with SMTP id v7so3335898lfd.2;
        Wed, 13 Feb 2019 17:40:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=9L1R7tq+jbBDdpCCVIX8DPerDZM/zz6S65VW2whbTlY=;
        b=MHVghEDCjgWr9YiND8WyVHyNa3/GZcn6A2w0vrgPjeUHxu5jq0lCwpiQfmmW9HJT3g
         9FGST9d7yraJDt1FrRUqfJbnZEg+s40fw/20AHPOeLIhcNuFrEDtBVg5R8H+M9UEUDEo
         6V2DAk4i+9XPqi3ElEQU1uYI1Hd1N77GMsoGsC4p8PiOVgReD7Xqox8DaLp2TonFJ751
         xL6DI/7nj2Q3+d5MfPEaxDBS/mYfKDSu5pMcFsDAOlqVIWF1qc/fZOW1W25a49RM116y
         JlJ2u4uCC3hG2ZzSIbg8MFrIqJThgyNvnnWQtKMJOpcQlvfU6NIsycN79ALgcD4IwNxu
         Vd/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=9L1R7tq+jbBDdpCCVIX8DPerDZM/zz6S65VW2whbTlY=;
        b=hIFFhLP4nBbUwd2csy1dRrEnmAp2MJide21/018QP4G1Dt3yJwrAOy1ro11rU8uY4J
         9op1gUQj9/IoSqnZIS71EeCs2ZcYbwVb1mMMEeM6j/fc0DTyRE4lNpWY11+JUcRgNHKn
         L8LUG+WyqsKDw1hHrfHkuS38FOx+m+spiidlI0BO4716X7XZ4it5TuvP8dgxpHzQd1E9
         J83ccEjK9wiF7H2Z4vwOljSaSCgFQm/BfzmIysxK6i7jTSXCeHNWCpKfs1RkdMMgdCtg
         n5WhRPycfMGwgL8y+xGthA2FlV+eKf1g4VNYVOPgDEaNQjq9AuWzedwNdLUoH4AAOjUQ
         ukag==
X-Gm-Message-State: AHQUAub1qt4G1d/Dfnn/UkgK7ttnbUxGF3w2VmbMC65Z9tI70dRZcqUj
        62zS3gGD30JPhVI915pC7dnMfPtyH/s=
X-Google-Smtp-Source: AHgI3IY9NbxFTCR8kY3kF2dHmvIQ2RsuTG231BvTkFxMHwCJILe9QBn3dZLgqAXDvTyqCxJTzy0nIQ==
X-Received: by 2002:a19:105:: with SMTP id 5mr615792lfb.163.1550108452831;
        Wed, 13 Feb 2019 17:40:52 -0800 (PST)
Received: from im-mac (pool-109-191-226-91.is74.ru. [109.191.226.91])
        by smtp.gmail.com with ESMTPSA id k15sm161885ljc.39.2019.02.13.17.40.51
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 13 Feb 2019 17:40:52 -0800 (PST)
Message-ID: <9a13a073edd1c24636284377132bfcda8bfa945d.camel@gmail.com>
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
Date:   Thu, 14 Feb 2019 06:40:50 +0500
In-Reply-To: <20190213211323.6072-1-mironov.ivan@gmail.com>
References: <20190213211323.6072-1-mironov.ivan@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Unfortunately, everything broke again after yet another suspend/resume.
Currently I'm suspecting that my patch maybe only helps to survive the
short suspend, but not the long one.

After this bad suspend/resume, card reader disappeared again. Debug
logging was not enabled this time, so not too many information in the
dmesg:

[44013.429613] usb 2-4: Disable of device-initiated U1 failed.
[44018.549809] usb 2-4: Disable of device-initiated U2 failed.
[44024.182043] xhci_hcd 0000:00:14.0: Timeout while waiting for setup devic=
e command
[44029.814239] xhci_hcd 0000:00:14.0: Timeout while waiting for setup devic=
e command
[44030.022207] usb 2-4: device not accepting address 2, error -62
[44035.446526] xhci_hcd 0000:00:14.0: Timeout while waiting for setup devic=
e command
[44041.078732] xhci_hcd 0000:00:14.0: Timeout while waiting for setup devic=
e command
[44041.286640] usb 2-4: device not accepting address 2, error -62
[44046.710928] xhci_hcd 0000:00:14.0: Timeout while waiting for setup devic=
e command
[44052.343184] xhci_hcd 0000:00:14.0: Timeout while waiting for setup devic=
e command
[44052.551120] usb 2-4: device not accepting address 2, error -62
[44057.975369] xhci_hcd 0000:00:14.0: Timeout while waiting for setup devic=
e command
[44063.607605] xhci_hcd 0000:00:14.0: Timeout while waiting for setup devic=
e command
[44063.815538] usb 2-4: device not accepting address 2, error -62
[44063.882505] PM: resume devices took 55.895 seconds
[44063.882508] ------------[ cut here ]------------
[44063.882511] Component: resume devices, time: 55895
[44063.882530] WARNING: CPU: 1 PID: 10887 at kernel/power/suspend_test.c:55=
 suspend_test_finish+0x6b/0x70
[44063.882531] Modules linked in: vfat fat rfcomm fuse xt_CHECKSUM ipt_MASQ=
UERADE tun bridge stp llc devlink nf_conntrack_netbios_ns nf_conntrack_broa=
dcast xt_CT ip6t_rpfilter ip6t_REJECT nf_reject_ipv6 xt_conntrack ebtable_n=
at ip6table_nat nf_nat_ipv6 ip6table_mangle ip6table_raw ip6table_security =
iptable_nat nf_nat_ipv4 nf_nat iptable_mangle iptable_raw iptable_security =
nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 ip_set nfnetlink ebtable_filter =
ebtables ip6table_filter ip6_tables cmac bnep sunrpc nls_utf8 hfsplus joyde=
v iTCO_wdt iTCO_vendor_support intel_rapl x86_pkg_temp_thermal btusb intel_=
powerclamp applesmc btrtl input_polldev brcmfmac btbcm coretemp btintel blu=
etooth kvm_intel brcmutil snd_hda_codec_cirrus snd_hda_codec_generic snd_hd=
a_codec_hdmi intel_cstate snd_hda_intel intel_uncore cfg80211 snd_hda_codec=
 ecdh_generic intel_rapl_perf snd_hda_core snd_hwdep bcm5974 snd_seq snd_se=
q_device snd_pcm mmc_core rfkill thunderbolt snd_timer snd mei_me mei sound=
core i2c_i801 intel_pch_thermal
[44063.882614]  lpc_ich sbs acpi_als kfifo_buf sbshc industrialio apple_gmu=
x pcc_cpufreq apple_bl binfmt_misc xfs libcrc32c dm_crypt i915 kvmgt mdev v=
fio kvm irqbypass i2c_algo_bit drm_kms_helper crct10dif_pclmul crc32_pclmul=
 crc32c_intel drm uas ghash_clmulni_intel usb_storage video hid_apple
[44063.882648] CPU: 1 PID: 10887 Comm: systemd-sleep Not tainted 4.20.7-200=
.ivan3.fc29.x86_64 #1
[44063.882651] Hardware name: Apple Inc. MacBookPro11,4/Mac-06F11FD93F0323C=
5, BIOS MBP114.88Z.0184.B00.1806051659 06/05/2018
[44063.882656] RIP: 0010:suspend_test_finish+0x6b/0x70
[44063.882660] Code: 06 69 c2 e8 03 00 00 29 c1 e8 df a3 00 00 81 fd 10 27 =
00 00 77 03 5b 5d c3 89 ea 48 89 de 48 c7 c7 e9 bb 0c b3 e8 1f 56 fa ff <0f=
> 0b eb e8 90 0f 1f 44 00 00 0f b6 05 49 e5 88 01 c3 0f 1f 00 0f
[44063.882663] RSP: 0000:ffffbad682b0fd30 EFLAGS: 00010286
[44063.882666] RAX: 0000000000000000 RBX: ffffffffb30cb9c2 RCX: 00000000000=
00006
[44063.882669] RDX: 0000000000000007 RSI: 0000000000000082 RDI: ffff8f70af0=
568c0
[44063.882671] RBP: 000000000000da57 R08: 0000000000000002 R09: 00000000000=
207c0
[44063.882674] R10: 0000002394f2f376 R11: 000000000001cd94 R12: 00000000000=
00000
[44063.882676] R13: ffffffffb3254210 R14: 0000000000000000 R15: ffffbad682b=
0fd60
[44063.882681] FS:  00007fd487426940(0000) GS:ffff8f70af040000(0000) knlGS:=
0000000000000000
[44063.882683] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[44063.882686] CR2: 0000000000000000 CR3: 00000003fcc92002 CR4: 00000000001=
606e0
[44063.882688] Call Trace:
[44063.882699]  suspend_devices_and_enter+0x248/0x7f0
[44063.882706]  pm_suspend.cold.5+0x33c/0x392
[44063.882711]  state_store+0x80/0xe0
[44063.882718]  kernfs_fop_write+0x116/0x190
[44063.882728]  __vfs_write+0x36/0x1a0
[44063.882736]  ? selinux_file_permission+0xf0/0x130
[44063.882745]  ? security_file_permission+0x2c/0xb0
[44063.882751]  vfs_write+0xa5/0x1a0
[44063.882758]  ksys_write+0x4f/0xb0
[44063.882767]  do_syscall_64+0x5b/0x160
[44063.882776]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[44063.882781] RIP: 0033:0x7fd48816dff8
[44063.882785] Code: 89 02 48 c7 c0 ff ff ff ff eb b3 0f 1f 80 00 00 00 00 =
f3 0f 1e fa 48 8d 05 25 77 0d 00 8b 00 85 c0 75 17 b8 01 00 00 00 0f 05 <48=
> 3d 00 f0 ff ff 77 58 c3 0f 1f 80 00 00 00 00 41 54 49 89 d4 55
[44063.882788] RSP: 002b:00007fff49106d48 EFLAGS: 00000246 ORIG_RAX: 000000=
0000000001
[44063.882792] RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 00007fd4881=
6dff8
[44063.882794] RDX: 0000000000000004 RSI: 000055a1d121afe0 RDI: 00000000000=
00004
[44063.882796] RBP: 000055a1d121afe0 R08: 000055a1d1219390 R09: 00007fd4874=
26940
[44063.882799] R10: 000000000000000a R11: 0000000000000246 R12: 000055a1d12=
192b0
[44063.882801] R13: 0000000000000004 R14: 00007fd48823c740 R15: 00000000000=
00004
[44063.882805] ---[ end trace d28e1c30545cf612 ]---
[44063.883214] OOM killer enabled.
[44063.883216] Restarting tasks ...=20
[44063.883683] usb 2-4: USB disconnect, device number 2
[44063.895454] done.

Then I tried to suspend/resume again, just to check what will happen. Suspe=
nd succeed,
but card reader did not reappear. Then I tried to unbind xhci_hcd driver an=
d bind it
again (to "reset" the host controller) and the whole USB support died compl=
etely:

[44171.570065] xhci_hcd 0000:00:14.0: USB bus 2 deregistered
[44171.570292] xhci_hcd 0000:00:14.0: remove, state 1
[44171.570305] usb usb1: USB disconnect, device number 1
[44171.570309] usb 1-8: USB disconnect, device number 2
[44171.624668] usb 1-12: USB disconnect, device number 3
[44171.665118] bcm5974 1-12:1.2: could not read from device
[44171.674339] xhci_hcd 0000:00:14.0: USB bus 1 deregistered
[44174.677453] xhci_hcd 0000:00:14.0: xHCI Host Controller
[44174.678738] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus =
number 1
[44174.679880] xhci_hcd 0000:00:14.0: hcc params 0x200077c1 hci version 0x1=
00 quirks 0x0000000000009810
[44174.679892] xhci_hcd 0000:00:14.0: cache line size of 256 is not support=
ed
[44174.680861] usb usb1: New USB device found, idVendor=3D1d6b, idProduct=
=3D0002, bcdDevice=3D 4.20
[44174.680867] usb usb1: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[44174.680871] usb usb1: Product: xHCI Host Controller
[44174.680875] usb usb1: Manufacturer: Linux 4.20.7-200.ivan3.fc29.x86_64 x=
hci-hcd
[44174.680879] usb usb1: SerialNumber: 0000:00:14.0
[44174.681804] hub 1-0:1.0: USB hub found
[44174.681884] hub 1-0:1.0: 14 ports detected
[44174.683892] xhci_hcd 0000:00:14.0: xHCI Host Controller
[44174.684421] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus =
number 2
[44174.684434] xhci_hcd 0000:00:14.0: Host supports USB 3.0  SuperSpeed
[44174.684643] usb usb2: New USB device found, idVendor=3D1d6b, idProduct=
=3D0003, bcdDevice=3D 4.20
[44174.684652] usb usb2: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[44174.684657] usb usb2: Product: xHCI Host Controller
[44174.684663] usb usb2: Manufacturer: Linux 4.20.7-200.ivan3.fc29.x86_64 x=
hci-hcd
[44174.684669] usb usb2: SerialNumber: 0000:00:14.0
[44174.685224] hub 2-0:1.0: USB hub found
[44174.685244] hub 2-0:1.0: 6 ports detected
[44175.003318] usb 1-8: new full-speed USB device number 2 using xhci_hcd
[44175.132257] usb 1-8: New USB device found, idVendor=3D05ac, idProduct=3D=
8290, bcdDevice=3D 1.61
[44175.132265] usb 1-8: New USB device strings: Mfr=3D1, Product=3D2, Seria=
lNumber=3D0
[44175.132269] usb 1-8: Product: Bluetooth USB Host Controller
[44175.132273] usb 1-8: Manufacturer: Broadcom Corp.
[44175.139274] input: Broadcom Corp. Bluetooth USB Host Controller as /devi=
ces/pci0000:00/0000:00:14.0/usb1/1-8/1-8:1.0/0003:05AC:8290.0007/input/inpu=
t17
[44175.192287] hid-generic 0003:05AC:8290.0007: input,hidraw0: USB HID v1.1=
1 Keyboard [Broadcom Corp. Bluetooth USB Host Controller] on usb-0000:00:14=
.0-8/input0
[44175.193365] input: Broadcom Corp. Bluetooth USB Host Controller as /devi=
ces/pci0000:00/0000:00:14.0/usb1/1-8/1-8:1.1/0003:05AC:8290.0008/input/inpu=
t18
[44175.194093] hid-generic 0003:05AC:8290.0008: input,hidraw1: USB HID v1.1=
1 Mouse [Broadcom Corp. Bluetooth USB Host Controller] on usb-0000:00:14.0-=
8/input1
[44175.306721] Bluetooth: hci0: BCM: chip id 102 build 0715
[44175.307686] Bluetooth: hci0: BCM: product 05ac:8290
[44175.308676] Bluetooth: hci0: BCM: features 0x2f
[44175.324659] Bluetooth: hci0: im-mac
[44180.370567] xhci_hcd 0000:00:14.0: Timeout while waiting for setup devic=
e command
[44186.001831] xhci_hcd 0000:00:14.0: Timeout while waiting for setup devic=
e command
[44186.209761] usb 2-4: device not accepting address 2, error -62
[44186.345774] usb 1-12: new full-speed USB device number 3 using xhci_hcd
[44186.474418] usb 1-12: New USB device found, idVendor=3D05ac, idProduct=
=3D0274, bcdDevice=3D 6.24
[44186.474426] usb 1-12: New USB device strings: Mfr=3D1, Product=3D2, Seri=
alNumber=3D3
[44186.474431] usb 1-12: Product: Apple Internal Keyboard / Trackpad
[44186.474435] usb 1-12: Manufacturer: Apple Inc.
[44186.474440] usb 1-12: SerialNumber: D3H61830CG1FTV4A16PF
[44186.480463] apple 0003:05AC:0274.0009: hiddev96,hidraw2: USB HID v1.10 D=
evice [Apple Inc. Apple Internal Keyboard / Trackpad] on usb-0000:00:14.0-1=
2/input0
[44186.481998] input: Apple Inc. Apple Internal Keyboard / Trackpad as /dev=
ices/pci0000:00/0000:00:14.0/usb1/1-12/1-12:1.1/0003:05AC:0274.000A/input/i=
nput19
[44186.534551] apple 0003:05AC:0274.000A: input,hiddev97,hidraw3: USB HID v=
1.10 Keyboard [Apple Inc. Apple Internal Keyboard / Trackpad] on usb-0000:0=
0:14.0-12/input1
[44186.535255] input: bcm5974 as /devices/pci0000:00/0000:00:14.0/usb1/1-12=
/1-12:1.2/input/input20
[44186.536753] apple 0003:05AC:0274.000B: hiddev98,hidraw4: USB HID v1.10 D=
evice [Apple Inc. Apple Internal Keyboard / Trackpad] on usb-0000:00:14.0-1=
2/input3
[44186.538025] apple 0003:05AC:0274.000C: hiddev99,hidraw5: USB HID v1.10 D=
evice [Apple Inc. Apple Internal Keyboard / Trackpad] on usb-0000:00:14.0-1=
2/input4
[44192.145867] xhci_hcd 0000:00:14.0: xHCI host not responding to stop endp=
oint command.
[44192.145882] xhci_hcd 0000:00:14.0: xHCI host controller not responding, =
assume dead
[44192.145948] xhci_hcd 0000:00:14.0: Timeout while waiting for configure e=
ndpoint command
[44192.145955] xhci_hcd 0000:00:14.0: Timeout while waiting for setup devic=
e command
[44192.145960] usb 1-8: Not enough bandwidth for altsetting 0
[44192.145966] Bluetooth: hci0: setting interface failed (62)
[44192.145979] Bluetooth: hci0: urb 00000000a285970d failed to resubmit (22=
)
[44192.145988] Bluetooth: hci0: urb 00000000e0abf065 failed to resubmit (22=
)
[44192.145993] Bluetooth: hci0: urb 00000000cf6ab8ae failed to resubmit (22=
)
[44192.146009] xhci_hcd 0000:00:14.0: HC died; cleaning up
[44192.146267] usb 1-8: USB disconnect, device number 2
[44192.201413] usb 1-12: USB disconnect, device number 3
[44192.251930] bcm5974 1-12:1.2: could not read from device
[44192.561908] usb 2-4: device not accepting address 3, error -108
[44192.561958] usb usb2-port4: attempt power cycle
[44192.873872] usb usb2-port4: couldn't allocate usb_device

Full dmesg is here: https://raw.githubusercontent.com/im-0/investigate-card=
-reader-suspend-problem-on-mbp11.4/master/test-16/dmesg

Any ideas on how to proceed with this?

P.S. I'll try to reproduce this again with debug enabled.

