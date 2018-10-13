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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C423EC71122
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 04:55:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FB89204EC
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 04:55:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S3o6SlIa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FB89204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727267AbeJMMbJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Oct 2018 08:31:09 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:45001 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727164AbeJMMbG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Oct 2018 08:31:06 -0400
Received: by mail-pf1-f196.google.com with SMTP id r9-v6so7148632pff.11;
        Fri, 12 Oct 2018 21:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=M4dGHNWK9yvMCplN74sEUY4ZcqWQ+poGeb6zjVC5TlY=;
        b=S3o6SlIagmxnHfGrZI34r2HygKejAau1DPnNDbTQCEXLsdkEHMURCgMKM2hiSXKucQ
         GPmURtlvC/py9Hvtwx82PdYeCK+1JhVRuCiasUOBgeBJam8O8/kHdDk+qZpNLFJ6qGgk
         5RpSRHDuUyi6ebBOsmdfZdUQS4NYZCiUO2hucgejZIIu10fnOjOIIODj/ORaJnMuQcy2
         96deMshDa1STmPN/f2GVNywsH2V9RTM32EG/SKy50NZ98vHB+WTp4dHwVC89dWjzlRO7
         yHU+n828MdpsXCF2wt/uo0qdzDKQoCt0EUFSnXW4eN3o0NxANyd/a0ZiEfiI981ceyBy
         NZhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=M4dGHNWK9yvMCplN74sEUY4ZcqWQ+poGeb6zjVC5TlY=;
        b=M//kWHewnTRQn9uuv4WQLgQrAjkoZ2CoWO2xDjmhK+G67gwggE7vclsdVuutrPBrp5
         vSnY0EbnO1kxgwpkmGcvTjdZtz3sGLnmklfLeMCOnTEpxGrIPxyHGfw5mEELNwmoTTrw
         kaEusMLmTRW86y/dLR+mw1daGfZAiy9XLXu2RpybOifhYzgThppAHnIYnek6OzX2xTUG
         X5/34tssDdaw6oRomW6BQhulUwLrUOij7rBSw9eEM8tqGEveIrNLgMOOKDc/1Qq75rOh
         GhOWriatslnPqzpovBr6BZpKLL6F3IRwnCgPIHxzMaxHkkyy7fy0c3wYeVxLzbYFMM1b
         CckQ==
X-Gm-Message-State: ABuFfogsZqka7J0Cm1nTU0zOQM5cmdahxYlYatTHsz3xQBn6Ie5jHHIS
        vqfnWXyIFcCofu2SamsIZk4=
X-Google-Smtp-Source: ACcGV60vRUunZJMX+N8YwJwVcENXCI6zkkcPu3pWwg+A1ei+wf5ZAed2gu6okwiTBfo4Ne0KfSTbwg==
X-Received: by 2002:a62:5ac6:: with SMTP id o189-v6mr9102764pfb.40.1539406524814;
        Fri, 12 Oct 2018 21:55:24 -0700 (PDT)
Received: from localhost.localdomain (c-24-6-192-50.hsd1.ca.comcast.net. [24.6.192.50])
        by smtp.gmail.com with ESMTPSA id h87-v6sm6959462pfj.78.2018.10.12.21.55.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 12 Oct 2018 21:55:24 -0700 (PDT)
From:   frowand.list@gmail.com
To:     Rob Herring <robh+dt@kernel.org>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Alan Tull <atull@kernel.org>, Moritz Fischer <mdf@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        devicetree@vger.kernel.org, linux-fpga@vger.kernel.org
Subject: [PATCH v2 16/18] of: unittest: allow base devicetree to have symbol metadata
Date:   Fri, 12 Oct 2018 21:53:36 -0700
Message-Id: <1539406418-18162-17-git-send-email-frowand.list@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1539406418-18162-1-git-send-email-frowand.list@gmail.com>
References: <1539406418-18162-1-git-send-email-frowand.list@gmail.com>
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

Signed-off-by: Frank Rowand <frank.rowand@sony.com>
---
 drivers/of/unittest.c | 43 +++++++++++++++++++++++++++++++++++--------
 1 file changed, 35 insertions(+), 8 deletions(-)

diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
index 6d80f474c8f2..1c2bd8503095 100644
--- a/drivers/of/unittest.c
+++ b/drivers/of/unittest.c
@@ -1057,20 +1057,44 @@ static void __init of_unittest_platform_populate(void)
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
@@ -1079,18 +1103,23 @@ static void update_node_properties(struct device_node *np,
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
@@ -1111,8 +1140,6 @@ static int attach_node_and_children(struct device_node *np)
 		attach_node_and_children(child);
 		child = next;
 	}
-
-	return 0;
 }
 
 /**
-- 
Frank Rowand <frank.rowand@sony.com>

