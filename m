Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C748C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 17:16:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD239217DF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 17:16:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GlHEVoUm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD239217DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727848AbeHUUhP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 16:37:15 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44162 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727648AbeHUUhK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 16:37:10 -0400
Received: by mail-wr1-f68.google.com with SMTP id v16-v6so2067958wro.11
        for <linux-kernel@vger.kernel.org>; Tue, 21 Aug 2018 10:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=uLICDI2rFMMf3k2VHyDMwBZj1pMGu4/oLPZdp4TFfIA=;
        b=GlHEVoUmAe0dPYk6wjbhp84hdd/HsVxnO4/CFGUzHdid4OtY52vg6pxUBzZpL2XlWS
         tiVqPyQzvKVi9HdWP9x0EkJ62337e7DxoTwSyC7Y04b8MzY4gpII1y3Kosk/R3o5TgMc
         LFHgvHQ9lz8U1L2CNQBfXm97GKQdqil+bN8a5HEE+4yc2FVqNDsaSdzNDgePv0RJyvQ0
         Ky2aJQRYTKK0GwYNfoOKuoaY6w2sdJcnd2hKEfkcyNIJatveMVVy6aOadx8Ae//Rm1fZ
         6y8VwnI9w9YhpvgT6UDQ6xUdkHeiy6YJAt0pBnCw97IqG3nt+nV9poc3lu5vrW97KL/4
         rLnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=uLICDI2rFMMf3k2VHyDMwBZj1pMGu4/oLPZdp4TFfIA=;
        b=c7NHNgilSaxohiAYzS/u0a3AKNRmCkl4VM5V60PxwQVlwWHBTjAqTjKtjpYYiouHT8
         oA/KF4CX6j+aV2YrN4CicHMSMiXW9KqbCmUm7pQi7mx1h5OUgKbQmnfkq4Sz8PlPqCcV
         7cPqSs6baEhel9t0wAc5EP0LbYGU2UInWNe8RCuOBx9Yln3nqLpOEzyqg8BLbWViiEjG
         juSKnFVgPcoYPi6eX2z/9wQjdGSOpGixBZi0sz/d+nO6OpXKW5jYm5MonJJZSvdvGvKj
         y0zHHcUwbR1HPU/fOu95nEO0wf9Xlae6M1Fr9OxxhOTSNWixLh1Fmsq3DlgazpJHIfhu
         dFhA==
X-Gm-Message-State: AOUpUlEmrYersCUG1UiESb/zK8iOkf5CGI6+Hjpj7Oh4SIIgQSxdPKnZ
        4zzznrUk/YDQXDIpAano7B+tHedoZhU=
X-Google-Smtp-Source: AA+uWPxH70veLtBsptMgYtKnUU5hDpNKrQYC+wN+AyenCJgyq3HP2McKvUlcgnAlHjVs67MdA70K3g==
X-Received: by 2002:adf:90e9:: with SMTP id i96-v6mr32867638wri.146.1534871768349;
        Tue, 21 Aug 2018 10:16:08 -0700 (PDT)
Received: from localhost.localdomain (host86-148-21-150.range86-148.btcentralplus.com. [86.148.21.150])
        by smtp.gmail.com with ESMTPSA id 88-v6sm7564292wrf.95.2018.08.21.10.16.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Aug 2018 10:16:07 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 17/17] staging:rtl8192u: Remove commented out code and indent - Style
Date:   Tue, 21 Aug 2018 18:15:37 +0100
Message-Id: <20180821171537.9330-18-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180821171537.9330-1-johnfwhitmore@gmail.com>
References: <20180821171537.9330-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove old commented out structure and clean up the indentation.

These are coding style changes which should have no impact on runtime
code execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 .../staging/rtl8192u/ieee80211/rtl819x_BA.h   | 47 ++++++++-----------
 1 file changed, 20 insertions(+), 27 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_BA.h b/drivers/staging/rtl8192u/ieee80211/rtl819x_BA.h
index 1a494ecf05ac..1a727856ba53 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_BA.h
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_BA.h
@@ -2,26 +2,19 @@
 #ifndef _BATYPE_H_
 #define _BATYPE_H_
 
-#define	BA_SETUP_TIMEOUT	200
+#define	BA_SETUP_TIMEOUT	       200
 
-#define	BA_POLICY_DELAYED		0
-#define	BA_POLICY_IMMEDIATE	1
+#define	BA_POLICY_DELAYED		 0
+#define	BA_POLICY_IMMEDIATE	         1
 
-#define	ADDBA_STATUS_SUCCESS			0
+#define	ADDBA_STATUS_SUCCESS		 0
 #define	ADDBA_STATUS_REFUSED		37
 #define	ADDBA_STATUS_INVALID_PARAM	38
 
-#define	DELBA_REASON_END_BA			37
-#define	DELBA_REASON_UNKNOWN_BA	38
-#define	DELBA_REASON_TIMEOUT			39
-/*  whether need define BA Action frames here?
-struct ieee80211_ADDBA_Req{
-	struct ieee80211_header_data header;
-	u8	category;
-	u8
-} __attribute__ ((packed));
-*/
-//Is this need?I put here just to make it easier to define structure BA_RECORD //WB
+#define	DELBA_REASON_END_BA		37
+#define	DELBA_REASON_UNKNOWN_BA	        38
+#define	DELBA_REASON_TIMEOUT		39
+
 union sequence_control {
 	u16 short_data;
 	struct {
@@ -33,28 +26,28 @@ union sequence_control {
 union ba_param_set {
 	u16 short_data;
 	struct {
-		u16 amsdu_support:1;
-		u16 ba_policy:1;
-		u16 tid:4;
-		u16 buffer_size:10;
+		u16	amsdu_support:1;
+		u16	ba_policy:1;
+		u16	tid:4;
+		u16	buffer_size:10;
 	} field;
 };
 
 union delba_param_set {
 	u16 short_data;
 	struct {
-		u16 reserved:11;
-		u16 initiator:1;
-		u16 tid:4;
+		u16	reserved:11;
+		u16	initiator:1;
+		u16	tid:4;
 	} field;
 };
 
 struct ba_record {
-	struct timer_list		timer;
-	u8				valid;
-	u8				dialog_token;
-	union ba_param_set		param_set;
-	u16				timeout_value;
+	struct timer_list	timer;
+	u8			valid;
+	u8			dialog_token;
+	union ba_param_set	param_set;
+	u16			timeout_value;
 	union sequence_control	start_seq_ctrl;
 };
 
-- 
2.18.0

