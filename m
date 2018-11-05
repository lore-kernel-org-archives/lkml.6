Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 655F3C46475
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 15:27:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D67B20882
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 15:27:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bg1KRKBU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D67B20882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387459AbeKFArS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 19:47:18 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:38244 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387436AbeKFArR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 19:47:17 -0500
Received: by mail-pf1-f195.google.com with SMTP id b11-v6so4592002pfi.5;
        Mon, 05 Nov 2018 07:27:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=W/ugdsqQPdctDo60XCuqFFGpFOneBe3046JiaEcS3Tk=;
        b=bg1KRKBUnkvD8bqakSO/G5op6Sl3LuKAVBDOHlEtKzcvkGqeE6ND3wk2paM27XIa5O
         OLDGJqMysuedcArSEYTTXCLc48UJoAhKaBtrRLZDvcPnyfV8B7WDMW7eAf+3997u9TCd
         DqJvSY9u15gn8JjCRv5Ve9tAsQl8Yv7lHcQ1GoESnMoF+69m3tjS2qno8RHFhbM0tdD6
         fY4cEVgEyfoRGxNCCG25lwWJA4rGYCbowJN6PL+kNQqkRDQQVsmXgGKme/3GAc1Xg2we
         rtx6rKukY0Z04JVe2mWdWuzzAubiyswqRIPc6hCIE9NYcEV+yBjF4bTschvbkSBKBqKi
         gYiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=W/ugdsqQPdctDo60XCuqFFGpFOneBe3046JiaEcS3Tk=;
        b=WQpisV1OFhNgLejSHOgbmsnVToOWJF8YsCDeZ1wv1gzAMyBkMDAF6QwkHXu1WRbl/D
         35k8ywGDSX1fN5P8RLzCvDGhfS267L7ZSGWRZ9/2eIUAMGm46CjqCgUSuPHdvnbsiNN4
         hccw7X+9zbYoH5hEu/JmnFOcglWXiZk3IiTSbz21tN7MlJRliI28WfAuFkEPa+6wOKT0
         ip43FrXt6WzZfUOUNE0pTwitWwdE5qfXNZRRNBC94OWgcuAEsexNnnLkccdZhtLbjwVW
         tz3oGCv0HtnVgNHzSpMt08TLZfPnXqxocSS2fyRsyqsUVXDM80aevn1I0cY1TvlAKK3h
         oMsw==
X-Gm-Message-State: AGRZ1gJI5pgcNN3yFSQOf97G6hG/GgdIaEsIap5a0RiHUotvIlEi+XZW
        DWqp1EjxxuAHSxfO3xOwS3MBpPl8
X-Google-Smtp-Source: AJdET5ccLkrxaZbxF0AH5thFn7Qd9uQuFK8XE4PHF17QhFvKzbiWcOT0YjLgV2MMrG1Hrqz7TAvOFQ==
X-Received: by 2002:a63:6150:: with SMTP id v77mr20138797pgb.266.1541431624229;
        Mon, 05 Nov 2018 07:27:04 -0800 (PST)
Received: from localhost.localdomain (c-24-6-192-50.hsd1.ca.comcast.net. [24.6.192.50])
        by smtp.gmail.com with ESMTPSA id u76-v6sm37260578pfa.176.2018.11.05.07.27.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 05 Nov 2018 07:27:03 -0800 (PST)
From:   frowand.list@gmail.com
To:     Rob Herring <robh+dt@kernel.org>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Alan Tull <atull@kernel.org>, Moritz Fischer <mdf@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        devicetree@vger.kernel.org, linux-fpga@vger.kernel.org
Subject: [PATCH v6 09/18] of: overlay: validate overlay properties #address-cells and #size-cells
Date:   Mon,  5 Nov 2018 07:25:06 -0800
Message-Id: <1541431515-25197-10-git-send-email-frowand.list@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1541431515-25197-1-git-send-email-frowand.list@gmail.com>
References: <1541431515-25197-1-git-send-email-frowand.list@gmail.com>
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
index 5dd9ff480397..f247a3f557e0 100644
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

