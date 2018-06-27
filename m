Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD14DC43144
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 15:29:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75EDD2147E
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 15:29:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="kqKttLXt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75EDD2147E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965522AbeF0P24 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 11:28:56 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:46865 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965301AbeF0P23 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 11:28:29 -0400
Received: by mail-wr0-f193.google.com with SMTP id t6-v6so2461982wrq.13
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jun 2018 08:28:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/ThhxevIU3epv9lgxlCyqJq5OSMzAnmUAMY3rX7cEds=;
        b=kqKttLXtWlwynBGpetiSwDEInrvnGlExomqQ0eXXLx75B7dByD8TUBFz9yH3AvtO6o
         Oa561AwyMYsTR+3nEkbz4X/yVdnwMF9wWcL4gomFwhKERK3dxebO72DRrljqYy4jRt6E
         k28iDwZEbrkbol3gjFIwuM0wpgJ61K377uZTo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/ThhxevIU3epv9lgxlCyqJq5OSMzAnmUAMY3rX7cEds=;
        b=oHEy+Upl/Dths/b2oj4a+HazPAgHp7UJ2UIF9uZYWJ3E+Woxx6odGzXyAgsLTKTyPe
         ACXqe9lYs5CiBYqK0nBGo/EOO8Iz6/wUkT5T1tTFoHn8ooooIZsiGRihy3GFwnrtW7tk
         zevXKIrcDaaBw0nX1gAux3APJ6dZyEJh7l8fZ+k1J6T3eSj3kkpcy4VhvhcFtUdcDN+S
         p9ogUdE/P1dfjao/g1ah8WSGMct3ULgQ+6LKgKtv8hf6CONeXIdb/UEZDlTXOACneUYq
         UrgdvMuV+ZD5TAm93JRYkRJXO4gVNeLqb9XpHLG113BCu04fleB1HuFviSsuAAhILnzW
         CJew==
X-Gm-Message-State: APt69E0hcbo0OeQSS8iSi4n8fXN+kvLe714/wXcambadDQ/e0a8B7m5X
        0pBzhcKTIu3YGPix0VaSvdYPXg==
X-Google-Smtp-Source: AAOMgpe+l2sAy31WAlyOMo7Jj56Yz4zxEyNfNLt5V3nmz9OhtCt9fOUJNJ39Ud/hJ2FqNjoGBpTXzQ==
X-Received: by 2002:adf:83c5:: with SMTP id 63-v6mr5421441wre.220.1530113308623;
        Wed, 27 Jun 2018 08:28:28 -0700 (PDT)
Received: from mms-0440.qualcomm.mm-sol.com ([37.157.136.206])
        by smtp.gmail.com with ESMTPSA id o203-v6sm2916075wmd.30.2018.06.27.08.28.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Jun 2018 08:28:28 -0700 (PDT)
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Vikash Garodia <vgarodia@codeaurora.org>,
        Tomasz Figa <tfiga@chromium.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>
Subject: [PATCH v4 26/27] venus: core: add sdm845 DT compatible and resource data
Date:   Wed, 27 Jun 2018 18:27:24 +0300
Message-Id: <20180627152725.9783-27-stanimir.varbanov@linaro.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180627152725.9783-1-stanimir.varbanov@linaro.org>
References: <20180627152725.9783-1-stanimir.varbanov@linaro.org>
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

