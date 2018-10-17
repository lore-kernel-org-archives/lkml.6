Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2A22C5ACC6
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 01:24:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9034E214FF
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 01:24:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nP4EKuPD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9034E214FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727252AbeJQJRr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 05:17:47 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:38710 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727108AbeJQJRq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 05:17:46 -0400
Received: by mail-pf1-f194.google.com with SMTP id f29-v6so12337177pff.5;
        Tue, 16 Oct 2018 18:24:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vFfDD2gWNfwOEnszdMRio65CHH3Wl6oxXiNH3dNN12o=;
        b=nP4EKuPDeVqog11yorrYjuFKGgHU7wbO92gSQ7NGyEHUxPha3ll9A8k9eLoFf+snU4
         j0HpNQaBvvrPd5+4Ut2UE7OSWRWCRQBWvT4llYsMNpea2rbVbr1zxbyHHqaGIXbEedJI
         rC1qoYV07v4ze/nB3ZJwy/EX12EeX6Banbf02fphY3firix0fO5imkff5MhV7pKuQjZS
         mtUnib9vyHCVH6X4NeK476tONzqXb9iKsPuHK7iftn0awSvObYZY5xpOEJ4LOa8Kxzcn
         jyJXE2Tu1iNDAd5R4Em8qoKFqwSF/CNMn+VRf4y+5Q94sjah7bkgDLiSKfo84Kx5U71M
         SC5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vFfDD2gWNfwOEnszdMRio65CHH3Wl6oxXiNH3dNN12o=;
        b=IW5kPqIWsGbTQmHLyz8ie3dnhs/+YCgbrLAvwjEwiaWUF02CQZ+IGcrLoXe6KDnrG2
         bIF/FFTeYupRn+O8nDjwG97qSxjqQDie/YGvbgtOAyBNZ6l2sy9N9Buk8HPjaCUND5p7
         zJ0QxL45gzpPyUztR5++9HFHy/SY0UYZjv/nlRbNElXxwn8Hmi3Cpzh1jYNEfy54eGdb
         efEipfvp99+KtDiIlb+LCvzemlHLzrtzFKh5Q0zwCdr3gpL/ZxWpHRBfbmlegmruDuXb
         +LcTjmT78Rew3RZLc/vzqs1nkzsJRVgsvvvJv7zZrqy0XfQa9mQBzMirln8/uqN0rFaX
         5RVA==
X-Gm-Message-State: ABuFfohpNaZ9ufgLRoiPDgU40oeHUdC43HmBZmvPoHKc7cGteIbjkI1V
        kO7K/f+VYQoc48gTyN0cVR8=
X-Google-Smtp-Source: ACcGV613fZR3oQfqCsO7fgrCzWQhizzLnMIqix6UiPwKrdiJF7A9c5esIvSAOhThPUSvL/wfJTZEXg==
X-Received: by 2002:a62:5ac6:: with SMTP id o189-v6mr24936315pfb.40.1539739476075;
        Tue, 16 Oct 2018 18:24:36 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id n64-v6sm22841851pfi.185.2018.10.16.18.24.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Oct 2018 18:24:35 -0700 (PDT)
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     jdelvare@suse.com, linux@roeck-us.net
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] hwmon: (ina3221) Make sure data is ready after channel enabling
Date:   Tue, 16 Oct 2018 18:24:25 -0700
Message-Id: <20181017012426.26958-5-nicoleotsuka@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181017012426.26958-1-nicoleotsuka@gmail.com>
References: <20181017012426.26958-1-nicoleotsuka@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The data might need some time to get ready after channel enabling,
although the data register is readable without CVRF being set. So
this patch adds a CVRF polling to make sure that data register is
updated with the new data.

Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
---
 drivers/hwmon/ina3221.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/hwmon/ina3221.c b/drivers/hwmon/ina3221.c
index 5fc375bf6635..160ddc404d73 100644
--- a/drivers/hwmon/ina3221.c
+++ b/drivers/hwmon/ina3221.c
@@ -45,6 +45,7 @@
 #define INA3221_CONFIG_MODE_BUS		BIT(1)
 #define INA3221_CONFIG_MODE_CONTINUOUS	BIT(2)
 #define INA3221_CONFIG_CHx_EN(x)	BIT(14 - (x))
+#define INA3221_CONFIG_CHs_EN_MASK	GENMASK(14, 12)
 
 #define INA3221_RSHUNT_DEFAULT		10000
 
@@ -52,6 +53,9 @@ enum ina3221_fields {
 	/* Configuration */
 	F_RST,
 
+	/* Status Flags */
+	F_CVRF,
+
 	/* Alert Flags */
 	F_WF3, F_WF2, F_WF1,
 	F_CF3, F_CF2, F_CF1,
@@ -63,6 +67,7 @@ enum ina3221_fields {
 static const struct reg_field ina3221_reg_fields[] = {
 	[F_RST] = REG_FIELD(INA3221_CONFIG, 15, 15),
 
+	[F_CVRF] = REG_FIELD(INA3221_MASK_ENABLE, 0, 0),
 	[F_WF3] = REG_FIELD(INA3221_MASK_ENABLE, 3, 3),
 	[F_WF2] = REG_FIELD(INA3221_MASK_ENABLE, 4, 4),
 	[F_WF1] = REG_FIELD(INA3221_MASK_ENABLE, 5, 5),
@@ -111,6 +116,19 @@ static inline bool ina3221_is_enabled(struct ina3221_data *ina, int channel)
 	return ina->reg_config & INA3221_CONFIG_CHx_EN(channel);
 }
 
+static inline int ina3221_wait_for_data_if_active(struct ina3221_data *ina)
+{
+	u32 cvrf;
+
+	/* No need to wait if all channels are disabled */
+	if ((ina->reg_config & INA3221_CONFIG_CHs_EN_MASK) == 0)
+		return 0;
+
+	/* Polling the CVRF bit to make sure read data is ready */
+	return regmap_field_read_poll_timeout(ina->fields[F_CVRF],
+					      cvrf, cvrf, 100, 100000);
+}
+
 static int ina3221_read_value(struct ina3221_data *ina, unsigned int reg,
 			      int *val)
 {
@@ -258,6 +276,13 @@ static int ina3221_write_enable(struct device *dev, int channel, bool enable)
 	if (ret)
 		return ret;
 
+	/* Make sure data conversion is finished */
+	ret = ina3221_wait_for_data_if_active(ina);
+	if (ret) {
+		dev_err(dev, "Timed out at waiting for CVRF bit\n");
+		return ret;
+	}
+
 	return 0;
 }
 
@@ -676,6 +701,13 @@ static int __maybe_unused ina3221_resume(struct device *dev)
 	if (ret)
 		return ret;
 
+	/* Make sure data conversion is finished */
+	ret = ina3221_wait_for_data_if_active(ina);
+	if (ret) {
+		dev_err(dev, "Timed out at waiting for CVRF bit\n");
+		return ret;
+	}
+
 	return 0;
 }
 
-- 
2.17.1

