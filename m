Return-Path: <SRS0=sHJz=MZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20F13C28CF8
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 04:55:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4A7F204EC
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 04:55:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g99Xtb6J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4A7F204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727095AbeJMMbC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Oct 2018 08:31:02 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:42749 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727034AbeJMMbA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Oct 2018 08:31:00 -0400
Received: by mail-pf1-f195.google.com with SMTP id f26-v6so7148459pfn.9;
        Fri, 12 Oct 2018 21:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MQkPQ3Ye7d3w5BiZWu8XQjh4/A63Ebp7lKxP6h4EbZE=;
        b=g99Xtb6JDwiEl3wyvYqXX2SmR2T5V42+LyhdkSzzDIpwQqu8NPCNq4rREWOttQ8wYR
         j6Li/rQ7fHUhoI57LZ0rd5IQccaFgExXuebrApHg+Mmymx3d4ge2db4Shm3POrdPi0xy
         6ygDLHiCrj0t+ah/Hghpycbml23+FGwN32MJDaKnrItOzNCF40RqmerhMXu0gu3ynHfS
         GM3E8f5awZYTtRDZyduy/GL3J0uCKQ0geNDzRktqRsVq2V7wrHtYWI7NMC2UT47C3peB
         tzfBZ/xZ8zjXI4937k6S7pinsHZgy2WTr8BUZtKa217nHwCRX92xsliFWPnZBIb8if89
         vXxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=MQkPQ3Ye7d3w5BiZWu8XQjh4/A63Ebp7lKxP6h4EbZE=;
        b=f80GmtV1DAgu8DCtzoUcbz4COWmkScMpNylTnDmd/6CSTbcChUYx6Dsqz0aDTbavSf
         VWP3R2lQVeq2/TDy1ZVWX5QDCxSOttXJNlC5V/XZBLEv8hj8e4Jnz9OVpRyLqGRPYST6
         oMm1day/Z53mhuR1svvU6U7yvZK8JfRKH+1HYK+wUch6q85TlKRox5Zh6J+1h+6YLMET
         A//kt09Q5Ci6LEpzXIPJDiArcBDgBqPtl43BOz1BJVyektdMOPUBRTTt+1WCLr2+e6Fp
         PNm3WGhch4d4kMRkVVxe+XOuBIWA+pQfk9FFROkZ2sWftr4MephkuUUY4zV1VypTvb1K
         GZMw==
X-Gm-Message-State: ABuFfogQSJAYgQ6jtQ0BPOlVmiG6FYE5r9rHEJIn4ZZ1CxXIvbws7UDM
        aD9sJckZA0iaCQD+3W10wuk=
X-Google-Smtp-Source: ACcGV62YEo8xl0qmURaRgThuPQJ8l+1RAltoTf1LqqDn+a+vGT6Ghz0UNjwxBNzW4dS/q0EUGSUnjA==
X-Received: by 2002:aa7:86cc:: with SMTP id h12-v6mr8780573pfo.58.1539406519799;
        Fri, 12 Oct 2018 21:55:19 -0700 (PDT)
Received: from localhost.localdomain (c-24-6-192-50.hsd1.ca.comcast.net. [24.6.192.50])
        by smtp.gmail.com with ESMTPSA id h87-v6sm6959462pfj.78.2018.10.12.21.55.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 12 Oct 2018 21:55:19 -0700 (PDT)
From:   frowand.list@gmail.com
To:     Rob Herring <robh+dt@kernel.org>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Alan Tull <atull@kernel.org>, Moritz Fischer <mdf@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        devicetree@vger.kernel.org, linux-fpga@vger.kernel.org
Subject: [PATCH v2 12/18] of: overlay: check prevents multiple fragments add or delete same node
Date:   Fri, 12 Oct 2018 21:53:32 -0700
Message-Id: <1539406418-18162-13-git-send-email-frowand.list@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1539406418-18162-1-git-send-email-frowand.list@gmail.com>
References: <1539406418-18162-1-git-send-email-frowand.list@gmail.com>
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
fixed two patches later in this series

 drivers/of/overlay.c | 58 ++++++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 49 insertions(+), 9 deletions(-)

diff --git a/drivers/of/overlay.c b/drivers/of/overlay.c
index a3990c20e210..b0a0dafb6a13 100644
--- a/drivers/of/overlay.c
+++ b/drivers/of/overlay.c
@@ -398,14 +398,6 @@ static int add_changeset_property(struct overlay_changeset *ovcs,
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
@@ -523,6 +515,54 @@ static int build_changeset_symbols_node(struct overlay_changeset *ovcs,
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
@@ -577,7 +617,7 @@ static int build_changeset(struct overlay_changeset *ovcs)
 		}
 	}
 
-	return 0;
+	return check_changeset_dup_add_node(ovcs);
 }
 
 /*
-- 
Frank Rowand <frank.rowand@sony.com>

