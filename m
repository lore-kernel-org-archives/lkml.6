Return-Path: <SRS0=ZAeg=KF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8209AECDE5F
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 12:57:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32C2E20858
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 12:57:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mv9IJR6+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32C2E20858
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728254AbeGUNuT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Jul 2018 09:50:19 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:41566 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728137AbeGUNuS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jul 2018 09:50:18 -0400
Received: by mail-pg1-f195.google.com with SMTP id z8-v6so9020783pgu.8
        for <linux-kernel@vger.kernel.org>; Sat, 21 Jul 2018 05:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=EMNJOZEZ0arrq76rwhD4xAsOEZbOlCLN3fwdfDJ6izM=;
        b=mv9IJR6+PPfbbdefmWSPunAZ7Xo0WSfsbN58eAOFPQgYpx5hLs+qRZz2Td4wxxlsFt
         npopIsrWpHy+VtYr1N+Qwl0l3kHISebC2iM0772jVwjKCXQelXl26C3YL5Jq5M0f1rEL
         RleuUh6MMEJCyQAF8Yb/cbLBaZvsQUYxCELFWT9BEyhQV7V7T6MtHtgvfMK1PMZFla8v
         a8HgqL3iZgN31YGtlrIpZxXdYk4Bb7V3ykI61Z7aKCFblt/uhaeFegyLzbleqtxLlZxJ
         SLtJmODzypDn82au9bFNMW+VLHlGGBrxev2Tp2lCMruf4S89DrEtKejA7rFi3JiP/2JH
         FrCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=EMNJOZEZ0arrq76rwhD4xAsOEZbOlCLN3fwdfDJ6izM=;
        b=A3GwH+9PyJ65e9Qc1dMxBAQFQyCqKMTShxaO+U379UCwiFD/StQ33ltRmyKhLSOyho
         1jvxBxi61x0XpgPtFOcIlDoQTEhYlPGezm3ATW/Fu9Ipd9NufLd8t4K7x2RCpV5/R4j3
         GBqIss1qqvM7tX3rHMuq1jhd290xW8dFj/+3X0eOceTHc5uVnzjcBQqh/XYX5szhDa1u
         aOqflJntHnztf6Usdf+58YnI2XQIWdQrrMmqOQsZMj6lGpBxZz2V4ZrNvmgocNaHKrjj
         J+7sFkyIMpAAHVc7+VNVzQGLM+71LegjafqnR1BZ7JHoPDaaJ9FIh9Ra3dQVrNWv+gYp
         RkGA==
X-Gm-Message-State: AOUpUlF5RDNg6Dvf70kUq2UCsCe5nyqsrX2i1UoNrg8lCVQklOJu+M8W
        nSC8aLwbCdBmyzlBQTT18OY=
X-Google-Smtp-Source: AAOMgpfVArV7ttTdc1DJv/rN1AmWnv0Jg/reehd/nh+CQRt9hx+Nh55glhxEMm5/zf19F0bZoDmZ/A==
X-Received: by 2002:a63:115e:: with SMTP id 30-v6mr5598204pgr.53.1532177858752;
        Sat, 21 Jul 2018 05:57:38 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id d19-v6sm1072542pfe.42.2018.07.21.05.57.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 21 Jul 2018 05:57:38 -0700 (PDT)
From:   Todd Poynor <toddpoynor@gmail.com>
To:     Rob Springer <rspringer@google.com>,
        John Joseph <jnjoseph@google.com>,
        Ben Chan <benchan@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Zhongze Hu <frankhu@chromium.org>,
        Dmitry Torokhov <dtor@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Todd Poynor <toddpoynor@google.com>
Subject: [PATCH 03/20] staging: gasket: remove code for no physical device
Date:   Sat, 21 Jul 2018 05:56:45 -0700
Message-Id: <20180721125713.88501-7-toddpoynor@gmail.com>
X-Mailer: git-send-email 2.18.0.233.g985f88cf7e-goog
In-Reply-To: <20180721125713.88501-1-toddpoynor@gmail.com>
References: <20180721125713.88501-1-toddpoynor@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Todd Poynor <toddpoynor@google.com>

gasket_enable_dev code for enabling a gasket device with no physical PCI
device registered shouldn't be necessary.

Reported-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Todd Poynor <toddpoynor@google.com>
---
 drivers/staging/gasket/gasket_core.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/staging/gasket/gasket_core.c b/drivers/staging/gasket/gasket_core.c
index f327c9d7f90a3..18cc8e3283b39 100644
--- a/drivers/staging/gasket/gasket_core.c
+++ b/drivers/staging/gasket/gasket_core.c
@@ -898,7 +898,6 @@ static int gasket_enable_dev(
 {
 	int tbl_idx;
 	int ret;
-	struct device *ddev;
 	const struct gasket_driver_desc *driver_desc =
 		internal_desc->driver_desc;
 
@@ -919,21 +918,12 @@ static int gasket_enable_dev(
 	for (tbl_idx = 0; tbl_idx < driver_desc->num_page_tables; tbl_idx++) {
 		gasket_log_debug(
 			gasket_dev, "Initializing page table %d.", tbl_idx);
-		if (gasket_dev->pci_dev) {
-			ddev = &gasket_dev->pci_dev->dev;
-		} else {
-			gasket_log_error(
-				gasket_dev,
-				"%s with no physical device!!", __func__);
-			WARN_ON(1);
-			ddev = NULL;
-		}
 		ret = gasket_page_table_init(
 			&gasket_dev->page_table[tbl_idx],
 			&gasket_dev->bar_data[
 				driver_desc->page_table_bar_index],
 			&driver_desc->page_table_configs[tbl_idx],
-			ddev, gasket_dev->pci_dev, true);
+			&gasket_dev->pci_dev->dev, gasket_dev->pci_dev, true);
 		if (ret) {
 			gasket_log_error(
 				gasket_dev,
-- 
2.18.0.233.g985f88cf7e-goog

