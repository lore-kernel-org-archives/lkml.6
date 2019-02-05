Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13F5DC282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 23:25:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5454217F9
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 23:25:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="x+rHdm2H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729387AbfBEXZ2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 18:25:28 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:39945 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728608AbfBEXZD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 18:25:03 -0500
Received: by mail-pg1-f195.google.com with SMTP id z10so2085916pgp.7
        for <linux-kernel@vger.kernel.org>; Tue, 05 Feb 2019 15:25:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=e6pkWcYABKD3ejWDgmD7yJDvlBAzURnOywHEGbKPVIw=;
        b=x+rHdm2H9c5f7/fy2daKzz6YY1pGQEECKYb92HEZv3FPw0hfs81DfPNv1CLSpquhbN
         mSL0lH8eTKwOW/Ho1i9vihbIClUV4VlgKI4DKMEOiSjSxIyt8Dx+5qxKH10AQSkKFkON
         JqLjyoxM6xoq3vIAiMaQcYWOao877gaYtswJW9ObYHQ9yuuSxfxlfWsJDyFxwL6HHPwC
         rDu6+t6EYoliVAx2pBQGIknucCOd0lriUoZ9NBjo+4AZkuDIZaupBRuD6MCFIB5qL4J2
         ONSZF2ixSEq9k3l/Ei7I+zuDGxRjJBQX7vu0rJFZ0z4gWTFdh28n6t9Od6G+JxeAehBn
         UJiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=e6pkWcYABKD3ejWDgmD7yJDvlBAzURnOywHEGbKPVIw=;
        b=LjJ81NuwJpjuKnSROApOggeVPABrJI7C2NwpsHJhIcmqoMT0HuEBLPZAKiLGt0PoIf
         O2fTIO/rVz29AW26I2pieVMwzMzdjWEEi9HGO44Cv+woiwciuJ897TE82q7ri48visPe
         J2unArc0ucF+tz9/CLT5iq9T5nuQdgWNx0SMJHZ3g+HRHbIY83Yfj4VpdSnBP5a6m8ag
         nHcppVrusj6QPYnK1ehicmqb2I9RcSSlpC87mTFZowON0oYlNCt3dqwg6GxiubHrW7Sn
         vIHG0d6PHj0dTRPMWj91yK5zWPrr54Im9p2UVl7V0k6h4LDvOqiJjTZucBOb5iojKH52
         IrJw==
X-Gm-Message-State: AHQUAuYSLnfDJNtawoZgDlRNBIyw+0gJNwHBqUyGOvTEeo32X6ofpceE
        JyeHSoTwFBpsFhcnNScUm6peAA==
X-Google-Smtp-Source: AHgI3IaR466XIuDZW1+60B9graoxktSuMAVlGcLCVD/I3GnM5aX4T1zCysSgzMA34hWEgzpbidzyWQ==
X-Received: by 2002:a62:43c5:: with SMTP id l66mr7531841pfi.207.1549409102690;
        Tue, 05 Feb 2019 15:25:02 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id g136sm5926917pfb.154.2019.02.05.15.25.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Feb 2019 15:25:02 -0800 (PST)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/6] coresight: stm: Remove set but not used variable 'res_size'
Date:   Tue,  5 Feb 2019 16:24:54 -0700
Message-Id: <20190205232458.7074-3-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190205232458.7074-1-mathieu.poirier@linaro.org>
References: <20190205232458.7074-1-mathieu.poirier@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/hwtracing/coresight/coresight-stm.c: In function 'stm_probe':
drivers/hwtracing/coresight/coresight-stm.c:796:9: warning:
 variable 'res_size' set but not used [-Wunused-but-set-variable]

It never used since introduction in commit 237483aa5cf4 ("coresight: stm:
adding driver for CoreSight STM component")

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Tested-by: Leo Yan <leo.yan@linaro.org>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-stm.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-stm.c b/drivers/hwtracing/coresight/coresight-stm.c
index ef339ff22090..f07825df5c7a 100644
--- a/drivers/hwtracing/coresight/coresight-stm.c
+++ b/drivers/hwtracing/coresight/coresight-stm.c
@@ -793,7 +793,7 @@ static int stm_probe(struct amba_device *adev, const struct amba_id *id)
 	struct stm_drvdata *drvdata;
 	struct resource *res = &adev->res;
 	struct resource ch_res;
-	size_t res_size, bitmap_size;
+	size_t bitmap_size;
 	struct coresight_desc desc = { 0 };
 	struct device_node *np = adev->dev.of_node;
 
@@ -833,15 +833,11 @@ static int stm_probe(struct amba_device *adev, const struct amba_id *id)
 
 	drvdata->write_bytes = stm_fundamental_data_size(drvdata);
 
-	if (boot_nr_channel) {
+	if (boot_nr_channel)
 		drvdata->numsp = boot_nr_channel;
-		res_size = min((resource_size_t)(boot_nr_channel *
-				  BYTES_PER_CHANNEL), resource_size(res));
-	} else {
+	else
 		drvdata->numsp = stm_num_stimulus_port(drvdata);
-		res_size = min((resource_size_t)(drvdata->numsp *
-				 BYTES_PER_CHANNEL), resource_size(res));
-	}
+
 	bitmap_size = BITS_TO_LONGS(drvdata->numsp) * sizeof(long);
 
 	guaranteed = devm_kzalloc(dev, bitmap_size, GFP_KERNEL);
-- 
2.17.1

