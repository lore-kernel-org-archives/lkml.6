Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38456C43610
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 19:35:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E835D21582
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 19:35:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E835D21582
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727221AbeKNFet (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 00:34:49 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:32763 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725748AbeKNFet (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 00:34:49 -0500
Received: from LHREML713-CAH.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id 66C53B53EFEEA;
        Tue, 13 Nov 2018 19:35:12 +0000 (GMT)
Received: from [10.202.210.149] (10.202.210.149) by smtpsuk.huawei.com
 (10.201.108.36) with Microsoft SMTP Server (TLS) id 14.3.408.0; Tue, 13 Nov
 2018 19:35:12 +0000
Subject: Re: [PATCH 10/17] prmem: documentation
To:     Andy Lutomirski <luto@kernel.org>
CC:     Nadav Amit <nadav.amit@gmail.com>,
        Igor Stoppa <igor.stoppa@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
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
 <386C0CB1-C4B1-43E2-A754-DA8DBE4FB3CB@gmail.com>
 <CALCETrWWcfLK4W3mn0bavzejmMBVKMX29aAUA3+VPQ8m9vmfhw@mail.gmail.com>
 <9373ccf0-f51b-4bfa-2b16-e03ebf3c670d@huawei.com>
 <CALCETrXfBePNs_bs1OroLn9Kdi91FktZ0==N7JK7e=CX=uUisg@mail.gmail.com>
From:   Igor Stoppa <igor.stoppa@huawei.com>
Message-ID: <e7de7c38-1312-0bea-26a2-055f335aa0ad@huawei.com>
Date:   Tue, 13 Nov 2018 21:35:11 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CALCETrXfBePNs_bs1OroLn9Kdi91FktZ0==N7JK7e=CX=uUisg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.210.149]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/11/2018 20:48, Andy Lutomirski wrote:
> On Tue, Nov 13, 2018 at 10:31 AM Igor Stoppa <igor.stoppa@huawei.com> wrote:
>>
>> On 13/11/2018 19:47, Andy Lutomirski wrote:
>>
>>> For general rare-writish stuff, I don't think we want IRQs running
>>> with them mapped anywhere for write.  For AVC and IMA, I'm less sure.
>>
>> Why would these be less sensitive?
> 
> I'm not really saying they're less sensitive so much as that the
> considerations are different.  I think the original rare-write code is
> based on ideas from grsecurity, and it was intended to protect static
> data like structs full of function pointers.   Those targets have some
> different properties:
> 
>  - Static targets are at addresses that are much more guessable, so
> they're easier targets for most attacks.  (Not spraying attacks like
> the ones you're interested in, though.)
> 
>  - Static targets are higher value.  No offense to IMA or AVC, but
> outright execution of shellcode, hijacking of control flow, or compete
> disablement of core security features is higher impact than bypassing
> SELinux or IMA.  Why would you bother corrupting the AVC if you could
> instead just set enforcing=0?  (I suppose that corrupting the AVC is
> less likely to be noticed by monitoring tools.)
> 
>  - Static targets are small.  This means that the interrupt latency
> would be negligible, especially in comparison to the latency of
> replacing the entire SELinux policy object.

Your analysis is correct.
In my case, having already taken care of those, I was going *also* after
the next target in line.
Admittedly, flipping a bit located at a fixed offset is way easier than
spraying dynamically allocated data structured.

However, once the bit is not easily writable, the only options are to
either find another way to flip it (unprotect it or subvert something
that can write it) or to identify another target that is still writable.

AVC and policyDB fit the latter description.

> Anyway, I'm not all that familiar with SELinux under the hood, but I'm
> wondering if a different approach to thinks like the policy database
> might be appropriate.  When the policy is changed, rather than
> allocating rare-write memory and writing to it, what if we instead
> allocated normal memory, wrote to it, write-protected it, and then
> used the rare-write infrastructure to do a much smaller write to
> replace the pointer?

Actually, that's exactly what I did.

I did not want to overload this discussion, but since you brought it up,
I'm not sure write rare is enough.

* write_rare is for stuff that sometimes changes all the time, ex: AVC

* dynamic read only is for stuff that at some point should not be
modified anymore, but could still be destroyed. Ex: policyDB

I think it would be good to differentiate, at runtime, between the two,
to minimize the chance that a write_rare function is used against some
read_only data.

Releasing dynamically allocated protected memory is also a big topic.
In some cases it's allocated and released continuously, like in the AVC.
Maybe it can be optimized, or maybe it can be turned into an object
cache of protected object.

But for releasing, it would be good, I think, to have a mechanism for
freeing all the memory in one loop, like having a pool containing all
the memory that was allocated for a specific use (ex: policyDB)

> Admittedly, this creates a window where another core could corrupt the
> data as it's being written.  That may not matter so much if an
> attacker can't force a policy update.  Alternatively, the update code
> could re-verify the policy after write-protecting it, or there could
> be a fancy API to allocate some temporarily-writable memory (by
> creating a whole new mm_struct, mapping the memory writable just in
> that mm_struct, and activating it) so that only the actual policy
> loader could touch the memory.  But I'm mostly speculating here, since
> I'm not familiar with the code in question.

They are all corner cases ... possible but unlikely.
Another, maybe more critical, one is that the policyDB is not available
at boot.
There is a window of opportunity, before it's loaded. But it could be
mitigated by loading a barebone set of rules, either from initrd or even
as "firmware".

> Anyway, I tend to think that the right way to approach mainlining all
> this is to first get the basic rare write support for static data into
> place and then to build on that.  I think it's great that you're
> pushing this effort, but doing this for SELinux and IMA is a bigger
> project than doing it for static data, and it might make sense to do
> it in bite-sized pieces.
> 
> Does any of this make sense?

Yes, sure.

I *have* to do SELinux, but I do not necessarily have to wait for the
final version to be merged upstream. And anyways Android is on a
different kernel.

However, I think both SELinux and IMA have a value in being sufficiently
complex cases to be used for validating the design as it evolves.

Each of them has static data that could be the first target for
protection, in a smaller patch.

Lists of write rare data are probably the next big thing, in terms of
defining the API.

But I could start with introducing __wr_after_init.

--
igor
