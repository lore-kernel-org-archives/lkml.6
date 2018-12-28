Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 311B1C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 02:59:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0FA821901
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 02:59:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728779AbeL1C7a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Dec 2018 21:59:30 -0500
Received: from mga11.intel.com ([192.55.52.93]:20917 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727103AbeL1C73 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Dec 2018 21:59:29 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Dec 2018 18:59:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,407,1539673200"; 
   d="scan'208";a="131172362"
Received: from kemi-desktop.sh.intel.com (HELO [10.239.13.130]) ([10.239.13.130])
  by fmsmga004.fm.intel.com with ESMTP; 27 Dec 2018 18:59:27 -0800
Subject: Re: [LKP] [mm] 9bc8039e71: will-it-scale.per_thread_ops -64.1%
 regression
To:     Waiman Long <longman@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "vbabka@suse.cz" <vbabka@suse.cz>,
        Davidlohr Bueso <dave@stgolabs.net>
Cc:     "yang.shi@linux.alibaba.com" <yang.shi@linux.alibaba.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        "mhocko@kernel.org" <mhocko@kernel.org>,
        Colin King <colin.king@canonical.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "ldufour@linux.vnet.ibm.com" <ldufour@linux.vnet.ibm.com>,
        "lkp@01.org" <lkp@01.org>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>
References: <20181105050813.GP24195@shao2-debian>
 <CAHk-=wi8BNNTp+Xt4ROz1TqGgFT-c6-Hmmc9yW0B6p2FTFwJTg@mail.gmail.com>
 <f901e346-6203-371d-a39a-ed9231187570@suse.cz>
 <CAHk-=wjZ1C2iL79jOuC9ysvX2oRpUjoqXirvY0NRuLC0eQ8nbg@mail.gmail.com>
 <60ef3584-6f3a-1a9a-94d1-3d4a5b9f1e56@redhat.com>
 <25017BF213203E48912DB000DE5F5E1E76365678@SHSMSX101.ccr.corp.intel.com>
 <9a6fdc15-4ce1-9c55-d660-a9825b9ae104@redhat.com>
From:   kemi <kemi.wang@intel.com>
Message-ID: <8963c923-ef98-6752-6670-b9193267ca01@intel.com>
Date:   Fri, 28 Dec 2018 10:55:05 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <9a6fdc15-4ce1-9c55-d660-a9825b9ae104@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018/12/28 上午10:55, Waiman Long wrote:
> On 12/27/2018 08:31 PM, Wang, Kemi wrote:
>> Hi, Waiman
>>    Did you post that patch? Let's see if it helps.
> 
> I did post the patch a while ago. I will need to rebase it to a new
> baseline. Will do that in a week or 2.
> 

OK．I　will take a look at it and try to rebase it on shi's patch to see if 
the regression can be fixed.
May I know where I can get that patch, I didn't find it in my inbox. Thanks

> -Longman
> 
>>
>> -----Original Message-----
>> From: LKP [mailto:lkp-bounces@lists.01.org] On Behalf Of Waiman Long
>> Sent: Tuesday, November 6, 2018 6:40 AM
>> To: Linus Torvalds <torvalds@linux-foundation.org>; vbabka@suse.cz; Davidlohr Bueso <dave@stgolabs.net>
>> Cc: yang.shi@linux.alibaba.com; Linux Kernel Mailing List <linux-kernel@vger.kernel.org>; Matthew Wilcox <willy@infradead.org>; mhocko@kernel.org; Colin King <colin.king@canonical.com>; Andrew Morton <akpm@linux-foundation.org>; ldufour@linux.vnet.ibm.com; lkp@01.org; kirill.shutemov@linux.intel.com
>> Subject: Re: [LKP] [mm] 9bc8039e71: will-it-scale.per_thread_ops -64.1% regression
>>
>> On 11/05/2018 05:14 PM, Linus Torvalds wrote:
>>> On Mon, Nov 5, 2018 at 12:12 PM Vlastimil Babka <vbabka@suse.cz> wrote:
>>>> I didn't spot an obvious mistake in the patch itself, so it looks
>>>> like some bad interaction between scheduler and the mmap downgrade?
>>> I'm thinking it's RWSEM_SPIN_ON_OWNER that ends up being confused by
>>> the downgrade.
>>>
>>> It looks like the benchmark used to be basically CPU-bound, at about
>>> 800% CPU, and now it's somewhere in the 200% CPU region:
>>>
>>>                   will-it-scale.time.percent_of_cpu_this_job_got
>>>
>>>   800 +-+-------------------------------------------------------------------+
>>>       |.+.+.+.+.+.+.+.  .+.+.+.+.+.+.+.+.+.+.+.+.+.+.+.+.+..+.+.+.+. .+.+.+.|
>>>   700 +-+             +.                                            +       |
>>>       |                                                                     |
>>>   600 +-+                                                                   |
>>>       |                                                                     |
>>>   500 +-+                                                                   |
>>>       |                                                                     |
>>>   400 +-+                                                                   |
>>>       |                                                                     |
>>>   300 +-+                                                                   |
>>>       |                                                                     |
>>>   200 O-O O O O O                O                                          |
>>>       |           O O O  O O O O   O O O O O O O O O O O                    |
>>>   100 +-+-------------------------------------------------------------------+
>>>
>>> which sounds like the downgrade really messes with the "spin waiting
>>> for lock" logic.
>>>
>>> I'm thinking it's the "wake up waiter" logic that has some bad
>>> interaction with spinning, and breaks that whole optimization.
>>>
>>> Adding Waiman and Davidlohr to the participants, because they seem to
>>> be the obvious experts in this area.
>>>
>>>                             Linus
>> Optimistic spinning on rwsem is done only on writers spinning on a
>> writer-owned rwsem. If a write-lock is downgraded to a read-lock, all
>> the spinning waiters will quit. That may explain the drop in cpu
>> utilization. I do have a old patch that enable a certain amount of
>> reader spinning which may help the situation. I can rebase that and send
>> it out for review if people have interest.
>>
>> Cheers,
>> Longman
>>
>>
>> _______________________________________________
>> LKP mailing list
>> LKP@lists.01.org
>> https://lists.01.org/mailman/listinfo/lkp
> 
> 
