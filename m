Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-401392-1521258485-2-4695312798623404933
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
    t=1521258483; b=m5j+ho2MLu6J/i9F1KaYKfO5M9yXvmzdhqKRs4q8LcoWF1W
    ADmT/nEok1uNLFtiUX8j93exXS/bxUiavbRn5w2zNNKvMzF67gHOML55mMst/NII
    ujY3egJkiciMX0Bzfl4jpHmKzpae2hzlnOo+wrCrByBBg7JeuEHUem+F0PXqpZb1
    +H/rks5okYxmZZJloyBv6hjFLtpGoAibsyTcU+48Gd0JmkltIAqJ9kZdIN44ioaY
    1zj1sgVw6XPvnFshvFQ6CnehJUwoBt9pGD2qMxv15K/F5zdMAFTTKiKLjIkPpzl6
    CxJQhkzEe6fa4Zo8U/kvJn7Eohio4KlohybPNUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:from:to:cc:references:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1521258483; bh=2Oe50s+iqT4zWjWBV+gA5eu0adE8/mP7egk/9joGNuk=; b=K
    GTXbcmjcHEkpqAoLybER94PmQyM7NrRO3nwsCDVgew2UqKQWnMZzsRpG2U2ptCHL
    BlzkwpBB+GaAJwhhi0f/8P2Svoq+k/2ImDW7p7w5RMQubJK2RnzM+zFd5gZXOAqq
    NpVdS8nuxsf4Uq9wRLEQ03qH6cwhW1Lq61qIZQZdFciUGLmozPNozqxrHikRNyUi
    5ZYQCSVRfl2Mx5fiWODT2TS6NyZ4e6k4xnaGsGyKYhscqTDs11MehbTd8kskyMXh
    /xcc0PRwcYBkwyyWP1QIUlFESJv7p5tTe3rmDfKaNATihhxgwORsz6AhAU3utkrR
    +A634mNLKeOflJXBk4SGw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=nvidia.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=nvidia.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
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
        id S1753082AbeCQDsA (ORCPT <rfc822;greg@kroah.com>);
        Fri, 16 Mar 2018 23:48:00 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:1620 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753039AbeCQDsA (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 16 Mar 2018 23:48:00 -0400
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 16 Mar 2018 20:47:59 -0700
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
X-Nvconfidentiality: public
Message-ID: <b0cd570b-dfe4-4b42-18bb-967d1dbddcb3@nvidia.com>
Date: Fri, 16 Mar 2018 20:47:58 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <7e87c1f9-5c1a-84fd-1f7f-55ffaaed8a66@nvidia.com>
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

On 03/16/2018 07:36 PM, John Hubbard wrote:
> On 03/16/2018 12:14 PM, jglisse@redhat.com wrote:
>> From: Ralph Campbell <rcampbell@nvidia.com>
>>
> 
> <snip>
> 
>> +static void hmm_release(struct mmu_notifier *mn, struct mm_struct *mm)
>> +{
>> +	struct hmm *hmm = mm->hmm;
>> +	struct hmm_mirror *mirror;
>> +	struct hmm_mirror *mirror_next;
>> +
>> +	down_write(&hmm->mirrors_sem);
>> +	list_for_each_entry_safe(mirror, mirror_next, &hmm->mirrors, list) {
>> +		list_del_init(&mirror->list);
>> +		if (mirror->ops->release)
>> +			mirror->ops->release(mirror);
>> +	}
>> +	up_write(&hmm->mirrors_sem);
>> +}
>> +
> 
> OK, as for actual code review:
> 
> This part of the locking looks good. However, I think it can race against
> hmm_mirror_register(), because hmm_mirror_register() will just add a new 
> mirror regardless.
> 
> So:
> 
> thread 1                                      thread 2
> --------------                                -----------------
> hmm_release                                   hmm_mirror_register 
>     down_write(&hmm->mirrors_sem);                <blocked: waiting for sem>
>         // deletes all list items
>     up_write
>                                                   unblocked: adds new mirror
>                                               
> 
> ...so I think we need a way to back out of any pending hmm_mirror_register()
> calls, as part of the .release steps, right? It seems hard for the device driver,
> which could be inside of hmm_mirror_register(), to handle that. Especially considering
> that right now, hmm_mirror_register() will return success in this case--so
> there is no indication that anything is wrong.
> 
> Maybe hmm_mirror_register() could return an error (and not add to the mirror list),
> in such a situation, how's that sound?
> 

In other words, I think this would help (not tested yet beyond a quick compile,
but it's pretty simple):

diff --git a/mm/hmm.c b/mm/hmm.c
index 7ccca5478ea1..da39f8522dca 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -66,6 +66,7 @@ struct hmm {
        struct list_head        mirrors;
        struct mmu_notifier     mmu_notifier;
        struct rw_semaphore     mirrors_sem;
+       bool                    shutting_down;
 };
 
 /*
@@ -99,6 +100,7 @@ static struct hmm *hmm_register(struct mm_struct *mm)
        INIT_LIST_HEAD(&hmm->ranges);
        spin_lock_init(&hmm->lock);
        hmm->mm = mm;
+       hmm->shutting_down = false;
 
        /*
         * We should only get here if hold the mmap_sem in write mode ie on
@@ -167,6 +169,7 @@ static void hmm_release(struct mmu_notifier *mn, struct mm_struct *mm)
        struct hmm_mirror *mirror_next;
 
        down_write(&hmm->mirrors_sem);
+       hmm->shutting_down = true;
        list_for_each_entry_safe(mirror, mirror_next, &hmm->mirrors, list) {
                list_del_init(&mirror->list);
                if (mirror->ops->release)
@@ -227,6 +230,10 @@ int hmm_mirror_register(struct hmm_mirror *mirror, struct mm_struct *mm)
                return -ENOMEM;
 
        down_write(&mirror->hmm->mirrors_sem);
+       if (mirror->hmm->shutting_down) {
+               up_write(&mirror->hmm->mirrors_sem);
+               return -ESRCH;
+       }
        list_add(&mirror->list, &mirror->hmm->mirrors);
        up_write(&mirror->hmm->mirrors_sem);


thanks,
-- 
John Hubbard
NVIDIA
