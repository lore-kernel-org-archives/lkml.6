Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83484C6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 06:51:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26165208FA
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 06:51:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BifqwtDC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26165208FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932322AbeGCGvp (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 02:51:45 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:33521 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932194AbeGCGvk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 02:51:40 -0400
Received: by mail-pf0-f193.google.com with SMTP id b17-v6so532073pfi.0;
        Mon, 02 Jul 2018 23:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9ejno87GyeulgdnAebRnV2Zex8zHD6PleTSMZDbb+jI=;
        b=BifqwtDCFSHMcPabs1Bh9/CyM2p1LbQR/l+26FowG946FQ+3chTBAR5QgHF67sQjgc
         1WZTS37cRoMRoPoSGawITY5DNYJDJ4uEBp+rxK6IK4p7TaNc1hbP6FG0Bzppi4lOwMHr
         P5mQEbxxsavU7YncBC7U4Pe5qxmrmISwKjCOfY8++nj0DuK+R+r9eYqvhQy7VPynw1vF
         ycJZQ78QNnShCkCmIZgycwgUqfQFq9fj/pW6NQVFysY/BlcVyf576ulqC5SdTYNZ9tWH
         qptVS4XFpygMMj/H6+zAO3f7+AIMz8ce1VIhkgzj+iGw0jNqMHLoVKKqxCSOh6n2mnU0
         kvnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9ejno87GyeulgdnAebRnV2Zex8zHD6PleTSMZDbb+jI=;
        b=iHo10aVX8q+0ZKdyeM1r71dGhQT0YJ/ARVNTXIjDhNkIMzYRatgbsUmh3qOFkM6GDC
         exKR/lqfqWa9k3Xr+3v9rV17e866QO5RRKaMAHzTfjYZ8YNM8mg1Fq/4tDS51TUDH9Gq
         ZqvZDVAwPip6I5bUzj8gcVagD6eGstDvk8ixACCjzqhP2/VRaT7hCNAyA2MUxCXK1po2
         ENVn3U7Vx9aj/orn8OwDSykjiVqtjtobaTxHf2AMv/zInY3yYfpbzY6FVEzPF9Lo7RmB
         yFhMvhrWf81TN+hv6DXlft2WjyoJ8PrvQHZuqiD9rtcaxZNqZoaERRZ4ptaPV6xJvgLP
         m0XA==
X-Gm-Message-State: APt69E30Z1lXt3ZFg/vxKHxl26LwAoIErx4hmk/UrA80Kia7nPESIBmU
        7FWpHgU6gaI+RNTpHayWubtL
X-Google-Smtp-Source: AAOMgpdyHfY7IfXmh16bgzGm3fOZd/ietu45vS2ArjouRdpg9HU8P7QmfJSO18YfkBqdZYbJATKfYA==
X-Received: by 2002:a65:6243:: with SMTP id q3-v6mr21853883pgv.273.1530600699193;
        Mon, 02 Jul 2018 23:51:39 -0700 (PDT)
Received: from mylaptop.nay.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id e189-v6sm981122pfe.52.2018.07.02.23.51.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Jul 2018 23:51:38 -0700 (PDT)
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
Subject: [PATCHv3 2/4] drivers/base: utilize device tree info to shutdown devices
Date:   Tue,  3 Jul 2018 14:50:40 +0800
Message-Id: <1530600642-25090-3-git-send-email-kernelfans@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1530600642-25090-1-git-send-email-kernelfans@gmail.com>
References: <1530600642-25090-1-git-send-email-kernelfans@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit 52cdbdd49853 ("driver core: correct device's shutdown order")
places an assumption of supplier<-consumer order on the process of probe.
But it turns out to break down the parent <- child order in some scene.
E.g in pci, a bridge is enabled by pci core, and behind it, the devices
have been probed. Then comes the bridge's module, which enables extra
feature(such as hotplug) on this bridge. This will break the
parent<-children order and cause failure when "kexec -e" in some scenario.

The detailed description of the scenario:
An IBM Power9 machine on which, two drivers portdrv_pci and shpchp(a mod)
match the PCI_CLASS_BRIDGE_PCI, but neither of them success to probe due
to some issue. For this case, the bridge is moved after its children in
devices_kset. Then, when "kexec -e", a ata-disk behind the bridge can not
write back buffer in flight due to the former shutdown of the bridge which
clears the BusMaster bit.

It is a little hard to impose both "parent<-child" and "supplier<-consumer"
order on devices_kset. Take the following scene:
step0: before a consumer's probing, (note child_a is supplier of consumer_a)
  [ consumer-X, child_a, ...., child_z] [... consumer_a, ..., consumer_z, ...] supplier-X
                                         ^^^^^^^^^^ affected range ^^^^^^^^^^
step1: when probing, moving consumer-X after supplier-X
  [ child_a, ...., child_z] [.... consumer_a, ..., consumer_z, ...] supplier-X, consumer-X
step2: the children of consumer-X should be re-ordered to maintain the seq
  [... consumer_a, ..., consumer_z, ....] supplier-X  [consumer-X, child_a, ...., child_z]
step3: the consumer_a should be re-ordered to maintain the seq
  [... consumer_z, ...] supplier-X [ consumer-X, child_a, consumer_a ..., child_z]

It requires two nested recursion to drain out all out-of-order item in
"affected range". To avoid such complicated code, this patch suggests
to utilize the info in device tree, instead of using the order of
devices_kset during shutdown. It iterates the device tree, and firstly
shutdown a device's children and consumers. After this patch, the buggy
commit is hollow and left to clean.

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
 drivers/base/core.c    | 48 +++++++++++++++++++++++++++++++++++++++++++-----
 include/linux/device.h |  1 +
 2 files changed, 44 insertions(+), 5 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index a48868f..684b994 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -1446,6 +1446,7 @@ void device_initialize(struct device *dev)
 	INIT_LIST_HEAD(&dev->links.consumers);
 	INIT_LIST_HEAD(&dev->links.suppliers);
 	dev->links.status = DL_DEV_NO_DRIVER;
+	dev->shutdown = false;
 }
 EXPORT_SYMBOL_GPL(device_initialize);
 
@@ -2811,7 +2812,6 @@ static void __device_shutdown(struct device *dev)
 	 * lock is to be held
 	 */
 	parent = get_device(dev->parent);
-	get_device(dev);
 	/*
 	 * Make sure the device is off the kset list, in the
 	 * event that dev->*->shutdown() doesn't remove it.
@@ -2842,23 +2842,60 @@ static void __device_shutdown(struct device *dev)
 			dev_info(dev, "shutdown\n");
 		dev->driver->shutdown(dev);
 	}
-
+	dev->shutdown = true;
 	device_unlock(dev);
 	if (parent)
 		device_unlock(parent);
 
-	put_device(dev);
 	put_device(parent);
 	spin_lock(&devices_kset->list_lock);
 }
 
+/* shutdown dev's children and consumer firstly, then itself */
+static int device_for_each_child_shutdown(struct device *dev)
+{
+	struct klist_iter i;
+	struct device *child;
+	struct device_link *link;
+
+	/* already shutdown, then skip this sub tree */
+	if (dev->shutdown)
+		return 0;
+
+	if (!dev->p)
+		goto check_consumers;
+
+	/* there is breakage of lock in __device_shutdown(), and the redundant
+	 * ref++ on srcu protected consumer is harmless since shutdown is not
+	 * hot path.
+	 */
+	get_device(dev);
+
+	klist_iter_init(&dev->p->klist_children, &i);
+	while ((child = next_device(&i)))
+		device_for_each_child_shutdown(child);
+	klist_iter_exit(&i);
+
+check_consumers:
+	list_for_each_entry_rcu(link, &dev->links.consumers, s_node) {
+		if (!link->consumer->shutdown)
+			device_for_each_child_shutdown(link->consumer);
+	}
+
+	__device_shutdown(dev);
+	put_device(dev);
+	return 0;
+}
+
 /**
  * device_shutdown - call ->shutdown() on each device to shutdown.
  */
 void device_shutdown(void)
 {
 	struct device *dev;
+	int idx;
 
+	idx = device_links_read_lock();
 	spin_lock(&devices_kset->list_lock);
 	/*
 	 * Walk the devices list backward, shutting down each in turn.
@@ -2866,11 +2903,12 @@ void device_shutdown(void)
 	 * devices offline, even as the system is shutting down.
 	 */
 	while (!list_empty(&devices_kset->list)) {
-		dev = list_entry(devices_kset->list.prev, struct device,
+		dev = list_entry(devices_kset->list.next, struct device,
 				kobj.entry);
-		__device_shutdown(dev);
+		device_for_each_child_shutdown(dev);
 	}
 	spin_unlock(&devices_kset->list_lock);
+	device_links_read_unlock(idx);
 }
 
 /*
diff --git a/include/linux/device.h b/include/linux/device.h
index 055a69d..8a0f784 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -1003,6 +1003,7 @@ struct device {
 	bool			offline:1;
 	bool			of_node_reused:1;
 	bool			dma_32bit_limit:1;
+	bool			shutdown:1; /* one direction: false->true */
 };
 
 static inline struct device *kobj_to_dev(struct kobject *kobj)
-- 
2.7.4

