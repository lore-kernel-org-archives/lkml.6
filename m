Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DA08ECDE30
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 09:09:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F309521523
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 09:09:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F309521523
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727055AbeJQREI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 13:04:08 -0400
Received: from mx2.suse.de ([195.135.220.15]:51984 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726636AbeJQREI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 13:04:08 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id AF8D1AE5E;
        Wed, 17 Oct 2018 09:09:21 +0000 (UTC)
Subject: Re: [PATCH] x86: modify inline asm constraints in __cmpxchg_double()
To:     Ingo Molnar <mingo@kernel.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, hpa@zytor.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de
References: <20181015084802.30934-1-jgross@suse.com>
 <20181016062556.GA56841@gmail.com>
 <e43d18fd-22c0-5c59-5cb6-3d7c8da71d8e@suse.com>
 <20181016080150.GB41162@gmail.com>
From:   Juergen Gross <jgross@suse.com>
Openpgp: preference=signencrypt
Autocrypt: addr=jgross@suse.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <438ae46c-4dcd-53f3-3b01-bc54ac2c6ffa@suse.com>
Date:   Wed, 17 Oct 2018 11:09:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181016080150.GB41162@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/10/2018 10:01, Ingo Molnar wrote:
> 
> * Juergen Gross <jgross@suse.com> wrote:
> 
>> On 16/10/2018 08:25, Ingo Molnar wrote:
>>>
>>> * Juergen Gross <jgross@suse.com> wrote:
>>>
>>>> Some gcc versions seem to have problems with the constraints in
>>>> __cmpxchg_double() as they suddenly issue a build error when random
>>>> parts of sources calling __cmpxchg_double() are modified, like e.g.
>>>> slub.c. This has been observed on Debian systems only so far.
>>>>
>>>> Using "0" instead of "a" in the input constraints has the same
>>>> semantics while avoiding that build error.
>>>>
>>>> Signed-off-by: Juergen Gross <jgross@suse.com>
>>>> ---
>>>> I should note that I have observed gcc hangs instead sometimes. Not
>>>> taking any patches modifying users of __cmpxchg_double() due to a gcc
>>>> bug which seems to be distro-specific is a bad move IMO.
>>>>
>>>> I'd rather make it clear from build behavior that this is a bug in gcc
>>>> by letting the build hang instead of throwing error warnings not in any
>>>> way related to changes in the code.
>>>>
>>>> The gcc bug is filed under:
>>>>
>>>> https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=908154
>>>> ---
>>>>  arch/x86/include/asm/cmpxchg.h | 2 +-
>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/arch/x86/include/asm/cmpxchg.h b/arch/x86/include/asm/cmpxchg.h
>>>> index a55d79b233d3..b3b4d61a8969 100644
>>>> --- a/arch/x86/include/asm/cmpxchg.h
>>>> +++ b/arch/x86/include/asm/cmpxchg.h
>>>> @@ -245,7 +245,7 @@ extern void __add_wrong_size(void)
>>>>  	asm volatile(pfx "cmpxchg%c4b %2; sete %0"			\
>>>>  		     : "=a" (__ret), "+d" (__old2),			\
>>>>  		       "+m" (*(p1)), "+m" (*(p2))			\
>>>> -		     : "i" (2 * sizeof(long)), "a" (__old1),		\
>>>> +		     : "i" (2 * sizeof(long)), "0" (__old1),		\
>>>>  		       "b" (__new1), "c" (__new2));			\
>>>
>>> This got changed to +a in -tip:
>>>
>>>   c808c09b527c: x86/asm: Use CC_SET()/CC_OUT() in __cmpxchg_double()
>>>
>>> Mind sending a patch on top of -tip?
>>
>> No, I think you can drop my patch.
>>
>> c808c09b527c: x86/asm: Use CC_SET()/CC_OUT() in __cmpxchg_double()
>> has the same effect as my patch: the build failure is replaced by
>> gcc hanging instead in the critical configuration.
> 
> Ok. No sane workaround we can do to avoid the hang I suspect, right?

I'm not aware of any.

> Should we propagate the fix/enhancement to x86/urgent? It's currently in 
> x86/asm for a v4.20 merge.

My patch triggering the issue is queued for 4.20, too.

There might be other constellations triggering it, but I haven't
seen any yet.


Juergen
