Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8351C282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 23:25:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7903E2184E
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 23:25:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bstSTAmY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729214AbfBEXZP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 18:25:15 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:38052 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728791AbfBEXZH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 18:25:07 -0500
Received: by mail-pl1-f193.google.com with SMTP id e5so2231841plb.5
        for <linux-kernel@vger.kernel.org>; Tue, 05 Feb 2019 15:25:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=T/vUeT1ORrN3V6Xm/Q75X5Mtmayi18DWRftVV4tUDww=;
        b=bstSTAmYg287/AN83sioCCQF3lwhhf2bu3omT1q2J+R9zhS3UM3KxeLXvMV1ruuCeP
         QDB9q6pw561Z7x5cOmJmYEb66TIF0mE95NJIcjM6rvXIEWJvmi+v5vvWga45nhDzPjpk
         pGeIBVREElGP5np/UgeHvUFPUWjv0zt6X9g/khfZUbJ8HInsukkb3ytF6L7BcJIT3VLP
         lq6UsgdG7zTZZIWczE/p2Wm9kJ5DIHTSSUGZHGPbMxWTDdXU0LH3MR18OOlb2GZcAqMB
         zVxXOQH1ezUo3rMGCoqA8Pi4YSRsOLbStwXI4+kgSAKu36hzx3DNICh+HDzeQ/WK1WU8
         1gLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=T/vUeT1ORrN3V6Xm/Q75X5Mtmayi18DWRftVV4tUDww=;
        b=c19z85AZsJr56CxnZ6m6b3aAGEzgZX0uQuQcgCBYI0sDhdurL9pjq31TPwWLYcqbYj
         ZI/aWSBNuYdyNhLbGfoeRcqH4kfl4UzY51xvBtOKrL2ob6Pz/oIFeuXeVmnwKAIj0A9N
         h2XP7X0y8LlqUWPr33nI8OvfqkbNSWjNSWqeK7p3DLntT28maPaGtdC98vOH0wLTnUQY
         F6um8uIcVSKffosCFN0A74/uFRPQCRNpgYNXZbc+CR0HGtWfRm+5zbXdAEtrpTRLkcKv
         Hw9BkYNkhK/0VtfJothGRydU0XYaYOYltjg45gb21lv+cvoyW4zDyOoUheB8hVSq7u9e
         8fOg==
X-Gm-Message-State: AHQUAubvU71LAeQ02AKK66N/m6ePmuBs9vnTpJuT+SvuVgZe4TfyzmFu
        pRsAHltyYEx2+0oeipEnwKXtmBtF9PoWuQ==
X-Google-Smtp-Source: AHgI3IbzB+7XtiW5RnV7RAe9VN0lBfScHw6zPKsaKCB5m9oNWy6kWeYPzildgjXUwimRx4FkDyniOw==
X-Received: by 2002:a17:902:4025:: with SMTP id b34mr7698243pld.181.1549409105757;
        Tue, 05 Feb 2019 15:25:05 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id g136sm5926917pfb.154.2019.02.05.15.25.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Feb 2019 15:25:05 -0800 (PST)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 5/6] coresight: perf: Add "sinks" group to PMU directory
Date:   Tue,  5 Feb 2019 16:24:57 -0700
Message-Id: <20190205232458.7074-6-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190205232458.7074-1-mathieu.poirier@linaro.org>
References: <20190205232458.7074-1-mathieu.poirier@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a "sinks" directory entry so that users can see all the sinks
available in the system in a single place.  Individual sink are added
as they are registered with the coresight bus.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 .../hwtracing/coresight/coresight-etm-perf.c  | 82 +++++++++++++++++++
 .../hwtracing/coresight/coresight-etm-perf.h  |  6 +-
 drivers/hwtracing/coresight/coresight.c       | 18 ++++
 include/linux/coresight.h                     |  7 +-
 4 files changed, 110 insertions(+), 3 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
index f21eb28b6782..cdbdb28dc175 100644
--- a/drivers/hwtracing/coresight/coresight-etm-perf.c
+++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
@@ -14,6 +14,7 @@
 #include <linux/perf_event.h>
 #include <linux/percpu-defs.h>
 #include <linux/slab.h>
+#include <linux/stringhash.h>
 #include <linux/types.h>
 #include <linux/workqueue.h>
 
@@ -43,8 +44,18 @@ static const struct attribute_group etm_pmu_format_group = {
 	.attrs  = etm_config_formats_attr,
 };
 
+static struct attribute *etm_config_sinks_attr[] = {
+	NULL,
+};
+
+static const struct attribute_group etm_pmu_sinks_group = {
+	.name   = "sinks",
+	.attrs  = etm_config_sinks_attr,
+};
+
 static const struct attribute_group *etm_pmu_attr_groups[] = {
 	&etm_pmu_format_group,
+	&etm_pmu_sinks_group,
 	NULL,
 };
 
@@ -479,6 +490,77 @@ int etm_perf_symlink(struct coresight_device *csdev, bool link)
 	return 0;
 }
 
+static ssize_t etm_perf_sink_name_show(struct device *dev,
+				       struct device_attribute *dattr,
+				       char *buf)
+{
+	struct dev_ext_attribute *ea;
+
+	ea = container_of(dattr, struct dev_ext_attribute, attr);
+	return scnprintf(buf, PAGE_SIZE, "0x%lx\n", (unsigned long)(ea->var));
+}
+
+int etm_perf_add_symlink_sink(struct coresight_device *csdev)
+{
+	int ret;
+	unsigned long hash;
+	const char *name;
+	struct device *pmu_dev = etm_pmu.dev;
+	struct device *pdev = csdev->dev.parent;
+	struct dev_ext_attribute *ea;
+
+	if (csdev->type != CORESIGHT_DEV_TYPE_SINK &&
+	    csdev->type != CORESIGHT_DEV_TYPE_LINKSINK)
+		return -EINVAL;
+
+	if (csdev->ea != NULL)
+		return -EINVAL;
+
+	if (!etm_perf_up)
+		return -EPROBE_DEFER;
+
+	ea = devm_kzalloc(pdev, sizeof(*ea), GFP_KERNEL);
+	if (!ea)
+		return -ENOMEM;
+
+	name = dev_name(pdev);
+	/* See function coresight_get_sink_by_id() to know where this is used */
+	hash = hashlen_hash(hashlen_string(NULL, name));
+
+	ea->attr.attr.name = devm_kstrdup(pdev, name, GFP_KERNEL);
+	if (!ea->attr.attr.name)
+		return -ENOMEM;
+
+	ea->attr.attr.mode = 0444;
+	ea->attr.show = etm_perf_sink_name_show;
+	ea->var = (unsigned long *)hash;
+
+	ret = sysfs_add_file_to_group(&pmu_dev->kobj,
+				      &ea->attr.attr, "sinks");
+
+	if (!ret)
+		csdev->ea = ea;
+
+	return ret;
+}
+
+void etm_perf_del_symlink_sink(struct coresight_device *csdev)
+{
+	struct device *pmu_dev = etm_pmu.dev;
+	struct dev_ext_attribute *ea = csdev->ea;
+
+	if (csdev->type != CORESIGHT_DEV_TYPE_SINK &&
+	    csdev->type != CORESIGHT_DEV_TYPE_LINKSINK)
+		return;
+
+	if (!ea)
+		return;
+
+	sysfs_remove_file_from_group(&pmu_dev->kobj,
+				     &ea->attr.attr, "sinks");
+	csdev->ea = NULL;
+}
+
 static int __init etm_perf_init(void)
 {
 	int ret;
diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.h b/drivers/hwtracing/coresight/coresight-etm-perf.h
index da7d9336a15c..015213abe00a 100644
--- a/drivers/hwtracing/coresight/coresight-etm-perf.h
+++ b/drivers/hwtracing/coresight/coresight-etm-perf.h
@@ -59,6 +59,8 @@ struct etm_event_data {
 
 #ifdef CONFIG_CORESIGHT
 int etm_perf_symlink(struct coresight_device *csdev, bool link);
+int etm_perf_add_symlink_sink(struct coresight_device *csdev);
+void etm_perf_del_symlink_sink(struct coresight_device *csdev);
 static inline void *etm_perf_sink_config(struct perf_output_handle *handle)
 {
 	struct etm_event_data *data = perf_get_aux(handle);
@@ -70,7 +72,9 @@ static inline void *etm_perf_sink_config(struct perf_output_handle *handle)
 #else
 static inline int etm_perf_symlink(struct coresight_device *csdev, bool link)
 { return -EINVAL; }
-
+int etm_perf_add_symlink_sink(struct coresight_device *csdev)
+{ return -EINVAL; }
+void etm_perf_del_symlink_sink(struct coresight_device *csdev) {}
 static inline void *etm_perf_sink_config(struct perf_output_handle *handle)
 {
 	return NULL;
diff --git a/drivers/hwtracing/coresight/coresight.c b/drivers/hwtracing/coresight/coresight.c
index 2b0df1a0a8df..d7fa90be6f42 100644
--- a/drivers/hwtracing/coresight/coresight.c
+++ b/drivers/hwtracing/coresight/coresight.c
@@ -18,6 +18,7 @@
 #include <linux/delay.h>
 #include <linux/pm_runtime.h>
 
+#include "coresight-etm-perf.h"
 #include "coresight-priv.h"
 
 static DEFINE_MUTEX(coresight_mutex);
@@ -1167,6 +1168,22 @@ struct coresight_device *coresight_register(struct coresight_desc *desc)
 		goto err_out;
 	}
 
+	if (csdev->type == CORESIGHT_DEV_TYPE_SINK ||
+	    csdev->type == CORESIGHT_DEV_TYPE_LINKSINK) {
+		ret = etm_perf_add_symlink_sink(csdev);
+
+		if (ret) {
+			device_unregister(&csdev->dev);
+			/*
+			 * As with the above, all resources are free'd
+			 * explicitly via coresight_device_release() triggered
+			 * from put_device(), which is in turn called from
+			 * function device_unregister().
+			 */
+			goto err_out;
+		}
+	}
+
 	mutex_lock(&coresight_mutex);
 
 	coresight_fixup_device_conns(csdev);
@@ -1185,6 +1202,7 @@ EXPORT_SYMBOL_GPL(coresight_register);
 
 void coresight_unregister(struct coresight_device *csdev)
 {
+	etm_perf_del_symlink_sink(csdev);
 	/* Remove references of that device in the topology */
 	coresight_remove_conns(csdev);
 	device_unregister(&csdev->dev);
diff --git a/include/linux/coresight.h b/include/linux/coresight.h
index 46c67a764877..7b87965f7a65 100644
--- a/include/linux/coresight.h
+++ b/include/linux/coresight.h
@@ -154,8 +154,9 @@ struct coresight_connection {
  * @orphan:	true if the component has connections that haven't been linked.
  * @enable:	'true' if component is currently part of an active path.
  * @activated:	'true' only if a _sink_ has been activated.  A sink can be
-		activated but not yet enabled.  Enabling for a _sink_
-		happens when a source has been selected for that it.
+ *		activated but not yet enabled.  Enabling for a _sink_
+ *		appens when a source has been selected for that it.
+ * @ea:		Device attribute for sink representation under PMU directory.
  */
 struct coresight_device {
 	struct coresight_connection *conns;
@@ -168,7 +169,9 @@ struct coresight_device {
 	atomic_t *refcnt;
 	bool orphan;
 	bool enable;	/* true only if configured as part of a path */
+	/* sink specific fields */
 	bool activated;	/* true only if a sink is part of a path */
+	struct dev_ext_attribute *ea;
 };
 
 #define to_coresight_device(d) container_of(d, struct coresight_device, dev)
-- 
2.17.1

