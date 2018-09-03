Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07E4EC43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 21:16:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 850412086B
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 21:16:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rRfzBJNN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 850412086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727410AbeIDBii (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 21:38:38 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:43825 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725947AbeIDBii (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 21:38:38 -0400
Received: by mail-ed1-f68.google.com with SMTP id z27-v6so1652065edb.10;
        Mon, 03 Sep 2018 14:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:newsgroups:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=kKmA7jSJXLz56ckL0xA53UoPA4aeLxCD2UFVnb6Qdfs=;
        b=rRfzBJNNH/vupNy79hPN4NhYB3CtGPOY1ylW5olvwI4+IzrBMXQl8KOzlKAo+1NZjk
         ypu5AISDEB7kHVjWtoMRqiRounDiKz7m4opLN+Oe8Yw4Uiun4ATUD7KI260HiC+9zc2D
         xnHmoqDi45DQcYndxpSJANJRhXkFosKw5pERtT+QNGpAK53WwskF2XQ0B1G5HDs9e6Fx
         Ob3R3H+wjMTHLQdyVLzkkpqbyM3xa8n39bdX/vLdCEPv+m7jOg7t7ZbeI5rBHe/aqwTd
         9MSsntNDqLJnZzt2Ka7DUubODQ94o9SfDOm/Vip/OJaHl2wpZVtwcj4/kiNh/+yEA+MC
         uDZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:newsgroups:references:from:openpgp
         :autocrypt:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=kKmA7jSJXLz56ckL0xA53UoPA4aeLxCD2UFVnb6Qdfs=;
        b=NVLT0xd0NHTLALe/yP073Q99/KmtGiM/44WtxVemPCqcFRmANEcbh+m/SNjBtE7GLG
         Qr+oalHpOoM0owOf55wJ7LlVfKeT1Lve6s0M/PZNLWwqGd+vBROoZ0OmnYD/rxMsm2Y1
         SGXyxlHOyzZmUI2zr4t9mr9DSvZPCWFUTF9JAklPt2aj+jskQat9abQr4XjxKWUNigZz
         /oJ2X2zWesg26HTuLx0bw82xmZfOYsD6fgHrPc05usmThqkhxC3QZ5K0Mdl5uQG3/lmB
         jPwTTI4Y3tHrf/9yszZQbHXFWLePFTZKRrsm+ltnfh4jrq1/T37kcAUIVoMJW5U51EV9
         oOgA==
X-Gm-Message-State: APzg51AfFi68dlVowZRXgbdkk9M4Qb0yloOHuGB35jWT50e2wW9cuwQR
        dyiW6ifCjPt1YFG7TV9fFD5l92dq5CY=
X-Google-Smtp-Source: ANB0VdYMhAFatgC0lXOSdBE3jLEUZ6VpifRzDbbeHgXLxVVVj9iJglc+aogo7S8Z2lc2QlG+Rftb9Q==
X-Received: by 2002:a50:a4a1:: with SMTP id w30-v6mr33069169edb.67.1536009394735;
        Mon, 03 Sep 2018 14:16:34 -0700 (PDT)
Received: from [192.168.1.3] (host-109-89-151-97.dynamic.voo.be. [109.89.151.97])
        by smtp.gmail.com with ESMTPSA id b20-v6sm10236095edc.30.2018.09.03.14.16.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Sep 2018 14:16:33 -0700 (PDT)
Subject: Re: [PATCH 4.18 000/123] 4.18.6-stable review
To:     =?UTF-8?Q?Holger_Hoffst=c3=a4tte?= <holger@applied-asynchrony.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Newsgroups: gmane.linux.kernel,gmane.linux.kernel.stable
References: <20180903165719.499675257@linuxfoundation.org>
 <64889a4a-c095-3db8-b496-631acbafcf9a@applied-asynchrony.com>
From:   =?UTF-8?Q?Fran=c3=a7ois_Valenduc?= <francoisvalenduc@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=francoisvalenduc@gmail.com; keydata=
 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
Message-ID: <8147a9c3-256b-023a-932f-f3b45cb80a16@gmail.com>
Date:   Mon, 3 Sep 2018 23:16:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <64889a4a-c095-3db8-b496-631acbafcf9a@applied-asynchrony.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 3/09/18 à 20:39, Holger Hoffstätte a écrit :
> On 09/03/18 18:55, Greg Kroah-Hartman wrote:
>> This is the start of the stable review cycle for the 4.18.6 release.
> 
> Unfortunately this is busted. First blamed my custom patches, but as it
> turns out a 100% vanilla 4.18.6 build crashes as well. Single-user starts,
> but later when starting services and esp. autofs (I think - too much
> output)
> explodes with:
> 
> ...
> Sep  3 20:19:36 ragnarok kernel: IPv6: ADDRCONF(NETDEV_UP): eth0: link
> is not ready
> Sep  3 20:19:38 ragnarok kernel: BUG: stack guard page was hit at
> 00000000ab58c99c (stack is 00000000382b9464..00000000d642b9d6)
> Sep  3 20:19:38 ragnarok kernel: kernel stack overflow (double-fault):
> 0000 [#1] SMP
> Sep  3 20:19:38 ragnarok kernel: CPU: 4 PID: 3634 Comm: automount
> Tainted: G           O      4.18.6 #1
> Sep  3 20:19:38 ragnarok kernel: Hardware name: Gigabyte Technology Co.,
> Ltd. P67-DS3-B3/P67-DS3-B3, BIOS F1 05/06/2011
> Sep  3 20:19:38 ragnarok kernel: RIP:
> 0010:flush_tlb_func_common.constprop.4+0x23/0x260
> Sep  3 20:19:38 ragnarok kernel: Code: 0b eb e5 0f 1f 40 00 66 66 66 66
> 90 55 48 89 e5 41 57 41 56 41 55 41 54 53 48 83 e4 f0 48 83 ec 20 65 48
> 8b 04 25 28 00 00 00 <48> 89 44 24 18 31 c0 65 66 8b 1d 96 fd fc 7e 0f
> b7 c3 65 48 8b 15
> Sep  3 20:19:38 ragnarok kernel: RSP: 0018:ffffc9000326bfe0 EFLAGS:
> 00010082
> Sep  3 20:19:38 ragnarok kernel: RAX: cf0a75e3a0e78e00 RBX:
> ffff880601006cc0 RCX: 0000000000000000
> Sep  3 20:19:38 ragnarok kernel: RDX: 00007fb464e7e000 RSI:
> 0000000000000003 RDI: ffffc9000326c040
> Sep  3 20:19:38 ragnarok kernel: RBP: ffffc9000326c030 R08:
> 00000005fca490e7 R09: 00000000004fa811
> Sep  3 20:19:38 ragnarok kernel: R10: 0000000000000002 R11:
> 0000000000000000 R12: 0000000000000004
> Sep  3 20:19:38 ragnarok kernel: R13: ffff8805fbab7600 R14:
> ffff880601006cc0 R15: ffff880602dfb540
> Sep  3 20:19:38 ragnarok kernel: FS:  00007fb469245240(0000)
> GS:ffff88061f500000(0000) knlGS:0000000000000000
> Sep  3 20:19:38 ragnarok kernel: CS:  0010 DS: 0000 ES: 0000 CR0:
> 0000000080050033
> Sep  3 20:19:38 ragnarok kernel: CR2: ffffc9000326bfd8 CR3:
> 00000005feadb001 CR4: 00000000000606e0
> Sep  3 20:19:38 ragnarok kernel: Call Trace:
> Sep  3 20:19:38 ragnarok kernel:  flush_tlb_mm_range+0xff/0x110
> Sep  3 20:19:38 ragnarok kernel:  ? cpumask_any_but+0x1f/0x40
> Sep  3 20:19:38 ragnarok kernel:  ? cpumask_any_but+0x1f/0x40
> Sep  3 20:19:38 ragnarok kernel:  tlb_flush_mmu_tlbonly+0x76/0xc0
> Sep  3 20:19:38 ragnarok kernel:  tlb_table_flush.part.13+0xe/0x30
> Sep  3 20:19:38 ragnarok kernel:  tlb_flush_mmu_tlbonly+0x54/0xc0
> ..a few hundred times..
> Sep  3 20:19:38 ragnarok kernel:  tlb_table_flush.part.13+0xe/0x30
> Sep  3 20:19:38 ragnarok kernel:  tlb_flush_mmu_tlbonly+0x54/0xc0
> Sep  3 20:19:38 ragnarok kernel:  arch_tlb_finish_mmu+0x3a/0x70
> Sep  3 20:19:38 ragnarok kernel:  tlb_finish_mmu+0x1f/0x30
> Sep  3 20:19:38 ragnarok kernel:  unmap_region+0xdd/0x110
> Sep  3 20:19:38 ragnarok kernel:  ? __vma_rb_erase+0x128/0x250
> Sep  3 20:19:38 ragnarok kernel:  do_munmap+0x273/0x3f0
> Sep  3 20:19:38 ragnarok kernel:  vm_munmap+0x5f/0xa0
> Sep  3 20:19:38 ragnarok kernel:  __x64_sys_munmap+0x22/0x30
> Sep  3 20:19:38 ragnarok kernel:  do_syscall_64+0x3e/0xe0
> Sep  3 20:19:38 ragnarok kernel:  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> Sep  3 20:19:38 ragnarok kernel: RIP: 0033:0x7fb469081187
> Sep  3 20:19:38 ragnarok kernel: Code: ff ff ff f7 d8 89 05 58 df 20 00
> 48 c7 c0 ff ff ff ff eb 8a 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00
> b8 0b 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8d 0d 29 df 20 00
> f7 d8 89 01 48 83
> Sep  3 20:19:38 ragnarok kernel: RSP: 002b:00007ffef83ba548 EFLAGS:
> 00000206 ORIG_RAX: 000000000000000b
> Sep  3 20:19:38 ragnarok kernel: RAX: ffffffffffffffda RBX:
> 0000562a1dca9010 RCX: 00007fb469081187
> Sep  3 20:19:38 ragnarok kernel: RDX: 0000000000000002 RSI:
> 0000000000204028 RDI: 00007fb464c79000
> Sep  3 20:19:38 ragnarok kernel: RBP: 00007ffef83ba720 R08:
> 00007fb46928e930 R09: 0000000000000000
> Sep  3 20:19:38 ragnarok kernel: R10: 00007fb464e7d000 R11:
> 0000000000000206 R12: 00007ffef83ba654
> Sep  3 20:19:38 ragnarok kernel: R13: 00007ffef83ba610 R14:
> 00007ffef83ba655 R15: 00007fb46928e000
> Sep  3 20:19:38 ragnarok kernel: Modules linked in: autofs4 tcp_bbr
> sch_fq_codel pci_stub vboxpci(O) vboxnetadp(O) vboxnetflt(O) vboxdrv(O)
> it87 hwmon_vid x86_pkg_temp_thermal uvcvideo videobuf2_vmalloc
> videobuf2_memops snd_usb_audio videobuf2_v4l2 snd_hwdep bfq
> snd_usbmidi_lib videodev snd_rawmidi coretemp snd_seq_device
> videobuf2_common radeon usbhid kvm_intel i2c_algo_bit kvm
> snd_hda_codec_realtek irqbypass drm_kms_helper snd_hda_codec_hdmi
> snd_hda_codec_generic pcbc syscopyarea sysfillrect sysimgblt mq_deadline
> fb_sys_fops ttm snd_hda_intel aesni_intel snd_hda_codec drm snd_hda_core
> aes_x86_64 crypto_simd drm_panel_orientation_quirks cryptd snd_pcm
> glue_helper backlight snd_timer snd i2c_i801 soundcore i2c_core r8169
> parport_pc parport mii
> Sep  3 20:19:38 ragnarok kernel: ---[ end trace cf25033b43d98311 ]---
> Sep  3 20:19:38 ragnarok kernel: RIP:
> 0010:flush_tlb_func_common.constprop.4+0x23/0x260
> Sep  3 20:19:38 ragnarok kernel: Code: 0b eb e5 0f 1f 40 00 66 66 66 66
> 90 55 48 89 e5 41 57 41 56 41 55 41 54 53 48 83 e4 f0 48 83 ec 20 65 48
> 8b 04 25 28 00 00 00 <48> 89 44 24 18 31 c0 65 66 8b 1d 96 fd fc 7e 0f
> b7 c3 65 48 8b 15
> Sep  3 20:19:38 ragnarok kernel: RSP: 0018:ffffc9000326bfe0 EFLAGS:
> 00010082
> Sep  3 20:19:38 ragnarok kernel: RAX: cf0a75e3a0e78e00 RBX:
> ffff880601006cc0 RCX: 0000000000000000
> Sep  3 20:19:38 ragnarok kernel: RDX: 00007fb464e7e000 RSI:
> 0000000000000003 RDI: ffffc9000326c040
> Sep  3 20:19:38 ragnarok kernel: RBP: ffffc9000326c030 R08:
> 00000005fca490e7 R09: 00000000004fa811
> Sep  3 20:19:38 ragnarok kernel: R10: 0000000000000002 R11:
> 0000000000000000 R12: 0000000000000004
> Sep  3 20:19:38 ragnarok kernel: R13: ffff8805fbab7600 R14:
> ffff880601006cc0 R15: ffff880602dfb540
> Sep  3 20:19:38 ragnarok kernel: FS:  00007fb469245240(0000)
> GS:ffff88061f500000(0000) knlGS:0000000000000000
> Sep  3 20:19:38 ragnarok kernel: CS:  0010 DS: 0000 ES: 0000 CR0:
> 0000000080050033
> Sep  3 20:19:38 ragnarok kernel: CR2: ffffc9000326bfd8 CR3:
> 00000005feadb001 CR4: 00000000000606e0
> Sep  3 20:19:40 ragnarok kernel: r8169 0000:04:00.0 eth0: link up
> Sep  3 20:19:40 ragnarok kernel: IPv6: ADDRCONF(NETDEV_CHANGE): eth0:
> link becomes ready
> 
> This is repeatable; full log is available on request.
> 
> Reverting
> "mm-tlb-x86-mm-support-invalidating-tlb-caches-for-rcu_table_free"
> makes everything work.
> 
> I'm now going back to my custom tree with lazy TLB handling, that worked as
> advertised. :D
> 
> cheers
> Holger
> 
I confirm this also for the 4.14 tree. I get the same errors and
reverting the same patch also fixes the problem.

François Valenduc
