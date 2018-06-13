Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 9CDEEC433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 15:09:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 533C6208B3
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 15:09:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="KRk1fgWs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 533C6208B3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964878AbeFMPJx (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 11:09:53 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:37367 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936078AbeFMPJo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 11:09:44 -0400
Received: by mail-wm0-f65.google.com with SMTP id r125-v6so6101815wmg.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jun 2018 08:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/ThhxevIU3epv9lgxlCyqJq5OSMzAnmUAMY3rX7cEds=;
        b=KRk1fgWsfsTwYcRkAC+meZ+lUFWkF/zVwMeaRQvN8CXkDYhy2L3SzmbgnRVcHFCxri
         z82SZTblgeNothGLK+VEQvQL1fCwpQrTf0KqHKZJ+XjmYUypqk6zFI1AZog1YDAcSFp2
         mRXp9QwyUsrfVYdTB2JUZRuDvJ6RAgOZrNGx4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/ThhxevIU3epv9lgxlCyqJq5OSMzAnmUAMY3rX7cEds=;
        b=Pa9IcxnAHuaAcuZSAyf3IZ9yFssZ+1mlBbldnzxbVUuXj/6mZseogBmxKsxVYfeRiZ
         yHXUzM2k11n6y/Nz4ed7sSHEjTbUN8c1KFrD7SJmZ+6z5hVukFGPZ9/wI+yuzI71Hunh
         CT319H1O8emOjPv5RjNStO/G7aaSNa7s8WOMRNy8KhZvRqTI7nmLUn7tebRnXcV3lVOA
         UHZ5HQ6C8fTXanIp6Ww/IxOCXuk9cydP4EzsUAPcJ+iqGrHiDFfOvxRSCtHlcDxl/Aw2
         Ab1zH80dMCbWo8puzLcOrk4ZJjmbJNfk6IGHxTK3mi95AqXXsRx+P9BUWW5k0x3qHU4J
         Rbng==
X-Gm-Message-State: APt69E3ueSiCpw6JvU+TminOpPf+kv7kIIZnwQxaAmPeOKaAUx6F6c6r
        edR1aEB9xgMBw0s8sChIR192kg==
X-Google-Smtp-Source: ADUXVKJKgdyqTGH+T0EBqSp3UJlLOh6FqvAhZXLly86JZKBK7/88j5JUdfhtvPtIVqB34Qv6xYe5+Q==
X-Received: by 2002:a1c:4108:: with SMTP id o8-v6mr4091174wma.50.1528902583143;
        Wed, 13 Jun 2018 08:09:43 -0700 (PDT)
Received: from mms-0440.qualcomm.mm-sol.com ([37.157.136.206])
        by smtp.gmail.com with ESMTPSA id e13-v6sm2886548wrm.45.2018.06.13.08.09.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Jun 2018 08:09:42 -0700 (PDT)
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Vikash Garodia <vgarodia@codeaurora.org>,
        Tomasz Figa <tfiga@chromium.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>
Subject: [PATCH v3 26/27] venus: core: add sdm845 DT compatible and resource data
Date:   Wed, 13 Jun 2018 18:08:00 +0300
Message-Id: <20180613150801.11702-27-stanimir.varbanov@linaro.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180613150801.11702-1-stanimir.varbanov@linaro.org>
References: <20180613150801.11702-1-stanimir.varbanov@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds sdm845 DT compatible string with it's resource
data table.

Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/media/qcom,venus.txt       |  1 +
 drivers/media/platform/qcom/venus/core.c           | 22 ++++++++++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/Documentation/devicetree/bindings/media/qcom,venus.txt b/Documentation/devicetree/bindings/media/qcom,venus.txt
index 2693449daf73..00d0d1bf7647 100644
--- a/Documentation/devicetree/bindings/media/qcom,venus.txt
+++ b/Documentation/devicetree/bindings/media/qcom,venus.txt
@@ -6,6 +6,7 @@
 	Definition: Value should contain one of:
 		- "qcom,msm8916-venus"
 		- "qcom,msm8996-venus"
+		- "qcom,sdm845-venus"
 - reg:
 	Usage: required
 	Value type: <prop-encoded-array>
diff --git a/drivers/media/platform/qcom/venus/core.c b/drivers/media/platform/qcom/venus/core.c
index 381bfdd688db..bb6add9d340e 100644
--- a/drivers/media/platform/qcom/venus/core.c
+++ b/drivers/media/platform/qcom/venus/core.c
@@ -450,9 +450,31 @@ static const struct venus_resources msm8996_res = {
 	.fwname = "qcom/venus-4.2/venus.mdt",
 };
 
+static const struct freq_tbl sdm845_freq_table[] = {
+	{ 1944000, 380000000 },	/* 4k UHD @ 60 */
+	{  972000, 320000000 },	/* 4k UHD @ 30 */
+	{  489600, 200000000 },	/* 1080p @ 60 */
+	{  244800, 100000000 },	/* 1080p @ 30 */
+};
+
+static const struct venus_resources sdm845_res = {
+	.freq_tbl = sdm845_freq_table,
+	.freq_tbl_size = ARRAY_SIZE(sdm845_freq_table),
+	.clks = {"core", "iface", "bus" },
+	.clks_num = 3,
+	.max_load = 2563200,
+	.hfi_version = HFI_VERSION_4XX,
+	.vmem_id = VIDC_RESOURCE_NONE,
+	.vmem_size = 0,
+	.vmem_addr = 0,
+	.dma_mask = 0xe0000000 - 1,
+	.fwname = "qcom/venus-5.2/venus.mdt",
+};
+
 static const struct of_device_id venus_dt_match[] = {
 	{ .compatible = "qcom,msm8916-venus", .data = &msm8916_res, },
 	{ .compatible = "qcom,msm8996-venus", .data = &msm8996_res, },
+	{ .compatible = "qcom,sdm845-venus", .data = &sdm845_res, },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, venus_dt_match);
-- 
2.14.1

