Return-Path: <SRS0=4IUq=NH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 962B9C46475
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Oct 2018 04:07:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30966204FD
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Oct 2018 04:07:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30966204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cox.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727567AbeJ0Mqp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Oct 2018 08:46:45 -0400
Received: from fed1rmfepo101.cox.net ([68.230.241.143]:57875 "EHLO
        fed1rmfepo101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726730AbeJ0Mqo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Oct 2018 08:46:44 -0400
Received: from fed1rmimpo109.cox.net ([68.230.241.158])
          by fed1rmfepo101.cox.net
          (InterMail vM.8.01.05.28 201-2260-151-171-20160122) with ESMTP
          id <20181027040705.KIJK4101.fed1rmfepo101.cox.net@fed1rmimpo109.cox.net>
          for <linux-kernel@vger.kernel.org>;
          Sat, 27 Oct 2018 00:07:05 -0400
Received: from thunderbird.smith.home ([68.2.114.239])
        by fed1rmimpo109.cox.net with cox
        id sU751y00159yGBo01U75QG; Sat, 27 Oct 2018 00:07:05 -0400
X-CT-Class: Clean
X-CT-Score: 0.00
X-CT-RefID: str=0001.0A090206.5BD3E469.0015,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
X-CT-Spam: 0
X-Authority-Analysis: v=2.3 cv=aZHVYigt c=1 sm=1 tr=0
 a=BlDZPKRk22kUaIvSBqmi8w==:117 a=BlDZPKRk22kUaIvSBqmi8w==:17
 a=kj9zAlcOel0A:10 a=smKx5t2vBNcA:10 a=WDhBSedXqNQA:10
 a=_dngzG2nIFMwGIS_DuAA:9 a=CjuIK1q_8ugA:10
X-CM-Score: 0.00
Authentication-Results: cox.net; auth=pass (LOGIN) smtp.auth=ischis2@cox.net
Received: from thunderbird.localnet (localhost [127.0.0.1])
        by thunderbird.smith.home (Postfix) with ESMTP id BEF6D29A00B9;
        Fri, 26 Oct 2018 21:07:04 -0700 (MST)
From:   Stephen Smith <ischis2@cox.net>
To:     linux-kernel@vger.kernel.org
Cc:     ischis2@cox.net
Subject: Re: Linux kernel crash
Date:   Fri, 26 Oct 2018 21:07:04 -0700
Message-ID: <8609715.XleivgsqJ9@thunderbird>
Organization: Personal
In-Reply-To: <1654617.UvxYW9xS0L@thunderbird>
References: <1654617.UvxYW9xS0L@thunderbird>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, October 24, 2018 10:20:05 PM MST Stephen Smith wrote:
> 
> Whenever I run "shutdown -h now" or "reboot" I receive an immediate kernel
> crash with a dump that has:
> 
> "Code: Bad RIP value"

I Canonical response noted  the following from the dump:

[ 42.640541] resource sanity check: requesting [mem 0x000c0000-0x000fffff], 
which spans more than PCI Bus 0000:00 [mem 0x000c0000-0x000dffff window]

I've since updated to the latest BIOS at there suggestion.   

I see the following on the screen when the kernel crashes:
[   43.115817] WARNING: CPU: 2 PID: 1847 at mm/usercopy.c:81 
usercopy_warn+0x81/0xa0
[   43.115818] Modules linked in: binfmt_misc snd_hda_codec_hdmi 
snd_hda_codec_realtek snd_hda_codec_generic edac_mce_amd snd_hda_intel kvm_amd 
kvm snd_hda_codec snd_hda_core irqbypass crct10dif_pclmul crc32_pclmul 
snd_hwdep snd_pcm snd_seq_midi snd_seq_midi_event ghash_clmulni_intel 
snd_rawmidi snd_seq pcbc aesni_intel snd_seq_device snd_timer eeepc_wmi 
asus_wmi sparse_keymap aes_x86_64 joydev snd video crypto_simd cryptd 
soundcore wmi_bmof glue_helper input_leds wmi k10temp ccp serio_raw 
nvidia_uvm(POE) mac_hid sch_fq_codel parport_pc ppdev lp parport ip_tables 
x_tables autofs4 raid10 raid456 async_raid6_recov async_memcpy async_pq 
async_xor async_tx xor raid6_pq libcrc32c raid0 multipath linear raid1 
hid_generic usbhid hid nvidia_drm(POE) nvidia_modeset(POE) nvidia(POE) 
drm_kms_helper syscopyarea
[   43.115849]  sysfillrect sysimgblt fb_sys_fops drm r8169 ipmi_devintf 
i2c_piix4 ipmi_msghandler mii ahci libahci gpio_amdpt gpio_generic
[   43.115856] CPU: 2 PID: 1847 Comm: Xorg Tainted: P           OE     
4.18.0-10-generic #11-Ubuntu
[   43.115857] Hardware name: System manufacturer System Product Name/PRIME 
B350-PLUS, BIOS 0406 02/07/2017
[   43.115859] RIP: 0010:usercopy_warn+0x81/0xa0
[   43.115859] Code: 10 99 41 51 4d 89 d8 48 c7 c0 89 8d 0f 99 49 89 f1 48 89 
f9 48 0f 45 c2 48 c7 c7 f0 a1 10 99 4c 89 d2 48 89 c6 e8 f1 cf df ff <0f> 0b 
48 83 c4 18 c9 c3 48 c7 c6 b2 8a 12 99 49 89 f1 49 89 f3 eb 
[   43.115875] RSP: 0018:ffffb0c741f07b08 EFLAGS: 00010286
[   43.115876] RAX: 0000000000000000 RBX: ffff9beec5c42cb0 RCX: 
0000000000000006
[   43.115876] RDX: 0000000000000007 RSI: 0000000000000096 RDI: 
ffff9beece6964b0
[   43.115877] RBP: ffffb0c741f07b20 R08: 0000000000000001 R09: 
0000000000000392
[   43.115878] R10: 0000000000000004 R11: 0000000000000000 R12: 
0000000000000003
[   43.115878] R13: 0000000000000001 R14: ffff9beec5c42cb3 R15: 
ffff9beec5c42cf8
[   43.115879] FS:  00007f6267654a80(0000) GS:ffff9beece680000(0000) knlGS:
0000000000000000
[   43.115880] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   43.115881] CR2: 00007f6263cc5d20 CR3: 0000000402fb0000 CR4: 
00000000003406e0
[   43.115881] Call Trace:
[   43.115886]  __check_heap_object+0xc2/0x110
[   43.115887]  __check_object_size+0x14c/0x178
[   43.116024]  os_memcpy_to_user+0x26/0x50 [nvidia]
[   43.116158]  _nv009384rm+0xbf/0xe0 [nvidia]
[   43.116159] WARNING: kernel stack frame pointer at 00000000e73eb0f3 in 
Xorg:1847 has bad value 0000000074044542


