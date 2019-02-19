Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B05E0C4360F
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 07:26:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83AF821903
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 07:26:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725801AbfBSH04 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 02:26:56 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:59500 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725536AbfBSH0z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 02:26:55 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 6B2DD7952850CDFFBC6C;
        Tue, 19 Feb 2019 15:26:51 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.408.0; Tue, 19 Feb 2019
 15:26:41 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <peterhuewe@gmx.de>, <jarkko.sakkinen@linux.intel.com>,
        <jgg@ziepe.ca>, <arnd@arndb.de>, <gregkh@linuxfoundation.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-integrity@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] tpm: change the return type of calc_tpm2_event_size to size_t
Date:   Tue, 19 Feb 2019 15:26:18 +0800
Message-ID: <20190219072618.23048-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

calc_tpm2_event_size return size of the event which type is
size_t, If it is an invalid event, returns 0. And all the
caller use a size_t variable to check the return value, so
no need to convert to the return value type to int.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
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


