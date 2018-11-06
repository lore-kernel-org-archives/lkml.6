Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A1FDC32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 13:47:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9C2E2083D
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 13:47:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LpqQZGpQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9C2E2083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388368AbeKFXM2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 18:12:28 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:36800 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388048AbeKFXM1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 18:12:27 -0500
Received: by mail-pg1-f195.google.com with SMTP id z17-v6so5848687pgv.3
        for <linux-kernel@vger.kernel.org>; Tue, 06 Nov 2018 05:47:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=pTESJ2/S8dzaTzkVSOvuQhE3I6U09WoCR1Pwcr4kIPA=;
        b=LpqQZGpQW3f/IF+D90SKDGQ3EhLUDrw1Ne1ftHNFYyV1XylcGmyId25zw36Jr/wl25
         7DDplKLzwptMTqCEondnZomyxMf8x8evaYa8pPna1QuwZRfTJPYiFScTcOrh2Jf3aITZ
         FNmPKM/r8d2n0Dgasg43agww5YdiLNea523whBV39NfjDqvT1jXxtbeb2V3b1Q0wkNp7
         5NVAWPmUM8YsxF46+sxfreFiJPkWmadOe0lV6FLrA1LgQC/2XFD2RKgdGkpXGdWERcew
         7pDSnp1eVJVckzutvoBeq4CiD9o3s2wmWj7Ozbq7k+zMONF6hOfXA8drE0lspw4HMXFj
         uBSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=pTESJ2/S8dzaTzkVSOvuQhE3I6U09WoCR1Pwcr4kIPA=;
        b=GfJN5FcIiAMc//sMYw/PU/0Pal6QTGtlRDqn8qCyW7X5y0kESrhyKzXhl8qZmc0PSW
         vpdleUf0MuqA7swW6Ju2TNU62YpyXiw65hMN/PvyOYVZouA1mUZy84ywQTxs3uJEyPmK
         Nd3W0uHB0A2dL7ZjQ3rncjTGVNE/LypVnnvCRSTYF2FN+w+LzXm4ujJ3XeSzFN+fhTy7
         DNDTAmrFFc+EIbbg/8bHsJtCT8ZNkGG3KsvqbHgWUW9lwf0z6PwUaYdJLgO5/pRyUY51
         pqSHFl/Z/q1K1KyNFNc/rzrcelEnfLECltu06KF/9Izm2yzXm5Xjxd208YD5rGgNh4vN
         73nw==
X-Gm-Message-State: AGRZ1gLRccS+KGHPDhuLMBJ1t/OgPqpG+hhYlYNstd+BeVmg+BVCCd4c
        vXJSNtEOpnGuV5/VMFVGG5o=
X-Google-Smtp-Source: AJdET5f+i6U92Zjx0c3APqwq3pqXAZHGY4nQWOk16ofbd2NRkXHLUXsZcoQKamtL1qM+W3SjaqS2Cw==
X-Received: by 2002:aa7:8498:: with SMTP id u24-v6mr26236256pfn.220.1541512028637;
        Tue, 06 Nov 2018 05:47:08 -0800 (PST)
Received: from localhost.localdomain ([104.238.150.158])
        by smtp.gmail.com with ESMTPSA id h62-v6sm70127432pfa.146.2018.11.06.05.47.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Nov 2018 05:47:07 -0800 (PST)
From:   Muchun Song <smuchun@gmail.com>
To:     gregkh@linuxfoundation.org, rafael@kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] driver core: Add branch prediction hints in really_probe()
Date:   Tue,  6 Nov 2018 21:46:30 +0800
Message-Id: <20181106134630.29591-1-smuchun@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If condition is false in most cases. So, add an unlikely() to the if
condition, so that the optimizer assumes that the condition is false.

Signed-off-by: Muchun Song <smuchun@gmail.com>
---
 drivers/base/dd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index 169412ee4ae8..8eba453c4e5d 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -450,7 +450,7 @@ static int really_probe(struct device *dev, struct device_driver *drv)
 	bool test_remove = IS_ENABLED(CONFIG_DEBUG_TEST_DRIVER_REMOVE) &&
 			   !drv->suppress_bind_attrs;
 
-	if (defer_all_probes) {
+	if (unlikely(defer_all_probes)) {
 		/*
 		 * Value of defer_all_probes can be set only by
 		 * device_defer_all_probes_enable() which, in turn, will call
@@ -508,7 +508,7 @@ static int really_probe(struct device *dev, struct device_driver *drv)
 			goto probe_failed;
 	}
 
-	if (test_remove) {
+	if (unlikely(test_remove)) {
 		test_remove = false;
 
 		if (dev->bus->remove)
-- 
2.17.1

