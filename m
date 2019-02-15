Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFFE8C10F04
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 01:35:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84C6C21B1C
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 01:35:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="TReKCFle"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730850AbfBOBfr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 20:35:47 -0500
Received: from smtprelay.synopsys.com ([198.182.60.111]:49408 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728905AbfBOBfq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 20:35:46 -0500
Received: from mailhost.synopsys.com (dc8-mailhost1.synopsys.com [10.13.135.209])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay.synopsys.com (Postfix) with ESMTPS id B376F10C1039;
        Thu, 14 Feb 2019 17:35:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1550194545; bh=IBqm5qNukl2ROXiPY4aT5wo5lRAbddJ8leJA9h5MEGc=;
        h=Subject:To:CC:References:From:Date:In-Reply-To:From;
        b=TReKCFletXfXxZ2HF7Vv6+pDU1nQvbRZU6jpc8uBi4qNA/H9z9S4KTaDRQcX8rKS4
         jZeLr/awoDOpMN9R7oTUiohsU65m961S7shDVkLQWH6cK9CAo5gWFkL3j3t/LlInt1
         F0rA03bLvgpuM2ZsBsmdyV66iEynsd8ghg2quHdmMCbKo0Of4vNQY5tbKLKOB2At6w
         5YpxK5foFx+7+/waGYjmQ7dqjU8I/qxfZCiZVG70MJIEVPHB4zEQnW6uzIfMuQpqvh
         kOK6nq6YdvaZDuezbwQPvtPMkP8fz1wOOQfH85goJuD/R71a+urIuRzitWpe26GF1b
         emTaRn+88AfRg==
Received: from US01WXQAHTC1.internal.synopsys.com (us01wxqahtc1.internal.synopsys.com [10.12.238.230])
        (using TLSv1.2 with cipher AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 34D1FA005A;
        Fri, 15 Feb 2019 01:35:36 +0000 (UTC)
Received: from IN01WEHTCA.internal.synopsys.com (10.144.199.104) by
 US01WXQAHTC1.internal.synopsys.com (10.12.238.230) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Thu, 14 Feb 2019 17:34:40 -0800
Received: from IN01WEHTCB.internal.synopsys.com (10.144.199.105) by
 IN01WEHTCA.internal.synopsys.com (10.144.199.103) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Fri, 15 Feb 2019 07:04:42 +0530
Received: from [10.10.161.59] (10.10.161.59) by
 IN01WEHTCB.internal.synopsys.com (10.144.199.243) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Fri, 15 Feb 2019 07:04:43 +0530
Subject: Re: [PATCH] ARC: Explicitly set ARCH_SLAB_MINALIGN = 8
To:     Alexey Brodkin <alexey.brodkin@synopsys.com>,
        Peter Zijlstra <peterz@infradead.org>
CC:     David Laight <David.Laight@ACULAB.COM>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>,
        Arnd Bergmann <arnd.bergmann@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Newsgroups: gmane.linux.kernel.stable,gmane.linux.kernel.arc,gmane.linux.kernel
References: <20190208105519.26750-1-abrodkin@synopsys.com>
 <81017fe4-b31f-4942-e822-a7b70008b74d@synopsys.com>
 <f83412d1e7fd4d67b4632c1f81fae963@AcuMS.aculab.com>
 <bfc65835-21f9-6d5e-791d-ee49113d939c@synopsys.com>
 <20190213125651.GP32494@hirez.programming.kicks-ass.net>
 <e6138aeb-9ce4-fbfa-4d6a-b76f189a3e47@synopsys.com>
 <4881796E12491D4BB15146FE0209CE64681DB01F@DE02WEMBXB.internal.synopsys.com>
From:   Vineet Gupta <vineet.gupta1@synopsys.com>
Openpgp: preference=signencrypt
Autocrypt: addr=vgupta@synopsys.com; keydata=
 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
 hhqBJlyU6MVUa6vZNv8E
Message-ID: <e4aed55f-656b-ebec-c3e3-393714cc693e@synopsys.com>
Date:   Thu, 14 Feb 2019 17:34:29 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <4881796E12491D4BB15146FE0209CE64681DB01F@DE02WEMBXB.internal.synopsys.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.10.161.59]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/14/19 12:50 AM, Alexey Brodkin wrote:

>>>>> I suspect the slab allocator should be returning 8 byte aligned addresses
>>>>> on all systems....
>>>>
>>>> why ? As I understand it is still not fool proof against the expected alignment of
>>>> inner members. There ought to be a better way to enforce all this.
>>>
>>> I agree that for ARC ARCH_SLAB_MINALIGN should be at least 8.
>>
>> This issue aside, are there other reasons ? Because making it 8 on ARC is just
>> pending the eventuality for later.
> 
> But that's pretty much the same for other 32-bit arches that have 64-bit atomics
> like ARM etc. From what I may see from ARM's documentation for LDREXD/SRREXD they
> require double-word alignment of data as well.

Right LLOCKD/SCONDD (64-bit exclusive load/store) needs 64-bit aligned effective
addresses for micro-arch reasons (1 vs 2 cache lines) etc.

So lets try to unpack this for me. Say we had.

   struct foo {
	int        a;
	atomic64_t b;
   };

The atomic64_t (which for ARC and most others is u64 __attribute__((aligned(8))
*already ensures* that there a 4 b padding is generated by gcc (I just confirmed
with a simple test case).

   #ifdef DOALIGN__
   #define my_u64	__u64 __attribute__((aligned(8)))
   #else
   #define my_u64	__u64
   #endif

  struct foo on_heap;

  printf(%d", &on_heap.b)

$ arc-linux-gcc -O2 test.c -DDOALIGN__ -c --save-temps

   main:
	mov_s r1,@on_heap+8   <----
	mov_s r0,@.LC0
	b @printf

W/o the alignment attribute (say normal LDD/STD)

$ arc-linux-gcc -O2 test.c -c --save-temps

   main:
	mov_s r1,@on_heap+4
	mov_s r0,@.LC0
	b @printf

So indeed your patch aligns dynamic structs to 64-bit, ensuring any embedded
aligned_u64 to be 64-bit aligned as well. Phew !


> That said if for some reason atomic64_t variable is unaligned execution on
> any (or at least most) 32-bit architectures will lead to run-time failure,
> i.e. we'll know about it and this will be fixed.
> 
> And what I'm doing by that change (ARCH_SLAB_MINALIGN=8 for ARC) I'm just
> working-around peculiarity of ARC ABI.

Right.

> 
> Out of curiosity I checked if there're any other occurrences of "alingof(long long)"
> and there seems to be a couple of more:
> ----------------------------------->8-----------------------------
> # git grep alignof | grep "long long"
> 
> ...
> 
> kernel/workqueue.c:5693:        WARN_ON(__alignof__(struct pool_workqueue) < __alignof__(long long));
> mm/slab.c:155:#define   REDZONE_ALIGN           max(BYTES_PER_WORD, __alignof__(unsigned long long))

For ARC, it will be max(4,4) so 4
for others 32-bit,it will be max(4,8)

So indeed it makes sense to change it.

> mm/slab.c:2034: if (ralign > __alignof__(unsigned long long))
> ----------------------------------->8-----------------------------
> 
> Not really sure how important is "kernel/workqueue.c" part but in case of "mm/slab.c"
> shouldn't we use ARCH_SLAB_MINALIGN there instead of that "not very meaningful" __alignof__(long long)?

