Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-616870-1526295705-2-18081880635529930604
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526295703; b=j61I+i79h2KYJ2MHFvVkncuGqB+VOsaqeP/JYwt17RClDwEYaK
    8OwxifojwXtwUl4RQoPTHQfNgc0kCP4W8Xk7f6nNPnF8etoxT+cbS9mAJlJpAzRZ
    r7hZMgVY+CTKuH7tMfdpmrTTR6yqAuDmXnt6lX6YjeosVot7QWNfizkYlZjfXlae
    o3lkd2+ZFtkkAHlmsSNVmIWYyKXXtzNyE+/hlczGjF8CmcMK0YG9rsj04z8LJqbg
    +OIysYit1T6SUvzR7Dpd+og3L42u896PLDuFs1pbDJal74E6oWlxFbSYLoNJ+dhD
    letcQyblPC0KbFh17KNPo1nD+Hc1JzAT8uqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=fm2; t=1526295703; bh=vkWAAFSqCGK0pLTficpyatsoRTWp4U
    /gsYNC6SR/ppo=; b=f6hVNg1gzZ1byPrRl8bdBVBcNDhvyIG2UUq641RomnfC+2
    P2+u/eIxNLym1mvxJsugxGXbhVamXekleJKpO5APbE4yT//xgzpZYh2Wfy4wcZRT
    fjti3pGUtCcSsBQ9QzTvk/IfyjZwhGXnFyIp2D3fgfQ0TP2atvGNzCEoV3+/TdJR
    tUkEs6RMlaPNwF6I2i3QQvtrJLIY3rUwVPxQjxQ7DbR//ykOt8xmIxH5uQI4wfWY
    Lp8xreFkEg6ZxF5tyUBELKwPH2ukUBZmzqToHCWY2PzXZnGlsfbj+8VzIVMv02I3
    k9YzuuE2s3B0NgNXBiq6fryiwTNj+q0LH+7LHupw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arm.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=arm.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arm.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=arm.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfBujZBcuBBg2QEa/Yh5FCZr5mJyo52gfTApA9K8F7OVTjGc6Z7qepmQWu1ZoSzdJGM4hSJCzwWFnHanc+hVks/hiauw3+oPwuhFANeTaJ5pUOqgzMOwL
    6ecYGq79GlhyJMnn4NM91DYNVAhDkASnF26l6qBLf6oEzbdI65k1t7Or2LYGKKeDuZr2Mmp4GAsx6wjJZaVei7gUq+0zLeNXhLFqEQnbrifdAoXntn9Lcj+5
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=VwQbUJbxAAAA:8
    a=7CQSdrXTAAAA:8 a=KKAkSRfTAAAA:8 a=uQ3iYVkgtWDrDYqBGE8A:9
    a=AjGcO6oz07-iQ99wixmX:22 a=a-qgeE7W1pNrGK8U0ZQC:22 a=cvBusfyB2V15izCimMoJ:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752533AbeENLBM (ORCPT <rfc822;greg@kroah.com>);
        Mon, 14 May 2018 07:01:12 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:40006 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752151AbeENLBK (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 14 May 2018 07:01:10 -0400
From: Suzuki K Poulose <suzuki.poulose@arm.com>
To: stable@vger.kernel.org
Cc: suzuki.poulose@arm.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com,
        will.deacon@arm.com, mark.rutland@arm.com, dave.martin@arm.com
Subject: [PATCH 1/2][stable-4.4] arm64: introduce mov_q macro to move a constant into a 64-bit register
Date: Mon, 14 May 2018 12:01:03 +0100
Message-Id: <1526295664-22187-1-git-send-email-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.7.4
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

commit 30b5ba5cf333cc650e474eaf2cc1ae91bc7cf89f upstream

Implement a macro mov_q that can be used to move an immediate constant
into a 64-bit register, using between 2 and 4 movz/movk instructions
(depending on the operand)

Cc: stable@vger.kernel.org # v4.4
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
  Cherry picked for backport of
  "commit ece1397cbc89c51914fae1aec729539cfd8bd62b upstream"
---
 arch/arm64/include/asm/assembler.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/assembler.h
index 12eff92..83e2309 100644
--- a/arch/arm64/include/asm/assembler.h
+++ b/arch/arm64/include/asm/assembler.h
@@ -204,4 +204,24 @@ lr	.req	x30		// link register
 	.size	__pi_##x, . - x;	\
 	ENDPROC(x)
 
+	/*
+	 * mov_q - move an immediate constant into a 64-bit register using
+	 *         between 2 and 4 movz/movk instructions (depending on the
+	 *         magnitude and sign of the operand)
+	 */
+	.macro	mov_q, reg, val
+	.if (((\val) >> 31) == 0 || ((\val) >> 31) == 0x1ffffffff)
+	movz	\reg, :abs_g1_s:\val
+	.else
+	.if (((\val) >> 47) == 0 || ((\val) >> 47) == 0x1ffff)
+	movz	\reg, :abs_g2_s:\val
+	.else
+	movz	\reg, :abs_g3:\val
+	movk	\reg, :abs_g2_nc:\val
+	.endif
+	movk	\reg, :abs_g1_nc:\val
+	.endif
+	movk	\reg, :abs_g0_nc:\val
+	.endm
+
 #endif	/* __ASM_ASSEMBLER_H */
-- 
2.7.4
