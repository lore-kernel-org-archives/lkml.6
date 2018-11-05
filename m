Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2029C46475
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 12:05:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93A4320825
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 12:05:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93A4320825
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=benyossef.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729124AbeKEVYb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 16:24:31 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:42126 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727128AbeKEVYb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 16:24:31 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A444180D;
        Mon,  5 Nov 2018 04:05:06 -0800 (PST)
Received: from sugar.kfn.arm.com (E110176.Arm.com [10.50.4.178])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 02FED3F5BD;
        Mon,  5 Nov 2018 04:05:04 -0800 (PST)
From:   Gilad Ben-Yossef <gilad@benyossef.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
Cc:     Ofir Drang <Ofir.Drang@arm.com>, Yael Chemla <Yael.Chemla@arm.com>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] crypto: cts: document NIST standard status
Date:   Mon,  5 Nov 2018 12:05:01 +0000
Message-Id: <1541419502-7286-1-git-send-email-gilad@benyossef.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cts(cbc(aes)) as used in the kernel has been added to NIST
standard as CBC-CS3. Document it as such.

Signed-off-by: Gilad Ben-Yossef <gilad@benyossef.com>
Suggested-by: Stephan Mueller <smueller@chronox.de>
---
 crypto/Kconfig | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/crypto/Kconfig b/crypto/Kconfig
index f7a235d..9176023 100644
--- a/crypto/Kconfig
+++ b/crypto/Kconfig
@@ -430,11 +430,14 @@ config CRYPTO_CTS
 	help
 	  CTS: Cipher Text Stealing
 	  This is the Cipher Text Stealing mode as described by
-	  Section 8 of rfc2040 and referenced by rfc3962.
-	  (rfc3962 includes errata information in its Appendix A)
+	  Section 8 of rfc2040 and referenced by rfc3962
+	  (rfc3962 includes errata information in its Appendix A) or
+	  CBC-CS3 as defined by NIST in Sp800-38A addendum from Oct 2010.
 	  This mode is required for Kerberos gss mechanism support
 	  for AES encryption.
 
+	  See: https://csrc.nist.gov/publications/detail/sp/800-38a/addendum/final
+
 config CRYPTO_ECB
 	tristate "ECB support"
 	select CRYPTO_BLKCIPHER
-- 
2.7.4

