Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A96E3C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 06:20:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79CF72173C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 06:20:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551162037;
	bh=NJGIYZWvPFO+0UAaCDXj5clVtXeY/9xPQccL7k8fx4o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To:List-ID:
	 From;
	b=B/x2wJHcdNEfiurs94qJDKuve9S22ZvozHMQvgSerdypjr8zv2d9s9ssB6M80N53g
	 dcTYbjwfONvwOcsigpY0pC0ZiMRLhHBOKtqRnd2JILCHNli5ZRZyHmUp/iFDikFaU/
	 qzGa6m82hQUBUEeDLoYCxA2RB51wG6O4MDAz6hiY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726684AbfBZGUf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 01:20:35 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:39230 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726575AbfBZGUc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 01:20:32 -0500
Received: by mail-it1-f196.google.com with SMTP id l15so2427615iti.4;
        Mon, 25 Feb 2019 22:20:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :reply-to:organization;
        bh=NSYXONgc0YFs4Y2t1zMwI+tANX39sYybTKNULj9IgA8=;
        b=u6f7IgN0+uoWseKPwG0S94lG6EwLmG2qil5bgbNx4k0WtnmsYJnTkvF0jfvDbBqHcY
         RKR671yFUn6DCzjSzjuJMpqRM772IuAL1buAsZPu916Qayfuhsc+27BKgKL0LWg0RlNu
         z7hi1yXY0Md1L3TvsPqoICCAg8mS0GEDUi/X3+Mb3LSgfxRct9nAEDMrSivJtRSWWbeM
         4W0P8mHsN/+K1axpk1GnE6jS22a7MTAbRT0uAMAiooVPchygkWlOj2ds3EIs3EAfJoDo
         CYNueT5p35CM3QjMJVqiqanm8zovLM71Mopv2Uk8Odv59SquDlA/arokhSh0TlBnmMTw
         Cx5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:reply-to:organization;
        bh=NSYXONgc0YFs4Y2t1zMwI+tANX39sYybTKNULj9IgA8=;
        b=JXqY4uS0d24VE7b4P1XLlkUCAXA+Dn095Px7RBdpmvL89lKk+JcP3F+pQybzILONph
         +AJ8NsdQc+0pkjEku+8bRuGodwCY40hMCzrc2rYi81bjF8h18iE9t4bXCcvnlLB4U6s9
         VxWVs5kD8xexH3o+8SYWYOTduxA1pFbrxDH0KFiF84tnKGnnCPPd5AVlqZtQYdup1zIF
         B2fFE2lHDqPqcDlzDR1pUYToH5xJIvt+W7ccF3wWXPsVakh6uh5q7GDl9jmA4xJW5GJg
         Gz/rP5RxbxZUB39V9k0VqQ0henTdKRNPxBkZNZOODVc1ujrEdVBw1FiNexUMwy2G79b7
         RLgA==
X-Gm-Message-State: AHQUAuaUhnuoHXTuY8jBaF9lRLKj7g23fO9WELpBok0V3/EMRSEKoJWm
        QGFB7Wg7kSubJMmFh3eeT74=
X-Google-Smtp-Source: APXvYqz8VkZk0H6sLgkY0Reo3FbO+iW8labQI1rr8PbRYiDqTSMMC4XJI6coYDb+FMI40LVsQ1033A==
X-Received: by 2002:a24:7a85:: with SMTP id a127mr1612194itc.46.1551162031239;
        Mon, 25 Feb 2019 22:20:31 -0800 (PST)
Received: from kbl.lan (h66-222-56-144.cntcnh.dsl.dynamic.tds.net. [66.222.56.144])
        by smtp.gmail.com with ESMTPSA id w8sm6431431ita.21.2019.02.25.22.20.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Feb 2019 22:20:30 -0800 (PST)
From:   Len Brown <lenb@kernel.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>,
        Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org
Subject: [PATCH 07/14] powercap/intel_rapl: Simplify rapl_find_package()
Date:   Tue, 26 Feb 2019 01:20:05 -0500
Message-Id: <4dd94a34999d6db4ced7a0759c02f7cd93729dc4.1551160674.git.len.brown@intel.com>
X-Mailer: git-send-email 2.18.0-rc0
In-Reply-To: <e2810a5317d3a109a98204e883fd1461f77b9339.1551160674.git.len.brown@intel.com>
References: <e2810a5317d3a109a98204e883fd1461f77b9339.1551160674.git.len.brown@intel.com>
Reply-To: Len Brown <lenb@kernel.org>
Organization: Intel Open Source Technology Center
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhang Rui <rui.zhang@intel.com>

Syntax only, no functional or semantic change.

Simplify how the code to discover a package is called.
Rename find_package_by_id() to rapl_find_package()

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: linux-pm@vger.kernel.org
---
 drivers/powercap/intel_rapl.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/powercap/intel_rapl.c b/drivers/powercap/intel_rapl.c
index 6cdb2c14eee4..6057d9695fed 100644
--- a/drivers/powercap/intel_rapl.c
+++ b/drivers/powercap/intel_rapl.c
@@ -264,8 +264,9 @@ static struct powercap_control_type *control_type; /* PowerCap Controller */
 static struct rapl_domain *platform_rapl_domain; /* Platform (PSys) domain */
 
 /* caller to ensure CPU hotplug lock is held */
-static struct rapl_package *find_package_by_id(int id)
+static struct rapl_package *rapl_find_package(int cpu)
 {
+	int id = topology_physical_package_id(cpu);
 	struct rapl_package *rp;
 
 	list_for_each_entry(rp, &rapl_packages, plist) {
@@ -1298,7 +1299,7 @@ static int __init rapl_register_psys(void)
 	rd->rpl[0].name = pl1_name;
 	rd->rpl[1].prim_id = PL2_ENABLE;
 	rd->rpl[1].name = pl2_name;
-	rd->rp = find_package_by_id(0);
+	rd->rp = rapl_find_package(0);
 
 	power_zone = powercap_register_zone(&rd->power_zone, control_type,
 					    "psys", NULL,
@@ -1454,8 +1455,9 @@ static void rapl_remove_package(struct rapl_package *rp)
 }
 
 /* called from CPU hotplug notifier, hotplug lock held */
-static struct rapl_package *rapl_add_package(int cpu, int pkgid)
+static struct rapl_package *rapl_add_package(int cpu)
 {
+	int id = topology_physical_package_id(cpu);
 	struct rapl_package *rp;
 	int ret;
 
@@ -1464,7 +1466,7 @@ static struct rapl_package *rapl_add_package(int cpu, int pkgid)
 		return ERR_PTR(-ENOMEM);
 
 	/* add the new package to the list */
-	rp->id = pkgid;
+	rp->id = id;
 	rp->lead_cpu = cpu;
 
 	/* check if the package contains valid domains */
@@ -1495,12 +1497,11 @@ static struct rapl_package *rapl_add_package(int cpu, int pkgid)
  */
 static int rapl_cpu_online(unsigned int cpu)
 {
-	int pkgid = topology_physical_package_id(cpu);
 	struct rapl_package *rp;
 
-	rp = find_package_by_id(pkgid);
+	rp = rapl_find_package(cpu);
 	if (!rp) {
-		rp = rapl_add_package(cpu, pkgid);
+		rp = rapl_add_package(cpu);
 		if (IS_ERR(rp))
 			return PTR_ERR(rp);
 	}
@@ -1510,11 +1511,10 @@ static int rapl_cpu_online(unsigned int cpu)
 
 static int rapl_cpu_down_prep(unsigned int cpu)
 {
-	int pkgid = topology_physical_package_id(cpu);
 	struct rapl_package *rp;
 	int lead_cpu;
 
-	rp = find_package_by_id(pkgid);
+	rp = rapl_find_package(cpu);
 	if (!rp)
 		return 0;
 
-- 
2.18.0-rc0

