Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2704EC4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 10:14:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D621D21A02
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 10:14:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="DMpwJJY0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D621D21A02
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729716AbeHFMXR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 08:23:17 -0400
Received: from mail-wm0-f49.google.com ([74.125.82.49]:36881 "EHLO
        mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728948AbeHFMXI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 08:23:08 -0400
Received: by mail-wm0-f49.google.com with SMTP id n11-v6so13660100wmc.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 Aug 2018 03:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3GzfBKQrailO+bECqTB4UMju7pt1CJOnkWC1yfUt1mU=;
        b=DMpwJJY04D9qTRgVjuvuUZebn8dFRdvy8yQmTuCna8I8UqCXfWPUj+7t5z4kzORiO9
         sOG8T+4ijvKOPk1jMaPRaZLM3ghGSMpnG87Co9OyqT+OROT16tOy6KrRwONs9cQofdFG
         sVne+BuXIqhg1du5Es4NgxcBd+S2mOxJTX1M4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3GzfBKQrailO+bECqTB4UMju7pt1CJOnkWC1yfUt1mU=;
        b=ZnRnGaDP20LpV3MeW/JTcrci5S9yE/orVnTpNMYNtvFgChKIce3OvJTjruAPSgSssJ
         MHyPIWIupcvlCE85oU/AaAqCOMe/ZZI9HPciyXu9uIM5hUkUZnDFUMxVoj3GfmzlF6Lo
         RLve1ql0mkWRZ7trraV4Fh2JEBBDJ9OzETZFF7F0SOwCJtSagVuevuaKuw7oF+K2l5yq
         62q+BC3iq7mEfWeC04rvP4VDkxhSGpgtQBQOJNfTnU/+dG/NHADGDLhhtj4vOY5bav+J
         R8IyAXBhuwJ5Lu7Pc2tKsb4zcIxlLTdPjUwui6SZyZl6zQ17MGZSe66SdzjoJtw/4PFv
         Qh5w==
X-Gm-Message-State: AOUpUlHLnwjYBmAxC3IMo/3Cy5uhyCAibN04MoXONUGNVINEMVjI3MXY
        v5Hb5+XxKQC5ZBhBpaWAW5AMbNzkIjg=
X-Google-Smtp-Source: AAOMgpcgmSz8frpPS2rq57KJVPcxtI591IZq2NcKII7m+wtNCy44cq9Upkdd0wyYmQWhYPw4bsf2RA==
X-Received: by 2002:a1c:8587:: with SMTP id h129-v6mr10481742wmd.105.1533550486225;
        Mon, 06 Aug 2018 03:14:46 -0700 (PDT)
Received: from localhost.localdomain (cpc90716-aztw32-2-0-cust92.18-1.cable.virginm.net. [86.26.100.93])
        by smtp.gmail.com with ESMTPSA id s2-v6sm8095644wrw.52.2018.08.06.03.14.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 06 Aug 2018 03:14:45 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org, lgirdwood@gmail.com,
        alsa-devel@alsa-project.org
Cc:     perex@perex.cz, tiwai@suse.com, vkoul@kernel.org,
        linux-kernel@vger.kernel.org, rohitkr@codeaurora.org,
        bgoswami@codeaurora.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 4/5] ASoC: qcom: remove unused header files from common.h
Date:   Mon,  6 Aug 2018 11:12:08 +0100
Message-Id: <20180806101209.15167-5-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180806101209.15167-1-srinivas.kandagatla@linaro.org>
References: <20180806101209.15167-1-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes unused header files from common.h.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/qcom/common.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/qcom/common.h b/sound/soc/qcom/common.h
index ad5d2cf27459..f05c05b12bd7 100644
--- a/sound/soc/qcom/common.h
+++ b/sound/soc/qcom/common.h
@@ -4,7 +4,6 @@
 #ifndef __QCOM_SND_COMMON_H__
 #define __QCOM_SND_COMMON_H__
 
-#include <linux/component.h>
 #include <sound/soc.h>
 
 int qcom_snd_parse_of(struct snd_soc_card *card);
-- 
2.16.2

