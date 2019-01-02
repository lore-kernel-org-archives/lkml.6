Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D38EC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 17:07:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC96A2171F
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 17:07:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730592AbfABRHo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 12:07:44 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:17532 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729375AbfABRHn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 12:07:43 -0500
Received: from fsav107.sakura.ne.jp (fsav107.sakura.ne.jp [27.133.134.234])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x02H6x1K029517;
        Thu, 3 Jan 2019 02:06:59 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav107.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav107.sakura.ne.jp);
 Thu, 03 Jan 2019 02:06:59 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav107.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126126163036.bbtec.net [126.126.163.36])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x02H6w2M029513
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Thu, 3 Jan 2019 02:06:58 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: INFO: rcu detected stall in ndisc_alloc_skb
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     syzbot <syzbot+ea7d9cb314b4ab49a18a@syzkaller.appspotmail.com>,
        David Miller <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        LKML <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Linux-MM <linux-mm@kvack.org>
References: <0000000000007beca9057e4c8c14@google.com>
 <CACT4Y+Yx4BJw=F_PMx9a8AjPKzEwhzLnzt9K-dgkBoNkKQj2+g@mail.gmail.com>
 <ef2508c9-d069-2143-09a6-a90b9ef12568@I-love.SAKURA.ne.jp>
 <CACT4Y+YYwYDnqFmMwfSg6UNXnrbh46bo0jp7ijbej8nkDDmBXQ@mail.gmail.com>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <eeb95c52-5bf8-d3ce-d32b-269aa86bcd93@i-love.sakura.ne.jp>
Date:   Thu, 3 Jan 2019 02:06:58 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CACT4Y+YYwYDnqFmMwfSg6UNXnrbh46bo0jp7ijbej8nkDDmBXQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/12/31 17:24, Dmitry Vyukov wrote:
>>> Since this involves OOMs and looks like a one-off induced memory corruption:
>>>
>>> #syz dup: kernel panic: corrupted stack end in wb_workfn
>>>
>>
>> Why?
>>
>> RCU stall in this case is likely to be latency caused by flooding of printk().
> 
> Just a hypothesis. OOMs lead to arbitrary memory corruptions, so can
> cause stalls as well. But can be what you said too. I just thought
> that cleaner dashboard is more useful than a large assorted pile of
> crashes. If you think it's actionable in some way, feel free to undup.
> 

We don't know why bpf tree is hitting this problem.
Let's continue monitoring this problem.

#syz undup
