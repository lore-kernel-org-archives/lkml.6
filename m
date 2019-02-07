Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C241C282C4
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 12:57:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D6A321904
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 12:57:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GU6vdUEv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727549AbfBGM55 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 07:57:57 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:39187 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726843AbfBGM54 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 07:57:56 -0500
Received: by mail-pl1-f194.google.com with SMTP id 101so4749148pld.6
        for <linux-kernel@vger.kernel.org>; Thu, 07 Feb 2019 04:57:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=xvoojo3eKvN4L9IBWkrmUvvE40O1kNL0V6YvK2/qLWI=;
        b=GU6vdUEvju3j5DwbO0WlBLy1ZvQH2jJ6XLDpWGXp/6M6zUPJ5eyJ8OfzzGWWVX9pBC
         8pcaJRRFr4rc7CHQF+uto6DQv48Sl32wD4b4Li78o+Z0FY3re52q+74ZCnt8UuTVC2G8
         szkCHa5S5jSVbDU0fjSMlmA2T0EPpCC1z0whbRAZBLl469lK0xpQaOQN0YYLPBDqDrV9
         93kl6UGCeUqdjGAWw0C6GzCSR9QZ1npMYymhNN4mjsIYPoPEl4Ye/By0+TbSBozqwhC3
         QRLlECdR88w8o2C7ZCpxToRYQ269Wg6ufMOPHKhRY46zI4Q3Arnor1kNk9Ke7isQJ/Ap
         9qVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=xvoojo3eKvN4L9IBWkrmUvvE40O1kNL0V6YvK2/qLWI=;
        b=W+J9Gb0BrN92UR9uvM2+LGyPL0daWjR94zKf+S7xWtG8LuZX4ktZKFWkjwcBHl2u1U
         X1pqhnvkUHjO8Gj6ySZuiFSFtL3J9374Uc9LDTlpMZwY6ItBFnNXX9SrvkVF8zJQvgRn
         lLEmNbxWIUsImmndadPxZJ7YPcj+dgtxnx39llUDzdMS9UZCV0u9c0g15p5G+4Ie6YOG
         rUowai17CaU+HMud501jwm6xtJ5AtWfwiIq5M880p+u/BwfhRlw3VRlWlURclPkrXH75
         bceiiHkaviW9+GMWErj6wnBsD/inGOcOc/prc62nuZGd9v+V6B5O0PB3pLjTazStF4sd
         yQ2g==
X-Gm-Message-State: AHQUAuYko27PDaIZVEoRZRdMfWQH4ahD7Gy0x4T2QlgrlSBJTfIOff33
        Hw8pBQr1Zl1DHg0QQrOwRK8W72TyuKY=
X-Google-Smtp-Source: AHgI3IY4AfwU4mluW2xleqadZOevjpdXJZpYog0+thT1ZC5ix7w6CI4qL4gWh1byZbTKiVou3Wn3FQ==
X-Received: by 2002:a17:902:a50e:: with SMTP id s14mr4383413plq.311.1549544275562;
        Thu, 07 Feb 2019 04:57:55 -0800 (PST)
Received: from localhost ([2402:3a80:c80:4138:75dd:3900:1d90:762f])
        by smtp.gmail.com with ESMTPSA id s190sm14292437pfb.103.2019.02.07.04.57.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Feb 2019 04:57:54 -0800 (PST)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com,
        andy.gross@linaro.org, Daniel Lezcano <daniel.lezcano@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     linux-pm@vger.kernel.org
Subject: [PATCH v1 07/24] drivers: thermal: tsens: Rename tsens-8916 to prepare to merge with tsens-8974
Date:   Thu,  7 Feb 2019 16:19:25 +0530
Message-Id: <ca6649df6affcdd469c33f510e73714c1be2789f.1549525708.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1549525708.git.amit.kucheria@linaro.org>
References: <cover.1549525708.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1549525708.git.amit.kucheria@linaro.org>
References: <cover.1549525708.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

8916 and 8974 use v0.1.0 of the TSENS IP. Rename tsens-8916 to prepare
it for merging with tsens-8974 in a later commit.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 drivers/thermal/qcom/Makefile                       | 2 +-
 drivers/thermal/qcom/{tsens-8916.c => tsens-v0_1.c} | 0
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename drivers/thermal/qcom/{tsens-8916.c => tsens-v0_1.c} (100%)

diff --git a/drivers/thermal/qcom/Makefile b/drivers/thermal/qcom/Makefile
index 717a08600bb5..1f2fafd43dff 100644
--- a/drivers/thermal/qcom/Makefile
+++ b/drivers/thermal/qcom/Makefile
@@ -1,3 +1,3 @@
 obj-$(CONFIG_QCOM_TSENS)	+= qcom_tsens.o
-qcom_tsens-y			+= tsens.o tsens-common.o tsens-8916.o tsens-8974.o tsens-8960.o tsens-v2.o
+qcom_tsens-y			+= tsens.o tsens-common.o tsens-v0_1.o tsens-8974.o tsens-8960.o tsens-v2.o
 obj-$(CONFIG_QCOM_SPMI_TEMP_ALARM)	+= qcom-spmi-temp-alarm.o
diff --git a/drivers/thermal/qcom/tsens-8916.c b/drivers/thermal/qcom/tsens-v0_1.c
similarity index 100%
rename from drivers/thermal/qcom/tsens-8916.c
rename to drivers/thermal/qcom/tsens-v0_1.c
-- 
2.17.1

