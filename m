Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14757C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 06:44:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D42D72080F
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 06:44:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ybWJeU6M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726812AbfBUGoQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 01:44:16 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:38960 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725978AbfBUGoN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 01:44:13 -0500
Received: by mail-pl1-f194.google.com with SMTP id 101so13660263pld.6
        for <linux-kernel@vger.kernel.org>; Wed, 20 Feb 2019 22:44:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=QetkU8HkeLHZ7CDP8UqLFrIsq3JOZpxLPjU3HCJfceo=;
        b=ybWJeU6Mu2zhZx5fivSPY6ji/N+2+BKh+V0cdC41h+EDcyPkv5PNd1OgarL1qnrctK
         z8jx/Kz7FrTP4qFDcBzxqWN92wKJTbzRLBfmfvfk5RQ644Tv/GVhSRH2jvYKwFSenNPk
         VAjURrSghxrrGowOJEKsBOXa/vPRtn/aVG5lp7tXmqXZ/fX2RUqlbtIO2sJMvuIGjwjN
         6fp+0SkVZ/jM/Tzjdxwz/EqCvqf9OJ5fOyARmbFt4BD36TQgsAn4LS+VzhPs9j6A6aCX
         7XYkZO9z9ai1OxGyiOCb9dk9ejziGnTuqJZVa6kAnvAOE2EvuqTlnn7XSwHbdcWcJ539
         XNGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=QetkU8HkeLHZ7CDP8UqLFrIsq3JOZpxLPjU3HCJfceo=;
        b=AQ8fm+iOwBCwL7NISNmOWxCAQcRBUjV0wfST/NQGV86WHv0ah/f4uP0IX+dc7znIlM
         mJxVXZ/umKRuuPX5UrSlg29jwSoEwfj90JUOR3agAAETCQGBwabqSOgOpiXjl/fdOp6E
         9A+oAxk5EMmnbVxU1g+j+OnjxY9H048Szv4Q4mtKuGLVqFuLjPxWBia40Velq1bnHH4z
         FpkcMBZfpliZlc1wknaLurA55U/AFBNyyAxxj1S1QezwcbCQkTJ+eI1F0RzdJggkF03x
         gV+WRZsAqrdbcMbqZRB+QYfsvY4vlyrgaJ29Yl8j0s8aoh68Uc/FGR2xxgseqio3T1Rr
         bIIA==
X-Gm-Message-State: AHQUAub8fFfmflauasVyGcRs2ilRJULrPRof1zyEuqSnIz+YRBASzVto
        k/ao2xj80bm/iwqQ5IWvZJtQGA==
X-Google-Smtp-Source: AHgI3IZMhNG6aQm6Q74VYB/dIGK03U4rwVLSw9isjhdaxkDsHk6U8huaLgAKVvAGoA7v2dCCbxmRjA==
X-Received: by 2002:a17:902:8348:: with SMTP id z8mr19400212pln.151.1550731453196;
        Wed, 20 Feb 2019 22:44:13 -0800 (PST)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id b4sm22777892pgq.57.2019.02.20.22.44.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Feb 2019 22:44:12 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] soc: qcom: rpmpd: Modify corner defining macros
Date:   Wed, 20 Feb 2019 22:44:32 -0800
Message-Id: <20190221064434.2760-2-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190221064434.2760-1-bjorn.andersson@linaro.org>
References: <20190221064434.2760-1-bjorn.andersson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QCS404 uses individual resource type magic for each power-domain, so
adjust the macros slightly to make them reusable for this.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/soc/qcom/rpmpd.c | 34 ++++++++++++++--------------------
 1 file changed, 14 insertions(+), 20 deletions(-)

diff --git a/drivers/soc/qcom/rpmpd.c b/drivers/soc/qcom/rpmpd.c
index 005326050c23..74b2f001b9c6 100644
--- a/drivers/soc/qcom/rpmpd.c
+++ b/drivers/soc/qcom/rpmpd.c
@@ -17,8 +17,8 @@
 #define domain_to_rpmpd(domain) container_of(domain, struct rpmpd, pd)
 
 /* Resource types */
-#define RPMPD_SMPA 0x61706d73
-#define RPMPD_LDOA 0x616f646c
+#define RPMPD_SMPA 0x61706d73 /* smpa */
+#define RPMPD_LDOA 0x616f646c /* ldoa */
 
 /* Operation Keys */
 #define KEY_CORNER		0x6e726f63 /* corn */
@@ -27,12 +27,12 @@
 
 #define MAX_RPMPD_STATE		6
 
-#define DEFINE_RPMPD_CORNER_SMPA(_platform, _name, _active, r_id)		\
+#define DEFINE_RPMPD_CORNER_PAIR(_platform, _name, _active, r_type, r_id) \
 	static struct rpmpd _platform##_##_active;			\
 	static struct rpmpd _platform##_##_name = {			\
 		.pd = {	.name = #_name,	},				\
 		.peer = &_platform##_##_active,				\
-		.res_type = RPMPD_SMPA,					\
+		.res_type = RPMPD_##r_type,				\
 		.res_id = r_id,						\
 		.key = KEY_CORNER,					\
 	};								\
@@ -40,33 +40,27 @@
 		.pd = { .name = #_active, },				\
 		.peer = &_platform##_##_name,				\
 		.active_only = true,					\
-		.res_type = RPMPD_SMPA,					\
+		.res_type = RPMPD_##r_type,				\
 		.res_id = r_id,						\
 		.key = KEY_CORNER,					\
 	}
 
-#define DEFINE_RPMPD_CORNER_LDOA(_platform, _name, r_id)			\
+#define DEFINE_RPMPD_CORNER(_platform, _name, r_type, r_id)		\
 	static struct rpmpd _platform##_##_name = {			\
 		.pd = { .name = #_name, },				\
-		.res_type = RPMPD_LDOA,					\
+		.res_type = RPMPD_##r_type,				\
 		.res_id = r_id,						\
 		.key = KEY_CORNER,					\
 	}
 
-#define DEFINE_RPMPD_VFC(_platform, _name, r_id, r_type)		\
+#define DEFINE_RPMPD_VFC(_platform, _name, r_type, r_id)		\
 	static struct rpmpd _platform##_##_name = {			\
 		.pd = { .name = #_name, },				\
-		.res_type = r_type,					\
+		.res_type = RPMPD_##r_type,				\
 		.res_id = r_id,						\
 		.key = KEY_FLOOR_CORNER,				\
 	}
 
-#define DEFINE_RPMPD_VFC_SMPA(_platform, _name, r_id)			\
-	DEFINE_RPMPD_VFC(_platform, _name, r_id, RPMPD_SMPA)
-
-#define DEFINE_RPMPD_VFC_LDOA(_platform, _name, r_id)			\
-	DEFINE_RPMPD_VFC(_platform, _name, r_id, RPMPD_LDOA)
-
 struct rpmpd_req {
 	__le32 key;
 	__le32 nbytes;
@@ -94,12 +88,12 @@ struct rpmpd_desc {
 static DEFINE_MUTEX(rpmpd_lock);
 
 /* msm8996 RPM Power domains */
-DEFINE_RPMPD_CORNER_SMPA(msm8996, vddcx, vddcx_ao, 1);
-DEFINE_RPMPD_CORNER_SMPA(msm8996, vddmx, vddmx_ao, 2);
-DEFINE_RPMPD_CORNER_LDOA(msm8996, vddsscx, 26);
+DEFINE_RPMPD_CORNER_PAIR(msm8996, vddcx, vddcx_ao, SMPA, 1);
+DEFINE_RPMPD_CORNER_PAIR(msm8996, vddmx, vddmx_ao, SMPA, 2);
+DEFINE_RPMPD_CORNER(msm8996, vddsscx, LDOA, 26);
 
-DEFINE_RPMPD_VFC_SMPA(msm8996, vddcx_vfc, 1);
-DEFINE_RPMPD_VFC_LDOA(msm8996, vddsscx_vfc, 26);
+DEFINE_RPMPD_VFC(msm8996, vddcx_vfc, SMPA, 1);
+DEFINE_RPMPD_VFC(msm8996, vddsscx_vfc, LDOA, 26);
 
 static struct rpmpd *msm8996_rpmpds[] = {
 	[MSM8996_VDDCX] =	&msm8996_vddcx,
-- 
2.18.0

