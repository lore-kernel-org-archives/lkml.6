Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6018CC6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 06:51:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F368208FA
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 06:51:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J6Fzle3x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F368208FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754456AbeGCGvi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 02:51:38 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:36817 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752719AbeGCGvf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 02:51:35 -0400
Received: by mail-pf0-f194.google.com with SMTP id u16-v6so529777pfh.3;
        Mon, 02 Jul 2018 23:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ekKHE1upI1u6JQRCI10SmXBvRXgm/pCCr/snxtYlQNI=;
        b=J6Fzle3xuXyBrIfVUrAKawmeVV6kFzHf3JZVhUDigezTcrC9fNJ5fdbeVU3Drd0kKV
         X6G5GsecuddQm1du9kG7HkYKiGIKEjPtc7/IhravSKUIqWPlyTgwuSEyIsAteZ3f0kTF
         DsewFtxM2fuS0UqKGEBy9SNSBr9p5JMTO0G8y3n+C2H2AYJmWne+MOYP5JvoYNf6ee+I
         /C8B/xhiGbjUPu5Q26gmSUkVnTTEYQ2NoL31172BC2b1jqN/+BLScnoaPK6zdjpAR3iI
         +lZKe44PrLi+LRGiC/gB3Kc0JM7ODliHZFLZf3qUelGzuxPkzu3TMriTuIClaOnl6gp7
         PT0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ekKHE1upI1u6JQRCI10SmXBvRXgm/pCCr/snxtYlQNI=;
        b=SQmwSYNQ1vt+GalF4HWt4+qF888MTZqxDcbU34hk/MWRFwELSwTNIwsWmAkkH+dlVI
         6Lct3o2HVY9nfRkfKmVH+vN9b3dKss8nWbCdJl60pRbZOQaTHDTnvgQCB0gO55L1MuXg
         /GRNrEsZnB1NY9a9tp4Oi0cNC5lYwG/nEUYEBJg8Kjj0lvU7gwaF+pwyrE233I9K6DPI
         C27N5Wppr6jThts8pUoL4C7efZ4FsdoiGMr7WM/hB9zGjMK9BZXcRgSPkrusgpctkIbc
         zf2FMGhIUf2NBNqlsbBdjCrnszg2/BgjCb5zaJXYFqh+0ZryFXzeI0GvWInnOEsgonF9
         Z+BA==
X-Gm-Message-State: APt69E2UjAIZsx848elmeCmjajBDmDLaCFO4aU6P3wfBvCwvLkLSqbkn
        w1UqRJUbFW7jcJspSPfdnVof
X-Google-Smtp-Source: AAOMgpcXhK2+wv6kn1QNTEtwzk89l3S+HwU2Q0sPNI/o4r91egKKDeLLprRI33urfADgU5fGOwDxUg==
X-Received: by 2002:a62:3101:: with SMTP id x1-v6mr28007532pfx.246.1530600694598;
        Mon, 02 Jul 2018 23:51:34 -0700 (PDT)
Received: from mylaptop.nay.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id e189-v6sm981122pfe.52.2018.07.02.23.51.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Jul 2018 23:51:34 -0700 (PDT)
From:   Pingfan Liu <kernelfans@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Pingfan Liu <kernelfans@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Christoph Hellwig <hch@infradead.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Dave Young <dyoung@redhat.com>, linux-pci@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCHv3 1/4] drivers/base: fold the routine of device's shutdown into a func
Date:   Tue,  3 Jul 2018 14:50:39 +0800
Message-Id: <1530600642-25090-2-git-send-email-kernelfans@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1530600642-25090-1-git-send-email-kernelfans@gmail.com>
References: <1530600642-25090-1-git-send-email-kernelfans@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pack the code into a function to ease the using and reading.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: Christoph Hellwig <hch@infradead.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>
Cc: Dave Young <dyoung@redhat.com>
Cc: linux-pci@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
---
 drivers/base/core.c | 100 +++++++++++++++++++++++++++-------------------------
 1 file changed, 52 insertions(+), 48 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index df3e1a4..a48868f 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -2802,12 +2802,62 @@ int device_move(struct device *dev, struct device *new_parent,
 }
 EXPORT_SYMBOL_GPL(device_move);
 
+static void __device_shutdown(struct device *dev)
+{
+	struct device *parent;
+	/*
+	 * hold reference count of device's parent to
+	 * prevent it from being freed because parent's
+	 * lock is to be held
+	 */
+	parent = get_device(dev->parent);
+	get_device(dev);
+	/*
+	 * Make sure the device is off the kset list, in the
+	 * event that dev->*->shutdown() doesn't remove it.
+	 */
+	list_del_init(&dev->kobj.entry);
+	spin_unlock(&devices_kset->list_lock);
+
+	/* hold lock to avoid race with probe/release */
+	if (parent)
+		device_lock(parent);
+	device_lock(dev);
+
+	/* Don't allow any more runtime suspends */
+	pm_runtime_get_noresume(dev);
+	pm_runtime_barrier(dev);
+
+	if (dev->class && dev->class->shutdown_pre) {
+		if (initcall_debug)
+			dev_info(dev, "shutdown_pre\n");
+		dev->class->shutdown_pre(dev);
+	}
+	if (dev->bus && dev->bus->shutdown) {
+		if (initcall_debug)
+			dev_info(dev, "shutdown\n");
+		dev->bus->shutdown(dev);
+	} else if (dev->driver && dev->driver->shutdown) {
+		if (initcall_debug)
+			dev_info(dev, "shutdown\n");
+		dev->driver->shutdown(dev);
+	}
+
+	device_unlock(dev);
+	if (parent)
+		device_unlock(parent);
+
+	put_device(dev);
+	put_device(parent);
+	spin_lock(&devices_kset->list_lock);
+}
+
 /**
  * device_shutdown - call ->shutdown() on each device to shutdown.
  */
 void device_shutdown(void)
 {
-	struct device *dev, *parent;
+	struct device *dev;
 
 	spin_lock(&devices_kset->list_lock);
 	/*
@@ -2818,53 +2868,7 @@ void device_shutdown(void)
 	while (!list_empty(&devices_kset->list)) {
 		dev = list_entry(devices_kset->list.prev, struct device,
 				kobj.entry);
-
-		/*
-		 * hold reference count of device's parent to
-		 * prevent it from being freed because parent's
-		 * lock is to be held
-		 */
-		parent = get_device(dev->parent);
-		get_device(dev);
-		/*
-		 * Make sure the device is off the kset list, in the
-		 * event that dev->*->shutdown() doesn't remove it.
-		 */
-		list_del_init(&dev->kobj.entry);
-		spin_unlock(&devices_kset->list_lock);
-
-		/* hold lock to avoid race with probe/release */
-		if (parent)
-			device_lock(parent);
-		device_lock(dev);
-
-		/* Don't allow any more runtime suspends */
-		pm_runtime_get_noresume(dev);
-		pm_runtime_barrier(dev);
-
-		if (dev->class && dev->class->shutdown_pre) {
-			if (initcall_debug)
-				dev_info(dev, "shutdown_pre\n");
-			dev->class->shutdown_pre(dev);
-		}
-		if (dev->bus && dev->bus->shutdown) {
-			if (initcall_debug)
-				dev_info(dev, "shutdown\n");
-			dev->bus->shutdown(dev);
-		} else if (dev->driver && dev->driver->shutdown) {
-			if (initcall_debug)
-				dev_info(dev, "shutdown\n");
-			dev->driver->shutdown(dev);
-		}
-
-		device_unlock(dev);
-		if (parent)
-			device_unlock(parent);
-
-		put_device(dev);
-		put_device(parent);
-
-		spin_lock(&devices_kset->list_lock);
+		__device_shutdown(dev);
 	}
 	spin_unlock(&devices_kset->list_lock);
 }
-- 
2.7.4

