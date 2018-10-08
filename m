Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49C8CC676D2
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 13:00:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9263F2084D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 13:00:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=escila-net.20150623.gappssmtp.com header.i=@escila-net.20150623.gappssmtp.com header.b="H6EDAMEj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9263F2084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=escila.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726468AbeJHULv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 16:11:51 -0400
Received: from mail-lj1-f170.google.com ([209.85.208.170]:35495 "EHLO
        mail-lj1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726177AbeJHULv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 16:11:51 -0400
Received: by mail-lj1-f170.google.com with SMTP id o14-v6so17813614ljj.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Oct 2018 06:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=escila-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=0JtetnTSi5WUwZJRoodr/SlhVUuC/JX6mTFchnMdlwo=;
        b=H6EDAMEjJ9R7oIiWFjKdklAHGSMDXZUZ0Kk3xoDzdL+meQnnhq+UYJucvGQFo4E3r6
         9BmeD1Zs/warGS39DWXO92F+SW/5q3AFCFJCbS7XjFcMEzxPmL/qzMbpsxZrKSNIVg+I
         9vOYf87EleR7wxLsMu3V6ydQzC9fd/OK22zh+GNlXZ4P35Q37aiXF3af3zjdJAgZXQsv
         LfZxXwqiAZgYobju8VM8WLILNv1hsBv0P2xcw5HSSs+3dQ9zJl1IDj3+Zb6z8QFglMT3
         nFErxY3CRqXSIcI7V3PesRbeqdApkeYiimVN/pVuZUTmJe4Xh/x9nv3yQX0xafcEyKsZ
         OG7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=0JtetnTSi5WUwZJRoodr/SlhVUuC/JX6mTFchnMdlwo=;
        b=C6LJHeH5m+xlBKyo0Vts3/7XkGILJjZWr7LCi5iZ7zGvmQQcfOwEUHq5HswJguyHKO
         mqaYxBY1Xq7463lZEBTP/uUCeVXrYxlGK8ZCj1YpRsmZWoWspsy4Fk/Azbisil63Dpq9
         KwzNJA421zRJd6bbYsPuDTxaMR6GCu1+IqCXNdPlY/PyX+CM19T6D/wmKuWcwXsqrufN
         awXXIsm4XqphSWNgy6KmvEJ8M4hG5uHoC+yMZnvwocxP9cbsRAK0462k5QjTyPLEokRT
         ZZYNrzCldyfF5ZoxOTAWkgO4IG+Syc6900tyrUC/MiqZMr3RmE+5RYHAhNp5zuZUhPTZ
         quLg==
X-Gm-Message-State: ABuFfogNURY/h+HD30S9TBlmHobRmoIEHTLyWii0A8QsovwaYyfonKZy
        RXpTK71E71K2WVxdTpCTQ1Ob9eW7ylLjMB/U6pZwr+YjzqA=
X-Google-Smtp-Source: ACcGV63/iFjphPCkI3K0qXYursQDL/yZ4gB82iqli+tDidTH2vxoqNKoXo6utiP7zLY0j5mr7X4wouqkC+YwYgse7B0=
X-Received: by 2002:a2e:8797:: with SMTP id n23-v6mr14605477lji.173.1539003609473;
 Mon, 08 Oct 2018 06:00:09 -0700 (PDT)
MIME-Version: 1.0
From:   Carles <carles@escila.net>
Date:   Mon, 8 Oct 2018 14:59:58 +0200
Message-ID: <CAMJbkpV2XShD--NyEMmd0boJU9VzRpEX79_++GrcM89nqQpKVA@mail.gmail.com>
Subject: PROBLEM: High utilisation of memory freezes the computer with an high
 use of hard disk
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[1.] One line summary of the problem:
High utilisation of memory freezes the computer completely for a long
time, with an extremely high access to the hard disk

[2.] Full description of the problem/report:
2a. While booted into the newest mainline kernel only how is the bug
reproducible?
Its possible to reproduce it with a regular use of Chromium, Firefox
and/or LibreOffice, by instance.

In a  system, when there is "little" free memory, if we open *some*
new links on new tabs on the browser, the system freezes and it's
impossible to do anything.
Also, there are some worksheets that we can open quickly and without
problems when we have a lot of free memory, but when we try to open
the same document with little free memory, the system freezes.

Then, sometimes the system becomes very very slow but we can change to
a tty and enter some commands to kill Chromium, Firefox or
LibreOffice... and the system responds again.
Sometimes, after and hour or so the system accept commands again.
Although it's also possible "recover" the system using SysRq
memory-full-oom-kill(f), but with the consequence of the crashing of
one or more applications (it doesn't have to be the one that
apparently caused the problem)

In all cases, the hard disk starts to work intensely... until the
system has returned to "normal" condition.

2b. Is this a regression?
I don't know.

[3.] Keywords (i.e., modules, networking, kernel):

[4.] Kernel version (from /proc/version):
Linux version 4.19.0-041900rc7-generic (kernel@kathleen) (gcc version
8.2.0 (Ubuntu 8.2.0-7ubuntu1)) #201810071631 SMP Sun Oct 7 16:33:10
UTC 2018

[5.] Output of Oops.. message (if applicable) with symbolic
information resolved (see Documentation/oops-tracing.txt)
N/A

[6.] A small shell script or example program which triggers the
problem (if possible)
I'm sorry, I cannot provide it.

[7.] Environment
lsb_release -rd
Description: Ubuntu 18.04.1 LTS
Release: 18.04

[7.1.] Software (add the output of the ver_linux script here)
sh ver_linux
Linux cferreru 4.19.0-041900rc7-generic #201810071631 SMP Sun Oct 7
16:33:10 UTC 2018 x86_64 x86_64 x86_64 GNU/Linux

GNU Make            4.1
Binutils            2.30
Util-linux          2.31.1
Mount                2.31.1
Module-init-tools    24
E2fsprogs            1.44.1
Pcmciautils          018
PPP                  2.4.7
Linux C Library      2.27
Dynamic linker (ldd) 2.27
Linux C++ Library    6.0.25
Procps              3.3.12
Net-tools            2.10
Kbd                  2.0.4
Console-tools        2.0.4
Sh-utils            8.28
Udev                237
Wireless-tools      30
Modules Loaded      acpi_pad aesni_intel aes_x86_64 ahci autofs4
binfmt_misc btrfs coretemp crc32_pclmul crct10dif_pclmul cryptd
crypto_simd drm drm_kms_helper e1000e fb_sys_fops ghash_clmulni_intel
glue_helper hid hid_generic hp_wmi i2c_algo_bit i915 input_leds
intel_cstate intel_pch_thermal intel_powerclamp intel_rapl
intel_rapl_perf ip_tables irqbypass kvm kvmgt kvm_intel libahci
libcrc32c lp mac_hid mdev media mei mei_me parport parport_pc pcbc
pci_stub ppdev psmouse raid6_pq sch_fq_codel serio_raw snd
snd_hda_codec snd_hda_codec_generic snd_hda_codec_hdmi
snd_hda_codec_realtek snd_hda_core snd_hda_intel snd_hwdep snd_pcm
snd_rawmidi snd_seq snd_seq_device snd_seq_dummy snd_seq_midi
snd_seq_midi_event snd_seq_oss snd_timer snd_usb_audio snd_usbmidi_lib
soundcore sparse_keymap syscopyarea sysfillrect sysimgblt tpm_infineon
uas usbhid usb_storage uvcvideo vboxdrv vboxnetadp vboxnetflt vboxpci
vfio vfio_iommu_type1 vfio_mdev video videobuf2_common
videobuf2_memops videobuf2_v4l2 videobuf2_vmalloc videodev wmi
wmi_bmof x86_pkg_temp_thermal xor x_tables zstd_compress

[7.2.] Processor information (from /proc/cpuinfo):
cat /proc/cpuinfo
processor : 0
vendor_id : GenuineIntel
cpu family : 6
model : 94
model name : Intel(R) Core(TM) i5-6500 CPU @ 3.20GHz
stepping : 3
microcode : 0xc6
cpu MHz : 857.078
cache size : 6144 KB
physical id : 0
siblings : 4
core id : 0
cpu cores : 4
apicid : 0
initial apicid : 0
fpu : yes
fpu_exception : yes
cpuid level : 22
wp : yes
flags : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx
pdpe1gb rdtscp lm constant_tsc art arch_perfmon pebs bts rep_good nopl
xtopology nonstop_tsc cpuid aperfmperf tsc_known_freq pni pclmulqdq
dtes64 monitor ds_cpl vmx smx est tm2 ssse3 sdbg fma cx16 xtpr pdcm
pcid sse4_1 sse4_2 x2apic movbe popcnt tsc_deadline_timer aes xsave
avx f16c rdrand lahf_lm abm 3dnowprefetch cpuid_fault epb
invpcid_single pti ssbd ibrs ibpb stibp tpr_shadow vnmi flexpriority
ept vpid ept_ad fsgsbase tsc_adjust bmi1 hle avx2 smep bmi2 erms
invpcid rtm mpx rdseed adx smap clflushopt intel_pt xsaveopt xsavec
xgetbv1 xsaves dtherm ida arat pln pts hwp hwp_notify hwp_act_window
hwp_epp flush_l1d
bugs : cpu_meltdown spectre_v1 spectre_v2 spec_store_bypass l1tf
bogomips : 6384.00
clflush size : 64
cache_alignment : 64
address sizes : 39 bits physical, 48 bits virtual
power management:

processor : 1
vendor_id : GenuineIntel
cpu family : 6
model : 94
model name : Intel(R) Core(TM) i5-6500 CPU @ 3.20GHz
stepping : 3
microcode : 0xc6
cpu MHz : 845.247
cache size : 6144 KB
physical id : 0
siblings : 4
core id : 1
cpu cores : 4
apicid : 2
initial apicid : 2
fpu : yes
fpu_exception : yes
cpuid level : 22
wp : yes
flags : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx
pdpe1gb rdtscp lm constant_tsc art arch_perfmon pebs bts rep_good nopl
xtopology nonstop_tsc cpuid aperfmperf tsc_known_freq pni pclmulqdq
dtes64 monitor ds_cpl vmx smx est tm2 ssse3 sdbg fma cx16 xtpr pdcm
pcid sse4_1 sse4_2 x2apic movbe popcnt tsc_deadline_timer aes xsave
avx f16c rdrand lahf_lm abm 3dnowprefetch cpuid_fault epb
invpcid_single pti ssbd ibrs ibpb stibp tpr_shadow vnmi flexpriority
ept vpid ept_ad fsgsbase tsc_adjust bmi1 hle avx2 smep bmi2 erms
invpcid rtm mpx rdseed adx smap clflushopt intel_pt xsaveopt xsavec
xgetbv1 xsaves dtherm ida arat pln pts hwp hwp_notify hwp_act_window
hwp_epp flush_l1d
bugs : cpu_meltdown spectre_v1 spectre_v2 spec_store_bypass l1tf
bogomips : 6384.00
clflush size : 64
cache_alignment : 64
address sizes : 39 bits physical, 48 bits virtual
power management:

processor : 2
vendor_id : GenuineIntel
cpu family : 6
model : 94
model name : Intel(R) Core(TM) i5-6500 CPU @ 3.20GHz
stepping : 3
microcode : 0xc6
cpu MHz : 865.511
cache size : 6144 KB
physical id : 0
siblings : 4
core id : 2
cpu cores : 4
apicid : 4
initial apicid : 4
fpu : yes
fpu_exception : yes
cpuid level : 22
wp : yes
flags : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx
pdpe1gb rdtscp lm constant_tsc art arch_perfmon pebs bts rep_good nopl
xtopology nonstop_tsc cpuid aperfmperf tsc_known_freq pni pclmulqdq
dtes64 monitor ds_cpl vmx smx est tm2 ssse3 sdbg fma cx16 xtpr pdcm
pcid sse4_1 sse4_2 x2apic movbe popcnt tsc_deadline_timer aes xsave
avx f16c rdrand lahf_lm abm 3dnowprefetch cpuid_fault epb
invpcid_single pti ssbd ibrs ibpb stibp tpr_shadow vnmi flexpriority
ept vpid ept_ad fsgsbase tsc_adjust bmi1 hle avx2 smep bmi2 erms
invpcid rtm mpx rdseed adx smap clflushopt intel_pt xsaveopt xsavec
xgetbv1 xsaves dtherm ida arat pln pts hwp hwp_notify hwp_act_window
hwp_epp flush_l1d
bugs : cpu_meltdown spectre_v1 spectre_v2 spec_store_bypass l1tf
bogomips : 6384.00
clflush size : 64
cache_alignment : 64
address sizes : 39 bits physical, 48 bits virtual
power management:

processor : 3
vendor_id : GenuineIntel
cpu family : 6
model : 94
model name : Intel(R) Core(TM) i5-6500 CPU @ 3.20GHz
stepping : 3
microcode : 0xc6
cpu MHz : 855.970
cache size : 6144 KB
physical id : 0
siblings : 4
core id : 3
cpu cores : 4
apicid : 6
initial apicid : 6
fpu : yes
fpu_exception : yes
cpuid level : 22
wp : yes
flags : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx
pdpe1gb rdtscp lm constant_tsc art arch_perfmon pebs bts rep_good nopl
xtopology nonstop_tsc cpuid aperfmperf tsc_known_freq pni pclmulqdq
dtes64 monitor ds_cpl vmx smx est tm2 ssse3 sdbg fma cx16 xtpr pdcm
pcid sse4_1 sse4_2 x2apic movbe popcnt tsc_deadline_timer aes xsave
avx f16c rdrand lahf_lm abm 3dnowprefetch cpuid_fault epb
invpcid_single pti ssbd ibrs ibpb stibp tpr_shadow vnmi flexpriority
ept vpid ept_ad fsgsbase tsc_adjust bmi1 hle avx2 smep bmi2 erms
invpcid rtm mpx rdseed adx smap clflushopt intel_pt xsaveopt xsavec
xgetbv1 xsaves dtherm ida arat pln pts hwp hwp_notify hwp_act_window
hwp_epp flush_l1d
bugs : cpu_meltdown spectre_v1 spectre_v2 spec_store_bypass l1tf
bogomips : 6384.00
clflush size : 64
cache_alignment : 64
address sizes : 39 bits physical, 48 bits virtual
power management:

[7.3.] Module information (from /proc/modules):
cat /proc/modules
uas 24576 0 - Live 0xffffffffc0a1d000
usb_storage 65536 2 uas, Live 0xffffffffc0a0c000
pci_stub 16384 1 - Live 0xffffffffc0af3000
vboxpci 24576 0 - Live 0xffffffffc0aec000 (OE)
vboxnetadp 28672 0 - Live 0xffffffffc0ae1000 (OE)
vboxnetflt 28672 1 - Live 0xffffffffc0ad9000 (OE)
vboxdrv 471040 4 vboxpci,vboxnetadp,vboxnetflt, Live 0xffffffffc0a65000 (OE)
binfmt_misc 20480 1 - Live 0xffffffffc093c000
intel_rapl 20480 0 - Live 0xffffffffc086b000
x86_pkg_temp_thermal 16384 0 - Live 0xffffffffc08d4000
snd_hda_codec_hdmi 49152 1 - Live 0xffffffffc080e000
intel_powerclamp 16384 0 - Live 0xffffffffc0809000
snd_hda_codec_realtek 106496 1 - Live 0xffffffffc0a4a000
kvm_intel 208896 0 - Live 0xffffffffc09d8000
snd_hda_codec_generic 73728 1 snd_hda_codec_realtek, Live 0xffffffffc0918000
crct10dif_pclmul 16384 0 - Live 0xffffffffc0836000
snd_hda_intel 40960 6 - Live 0xffffffffc0906000
snd_hda_codec 126976 4
snd_hda_codec_hdmi,snd_hda_codec_realtek,snd_hda_codec_generic,snd_hda_intel,
Live 0xffffffffc08d9000
crc32_pclmul 16384 0 - Live 0xffffffffc0831000
uvcvideo 102400 0 - Live 0xffffffffc08ba000
ghash_clmulni_intel 16384 0 - Live 0xffffffffc099f000
pcbc 16384 0 - Live 0xffffffffc0990000
videobuf2_vmalloc 16384 1 uvcvideo, Live 0xffffffffc0982000
videobuf2_memops 16384 1 videobuf2_vmalloc, Live 0xffffffffc098b000
snd_hda_core 81920 5
snd_hda_codec_hdmi,snd_hda_codec_realtek,snd_hda_codec_generic,snd_hda_intel,snd_hda_codec,
Live 0xffffffffc096d000
videobuf2_v4l2 24576 1 uvcvideo, Live 0xffffffffc0966000
aesni_intel 200704 0 - Live 0xffffffffc0888000
snd_seq_dummy 16384 0 - Live 0xffffffffc0883000
snd_seq_oss 36864 0 - Live 0xffffffffc0879000
videobuf2_common 45056 2 uvcvideo,videobuf2_v4l2, Live 0xffffffffc0825000
videodev 188416 3 uvcvideo,videobuf2_v4l2,videobuf2_common, Live
0xffffffffc083c000
aes_x86_64 20480 1 aesni_intel, Live 0xffffffffc07ad000
media 36864 2 uvcvideo,videodev, Live 0xffffffffc081b000
snd_usb_audio 225280 2 - Live 0xffffffffc07d1000
snd_usbmidi_lib 32768 1 snd_usb_audio, Live 0xffffffffc07c4000
snd_hwdep 20480 2 snd_hda_codec,snd_usb_audio, Live 0xffffffffc07ba000
snd_seq_midi 16384 0 - Live 0xffffffffc0787000
input_leds 16384 0 - Live 0xffffffffc077b000
snd_pcm 102400 5
snd_hda_codec_hdmi,snd_hda_intel,snd_hda_codec,snd_hda_core,snd_usb_audio,
Live 0xffffffffc0793000
snd_seq_midi_event 16384 2 snd_seq_oss,snd_seq_midi, Live 0xffffffffc0761000
crypto_simd 16384 1 aesni_intel, Live 0xffffffffc07b5000
cryptd 24576 3 ghash_clmulni_intel,aesni_intel,crypto_simd, Live
0xffffffffc078c000
glue_helper 16384 1 aesni_intel, Live 0xffffffffc075c000
snd_rawmidi 32768 2 snd_usbmidi_lib,snd_seq_midi, Live 0xffffffffc0772000
snd_seq 65536 6
snd_seq_dummy,snd_seq_oss,snd_seq_midi,snd_seq_midi_event, Live
0xffffffffc074b000
snd_seq_device 16384 4 snd_seq_oss,snd_seq_midi,snd_rawmidi,snd_seq,
Live 0xffffffffc0782000
intel_cstate 20480 0 - Live 0xffffffffc0720000
snd_timer 32768 2 snd_pcm,snd_seq, Live 0xffffffffc0769000
intel_rapl_perf 16384 0 - Live 0xffffffffc0728000
snd 81920 30 snd_hda_codec_hdmi,snd_hda_codec_realtek,snd_hda_codec_generic,snd_hda_intel,snd_hda_codec,snd_seq_oss,snd_usb_audio,snd_usbmidi_lib,snd_hwdep,snd_pcm,snd_rawmidi,snd_seq,snd_seq_device,snd_timer,
Live 0xffffffffc0736000
hp_wmi 16384 0 - Live 0xffffffffc072d000
serio_raw 16384 0 - Live 0xffffffffc06d5000
mei_me 40960 0 - Live 0xffffffffc0715000
sparse_keymap 16384 1 hp_wmi, Live 0xffffffffc0710000
soundcore 16384 1 snd, Live 0xffffffffc0708000
wmi_bmof 16384 0 - Live 0xffffffffc06d0000
mei 102400 1 mei_me, Live 0xffffffffc06b0000
intel_pch_thermal 16384 0 - Live 0xffffffffc06cb000
mac_hid 16384 0 - Live 0xffffffffc06ab000
acpi_pad 180224 0 - Live 0xffffffffc06db000
tpm_infineon 20480 0 - Live 0xffffffffc06a5000
sch_fq_codel 20480 2 - Live 0xffffffffc0689000
coretemp 16384 0 - Live 0xffffffffc0677000
parport_pc 36864 0 - Live 0xffffffffc067f000
ppdev 20480 0 - Live 0xffffffffc034f000
lp 20480 0 - Live 0xffffffffc0671000
parport 49152 3 parport_pc,ppdev,lp, Live 0xffffffffc0664000
ip_tables 24576 0 - Live 0xffffffffc0112000
x_tables 36864 1 ip_tables, Live 0xffffffffc01cc000
autofs4 40960 2 - Live 0xffffffffc0281000
btrfs 1159168 1 - Live 0xffffffffc0548000
xor 24576 1 btrfs, Live 0xffffffffc01a8000
zstd_compress 159744 1 btrfs, Live 0xffffffffc0520000
raid6_pq 114688 1 btrfs, Live 0xffffffffc0503000
libcrc32c 16384 1 btrfs, Live 0xffffffffc00fa000
hid_generic 16384 0 - Live 0xffffffffc010d000
usbhid 49152 0 - Live 0xffffffffc0157000
hid 126976 2 hid_generic,usbhid, Live 0xffffffffc032b000
i915 1757184 32 - Live 0xffffffffc0355000
kvmgt 24576 0 - Live 0xffffffffc017b000
vfio_mdev 16384 0 - Live 0xffffffffc0173000
mdev 20480 2 kvmgt,vfio_mdev, Live 0xffffffffc016d000
vfio_iommu_type1 24576 0 - Live 0xffffffffc0166000
vfio 28672 3 kvmgt,vfio_mdev,vfio_iommu_type1, Live 0xffffffffc00d0000
kvm 622592 2 kvm_intel,kvmgt, Live 0xffffffffc0292000
irqbypass 16384 1 kvm, Live 0xffffffffc00c9000
i2c_algo_bit 16384 1 i915, Live 0xffffffffc00dc000
drm_kms_helper 176128 1 i915, Live 0xffffffffc0255000
syscopyarea 16384 1 drm_kms_helper, Live 0xffffffffc01c7000
sysfillrect 16384 1 drm_kms_helper, Live 0xffffffffc01c0000
sysimgblt 16384 1 drm_kms_helper, Live 0xffffffffc01b9000
fb_sys_fops 16384 1 drm_kms_helper, Live 0xffffffffc01b4000
psmouse 151552 0 - Live 0xffffffffc0182000
drm 466944 19 i915,drm_kms_helper, Live 0xffffffffc01e2000
e1000e 249856 0 - Live 0xffffffffc0119000
ahci 40960 2 - Live 0xffffffffc00e5000
libahci 32768 1 ahci, Live 0xffffffffc00f1000
wmi 24576 2 hp_wmi,wmi_bmof, Live 0xffffffffc01d6000
video 45056 1 i915, Live 0xffffffffc0101000

[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)
cat /proc/ioports
0000-0cf7 : PCI Bus 0000:00
  0000-001f : dma1
  0020-0021 : pic1
  0040-0043 : timer0
  0050-0053 : timer1
  0060-0060 : keyboard
  0062-0062 : PNP0C09:01
    0062-0062 : EC data
  0064-0064 : keyboard
  0066-0066 : PNP0C09:01
    0066-0066 : EC cmd
  0070-0077 : rtc0
  0080-008f : dma page reg
  00a0-00a1 : pic2
  00c0-00df : dma2
  00f0-00ff : fpu
    00f0-00f0 : PNP0C04:00
  0200-023f : pnp 00:09
  03c0-03df : vesafb
  03f8-03ff : serial
  0680-069f : pnp 00:02
  0800-087f : pnp 00:03
0cf8-0cff : PCI conf1
0d00-ffff : PCI Bus 0000:00
  164e-164f : pnp 00:02
  1800-18fe : pnp 00:02
    1800-1803 : ACPI PM1a_EVT_BLK
    1804-1805 : ACPI PM1a_CNT_BLK
    1808-180b : ACPI PM_TMR
    1810-1815 : ACPI CPU throttle
    1850-1850 : ACPI PM2_CNT_BLK
    1854-1857 : pnp 00:05
    1880-189f : ACPI GPE0_BLK
  2000-20fe : pnp 00:01
  3000-303f : 0000:00:02.0
  3040-305f : 0000:00:17.0
    3040-305f : ahci
  3080-3087 : 0000:00:16.3
    3080-3087 : serial
  3088-308f : 0000:00:17.0
    3088-308f : ahci
  3090-3093 : 0000:00:17.0
    3090-3093 : ahci
  efa0-efbf : 0000:00:1f.4
  ffff-ffff : pnp 00:02
    ffff-ffff : pnp 00:02
      ffff-ffff : pnp 00:02

cat /proc/iomem
00000000-00000fff : Reserved
00001000-0009dbff : System RAM
0009dc00-0009ffff : Reserved
000a0000-000bffff : PCI Bus 0000:00
000c0000-000cfbff : Video ROM
000e0000-000fffff : Reserved
  000f0000-000fffff : System ROM
00100000-b9c56fff : System RAM
  45000000-45e031d0 : Kernel code
  45e031d1-468a0bbf : Kernel data
  46b22000-46ffffff : Kernel bss
b9c57000-b9c57fff : Reserved
b9c58000-c90fafff : System RAM
c90fb000-c9c7efff : Reserved
c9c7f000-c9e7efff : ACPI Non-volatile Storage
c9e7f000-c9efefff : ACPI Tables
c9eff000-c9efffff : System RAM
c9f00000-ce7fffff : Reserved
  cc800000-ce7fffff : Graphics Stolen Memory
ce800000-f7ffffff : PCI Bus 0000:00
  ce800000-ce81ffff : pnp 00:0a
  d0000000-dfffffff : 0000:00:02.0
  e0000000-e0ffffff : 0000:00:02.0
  e1000000-e101ffff : 0000:00:1f.6
    e1000000-e101ffff : e1000e
  e1020000-e102ffff : 0000:00:14.0
    e1020000-e102ffff : xhci-hcd
  e1030000-e103ffff : 0000:00:1f.3
    e1030000-e103ffff : ICH HD audio
  e1040000-e1043fff : 0000:00:1f.2
  e1044000-e1047fff : 0000:00:1f.3
    e1044000-e1047fff : ICH HD audio
  e1048000-e1049fff : 0000:00:17.0
    e1048000-e1049fff : ahci
  e104a000-e104afff : 0000:00:16.3
  e104b000-e104bfff : 0000:00:14.2
    e104b000-e104bfff : Intel PCH thermal driver
  e104c000-e104cfff : 0000:00:16.0
    e104c000-e104cfff : mei_me
  e104d000-e104d7ff : 0000:00:17.0
    e104d000-e104d7ff : ahci
  e104e000-e104e0ff : 0000:00:1f.4
  e104f000-e104f0ff : 0000:00:17.0
    e104f000-e104f0ff : ahci
f8000000-fbffffff : PCI MMCONFIG 0000 [bus 00-3f]
  f8000000-fbffffff : Reserved
    f8000000-fbffffff : pnp 00:0a
fd000000-fe7fffff : Reserved
  fd000000-fe7fffff : PCI Bus 0000:00
    fd000000-fdabffff : pnp 00:00
    fdad0000-fdadffff : pnp 00:00
    fdb00000-fdffffff : pnp 00:00
    fe000000-fe01ffff : pnp 00:00
    fe03d000-fe3fffff : pnp 00:00
fec00000-fec00fff : Reserved
  fec00000-fec003ff : IOAPIC 0
fed00000-fed00fff : Reserved
  fed00000-fed003ff : HPET 0
    fed00000-fed003ff : PNP0103:00
fed10000-fed19fff : Reserved
  fed10000-fed17fff : pnp 00:0a
  fed18000-fed18fff : pnp 00:0a
  fed19000-fed19fff : pnp 00:0a
fed20000-fed3ffff : pnp 00:0a
fed84000-fed84fff : Reserved
fed90000-fed90fff : dmar0
fed91000-fed91fff : dmar1
fedb0000-fedbffff : Reserved
  fedb0000-fedbffff : pnp 00:09
fee00000-fee00fff : Local APIC
  fee00000-fee00fff : Reserved
ff000000-ffffffff : INT0800:00
  ff700000-ffffffff : Reserved
100000000-12f7fffff : System RAM
12f800000-12fffffff : RAM buffer

[7.5.] PCI information ('lspci -vvv' as root)
sudo lspci -vvv
00:00.0 Host bridge: Intel Corporation Skylake Host Bridge/DRAM
Registers (rev 07)
Subsystem: Hewlett-Packard Company Xeon E3-1200 v5/E3-1500 v5/6th Gen
Core Processor Host Bridge/DRAM Registers
Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B- DisINTx-
Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort+ >SERR- <PERR- INTx-
Latency: 0
Capabilities: [e0] Vendor Specific Information: Len=10 <?>
Kernel driver in use: skl_uncore

00:02.0 VGA compatible controller: Intel Corporation HD Graphics 530
(rev 06) (prog-if 00 [VGA controller])
Subsystem: Hewlett-Packard Company HD Graphics 530
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+
Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 0
Interrupt: pin A routed to IRQ 125
Region 0: Memory at e0000000 (64-bit, non-prefetchable) [size=16M]
Region 2: Memory at d0000000 (64-bit, prefetchable) [size=256M]
Region 4: I/O ports at 3000 [size=64]
[virtual] Expansion ROM at 000c0000 [disabled] [size=128K]
Capabilities: [40] Vendor Specific Information: Len=0c <?>
Capabilities: [70] Express (v2) Root Complex Integrated Endpoint, MSI 00
DevCap: MaxPayload 128 bytes, PhantFunc 0
ExtTag- RBE+
DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
MaxPayload 128 bytes, MaxReadReq 128 bytes
DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
DevCap2: Completion Timeout: Not Supported, TimeoutDis-, LTR-, OBFF
Not Supported
DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF Disabled
Capabilities: [ac] MSI: Enable+ Count=1/1 Maskable- 64bit-
Address: fee00018  Data: 0000
Capabilities: [d0] Power Management version 2
Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
Capabilities: [100 v1] Process Address Space ID (PASID)
PASIDCap: Exec+ Priv-, Max PASID Width: 14
PASIDCtl: Enable- Exec- Priv-
Capabilities: [200 v1] Address Translation Service (ATS)
ATSCap: Invalidate Queue Depth: 00
ATSCtl: Enable-, Smallest Translation Unit: 00
Capabilities: [300 v1] Page Request Interface (PRI)
PRICtl: Enable- Reset-
PRISta: RF- UPRGI- Stopped-
Page Request Capacity: 00008000, Page Request Allocation: 00000000
Kernel driver in use: i915
Kernel modules: i915

00:14.0 USB controller: Intel Corporation Sunrise Point-H USB 3.0 xHCI
Controller (rev 31) (prog-if 30 [XHCI])
Subsystem: Hewlett-Packard Company Sunrise Point-H USB 3.0 xHCI Controller
Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B- DisINTx+
Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 0
Interrupt: pin A routed to IRQ 122
Region 0: Memory at e1020000 (64-bit, non-prefetchable) [size=64K]
Capabilities: [70] Power Management version 2
Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0-,D1-,D2-,D3hot+,D3cold+)
Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
Capabilities: [80] MSI: Enable+ Count=1/8 Maskable- 64bit+
Address: 00000000fee00238  Data: 0000
Kernel driver in use: xhci_hcd

00:14.2 Signal processing controller: Intel Corporation Sunrise
Point-H Thermal subsystem (rev 31)
Subsystem: Hewlett-Packard Company Sunrise Point-H Thermal subsystem
Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B- DisINTx-
Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 0
Interrupt: pin C routed to IRQ 18
Region 0: Memory at e104b000 (64-bit, non-prefetchable) [size=4K]
Capabilities: [50] Power Management version 3
Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
Capabilities: [80] MSI: Enable- Count=1/1 Maskable- 64bit-
Address: 00000000  Data: 0000
Kernel driver in use: intel_pch_thermal
Kernel modules: intel_pch_thermal

00:16.0 Communication controller: Intel Corporation Sunrise Point-H
CSME HECI #1 (rev 31)
Subsystem: Hewlett-Packard Company Sunrise Point-H CSME HECI
Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+
Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 0
Interrupt: pin A routed to IRQ 126
Region 0: Memory at e104c000 (64-bit, non-prefetchable) [size=4K]
Capabilities: [50] Power Management version 3
Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot+,D3cold-)
Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
Capabilities: [8c] MSI: Enable+ Count=1/1 Maskable- 64bit+
Address: 00000000fee002b8  Data: 0000
Kernel driver in use: mei_me
Kernel modules: mei_me

00:16.3 Serial controller: Intel Corporation Sunrise Point-H KT
Redirection (rev 31) (prog-if 02 [16550])
Subsystem: Hewlett-Packard Company Sunrise Point-H KT Redirection
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 0
Interrupt: pin D routed to IRQ 19
Region 0: I/O ports at 3080 [size=8]
Region 1: Memory at e104a000 (32-bit, non-prefetchable) [size=4K]
Capabilities: [40] MSI: Enable- Count=1/1 Maskable- 64bit+
Address: 0000000000000000  Data: 0000
Capabilities: [50] Power Management version 3
Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
Kernel driver in use: serial

00:17.0 SATA controller: Intel Corporation Sunrise Point-H SATA
controller [AHCI mode] (rev 31) (prog-if 01 [AHCI 1.0])
Subsystem: Hewlett-Packard Company Sunrise Point-H SATA controller [AHCI mode]
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B- DisINTx+
Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 0
Interrupt: pin A routed to IRQ 123
Region 0: Memory at e1048000 (32-bit, non-prefetchable) [size=8K]
Region 1: Memory at e104f000 (32-bit, non-prefetchable) [size=256]
Region 2: I/O ports at 3088 [size=8]
Region 3: I/O ports at 3090 [size=4]
Region 4: I/O ports at 3040 [size=32]
Region 5: Memory at e104d000 (32-bit, non-prefetchable) [size=2K]
Capabilities: [80] MSI: Enable+ Count=1/1 Maskable- 64bit-
Address: fee00258  Data: 0000
Capabilities: [70] Power Management version 3
Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot+,D3cold-)
Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
Capabilities: [a8] SATA HBA v1.0 BAR4 Offset=00000004
Kernel driver in use: ahci
Kernel modules: ahci

00:1f.0 ISA bridge: Intel Corporation Sunrise Point-H LPC Controller (rev 31)
Subsystem: Hewlett-Packard Company Sunrise Point-H LPC Controller
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B- DisINTx+
Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 0

00:1f.2 Memory controller: Intel Corporation Sunrise Point-H PMC (rev 31)
Subsystem: Hewlett-Packard Company Sunrise Point-H PMC
Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 0
Region 0: Memory at e1040000 (32-bit, non-prefetchable) [size=16K]

00:1f.3 Audio device: Intel Corporation Sunrise Point-H HD Audio (rev 31)
Subsystem: Hewlett-Packard Company Sunrise Point-H HD Audio
Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B- DisINTx+
Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 64
Interrupt: pin A routed to IRQ 127
Region 0: Memory at e1044000 (64-bit, non-prefetchable) [size=16K]
Region 4: Memory at e1030000 (64-bit, non-prefetchable) [size=64K]
Capabilities: [50] Power Management version 3
Flags: PMEClk- DSI- D1- D2- AuxCurrent=55mA PME(D0-,D1-,D2-,D3hot+,D3cold+)
Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
Capabilities: [60] MSI: Enable+ Count=1/1 Maskable- 64bit+
Address: 00000000fee002d8  Data: 0000
Kernel driver in use: snd_hda_intel
Kernel modules: snd_hda_intel

00:1f.4 SMBus: Intel Corporation Sunrise Point-H SMBus (rev 31)
Subsystem: Hewlett-Packard Company Sunrise Point-H SMBus
Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B- DisINTx-
Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Interrupt: pin A routed to IRQ 11
Region 0: Memory at e104e000 (64-bit, non-prefetchable) [size=256]
Region 4: I/O ports at efa0 [size=32]
Kernel modules: i2c_i801

00:1f.6 Ethernet controller: Intel Corporation Ethernet Connection (2)
I219-LM (rev 31)
Subsystem: Hewlett-Packard Company Ethernet Connection (2) I219-LM
Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B- DisINTx+
Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 0
Interrupt: pin A routed to IRQ 124
Region 0: Memory at e1000000 (32-bit, non-prefetchable) [size=128K]
Capabilities: [c8] Power Management version 3
Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=1 PME-
Capabilities: [d0] MSI: Enable+ Count=1/1 Maskable- 64bit+
Address: 00000000fee00278  Data: 0000
Capabilities: [e0] PCI Advanced Features
AFCap: TP+ FLR+
AFCtrl: FLR-
AFStatus: TP-
Kernel driver in use: e1000e
Kernel modules: e1000e

[7.6.] SCSI information (from /proc/scsi/scsi)
cat /proc/scsi/scsi
Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: ATA      Model: ST500DM002-1BD14 Rev: HP74
  Type:   Direct-Access                    ANSI  SCSI revision: 05
Host: scsi1 Channel: 00 Id: 00 Lun: 00
  Vendor: hp       Model: DVDRW  DU8A6SH   Rev: DHS3
  Type:   CD-ROM                           ANSI  SCSI revision: 05
Host: scsi6 Channel: 00 Id: 00 Lun: 00
  Vendor: SanDisk  Model: Ultra Fit        Rev: 1.00
  Type:   Direct-Access                    ANSI  SCSI revision: 06

[7.7.] Other information that might be relevant to the problem (please
look in /proc and include all information that you think to be
relevant):
ls /proc
1      11969  15    2     260  290   4483  4808  4883  5136  5250
5389  5999  842        devices      mdstat         tty
10     11993  1514  200   261  291   45    4811  49    5140  5251
5392  6     847        diskstats    meminfo        uptime
1017   11994  1516  201   262  2971  4533  4813  4918  5142  5252
5408  6230  849        dma          misc           version
1022   11995  1517  202   263  3     4534  4816  4944  5152  5255
5438  6489  854        driver       modules        vmallocinfo
103    12     1518  203   264  30    4536  4826  4948  5156  526
5448  6521  860        execdomains  mounts         vmstat
1038   12009  1550  204   265  31    46    4827  4949  5168  5260
5457  6656  862        fb           mtrr           zoneinfo
104    12010  16    207   266  33    4704  4833  4962  5169  5261
5471  6658  863        filesystems  net
10443  12044  17    208   267  337   4705  4837  4966  5176  5265  56
  6660  866        fs           pagetypeinfo
105    1234   18    209   268  34    4730  4838  4968  5180  528
5622  695   8743       interrupts   partitions
106    1270   1856  21    269  3490  4737  4840  4973  5189  529
5626  696   9          iomem        sched_debug
1061   13     1857  210   27   35    4746  4843  4977  5200  53
5634  8     921        ioports      schedstat
107    13010  1859  215   270  36    4747  4844  50    5204  5300
5638  8227  945        irq          scsi
108    13017  19    2178  271  37    4758  4845  5065  5213  5305
5651  8228  9781       kallsyms     self
1089   1305   191   2179  272  38    4760  4849  5067  5214  5306
5690  8230  acpi       kcore        slabinfo
109    134    192   22    273  39    4762  4852  5072  5215  5307  57
  828   asound     keys         softirqs
11     1345   193   23    274  4     4770  4853  5074  5217  5308
5780  830   buddyinfo  key-users    stat
1127   1346   194   24    275  40    4777  4856  5087  5219  5311  58
  835   bus        kmsg         swaps
11284  1357   195   2494  276  41    4784  4857  5092  5223  5334
5800  836   cgroups    kpagecgroup  sys
11285  1363   196   25    277  42    4789  4862  51    5232  5346
5802  838   cmdline    kpagecount   sysrq-trigger
1152   1438   197   257   28   43    4791  4863  5109  5236  5350
5851  839   consoles   kpageflags   sysvipc
1185   1442   198   258   282  434   4795  4870  5118  5239  5372
5855  840   cpuinfo    loadavg      thread-self
119    1448   199   259   29   44    48    4873  5132  5249  5375
5957  841   crypto     locks        timer_list

[X.] Other notes, patches, fixes, workarounds:
Launchpad bug report:
https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1794763
