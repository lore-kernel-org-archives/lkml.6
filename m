Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F412C65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 21:36:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BBB620839
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 21:36:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BBB620839
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=solarflare.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728309AbeLLVg3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 16:36:29 -0500
Received: from dispatch1-us1.ppe-hosted.com ([148.163.129.52]:46202 "EHLO
        dispatch1-us1.ppe-hosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726297AbeLLVg3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 16:36:29 -0500
X-Virus-Scanned: Proofpoint Essentials engine
Received: from webmail.solarflare.com (webmail.solarflare.com [12.187.104.26])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1-us3.ppe-hosted.com (Proofpoint Essentials ESMTP Server) with ESMTPS id D4597480088;
        Wed, 12 Dec 2018 21:36:27 +0000 (UTC)
Received: from ec-desktop.uk.solarflarecom.com (10.17.20.45) by
 ocex03.SolarFlarecom.com (10.20.40.36) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 12 Dec 2018 13:36:24 -0800
Subject: Re: [PATCH v2 0/4] Static calls
To:     Nadav Amit <namit@vmware.com>
CC:     Josh Poimboeuf <jpoimboe@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>, Paolo Abeni <pabeni@redhat.com>
References: <cover.1543200841.git.jpoimboe@redhat.com>
 <0e96ac37-d5c5-86b6-833c-0de01ba18f0d@solarflare.com>
 <20181211180521.ljdvnnztjnvoijge@treble>
 <86D72260-838C-4CE0-ACE3-BE92A3E9CFD8@vmware.com>
 <899194d1-9777-71ed-70db-212d2983a400@solarflare.com>
 <294E22E9-7577-4716-A531-CBFE628789C3@vmware.com>
 <496ba248-eca5-d432-0ec9-95b2e0d775a1@solarflare.com>
 <B83BB5F6-4EBB-4BCA-9AA2-18EEB6483E7A@vmware.com>
From:   Edward Cree <ecree@solarflare.com>
Message-ID: <406f3f88-026c-f611-3b47-6dee3c6bbb0b@solarflare.com>
Date:   Wed, 12 Dec 2018 21:36:22 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <B83BB5F6-4EBB-4BCA-9AA2-18EEB6483E7A@vmware.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
X-Originating-IP: [10.17.20.45]
X-TM-AS-Product-Ver: SMEX-12.5.0.1300-8.5.1010-24280.005
X-TM-AS-Result: No-6.437400-4.000000-10
X-TMASE-MatchedRID: csPTYAMX1+EOwH4pD14DsPHkpkyUphL9QPCWRE0Lo8IwyfWtyopBqP7n
        p1jxGcSc29PfXyjwtNdh4t35I7152kn2lBNZmEziOXon7t5qW1Y0AKed0u9fB43HvDXeBtl6vHV
        BK0WUflcbsatP6ByaYUATX+VlevKk2gKTowYKIa0TRDzcDa8P6wiBYiT9V2dSCqIJhrrDy29ZMU
        fzivhwNO+BpbHS+DnIQ2nyydpJ0FcM8jMXjBF+sIMbH85DUZXy3QfwsVk0UbtuRXh7bFKB7sO1y
        BJ/ObjmBqO2dMNgMYrXiHZFHxNvZvks6i5duv13PpCuffGH9zI=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--6.437400-4.000000
X-TMASE-Version: SMEX-12.5.0.1300-8.5.1010-24280.005
X-MDID: 1544650588-9VItPnQVo1rO
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/12/18 21:15, Nadav Amit wrote:
>> On Dec 12, 2018, at 10:33 AM, Edward Cree <ecree@solarflare.com> wrote:
>>
>> AIUI the outline version uses a tail-call (i.e. jmpq *target) rather than an
>>  additional call and ret.  So I wouldn't expect it to be too expensive.
>> More to the point, it seems like it's easier to get right than the inline
>>  version, and if we get the inline version working later we can introduce it
>>  without any API change, much as Josh's existing patches have both versions
>>  behind a Kconfig switch.
> I see. For my outlined blocks I used the opposite approach - a call followed
> by jmp
That's what Josh did too.  I.e. caller calls the trampoline, which jmps to the
 callee; later it rets, taking it back to the caller.  Perhaps I wasn't clear.
The point is that there's still only one call and one ret.

>> I was working on the assumption that it would be opt-in, wrapping a macro
>>  around indirect calls that are known to have a fairly small number of hot
>>  targets.  There are plenty of indirect calls in the kernel that are only
>>  called once in a blue moon, e.g. in control-plane operations like ethtool;
>>  we don't really need to bulk up .text with trampolines for all of them.
> On the other hand, I’m not sure the static_call interface is so intuitive.
> And extending it into “dynamic_call” might be even worse. As I initially
> used an opt-in approach, I can tell you that it was very exhausting.
Well, if it's done with a gcc plugin after all, then it wouldn't be too hard
 to make it opt-out.
One advantage of the explicit opt-in dynamic_call, though, which can be seen
 in my patch is that multiple call sites can share the same learning-state,
 if they're expected to call the same set of functions.  An opt-out approach
 would automatically give each indirect call statement its own individual BTB.
Either way, I think the question is orthogonal to what the trampolines
 themselves look like (and even to the inline vs outline question).

-Ed
