Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3D43C67863
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 22:48:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B0E82098A
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 22:48:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tPahr7z+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B0E82098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727709AbeJSGvc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 02:51:32 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:33222 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727474AbeJSGvc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 02:51:32 -0400
Received: by mail-pl1-f194.google.com with SMTP id s4-v6so14976348plp.0;
        Thu, 18 Oct 2018 15:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UyISa4Vgk45B7KLWkPwTcGVnrcGhj2ncy5/h8GMRMMc=;
        b=tPahr7z+tjGM61BJ7XrxUM2d4duxBQoLxE9WA6LQQMwP1OeMLjZMz17Q2Qx3xfSXnI
         Ja7Umyzk6lcBgPZYT5HxxXHElsbJRJVdrZ8ibLbeWc7lMd97ZB57sKBkr3P+EI/ZizrF
         Cb3FHHlWv7C2w26qW3BsfgMp70StEZfIGek7XwEzOKZSD2NxI9zy53OJWUQmhwB0Dwcd
         uQzYQ/v75v1yrdWxMC6PKGOvIEq5g5851HZ8jWTdhzjy7vH4J9htpNQoe6Rf92Wg6UBu
         cjvvP2DVVi2WLk+VsJ5Vyt4uTlJY0VlN8XT1Gwb3C94XJ1QVfMwzDvg62brCJZLKQEFs
         PEhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=UyISa4Vgk45B7KLWkPwTcGVnrcGhj2ncy5/h8GMRMMc=;
        b=VsnjHdkSt5yy6TMOglzhELxQxX1gygMGLOB/6OJiiIq7lXXqLehXB5KkEMvuTF26U1
         SuzOlMD9nKX61Rz7B3bWQzvg25yEjuCq7WYlqIYDIsadP5cMx3ZWHGz70R4aS4uVgoXf
         wgByPgV9T8/ObFNoFzR/GRI2BNaWcXuw8yde15yVF3a/axhs03yIuzGPtux3TldXZ0gU
         9nWB2Ybost6o8rZblxxSuKPKoTAZfgmOnnLUig7TuMxnikpbSN8Cy7J7RFSqKSSc03AO
         FY7XJtneZzompYjbOmDSj1ojp5a3FAjJ90rOjdcOu2fmzcGb7go/H1UYFLpoI4a0B6fx
         c76w==
X-Gm-Message-State: ABuFfogoH9GgCz/JBmQbYp6rKQxoxQ3DFiTAbCq5G98Vz9OfUIApOadS
        uJkr2DreGqpw4VZsm74N7gQ=
X-Google-Smtp-Source: ACcGV60J7agimDNbHWa/FB2EUSr2pUmCOzaCSwUjGjDK+XORHP4FFsvxv0MZI1zqWMb5t+hMB3tUoA==
X-Received: by 2002:a17:902:7109:: with SMTP id a9-v6mr31604083pll.310.1539902902454;
        Thu, 18 Oct 2018 15:48:22 -0700 (PDT)
Received: from localhost.localdomain (c-24-6-192-50.hsd1.ca.comcast.net. [24.6.192.50])
        by smtp.gmail.com with ESMTPSA id v81-v6sm38129268pfj.25.2018.10.18.15.48.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 18 Oct 2018 15:48:21 -0700 (PDT)
From:   frowand.list@gmail.com
To:     Rob Herring <robh+dt@kernel.org>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Alan Tull <atull@kernel.org>, Moritz Fischer <mdf@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        devicetree@vger.kernel.org, linux-fpga@vger.kernel.org
Subject: [PATCH v5 15/18] of: overlay: set node fields from properties when add new overlay node
Date:   Thu, 18 Oct 2018 15:46:33 -0700
Message-Id: <1539902796-8382-16-git-send-email-frowand.list@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1539902796-8382-1-git-send-email-frowand.list@gmail.com>
References: <1539902796-8382-1-git-send-email-frowand.list@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frank Rowand <frank.rowand@sony.com>

Overlay nodes added by add_changeset_node() do not have the node
fields name, phandle, and type set.

The node passed to __of_attach_node() when the add node changeset
entry is processed does not contain any properties.  The node's
properties are located in add property changeset entries that will
be processed after the add node changeset is applied.

Set the node's fields in the node contained in the add node
changeset entry and do not set them to incorrect values in
add_changeset_node().

A visible symptom that is fixed by this patch is the names of nodes
added by overlays that have an entry in /sys/bus/platform/drivers/*/
will contain the unit-address but the node-name will be <NULL>,  for
example, "fc4ab000.<NULL>".  After applying the patch the name, in
this example, for node restart@fc4ab000 is "fc4ab000.restart".

Signed-off-by: Frank Rowand <frank.rowand@sony.com>
---
 drivers/of/dynamic.c | 27 ++++++++++++++++++---------
 drivers/of/overlay.c | 29 ++++++++++++++++++++++++-----
 2 files changed, 42 insertions(+), 14 deletions(-)

diff --git a/drivers/of/dynamic.c b/drivers/of/dynamic.c
index beea792debb6..43e1ccb9c387 100644
--- a/drivers/of/dynamic.c
+++ b/drivers/of/dynamic.c
@@ -205,15 +205,24 @@ static void __of_attach_node(struct device_node *np)
 	const __be32 *phandle;
 	int sz;
 
-	np->name = __of_get_property(np, "name", NULL) ? : "<NULL>";
-	np->type = __of_get_property(np, "device_type", NULL) ? : "<NULL>";
-
-	phandle = __of_get_property(np, "phandle", &sz);
-	if (!phandle)
-		phandle = __of_get_property(np, "linux,phandle", &sz);
-	if (IS_ENABLED(CONFIG_PPC_PSERIES) && !phandle)
-		phandle = __of_get_property(np, "ibm,phandle", &sz);
-	np->phandle = (phandle && (sz >= 4)) ? be32_to_cpup(phandle) : 0;
+	if (!of_node_check_flag(np, OF_OVERLAY)) {
+		np->name = __of_get_property(np, "name", NULL);
+		np->type = __of_get_property(np, "device_type", NULL);
+		if (!np->name)
+			np->name = "<NULL>";
+		if (!np->type)
+			np->type = "<NULL>";
+
+		phandle = __of_get_property(np, "phandle", &sz);
+		if (!phandle)
+			phandle = __of_get_property(np, "linux,phandle", &sz);
+		if (IS_ENABLED(CONFIG_PPC_PSERIES) && !phandle)
+			phandle = __of_get_property(np, "ibm,phandle", &sz);
+		if (phandle && (sz >= 4))
+			np->phandle = be32_to_cpup(phandle);
+		else
+			np->phandle = 0;
+	}
 
 	np->child = NULL;
 	np->sibling = np->parent->child;
diff --git a/drivers/of/overlay.c b/drivers/of/overlay.c
index 9e4af83c8c62..eaedb3a63077 100644
--- a/drivers/of/overlay.c
+++ b/drivers/of/overlay.c
@@ -307,10 +307,11 @@ static int add_changeset_property(struct overlay_changeset *ovcs,
 	int ret = 0;
 	bool check_for_non_overlay_node = false;
 
-	if (!of_prop_cmp(overlay_prop->name, "name") ||
-	    !of_prop_cmp(overlay_prop->name, "phandle") ||
-	    !of_prop_cmp(overlay_prop->name, "linux,phandle"))
-		return 0;
+	if (target->in_livetree)
+		if (!of_prop_cmp(overlay_prop->name, "name") ||
+		    !of_prop_cmp(overlay_prop->name, "phandle") ||
+		    !of_prop_cmp(overlay_prop->name, "linux,phandle"))
+			return 0;
 
 	if (target->in_livetree)
 		prop = of_find_property(target->np, overlay_prop->name, NULL);
@@ -330,6 +331,10 @@ static int add_changeset_property(struct overlay_changeset *ovcs,
 
 	if (!prop) {
 		check_for_non_overlay_node = true;
+		if (!target->in_livetree) {
+			new_prop->next = target->np->deadprops;
+			target->np->deadprops = new_prop;
+		}
 		ret = of_changeset_add_property(&ovcs->cset, target->np,
 						new_prop);
 	} else if (!of_prop_cmp(prop->name, "#address-cells")) {
@@ -400,9 +405,10 @@ static int add_changeset_node(struct overlay_changeset *ovcs,
 		struct target *target, struct device_node *node)
 {
 	const char *node_kbasename;
+	const __be32 *phandle;
 	struct device_node *tchild;
 	struct target target_child;
-	int ret = 0;
+	int ret = 0, size;
 
 	node_kbasename = kbasename(node->full_name);
 
@@ -416,6 +422,19 @@ static int add_changeset_node(struct overlay_changeset *ovcs,
 			return -ENOMEM;
 
 		tchild->parent = target->np;
+		tchild->name = __of_get_property(node, "name", NULL);
+		tchild->type = __of_get_property(node, "device_type", NULL);
+
+		if (!tchild->name)
+			tchild->name = "<NULL>";
+		if (!tchild->type)
+			tchild->type = "<NULL>";
+
+		/* ignore obsolete "linux,phandle" */
+		phandle = __of_get_property(node, "phandle", &size);
+		if (phandle && (size == 4))
+			tchild->phandle = be32_to_cpup(phandle);
+
 		of_node_set_flag(tchild, OF_OVERLAY);
 
 		ret = of_changeset_attach_node(&ovcs->cset, tchild);
-- 
Frank Rowand <frank.rowand@sony.com>

