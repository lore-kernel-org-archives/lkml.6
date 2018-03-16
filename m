Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3921380-1521236257-2-13024823866341097624
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
    t=1521236257; b=BH19J2OvZMr21saHnbUlfEucrO6ktDD2hf+cyNkNhsgLqV5
    dZKf48H1bTKGeZOZrAKrQBCmRsl8eaZlnIOfr1JR4rm0vHPPRIgJUwY+zf2w+g1F
    NB21i0QjyEiuNFS1cxTv86n/SLc2t7+vhIdhp7+mqyAsTVGqn/jbvBEUahKKKt2u
    G3WaNym54q0twS80HbZSCZ340BaivvYga01KqEBtPppQM0HzCqddS20se3Iff4lb
    z3tjMUfinjaC9pxNk0QMuDIgaiZEJbyDId+qowRHUF7E4tudDsGh8Af8LjdMXZhY
    XBZml9+GJajCssIu1djKIao7Ds6sMF5FBrZ1Mxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1521236257; bh=pLY+Zqw9e+uNisf95kp7a9//BQjSfXHoQ3KgBM6k6iM=; b=Y
    iljqWsdzSnYv9TP66md2rv41Jaal3sUe2AHleJUyUD0SY8tdvS55AREQZHg2NnYz
    ZkQWahKit3duMqo1D8ZIk+4vWH8oy2HN66NcUvgFg5yProlpf7tFrN88ebbxukD5
    eqNdKMjLSdogHTUCO2+MaOmRb/QCLRQ2Z5P4oOw2iK4LKjFf5YBN8I2m5m3I8fxY
    lh8F2e3GHHXyq5vdDxhObRUG6bYJTznFQ3OsJcAaSsjw/h7iMpek2bj2uzXc1d0k
    l8StyjrzUaj/v/U1ukMt32A4FlS3EVA1n5xN7HJ0QoHM4KvYRKpApISlPkwMXmKS
    k83Gu+xxtWuJc3LuevqgQ==
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
        id S1750915AbeCPVhf convert rfc822-to-8bit (ORCPT
        <rfc822;greg@kroah.com>); Fri, 16 Mar 2018 17:37:35 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:6621 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751245AbeCPVhe (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 16 Mar 2018 17:37:34 -0400
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 16 Mar 2018 14:37:34 -0700
Subject: Re: [PATCH 03/14] mm/hmm: HMM should have a callback before MM is
 destroyed v2
To: Jerome Glisse <jglisse@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>
CC: <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Ralph Campbell <rcampbell@nvidia.com>,
        <stable@vger.kernel.org>, Evgeny Baskakov <ebaskakov@nvidia.com>,
        Mark Hairgrove <mhairgrove@nvidia.com>
References: <20180316191414.3223-1-jglisse@redhat.com>
 <20180316191414.3223-4-jglisse@redhat.com>
 <20180316141221.f2b622630de3f1da51a5c105@linux-foundation.org>
 <20180316212630.GC4861@redhat.com>
X-Nvconfidentiality: public
From: John Hubbard <jhubbard@nvidia.com>
Message-ID: <0748100d-1414-93b8-baab-f08bb0b0b6ea@nvidia.com>
Date: Fri, 16 Mar 2018 14:37:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180316212630.GC4861@redhat.com>
X-Originating-IP: [10.110.48.28]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8BIT
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 03/16/2018 02:26 PM, Jerome Glisse wrote:
> On Fri, Mar 16, 2018 at 02:12:21PM -0700, Andrew Morton wrote:
>> On Fri, 16 Mar 2018 15:14:08 -0400 jglisse@redhat.com wrote:
>>
>>> The hmm_mirror_register() function registers a callback for when
>>> the CPU pagetable is modified. Normally, the device driver will
>>> call hmm_mirror_unregister() when the process using the device is
>>> finished. However, if the process exits uncleanly, the struct_mm
>>> can be destroyed with no warning to the device driver.
>>
>> Again, what are the user-visible effects of the bug?  Such info is
>> needed when others review our request for a -stable backport.  And the
>> many people who review -stable patches for integration into their own
>> kernel trees will want to understand the benefit of the patch to their
>> users.
> 
> I have not had any issues in any of my own testing but nouveau driver
> is not as advance as the NVidia closed driver in respect to HMM inte-
> gration yet.
> 
> If any issues they will happen between exit_mm() and exit_files() in
> do_exit() (kernel/exit.c) exit_mm() tear down the mm struct but without
> this callback the device driver might still be handling page fault and
> thus might potentialy tries to handle them against a dead mm_struct.
> 
> So i am not sure what are the symptoms. To be fair there is no public
> driver using that part of HMM beside nouveau rfc patches. So at this
> point the impact on anybody is non existent. If anyone want to back-
> port nouveau HMM support once it make it upstream it will probably
> have to backport more things along the way. This is why i am not that
> aggressive on ccing stable so far.

The problem I'd like to avoid is: having a version of HMM in stable that
is missing this new callback. And without it, once the driver starts doing
actual concurrent operations, we can expect that the race condition will
happen.

It just seems unfortunate to have stable versions out there that would
be exposed to this, when it only require a small patch to avoid it.

On the other hand, it's also reasonable to claim that this is part of the
evolving HMM feature, and as such, this new feature does not belong in
stable.  I'm not sure which argument carries more weight here.

thanks,
-- 
John Hubbard
NVIDIA

> 
> Cheers,
> Jérôme
> 
