Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C853C43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 13:54:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F72A206BA
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 13:54:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F72A206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729845AbeIFS3u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 14:29:50 -0400
Received: from mx2.suse.de ([195.135.220.15]:46068 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726949AbeIFS3t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 14:29:49 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id DC8BBABEF;
        Thu,  6 Sep 2018 13:54:07 +0000 (UTC)
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org,
        peterz@infradead.org, x86@kernel.org
References: <alpine.DEB.2.21.1808312122300.1349@nanos.tec.linutronix.de>
Subject: =?UTF-8?Q?Re:_cmpxchg.h:245:2:_error:_=e2=80=98asm=e2=80=99_operand?=
 =?UTF-8?Q?_has_impossible_constraints?=
To:     mroos@linux.ee
From:   Juergen Gross <jgross@suse.com>
Openpgp: preference=signencrypt
Autocrypt: addr=jgross@suse.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <cfc3163c-40f2-ad5e-b303-bb8dc4288022@suse.com>
Date:   Thu, 6 Sep 2018 15:54:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1808312122300.1349@nanos.tec.linutronix.de>
Content-Type: multipart/mixed;
 boundary="------------F7AC99E4326795D3F57926D8"
Content-Language: de-DE
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------F7AC99E4326795D3F57926D8
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Hey Meelis,

On Mon, 27 Aug 2018, Meelis Roos wrote:

> While trying to compile v4.18-13105-gaba16dc5cf93 with gcc 5.3.1 on a
> 32-bit x86 configured for AMD K6
>   CC      mm/slub.o
> In file included from ./arch/x86/include/asm/atomic.h:8:0,
>                  from ./include/linux/atomic.h:7,
>                  from ./arch/x86/include/asm/thread_info.h:54,
>                  from ./include/linux/thread_info.h:38,
>                  from ./arch/x86/include/asm/preempt.h:7,
>                  from ./include/linux/preempt.h:81,
>                  from ./include/linux/spinlock.h:51,
>                  from ./include/linux/mmzone.h:8,
>                  from ./include/linux/gfp.h:6,
>                  from ./include/linux/mm.h:10,
>                  from mm/slub.c:13:
> mm/slub.c: In function ‘__slab_free’:
> ./arch/x86/include/asm/cmpxchg.h:245:2: error: ‘asm’ operand has
impossible constraints
>   asm volatile(pfx "cmpxchg%c4b %2; sete %0"   \

Could you give the attched patch a try? I've been hit by this issue
via kbuild robot complaining about one of my patches which didn't
touch the asm stuff above.

I suspect the "=a" contraint of the outputs and "a" of the inputs
are the culprit. You could save me from having to search through
all the debian repos for a gcc showing that issue...


Juergen

--------------F7AC99E4326795D3F57926D8
Content-Type: text/x-patch;
 name="0001-x86-correct-inline-asm-constraints-in-__cmpxchg_doub.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-x86-correct-inline-asm-constraints-in-__cmpxchg_doub.pa";
 filename*1="tch"

From 252450d28ffc8fbfd5b332d0b97990ae12a207d9 Mon Sep 17 00:00:00 2001
From: Juergen Gross <jgross@suse.com>
Date: Wed, 5 Sep 2018 11:32:26 +0200
Subject: [PATCH] x86: correct inline asm constraints in __cmpxchg_double()

Specifying "=a" for output constraints and "a" for input seems to be
wrong. Instead "0" should be used for the input constraint.

Fixes: cdcd629869fab ("x86: Fix and improve cmpxchg_double{,_local}()")
Cc: stable@vger.kernel.org
Signed-off-by: Juergen Gross <jgross@suse.com>
---
 arch/x86/include/asm/cmpxchg.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/cmpxchg.h b/arch/x86/include/asm/cmpxchg.h
index a55d79b233d3..b3b4d61a8969 100644
--- a/arch/x86/include/asm/cmpxchg.h
+++ b/arch/x86/include/asm/cmpxchg.h
@@ -245,7 +245,7 @@ extern void __add_wrong_size(void)
 	asm volatile(pfx "cmpxchg%c4b %2; sete %0"			\
 		     : "=a" (__ret), "+d" (__old2),			\
 		       "+m" (*(p1)), "+m" (*(p2))			\
-		     : "i" (2 * sizeof(long)), "a" (__old1),		\
+		     : "i" (2 * sizeof(long)), "0" (__old1),		\
 		       "b" (__new1), "c" (__new2));			\
 	__ret;								\
 })
-- 
2.16.4


--------------F7AC99E4326795D3F57926D8--
