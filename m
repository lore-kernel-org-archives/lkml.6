Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FBABC4360F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 08:26:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EFA4208E4
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 08:26:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726295AbfBTI0F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 03:26:05 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:4231 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725813AbfBTI0E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 03:26:04 -0500
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id D2EAC34512E3DE65C2D5;
        Wed, 20 Feb 2019 16:25:55 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.408.0; Wed, 20 Feb 2019
 16:25:45 +0800
From:   Yue Haibing <yuehaibing@huawei.com>
To:     <peterhuewe@gmx.de>, <jarkko.sakkinen@linux.intel.com>,
        <jgg@ziepe.ca>, <arnd@arndb.de>, <gregkh@linuxfoundation.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        Yue Haibing <yuehaibing@huawei.com>, <stable@vger.kernel.org>
Subject: [PATCH v3 -next] tpm: Fix the type of the return value in calc_tpm2_event_size()
Date:   Wed, 20 Feb 2019 16:25:38 +0800
Message-ID: <20190220082538.26260-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

calc_tpm2_event_size() has an invalid signature because
it returns a 'size_t' where as its signature says that
it returns 'int'.

Cc: <stable@vger.kernel.org>
Fixes: 4d23cc323cdb ("tpm: add securityfs support for TPM 2.0 firmware event log")
Suggested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
---
v3: fix My real name and cc stable
v2: modify patch title and commit message as Jarkko suggested
---
 drivers/char/tpm/eventlog/tpm2.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/char/tpm/eventlog/tpm2.c b/drivers/char/tpm/eventlog/tpm2.c
index d8b7713..f824563 100644
--- a/drivers/char/tpm/eventlog/tpm2.c
+++ b/drivers/char/tpm/eventlog/tpm2.c
@@ -37,8 +37,8 @@
  *
  * Returns size of the event. If it is an invalid event, returns 0.
  */
-static int calc_tpm2_event_size(struct tcg_pcr_event2_head *event,
-				struct tcg_pcr_event *event_header)
+static size_t calc_tpm2_event_size(struct tcg_pcr_event2_head *event,
+				   struct tcg_pcr_event *event_header)
 {
 	struct tcg_efi_specid_event_head *efispecid;
 	struct tcg_event_field *event_field;
-- 
2.7.0


