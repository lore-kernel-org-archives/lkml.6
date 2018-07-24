Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1D9FC6778F
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 23:56:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6321C20880
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 23:56:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6321C20880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388578AbeGYBFn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 21:05:43 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:39861 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388447AbeGYBFn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 21:05:43 -0400
Received: by mail-pl0-f67.google.com with SMTP id m1-v6so2440410plt.6
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jul 2018 16:56:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=yUQ6ZBSSjkTy86/Cz5L8DDuSY21Psh4pSHnGi5L6q84=;
        b=A3pulVrRGBP6uCfROZMJ5moPHztWIAxTf03bG1Sc+XiNKBFabvbf7xSKPdaNO1Avl9
         jWUAboGAkkmuGaEQh3HOWQvXR8wx5yJGqmrkjkhJJDbxKmUWZzbO0uP8pb5o853zoMb6
         t9mbK7+fgvD9IRDyjdqK/r8rOegZJFdcFc0X/woR3WVp4mZ44apTMOFVCIa6ZyXrFfsO
         DWzsPC+gD+LmVOb/Jak6KY7HbhFY/pASO2kVdAFb8HdejqIAmB40GetNuX6g0ZhiIWMe
         kTgpWo1G9R8OsM4eXUxWWNqKIawz1TE576LcYch3MF7N+AFbLRaAR3AAa78c8/vi1n05
         YlVg==
X-Gm-Message-State: AOUpUlH2T5iXFBYCeypVGNrwQzSXm45xR4zVuBFy37FnDMy0KcZdDXzx
        jh4vG//lSVEf3BEDK+yLFk2V3A==
X-Google-Smtp-Source: AAOMgpcx/wuMd+7LY4OaKkQuyoMfu/QXYH34tpSkmsvRLdqmzig+S2gWDfplih3UHhkmIGwgxE5kdg==
X-Received: by 2002:a17:902:184:: with SMTP id b4-v6mr19070231plb.340.1532476607636;
        Tue, 24 Jul 2018 16:56:47 -0700 (PDT)
Received: from mka.mtv.corp.google.com ([2620:0:1000:1501:8e2d:4727:1211:622])
        by smtp.gmail.com with ESMTPSA id f67-v6sm21817559pfe.75.2018.07.24.16.56.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Jul 2018 16:56:47 -0700 (PDT)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH] thermal: qcom-spmi: Delete unused field 'prev_stage'
Date:   Tue, 24 Jul 2018 16:56:36 -0700
Message-Id: <20180724235636.60357-1-mka@chromium.org>
X-Mailer: git-send-email 2.18.0.233.g985f88cf7e-goog
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The field 'prev_stage' in struct qpnp_tm_chip is not used, remove it.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---
 drivers/thermal/qcom-spmi-temp-alarm.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/thermal/qcom-spmi-temp-alarm.c b/drivers/thermal/qcom-spmi-temp-alarm.c
index ad4f3a8d6560..964d35e32027 100644
--- a/drivers/thermal/qcom-spmi-temp-alarm.c
+++ b/drivers/thermal/qcom-spmi-temp-alarm.c
@@ -67,7 +67,6 @@ struct qpnp_tm_chip {
 	long				temp;
 	unsigned int			thresh;
 	unsigned int			stage;
-	unsigned int			prev_stage;
 	unsigned int			base;
 	struct iio_channel		*adc;
 };
-- 
2.18.0.233.g985f88cf7e-goog

