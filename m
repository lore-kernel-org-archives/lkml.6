Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9688BC71122
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 00:26:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47C1D20876
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 00:26:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="koc+J4MD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47C1D20876
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726917AbeJOIJG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 04:09:06 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:42514 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726883AbeJOIJF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 04:09:05 -0400
Received: by mail-pg1-f195.google.com with SMTP id i4-v6so8289561pgq.9;
        Sun, 14 Oct 2018 17:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wiP1rYr32Lf/QXaWyA9yA91bv6hFIJaCasE1H+3zy38=;
        b=koc+J4MDojZpcz36xvOSkjoqfevRszDz3UqfQY+rfB37qfKorTU9rO4a0pWj4I5KTc
         0UYqguaolPopPFCFbLg9bP0MJOXwLkW7aPjTg7aZsbEHFLY/LR5a9Iv88JLEAhvp22YA
         cqv98ZiU2WrRmGxx5nmP3RSBt050epgcevrsltleuS9+X6s07r3dNbMF73RU90cTfToG
         S5FL3aFnbyjCZ3G2PL0cqm2yh39B8AqoKVOFHTnOtHQjSuHmPqDkYSUvze4KHdJEZY6j
         GU6X88P/OVxdkVNz2xi98McNgCeL+cI10zrZ7DbPHGr8cYjRivF/OYwFWofJ0/WC+V0u
         dV3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wiP1rYr32Lf/QXaWyA9yA91bv6hFIJaCasE1H+3zy38=;
        b=kuWhiuJy0Bo0jOuEyc129xbMSeIR+mTr41KxXMPMw7Er+e5AiIbtEUH9zZvrWGeX0L
         2bFhFj08S2fTHoBZ7c8kiHsr3Ub/LayhENZwl95JPEDZPaq6T3uLxxKzNYZMsxgNtL5W
         2W9P0T7191fSFabTr2lCnTFHxCuEFH3Q+c08QaSK8HG3Hv6/I4bDYOsJdQ2mts0PYcg1
         hJcvzitrYMuwGinWx9Hx3tl8mfJfEtH6owBAZzaV/+X6MKujC+A3Y3Ci48jbyiiiVDWZ
         q5pkxcbliO6vdM/bS+u8lICjnmyhFCxs5mQdYSICz7qEIE+GWgJCsvs6dxzZ7Zd9Uk7Y
         ZB8w==
X-Gm-Message-State: ABuFfogJRZPu+EWDOE3aQQm6ICV6B4vEPKg6vA3NIRu2p+sacXKJwr/B
        1iMB84uEFCfBEYFmKxf4S1GDoxLO
X-Google-Smtp-Source: ACcGV63kvseQYHhjyZLy3eAW/eJY77Hbvyfxp/HTbLvY4vVI5zr3xecqwY00JcTXJfwg+ikKq8o2Aw==
X-Received: by 2002:a63:b08:: with SMTP id 8-v6mr13870320pgl.130.1539563176346;
        Sun, 14 Oct 2018 17:26:16 -0700 (PDT)
Received: from localhost.localdomain (c-24-6-192-50.hsd1.ca.comcast.net. [24.6.192.50])
        by smtp.gmail.com with ESMTPSA id j14-v6sm11387110pgh.52.2018.10.14.17.26.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 14 Oct 2018 17:26:15 -0700 (PDT)
From:   frowand.list@gmail.com
To:     Rob Herring <robh+dt@kernel.org>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Alan Tull <atull@kernel.org>, Moritz Fischer <mdf@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        devicetree@vger.kernel.org, linux-fpga@vger.kernel.org
Subject: [PATCH v3 13/18] of: overlay: check prevents multiple fragments touching same property
Date:   Sun, 14 Oct 2018 17:24:25 -0700
Message-Id: <1539563070-12969-14-git-send-email-frowand.list@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1539563070-12969-1-git-send-email-frowand.list@gmail.com>
References: <1539563070-12969-1-git-send-email-frowand.list@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frank Rowand <frank.rowand@sony.com>

Add test case of two fragments updating the same property.  After
adding the test case, the system hangs at end of boot, after
after slub stack dumps from kfree() in crypto modprobe code.

Multiple overlay fragments adding, modifying, or deleting the same
property is not supported.  Add check to detect the attempt and fail
the overlay apply.

After applying this patch, the devicetree unittest messages will
include:

   OF: overlay: ERROR: multiple overlay fragments add, update, and/or delete property /testcase-data-2/substation@100/motor-1/rpm_avail

   ...

   ### dt-test ### end of unittest - 212 passed, 0 failed

The check to detect two fragments updating the same property is
folded into the patch that created the test case to maintain
bisectability.

Signed-off-by: Frank Rowand <frank.rowand@sony.com>
---

Changes since v2:
  - Use continue to reduce indentation in find_dup_cset_node_entry()
    and find_dup_cset_prop()

 drivers/of/overlay.c                               | 118 ++++++++++++++-------
 drivers/of/unittest-data/Makefile                  |   1 +
 .../of/unittest-data/overlay_bad_add_dup_prop.dts  |  24 +++++
 drivers/of/unittest-data/overlay_base.dts          |   1 +
 drivers/of/unittest.c                              |   5 +
 5 files changed, 112 insertions(+), 37 deletions(-)
 create mode 100644 drivers/of/unittest-data/overlay_bad_add_dup_prop.dts

diff --git a/drivers/of/overlay.c b/drivers/of/overlay.c
index b0a0dafb6a13..908bcc62019b 100644
--- a/drivers/of/overlay.c
+++ b/drivers/of/overlay.c
@@ -514,52 +514,96 @@ static int build_changeset_symbols_node(struct overlay_changeset *ovcs,
 	return 0;
 }
 
+static int find_dup_cset_node_entry(struct overlay_changeset *ovcs,
+		struct of_changeset_entry *ce_1)
+{
+	struct of_changeset_entry *ce_2;
+	char *fn_1, *fn_2;
+	int node_path_match;
+
+	if (ce_1->action != OF_RECONFIG_ATTACH_NODE &&
+	    ce_1->action != OF_RECONFIG_DETACH_NODE)
+		return 0;
+
+	ce_2 = ce_1;
+	list_for_each_entry_continue(ce_2, &ovcs->cset.entries, node) {
+		if ((ce_2->action != OF_RECONFIG_ATTACH_NODE &&
+		     ce_2->action != OF_RECONFIG_DETACH_NODE) ||
+		    of_node_cmp(ce_1->np->full_name, ce_2->np->full_name))
+			continue;
+
+		fn_1 = kasprintf(GFP_KERNEL, "%pOF", ce_1->np);
+		fn_2 = kasprintf(GFP_KERNEL, "%pOF", ce_2->np);
+		node_path_match = !strcmp(fn_1, fn_2);
+		kfree(fn_1);
+		kfree(fn_2);
+		if (node_path_match) {
+			pr_err("ERROR: multiple overlay fragments add and/or delete node %pOF\n",
+			       ce_1->np);
+			return -EINVAL;
+		}
+	}
+
+	return 0;
+}
+
+static int find_dup_cset_prop(struct overlay_changeset *ovcs,
+		struct of_changeset_entry *ce_1)
+{
+	struct of_changeset_entry *ce_2;
+	char *fn_1, *fn_2;
+	int node_path_match;
+
+	if (ce_1->action != OF_RECONFIG_ADD_PROPERTY &&
+	    ce_1->action != OF_RECONFIG_REMOVE_PROPERTY &&
+	    ce_1->action != OF_RECONFIG_UPDATE_PROPERTY)
+		return 0;
+
+	ce_2 = ce_1;
+	list_for_each_entry_continue(ce_2, &ovcs->cset.entries, node) {
+		if ((ce_2->action != OF_RECONFIG_ADD_PROPERTY &&
+		     ce_2->action != OF_RECONFIG_REMOVE_PROPERTY &&
+		     ce_2->action != OF_RECONFIG_UPDATE_PROPERTY) ||
+		    of_node_cmp(ce_1->np->full_name, ce_2->np->full_name))
+			continue;
+
+		fn_1 = kasprintf(GFP_KERNEL, "%pOF", ce_1->np);
+		fn_2 = kasprintf(GFP_KERNEL, "%pOF", ce_2->np);
+		node_path_match = !strcmp(fn_1, fn_2);
+		kfree(fn_1);
+		kfree(fn_2);
+		if (node_path_match &&
+		    !of_prop_cmp(ce_1->prop->name, ce_2->prop->name)) {
+			pr_err("ERROR: multiple overlay fragments add, update, and/or delete property %pOF/%s\n",
+			       ce_1->np, ce_1->prop->name);
+			return -EINVAL;
+		}
+	}
+
+	return 0;
+}
+
 /**
- * check_changeset_dup_add_node() - changeset validation: duplicate add node
+ * changeset_dup_entry_check() - check for duplicate entries
  * @ovcs:	Overlay changeset
  *
- * Check changeset @ovcs->cset for multiple add node entries for the same
- * node.
+ * Check changeset @ovcs->cset for multiple {add or delete} node entries for
+ * the same node or duplicate {add, delete, or update} properties entries
+ * for the same property.
  *
- * Returns 0 on success, -ENOMEM if memory allocation failure, or -EINVAL if
- * invalid overlay in @ovcs->fragments[].
+ * Returns 0 on success, or -EINVAL if duplicate changeset entry found.
  */
-static int check_changeset_dup_add_node(struct overlay_changeset *ovcs)
+static int changeset_dup_entry_check(struct overlay_changeset *ovcs)
 {
-	struct of_changeset_entry *ce_1, *ce_2;
-	char *fn_1, *fn_2;
-	int name_match;
+	struct of_changeset_entry *ce_1;
+	int dup_entry = 0;
 
 	list_for_each_entry(ce_1, &ovcs->cset.entries, node) {
-
-		if (ce_1->action == OF_RECONFIG_ATTACH_NODE ||
-		    ce_1->action == OF_RECONFIG_DETACH_NODE) {
-
-			ce_2 = ce_1;
-			list_for_each_entry_continue(ce_2, &ovcs->cset.entries, node) {
-				if (ce_2->action == OF_RECONFIG_ATTACH_NODE ||
-				    ce_2->action == OF_RECONFIG_DETACH_NODE) {
-					/* inexpensive name compare */
-					if (!of_node_cmp(ce_1->np->full_name,
-					    ce_2->np->full_name)) {
-						/* expensive full path name compare */
-						fn_1 = kasprintf(GFP_KERNEL, "%pOF", ce_1->np);
-						fn_2 = kasprintf(GFP_KERNEL, "%pOF", ce_2->np);
-						name_match = !strcmp(fn_1, fn_2);
-						kfree(fn_1);
-						kfree(fn_2);
-						if (name_match) {
-							pr_err("ERROR: multiple overlay fragments add and/or delete node %pOF\n",
-							       ce_1->np);
-							return -EINVAL;
-						}
-					}
-				}
-			}
-		}
+		dup_entry |= find_dup_cset_node_entry(ovcs, ce_1);
+		dup_entry |= find_dup_cset_prop(ovcs, ce_1);
 	}
 
-	return 0;
+	return dup_entry ? -EINVAL : 0;
 }
 
 /**
@@ -617,7 +661,7 @@ static int build_changeset(struct overlay_changeset *ovcs)
 		}
 	}
 
-	return check_changeset_dup_add_node(ovcs);
+	return changeset_dup_entry_check(ovcs);
 }
 
 /*
diff --git a/drivers/of/unittest-data/Makefile b/drivers/of/unittest-data/Makefile
index 166dbdbfd1c5..9b6807065827 100644
--- a/drivers/of/unittest-data/Makefile
+++ b/drivers/of/unittest-data/Makefile
@@ -18,6 +18,7 @@ obj-$(CONFIG_OF_OVERLAY) += overlay.dtb.o \
 			    overlay_13.dtb.o \
 			    overlay_15.dtb.o \
 			    overlay_bad_add_dup_node.dtb.o \
+			    overlay_bad_add_dup_prop.dtb.o \
 			    overlay_bad_phandle.dtb.o \
 			    overlay_bad_symbol.dtb.o \
 			    overlay_base.dtb.o
diff --git a/drivers/of/unittest-data/overlay_bad_add_dup_prop.dts b/drivers/of/unittest-data/overlay_bad_add_dup_prop.dts
new file mode 100644
index 000000000000..c190da54f175
--- /dev/null
+++ b/drivers/of/unittest-data/overlay_bad_add_dup_prop.dts
@@ -0,0 +1,24 @@
+// SPDX-License-Identifier: GPL-2.0
+/dts-v1/;
+/plugin/;
+
+/*
+ * &electric_1/motor-1 and &spin_ctrl_1 are the same node:
+ *   /testcase-data-2/substation@100/motor-1
+ *
+ * Thus the property "rpm_avail" in each fragment will
+ * result in an attempt to update the same property twice.
+ * This will result in an error and the overlay apply
+ * will fail.
+ */
+
+&electric_1 {
+
+	motor-1 {
+		rpm_avail = < 100 >;
+	};
+};
+
+&spin_ctrl_1 {
+		rpm_avail = < 100 200 >;
+};
diff --git a/drivers/of/unittest-data/overlay_base.dts b/drivers/of/unittest-data/overlay_base.dts
index 820b79ca378a..99ab9d12d00b 100644
--- a/drivers/of/unittest-data/overlay_base.dts
+++ b/drivers/of/unittest-data/overlay_base.dts
@@ -30,6 +30,7 @@
 			spin_ctrl_1: motor-1 {
 				compatible = "ot,ferris-wheel-motor";
 				spin = "clockwise";
+				rpm_avail = < 50 >;
 			};
 
 			spin_ctrl_2: motor-8 {
diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
index 471b8eb6e842..efd9c947f192 100644
--- a/drivers/of/unittest.c
+++ b/drivers/of/unittest.c
@@ -2148,6 +2148,7 @@ struct overlay_info {
 OVERLAY_INFO_EXTERN(overlay_13);
 OVERLAY_INFO_EXTERN(overlay_15);
 OVERLAY_INFO_EXTERN(overlay_bad_add_dup_node);
+OVERLAY_INFO_EXTERN(overlay_bad_add_dup_prop);
 OVERLAY_INFO_EXTERN(overlay_bad_phandle);
 OVERLAY_INFO_EXTERN(overlay_bad_symbol);
 
@@ -2171,6 +2172,7 @@ struct overlay_info {
 	OVERLAY_INFO(overlay_13, 0),
 	OVERLAY_INFO(overlay_15, 0),
 	OVERLAY_INFO(overlay_bad_add_dup_node, -EINVAL),
+	OVERLAY_INFO(overlay_bad_add_dup_prop, -EINVAL),
 	OVERLAY_INFO(overlay_bad_phandle, -EINVAL),
 	OVERLAY_INFO(overlay_bad_symbol, -EINVAL),
 	{}
@@ -2418,6 +2420,9 @@ static __init void of_unittest_overlay_high_level(void)
 	unittest(overlay_data_apply("overlay_bad_add_dup_node", NULL),
 		 "Adding overlay 'overlay_bad_add_dup_node' failed\n");
 
+	unittest(overlay_data_apply("overlay_bad_add_dup_prop", NULL),
+		 "Adding overlay 'overlay_bad_add_dup_prop' failed\n");
+
 	unittest(overlay_data_apply("overlay_bad_phandle", NULL),
 		 "Adding overlay 'overlay_bad_phandle' failed\n");
 
-- 
Frank Rowand <frank.rowand@sony.com>

