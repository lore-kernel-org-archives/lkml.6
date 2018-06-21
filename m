Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C79C8C43141
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 00:37:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7207020883
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 00:37:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nXu4ioLb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7207020883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754291AbeFUAhu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 20:37:50 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:37374 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753960AbeFUAhs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 20:37:48 -0400
Received: by mail-pl0-f68.google.com with SMTP id 31-v6so669064plc.4;
        Wed, 20 Jun 2018 17:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=uWG/pZtGMnaY67gWRK39S9A8lkWNJYOcT6WMlvv3+BI=;
        b=nXu4ioLbIHks8alI2/LWEvhcn6vvWaRJ7MSap9qkoM1MFTJKsA6e2m06mMrBztFaqv
         mZZWHTpZzpo4czgeeN5EufEzeHx56KpHD2n9204myx6UNAqazKMNTYV3NVnznih0GsR5
         RUJT7X/mc/hIoOAbZ76OfODnqXmCRSeCza5kyVOBHAZ1jHwOquiHGopG+9l3hbpNM+FO
         6njOYFipn2z1OahpWDsRFkiJX3BbNa7sZ0DanNMBJGBKy9ujxz041o0A8awDPwOuRx6/
         IqRr4so9K+BJInAZ1JUgsCOuAK22vDeGQNcMigWfiVzJqjrDaTCLjS0Lgt7491XZs8b+
         F3Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=uWG/pZtGMnaY67gWRK39S9A8lkWNJYOcT6WMlvv3+BI=;
        b=rdFKdQoSHCDutXqSFreGVO79drpg37Hat3TxbeG16Kh4ZM7x3DaqjgIDI/RLU4k4JU
         JHyLZMq4OW7dl84iIA2GL2FgNU2zeVcH7IGtCqDfQGrJH4bt1RD40t7rfUSmJXQjwY2v
         fGjqxjywB+jKEFL3VfVzjueLH39fNhGcnvfiMsQAZi0NxtODJZpWeyuCZNLDCL9YYw4l
         02eJQksbaUrYxGd344ee2tpiGRUFsBcExdXl6p+OUILgvf/KVzZ1LW7ViXwFti6dkNjC
         l7Ltf85Z2pijgBOCFw1loelsss+rtCFghVjWlSdvrmMdQOskvK1n08dXyKRQFSNmpJlH
         v1sA==
X-Gm-Message-State: APt69E05ySXbIZA3Xjl0xeo4e0p2hgoMlTQeEsGH45xxDWLJGCj//bpL
        HOl2NCBhjJfqlFhpLgCPngw=
X-Google-Smtp-Source: ADUXVKKnCy+uJrZ2JxnPLjuaNOHNfBtloTZV0SDyFwSwc2UNqw2K99ZozFfOpJhtsexIYGKrSfDCOA==
X-Received: by 2002:a17:902:d90f:: with SMTP id c15-v6mr25740458plz.65.1529541467362;
        Wed, 20 Jun 2018 17:37:47 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:1600:17a6:2407:f707:f7f9])
        by smtp.gmail.com with ESMTPSA id d22-v6sm10447106pfl.10.2018.06.20.17.37.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Jun 2018 17:37:46 -0700 (PDT)
From:   Todd Poynor <toddpoynor@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, kernel-team@android.com,
        Todd Poynor <toddpoynor@google.com>
Subject: [PATCH v2] drivers: base: initcall_debug logs for driver probe times
Date:   Wed, 20 Jun 2018 17:35:56 -0700
Message-Id: <20180621003556.65578-1-toddpoynor@gmail.com>
X-Mailer: git-send-email 2.18.0.rc1.244.gcf134e6275-goog
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Todd Poynor <toddpoynor@google.com>

Add initcall_debug logs for each driver device probe call, for example:

   probe of a3800000.ramoops returned 1 after 3007 usecs

This replaces the previous code added to report times for deferred
probes.  It also reports OF platform bus device creates that were
formerly lumped together in a single entry for function
of_platform_default_populate_init, as well as helping to annotate other
initcalls that involve device probing.

Remove restriction on printing probe times only during initcalls, since
initcall_debug now continues to show driver timing info past the boot
phase.

Signed-off-by: Todd Poynor <toddpoynor@google.com>
---
 drivers/base/dd.c | 50 +++++++++++++++++++++--------------------------
 1 file changed, 22 insertions(+), 28 deletions(-)

Changes from v1:
* unsigned long long -> s64
* use ktime_to_us() instead of ktime_to_ns with shift
* print probe return value
* drop code that stopped output on end of initcall processing

diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index 1435d7281c66..6ea9c5cece71 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -53,7 +53,6 @@ static DEFINE_MUTEX(deferred_probe_mutex);
 static LIST_HEAD(deferred_probe_pending_list);
 static LIST_HEAD(deferred_probe_active_list);
 static atomic_t deferred_trigger_count = ATOMIC_INIT(0);
-static bool initcalls_done;
 
 /*
  * In some cases, like suspend to RAM or hibernation, It might be reasonable
@@ -62,26 +61,6 @@ static bool initcalls_done;
  */
 static bool defer_all_probes;
 
-/*
- * For initcall_debug, show the deferred probes executed in late_initcall
- * processing.
- */
-static void deferred_probe_debug(struct device *dev)
-{
-	ktime_t calltime, delta, rettime;
-	unsigned long long duration;
-
-	printk(KERN_DEBUG "deferred probe %s @ %i\n", dev_name(dev),
-	       task_pid_nr(current));
-	calltime = ktime_get();
-	bus_probe_device(dev);
-	rettime = ktime_get();
-	delta = ktime_sub(rettime, calltime);
-	duration = (unsigned long long) ktime_to_ns(delta) >> 10;
-	printk(KERN_DEBUG "deferred probe %s returned after %lld usecs\n",
-	       dev_name(dev), duration);
-}
-
 /*
  * deferred_probe_work_func() - Retry probing devices in the active list.
  */
@@ -125,11 +104,7 @@ static void deferred_probe_work_func(struct work_struct *work)
 		device_pm_move_to_tail(dev);
 
 		dev_dbg(dev, "Retrying from deferred list\n");
-		if (initcall_debug && !initcalls_done)
-			deferred_probe_debug(dev);
-		else
-			bus_probe_device(dev);
-
+		bus_probe_device(dev);
 		mutex_lock(&deferred_probe_mutex);
 
 		put_device(dev);
@@ -237,7 +212,6 @@ static int deferred_probe_initcall(void)
 	driver_deferred_probe_trigger();
 	/* Sort as many dependencies as possible before exiting initcalls */
 	flush_work(&deferred_probe_work);
-	initcalls_done = true;
 	return 0;
 }
 late_initcall(deferred_probe_initcall);
@@ -527,6 +501,23 @@ static int really_probe(struct device *dev, struct device_driver *drv)
 	return ret;
 }
 
+/*
+ * For initcall_debug, show the driver probe time.
+ */
+static int really_probe_debug(struct device *dev, struct device_driver *drv)
+{
+	ktime_t calltime, delta, rettime;
+	int ret;
+
+	calltime = ktime_get();
+	ret = really_probe(dev, drv);
+	rettime = ktime_get();
+	delta = ktime_sub(rettime, calltime);
+	printk(KERN_DEBUG "probe of %s returned %d after %lld usecs\n",
+	       dev_name(dev), ret, (s64) ktime_to_us(delta));
+	return ret;
+}
+
 /**
  * driver_probe_done
  * Determine if the probe sequence is finished or not.
@@ -585,7 +576,10 @@ int driver_probe_device(struct device_driver *drv, struct device *dev)
 		pm_runtime_get_sync(dev->parent);
 
 	pm_runtime_barrier(dev);
-	ret = really_probe(dev, drv);
+	if (initcall_debug)
+		ret = really_probe_debug(dev, drv);
+	else
+		ret = really_probe(dev, drv);
 	pm_request_idle(dev);
 
 	if (dev->parent)
-- 
2.18.0.rc1.244.gcf134e6275-goog

