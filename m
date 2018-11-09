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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81DDCC04EB9
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 06:07:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A40E20892
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 06:07:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YBoYAGyk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A40E20892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728050AbeKIPqz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 10:46:55 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:37078 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728008AbeKIPqy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 10:46:54 -0500
Received: by mail-pl1-f193.google.com with SMTP id p6-v6so454439pll.4;
        Thu, 08 Nov 2018 22:07:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=cpf2dIT5Msmqzai+NGfqmtLpgWTzNgysLoTwS0LtWIM=;
        b=YBoYAGykF/EmE4puBETce1UG3DOG4xKYF1QYyo52dg547QRPTrMreBFjDi7MjaqOg3
         t3UxyjI6dDCHdwwRlsXwatTy2ewK7xIRP8nwFIY5GXv5HXhpGIhvIqcH5XDBPFIiazLe
         p/UZh8YQu9k7U1h1bwUJeuXkYFgyIq7E8mPqh1kYxoS5Bg3zvKIcgksINoYm1d+msd+w
         RSZOFmIEAGyD5LcPzinkaW3P/VPHyCFdOR+9pX4NPLTzxaBJUayEGVdetMD1ypG4STDb
         KpfMAV5cVMLBGMdzggCpYMnC4qIbhD1LxddvC9/4QDbs5KsYsyrKX/BNWZQ+QUEDJLVl
         2UQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=cpf2dIT5Msmqzai+NGfqmtLpgWTzNgysLoTwS0LtWIM=;
        b=Y1Q8UQ3nVPka4c66N4vrhTDl+4qot4ftVEl66KYqMqW5zBmJkPXwQlTeV1Ez1Ry3b/
         Emat6Ipdb32SWgtyqU4/I07hseRWoRtHlRx5PTYu7Up9EbY4WgXBeczVunrxV1UphAuQ
         Ubtm+SF4wEF/8Rg5vIKUgaZq0oLLghTrkNzKSeWWLJMI8O9ZBpdsFu0Dcm7bZ358NcaY
         TKIm4P5PslJO6BPqDqs7ixOjRq88XuiNwgLnTnXkx0LLFW/CuwAIeHGTt05mMdgWlphk
         FiXvwGVbaE4UwVa4elxYJmsB7YTq0E27eT9W0iMObCpw8lpEs2fUQtnVTtwHzZrhrYMg
         eYlw==
X-Gm-Message-State: AGRZ1gKHnj7apAL7Ailfrk0bLCc4pMHwS4n9cE22MV+cPehVd5DdMMZG
        YwRqi98UUJnSBJl3+SbQGaQ=
X-Google-Smtp-Source: AJdET5dsZjILh/W+uHaT2jQRME1Qbv9jzSpEJ4qvZP0Y+lOOfpnyPwd/1iP4VXcGd18TllX2yFrE3A==
X-Received: by 2002:a17:902:9043:: with SMTP id w3-v6mr7398287plz.32.1541743674279;
        Thu, 08 Nov 2018 22:07:54 -0800 (PST)
Received: from localhost.localdomain (c-24-6-192-50.hsd1.ca.comcast.net. [24.6.192.50])
        by smtp.gmail.com with ESMTPSA id c70-v6sm6620722pfg.97.2018.11.08.22.07.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 08 Nov 2018 22:07:53 -0800 (PST)
From:   frowand.list@gmail.com
To:     Rob Herring <robh+dt@kernel.org>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Alan Tull <atull@kernel.org>, Moritz Fischer <mdf@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        devicetree@vger.kernel.org, linux-fpga@vger.kernel.org
Subject: [PATCH v7 08/17] of: overlay: validate overlay properties #address-cells and #size-cells
Date:   Thu,  8 Nov 2018 22:05:56 -0800
Message-Id: <1541743565-23163-9-git-send-email-frowand.list@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1541743565-23163-1-git-send-email-frowand.list@gmail.com>
References: <1541743565-23163-1-git-send-email-frowand.list@gmail.com>
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

Tested-by: Alan Tull <atull@kernel.org>
Signed-off-by: Frank Rowand <frank.rowand@sony.com>
---
 drivers/of/overlay.c | 32 +++++++++++++++++++++++++++++---
 include/linux/of.h   |  6 ++++++
 2 files changed, 35 insertions(+), 3 deletions(-)

diff --git a/drivers/of/overlay.c b/drivers/of/overlay.c
index 15be3da34fef..72bf00adb9c8 100644
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
index 664cd5573ae2..18ac8921e90c 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -990,6 +990,12 @@ static inline int of_map_rid(struct device_node *np, u32 rid,
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

