Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D7D4C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 16:14:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C271620870
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 16:14:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="WWctfzyZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C271620870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732617AbeGaRzA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 13:55:00 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40791 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732593AbeGaRy7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 13:54:59 -0400
Received: by mail-wr1-f65.google.com with SMTP id h15-v6so17261209wrs.7
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jul 2018 09:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0+4xU3LQjP5NBavrf6IET5qA3bhywT6/Vh+ut+tLFvU=;
        b=WWctfzyZtwl+wXQLK/cmDi9TO+ae3QkmWeuUnQnUhXUn/+unCAifhqbgMA7WBmLUkj
         Zxla0n5a0nlwqrKhHTtaB372wgc+n7yZcJ7cLtMJoYal3oVwHz56OBI11nOM2tpremwz
         VnOcFVQX8hUWjfcUVAh0+Nw4JNWTHJn1hfXwI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0+4xU3LQjP5NBavrf6IET5qA3bhywT6/Vh+ut+tLFvU=;
        b=Jty49wkvXinEJWv3ViyrbvGNBblGI31lDquO23EGtieJySwHv5r2V3u12IXfgd0v5L
         GsVgQ+ha0rPZE/IZahb1f7hy2kH6b1BJEQKMT45D5VHI4C4YwSNytXRiJcGkRJ6xA191
         3xf1xWRl/V3fqreL5FMTPMxzxuJT1PZzCaNTG9Xi/Oh7OV4VyQSRrmwAK8IiGcgBArJr
         A5fL9fy8oE27bfNBV96N5K9K2357ztMGO6fnZzowEGfHPX7vjpfG1P7W2slnXdcM79kv
         Jdt+jlKOWgu5Bp0Sjrus4DaVe66vR0SR2gc/ddaN/m0EI+au3NAMgvV4XWs3bDpgwHNu
         GhXA==
X-Gm-Message-State: AOUpUlGreQ5TlOceFb+636reFuFIlAABQun5IjPZHL61qHU0A8SV08U5
        gA+m5ZtCu4U30erDUM0oaNnRGA==
X-Google-Smtp-Source: AAOMgpfZ+oO0zubhhwfmXSqkm1QERp94U1Fl+6taIKIljS4DYOlxsoliLKVk7T2kHZLeVOm9vqvk6w==
X-Received: by 2002:a5d:56d0:: with SMTP id m16-v6mr2935899wrw.58.1533053637120;
        Tue, 31 Jul 2018 09:13:57 -0700 (PDT)
Received: from localhost.localdomain ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id t186-v6sm3643457wmf.14.2018.07.31.09.13.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 31 Jul 2018 09:13:56 -0700 (PDT)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     linux-pm@vger.kernel.org, gregkh@linuxfoundation.org
Cc:     rjw@rjwysocki.net, robh+dt@kernel.org, mturquette@baylibre.com,
        khilman@baylibre.com, vincent.guittot@linaro.org,
        skannan@codeaurora.org, bjorn.andersson@linaro.org,
        amit.kucheria@linaro.org, seansw@qti.qualcomm.com,
        daidavid1@codeaurora.org, evgreen@chromium.org,
        mark.rutland@arm.com, lorenzo.pieralisi@arm.com,
        abailon@baylibre.com, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, georgi.djakov@linaro.org
Subject: [PATCH v7 8/8] interconnect: Allow endpoints translation via DT
Date:   Tue, 31 Jul 2018 19:13:40 +0300
Message-Id: <20180731161340.13000-9-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180731161340.13000-1-georgi.djakov@linaro.org>
References: <20180731161340.13000-1-georgi.djakov@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently we support only platform data for specifying the interconnect
endpoints. As now the endpoints are hard-coded into the consumer driver
this may lead to complications when a single driver is used by multiple
SoCs, which may have different interconnect topology.
To avoid cluttering the consumer drivers, introduce a translation function
to help us get the board specific interconnect data from device-tree.

Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
---
 drivers/interconnect/core.c  | 62 ++++++++++++++++++++++++++++++++++++
 include/linux/interconnect.h |  7 ++++
 2 files changed, 69 insertions(+)

diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
index 9fef180cf77e..d1b6adff0a3d 100644
--- a/drivers/interconnect/core.c
+++ b/drivers/interconnect/core.c
@@ -16,6 +16,7 @@
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/slab.h>
+#include <linux/of.h>
 #include <linux/overflow.h>
 #include <linux/uaccess.h>
 
@@ -251,6 +252,67 @@ static int apply_constraints(struct icc_path *path)
 	return ret;
 }
 
+struct icc_path *of_icc_get(struct device *dev, const char *name)
+{
+	struct device_node *np = NULL;
+	struct of_phandle_args src_args, dst_args;
+	u32 src_id, dst_id;
+	int idx = 0;
+	int ret;
+
+	if (!dev || !dev->of_node)
+		return ERR_PTR(-ENODEV);
+
+	np = dev->of_node;
+
+	/*
+	 * When the consumer DT node do not have "interconnects" property
+	 * return a NULL path to skip setting constraints.
+	 */
+	if (!of_find_property(np, "interconnects", NULL))
+		return NULL;
+
+	/*
+	 * We use a combination of phandle and specifier for endpoint. For now
+	 * lets support only global ids and extend this is the future if needed
+	 * without breaking DT compatibility.
+	 */
+	if (name) {
+		idx = of_property_match_string(np, "interconnect-names", name);
+		if (idx < 0)
+			return ERR_PTR(idx);
+	}
+
+	ret = of_parse_phandle_with_args(np, "interconnects",
+					 "#interconnect-cells", idx * 2,
+					 &src_args);
+	if (ret)
+		return ERR_PTR(ret);
+
+	of_node_put(src_args.np);
+
+	if (!src_args.args_count || src_args.args_count > 1)
+		return ERR_PTR(-EINVAL);
+
+	src_id = src_args.args[0];
+
+	ret = of_parse_phandle_with_args(np, "interconnects",
+					 "#interconnect-cells", idx * 2 + 1,
+					 &dst_args);
+	if (ret)
+		return ERR_PTR(ret);
+
+	of_node_put(dst_args.np);
+
+	if (!dst_args.args_count || dst_args.args_count > 1)
+		return ERR_PTR(-EINVAL);
+
+	dst_id = dst_args.args[0];
+
+	return icc_get(dev, src_id, dst_id);
+}
+EXPORT_SYMBOL_GPL(of_icc_get);
+
 /**
  * icc_set() - set constraints on an interconnect path between two endpoints
  * @path: reference to the path returned by icc_get()
diff --git a/include/linux/interconnect.h b/include/linux/interconnect.h
index 593215371fd6..ae6744da9bc2 100644
--- a/include/linux/interconnect.h
+++ b/include/linux/interconnect.h
@@ -17,6 +17,7 @@ struct device;
 
 struct icc_path *icc_get(struct device *dev, const int src_id,
 			 const int dst_id);
+struct icc_path *of_icc_get(struct device *dev, const char *name);
 void icc_put(struct icc_path *path);
 int icc_set(struct icc_path *path, u32 avg_bw, u32 peak_bw);
 
@@ -28,6 +29,12 @@ static inline struct icc_path *icc_get(struct device *dev, const int src_id,
 	return NULL;
 }
 
+static inline struct icc_path *of_icc_get(struct device *dev,
+					  const char *name)
+{
+	return NULL;
+}
+
 static inline void icc_put(struct icc_path *path)
 {
 }
