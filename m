Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5666BC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 01:53:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3367B218D3
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 01:53:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729620AbfB0Bxq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 20:53:46 -0500
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:54598 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729364AbfB0Bxq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 20:53:46 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=joseph.qi@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0TLQeSnI_1551232390;
Received: from JosephdeMacBook-Pro.local(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0TLQeSnI_1551232390)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 27 Feb 2019 09:53:10 +0800
Subject: Re: [bug report][stable] perf probe: failed to add events
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        luto@kernel.org, Jiufei Xue <jiufei.xue@linux.alibaba.com>,
        Xu Yu <xuyu@linux.alibaba.com>, peterz@infradead.org,
        mingo@redhat.com, acme@kernel.org
References: <1a4240a8-288b-45d0-073d-d5cb8f0c63eb@linux.alibaba.com>
 <20190226090505.GA24409@kroah.com>
 <c7ccd9cb-3a66-98a9-faa1-7ee5ed20ff88@linux.alibaba.com>
 <20190226130802.GA10343@kroah.com>
From:   Joseph Qi <joseph.qi@linux.alibaba.com>
Message-ID: <1ef19ecb-45b3-0115-d733-fec57d2f0216@linux.alibaba.com>
Date:   Wed, 27 Feb 2019 09:53:10 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:60.0)
 Gecko/20100101 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190226130802.GA10343@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 19/2/26 21:08, Greg KH wrote:
> On Tue, Feb 26, 2019 at 08:32:34PM +0800, Joseph Qi wrote:
>>
>>
>> On 19/2/26 17:05, Greg KH wrote:
>>> On Tue, Feb 26, 2019 at 03:31:14PM +0800, Joseph Qi wrote:
>>>> Hi,
>>>>
>>>> I'm using kernel v4.19.24 and have found that there is an issue when
>>>> using perf probe to define a new dynamic tracepoint.
>>>>
>>>> $ perf probe -a handle_mm_fault
>>>> Failed to write event: Numerical result out of range
>>>>   Error: Failed to add events.
>>>>
>>>> I've also tried kernel v4.20, and it can pass.
>>>
>>> Ick, has this ever worked on the 4.19 stable tree?  If so, any chance
>>> you can run 'git bisect' to find the offending commit?
>>>
>> >From my test, v4.19.0 also has this issue.
>> Bisect locates that it is introduced by commit bf904d2762ee
>> "x86/pti/64: Remove the SYSCALL64 entry trampoline".
> 
> But that commit was in 4.20, not 4.19.  So if this never worked, it's
> not a regression?
> 
> confused,
Oops, my fault.
The first bad commit is:
d83212d5dd67 kallsyms, x86: Export addresses of PTI entry trampolines

It is between v4.18 and v4.19.

> 
> greg k-h
> 
