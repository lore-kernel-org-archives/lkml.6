Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18380C28CF8
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 05:00:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4D6020881
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 05:00:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZgxP6snW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4D6020881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726843AbeJOMnf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 08:43:35 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:33256 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726347AbeJOMne (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 08:43:34 -0400
Received: by mail-pf1-f194.google.com with SMTP id 78-v6so6653745pfq.0
        for <linux-kernel@vger.kernel.org>; Sun, 14 Oct 2018 22:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yqZJQRsyqis2L0+DfEqpqLoPzDXUAn1De5UR7iF3DeE=;
        b=ZgxP6snWJh3xE8YL3xxwGIf29Z7yiWE0SgaLECQyU4PTIzhDKarqwwywV3LK1tE2YI
         SxgcF/ZH25FBEgJpssoCLTBujUwQYVbuQABhd2i1ZCYFMdOOSg85lzSPCVJPgn2Jet5a
         4WWhrGlIQHkFqKwpevgIo7813UrhISM0vXC1dcnEjuOROjquofyek/ek4kg/b9wkFlLW
         BTX8NNBtI+znTVlRRlr4/cSQLyQ2CxU5E3kWtnnUA5G0dzyRtUpWDeuKAjn91mFGwpFy
         JkllwJYo/aoIEZTsjvlpinVLTHi4oI9DC2OurYLDQI+10drHq9HOlSsRczGC2WouWBCp
         oI/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yqZJQRsyqis2L0+DfEqpqLoPzDXUAn1De5UR7iF3DeE=;
        b=AZSghOkfa1s/rciGYP8PiGKHMvCbBfMaDhjlxcio1jEe2WSWvpUqVcaaz/iyo3ocWJ
         bHfA8k0jh/ognfJzcwnoovzAm+Fx8uVA/fS2TTqOotG2RV29CV79iaB5RCmD8IhueUxk
         EdhQmyUWXUFObT1X6nJc4R9HZ5ahKENmhzQ7SreQFQ3hPpL4Pfx6VZXj4xWkboZiWm8+
         LsS33O+yXLw1gq7UKOLHA2ZrhKhDeGOwtcx6nckG2E5wFUNvOW0L5hmwZLPJnM2ujlxf
         e68ARjDfzFAFphrZvPZa18xe0SPuP4P1LpzS8Y5gmj2muucjTQhdMu9UruThChyF+Iyu
         kMiQ==
X-Gm-Message-State: ABuFfoge6iZYiRrgsWL/L3O8uChz5OSQcnhKoRQRXk4PC/b3dcpJOKk7
        fTfJtMnN3XI9MO2OfmSoVYI=
X-Google-Smtp-Source: ACcGV63gDztoxmg7IIKIiVgmrdzO96ujs8I6H2p4KDC/YzVt+excc2KcYVtSk/snfSoILQL1RnM5WQ==
X-Received: by 2002:a62:5103:: with SMTP id f3-v6mr16018089pfb.107.1539579600641;
        Sun, 14 Oct 2018 22:00:00 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id p62-v6sm12244698pfp.111.2018.10.14.21.59.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 14 Oct 2018 22:00:00 -0700 (PDT)
From:   Todd Poynor <toddpoynor@gmail.com>
To:     Rob Springer <rspringer@google.com>,
        Ben Chan <benchan@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Nick Ewalt <nicholasewalt@google.com>,
        Todd Poynor <toddpoynor@google.com>
Subject: [PATCH 06/11] staging: gasket: page table: fixup error path allocating coherent mem
Date:   Sun, 14 Oct 2018 21:59:22 -0700
Message-Id: <20181015045927.156790-7-toddpoynor@gmail.com>
X-Mailer: git-send-email 2.19.0.605.g01d371f741-goog
In-Reply-To: <20181015045927.156790-1-toddpoynor@gmail.com>
References: <20181015045927.156790-1-toddpoynor@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nick Ewalt <nicholasewalt@google.com>

Correctly clean up data structure state in gasket_alloc_coherent_memory
error path, to ensure no double free on the stale pointer value.

Signed-off-by: Nick Ewalt <nicholasewalt@google.com>
Signed-off-by: Todd Poynor <toddpoynor@google.com>
---
 drivers/staging/gasket/gasket_page_table.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/gasket/gasket_page_table.c b/drivers/staging/gasket/gasket_page_table.c
index 9c2f8671216b5..a88f2ae0cee8b 100644
--- a/drivers/staging/gasket/gasket_page_table.c
+++ b/drivers/staging/gasket/gasket_page_table.c
@@ -1332,9 +1332,13 @@ int gasket_alloc_coherent_memory(struct gasket_dev *gasket_dev, u64 size,
 	return 0;
 
 nomem:
-	if (mem)
+	if (mem) {
 		dma_free_coherent(gasket_get_device(gasket_dev),
 				  num_pages * PAGE_SIZE, mem, handle);
+		gasket_dev->coherent_buffer.length_bytes = 0;
+		gasket_dev->coherent_buffer.virt_base = NULL;
+		gasket_dev->coherent_buffer.phys_base = 0;
+	}
 
 	kfree(gasket_dev->page_table[index]->coherent_pages);
 	gasket_dev->page_table[index]->coherent_pages = NULL;
-- 
2.19.0.605.g01d371f741-goog

