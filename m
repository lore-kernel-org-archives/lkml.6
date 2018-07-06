Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E844C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 22:06:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 237B722459
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 22:06:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (4096-bit key) header.d=kolabnow.com header.i=@kolabnow.com header.b="P3iosQGX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 237B722459
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vaga.pv.it
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754291AbeGFWGI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 18:06:08 -0400
Received: from mx.kolabnow.com ([95.128.36.42]:42156 "EHLO mx.kolabnow.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754187AbeGFWGE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 18:06:04 -0400
Received: from localhost (unknown [127.0.0.1])
        by ext-mx-out003.mykolab.com (Postfix) with ESMTP id 712AC41A99;
        Sat,  7 Jul 2018 00:06:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kolabnow.com; h=
        content-transfer-encoding:content-type:content-type:mime-version
        :references:in-reply-to:message-id:date:date:subject:subject
        :from:from:received:received:received; s=dkim20160331; t=
        1530914761; x=1532729162; bh=EYU8ulgCyhN/g/2or8AoVhPSm0DaScM5Ra9
        Y5vjRBSs=; b=P3iosQGXK8tUEDazHdpEnnuC6pJHyzYNgYFAw/4526vv5j2RW8y
        IjbrGK0nFMJCcCDpRUeJL0purEXcYFqAXkI2PK54Z7+WHsjyosnhU8W94CN+XzD9
        O2jOJ7wb+VPbrbz/Hlx0CAy3/BNeOLu/0w2teR4S1I9hLob5RS3PM/n/oy9ekglI
        hyAsgjtl4FtMVx5dFCc6OsIIlNMDgl0g8HfvDTkMGu7jLkrVWf+GUX3pu3CjBY+I
        BNsIoahOauJ01PZXS+zMHcTjCJqKVtDZAJhwHzhCm0x18shmSYzVwcav7uTIFKXl
        CEs1jdtvkDkd9SVQPM7dkzAUOfXKZSP0upjjfFpcOXG43pLawcmg6sM/rWoLgnEw
        qA0WdULElYA3Fpv4is/7kg3ED2n971HaaRuHNiLgk/H7dCC1daEqziq+oOvyLMDv
        VtmoKXasADmdlTTxObuwznDUzBwxMaU4xG12hJ3bHc4xKL0DtsdOr3f/CNdYovyl
        w2a7D3g1F23CcBLiUTN2RJ29JAb8aMdlNGeIwSHn65zF2AFm/e2QLjT0G1A1/b0B
        rKe465p9wG8VngAtgrU2GF802Zx/Krnz2NXr2DyspG+zP/I6Wne+sQy2iaWjRiPy
        wpuiw3+BX27WP9d/w0cfUsHryT99fGmGYQaR4+L5IWNLZL7KBE8XxMaE=
X-Virus-Scanned: amavisd-new at mykolab.com
Received: from mx.kolabnow.com ([127.0.0.1])
        by localhost (ext-mx-out003.mykolab.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id kjcpCfi_0KFk; Sat,  7 Jul 2018 00:06:01 +0200 (CEST)
Received: from int-mx003.mykolab.com (unknown [10.9.13.3])
        by ext-mx-out003.mykolab.com (Postfix) with ESMTPS id CC1F0403BE;
        Sat,  7 Jul 2018 00:06:01 +0200 (CEST)
Received: from ext-subm003.mykolab.com (unknown [10.9.6.3])
        by int-mx003.mykolab.com (Postfix) with ESMTPS id 76D4EA51;
        Sat,  7 Jul 2018 00:06:01 +0200 (CEST)
From:   Federico Vaga <federico.vaga@vaga.pv.it>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alessia Mantegazza <amantegazza@vaga.pv.it>,
        Federico Vaga <federico.vaga@vaga.pv.it>
Subject: [PATCH 1/2] doc:hacking: add labels
Date:   Sat,  7 Jul 2018 00:05:16 +0200
Message-Id: <20180706220517.28623-2-federico.vaga@vaga.pv.it>
In-Reply-To: <20180706220517.28623-1-federico.vaga@vaga.pv.it>
References: <20180706220517.28623-1-federico.vaga@vaga.pv.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Apparently some local links are not properly generated in locking.rst.
This patch use the ':ref:' directive to add the link to the section label.

Signed-off-by: Federico Vaga <federico.vaga@vaga.pv.it>
---
 Documentation/kernel-hacking/locking.rst | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/Documentation/kernel-hacking/locking.rst b/Documentation/kernel-hacking/locking.rst
index f937c0fd11aa..574fc92a6f20 100644
--- a/Documentation/kernel-hacking/locking.rst
+++ b/Documentation/kernel-hacking/locking.rst
@@ -177,7 +177,7 @@ perfect world).
 
 Note that you can also use :c:func:`spin_lock_irq()` or
 :c:func:`spin_lock_irqsave()` here, which stop hardware interrupts
-as well: see `Hard IRQ Context <#hardirq-context>`__.
+as well: see :ref:`Hard IRQ Context <hardirq-context>`.
 
 This works perfectly for UP as well: the spin lock vanishes, and this
 macro simply becomes :c:func:`local_bh_disable()`
@@ -228,7 +228,7 @@ The Same Softirq
 ~~~~~~~~~~~~~~~~
 
 The same softirq can run on the other CPUs: you can use a per-CPU array
-(see `Per-CPU Data <#per-cpu>`__) for better performance. If you're
+(see :ref:`Per-CPU Data <per-cpu>`) for better performance. If you're
 going so far as to use a softirq, you probably care about scalable
 performance enough to justify the extra complexity.
 
@@ -243,6 +243,8 @@ You'll need to use :c:func:`spin_lock()` and
 tasklet, different softirq or the same or another softirq: any of them
 could be running on a different CPU.
 
+.. _`hardirq-context`:
+
 Hard IRQ Context
 ================
 
@@ -875,6 +877,8 @@ Alan Cox says, “Lock data, not code”.
 Common Problems
 ===============
 
+.. _`deadlock`:
+
 Deadlock: Simple and Advanced
 -----------------------------
 
@@ -1247,6 +1251,8 @@ The benefit here is that the reference count is not written to: the
 object is not altered in any way, which is much faster on SMP machines
 due to caching.
 
+.. _`per-cpu`:
+
 Per-CPU Data
 ------------
 
@@ -1294,6 +1300,8 @@ Naturally, this is slower than just a :c:func:`spin_lock_irq()`
 call, so it only makes sense if this type of access happens extremely
 rarely.
 
+.. _`sleeping-things`:
+
 What Functions Are Safe To Call From Interrupts?
 ================================================
 
-- 
2.17.1

