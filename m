Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D75BC6778F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 14:16:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA52220878
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 14:16:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA52220878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i-love.sakura.ne.jp
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932903AbeGIOQO (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 10:16:14 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:43130 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932574AbeGIOQN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 10:16:13 -0400
Received: from fsav302.sakura.ne.jp (fsav302.sakura.ne.jp [153.120.85.133])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id w69EGBtG097082;
        Mon, 9 Jul 2018 23:16:11 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav302.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav302.sakura.ne.jp);
 Mon, 09 Jul 2018 23:16:11 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav302.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126074194044.bbtec.net [126.74.194.44])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id w69EFpJN096906
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Mon, 9 Jul 2018 23:16:11 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: BUG: corrupted list in cpu_stop_queue_work
To:     Matthew Wilcox <willy@infradead.org>
Cc:     syzbot <syzbot+d8a8e42dfba0454286ff@syzkaller.appspotmail.com>,
        bigeasy@linutronix.de, linux-kernel@vger.kernel.org,
        matt@codeblueprint.co.uk, mingo@kernel.org, peterz@infradead.org,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de,
        linux-mm <linux-mm@kvack.org>
References: <00000000000032412205706753b5@google.com>
 <000000000000693c7d057087caf3@google.com>
 <1271c58e-876b-0df3-3224-319d82634663@I-love.SAKURA.ne.jp>
 <20180709133212.GA2662@bombadil.infradead.org>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <8b258017-8817-8050-14a5-5e55c56bbf18@i-love.sakura.ne.jp>
Date:   Mon, 9 Jul 2018 23:15:54 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.0
MIME-Version: 1.0
In-Reply-To: <20180709133212.GA2662@bombadil.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/07/09 22:32, Matthew Wilcox wrote:
>> >From d6f24d6eecd79836502527624f8086f4e3e4c331 Mon Sep 17 00:00:00 2001
>> From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
>> Date: Mon, 9 Jul 2018 15:58:44 +0900
>> Subject: [PATCH] shmem: Fix crash upon xas_store() failure.
>>
>> syzbot is reporting list corruption [1]. This is because xas_store() from
>> shmem_add_to_page_cache() is not handling memory allocation failure. Fix
>> this by checking xas_error() after xas_store().
> 
> I have no idea why you wrote this patch on Monday when I already said
> I knew what the problem was on Friday, fixed the problem and pushed it
> out to my git tree on Saturday.
> 

Because syzbot found a C reproducer on 2018/07/09 02:29 UTC, and your fix was
not in time for a kernel version syzbot was testing, and you were not listed
as a recipient of this bug, and I didn't know you already fixed this bug.

Anyway, linux-next-20180709 still does not have this fix.
What is the title of your fix you pushed on Saturday?
