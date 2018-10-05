Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B0ECC65BA7
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 04:14:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CED8C2084D
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 04:14:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pmV+gvcJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CED8C2084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727798AbeJELLN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 07:11:13 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33166 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727599AbeJELLM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 07:11:12 -0400
Received: by mail-pg1-f196.google.com with SMTP id y18-v6so4148925pge.0;
        Thu, 04 Oct 2018 21:14:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=13Uv0Hfs4/ntC09BePszlnDUCQa1RtKNfNFOAls9wrk=;
        b=pmV+gvcJHSf4YdFmb92Ae64KwhXyt69qdjDo4jjS7f/jRx2+TuHqAXlF2P4BKbgmhV
         4zvkKkKyd9oG0oPLdwgdPs+osUOJ4YmQXGl2gLumNo6dJz8DXx1s6xmqs2dxgbNZcmUJ
         seiNeQF82aP3xOMjQd4XZ7x+V81qx11mYo3B6JMIjam9bV5xvlEOWEM1KKATKOKNoetr
         vL7jMimXHO3BRxYDU1FBrkTGDMfuNjzO4O2wcPUHTAEdYUgus552cWctk+9dDbt5phzf
         121j2gAJpJBLwTAngBe8qKTYR1Dd9XE8cPXSpZaXeZoZqM5gfNOMjcx0lLAWVWdt/5gv
         JvxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=13Uv0Hfs4/ntC09BePszlnDUCQa1RtKNfNFOAls9wrk=;
        b=q/mqeBE1TGSMxzX+c82mF05XxPAlBDWVOmmWWDzPz0avEiDzuO8BMwADCU+kdLSfCC
         bOX9Pe1sgAwyDLEpddRV8oMQmFWSWHxBf1ojG3vuQ3vaT9SCRqDa0uDl9WcTBAOQqa8q
         zNscVRuO6fUlKbh155sICuDYhupovDCAMZJ0cKX6+F6NXxNN08eY4DE8E0KM7ZfF1RBR
         MIDonTfBjro1V4l7m5FtWberit0DmkFcrbLkmDMR4/tdomusiIvX4jcFqz4kRSyg2HDA
         qKnh/I1SGVc/QTGVNJGEtt+RmGMtAzyMDYq29NHJur7EM8ThUDJUS/5Kz2RhQHcrNhox
         kD+Q==
X-Gm-Message-State: ABuFfoiovDNVStMXNQ6Emd/X0eXXlzwvZ+X/tvswEYA/7nRnzgiI70YO
        07l9AfaVAowvK4dLF/LcDos=
X-Google-Smtp-Source: ACcGV62d20VGbvyyroQzD8oc2KRAGrFicGuw2UjeVMoMttmoKedSCFn87aoeREyJ+rBo8d27k/6ECg==
X-Received: by 2002:a63:e645:: with SMTP id p5-v6mr8145953pgj.218.1538712860977;
        Thu, 04 Oct 2018 21:14:20 -0700 (PDT)
Received: from localhost.localdomain (c-24-6-192-50.hsd1.ca.comcast.net. [24.6.192.50])
        by smtp.gmail.com with ESMTPSA id n63-v6sm277975pfn.9.2018.10.04.21.14.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 04 Oct 2018 21:14:20 -0700 (PDT)
From:   frowand.list@gmail.com
To:     Rob Herring <robh+dt@kernel.org>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Alan Tull <atull@kernel.org>, Moritz Fischer <mdf@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        devicetree@vger.kernel.org, linux-fpga@vger.kernel.org
Subject: [PATCH 07/16] of: dynamic: change type of of_{at,de}tach_node() to void
Date:   Thu,  4 Oct 2018 21:12:38 -0700
Message-Id: <1538712767-30394-8-git-send-email-frowand.list@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1538712767-30394-1-git-send-email-frowand.list@gmail.com>
References: <1538712767-30394-1-git-send-email-frowand.list@gmail.com>
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

Powerpc files not tested

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

