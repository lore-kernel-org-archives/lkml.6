Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11EA5C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 18:53:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2B9520652
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 18:53:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XCg7feNu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2B9520652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727354AbeHaXCE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 19:02:04 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35214 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726704AbeHaXCE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 19:02:04 -0400
Received: by mail-wr1-f67.google.com with SMTP id j26-v6so12088692wre.2
        for <linux-kernel@vger.kernel.org>; Fri, 31 Aug 2018 11:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version
         :content-transfer-encoding;
        bh=J8FtBWkjrOk4e6o0S6vezvr0xPaDdwNB7X7xuMtTPuM=;
        b=XCg7feNua68Qk1BQHAF8esl4z+oUz0X0QRJUNTWotljBUP/yzvvorNig3sLwmJ9xMT
         kT68DZe0i4F79OS7Qyz/u5PQdAe3CI0Tp7TkvbDM5jPhy2gCylZKEUA74cJeNpZcWq6c
         5jteomJreZyY/JpAzoBlT6ytNv7vPABXkra8zkyoRiHDbwZNnp7j4EIi6BoTYmkk1KvG
         PML/LtKKPRwX52F5Op9ZIS8lW2xaLZaIDl352/+BlI4HiaI5wKBqxjmSsLBWvv/ERnhg
         Q0mWFlxXuQWvTOpT4lqeLaZNdvqKjTYqI2wNqobwYdB/lc0Y7bkN7nN+3knGBgQa1lVh
         un3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-transfer-encoding;
        bh=J8FtBWkjrOk4e6o0S6vezvr0xPaDdwNB7X7xuMtTPuM=;
        b=KbJVwZfUkGSNA2dFcWQcFcV3EQ8enUFz/z5PVJd+ANuv6sLBtU0mAikKJCmdUpZz0j
         EGFclaGl4g6HTXx8OO9TZ3dfDYf3fNNex1BcdbrnTtOTxwGu7mGYO3EWWFRNjmvDPNJa
         BbFAY+fP8UKoMX0M4iyaeAcS3UvttECTLxMXtKLUdObcqlz0z2t011Ex59TvoZxaogRF
         pylxh8QfQfwHLYFPpxS22yXr+QjcQmLVA5KotK2teAmBzhUBcEodxaP8gOSvyGK89/+e
         8mo5BAbZQ8UYN38ZqhBueTu8hemG76CjL0ApsC3mxzNvrlsSP17xV6ZHnjJZo6mr1Wka
         VmLA==
X-Gm-Message-State: APzg51D7D4CQF88DvQop1fLBZHP82sXp/wPPRXGSxN3eBIwgIygEi0GR
        twdPOVsckuWRb1eCkXuN1pUBVUWbQRo=
X-Google-Smtp-Source: ANB0VdbLz1vpLGkqOUuLe4JYtraEfLDQmJCX1tC/9O8SeEpify97EGSBdEnFiCXgfi1sYMVvPWdVEQ==
X-Received: by 2002:adf:9404:: with SMTP id 4-v6mr12354233wrq.129.1535741595543;
        Fri, 31 Aug 2018 11:53:15 -0700 (PDT)
Received: from korsan.localdomain ([78.167.231.57])
        by smtp.gmail.com with ESMTPSA id t9-v6sm26346876wra.91.2018.08.31.11.53.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 31 Aug 2018 11:53:15 -0700 (PDT)
Date:   Fri, 31 Aug 2018 21:53:11 +0300
From:   Numan =?UTF-8?B?RGVtaXJkw7bEn2Vu?= <if.gnu.linux@gmail.com>
To:     peterz@infradead.org
Cc:     mingo@redhat.com, linux-kernel@vger.kernel.org
Subject: PROBLEM: Keyboard not responding after resuming from
 suspend/hibernate
Message-ID: <20180831215121.1b1f66bf@korsan.localdomain>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If I put laptop to suspend or hibernate by closing lid, power
manager or any other method and then I resume/wake up laptop, keyboard
is not responding. My laptop is a Sony Vaio VPCEH2F1E.=20

Steps to produce bug:
1. Boot
2. Put laptop to sleep
3. Resume

What I expect to happen: Keyboard responds to key press.
What happens: Keyboard does not respond but mouse and trackball are
working.

git bisect point 9d659ae14b545c4296e812c70493bfdc999b5c1c as the first
bad commit.

Bad commit link:
https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?id=3D9d=
659ae14b545c4296e812c70493bfdc999b5c1c

 Link to actual bug report:
https://bugzilla.kernel.org/show_bug.cgi?id=3D195471

awk -f ver_linux
Linux korsan 4.18.5-arch1-1-ARCH #1 SMP PREEMPT Fri Aug 24 12:48:58 UTC 201=
8 x86_64 GNU/Linux
GNU C               	8.2.0
GNU Make            	4.2.1
Binutils            	2.31.1
Util-linux          	2.32.1
Mount               	2.32.1
Module-init-tools   	25
E2fsprogs           	1.44.4
Jfsutils            	1.1.15
Reiserfsprogs       	3.6.27
Xfsprogs            	4.17.0
Pcmciautils         	018
Linux C Library     	2.28
Dynamic linker (ldd)	2.28
Linux C++ Library   	6.0.25
Procps              	3.3.15
Kbd                 	2.0.4
Console-tools       	2.0.4
Sh-utils            	8.29
Udev                	239
Wireless-tools      	30
Modules Loaded      	ac agpgart ahci arc4 ath ath3k ath9k ath9k_common ath9=
k_hw atkbd battery bluetooth bpfilter ccm cdrom cfg80211 coretemp crc16 crc=
32c_generic crc32c_intel crc32_pclmul crct10dif_pclmul cryptd drm drm_kms_h=
elper ecdh_generic ehci_hcd ehci_pci evdev ext4 fb_sys_fops fscrypto fuse g=
hash_clmulni_intel gpio_ich hid hid_generic i2c_algo_bit i2c_i801 i8042 i91=
5 input_leds intel_cstate intel_gtt intel_powerclamp intel_rapl intel_rapl_=
perf intel_uncore iptable_filter iptable_mangle iptable_nat ip_tables irqby=
pass iTCO_vendor_support iTCO_wdt jbd2 kvm kvm_intel led_class libahci liba=
ta libcrc32c libps2 lpc_ich mac80211 mac_hid mbcache mei mei_me mousedev ms=
r nf_conntrack nf_conntrack_ipv4 nf_defrag_ipv4 nf_nat nf_nat_ipv4 pcc_cpuf=
req psmouse rfkill rtc_cmos scsi_mod sd_mod serio serio_raw snd snd_hda_cod=
ec snd_hda_codec_conexant snd_hda_codec_generic snd_hda_codec_hdmi snd_hda_=
core snd_hda_intel snd_hwdep snd_pcm snd_timer sony_laptop soundcore sr_mod=
 syscopyarea sysfillrect sysimgblt usb_common usbcore usbhid x86_pkg_temp_t=
hermal x_tables

dmesg | grep i8042
[    0.574078] i8042: PNP: PS/2 Controller [PNP0303:PS2K,PNP0f13:PS2M] at 0=
x60,0x64 irq 1,12
[    0.575936] serio: i8042 KBD port at 0x60,0x64 irq 1
[    0.576143] serio: i8042 AUX port at 0x60,0x64 irq 12
[    0.618880] input: AT Translated Set 2 keyboard as /devices/platform/i80=
42/serio0/input/input3
[   11.248435] input: AlpsPS/2 ALPS GlidePoint as /devices/platform/i8042/s=
erio1/input/input5

cat /proc/interrupts=20
           CPU0       CPU1       CPU2       CPU3      =20
  0:          8          0          0          0   IO-APIC   2-edge      ti=
mer
  1:          0          0          0      10286   IO-APIC   1-edge      i8=
042
  8:          0          0          0          1   IO-APIC   8-edge      rt=
c0
  9:          0       9479          0          0   IO-APIC   9-fasteoi   ac=
pi
 12:          0          0     370114          0   IO-APIC  12-edge      i8=
042
 16:     197457          0          0          0   IO-APIC  16-fasteoi   eh=
ci_hcd:usb1, ath9k
 19:          0          0          0          0   IO-APIC  19-fasteoi   i8=
01_smbus
 23:          0          0      71055          0   IO-APIC  23-fasteoi   eh=
ci_hcd:usb2
 24:          0      74549          0          0   PCI-MSI 512000-edge     =
 ahci[0000:00:1f.2]
 25:          0         14          0          0   PCI-MSI 360448-edge     =
 mei_me
 26:          0          0     138870          0   PCI-MSI 32768-edge      =
i915
 27:          0          0          0        330   PCI-MSI 442368-edge     =
 snd_hda_intel:card0
NMI:         24         22         25         21   Non-maskable interrupts
LOC:     534734     446934     603337     440320   Local timer interrupts
SPU:          0          0          0          0   Spurious interrupts
PMI:         24         22         25         21   Performance monitoring i=
nterrupts
IWI:         26         12      43115         22   IRQ work interrupts
RTR:          0          0          0          0   APIC ICR read retries
RES:      95282      76970      60242      46409   Rescheduling interrupts
CAL:      66746      75300      70554      69119   Function call interrupts
TLB:      50929      54528      51413      48017   TLB shootdowns
TRM:          0          0          0          0   Thermal event interrupts
THR:          0          0          0          0   Threshold APIC interrupts
DFR:          0          0          0          0   Deferred Error APIC inte=
rrupts
MCE:          0          0          0          0   Machine check exceptions
MCP:         18         19         19         19   Machine check polls
HYP:          0          0          0          0   Hypervisor callback inte=
rrupts
HRE:          0          0          0          0   Hyper-V reenlightenment =
interrupts
HVS:          0          0          0          0   Hyper-V stimer0 interrup=
ts
ERR:          0
MIS:          0
PIN:          0          0          0          0   Posted-interrupt notific=
ation event
NPI:          0          0          0          0   Nested posted-interrupt =
event
PIW:          0          0          0          0   Posted-interrupt wakeup =
event

P.S: My native language is not English.

--=20
Numan Demird=C3=B6=C4=9Fen
