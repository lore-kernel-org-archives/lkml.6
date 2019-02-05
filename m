Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53B48C282D7
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 23:25:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E0092184E
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 23:25:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LK6FWzrI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728703AbfBEXZD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 18:25:03 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:39614 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726547AbfBEXZC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 18:25:02 -0500
Received: by mail-pf1-f194.google.com with SMTP id r136so2223081pfc.6
        for <linux-kernel@vger.kernel.org>; Tue, 05 Feb 2019 15:25:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Ccqi0PrQP2++Gk2Iw5QSemotnIhaAp8U4DdCM+tifrE=;
        b=LK6FWzrII6f/kojrANilyG8yDT0cJQUmHYQy+ONwR4BZjGOyuMLSRwnQ47LBWWn6cB
         0MLGXbPqSzhkKsyg9a8NxwITiigYQP/f7ve6TGh1qrudVfLZTH2yfBzDMFO85YJGQFJa
         zGzlUAz9kS8dkIN67FaYTVzrfF8aA5+S703q2xlWUJl7e6l6ZR9QKQP6Dn69s4ao044W
         /AiV0jptZRgjqy1cAx39FyGFO76UA9vp073L/nOJEObkGN+EGe69kp80BTiDn4MP3lW7
         944PlZsE6w+hirYywhI+P9Ot2/h8SFgPEsZPCgYMhNIMyJUIxzl6LbG+6014b0wUw67S
         tXrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Ccqi0PrQP2++Gk2Iw5QSemotnIhaAp8U4DdCM+tifrE=;
        b=WChF/n4RrlfZY8yJsmF2b5lfh4ew7LY2hKGQZ6Dn/PN+l7NiZedvcC4Nr3+a/nIUPL
         tKBzG+P96kFIYFhPqmNj2+zLwH8sweyLCbv7zLXQ1tA7WmtJUh+H5JXbmFQE8KOIJZDR
         OV8os4M4EbXQ6ODlwK0evYhoi5SMJk7BUop55WOw7gssysjL39ltaoKdxTOVVgQQ1opj
         w6WOvWqrttvcCN72OoF092AcKkNORbtn3eYPWGVuL8/mVhDP2UkJzWGyxAaqAScFLAEw
         q+H9iYWKbXs8fHKHQ2n2WDmLJXLPdWdrEkKLelznliR7HjXqL+JbWggsEiam8H27bq2e
         9AAA==
X-Gm-Message-State: AHQUAuYS3IT/ogVWhAPSY1TMJTffxdFGpy6PKRK0oDe5VmfdddGPWsoZ
        drtmuuszJdqxknCaJrDVoPotuQ==
X-Google-Smtp-Source: AHgI3IYOw7BBC0PRVuH7x0KhBzpKVLHVU+AJXBxtBGrXpkPyIXo9kinLZw2ZFYGBz7osbCg8LgGG4Q==
X-Received: by 2002:a63:4706:: with SMTP id u6mr6534664pga.95.1549409101607;
        Tue, 05 Feb 2019 15:25:01 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id g136sm5926917pfb.154.2019.02.05.15.25.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Feb 2019 15:25:00 -0800 (PST)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/6] coresight: cpu-debug: Support for CA73 CPUs
Date:   Tue,  5 Feb 2019 16:24:53 -0700
Message-Id: <20190205232458.7074-2-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190205232458.7074-1-mathieu.poirier@linaro.org>
References: <20190205232458.7074-1-mathieu.poirier@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Leo Yan <leo.yan@linaro.org>

This patch is to add the AMBA device ID for CA73 CPU, so that CPU debug
module can be initialized successfully when a SoC contain CA73 CPUs.

This patch has been verified on 96boards Hikey960.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-cpu-debug.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/hwtracing/coresight/coresight-cpu-debug.c b/drivers/hwtracing/coresight/coresight-cpu-debug.c
index 45b2460f3166..e8819d750938 100644
--- a/drivers/hwtracing/coresight/coresight-cpu-debug.c
+++ b/drivers/hwtracing/coresight/coresight-cpu-debug.c
@@ -668,6 +668,10 @@ static const struct amba_id debug_ids[] = {
 		.id	= 0x000bbd08,
 		.mask	= 0x000fffff,
 	},
+	{       /* Debug for Cortex-A73 */
+		.id	= 0x000bbd09,
+		.mask	= 0x000fffff,
+	},
 	{ 0, 0 },
 };
 
-- 
2.17.1

