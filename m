Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CA88C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 16:58:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DBBB21908
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 16:58:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549558738;
	bh=f6DbzwCzt3QlWDGzFWnf4ZQSKBBR/vDRJuxbLjCygqw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=H3n6rRyqoWeEluYaszawjhtcDsHKvAI5lpLLCGVaCl9uq4ArCD9CiaZaUguysTAQL
	 aLGS+8cDaaGhzy9TZcS55I6Hng9diQUnbxsNe/0IMITCyk2Zvl+tIYlpKyTufNyaSW
	 IewVpi2BiwWDar3RKe1AkUdrL0Gl3Pu59Kw37Fw8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727076AbfBGQ64 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 11:58:56 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:46819 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726650AbfBGQ6o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 11:58:44 -0500
Received: by mail-lf1-f67.google.com with SMTP id f5so372474lfc.13;
        Thu, 07 Feb 2019 08:58:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MHIO03FFxcWAKfGcLX7T/jlqXz8Gs8V5XO/qdL8floE=;
        b=oGQ4hpEjDy6EBsEbfT2Hu2TAfoKlEhaaP/Mkkpudbt1iAZ3jNT7gET5L4ZeJefVYRZ
         q7GSauBQPYbUCCm9sqZV4ZcpX+OmM5+Kau1yzvlPMPn9MXZ/TsLlpgH3BkKettlFRe73
         EM8IX5MuttL/oateZrKokXMt1BPVHwu1IQRKcfCl7dfvIybX9+y10pusHVQ6xpDJs5mj
         7cXotlmzCHhBby2qDlzrZi7C6qsVWshzyfZKG5y1x/FA0mUkURGgFyTbdk1/ERn9IR4H
         s+H6hsUkDD3BXn4kbmZFQDy5B/0esXbanrkrFbrJ1qK5CvrwXU91qWFPjFEHhPa9ccui
         3SFA==
X-Gm-Message-State: AHQUAub5+XbsWJm1BuQm4LWUAKlvpw6fKlILDaebtwZ/AUN4jxEWA99Z
        zeDHJrFyh8ypnEzPhoqr6OY=
X-Google-Smtp-Source: AHgI3IbfUQEa8oX3YIXlIGFQ/8h89bkinalyN/xlJic7Zk4qbLUjPEsjKgCa4WTpw4V+DxJnVb+XTg==
X-Received: by 2002:ac2:55b3:: with SMTP id y19mr11189848lfg.28.1549558721890;
        Thu, 07 Feb 2019 08:58:41 -0800 (PST)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id b20sm4953747lfj.61.2019.02.07.08.58.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Feb 2019 08:58:39 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@xi.terra>)
        id 1grn0Y-0000Py-8n; Thu, 07 Feb 2019 17:58:38 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>
Subject: [PATCH 2/3] ASoC: msm8916-wcd-digital: convert license header to SPDX
Date:   Thu,  7 Feb 2019 17:57:54 +0100
Message-Id: <20190207165755.1548-3-johan@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190207165755.1548-1-johan@kernel.org>
References: <20190207165755.1548-1-johan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the GPLv2-only license header to SPDX.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 sound/soc/codecs/msm8916-wcd-digital.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/sound/soc/codecs/msm8916-wcd-digital.c b/sound/soc/codecs/msm8916-wcd-digital.c
index 3063dedd21cf..5273996b40d5 100644
--- a/sound/soc/codecs/msm8916-wcd-digital.c
+++ b/sound/soc/codecs/msm8916-wcd-digital.c
@@ -1,13 +1,6 @@
-/* Copyright (c) 2016, The Linux Foundation. All rights reserved.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 and
- * only version 2 as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2016, The Linux Foundation. All rights reserved.
  */
 
 #include <linux/module.h>
-- 
2.20.1

