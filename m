Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A2A0C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 08:12:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDA0420855
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 08:12:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDA0420855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728439AbeKIRvn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 12:51:43 -0500
Received: from mx2.suse.de ([195.135.220.15]:42578 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727532AbeKIRvn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 12:51:43 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C4D75ACEB;
        Fri,  9 Nov 2018 08:12:13 +0000 (UTC)
Subject: Re: [PATCH] slab.h: Avoid using & for logical and of booleans
To:     David Laight <David.Laight@ACULAB.COM>,
        'Bart Van Assche' <bvanassche@acm.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Christoph Lameter <cl@linux.com>, Roman Gushchin <guro@fb.com>,
        "Darryl T. Agostinelli" <dagostinelli@gmail.com>
References: <20181105204000.129023-1-bvanassche@acm.org>
 <62188a351f2249188ce654ee03c894b1@AcuMS.aculab.com>
 <e44e6c8b-e4e4-e7cb-a5ca-88e9559eb0d7@suse.cz>
 <3c9adab0f1f74c46a60b3d4401030337@AcuMS.aculab.com>
 <60deb90d-e521-39e5-5072-fc9efb98e365@suse.cz>
 <9af3ac1d43bb422cb3c41e7e8e422e6e@AcuMS.aculab.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Openpgp: preference=signencrypt
Autocrypt: addr=vbabka@suse.cz; prefer-encrypt=mutual; keydata=
 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
 cqmP8roqufIAj+Ohhzs=
Message-ID: <cbc1fc52-dc8c-aa38-8f29-22da8bcd91c1@suse.cz>
Date:   Fri, 9 Nov 2018 09:12:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <9af3ac1d43bb422cb3c41e7e8e422e6e@AcuMS.aculab.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/7/18 11:41 AM, David Laight wrote:
> From: Vlastimil Babka
>> Sent: 06 November 2018 12:51
>>
>> On 11/6/18 12:07 PM, David Laight wrote:
>>> From: Vlastimil Babka [mailto:vbabka@suse.cz]
>>> 0000000000000020 <f1>:
>>>   20:   40 f6 c7 11             test   $0x11,%dil
>>>   24:   75 03                   jne    29 <f1+0x9>
>>>   26:   31 c0                   xor    %eax,%eax
>>>   28:   c3                      retq
>>>   29:   83 e7 01                and    $0x1,%edi
>>>   2c:   83 ff 01                cmp    $0x1,%edi
>>>   2f:   19 c0                   sbb    %eax,%eax
>>>   31:   83 c0 02                add    $0x2,%eax
>>>   34:   c3                      retq
>>>
>>> The jne will be predicted not taken and the retq predicted.
>>> So this might only be 1 clock in the normal case.
>>
>> I think this is the winner. It's also a single branch and not two,
>> because the compiler could figure out some of the "clever arithmetics"
>> itself. Care to send a full patch?
> 
> I've not got a suitable source tree lurking.
> So someone else would need to do it.
> I'll waive any copyright that could plausibly be assigned to the above!

There we go. This is to replace the current fix by Bart (sorry) which seems
to add an extra IMUL. Apparently current mainline is spamming anyone running
sparse with lots of warning, so it should be merged soon.

----8<----
From ddd2fc6fcba425733f8320413a1451410687c9c3 Mon Sep 17 00:00:00 2001
From: Vlastimil Babka <vbabka@suse.cz>
Date: Fri, 9 Nov 2018 08:47:12 +0100
Subject: [PATCH] mm, slab: fix sparse warning in kmalloc_type()

Multiple people have reported the following sparse warning:

./include/linux/slab.h:332:43: warning: dubious: x & !y

The minimal fix would be to change the logical & to boolean &&, which emits the
same code, but Andrew has suggested that the branch-avoiding tricks are maybe
not worthwile. David Laight provided a nice comparison of disassembly of
multiple variants, which shows that the current version produces a 4 deep
dependency chain, and fixing the sparse warning by changing logical and to
multiplication emits an IMUL, making it even more expensive.

The code as rewritten by this patch yielded the best disassembly, with a single
predictable branch for the most common case, and a ternary operator for the
rest, which gcc seems to compile without a branch or cmov by itself.

The result should be more readable, without a sparse warning and probably also
faster for the common case.

Reported-by: Bart Van Assche <bvanassche@acm.org>
Reported-by: Darryl T. Agostinelli <dagostinelli@gmail.com>
Suggested-by: Andrew Morton <akpm@linux-foundation.org>
Suggested-by: David Laight <David.Laight@ACULAB.COM>
Fixes: 1291523f2c1d ("mm, slab/slub: introduce kmalloc-reclaimable caches")
Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 include/linux/slab.h | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/include/linux/slab.h b/include/linux/slab.h
index 918f374e7156..18c6920c2803 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -304,6 +304,8 @@ enum kmalloc_cache_type {
 	KMALLOC_RECLAIM,
 #ifdef CONFIG_ZONE_DMA
 	KMALLOC_DMA,
+#else
+	KMALLOC_DMA = KMALLOC_NORMAL,
 #endif
 	NR_KMALLOC_TYPES
 };
@@ -314,22 +316,20 @@ kmalloc_caches[NR_KMALLOC_TYPES][KMALLOC_SHIFT_HIGH + 1];
 
 static __always_inline enum kmalloc_cache_type kmalloc_type(gfp_t flags)
 {
-	int is_dma = 0;
-	int type_dma = 0;
-	int is_reclaimable;
-
-#ifdef CONFIG_ZONE_DMA
-	is_dma = !!(flags & __GFP_DMA);
-	type_dma = is_dma * KMALLOC_DMA;
-#endif
+	int gfp_dma = IS_ENABLED(CONFIG_ZONE_DMA) ? __GFP_DMA : 0;
 
-	is_reclaimable = !!(flags & __GFP_RECLAIMABLE);
+	/*
+	 * The most common case is KMALLOC_NORMAL, so test for it
+	 * with a single branch for both flags.
+	 */
+	if (likely((flags & (gfp_dma | __GFP_RECLAIMABLE)) == 0))
+		return KMALLOC_NORMAL;
 
 	/*
-	 * If an allocation is both __GFP_DMA and __GFP_RECLAIMABLE, return
-	 * KMALLOC_DMA and effectively ignore __GFP_RECLAIMABLE
+	 * At least one of the flags has to be set. If both are, __GFP_DMA
+	 * is more important.
 	 */
-	return type_dma + (is_reclaimable & !is_dma) * KMALLOC_RECLAIM;
+	return flags & gfp_dma ? KMALLOC_DMA : KMALLOC_RECLAIM;
 }
 
 /*
-- 
2.19.1

