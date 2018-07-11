Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78852C5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 10:32:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3546120B6F
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 10:32:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3546120B6F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732254AbeGKKgO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 06:36:14 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:46997 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726440AbeGKKgO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 06:36:14 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1fdCQ9-0003nt-GH; Wed, 11 Jul 2018 10:32:29 +0000
From:   Colin King <colin.king@canonical.com>
To:     Ian Abbott <abbotti@mev.co.uk>,
        H Hartley Sweeten <hsweeten@visionengravers.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: comedi: remove redundant variable segpos
Date:   Wed, 11 Jul 2018 11:32:29 +0100
Message-Id: <20180711103229.30066-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Variable segpos is being assigned but is never used hence it is redundant
and can be removed.

Cleans up clang warning:
warning: variable 'segpos' set but not used [-Wunused-but-set-variable]

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/staging/comedi/drivers/pcl816.c | 4 ++--
 drivers/staging/comedi/drivers/pcl818.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/comedi/drivers/pcl816.c b/drivers/staging/comedi/drivers/pcl816.c
index d722079f3327..d87cf6d4a161 100644
--- a/drivers/staging/comedi/drivers/pcl816.c
+++ b/drivers/staging/comedi/drivers/pcl816.c
@@ -282,7 +282,7 @@ static int check_channel_list(struct comedi_device *dev,
 			      unsigned int chanlen)
 {
 	unsigned int chansegment[16];
-	unsigned int i, nowmustbechan, seglen, segpos;
+	unsigned int i, nowmustbechan, seglen;
 
 	/*  correct channel and range number check itself comedi/range.c */
 	if (chanlen < 1) {
@@ -312,7 +312,7 @@ static int check_channel_list(struct comedi_device *dev,
 		}
 
 		/*  check whole chanlist */
-		for (i = 0, segpos = 0; i < chanlen; i++) {
+		for (i = 0; i < chanlen; i++) {
 			if (chanlist[i] != chansegment[i % seglen]) {
 				dev_dbg(dev->class_dev,
 					"bad channel or range number! chanlist[%i]=%d,%d,%d and not %d,%d,%d!\n",
diff --git a/drivers/staging/comedi/drivers/pcl818.c b/drivers/staging/comedi/drivers/pcl818.c
index eebb49751713..0af5315d4357 100644
--- a/drivers/staging/comedi/drivers/pcl818.c
+++ b/drivers/staging/comedi/drivers/pcl818.c
@@ -573,7 +573,7 @@ static int check_channel_list(struct comedi_device *dev,
 			      unsigned int *chanlist, unsigned int n_chan)
 {
 	unsigned int chansegment[16];
-	unsigned int i, nowmustbechan, seglen, segpos;
+	unsigned int i, nowmustbechan, seglen;
 
 	/* correct channel and range number check itself comedi/range.c */
 	if (n_chan < 1) {
@@ -605,7 +605,7 @@ static int check_channel_list(struct comedi_device *dev,
 		}
 
 		/*  check whole chanlist */
-		for (i = 0, segpos = 0; i < n_chan; i++) {
+		for (i = 0; i < n_chan; i++) {
 			if (chanlist[i] != chansegment[i % seglen]) {
 				dev_dbg(dev->class_dev,
 					"bad channel or range number! chanlist[%i]=%d,%d,%d and not %d,%d,%d!\n",
-- 
2.17.1

