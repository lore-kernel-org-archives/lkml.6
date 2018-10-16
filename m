Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3519AC04EB9
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 02:40:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E50E220869
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 02:40:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kZA1Lz8z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E50E220869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727384AbeJPK2O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 06:28:14 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:38883 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727195AbeJPK1a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 06:27:30 -0400
Received: by mail-pg1-f195.google.com with SMTP id f8-v6so10077945pgq.5;
        Mon, 15 Oct 2018 19:39:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2sdM+uo5RY9Q3iE4GFDb5Oob/oVxCfBYkc7AVXa7cZY=;
        b=kZA1Lz8zHcByxCry/YeRs8ALfD30508qaWFQHYq115X6dd9f0wM26ukaVHbqpeoPc/
         TurknnyL4mGK1Hq0cfhVNCZZRZcqpsCOphB9dUYzU5STOm8zj1NCJr1Wkf5Bta1IyBoV
         6cQ2kjjyRR9f9cS05zLqzleqQ5fMm0ckHaTKQaw8B8jvWksjTGQvHBwJPfNQphKcUklS
         O65Te9VOabEK8Qabr4V7yOqldDcEr68UKBvctod4rpN2yA3lxIlfugIFsW0A/PTe/4Py
         FftgZzPXQ+Xev3w0unlhu7fHVpzAgedfqMV6HNXLLZjpwOw2gOcFDidgIr8NX1n/cj5P
         5IlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2sdM+uo5RY9Q3iE4GFDb5Oob/oVxCfBYkc7AVXa7cZY=;
        b=H0jQVkbvE1HojXE7YNaf/1h5Ltt9B74PpaHNESiDc5U4ILHgFEbEA2w+KecHAhDA7+
         UJIhl55Ti0xOdabQxYcRYGRrTij9e5xNNfRDEidV0CymlWlAPs5JiJ/9KxnAu9WWDYF7
         uqwaX0cGQDiHaRnIJkaVNLmQBM24K3lp5KKhMDeOGGttTREWzhIVeAkOOd8OF8iokqYv
         d6yXqooB4WmhPDlzMRxSD8dQTcRdntCCFiYE2hix9ovQx6RXhAZAXKBa3dBTB7YnQ4T6
         VwEh6BaVh+jBg38HNR2LvFUy9SWyvJvjbKcPrSi+IVRc9cb5/Qm+gTii66YpGcY9WWOQ
         OSqA==
X-Gm-Message-State: ABuFfogrkmKvcaqYNbOTz5QYYlx0IqaihJeVTpRGnMylvgjaNVRUmBpV
        S40KlqrGFSy+ILe7kAJ0hLA=
X-Google-Smtp-Source: ACcGV614hva4jqYOrW2hXQU2LKAa96Bd7sLWayujOUfebVYSbQWsLEPy6rFODsVseYoyz8mFvCWX/Q==
X-Received: by 2002:a62:8f0c:: with SMTP id n12-v6mr20384309pfd.172.1539657566313;
        Mon, 15 Oct 2018 19:39:26 -0700 (PDT)
Received: from localhost.localdomain (c-24-6-192-50.hsd1.ca.comcast.net. [24.6.192.50])
        by smtp.gmail.com with ESMTPSA id u79-v6sm18620287pfd.117.2018.10.15.19.39.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 15 Oct 2018 19:39:25 -0700 (PDT)
From:   frowand.list@gmail.com
To:     Rob Herring <robh+dt@kernel.org>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Alan Tull <atull@kernel.org>, Moritz Fischer <mdf@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        devicetree@vger.kernel.org, linux-fpga@vger.kernel.org
Subject: [PATCH v4 12/18] of: overlay: check prevents multiple fragments add or delete same node
Date:   Mon, 15 Oct 2018 19:37:32 -0700
Message-Id: <1539657458-24401-13-git-send-email-frowand.list@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1539657458-24401-1-git-send-email-frowand.list@gmail.com>
References: <1539657458-24401-1-git-send-email-frowand.list@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frank Rowand <frank.rowand@sony.com>

Multiple overlay fragments adding or deleting the same node is not
supported.  Replace code comment of such, with check to detect the
attempt and fail the overlay apply.

Devicetree unittest where multiple fragments added the same node was
added in the previous patch in the series.  After applying this patch
the unittest messages will no longer include:

   Duplicate name in motor-1, renamed to "controller#1"
   OF: overlay: of_overlay_apply() err=0
   ### dt-test ### of_overlay_fdt_apply() expected -22, ret=0, overlay_bad_add_dup_node
   ### dt-test ### FAIL of_unittest_overlay_high_level():2419 Adding overlay 'overlay_bad_add_dup_node' failed

   ...

   ### dt-test ### end of unittest - 210 passed, 1 failed

but will instead include:

   OF: overlay: ERROR: multiple overlay fragments add and/or delete node /testcase-data-2/substation@100/motor-1/controller

   ...

   ### dt-test ### end of unittest - 211 passed, 0 failed

Signed-off-by: Frank Rowand <frank.rowand@sony.com>
---

checkpatch errors "line over 80 characters" are ok, they will be
fixed later in this series

 drivers/of/overlay.c | 58 ++++++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 49 insertions(+), 9 deletions(-)

diff --git a/drivers/of/overlay.c b/drivers/of/overlay.c
index 34396d6db1b3..0dc7452e2ed5 100644
--- a/drivers/of/overlay.c
+++ b/drivers/of/overlay.c
@@ -402,14 +402,6 @@ static int add_changeset_property(struct overlay_changeset *ovcs,
  *       a live devicetree created from Open Firmware.
  *
  * NOTE_2: Multiple mods of created nodes not supported.
- *       If more than one fragment contains a node that does not already exist
- *       in the live tree, then for each fragment of_changeset_attach_node()
- *       will add a changeset entry to add the node.  When the changeset is
- *       applied, __of_attach_node() will attach the node twice (once for
- *       each fragment).  At this point the device tree will be corrupted.
- *
- *       TODO: add integrity check to ensure that multiple fragments do not
- *             create the same node.
  *
  * Returns 0 on success, -ENOMEM if memory allocation failure, or -EINVAL if
  * invalid @overlay.
@@ -527,6 +519,54 @@ static int build_changeset_symbols_node(struct overlay_changeset *ovcs,
 }
 
 /**
+ * check_changeset_dup_add_node() - changeset validation: duplicate add node
+ * @ovcs:	Overlay changeset
+ *
+ * Check changeset @ovcs->cset for multiple add node entries for the same
+ * node.
+ *
+ * Returns 0 on success, -ENOMEM if memory allocation failure, or -EINVAL if
+ * invalid overlay in @ovcs->fragments[].
+ */
+static int check_changeset_dup_add_node(struct overlay_changeset *ovcs)
+{
+	struct of_changeset_entry *ce_1, *ce_2;
+	char *fn_1, *fn_2;
+	int name_match;
+
+	list_for_each_entry(ce_1, &ovcs->cset.entries, node) {
+
+		if (ce_1->action == OF_RECONFIG_ATTACH_NODE ||
+		    ce_1->action == OF_RECONFIG_DETACH_NODE) {
+
+			ce_2 = ce_1;
+			list_for_each_entry_continue(ce_2, &ovcs->cset.entries, node) {
+				if (ce_2->action == OF_RECONFIG_ATTACH_NODE ||
+				    ce_2->action == OF_RECONFIG_DETACH_NODE) {
+					/* inexpensive name compare */
+					if (!of_node_cmp(ce_1->np->full_name,
+					    ce_2->np->full_name)) {
+						/* expensive full path name compare */
+						fn_1 = kasprintf(GFP_KERNEL, "%pOF", ce_1->np);
+						fn_2 = kasprintf(GFP_KERNEL, "%pOF", ce_2->np);
+						name_match = !strcmp(fn_1, fn_2);
+						kfree(fn_1);
+						kfree(fn_2);
+						if (name_match) {
+							pr_err("ERROR: multiple overlay fragments add and/or delete node %pOF\n",
+							       ce_1->np);
+							return -EINVAL;
+						}
+					}
+				}
+			}
+		}
+	}
+
+	return 0;
+}
+
+/**
  * build_changeset() - populate overlay changeset in @ovcs from @ovcs->fragments
  * @ovcs:	Overlay changeset
  *
@@ -581,7 +621,7 @@ static int build_changeset(struct overlay_changeset *ovcs)
 		}
 	}
 
-	return 0;
+	return check_changeset_dup_add_node(ovcs);
 }
 
 /*
-- 
Frank Rowand <frank.rowand@sony.com>

