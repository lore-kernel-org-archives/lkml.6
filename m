Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2921FC4360F
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 03:40:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EED3D21773
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 03:40:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550547647;
	bh=twcOX56e0/4WliLxy1WR5bEhwD8Jk/rippbyemDJcp0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To:List-ID:
	 From;
	b=DCIp6RAut4l7TpIRHwi1N42/IqZq5/wp5Vhr++0KtQsk3YY6pc5Zu9qfhBnQrqzsO
	 EcTd7e101UT5H0xmMgq3DKmmfThV8yihAEHhM6U/o3vexkqwQYJlsNh9cMxmeJGaOG
	 t9eRDXVKiQGsexMyJactnI/7i3eZyH22KQ+SEyXY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726841AbfBSDkp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 22:40:45 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:38245 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726583AbfBSDkh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 22:40:37 -0500
Received: by mail-qk1-f195.google.com with SMTP id p15so11253034qkl.5;
        Mon, 18 Feb 2019 19:40:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :reply-to:organization;
        bh=4x3YEbY+b8iwgi6V4Vw/GKRAcVXI/s5Wldf/gvM/ryc=;
        b=YmAtURyI8zG/1xt0X4+vDRUqCZvrKrDB7Hln7uHlOsYMsx8bvgnkAZa0voxRwOwA8v
         /ZU6+VR07GCo+PMhvCDL+MWcBx01NUeXeKrHmk5gn6D6X9Y36GDvEe4oeAqwe4VsUmcy
         dcO6FMMEHgTQIzTeyP83lmaY5necvZ0Pky7aXRH4nH/fciWURxtzJ1B+oPIVOwyU4Vrs
         ya4FsJtzfsmxEW60p9Lpv7+DTKdpZWn8S9m/URu2gLlcyEVu5tBUUUOUqDjP9CrsST8b
         +XoFEAJjnEFr5/P0E6sdZelb2JLJpJOCsRaL/s6Nv6NyaOi099RRMrcl6fmIjpqWvXqm
         htEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:reply-to:organization;
        bh=4x3YEbY+b8iwgi6V4Vw/GKRAcVXI/s5Wldf/gvM/ryc=;
        b=ezEMrTTqBYq3V15b3toGViqxeuaYfXf7rUv+ZU4hsAiwXwDTZ67qLJK7VzbN0ERJsx
         0XVu9JjzXTahcWUf+JoQaEiPsKgSgybzbyhbUg9biBwMLp2S8L35xxm5L13hd4hxFjb5
         m0hd0QQd0kNgypSXJMA769LySl6WfEV2vh4GPcr+gMNEGEIZQTEXlQ3jq0gfb5Af5GXM
         jDupx/vkTP8/JmninGw5aFkjmMqc3meckkNbJwuDz46s0mj90hDz2iYAxMA/SrXWExNz
         +UltK83maB99TjKDibZzTxocdl4QgjbHM8ESuMjkwm3r/FBPhwPFfhbPPEXLHBlerTiH
         ATSA==
X-Gm-Message-State: AHQUAubjE91EdDP8mDRFrI7XoupOcGakDRhrxd3rxhQ72stx+sD/qqrg
        qE/g51+zZ1+mNdQYJUtRaBg=
X-Google-Smtp-Source: AHgI3IZqczMZvBsPPtJt4zm0gkPkcnsOELBX8QanN7ftQG2PiWd88Lxp1MjX3f0JwspMhcOmSfPR2A==
X-Received: by 2002:a37:b801:: with SMTP id i1mr18864499qkf.24.1550547636192;
        Mon, 18 Feb 2019 19:40:36 -0800 (PST)
Received: from kbl.fios-router.home (pool-96-233-42-17.bstnma.fios.verizon.net. [96.233.42.17])
        by smtp.gmail.com with ESMTPSA id u5sm7327680qtg.37.2019.02.18.19.40.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Feb 2019 19:40:35 -0800 (PST)
From:   Len Brown <lenb@kernel.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>,
        Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org,
        linux-hwmon@vger.kernel.org
Subject: [PATCH 11/11] hwmon/coretemp: Support multi-die/package
Date:   Mon, 18 Feb 2019 22:40:13 -0500
Message-Id: <8ce75b95ef6105ebe5fb8c9e43b33f06516e3c16.1550545163.git.len.brown@intel.com>
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

This patch introduces coretemp driver support
for new dual-die/package systems.

On the new dual-die/package systems, the package temperature MSRs becomes
die-scope. Thus instead of one hwmon device per physical package, now
there should be one hwmon device for each die on these systems.

On the hardwares that do not have multi-die support,
topology_unique_die_id() equals topology_physical_package_id(), thus the
only difference is that physical package id is used as the coretemp
platform device id, instead of logical package id on these systems.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
Cc: linux-pm@vger.kernel.org
Cc: linux-hwmon@vger.kernel.org
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/hwmon/coretemp.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/hwmon/coretemp.c b/drivers/hwmon/coretemp.c
index 5d34f7271e67..a0b6b2247c3a 100644
--- a/drivers/hwmon/coretemp.c
+++ b/drivers/hwmon/coretemp.c
@@ -435,7 +435,7 @@ static int chk_ucode_version(unsigned int cpu)
 
 static struct platform_device *coretemp_get_pdev(unsigned int cpu)
 {
-	int pkgid = topology_logical_package_id(cpu);
+	int pkgid = topology_unique_die_id(cpu);
 
 	if (pkgid >= 0 && pkgid < max_packages)
 		return pkg_devices[pkgid];
@@ -579,7 +579,7 @@ static struct platform_driver coretemp_driver = {
 
 static struct platform_device *coretemp_device_add(unsigned int cpu)
 {
-	int err, pkgid = topology_logical_package_id(cpu);
+	int err, pkgid = topology_unique_die_id(cpu);
 	struct platform_device *pdev;
 
 	if (pkgid < 0)
@@ -703,7 +703,7 @@ static int coretemp_cpu_offline(unsigned int cpu)
 	 * the rest.
 	 */
 	if (cpumask_empty(&pd->cpumask)) {
-		pkg_devices[topology_logical_package_id(cpu)] = NULL;
+		pkg_devices[topology_unique_die_id(cpu)] = NULL;
 		platform_device_unregister(pdev);
 		return 0;
 	}
@@ -732,6 +732,7 @@ static enum cpuhp_state coretemp_hp_online;
 static int __init coretemp_init(void)
 {
 	int err;
+	struct cpuinfo_x86 *c = &cpu_data(0);
 
 	/*
 	 * CPUID.06H.EAX[0] indicates whether the CPU has thermal
@@ -741,7 +742,7 @@ static int __init coretemp_init(void)
 	if (!x86_match_cpu(coretemp_ids))
 		return -ENODEV;
 
-	max_packages = topology_max_packages();
+	max_packages = topology_max_packages() * c->x86_max_dies;
 	pkg_devices = kcalloc(max_packages, sizeof(struct platform_device *),
 			      GFP_KERNEL);
 	if (!pkg_devices)
-- 
2.18.0-rc0

