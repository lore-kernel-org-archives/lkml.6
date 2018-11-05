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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3691FECDE47
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 15:27:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F32CA2085B
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 15:27:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kJtlW7/X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F32CA2085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730314AbeKFArP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 19:47:15 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:45780 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730278AbeKFArO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 19:47:14 -0500
Received: by mail-pg1-f193.google.com with SMTP id y4so3935837pgc.12;
        Mon, 05 Nov 2018 07:27:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=F6KmbgY3n3rbRZSqTuDCS/DaBOfiNxuxWCysnxw9sbs=;
        b=kJtlW7/X9mXdNerhTjKq4D9pTQsEL0IcsfFeoFxwqdDPAYsLNO4JFbHqZUqE2WcyLw
         wpjU1V621lLCDG8jVzey+noPrl7INeawI0wsZIDZi4KKSfDmCokgYI9rFTyHRJNingdD
         ZqKKo464OZrVBUq7eduW0ixyXiU3kEhU1Hws6Je0eIfgscqFZz4lBX95b6JJ8Sh6k7k2
         OS3Tfvv2uwFB3R8TaWKH9xVaFC1qDTBbgw4wWTyVw+DoQ14kagHmiWDzcEIZchs0jQC6
         kD1yJg92fty5WLpt8QzJU0+tzugKqyet5NpDC9tD1t0YDqZ5gNJIj0M3EzF/el8QAJ2Q
         xAQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=F6KmbgY3n3rbRZSqTuDCS/DaBOfiNxuxWCysnxw9sbs=;
        b=Bu5TYUBUEOYANpgFMbhY+290nGaSJEIcqXbUDU5ANEUL46AKwKUBQVqlrFFUy3eMjr
         /XPY7vgef1o1lj7BWw3iiTPoVZ5gj5J/xd5AAzu9Ft6q2zGkvr8LH1Xrbf+j2WCdmihM
         gS0AQ7tGrerDp/smF6Q6M4XrBJjfXk/Zl0A25vvwUW9CDmaVcxnpGgCwcts++OtE7rgq
         Y2CDLUm07PsUHP+hNI8ZtlxBl8pFqJ1i6rTy0z1mBUHQCH8hZCtm8OvbK6zEbMzRAtFS
         lZJbbKSlpfWpwCiKbZSmF2YTuXTgakEyo1ueeEfXyxH0wZ5NMzn5F77cNZl50/YJBfro
         UzmA==
X-Gm-Message-State: AGRZ1gJQ5v4RdzBzAtfMWlYNbz6aLMD2uuayrvJl92/hphx6tn5noT6V
        2zfoaHkr0DbezwwuNGkm2UI=
X-Google-Smtp-Source: AJdET5dEpgdI6oSLhOs3BDZ3K6Q0xAP5o8VI34oeKoCKxOk0ElWLP8jwkfX1XZTPcFBQYJoX27P8NA==
X-Received: by 2002:a62:3707:: with SMTP id e7-v6mr4380329pfa.70.1541431621632;
        Mon, 05 Nov 2018 07:27:01 -0800 (PST)
Received: from localhost.localdomain (c-24-6-192-50.hsd1.ca.comcast.net. [24.6.192.50])
        by smtp.gmail.com with ESMTPSA id u76-v6sm37260578pfa.176.2018.11.05.07.27.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 05 Nov 2018 07:27:01 -0800 (PST)
From:   frowand.list@gmail.com
To:     Rob Herring <robh+dt@kernel.org>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Alan Tull <atull@kernel.org>, Moritz Fischer <mdf@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        devicetree@vger.kernel.org, linux-fpga@vger.kernel.org
Subject: [PATCH v6 07/18] of: dynamic: change type of of_{at,de}tach_node() to void
Date:   Mon,  5 Nov 2018 07:25:04 -0800
Message-Id: <1541431515-25197-8-git-send-email-frowand.list@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1541431515-25197-1-git-send-email-frowand.list@gmail.com>
References: <1541431515-25197-1-git-send-email-frowand.list@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frank Rowand <frank.rowand@sony.com>

of_attach_node() and of_detach_node() always return zero, so
their return value is meaningless.  Change their type to void
and fix all callers to ignore return value.

Tested-by: Alan Tull <atull@kernel.org>
Signed-off-by: Frank Rowand <frank.rowand@sony.com>
---
 arch/powerpc/platforms/pseries/dlpar.c    | 13 ++-----------
 arch/powerpc/platforms/pseries/reconfig.c |  6 +-----
 drivers/of/dynamic.c                      |  9 ++-------
 include/linux/of.h                        |  4 ++--
 4 files changed, 7 insertions(+), 25 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/dlpar.c b/arch/powerpc/platforms/pseries/dlpar.c
index 17958043e7f7..7c5a6f8fe9c1 100644
--- a/arch/powerpc/platforms/pseries/dlpar.c
+++ b/arch/powerpc/platforms/pseries/dlpar.c
@@ -242,15 +242,9 @@ struct device_node *dlpar_configure_connector(__be32 drc_index,
 
 int dlpar_attach_node(struct device_node *dn, struct device_node *parent)
 {
-	int rc;
-
 	dn->parent = parent;
 
-	rc = of_attach_node(dn);
-	if (rc) {
-		printk(KERN_ERR "Failed to add device node %pOF\n", dn);
-		return rc;
-	}
+	of_attach_node(dn);
 
 	return 0;
 }
@@ -258,7 +252,6 @@ int dlpar_attach_node(struct device_node *dn, struct device_node *parent)
 int dlpar_detach_node(struct device_node *dn)
 {
 	struct device_node *child;
-	int rc;
 
 	child = of_get_next_child(dn, NULL);
 	while (child) {
@@ -266,9 +259,7 @@ int dlpar_detach_node(struct device_node *dn)
 		child = of_get_next_child(dn, child);
 	}
 
-	rc = of_detach_node(dn);
-	if (rc)
-		return rc;
+	of_detach_node(dn);
 
 	of_node_put(dn);
 
diff --git a/arch/powerpc/platforms/pseries/reconfig.c b/arch/powerpc/platforms/pseries/reconfig.c
index 0e0208117e77..0b72098da454 100644
--- a/arch/powerpc/platforms/pseries/reconfig.c
+++ b/arch/powerpc/platforms/pseries/reconfig.c
@@ -47,11 +47,7 @@ static int pSeries_reconfig_add_node(const char *path, struct property *proplist
 		goto out_err;
 	}
 
-	err = of_attach_node(np);
-	if (err) {
-		printk(KERN_ERR "Failed to add device node %s\n", path);
-		goto out_err;
-	}
+	of_attach_node(np);
 
 	of_node_put(np->parent);
 
diff --git a/drivers/of/dynamic.c b/drivers/of/dynamic.c
index 146681540487..beea792debb6 100644
--- a/drivers/of/dynamic.c
+++ b/drivers/of/dynamic.c
@@ -224,7 +224,7 @@ static void __of_attach_node(struct device_node *np)
 /**
  * of_attach_node() - Plug a device node into the tree and global list.
  */
-int of_attach_node(struct device_node *np)
+void of_attach_node(struct device_node *np)
 {
 	struct of_reconfig_data rd;
 	unsigned long flags;
@@ -241,8 +241,6 @@ int of_attach_node(struct device_node *np)
 	mutex_unlock(&of_mutex);
 
 	of_reconfig_notify(OF_RECONFIG_ATTACH_NODE, &rd);
-
-	return 0;
 }
 
 void __of_detach_node(struct device_node *np)
@@ -273,11 +271,10 @@ void __of_detach_node(struct device_node *np)
 /**
  * of_detach_node() - "Unplug" a node from the device tree.
  */
-int of_detach_node(struct device_node *np)
+void of_detach_node(struct device_node *np)
 {
 	struct of_reconfig_data rd;
 	unsigned long flags;
-	int rc = 0;
 
 	memset(&rd, 0, sizeof(rd));
 	rd.dn = np;
@@ -291,8 +288,6 @@ int of_detach_node(struct device_node *np)
 	mutex_unlock(&of_mutex);
 
 	of_reconfig_notify(OF_RECONFIG_DETACH_NODE, &rd);
-
-	return rc;
 }
 EXPORT_SYMBOL_GPL(of_detach_node);
 
diff --git a/include/linux/of.h b/include/linux/of.h
index 664cd5573ae2..5dd9ff480397 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -410,8 +410,8 @@ extern int of_alias_get_alias_list(const struct of_device_id *matches,
 #define OF_RECONFIG_REMOVE_PROPERTY	0x0004
 #define OF_RECONFIG_UPDATE_PROPERTY	0x0005
 
-extern int of_attach_node(struct device_node *);
-extern int of_detach_node(struct device_node *);
+extern void of_attach_node(struct device_node *np);
+extern void of_detach_node(struct device_node *np);
 
 #define of_match_ptr(_ptr)	(_ptr)
 
-- 
Frank Rowand <frank.rowand@sony.com>

