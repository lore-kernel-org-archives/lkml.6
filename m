Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AE6EECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:16:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3049E208D9
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:16:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3049E208D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732167AbeIXSRx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 14:17:53 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:55666 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730150AbeIXSRw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 14:17:52 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 9DBA010A5;
        Mon, 24 Sep 2018 12:16:01 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Michael=20M=C3=BCller?= <michael@fds-team.de>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 070/173] crypto: sharah - Unregister correct algorithms for SAHARA 3
Date:   Mon, 24 Sep 2018 13:51:44 +0200
Message-Id: <20180924113121.189682269@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180924113114.334025954@linuxfoundation.org>
References: <20180924113114.334025954@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michael Müller <michael@fds-team.de>

[ Upstream commit 0e7d4d932ffc23f75efb31a8c2ac2396c1b81c55 ]

This patch fixes two typos related to unregistering algorithms supported by
SAHARAH 3. In sahara_register_algs the wrong algorithms are unregistered
in case of an error. In sahara_unregister_algs the wrong array is used to
determine the iteration count.

Signed-off-by: Michael Müller <michael@fds-team.de>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/crypto/sahara.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/crypto/sahara.c
+++ b/drivers/crypto/sahara.c
@@ -1351,7 +1351,7 @@ err_sha_v4_algs:
 
 err_sha_v3_algs:
 	for (j = 0; j < k; j++)
-		crypto_unregister_ahash(&sha_v4_algs[j]);
+		crypto_unregister_ahash(&sha_v3_algs[j]);
 
 err_aes_algs:
 	for (j = 0; j < i; j++)
@@ -1367,7 +1367,7 @@ static void sahara_unregister_algs(struc
 	for (i = 0; i < ARRAY_SIZE(aes_algs); i++)
 		crypto_unregister_alg(&aes_algs[i]);
 
-	for (i = 0; i < ARRAY_SIZE(sha_v4_algs); i++)
+	for (i = 0; i < ARRAY_SIZE(sha_v3_algs); i++)
 		crypto_unregister_ahash(&sha_v3_algs[i]);
 
 	if (dev->version > SAHARA_VERSION_3)


