Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DAC3ECE566
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 13:19:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E72F12150E
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 13:19:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E72F12150E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=benyossef.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732867AbeITTCy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 15:02:54 -0400
Received: from foss.arm.com ([217.140.101.70]:45858 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732650AbeITTCx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 15:02:53 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 963847A9;
        Thu, 20 Sep 2018 06:19:24 -0700 (PDT)
Received: from sugar.kfn.arm.com (E110176.Emea.Arm.com [10.50.4.176])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2BB083F5BD;
        Thu, 20 Sep 2018 06:19:22 -0700 (PDT)
From:   Gilad Ben-Yossef <gilad@benyossef.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
Cc:     ofir.drang@arm.com, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] crypto: tcrypt: add OFB functional tests
Date:   Thu, 20 Sep 2018 14:18:40 +0100
Message-Id: <1537449521-16182-4-git-send-email-gilad@benyossef.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1537449521-16182-1-git-send-email-gilad@benyossef.com>
References: <1537449521-16182-1-git-send-email-gilad@benyossef.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We already have OFB test vectors and tcrypt OFB speed tests.
Add OFB functional tests to tcrypt as well.

Signed-off-by: Gilad Ben-Yossef <gilad@benyossef.com>
---
 crypto/tcrypt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/crypto/tcrypt.c b/crypto/tcrypt.c
index e56c3e1..e64f1df 100644
--- a/crypto/tcrypt.c
+++ b/crypto/tcrypt.c
@@ -1733,6 +1733,7 @@ static int do_test(const char *alg, u32 type, u32 mask, int m, u32 num_mb)
 		ret += tcrypt_test("xts(aes)");
 		ret += tcrypt_test("ctr(aes)");
 		ret += tcrypt_test("rfc3686(ctr(aes))");
+		ret += tcrypt_test("ofb(aes)");
 		break;
 
 	case 11:
-- 
2.7.4

