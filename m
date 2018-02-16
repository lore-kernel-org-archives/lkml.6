Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-268172-1518789741-2-4434505459968177517
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518789741; b=HRz3VAaMDn/xIBvLZxO/bZ0pnigYyRDE2IiUu3j8vCkP54B
    ca9nXxZ+djQB+Dvljk8pwZRLsQJ/J95wUAAMavxOo26AKnocGvYe+AdoeuxtxWzx
    LSy1gu47kAcODXnrQpyR5IC3ea6R7opmXn+uTIuyya+WKJ4HLLIZ31TEvy0HfnWy
    TWANmsnV7xlXn57ZJCBiL2qYhLc/fV1e5hHwyUqVApUhphC9FhZIAcyu8sESKj+1
    aeVqd5HMOtnjY9MLwjgB10cAV67Dmq31DKfJw8VEQpAeilMedVUrXWbd0E2pDrD8
    an2EMxfKdxMEex7RtpUA6FPF0rUgPGF4nfGR6VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1518789741; bh=gNmngoSqS+XtvnILROW90ePKDDeI/T/RU1QdKHN/qh4=; b=d
    4DkEtA0UpSsD7AE4YxkSCwJlbfVRh9Ws5POh9U26Vx8O/haSPtz8KxWfHxW8Magu
    3apD+XwS3z2AyuGGmt/h7GxORC+IlvcnsdA+Fk7vkHFtLQfZ/7JfajeEENEkJGXw
    ZZsEjjmntpzGsR9D+K4Zcu/tJ6RA5nqaS8Hnb6r32ptrmHxQZMMFP8XYbrrOLSgX
    aSE4YnRJqPi0W+iksVstqyfn4lD5/zdULf5/vbVJWTDWX9hUx0l75WKhLGXIpylH
    5xNeUrxLkO7S2XT9NaxlAT/IEm31S5Yxn50AVKpYoZOIQEbXvd6QX4xv1HpQ9jOJ
    MZ1H3lJvACuzg5mTXTgXg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=suse.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=suse.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=suse.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=suse.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033348AbeBPOCU (ORCPT <rfc822;greg@kroah.com>);
        Fri, 16 Feb 2018 09:02:20 -0500
Received: from mx2.suse.de ([195.135.220.15]:56680 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1032862AbeBPOCT (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 16 Feb 2018 09:02:19 -0500
Subject: Re: [PATCH] mm: don't defer struct page initialization for Xen pv
 guests
To: Michal Hocko <mhocko@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        xen-devel@lists.xenproject.org, akpm@linux-foundation.org,
        stable@vger.kernel.org, Pavel Tatashin <pasha.tatashin@oracle.com>
References: <20180216133726.30813-1-jgross@suse.com>
 <20180216135940.GQ7275@dhcp22.suse.cz>
From: Juergen Gross <jgross@suse.com>
Message-ID: <1424bb25-7d6a-ee21-83b4-0e90369d6132@suse.com>
Date: Fri, 16 Feb 2018 15:02:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180216135940.GQ7275@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 16/02/18 14:59, Michal Hocko wrote:
> [CC Pavel]
> 
> On Fri 16-02-18 14:37:26, Juergen Gross wrote:
>> Commit f7f99100d8d95dbcf09e0216a143211e79418b9f ("mm: stop zeroing
>> memory during allocation in vmemmap") broke Xen pv domains in some
>> configurations, as the "Pinned" information in struct page of early
>> page tables could get lost.
> 
> Could you be more specific please?

In which way? Do you want to see the resulting crash in the commit
message or some more background information?

> 
>> Avoid this problem by not deferring struct page initialization when
>> running as Xen pv guest.
>>
>> Cc: <stable@vger.kernel.org> #4.15
> Fixes: f7f99100d8d9 ("mm: stop zeroing memory during allocation in vmemmap")
> 
> please

Okay.


Juergen
