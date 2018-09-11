Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11977C04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 21:50:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6C6A20880
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 21:50:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="d2K1kFp0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6C6A20880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728264AbeILCvS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 22:51:18 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:37372 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727734AbeILCvR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 22:51:17 -0400
Received: by mail-it0-f66.google.com with SMTP id h20-v6so347006itf.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Sep 2018 14:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ndon8OHIl6m5sRiniUkX7B9EbcN5ooYPsC8th1bX5sM=;
        b=d2K1kFp09lizW8A4V55ef6PUvzrTLFRWgzs8A6b7l1rYrlhTqaREKXv0vW90d19/Tj
         MgoaUKJksszvePD4w0Sb1TVfjr8nn7hc3fHEkS6y4N83R0L257Js7SbQZaUwkkHRBt+F
         zvhbtc3lmfpHHEjL1vr2hmQfgNifAA5P0V90g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ndon8OHIl6m5sRiniUkX7B9EbcN5ooYPsC8th1bX5sM=;
        b=AKNzCRmydCFbxEbJlHuRgKp4RxDEwRKj/6PJK1jCox0AJLCSNH2O7oxvll8x68wuRx
         d+gNq79JCmqIjsQJSdma27/lC4npWqLA6T2E2WF87Ko3p4967DWx6oj4lvWXdjxGKvPI
         ZBTXR0o+deFfjTrvgOq8GVHxXGlgP5JhhwRKGXtIeci2/PqcIhzGqsjNxac/ZI2CHASe
         beO/22MSQSjYpqgPAuenCb4+2KZA8j0oyZ7VS2G4B5RSUwPpqF2Ft0pdD9N9D+7uimPV
         A3S9aMPSeGz07UnBSTSKuZk4q6yqfUgFwfQhF8rHSZam4ifQCvCbDD3NUSra1LiW8ekp
         BDwA==
X-Gm-Message-State: APzg51C6nKTurTs3K9z6ZocL99DTXUx/7P32BaSsSGe3ujZ+cZ6BQss/
        8c4ox+oNlHhpLe/BeolTBrU7WA==
X-Google-Smtp-Source: ANB0VdZ66amUIb9ElbYyIK/4PAX1YO5Q08JozT21JbpnC4bjNZmhRQzpzjfN2q37i1xAVVMypYuoJw==
X-Received: by 2002:a24:2f0e:: with SMTP id j14-v6mr3337355itj.120.1536702600493;
        Tue, 11 Sep 2018 14:50:00 -0700 (PDT)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id c3-v6sm1102172itd.8.2018.09.11.14.49.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 11 Sep 2018 14:49:59 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     alexander.shishkin@linux.intel.com, suzuki.poulose@arm.com,
        gregkh@linuxfoundation.org, kim.phillips@arm.com,
        leo.yan@linaro.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] coresight: Make path enable/disable aware of operation mode
Date:   Tue, 11 Sep 2018 15:49:51 -0600
Message-Id: <1536702595-9999-2-git-send-email-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1536702595-9999-1-git-send-email-mathieu.poirier@linaro.org>
References: <1536702595-9999-1-git-send-email-mathieu.poirier@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make functions that enable and disable a path aware of the mode,
i.e sysFS or perf, they are being operated from.  That way said
mode can be communicated to device specific operations in order
to control how verbose they can be.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-etm-perf.c | 4 ++--
 drivers/hwtracing/coresight/coresight-priv.h     | 2 +-
 drivers/hwtracing/coresight/coresight.c          | 8 ++++----
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
index abe8249b893b..92affdcf2467 100644
--- a/drivers/hwtracing/coresight/coresight-etm-perf.c
+++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
@@ -304,7 +304,7 @@ static void etm_event_start(struct perf_event *event, int flags)
 	return;
 
 fail_disable_path:
-	coresight_disable_path(path);
+	coresight_disable_path(path, CS_MODE_PERF);
 fail_end_stop:
 	perf_aux_output_flag(handle, PERF_AUX_FLAG_TRUNCATED);
 	perf_aux_output_end(handle, 0);
@@ -356,7 +356,7 @@ static void etm_event_stop(struct perf_event *event, int mode)
 	}
 
 	/* Disabling the path make its elements available to other sessions */
-	coresight_disable_path(path);
+	coresight_disable_path(path, CS_MODE_PERF);
 }
 
 static int etm_event_add(struct perf_event *event, int mode)
diff --git a/drivers/hwtracing/coresight/coresight-priv.h b/drivers/hwtracing/coresight/coresight-priv.h
index c11da5564a67..acfe67646a05 100644
--- a/drivers/hwtracing/coresight/coresight-priv.h
+++ b/drivers/hwtracing/coresight/coresight-priv.h
@@ -136,7 +136,7 @@ static inline void coresight_write_reg_pair(void __iomem *addr, u64 val,
 		writel_relaxed((u32)(val >> 32), addr + hi_offset);
 }
 
-void coresight_disable_path(struct list_head *path);
+void coresight_disable_path(struct list_head *path, u32 mode);
 int coresight_enable_path(struct list_head *path, u32 mode, void *sink_data);
 struct coresight_device *coresight_get_sink(struct list_head *path);
 struct coresight_device *coresight_get_enabled_sink(bool reset);
diff --git a/drivers/hwtracing/coresight/coresight.c b/drivers/hwtracing/coresight/coresight.c
index e73ca6af4765..118b435f0887 100644
--- a/drivers/hwtracing/coresight/coresight.c
+++ b/drivers/hwtracing/coresight/coresight.c
@@ -277,7 +277,7 @@ static bool coresight_disable_source(struct coresight_device *csdev)
 	return !csdev->enable;
 }
 
-void coresight_disable_path(struct list_head *path)
+void coresight_disable_path(struct list_head *path, u32 mode)
 {
 	u32 type;
 	struct coresight_node *nd;
@@ -369,7 +369,7 @@ int coresight_enable_path(struct list_head *path, u32 mode, void *sink_data)
 out:
 	return ret;
 err:
-	coresight_disable_path(path);
+	coresight_disable_path(path, mode);
 	goto out;
 }
 
@@ -677,7 +677,7 @@ int coresight_enable(struct coresight_device *csdev)
 	return ret;
 
 err_source:
-	coresight_disable_path(path);
+	coresight_disable_path(path, CS_MODE_SYSFS);
 
 err_path:
 	coresight_release_path(path);
@@ -714,7 +714,7 @@ void coresight_disable(struct coresight_device *csdev)
 		break;
 	}
 
-	coresight_disable_path(path);
+	coresight_disable_path(path, CS_MODE_SYSFS);
 	coresight_release_path(path);
 
 out:
-- 
2.7.4

