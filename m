Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79369C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 08:28:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 381CC208A3
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 08:28:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 381CC208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727523AbeKKSQr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Nov 2018 13:16:47 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:27937 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727334AbeKKSQr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Nov 2018 13:16:47 -0500
Received: from fsav305.sakura.ne.jp (fsav305.sakura.ne.jp [153.120.85.136])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id wAB8Sp9O088549;
        Sun, 11 Nov 2018 17:28:51 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav305.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav305.sakura.ne.jp);
 Sun, 11 Nov 2018 17:28:51 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav305.sakura.ne.jp)
Received: from [192.168.1.8] (softbank060157065137.bbtec.net [60.157.65.137])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id wAB8SpJo088545
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Sun, 11 Nov 2018 17:28:51 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Subject: Re: INFO: task hung in blkdev_put
To:     Dmitry Vyukov <dvyukov@google.com>,
        syzbot 
        <bot+a444b4083d33277c6e9b4605faf0a79773e29cc5@syzkaller.appspotmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        syzkaller-bugs@googlegroups.com, Jens Axboe <axboe@kernel.dk>,
        Ming Lei <tom.leiming@gmail.com>,
        Omar Sandoval <osandov@fb.com>, Hannes Reinecke <hare@suse.de>,
        shli@fb.com
References: <001a11425c94cc5f45055ffc86ef@google.com>
 <CACT4Y+YAKWzSjskMSRNQU-VzQo822Ht+QX0jVZjJGjuUwpZdJQ@mail.gmail.com>
 <762e920e-4914-bd95-66f2-4304e1bf6b5b@I-love.SAKURA.ne.jp>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Message-ID: <440554b7-7ef2-5651-544e-5c3669f9896a@I-love.SAKURA.ne.jp>
Date:   Sun, 11 Nov 2018 17:28:48 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <762e920e-4914-bd95-66f2-4304e1bf6b5b@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/11/11 17:25, Tetsuo Handa wrote:
> On 2017/12/13 1:45, Dmitry Vyukov wrote:
>> +loop maintainers
>>
>> #syz dup: INFO: task hung in lo_ioctl
> 
> https://syzkaller.appspot.com/text?tag=CrashLog&x=14a09f95400000 has
> "getblk(): executed=9 bh_count=0 bh_state=0" line.
> 
> #syz undup
> 

Merging into not-yet-fixed this one.

#syz dup: INFO: task hung in generic_file_write_iter
