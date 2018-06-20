Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E71EFC1B0F1
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 02:39:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A221B205C9
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 02:39:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aw7WMQtm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A221B205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754315AbeFTCjZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 22:39:25 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:38550 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754240AbeFTCjV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 22:39:21 -0400
Received: by mail-pl0-f67.google.com with SMTP id d10-v6so891451plo.5;
        Tue, 19 Jun 2018 19:39:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=A8v3wakaTcXuBObrrt6OwOnjuJ1SiXmHqQaUOF8hq54=;
        b=aw7WMQtmwG7LIf4911gr/U1I6brRYihWNgrh7J4nlv9zmgofZkqe3EgIHaLDVohd45
         h5pI6xtqsGwiru3JT0r9zBISsPrvZTeBAHZdBoPNvU6D92tpZx4e38/iOsLwjbCSyV+A
         42TDlAaE7Znxd+iGsCdVIs9TOq0tnsKIsmuzv/9bmZztq2AJpybUCz2aaTniBLW1bKsJ
         tqZMjSu8eG9d728MqN45RL+jM/iHQ34DNZQrNXiB2wmsyg0loqkPb/Epfstwigl0/LX3
         OrkfUUX2T1HsAO0iwMoqdWuafy9zPBukkLiYIRHzX1aa9v9p8nhN1nfAK8UZbh8JvW91
         lUTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=A8v3wakaTcXuBObrrt6OwOnjuJ1SiXmHqQaUOF8hq54=;
        b=k+a5odA5m15aznM0x13AkAD5PGdjIEdV5Bgha+eUyU9Aa/7IPRMVsXderwIzlMhn6V
         9oLOrn+lIzCBMjx9O91W6XAFx6VZRh09dCaWhwL6I5uHO6PmmCpW6YyY/fBXiIDBlr7c
         U3RKmsiX2URYJegspR/rHAgWToHxnb7tPDqT+qoWUGMs9vehGkxlnfCq/ArzDIAwjhMI
         fzUY4JWi9JYixlxopGn7Qiar5tV/UzzjFJW5DZaaXjvOLCoZF9JpUr016fy5kjm3HL6B
         nXRUguCRT9rbCQ2j3TIVL1z3rFcGtv0bX1Rh2QVsuPRtxeL3SjsX1/TTIUDOWUw/1bhT
         uJeA==
X-Gm-Message-State: APt69E0Z08iEGGjnuV9DHjIW6Heflmjq423pUJ7LhEdnCXX1fsHBtklr
        UozHWa/RFjg9ykp2Rtn3RHU=
X-Google-Smtp-Source: ADUXVKKsVUsSBlCcrT+VCPQbJCMmvtJaiyumegO3WD+i2IQ3VeqKKwONHxClzl4rPt53ju0Z6sk3xQ==
X-Received: by 2002:a17:902:b604:: with SMTP id b4-v6mr21453988pls.18.1529462360157;
        Tue, 19 Jun 2018 19:39:20 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:1600:17a6:2407:f707:f7f9])
        by smtp.gmail.com with ESMTPSA id w125-v6sm923835pgb.92.2018.06.19.19.39.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Jun 2018 19:39:19 -0700 (PDT)
From:   Todd Poynor <toddpoynor@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, kernel-team@android.com,
        Todd Poynor <toddpoynor@google.com>
Subject: [PATCH] drivers: base: initcall_debug logs for driver probe times
Date:   Tue, 19 Jun 2018 19:39:03 -0700
Message-Id: <20180620023903.242758-1-toddpoynor@gmail.com>
X-Mailer: git-send-email 2.18.0.rc1.244.gcf134e6275-goog
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Todd Poynor <toddpoynor@google.com>

Add initcall_debug logs for each driver device probe call, for example:

   probe of a3800000.ramoops returned after 3007 usecs

This replaces the previous code added to report times for deferred
probes.  It also reports OF platform bus device creates that were
formerly lumped together in a single entry for function
of_platform_default_populate_init, as well as helping to annotate other
initcalls that involve device probing.

Signed-off-by: Todd Poynor <toddpoynor@google.com>
---
 drivers/base/dd.c | 50 +++++++++++++++++++++++------------------------
 1 file changed, 24 insertions(+), 26 deletions(-)

diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index 1435d7281c66..56db446a467a 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -62,26 +62,6 @@ static bool initcalls_done;
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
@@ -125,11 +105,7 @@ static void deferred_probe_work_func(struct work_struct *work)
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
@@ -527,6 +503,25 @@ static int really_probe(struct device *dev, struct device_driver *drv)
 	return ret;
 }
 
+/*
+ * For initcall_debug, show the driver probe time.
+ */
+static int really_probe_debug(struct device *dev, struct device_driver *drv)
+{
+	ktime_t calltime, delta, rettime;
+	unsigned long long duration;
+	int ret;
+
+	calltime = ktime_get();
+	ret = really_probe(dev, drv);
+	rettime = ktime_get();
+	delta = ktime_sub(rettime, calltime);
+	duration = (unsigned long long) ktime_to_ns(delta) >> 10;
+	printk(KERN_DEBUG "probe of %s returned after %lld usecs\n",
+	       dev_name(dev), duration);
+	return ret;
+}
+
 /**
  * driver_probe_done
  * Determine if the probe sequence is finished or not.
@@ -585,7 +580,10 @@ int driver_probe_device(struct device_driver *drv, struct device *dev)
 		pm_runtime_get_sync(dev->parent);
 
 	pm_runtime_barrier(dev);
-	ret = really_probe(dev, drv);
+	if (initcall_debug && !initcalls_done)
+		ret = really_probe_debug(dev, drv);
+	else
+		ret = really_probe(dev, drv);
 	pm_request_idle(dev);
 
 	if (dev->parent)
-- 
2.18.0.rc1.244.gcf134e6275-goog

