Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E556C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 08:10:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2E7120841
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 08:10:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="Dw0r/F/8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2E7120841
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727059AbeJJPbN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 11:31:13 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37809 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726663AbeJJPbN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 11:31:13 -0400
Received: by mail-wm1-f66.google.com with SMTP id 185-v6so4672269wmt.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Oct 2018 01:10:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=wHdJhWjF+jhdxzXFW98XRNl9IpD2T3A3mSD6ikeXs7E=;
        b=Dw0r/F/8wsp9Lg5/mxYYa2BLu8MaofgxAbG4r+xBg5GDEVAQSoZXlKBmVC1TzFt9Po
         K1BSzHneFMxmaDe1Jhpbm+dEYGU5rruiAEb7Hw35LoEr7zbMLQim3hW2u5hz4I7GtMKD
         E+90eHxjDl46XDMM8MYjNxAZfM0kVoyklSjYZFnmAGVw1o+jIUQR4088/3rby/5UyvDm
         WWfePq2UPPA/I1zRL1Se5qGB1PuW12Cuat9MdNM7hMGmj4IL4KDY4o8tFtHrDqq4zOTu
         /IwMKcYoPiimh1F8oLNyldjgLA++cbRNPo/W3UyM4YaCbasYoihfdc85LfG6i91n1hSM
         TboA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wHdJhWjF+jhdxzXFW98XRNl9IpD2T3A3mSD6ikeXs7E=;
        b=liFZJCFL87IQ2vPvh2BhcXrQJnqkR5kZMK+/1FpVCPLj+0rSzlJbQ7GPLpVuTWgB2j
         0miuseUBML6bePbLN7HnIOvqb8yRrkyvvXeGFFQtJo9zkSPwc47AtsNLyjimgD++a5pF
         w8Qh/ySLJJlSzK7Z1WaVKG7FBxpmcCFRcf4eOrfAMxHfSQLQvuP3pxZ1x548pshUzoVR
         Alb3v7qpqWljOcawQNnaKJqjZQL9Lv+C0el6big/6HIin6TN4pfswGJprmL0XxzwQv1+
         2lZZKEOnDvE37CWGnuj40NeSSIJrPBLHxvJJOCJZKW8bfRvJkxp1HG6KjLy5LFB6onkp
         xvfw==
X-Gm-Message-State: ABuFfog/q3ifqQxnWhZp/zZE5IdnDGMZQ1E7XLoC/kGoosCk6rVh+qf3
        i7bIHLMjFAWIXsVgZLSyy1cATgin
X-Google-Smtp-Source: ACcGV61hXkW8JEmJw7heSM0GqLoxQRi+RAMEaIKBWphefQlRLVVyIgdBlOY4FhILf1f4o6PJYVxeJg==
X-Received: by 2002:a1c:bc82:: with SMTP id m124-v6mr4468401wmf.76.1539159008618;
        Wed, 10 Oct 2018 01:10:08 -0700 (PDT)
Received: from [192.168.0.20] ([94.1.125.110])
        by smtp.googlemail.com with ESMTPSA id q77-v6sm7187820wmd.33.2018.10.10.01.10.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Oct 2018 01:10:07 -0700 (PDT)
Subject: Re: R8169: Network lockups in 4.18.{8,9,10} (and 4.19 dev)
To:     "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc:     Heiner Kallweit <hkallweit1@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Azat Khuzhin <a3at.mail@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Realtek linux nic maintainers <nic_swsd@realtek.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <54d8d7e9-a80d-dc2b-5628-22f9dc14e2ee@maciej.szmigiero.name>
 <535f42c7-6c3b-8e5a-49de-5dc975879b21@googlemail.com>
 <98680351-5123-761f-982a-726098da9716@gmail.com>
 <9980dcc1-f7fe-5de7-75be-99b1592c9206@googlemail.com>
 <6b1685ce-22ac-2c71-e1d4-b05748a7d977@googlemail.com>
 <bed5c327-6a2a-99da-8b86-16f897b32548@maciej.szmigiero.name>
 <7199b1e4-ce40-60ae-2a6a-ef7e95e563ea@googlemail.com>
 <0e206e6b-3d0c-de27-dedb-48c30e02649c@gmail.com>
 <9d99060a-db1d-7177-3041-e407b131548e@maciej.szmigiero.name>
From:   Chris Clayton <chris2553@googlemail.com>
Message-ID: <98b10480-cf4b-bc86-7f89-d3bbcf03f979@googlemail.com>
Date:   Wed, 10 Oct 2018 09:09:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <9d99060a-db1d-7177-3041-e407b131548e@maciej.szmigiero.name>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/10/2018 01:24, Maciej S. Szmigiero wrote:
> On 09.10.2018 22:36, Heiner Kallweit wrote:
>> On 09.10.2018 16:40, Chris Clayton wrote:
>>> Thanks to Maciej and Heiner for their replies.
>>>
>>> On 09/10/2018 13:32, Maciej S. Szmigiero wrote:
>>>> On 07.10.2018 21:36, Chris Clayton wrote:
>>>>> Hi again,
>>>>>
>>>>> I didn't think there was anything in 4.19-rc7 to fix this regression, but tried it anyway. I can confirm that the
>>>>> regression is still present and my network still fails when, after a resume from suspend (to ram or disk), I open my
>>>>> browser or my mail client. In both those cases the failure is almost immediate - e.g. my home page doesn't get displayed
>>>>> in the browser. Pinging one of my ISPs name servers doesn't fail quite so quickly but the reported time increases from
>>>>> 14-15ms to more than 1000ms.
>>>>
>>>> You can try comparing chip registers (ethtool -d eth0) in the working
>>>> state (before a suspend) and in the broken state (after a resume).
>>>> Maybe there will be some obvious in the difference.
>>>>
>>>> The same goes for the PCI configuration (lspci -d :8168 -vv).
>>>>
>>> Maciej suggested comparing the output from lspci -vv for the ethernet device. They are identical.
>>>
>>> Both Maciej and Heiner suggested comparing the output from "ethtool -d" pre and post suspend. Again, they are identical.
>>> Heiner specifically suggested looking at the RxConfig. The value of that is 0x0002870e both pre and post suspend.
>>>
>> Hmm, this is very weird, especially taking into account that in your original
>> report you state that removing the call to rtl_init_rxcfg() from rtl_hw_start()
>> fixes the issue. rtl_init_rxcfg() deals with the RxConfig register only and
>> register values seem to be the same before and after resume. So how can the
>> chip behave differently?
>> So far my best guess is that some chip quirk causes it to accept writes to
>> register RxConfig, but to misinterpret or ignore the written value.
>> So far your report is the only one (affecting RTL8411), but we don't know
>> whether other chip versions are affected too.
> 
> Also, it is interesting that even if one removes a call to
> rtl_init_rxcfg() from rtl_hw_start() the RxConfig register will still get
> written to moments later by rtl_set_rx_mode().
> 
> The only chip accesses in the meantime seems to be a write to TxConfig by
> rtl_set_tx_config_registers() and then a read of RxConfig plus two writes
> to MAR0 earlier in rtl_set_rx_mode().
> 
> My proposals are:
> 1) Try swapping "rtl_init_rxcfg(tp);" and "rtl_set_tx_config_registers(tp);"
> in rtl_hw_start().
> Maybe the chip does not like sometimes that RxConfig is written before
> TxConfig.
> 
After testing your first proposal, which made no  difference, I founf the following in dmesg in the output from dmesg:

[  761.999468] ------------[ cut here ]------------
[  761.999471] NETDEV WATCHDOG: eth0 (r8169): transmit queue 0 timed out
[  761.999483] WARNING: CPU: 0 PID: 8938 at net/sched/sch_generic.c:461 dev_watchdog+0x1e9/0x1f0
[  761.999484] Modules linked in: btusb btintel r8169 rfcomm bnep iptable_filter xt_conntrack iptable_nat ipt_MASQUERADE
nf_nat_ipv4 nf_nat nf_conntrack nf_defrag_ipv4 uvcvideo videobuf2_vmalloc videobuf2_memops snd_hda_codec_via
videobuf2_v4l2 snd_hda_codec_hdmi snd_hda_codec_generic videobuf2_common usbhid realtek coretemp snd_hda_intel hwmon
snd_hda_codec x86_pkg_temp_thermal snd_hwdep libphy snd_hda_core [last unloaded: btintel]
[  761.999503] CPU: 0 PID: 8938 Comm: kworker/0:0 Not tainted 4.19.0-rc7 #328
[  761.999504] Hardware name: Notebook                         W65_67SZ                        /W65_67SZ
       , BIOS 1.03.05 02/26/2014
[  761.999508] Workqueue: events rtl_task [r8169]
[  761.999510] RIP: 0010:dev_watchdog+0x1e9/0x1f0
[  761.999512] Code: 00 48 63 4d e8 eb 99 4c 89 ef c6 05 b6 13 a6 00 01 e8 1b c7 fd ff 89 d9 4c 89 ee 48 c7 c7 40 53 e1
81 48 89 c2 e8 ae f4 a3 ff <0f> 0b eb c0 0f 1f 00 48 c7 47 08 00 00 00 00 48 c7 07 00 00 00 00
[  761.999513] RSP: 0018:ffff88040f803e98 EFLAGS: 00010282
[  761.999514] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000006
[  761.999516] RDX: 0000000000000007 RSI: 0000000000000096 RDI: ffff88040f8153d0
[  761.999517] RBP: ffff88040ca9a3b8 R08: ffffffff813565f0 R09: 000000000000034e
[  761.999517] R10: 0000000000000007 R11: 0000000000000000 R12: ffff88040ca9a39c
[  761.999518] R13: ffff88040ca9a000 R14: 0000000000000001 R15: ffff8803ea17cc80
[  761.999520] FS:  0000000000000000(0000) GS:ffff88040f800000(0000) knlGS:0000000000000000
[  761.999521] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  761.999522] CR2: 00007f67280206b8 CR3: 000000000200a002 CR4: 00000000001606f0
[  761.999523] Call Trace:
[  761.999525]  <IRQ>
[  761.999527]  ? qdisc_reset+0xe0/0xe0
[  761.999529]  ? qdisc_reset+0xe0/0xe0
[  761.999532]  call_timer_fn+0x11/0x70
[  761.999534]  expire_timers+0x8e/0xa0
[  761.999535]  run_timer_softirq+0x7e/0x150
[  761.999538]  ? __hrtimer_run_queues+0x12b/0x1a0
[  761.999541]  ? recalibrate_cpu_khz+0x10/0x10
[  761.999543]  ? ktime_get+0x32/0x90
[  761.999546]  ? lapic_next_event+0x20/0x20
[  761.999549]  __do_softirq+0xcc/0x1fc
[  761.999552]  irq_exit+0x82/0xb0
[  761.999554]  smp_apic_timer_interrupt+0x61/0x90
[  761.999556]  apic_timer_interrupt+0xf/0x20
[  761.999557]  </IRQ>
[  761.999560] RIP: 0010:rtl_slow_event_work+0x2a/0x1f0 [r8169]
[  761.999562] Code: 41 56 41 55 41 54 55 53 48 89 fb 48 83 ec 10 4c 8b 67 10 65 48 8b 04 25 28 00 00 00 48 89 44 24 08
31 c0 48 8b 07 66 8b 68 3e <66> 23 af da 0d 00 00 48 8b 07 66 89 68 3e 40 f6 c5 40 0f 85 3b 01
[  761.999563] RSP: 0018:ffffc900014d7e40 EFLAGS: 00000246 ORIG_RAX: ffffffffffffff13
[  761.999564] RAX: ffffc900000b9000 RBX: ffff88040ca9a7c0 RCX: ffff88040f81f160
[  761.999565] RDX: ffff8803ea21b300 RSI: 0000000000000000 RDI: ffff88040ca9a7c0
[  761.999566] RBP: ffff88040ca90050 R08: 0000000000000000 R09: 000073746e657665
[  761.999567] R10: 8080808080808080 R11: ffff88040f81ea68 R12: ffff88040ca9a000
[  761.999568] R13: ffff88040ca9a000 R14: ffff88040f81f140 R15: 0000000000000000
[  761.999571]  ? __switch_to_asm+0x34/0x70
[  761.999573]  rtl_task+0x4f/0x70 [r8169]
[  761.999576]  process_one_work+0x1bc/0x2f0
[  761.999577]  worker_thread+0x28/0x3c0
[  761.999579]  ? process_one_work+0x2f0/0x2f0
[  761.999581]  kthread+0x109/0x120
[  761.999583]  ? kthread_park+0x80/0x80
[  761.999585]  ret_from_fork+0x35/0x40
[  761.999586] ---[ end trace fd5800440feffc06 ]---

I haven't seen this before, but maybe it's a consequence of swapping the order of the two functions calls.

I'll work on the second proposal later today.

Chris
> 2) Check the original value of RxConfig (after a resume) before
> rtl_init_rxcfg() overwrites it (compile tested only):
> --- r8169.c.ori
> +++ r8169.c
> @@ -5155,6 +5155,9 @@
>  	/* Initially a 10 us delay. Turned it into a PCI commit. - FR */
>  	RTL_R8(tp, IntrMask);
>  	RTL_W8(tp, ChipCmd, CmdTxEnb | CmdRxEnb);
> +
> +	pr_notice("RxConfig before init was %.8x\n",
> +		(unsigned int)RTL_R32(tp, RxConfig));
>  	rtl_init_rxcfg(tp);
>  	rtl_set_tx_config_registers(tp);
>  
> 
> This should be the value that you got when you removed the call to
> rtl_init_rxcfg() for testing.
> Now, knowing the "right" value you can experiment with what rtl_init_rxcfg()
> writes (under the "default:" label for your NIC model).
> 
> Hope this helps,
> Maciej
> 
