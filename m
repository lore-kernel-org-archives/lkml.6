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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 858C7C67863
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 22:48:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E02A20866
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 22:48:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HZR4PRXS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E02A20866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727621AbeJSGv0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 02:51:26 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:38860 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727474AbeJSGvZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 02:51:25 -0400
Received: by mail-pf1-f196.google.com with SMTP id f29-v6so15558995pff.5;
        Thu, 18 Oct 2018 15:48:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3p9z0Ehj9iwgF9Lhv52flr3WKpZAxs8EQb4W3gnL4wU=;
        b=HZR4PRXSXC3f+OMGauO6hcsGtA18EWWZyAT13lTC6JiP5/njGLW9QpgSTrjkm7AeTO
         Pzmpj4MLhYvoEk+cie1GsGqJaiagsjDi7S0n8R2EhGyO484/VyfjWaH13PygS5PYvk40
         WwPi66GZ5/4OCIz7qmmL/QWx9pFrFTdN5CbtAmZIHGRHd5cOn+c1KHWYAukRamdds023
         nvmun3DYUlpi+ItHi37r2vXpUD3wQju2cOI6OkHwSlra/QeFcBYY5ASZHKho8CW+xakb
         Wfb3ySCml32Gdsk8DkDsHlzGzyi5GcS7qIcLChl0fNRPs08grrWiuESLsBbqh5wHJylE
         JObw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3p9z0Ehj9iwgF9Lhv52flr3WKpZAxs8EQb4W3gnL4wU=;
        b=oJXaTuH1hTOHoGg1bIced/mVvMEJXBjbcsYacA5Km9pvx6Ki64qxC9l7Qx/+dXk+4l
         kD+Huomme1S0KwXkdqLHk6Ux91Lz4aIDk3jhzJHfYhMtlHdxCuirRvH3OLgCkHfIM3ds
         NTTgkpTHuyZ5Iq2xpOol4mdwtzjWjWo/hevDmfUZ6T4IegbCJ+L7wYhl/wlzvyq1QvhH
         NGJsZ7IYUxs9vp6GAeZ276z4gblUzmgbsVINyfODdmLmXezNxR4EjTrcovFfmgT/8xgD
         8HmkC8KW3MLJrUAs6C9rseBnROs2EaiP0qPhzrIWulR/aiqqwZxota6h6DkFCvn24kTf
         7fAw==
X-Gm-Message-State: ABuFfoh7W1qSmSJFHqK2RDGqbpnf5Juqo+NJh3ctXmKSsxkFU/yQM1Cy
        Ki1rz5JL/EwMRXF7BoNQ7no=
X-Google-Smtp-Source: ACcGV62j6brXEhvm6NxaHvXh8fuyuIlHYH77b5IHomUnKE2awpa6wXOXu3BxaUyrg4+cW2Injfp+/g==
X-Received: by 2002:a62:8f:: with SMTP id 137-v6mr31996648pfa.24.1539902895523;
        Thu, 18 Oct 2018 15:48:15 -0700 (PDT)
Received: from localhost.localdomain (c-24-6-192-50.hsd1.ca.comcast.net. [24.6.192.50])
        by smtp.gmail.com with ESMTPSA id v81-v6sm38129268pfj.25.2018.10.18.15.48.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 18 Oct 2018 15:48:15 -0700 (PDT)
From:   frowand.list@gmail.com
To:     Rob Herring <robh+dt@kernel.org>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Alan Tull <atull@kernel.org>, Moritz Fischer <mdf@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        devicetree@vger.kernel.org, linux-fpga@vger.kernel.org
Subject: [PATCH v5 09/18] of: overlay: validate overlay properties #address-cells and #size-cells
Date:   Thu, 18 Oct 2018 15:46:27 -0700
Message-Id: <1539902796-8382-10-git-send-email-frowand.list@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1539902796-8382-1-git-send-email-frowand.list@gmail.com>
References: <1539902796-8382-1-git-send-email-frowand.list@gmail.com>
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
changeset and eliminates a possible memory leak.

Signed-off-by: Frank Rowand <frank.rowand@sony.com>
---

Changes since v4:
  - create of_prop_val_eq() and change open code to use it
  - remove extra blank lines

 drivers/of/overlay.c | 32 +++++++++++++++++++++++++++++---
 include/linux/of.h   |  6 ++++++
 2 files changed, 35 insertions(+), 3 deletions(-)

diff --git a/drivers/of/overlay.c b/drivers/of/overlay.c
index 272a0d1a5e18..e20d8923f475 100644
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
@@ -322,12 +328,32 @@ static int add_changeset_property(struct overlay_changeset *ovcs,
 	if (!new_prop)
 		return -ENOMEM;
 
-	if (!prop)
+	if (!prop) {
+		check_for_non_overlay_node = true;
 		ret = of_changeset_add_property(&ovcs->cset, target->np,
 						new_prop);
-	else
+	} else if (!of_prop_cmp(prop->name, "#address-cells")) {
+		if (!of_prop_val_eq(prop, new_prop)) {
+			pr_err("ERROR: changing value of #address-cells is not allowed in %pOF\n",
+			       target->np);
+			ret = -EINVAL;
+		}
+	} else if (!of_prop_cmp(prop->name, "#size-cells")) {
+		if (!of_prop_val_eq(prop, new_prop)) {
+			pr_err("ERROR: changing value of #size-cells is not allowed in %pOF\n",
+			       target->np);
+			ret = -EINVAL;
+		}
+	} else {
+		check_for_non_overlay_node = true;
 		ret = of_changeset_update_property(&ovcs->cset, target->np,
 						   new_prop);
+	}
+
+	if (check_for_non_overlay_node &&
+	    !of_node_check_flag(target->np, OF_OVERLAY))
+		pr_err("WARNING: memory leak will occur if overlay removed, property: %pOF/%s\n",
+		       target->np, new_prop->name);
 
 	if (ret) {
 		kfree(new_prop->name);
diff --git a/include/linux/of.h b/include/linux/of.h
index 72c593455019..1bb14a1f7227 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -947,6 +947,12 @@ static inline int of_cpu_node_to_id(struct device_node *np)
 #define of_node_cmp(s1, s2)		strcasecmp((s1), (s2))
 #endif
 
+static inline int of_prop_val_eq(struct property *p1, struct property *p2)
+{
+	return p1->length == p2->length &&
+	       !memcmp(p1->value, p2->value, (size_t)p1->length);
+}
+
 #if defined(CONFIG_OF) && defined(CONFIG_NUMA)
 extern int of_node_to_nid(struct device_node *np);
 #else
-- 
Frank Rowand <frank.rowand@sony.com>

