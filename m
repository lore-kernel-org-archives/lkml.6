Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E865C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 17:22:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C63572133F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 17:22:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="WBT0TGuz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388388AbeLQRWD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 12:22:03 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:45964 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388299AbeLQRWA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 12:22:00 -0500
Received: by mail-pl1-f196.google.com with SMTP id a14so6428730plm.12
        for <linux-kernel@vger.kernel.org>; Mon, 17 Dec 2018 09:22:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3vpJNza9or+DqAPy2Ouz+IaFpD2uwWIrDBJByTZlu+A=;
        b=WBT0TGuzBRScvsuhIEQeJ4p5P/ED7pvZwMP1kvAA1n//d+x1KAuFV92CjrST4/Vzml
         25yzhLdHeKYAFk+jZaWo74/5nIrkljnJhwDC1jFUIYhUQ0fpKf/FUzzRyUGlPuGnpcSo
         WmX62nnHyUDu8zelXpQJOHbYsDzeBAAXBsq0E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3vpJNza9or+DqAPy2Ouz+IaFpD2uwWIrDBJByTZlu+A=;
        b=V4yfm0rdLHuG5VLmdMfSkXTaacOnIqrsWTk6pioI3tVS4tS95CTD02lb3kBmoxJ3wh
         STZVCpNG0QY1TEpUk4GCzB5pKr310rCy7qyYR6NI0hnaV2P/FHNCDmqgLd3lGtxMYmO5
         r52z9rtdtjUYhD4ZNWt81CjigttoKc25SSTnwWpy5i55gPEVtn2C2/5pyG8m2xVnnufJ
         vfzAQn4D4bfAsyUp8bCZVE06szb3dxXQZVW8K8NPoI38Ocw8YRTD/+GwN4QPSJmpjny3
         micuyFdmYbFp9YX+m6dDILMUXP32x07+cXlqv/+y5F7N2yv83McWPuvhudOiT7cgoR65
         rPAw==
X-Gm-Message-State: AA+aEWakXC0vDV84P9i2Vkh7culdjm1zfDxFtS7obAq/yaqog/ZM0uvG
        L3ppmuFg1JlGlW0UOrpU0Oaoqg==
X-Google-Smtp-Source: AFSGD/W3rAQeKcrlu6C2xJRjkJM0Wm+1HGgVskXUMBLHLFPSTZQCZlcMuiXSTGc7Vs8VZa+iY4DSlA==
X-Received: by 2002:a17:902:4681:: with SMTP id p1mr13799807pld.184.1545067319819;
        Mon, 17 Dec 2018 09:21:59 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id j6sm20526648pfg.126.2018.12.17.09.21.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 17 Dec 2018 09:21:59 -0800 (PST)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     acme@kernel.org, peterz@infradead.org, gregkh@linuxfoundation.org
Cc:     mingo@redhat.com, tglx@linutronix.de,
        alexander.shishkin@linux.intel.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, will.deacon@arm.com,
        mark.rutland@arm.com, jolsa@redhat.com, namhyung@kernel.org,
        adrian.hunter@intel.com, ast@kernel.org, hpa@zytor.com,
        suzuki.poulosi@arm.com, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [RESEND PATCH v5 6/6] perf tools: Use ioctl function to send sink information to kernel
Date:   Mon, 17 Dec 2018 10:21:46 -0700
Message-Id: <1545067306-31687-7-git-send-email-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1545067306-31687-1-git-send-email-mathieu.poirier@linaro.org>
References: <1545067306-31687-1-git-send-email-mathieu.poirier@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The communication of sink information for a trace session doesn't work when
more than one CPU is involved in the scenario due to the static nature of
sysfs.  As such communicate the sink information to each event by using the
an ioctl command.  The information sent to the kernel is the component's HW
address, which is guaranteed to be unique on the CoreSight bus and known to
the kernel.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 tools/perf/arch/arm/util/cs-etm.c | 66 +++++++++++++++++++++++++++++++++++++--
 tools/perf/util/evsel.c           |  6 ++++
 tools/perf/util/evsel.h           |  1 +
 3 files changed, 71 insertions(+), 2 deletions(-)

diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/util/cs-etm.c
index d8081c2e6d44..41e394806707 100644
--- a/tools/perf/arch/arm/util/cs-etm.c
+++ b/tools/perf/arch/arm/util/cs-etm.c
@@ -22,11 +22,13 @@
 #include "../../util/thread_map.h"
 #include "../../util/cs-etm.h"
 
+#include <stdio.h>
 #include <stdlib.h>
 #include <sys/stat.h>
 
 #define ENABLE_SINK_MAX	128
 #define CS_BUS_DEVICE_PATH "/bus/coresight/devices/"
+#define AMBA_BUS_DEVICE_PATH "/bus/amba/devices/"
 
 struct cs_etm_recording {
 	struct auxtrace_record	itr;
@@ -619,6 +621,41 @@ static FILE *cs_device__open_file(const char *name)
 
 }
 
+static int cs_etm_check_drv_config_term(const char *name, u64 *addr)
+{
+	char path[PATH_MAX];
+	const char *sysfs;
+	int err;
+	FILE *file;
+	u64 start;
+
+	/* CS devices are all found under sysFS */
+	sysfs = sysfs__mountpoint();
+	if (!sysfs)
+		return -EINVAL;
+
+	/* The resource file contains the HW start address of this component */
+	snprintf(path, PATH_MAX,
+		 "%s" AMBA_BUS_DEVICE_PATH "%s" "/resource", sysfs, name);
+
+	file = fopen(path, "r");
+	if (!file) {
+		pr_debug("Unable to open file: %s\n", path);
+		return -EINVAL;
+	}
+
+	/* We just need the first value */
+	err = fscanf(file, "%016lx", &start);
+	if (err != 1) {
+		pr_debug("Unable to get resource start value for: %s\n", path);
+		return -EINVAL;
+	}
+
+	*addr = start;
+
+	return 0;
+}
+
 static int __printf(2, 3) cs_device__print_file(const char *name, const char *fmt, ...)
 {
 	va_list args;
@@ -635,7 +672,7 @@ static int __printf(2, 3) cs_device__print_file(const char *name, const char *fm
 	return ret;
 }
 
-static int cs_etm_set_drv_config_term(struct perf_evsel_config_term *term)
+static int cs_etm_set_drv_config_term_sysfs(struct perf_evsel_config_term *term)
 {
 	int ret;
 	char enable_sink[ENABLE_SINK_MAX];
@@ -650,6 +687,21 @@ static int cs_etm_set_drv_config_term(struct perf_evsel_config_term *term)
 	return 0;
 }
 
+static int cs_etm_set_drv_config_term_ioctl(struct perf_evsel *evsel,
+					    struct perf_evsel_config_term *term)
+{
+	u64 addr;
+	int ret;
+
+	/* First check the input */
+	ret = cs_etm_check_drv_config_term(term->val.drv_cfg, &addr);
+	if (ret)
+		return ret;
+
+	/* All good, apply configuration */
+	return perf_evsel__apply_drv_config(evsel, addr);
+}
+
 int cs_etm_set_drv_config(struct perf_evsel *evsel,
 			  struct perf_evsel_config_term **err_term)
 {
@@ -660,7 +712,17 @@ int cs_etm_set_drv_config(struct perf_evsel *evsel,
 		if (term->type != PERF_EVSEL__CONFIG_TERM_DRV_CFG)
 			continue;
 
-		err = cs_etm_set_drv_config_term(term);
+		/* First try the new interface, i.e ioctl() */
+		err = cs_etm_set_drv_config_term_ioctl(evsel, term);
+		if (!err)
+			continue;
+
+		/*
+		 * Something went wrong, we are probably working with an older
+		 * kernel.  As such use the sysFS interface, which will only
+		 * work for per-thread scenarios.
+		 */
+		err = cs_etm_set_drv_config_term_sysfs(term);
 		if (err) {
 			*err_term = term;
 			break;
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 6d187059a373..8aa2b79c3314 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1195,6 +1195,12 @@ static int perf_evsel__append_filter(struct perf_evsel *evsel,
 	return -1;
 }
 
+int perf_evsel__apply_drv_config(struct perf_evsel *evsel, u64 addr)
+{
+	return perf_evsel__run_ioctl(evsel,
+				     PERF_EVENT_IOC_SET_DRV_CONFIG, &addr);
+}
+
 int perf_evsel__append_tp_filter(struct perf_evsel *evsel, const char *filter)
 {
 	return perf_evsel__append_filter(evsel, "(%s) && (%s)", filter);
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 3147ca76c6fc..6be7560bc986 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -276,6 +276,7 @@ int perf_evsel__append_tp_filter(struct perf_evsel *evsel, const char *filter);
 int perf_evsel__append_addr_filter(struct perf_evsel *evsel,
 				   const char *filter);
 int perf_evsel__apply_filter(struct perf_evsel *evsel, const char *filter);
+int perf_evsel__apply_drv_config(struct perf_evsel *evsel, u64 addr);
 int perf_evsel__enable(struct perf_evsel *evsel);
 int perf_evsel__disable(struct perf_evsel *evsel);
 
-- 
2.7.4

