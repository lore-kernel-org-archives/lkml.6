Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78833C04EB9
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 02:39:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F0E320869
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 02:39:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oysgHh72"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F0E320869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727308AbeJPK1i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 06:27:38 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:33810 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727169AbeJPK1f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 06:27:35 -0400
Received: by mail-pl1-f194.google.com with SMTP id f18-v6so10224716plr.1;
        Mon, 15 Oct 2018 19:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=M4dGHNWK9yvMCplN74sEUY4ZcqWQ+poGeb6zjVC5TlY=;
        b=oysgHh72/mxaYZJ/b4PNJjAyoRV/9Ke5PLphlbEgRdZLmnPLLXZMuiv3pNucPd20b9
         lJfhKxdauam/g86u//Gj7Grz7sTpjlYnNsrx3znoPKz6Kj+m7vIQR23cseO2MrGD7fhX
         /2xvZYe6vMxR8ykMXUe7SWCaCWwPDlyQQplb7+gKF8SW5MPuKPhS+3deAgMf0xead0Al
         jPc+9nX0CFIoYFToLua4fNn2ngjyjbrM4PXZrbKEKTWwOerCpaudyx0WEcx/djS8pG6Z
         ZKwF0IThjR0CJ9DXVvCX8KgYW2pjYiYDvqDqvKPwN4q0jZ8dwQRUbg15jMl8VFlV8p18
         PgRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=M4dGHNWK9yvMCplN74sEUY4ZcqWQ+poGeb6zjVC5TlY=;
        b=Ovk9hP3TkDV4QdC1TtJNWCLW38uMC4LUv5wgV5MlLBvgBTm3eTBC7CPZdlb84w8boE
         Yp1OSjZgiICxmlXCfegH/ETI5gi6NV23NOlTFTz7620dLU6DAtGsd9+8/XTEt91yOojK
         LuutnYyanBTWlVaVa+gytwZ1/KGKzcfmLY/wVJrwEpHnhxfyuoyDqxpsND9kSzY2S3BO
         /O7/REx7jmHNPtCW9OWYvHpPmpkt1cYR1ejVyWvCuAJssRITEQrFs8rDdOrSk+8pVJeL
         u/BubCOVnRwldixoGhR4tJGGjTALb2RqYmJrXU9k+kOe2S5OVRaSQiZ4gWOIWxeBf0WH
         Ue6Q==
X-Gm-Message-State: ABuFfojRltoMLOA+Cg+rLQ21RoVQAx6gbzN0ZgmGjuNoBguZNUxBpV4d
        8zaRuCtjNR5q+V8gKl800Sg=
X-Google-Smtp-Source: ACcGV63d3vRFZ4hSByVFcvJTV5I3AI3LA286eh40EnB5CM0oRhr5qnVGgvmTyXfmlsRe22aPcHBdWQ==
X-Received: by 2002:a17:902:8648:: with SMTP id y8-v6mr19912804plt.335.1539657571277;
        Mon, 15 Oct 2018 19:39:31 -0700 (PDT)
Received: from localhost.localdomain (c-24-6-192-50.hsd1.ca.comcast.net. [24.6.192.50])
        by smtp.gmail.com with ESMTPSA id u79-v6sm18620287pfd.117.2018.10.15.19.39.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 15 Oct 2018 19:39:30 -0700 (PDT)
From:   frowand.list@gmail.com
To:     Rob Herring <robh+dt@kernel.org>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Alan Tull <atull@kernel.org>, Moritz Fischer <mdf@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        devicetree@vger.kernel.org, linux-fpga@vger.kernel.org
Subject: [PATCH v4 16/18] of: unittest: allow base devicetree to have symbol metadata
Date:   Mon, 15 Oct 2018 19:37:36 -0700
Message-Id: <1539657458-24401-17-git-send-email-frowand.list@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1539657458-24401-1-git-send-email-frowand.list@gmail.com>
References: <1539657458-24401-1-git-send-email-frowand.list@gmail.com>
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

