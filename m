Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BA98C04EB9
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 02:40:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE56020869
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 02:40:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VuFBfJMM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE56020869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727015AbeJPK1R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 06:27:17 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:35613 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726944AbeJPK1R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 06:27:17 -0400
Received: by mail-pg1-f196.google.com with SMTP id v133-v6so10083589pgb.2;
        Mon, 15 Oct 2018 19:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JHz4eQu2QicbBVTkAKqK9aKvo2anD2RJn53w2YKB8e0=;
        b=VuFBfJMMk6qap6AVKX2Sa0pM5k7L/UmMs/xnds8HFlzeaKdsJeXdUwLD2/9HDsaiFW
         seUTu1j/+Jmg/V0TiRXDN4wlnkR1IhBWg0HE0LLVmRiZOktbYOWPhcTjC8iLMGXNZUoU
         vJRC4VIPI0l25gLyTwBMd88ETXtp7zaHREELU6ea5fGnYADBdJ5oHQxD4u3dS5/Adh3C
         xWwfP6bblrpgPVwKA0Dc8WmAMypiKsEkbI/yn0DLH8zz60jRGIOtEFXsTeb3BeFwebXk
         GwiL7n4Jjyqb/hHdRQjXlXHDbEfxBOCTQTZdFNx+duZTvaySIpzKDtPGGHM2synn1l0y
         uPhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=JHz4eQu2QicbBVTkAKqK9aKvo2anD2RJn53w2YKB8e0=;
        b=PmGQaVs7mc02f6XYK/uVBWASySTHQXa0Ovc5vaM2o/Xlm2SOO7NZZmShiDx6sK9MIi
         tYJ7otgTU6vU7IMA1O7X2jvZkuDA+xzY38BmvKzEBqwD8O0Z3HFwCJsFAqhjbMfct3vm
         syfzwEv/g4ioNhsvLbq3TXuObgtfXJvrE02bPepvXo2pbbyauntxZRBZv4D5E5QKcfZ3
         YKKaE/9z37dxJIZVmk469MnWw3TyCXQHUucfzdQKnbEyFU1SIDJld5k9vcdZZfAJIaf1
         tMQ8PWIAVTr+bkM7A6BDGHMamYXAEcxrNyvq1J3YEss6pdVdCdWBpbBiYr6qTAZ8VDNX
         FCJg==
X-Gm-Message-State: ABuFfoiDMvaCc192Jw+H4cFORdhAKop4uJm1Mo23QPmzrNzH/YY2HNQg
        is2YCJN7iZNW3MrhnF9fKgc=
X-Google-Smtp-Source: ACcGV639CBmDpGh7IxP36f5mNtBe8sg3FSECUCzIxDTxhGjWl2qLULnogvgzhlm+V2d/huyFocVcgg==
X-Received: by 2002:a62:1d16:: with SMTP id d22-v6mr1132680pfd.159.1539657552452;
        Mon, 15 Oct 2018 19:39:12 -0700 (PDT)
Received: from localhost.localdomain (c-24-6-192-50.hsd1.ca.comcast.net. [24.6.192.50])
        by smtp.gmail.com with ESMTPSA id u79-v6sm18620287pfd.117.2018.10.15.19.39.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 15 Oct 2018 19:39:11 -0700 (PDT)
From:   frowand.list@gmail.com
To:     Rob Herring <robh+dt@kernel.org>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Alan Tull <atull@kernel.org>, Moritz Fischer <mdf@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        devicetree@vger.kernel.org, linux-fpga@vger.kernel.org
Subject: [PATCH v4 01/18] of: overlay: add tests to validate kfrees from overlay removal
Date:   Mon, 15 Oct 2018 19:37:21 -0700
Message-Id: <1539657458-24401-2-git-send-email-frowand.list@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1539657458-24401-1-git-send-email-frowand.list@gmail.com>
References: <1539657458-24401-1-git-send-email-frowand.list@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frank Rowand <frank.rowand@sony.com>

Add checks:
  - attempted kfree due to refcount reaching zero before overlay
    is removed
  - properties linked to an overlay node when the node is removed
  - node refcount > one during node removal in a changeset destroy,
    if the node was created by the changeset

After applying this patch, several validation warnings will be
reported from the devicetree unittest during boot due to
pre-existing devicetree bugs. The warnings will be similar to:

  OF: ERROR: of_node_release() overlay node /testcase-data/overlay-node/test-bus/test-unittest11/test-unittest111 contains unexpected properties
  OF: ERROR: memory leak - destroy cset entry: attach overlay node /testcase-data-2/substation@100/hvac-medium-2 expected refcount 1 instead of 2.  of_node_get() / of_node_put() are unbalanced for this node.

Signed-off-by: Frank Rowand <frank.rowand@sony.com>
---
Changes since v3:
  - Add expected value of refcount for destroy cset entry error.  Also
    explain the cause of the error.

 drivers/of/dynamic.c | 29 +++++++++++++++++++++++++++++
 drivers/of/overlay.c |  1 +
 include/linux/of.h   | 15 ++++++++++-----
 3 files changed, 40 insertions(+), 5 deletions(-)

diff --git a/drivers/of/dynamic.c b/drivers/of/dynamic.c
index f4f8ed9b5454..24c97b7a050f 100644
--- a/drivers/of/dynamic.c
+++ b/drivers/of/dynamic.c
@@ -330,6 +330,25 @@ void of_node_release(struct kobject *kobj)
 	if (!of_node_check_flag(node, OF_DYNAMIC))
 		return;
 
+	if (of_node_check_flag(node, OF_OVERLAY)) {
+
+		if (!of_node_check_flag(node, OF_OVERLAY_FREE_CSET)) {
+			/* premature refcount of zero, do not free memory */
+			pr_err("ERROR: memory leak %s() overlay node %pOF before free overlay changeset\n",
+			       __func__, node);
+			return;
+		}
+
+		/*
+		 * If node->properties non-empty then properties were added
+		 * to this node either by different overlay that has not
+		 * yet been removed, or by a non-overlay mechanism.
+		 */
+		if (node->properties)
+			pr_err("ERROR: %s() overlay node %pOF contains unexpected properties\n",
+			       __func__, node);
+	}
+
 	property_list_free(node->properties);
 	property_list_free(node->deadprops);
 
@@ -434,6 +453,16 @@ struct device_node *__of_node_dup(const struct device_node *np,
 
 static void __of_changeset_entry_destroy(struct of_changeset_entry *ce)
 {
+	if (ce->action == OF_RECONFIG_ATTACH_NODE &&
+	    of_node_check_flag(ce->np, OF_OVERLAY)) {
+		if (kref_read(&ce->np->kobj.kref) > 1) {
+			pr_err("ERROR: memory leak - destroy cset entry: attach overlay node %pOF expected refcount 1 instead of %d.  of_node_get() / of_node_put() are unbalanced for this node.\n",
+			       ce->np, kref_read(&ce->np->kobj.kref));
+		} else {
+			of_node_set_flag(ce->np, OF_OVERLAY_FREE_CSET);
+		}
+	}
+
 	of_node_put(ce->np);
 	list_del(&ce->node);
 	kfree(ce);
diff --git a/drivers/of/overlay.c b/drivers/of/overlay.c
index eda57ef12fd0..1176cb4b6e4e 100644
--- a/drivers/of/overlay.c
+++ b/drivers/of/overlay.c
@@ -373,6 +373,7 @@ static int add_changeset_node(struct overlay_changeset *ovcs,
 			return -ENOMEM;
 
 		tchild->parent = target_node;
+		of_node_set_flag(tchild, OF_OVERLAY);
 
 		ret = of_changeset_attach_node(&ovcs->cset, tchild);
 		if (ret)
diff --git a/include/linux/of.h b/include/linux/of.h
index 4d25e4f952d9..aa1dafaec6ae 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -138,11 +138,16 @@ static inline void of_node_put(struct device_node *node) { }
 extern struct device_node *of_stdout;
 extern raw_spinlock_t devtree_lock;
 
-/* flag descriptions (need to be visible even when !CONFIG_OF) */
-#define OF_DYNAMIC	1 /* node and properties were allocated via kmalloc */
-#define OF_DETACHED	2 /* node has been detached from the device tree */
-#define OF_POPULATED	3 /* device already created for the node */
-#define OF_POPULATED_BUS	4 /* of_platform_populate recursed to children of this node */
+/*
+ * struct device_node flag descriptions
+ * (need to be visible even when !CONFIG_OF)
+ */
+#define OF_DYNAMIC		1 /* (and properties) allocated via kmalloc */
+#define OF_DETACHED		2 /* detached from the device tree */
+#define OF_POPULATED		3 /* device already created */
+#define OF_POPULATED_BUS	4 /* platform bus created for children */
+#define OF_OVERLAY		5 /* allocated for an overlay */
+#define OF_OVERLAY_FREE_CSET	6 /* in overlay cset being freed */
 
 #define OF_BAD_ADDR	((u64)-1)
 
-- 
Frank Rowand <frank.rowand@sony.com>

