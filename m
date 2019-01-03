Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 718C4C43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 11:44:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A3B821479
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 11:44:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kolivas-org.20150623.gappssmtp.com header.i=@kolivas-org.20150623.gappssmtp.com header.b="wWVdcngG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730610AbfACLoI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 06:44:08 -0500
Received: from mail-io1-f42.google.com ([209.85.166.42]:44959 "EHLO
        mail-io1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726392AbfACLoH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 06:44:07 -0500
Received: by mail-io1-f42.google.com with SMTP id r200so26757645iod.11
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jan 2019 03:44:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kolivas-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=xIff08wlaLYDRo7LOlvaDurB8j/WvdwaKmvEtnyUSUs=;
        b=wWVdcngGPFjnx/Z0iw4J+nVNLb0oeijtBi1gO3QYDS7H9Fq1t2+Yz9HmOFHe4/gV4z
         dT4nDnwt2UqvD7zkKLxY1/wqZ/Pxw8A/6MLSSH4iQz18l6zTNwXU8LhbDpO3wv3fGIX0
         scEfwJga1AIJNlCc3ylY/QYgkTs9TLNlPzERXuQO0xSy88xdYLZaFSD5asYdLGjxCprb
         ww9bxbLVj6BnNbMAqirjHzR1Kj6cjzFpz/t3te2a+oAXOriBt1esOfFcEQlgPhbPWLhn
         smpyqIdehMZfHVtdJJMnLwTveYWtpb4WMSUDxwCM7CHa2UrX0pVEoRigXm7xehXMZutT
         Jz9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=xIff08wlaLYDRo7LOlvaDurB8j/WvdwaKmvEtnyUSUs=;
        b=VP6HU/M0WThspMqWbvukFITe1iygNwkKsSmGmP2S9N5zoZmPB/4se+BTvNRusyrXiC
         UmXMlpXyCS7PbuXBl80CoBwax/trAuPA9uOn1lQpn5MfQCdyI+cTgbnkL537eFEsmpU6
         BUdt5M0vQvd5r3S5bz8qwnSWt2+rLasWKGIT/jcGxPVOirCsA3TPplVSdeN6tUecC9v7
         yxZw4lZOlF4JESXWERk6kYiYWOnOlyG9CmiSFpJDvN3GOTcauC6McyH3CrTzJtjywZX/
         IxtH6uQ4xMFFROf+tE64X1Q1NSN2E807iCFEX0nOfJvbrP5MBAod1hJP79zCXFwViBeH
         yh3g==
X-Gm-Message-State: AJcUuke06ybls8NhBsV0BAEM+P8JM0K65v5Z1UJJ/lVeYlr+INXeZihD
        yoXHh0sXmvqXmyhIUeIym/Kuk7XZ3qqWc/OA/TyrSOGb
X-Google-Smtp-Source: ALg8bN5SAa1QJEqUml7w8Q4TxcJ1UMXrWQV3ABMMf5JoNVyA5LGhC8r2/Gs6OKeKCm5jX+e6RYCxUH9gXRjh7tczhH4=
X-Received: by 2002:a5d:94c7:: with SMTP id y7mr11711318ior.285.1546515845618;
 Thu, 03 Jan 2019 03:44:05 -0800 (PST)
MIME-Version: 1.0
From:   Con Kolivas <kernel@kolivas.org>
Date:   Thu, 3 Jan 2019 22:43:54 +1100
Message-ID: <CABqErrECNH+gRiZXM+z=igjAw895e7KLeV6H0EKvMkW0UsVvJw@mail.gmail.com>
Subject: ALSA:usb audio Higher sample rates on usb audio no longer working.
To:     linux-kernel <linux-kernel@vger.kernel.org>,
        Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Upon switching from 4.19.0 to 4.20.0, pulseaudio started complaining
that sinks that previously worked are no longer supported.

On 4.19.0 trying 24 bit 88200, 176400, and 192000 I get the following
output from pulse.
resampler.c: Forcing resampler 'copy', because of fixed, identical
sample rates.sink-input.c: Created input 15 "Playback Stream" on
alsa_output.usb-DSPeaker_Anti-Mode_X4-00.iec958-stereo with sample
spec float32le 2ch 176400Hz and channel map front-left,front-right

Switching to 4.20 gives me:
alsa-sink.c: Sink does not support sample rate of 176400 Hz
and
alsa-sink.c: Sink does not support sample rate of 88200 Hz
and
alsa-sink.c: Sink does not support sample rate of 192000 Hz

Sample rates of 44100, 48000, and 96000 work fine, but 88200, 176400,
and 192000 no longer work

Switching back to 4.19 immediately fixes the issue.


I tried looking through the alsa changelogs but there were too many to
give an obvious culprit, and haven't had time to do a git bisect. If
there's an obvious choice patch to back out I'd be grateful for the
heads up.

Regards,
Con


Output from 4.19 dmesg grep snd:
[    4.941164] snd_hda_intel 0000:02:00.1: Disabling MSI
[    4.957534] snd_hda_codec_realtek hdaudioC0D0: autoconfig for
ALC892: line_outs=4 (0x14/0x15/0x16/0x17/0x0) type:line
[    4.957536] snd_hda_codec_realtek hdaudioC0D0:    speaker_outs=0
(0x0/0x0/0x0/0x0/0x0)
[    4.957537] snd_hda_codec_realtek hdaudioC0D0:    hp_outs=1
(0x1b/0x0/0x0/0x0/0x0)
[    4.957538] snd_hda_codec_realtek hdaudioC0D0:    mono: mono_out=0x0
[    4.957538] snd_hda_codec_realtek hdaudioC0D0:    dig-out=0x11/0x1e
[    4.957539] snd_hda_codec_realtek hdaudioC0D0:    inputs:
[    4.957540] snd_hda_codec_realtek hdaudioC0D0:      Front Mic=0x19
[    4.957541] snd_hda_codec_realtek hdaudioC0D0:      Rear Mic=0x18
[    4.957542] snd_hda_codec_realtek hdaudioC0D0:      Line=0x1a
[    6.215818] usbcore: registered new interface driver snd-usb-audio

Output from 4.20 dmesg grep snd (identical):
[    4.960455] snd_hda_intel 0000:02:00.1: Disabling MSI
[    4.986848] snd_hda_codec_realtek hdaudioC0D0: autoconfig for
ALC892: line_outs=4 (0x14/0x15/0x16/0x17/0x0) type:line
[    4.986850] snd_hda_codec_realtek hdaudioC0D0:    speaker_outs=0
(0x0/0x0/0x0/0x0/0x0)
[    4.986852] snd_hda_codec_realtek hdaudioC0D0:    hp_outs=1
(0x1b/0x0/0x0/0x0/0x0)
[    4.986853] snd_hda_codec_realtek hdaudioC0D0:    mono: mono_out=0x0
[    4.986854] snd_hda_codec_realtek hdaudioC0D0:    dig-out=0x11/0x1e
[    4.986855] snd_hda_codec_realtek hdaudioC0D0:    inputs:
[    4.986856] snd_hda_codec_realtek hdaudioC0D0:      Front Mic=0x19
[    4.986857] snd_hda_codec_realtek hdaudioC0D0:      Rear Mic=0x18
[    4.986858] snd_hda_codec_realtek hdaudioC0D0:      Line=0x1a
[    6.211079] usbcore: registered new interface driver snd-usb-audio

Output from usb connected audio device 4.19:
[  998.567015] usb 2-1.8.4: new high-speed USB device number 19 using ehci-pci
[  998.682497] usb 2-1.8.4: New USB device found, idVendor=19fb,
idProduct=2040, bcdDevice= 2.00
[  998.682502] usb 2-1.8.4: New USB device strings: Mfr=1, Product=2,
SerialNumber=0
[  998.682505] usb 2-1.8.4: Product: Anti-Mode X4
[  998.682507] usb 2-1.8.4: Manufacturer: DSPeaker

4.20 (identical):
[   98.428175] usb 2-1.8.4: new high-speed USB device number 19 using ehci-pci
[   98.543175] usb 2-1.8.4: New USB device found, idVendor=19fb,
idProduct=2040, bcdDevice= 2.00
[   98.543177] usb 2-1.8.4: New USB device strings: Mfr=1, Product=2,
SerialNumber=0
[   98.543178] usb 2-1.8.4: Product: Anti-Mode X4
[   98.543179] usb 2-1.8.4: Manufacturer: DSPeaker

lspci output:
00:00.0 Host bridge: Intel Corporation Xeon E7 v2/Xeon E5 v2/Core i7
DMI2 (rev 04)
00:01.0 PCI bridge: Intel Corporation Xeon E7 v2/Xeon E5 v2/Core i7
PCI Express Root Port 1a (rev 04)
00:02.0 PCI bridge: Intel Corporation Xeon E7 v2/Xeon E5 v2/Core i7
PCI Express Root Port 2a (rev 04)
00:03.0 PCI bridge: Intel Corporation Xeon E7 v2/Xeon E5 v2/Core i7
PCI Express Root Port 3a (rev 04)
00:05.0 System peripheral: Intel Corporation Xeon E7 v2/Xeon E5
v2/Core i7 VTd/Memory Map/Misc (rev 04)
00:05.2 System peripheral: Intel Corporation Xeon E7 v2/Xeon E5
v2/Core i7 IIO RAS (rev 04)
00:05.4 PIC: Intel Corporation Xeon E7 v2/Xeon E5 v2/Core i7 IOAPIC (rev 04)
00:11.0 PCI bridge: Intel Corporation C600/X79 series chipset PCI
Express Virtual Root Port (rev 06)
00:16.0 Communication controller: Intel Corporation C600/X79 series
chipset MEI Controller #1 (rev 05)
00:1a.0 USB controller: Intel Corporation C600/X79 series chipset USB2
Enhanced Host Controller #2 (rev 06)
00:1b.0 Audio device: Intel Corporation C600/X79 series chipset High
Definition Audio Controller (rev 06)
00:1c.0 PCI bridge: Intel Corporation C600/X79 series chipset PCI
Express Root Port 1 (rev b6)
00:1c.2 PCI bridge: Intel Corporation C600/X79 series chipset PCI
Express Root Port 3 (rev b6)
00:1c.3 PCI bridge: Intel Corporation C600/X79 series chipset PCI
Express Root Port 4 (rev b6)
00:1c.4 PCI bridge: Intel Corporation C600/X79 series chipset PCI
Express Root Port 5 (rev b6)
00:1c.5 PCI bridge: Intel Corporation C600/X79 series chipset PCI
Express Root Port 6 (rev b6)
00:1d.0 USB controller: Intel Corporation C600/X79 series chipset USB2
Enhanced Host Controller #1 (rev 06)
00:1e.0 PCI bridge: Intel Corporation 82801 PCI Bridge (rev a6)
00:1f.0 ISA bridge: Intel Corporation C600/X79 series chipset LPC
Controller (rev 06)
00:1f.2 SATA controller: Intel Corporation C600/X79 series chipset
6-Port SATA AHCI Controller (rev 06)
00:1f.3 SMBus: Intel Corporation C600/X79 series chipset SMBus Host
Controller (rev 06)
02:00.0 VGA compatible controller: NVIDIA Corporation GP106 [GeForce
GTX 1060 3GB] (rev a1)
02:00.1 Audio device: NVIDIA Corporation GP106 High Definition Audio
Controller (rev a1)
06:00.0 USB controller: ASMedia Technology Inc. ASM1042A USB 3.0 Host Controller
07:00.0 USB controller: ASMedia Technology Inc. ASM1042A USB 3.0 Host Controller
08:00.0 SATA controller: ASMedia Technology Inc. ASM1062 Serial ATA
Controller (rev 01)
09:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd.
RTL8111/8168/8411 PCI Express Gigabit Ethernet Controller (rev 09)
ff:08.0 System peripheral: Intel Corporation Xeon E7 v2/Xeon E5
v2/Core i7 QPI Link 0 (rev 04)
ff:09.0 System peripheral: Intel Corporation Xeon E7 v2/Xeon E5
v2/Core i7 QPI Link 1 (rev 04)
ff:0a.0 System peripheral: Intel Corporation Xeon E7 v2/Xeon E5
v2/Core i7 Power Control Unit 0 (rev 04)
ff:0a.1 System peripheral: Intel Corporation Xeon E7 v2/Xeon E5
v2/Core i7 Power Control Unit 1 (rev 04)
ff:0a.2 System peripheral: Intel Corporation Xeon E7 v2/Xeon E5
v2/Core i7 Power Control Unit 2 (rev 04)
ff:0a.3 System peripheral: Intel Corporation Xeon E7 v2/Xeon E5
v2/Core i7 Power Control Unit 3 (rev 04)
ff:0b.0 System peripheral: Intel Corporation Xeon E7 v2/Xeon E5
v2/Core i7 UBOX Registers (rev 04)
ff:0b.3 System peripheral: Intel Corporation Xeon E7 v2/Xeon E5
v2/Core i7 UBOX Registers (rev 04)
ff:0c.0 System peripheral: Intel Corporation Xeon E7 v2/Xeon E5
v2/Core i7 Unicast Registers (rev 04)
ff:0c.1 System peripheral: Intel Corporation Xeon E7 v2/Xeon E5
v2/Core i7 Unicast Registers (rev 04)
ff:0c.2 System peripheral: Intel Corporation Xeon E7 v2/Xeon E5
v2/Core i7 Unicast Registers (rev 04)
ff:0d.0 System peripheral: Intel Corporation Xeon E7 v2/Xeon E5
v2/Core i7 Unicast Registers (rev 04)
ff:0d.1 System peripheral: Intel Corporation Xeon E7 v2/Xeon E5
v2/Core i7 Unicast Registers (rev 04)
ff:0d.2 System peripheral: Intel Corporation Xeon E7 v2/Xeon E5
v2/Core i7 Unicast Registers (rev 04)
ff:0e.0 System peripheral: Intel Corporation Xeon E7 v2/Xeon E5
v2/Core i7 Home Agent 0 (rev 04)
ff:0e.1 Performance counters: Intel Corporation Xeon E7 v2/Xeon E5
v2/Core i7 Home Agent 0 (rev 04)
ff:0f.0 System peripheral: Intel Corporation Xeon E7 v2/Xeon E5
v2/Core i7 Integrated Memory Controller 0 Target Address/Thermal
Registers (rev 04)
ff:0f.1 System peripheral: Intel Corporation Xeon E7 v2/Xeon E5
v2/Core i7 Integrated Memory Controller 0 RAS Registers (rev 04)
ff:0f.2 System peripheral: Intel Corporation Xeon E7 v2/Xeon E5
v2/Core i7 Integrated Memory Controller 0 Channel Target Address
Decoder Registers (rev 04)
ff:0f.3 System peripheral: Intel Corporation Xeon E7 v2/Xeon E5
v2/Core i7 Integrated Memory Controller 0 Channel Target Address
Decoder Registers (rev 04)
ff:0f.4 System peripheral: Intel Corporation Xeon E7 v2/Xeon E5
v2/Core i7 Integrated Memory Controller 0 Channel Target Address
Decoder Registers (rev 04)
ff:0f.5 System peripheral: Intel Corporation Xeon E7 v2/Xeon E5
v2/Core i7 Integrated Memory Controller 0 Channel Target Address
Decoder Registers (rev 04)
ff:10.0 System peripheral: Intel Corporation Xeon E7 v2/Xeon E5
v2/Core i7 Integrated Memory Controller 1 Channel 0-3 Thermal Control
0 (rev 04)
ff:10.1 System peripheral: Intel Corporation Xeon E7 v2/Xeon E5
v2/Core i7 Integrated Memory Controller 1 Channel 0-3 Thermal Control
1 (rev 04)
ff:10.2 System peripheral: Intel Corporation Xeon E7 v2/Xeon E5
v2/Core i7 Integrated Memory Controller 1 Channel 0-3 ERROR Registers
0 (rev 04)
ff:10.3 System peripheral: Intel Corporation Xeon E7 v2/Xeon E5
v2/Core i7 Integrated Memory Controller 1 Channel 0-3 ERROR Registers
1 (rev 04)
ff:10.4 System peripheral: Intel Corporation Xeon E7 v2/Xeon E5
v2/Core i7 Integrated Memory Controller 1 Channel 0-3 Thermal Control
2 (rev 04)
ff:10.5 System peripheral: Intel Corporation Xeon E7 v2/Xeon E5
v2/Core i7 Integrated Memory Controller 1 Channel 0-3 Thermal Control
3 (rev 04)
ff:10.6 System peripheral: Intel Corporation Xeon E7 v2/Xeon E5
v2/Core i7 Integrated Memory Controller 1 Channel 0-3 ERROR Registers
2 (rev 04)
ff:10.7 System peripheral: Intel Corporation Xeon E7 v2/Xeon E5
v2/Core i7 Integrated Memory Controller 1 Channel 0-3 ERROR Registers
3 (rev 04)
ff:13.0 System peripheral: Intel Corporation Xeon E7 v2/Xeon E5
v2/Core i7 R2PCIe (rev 04)
ff:13.1 Performance counters: Intel Corporation Xeon E7 v2/Xeon E5
v2/Core i7 R2PCIe (rev 04)
ff:13.4 System peripheral: Intel Corporation Xeon E7 v2/Xeon E5
v2/Core i7 QPI Ring Registers (rev 04)
ff:13.5 Performance counters: Intel Corporation Xeon E7 v2/Xeon E5
v2/Core i7 QPI Ring Performance Ring Monitoring (rev 04)
ff:16.0 System peripheral: Intel Corporation Xeon E7 v2/Xeon E5
v2/Core i7 System Address Decoder (rev 04)
ff:16.1 System peripheral: Intel Corporation Xeon E7 v2/Xeon E5
v2/Core i7 Broadcast Registers (rev 04)
ff:16.2 System peripheral: Intel Corporation Xeon E7 v2/Xeon E5
v2/Core i7 Broadcast Registers (rev 04)

lsusb:
Bus 002 Device 014: ID 19fb:2040
Bus 002 Device 010: ID 05e3:0610 Genesys Logic, Inc. 4-port hub
Bus 002 Device 007: ID 1a40:0101 Terminus Technology Inc. Hub
Bus 002 Device 016: ID 0627:0001 Adomax Technology Co., Ltd
Bus 002 Device 012: ID 04d9:0169 Holtek Semiconductor, Inc.
Bus 002 Device 009: ID 046d:09a2 Logitech, Inc. QuickCam Communicate
Deluxe/S7500
Bus 002 Device 005: ID 2109:2811 VIA Labs, Inc. Hub
Bus 002 Device 013: ID 046d:0a29 Logitech, Inc. H600 [Wireless Headset]
Bus 002 Device 017: ID 04d9:0198 Holtek Semiconductor, Inc.
Bus 002 Device 015: ID 1235:8202 Focusrite-Novation
Bus 002 Device 011: ID 1a40:0201 Terminus Technology Inc. FE 2.1 7-port Hub
Bus 002 Device 008: ID 0a12:0001 Cambridge Silicon Radio, Ltd
Bluetooth Dongle (HCI mode)
Bus 002 Device 006: ID 04b8:012c Seiko Epson Corp. GT-X900 [Perfection
V700/V750 Photo]
Bus 002 Device 004: ID 1a40:0201 Terminus Technology Inc. FE 2.1 7-port Hub
Bus 002 Device 003: ID 1759:5000 LucidPort Technology, Inc.
Bus 002 Device 002: ID 8087:0024 Intel Corp. Integrated Rate Matching Hub
Bus 002 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
Bus 006 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
Bus 005 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
Bus 004 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
Bus 003 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
Bus 001 Device 002: ID 8087:0024 Intel Corp. Integrated Rate Matching Hub
Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
