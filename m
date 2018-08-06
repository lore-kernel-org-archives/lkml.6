Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2EC0C46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 10:15:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93A3D219F4
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 10:15:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="gEAe7ysc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93A3D219F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729732AbeHFMXY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 08:23:24 -0400
Received: from mail-wm0-f54.google.com ([74.125.82.54]:36881 "EHLO
        mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726699AbeHFMXG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 08:23:06 -0400
Received: by mail-wm0-f54.google.com with SMTP id n11-v6so13659972wmc.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 Aug 2018 03:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jcY+VCWyDJSWv1ZyfT9BzBqleWzty6Jj8/0HWv9QHUA=;
        b=gEAe7yscJ6YtocuJyN8J9fZKowR8u2ZLWeCSjJ6djhEyHRmbnEZ2IDeHSsfbiQWC8f
         5LZG8cUybIQoM4Em9d9L0BM5hxmfZdrNmW4SFpl2kD0lKSlQUWTYyLBikt3htMrHcuRd
         PL49XiVbPU8cz9zadqxPBKtYMhR4I7NbEmjDo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jcY+VCWyDJSWv1ZyfT9BzBqleWzty6Jj8/0HWv9QHUA=;
        b=fvnR65JF1z6TJKiZfqWQQBdmbLTE3i+3fBpfl5LIx5x+9bnLymbLIkF925AtvsUgcr
         AWvuqwYC31VZ7WhI832xtA2pXjl5dsS9cd4FLgBHifD1lEKMM+HZ1cwUlBUfMuSNp9F4
         403DP4r8F4RBI4WYHrXeC8+80rDjy3abP9v7hqsbrU8IEvzWaO4jGps+eg5v2/gn0imu
         Wq4spzHujDysVjEpNpcSBBKS51+9LjT5rVmPTKosqO988tTuMK4yFnDSeqwss/pVmSaK
         jhvULlur2WkTEC/R9TUz9KRE7/P42jgmwZhwmeEiWhU5S3pEN22SPMYLZIMRHIQgu5rg
         ki3g==
X-Gm-Message-State: AOUpUlGkFj3CMu0LFT7ahc9TGsOPhhndbD76HJEU3Gt3FCtIkHZ3NPdR
        nbifWuBkbszU7GFMgeYOniTqQg==
X-Google-Smtp-Source: AAOMgpe7/ohioXEUFh0edBtQIZ5+4Aao6zXRK7dRGXNfAenHEMfZ+WnpBJf8gsNi4CO/7ST6uOEbew==
X-Received: by 2002:a1c:9f12:: with SMTP id i18-v6mr11620311wme.124.1533550484243;
        Mon, 06 Aug 2018 03:14:44 -0700 (PDT)
Received: from localhost.localdomain (cpc90716-aztw32-2-0-cust92.18-1.cable.virginm.net. [86.26.100.93])
        by smtp.gmail.com with ESMTPSA id s2-v6sm8095644wrw.52.2018.08.06.03.14.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 06 Aug 2018 03:14:43 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org, lgirdwood@gmail.com,
        alsa-devel@alsa-project.org
Cc:     perex@perex.cz, tiwai@suse.com, vkoul@kernel.org,
        linux-kernel@vger.kernel.org, rohitkr@codeaurora.org,
        bgoswami@codeaurora.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 2/5] ASoC: apq8096: remove unused header files
Date:   Mon,  6 Aug 2018 11:12:06 +0100
Message-Id: <20180806101209.15167-3-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180806101209.15167-1-srinivas.kandagatla@linaro.org>
References: <20180806101209.15167-1-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes unused header files from the driver.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/qcom/apq8096.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/soc/qcom/apq8096.c b/sound/soc/qcom/apq8096.c
index 6ee7e66cbaaa..1543e85629f8 100644
--- a/sound/soc/qcom/apq8096.c
+++ b/sound/soc/qcom/apq8096.c
@@ -1,9 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 // Copyright (c) 2018, Linaro Limited
 
-#include <linux/soc/qcom/apr.h>
 #include <linux/module.h>
-#include <linux/component.h>
 #include <linux/platform_device.h>
 #include <linux/of_device.h>
 #include <sound/soc.h>
-- 
2.16.2

