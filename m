Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A64BBECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 06:43:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46FDB205F4
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 06:43:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="X1wYElMj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46FDB205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728929AbeGRHUC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 03:20:02 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40638 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728240AbeGRHUC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 03:20:02 -0400
Received: by mail-wr1-f68.google.com with SMTP id t6-v6so3420955wrn.7
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 23:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=4oDCvpizcqb4/i72AEYMNJaEhphPFSx5aHBq53Ho/iA=;
        b=X1wYElMjmFFVBIYhnF7TLSBDWkYYSU6NiObba5XVecgkEWylovwt0I8cX1pfFxrGeL
         8QdFNOz/JrEkJeDaSswui7prpExaAtgg0Kq2WP9g9vgtoLpQjUmeFy5BLv0tlzBrniZH
         H01jcO/5eL22yYG5HcgTxZ8RLX7I/a8H/+OUc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=4oDCvpizcqb4/i72AEYMNJaEhphPFSx5aHBq53Ho/iA=;
        b=S1mppyYfAkbSNCULg3pE8FxOSRrJ0OdhdKcVnazgHpYt/zyc23HonTIYkSk81SYFYU
         TMGWwk9R+K/a//LyNql0TUxHPCCFhtlN8XcwyNKpuWHxht2dEDSEvSd8UsyxMX5+p0/U
         ZDYQMoiw4BC6XNf7E7choRnYuh5Tef4s/Gwnj2z5HgikmLbk56acYg5jaeWJynhKIZ3i
         xPbobZE2wzEQBigl2JYLFzP4JeFvDK/CukTTFVD6D5Nx/wOSf5ZbifVXLamaF1uYmqkz
         ld3oXa+pDSjhP5+SLmrZJavT1DU/kq2FWWkssaJGtWHUXMnoesFu0RX/ue9TJlHCtA4w
         fHmw==
X-Gm-Message-State: AOUpUlHy3byAFgJsNE3c5XW7xhwyNqQLepdbsDPp+KmR9nhxcZvRypLH
        2a+IrDN7fipj0LefjhgyBggcdXNJISg=
X-Google-Smtp-Source: AAOMgpfMiLOTQcS+5ke9s+tL6hsTkO7ky9sAkOOIOsQOYtnf4/Ccc8Db46TgBY/zvRYYclDC2uw9gg==
X-Received: by 2002:adf:f410:: with SMTP id g16-v6mr3395500wro.256.1531896222866;
        Tue, 17 Jul 2018 23:43:42 -0700 (PDT)
Received: from localhost ([103.249.91.115])
        by smtp.gmail.com with ESMTPSA id r140-v6sm1365330wmd.27.2018.07.17.23.43.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Jul 2018 23:43:42 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     rnayak@codeaurora.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com,
        smohanad@codeaurora.org, vivek.gautam@codeaurora.org,
        andy.gross@linaro.org, dianders@chromium.org, mka@chromium.org,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org
Subject: [PATCH v8 1/7] thermal: tsens: Get rid of unused fields in structure
Date:   Wed, 18 Jul 2018 12:13:07 +0530
Message-Id: <37bbc8c5c464bbc8d610c85bccaf449e5670497b.1531895128.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1531895128.git.amit.kucheria@linaro.org>
References: <cover.1531895128.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1531895128.git.amit.kucheria@linaro.org>
References: <cover.1531895128.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

status_field and trdy are unused in any of the tsens drivers. Remove them.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Acked-by: Rajendra Nayak <rnayak@codeaurora.org>
Tested-by: Matthias Kaehlcke <mka@chromium.org>
---
 drivers/thermal/qcom/tsens.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/thermal/qcom/tsens.h b/drivers/thermal/qcom/tsens.h
index 911c197..dc56e1e 100644
--- a/drivers/thermal/qcom/tsens.h
+++ b/drivers/thermal/qcom/tsens.h
@@ -77,9 +77,7 @@ struct tsens_device {
 	struct device			*dev;
 	u32				num_sensors;
 	struct regmap			*map;
-	struct regmap_field		*status_field;
 	struct tsens_context		ctx;
-	bool				trdy;
 	const struct tsens_ops		*ops;
 	struct tsens_sensor		sensor[0];
 };
-- 
2.7.4

