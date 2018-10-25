Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41251C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 16:40:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF8922083E
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 16:40:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jggDIX9U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF8922083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727877AbeJZBNi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 21:13:38 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:46665 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727363AbeJZBNi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 21:13:38 -0400
Received: by mail-pf1-f193.google.com with SMTP id r64-v6so4449998pfb.13;
        Thu, 25 Oct 2018 09:40:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=A7MWvFm33AV6bMca1yv+aRiIsR0DVJ9uj6IokFumh2A=;
        b=jggDIX9UOs9dh6b9w26h4LZXHVQpLgtGcOrnReyoAkeVbL+IWusW3mq/Zj3+6L9CLD
         Z2pcSMpD/vix+T1jp9BWqWqUFL0CMqeRiduN0bT6SrUxCx9McqCXrEDsf9LDpZWRKm1q
         xbTj2f3hOF23fHD3LX6VyoNJMkKIy4seLWL0ATbhyEeB7WCelDXBPU77OiveE4tSOzy0
         7jlptmHrrkgEsuLK9Nwa1Zvbna+oiUgZJoZaV1TWidBSuBorwCVigCpKYhA9jV1jeCMw
         xiF00tIjpSbmAo/XIQ2HzMuG3YjJkQOBlAreNB1MePdj9oZrjUTS39TTFxSkTAWJkvIP
         qtAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=A7MWvFm33AV6bMca1yv+aRiIsR0DVJ9uj6IokFumh2A=;
        b=T4Gx0F1CMpUXFqRwHwqWpp5cgUaeb+Xe7fdjGxDWAEeNo89clhkA2n1DS7dIP3WZVc
         MPmNKjk8PDKKrRQebPkk7JHM/Adpu438kC7vddoPWBiZaxMIq3AhGKGcQ06IM49VI8TX
         h8o88caKJ22N0OZBY4/L+/gMQ85zq67Eex6T1srJa+gmd9Rsbh84q2J1+GqQ9BHu27LJ
         fPvHFS8VqzJ+Fc8RtKSTJJ4ItdnBBcMAVS/gelQXVU5ux0U8OpWUCTUvMGq5Q8gwj4/y
         H6DllQtA0k6H1jL6nBX4o17/cj518Ihpf4C52QEM7Tom1ucxubNfeOGI48XyX7yw1+T2
         /GQw==
X-Gm-Message-State: AGRZ1gLe+h1pLZpmQlzVb7kfjdYiWv9SY2V9nHNOfC9B4KJvyYVId3s6
        BYYooC+dd+B8mu5pUdf90GU=
X-Google-Smtp-Source: AJdET5de62UHEtFP+pQfvbYDWjOC45P6Jj9rK//sNRj7dJoZWVsAB5ai1xPNF12lATcgnaFsvEVJjA==
X-Received: by 2002:a63:6bc1:: with SMTP id g184mr2186161pgc.25.1540485604622;
        Thu, 25 Oct 2018 09:40:04 -0700 (PDT)
Received: from localhost.localdomain ([49.171.224.30])
        by smtp.gmail.com with ESMTPSA id f1-v6sm13537100pfg.71.2018.10.25.09.40.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 25 Oct 2018 09:40:03 -0700 (PDT)
From:   Jaewon Kim <jaewon02.kim@gmail.com>
X-Google-Original-From: Jaewon Kim <jaewon02.kim@samsung.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Jaewon Kim <jaewon02.kim@samsung.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] of/platform: Support dynamic device tree on AMBA bus
Date:   Fri, 26 Oct 2018 01:39:57 +0900
Message-Id: <1540485597-12240-1-git-send-email-jaewon02.kim@samsung.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch supports dynamic device-tree for AMBA device.
The AMBA device must be registered on the AMBA bus, not the platform bus.

Signed-off-by: Jaewon Kim <jaewon02.kim@samsung.com>
---
 drivers/of/platform.c | 93 ++++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 73 insertions(+), 20 deletions(-)

diff --git a/drivers/of/platform.c b/drivers/of/platform.c
index 04ad312..b9ac105 100644
--- a/drivers/of/platform.c
+++ b/drivers/of/platform.c
@@ -286,6 +286,22 @@ static struct amba_device *of_amba_device_create(struct device_node *node,
 	of_node_clear_flag(node, OF_POPULATED);
 	return NULL;
 }
+
+/**
+ * of_find_amba_device_by_node - Find the amba_device associated with a node
+ * @np: Pointer to device tree node
+ *
+ * Returns amba_device pointer, or NULL if not found
+ */
+struct amba_device *of_find_amba_device_by_node(struct device_node *np)
+{
+	struct device *dev;
+
+	dev = bus_find_device(&amba_bustype, NULL, np, of_dev_node_match);
+	return dev ? to_amba_device(dev) : NULL;
+}
+EXPORT_SYMBOL(of_find_amba_device_by_node);
+
 #else /* CONFIG_ARM_AMBA */
 static struct amba_device *of_amba_device_create(struct device_node *node,
 						 const char *bus_id,
@@ -294,6 +310,12 @@ static struct amba_device *of_amba_device_create(struct device_node *node,
 {
 	return NULL;
 }
+
+struct amba_device *of_find_amba_device_by_node(struct device_node *np)
+{
+	return NULL;
+}
+EXPORT_SYMBOL(of_find_amba_device_by_node);
 #endif /* CONFIG_ARM_AMBA */
 
 /**
@@ -665,6 +687,7 @@ static int of_platform_notify(struct notifier_block *nb,
 {
 	struct of_reconfig_data *rd = arg;
 	struct platform_device *pdev_parent, *pdev;
+	struct amba_device *adev_p, *adev;
 	bool children_left;
 
 	switch (of_reconfig_get_state_change(action, rd)) {
@@ -677,17 +700,34 @@ static int of_platform_notify(struct notifier_block *nb,
 		if (of_node_check_flag(rd->dn, OF_POPULATED))
 			return NOTIFY_OK;
 
-		/* pdev_parent may be NULL when no bus platform device */
-		pdev_parent = of_find_device_by_node(rd->dn->parent);
-		pdev = of_platform_device_create(rd->dn, NULL,
-				pdev_parent ? &pdev_parent->dev : NULL);
-		of_dev_put(pdev_parent);
-
-		if (pdev == NULL) {
-			pr_err("%s: failed to create for '%pOF'\n",
-					__func__, rd->dn);
-			/* of_platform_device_create tosses the error code */
-			return notifier_from_errno(-EINVAL);
+		if (of_device_is_compatible(rd->dn, "arm,primecell")) {
+			/* adev_p may be NULL when no bus amba device */
+			adev_p = of_find_amba_device_by_node(rd->dn->parent);
+			adev = of_amba_device_create(rd->dn, NULL, NULL,
+					adev_p ? &adev_p->dev : NULL);
+
+			if (adev_p)
+				put_device(&adev_p->dev);
+
+			if (adev == NULL) {
+				pr_err("%s: failed to create for '%s'\n",
+						__func__, rd->dn->full_name);
+				/* of_amba_device_create tosses the error */
+				return notifier_from_errno(-EINVAL);
+			}
+		} else {
+			/* pdev_parent may be NULL when no bus platform device*/
+			pdev_parent = of_find_device_by_node(rd->dn->parent);
+			pdev = of_platform_device_create(rd->dn, NULL,
+					pdev_parent ? &pdev_parent->dev : NULL);
+			of_dev_put(pdev_parent);
+
+			if (pdev == NULL) {
+				pr_err("%s: failed to create for '%pOF'\n",
+						__func__, rd->dn);
+				/* of_platform_device_create tosses the error */
+				return notifier_from_errno(-EINVAL);
+			}
 		}
 		break;
 
@@ -698,15 +738,28 @@ static int of_platform_notify(struct notifier_block *nb,
 			return NOTIFY_OK;
 
 		/* find our device by node */
-		pdev = of_find_device_by_node(rd->dn);
-		if (pdev == NULL)
-			return NOTIFY_OK;	/* no? not meant for us */
-
-		/* unregister takes one ref away */
-		of_platform_device_destroy(&pdev->dev, &children_left);
-
-		/* and put the reference of the find */
-		of_dev_put(pdev);
+		if (of_device_is_compatible(rd->dn, "arm,primecell")) {
+			adev = of_find_amba_device_by_node(rd->dn);
+			if (adev == NULL)
+				return NOTIFY_OK; /* no? not meant for us */
+
+			/* unregister takes one ref away */
+			of_platform_device_destroy(&adev->dev, &children_left);
+
+			/* and put the reference of the find */
+			if (adev)
+				put_device(&adev->dev);
+		} else {
+			pdev = of_find_device_by_node(rd->dn);
+			if (pdev == NULL)
+				return NOTIFY_OK; /* no? not meant for us */
+
+			/* unregister takes one ref away */
+			of_platform_device_destroy(&pdev->dev, &children_left);
+
+			/* and put the reference of the find */
+			of_dev_put(pdev);
+		}
 		break;
 	}
 
-- 
2.7.4

