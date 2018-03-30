Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-172903-1522443506-2-6653540594492950838
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='net', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522443506; b=GTdAkJ7fZ2RKrK5QLuCnu+nGzs5cKNpX58KVI3JHglU0Z3R01H
    dMMVU0gAjXVkmLYFKX3cvnl4Kt9teq13ufx8EclViCb59EPxv717ZtGgT4urTTRS
    IxAIudQ4fiHNiVLlye4rtXxr4NyPXOXo7MbM7W7luc4AgKfQvUvKSw4/i/F0vjmA
    D4ATAMGI598P7W/B7SZH13qerWb0DnJgO5Gu4J+jnOE188Om9nVObMbQJlCPKn8Y
    4yfNVlXG2PbiilyBfSxTOJt6M95p0euL3LFByPitzD2YD7S7vGYLj7T1A0rcGLwt
    ALjSFAnR2N5Gjef0JOgWKA1feJD3J0PT+MLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1522443506; bh=1Usnymbdbseq57+0/qJ7Iqh1X4Ai6r
    Qcg4JjK4ksu3c=; b=Vg0Ylgolj8bJLoU+LcCFX9KTUTVzHGurRCkiBCPNwnQsNh
    /4pnYwLfqAzyFMrXH9PGFZdQiDsG+fMR6qTSFv9e+PNgTlSWBJ12sgeQKAEJhx6J
    ER61xRUXXB9GxSmy+rXZjhF01vNkhPfI8/U5rKoGxiWWUdoG/+hssitvdv5oFTF5
    JBC0FJkygAdDFYglGb4XTN6MCzrOz2+5yrWtuq2ImnkGrfb5u+DZRIv08es1/KUT
    CvN4xXAvb+1haRnFWQ7ac5w9Wdwwuh7VxCvb8OlfEapIwzzJRqsI+uhMh1yErZPN
    d+7aEce/DE0FqYukn+fNhIThZwMgYJWSq6od8lOw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=stgolabs.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=stgolabs.net header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=stgolabs.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=stgolabs.net header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfOg0lK+YirKKs8IM5vPZgSXnfPPhcxhEFQy5w3lHH3FvBK35c0DIL6hEBpJygCKW2YSVN5UsbK84xHEGI2lFsmAqI8RrF0vHyW1LmYDE7rY0x1jH4ocH
    1d9JizysfZQKXfHnvjRBewzzHobHrXh8f2g0tcEBOwshD1kCW2KCfyMgB9cX7R2oOW9A5G+bbvnQTAQc9B3Ugfxg9dZieysHOBNN2VpDZAhoxcTV2qDm52vq
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=v2DPQv5-lfwA:10
    a=R4ayLD03AAAA:8 a=VwQbUJbxAAAA:8 a=Reunm8aL6lqFLX1_fGgA:9 a=CjuIK1q_8ugA:10
    a=x8gzFH9gYPwA:10 a=qJlm0-shE6CLU_iKUWNr:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752626AbeC3U6X (ORCPT <rfc822;greg@kroah.com>);
        Fri, 30 Mar 2018 16:58:23 -0400
Received: from mx2.suse.de ([195.135.220.15]:49758 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752568AbeC3U6X (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Fri, 30 Mar 2018 16:58:23 -0400
Date: Fri, 30 Mar 2018 13:45:57 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: manfred@colorfullife.com,
        Linux Containers <containers@lists.linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        khlebnikov@yandex-team.ru, prakash.sangappa@oracle.com,
        luto@kernel.org, akpm@linux-foundation.org, oleg@redhat.com,
        serge.hallyn@ubuntu.com, esyr@redhat.com, jannh@google.com,
        linux-security-module@vger.kernel.org,
        Pavel Emelyanov <xemul@openvz.org>,
        Nagarathnam Muthusamy <nagarathnam.muthusamy@oracle.com>
Subject: Re: [REVIEW][PATCH 11/11] ipc/sem: Fix semctl(..., GETPID, ...)
 between pid namespaces
Message-ID: <20180330204557.5cgyipyqawfte3ml@linux-n805>
References: <87vadmobdw.fsf_-_@xmission.com>
 <20180323191614.32489-11-ebiederm@xmission.com>
 <20180329005209.fnzr3hzvyr4oy3wi@linux-n805>
 <20180330190951.nfcdwuzp42bl2lfy@linux-n805>
 <87y3i91fxh.fsf@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <87y3i91fxh.fsf@xmission.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, 30 Mar 2018, Eric W. Biederman wrote:

>Davidlohr Bueso <dave@stgolabs.net> writes:
>
>> I ran this on a 40-core (no ht) Westmere with two benchmarks. The first
>> is Manfred's sysvsem lockunlock[1] program which uses _processes_ to,
>> well, lock and unlock the semaphore. The options are a little
>> unconventional, to keep the "critical region small" and the lock+unlock
>> frequency high I added busy_in=busy_out=10. Similarly, to get the
>> worst case scenario and have everyone update the same semaphore, a single
>> one is used. Here are the results (pretty low stddev from run to run)
>> for doing 100,000 lock+unlock.
>>
>> - 1 proc:
>>   * vanilla
>> 	total execution time: 0.110638 seconds for 100000 loops
>>   * dirty
>> 	total execution time: 0.120144 seconds for 100000 loops
>>
>> - 2 proc:
>>   * vanilla
>> 	total execution time: 0.379756 seconds for 100000 loops
>>   * dirty
>> 	total execution time: 0.477778 seconds for 100000 loops
>>
>> - 4 proc:
>>   * vanilla
>> 	total execution time: 6.749710 seconds for 100000 loops
>>   * dirty
>> 	total execution time: 4.651872 seconds for 100000 loops
>>
>> - 8 proc:
>>   * vanilla
>>        total execution time: 5.558404 seconds for 100000 loops
>>   * dirty
>> 	total execution time: 7.143329 seconds for 100000 loops
>>
>> - 16 proc:
>>   * vanilla
>> 	total execution time: 9.016398 seconds for 100000 loops
>>   * dirty
>> 	total execution time: 9.412055 seconds for 100000 loops
>>
>> - 32 proc:
>>   * vanilla
>> 	total execution time: 9.694451 seconds for 100000 loops
>>   * dirty
>> 	total execution time: 9.990451 seconds for 100000 loops
>>
>> - 64 proc:
>>   * vanilla
>> 	total execution time: 9.844984 seconds for 100032 loops
>>   * dirty
>> 	total execution time: 10.016464 seconds for 100032 loops
>>
>> Lower task counts show pretty massive performance hits of ~9%, ~25%
>> and ~30% for single, two and four/eight processes. As more are added
>> I guess the overhead tends to disappear as for one you have a lot
>> more locking contention going on.
>
>Can you check your notes on the 4 process case?  As I read the 4 process
>case above it is ~30% improvement.  Either that is a typo or there is the
>potential for quite a bit of noise in the test case.

Yeah, sorry that was a typo. Unlike the second benchmark I didn't have
this one automated but it's always the vanilla kernel that outperforms
the dirty.

Thanks,
Davidlohr
