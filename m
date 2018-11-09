Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03AE0C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 06:08:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B59752086C
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 06:08:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JoePG8V9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B59752086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728115AbeKIPq7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 10:46:59 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:46068 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727704AbeKIPq7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 10:46:59 -0500
Received: by mail-pf1-f195.google.com with SMTP id p17-v6so432866pfj.12;
        Thu, 08 Nov 2018 22:07:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9a1Olt+9gSUcbGlkI6FmhtduS6tNkDQuhvu9c7HHqj8=;
        b=JoePG8V9MYM0jxW4xy99V24ecpn2bzFyJI6k64nJfE7e5CLtXFTHrwDOQeg2Dqfka0
         9VpM1rJNgqegnWhX89hbSH5FwdDz2v0Cr+IUW02hN/E8S/leqNEL2hBcJEPZn7uZoEpd
         tM+LZVpSo/bdyzQvMxrZo+2hR5Sg1gtjoQdnt+oi8/GXyckRA/bOdOmaE/TIXk/XzTf3
         muSGlbzvjLBZtfnltPTkiFJysTXx3ku1CDNBUaFQ3FfEEi4FfZWCgwsAQzWI0+vd6hdJ
         h942KjrfAofO0M4iyQb3g7OGseqISJo0rIK/cM9OJjYxb5gcsXwVdaI2ub745YV68wAm
         Nn9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9a1Olt+9gSUcbGlkI6FmhtduS6tNkDQuhvu9c7HHqj8=;
        b=aZsNmKohRPY47zwDA1dXyd4iWZAiLSoC4JRs1aC6wmDo+DPtcr5BnGotjBUqWibKNG
         ZzpH2oRb0jVUEFE9jghiF0/+7J943i6onXhzGyaT+X2zlAqyOJGEsokPJ2a9ZGeClIRC
         FKallu3Jmptw8ITSrnIwFmv1Dwbh6UQbL5bjKaRafH3K9sxBk8e2FWMrwAjBOVc9UWxF
         mElhH6YTjBPUd5HNxZbUG+6x3d0mNWn/3opZOwW0owev4RY6fPMbjThJPqKr3YVQA8jA
         Wxy6CEOUKQTnSOZjhlQsmHJMhhgTHNhtPfMrHO2UvnqRC9iq9l+o/qb/h1cWwkk/etS8
         A0Pw==
X-Gm-Message-State: AGRZ1gJyq1HbAXVuGYPY96MsgARc2P+5vCIcjuhHFb+QkLDg+oovp2kD
        4V/IRINo7Ot7vuKuxsWdBug=
X-Google-Smtp-Source: AJdET5dHFAHhvT/n2IDsV3psvaYfO4LOT5j/MRd2wbsoLiBZOULHalcKrosoelrmjwfeG812nyQZ9w==
X-Received: by 2002:a62:da54:: with SMTP id w20-v6mr7680853pfl.106.1541743677771;
        Thu, 08 Nov 2018 22:07:57 -0800 (PST)
Received: from localhost.localdomain (c-24-6-192-50.hsd1.ca.comcast.net. [24.6.192.50])
        by smtp.gmail.com with ESMTPSA id c70-v6sm6620722pfg.97.2018.11.08.22.07.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 08 Nov 2018 22:07:57 -0800 (PST)
From:   frowand.list@gmail.com
To:     Rob Herring <robh+dt@kernel.org>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Alan Tull <atull@kernel.org>, Moritz Fischer <mdf@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        devicetree@vger.kernel.org, linux-fpga@vger.kernel.org
Subject: [PATCH v7 11/17] of: overlay: check prevents multiple fragments add or delete same node
Date:   Thu,  8 Nov 2018 22:05:59 -0800
Message-Id: <1541743565-23163-12-git-send-email-frowand.list@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1541743565-23163-1-git-send-email-frowand.list@gmail.com>
References: <1541743565-23163-1-git-send-email-frowand.list@gmail.com>
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

Tested-by: Alan Tull <atull@kernel.org>
Signed-off-by: Frank Rowand <frank.rowand@sony.com>
---

checkpatch errors "line over 80 characters" and "Too many leading tabs"
are ok, they will be fixed later in this series

 drivers/of/overlay.c | 58 ++++++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 49 insertions(+), 9 deletions(-)

diff --git a/drivers/of/overlay.c b/drivers/of/overlay.c
index c8f88b0836a3..8af8115bd36e 100644
--- a/drivers/of/overlay.c
+++ b/drivers/of/overlay.c
@@ -392,14 +392,6 @@ static int add_changeset_property(struct overlay_changeset *ovcs,
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
@@ -517,6 +509,54 @@ static int build_changeset_symbols_node(struct overlay_changeset *ovcs,
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
@@ -571,7 +611,7 @@ static int build_changeset(struct overlay_changeset *ovcs)
 		}
 	}
 
-	return 0;
+	return check_changeset_dup_add_node(ovcs);
 }
 
 /*
-- 
Frank Rowand <frank.rowand@sony.com>

