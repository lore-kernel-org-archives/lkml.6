Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB602C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 03:41:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72230217D7
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 03:41:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550547667;
	bh=7Fc8JQrJ/HQ6WUDneyt8rHe9oG955W6ZMdACClr4UMQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To:List-ID:
	 From;
	b=PSNtoupJqyomHTHFiP/oGIYP7rrNQ6216J2ngqolH40klSvmyuc3YvsKU5pJUuOvC
	 YdWMxQLYcGu1DBzEU9WJAOwC2CZLnXFs6COvVu38g6LjPzfOUDQcdBAK9o2gFTOdYQ
	 U+GNoZCruRf7TBTE0kW8c0Vx3arRSLhGWO/8hBEU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727003AbfBSDlG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 22:41:06 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:46227 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725870AbfBSDk2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 22:40:28 -0500
Received: by mail-qk1-f194.google.com with SMTP id i5so11220033qkd.13;
        Mon, 18 Feb 2019 19:40:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :reply-to:organization;
        bh=vd7SXS+DM9G/S+g6dKoqWpmBLRLvj4kTz4MPUfwNqzY=;
        b=KTbn0ntzQ/+3XzAGlb3ei0HzItGTvGOBcdRtK4IWqXyPCkLRC6EBT3XpZiKzGnSVMX
         Uv2BP7uiKi/WJlduRTzk1zZFokbKQPbw6HZ1vrsc/3BAjGe7IkQmKaiFexgwp525I3HO
         s30ClDMgOSBJkcroHU+gv/9slMqA21K+POzUr7jcs+iFM5KjQOiWyr8ltFrTIKWkmuRA
         E4QwDCzJcA1p9lxy3QiWpHxWpcBP0QGPy1XlqrUWOETahvqMPP7ixsnVXPvatItBJ6xQ
         JPrmYDAEgvg+gIvDMLwviKXVu6Br8bWzALX3maIkbdMSVcX7elgdgblJLlTE92N5kvCb
         P+jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:reply-to:organization;
        bh=vd7SXS+DM9G/S+g6dKoqWpmBLRLvj4kTz4MPUfwNqzY=;
        b=OgRZ+jIIfNa/00MzjG8zd+v+QckajPwb/ZxU79+/m9K7z4Ej3zAuyz/pFmaA9LxJLM
         R1rnnYzQ3X8AzqrYRDqJIbYBqxM9q9RGPRHSrBmMPKWoZUQwDGTlvuooG+ev3aLx///G
         GWtBGzNJMLihzSKULmx21/LGHCbw3Ix7ok3heGbWYlWZavBwSDlQK14tXDnCycPDwN5k
         5mHym7Y3xSXWqCDIs7MJRPEzem0Zj6GY3OeClZWXdTfMbGAMJ9QMQ8HcPUfLLs53m7es
         P0d/WGdi/LffsxS4gmt/2d8EE/sGcWWw2QQEwpXWVjibznuC3g5g48XgZY9nNbYtiHqs
         sK+g==
X-Gm-Message-State: AHQUAuZUn0CxUIQ8yLIlFwMaOJ9EowkuFqUwNhnH/3IZ1SwA7U+AtTcp
        Lu0SexmuzzNmEcPXszWmZ9E=
X-Google-Smtp-Source: AHgI3IbJvpNPL4fDWhK85P8Ha2hIXxEfJWYUkGhL/iPYsueLyXevlDL5W6OY9gPHWAypSIjOEEXLyQ==
X-Received: by 2002:a37:a546:: with SMTP id o67mr19056989qke.42.1550547627089;
        Mon, 18 Feb 2019 19:40:27 -0800 (PST)
Received: from kbl.fios-router.home (pool-96-233-42-17.bstnma.fios.verizon.net. [96.233.42.17])
        by smtp.gmail.com with ESMTPSA id u5sm7327680qtg.37.2019.02.18.19.40.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Feb 2019 19:40:26 -0800 (PST)
From:   Len Brown <lenb@kernel.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>,
        linux-doc@vger.kernel.org
Subject: [PATCH 04/11] cpu topology: export die_id
Date:   Mon, 18 Feb 2019 22:40:06 -0500
Message-Id: <a1faeb72345227a49aae0475abf910421dc40a1c.1550545163.git.len.brown@intel.com>
X-Mailer: git-send-email 2.18.0-rc0
In-Reply-To: <635b2bf8b1151a191cd9299276b75791a818c0c2.1550545163.git.len.brown@intel.com>
References: <635b2bf8b1151a191cd9299276b75791a818c0c2.1550545163.git.len.brown@intel.com>
Reply-To: Len Brown <lenb@kernel.org>
Organization: Intel Open Source Technology Center
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Len Brown <len.brown@intel.com>

Export die_id in cpu topology, for the benefit of hardware that
has multiple die per package.  die_id is quite similar to core_id,
in that it holds multiple CPUs, but is inside a package.

This needed by topology-aware user-space.  In particular,
an application, such as turbostat(8), which needs to know
the actual scope of "package-scope" MSRs.

Signed-off-by: Len Brown <len.brown@intel.com>
Cc: linux-doc@vger.kernel.org
Signed-off-by: Len Brown <len.brown@intel.com>
---
 Documentation/cputopology.txt   | 10 ++++++++--
 arch/x86/include/asm/topology.h |  1 +
 drivers/base/topology.c         |  4 ++++
 include/linux/topology.h        |  3 +++
 4 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/Documentation/cputopology.txt b/Documentation/cputopology.txt
index 2698da7e4f49..287213b4517b 100644
--- a/Documentation/cputopology.txt
+++ b/Documentation/cputopology.txt
@@ -12,6 +12,12 @@ physical_package_id:
 	socket number, but the actual value is architecture and platform
 	dependent.
 
+die_id:
+
+	the CPU die ID of cpuX. Typically it is the hardware platform's
+	identifier (rather than the kernel's).  The actual value is
+	architecture and platform dependent.
+
 core_id:
 
 	the CPU core ID of cpuX. Typically it is the hardware platform's
@@ -43,12 +49,12 @@ thread_siblings_list:
 core_siblings:
 
 	internal kernel map of cpuX's hardware threads within the same
-	physical_package_id.
+	die_id.
 
 core_siblings_list:
 
 	human-readable list of cpuX's hardware threads within the same
-	physical_package_id.
+	die_id.
 
 book_siblings:
 
diff --git a/arch/x86/include/asm/topology.h b/arch/x86/include/asm/topology.h
index 453cf38a1c33..281be6bbc80d 100644
--- a/arch/x86/include/asm/topology.h
+++ b/arch/x86/include/asm/topology.h
@@ -106,6 +106,7 @@ extern const struct cpumask *cpu_coregroup_mask(int cpu);
 
 #define topology_logical_package_id(cpu)	(cpu_data(cpu).logical_proc_id)
 #define topology_physical_package_id(cpu)	(cpu_data(cpu).phys_proc_id)
+#define topology_die_id(cpu)			(cpu_data(cpu).cpu_die_id)
 #define topology_core_id(cpu)			(cpu_data(cpu).cpu_core_id)
 
 #ifdef CONFIG_SMP
diff --git a/drivers/base/topology.c b/drivers/base/topology.c
index 5fd9f167ecc1..50352cf96f85 100644
--- a/drivers/base/topology.c
+++ b/drivers/base/topology.c
@@ -43,6 +43,9 @@ static ssize_t name##_list_show(struct device *dev,			\
 define_id_show_func(physical_package_id);
 static DEVICE_ATTR_RO(physical_package_id);
 
+define_id_show_func(die_id);
+static DEVICE_ATTR_RO(die_id);
+
 define_id_show_func(core_id);
 static DEVICE_ATTR_RO(core_id);
 
@@ -72,6 +75,7 @@ static DEVICE_ATTR_RO(drawer_siblings_list);
 
 static struct attribute *default_attrs[] = {
 	&dev_attr_physical_package_id.attr,
+	&dev_attr_die_id.attr,
 	&dev_attr_core_id.attr,
 	&dev_attr_thread_siblings.attr,
 	&dev_attr_thread_siblings_list.attr,
diff --git a/include/linux/topology.h b/include/linux/topology.h
index cb0775e1ee4b..5cc8595dd0e4 100644
--- a/include/linux/topology.h
+++ b/include/linux/topology.h
@@ -184,6 +184,9 @@ static inline int cpu_to_mem(int cpu)
 #ifndef topology_physical_package_id
 #define topology_physical_package_id(cpu)	((void)(cpu), -1)
 #endif
+#ifndef topology_die_id
+#define topology_die_id(cpu)			((void)(cpu), -1)
+#endif
 #ifndef topology_core_id
 #define topology_core_id(cpu)			((void)(cpu), 0)
 #endif
-- 
2.18.0-rc0

