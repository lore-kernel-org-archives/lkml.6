Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8ADFC3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 07:37:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83B21259CB
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 07:37:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83B21259CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933305AbeGBHhY (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 03:37:24 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:52166 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751420AbeGBHhX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 03:37:23 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1fZtOj-0002PC-L0; Mon, 02 Jul 2018 07:37:21 +0000
From:   Colin King <colin.king@canonical.com>
To:     Chas Williams <3chas3@gmail.com>,
        linux-atm-general@lists.sourceforge.net, netdev@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] atm: zatm: remove redundant pointer zatm_dev
Date:   Mon,  2 Jul 2018 08:37:21 +0100
Message-Id: <20180702073721.10272-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Pointer zatm_dev is being assigned but is never used hence it is redundant
and can be removed.

Cleans up clang warning:
warning: variable 'zatm_dev' set but not used [-Wunused-but-set-variable]

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/atm/zatm.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/atm/zatm.c b/drivers/atm/zatm.c
index 2c288d1f42bb..e89146ddede6 100644
--- a/drivers/atm/zatm.c
+++ b/drivers/atm/zatm.c
@@ -1385,14 +1385,12 @@ static void zatm_close(struct atm_vcc *vcc)
 
 static int zatm_open(struct atm_vcc *vcc)
 {
-	struct zatm_dev *zatm_dev;
 	struct zatm_vcc *zatm_vcc;
 	short vpi = vcc->vpi;
 	int vci = vcc->vci;
 	int error;
 
 	DPRINTK(">zatm_open\n");
-	zatm_dev = ZATM_DEV(vcc->dev);
 	if (!test_bit(ATM_VF_PARTIAL,&vcc->flags))
 		vcc->dev_data = NULL;
 	if (vci != ATM_VPI_UNSPEC && vpi != ATM_VCI_UNSPEC)
-- 
2.17.1

