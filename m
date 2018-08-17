Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9655AC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 10:28:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BC63208DB
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 10:28:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BC63208DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727461AbeHQNbK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 09:31:10 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:59335 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727032AbeHQNab (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 09:30:31 -0400
Received: from wuerfel.lan ([109.193.40.16]) by mrelayeu.kundenserver.de
 (mreue101 [212.227.15.145]) with ESMTPA (Nemesis) id
 0MAdid-1fjhxn3cuR-00BsPO; Fri, 17 Aug 2018 12:27:16 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linuxppc-dev@lists.ozlabs.org, linux-acpi@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>
Subject: [RFC 04/15] PCI: export pci_register_host_bridge
Date:   Fri, 17 Aug 2018 12:26:34 +0200
Message-Id: <20180817102645.3839621-5-arnd@arndb.de>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180817102645.3839621-1-arnd@arndb.de>
References: <20180817102645.3839621-1-arnd@arndb.de>
X-Provags-ID: V03:K1:qV+QiFpoLBNDT+pnsfxk7Q12Wr+Zfztf79RikKLfT1kBpbTwKUM
 iZEEf/AFkASGLvQTzHO6lI+OsNf423ev36D4uMlANybis7iSjomPpFGobYlMVXCwQdTCqSd
 ugZbMhW+33xetnzQSUdMeicQ786GrhuoT6iTK6eAwaMormNmf16uMK5AaJlveZ1uMEi0UOl
 d7rj/WjNLBnDisKLuP0zg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:6viyPx4Qb74=:ccCWwxVG4h9e67s1aeOEA5
 DSD5frqpk3rf+CElY2taeu1iNYf0RDqjWPk1AQkQlRZIT8V6ygBWKhYW8+niK8SPrhzEefQoN
 MTAzJhGQjUG5mJz4neuPJrfWfvoRyWWno3raPfFD4IBjJzeE+wQ5wSD5PVhe19BsXlubY02g8
 5MO+LdODz2tWxlOkI+FGaNMHD3AUyYbfeZFVfCVihpH50sWaTbfhg9dfHCMQlN3Ux8fH+iDcz
 CzK2NJmTJLXfvDYvkbuBwOQsXeMCOMgWI0S787/Hu3SxiX6sgA0WyOQsvPnufZss/8nagJgzF
 pmhXqG5ei/dM3MxDDeER5wKJlSfFLLZV9YBysTjF+RyUu0srfhAgAK/0VoLg/xLf8+W+ss8S6
 cT6Eop6PKWq7TliAkzqtHUgUqQKfTg63eGJ+bxelz36NgAJhtrdwfjUrvcK8GvIo9n6ofst7f
 M+ZpnwtofMJalysbiNMd0/U5C+LZvQIDyhBnjN+ztTMX161kKMmQQRMGt9bU5zlGebSHJML9t
 uxwQ3exwP8EM1g/36YZc/Juqs5Obu3SVHVwOM1GmpgDg6RViN0CBJ9wm0T9fA1B4qvj9y5YX3
 okKhgiwMMZCJUT1fjABTxHH38aHmgTpoprIuHZ9tZSVc1oJT/y7nNxmLlGE+AtLIOIUiyAUVu
 8M9riaC7jjFCIl60jk8C9N1eE/iRsPX3qGaPVVog7/SbWPtLeyy25TBnk4ZFk760HgD0=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are a couple of users of the old pci_create_root_bus() interface,
which calls pci_register_host_bridge() without actually scanning the bus.

In order to get those callers a little closer to the current method
of separating the allocation and probing of the host bridge, this
exports the internal interface to modules. If all the callers can
get moved over to pci_host_probe() or pci_scan_root_bus_bridge()
later, the export can be removed again.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/pci/probe.c | 25 ++++++++++++++++++++++++-
 include/linux/pci.h |  1 +
 2 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index cf169742c03e..5ca7d5941ad0 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -762,7 +762,29 @@ static void pci_set_bus_msi_domain(struct pci_bus *bus)
 	dev_set_msi_domain(&bus->dev, d);
 }
 
-static int pci_register_host_bridge(struct pci_host_bridge *bridge)
+/*
+ * pci_register_host_bridge() - Register a host bridge without scanning
+ *
+ * @bridge: a newly allocated host bridge structure
+ *
+ * This is the core part of bringing up a new PCI host bridge,
+ * before we scan for attached devices and register them as
+ * pci_dev.
+ *
+ * For the most part, this is an implementation detail of the
+ * pci_host_probe() interface, which brings up the entire bus,
+ * bus some older platforms still call it directly and manually
+ * scan for devices.
+ *
+ * If your driver uses this, try to convert it to using
+ * pci_host_probe() instead.
+ *
+ * Return: zero on suggess, or a negative error code.
+ * Note: after pci_register_host_bridge() successfully returns,
+ * the pci_host_bridge device is alive in driver core, and must
+ * not be freed directly.
+ */
+int pci_register_host_bridge(struct pci_host_bridge *bridge)
 {
 	struct device *parent = bridge->dev.parent;
 	struct resource_entry *window, *n;
@@ -877,6 +899,7 @@ static int pci_register_host_bridge(struct pci_host_bridge *bridge)
 	kfree(bus);
 	return err;
 }
+EXPORT_SYMBOL_GPL(pci_register_host_bridge);
 
 static bool pci_bridge_child_ext_cfg_accessible(struct pci_dev *bridge)
 {
diff --git a/include/linux/pci.h b/include/linux/pci.h
index d226e06fb5e5..e1337148cf9f 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -909,6 +909,7 @@ struct pci_bus *pci_create_root_bus(struct device *parent, int bus,
 				    struct pci_ops *ops, void *sysdata,
 				    struct list_head *resources);
 int pci_host_probe(struct pci_host_bridge *bridge);
+int pci_register_host_bridge(struct pci_host_bridge *);
 int pci_bus_insert_busn_res(struct pci_bus *b, int bus, int busmax);
 int pci_bus_update_busn_res_end(struct pci_bus *b, int busmax);
 void pci_bus_release_busn_res(struct pci_bus *b);
-- 
2.18.0

