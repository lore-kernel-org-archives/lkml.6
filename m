Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8744C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 05:18:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADB8A21773
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 05:18:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GX1ajfFp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727788AbfBTFSb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 00:18:31 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:36872 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726746AbfBTFSP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 00:18:15 -0500
Received: by mail-it1-f193.google.com with SMTP id z124so12678650itc.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Feb 2019 21:18:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=y4yMs6hMqtvvahMCzASAJoZSo4lJex4Sz2Dn5yBReks=;
        b=GX1ajfFpPX3dsFo72S7pW/PMfXxzSgfIp9vu8dvVBCXLMw4UNg6NfUlBPfiAzR4bYW
         DFBpWdVe91cdXaohtmMZ6KwvpdHYlDGPF309YLcrIigvhr3zGa1ZnvXNuMYVAbJhPzdr
         ZbyuTHxMehoFFPcdlDc964ax2J7Vn4WAyYuEe4Je2fjWEctCq7TXYq5ZKYON6PQript7
         4eBhmeaGm8y8vK1FVbGZIqRXVWb9NiV3iSbD3oV6AIE8qa8DsDrvjUnOq4bkiICsR9R4
         RZ3eNeuR8+mLg2oz7kr4+zvZx+4QjECsK4jp3FVete795spMOHgittlO5BRim05UubTR
         unVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=y4yMs6hMqtvvahMCzASAJoZSo4lJex4Sz2Dn5yBReks=;
        b=h3ZfGJf8C3MsgP49eR2rUXJYlLd+LFC5DdNfqCqP4+C5FbPPIh+5tus4SzSidX7eOR
         UuMuMHVIKVrDwdIyLkhxcqxfiJLgsG7lLkOgArRfqWaigFIaADXSCCVSI8P3IUQgRZnQ
         JQWO7EKcnxJQnSm1/1r2m/VzZrm9KbcQdatWhbPJSazdSvdYOQHLooXM/N+RRrD/pwtW
         4INnFDxVrmqY9M7yoN0oKyfeaeK60T9jISMsxPER77/OgWP8TsBYq6tyDlTZBgj5CF6V
         zVl7WlpfJ6UWKcee/aJZHcte8q+6d/x4GZQVN5AtL+RgGIar7rhubrI8joHK0kaVkJGS
         wbdQ==
X-Gm-Message-State: AHQUAuZxtprWfhhK8EEDRzh/lSqd5Fke9IhBTw4iMWK2N61I1vAb1c3W
        lTAUU6eDkhWiQGrZJ2jZul0=
X-Google-Smtp-Source: AHgI3IaA/eXALcXlrFadhoc2xMBe+U8NbZad6dfUETL7d2miVtrzbDInERomUENJIKZqboT7SlCXpQ==
X-Received: by 2002:a24:6890:: with SMTP id v138mr4495624itb.53.1550639895043;
        Tue, 19 Feb 2019 21:18:15 -0800 (PST)
Received: from localhost.localdomain (c-73-242-244-99.hsd1.nm.comcast.net. [73.242.244.99])
        by smtp.gmail.com with ESMTPSA id k64sm2297550itb.7.2019.02.19.21.18.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Feb 2019 21:18:14 -0800 (PST)
From:   George Hilliard <thirtythreeforty@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     linux-kernel@vger.kernel.org, Neil Brown <neil@brown.name>,
        George Hilliard <thirtythreeforty@gmail.com>
Subject: [PATCH 08/10] staging: mt7621-mmc: Check for nonzero number of scatterlist entries
Date:   Tue, 19 Feb 2019 22:17:52 -0700
Message-Id: <20190220051754.12195-9-thirtythreeforty@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190220051754.12195-1-thirtythreeforty@gmail.com>
References: <20190220051754.12195-1-thirtythreeforty@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The buffer descriptor setup loop is correct only if it is setting up at
least one bd struct.  Besides, there is an error somewhere if
dma_map_sg() returns 0.  So add a paranoid check for this condition.

Signed-off-by: George Hilliard <thirtythreeforty@gmail.com>
---
 drivers/staging/mt7621-mmc/sd.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/mt7621-mmc/sd.c b/drivers/staging/mt7621-mmc/sd.c
index 942c0d63d710..736e1d23b391 100644
--- a/drivers/staging/mt7621-mmc/sd.c
+++ b/drivers/staging/mt7621-mmc/sd.c
@@ -594,7 +594,12 @@ static void msdc_dma_setup(struct msdc_host *host, struct msdc_dma *dma,
 	struct bd *bd;
 	u32 j;
 
-	BUG_ON(sglen > MAX_BD_NUM); /* not support currently */
+	// Shouldn't happen; we configure the mmc host layer
+	// based on MAX_BD_NUM:
+	BUG_ON(sglen > MAX_BD_NUM);
+	// Correct setup below requires at least one bd
+	// (and dma_map_sg should not return 0):
+	BUG_ON(sglen == 0);
 
 	gpd = dma->gpd;
 	bd  = dma->bd;
-- 
2.20.1

