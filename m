Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42227C282C4
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 12:43:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DF3C2084D
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 12:43:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727002AbfBIMne (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Feb 2019 07:43:34 -0500
Received: from terminus.zytor.com ([198.137.202.136]:54985 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726722AbfBIMne (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Feb 2019 07:43:34 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x19Cg5LY2629709
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 9 Feb 2019 04:42:05 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x19Cg4gv2629705;
        Sat, 9 Feb 2019 04:42:04 -0800
Date:   Sat, 9 Feb 2019 04:42:04 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Mathieu Poirier <tipbot@zytor.com>
Message-ID: <tip-2264439258870ed258e190491c54cfb8fc7fa955@git.kernel.org>
Cc:     mark.rutland@arm.com, will.deacon@arm.com, tglx@linutronix.de,
        adrian.hunter@intel.com, peterz@infradead.org,
        mathieu.poirier@linaro.org, suzuki.poulose@arm.com,
        mingo@kernel.org, schwidefsky@de.ibm.com,
        gregkh@linuxfoundation.org, alexander.shishkin@linux.intel.com,
        hpa@zytor.com, jolsa@redhat.com, linux-kernel@vger.kernel.org,
        acme@redhat.com, ast@kernel.org, namhyung@kernel.org,
        heiko.carstens@de.ibm.com
Reply-To: suzuki.poulose@arm.com, mingo@kernel.org,
          mathieu.poirier@linaro.org, peterz@infradead.org,
          will.deacon@arm.com, mark.rutland@arm.com, tglx@linutronix.de,
          adrian.hunter@intel.com, heiko.carstens@de.ibm.com,
          acme@redhat.com, ast@kernel.org, namhyung@kernel.org,
          hpa@zytor.com, linux-kernel@vger.kernel.org, jolsa@redhat.com,
          schwidefsky@de.ibm.com, alexander.shishkin@linux.intel.com,
          gregkh@linuxfoundation.org
In-Reply-To: <20190131184714.20388-4-mathieu.poirier@linaro.org>
References: <20190131184714.20388-4-mathieu.poirier@linaro.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] coresight: Use event attributes for sink selection
Git-Commit-ID: 2264439258870ed258e190491c54cfb8fc7fa955
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  2264439258870ed258e190491c54cfb8fc7fa955
Gitweb:     https://git.kernel.org/tip/2264439258870ed258e190491c54cfb8fc7fa955
Author:     Mathieu Poirier <mathieu.poirier@linaro.org>
AuthorDate: Thu, 31 Jan 2019 11:47:10 -0700
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 6 Feb 2019 10:00:39 -0300

coresight: Use event attributes for sink selection

This patch uses the information conveyed by perf_event::attr::config2
to select a sink to use for the session.  That way a sink can easily be
selected to be used by more than one source, something that isn't currently
possible with the sysfs implementation.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Acked-by: Peter Zijlstra <peterz@infradead.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Will Deacon <will.deacon@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-s390@vger.kernel.org
Link: http://lkml.kernel.org/r/20190131184714.20388-4-mathieu.poirier@linaro.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 drivers/hwtracing/coresight/coresight-etm-perf.c | 24 +++++++-------
 drivers/hwtracing/coresight/coresight-priv.h     |  1 +
 drivers/hwtracing/coresight/coresight.c          | 42 ++++++++++++++++++++++++
 3 files changed, 55 insertions(+), 12 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
index cdbdb28dc175..8c88bf0a1e5f 100644
--- a/drivers/hwtracing/coresight/coresight-etm-perf.c
+++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
@@ -31,11 +31,14 @@ static DEFINE_PER_CPU(struct coresight_device *, csdev_src);
 PMU_FORMAT_ATTR(cycacc,		"config:" __stringify(ETM_OPT_CYCACC));
 PMU_FORMAT_ATTR(timestamp,	"config:" __stringify(ETM_OPT_TS));
 PMU_FORMAT_ATTR(retstack,	"config:" __stringify(ETM_OPT_RETSTK));
+/* Sink ID - same for all ETMs */
+PMU_FORMAT_ATTR(sinkid,		"config2:0-31");
 
 static struct attribute *etm_config_formats_attr[] = {
 	&format_attr_cycacc.attr,
 	&format_attr_timestamp.attr,
 	&format_attr_retstack.attr,
+	&format_attr_sinkid.attr,
 	NULL,
 };
 
@@ -191,6 +194,7 @@ static void etm_free_aux(void *data)
 static void *etm_setup_aux(struct perf_event *event, void **pages,
 			   int nr_pages, bool overwrite)
 {
+	u32 id;
 	int cpu = event->cpu;
 	cpumask_t *mask;
 	struct coresight_device *sink;
@@ -201,18 +205,14 @@ static void *etm_setup_aux(struct perf_event *event, void **pages,
 		return NULL;
 	INIT_WORK(&event_data->work, free_event_data);
 
-	/*
-	 * In theory nothing prevent tracers in a trace session from being
-	 * associated with different sinks, nor having a sink per tracer.  But
-	 * until we have HW with this kind of topology we need to assume tracers
-	 * in a trace session are using the same sink.  Therefore go through
-	 * the coresight bus and pick the first enabled sink.
-	 *
-	 * When operated from sysFS users are responsible to enable the sink
-	 * while from perf, the perf tools will do it based on the choice made
-	 * on the cmd line.  As such the "enable_sink" flag in sysFS is reset.
-	 */
-	sink = coresight_get_enabled_sink(true);
+	/* First get the selected sink from user space. */
+	if (event->attr.config2) {
+		id = (u32)event->attr.config2;
+		sink = coresight_get_sink_by_id(id);
+	} else {
+		sink = coresight_get_enabled_sink(true);
+	}
+
 	if (!sink || !sink_ops(sink)->alloc_buffer)
 		goto err;
 
diff --git a/drivers/hwtracing/coresight/coresight-priv.h b/drivers/hwtracing/coresight/coresight-priv.h
index 579f34943bf1..b936c6d7e13f 100644
--- a/drivers/hwtracing/coresight/coresight-priv.h
+++ b/drivers/hwtracing/coresight/coresight-priv.h
@@ -147,6 +147,7 @@ void coresight_disable_path(struct list_head *path);
 int coresight_enable_path(struct list_head *path, u32 mode, void *sink_data);
 struct coresight_device *coresight_get_sink(struct list_head *path);
 struct coresight_device *coresight_get_enabled_sink(bool reset);
+struct coresight_device *coresight_get_sink_by_id(u32 id);
 struct list_head *coresight_build_path(struct coresight_device *csdev,
 				       struct coresight_device *sink);
 void coresight_release_path(struct list_head *path);
diff --git a/drivers/hwtracing/coresight/coresight.c b/drivers/hwtracing/coresight/coresight.c
index d7fa90be6f42..29cef898afba 100644
--- a/drivers/hwtracing/coresight/coresight.c
+++ b/drivers/hwtracing/coresight/coresight.c
@@ -11,6 +11,7 @@
 #include <linux/err.h>
 #include <linux/export.h>
 #include <linux/slab.h>
+#include <linux/stringhash.h>
 #include <linux/mutex.h>
 #include <linux/clk.h>
 #include <linux/coresight.h>
@@ -541,6 +542,47 @@ struct coresight_device *coresight_get_enabled_sink(bool deactivate)
 	return dev ? to_coresight_device(dev) : NULL;
 }
 
+static int coresight_sink_by_id(struct device *dev, void *data)
+{
+	struct coresight_device *csdev = to_coresight_device(dev);
+	unsigned long hash;
+
+	if (csdev->type == CORESIGHT_DEV_TYPE_SINK ||
+	     csdev->type == CORESIGHT_DEV_TYPE_LINKSINK) {
+
+		if (!csdev->ea)
+			return 0;
+		/*
+		 * See function etm_perf_add_symlink_sink() to know where
+		 * this comes from.
+		 */
+		hash = (unsigned long)csdev->ea->var;
+
+		if ((u32)hash == *(u32 *)data)
+			return 1;
+	}
+
+	return 0;
+}
+
+/**
+ * coresight_get_sink_by_id - returns the sink that matches the id
+ * @id: Id of the sink to match
+ *
+ * The name of a sink is unique, whether it is found on the AMBA bus or
+ * otherwise.  As such the hash of that name can easily be used to identify
+ * a sink.
+ */
+struct coresight_device *coresight_get_sink_by_id(u32 id)
+{
+	struct device *dev = NULL;
+
+	dev = bus_find_device(&coresight_bustype, NULL, &id,
+			      coresight_sink_by_id);
+
+	return dev ? to_coresight_device(dev) : NULL;
+}
+
 /*
  * coresight_grab_device - Power up this device and any of the helper
  * devices connected to it for trace operation. Since the helper devices
