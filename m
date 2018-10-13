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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D159DC71124
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 04:55:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88D70204EC
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 04:55:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XZ4qXCA6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88D70204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726979AbeJMMa5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Oct 2018 08:30:57 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:39048 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726758AbeJMMa4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Oct 2018 08:30:56 -0400
Received: by mail-pl1-f194.google.com with SMTP id w14-v6so6817214plp.6;
        Fri, 12 Oct 2018 21:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BwKhWXvi9uObifIA2caG7KxBnrbJ0SRY7Oj5Ow4g1sM=;
        b=XZ4qXCA6jBwzs4BJQJHCEF4+8gTh9fFr52BmTGEckHBTT9Nra/WMAJ32F3wyt0umZg
         jZ/jQJJx5dBAt/rhoUf98Vv9w6ypT/t1mMO5oZH2qxL61LON4yddsoR/uRFTw5yHXkKj
         J5ZsNLbBRQ1gpU/EHhZoxab8VZViK0hPgMy6DtQa2+JdFaaOlUyQZ7zGguVWI42m/hD1
         ecgYiRoFLOlxQOSs+CS/d8KW3UttiD/brvms5FD/0Oq4jr9g6nlC+4bZKnBYM9xqHsLI
         TkdT4gIDUMvA0QLBxMnlyNgnLkhFjzy0FtV4Bm2stIZbhi08mQkJZOREl5RA9E9SFrMO
         2epg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BwKhWXvi9uObifIA2caG7KxBnrbJ0SRY7Oj5Ow4g1sM=;
        b=Nr2IiXgtkwwl5Y4iR0GLZO0Q6MkmTJy9Utw9t9XSKjP0+hukqrq8hI8MXilAmKsWjA
         EFR832dsFTPCp5SnlYN/UKOdhJbfifrJnZmDNcSHCOPr29kGKXIO/CiykBjignX9XW+t
         xhwthHCxlX+n5y6DsnXoSO5KI86BmiVVbkLlr70Jt02Uhg9FdKw/Ys112m8FMsmN0JKv
         0L98/W7WU/TtMj6Ox20+ZeYyK/p67lQXOPUsrtuOIzcfttG6nbVlZ581V7B6pa1PXeMo
         cd5llRJENCOiTD6d7056hy5jHMZtSW/xivWrhtuYwoZeA2GcAigdq7wlaPvJcNxYYr8W
         VEnQ==
X-Gm-Message-State: ABuFfogUfzFcDIibAv3Zvkgqp4bWHbh1eZc5ILmCqvQRCNGVj8Lpb7Y8
        hyv5dDFuPNQ8WfBCetD2ZXg=
X-Google-Smtp-Source: ACcGV62f3udKGPelQenyfTrmljSknUmfOiXF7LK4m9fe8WDAEAmXINJzXsckXVJCGBO/ZFK64aRSTA==
X-Received: by 2002:a17:902:2:: with SMTP id 2-v6mr8743154pla.178.1539406516046;
        Fri, 12 Oct 2018 21:55:16 -0700 (PDT)
Received: from localhost.localdomain (c-24-6-192-50.hsd1.ca.comcast.net. [24.6.192.50])
        by smtp.gmail.com with ESMTPSA id h87-v6sm6959462pfj.78.2018.10.12.21.55.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 12 Oct 2018 21:55:15 -0700 (PDT)
From:   frowand.list@gmail.com
To:     Rob Herring <robh+dt@kernel.org>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Alan Tull <atull@kernel.org>, Moritz Fischer <mdf@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        devicetree@vger.kernel.org, linux-fpga@vger.kernel.org
Subject: [PATCH v2 09/18] of: overlay: validate overlay properties #address-cells and #size-cells
Date:   Fri, 12 Oct 2018 21:53:29 -0700
Message-Id: <1539406418-18162-10-git-send-email-frowand.list@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1539406418-18162-1-git-send-email-frowand.list@gmail.com>
References: <1539406418-18162-1-git-send-email-frowand.list@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frank Rowand <frank.rowand@sony.com>

If overlay properties #address-cells or #size-cells are already in
the live devicetree for any given node, then the values in the
overlay must match the values in the live tree.

If the properties are already in the live tree then there is no
need to create a changeset entry to add them since they must
have the same value.  This reduces the memory used by the
changeset and eliminates a possible memory leak.  This is
verified by 12 fewer warnings during the devicetree unittest,
as the possible memory leak warnings about #address-cells and

Signed-off-by: Frank Rowand <frank.rowand@sony.com>
---
 drivers/of/overlay.c | 38 +++++++++++++++++++++++++++++++++++---
 1 file changed, 35 insertions(+), 3 deletions(-)

diff --git a/drivers/of/overlay.c b/drivers/of/overlay.c
index 272a0d1a5e18..ee66651db553 100644
--- a/drivers/of/overlay.c
+++ b/drivers/of/overlay.c
@@ -287,7 +287,12 @@ static struct property *dup_and_fixup_symbol_prop(
  * @target may be either in the live devicetree or in a new subtree that
  * is contained in the changeset.
  *
- * Some special properties are not updated (no error returned).
+ * Some special properties are not added or updated (no error returned):
+ * "name", "phandle", "linux,phandle".
+ *
+ * Properties "#address-cells" and "#size-cells" are not updated if they
+ * are already in the live tree, but if present in the live tree, the values
+ * in the overlay must match the values in the live tree.
  *
  * Update of property in symbols node is not allowed.
  *
@@ -300,6 +305,7 @@ static int add_changeset_property(struct overlay_changeset *ovcs,
 {
 	struct property *new_prop = NULL, *prop;
 	int ret = 0;
+	bool check_for_non_overlay_node = false;
 
 	if (!of_prop_cmp(overlay_prop->name, "name") ||
 	    !of_prop_cmp(overlay_prop->name, "phandle") ||
@@ -322,13 +328,39 @@ static int add_changeset_property(struct overlay_changeset *ovcs,
 	if (!new_prop)
 		return -ENOMEM;
 
-	if (!prop)
+	if (!prop) {
+
+		check_for_non_overlay_node = true;
 		ret = of_changeset_add_property(&ovcs->cset, target->np,
 						new_prop);
-	else
+
+	} else if (!of_prop_cmp(prop->name, "#address-cells")) {
+
+		if (prop->length != 4 || new_prop->length != 4 ||
+		    *(u32 *)prop->value != *(u32 *)new_prop->value)
+			pr_err("ERROR: overlay and/or live tree #address-cells invalid in node %pOF\n",
+			       target->np);
+
+	} else if (!of_prop_cmp(prop->name, "#size-cells")) {
+
+		if (prop->length != 4 || new_prop->length != 4 ||
+		    *(u32 *)prop->value != *(u32 *)new_prop->value)
+			pr_err("ERROR: overlay and/or live tree #size-cells invalid in node %pOF\n",
+			       target->np);
+
+	} else {
+
+		check_for_non_overlay_node = true;
 		ret = of_changeset_update_property(&ovcs->cset, target->np,
 						   new_prop);
 
+	}
+
+	if (check_for_non_overlay_node &&
+	    !of_node_check_flag(target->np, OF_OVERLAY))
+		pr_err("WARNING: %s(), memory leak will occur if overlay removed.  Property: %pOF/%s\n",
+		       __func__, target->np, new_prop->name);
+
 	if (ret) {
 		kfree(new_prop->name);
 		kfree(new_prop->value);
-- 
Frank Rowand <frank.rowand@sony.com>

