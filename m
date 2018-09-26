Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61389C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 21:50:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1727C2154B
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 21:50:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cNdDd69J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1727C2154B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727146AbeI0EFo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 00:05:44 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:38101 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727015AbeI0EFo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 00:05:44 -0400
Received: by mail-pg1-f195.google.com with SMTP id r77-v6so308285pgr.5;
        Wed, 26 Sep 2018 14:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=cL6j5lhIQlDa1HUAQA1lMIhFXZlLqjbbny4TxZ22kLE=;
        b=cNdDd69JIilhM5kkDa0EGHSdq2evkmLKSF6KLHkqGuSeJ/5PTkZkoIve1NX7aaHGg+
         9bJ9z45XGYbX6P1fLBiODH6+wodPHwLuFYVp7amkgtWF+dJi5dLHlwrUQsHavDmg0u+K
         HubyaERsmBPhlgwjl1zCPGqdQJgmhUWWYWeCH3hWvQNIPpvQDiOOf3aaeHYP9uOf5Jex
         sAf6+W2efahPY4coQMJlUFeL7Jnrly7naJU0t6IYDz38Tjc24Iv7DgNz1Uq+kZjS0CTP
         c2Tx/OUNdTo6fy2PNusjAF0n5iP75SOAocUanwcq7giz3hxOl9mTepoavY3NI41Qrmgn
         tklQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cL6j5lhIQlDa1HUAQA1lMIhFXZlLqjbbny4TxZ22kLE=;
        b=uNIjOKcvpwG11Qg7Qps8eHU2Zk4TO81rPs9WvYc4tEboMFNP8H/6YJio2TMbwoO0NI
         94nvrTMbdaSqNLuRIlrRUgtbjJzfasHVc5LX6w2XHK2YL6i4It9NYGylE4Q9IFL00Naq
         RNnkHDW5KX3rSHMxdOHe1Nc7MKi/BkJi6cqjkKuYbD+r9GOzZzGAnZQiy9T7Uk7D5VBQ
         sJSo3qbh1YsDw2kBQTFQnFsR4BquGD7+0OJFu2kxiOtu7wqahX9RccP/PNp3MvnWGYyT
         8GVdrSPlnxBvWY+frDhVpQGiJVEfqKB6E/kaG9t4k2xUjSbxhhffAhqcC5fN0tvqu3Oe
         afbQ==
X-Gm-Message-State: ABuFfohg+RErHqm1Sm20rR8KQ8NTIX9P7f1DCTWLYMAEUlwwi9WBm6a7
        kMzeFwJE/ic/B8fqPogVWK0gwl+I
X-Google-Smtp-Source: ACcGV61jFI3iH5qEaDDbPPx5w+pYSuYrnsGTHglhS272Z61t9eoQM4AV3UCFrtSlAdyfDNLKTDixeg==
X-Received: by 2002:a65:5cc3:: with SMTP id b3-v6mr7425350pgt.277.1537998644006;
        Wed, 26 Sep 2018 14:50:44 -0700 (PDT)
Received: from ?IPv6:2620:15c:2c1:200:55c7:81e6:c7d8:94b? ([2620:15c:2c1:200:55c7:81e6:c7d8:94b])
        by smtp.gmail.com with ESMTPSA id f29-v6sm144888pff.29.2018.09.26.14.50.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Sep 2018 14:50:43 -0700 (PDT)
Subject: Re: KASAN: use-after-free Read in tcf_block_find
To:     Cong Wang <xiyou.wangcong@gmail.com>,
        syzbot+37b8770e6d5a8220a039@syzkaller.appspotmail.com
Cc:     David Miller <davem@davemloft.net>,
        Jamal Hadi Salim <jhs@mojatatu.com>,
        Jiri Pirko <jiri@resnulli.us>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Kernel Network Developers <netdev@vger.kernel.org>,
        syzkaller-bugs@googlegroups.com
References: <00000000000084e2450576c817cc@google.com>
 <CAM_iQpXxzR3GP4wK7z+wW_0-vC9cuyiwnrCYqx+NpBgDvBXLcg@mail.gmail.com>
From:   Eric Dumazet <eric.dumazet@gmail.com>
Message-ID: <7fcb1c03-6976-9b34-601d-5f50b74c5b0a@gmail.com>
Date:   Wed, 26 Sep 2018 14:50:42 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAM_iQpXxzR3GP4wK7z+wW_0-vC9cuyiwnrCYqx+NpBgDvBXLcg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/26/2018 02:44 PM, Cong Wang wrote:
> On Wed, Sep 26, 2018 at 8:44 AM syzbot
> <syzbot+37b8770e6d5a8220a039@syzkaller.appspotmail.com> wrote:
>>
>> Hello,
>>
>> syzbot found the following crash on:
>>
>> HEAD commit:    4b1bd6976945 net: phy: marvell: Fix build.
>> git tree:       net-next
>> console output: https://syzkaller.appspot.com/x/log.txt?x=16f763fa400000
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=443816db871edd66
>> dashboard link: https://syzkaller.appspot.com/bug?extid=37b8770e6d5a8220a039
>> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
>> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17a5614e400000
>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=141a532a400000
>>
>> IMPORTANT: if you fix the bug, please add the following tag to the commit:
>> Reported-by: syzbot+37b8770e6d5a8220a039@syzkaller.appspotmail.com
>>
>> IPv6: ADDRCONF(NETDEV_CHANGE): veth0: link becomes ready
>> 8021q: adding VLAN 0 to HW filter on device team0
>> ==================================================================
>> BUG: KASAN: use-after-free in tcf_block_find+0x9d1/0xb90
>> net/sched/cls_api.c:646
>> Read of size 4 at addr ffff8801cc126978 by task syz-executor002/5646
>>
>> CPU: 1 PID: 5646 Comm: syz-executor002 Not tainted 4.19.0-rc5+ #232
>> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
>> Google 01/01/2011
>> Call Trace:
>>   __dump_stack lib/dump_stack.c:77 [inline]
>>   dump_stack+0x1c4/0x2b4 lib/dump_stack.c:113
>>   print_address_description.cold.8+0x9/0x1ff mm/kasan/report.c:256
>>   kasan_report_error mm/kasan/report.c:354 [inline]
>>   kasan_report.cold.9+0x242/0x309 mm/kasan/report.c:412
>>   __asan_report_load4_noabort+0x14/0x20 mm/kasan/report.c:432
>>   tcf_block_find+0x9d1/0xb90 net/sched/cls_api.c:646
> 
> Hmm. looks like missing a rcu_dereference() here:
> 
>                 if (!*parent) {
>                         *q = dev->qdisc;
>                         *parent = (*q)->handle;
> 

We hold RTNL here.

Have we already done the changes allowing dev->qdisc being changed
without RTNL being required ?

