Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BE63C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 11:44:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC0DE20896
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 11:44:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="CISB1Njq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC0DE20896
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754519AbeGILoC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 07:44:02 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:42312 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754467AbeGILn7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 07:43:59 -0400
Received: by mail-pf0-f193.google.com with SMTP id l9-v6so1872952pff.9
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jul 2018 04:43:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=RqHvCXWgQNEn4X6AU/ZqYttyBtBVtMakbjX0moav5Ps=;
        b=CISB1Njq3EwhHIEELfi+QKNGw0UrCiOaotNAGzoY0sPV0ZozSTMQ2faE6hhaQstqL/
         v+AyzosbCgoofvyt6B/5Bqeps1WHxqwaLrIASoftzwtCnjhnc3oNyvE9+iy44np0ZW15
         5Mw/FY26Z+KUf221TkM97NVawFY66L/zz6A7s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=RqHvCXWgQNEn4X6AU/ZqYttyBtBVtMakbjX0moav5Ps=;
        b=ifo7OSbXBEOjO1kgC8TPvXgBs5nOO1oS+qaVZYC18icOq/8ah3yEZdpjkFUIMb5RM2
         rvgf85gXM5lP9Co9js8mhH1dnr+X0XyI94B+1O6rQW4SNerYWZAtjKa58MdYeZxWtHp+
         uB/eypP6gboOrT2bnpxITRUArSsbRQ/2cSEhRmyZXPOHKQ9948ID2bf/TgTB7llVFKrw
         CwMzI1xYZygN/5rYxlNCBt4aKGIdEMR+Qjcqk5yW7NZtOMPBMIKt6LZ2kAvO7qvuKRa9
         wQX5QGJF4bg/a1y+CH4Bz+2vNdzHRss5kIEMG+U5l1A1moYfCLd2bmIJeSqQRVd6HWmt
         Rsrg==
X-Gm-Message-State: APt69E1+YfM9M6o8o6Fyp849yhM4MEs8kZOPuOIPNwbXYFo4/N1zshHR
        05qG6nkDG0rwLlhkglA2T3fkLUD/n54=
X-Google-Smtp-Source: AAOMgpdLroGdD313YbB27+Bk12JmU+QDaK17Yg3ziO6QQSvK4AsFTiQu988/13orqGi2Z10XctR0+g==
X-Received: by 2002:a62:dc1d:: with SMTP id t29-v6mr21149179pfg.244.1531136638539;
        Mon, 09 Jul 2018 04:43:58 -0700 (PDT)
Received: from localhost ([103.249.91.93])
        by smtp.gmail.com with ESMTPSA id z8-v6sm25592443pfg.24.2018.07.09.04.43.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Jul 2018 04:43:57 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     rnayak@codeaurora.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com,
        smohanad@codeaurora.org, vivek.gautam@codeaurora.org,
        andy.gross@linaro.org, Zhang Rui <rui.zhang@intel.com>,
        linux-pm@vger.kernel.org
Subject: [PATCH v6 1/7] thermal: tsens: Get rid of unused fields in structure
Date:   Mon,  9 Jul 2018 17:13:23 +0530
Message-Id: <a55492279160077e59fcc1e29b2c3b6d9d0f822f.1531135999.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1531135999.git.amit.kucheria@linaro.org>
References: <cover.1531135999.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1531135999.git.amit.kucheria@linaro.org>
References: <cover.1531135999.git.amit.kucheria@linaro.org>
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

