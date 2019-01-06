Return-Path: <SRS0=QMhl=PO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1742BC43444
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Jan 2019 13:48:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC1CE2085A
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Jan 2019 13:48:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726453AbfAFNsX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Jan 2019 08:48:23 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:44497 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726336AbfAFNsW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jan 2019 08:48:22 -0500
Received: from fsav101.sakura.ne.jp (fsav101.sakura.ne.jp [27.133.134.228])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x06DlWZs071605;
        Sun, 6 Jan 2019 22:47:32 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav101.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav101.sakura.ne.jp);
 Sun, 06 Jan 2019 22:47:32 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav101.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126126163036.bbtec.net [126.126.163.36])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x06DlPZg071385
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Sun, 6 Jan 2019 22:47:32 +0900 (JST)
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
 <eeb95c52-5bf8-d3ce-d32b-269aa86bcd93@i-love.sakura.ne.jp>
 <8cdbcb63-d2f7-cace-0eda-d73255fd47e7@i-love.sakura.ne.jp>
 <CACT4Y+Y5cdD=optF2k4a0W7vriVnzmzLU0SPGEJoOHRMi_bsZA@mail.gmail.com>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <ea2bc542-38b2-8218-9eb7-4c4a05da36ea@i-love.sakura.ne.jp>
Date:   Sun, 6 Jan 2019 22:47:19 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CACT4Y+Y5cdD=optF2k4a0W7vriVnzmzLU0SPGEJoOHRMi_bsZA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/01/06 22:24, Dmitry Vyukov wrote:
>> A report at 2019/01/05 10:08 from "no output from test machine (2)"
>> ( https://syzkaller.appspot.com/text?tag=CrashLog&x=1700726f400000 )
>> says that there are flood of memory allocation failure messages.
>> Since continuous memory allocation failure messages itself is not
>> recognized as a crash, we might be misunderstanding that this problem
>> is not occurring recently. It will be nice if we can run testcases
>> which are executed on bpf-next tree.
> 
> What exactly do you mean by running test cases on bpf-next tree?
> syzbot tests bpf-next, so it executes lots of test cases on that tree.
> One can also ask for patch testing on bpf-next tree to test a specific
> test case.

syzbot ran "some tests" before getting this report, but we can't find from
this report what the "some tests" are. If we could record all tests executed
in syzbot environments before getting this report, we could rerun the tests
(with manually examining where the source of memory consumption is) in local
environments.

Since syzbot is now using memcg, maybe we can test with sysctl_panic_on_oom == 1.
Any memory consumption that triggers global OOM killer could be considered as
a problem (e.g. memory leak or uncontrolled memory allocation).

