Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3218881-1519790690-2-4209652626069784773
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES enro, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519790690; b=piOdvV5Zk3TYv/NQvUyM6+OJHeMC8lFVYzeXpIya5LoicYo
    R7p9oZ2nehR0+lkHUIS7dCXKKKJ230oWFIO2loS/fu2yMfmjLUmClto1KfMb+fEb
    O+LQJVpB5EPd50oukB1kWjo6J2ItPkVrwCCfYHGT/riK64MmSB7FqIPwV9eNWd3T
    lNHhL+Pkw0ZdUmVtY0rifjILzAWPryPFeSP1x7RtWgHt2aeVW1ESH5V1EZ4PVqcg
    6V1HMYsgOlLKcwwhupdvoiWu0R8hd6YPZbotFh60GxPK3ioCu6ZvEKsvwS08q0wM
    U/5wysQOAJ3ZMw+uw+0zzkZgraV+JOrfHXpzIZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1519790690;
    bh=ei8K/u/Kw0usIbJStlCx/X9r89lOl79D4a+wZXmBbiM=; b=wAtm40ZBAgfA
    4ogNOzEkI5DHcSnZYG2JpwwGHWwCY1HNoPtjoi3lYn/1P36WNkB0lG18MjmSCSw/
    J2xxKhTxc89L+bN8yoynSaQ0GrD0DXIrX21u73+eCIMUkjy5yjWQa05vV3UOsXSx
    SxT3rCeqPI6IO6c26/iQReMizADLC6mftxU8nCdWr53iRQ3HL0C8d8S7+/QjE0Wc
    DAO8O0vA5XJ++PXJPoZuhXhs6EeY6tOJTJbXaijeME6nYsyZmlwAYRYDS4k3RG1d
    OJ0Z6e22dWkw6IIMZ2QvWGwyocrvJwKrzP/lsyanQiDcJFBtN79ntcKla37VavO0
    sb6OlCiJDw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=CZzvQxfG x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=oREu3izv;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=CZzvQxfG x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=oREu3izv;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751943AbeB1D5y (ORCPT <rfc822;greg@kroah.com>);
        Tue, 27 Feb 2018 22:57:54 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:43054 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751811AbeB1D5v (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 27 Feb 2018 22:57:51 -0500
X-Google-Smtp-Source: AH8x225/NZ7mzysgfeYj3kn1hWAbvofRNbXpE6bobCK+GVWXabT+4n2gYu8+o9CImYu42riJWcoATA==
From: Alex Shi <alex.shi@linaro.org>
To: Marc Zyngier <marc.zyngier@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        stable@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc: Alex Shi <alex.shi@linaro.org>
Subject: [PATCH 03/29] arm64: mm: Allocate ASIDs in pairs
Date: Wed, 28 Feb 2018 11:56:25 +0800
Message-Id: <1519790211-16582-4-git-send-email-alex.shi@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519790211-16582-1-git-send-email-alex.shi@linaro.org>
References: <1519790211-16582-1-git-send-email-alex.shi@linaro.org>
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Will Deacon <will.deacon@arm.com>

commit 0c8ea531b774 upstream.

In preparation for separate kernel/user ASIDs, allocate them in pairs
for each mm_struct. The bottom bit distinguishes the two: if it is set,
then the ASID will map only userspace.

Reviewed-by: Mark Rutland <mark.rutland@arm.com>
Tested-by: Laura Abbott <labbott@redhat.com>
Tested-by: Shanker Donthineni <shankerd@codeaurora.org>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Alex Shi <alex.shi@linaro.org>

Conflicts:
	no MMCF_AARCH32 in arch/arm64/include/asm/mmu.h
---
 arch/arm64/include/asm/mmu.h |  2 ++
 arch/arm64/mm/context.c      | 25 +++++++++++++++++--------
 2 files changed, 19 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/include/asm/mmu.h b/arch/arm64/include/asm/mmu.h
index 8d9fce0..49924e5 100644
--- a/arch/arm64/include/asm/mmu.h
+++ b/arch/arm64/include/asm/mmu.h
@@ -16,6 +16,8 @@
 #ifndef __ASM_MMU_H
 #define __ASM_MMU_H
 
+#define USER_ASID_FLAG	(UL(1) << 48)
+
 typedef struct {
 	atomic64_t	id;
 	void		*vdso;
diff --git a/arch/arm64/mm/context.c b/arch/arm64/mm/context.c
index efcf1f7..f00f5ee 100644
--- a/arch/arm64/mm/context.c
+++ b/arch/arm64/mm/context.c
@@ -39,7 +39,16 @@ static cpumask_t tlb_flush_pending;
 
 #define ASID_MASK		(~GENMASK(asid_bits - 1, 0))
 #define ASID_FIRST_VERSION	(1UL << asid_bits)
-#define NUM_USER_ASIDS		ASID_FIRST_VERSION
+
+#ifdef CONFIG_UNMAP_KERNEL_AT_EL0
+#define NUM_USER_ASIDS		(ASID_FIRST_VERSION >> 1)
+#define asid2idx(asid)		(((asid) & ~ASID_MASK) >> 1)
+#define idx2asid(idx)		(((idx) << 1) & ~ASID_MASK)
+#else
+#define NUM_USER_ASIDS		(ASID_FIRST_VERSION)
+#define asid2idx(asid)		((asid) & ~ASID_MASK)
+#define idx2asid(idx)		asid2idx(idx)
+#endif
 
 /* Get the ASIDBits supported by the current CPU */
 static u32 get_cpu_asid_bits(void)
@@ -104,7 +113,7 @@ static void flush_context(unsigned int cpu)
 		 */
 		if (asid == 0)
 			asid = per_cpu(reserved_asids, i);
-		__set_bit(asid & ~ASID_MASK, asid_map);
+		__set_bit(asid2idx(asid), asid_map);
 		per_cpu(reserved_asids, i) = asid;
 	}
 
@@ -159,16 +168,16 @@ static u64 new_context(struct mm_struct *mm, unsigned int cpu)
 		 * We had a valid ASID in a previous life, so try to re-use
 		 * it if possible.
 		 */
-		asid &= ~ASID_MASK;
-		if (!__test_and_set_bit(asid, asid_map))
+		if (!__test_and_set_bit(asid2idx(asid), asid_map))
 			return newasid;
 	}
 
 	/*
 	 * Allocate a free ASID. If we can't find one, take a note of the
-	 * currently active ASIDs and mark the TLBs as requiring flushes.
-	 * We always count from ASID #1, as we use ASID #0 when setting a
-	 * reserved TTBR0 for the init_mm.
+	 * currently active ASIDs and mark the TLBs as requiring flushes.  We
+	 * always count from ASID #2 (index 1), as we use ASID #0 when setting
+	 * a reserved TTBR0 for the init_mm and we allocate ASIDs in even/odd
+	 * pairs.
 	 */
 	asid = find_next_zero_bit(asid_map, NUM_USER_ASIDS, cur_idx);
 	if (asid != NUM_USER_ASIDS)
@@ -185,7 +194,7 @@ static u64 new_context(struct mm_struct *mm, unsigned int cpu)
 set_asid:
 	__set_bit(asid, asid_map);
 	cur_idx = asid;
-	return asid | generation;
+	return idx2asid(asid) | generation;
 }
 
 void check_and_switch_context(struct mm_struct *mm, unsigned int cpu)
-- 
2.7.4
