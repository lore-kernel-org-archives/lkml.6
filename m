Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C64EFD21E1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 08:59:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEDA720870
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 08:59:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEDA720870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726854AbeG3Kdi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 06:33:38 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:49547 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726639AbeG3Kdh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 06:33:37 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1fk41g-0004MV-Lo; Mon, 30 Jul 2018 08:59:36 +0000
From:   Colin King <colin.king@canonical.com>
To:     linux-crypto@vger.kernel.org, Eric Biggers <ebiggers@google.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][RESEND] lib/mpi: remove redundant variable esign
Date:   Mon, 30 Jul 2018 09:59:36 +0100
Message-Id: <20180730085936.10050-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Variable esign is being assigned but is never used hence it is
redundant and can be removed.

Cleans up clang warning:
warning: variable 'esign' set but not used [-Wunused-but-set-variable]

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 lib/mpi/mpi-pow.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/lib/mpi/mpi-pow.c b/lib/mpi/mpi-pow.c
index 468fb7cd1221..a5c921e6d667 100644
--- a/lib/mpi/mpi-pow.c
+++ b/lib/mpi/mpi-pow.c
@@ -41,7 +41,7 @@ int mpi_powm(MPI res, MPI base, MPI exp, MPI mod)
 	mpi_ptr_t tspace = NULL;
 	mpi_ptr_t rp, ep, mp, bp;
 	mpi_size_t esize, msize, bsize, rsize;
-	int esign, msign, bsign, rsign;
+	int msign, bsign, rsign;
 	mpi_size_t size;
 	int mod_shift_cnt;
 	int negative_result;
@@ -53,7 +53,6 @@ int mpi_powm(MPI res, MPI base, MPI exp, MPI mod)
 	esize = exp->nlimbs;
 	msize = mod->nlimbs;
 	size = 2 * msize;
-	esign = exp->sign;
 	msign = mod->sign;
 
 	rp = res->d;
-- 
2.17.1

