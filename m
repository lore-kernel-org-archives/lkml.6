Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64D64C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 17:28:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30E6A20675
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 17:28:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545067724;
	bh=8uVUZq2TRCvabAuqhJxdARx5sGhgg1dV7CbeBgIkHHs=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=odnMSUk5BSQIcwUN7Mb4DjPgp1aNFw+lZqsli8Q5ou6Ut3ooK9zEI/mjfXPbg8C2+
	 s2kmCudpcyEH4MUwoVvMYuG/NOOJBHAkyaLxrMQsweWtL0ittwtRTF4XvnDH211MEU
	 QUZ4SQ/pj2xfBoB+VrM7sghDfQ5oQasw9vqoAtMI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732963AbeLQR2n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 12:28:43 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:37085 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726436AbeLQR2m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 12:28:42 -0500
Received: by mail-ot1-f68.google.com with SMTP id 40so12926812oth.4;
        Mon, 17 Dec 2018 09:28:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8NmIBVoeKBeAZTXKLe4KWvaKj+jyo0p9haMIP3XNRgk=;
        b=Emf8JmA8oa9prBPhvRjgYsbRevzO1BBQR8eAO8oa0QFdtMBskIIWWUn3/jcMBdrOfl
         tr4/Ov7XpOL6TF4BkHvvHAEmpaaJ3lm3idKqf1IDdl5qYptWcmPLvXYcqSIIdwATn1DI
         BJa4mVZRO7uleqBoAL91tGP68mnGan5WkeYoaf8zDjdCx+hnXyJtxI3ZHzNJGrMPSccv
         kd5LNPqNNR4d+JArLO6x4mosjzes7fFC8NKSxO4iUoOpzcwPmXSOuAFS0i0J0KtuAZjR
         H7h2ObPgIGklJPkVbLmAnqN3SEnX40X4xEn8NYlS6kXIsrs6id9583mgKeJUFBrWAYww
         kcyw==
X-Gm-Message-State: AA+aEWZorcf044totQ5kVkSJUe7/H5/gn4Mf2GQTrPl0cU8vGBZLXWK+
        4jX+EFMB3QjCk5oFpmZOFQblmp4=
X-Google-Smtp-Source: AFSGD/XpVDYYU50T5o2mx2FVlBkC1Ls7+atTgh7ZBqGG/V0ePuRj7TaWWzXq7HvZIScPa4NLOJ1CZw==
X-Received: by 2002:a9d:3646:: with SMTP id w64mr9554784otb.118.1545067721342;
        Mon, 17 Dec 2018 09:28:41 -0800 (PST)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id i12sm6143219otr.74.2018.12.17.09.28.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Dec 2018 09:28:40 -0800 (PST)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Frank Rowand <frowand.list@gmail.com>
Subject: [PATCH] of: Remove struct device_node.type pointer
Date:   Mon, 17 Dec 2018 11:28:38 -0600
Message-Id: <20181217172838.25495-1-robh@kernel.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that all users of device_node.type pointer have been removed in
favor of accessor functions, we can remove it.

Cc: Frank Rowand <frowand.list@gmail.com>
Cc: devicetree@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
All the dependencies for this are in linux-next now. I plan to apply and 
send this at the end of the merge window.

Rob

 drivers/of/dynamic.c | 3 ---
 drivers/of/fdt.c     | 4 ----
 drivers/of/overlay.c | 3 ---
 drivers/of/pdt.c     | 1 -
 include/linux/of.h   | 1 -
 5 files changed, 12 deletions(-)

diff --git a/drivers/of/dynamic.c b/drivers/of/dynamic.c
index b4e5b90cb314..ae04a138a729 100644
--- a/drivers/of/dynamic.c
+++ b/drivers/of/dynamic.c
@@ -207,11 +207,8 @@ static void __of_attach_node(struct device_node *np)
 
 	if (!of_node_check_flag(np, OF_OVERLAY)) {
 		np->name = __of_get_property(np, "name", NULL);
-		np->type = __of_get_property(np, "device_type", NULL);
 		if (!np->name)
 			np->name = "<NULL>";
-		if (!np->type)
-			np->type = "<NULL>";
 
 		phandle = __of_get_property(np, "phandle", &sz);
 		if (!phandle)
diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index 7099c652c6a5..9cc1461aac7d 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -314,12 +314,8 @@ static bool populate_node(const void *blob,
 	populate_properties(blob, offset, mem, np, pathp, dryrun);
 	if (!dryrun) {
 		np->name = of_get_property(np, "name", NULL);
-		np->type = of_get_property(np, "device_type", NULL);
-
 		if (!np->name)
 			np->name = "<NULL>";
-		if (!np->type)
-			np->type = "<NULL>";
 	}
 
 	*pnp = np;
diff --git a/drivers/of/overlay.c b/drivers/of/overlay.c
index 2b5ac43a5690..c423e94baf0f 100644
--- a/drivers/of/overlay.c
+++ b/drivers/of/overlay.c
@@ -423,12 +423,9 @@ static int add_changeset_node(struct overlay_changeset *ovcs,
 
 		tchild->parent = target->np;
 		tchild->name = __of_get_property(node, "name", NULL);
-		tchild->type = __of_get_property(node, "device_type", NULL);
 
 		if (!tchild->name)
 			tchild->name = "<NULL>";
-		if (!tchild->type)
-			tchild->type = "<NULL>";
 
 		/* ignore obsolete "linux,phandle" */
 		phandle = __of_get_property(node, "phandle", &size);
diff --git a/drivers/of/pdt.c b/drivers/of/pdt.c
index d3185063d369..7eda43c66c91 100644
--- a/drivers/of/pdt.c
+++ b/drivers/of/pdt.c
@@ -155,7 +155,6 @@ static struct device_node * __init of_pdt_create_node(phandle node,
 	dp->parent = parent;
 
 	dp->name = of_pdt_get_one_property(node, "name");
-	dp->type = of_pdt_get_one_property(node, "device_type");
 	dp->phandle = node;
 
 	dp->properties = of_pdt_build_prop_list(node);
diff --git a/include/linux/of.h b/include/linux/of.h
index fe472e5195a9..e240992e5cb6 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -50,7 +50,6 @@ struct of_irq_controller;
 
 struct device_node {
 	const char *name;
-	const char *type;
 	phandle phandle;
 	const char *full_name;
 	struct fwnode_handle fwnode;
-- 
2.19.1

