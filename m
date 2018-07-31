Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29361C46462
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 21:00:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D298820841
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 21:00:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aLJ5e7fa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D298820841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732348AbeGaWmo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 18:42:44 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:38408 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732154AbeGaWmn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 18:42:43 -0400
Received: by mail-ed1-f67.google.com with SMTP id t2-v6so5861893edr.5
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jul 2018 14:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+qIkgy5uwfjQTihjreDNZObGJuRrZI1HX+DKRsygATo=;
        b=aLJ5e7fay6Z5SikwnZjVMu9XO+EarTEC8IT+oYUtE4LzC65s4bjzMAufZO7KJhXqiy
         QzqaKXhFZRpqcAPKO1IVnAxOmXvkeUQeLFyx50wfwo6Do6OYjpd452Cf4Mosl26IpXz/
         vnetsPQwKi2+RdM06vRtsXdGE9IBwPwzE1i94FhLJ5xnay6J8nCYrV5DX4bocJxyhNQU
         wfcAkOitFMP1+pGetbYTYF5p7bUl5wGSwkIWiPBJ/bBczNp4z+8HVYe/ejh/od2BTOkq
         79TuXL4gTryTUzy5uaH1tzmM7IxQOQdquNOD9uxX8NMHs9A7cNIV8WJdX561Fgdu/9zQ
         xArA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+qIkgy5uwfjQTihjreDNZObGJuRrZI1HX+DKRsygATo=;
        b=sH6/7Ys8sXJnjEt6epPatfT6bxa6UR6n0vDRMhG3XO/V0XLA4pvhK//2/5QYxzIOjv
         51Ibz/qlIm2iupQT55VKoxrnqDJn2CW9v95AJUwZwKqNk3yc03w1CZUVfv36sJkWZZwR
         dq49sTLEmk0ZQh6nP2QE5Co+e+Xl7ROf24MBj8G7AfgZ3BxFLVJJ+Qc3X6sE7ilmW2dQ
         vDnlnfeZeVDhILahsqmRESxv0Bggjnv22hOR7L0aacORqHa/D1bH8LD7BfGrhSiO1JsB
         Oq+c1bwqFoAqR6XyIL4cO2bN5KfqEvh8gaRgJghMre1Vk7fnqq2yS6e7cNHdNgpGM1cA
         /KfA==
X-Gm-Message-State: AOUpUlGxZtMlRilOjugMB3nVisMDXBRFfKy8L2a4QQ64xmV68rr+13yB
        mvBA+ZJGQQ7P7zSucNKOT9gcah1T
X-Google-Smtp-Source: AAOMgpe5NEfY4Nqf7h30prjMc9yVqaWEiJoLRRM1F+D9j1LPCyUQznhV9oYz4klXaAMOBcd+kEa/vA==
X-Received: by 2002:a50:b399:: with SMTP id s25-v6mr1114820edd.217.1533070831620;
        Tue, 31 Jul 2018 14:00:31 -0700 (PDT)
Received: from localhost.localdomain ([109.77.253.253])
        by smtp.gmail.com with ESMTPSA id j42-v6sm4143373eda.2.2018.07.31.14.00.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 31 Jul 2018 14:00:30 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 02/14] staging:rtl8192u: Remove union from aci_aifsn - Style
Date:   Tue, 31 Jul 2018 21:59:53 +0100
Message-Id: <20180731210005.17452-3-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180731210005.17452-1-johnfwhitmore@gmail.com>
References: <20180731210005.17452-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The union aci_aifsn is not used as a union, but only as a struct.
The union seems to have been used to ensure that the size of the
structure was only a single byte. That size is set by the bitfield
structure, adding a union with an unused byte adds nothing.

The union has been removed. This is a coding style change and
should not impact runtime code execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 .../staging/rtl8192u/ieee80211/rtl819x_Qos.h  | 23 ++++++++-----------
 drivers/staging/rtl8192u/r8192U_dm.c          |  4 ++--
 2 files changed, 12 insertions(+), 15 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_Qos.h b/drivers/staging/rtl8192u/ieee80211/rtl819x_Qos.h
index 810d81addcf6..1f16d1692c03 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_Qos.h
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_Qos.h
@@ -2,19 +2,16 @@
 #ifndef __INC_QOS_TYPE_H
 #define __INC_QOS_TYPE_H
 
-//
-// ACI/AIFSN Field.
-// Ref: WMM spec 2.2.2: WME Parameter Element, p.12.
-//
-union aci_aifsn {
-	u8	char_data;
-
-	struct {
-		u8	aifsn:4;
-		u8	acm:1;
-		u8	aci:2;
-		u8	reserved:1;
-	} f;	// Field
+/*
+ * ACI/AIFSN Field.
+ * Ref: WMM spec 2.2.2: WME Parameter Element, p.12.
+ * Note: 1 Byte Length
+ */
+struct aci_aifsn {
+	u8	aifsn:4;
+	u8	acm:1;
+	u8	aci:2;
+	u8:1;
 };
 
 //
diff --git a/drivers/staging/rtl8192u/r8192U_dm.c b/drivers/staging/rtl8192u/r8192U_dm.c
index 92ba1fdd9831..0ba1b1e2bc6e 100644
--- a/drivers/staging/rtl8192u/r8192U_dm.c
+++ b/drivers/staging/rtl8192u/r8192U_dm.c
@@ -2242,12 +2242,12 @@ static void dm_check_edca_turbo(
 			{
 				/*  TODO:  Modified this part and try to set acm control in only 1 IO processing!! */
 
-				union aci_aifsn *pAciAifsn = (union aci_aifsn *)&(qos_parameters->aifs[0]);
+				struct aci_aifsn *pAciAifsn = (struct aci_aifsn *)&(qos_parameters->aifs[0]);
 				u8		AcmCtrl;
 
 				read_nic_byte(dev, AcmHwCtrl, &AcmCtrl);
 
-				if (pAciAifsn->f.acm) { /*  acm bit is 1. */
+				if (pAciAifsn->acm) { /*  acm bit is 1. */
 					AcmCtrl |= AcmHw_BeqEn;
 				} else {	/* ACM bit is 0. */
 					AcmCtrl &= (~AcmHw_BeqEn);
-- 
2.18.0

