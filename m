Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 568EFC3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 12:45:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DC1323EF2
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 12:45:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="iMAf4CMk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DC1323EF2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753146AbeGBMpH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 08:45:07 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:37293 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752146AbeGBMpD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 08:45:03 -0400
Received: by mail-pl0-f67.google.com with SMTP id 31-v6so7915247plc.4
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 05:45:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=p3koVhtRRzyhzphTmu+qmrI0x4JDa4s0PSex5KgY8no=;
        b=iMAf4CMkixc+6N4DEsUC+7GixyaVLiWNzVPXziMW0IhO6mxTMVfxYpSwvwENQdlKZc
         5JUI+HpGPrnWnItKuszB2UUA/cjwQ2fr5EZcolwVdu39ea5JlbdXgShEZ2aSeMffdvS4
         dBGoSokGFrgdG2+wu4oiD+ywb1VAhVpMmpGQY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=p3koVhtRRzyhzphTmu+qmrI0x4JDa4s0PSex5KgY8no=;
        b=Vlx+zrpjMW5gxJs1y8/gehOOpsoaauLXTliUXOHokdpyzNH+li0Y0/RAaKMIxoxJVt
         fnfzosDGakKLpzju0wq4ojhYuHra/VdJAEI6uRLyX3ReyvXDTXT7gQLX/etJETbUxTcM
         EQuH52UCwYQFeNiVR5l4pV484eQ5Xl9qBgi7Ng+gxib9OQIC4e1bOe6zWgcEt+osRDk4
         peXovAgC8SkdRjMrDzuHbnwEg7hQEZaSFi7TwOxDUpl/8bbjdxjujO1aJP+g5MLYXdfl
         rdd+HsZtMFR8Isay0LBufGU2wuz+1jtKDsTUbza9o/wUZwoI8bt0qB+Z1B/kSxcONlrj
         tgPg==
X-Gm-Message-State: APt69E2lrO0RhwEgbjk6d5GqR5AwDvtIZ/DiLJKVOhBgfg3BhHKfKooB
        GKs4OM9HvTM4W+aeEZAixlf7PaMPRMw=
X-Google-Smtp-Source: ADUXVKK9QoQU7rnov/BsGPI2GaldJtcMBooU26t3+eEE6pogEeqfXgBplYi66Z0rhmuotDmSuHhmIA==
X-Received: by 2002:a17:902:7202:: with SMTP id ba2-v6mr25198257plb.119.1530535501540;
        Mon, 02 Jul 2018 05:45:01 -0700 (PDT)
Received: from localhost ([49.248.63.129])
        by smtp.gmail.com with ESMTPSA id c85-v6sm8483724pfd.110.2018.07.02.05.45.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Jul 2018 05:45:01 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     rnayak@codeaurora.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com,
        smohanad@codeaurora.org, vivek.gautam@codeaurora.org,
        andy.gross@linaro.org, Zhang Rui <rui.zhang@intel.com>,
        linux-pm@vger.kernel.org
Subject: [PATCH v4 5/6] thermal: tsens: Check if we have valid data before reading
Date:   Mon,  2 Jul 2018 18:14:08 +0530
Message-Id: <e2fd1933390c2c1c0fedc6e2c4f2093470c4242a.1530533998.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1530533998.git.amit.kucheria@linaro.org>
References: <cover.1530533998.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1530533998.git.amit.kucheria@linaro.org>
References: <cover.1530533998.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/thermal/qcom/tsens-v2.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/thermal/qcom/tsens-v2.c b/drivers/thermal/qcom/tsens-v2.c
index 1871945..0473f33 100644
--- a/drivers/thermal/qcom/tsens-v2.c
+++ b/drivers/thermal/qcom/tsens-v2.c
@@ -7,6 +7,9 @@
 #include <linux/regmap.h>
 #include "tsens.h"
 
+#define TRDY_OFFSET            0xe4
+#define TRDY_READY_BIT         BIT(0)
+
 #define STATUS_OFFSET		0xa0
 #define LAST_TEMP_MASK		0xfff
 #define STATUS_VALID_BIT	BIT(21)
@@ -19,6 +22,12 @@ static int get_temp_tsens_v2(struct tsens_device *tmdev, int id, int *temp)
 	unsigned int sensor_addr;
 	int last_temp = 0, last_temp2 = 0, last_temp3 = 0, ret;
 
+	ret = regmap_read(tmdev->map, TRDY_OFFSET, &code);
+	if (ret)
+		return ret;
+	if (code & TRDY_READY_BIT)
+		return -ENODATA;
+
 	sensor_addr = STATUS_OFFSET + s->hw_id * 4;
 	ret = regmap_read(tmdev->map, sensor_addr, &code);
 	if (ret)
-- 
2.7.4

