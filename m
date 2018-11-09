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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 824BDC43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 06:08:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37E6F2086C
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 06:08:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s0wH8Yom"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37E6F2086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728203AbeKIPrE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 10:47:04 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:41697 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728158AbeKIPrD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 10:47:03 -0500
Received: by mail-pl1-f193.google.com with SMTP id p16-v6so445792plr.8;
        Thu, 08 Nov 2018 22:08:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=B33kF9iV0Uu4RxMZKXEawnQNU8qd2/woHNjsUwzS9rE=;
        b=s0wH8YomeWLrPb03gdpSrV8FvNg+cry98nME9qdxQmtbwOeGmOq0GmEX8IbGOxkJvv
         oZd96a5pZLvLvIF78gGHg2Xig3uLwfgMSwRFMoy7/p8rF4cQtTUj2A/N4REYk1cYRgKD
         e2WUgV1RWVU7Mw5onOqqHfJJzubT5HOIMZ1VrIFK0xP6ZlZb+9Tp598x2zOERaW2P9UP
         SlArPRpKTIKONZ2BFUkPPwwhnuDmd4MsWh4T0Jkg324fUjflYp2uCV7Q3WPf258/L/jq
         ggd6I3LlYjUaD/1M4mT++5i1gyfKAyPf8wrO42Wxwb2uAss0UlTvxhY13j/P0OBhJ2+a
         mhxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=B33kF9iV0Uu4RxMZKXEawnQNU8qd2/woHNjsUwzS9rE=;
        b=nRr9bSFucy4seN8nAUbHypLUWKWiKZa5cb4H+hwnlUH0X7qxhqnpo0wg5xuJYS5Gu4
         EnvDNpgYWokrULohSICq5LE+GRX7jw3crAiadjq1H4YokI4CEqKQTd/iwuAikF7t2RC8
         kUDhQsR3coZByVxT+3GeJeO9TKjjXdcv8lIgsmGqbr+1rlM43TYG6WNIlF3VKw2f8Rx0
         71/or2L0oA/9B4pSOGnjAlPYd2riXC+abiRZnBhl0ptZD76tqrtLHKbErZFtBR9GBEbJ
         8o5M+WfMXVqQx5MH/Eks1pVgVRUUXUUGQviIywam7FkGDw70K8GVWcGKodOF8RQk2lZA
         Ip2Q==
X-Gm-Message-State: AGRZ1gKfIpMpoVnEzTDwWoOB5yJnPUAvfWYs0NnOUVEq3E561r8HvcZv
        tqUEww4UAqZlxI15GhNqD9E=
X-Google-Smtp-Source: AJdET5ezU26q3qtFV5XI8uVFXwC43rVlxWbKko340mCXDyN6CqYYMNG3rUhPWdsBExyKgyvIP0cg8A==
X-Received: by 2002:a17:902:163:: with SMTP id 90-v6mr7711103plb.87.1541743682489;
        Thu, 08 Nov 2018 22:08:02 -0800 (PST)
Received: from localhost.localdomain (c-24-6-192-50.hsd1.ca.comcast.net. [24.6.192.50])
        by smtp.gmail.com with ESMTPSA id c70-v6sm6620722pfg.97.2018.11.08.22.08.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 08 Nov 2018 22:08:01 -0800 (PST)
From:   frowand.list@gmail.com
To:     Rob Herring <robh+dt@kernel.org>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Alan Tull <atull@kernel.org>, Moritz Fischer <mdf@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        devicetree@vger.kernel.org, linux-fpga@vger.kernel.org
Subject: [PATCH v7 15/17] of: unittest: allow base devicetree to have symbol metadata
Date:   Thu,  8 Nov 2018 22:06:03 -0800
Message-Id: <1541743565-23163-16-git-send-email-frowand.list@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1541743565-23163-1-git-send-email-frowand.list@gmail.com>
References: <1541743565-23163-1-git-send-email-frowand.list@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frank Rowand <frank.rowand@sony.com>

The overlay metadata nodes in the FDT created from testcases.dts
are not handled properly.

The __fixups__ and __local_fixups__ node were added to the live
devicetree, but should not be.

Only the first property in the /__symbols__ node was added to the
live devicetree if the live devicetree already contained a
/__symbols node.  All of the node's properties must be added.

Tested-by: Alan Tull <atull@kernel.org>
Signed-off-by: Frank Rowand <frank.rowand@sony.com>
---
 drivers/of/unittest.c | 43 +++++++++++++++++++++++++++++++++++--------
 1 file changed, 35 insertions(+), 8 deletions(-)

diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
index 14838b21ec6a..d625a91a7f60 100644
--- a/drivers/of/unittest.c
+++ b/drivers/of/unittest.c
@@ -1071,20 +1071,44 @@ static void __init of_unittest_platform_populate(void)
  *	of np into dup node (present in live tree) and
  *	updates parent of children of np to dup.
  *
- *	@np:	node already present in live tree
+ *	@np:	node whose properties are being added to the live tree
  *	@dup:	node present in live tree to be updated
  */
 static void update_node_properties(struct device_node *np,
 					struct device_node *dup)
 {
 	struct property *prop;
+	struct property *save_next;
 	struct device_node *child;
-
-	for_each_property_of_node(np, prop)
-		of_add_property(dup, prop);
+	int ret;
 
 	for_each_child_of_node(np, child)
 		child->parent = dup;
+
+	/*
+	 * "unittest internal error: unable to add testdata property"
+	 *
+	 *    If this message reports a property in node '/__symbols__' then
+	 *    the respective unittest overlay contains a label that has the
+	 *    same name as a label in the live devicetree.  The label will
+	 *    be in the live devicetree only if the devicetree source was
+	 *    compiled with the '-@' option.  If you encounter this error,
+	 *    please consider renaming __all__ of the labels in the unittest
+	 *    overlay dts files with an odd prefix that is unlikely to be
+	 *    used in a real devicetree.
+	 */
+
+	/*
+	 * open code for_each_property_of_node() because of_add_property()
+	 * sets prop->next to NULL
+	 */
+	for (prop = np->properties; prop != NULL; prop = save_next) {
+		save_next = prop->next;
+		ret = of_add_property(dup, prop);
+		if (ret)
+			pr_err("unittest internal error: unable to add testdata property %pOF/%s",
+			       np, prop->name);
+	}
 }
 
 /**
@@ -1093,18 +1117,23 @@ static void update_node_properties(struct device_node *np,
  *
  *	@np:	Node to attach to live tree
  */
-static int attach_node_and_children(struct device_node *np)
+static void attach_node_and_children(struct device_node *np)
 {
 	struct device_node *next, *dup, *child;
 	unsigned long flags;
 	const char *full_name;
 
 	full_name = kasprintf(GFP_KERNEL, "%pOF", np);
+
+	if (!strcmp(full_name, "/__local_fixups__") ||
+	    !strcmp(full_name, "/__fixups__"))
+		return;
+
 	dup = of_find_node_by_path(full_name);
 	kfree(full_name);
 	if (dup) {
 		update_node_properties(np, dup);
-		return 0;
+		return;
 	}
 
 	child = np->child;
@@ -1125,8 +1154,6 @@ static int attach_node_and_children(struct device_node *np)
 		attach_node_and_children(child);
 		child = next;
 	}
-
-	return 0;
 }
 
 /**
-- 
Frank Rowand <frank.rowand@sony.com>

