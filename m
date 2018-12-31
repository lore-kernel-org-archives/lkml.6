Return-Path: <SRS0=w+lf=PI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5558EC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 13:43:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10E3A20828
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 13:43:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a+gzh/l0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726742AbeLaNnW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Dec 2018 08:43:22 -0500
Received: from mail-vs1-f65.google.com ([209.85.217.65]:35856 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726045AbeLaNnV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Dec 2018 08:43:21 -0500
Received: by mail-vs1-f65.google.com with SMTP id v205so16503347vsc.3
        for <linux-kernel@vger.kernel.org>; Mon, 31 Dec 2018 05:43:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:sender:from:date:message-id
         :subject:to:cc;
        bh=2wsx3M3+EPqRrXrwQ4vMDHCnjKlmPZYqUIr9l6q6CUI=;
        b=a+gzh/l0i+HPeNavc81HvTzrgDiU2WRDZso9DYBNl8TRTKLUP5acuf0MMWHVPNwBIR
         idNUeUpMvY+JmY6SA9E0kxOx6FJRDMTwwKGbbjtAx0ywDbDcv0vCZ9XUQ959eAlWFAbZ
         l5+lVBtiFsnmCyktnDnOnUUgeLIILwx07gkI1BXhTMT2z/L3vUXb2mVyXg7fy40LyGV0
         5KFTLaK8gT4RXULutUtkoVXhTomampcsYeM7/CD78d8O+j1j58uIdwku+XqCKsVfqX1J
         olrk+fAnzdY4dfGwMVgxWkbu0skY/eH1vNiTKmMCnqGEDJ9uk0uczJJ74xFdRYcAjYP3
         VY4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:sender:from
         :date:message-id:subject:to:cc;
        bh=2wsx3M3+EPqRrXrwQ4vMDHCnjKlmPZYqUIr9l6q6CUI=;
        b=nRw6oGVySMuWWglORZck8AZlvjPnmVG91OKE8jjt/EpBDO7AZErzd7lMICEDDXqf4P
         ZHaZEOWGqdXvkG2y4UMObrixzbn9oNHyD/lZxgWPhkmnFfIHqyl7K4eQ+At8bl8iXJDt
         1knULOu3PmuVygPlbm9VbDBA1zuP3nbFmsBbQRfk6116kfuM2Fx30hTcDemc5F7J87Bq
         Pex8MainODWSO4ag5bbFwJcHTsyFj61Q3PiUgpnNUKM3p0aSMM00vHDraY+/mDp11PHR
         ZRzxjkYCmmVTDIdj9fb7InqyfqT9Q3ZX6UPlWwV2cHJ84LICQtGbHTNvw2EtgmSqLCpS
         TSww==
X-Gm-Message-State: AA+aEWY3KnCt6il6FXnyxhthb/EfuK+U5q7NnlybN3cueWtF0UHSS/Tr
        uI5Zk24eTBn/lbe34nneNCZKl06/G/vwIADZFUU=
X-Google-Smtp-Source: AFSGD/XqCpihMQQ+8myZLEhWSASutgUpOw99UBtqaAXD1FTDOaLTQIClgGY5Mb9U4F0e7QzwvB41zvRwYSeJbztG9aI=
X-Received: by 2002:a67:ca0c:: with SMTP id z12mr15472957vsk.83.1546263799756;
 Mon, 31 Dec 2018 05:43:19 -0800 (PST)
MIME-Version: 1.0
References: <s5hk1k48ayx.wl-tiwai@suse.de> <CAHk-=wg+hjDa8UGRVnCFytjwYLPk2yDgJoKOESVSE7_6KfaeTg@mail.gmail.com>
 <20181228124303.GA16558@gmail.com> <s5hmuoplgw2.wl-tiwai@suse.de>
 <CAHk-=wjXVPpDWHzvNL=9gGVGNnYg1jOH8hQx=dq4caEzip-n0g@mail.gmail.com>
 <s5hef9zl69r.wl-tiwai@suse.de> <82bb7f60-c3c2-4715-a0a0-f1f2a8b14c74@linux.intel.com>
 <s5h1s5ykteg.wl-tiwai@suse.de>
In-Reply-To: <s5h1s5ykteg.wl-tiwai@suse.de>
X-Google-Sender-Delegation: a3at.mail@gmail.com
From:   Azat Khuzhin <dohardgopro@gmail.com>
Date:   Mon, 31 Dec 2018 16:43:08 +0300
X-Google-Sender-Auth: ASv35MBKw39v84BzDdK3zet-VEw
Message-ID: <CAAW1UO_YDtddPk7-b=c03crPAOL33YWtu_q225um_hxh4SVYtA@mail.gmail.com>
Subject: Re: [GIT PULL] sound updates for 4.21
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +/* CFL and later models, preferring ASoC when DSP is available */
> +#define IS_CFL_PLUS(pci)            \
> +       ((pci)->vendor == 0x8086 &&  \
> +        ((pci)->device == 0xa348 || \
> +         (pci)->device == 0x9dc8 || \
> +         (pci)->device == 0x34c8))
> +
>  static char *driver_short_names[] = {
>         [AZX_DRIVER_ICH] = "HDA Intel",
>         [AZX_DRIVER_PCH] = "HDA Intel PCH",
> @@ -2056,7 +2063,7 @@ static int azx_probe(struct pci_dev *pci,
>         if (pci_id->driver_data & AZX_DCAPS_INTEL_SHARED) {
>                 switch (skl_pci_binding) {
>                 case SND_SKL_PCI_BIND_AUTO:
> -                       if (pci->class != 0x040300) {
> +                       if (pci->class != 0x040300 && IS_CFL_PLUS(pci)) {
>                                 dev_info(&pci->dev, "The DSP is enabled on this platform, aborting probe\n");
>                                 return -ENODEV;
>                         }

lenovo thinkpad carbon 6th gen - no sound after this patch, and this
patch should fix sound issue for it (not tested, just checking the
condition and pci attrs)
But what interesting is that I cannot remove snd_soc_skl module
without reboot (to adjust "pci_binding=1" so make sound works),
because kernel hang after short period doing it:

# rmmod snd_soc_skl_ssp_clk
# rmmod snd_soc_skl

WARN_ON triggered on rmmod:

Dec 30 19:29:38 WARNING: CPU: 0 PID: 22941 at
sound/hda/hdac_component.c:327 snd_hdac_acomp_exit+0x69/0x90
[snd_hda_core]
Dec 30 19:29:38 Modules linked in: snd_hda_intel snd_usb_audio
snd_usbmidi_lib snd_rawmidi snd_seq_device cdc_ether usbnet r8152 mii
hid_apple hid_generic usbhid hid thunderbolt tun
bluetooth ecdh_generic nf_conntrack_netlink nfnetlink xfrm_user
xfrm_algo xt_addrtype xt_conntrack br_netfilter iptable_mangle
xt_CHECKSUM iptable_nat joydev mousedev rmi_smbus rmi_c
ore ipt_MASQUERADE nf_nat_ipv4 nf_nat nf_conntrack nf_defrag_ipv6
nf_defrag_ipv4 libcrc32c xt_tcpudp overlay bridge stp llc
iptable_filter ccm algif_aead cbc snd_soc_hdac_hdmi des_ge
neric zram arc4 lz4 lz4_compress cmac msr md4 algif_hash i915
snd_soc_dmic snd_soc_skl(-) iwlmvm snd_soc_skl_ipc snd_soc_sst_ipc
snd_soc_sst_dsp snd_hda_ext_core snd_soc_acpi_intel_m
atch snd_soc_acpi mac80211 snd_soc_core snd_compress iTCO_wdt ac97_bus
kvmgt iTCO_vendor_support intel_rapl snd_pcm_dmaengine vfio_mdev mdev
x86_pkg_temp_thermal uvcvideo intel_power
clamp coretemp vfio_iommu_type1 kvm_intel vfio snd_hda_codec
videobuf2_vmalloc i2c_algo_bit
Dec 30 19:29:38  videobuf2_memops iwlwifi videobuf2_v4l2
videobuf2_common snd_hda_core videodev drm_kms_helper tpm_crb kvm
nls_iso8859_1 snd_hwdep cfg80211 drm nls_cp437 snd_pcm irqb
ypass thinkpad_acpi intel_cstate intel_uncore nvram psmouse intel_gtt
e1000e snd_timer agpgart ledtrig_audio intel_rapl_perf syscopyarea snd
input_leds processor_thermal_device pcspk
r tpm_tis tpm_tis_core sysfillrect i2c_i801 media wmi_bmof
intel_wmi_thunderbolt tpm ucsi_acpi typec_ucsi mei_me int3403_thermal
sysimgblt rfkill mei fb_sys_fops typec intel_soc_dts_
iosf intel_pch_thermal rng_core soundcore battery ac
int340x_thermal_zone evdev mac_hid int3400_thermal acpi_thermal_rel
pcc_cpufreq vboxnetflt(OE) vboxnetadp(OE) vboxpci(OE) vboxdrv
(OE) crypto_user ip_tables x_tables ext4 crc32c_generic crc16 mbcache
jbd2 fscrypto algif_skcipher af_alg dm_crypt dm_mod crct10dif_pclmul
crc32_pclmul crc32c_intel ghash_clmulni_int
el serio_raw atkbd libps2 aesni_intel aes_x86_64 xhci_pci crypto_simd
cryptd xhci_hcd glue_helper
Dec 30 19:29:38  wmi i8042 serio vfat fat [last unloaded: snd_soc_skl_ssp_clk]
Dec 30 19:29:38 CPU: 0 PID: 22941 Comm: rmmod Tainted: G     U     OE
   4.20.0-custom-06428-g00c569b567c7 #1
Dec 30 19:29:38 Hardware name: LENOVO 20KH006MRT/20KH006MRT, BIOS
N23ET50W (1.25 ) 06/25/2018
Dec 30 19:29:38 RIP: 0010:snd_hdac_acomp_exit+0x69/0x90 [snd_hda_core]
Dec 30 19:29:38 Code: 0d 83 5f c5 48 89 ef 31 c9 31 d2 48 c7 83 a0 04
00 00 00 00 00 00 48 c7 c6 80 6b ba c0 e8 4f 35 60 c5 31 c0 5b 5d c3
31 c0 c3 <0f> 0b 48 8b 50 08 48 85 d2 74 ae
 48 8b 52 10 48 8b 38 e8 d0 a1 c5
Dec 30 19:29:38 RSP: 0018:ffffa73f42b97de8 EFLAGS: 00010202
Dec 30 19:29:38 RAX: ffff94464d71e7f8 RBX: ffff94464a22c018 RCX:
0000000000000000
Dec 30 19:29:38 RDX: 0000000000000001 RSI: 0000000000000000 RDI:
ffff94464a22c018
Dec 30 19:29:38 RBP: ffff94464fa690b0 R08: ffff944651c02480 R09:
ffff944651c024f8
Dec 30 19:29:38 R10: 0000000000000000 R11: ffffffff86e4a478 R12:
ffff94464fa690b0
Dec 30 19:29:38 R13: ffffffffc0b2e070 R14: ffff94464ffb7c60 R15:
dead000000000100
Dec 30 19:29:38 FS:  00007ffff7983b80(0000) GS:ffff944652400000(0000)
knlGS:0000000000000000
Dec 30 19:29:38 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
Dec 30 19:29:38 CR2: 0000555555784098 CR3: 0000000304682003 CR4:
00000000003606f0
Dec 30 19:29:38 Call Trace:
Dec 30 19:29:38  skl_free+0x7e/0x90 [snd_soc_skl]
Dec 30 19:29:38  skl_remove+0x9f/0xb0 [snd_soc_skl]
Dec 30 19:29:38  pci_device_remove+0x3b/0xc0
Dec 30 19:29:38  device_release_driver_internal+0x180/0x240
Dec 30 19:29:38  driver_detach+0x37/0x68
Dec 30 19:29:38  bus_remove_driver+0x74/0xc6
Dec 30 19:29:38  pci_unregister_driver+0x3d/0x90
Dec 30 19:29:38  __se_sys_delete_module+0x1a2/0x300
Dec 30 19:29:38  do_syscall_64+0x5b/0x170
Dec 30 19:29:38  entry_SYSCALL_64_after_hwframe+0x44/0xa9
Dec 30 19:29:38 RIP: 0033:0x7ffff7aa247b
Dec 30 19:29:38 Code: 73 01 c3 48 8b 0d e5 19 0c 00 f7 d8 64 89 01 48
83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa b8 b0 00 00
00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b
 0d b5 19 0c 00 f7 d8 64 89 01 48
Dec 30 19:29:38 RSP: 002b:00007fffffffe1a8 EFLAGS: 00000206 ORIG_RAX:
00000000000000b0
Dec 30 19:29:38 RAX: ffffffffffffffda RBX: 00005555557797b0 RCX:
00007ffff7aa247b
Dec 30 19:29:38 RDX: 000000000000000a RSI: 0000000000000800 RDI:
0000555555779818
Dec 30 19:29:38 RBP: 0000000000000000 R08: 00007fffffffd121 R09:
0000000000000000
Dec 30 19:29:38 R10: 00007ffff7b14ae0 R11: 0000000000000206 R12:
00007fffffffe3d0
Dec 30 19:29:38 R13: 00007fffffffe665 R14: 0000555555779260 R15:
00005555557797b0
Dec 30 19:29:38 snd_soc_skl 0000:00:1f.3: Dropping the link to 0000:00:02.0

And kernel hang I guess after:

Dec 30 19:31:33 snd_hda_intel 0000:00:1f.3: The DSP is enabled on this
platform, aborting probe
Dec 30 19:31:53 general protection fault: 0000 [#1] PREEMPT SMP NOPTI
Dec 30 19:31:53 CPU: 5 PID: 31046 Comm: chromium Tainted: G     U  W
OE     4.20.0-custom-06428-g00c569b567c7 #1
Dec 30 19:31:53 Hardware name: LENOVO 20KH006MRT/20KH006MRT, BIOS
N23ET50W (1.25 ) 06/25/2018
Dec 30 19:31:53 RIP: 0010:__kmalloc_node+0xcd/0x2b0
Dec 30 19:31:53 Code: 41 83 fd ff 74 10 48 8b 00 48 c1 e8 3b 41 39 c5
0f 85 85 00 00 00 41 8b 58 20 49 8b 38 48 8d 8a 00 02 00 00 4c 89 f0
4c 01 f3 <48> 33 1b 49 33 98 30 01 00 00 65 48 0f c7 0f 0f 94 c0 84 c0
74 8b
Dec 30 19:31:53 RSP: 0018:ffffa73f4211fcb0 EFLAGS: 00010282
Dec 30 19:31:53 RAX: c56d53959ec46bfe RBX: c56d53959ec46bfe RCX:
0000000010720205
Dec 30 19:31:53 RDX: 0000000010720005 RSI: 0000000010720005 RDI:
0000000000026160
Dec 30 19:31:53 RBP: 00000000006002c0 R08: ffff944652002f00 R09:
ffffffffc10edb4c
Dec 30 19:31:53 R10: 0000000000000000 R11: ffffffffc10ca618 R12:
0000000000000220
Dec 30 19:31:53 R13: 00000000ffffffff R14: c56d53959ec46bfe R15:
ffff944652002f00
Dec 30 19:31:53 FS:  00007fffe9d8dc80(0000) GS:ffff944652540000(0000)
knlGS:0000000000000000
Dec 30 19:31:53 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
Dec 30 19:31:53 CR2: 00007fffe1c84000 CR3: 00000004700be001 CR4:
00000000003606e0
Dec 30 19:31:53 Call Trace:
Dec 30 19:31:53  ? i915_gem_execbuffer2_ioctl+0x90/0x350 [i915]
Dec 30 19:31:53  i915_gem_execbuffer2_ioctl+0x90/0x350 [i915]
Dec 30 19:31:53  ? unix_stream_recvmsg+0x53/0x70
Dec 30 19:31:53  ? i915_gem_execbuffer_ioctl+0x2b0/0x2b0 [i915]
Dec 30 19:31:53  drm_ioctl_kernel+0xaf/0xf0 [drm]
Dec 30 19:31:53  drm_ioctl+0x32b/0x3e0 [drm]
Dec 30 19:31:53  ? i915_gem_execbuffer_ioctl+0x2b0/0x2b0 [i915]
Dec 30 19:31:53  ? vfs_writev+0xa2/0xf0
Dec 30 19:31:53  do_vfs_ioctl+0xa4/0x630
Dec 30 19:31:53  ? __sys_recvmsg+0x83/0xa0
Dec 30 19:31:53  ksys_ioctl+0x60/0x90
Dec 30 19:31:53  __x64_sys_ioctl+0x16/0x20
Dec 30 19:31:53  do_syscall_64+0x5b/0x170
Dec 30 19:31:53  entry_SYSCALL_64_after_hwframe+0x44/0xa9
Dec 30 19:31:53 RIP: 0033:0x7ffff2d3880b
Dec 30 19:31:53 Code: 0f 1e fa 48 8b 05 55 b6 0c 00 64 c7 00 26 00 00
00 48 c7 c0 ff ff ff ff c3 66 0f 1f 44 00 00 f3 0f 1e fa b8 10 00 00
00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 25 b6 0c 00 f7 d8 64 89
01 48
Dec 30 19:31:53 RSP: 002b:00007fffffffd1e8 EFLAGS: 00000246 ORIG_RAX:
0000000000000010
Dec 30 19:31:53 RAX: ffffffffffffffda RBX: 0000262a4e3f3030 RCX:
00007ffff2d3880b
Dec 30 19:31:53 RDX: 00007fffffffd230 RSI: 0000000040406469 RDI:
000000000000000e
Dec 30 19:31:53 RBP: 00007fffffffd230 R08: 0000262a4ed7e880 R09:
0000262a50407050
Dec 30 19:31:53 R10: 00007fffffffd2d0 R11: 0000000000000246 R12:
0000000040406469
Dec 30 19:31:53 R13: 000000000000000e R14: ffffffffffffffff R15:
0000000000000000

Full log starting from this moment is available here:
  https://gist.github.com/azat/8554aaefce880cc37841dd9141b00bd9

# lspci -nn -vvvvv -s 00:1f.3
00:1f.3 Audio device [0403]: Intel Corporation Sunrise Point-LP HD
Audio [8086:9d71] (rev 21) (prog-if 80)
        Subsystem: Lenovo Sunrise Point-LP HD Audio [17aa:225c]
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx+
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 64
        Interrupt: pin A routed to IRQ 143
        Region 0: Memory at 2ffb028000 (64-bit, non-prefetchable) [size=16K]
        Region 4: Memory at 2ffb000000 (64-bit, non-prefetchable) [size=64K]
        Capabilities: [50] Power Management version 3
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=55mA
PME(D0-,D1-,D2-,D3hot+,D3cold+)
                Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [60] MSI: Enable+ Count=1/1 Maskable- 64bit+
                Address: 00000000fee003d8  Data: 0000
        Kernel driver in use: snd_hda_intel
        Kernel modules: snd_hda_intel, snd_soc_skl

# lspci -m -nn -vvvvv -s 00:1f.3
Device: 00:1f.3
Class:  Audio device [0403]
Vendor: Intel Corporation [8086]
Device: Sunrise Point-LP HD Audio [9d71]
SVendor:        Lenovo [17aa]
SDevice:        Sunrise Point-LP HD Audio [225c]
Rev:    21
ProgIf: 80

# head /sys/bus/pci/devices/0000:00:1f.3/{device,class,vendor}
==> /sys/bus/pci/devices/0000:00:1f.3/device <==
0x9d71
==> /sys/bus/pci/devices/0000:00:1f.3/class <==
0x040380
==> /sys/bus/pci/devices/0000:00:1f.3/vendor <==
0x8086

# dmesg | fgrep snd
Dec 28 13:16:18 snd_hda_intel 0000:00:1f.3: The DSP is enabled on this
platform, aborting probe
Dec 28 13:16:19 snd_soc_skl 0000:00:1f.3: DSP detected with PCI
class/subclass/prog-if info 0x040380
Dec 28 13:16:19 snd_soc_skl 0000:00:1f.3: Linked as a consumer to 0000:00:02.0
Dec 28 13:16:19 snd_soc_skl 0000:00:1f.3: bound 0000:00:02.0 (ops
i915_audio_component_bind_ops [i915])

P.S. "{hostname} kernel: " stripped from the dmesg.
