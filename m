Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752587AbeESUXW (ORCPT <rfc822;w@1wt.eu>);
        Sat, 19 May 2018 16:23:22 -0400
Received: from mail-qt0-f169.google.com ([209.85.216.169]:43365 "EHLO
        mail-qt0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752532AbeESUXQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 May 2018 16:23:16 -0400
X-Google-Smtp-Source: AB8JxZqLbgwdzgQ3qWfYGh8jCaR1FOWxCTMsHXmnetjhuwyjcE7i3tHUwt2h+dJhEk3nXFrLdZUI+oEqrFqL0Nh5+2A=
MIME-Version: 1.0
From: Jeffrin Thalakkottoor <jeffrin@rajagiritech.edu.in>
Date: Sun, 20 May 2018 01:53:15 +0530
Message-ID: <CAG=yYwnNYY6YKD8wtnjQD-87N7ipSCnyXr8dzFGm4brE6-cgNw@mail.gmail.com>
Subject: PROBLEM: found 2 tests failed using "perf test" command
To: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org
Cc: lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hello,


i found two tests failed while i did "sudo ./perf test"

--------------------------------------------------------------------------->
24: Object code reading                                   : FAILED!
64: probe libc's inet_pton & backtrace it with ping       : FAILED!
---------------------------------------------------------------------------->

some relevent shell session details from ./sudo perf test -vv 24
-------------------------------------------------------------------------------------------------------->
Objdump command is: objdump -z -d --start-address=0xffffffff8132dda7
--stop-address=0xffffffff8132de27
/lib/modules/4.17.0-rc5+/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xfffffe000005e01e
thread__find_addr_map failed
test child finished with -1
---- end ----
Object code reading: FAILED!
---------------------------------------------------------------------------------------------------------->

$sudo ./perf test -vv 64
64: probe libc's inet_pton & backtrace it with ping       :
--- start ---
test child forked, pid 4751
test child finished with -1
---- end ----
probe libc's inet_pton & backtrace it with ping: FAILED!
$

----------------------------------------------------------------------------------------------------------->

 $awk -f scripts/ver_linux
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux debian 4.17.0-rc5+ #30 SMP Sat May 19 19:59:08 IST 2018 x86_64 GNU/Linux

GNU Make            4.2.1
Binutils            2.30
Util-linux          2.32
Mount                2.32
Linux C Library      2.27
Dynamic linker (ldd) 2.27
readlink: missing operand
Try 'readlink --help' for more information.
Procps              3.3.14
Kbd                  2.0.4
Console-tools        2.0.4
Sh-utils            8.28
Udev                238
Modules Loaded      ac acpi_pad acpi_thermal_rel ahci autofs4 battery
binfmt_misc bluetooth bnep btbcm btintel btrtl btusb button cdrom
cfg80211 cmac coretemp crc32c_intel crc32_pclmul crct10dif_pclmul
cryptd drm drm_kms_helper ecdh_generic efi_pstore efivarfs efivars
ehci_hcd ehci_pci evdev fan fat fuse ghash_clmulni_intel hid
hp_wireless hp_wmi i2c_algo_bit i2c_hid i2c_i801 i915 int3400_thermal
int340x_thermal_zone intel_cstate intel_pch_thermal intel_powerclamp
intel_rapl intel_rapl_perf intel_soc_dts_iosf intel_uncore ip_tables
irqbypass iTCO_vendor_support iTCO_wdt joydev kvm kvm_intel libahci
libata loop lp lpc_ich media mei mei_me mfd_core mii nls_ascii
nls_cp437 parport parport_pc pcspkr ppdev processor_thermal_device
psmouse r8169 rfcomm rfkill scsi_mod sd_mod serio_raw sg shpchp snd
snd_hda_codec snd_hda_codec_generic snd_hda_codec_hdmi
snd_hda_codec_realtek snd_hda_core snd_hda_intel snd_hwdep snd_pcm
snd_timer soundcore sparse_keymap sr_mod sunrpc thermal usbcore
uvcvideo vfat video videobuf2_common videobuf2_memops videobuf2_v4l2
videobuf2_vmalloc videodev wl wmi wmi_bmof x86_pkg_temp_thermal
xhci_hcd xhci_pci x_tables
$

-- 
software engineer
rajagiri school of engineering and technology
