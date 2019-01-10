Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC326C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 11:27:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99108206B6
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 11:27:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728413AbfAJL1k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 06:27:40 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:31707 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727455AbfAJL1k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 06:27:40 -0500
Received: from fsav303.sakura.ne.jp (fsav303.sakura.ne.jp [153.120.85.134])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x0ABRb5P087629;
        Thu, 10 Jan 2019 20:27:38 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav303.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav303.sakura.ne.jp);
 Thu, 10 Jan 2019 20:27:37 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav303.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126126163036.bbtec.net [126.126.163.36])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x0ABRbrB087626
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Thu, 10 Jan 2019 20:27:37 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH] printk: Add caller information to printk() output.
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller <syzkaller@googlegroups.com>
References: <20181204152724.ypk44mi4a56nrud4@pathway.suse.cz>
 <459018db-763b-9520-ead2-2c0d5975fbf3@i-love.sakura.ne.jp>
 <20181210130930.bas4fozjhe3dc5nu@pathway.suse.cz>
 <c5b5d660-d217-35f0-c4f1-7252367934d1@i-love.sakura.ne.jp>
 <e3f69846-ef08-c8f5-368f-4dada13c9970@i-love.sakura.ne.jp>
 <20181213121847.mwlr2vyv6qzclhk6@pathway.suse.cz>
 <20181213124255.GB3053@tigerII.localdomain>
 <20181217145452.3kev4rmo2l5lt2qy@pathway.suse.cz>
 <93f19e57-5051-c67d-9af4-b17624062d44@i-love.sakura.ne.jp>
 <20181218083911.qxvlqlwlb4eye72x@pathway.suse.cz>
 <20181218085833.GA460@jagdpanzerIV>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <9de5b69f-b54d-0c28-6e60-623c2e412263@i-love.sakura.ne.jp>
Date:   Thu, 10 Jan 2019 20:27:36 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20181218085833.GA460@jagdpanzerIV>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/12/18 17:58, Sergey Senozhatsky wrote:
> On (12/18/18 09:39), Petr Mladek wrote:
>>
>> Sergey, are you okay with this squashed patch, please?
>>
> 
> Yeah. There are several minor nitpicks, but here is my
> Acked-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
> 
> 
> One final question - can syzbot folks confirm that the patch
> helps? Just curious.

syzbot started utilizing this patch in linux-next.git. And surprisingly,
almost all reports which were previously treated as "corrupted report" are
now appropriately reported. I can hardly wait for arrival at linux.git.
Even if we revert from linux.git at 5.0-rc7, having this patch temporarily
available until 5.0-rc7 in linux.git would be so helpful. ;-)
