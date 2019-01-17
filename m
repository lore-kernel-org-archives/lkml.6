Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A797FC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 05:12:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7653C205C9
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 05:12:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="PJPLA3vn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729266AbfAQFME (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 00:12:04 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:38675 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725953AbfAQFMD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 00:12:03 -0500
Received: by mail-pg1-f196.google.com with SMTP id g189so3887130pgc.5
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 21:12:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=sw58SkYJejOHqOYOm4JYlutkdMfKaNYQfwacC5uJ8QE=;
        b=PJPLA3vn6+kb/T71/ROYTnOjCgv6WZ6F/ukkzqV+zJwlfmt6hy1fxkPV+g/qYWpwMz
         V/Ahrk5Oq15ECxrcza2Q8K/12w8jvDoouXRhoIPGacgf0jKj/fQZ6Q86PfvF3mDsJkAv
         aEW0U5v+l9ptZpCPAkzXupRX6GsCtWQnfIvPs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=sw58SkYJejOHqOYOm4JYlutkdMfKaNYQfwacC5uJ8QE=;
        b=XSiT4PGFbm4pNdFai7yLmZwr6LCqx5CQbrgqNrVo24SOhplRjnWc2JB2dqAWdR4+1x
         sXWi7VrCFzrBZxUKUOUOf3ESDLnoRWpeMGk9Bj4IXyayO1SztozbKI8qQdGScLYLO1Mw
         yKNP2enCQasPe7zX4P62MVpQKI1q6hmodyUrjIhU50NnkVB88mTfwpOKMdzaUgJn19tt
         bVgEHkW2ychgJPb9Av0L52+qX2qA2VF4S+aA17SkpmUdgb5OXqc+3ZCEDQtkuRplDMgf
         ECtHRCwCkqGehz0Kw4PrhCk/zbyXXNInzKqveiKDVrR9+hF9FqkzINPBRjPGLZWIzBNb
         Qz5g==
X-Gm-Message-State: AJcUukcXl+fZr2O9GlVMPyubw1zbhlw2svm8mPe+MWaenqbRMXEPaTMw
        0dYgux2yEl3Hs5GCdzCAstks+g==
X-Google-Smtp-Source: ALg8bN4uXfvrF68ilHWwaWZeQS7LJL7TWsfHyFiNRYi1+exgJAq0+3i0Py3DoAOJfHI6usEU4Xkjcw==
X-Received: by 2002:a63:7154:: with SMTP id b20mr12135637pgn.342.1547701921753;
        Wed, 16 Jan 2019 21:12:01 -0800 (PST)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id l185sm701089pfl.54.2019.01.16.21.12.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Jan 2019 21:12:01 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rajendra Nayak <rnayak@codeaurora.org>
Subject: [PATCH] soc: qcom: rpmpd: Drop family A RPM dependency
Date:   Wed, 16 Jan 2019 21:11:20 -0800
Message-Id: <20190117051120.31913-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The MFD_QCOM_RPM is the RPM in family A, but the rpmpd driver only implements
support for SMD based devices. Drop the dependency and remove includes of the
family A headers. No functional change.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Sorry for not spotting this earlier, let's apply the series and this fix on
top.

 drivers/soc/qcom/Kconfig |  2 +-
 drivers/soc/qcom/rpmpd.c | 10 ++++------
 2 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
index 6241d3e3b115..a5d5167c3f16 100644
--- a/drivers/soc/qcom/Kconfig
+++ b/drivers/soc/qcom/Kconfig
@@ -109,7 +109,7 @@ config QCOM_RPMHPD
 
 config QCOM_RPMPD
 	bool "Qualcomm RPM Power domain driver"
-	depends on MFD_QCOM_RPM && QCOM_SMD_RPM
+	depends on QCOM_SMD_RPM
 	help
 	  QCOM RPM Power domain driver to support power-domains with
 	  performance states. The driver communicates a performance state
diff --git a/drivers/soc/qcom/rpmpd.c b/drivers/soc/qcom/rpmpd.c
index 35a711017d6f..005326050c23 100644
--- a/drivers/soc/qcom/rpmpd.c
+++ b/drivers/soc/qcom/rpmpd.c
@@ -6,14 +6,12 @@
 #include <linux/kernel.h>
 #include <linux/mutex.h>
 #include <linux/pm_domain.h>
-#include <linux/mfd/qcom_rpm.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/pm_opp.h>
 #include <linux/soc/qcom/smd-rpm.h>
 
-#include <dt-bindings/mfd/qcom-rpm.h>
 #include <dt-bindings/power/qcom-rpmpd.h>
 
 #define domain_to_rpmpd(domain) container_of(domain, struct rpmpd, pd)
@@ -131,8 +129,8 @@ static int rpmpd_send_enable(struct rpmpd *pd, bool enable)
 		.value = cpu_to_le32(enable),
 	};
 
-	return qcom_rpm_smd_write(pd->rpm, QCOM_RPM_ACTIVE_STATE, pd->res_type,
-				  pd->res_id, &req, sizeof(req));
+	return qcom_rpm_smd_write(pd->rpm, QCOM_SMD_RPM_ACTIVE_STATE,
+				  pd->res_type, pd->res_id, &req, sizeof(req));
 }
 
 static int rpmpd_send_corner(struct rpmpd *pd, int state, unsigned int corner)
@@ -174,13 +172,13 @@ static int rpmpd_aggregate_corner(struct rpmpd *pd)
 
 	active_corner = max(this_active_corner, peer_active_corner);
 
-	ret = rpmpd_send_corner(pd, QCOM_RPM_ACTIVE_STATE, active_corner);
+	ret = rpmpd_send_corner(pd, QCOM_SMD_RPM_ACTIVE_STATE, active_corner);
 	if (ret)
 		return ret;
 
 	sleep_corner = max(this_sleep_corner, peer_sleep_corner);
 
-	return rpmpd_send_corner(pd, QCOM_RPM_SLEEP_STATE, sleep_corner);
+	return rpmpd_send_corner(pd, QCOM_SMD_RPM_SLEEP_STATE, sleep_corner);
 }
 
 static int rpmpd_power_on(struct generic_pm_domain *domain)
-- 
2.18.0

