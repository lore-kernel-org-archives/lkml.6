Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D56DDC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 06:07:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72E9020823
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 06:07:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K2YYHPkH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725927AbfBVGHp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 01:07:45 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36888 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725792AbfBVGHp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 01:07:45 -0500
Received: by mail-wm1-f66.google.com with SMTP id x10so835669wmg.2;
        Thu, 21 Feb 2019 22:07:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:openpgp:autocrypt:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=NXJplUERmM2wluRfGFOncUfzp8xHd0AOhNqBI2kws1g=;
        b=K2YYHPkHHcdFbgI+zi8BzGJw+2ftrvsfqDmJKcCGL+HDieL/j43Q6XXJcOBLRiRDdJ
         hV6DE92HoZdIpBY3RGtVOQkX4x7dSGed0yUVrmumTnng1Eb6uvzf9+p6h0zO0pjO5TZX
         oQiZcgp1Bsh8XDs9cMa1s2JlfSs/0Kd+a0OtwDocQ15qtTq/3+f6yN34i6j2T81YcEdI
         kgIfqETbZxyPib19V5C/bq7udZqDvS6MCofc8L0y8RBGqPyq1rLI9gxO8cc1sWce671O
         fROcMvzm6FZt/QwRavPd6JpySN9Pb4g6j7SUbwaVsxIv3/cbJOaVw9hKq7iGoyBGyy65
         O1CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:openpgp:autocrypt:message-id
         :date:user-agent:mime-version:content-language
         :content-transfer-encoding;
        bh=NXJplUERmM2wluRfGFOncUfzp8xHd0AOhNqBI2kws1g=;
        b=fZUrgvt7iw8lZkPzdru3QBGNH8SrTb5ZGK500rk7xbg8GyYSyk10BSzFNNkL2LFOag
         30O0jwCiGbaK3ZAn7mlWb+Lc/EPh91ncYPUHsHKIH+0z6F46KE5XgAIN/CYvl9V+9t0y
         pw2/ADSopIMOMA6Te3/WFKzZgvRb2dkLgYd3Y2yv9tjKCucCXGRbmlc4jF3kGUDvcX48
         nQlWPyv3ANqVAgD/aqUIdMesR/lD2DVVLWIUac/rjtohI38QQrOrxa2Vwy/4zcAdmksj
         ne//65dnbFcREX4HZjd+1gbKrOVVUp/iQqGh9OChz820TYaas7y5Z8NwENwwBt9+yGef
         vIBQ==
X-Gm-Message-State: AHQUAubYTuej564Hk/nhMb3TORst7FjMvoYq1/VU7umiobGUkLpRyIpm
        U5Hi/Xa78rs55AD8+Ht6Oub8SK4h
X-Google-Smtp-Source: AHgI3IbFzw064tNTyKbIO1Rwqyfwyk17kpxXhMbbMjz9gS5i12xWwpxZ46/g63NWHJm61uBho7hTcg==
X-Received: by 2002:a1c:d18a:: with SMTP id i132mr1221003wmg.27.1550815661282;
        Thu, 21 Feb 2019 22:07:41 -0800 (PST)
Received: from ?IPv6:2001:778:e27f:a23:36c4:e19f:3c1:8a8? (frost.nullroute.eu.org. [2001:778:e27f:a23:36c4:e19f:3c1:8a8])
        by smtp.gmail.com with ESMTPSA id e23sm185617wme.15.2019.02.21.22.07.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Feb 2019 22:07:40 -0800 (PST)
X-Mozilla-News-Host: news://news.gmane.org:119
To:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
From:   =?UTF-8?Q?Mantas_Mikul=c4=97nas?= <grawity@gmail.com>
Subject: Synaptics RMI4 - accessing /dev/v4l-touch0 breaks everything
Openpgp: preference=signencrypt
Autocrypt: addr=grawity@gmail.com; prefer-encrypt=mutual; keydata=
 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
 mpWbW251SBs=
Message-ID: <524648a9-3fb9-1423-aa1a-376289fafc5d@gmail.com>
Date:   Fri, 22 Feb 2019 08:07:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I have a laptop with a Synaptics touchpad via RMI4/i2c-hid. I noticed
that it is also exposed as a "/dev/v4l-touch0" device
(/sys/devices/rmi4-00/rmi4-00.fn54/video4linux/v4l-touch0).

Because it has "v4l" in its name, I was stupid enough to run the `mpv`
video player on it. Now I have a dmesg full of errors, and don't have a
touchpad anymore (until rebooting).

Of course, I didn't really expect it to do anything useful, but somewhat
more concerning is that I got this kind of kernel messages instead:

"BUG: unable to handle kernel NULL pointer dereference"
"kernel tried to execute NX-protected page - exploit attempt? (uid: 0)"
"BUG: unable to handle kernel paging request"
"Fixing recursive fault but reboot is needed"

The full dmesg output generated by `mpv /dev/v4l-touch0` is:

---
[   36.018308] BUG: unable to handle kernel NULL pointer dereference at
0000000000000000
[   36.018313] PGD 0 P4D 0
[   36.018316] Oops: 0010 [#1] PREEMPT SMP PTI
[   36.018318] CPU: 2 PID: 509 Comm: irq/51-i2c_hid Not tainted
4.20.11-arch1-1-ARCH #1
[   36.018319] Hardware name: Dell Inc. Inspiron 5547/06X5CY, BIOS A10
08/25/2016
[   36.018321] RIP: 0010:          (null)
[   36.018324] Code: Bad RIP value.
[   36.018325] RSP: 0000:ffffb9bd414dfe28 EFLAGS: 00010286
[   36.018327] RAX: 0000000000000000 RBX: ffffffff86421e00 RCX:
0000000000000000
[   36.018328] RDX: 0000000000000000 RSI: 0000000000000000 RDI:
0000000000000000
[   36.018329] RBP: 0000000000000000 R08: ffff9a8d56802238 R09:
ffff9a8d56802260
[   36.018330] R10: 0000000000000000 R11: ffffffff864507a8 R12:
ffff9a8d56d17c00
[   36.018331] R13: ffff9a8d56d17ce4 R14: ffff9a8d51f69ee4 R15:
ffff9a8d43edbc80
[   36.018332] FS:  0000000000000000(0000) GS:ffff9a8d57080000(0000)
knlGS:0000000000000000
[   36.018333] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   36.018334] CR2: ffffffffffffffd6 CR3: 0000000205bb8004 CR4:
00000000001606e0
[   36.018335] Call Trace:
[   36.018340]  ? handle_nested_irq+0xb3/0x110
[   36.018347]  ? rmi_process_interrupt_requests+0x7d/0x110 [rmi_core]
[   36.018349]  ? rmi_irq_fn+0x5f/0xe0 [rmi_core]
[   36.018351]  ? irq_forced_thread_fn+0x70/0x70
[   36.018353]  ? irq_thread_fn+0x1f/0x60
[   36.018354]  ? irq_thread+0xe7/0x160
[   36.018355]  ? wake_threads_waitq+0x30/0x30
[   36.018357]  ? irq_thread_dtor+0x80/0x80
[   36.018359]  ? kthread+0x112/0x130
[   36.018361]  ? kthread_park+0x80/0x80
[   36.018364]  ? ret_from_fork+0x1f/0x40
[   36.018367] Modules linked in: fuse rfcomm nft_reject_inet
nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct bnep btusb btrtl btbcm
btintel bluetooth rtsx_usb_ms nf_tables_set ecdh_generic nf_tables
joydev mousedev amdgpu arc4 hid_rmi rmi_core videobuf2_vmalloc
videobuf2_memops videobuf2_v4l2 videobuf2_common videodev
intel_spi_platform intel_spi spi_nor iTCO_wdt mtd iTCO_vendor_support
wmi_bmof dell_wmi iwlmvm sparse_keymap media mac80211
snd_hda_codec_realtek snd_hda_codec_hdmi snd_hda_codec_generic
dell_laptop intel_rapl snd_hda_intel dell_smbios x86_pkg_temp_thermal
intel_powerclamp iwlwifi coretemp snd_hda_codec dell_wmi_descriptor
kvm_intel dcdbas dell_smm_hwmon snd_hda_core intel_cstate input_leds
snd_hwdep intel_uncore snd_pcm chash amd_iommu_v2 psmouse
intel_rapl_perf cfg80211 pcspkr gpu_sched ttm snd_timer r8169 mei_me
realtek snd mei soundcore lpc_ich i2c_i801 wmi battery ac gpio_lynxpoint
i2c_hid dell_rbtn evdev rfkill mac_hid pcc_cpufreq tcp_lp cdc_acm pl2303
[   36.018393]  nf_conntrack_netlink nfnetlink nf_conntrack
nf_defrag_ipv6 nf_defrag_ipv4 libcrc32c rndis_host cdc_ether
ax88179_178a asix usbnet mii libphy tun sit tunnel4 ip_tunnel 8021q garp
mrp stp llc cifs ccm dns_resolver fscache nls_utf8 nls_iso8859_1
nls_cp437 vfat fat udf crc_itu_t isofs mspro_block ms_block memstick
mmc_block ums_cypress sr_mod cdrom uas usb_storage loop msr sg
crypto_user ip_tables x_tables ext4 crc32c_generic crc16 mbcache jbd2
fscrypto algif_skcipher af_alg rtsx_usb_sdmmc mmc_core rtsx_usb
hid_generic usbhid hid dm_crypt dm_mod sd_mod crct10dif_pclmul
crc32_pclmul crc32c_intel ghash_clmulni_intel serio_raw atkbd libps2
ahci libahci libata aesni_intel ehci_pci xhci_pci aes_x86_64 crypto_simd
cryptd glue_helper scsi_mod xhci_hcd ehci_hcd i8042 serio i915 kvmgt
vfio_mdev mdev vfio_iommu_type1 vfio kvm irqbypass intel_gtt
i2c_algo_bit drm_kms_helper syscopyarea sysfillrect sysimgblt
fb_sys_fops drm agpgart
[   36.018433] CR2: 0000000000000000
[   36.018435] ---[ end trace 5fe08f697d858ed0 ]---
[   36.018436] RIP: 0010:          (null)
[   36.018438] Code: Bad RIP value.
[   36.018439] RSP: 0000:ffffb9bd414dfe28 EFLAGS: 00010286
[   36.018441] RAX: 0000000000000000 RBX: ffffffff86421e00 RCX:
0000000000000000
[   36.018442] RDX: 0000000000000000 RSI: 0000000000000000 RDI:
0000000000000000
[   36.018443] RBP: 0000000000000000 R08: ffff9a8d56802238 R09:
ffff9a8d56802260
[   36.018444] R10: 0000000000000000 R11: ffffffff864507a8 R12:
ffff9a8d56d17c00
[   36.018445] R13: ffff9a8d56d17ce4 R14: ffff9a8d51f69ee4 R15:
ffff9a8d43edbc80
[   36.018446] FS:  0000000000000000(0000) GS:ffff9a8d57080000(0000)
knlGS:0000000000000000
[   36.018447] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   36.018448] CR2: ffffffffffffffd6 CR3: 0000000205bb8004 CR4:
00000000001606e0
[   36.018455] kernel tried to execute NX-protected page - exploit
attempt? (uid: 0)
[   36.018456] BUG: unable to handle kernel paging request at
ffff9a8d43edbc01
[   36.018457] PGD 22d801067 P4D 22d801067 PUD 22d805067 PMD 243f2d063
PTE 8000000243edb063
[   36.018459] Oops: 0011 [#2] PREEMPT SMP PTI
[   36.018461] CPU: 2 PID: 509 Comm: irq/51-i2c_hid Tainted: G      D
        4.20.11-arch1-1-ARCH #1
[   36.018462] Hardware name: Dell Inc. Inspiron 5547/06X5CY, BIOS A10
08/25/2016
[   36.018464] RIP: 0010:0xffff9a8d43edbc01
[   36.018465] Code: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 <00> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[   36.018466] RSP: 0000:ffffb9bd414dfea0 EFLAGS: 00010282
[   36.018467] RAX: ffffb9bd414dfec8 RBX: ffff9a8d43edc400 RCX:
0000000000000000
[   36.018468] RDX: ffff9a8d43edbc01 RSI: 0000000000000000 RDI:
ffffb9bd414dfec8
[   36.018469] RBP: 0000000000000000 R08: 0000000000000000 R09:
0000000000000000
[   36.018470] R10: ffffe28c8912ec00 R11: ffffffff86a50fcd R12:
ffff9a8d43edbc80
[   36.018471] R13: ffffffff86a49f10 R14: 0000000000000000 R15:
ffff9a8d43edc434
[   36.018472] FS:  0000000000000000(0000) GS:ffff9a8d57080000(0000)
knlGS:0000000000000000
[   36.018473] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   36.018474] CR2: ffff9a8d43edbc01 CR3: 0000000205bb8004 CR4:
00000000001606e0
[   36.018475] Call Trace:
[   36.018477]  ? task_work_run+0x8f/0xb0
[   36.018481]  ? do_exit+0x3a3/0xb60
[   36.018483]  ? irq_thread_dtor+0x80/0x80
[   36.018485]  ? kthread+0x112/0x130
[   36.018488]  ? rewind_stack_do_exit+0x17/0x20
[   36.018490] Modules linked in: fuse rfcomm nft_reject_inet
nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct bnep btusb btrtl btbcm
btintel bluetooth rtsx_usb_ms nf_tables_set ecdh_generic nf_tables
joydev mousedev amdgpu arc4 hid_rmi rmi_core videobuf2_vmalloc
videobuf2_memops videobuf2_v4l2 videobuf2_common videodev
intel_spi_platform intel_spi spi_nor iTCO_wdt mtd iTCO_vendor_support
wmi_bmof dell_wmi iwlmvm sparse_keymap media mac80211
snd_hda_codec_realtek snd_hda_codec_hdmi snd_hda_codec_generic
dell_laptop intel_rapl snd_hda_intel dell_smbios x86_pkg_temp_thermal
intel_powerclamp iwlwifi coretemp snd_hda_codec dell_wmi_descriptor
kvm_intel dcdbas dell_smm_hwmon snd_hda_core intel_cstate input_leds
snd_hwdep intel_uncore snd_pcm chash amd_iommu_v2 psmouse
intel_rapl_perf cfg80211 pcspkr gpu_sched ttm snd_timer r8169 mei_me
realtek snd mei soundcore lpc_ich i2c_i801 wmi battery ac gpio_lynxpoint
i2c_hid dell_rbtn evdev rfkill mac_hid pcc_cpufreq tcp_lp cdc_acm pl2303
[   36.018508]  nf_conntrack_netlink nfnetlink nf_conntrack
nf_defrag_ipv6 nf_defrag_ipv4 libcrc32c rndis_host cdc_ether
ax88179_178a asix usbnet mii libphy tun sit tunnel4 ip_tunnel 8021q garp
mrp stp llc cifs ccm dns_resolver fscache nls_utf8 nls_iso8859_1
nls_cp437 vfat fat udf crc_itu_t isofs mspro_block ms_block memstick
mmc_block ums_cypress sr_mod cdrom uas usb_storage loop msr sg
crypto_user ip_tables x_tables ext4 crc32c_generic crc16 mbcache jbd2
fscrypto algif_skcipher af_alg rtsx_usb_sdmmc mmc_core rtsx_usb
hid_generic usbhid hid dm_crypt dm_mod sd_mod crct10dif_pclmul
crc32_pclmul crc32c_intel ghash_clmulni_intel serio_raw atkbd libps2
ahci libahci libata aesni_intel ehci_pci xhci_pci aes_x86_64 crypto_simd
cryptd glue_helper scsi_mod xhci_hcd ehci_hcd i8042 serio i915 kvmgt
vfio_mdev mdev vfio_iommu_type1 vfio kvm irqbypass intel_gtt
i2c_algo_bit drm_kms_helper syscopyarea sysfillrect sysimgblt
fb_sys_fops drm agpgart
[   36.018530] CR2: ffff9a8d43edbc01
[   36.018531] ---[ end trace 5fe08f697d858ed1 ]---
[   36.018532] RIP: 0010:          (null)
[   36.018534] Code: Bad RIP value.
[   36.018535] RSP: 0000:ffffb9bd414dfe28 EFLAGS: 00010286
[   36.018536] RAX: 0000000000000000 RBX: ffffffff86421e00 RCX:
0000000000000000
[   36.018537] RDX: 0000000000000000 RSI: 0000000000000000 RDI:
0000000000000000
[   36.018538] RBP: 0000000000000000 R08: ffff9a8d56802238 R09:
ffff9a8d56802260
[   36.018539] R10: 0000000000000000 R11: ffffffff864507a8 R12:
ffff9a8d56d17c00
[   36.018540] R13: ffff9a8d56d17ce4 R14: ffff9a8d51f69ee4 R15:
ffff9a8d43edbc80
[   36.018541] FS:  0000000000000000(0000) GS:ffff9a8d57080000(0000)
knlGS:0000000000000000
[   36.018542] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   36.018543] CR2: ffffffffffffffd6 CR3: 0000000205bb8004 CR4:
00000000001606e0
[   36.018544] Fixing recursive fault but reboot is needed!
[   37.015459] rmi4_f54 rmi4-00.fn54: Timed out
[   37.042105] hid-rmi 0018:06CB:2934.0003: rmi_hid_read_block: timeout
elapsed
[   38.058792] i2c_designware INT33C3:00: controller timed out
[   38.085205] i2c_designware INT33C3:00: timeout in disabling adapter
[   38.085216] i2c_hid i2c-DLL063E:00: failed to set a report to device.
[   38.085221] hid-rmi 0018:06CB:2934.0003: failed to write hid report
(-110)
[   38.085224] hid-rmi 0018:06CB:2934.0003: failed to write request
output report (-110)
[   38.085229] rmi4_f54 rmi4-00.fn54: rmi_f54_work: read [722 bytes]
returned -110
---



-- 
Mantas Mikulėnas <grawity@gmail.com>
