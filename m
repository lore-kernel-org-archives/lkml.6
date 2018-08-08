Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE498C46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 14:50:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7387A21A12
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 14:50:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pv6eXifO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7387A21A12
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727653AbeHHRKg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 13:10:36 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:43704 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727146AbeHHRKg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 13:10:36 -0400
Received: by mail-pf1-f194.google.com with SMTP id j26-v6so1249097pfi.10;
        Wed, 08 Aug 2018 07:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=+fylNTi5bV/DGFZ7AukNnDfwVutWQ/BlHQxVLJ9/vF8=;
        b=Pv6eXifOUJCF9UnapaP1yC6KPsuC336mb9LDrxALwe/KWKQTyEjNVr/zZDpzsPR6SR
         XSOeH3y3bHZnfWP3H8tPKT5tTxdBY55uQXRVkHA79vrZwBwANglmQ4b04FJNNPYs2tnB
         SRc/yHvLmueq+/s0hjh/2HC4fuyAwoVPskJkaU84VzWcnMWu8zkUD9qx2QIi94Pp/Eky
         LtpfOfs62keZkcbOlRuqK1Df+S4dEpkpYAb3epRDPMeAOfyEEJF1M/lAEKnSf48j326b
         Up9LqpaliSf21u1n9c5rPlSYMcEG1G86yT15UhJHsE9ZqhXwwMhplX8BDxhaMtruAksk
         5njQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=+fylNTi5bV/DGFZ7AukNnDfwVutWQ/BlHQxVLJ9/vF8=;
        b=a3ZbDgj5yE4of7RkxN+5YcL7579pxMxM/HWvF+5x4I+53TxBtSoKX10iVfKkySGSXq
         DWNExIsZPN45eI8K5chbguJ8j/8vmaOmYHMwacB+wKhCMlJ0DSzqGJBmjUTSDSQh1zir
         +thg/7VO0bFpc//m7SkgYNm09U4p7jQ7PG+YHD3byWdPNUk58oxQB1yINfNHVqJjlUIH
         BDrLUnYNpGDp9MsS+racG9k9S872UQOze/DdNlPb2ft0p4Y638WBLnnn6L3V23vN763y
         WUP1yJGiwSlal2jihHOwaEcZD6OWVCUhBPV0ZFvFZ4o1WYPTGTcn6ocbqO5TgO6DxDWr
         7UrQ==
X-Gm-Message-State: AOUpUlEEgHOW0746LvAUGzD/w9dGiHqlkWNZtv+2sLequ4cXJjzas54L
        y1VatCwCiq5P9wnmUEinKg0=
X-Google-Smtp-Source: AA+uWPzP43ejApH+edsVrevG4j+Vk8P3cUZx3h9Q6zcnhvswzCeZwqI9Nx+4Fk3x0ndq9g9pfgEQnw==
X-Received: by 2002:a62:c4c3:: with SMTP id h64-v6mr3285220pfk.39.1533739835634;
        Wed, 08 Aug 2018 07:50:35 -0700 (PDT)
Received: from 192.168.190.131 ([45.62.52.60])
        by smtp.gmail.com with ESMTPSA id x2-v6sm8220854pfi.166.2018.08.08.07.50.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Aug 2018 07:50:35 -0700 (PDT)
From:   Ocean He <oceanhehy@gmail.com>
To:     dan.j.williams@intel.com, ross.zwisler@linux.intel.com,
        vishal.l.verma@intel.com, dave.jiang@intel.com, rjw@rjwysocki.net,
        lenb@kernel.org
Cc:     linux-nvdimm@lists.01.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ocean He <hehy1@lenovo.com>
Subject: [PATCH] ACPI: nfit: check dcr immediately following its assignment codes
Date:   Wed,  8 Aug 2018 10:50:21 -0400
Message-Id: <1533739821-9864-1-git-send-email-oceanhehy@gmail.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ocean He <hehy1@lenovo.com>

In commit 6697b2cf69d43632 ("nfit: fix multi-interface dimm handling,
acpi6.1 compatibility"), the check codes of dcr were just following its
assignment codes. But they were separated by commit ad9ac5e1957531a8
("nfit: always associate flush hints").

Just change the check codes back to original position, without function
change.

Signed-off-by: Ocean He <hehy1@lenovo.com>
---
 drivers/acpi/nfit/core.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
index 7c47900..c9e4c9a 100644
--- a/drivers/acpi/nfit/core.c
+++ b/drivers/acpi/nfit/core.c
@@ -1078,6 +1078,12 @@ static int __nfit_mem_init(struct acpi_nfit_desc *acpi_desc,
 			break;
 		}
 
+		if (dcr && !nfit_mem->dcr) {
+			dev_err(acpi_desc->dev, "SPA %d missing DCR %d\n",
+					spa->range_index, dcr);
+			return -ENODEV;
+		}
+
 		list_for_each_entry(nfit_flush, &acpi_desc->flushes, list) {
 			struct acpi_nfit_flush_address *flush;
 			u16 i;
@@ -1101,12 +1107,6 @@ static int __nfit_mem_init(struct acpi_nfit_desc *acpi_desc,
 			break;
 		}
 
-		if (dcr && !nfit_mem->dcr) {
-			dev_err(acpi_desc->dev, "SPA %d missing DCR %d\n",
-					spa->range_index, dcr);
-			return -ENODEV;
-		}
-
 		if (type == NFIT_SPA_DCR) {
 			struct nfit_idt *nfit_idt;
 			u16 idt_idx;
-- 
1.8.3.1

