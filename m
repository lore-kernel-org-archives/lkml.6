Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3726165-1519677366-2-1758979988505388195
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519677366; b=iSupH7HQGzI+1SYbeV3zOzQRL8jVNUvSz+/qc1jXAXyGk24
    QMrcOaLWIMZtuj0y+oerbZhijd+znvoJ1lXc2sQdZ709q5qCjVGbSwvwhFDFArCh
    otN1CVS/0+4P/HUsc9V38Uhzt6nbP32G7Qcg8BfAUsx7IhEv7pVH096lHRckTxTk
    ILqjICEolGF0Ea4N86KAaOrd3GNUpU5zJW9qgAWccw1ubek26nzNSXpn1GKbSiJq
    bhvdwDe+DFB0BjMuuWMd/L5iqBmrGFsgwgKa8edI99DoB5sO42hmiFcHruqv14Nm
    dpCailpzdH05n3pTfGX1doQJfdKqq6403Dh6NHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519677366; bh=tn7vayHQhIL0OuTAfA1SkMapSl
    evpEQl67y6chOzRlw=; b=YHnGRXKhgOMLLeAQ/+ABe5iuTc05oEisLJbzF7wFJK
    Axihc05H1vBnDuL5UeCO9iPOkO9fl/TulR4WJcbpc6E18KRyOk5q3bjQoCrPviKK
    EteBxRsmVBtULPivnWetzqWgHqyG6RtCVdpdIbPdrHQ1pw5QkHXAgLkARoLFoclV
    miBXP0v76mN0uw9BkSah6SeiyzCMmljq2ut/+cOVvCL5LM9QINX/XY7U7R2jR+ST
    DYM7ApkNpqFBzxxTAULBDO2Odry7agC9QC3/gP4zpD9cRIF+GTRP5vKwcp0UKycV
    Vg0JytapdrX6d7Hf9DJLtfkkflOCt5pK5CHoMdcxeURQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753106AbeBZUfv (ORCPT <rfc822;greg@kroah.com>);
        Mon, 26 Feb 2018 15:35:51 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:36904 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753778AbeBZU1r (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 26 Feb 2018 15:27:47 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Shanker Donthineni <shankerd@codeaurora.org>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH 4.15 41/64] arm64: cpufeature: Fix CTR_EL0 field definitions
Date: Mon, 26 Feb 2018 21:22:18 +0100
Message-Id: <20180226202155.197126619@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180226202153.453363333@linuxfoundation.org>
References: <20180226202153.453363333@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Will Deacon <will.deacon@arm.com>

commit be68a8aaf925aaf35574260bf820bb09d2f9e07f upstream.

Our field definitions for CTR_EL0 suffer from a number of problems:

  - The IDC and DIC fields are missing, which causes us to enable CTR
    trapping on CPUs with either of these returning non-zero values.

  - The ERG is FTR_LOWER_SAFE, whereas it should be treated like CWG as
    FTR_HIGHER_SAFE so that applications can use it to avoid false sharing.

  - [nit] A RES1 field is described as "RAO"

This patch updates the CTR_EL0 field definitions to fix these issues.

Cc: <stable@vger.kernel.org>
Cc: Shanker Donthineni <shankerd@codeaurora.org>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm64/kernel/cpufeature.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -197,9 +197,11 @@ static const struct arm64_ftr_bits ftr_i
 };
 
 static const struct arm64_ftr_bits ftr_ctr[] = {
-	ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_EXACT, 31, 1, 1),	/* RAO */
+	ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_EXACT, 31, 1, 1),		/* RES1 */
+	ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_LOWER_SAFE, 29, 1, 1),	/* DIC */
+	ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_LOWER_SAFE, 28, 1, 1),	/* IDC */
 	ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_HIGHER_SAFE, 24, 4, 0),	/* CWG */
-	ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_LOWER_SAFE, 20, 4, 0),	/* ERG */
+	ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_HIGHER_SAFE, 20, 4, 0),	/* ERG */
 	ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_LOWER_SAFE, 16, 4, 1),	/* DminLine */
 	/*
 	 * Linux can handle differing I-cache policies. Userspace JITs will
