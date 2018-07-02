Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57AA0C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 08:14:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10FB925458
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 08:14:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10FB925458
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754116AbeGBIOX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 04:14:23 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:52887 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753264AbeGBIOV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 04:14:21 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1fZtyV-0004UI-Qi; Mon, 02 Jul 2018 08:14:19 +0000
From:   Colin King <colin.king@canonical.com>
To:     Tim Waugh <tim@cyberelk.net>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] paride: remove redundant variable n
Date:   Mon,  2 Jul 2018 09:14:19 +0100
Message-Id: <20180702081419.12207-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Variable n is being assigned but is never used hence it is redundant
and can be removed. Also put spacing between variables in declaration
to clean up checkpatch warnings.

Cleans up clang warning:
warning: variable 'n' set but not used [-Wunused-but-set-variable]

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/block/paride/bpck.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/block/paride/bpck.c b/drivers/block/paride/bpck.c
index 4f27e7392e38..89a96786f6ae 100644
--- a/drivers/block/paride/bpck.c
+++ b/drivers/block/paride/bpck.c
@@ -347,7 +347,7 @@ static int bpck_test_proto( PIA *pi, char * scratch, int verbose )
 
 static void bpck_read_eeprom ( PIA *pi, char * buf )
 
-{       int i,j,k,n,p,v,f, om, od;
+{       int i, j, k, p, v, f, om, od;
 
 	bpck_force_spp(pi);
 
@@ -356,7 +356,6 @@ static void bpck_read_eeprom ( PIA *pi, char * buf )
 
 	bpck_connect(pi);
 	
-	n = 0;
 	WR(4,0);
 	for (i=0;i<64;i++) {
 	    WR(6,8);  
-- 
2.17.1

