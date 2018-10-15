Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C499C7112B
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 00:26:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56CAD20876
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 00:26:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rOFupecs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56CAD20876
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726762AbeJOII6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 04:08:58 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:42022 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726541AbeJOII5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 04:08:57 -0400
Received: by mail-pf1-f193.google.com with SMTP id f26-v6so8753754pfn.9;
        Sun, 14 Oct 2018 17:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zTyDK37nEPqC274OyD1pd7pErEfzjwmbQUNIOEBPW0Q=;
        b=rOFupecs8uTq1HCS83YABmAFUtfc2S7NKQjJAy1w3qd2U3tbwJCQQuPzA1AM/ru5Pf
         dZ3XYWUtScm5BIO6TIBqeAGHwhrbc9cwDbzT6hh/TctWuSxyFmU2GEZfdZBQNehS/B2z
         KOXq/VR3rALX21JhtNrYFeJlLd2vK+eamqbI0kRq3i+jKrPt1qOGoUJiA7Q7s/2rWT5i
         umo5ILA41q6XH9WwA8jNuZA8rgERTwaX5h/MwVff9Pq/42iIlcUi9mump6U81kefyJXX
         esqISCJ62+RZc/TLyYGH7yBSaeUOko8XzsbiDOuwYwGv4WwZ4MOsAUrYF5IykejRVfof
         v2Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zTyDK37nEPqC274OyD1pd7pErEfzjwmbQUNIOEBPW0Q=;
        b=NEZJLloYo+eGiA7wQ3L9fBhiqTys41lyKvt4HrrIhNzoG7mvpEhZPzh1X8KgnXunAk
         TLtBU0mmUU6MCajHE3mGEXOzjEe+aVvxxRKNMDiHjvl1aaKSMHPFIJiSbDkDKNliuuG1
         0wntpy0NmfD1I8x973mLEWThrK89UkZN9DvY1UKaaR+wCzAK7mX6SFwHepQSgt7tG/Oc
         +TJH2i1+sV4c/ug/I64zxPBm4d8nUSpUPBBCNQtu0YzBYv+kAa8/kDAxoI84S6FBNrHH
         VvSh1HRe4yFwq//UkKpigNVdHRahMkzzdFjRuLJbz/+FQnpUE5/JDfpEXP/F0/sip2pl
         BVYQ==
X-Gm-Message-State: ABuFfogkDZCKST68Iess5wUAyGC3cVN70DAdceNhZXHOXsfQ4wQXPUZg
        05SZMpmiQ7xTyicvhig8PXI=
X-Google-Smtp-Source: ACcGV60sDBBrCEtzm46WG8j5isz5tHoq5Ljd76Na6Y7S/wv3OKzkIdf0H/6fnCDMq/ihxtGtIHsSCg==
X-Received: by 2002:a63:4860:: with SMTP id x32-v6mr13865741pgk.375.1539563168776;
        Sun, 14 Oct 2018 17:26:08 -0700 (PDT)
Received: from localhost.localdomain (c-24-6-192-50.hsd1.ca.comcast.net. [24.6.192.50])
        by smtp.gmail.com with ESMTPSA id j14-v6sm11387110pgh.52.2018.10.14.17.26.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 14 Oct 2018 17:26:08 -0700 (PDT)
From:   frowand.list@gmail.com
To:     Rob Herring <robh+dt@kernel.org>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Alan Tull <atull@kernel.org>, Moritz Fischer <mdf@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        devicetree@vger.kernel.org, linux-fpga@vger.kernel.org
Subject: [PATCH v3 07/18] of: dynamic: change type of of_{at,de}tach_node() to void
Date:   Sun, 14 Oct 2018 17:24:19 -0700
Message-Id: <1539563070-12969-8-git-send-email-frowand.list@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1539563070-12969-1-git-send-email-frowand.list@gmail.com>
References: <1539563070-12969-1-git-send-email-frowand.list@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frank Rowand <frank.rowand@sony.com>

of_attach_node() and of_detach_node() always return zero, so
their return value is meaningless.  Change their type to void
and fix all callers to ignore return value.

Signed-off-by: Frank Rowand <frank.rowand@sony.com>
---
 arch/powerpc/platforms/pseries/dlpar.c    | 13 ++-----------
 arch/powerpc/platforms/pseries/reconfig.c |  6 +-----
 drivers/of/dynamic.c                      |  9 ++-------
 include/linux/of.h                        |  4 ++--
 4 files changed, 7 insertions(+), 25 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/dlpar.c b/arch/powerpc/platforms/pseries/dlpar.c
index e3010b14aea5..0027eea94a8b 100644
--- a/arch/powerpc/platforms/pseries/dlpar.c
+++ b/arch/powerpc/platforms/pseries/dlpar.c
@@ -244,15 +244,9 @@ struct device_node *dlpar_configure_connector(__be32 drc_index,
 
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
@@ -260,7 +254,6 @@ int dlpar_attach_node(struct device_node *dn, struct device_node *parent)
 int dlpar_detach_node(struct device_node *dn)
 {
 	struct device_node *child;
-	int rc;
 
 	child = of_get_next_child(dn, NULL);
 	while (child) {
@@ -268,9 +261,7 @@ int dlpar_detach_node(struct device_node *dn)
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
index 275c0d7e2268..5f7c99b9de0d 100644
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
index aa1dafaec6ae..72c593455019 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -406,8 +406,8 @@ extern int of_phandle_iterator_args(struct of_phandle_iterator *it,
 #define OF_RECONFIG_REMOVE_PROPERTY	0x0004
 #define OF_RECONFIG_UPDATE_PROPERTY	0x0005
 
-extern int of_attach_node(struct device_node *);
-extern int of_detach_node(struct device_node *);
+extern void of_attach_node(struct device_node *np);
+extern void of_detach_node(struct device_node *np);
 
 #define of_match_ptr(_ptr)	(_ptr)
 
-- 
Frank Rowand <frank.rowand@sony.com>

