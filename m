Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 739C8C282C4
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 09:59:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20A4520857
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 09:59:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cBMutbYk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726932AbfBIJ7y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Feb 2019 04:59:54 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51568 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726704AbfBIJ7x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Feb 2019 04:59:53 -0500
Received: by mail-wm1-f68.google.com with SMTP id b11so7725996wmj.1;
        Sat, 09 Feb 2019 01:59:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Hmh+TCYMlOeS4F/wLeUBjyPnZJZRYLyuvOiE/Cjd9zg=;
        b=cBMutbYkexKaTcR6GeNulog5narGdueAf6o/8aox49tUJaASLkLDnVvTuY1zWELjD5
         Qw5s+WcQOAQ5PJL71EwoWCXeVgcmYD/VPRMLKLhVhQo7vNpOccu19B0cc1JJGHd1uIUx
         Q/Tt9Z/kmrF/XD3KKZr9ay+9Up48wXGRySA/W2Qpma5meF9Zgs20t5Hn8+lrSD51z523
         mHcY3Q9J/obtuw6xzJw3nRE+FdoRsof8C1xutLJAd0zGpRw2qQ5q2dgxBn8eVh0U7aLf
         O5z68qSkxpTnPeezwuqY5msAiwns7okawLNJzLi5njyd6isNlt46uHZu6/1swL8L3eF7
         6cEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Hmh+TCYMlOeS4F/wLeUBjyPnZJZRYLyuvOiE/Cjd9zg=;
        b=gKMXQUhaNqhSjc0Nx0fWYlSLRQza29O353VFhkL21CJln+KtDvsCt+UdC55NDzS2sK
         pNVkwZN7B9bDZro0sQR9IHda4BZUkeUQu0E7h52H7pyFby6TSNgAt5NzpGthSTQkcPZB
         /Mtijm3JKvL/CLcGcC/v88yHBaYYNPX/I1MEpOnMVd+ofYLGBfjJtOR90XQzo7o0bvDs
         80F1eGquvGNPe9o80ZM/5tVvV3ejk1hwwLSQeoHKjNnNIT8GAdvZsvl1GcDAkhIpOoKc
         bYuT4bOeGdVLMDc7t/So/2aAPvLO+rpO3fDoTX2tURiv2teSqymDWrLxXq2S/7JBMkSA
         H51Q==
X-Gm-Message-State: AHQUAuajSmYC7XUCiJIeepGZ60mdjiiO6EdiVWtSBoD85Q6BfvNP0gdZ
        EHAwbqsASCYSg075rAEij7AcG0kj
X-Google-Smtp-Source: AHgI3Ib79fNnME7zfoz97Et4RG9UcgBHKEIz4SH6j/Vm1zNuCfdDbG0AliIWMPnA56+qx+C51KNJNg==
X-Received: by 2002:adf:b648:: with SMTP id i8mr3499610wre.319.1549706389839;
        Sat, 09 Feb 2019 01:59:49 -0800 (PST)
Received: from ?IPv6:2003:ea:8bf1:e200:aca4:3d:8205:4c97? (p200300EA8BF1E200ACA4003D82054C97.dip0.t-ipconnect.de. [2003:ea:8bf1:e200:aca4:3d:8205:4c97])
        by smtp.googlemail.com with ESMTPSA id l12sm2390811wrt.87.2019.02.09.01.59.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 09 Feb 2019 01:59:49 -0800 (PST)
Subject: Re: Linux 5.0 regression: rtl8169 / kernel BUG at
 lib/dynamic_queue_limits.c:27!
To:     Sander Eikelenboom <linux@eikelenboom.it>,
        Eric Dumazet <eric.dumazet@gmail.com>,
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
 <e6423f51-42cc-e49f-bb48-85ea922f01b6@gmail.com>
 <aa7eb814-ebf7-ffa5-ce61-317b9bbf2394@gmail.com>
 <6b4e8aa0-03c5-c0a8-439e-77daabb07416@eikelenboom.it>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Message-ID: <70e9a3fe-158a-c3a2-a427-2343bc6c9031@gmail.com>
Date:   Sat, 9 Feb 2019 10:59:40 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <6b4e8aa0-03c5-c0a8-439e-77daabb07416@eikelenboom.it>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09.02.2019 10:34, Sander Eikelenboom wrote:
> On 09/02/2019 10:02, Heiner Kallweit wrote:
>> On 09.02.2019 00:09, Eric Dumazet wrote:
>>>
>>>
>>> On 02/08/2019 01:50 PM, Heiner Kallweit wrote:
>>>> On 08.02.2019 22:45, Sander Eikelenboom wrote:
>>>>> On 08/02/2019 22:22, Heiner Kallweit wrote:
>>>>>> On 08.02.2019 21:55, Sander Eikelenboom wrote:
>>>>>>> On 08/02/2019 19:52, Heiner Kallweit wrote:
>>>>>>>> On 08.02.2019 19:29, Sander Eikelenboom wrote:
>>>>>>>>> L.S.,
>>>>>>>>>
>>>>>>>>> While testing a linux 5.0-rc5 kernel (with some patches on top but they don't seem related) under Xen i the nasty splat below, 
>>>>>>>>> that I haven encountered with Linux 4.20.x.
>>>>>>>>>
>>>>>>>>> Unfortunately I haven't got a clear reproducer for this and bisecting could be nasty due to another (networking related) kernel bug.
>>>>>>>>>
>>>>>>>>> If you need more info, want me to run a debug patch etc., please feel free to ask.
>>>>>>>>>
>>>>>>>> Thanks for the report. However I see no change in the r8169 driver between
>>>>>>>> 4.20 and 5.0 with regard to BQL code. Having said that the root cause could
>>>>>>>> be somewhere else. Therefore I'm afraid a bisect will be needed.
>>>>>>>
>>>>>>> Hmm i did some diging and i think:
>>>>>>> bd7153bd83b806bfcc2e79b7a6f43aa653d06ef3 r8169: remove unneeded mmiowb barriers
>>>>>>> 2e6eedb4813e34d8d84ac0eb3afb668966f3f356 r8169: make use of xmit_more and __netdev_sent_queue
>>>>>>> 620344c43edfa020bbadfd81a144ebe5181fc94f net: core: add __netdev_sent_queue as variant of __netdev_tx_sent_queue
>>>>>>>
>>>>>> You're right. Thought this was added in 4.20 already.
>>>>>> The BQL code pattern I copied from the mlx4 driver and so far I haven't heard about
>>>>>> this issue from any user of physical hw. And due to the fact that a lot of mainboards
>>>>>> have onboard Realtek network I have quite a few testers out there.
>>>>>> Does the issue occur under specific circumstances like very high load?
>>>>>
>>>>> Yep, the box is already quite contented with the Xen VM's and if I remember correctly it occurred while kernel compiling
>>>>> on the host.
>>>>>
>>>>>> If indeed the xmit_more patch causes the issue, I think we have to involve Eric Dumazet
>>>>>> as author of the underlying changes.
>>>>>
>>>>> It could also be the barriers weren't that unneeded as assumed.
>>>>
>>>> The barriers were removed after adding xmit_more handling. Therefore it would be good to
>>>> test also with only 
>>>> bd7153bd83b806bfcc2e79b7a6f43aa653d06ef3 r8169: remove unneeded mmiowb barriers
>>>> removed.
>>>>
>>>>> Since we are almost at RC6 i took the liberty to CC Eric now.
>>>>>
>>>> Sure, thanks.
>>>>
>>>>> BTW am i correct these patches are merely optimizations ?
>>>>
>>>> Yes
>>>>
>>>>> If so and concluding they revert cleanly, perhaps it should be considered at this point in the RC's
>>>>> to revert them for 5.0 and try again for 5.1 ?
>>>>>
>>>> Before removing both it would be good to test with only the barrier-removal removed.
>>>>
>>>
>>> Commit 2e6eedb4813e34d8d84ac0eb3afb668966f3f356 r8169: make use of xmit_more and __netdev_sent_queue
>>> looks buggy to me, since the skb might have been freed already on another cpu when you call
>>>
>>> You could try :
>>>
>>> diff --git a/drivers/net/ethernet/realtek/r8169.c b/drivers/net/ethernet/realtek/r8169.c
>>> index 3624e67aef72c92ed6e908e2c99ac2d381210126..f907d484165d9fd775e81bf2bfb9aa4ddedb1c93 100644
>>> --- a/drivers/net/ethernet/realtek/r8169.c
>>> +++ b/drivers/net/ethernet/realtek/r8169.c
>>> @@ -6070,6 +6070,7 @@ static netdev_tx_t rtl8169_start_xmit(struct sk_buff *skb,
>>>         dma_addr_t mapping;
>>>         u32 opts[2], len;
>>>         bool stop_queue;
>>> +       bool door_bell;
>>>         int frags;
>>>  
>>>         if (unlikely(!rtl_tx_slots_avail(tp, skb_shinfo(skb)->nr_frags))) {
>>> @@ -6116,6 +6117,8 @@ static netdev_tx_t rtl8169_start_xmit(struct sk_buff *skb,
>>>         /* Force memory writes to complete before releasing descriptor */
>>>         dma_wmb();
>>>  
>>> +       door_bell = __netdev_sent_queue(dev, skb->len, skb->xmit_more);
>>> +
>>>         txd->opts1 = rtl8169_get_txd_opts1(opts[0], len, entry);
>>>  
>>>         /* Force all memory writes to complete before notifying device */
>>> @@ -6127,7 +6130,7 @@ static netdev_tx_t rtl8169_start_xmit(struct sk_buff *skb,
>>>         if (unlikely(stop_queue))
>>>                 netif_stop_queue(dev);
>>>  
>>> -       if (__netdev_sent_queue(dev, skb->len, skb->xmit_more)) {
>>> +       if (door_bell) {
>>>                 RTL_W8(tp, TxPoll, NPQ);
>>>                 mmiowb();
>>>         }
>>>
>> Thanks a lot for checking and for the proposed fix.
>> Sander, can you try with this patch on top of 5.0-rc5 w/o removing two two commits?
> 
> I have done that already during the night .. the results:
> - I can confirm 2e6eedb4813e34d8d84ac0eb3afb668966f3f356 is the first commit which causes hitting the BUG_ON in lib/dynamic_queue_limits.c.
>   (in other word, with only reverting bd7153bd83b806bfcc2e79b7a6f43aa653d06ef3 it still blows up).
> 
> - The Eric's patch only applies cleanly with bd7153bd83b806bfcc2e79b7a6f43aa653d06ef3 reverted, so that's what I tested.
>   The patch seems to prevent hitting the BUG_ON in lib/dynamic_queue_limits.c, it has run this night and I gave done a few kernel compiles
>   this morning. How ever during these kernel compiles i'm getting a transmit queue timeout which i haven't seen with 4.20.x, although i regularly
>   compile kernels in the same way as I do now. The only thing I can't say if that is due to this change, or if it's again something else.
>   Which makes me somewhat inclined to go testing the complete revert some more and see if I can trigger the queue timeout on that or not.
> 
>   If I can, it is a separate issue.
>   If I can't it seems even with a patch it still seems as a regression in comparison with 4.20.x, for which
>   a revert would be the right thing to do (since as you indicated these are merely optimizations), 
>   which would give us more time for 5.1 to try to solve things on top of the 5.0-release-to-be.
>   (especially since I seem to still have other issues which need to be sorted out and time is limited)
> 
>   The timeout in question:
>         [28336.869479] NETDEV WATCHDOG: eth1 (r8169): transmit queue 0 timed out
>         [28336.881498] WARNING: CPU: 0 PID: 6925 at net/sched/sch_generic.c:461 dev_watchdog+0x20b/0x210
>         [28336.893358] Modules linked in:
>         [28336.904106] CPU: 0 PID: 6925 Comm: cc1 Tainted: G      D           5.0.0-rc5-20190208-thp-net-florian-rtl8169-eric-doflr+ #1
>         [28336.917385] Hardware name: MSI MS-7640/890FXA-GD70 (MS-7640)  , BIOS V1.8B1 09/13/2010
>         [28336.928988] RIP: e030:dev_watchdog+0x20b/0x210
>         [28336.940623] Code: 00 49 63 4e e0 eb 90 4c 89 e7 c6 05 ad d8 f1 00 01 e8 a9 32 fd ff 89 d9 48 89 c2 4c 89 e6 48 c7 c7 50 59 89 82 e8 e5 92 4d ff <0f> 0b eb c0 90 48 c7 47 08 00 00 00 00 48 c7 07 00 00 00 00 0f b7
>         [28336.965265] RSP: e02b:ffff88807d403ea0 EFLAGS: 00010286
>         [28336.977465] RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffffff82a69db8
>         [28336.991265] RDX: 0000000000000001 RSI: 0000000000000001 RDI: 0000000000000200
>         [28337.008865] RBP: ffff88807936e41c R08: 0000000000000000 R09: 0000000000000819
>         [28337.022250] R10: 0000000000000202 R11: ffffffff8247ca80 R12: ffff88807936e000
>         [28337.035204] R13: 0000000000000000 R14: ffff88807936e440 R15: 0000000000000001
>         [28337.049832] FS:  00007f53e9bf3840(0000) GS:ffff88807d400000(0000) knlGS:0000000000000000
>         [28337.062524] CS:  e030 DS: 0000 ES: 0000 CR0: 0000000080050033
>         [28337.075086] CR2: 00007f53e60c4000 CR3: 000000001a0be000 CR4: 0000000000000660
>         [28337.090052] Call Trace:
>         [28337.103615]  <IRQ>
>         [28337.116587]  ? qdisc_destroy+0x120/0x120
>         [28337.128905]  call_timer_fn+0x19/0x90
>         [28337.141892]  expire_timers+0x8b/0xa0
>         [28337.153354]  run_timer_softirq+0x7e/0x160
>         [28337.165931]  ? handle_irq_event_percpu+0x4c/0x70
>         [28337.176548]  ? handle_percpu_irq+0x32/0x50
>         [28337.186734]  __do_softirq+0xed/0x229
>         [28337.196404]  ? hypervisor_callback+0xa/0x20
>         [28337.207822]  irq_exit+0xb7/0xc0
>         [28337.218978]  xen_evtchn_do_upcall+0x27/0x40
>         [28337.230763]  xen_do_hypervisor_callback+0x29/0x40
>         [28337.241261]  </IRQ>
>         [28337.253283] RIP: e033:0xff7e62
>         [28337.264899] Code: 35 43 0f c7 00 4c 89 ef e8 8b 6d 67 ff 0f 1f 00 44 89 e0 44 89 e2 c1 e8 06 83 e2 3f 48 8b 0c c5 40 8d c6 01 48 0f a3 d1 72 0e <48> 8b 04 c5 50 8d c6 01 48 0f a3 d0 73 0b 44 89 e6 4c 89 ef e8 b5
>         [28337.288677] RSP: e02b:00007fff0fc6a340 EFLAGS: 00000202
>         [28337.299234] RAX: 0000000000000000 RBX: 00007f53e60c3580 RCX: 0000000000000000
>         [28337.309577] RDX: 0000000000000034 RSI: 0000000001e71a98 RDI: 00007fff0fc6a538
>         [28337.320724] RBP: 00007fff0fc6a4b0 R08: 0000000000000000 R09: 0000000000000000
>         [28337.331829] R10: 0000000000000001 R11: 00000000020cb3d0 R12: 0000000000000034
>         [28337.343900] R13: 00007fff0fc6a538 R14: 0000000000000000 R15: 0000000000000001
>         [28337.353977] ---[ end trace 6ff49f09286816b7 ]---
> 
Thanks for your efforts. As usual this tx timeout trace says basically nothing except
"timeout" and root cause could be anything. Earlier you reported a memory allocation error,
did that occur again?
If we decide to revert, I'd leave removal of the memory barriers in (as it doesn't seem to
contribute to the issue) and just submit a patch to effectively revert
2e6eedb4813e34d8d84ac0eb3afb668966f3f356.

> --
> Sander
> 
>  
>>>
>>> .
>>>
>> Heiner
>>
> 
> 
