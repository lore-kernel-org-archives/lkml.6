Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-380590-1524842056-2-12737370036800113055
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
    1524842055; b=hSF4/ie4KougdvV4KGbUlhQKKtvL/G8rZCalHk2hvY8rFL7dwd
    DHmZSSPwPqMiPad9GQf0bh7gr/Zg35Xpzo5+6y5gzPiEWC6SerfRgVVekv03A8ry
    TP452/DPoggNYm//7LZyhLWlONg71ueFqGg4wbClLlzJx4Vt3kw3g95oD48OJHyH
    M5Ih2yW3zQhXPD3y943tz5kMxHC6LhvewiwvmKRgoQ+c/u0upsEHW34hd+9E3vwd
    oK1REN1tRvgzYbiXwfd0HdqiFm7BPuyWkXfJjbw+dK1fpfsKrEozp438TJT6mQHu
    cdIzX73t69FGgZZrQYtOTAVCq1VYtnTwqzJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1524842055; bh=lOBIklq/6IvNcvOuOGn7kFryBT0eKE
    YoVTTZAzOfJeM=; b=D7x8LFE61+XYGDT2ZxFCCZWHNRODNViljNjuH3F2ju9yeK
    ZNYg4EhI2SRSPFB+0IoEQNy4LiAjhsydGhRgvziIuNxNhIEFNHNcoOmZGxF292jZ
    KL3ctk6dJVuYZsHmmdM1wHTV5SjmOIedOom/GxvOIMsGPGt3J3YC9PtWhMWBbXQ4
    7qpp5KNDZsAuvdq2prDYnG7PoVnpW/oQOwZ9FJmOmhdFFa9DzUKrag8t7Lduq3gH
    J+IqmdgxzsXGFyiPfcOHRNPI1hrIpQnNbbHv62qTCCn+/MBoHjLW9o4aWybblBfG
    zbpmHKsScNupsfSa6N7PvNXvP9GCmD5Aby+QQawQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
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
X-CM-Envelope: MS4wfB2dKkDQzylo50DrE4qn7ErOlLTRbmEjlVYgHTTOk9jxLNR5azld/NpBwO4Zgzw1NaqwIQyZ92Ypfs+pDIx1NGUI68W8pXN9r8CNj4ZQIZe3rV5hT7F4
    +v0SwQJFYePEXMXgZUhC/RX6K6HlhldsZhXg9kwhJK99s+3AiVPdMmwk5rRICvATi9wyvKvweDrRjqi1XcbqQp9DQeEs2H+oDcEoOdW0wGK7ZMkYLPkKG2CG
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=VnNF1IyMAAAA:8 a=20KFwNOVAAAA:8 a=ag1SF4gXAAAA:8 a=UCc2L4ef9RhdiquWdVcA:9
    a=QEXdDO2ut3YA:10 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933601AbeD0OD4 (ORCPT <rfc822;greg@kroah.com>);
        Fri, 27 Apr 2018 10:03:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:50320 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933596AbeD0ODx (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 27 Apr 2018 10:03:53 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0B9F2189D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>
Subject: [PATCH 4.9 33/74] s390/alternative: use a copy of the facility bit mask
Date: Fri, 27 Apr 2018 15:58:23 +0200
Message-Id: <20180427135711.305124292@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180427135709.899303463@linuxfoundation.org>
References: <20180427135709.899303463@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -17,6 +17,24 @@
 
 #define MAX_FACILITY_BIT (256*8)	/* stfle_fac_list has 256 bytes */
 
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
@@ -150,7 +150,8 @@ struct lowcore {
 	__u8	pad_0x0e20[0x0f00-0x0e20];	/* 0x0e20 */
 
 	/* Extended facility list */
-	__u64	stfle_fac_list[32];		/* 0x0f00 */
+	__u64	stfle_fac_list[16];		/* 0x0f00 */
+	__u64	alt_stfle_fac_list[16];		/* 0x0f80 */
 	__u8	pad_0x1000[0x11b0-0x1000];	/* 0x1000 */
 
 	/* Pointer to vector register save area */
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
@@ -299,6 +299,9 @@ static noinline __init void setup_facili
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
@@ -336,7 +336,9 @@ static void __init setup_lowcore(void)
 	lc->machine_flags = S390_lowcore.machine_flags;
 	lc->stfl_fac_list = S390_lowcore.stfl_fac_list;
 	memcpy(lc->stfle_fac_list, S390_lowcore.stfle_fac_list,
-	       MAX_FACILITY_BIT/8);
+	       sizeof(lc->stfle_fac_list));
+	memcpy(lc->alt_stfle_fac_list, S390_lowcore.alt_stfle_fac_list,
+	       sizeof(lc->alt_stfle_fac_list));
 	if (MACHINE_HAS_VX)
 		lc->vector_save_area_addr =
 			(unsigned long) &lc->vector_save_area;
--- a/arch/s390/kernel/smp.c
+++ b/arch/s390/kernel/smp.c
@@ -253,7 +253,9 @@ static void pcpu_prepare_secondary(struc
 	__ctl_store(lc->cregs_save_area, 0, 15);
 	save_access_regs((unsigned int *) lc->access_regs_save_area);
 	memcpy(lc->stfle_fac_list, S390_lowcore.stfle_fac_list,
-	       MAX_FACILITY_BIT/8);
+	       sizeof(lc->stfle_fac_list));
+	memcpy(lc->alt_stfle_fac_list, S390_lowcore.alt_stfle_fac_list,
+	       sizeof(lc->alt_stfle_fac_list));
 }
 
 static void pcpu_attach_task(struct pcpu *pcpu, struct task_struct *tsk)
