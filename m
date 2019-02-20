Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 384A3C4360F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 02:24:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05457206BB
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 02:24:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729625AbfBTCYJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 21:24:09 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:44910 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726235AbfBTCYI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 21:24:08 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 6695CBF141CF32E60072;
        Wed, 20 Feb 2019 10:24:06 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.408.0; Wed, 20 Feb 2019
 10:23:14 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <peterhuewe@gmx.de>, <jarkko.sakkinen@linux.intel.com>,
        <jgg@ziepe.ca>, <arnd@arndb.de>, <gregkh@linuxfoundation.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH v2 -next] tpm: Fix the type of the return value in calc_tpm2_event_size()
Date:   Wed, 20 Feb 2019 10:23:00 +0800
Message-ID: <20190220022300.25888-1-yuehaibing@huawei.com>
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

Fixes: 4d23cc323cdb ("tpm: add securityfs support for TPM 2.0 firmware event log")
Suggested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
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


