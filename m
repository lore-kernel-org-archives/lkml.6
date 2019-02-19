Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9E13C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 03:40:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7667B2183E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 03:40:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550547644;
	bh=qwcpKn1OQucrzQ2sij4i1GeJI5YkJ4UrPjVNIIQWr7Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To:List-ID:
	 From;
	b=z9XcN8AkpOY5M+ruucRBy0p0SFkIMnNUFm9vlDfICadvG1IUXOggnC6uzTuF4SwyU
	 Ia4bqE5X14G4OYitDdlgyy4SsHUe1uuKrQrcOb21LkxoZRKcsQ82NphTJVcZY+N1t6
	 CmBq4Eg9+y2tSBaY7G9ugNLYPc0LNlwmFxfamw1o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726655AbfBSDkh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 22:40:37 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:33355 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726462AbfBSDkf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 22:40:35 -0500
Received: by mail-qt1-f196.google.com with SMTP id z39so21697841qtz.0;
        Mon, 18 Feb 2019 19:40:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :reply-to:organization;
        bh=kE0vLAMF2xKGBrwq8WppmzzgNu3Piviln0s9+qxvuPk=;
        b=W9qXVeeUT6WaXdJfStwZCDA2PJbuMJZJ0PUOVGfcdo+9HOnLNYxMeMl18WEFItuh/A
         RpdMWu8jqdKgWrUkvowPvUmTb9FrqJgcjp7LjLGrlcO0RrCoiASkfo9TDrtdPL5p9pw+
         TR2Rjxw4hnMtHWAq40kmICJB6qs71z/+/aXWGqn+JaEgoJ3d+LgRmRpR4jtM8Bq3lupr
         Ato+E4iHZsVr6tIN97SiSZf3VvxPafoOBn21cV8kx0bLsMU1JQfZ4kuFb61hvaFDHczp
         96leFMBo8hfOdUjZx0tWQg10HsMHltFmHvxyN9vxoEliayeVaEGaikhREE3UnPoQ/Gxk
         PR4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:reply-to:organization;
        bh=kE0vLAMF2xKGBrwq8WppmzzgNu3Piviln0s9+qxvuPk=;
        b=qssjHiNYIu3sunm0lWtaZAhtHoLH5eP+e9rZrSno+ytf0MWwEuxl8LX6x2wy1tBEvr
         BxISUBI60Gh5P5V9zgaRkrUw/DHcKGFIGMFRdzlaC5vBvOTSYvQXZQiD2C7WPUfF543w
         /HgPHsofRa+7RUQ8EvYDYhpfpp0ITOCSLAx+K9Vz65PZGI+7ys/1aTeY5LVrklkZx0EH
         knZwgWca4C2/RyoYt6djaCzeFaFFGD3/5q1EumLONGfFx5keCc2iZf0+UUt3g7m09EOR
         WYMi3+tjiPbSauTsPrHI4KlNCQDdvqNzKRR9HNe+JPH/8jGPQd/Ebmxartzo1QmvnX9y
         GzxQ==
X-Gm-Message-State: AHQUAuaJVMyfLAPfZh1xBbUSdpIcvo2b0pE4n9B1IoyQgXEJrManRkQs
        iZKRVZwgqJL9agJPebsQJsx+lXlD
X-Google-Smtp-Source: AHgI3IanmgLOqaSt8LvZhh0RyQuJ/OwgN5+BwimdqecKNTAjQNSo41RGPmjyoIbNvzi8NPpesSXohw==
X-Received: by 2002:a0c:b527:: with SMTP id d39mr19884898qve.201.1550547633618;
        Mon, 18 Feb 2019 19:40:33 -0800 (PST)
Received: from kbl.fios-router.home (pool-96-233-42-17.bstnma.fios.verizon.net. [96.233.42.17])
        by smtp.gmail.com with ESMTPSA id u5sm7327680qtg.37.2019.02.18.19.40.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Feb 2019 19:40:33 -0800 (PST)
From:   Len Brown <lenb@kernel.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>,
        Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org
Subject: [PATCH 09/11] powercap/intel_rapl: update rapl domain name and debug messages
Date:   Mon, 18 Feb 2019 22:40:11 -0500
Message-Id: <5b1116912102ce6d0753fa1fedefc1a4e62837fe.1550545163.git.len.brown@intel.com>
X-Mailer: git-send-email 2.18.0-rc0
In-Reply-To: <635b2bf8b1151a191cd9299276b75791a818c0c2.1550545163.git.len.brown@intel.com>
References: <635b2bf8b1151a191cd9299276b75791a818c0c2.1550545163.git.len.brown@intel.com>
Reply-To: Len Brown <lenb@kernel.org>
Organization: Intel Open Source Technology Center
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhang Rui <rui.zhang@intel.com>

The RAPL domain "name" attribute contains "Package-N",
which is ambiguous on multi-die per-package systems.

Update the name to "package-X-die-Y" on those systems.

No change on systems without multi-die.

Driver debug messages are also updated.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
Cc: linux-pm@vger.kernel.org
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/powercap/intel_rapl.c | 57 ++++++++++++++++++++---------------
 1 file changed, 32 insertions(+), 25 deletions(-)

diff --git a/drivers/powercap/intel_rapl.c b/drivers/powercap/intel_rapl.c
index e004707283da..c990eee45239 100644
--- a/drivers/powercap/intel_rapl.c
+++ b/drivers/powercap/intel_rapl.c
@@ -178,12 +178,15 @@ struct rapl_domain {
 #define power_zone_to_rapl_domain(_zone) \
 	container_of(_zone, struct rapl_domain, power_zone)
 
+/* maximum rapl package domain name: package-%d-die-%d */
+#define PACKAGE_DOMAIN_NAME_LENGTH 30
 
-/* Each physical package contains multiple domains, these are the common
+
+/* Each rapl package contains multiple domains, these are the common
  * data across RAPL domains within a package.
  */
 struct rapl_package {
-	unsigned int id; /* physical package/socket id */
+	unsigned int id; /* logical die id, equals physical 1-die systems */
 	unsigned int nr_domains;
 	unsigned long domain_map; /* bit map of active domains */
 	unsigned int power_unit;
@@ -198,6 +201,7 @@ struct rapl_package {
 	int lead_cpu; /* one active cpu per package for access */
 	/* Track active cpus */
 	struct cpumask cpumask;
+	char name[PACKAGE_DOMAIN_NAME_LENGTH];
 };
 
 struct rapl_defaults {
@@ -926,8 +930,8 @@ static int rapl_check_unit_core(struct rapl_package *rp, int cpu)
 	value = (msr_val & TIME_UNIT_MASK) >> TIME_UNIT_OFFSET;
 	rp->time_unit = 1000000 / (1 << value);
 
-	pr_debug("Core CPU package %d energy=%dpJ, time=%dus, power=%duW\n",
-		rp->id, rp->energy_unit, rp->time_unit, rp->power_unit);
+	pr_debug("Core CPU %s energy=%dpJ, time=%dus, power=%duW\n",
+		rp->name, rp->energy_unit, rp->time_unit, rp->power_unit);
 
 	return 0;
 }
@@ -951,8 +955,8 @@ static int rapl_check_unit_atom(struct rapl_package *rp, int cpu)
 	value = (msr_val & TIME_UNIT_MASK) >> TIME_UNIT_OFFSET;
 	rp->time_unit = 1000000 / (1 << value);
 
-	pr_debug("Atom package %d energy=%dpJ, time=%dus, power=%duW\n",
-		rp->id, rp->energy_unit, rp->time_unit, rp->power_unit);
+	pr_debug("Atom %s energy=%dpJ, time=%dus, power=%duW\n",
+		rp->name, rp->energy_unit, rp->time_unit, rp->power_unit);
 
 	return 0;
 }
@@ -1179,7 +1183,7 @@ static void rapl_update_domain_data(struct rapl_package *rp)
 	u64 val;
 
 	for (dmn = 0; dmn < rp->nr_domains; dmn++) {
-		pr_debug("update package %d domain %s data\n", rp->id,
+		pr_debug("update %s domain %s data\n", rp->name,
 			 rp->domains[dmn].name);
 		/* exclude non-raw primitives */
 		for (prim = 0; prim < NR_RAW_PRIMITIVES; prim++) {
@@ -1204,7 +1208,6 @@ static void rapl_unregister_powercap(void)
 static int rapl_package_register_powercap(struct rapl_package *rp)
 {
 	struct rapl_domain *rd;
-	char dev_name[17]; /* max domain name = 7 + 1 + 8 for int + 1 for null*/
 	struct powercap_zone *power_zone = NULL;
 	int nr_pl, ret;
 
@@ -1215,20 +1218,16 @@ static int rapl_package_register_powercap(struct rapl_package *rp)
 	for (rd = rp->domains; rd < rp->domains + rp->nr_domains; rd++) {
 		if (rd->id == RAPL_DOMAIN_PACKAGE) {
 			nr_pl = find_nr_power_limit(rd);
-			pr_debug("register socket %d package domain %s\n",
-				rp->id, rd->name);
-			memset(dev_name, 0, sizeof(dev_name));
-			snprintf(dev_name, sizeof(dev_name), "%s-%d",
-				rd->name, rp->id);
+			pr_debug("register package domain %s\n", rp->name);
 			power_zone = powercap_register_zone(&rd->power_zone,
 							control_type,
-							dev_name, NULL,
+							rp->name, NULL,
 							&zone_ops[rd->id],
 							nr_pl,
 							&constraint_ops);
 			if (IS_ERR(power_zone)) {
-				pr_debug("failed to register package, %d\n",
-					rp->id);
+				pr_debug("failed to register power zone %s\n",
+					rp->name);
 				return PTR_ERR(power_zone);
 			}
 			/* track parent zone in per package/socket data */
@@ -1254,8 +1253,8 @@ static int rapl_package_register_powercap(struct rapl_package *rp)
 						&constraint_ops);
 
 		if (IS_ERR(power_zone)) {
-			pr_debug("failed to register power_zone, %d:%s:%s\n",
-				rp->id, rd->name, dev_name);
+			pr_debug("failed to register power_zone, %s:%s\n",
+				rp->name, rd->name);
 			ret = PTR_ERR(power_zone);
 			goto err_cleanup;
 		}
@@ -1268,7 +1267,7 @@ static int rapl_package_register_powercap(struct rapl_package *rp)
 	 * failed after the first domain setup.
 	 */
 	while (--rd >= rp->domains) {
-		pr_debug("unregister package %d domain %s\n", rp->id, rd->name);
+		pr_debug("unregister %s domain %s\n", rp->name, rd->name);
 		powercap_unregister_zone(control_type, &rd->power_zone);
 	}
 
@@ -1378,8 +1377,8 @@ static void rapl_detect_powerlimit(struct rapl_domain *rd)
 	/* check if the domain is locked by BIOS, ignore if MSR doesn't exist */
 	if (!rapl_read_data_raw(rd, FW_LOCK, false, &val64)) {
 		if (val64) {
-			pr_info("RAPL package %d domain %s locked by BIOS\n",
-				rd->rp->id, rd->name);
+			pr_info("RAPL %s domain %s locked by BIOS\n",
+				rd->rp->name, rd->name);
 			rd->state |= DOMAIN_STATE_BIOS_LOCKED;
 		}
 	}
@@ -1408,10 +1407,10 @@ static int rapl_detect_domains(struct rapl_package *rp, int cpu)
 	}
 	rp->nr_domains = bitmap_weight(&rp->domain_map,	RAPL_DOMAIN_MAX);
 	if (!rp->nr_domains) {
-		pr_debug("no valid rapl domains found in package %d\n", rp->id);
+		pr_debug("no valid rapl domains found in %s\n", rp->name);
 		return -ENODEV;
 	}
-	pr_debug("found %d domains on package %d\n", rp->nr_domains, rp->id);
+	pr_debug("found %d domains on %s\n", rp->nr_domains, rp->name);
 
 	rp->domains = kcalloc(rp->nr_domains + 1, sizeof(struct rapl_domain),
 			GFP_KERNEL);
@@ -1444,8 +1443,8 @@ static void rapl_remove_package(struct rapl_package *rp)
 			rd_package = rd;
 			continue;
 		}
-		pr_debug("remove package, undo power limit on %d: %s\n",
-			 rp->id, rd->name);
+		pr_debug("remove package, undo power limit on %s: %s\n",
+			 rp->name, rd->name);
 		powercap_unregister_zone(control_type, &rd->power_zone);
 	}
 	/* do parent zone last */
@@ -1459,6 +1458,7 @@ static struct rapl_package *rapl_add_package(int cpu)
 {
 	int id = topology_unique_die_id(cpu);
 	struct rapl_package *rp;
+	struct cpuinfo_x86 *c = &cpu_data(cpu);
 	int ret;
 
 	rp = kzalloc(sizeof(struct rapl_package), GFP_KERNEL);
@@ -1469,6 +1469,13 @@ static struct rapl_package *rapl_add_package(int cpu)
 	rp->id = id;
 	rp->lead_cpu = cpu;
 
+	if (c->x86_max_dies > 1)
+		snprintf(rp->name, PACKAGE_DOMAIN_NAME_LENGTH,
+			"package-%d-die-%d", c->phys_proc_id, c->cpu_die_id);
+	else
+		snprintf(rp->name, PACKAGE_DOMAIN_NAME_LENGTH, "package-%d",
+			c->phys_proc_id);
+
 	/* check if the package contains valid domains */
 	if (rapl_detect_domains(rp, cpu) ||
 		rapl_defaults->check_unit(rp, cpu)) {
-- 
2.18.0-rc0

