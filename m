Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1671812-1518451098-2-3179287065939973226
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='windows-1252'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-serial-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518451094; b=aQI35h6q0o2mMjdVX34JjR6h8aDUZE91CxM6Nh0xXY8YpDB
    2BHd3DdcP/i1OdMMMG/0Iiyu08U58uhbeO7c9kwILShDJp72OSvB4TBrwNj78xr7
    lOWpNjAeIQE61bvXJZHvVYToIAz1EvUF5t7etAZhFGRM3Ig/MaivUH6HNzbOyuvO
    COg4B3JmQ+l9p/XoAB1BTQl+MKJi1g8JCnfatBQogD85ONjOr4GBrFyrg9OnmE9q
    PgeyrxBdKRNbhCi7FgpQDfZcJiQ3T7vUucPxukhxC6R7aUZXc9GOs5J8epXRYzsw
    JVd9iXnS8u0ARU3oJK2TMSQmzn4CI3vcVszwESQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:references:cc:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1518451094; bh=7/XiQdpV21NcW4aPBLD28CIXlmo4Mk7yk/5kXEC+z68=; b=h
    wB8f6H5S2iMDN6ss+Zcj+nuME1ZQx02Gta7hHFpcmmZziBsdQ2qwDKNx9dkyNU5V
    BUb8E5cXoUbsSOVVXgFZ2YSpPleNjCPQdSxdOPz7ZzzONd4vcjOiffBwq21QwcK3
    MkV46Sg9Zs2v6nrcx9i7CBBdI6l0ID7Tp42WDPr3tg/sAoYewaCma8EIJXzhMgAh
    fPmA4Ugqfsl/9AbleRwXyCQ3PEjNQocmRsncRIUJPMw9beSMhHBKzZBzdkVxUCsb
    8SGO3q4bwM0982i2WLWi3IJya9tr42JqbwBgavl67hqL1TjOV5xWR1ym7HWcElP7
    Gk3kWWqke7aIT6JUKzcjA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932730AbeBLPyp (ORCPT <rfc822;greg@kroah.com>);
        Mon, 12 Feb 2018 10:54:45 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56016 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932236AbeBLPyn (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 12 Feb 2018 10:54:43 -0500
Subject: Re: [PATCH] acpi, spcr: Make SPCR available to x86
To: Peter Zijlstra <peterz@infradead.org>
References: <20180118150951.28964-1-prarit@redhat.com>
 <20180212133429.GC25314@hirez.programming.kicks-ass.net>
 <1e69fffc-1c3b-8cc0-f1cb-695de5ccdcb5@redhat.com>
 <20180212145652.GM25181@hirez.programming.kicks-ass.net>
 <03e799c6-a0f3-eccf-882d-78205e9335ad@redhat.com>
 <20180212154434.GX25201@hirez.programming.kicks-ass.net>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org, linux-serial@vger.kernel.org,
        Bhupesh Sharma <bhsharma@redhat.com>,
        Lv Zheng <lv.zheng@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Jonathan Corbet <corbet@lwn.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Timur Tabi <timur@codeaurora.org>, graeme.gregory@linaro.org,
        mark.salter@redhat.com
From: Prarit Bhargava <prarit@redhat.com>
Message-ID: <3299be7d-66cf-1116-042b-8c68c9b401af@redhat.com>
Date: Mon, 12 Feb 2018 10:54:41 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.0
MIME-Version: 1.0
In-Reply-To: <20180212154434.GX25201@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 02/12/2018 10:44 AM, Peter Zijlstra wrote:
> On Mon, Feb 12, 2018 at 10:18:06AM -0500, Prarit Bhargava wrote:
>>> But when I specify "earlyprintk=serial,ttyS0,115200" this SPCR crud will
>>> not interfere?
>>>
>>
>> I tested "earlyprintk=serial,ttyS0,115200" on a system which is known to have a
>> functional console with "console=ttyS0,1152008N1" both with and without
>> CONFIG_ACPI_SPCR_TABLE enabled.
> 
> OK, but my point was that SPCR will never override explicit earlyprintk
> stuff. There is absolutely nothing worse than breaking working setups.
> 

Oh, I see.  SPCR will not override earlyprintk config.

P.
