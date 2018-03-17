Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-282014-1521254191-2-560366454892709475
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
    t=1521254191; b=WXTT7LJHrk63VaVrNA1SWkxrhKUkaN3mXyNa+ofjIecZcWW
    cggmT0nOBwt7cMmiGIqDqezmY01VBZxkqurA8WjbyPA70qsk0lmfT8N11T5IvqdN
    NvipnUw+PB7dx89NoAxtvs3KcYvk1bcz9hSA4uY9pdSjIHkvMCjsgiLspbBFFzXq
    1LOIaWW0QaF8qx2yhWcD8PLNwjrVmQIL+atym6GoSlnDmSgXvdEB2gZ4AgfYOdTw
    83WaofYMuzcMk8BPkVoKfqwYMS8o4apANTT7AXanM2Uxmu9Yf+TJQSBEtndypNFM
    6BKmFGeVtpRaVCeUtq9zEVZdAbGRLZO6QK0o7Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1521254191; bh=llzesmZrcvHqzpUI9/ox7RkgZGu5gUgoy2Wxy68KM4Q=; b=m
    b/rTIZzHBdqX6MBs4ot+6IebGn7fxpAI39fllcs1Qazct5OYcF7EcGasSU8pxZ2P
    PRwXhECqlufH82tHVuHod9wWElY8J9YmSO5MkkyR4acedT7qgqt3WfgvQbW25/+B
    3vmd8l9Ih0X3/ZbgF1jfkzOv2E+dEtyJUG40azxzQZQuJti9ChDzVq82WvvYr/fv
    EV6zbYt09BwUaJuSPohqqtQw9/WcPvo4cZvhlmamSHiGn1M6MmQElMjABMIFWcHT
    sSqoZeaLT25SXvF04Pudp2uaWqLt17cNm3ajKtdlKhB1+pW8/0m04HjEcDDHIO0f
    vaG+MKenRi+iKR9bwtddA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=nvidia.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=nvidia.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
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
        id S1751437AbeCQCgZ (ORCPT <rfc822;greg@kroah.com>);
        Fri, 16 Mar 2018 22:36:25 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:19055 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751372AbeCQCgY (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 16 Mar 2018 22:36:24 -0400
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 16 Mar 2018 19:36:24 -0700
Subject: Re: [PATCH 03/14] mm/hmm: HMM should have a callback before MM is
 destroyed v2
To: <jglisse@redhat.com>, <linux-mm@kvack.org>
CC: Andrew Morton <akpm@linux-foundation.org>,
        <linux-kernel@vger.kernel.org>,
        Ralph Campbell <rcampbell@nvidia.com>,
        <stable@vger.kernel.org>, Evgeny Baskakov <ebaskakov@nvidia.com>,
        Mark Hairgrove <mhairgrove@nvidia.com>
References: <20180316191414.3223-1-jglisse@redhat.com>
 <20180316191414.3223-4-jglisse@redhat.com>
X-Nvconfidentiality: public
From: John Hubbard <jhubbard@nvidia.com>
Message-ID: <7e87c1f9-5c1a-84fd-1f7f-55ffaaed8a66@nvidia.com>
Date: Fri, 16 Mar 2018 19:36:23 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180316191414.3223-4-jglisse@redhat.com>
X-Originating-IP: [10.110.48.28]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 03/16/2018 12:14 PM, jglisse@redhat.com wrote:
> From: Ralph Campbell <rcampbell@nvidia.com>
> 

<snip>

> +static void hmm_release(struct mmu_notifier *mn, struct mm_struct *mm)
> +{
> +	struct hmm *hmm = mm->hmm;
> +	struct hmm_mirror *mirror;
> +	struct hmm_mirror *mirror_next;
> +
> +	down_write(&hmm->mirrors_sem);
> +	list_for_each_entry_safe(mirror, mirror_next, &hmm->mirrors, list) {
> +		list_del_init(&mirror->list);
> +		if (mirror->ops->release)
> +			mirror->ops->release(mirror);
> +	}
> +	up_write(&hmm->mirrors_sem);
> +}
> +

OK, as for actual code review:

This part of the locking looks good. However, I think it can race against
hmm_mirror_register(), because hmm_mirror_register() will just add a new 
mirror regardless.

So:

thread 1                                      thread 2
--------------                                -----------------
hmm_release                                   hmm_mirror_register 
    down_write(&hmm->mirrors_sem);                <blocked: waiting for sem>
        // deletes all list items
    up_write
                                                  unblocked: adds new mirror
                                              

...so I think we need a way to back out of any pending hmm_mirror_register()
calls, as part of the .release steps, right? It seems hard for the device driver,
which could be inside of hmm_mirror_register(), to handle that. Especially considering
that right now, hmm_mirror_register() will return success in this case--so
there is no indication that anything is wrong.

Maybe hmm_mirror_register() could return an error (and not add to the mirror list),
in such a situation, how's that sound?

thanks,
-- 
John Hubbard
NVIDIA
