Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-878172-1521670569-2-14882182946202310073
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
    t=1521670568; b=WQIYYCTnRCwiF53dd/8phrsms/UZQuT3AQw+EVxhCtgd9FW
    m0DJp3444l5AxtdpKeFFLEUMStK7q8KWAD1E1hNa34SnwF5Xtkjj9njA9uzUYchp
    0EdGOa30AXQv+dVEkQ1ys2kzWRepiftv5Qk2KrS6bd17IC4EWTEMwqzFgmi69eAQ
    J+mAOL1RFxuhCnqQNxjMMOwBlMqTJU38EQG0f44hH2Ocu0r9yTQLTLvGq9DPKK6j
    syMujvRQRwQLRkw6LnosZYPvR/Awmg+DES+49kNQEkUUROwbhWTPtAn5OqFefa9g
    qJlETkYRozZzkL0QAEL27wr4hC+XXEzwBbFDv2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1521670568; bh=JAik5NrF9Q00v0khws9ih2UriOabaTvZpRH6310KR+Q=; b=O
    YucnpI533+srDA+lgzaG7+sy23D3avOwAZLfN1MbW/XzxkWQMoE4RHMVb1K2CROA
    FLWa6DK/SsZH2XvGXkSQYBDgz8gncBYuJs0S30m3bhRUekkC4b3yjSOxKbK8EeZY
    nIQViEYmpI19qlihBKsl4pN5AsM0lI6qahVAHhyiDuMtsMj+ImKSdIyCu5M1AUt5
    CmRvCE9ueWRyDssdMIN2VznpbYI7d07mOYGGiT46puOTRutp3QNj1DFHBUmu70f1
    6ZZMhb1ExaANavVz5K9WQHyICcshwhk4KtTo5y7GWbaPdzeBwVM3SQ0IYdcgqCmy
    j/Hhx24URPjhTSnl6+8lg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=nvidia.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=nvidia.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
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
        id S1753870AbeCUWQG convert rfc822-to-8bit (ORCPT
        <rfc822;greg@kroah.com>); Wed, 21 Mar 2018 18:16:06 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:9625 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753744AbeCUWQF (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 21 Mar 2018 18:16:05 -0400
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 21 Mar 2018 15:16:04 -0700
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
X-Nvconfidentiality: public
From: John Hubbard <jhubbard@nvidia.com>
Message-ID: <788cf786-edbf-ab43-af0d-abbe9d538757@nvidia.com>
Date: Wed, 21 Mar 2018 15:16:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180321180342.GE3214@redhat.com>
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

On 03/21/2018 11:03 AM, Jerome Glisse wrote:
> On Tue, Mar 20, 2018 at 09:14:34PM -0700, John Hubbard wrote:
>> On 03/19/2018 07:00 PM, jglisse@redhat.com wrote:
>>> From: Ralph Campbell <rcampbell@nvidia.com>

<snip>

>> Hi Jerome,
>>
>> This presents a deadlock problem (details below). As for solution ideas, 
>> Mark Hairgrove points out that the MMU notifiers had to solve the
>> same sort of problem, and part of the solution involves "avoid
>> holding locks when issuing these callbacks". That's not an entire 
>> solution description, of course, but it seems like a good start.
>>
>> Anyway, for the deadlock problem:
>>
>> Each of these ->release callbacks potentially has to wait for the 
>> hmm_invalidate_range() callbacks to finish. That is not shown in any
>> code directly, but it's because: when a device driver is processing 
>> the above ->release callback, it has to allow any in-progress operations 
>> to finish up (as specified clearly in your comment documentation above). 
>>
>> Some of those operations will invariably need to do things that result 
>> in page invalidations, thus triggering the hmm_invalidate_range() callback.
>> Then, the hmm_invalidate_range() callback tries to acquire the same 
>> hmm->mirrors_sem lock, thus leading to deadlock:
>>
>> hmm_invalidate_range():
>> // ...
>> 	down_read(&hmm->mirrors_sem);
>> 	list_for_each_entry(mirror, &hmm->mirrors, list)
>> 		mirror->ops->sync_cpu_device_pagetables(mirror, action,
>> 							start, end);
>> 	up_read(&hmm->mirrors_sem);
> 
> That is just illegal, the release callback is not allowed to trigger
> invalidation all it does is kill all device's threads and stop device
> page fault from happening. So there is no deadlock issues. I can re-
> inforce the comment some more (see [1] for example on what it should
> be).

That rule is fine, and it is true that the .release callback will not 
directly trigger any invalidations. However, the problem is in letting 
any *existing* outstanding operations finish up. We have to let 
existing operations "drain", in order to meet the requirement that 
everything is done when .release returns.

For example, if a device driver thread is in the middle of working through
its fault buffer, it will call migrate_vma(), which will in turn unmap
pages. That will cause an hmm_invalidate_range() callback, which tries
to take hmm->mirrors_sems, and we deadlock.

There's no way to "kill" such a thread while it's in the middle of
migrate_vma(), you have to let it finish up.

> 
> Also it is illegal for the sync callback to trigger any mmu_notifier
> callback. I thought this was obvious. The sync callback should only
> update device page table and do _nothing else_. No way to make this
> re-entrant.

That is obvious, yes. I am not trying to say there is any problem with
that rule. It's the "drain outstanding operations during .release", 
above, that is the real problem.

thanks,
-- 
John Hubbard
NVIDIA

> 
> For anonymous private memory migrated to device memory it is freed
> shortly after the release callback (see exit_mmap()). For share memory
> you might want to migrate back to regular memory but that will be fine
> as you will not get mmu_notifier callback any more.
> 
> So i don't see any deadlock here.
> 
> Cheers,
> Jérôme
> 
> [1] https://cgit.freedesktop.org/~glisse/linux/commit/?h=nouveau-hmm&id=93adb3e6b4f39d5d146b6a8afb4175d37bdd4890
> 
