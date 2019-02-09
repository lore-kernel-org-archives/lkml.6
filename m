Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA878C282CB
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 09:10:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 952E321903
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 09:10:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KJABUuaa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727041AbfBIJKX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Feb 2019 04:10:23 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55246 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726985AbfBIJKU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Feb 2019 04:10:20 -0500
Received: by mail-wm1-f67.google.com with SMTP id a62so7539372wmh.4;
        Sat, 09 Feb 2019 01:10:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=tMH2iOuSvDXTvEbHO84NGPH8BrFvmErg8zCQcXwPr1Q=;
        b=KJABUuaar06ZLyg2bzwDBeS4QdllfP75Gno+zNMzVryBmDVOHYi2R6Z6hurGeIlCIO
         5aB9C8C1bSU+vQohKQwi2snaH09phe+dQDmypEMU4j67xk1I/L94E+yQBx3SrY1RUAXg
         athabAB0JwvFGsClj97hgjevtjxVTZT0y6LMmU3cjap/ZXrgEo0qZmsl+gcjcMSilQiX
         VD0YHsiFA/5xYvkgKCYnO7cuV3Vx1xYbeLiIs5p27PAaGWdzTDVsBKWOIJuCoAZaC62Z
         TNC1NAyHoRtjd4PzmoZ/HHRMvuO4n9Mh8linbdtrYe4htysPDG5gbhGQd7i9w5tywNkM
         faew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tMH2iOuSvDXTvEbHO84NGPH8BrFvmErg8zCQcXwPr1Q=;
        b=QInXfuf+Ekuoebl84qf3RfZQDbcvyy8l3HjtXlpK7cD6uituRTn5KkOPShe+Y3wJZ+
         pENp4Njw1+RWgXnbmuaR2jpmt3dsDhTqOwx+PSX64cXm0Jy+ja8js9rl2BrjdjaOddpU
         5I7zklhUyRmvGpScnLC/zlLzoUvwzhZ6lRGweI2Vg2jCPF9yTjjYWQ2NdBY+9tTQqeC7
         T30yd0zfmZCfrXeyEGGtUpbIIZwbZyqGtoc+kfMMo6kU+2R0QqHqpTjHJYmMRiJPnztV
         b3NBkJfI1RzIetygAIypJeeVyP9n6zfbt9lLvAeuXem5I6XO78ywttNumsdwf3smjb1F
         Ldeg==
X-Gm-Message-State: AHQUAuY6vkGHKRkldDopuZUQP/QYBQ1YoC/gnpmX0QRpiI0MbIlnDIEe
        e/LELQQLb2ZxXF9a+bLdjSoJbQ1n
X-Google-Smtp-Source: AHgI3Ia9UagQVyyw5poxIsuSbzw8/G7crThp8xxTM0k9l1MOoCE3CFe0To6gve4OpGrbG/tyYoB3uA==
X-Received: by 2002:adf:dd0d:: with SMTP id a13mr17112048wrm.46.1549703417505;
        Sat, 09 Feb 2019 01:10:17 -0800 (PST)
Received: from ?IPv6:2003:ea:8bf1:e200:aca4:3d:8205:4c97? (p200300EA8BF1E200ACA4003D82054C97.dip0.t-ipconnect.de. [2003:ea:8bf1:e200:aca4:3d:8205:4c97])
        by smtp.googlemail.com with ESMTPSA id t5sm4457039wmg.43.2019.02.09.01.10.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 09 Feb 2019 01:10:16 -0800 (PST)
Subject: Re: Linux 5.0 regression: rtl8169 / kernel BUG at
 lib/dynamic_queue_limits.c:27!
To:     Sander Eikelenboom <linux@eikelenboom.it>,
        Realtek linux nic maintainers <nic_swsd@realtek.com>,
        Eric Dumazet <edumazet@google.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>
References: <6c389fde-4c8d-300b-8c3c-300d6105c30a@eikelenboom.it>
 <0f605e50-56fe-06b5-9b66-6aed89a608ce@gmail.com>
 <471e550b-c227-22e6-19fd-5f9abd450e5f@eikelenboom.it>
 <1265d424-4943-e571-a74b-b1512ebec179@gmail.com>
 <059e59c6-2264-fd5c-068f-3656e39539c1@eikelenboom.it>
 <140d0df7-1775-5457-aa03-b21ece250a72@gmail.com>
 <7084be7a-c279-080d-d1ec-cd604f2b2b14@eikelenboom.it>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Message-ID: <1aa18ef6-7f1d-6a93-c4b8-ed98217f4740@gmail.com>
Date:   Sat, 9 Feb 2019 10:10:05 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <7084be7a-c279-080d-d1ec-cd604f2b2b14@eikelenboom.it>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09.02.2019 00:34, Sander Eikelenboom wrote:
> On 08/02/2019 22:50, Heiner Kallweit wrote:
>> On 08.02.2019 22:45, Sander Eikelenboom wrote:
>>> On 08/02/2019 22:22, Heiner Kallweit wrote:
>>>> On 08.02.2019 21:55, Sander Eikelenboom wrote:
>>>>> On 08/02/2019 19:52, Heiner Kallweit wrote:
>>>>>> On 08.02.2019 19:29, Sander Eikelenboom wrote:
>>>>>>> L.S.,
>>>>>>>
>>>>>>> While testing a linux 5.0-rc5 kernel (with some patches on top but they don't seem related) under Xen i the nasty splat below, 
>>>>>>> that I haven encountered with Linux 4.20.x.
>>>>>>>
>>>>>>> Unfortunately I haven't got a clear reproducer for this and bisecting could be nasty due to another (networking related) kernel bug.
>>>>>>>
>>>>>>> If you need more info, want me to run a debug patch etc., please feel free to ask.
>>>>>>>
>>>>>> Thanks for the report. However I see no change in the r8169 driver between
>>>>>> 4.20 and 5.0 with regard to BQL code. Having said that the root cause could
>>>>>> be somewhere else. Therefore I'm afraid a bisect will be needed.
>>>>>
>>>>> Hmm i did some diging and i think:
>>>>> bd7153bd83b806bfcc2e79b7a6f43aa653d06ef3 r8169: remove unneeded mmiowb barriers
>>>>> 2e6eedb4813e34d8d84ac0eb3afb668966f3f356 r8169: make use of xmit_more and __netdev_sent_queue
>>>>> 620344c43edfa020bbadfd81a144ebe5181fc94f net: core: add __netdev_sent_queue as variant of __netdev_tx_sent_queue
>>>>>
>>>> You're right. Thought this was added in 4.20 already.
>>>> The BQL code pattern I copied from the mlx4 driver and so far I haven't heard about
>>>> this issue from any user of physical hw. And due to the fact that a lot of mainboards
>>>> have onboard Realtek network I have quite a few testers out there.
>>>> Does the issue occur under specific circumstances like very high load?
>>>
>>> Yep, the box is already quite contented with the Xen VM's and if I remember correctly it occurred while kernel compiling
>>> on the host.
>>>
>>>> If indeed the xmit_more patch causes the issue, I think we have to involve Eric Dumazet
>>>> as author of the underlying changes.
>>>
>>> It could also be the barriers weren't that unneeded as assumed.
>>
>> The barriers were removed after adding xmit_more handling. Therefore it would be good to
>> test also with only 
>> bd7153bd83b806bfcc2e79b7a6f43aa653d06ef3 r8169: remove unneeded mmiowb barriers
>> removed.
> 
> *arghh* *grmbl*
> 
> with both:
>     bd7153bd83b806bfcc2e79b7a6f43aa653d06ef3
>     and
>     2e6eedb4813e34d8d84ac0eb3afb668966f3f356 
> reverted i get yet another splat:
> 
Puh, I'm not a memory management expert. The traces include also a failed memory
allocation from a file system operation. Maybe the system is going low on memory?
The issue occurs so deep in the memory mgmt, that I wonder if and how this could
be caused by the network driver.


> [ 3769.246083] ld: page allocation failure: order:0, mode:0x480020(GFP_ATOMIC), nodemask=(null),cpuset=/,mems_allowed=0
> [ 3769.246095] CPU: 2 PID: 3201 Comm: ld Not tainted 5.0.0-rc5-20190208-thp-net-florian-rtl8169-doflr+ #1
> [ 3769.246096] Hardware name: MSI MS-7640/890FXA-GD70 (MS-7640)  , BIOS V1.8B1 09/13/2010
> [ 3769.246098] Call Trace:
> [ 3769.246104]  <IRQ>
> [ 3769.246114]  dump_stack+0x5c/0x7b
> [ 3769.246120]  warn_alloc+0x103/0x190
> [ 3769.246122]  __alloc_pages_nodemask+0xe3d/0xe80
> [ 3769.246128]  ? inet_gro_receive+0x232/0x2c0
> [ 3769.246130]  page_frag_alloc+0x117/0x150
> [ 3769.246132]  __napi_alloc_skb+0x83/0xd0
> [ 3769.246137]  rtl8169_poll+0x210/0x640
> [ 3769.246140]  net_rx_action+0x23d/0x370
> [ 3769.246145]  __do_softirq+0xed/0x229
> [ 3769.246149]  irq_exit+0xb7/0xc0
> [ 3769.246152]  xen_evtchn_do_upcall+0x27/0x40
> [ 3769.246154]  xen_do_hypervisor_callback+0x29/0x40
> [ 3769.246155]  </IRQ>
> [ 3769.246161] RIP: e030:__pv_queued_spin_lock_slowpath+0xda/0x280
> [ 3769.246163] Code: 14 41 bc 01 00 00 00 41 bd 00 01 00 00 3c 02 0f 94 c0 0f b6 c0 48 89 04 24 c6 45 14 00 ba 00 80 00 00 c6 43 01 01 eb 0b f3 90 <83> ea 01 0f 84 49 01 00 00 0f b6 03 84 c0 75 ee 44 89 e8 f0 66 44
> [ 3769.246164] RSP: e02b:ffffc90005b0f780 EFLAGS: 00000202
> [ 3769.246166] RAX: 0000000000000001 RBX: ffff8880047c9200 RCX: 0000000000000001
> [ 3769.246167] RDX: 0000000000007d75 RSI: 0000000000000000 RDI: ffff8880047c9200
> [ 3769.246167] RBP: ffff88807d4a1a80 R08: ffffc90005b0f978 R09: ffffc90005b0f978
> [ 3769.246168] R10: ffffc90005b0f9d0 R11: ffff88807fc17000 R12: 0000000000000001
> [ 3769.246169] R13: 0000000000000100 R14: 0000000000000000 R15: 00000000000c0000
> [ 3769.246173]  _raw_spin_lock+0x16/0x20
> [ 3769.246176]  list_lru_add+0x59/0x170
> [ 3769.246179]  inode_lru_list_add+0x1b/0x40
> [ 3769.246182]  iput+0x18b/0x1a0
> [ 3769.246184]  __dentry_kill+0xc5/0x170
> [ 3769.246186]  shrink_dentry_list+0x93/0x1c0
> [ 3769.246187]  prune_dcache_sb+0x4d/0x70
> [ 3769.246191]  super_cache_scan+0x104/0x190
> [ 3769.246194]  do_shrink_slab+0x12c/0x1e0
> [ 3769.246196]  shrink_slab+0xdf/0x2b0
> [ 3769.246198]  shrink_node+0x158/0x470
> [ 3769.246200]  do_try_to_free_pages+0xd1/0x380
> [ 3769.246202]  try_to_free_pages+0xb2/0xe0
> [ 3769.246204]  __alloc_pages_nodemask+0x603/0xe80
> [ 3769.246207]  ? xas_load+0x9/0x80
> [ 3769.246209]  ? find_get_entry+0x58/0x120
> [ 3769.246210]  pagecache_get_page+0xde/0x210
> [ 3769.246213]  grab_cache_page_write_begin+0x17/0x30
> [ 3769.246215]  ext4_da_write_begin+0xc4/0x340
> [ 3769.246217]  generic_perform_write+0xb8/0x1b0
> [ 3769.246219]  __generic_file_write_iter+0x13c/0x1b0
> [ 3769.246223]  ext4_file_write_iter+0x121/0x3c0
> [ 3769.246225]  __vfs_write+0x123/0x1a0
> [ 3769.246226]  vfs_write+0xab/0x1a0
> [ 3769.246229]  ksys_write+0x4d/0xc0
> [ 3769.246232]  do_syscall_64+0x49/0x100
> [ 3769.246234]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [ 3769.246237] RIP: 0033:0x7fee5b265730
> [ 3769.246238] Code: 73 01 c3 48 8b 0d 68 d7 2b 00 f7 d8 64 89 01 48 83 c8 ff c3 66 0f 1f 44 00 00 83 3d d9 2f 2c 00 00 75 10 b8 01 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 31 c3 48 83 ec 08 e8 7e 9b 01 00 48 89 04 24
> [ 3769.246239] RSP: 002b:00007fff33183dd8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
> [ 3769.246240] RAX: ffffffffffffffda RBX: 0000000000000710 RCX: 00007fee5b265730
> [ 3769.246241] RDX: 0000000000000710 RSI: 000055559bed78b0 RDI: 0000000000000049
> [ 3769.246241] RBP: 000055559bed78b0 R08: 0000000000000b40 R09: 0000000001c0320c
> [ 3769.246242] R10: 00007fee5be91e80 R11: 0000000000000246 R12: 0000000000000710
> [ 3769.246243] R13: 0000000000000001 R14: 00005555a2690050 R15: 0000000000000710
> [ 3769.246244] Mem-Info:
> [ 3769.246249] active_anon:152383 inactive_anon:99216 isolated_anon:0
>                 active_file:51569 inactive_file:85922 isolated_file:0
>                 unevictable:552 dirty:6866 writeback:0 unstable:0
>                 slab_reclaimable:6707 slab_unreclaimable:16166
>                 mapped:1870 shmem:6 pagetables:2716 bounce:0
>                 free:3639 free_pcp:900 free_cma:0
> [ 3769.246252] Node 0 active_anon:609532kB inactive_anon:396864kB active_file:206276kB inactive_file:343688kB unevictable:2208kB isolated(anon):0kB isolated(file):0kB mapped:7480kB dirty:27464kB writeback:0kB shmem:24kB shmem_thp: 0kB shmem_pmdmapped: 0kB anon_thp: 0kB writeback_tmp:0kB unstable:0kB all_unreclaimable? no
> [ 3769.246253] Node 0 DMA free:7480kB min:44kB low:56kB high:68kB active_anon:8056kB inactive_anon:0kB active_file:92kB inactive_file:148kB unevictable:0kB writepending:8kB present:15956kB managed:15872kB mlocked:0kB kernel_stack:0kB pagetables:20kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
> [ 3769.246256] lowmem_reserve[]: 0 1865 1865 1865
> [ 3769.246258] Node 0 DMA32 free:7076kB min:19472kB low:21380kB high:23288kB active_anon:601840kB inactive_anon:396512kB active_file:206216kB inactive_file:343644kB unevictable:2208kB writepending:27256kB present:2080768kB managed:1833792kB mlocked:2208kB kernel_stack:9392kB pagetables:10844kB bounce:0kB free_pcp:3600kB local_pcp:596kB free_cma:0kB
> [ 3769.246260] lowmem_reserve[]: 0 0 0 0
> [ 3769.246262] Node 0 DMA: 6*4kB (UE) 4*8kB (UME) 4*16kB (UME) 2*32kB (UE) 6*64kB (UE) 2*128kB (UM) 4*256kB (UME) 3*512kB (UME) 2*1024kB (ME) 1*2048kB (M) 0*4096kB = 7480kB
> [ 3769.246267] Node 0 DMA32: 66*4kB (UM) 271*8kB (UME) 218*16kB (UME) 45*32kB (UME) 0*64kB 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 7360kB
> [ 3769.246272] 144878 total pagecache pages
> [ 3769.246276] 6812 pages in swap cache
> [ 3769.246277] Swap cache stats: add 62616, delete 55806, find 31/55
> [ 3769.246278] Free swap  = 3943164kB
> [ 3769.246278] Total swap = 4194300kB
> [ 3769.246279] 524181 pages RAM
> [ 3769.246279] 0 pages HighMem/MovableOnly
> [ 3769.246280] 61765 pages reserved
> [ 3769.246280] 0 pages cma reserved
> [ 3769.246284] ld: page allocation failure: order:0, mode:0x480020(GFP_ATOMIC), nodemask=(null),cpuset=/,mems_allowed=0
> [ 3769.246286] CPU: 2 PID: 3201 Comm: ld Not tainted 5.0.0-rc5-20190208-thp-net-florian-rtl8169-doflr+ #1
> [ 3769.246287] Hardware name: MSI MS-7640/890FXA-GD70 (MS-7640)  , BIOS V1.8B1 09/13/2010
> [ 3769.246287] Call Trace:
> [ 3769.246288]  <IRQ>
> [ 3769.246290]  dump_stack+0x5c/0x7b
> [ 3769.246291]  warn_alloc+0x103/0x190
> [ 3769.246293]  __alloc_pages_nodemask+0xe3d/0xe80
> [ 3769.246294]  ? inet_gro_receive+0x232/0x2c0
> [ 3769.246296]  page_frag_alloc+0x117/0x150
> [ 3769.246297]  __napi_alloc_skb+0x83/0xd0
> [ 3769.246299]  rtl8169_poll+0x210/0x640
> [ 3769.246300]  net_rx_action+0x23d/0x370
> [ 3769.246302]  __do_softirq+0xed/0x229
> [ 3769.246304]  irq_exit+0xb7/0xc0
> [ 3769.246305]  xen_evtchn_do_upcall+0x27/0x40
> [ 3769.246306]  xen_do_hypervisor_callback+0x29/0x40
> [ 3769.246307]  </IRQ>
> [ 3769.246308] RIP: e030:__pv_queued_spin_lock_slowpath+0xda/0x280
> [ 3769.246310] Code: 14 41 bc 01 00 00 00 41 bd 00 01 00 00 3c 02 0f 94 c0 0f b6 c0 48 89 04 24 c6 45 14 00 ba 00 80 00 00 c6 43 01 01 eb 0b f3 90 <83> ea 01 0f 84 49 01 00 00 0f b6 03 84 c0 75 ee 44 89 e8 f0 66 44
> [ 3769.246310] RSP: e02b:ffffc90005b0f780 EFLAGS: 00000202
> [ 3769.246311] RAX: 0000000000000001 RBX: ffff8880047c9200 RCX: 0000000000000001
> [ 3769.246312] RDX: 0000000000007d75 RSI: 0000000000000000 RDI: ffff8880047c9200
> [ 3769.246313] RBP: ffff88807d4a1a80 R08: ffffc90005b0f978 R09: ffffc90005b0f978
> [ 3769.246313] R10: ffffc90005b0f9d0 R11: ffff88807fc17000 R12: 0000000000000001
> [ 3769.246314] R13: 0000000000000100 R14: 0000000000000000 R15: 00000000000c0000
> [ 3769.246316]  _raw_spin_lock+0x16/0x20
> [ 3769.246317]  list_lru_add+0x59/0x170
> [ 3769.246318]  inode_lru_list_add+0x1b/0x40
> [ 3769.246320]  iput+0x18b/0x1a0
> [ 3769.246321]  __dentry_kill+0xc5/0x170
> [ 3769.246322]  shrink_dentry_list+0x93/0x1c0
> [ 3769.246323]  prune_dcache_sb+0x4d/0x70
> [ 3769.246325]  super_cache_scan+0x104/0x190
> [ 3769.246326]  do_shrink_slab+0x12c/0x1e0
> [ 3769.246328]  shrink_slab+0xdf/0x2b0
> [ 3769.246329]  shrink_node+0x158/0x470
> [ 3769.246331]  do_try_to_free_pages+0xd1/0x380
> [ 3769.246333]  try_to_free_pages+0xb2/0xe0
> [ 3769.246334]  __alloc_pages_nodemask+0x603/0xe80
> [ 3769.246336]  ? xas_load+0x9/0x80
> [ 3769.246337]  ? find_get_entry+0x58/0x120
> [ 3769.246338]  pagecache_get_page+0xde/0x210
> [ 3769.246340]  grab_cache_page_write_begin+0x17/0x30
> [ 3769.246341]  ext4_da_write_begin+0xc4/0x340
> [ 3769.246342]  generic_perform_write+0xb8/0x1b0
> [ 3769.246344]  __generic_file_write_iter+0x13c/0x1b0
> [ 3769.246345]  ext4_file_write_iter+0x121/0x3c0
> [ 3769.246347]  __vfs_write+0x123/0x1a0
> [ 3769.246348]  vfs_write+0xab/0x1a0
> [ 3769.246349]  ksys_write+0x4d/0xc0
> [ 3769.246350]  do_syscall_64+0x49/0x100
> [ 3769.246352]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [ 3769.246353] RIP: 0033:0x7fee5b265730
> [ 3769.246354] Code: 73 01 c3 48 8b 0d 68 d7 2b 00 f7 d8 64 89 01 48 83 c8 ff c3 66 0f 1f 44 00 00 83 3d d9 2f 2c 00 00 75 10 b8 01 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 31 c3 48 83 ec 08 e8 7e 9b 01 00 48 89 04 24
> [ 3769.246354] RSP: 002b:00007fff33183dd8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
> [ 3769.246355] RAX: ffffffffffffffda RBX: 0000000000000710 RCX: 00007fee5b265730
> [ 3769.246356] RDX: 0000000000000710 RSI: 000055559bed78b0 RDI: 0000000000000049
> [ 3769.246357] RBP: 000055559bed78b0 R08: 0000000000000b40 R09: 0000000001c0320c
> [ 3769.246357] R10: 00007fee5be91e80 R11: 0000000000000246 R12: 0000000000000710
> [ 3769.246358] R13: 0000000000000001 R14: 00005555a2690050 R15: 0000000000000710
> [ 3769.246364] ld: page allocation failure: order:0, mode:0x480020(GFP_ATOMIC), nodemask=(null),cpuset=/,mems_allowed=0
> [ 3769.246366] CPU: 2 PID: 3201 Comm: ld Not tainted 5.0.0-rc5-20190208-thp-net-florian-rtl8169-doflr+ #1
> [ 3769.246366] Hardware name: MSI MS-7640/890FXA-GD70 (MS-7640)  , BIOS V1.8B1 09/13/2010
> [ 3769.246366] Call Trace:
> [ 3769.246367]  <IRQ>
> [ 3769.246368]  dump_stack+0x5c/0x7b
> [ 3769.246370]  warn_alloc+0x103/0x190
> [ 3769.246371]  __alloc_pages_nodemask+0xe3d/0xe80
> [ 3769.246373]  ? inet_gro_receive+0x232/0x2c0
> [ 3769.246374]  page_frag_alloc+0x117/0x150
> [ 3769.246375]  __napi_alloc_skb+0x83/0xd0
> [ 3769.246376]  rtl8169_poll+0x210/0x640
> [ 3769.246378]  net_rx_action+0x23d/0x370
> [ 3769.246379]  __do_softirq+0xed/0x229
> [ 3769.246381]  irq_exit+0xb7/0xc0
> [ 3769.246382]  xen_evtchn_do_upcall+0x27/0x40
> [ 3769.246383]  xen_do_hypervisor_callback+0x29/0x40
> [ 3769.246383]  </IRQ>
> [ 3769.246385] RIP: e030:__pv_queued_spin_lock_slowpath+0xda/0x280
> [ 3769.246386] Code: 14 41 bc 01 00 00 00 41 bd 00 01 00 00 3c 02 0f 94 c0 0f b6 c0 48 89 04 24 c6 45 14 00 ba 00 80 00 00 c6 43 01 01 eb 0b f3 90 <83> ea 01 0f 84 49 01 00 00 0f b6 03 84 c0 75 ee 44 89 e8 f0 66 44
> [ 3769.246387] RSP: e02b:ffffc90005b0f780 EFLAGS: 00000202
> [ 3769.246388] RAX: 0000000000000001 RBX: ffff8880047c9200 RCX: 0000000000000001
> [ 3769.246388] RDX: 0000000000007d75 RSI: 0000000000000000 RDI: ffff8880047c9200
> [ 3769.246389] RBP: ffff88807d4a1a80 R08: ffffc90005b0f978 R09: ffffc90005b0f978
> [ 3769.246390] R10: ffffc90005b0f9d0 R11: ffff88807fc17000 R12: 0000000000000001
> [ 3769.246390] R13: 0000000000000100 R14: 0000000000000000 R15: 00000000000c0000
> [ 3769.246392]  _raw_spin_lock+0x16/0x20
> [ 3769.246393]  list_lru_add+0x59/0x170
> [ 3769.246395]  inode_lru_list_add+0x1b/0x40
> [ 3769.246396]  iput+0x18b/0x1a0
> [ 3769.246397]  __dentry_kill+0xc5/0x170
> [ 3769.246398]  shrink_dentry_list+0x93/0x1c0
> [ 3769.246399]  prune_dcache_sb+0x4d/0x70
> [ 3769.246401]  super_cache_scan+0x104/0x190
> [ 3769.246402]  do_shrink_slab+0x12c/0x1e0
> [ 3769.246404]  shrink_slab+0xdf/0x2b0
> [ 3769.246405]  shrink_node+0x158/0x470
> [ 3769.246407]  do_try_to_free_pages+0xd1/0x380
> [ 3769.246408]  try_to_free_pages+0xb2/0xe0
> [ 3769.246410]  __alloc_pages_nodemask+0x603/0xe80
> [ 3769.246411]  ? xas_load+0x9/0x80
> [ 3769.246413]  ? find_get_entry+0x58/0x120
> [ 3769.246414]  pagecache_get_page+0xde/0x210
> [ 3769.246415]  grab_cache_page_write_begin+0x17/0x30
> [ 3769.246416]  ext4_da_write_begin+0xc4/0x340
> [ 3769.246418]  generic_perform_write+0xb8/0x1b0
> [ 3769.246420]  __generic_file_write_iter+0x13c/0x1b0
> [ 3769.246421]  ext4_file_write_iter+0x121/0x3c0
> [ 3769.246422]  __vfs_write+0x123/0x1a0
> [ 3769.246423]  vfs_write+0xab/0x1a0
> [ 3769.246424]  ksys_write+0x4d/0xc0
> [ 3769.246426]  do_syscall_64+0x49/0x100
> [ 3769.246427]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [ 3769.246428] RIP: 0033:0x7fee5b265730
> [ 3769.246429] Code: 73 01 c3 48 8b 0d 68 d7 2b 00 f7 d8 64 89 01 48 83 c8 ff c3 66 0f 1f 44 00 00 83 3d d9 2f 2c 00 00 75 10 b8 01 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 31 c3 48 83 ec 08 e8 7e 9b 01 00 48 89 04 24
> [ 3769.246430] RSP: 002b:00007fff33183dd8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
> [ 3769.246431] RAX: ffffffffffffffda RBX: 0000000000000710 RCX: 00007fee5b265730
> [ 3769.246431] RDX: 0000000000000710 RSI: 000055559bed78b0 RDI: 0000000000000049
> [ 3769.246432] RBP: 000055559bed78b0 R08: 0000000000000b40 R09: 0000000001c0320c
> [ 3769.246433] R10: 00007fee5be91e80 R11: 0000000000000246 R12: 0000000000000710
> [ 3769.246433] R13: 0000000000000001 R14: 00005555a2690050 R15: 0000000000000710
> 
> 
>  
>>> Since we are almost at RC6 i took the liberty to CC Eric now.
>>>
>> Sure, thanks.
>>
>>> BTW am i correct these patches are merely optimizations ?
>>
>> Yes
>>
>>> If so and concluding they revert cleanly, perhaps it should be considered at this point in the RC's
>>> to revert them for 5.0 and try again for 5.1 ?
>>>
>> Before removing both it would be good to test with only the barrier-removal removed.
>>
>>> --
>>> Sander
>>>
>> Heiner
>>
>>>
>>>>
>>>>> would be candidates, which were merged in 5.0.
>>>>>
>>>>> I have reverted the first two, see how that works out.
>>>>>
>>>>> --
>>>>> Sander
>>>>>
>>>> Heiner
>>>>
>>>>>  
>>>>>>> --
>>>>>>> Sander
>>>>>>>
>>>>>> Heiner
>>>>>>
>>>>>>>
>>>>>>> [ 6466.554866] kernel BUG at lib/dynamic_queue_limits.c:27!
>>>>>>> [ 6466.571425] invalid opcode: 0000 [#1] SMP NOPTI
>>>>>>> [ 6466.585890] CPU: 3 PID: 7057 Comm: as Not tainted 5.0.0-rc5-20190208-thp-net-florian-doflr+ #1
>>>>>>> [ 6466.598693] Hardware name: MSI MS-7640/890FXA-GD70 (MS-7640)  , BIOS V1.8B1 09/13/2010
>>>>>>> [ 6466.611579] RIP: e030:dql_completed+0x126/0x140
>>>>>>> [ 6466.624339] Code: 2b 47 54 ba 00 00 00 00 c7 47 54 ff ff ff ff 0f 48 c2 48 8b 15 7b 39 4a 01 48 89 57 58 e9 48 ff ff ff 44 89 c0 e9 40 ff ff ff <0f> 0b 8b 47 50 29 e8 41 0f 48 c3 eb 9f 90 90 90 90 90 90 90 90 90
>>>>>>> [ 6466.648130] RSP: e02b:ffff88807d4c3e78 EFLAGS: 00010297
>>>>>>> [ 6466.659616] RAX: 0000000000000042 RBX: ffff8880049cf800 RCX: 0000000000000000
>>>>>>> [ 6466.672835] RDX: 0000000000000001 RSI: 0000000000000042 RDI: ffff8880049cf8c0
>>>>>>> [ 6466.684521] RBP: ffff888077df7260 R08: 0000000000000001 R09: 0000000000000000
>>>>>>> [ 6466.696824] R10: 00000000387c2336 R11: 00000000387c2336 R12: 0000000010000000
>>>>>>> [ 6466.709953] R13: ffff888077df6898 R14: ffff888077df75c0 R15: 0000000000454677
>>>>>>> [ 6466.722165] FS:  00007fd869147200(0000) GS:ffff88807d4c0000(0000) knlGS:0000000000000000
>>>>>>> [ 6466.733228] CS:  e030 DS: 0000 ES: 0000 CR0: 0000000080050033
>>>>>>> [ 6466.746581] CR2: 00007fd867dfd000 CR3: 0000000074884000 CR4: 0000000000000660
>>>>>>> [ 6466.758366] Call Trace:
>>>>>>> [ 6466.768118]  <IRQ>
>>>>>>> [ 6466.778214]  rtl8169_poll+0x4f4/0x640
>>>>>>> [ 6466.789198]  net_rx_action+0x23d/0x370
>>>>>>> [ 6466.798467]  __do_softirq+0xed/0x229
>>>>>>> [ 6466.807039]  irq_exit+0xb7/0xc0
>>>>>>> [ 6466.815471]  xen_evtchn_do_upcall+0x27/0x40
>>>>>>> [ 6466.826647]  xen_do_hypervisor_callback+0x29/0x40
>>>>>>> [ 6466.835902]  </IRQ>
>>>>>>> [ 6466.845361] RIP: e030:xen_hypercall_mmu_update+0xa/0x20
>>>>>>> [ 6466.853390] Code: 51 41 53 b8 00 00 00 00 0f 05 41 5b 59 c3 cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc 51 41 53 b8 01 00 00 00 0f 05 <41> 5b 59 c3 cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc
>>>>>>> [ 6466.874031] RSP: e02b:ffffc90003c0bdd0 EFLAGS: 00000246
>>>>>>> [ 6466.883452] RAX: 0000000000000000 RBX: 000000041f83bfe8 RCX: ffffffff8100102a
>>>>>>> [ 6466.891986] RDX: deadbeefdeadf00d RSI: deadbeefdeadf00d RDI: deadbeefdeadf00d
>>>>>>> [ 6466.903402] RBP: 0000000000000fe8 R08: 000000000000000b R09: 0000000000000000
>>>>>>> [ 6466.911201] R10: deadbeefdeadf00d R11: 0000000000000246 R12: 800000050c346067
>>>>>>> [ 6466.918491] R13: ffff8880607c4fe8 R14: ffff888005082800 R15: 0000000000000000
>>>>>>> [ 6466.926647]  ? xen_hypercall_mmu_update+0xa/0x20
>>>>>>> [ 6466.938195]  ? xen_set_pte_at+0x78/0xe0
>>>>>>> [ 6466.947046]  ? __handle_mm_fault+0xc43/0x1060
>>>>>>> [ 6466.955772]  ? do_mmap+0x44b/0x5b0
>>>>>>> [ 6466.964410]  ? handle_mm_fault+0xf8/0x200
>>>>>>> [ 6466.973290]  ? __do_page_fault+0x231/0x4a0
>>>>>>> [ 6466.981973]  ? page_fault+0x8/0x30
>>>>>>> [ 6466.990904]  ? page_fault+0x1e/0x30
>>>>>>> [ 6466.999585] Modules linked in:
>>>>>>> [ 6467.007533] ---[ end trace 94bec01608fe4061 ]---
>>>>>>> [ 6467.016751] RIP: e030:dql_completed+0x126/0x140
>>>>>>> [ 6467.024271] Code: 2b 47 54 ba 00 00 00 00 c7 47 54 ff ff ff ff 0f 48 c2 48 8b 15 7b 39 4a 01 48 89 57 58 e9 48 ff ff ff 44 89 c0 e9 40 ff ff ff <0f> 0b 8b 47 50 29 e8 41 0f 48 c3 eb 9f 90 90 90 90 90 90 90 90 90
>>>>>>> [ 6467.039726] RSP: e02b:ffff88807d4c3e78 EFLAGS: 00010297
>>>>>>> [ 6467.047243] RAX: 0000000000000042 RBX: ffff8880049cf800 RCX: 0000000000000000
>>>>>>> [ 6467.054202] RDX: 0000000000000001 RSI: 0000000000000042 RDI: ffff8880049cf8c0
>>>>>>> [ 6467.062000] RBP: ffff888077df7260 R08: 0000000000000001 R09: 0000000000000000
>>>>>>> [ 6467.069664] R10: 00000000387c2336 R11: 00000000387c2336 R12: 0000000010000000
>>>>>>> [ 6467.077715] R13: ffff888077df6898 R14: ffff888077df75c0 R15: 0000000000454677
>>>>>>> [ 6467.084916] FS:  00007fd869147200(0000) GS:ffff88807d4c0000(0000) knlGS:0000000000000000
>>>>>>> [ 6467.093352] CS:  e030 DS: 0000 ES: 0000 CR0: 0000000080050033
>>>>>>> [ 6467.101492] CR2: 00007fd867dfd000 CR3: 0000000074884000 CR4: 0000000000000660
>>>>>>> [ 6467.110542] Kernel panic - not syncing: Fatal exception in interrupt
>>>>>>> [ 6467.118166] Kernel Offset: disabled
>>>>>>> (XEN) [2019-02-08 18:04:48.854] Hardware Dom0 crashed: rebooting machine in 5 seconds.
>>>>>>>
>>>>>>
>>>>>
>>>>>
>>>>
>>>
>>>
>>
> 
> 

