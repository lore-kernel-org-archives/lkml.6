Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D2A7C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 02:55:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D22F5214C6
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 02:55:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728612AbeL1Czx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Dec 2018 21:55:53 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48960 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726873AbeL1Czx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Dec 2018 21:55:53 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3E8AC3D15;
        Fri, 28 Dec 2018 02:55:51 +0000 (UTC)
Received: from llong.remote.csb (ovpn-120-3.rdu2.redhat.com [10.10.120.3])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7A6C761527;
        Fri, 28 Dec 2018 02:55:48 +0000 (UTC)
Subject: Re: [LKP] [mm] 9bc8039e71: will-it-scale.per_thread_ops -64.1%
 regression
To:     "Wang, Kemi" <kemi.wang@intel.com>,
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
From:   Waiman Long <longman@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=longman@redhat.com; prefer-encrypt=mutual; keydata=
 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
 weim8xU=
Organization: Red Hat
Message-ID: <9a6fdc15-4ce1-9c55-d660-a9825b9ae104@redhat.com>
Date:   Thu, 27 Dec 2018 21:55:49 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <25017BF213203E48912DB000DE5F5E1E76365678@SHSMSX101.ccr.corp.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Fri, 28 Dec 2018 02:55:52 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/27/2018 08:31 PM, Wang, Kemi wrote:
> Hi, Waiman
>    Did you post that patch? Let's see if it helps.

I did post the patch a while ago. I will need to rebase it to a new
baseline. Will do that in a week or 2.

-Longman

>
> -----Original Message-----
> From: LKP [mailto:lkp-bounces@lists.01.org] On Behalf Of Waiman Long
> Sent: Tuesday, November 6, 2018 6:40 AM
> To: Linus Torvalds <torvalds@linux-foundation.org>; vbabka@suse.cz; Davidlohr Bueso <dave@stgolabs.net>
> Cc: yang.shi@linux.alibaba.com; Linux Kernel Mailing List <linux-kernel@vger.kernel.org>; Matthew Wilcox <willy@infradead.org>; mhocko@kernel.org; Colin King <colin.king@canonical.com>; Andrew Morton <akpm@linux-foundation.org>; ldufour@linux.vnet.ibm.com; lkp@01.org; kirill.shutemov@linux.intel.com
> Subject: Re: [LKP] [mm] 9bc8039e71: will-it-scale.per_thread_ops -64.1% regression
>
> On 11/05/2018 05:14 PM, Linus Torvalds wrote:
>> On Mon, Nov 5, 2018 at 12:12 PM Vlastimil Babka <vbabka@suse.cz> wrote:
>>> I didn't spot an obvious mistake in the patch itself, so it looks
>>> like some bad interaction between scheduler and the mmap downgrade?
>> I'm thinking it's RWSEM_SPIN_ON_OWNER that ends up being confused by
>> the downgrade.
>>
>> It looks like the benchmark used to be basically CPU-bound, at about
>> 800% CPU, and now it's somewhere in the 200% CPU region:
>>
>>                   will-it-scale.time.percent_of_cpu_this_job_got
>>
>>   800 +-+-------------------------------------------------------------------+
>>       |.+.+.+.+.+.+.+.  .+.+.+.+.+.+.+.+.+.+.+.+.+.+.+.+.+..+.+.+.+. .+.+.+.|
>>   700 +-+             +.                                            +       |
>>       |                                                                     |
>>   600 +-+                                                                   |
>>       |                                                                     |
>>   500 +-+                                                                   |
>>       |                                                                     |
>>   400 +-+                                                                   |
>>       |                                                                     |
>>   300 +-+                                                                   |
>>       |                                                                     |
>>   200 O-O O O O O                O                                          |
>>       |           O O O  O O O O   O O O O O O O O O O O                    |
>>   100 +-+-------------------------------------------------------------------+
>>
>> which sounds like the downgrade really messes with the "spin waiting
>> for lock" logic.
>>
>> I'm thinking it's the "wake up waiter" logic that has some bad
>> interaction with spinning, and breaks that whole optimization.
>>
>> Adding Waiman and Davidlohr to the participants, because they seem to
>> be the obvious experts in this area.
>>
>>                             Linus
> Optimistic spinning on rwsem is done only on writers spinning on a
> writer-owned rwsem. If a write-lock is downgraded to a read-lock, all
> the spinning waiters will quit. That may explain the drop in cpu
> utilization. I do have a old patch that enable a certain amount of
> reader spinning which may help the situation. I can rebase that and send
> it out for review if people have interest.
>
> Cheers,
> Longman
>
>
> _______________________________________________
> LKP mailing list
> LKP@lists.01.org
> https://lists.01.org/mailman/listinfo/lkp


