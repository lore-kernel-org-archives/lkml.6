Return-Path: <SRS0=mdhE=KU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E668C46471
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 20:46:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9677F219A3
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 20:46:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tn7NK3mn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9677F219A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728089AbeHEWwL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Aug 2018 18:52:11 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:53041 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726769AbeHEWwL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Aug 2018 18:52:11 -0400
Received: by mail-wm0-f65.google.com with SMTP id o11-v6so11706043wmh.2
        for <linux-kernel@vger.kernel.org>; Sun, 05 Aug 2018 13:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=s3BQg43rgM24nxStOQ7CvIh/JL3f7d45QeW8zCwGKl8=;
        b=Tn7NK3mnnx/G35dwaw/UoyNc/N5A37Ga6v0yQWjoBlIKEkI/oPw3mRHAiJ0jeSX0j4
         Jwe6ETmxGwQ7ArcZzYg+sCUrNgmTo/BLthv/DesjMH/01l1xulSbmMNQWBpNUsIZNhge
         i2t5XqGSM7TQTtA9dJBIhCLXsfqkoLq8mtWIYe/VYZaIujHAExqZ/l3aPyot/Hu14Kw0
         2M6MSJfxSNYY9/wVna0Gc+N/o6xdSS3tkDAsUNCCcY8JSXn8oSJSPzDrklBnj+knPICO
         DdunD7WrR6r1BFMnfW7x85osekk4FC18HtEy6u6SnuxWwpUE/i+E1qHlIib16YQJcgrr
         fqug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=s3BQg43rgM24nxStOQ7CvIh/JL3f7d45QeW8zCwGKl8=;
        b=YM4Ku6d4gkrW8cM06sQRIki6/poMwDeUKQRU3HaJrua1GZQ6aoE5Sj0vSyqPewMsZM
         5311TzJdE4N9b7my5bwV2gYOUn+iEMHOiFKmziuVKh40xbjlzyik/q64N26N+3EfcDes
         v/LfP7/0dKPR87/2LnWoRJ2YTMMwno7jQBkiWDo73zVzSMZP45PFQybgzExoEbKZ5+6j
         LXnEs8kgZc7HFKqPUDe5c0Oh8F+2k/4no7USOafefBAvJPAut+vGD5TWAqr4pt/rMxsq
         xuVZZgUXHFiYths0sXcHN6EjesV74bd3tGom9gEcQeTeslON6OgUeQoAKx5Fr+ZvKFrx
         WFaw==
X-Gm-Message-State: AOUpUlH5ZlNwlHBNOts1kOvc9WzYkd9mF24w3wIZsS3ljyafQ+VzodBv
        gJ4g2gtLUq4nsB814cI77wnOmkLd
X-Google-Smtp-Source: AAOMgpecd+BVTMw0uKVEujZLuRF5fXBmdGtQv0MPyN+ijUTemqNzUvDci+y4uADcQ5kaOSpnGQ4LVA==
X-Received: by 2002:a1c:3282:: with SMTP id y124-v6mr10204841wmy.11.1533501977678;
        Sun, 05 Aug 2018 13:46:17 -0700 (PDT)
Received: from ?IPv6:2a02:8108:85c0:57c8:32db:916d:97a2:c4eb? ([2a02:8108:85c0:57c8:32db:916d:97a2:c4eb])
        by smtp.gmail.com with ESMTPSA id y18-v6sm2167096wrh.85.2018.08.05.13.46.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 05 Aug 2018 13:46:17 -0700 (PDT)
Subject: Re: [PATCH 2/2] staging:r8188eu: Use lib80211 to encrypt (CCMP) tx
 frames
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Ivan Safonov <insafonov@gmail.com>, devel@driverdev.osuosl.org,
        Santha Meena Ramamoorthy <santhameena13@gmail.com>,
        Janani Sankara Babu <jananis37@gmail.com>,
        linux-kernel@vger.kernel.org
References: <20180714175410.24296-1-insafonov@gmail.com>
 <20180714175410.24296-2-insafonov@gmail.com>
 <a6a3900d-74f8-aa2a-4bb2-a67b59b44f31@gmail.com>
 <97e5e056-4f6c-4c70-4a00-6eecedbcde1a@gmail.com>
 <20180805140715.GA17478@kroah.com>
From:   Michael Straube <straube.linux@gmail.com>
Message-ID: <7fd0d374-827d-8253-16b4-a7af89e1337d@gmail.com>
Date:   Sun, 5 Aug 2018 22:46:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180805140715.GA17478@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/05/18 16:07, Greg Kroah-Hartman wrote:
> On Thu, Aug 02, 2018 at 06:35:05PM +0200, Michael Straube wrote:
>> On 07/16/18 15:30, Michael Straube wrote:
>>> On 07/14/18 19:54, Ivan Safonov wrote:
>>>> Put data to skb, decrypt with lib80211_crypt_ccmp, and place back to tx buffer.
>>>>
>>>> Signed-off-by: Ivan Safonov <insafonov@gmail.com>
>>>> ---
>>>>    drivers/staging/rtl8188eu/core/rtw_security.c | 778 +++-----------------------
>>>>    1 file changed, 72 insertions(+), 706 deletions(-)
>>>>
>>>
>>> Hi Ivan,
>>>
>>> with this applied I get the following in dmesg:
>>>
>>> [    3.901334] [drm] Initialized amdgpu 3.26.0 20150101 for 0000:07:00.0 on minor 0
>>> [    4.108904] IPv6: ADDRCONF(NETDEV_UP): enp6s0: link is not ready
>>> [    4.185502] r8169 0000:06:00.0 enp6s0: link down
>>> [    4.185564] IPv6: ADDRCONF(NETDEV_UP): enp6s0: link is not ready
>>> [    4.193647] IPv6: ADDRCONF(NETDEV_UP): wlp1s0f0u9: link is not ready
>>> [   17.741809] MAC Address = 7c:8b:ca:08:80:7e
>>> [   17.828850] IPv6: ADDRCONF(NETDEV_UP): wlp1s0f0u9: link is not ready
>>> [   17.969593] R8188EU: indicate disassoc
>>> [   18.081923] IPv6: ADDRCONF(NETDEV_UP): wlp1s0f0u9: link is not ready
>>> [   18.123036] IPv6: ADDRCONF(NETDEV_UP): wlp1s0f0u9: link is not ready
>>> [   23.034084] R8188EU: assoc success
>>> [   23.085043] IPv6: ADDRCONF(NETDEV_CHANGE): wlp1s0f0u9: link becomes ready
>>> [   23.093587] BUG: scheduling while atomic: NetworkManager/495/0x00000202
>>> [   23.093590] Modules linked in: amdkfd amd_iommu_v2 amdgpu nls_iso8859_1 nls_cp437 vfat fat r8188eu(C) lib80211 snd_hda_codec_realtek cfg80211 snd_hda_codec_generic edac_mce_amd chash snd_hda_codec_hdmi gpu_sched kvm_amd i2c_algo_bit ttm ccp snd_hda_intel rng_core drm_kms_helper kvm snd_hda_codec input_leds led_class joydev mousedev drm rfkill irqbypass snd_hda_core crct10dif_pclmul agpgart crc32_pclmul snd_hwdep ghash_clmulni_intel syscopyarea sysfillrect sysimgblt pcbc wmi_bmof snd_pcm aesni_intel snd_timer aes_x86_64 crypto_simd cryptd k10temp fb_sys_fops snd r8169 sp5100_tco pcspkr glue_helper soundcore mii i2c_piix4 rtc_cmos pinctrl_amd evdev gpio_amdpt wmi mac_hid acpi_cpufreq crypto_user ip_tables x_tables ext4 crc32c_generic crc16 mbcache jbd2 fscrypto sd_mod hid_generic usbhid hid ahci libahci
>>> [   23.093655]  xhci_pci xhci_hcd libata crc32c_intel usbcore scsi_mod usb_common
>>> [   23.093661] Preemption disabled at:
>>> [   23.093667] [<ffffffffb9600954>] __dev_queue_xmit+0x74/0x910
>>> [   23.093672] CPU: 7 PID: 495 Comm: NetworkManager Tainted: G         C        4.18.0-rc5-staging+ #1
>>> [   23.093673] Hardware name: Gigabyte Technology Co., Ltd. A320M-S2H/A320M-S2H-CF, BIOS F23d 04/17/2018
>>> [   23.093675] Call Trace:
>>> [   23.093683]  dump_stack+0x5c/0x80
>>> [   23.093686]  ? __dev_queue_xmit+0x74/0x910
>>> [   23.093691]  __schedule_bug.cold.14+0x82/0x9b
>>> [   23.093696]  __schedule+0x705/0x8b0
>>> [   23.093700]  ? enqueue_task_fair+0xc3/0x730
>>> [   23.093704]  schedule+0x32/0x90
>>> [   23.093707]  schedule_timeout+0x311/0x4a0
>>> [   23.093710]  ? _raw_spin_unlock_irqrestore+0x20/0x40
>>> [   23.093713]  ? try_to_wake_up+0x23a/0x490
>>> [   23.093716]  wait_for_common+0x15f/0x190
>>> [   23.093719]  ? wake_up_q+0x70/0x70
>>> [   23.093736]  ? rtw_aes_encrypt+0x26f/0x290 [r8188eu]
>>> [   23.093739]  wait_for_completion_killable+0x19/0x30
>>> [   23.093743]  call_usermodehelper_exec+0x115/0x160
>>> [   23.093747]  __request_module+0x1ac/0x3e2
>>> [   23.093764]  rtw_aes_encrypt+0x26f/0x290 [r8188eu]
>>> [   23.093778]  ? rtw_get_stainfo+0xe6/0x130 [r8188eu]
>>> [   23.093793]  rtw_xmitframe_coalesce+0x950/0xb00 [r8188eu]
>>> [   23.093799]  ? _raw_spin_lock_irqsave+0x25/0x50
>>> [   23.093812]  rtw_hal_xmit+0x83/0x130 [r8188eu]
>>> [   23.093826]  rtw_xmit+0x258/0x5d0 [r8188eu]
>>> [   23.093840]  rtw_xmit_entry+0xe8/0x2e7 [r8188eu]
>>> [   23.093845]  dev_hard_start_xmit+0xa5/0x240
>>> [   23.093849]  sch_direct_xmit+0x150/0x340
>>> [   23.093852]  __dev_queue_xmit+0x2f6/0x910
>>> [   23.093856]  packet_sendmsg+0x945/0x1592
>>> [   23.093860]  ? attach_to_pi_state+0x18/0x110
>>> [   23.093862]  ? preempt_count_sub+0x60/0x90
>>> [   23.093866]  ? ep_item_poll.isra.1+0x40/0xc0
>>> [   23.093871]  sock_sendmsg+0x33/0x40
>>> [   23.093874]  __sys_sendto+0xee/0x160
>>> [   23.093879]  ? memzero_explicit+0xa/0x10
>>> [   23.093883]  ? urandom_read+0x120/0x270
>>> [   23.093887]  __x64_sys_sendto+0x24/0x30
>>> [   23.093890]  do_syscall_64+0x5b/0x170
>>> [   23.093893]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
>>> [   23.093896] RIP: 0033:0x7fac0b700c12
>>> [   23.093897] Code: 48 83 ec 18 44 89 4c 24 08 e8 9a f5 ff ff 44 8b 4c 24 08 4d 89 f8 45 89 f2 89 c5 4c 89 ea 4c 89 e6 89 df b8 2c 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 3a 89 ef 48 89 44 24 08 e8 ca f5 ff ff 48 8b
>>> [   23.093935] RSP: 002b:00007fffc46321b0 EFLAGS: 00000293 ORIG_RAX: 000000000000002c
>>> [   23.093938] RAX: ffffffffffffffda RBX: 0000000000000011 RCX: 00007fac0b700c12
>>> [   23.093939] RDX: 0000000000000148 RSI: 000055f8a5417c70 RDI: 0000000000000011
>>> [   23.093940] RBP: 0000000000000000 R08: 000055f8a54154c0 R09: 0000000000000014
>>> [   23.093942] R10: 0000000000000000 R11: 0000000000000293 R12: 000055f8a5417c70
>>> [   23.093943] R13: 0000000000000148 R14: 0000000000000000 R15: 000055f8a54154c0
>>> [   23.096167] lib80211_crypt: registered algorithm 'CCMP'
>>> [   23.096544] ------------[ cut here ]------------
>>> [   23.096549] DEBUG_LOCKS_WARN_ON(val > preempt_count())
>>> [   23.096557] WARNING: CPU: 7 PID: 495 at kernel/sched/core.c:3246 preempt_count_sub+0x5a/0x90
>>> [   23.096561] Modules linked in: lib80211_crypt_ccmp amdkfd amd_iommu_v2 amdgpu nls_iso8859_1 nls_cp437 vfat fat r8188eu(C) lib80211 snd_hda_codec_realtek cfg80211 snd_hda_codec_generic edac_mce_amd chash snd_hda_codec_hdmi gpu_sched kvm_amd i2c_algo_bit ttm ccp snd_hda_intel rng_core drm_kms_helper kvm snd_hda_codec input_leds led_class joydev mousedev drm rfkill irqbypass snd_hda_core crct10dif_pclmul agpgart crc32_pclmul snd_hwdep ghash_clmulni_intel syscopyarea sysfillrect sysimgblt pcbc wmi_bmof snd_pcm aesni_intel snd_timer aes_x86_64 crypto_simd cryptd k10temp fb_sys_fops snd r8169 sp5100_tco pcspkr glue_helper soundcore mii i2c_piix4 rtc_cmos pinctrl_amd evdev gpio_amdpt wmi mac_hid acpi_cpufreq crypto_user ip_tables x_tables ext4 crc32c_generic crc16 mbcache jbd2 fscrypto sd_mod hid_generic
>>> [   23.096604]  usbhid hid ahci libahci xhci_pci xhci_hcd libata crc32c_intel usbcore scsi_mod usb_common
>>> [   23.096613] CPU: 7 PID: 495 Comm: NetworkManager Tainted: G        WC        4.18.0-rc5-staging+ #1
>>> [   23.096615] Hardware name: Gigabyte Technology Co., Ltd. A320M-S2H/A320M-S2H-CF, BIOS F23d 04/17/2018
>>> [   23.096618] RIP: 0010:preempt_count_sub+0x5a/0x90
>>> [   23.096619] Code: 15 f7 46 c3 e8 a7 86 2d 00 85 c0 74 f6 8b 15 15 6b 5a 01 85 d2 75 ec 48 c7 c6 be fb e6 b9 48 c7 c7 6b ad e5 b9 e8 c0 77 fd ff <0f> 0b c3 84 d2 75 c9 e8 7a 86 2d 00 85 c0 74 c9 8b 05 e8 6a 5a 01
>>> [   23.096647] RSP: 0018:ffff9d5581447c48 EFLAGS: 00010286
>>> [   23.096650] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000001
>>> [   23.096652] RDX: 0000000080000001 RSI: ffffffffb9e82096 RDI: 00000000ffffffff
>>> [   23.096653] RBP: ffff959ef568a600 R08: 0000001cb3397218 R09: 00000000000003f3
>>> [   23.096655] R10: ffffffffba5f7700 R11: 0000000000000000 R12: ffff959ef568a6ac
>>> [   23.096657] R13: ffff959f0db9a000 R14: ffff959f15441000 R15: 0000000000000007
>>> [   23.096660] FS:  00007fac0dcd9000(0000) GS:ffff959f1edc0000(0000) knlGS:0000000000000000
>>> [   23.096663] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>> [   23.096665] CR2: 00007fffc462efe8 CR3: 0000000206e88000 CR4: 00000000003406e0
>>> [   23.096667] Call Trace:
>>> [   23.096674]  _raw_spin_unlock+0x16/0x30
>>> [   23.096678]  sch_direct_xmit+0x178/0x340
>>> [   23.096684]  __dev_queue_xmit+0x2f6/0x910
>>> [   23.096689]  packet_sendmsg+0x945/0x1592
>>> [   23.096694]  ? attach_to_pi_state+0x18/0x110
>>> [   23.096696]  ? preempt_count_sub+0x60/0x90
>>> [   23.096701]  ? ep_item_poll.isra.1+0x40/0xc0
>>> [   23.096706]  sock_sendmsg+0x33/0x40
>>> [   23.096710]  __sys_sendto+0xee/0x160
>>> [   23.096715]  ? memzero_explicit+0xa/0x10
>>> [   23.096719]  ? urandom_read+0x120/0x270
>>> [   23.096724]  __x64_sys_sendto+0x24/0x30
>>> [   23.096728]  do_syscall_64+0x5b/0x170
>>> [   23.096732]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
>>> [   23.096735] RIP: 0033:0x7fac0b700c12
>>> [   23.096736] Code: 48 83 ec 18 44 89 4c 24 08 e8 9a f5 ff ff 44 8b 4c 24 08 4d 89 f8 45 89 f2 89 c5 4c 89 ea 4c 89 e6 89 df b8 2c 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 3a 89 ef 48 89 44 24 08 e8 ca f5 ff ff 48 8b
>>> [   23.096763] RSP: 002b:00007fffc46321b0 EFLAGS: 00000293 ORIG_RAX: 000000000000002c
>>> [   23.096766] RAX: ffffffffffffffda RBX: 0000000000000011 RCX: 00007fac0b700c12
>>> [   23.096767] RDX: 0000000000000148 RSI: 000055f8a5417c70 RDI: 0000000000000011
>>> [   23.096769] RBP: 0000000000000000 R08: 000055f8a54154c0 R09: 0000000000000014
>>> [   23.096770] R10: 0000000000000000 R11: 0000000000000293 R12: 000055f8a5417c70
>>> [   23.096772] R13: 0000000000000148 R14: 0000000000000000 R15: 000055f8a54154c0
>>> [   23.096775] ---[ end trace 8e7e0aecb937369e ]---
>>> [   23.096792] BUG: using __this_cpu_read() in preemptible [00000000] code: NetworkManager/495
>>> [   23.096795] caller is __local_bh_enable_ip+0x50/0x80
>>> [   23.096798] CPU: 7 PID: 495 Comm: NetworkManager Tainted: G        WC        4.18.0-rc5-staging+ #1
>>> [   23.096799] Hardware name: Gigabyte Technology Co., Ltd. A320M-S2H/A320M-S2H-CF, BIOS F23d 04/17/2018
>>> [   23.096800] Call Trace:
>>> [   23.096804]  dump_stack+0x5c/0x80
>>> [   23.096808]  check_preemption_disabled.cold.0+0x46/0x51
>>> [   23.096812]  __local_bh_enable_ip+0x50/0x80
>>> [   23.096814]  __dev_queue_xmit+0x450/0x910
>>> [   23.096819]  packet_sendmsg+0x945/0x1592
>>> [   23.096823]  ? attach_to_pi_state+0x18/0x110
>>> [   23.096826]  ? preempt_count_sub+0x60/0x90
>>> [   23.096829]  ? ep_item_poll.isra.1+0x40/0xc0
>>> [   23.096833]  sock_sendmsg+0x33/0x40
>>> [   23.096835]  __sys_sendto+0xee/0x160
>>> [   23.096840]  ? memzero_explicit+0xa/0x10
>>> [   23.096842]  ? urandom_read+0x120/0x270
>>> [   23.096845]  __x64_sys_sendto+0x24/0x30
>>> [   23.096848]  do_syscall_64+0x5b/0x170
>>> [   23.096850]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
>>> [   23.096852] RIP: 0033:0x7fac0b700c12
>>> [   23.096853] Code: 48 83 ec 18 44 89 4c 24 08 e8 9a f5 ff ff 44 8b 4c 24 08 4d 89 f8 45 89 f2 89 c5 4c 89 ea 4c 89 e6 89 df b8 2c 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 3a 89 ef 48 89 44 24 08 e8 ca f5 ff ff 48 8b
>>> [   23.096880] RSP: 002b:00007fffc46321b0 EFLAGS: 00000293 ORIG_RAX: 000000000000002c
>>> [   23.096882] RAX: ffffffffffffffda RBX: 0000000000000011 RCX: 00007fac0b700c12
>>> [   23.096885] RDX: 0000000000000148 RSI: 000055f8a5417c70 RDI: 0000000000000011
>>> [   23.096886] RBP: 0000000000000000 R08: 000055f8a54154c0 R09: 0000000000000014
>>> [   23.096888] R10: 0000000000000000 R11: 0000000000000293 R12: 000055f8a5417c70
>>> [   23.096889] R13: 0000000000000148 R14: 0000000000000000 R15: 000055f8a54154c0
>>>
>>>
>>>
>>
>> Hi,
>>
>> I guess in addition to
>> Revert "staging:r8188eu: Use lib80211 to encrypt (TKIP) tx frames"
>>
>> this patch should also be reverted. I still get the above messages in dmesg.
>> With this [1] reverted dmesg looks good.
>>
>> [1]
>> 515ce733e86ee2e1bea4dba76d2d4491013d0f73
>> staging:r8188eu: Use lib80211 to encrypt (CCMP) tx frames
> 
> Can you send me a patch to revert this?

Done. I hope it was not wrong to include the whole dmesg in the commit message.

Michael

