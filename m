Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 178F5C43610
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 19:01:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9DD421780
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 19:01:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9DD421780
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726296AbeKNFBO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 00:01:14 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:32761 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725750AbeKNFBN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 00:01:13 -0500
Received: from LHREML713-CAH.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id 57BEFFD570C7F;
        Tue, 13 Nov 2018 19:01:44 +0000 (GMT)
Received: from [10.202.210.149] (10.202.210.149) by smtpsuk.huawei.com
 (10.201.108.36) with Microsoft SMTP Server (TLS) id 14.3.408.0; Tue, 13 Nov
 2018 19:01:45 +0000
Subject: Re: [PATCH 10/17] prmem: documentation
To:     Andy Lutomirski <luto@amacapital.net>
CC:     Igor Stoppa <igor.stoppa@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Nadav Amit <nadav.amit@gmail.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        James Morris <jmorris@namei.org>,
        "Michal Hocko" <mhocko@kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Laura Abbott <labbott@redhat.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Thomas Gleixner" <tglx@linutronix.de>
References: <20181023213504.28905-1-igor.stoppa@huawei.com>
 <20181023213504.28905-11-igor.stoppa@huawei.com>
 <20181026092609.GB3159@worktop.c.hoisthospitality.com>
 <CAGXu5jKCs01jvtvpEFS7R8qCR-5iRqK11kJxLJY99NicGWc4aQ@mail.gmail.com>
 <20181028183126.GB744@hirez.programming.kicks-ass.net>
 <40cd77ce-f234-3213-f3cb-0c3137c5e201@gmail.com>
 <20181030152641.GE8177@hirez.programming.kicks-ass.net>
 <CAGXu5jJftJ+Hq+jrZGHX5CTDLWOog7kGsd_Ne=yMvrRs__skSg@mail.gmail.com>
 <0A7AFB50-9ADE-4E12-B541-EC7839223B65@amacapital.net>
 <6f60afc9-0fed-7f95-a11a-9a2eef33094c@gmail.com>
 <CALCETrXNckT9W288VXx-6inO5qYn-6dUPocKGcBT0GCO3xi3ZQ@mail.gmail.com>
 <17a007eb-43ea-e4da-b066-0d8c502f5f6e@huawei.com>
 <CALCETrVaPTbgycjzSB0fLUeGL=j1srUh-cL0qsKn6fw6UQgj7Q@mail.gmail.com>
From:   Igor Stoppa <igor.stoppa@huawei.com>
Message-ID: <12b6232f-ac3d-c74c-5f9e-d84905c39f0a@huawei.com>
Date:   Tue, 13 Nov 2018 21:01:43 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CALCETrVaPTbgycjzSB0fLUeGL=j1srUh-cL0qsKn6fw6UQgj7Q@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.210.149]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 13/11/2018 20:35, Andy Lutomirski wrote:
> On Tue, Nov 13, 2018 at 10:26 AM Igor Stoppa <igor.stoppa@huawei.com> wrote:

[...]

>> The high level API could be something like:
>>
>> wr_memcpy(void *src, void *dst, uint_t size)

[...]

> If you call a wr_memcpy() function with the signature you suggested,
> then you can overwrite any memory of this type.  Having a different
> mm_struct under the hood makes no difference.  As far as I'm
> concerned, for *dynamically allocated* rare-writable memory, you might
> as well allocate all the paging structures at the same time, so the
> mm_struct will always contain the mappings.  If there are serious bugs
> in wr_memcpy() that cause it to write to the wrong place, we have
> bigger problems.

Beside bugs, I'm also thinking about possible vulnerability.
It might be overthinking, though.

I do not think it's possible to really protect against control flow
attacks, unless there is some support from the HW and/or the compiler.

What is left, are data-based attacks. In this case, it would be an
attacker using one existing wr_ invocation with doctored parameters.

However, there is always the objection that it would be possible to come
up with a "writing kit" for plowing through the page tables and
unprotect anything that might be of value.

Ideally, that should be the only type of data-based attack left.

In practice, it might just be an excess of paranoia from my side.

> I can imagine that we'd want a *typed* wr_memcpy()-like API some day,
> but that can wait for v2.  And it still doesn't obviously need
> multiple mm_structs.

I left that out, for now, but yes, typing would play some role here.

[...]

> I think it's entirely reasonable for the API to internally break up
> very large memcpys.

The criteria for deciding if/how to break it down is not clear to me,
though. The single page was easy, but might be (probably is) too much.

--
igor
