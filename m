Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-502012-1521261545-2-10301348887651927697
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
    t=1521261544; b=uc3q7CmbyD0Whjl00goWD6kDB9P+J9YuTdHrlSpnWJw0tqb
    f76oF1lnmwgZQPb6o+NSjj1DtYUYILby8cO54faa9iXq2B00hJM6deTzEErOzAAo
    IJlFXe0j1B143kaJ4QfBYfHZlJqPFuE2dhSFdT7zs1QrwjzBgOBYHKD7yuUfW4mn
    Lk+CEBt53xVu0pK9HbgrhHZf+K5ikrnuhMwT5FLOupDArTBe3CAUgWzpAV/ivppS
    td50G3Jh7gI1vxKjLDZS0jKOM/JJl/2dh87xDS4jGIYBmeq0tN32ldS7gAbXTe/O
    c7x30HDqmvGrX/MHyCqTyg2OlIkwtkhbYnq8/dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:from:to:cc:references:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1521261544; bh=3VeTP6I3CpjkFP0hV0UAQjZZB0I4EIcvip6kQTILaEc=; b=Z
    D5q1hMRpiQ4B657JUAFwOnT5ZvbKKVKMJzOZGuFxNk+IxIWFz40WjPN1MDV/IZh7
    bn6vlT+BgpUL/cCn7lZmMyv2bn6eMSxWty53UB1FUfrVPNZzHCKzW/FXwFQup6To
    mQ6G5mWM2zDLtPTYsshm0Jq4HDxZJAq6dqjLGh1lebFQ3x4rFPM28kD6nGmcXuUl
    /0ChRnAJdnAYJjKS8Ue1OkSA8SBYT+dEEosVA9CWts6Ls6jo9vvq51sMPWM6mwHd
    zXaO2zQS4pZRrsycgA4TffUJyO2VDlL7Dno0D+/L/E9Zpn14D92HmDn/DX9ew84g
    +Cx+nSHrygTtyi+P8U0NQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=nvidia.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=nvidia.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=nvidia.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=nvidia.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750981AbeCQEjC (ORCPT <rfc822;greg@kroah.com>);
        Sat, 17 Mar 2018 00:39:02 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:19547 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750919AbeCQEjB (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 17 Mar 2018 00:39:01 -0400
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 16 Mar 2018 21:39:01 -0700
Subject: Re: [PATCH 03/14] mm/hmm: HMM should have a callback before MM is
 destroyed v2
From: John Hubbard <jhubbard@nvidia.com>
To: <jglisse@redhat.com>, <linux-mm@kvack.org>
CC: Andrew Morton <akpm@linux-foundation.org>,
        <linux-kernel@vger.kernel.org>,
        Ralph Campbell <rcampbell@nvidia.com>,
        <stable@vger.kernel.org>, Evgeny Baskakov <ebaskakov@nvidia.com>,
        Mark Hairgrove <mhairgrove@nvidia.com>
References: <20180316191414.3223-1-jglisse@redhat.com>
 <20180316191414.3223-4-jglisse@redhat.com>
 <7e87c1f9-5c1a-84fd-1f7f-55ffaaed8a66@nvidia.com>
 <b0cd570b-dfe4-4b42-18bb-967d1dbddcb3@nvidia.com>
X-Nvconfidentiality: public
Message-ID: <b1406b15-858f-00a2-e2c1-a950d190f0e1@nvidia.com>
Date: Fri, 16 Mar 2018 21:39:00 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <b0cd570b-dfe4-4b42-18bb-967d1dbddcb3@nvidia.com>
X-Originating-IP: [10.110.48.28]
X-ClientProxiedBy: HQMAIL103.nvidia.com (172.20.187.11) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 03/16/2018 08:47 PM, John Hubbard wrote:
> On 03/16/2018 07:36 PM, John Hubbard wrote:
>> On 03/16/2018 12:14 PM, jglisse@redhat.com wrote:
>>> From: Ralph Campbell <rcampbell@nvidia.com>
>>>
>>
>> <snip>
>>
>>> +static void hmm_release(struct mmu_notifier *mn, struct mm_struct *mm)
>>> +{
>>> +	struct hmm *hmm = mm->hmm;
>>> +	struct hmm_mirror *mirror;
>>> +	struct hmm_mirror *mirror_next;
>>> +
>>> +	down_write(&hmm->mirrors_sem);
>>> +	list_for_each_entry_safe(mirror, mirror_next, &hmm->mirrors, list) {
>>> +		list_del_init(&mirror->list);
>>> +		if (mirror->ops->release)
>>> +			mirror->ops->release(mirror);
>>> +	}
>>> +	up_write(&hmm->mirrors_sem);
>>> +}
>>> +
>>
>> OK, as for actual code review:
>>
>> This part of the locking looks good. However, I think it can race against
>> hmm_mirror_register(), because hmm_mirror_register() will just add a new 
>> mirror regardless.
>>
>> So:
>>
>> thread 1                                      thread 2
>> --------------                                -----------------
>> hmm_release                                   hmm_mirror_register 
>>     down_write(&hmm->mirrors_sem);                <blocked: waiting for sem>
>>         // deletes all list items
>>     up_write
>>                                                   unblocked: adds new mirror
>>                                               
>>

Mark Hairgrove just pointed out some more fun facts:

1. Because hmm_mirror_register() needs to be called with an mm that has a non-zero
refcount, you generally cannot get an hmm_release callback, so the above race should
not happen.

2. We looked around, and the code is missing a call to mmu_notifier_unregister().
That means that it is going to leak memory and not let the mm get released either.

Maybe having each mirror have its own mmu notifier callback is a possible way
to solve this.

thanks,
-- 
John Hubbard
NVIDIA
