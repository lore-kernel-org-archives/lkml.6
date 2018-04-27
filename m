Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-284719-1524838068-2-1226156745728108427
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524838068; b=LT5mO7eAnqGESQKR9E2gVK33gbtHEmYIn3ad8x2D5Q/caGb/lB
    x+6H6lccp5DUM7IF5tFnqeXxacs/nx1+CYfV/vPgORkLUv1P5Hazd3a8SV4EBPkr
    MhKd7Oyn0FlMvcIDwSqoZb/jviwvNRFAjTKytI2Gm5g3DIUp+xqYcSwnbPyRFyOZ
    iD+HPw+roXfzzchK6+gmpCkFil3zmG3vUcEZkHS/GNdH+PmgrfUF9o9zM7jILmgg
    31VUKarowCY4nBHQ/3mj8o7xgqVUER/NnPNAfcehrugguX5VqCBxk+UvSWWAzf4B
    ykVKNmHOm3AUHOCQtf0j5JgczSLSRDubnqFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1524838068; bh=8EWrbZ5CUq+uUf6Lg4NHz1YCBxJRZP
    vOIxOTD0JZqtY=; b=T6eJOcquK3mpqNxHaCcioVGwDmxqXt1/8CUT1QjHjqja/k
    HKB4aT3bLkaFTxiVg7oy7UfwNQPz5NB175kP09BVmiQQpEQNCYgsg9OWvTWCElLU
    senJDHG9cYbip9Djs5mz5kBrHA9oIh7jdswDhfaV53+vwXnlw9NDV5guBavUIyes
    EehWKOLZErTuyr8lwyyPomsY4+FI4ltU+X3f7L051qpk+x/oidGtEiHxwmP0rx0n
    U0NZq4V3uLFbGKAL+IyhV15LaeKnzgQRkGWGLx0DSzFEohiHhGce6STaBbByn5XV
    2NznWr8DzKOX/5WY9hFVx4HtC4ZHBA19z7TqxNvg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfHNSZvERpgm761+CRKiY1/joSH9az62PoslrLA5vf85PXo+Liq6bjVi1otfZ4xwm3PlglxsOHfNZsP6HwXuww+th2zbdCJM/5h1byy8G0b19+ypcTYZi
    x1oC+tYZyKZndqfG01cpin5J2lJ0+AcUnqUtpBP/Bo660zKX/QZY+sbdGML4ZDE+wTM3q64SggV3rlIfs6Fx4tDSzhb3+eOgKViJHZz/zVrQ+lWK17OD/hE9
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=VnNF1IyMAAAA:8 a=20KFwNOVAAAA:8 a=ag1SF4gXAAAA:8 a=ExkVqMlTcIx5Lt4i6OIA:9
    a=QEXdDO2ut3YA:10 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934342AbeD0OHo (ORCPT <rfc822;greg@kroah.com>);
        Fri, 27 Apr 2018 10:07:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:53466 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933869AbeD0OHm (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 27 Apr 2018 10:07:42 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22F02218CA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>
Subject: [PATCH 4.14 47/80] s390/alternative: use a copy of the facility bit mask
Date: Fri, 27 Apr 2018 15:58:40 +0200
Message-Id: <20180427135735.354589719@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180427135732.928644313@linuxfoundation.org>
References: <20180427135732.928644313@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Martin Schwidefsky <schwidefsky@de.ibm.com>


[ Upstream commit cf1489984641369611556bf00c48f945c77bcf02 ]

To be able to switch off specific CPU alternatives with kernel parameters
make a copy of the facility bit mask provided by STFLE and use the copy
for the decision to apply an alternative.

Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/s390/include/asm/facility.h |   18 ++++++++++++++++++
 arch/s390/include/asm/lowcore.h  |    3 ++-
 arch/s390/kernel/alternative.c   |    3 ++-
 arch/s390/kernel/early.c         |    3 +++
 arch/s390/kernel/setup.c         |    4 +++-
 arch/s390/kernel/smp.c           |    4 +++-
 6 files changed, 31 insertions(+), 4 deletions(-)

--- a/arch/s390/include/asm/facility.h
+++ b/arch/s390/include/asm/facility.h
@@ -15,6 +15,24 @@
 
 #define MAX_FACILITY_BIT (sizeof(((struct lowcore *)0)->stfle_fac_list) * 8)
 
+static inline void __set_facility(unsigned long nr, void *facilities)
+{
+	unsigned char *ptr = (unsigned char *) facilities;
+
+	if (nr >= MAX_FACILITY_BIT)
+		return;
+	ptr[nr >> 3] |= 0x80 >> (nr & 7);
+}
+
+static inline void __clear_facility(unsigned long nr, void *facilities)
+{
+	unsigned char *ptr = (unsigned char *) facilities;
+
+	if (nr >= MAX_FACILITY_BIT)
+		return;
+	ptr[nr >> 3] &= ~(0x80 >> (nr & 7));
+}
+
 static inline int __test_facility(unsigned long nr, void *facilities)
 {
 	unsigned char *ptr;
--- a/arch/s390/include/asm/lowcore.h
+++ b/arch/s390/include/asm/lowcore.h
@@ -155,7 +155,8 @@ struct lowcore {
 	__u8	pad_0x0e20[0x0f00-0x0e20];	/* 0x0e20 */
 
 	/* Extended facility list */
-	__u64	stfle_fac_list[32];		/* 0x0f00 */
+	__u64	stfle_fac_list[16];		/* 0x0f00 */
+	__u64	alt_stfle_fac_list[16];		/* 0x0f80 */
 	__u8	pad_0x1000[0x11b0-0x1000];	/* 0x1000 */
 
 	/* Pointer to the machine check extended save area */
--- a/arch/s390/kernel/alternative.c
+++ b/arch/s390/kernel/alternative.c
@@ -74,7 +74,8 @@ static void __init_or_module __apply_alt
 		instr = (u8 *)&a->instr_offset + a->instr_offset;
 		replacement = (u8 *)&a->repl_offset + a->repl_offset;
 
-		if (!test_facility(a->facility))
+		if (!__test_facility(a->facility,
+				     S390_lowcore.alt_stfle_fac_list))
 			continue;
 
 		if (unlikely(a->instrlen % 2 || a->replacementlen % 2)) {
--- a/arch/s390/kernel/early.c
+++ b/arch/s390/kernel/early.c
@@ -329,6 +329,9 @@ static noinline __init void setup_facili
 {
 	stfle(S390_lowcore.stfle_fac_list,
 	      ARRAY_SIZE(S390_lowcore.stfle_fac_list));
+	memcpy(S390_lowcore.alt_stfle_fac_list,
+	       S390_lowcore.stfle_fac_list,
+	       sizeof(S390_lowcore.alt_stfle_fac_list));
 }
 
 static __init void detect_diag9c(void)
--- a/arch/s390/kernel/setup.c
+++ b/arch/s390/kernel/setup.c
@@ -339,7 +339,9 @@ static void __init setup_lowcore(void)
 	lc->preempt_count = S390_lowcore.preempt_count;
 	lc->stfl_fac_list = S390_lowcore.stfl_fac_list;
 	memcpy(lc->stfle_fac_list, S390_lowcore.stfle_fac_list,
-	       MAX_FACILITY_BIT/8);
+	       sizeof(lc->stfle_fac_list));
+	memcpy(lc->alt_stfle_fac_list, S390_lowcore.alt_stfle_fac_list,
+	       sizeof(lc->alt_stfle_fac_list));
 	if (MACHINE_HAS_VX || MACHINE_HAS_GS) {
 		unsigned long bits, size;
 
--- a/arch/s390/kernel/smp.c
+++ b/arch/s390/kernel/smp.c
@@ -282,7 +282,9 @@ static void pcpu_prepare_secondary(struc
 	__ctl_store(lc->cregs_save_area, 0, 15);
 	save_access_regs((unsigned int *) lc->access_regs_save_area);
 	memcpy(lc->stfle_fac_list, S390_lowcore.stfle_fac_list,
-	       MAX_FACILITY_BIT/8);
+	       sizeof(lc->stfle_fac_list));
+	memcpy(lc->alt_stfle_fac_list, S390_lowcore.alt_stfle_fac_list,
+	       sizeof(lc->alt_stfle_fac_list));
 }
 
 static void pcpu_attach_task(struct pcpu *pcpu, struct task_struct *tsk)
