Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F496C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 11:28:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBD8120896
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 11:28:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZtbkqstD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBD8120896
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932755AbeGIL2R (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 07:28:17 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42717 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932609AbeGIL2M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 07:28:12 -0400
Received: by mail-wr1-f65.google.com with SMTP id p1-v6so10594956wrs.9
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jul 2018 04:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=RqHvCXWgQNEn4X6AU/ZqYttyBtBVtMakbjX0moav5Ps=;
        b=ZtbkqstDXIt1wd5jPPhvSO45ko4JglnNNr11mtK/Lw0Kz48LhzxWr5wgqCP1WJySjv
         V+TPJ+o2DIiCz3EovzkQj8lPyV613gltVlezLBvs/cVvyC3ksQ1jmfHHMG+8yVCj+2pY
         8RkfD/UIOvf6YNVT5t+wEipIPjQ5090z6psuc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=RqHvCXWgQNEn4X6AU/ZqYttyBtBVtMakbjX0moav5Ps=;
        b=KyMVqIml4vbMzYFdVUPey8qemGR1i7paHZlMd29v0mdq0U7s10X0nhnuorAD8Pp5vA
         bYM31zBIBPPmCNGBN7K8KW/fDd1d5m85Tpk3g2q5x0/dwieyUp2rTixWZB38+u1Cnk0M
         trq4BsIXTBZnIlGHwqw7OzbLTJ3bZGh+4mNHc9aktFpRjifOc1zRuNWYx0a1+5EoLvRu
         FuSgFe/TDSVjZmuzOfuEDW7K9w410Ap76/WnZJpP/TLCE7DfDeusJ3sjrSXJi/1ruupQ
         SH289sp882JL+4Jq5jpkEm2ksM8dubRTFRnXqFHXyDNTahENEiYjy/hAjfIjp368SB5B
         +9qA==
X-Gm-Message-State: APt69E15hu0cg76aR8hVunXTP1HAQnYv/MKa7Y6y2O8JsRwiMwaebddr
        7OHqD/CGrAqyHfHcrjV1pi8gZW0EiLg=
X-Google-Smtp-Source: AAOMgpdCGOH53svKR1jybui7+UmQy545ANSOdNa1IugdrzBK9BtEkaT7bwrw7CdTiopZEFLx33aYtA==
X-Received: by 2002:adf:9d1c:: with SMTP id k28-v6mr15390586wre.29.1531135691055;
        Mon, 09 Jul 2018 04:28:11 -0700 (PDT)
Received: from localhost ([49.248.189.240])
        by smtp.gmail.com with ESMTPSA id u135-v6sm1981330wmf.2.2018.07.09.04.28.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Jul 2018 04:28:10 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     rnayak@codeaurora.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com,
        smohanad@codeaurora.org, vivek.gautam@codeaurora.org,
        andy.gross@linaro.org, Zhang Rui <rui.zhang@intel.com>,
        linux-pm@vger.kernel.org
Subject: [PATCH v5 1/7] thermal: tsens: Get rid of unused fields in structure
Date:   Mon,  9 Jul 2018 16:57:34 +0530
Message-Id: <a55492279160077e59fcc1e29b2c3b6d9d0f822f.1531133611.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1531133611.git.amit.kucheria@linaro.org>
References: <cover.1531133611.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1531133611.git.amit.kucheria@linaro.org>
References: <cover.1531133611.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

status_field and trdy are unused in any of the tsens drivers. Remove them.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Acked-by: Rajendra Nayak <rnayak@codeaurora.org>
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

