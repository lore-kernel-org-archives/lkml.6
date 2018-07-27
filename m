Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 196AFECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 03:08:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C105520891
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 03:08:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LVX9f7ai"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C105520891
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729575AbeG0E14 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 00:27:56 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:46173 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729487AbeG0E1z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 00:27:55 -0400
Received: by mail-pg1-f195.google.com with SMTP id p23-v6so2345127pgv.13
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jul 2018 20:08:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bA5E+7oxB5/I9RZmISekzIBuNv3hX8/DEB6zrTy53Mg=;
        b=LVX9f7aiYYAb7PvTyKsT8BOI3MjC6dFb5pUN9Zw7lJPQag0YIBCT4b1pHt992rn/7U
         ZtbmNEkJ6CY9x2/dbME1/NQtRWA+utfa73SgxRI2pSpYGpYtwrk9ef9Fznf2HmgvTObI
         CWjnw0lcLVA7V5PZ0v8Ub+MANE7yf6XkeL9M6e6Yr4dRY53T1cz383u0+a1lWnpUjP4t
         Y1+EZ55l+NUkcDAK1g7oAdPLvkV/MdySSrqNWsv0Ci6LNCVAfVRVrsBzJL+5PzFk49/r
         4uVc7dqritpQpEhplFnBfGi+TbidX3ygy2GIUp3k4ngti1DGa4/Ee5RFcetjqSQU8vou
         yOvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bA5E+7oxB5/I9RZmISekzIBuNv3hX8/DEB6zrTy53Mg=;
        b=XUasSHGWB8AerafkJdqNmivpB2/paaK8wUXlKzqXMtH9PbvSEpUomRBHBpX1NCHcFe
         E4yyfe1wqJna05UZ0BLDcMAw3RBWVHVsfo13xdX5QNBIRGxvPB5D0YRnN2pBR/RU4Ub0
         0JeD/hWczW00xZzoGeERyTbesLRFrIAOqD7zrElIYBLh6AKbZrTk+gY/EmB1Fh/PHLt3
         YDe9WSiz59hYGZFbXniiUkjy2a9RRMvdG35gR8BhAngia33o/a5PE6iMuskywFw+2zdK
         TPSyP+SCR+kYxcQOuuhJ8PDDWLpIUKSnDtlWfV/hh/+8gpuycygMupPpUK7qHYzn2FT6
         pC4Q==
X-Gm-Message-State: AOUpUlG4cW33cwVaiF/gdp9jSmPoiYzZpKmmbgMDsxFngYzC3EROjPsQ
        ABV0Tff9F2WtHfifnFl3e8w=
X-Google-Smtp-Source: AAOMgpdIlBLUBVgqLb1jH93KAvXP7nIRb1oSQexqsCg42EpmZlwUQtG9gRqLEnzrsvjnduGlCoMung==
X-Received: by 2002:a63:1d22:: with SMTP id d34-v6mr4316139pgd.133.1532660892645;
        Thu, 26 Jul 2018 20:08:12 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id e126-v6sm6418544pfg.31.2018.07.26.20.08.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Jul 2018 20:08:11 -0700 (PDT)
From:   Todd Poynor <toddpoynor@gmail.com>
To:     Rob Springer <rspringer@google.com>,
        John Joseph <jnjoseph@google.com>,
        Ben Chan <benchan@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Todd Poynor <toddpoynor@google.com>
Subject: [PATCH 10/10] staging: gasket: don't print device addresses as kernel pointers
Date:   Thu, 26 Jul 2018 20:07:37 -0700
Message-Id: <20180727030737.231268-11-toddpoynor@gmail.com>
X-Mailer: git-send-email 2.18.0.345.g5c9ce644c3-goog
In-Reply-To: <20180727030737.231268-1-toddpoynor@gmail.com>
References: <20180727030737.231268-1-toddpoynor@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Todd Poynor <toddpoynor@google.com>

Print device addresses as unsigned long, not as kernel pointers.

Signed-off-by: Todd Poynor <toddpoynor@google.com>
---
 drivers/staging/gasket/gasket_page_table.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/gasket/gasket_page_table.c b/drivers/staging/gasket/gasket_page_table.c
index 8ea8ea1c5174c..32f1c1e10c7e2 100644
--- a/drivers/staging/gasket/gasket_page_table.c
+++ b/drivers/staging/gasket/gasket_page_table.c
@@ -1333,8 +1333,8 @@ static bool gasket_is_extended_dev_addr_bad(
 	/* check if the device address is out of bound */
 	addr = dev_addr & ~((pg_tbl)->extended_flag);
 	if (addr >> (GASKET_EXTENDED_LVL0_WIDTH + GASKET_EXTENDED_LVL0_SHIFT)) {
-		dev_err(pg_tbl->device, "device address out of bound, 0x%p\n",
-			(void *)dev_addr);
+		dev_err(pg_tbl->device, "device address out of bounds: 0x%lx\n",
+			dev_addr);
 		return true;
 	}
 
@@ -1351,8 +1351,8 @@ static bool gasket_is_extended_dev_addr_bad(
 
 	if (gasket_components_to_dev_address(
 		pg_tbl, 0, page_global_idx, page_offset) != dev_addr) {
-		dev_err(pg_tbl->device, "address is invalid, 0x%p\n",
-			(void *)dev_addr);
+		dev_err(pg_tbl->device, "address is invalid: 0x%lx\n",
+			dev_addr);
 		return true;
 	}
 
-- 
2.18.0.345.g5c9ce644c3-goog

