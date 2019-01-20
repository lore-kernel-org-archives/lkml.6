Return-Path: <SRS0=5EgK=P4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1DB3C61CE8
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 01:49:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A21A22084C
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 01:49:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729996AbfATBtE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 19 Jan 2019 20:49:04 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:53363 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727830AbfATBtE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jan 2019 20:49:04 -0500
Received: from fsav303.sakura.ne.jp (fsav303.sakura.ne.jp [153.120.85.134])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x0K1mi6o061723;
        Sun, 20 Jan 2019 10:48:44 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav303.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav303.sakura.ne.jp);
 Sun, 20 Jan 2019 10:48:44 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav303.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126126163036.bbtec.net [126.126.163.36])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x0K1mdWt061663
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Sun, 20 Jan 2019 10:48:44 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: INFO: task hung in fat_fallocate
To:     Dmitry Vyukov <dvyukov@google.com>,
        syzbot <syzbot+cfa5d826b19395f1940e@syzkaller.appspotmail.com>,
        Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.com>
Cc:     hirofumi@mail.parknet.co.jp, LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
References: <000000000000c49e10056affb536@google.com>
 <CACT4Y+aLeRxHE1wyGhjvb5V81LEKWh=7Lw3fDpqRFmTzq_4JtA@mail.gmail.com>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <c5b4b7b2-fc78-7bb0-7c3a-8f31c24028e6@i-love.sakura.ne.jp>
Date:   Sun, 20 Jan 2019 10:48:38 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CACT4Y+aLeRxHE1wyGhjvb5V81LEKWh=7Lw3fDpqRFmTzq_4JtA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/01/20 4:03, Dmitry Vyukov wrote:
> On Sun, Apr 29, 2018 at 7:03 PM syzbot
> <syzbot+cfa5d826b19395f1940e@syzkaller.appspotmail.com> wrote:
>>
>> Hello,
>>
>> syzbot hit the following crash on upstream commit
>> bf8f5de17442bba5f811e7e724980730e079ee11 (Sat Apr 28 17:05:04 2018 +0000)
>> MAINTAINERS: add myself as maintainer of AFFS
>> syzbot dashboard link:
>> https://syzkaller.appspot.com/bug?extid=cfa5d826b19395f1940e
>>
>> Unfortunately, I don't have any reproducer for this crash yet.
>> Raw console output:
>> https://syzkaller.appspot.com/x/log.txt?id=5087555854794752
>> Kernel config:
>> https://syzkaller.appspot.com/x/.config?id=7043958930931867332
>> compiler: gcc (GCC) 8.0.1 20180413 (experimental)
> 
> This mentions __getblk_gfp. Is it the same as "INFO: task hung in
> generic_file_write_iter":
> https://syzkaller.appspot.com/bug?id=b3c7e1440aa8ece16bf557dbac427fdff1dad9d6
> and fixed with "blockdev: Fix livelocks on loop device"?

Yes, I think so.

#syz dup: INFO: task hung in generic_file_write_iter
