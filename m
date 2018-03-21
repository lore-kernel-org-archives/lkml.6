Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1079496-1521673857-2-12349592576003400985
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='UNK'
X-Spam-charsets: plain='utf-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521673857; b=JbCg6pQnj6pfyaj5tUZ7O66L4f114EGFnbw1ijlNtAMo09P
    9uRgblBD7Rl+ZFgghVKSuo0yTXbZ5Y5pb/OvDlEoIie+xLrub3ZH1lyLc11lH9jA
    eBeiKOOtpOUUP1JqFP/8sajMixp8SrxdIxtvIM/WxjNrh8BpqnabZY22tnOUY6nj
    derqT3PuoM83xIhRvsh5jxEMarpm/tOPV7FhR4iKF/5sBbY3sJh8t+L1eZ20dtrm
    vFxXzgsk3WChv9VofVdwFPqG2wlBwAzpwARm1GEgQEUS+nSt1dO4EEqpMUW0sC0A
    5oolD+K843XGlSCAg0n3+NcOt8vXzAHu8RdLMcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1521673857; bh=bdLQND42A37IXT/nWCPE0qAc71OxX2r303DU5dhrpWg=; b=V
    YrCgaab3s6AopLx9Sqx2r39h/vEgIU+BwiSSBpEQHCv1zq6al5LR9jqmvCE5Cksb
    HAot53gX3dfDTA8qoaedcfRbBhyOl1WnY6op0M/3nQeif2h9sCSJR257bNgUR0mD
    GjXLDAv6vQ0QxNcILNl7j6Vexdjnnb8JEM29ew7y9Lpkb2iW+uiD9ngOyAkCc+ku
    Uk9PIMHkQiIKCkHdOO0JVa8PpfIFmIXQOdfBZ1zLu9NWOLW7qUCS76VnoGTqyYsg
    rSc1Jow6Fd93YMGXQ4FrW2bTOpaRAuQ/RYQgCN83+JGfXgAvKsMmVVBnBVwYjXWl
    S9Llyz6Tx7lQlyYeol3SA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=nvidia.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=nvidia.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=nvidia.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=nvidia.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754319AbeCUXKk convert rfc822-to-8bit (ORCPT
        <rfc822;greg@kroah.com>); Wed, 21 Mar 2018 19:10:40 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:14683 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754279AbeCUXKe (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 21 Mar 2018 19:10:34 -0400
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Wed, 21 Mar 2018 16:10:28 -0700
Subject: Re: [PATCH 03/15] mm/hmm: HMM should have a callback before MM is
 destroyed v2
To: Jerome Glisse <jglisse@redhat.com>
CC: <linux-mm@kvack.org>, Andrew Morton <akpm@linux-foundation.org>,
        <linux-kernel@vger.kernel.org>,
        Ralph Campbell <rcampbell@nvidia.com>,
        <stable@vger.kernel.org>, Evgeny Baskakov <ebaskakov@nvidia.com>,
        Mark Hairgrove <mhairgrove@nvidia.com>
References: <20180320020038.3360-1-jglisse@redhat.com>
 <20180320020038.3360-4-jglisse@redhat.com>
 <d89e417d-c939-4d18-72f5-08b22dc6cff0@nvidia.com>
 <20180321180342.GE3214@redhat.com>
 <788cf786-edbf-ab43-af0d-abbe9d538757@nvidia.com>
 <20180321224620.GH3214@redhat.com>
X-Nvconfidentiality: public
From: John Hubbard <jhubbard@nvidia.com>
Message-ID: <3f4e78a1-5a88-399d-e134-497229c42707@nvidia.com>
Date: Wed, 21 Mar 2018 16:10:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180321224620.GH3214@redhat.com>
X-Originating-IP: [10.110.48.28]
X-ClientProxiedBy: HQMAIL108.nvidia.com (172.18.146.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8BIT
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 03/21/2018 03:46 PM, Jerome Glisse wrote:
> On Wed, Mar 21, 2018 at 03:16:04PM -0700, John Hubbard wrote:
>> On 03/21/2018 11:03 AM, Jerome Glisse wrote:
>>> On Tue, Mar 20, 2018 at 09:14:34PM -0700, John Hubbard wrote:
>>>> On 03/19/2018 07:00 PM, jglisse@redhat.com wrote:
>>>>> From: Ralph Campbell <rcampbell@nvidia.com>
>>
>> <snip>
>>
>>>> Hi Jerome,
>>>>
>>>> This presents a deadlock problem (details below). As for solution ideas, 
>>>> Mark Hairgrove points out that the MMU notifiers had to solve the
>>>> same sort of problem, and part of the solution involves "avoid
>>>> holding locks when issuing these callbacks". That's not an entire 
>>>> solution description, of course, but it seems like a good start.
>>>>
>>>> Anyway, for the deadlock problem:
>>>>
>>>> Each of these ->release callbacks potentially has to wait for the 
>>>> hmm_invalidate_range() callbacks to finish. That is not shown in any
>>>> code directly, but it's because: when a device driver is processing 
>>>> the above ->release callback, it has to allow any in-progress operations 
>>>> to finish up (as specified clearly in your comment documentation above). 
>>>>
>>>> Some of those operations will invariably need to do things that result 
>>>> in page invalidations, thus triggering the hmm_invalidate_range() callback.
>>>> Then, the hmm_invalidate_range() callback tries to acquire the same 
>>>> hmm->mirrors_sem lock, thus leading to deadlock:
>>>>
>>>> hmm_invalidate_range():
>>>> // ...
>>>> 	down_read(&hmm->mirrors_sem);
>>>> 	list_for_each_entry(mirror, &hmm->mirrors, list)
>>>> 		mirror->ops->sync_cpu_device_pagetables(mirror, action,
>>>> 							start, end);
>>>> 	up_read(&hmm->mirrors_sem);
>>>
>>> That is just illegal, the release callback is not allowed to trigger
>>> invalidation all it does is kill all device's threads and stop device
>>> page fault from happening. So there is no deadlock issues. I can re-
>>> inforce the comment some more (see [1] for example on what it should
>>> be).
>>
>> That rule is fine, and it is true that the .release callback will not 
>> directly trigger any invalidations. However, the problem is in letting 
>> any *existing* outstanding operations finish up. We have to let 
>> existing operations "drain", in order to meet the requirement that 
>> everything is done when .release returns.
>>
>> For example, if a device driver thread is in the middle of working through
>> its fault buffer, it will call migrate_vma(), which will in turn unmap
>> pages. That will cause an hmm_invalidate_range() callback, which tries
>> to take hmm->mirrors_sems, and we deadlock.
>>
>> There's no way to "kill" such a thread while it's in the middle of
>> migrate_vma(), you have to let it finish up.
>>
>>> Also it is illegal for the sync callback to trigger any mmu_notifier
>>> callback. I thought this was obvious. The sync callback should only
>>> update device page table and do _nothing else_. No way to make this
>>> re-entrant.
>>
>> That is obvious, yes. I am not trying to say there is any problem with
>> that rule. It's the "drain outstanding operations during .release", 
>> above, that is the real problem.
> 
> Maybe just relax the release callback wording, it should stop any
> more processing of fault buffer but not wait for it to finish. In
> nouveau code i kill thing but i do not wait hence i don't deadlock.

But you may crash, because that approach allows .release to finish
up, thus removing the mm entirely, out from under (for example)
a migrate_vma call--or any other call that refers to the mm.

It doesn't seem too hard to avoid the problem, though: maybe we
can just drop the lock while doing the mirror->ops->release callback.
There are a few ways to do this, but one example is: 

    -- take the lock,
        -- copy the list to a local list, deleting entries as you go,
    -- drop the lock, 
    -- iterate through the local list copy and 
        -- issue the mirror->ops->release callbacks.

At this point, more items could have been added to the list, so repeat
the above until the original list is empty. 

This is subject to a limited starvation case if mirror keep getting 
registered, but I think we can ignore that, because it only lasts as long as 
mirrors keep getting added, and then it finishes up.

> 
> What matter is to stop any further processing. Yes some fault might
> be in flight but they will serialize on various lock. 

Those faults in flight could already be at a point where they have taken
whatever locks they need, so we don't dare let the mm get destroyed while
such fault handling is in progress.


So just do not
> wait in the release callback, kill thing. I might have a bug where i
> still fill in GPU page table in nouveau, i will check nouveau code
> for that.

Again, we can't "kill" a thread of execution (this would often be an
interrupt bottom half context, btw) while it is, for example,
in the middle of migrate_vma.

I really don't believe there is a safe way to do this without draining
the existing operations before .release returns, and for that, we'll need to 
issue the .release callbacks while not holding locks.

thanks,
-- 
John Hubbard
NVIDIA

> 
> Kill thing should also kill the channel (i don't do that in nouveau
> because i am waiting on some channel patchset) but i am not sure if
> hardware like it if we kill channel before stoping fault notification.
> 
> Cheers,
> Jérôme
> 
