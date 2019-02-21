Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62EADC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 18:33:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B11820818
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 18:33:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ekaa0Ez3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727666AbfBUSdu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 13:33:50 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:45160 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725831AbfBUSdt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 13:33:49 -0500
Received: by mail-ot1-f66.google.com with SMTP id 32so45697373ota.12
        for <linux-kernel@vger.kernel.org>; Thu, 21 Feb 2019 10:33:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=lMWT7KM6/aMcaslesYkuP8ba/eNeNhCpsmiEfBK4Z2g=;
        b=Ekaa0Ez3C+UUrAY1mlOYlG3EbjSYnz2Z52g6fgqMdImseWrNgiskPW6bm3H11/u1jl
         zREPtiBPJPXLiESD7k/hhD8acQGxLoYbL+0bTcznuDA/G5vUiTm2sdrduRbMgUPzq91/
         0AXSX09q+yNaYnHSpHmWgiGi2hEk17V6VoWaHfOIb376531NlG2H96bIYMUQCBriWVr8
         IYuqbQvbTXekOEX9cUbcd+ZiPh+yrWdW2nw3ag0ut/ShYBKT9FHQcWE03pl7xnnUn4XB
         oaaAboEDowml8w+mMLC3wsm+Q0mlfLceE6QbYquUE4VMB5ZmP6X5Td/9lrLI8B05vEb+
         U7Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=lMWT7KM6/aMcaslesYkuP8ba/eNeNhCpsmiEfBK4Z2g=;
        b=sPGV0TOSDc7XT1GlpnXsHtqvMTv1IFcQ6N+lRYVRYLIKgl6lyo458iWQtdYJZnyzk3
         0BxP7QAalYxIZWzArkWZcM3r3gzsRWj5ruNAMUk4EKGB8j20/6YSQQALKe31VUZnSuL4
         evJAxSC7aMJNEQDmDh9wyu8So9IgXZiErsrjPYEKkvYRlYtIDdb6aRzfoTQxcaeD9933
         477urrfA3ucd50L7CbDYLv1NFtkt1YGRlyCTP4wCCKjoFLRYMmHD1sBYU8NNTBb7QEBX
         hpjJPZxueym1XuwZYuMarUg9qLRXxhzXUFxHkg1V/AyJosShnwVUwANCMz4AFR6KPN9H
         4dtA==
X-Gm-Message-State: AHQUAuZ0AktozERnINOwyJT6yh9RmA5L4Ms0BIFOaGDmz1UxdOCFOi/d
        3oF7Rrq5/ONdb7VW4km47g==
X-Google-Smtp-Source: AHgI3IaRP7feBRxE3oGk5usMImCpGbZFhUcqLcJApKCumYAZa4UIhCwmr5TTetIXGR1injs5rDGFmQ==
X-Received: by 2002:a05:6830:144a:: with SMTP id w10mr12813235otp.154.1550774028132;
        Thu, 21 Feb 2019 10:33:48 -0800 (PST)
Received: from serve.minyard.net ([47.184.128.64])
        by smtp.gmail.com with ESMTPSA id c132sm9774984oia.41.2019.02.21.10.33.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Feb 2019 10:33:47 -0800 (PST)
Received: from t430.minyard.net (unknown [IPv6:2001:470:b8f6:1b:55d9:7907:9a5d:e782])
        by serve.minyard.net (Postfix) with ESMTPA id 9C1841808ED;
        Thu, 21 Feb 2019 18:33:46 +0000 (UTC)
Received: by t430.minyard.net (Postfix, from userid 1000)
        id 27492302A73; Thu, 21 Feb 2019 12:33:46 -0600 (CST)
From:   minyard@acm.org
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, honglei5@huawei.com,
        Corey Minyard <cminyard@mvista.com>
Subject: [PATCH] ipmi_si: Fix crash when using hard-coded device
Date:   Thu, 21 Feb 2019 12:33:43 -0600
Message-Id: <20190221183343.13554-1-minyard@acm.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Corey Minyard <cminyard@mvista.com>

When excuting a command like:
  modprobe ipmi_si ports=0xffc0e3 type=bt
The system would get an oops.

The trouble here is that ipmi_si_hardcode_find_bmc() is called before
ipmi_si_platform_init(), but initialization of the hard-coded device
creates an IPMI platform device, which won't be initialized yet.

The real trouble is that hard-coded devices aren't created with
any device, and the fixup is done later.  So do it right, create the
hard-coded devices as normal platform devices.

This required adding some new resource types to the IPMI platform
code for passing information required by the hard-coded device
and adding some code to remove the hard-coded platform devices
on module removal.

To enforce the "hard-coded devices passed by the user take priority
over firmware devices" rule, some special code was added to check
and see if a hard-coded device already exists.

Reported-by: Yang Yingliang <yangyingliang@huawei.com>
Signed-off-by: Corey Minyard <cminyard@mvista.com>
---

I believe this is the right fix.  Can you test/review and send the
results?

Thanks,

-corey

 drivers/char/ipmi/ipmi_si.h          |   4 +-
 drivers/char/ipmi/ipmi_si_hardcode.c | 236 ++++++++++++++++++++-------
 drivers/char/ipmi/ipmi_si_intf.c     |  23 ++-
 drivers/char/ipmi/ipmi_si_platform.c |  25 ++-
 4 files changed, 214 insertions(+), 74 deletions(-)

diff --git a/drivers/char/ipmi/ipmi_si.h b/drivers/char/ipmi/ipmi_si.h
index 52f6152d1fcb..7ae52c17618e 100644
--- a/drivers/char/ipmi/ipmi_si.h
+++ b/drivers/char/ipmi/ipmi_si.h
@@ -25,7 +25,9 @@ void ipmi_irq_finish_setup(struct si_sm_io *io);
 int ipmi_si_remove_by_dev(struct device *dev);
 void ipmi_si_remove_by_data(int addr_space, enum si_type si_type,
 			    unsigned long addr);
-int ipmi_si_hardcode_find_bmc(void);
+void ipmi_hardcode_init(void);
+void ipmi_si_hardcode_exit(void);
+int ipmi_si_hardcode_match(int addr_type, unsigned long addr);
 void ipmi_si_platform_init(void);
 void ipmi_si_platform_shutdown(void);
 
diff --git a/drivers/char/ipmi/ipmi_si_hardcode.c b/drivers/char/ipmi/ipmi_si_hardcode.c
index 487642809c58..1e5783961b0d 100644
--- a/drivers/char/ipmi/ipmi_si_hardcode.c
+++ b/drivers/char/ipmi/ipmi_si_hardcode.c
@@ -3,6 +3,7 @@
 #define pr_fmt(fmt) "ipmi_hardcode: " fmt
 
 #include <linux/moduleparam.h>
+#include <linux/platform_device.h>
 #include "ipmi_si.h"
 
 /*
@@ -12,23 +13,22 @@
 
 #define SI_MAX_PARMS 4
 
-static char          *si_type[SI_MAX_PARMS];
 #define MAX_SI_TYPE_STR 30
-static char          si_type_str[MAX_SI_TYPE_STR];
+static char          si_type_str[MAX_SI_TYPE_STR] __initdata;
 static unsigned long addrs[SI_MAX_PARMS];
 static unsigned int num_addrs;
 static unsigned int  ports[SI_MAX_PARMS];
 static unsigned int num_ports;
-static int           irqs[SI_MAX_PARMS];
-static unsigned int num_irqs;
-static int           regspacings[SI_MAX_PARMS];
-static unsigned int num_regspacings;
-static int           regsizes[SI_MAX_PARMS];
-static unsigned int num_regsizes;
-static int           regshifts[SI_MAX_PARMS];
-static unsigned int num_regshifts;
-static int slave_addrs[SI_MAX_PARMS]; /* Leaving 0 chooses the default value */
-static unsigned int num_slave_addrs;
+static int           irqs[SI_MAX_PARMS] __initdata;
+static unsigned int num_irqs __initdata;
+static int           regspacings[SI_MAX_PARMS] __initdata;
+static unsigned int num_regspacings __initdata;
+static int           regsizes[SI_MAX_PARMS] __initdata;
+static unsigned int num_regsizes __initdata;
+static int           regshifts[SI_MAX_PARMS] __initdata;
+static unsigned int num_regshifts __initdata;
+static int slave_addrs[SI_MAX_PARMS] __initdata;
+static unsigned int num_slave_addrs __initdata;
 
 module_param_string(type, si_type_str, MAX_SI_TYPE_STR, 0);
 MODULE_PARM_DESC(type, "Defines the type of each interface, each"
@@ -73,12 +73,133 @@ MODULE_PARM_DESC(slave_addrs, "Set the default IPMB slave address for"
 		 " overridden by this parm.  This is an array indexed"
 		 " by interface number.");
 
-int ipmi_si_hardcode_find_bmc(void)
+static struct platform_device *ipmi_hc_pdevs[SI_MAX_PARMS];
+
+static void __init ipmi_hardcode_init_one(const char *si_type_str,
+					  unsigned int i,
+					  unsigned long addr,
+					  unsigned int flags)
 {
-	int ret = -ENODEV;
-	int             i;
-	struct si_sm_io io;
+	struct platform_device *pdev;
+	unsigned int num_r = 1, size;
+	struct resource r[4];
+	struct property_entry p[6];
+	enum si_type si_type;
+	unsigned int regspacing, regsize;
+	int rv;
+
+	memset(p, 0, sizeof(p));
+	memset(r, 0, sizeof(r));
+
+	if (!si_type_str || !*si_type_str || strcmp(si_type_str, "kcs") == 0) {
+		size = 2;
+		si_type = SI_KCS;
+	} else if (strcmp(si_type_str, "smic") == 0) {
+		size = 2;
+		si_type = SI_SMIC;
+	} else if (strcmp(si_type_str, "bt") == 0) {
+		size = 3;
+		si_type = SI_BT;
+	} else if (strcmp(si_type_str, "invalid") == 0) {
+		/*
+		 * Allow a firmware-specified interface to be
+		 * disabled.
+		 */
+		size = 1;
+		si_type = SI_TYPE_INVALID;
+	} else {
+		pr_warn("Interface type specified for interface %d, was invalid: %s\n",
+			i, si_type_str);
+		return;
+	}
+
+	regsize = regsizes[i];
+	if (regsize == 0)
+		regsize = DEFAULT_REGSIZE;
+
+	p[0] = PROPERTY_ENTRY_U8("ipmi-type", si_type);
+	p[1] = PROPERTY_ENTRY_U8("slave-addr", slave_addrs[i]);
+	p[2] = PROPERTY_ENTRY_U8("addr-source", SI_HARDCODED);
+	p[3] = PROPERTY_ENTRY_U8("reg-shift", regshifts[i]);
+	p[4] = PROPERTY_ENTRY_U8("reg-size", regsize);
+	/* Last entry must be left NULL to terminate it. */
+
+	/*
+	 * Register spacing is derived from the resources in
+	 * the IPMI platform code.
+	 */
+	regspacing = regspacings[i];
+	if (regspacing == 0)
+		regspacing = regsize;
+
+	r[0].start = addr;
+	r[0].end = r[0].start + regsize - 1;
+	r[0].name = "IPMI Address 1";
+	r[0].flags = flags;
+
+	if (size > 1) {
+		r[1].start = r[0].start + regspacing;
+		r[1].end = r[1].start + regsize - 1;
+		r[1].name = "IPMI Address 2";
+		r[1].flags = flags;
+		num_r++;
+	}
+
+	if (size > 2) {
+		r[2].start = r[1].start + regspacing;
+		r[2].end = r[2].start + regsize - 1;
+		r[2].name = "IPMI Address 3";
+		r[2].flags = flags;
+		num_r++;
+	}
+
+	if (irqs[i]) {
+		r[num_r].start = irqs[i];
+		r[num_r].end = irqs[i];
+		r[num_r].name = "IPMI IRQ";
+		r[num_r].flags = IORESOURCE_IRQ;
+		num_r++;
+	}
+
+	pdev = platform_device_alloc("hardcode-ipmi-si", i);
+	if (!pdev) {
+		pr_err("Error allocating IPMI platform device %d\n", i);
+		return;
+	}
+
+	rv = platform_device_add_resources(pdev, r, num_r);
+	if (rv) {
+		dev_err(&pdev->dev,
+			"Unable to add hard-code resources: %d\n", rv);
+		goto err;
+	}
+
+	rv = platform_device_add_properties(pdev, p);
+	if (rv) {
+		dev_err(&pdev->dev,
+			"Unable to add hard-code properties: %d\n", rv);
+		goto err;
+	}
+
+	rv = platform_device_add(pdev);
+	if (rv) {
+		dev_err(&pdev->dev,
+			"Unable to add hard-code device: %d\n", rv);
+		goto err;
+	}
+
+	ipmi_hc_pdevs[i] = pdev;
+	return;
+
+err:
+	platform_device_put(pdev);
+}
+
+void __init ipmi_hardcode_init(void)
+{
+	unsigned int i;
 	char *str;
+	char *si_type[SI_MAX_PARMS];
 
 	/* Parse out the si_type string into its components. */
 	str = si_type_str;
@@ -95,54 +216,45 @@ int ipmi_si_hardcode_find_bmc(void)
 		}
 	}
 
-	memset(&io, 0, sizeof(io));
 	for (i = 0; i < SI_MAX_PARMS; i++) {
-		if (!ports[i] && !addrs[i])
-			continue;
-
-		io.addr_source = SI_HARDCODED;
-		pr_info("probing via hardcoded address\n");
-
-		if (!si_type[i] || strcmp(si_type[i], "kcs") == 0) {
-			io.si_type = SI_KCS;
-		} else if (strcmp(si_type[i], "smic") == 0) {
-			io.si_type = SI_SMIC;
-		} else if (strcmp(si_type[i], "bt") == 0) {
-			io.si_type = SI_BT;
-		} else {
-			pr_warn("Interface type specified for interface %d, was invalid: %s\n",
-				i, si_type[i]);
-			continue;
-		}
+		if (i < num_ports && ports[i])
+			ipmi_hardcode_init_one(si_type[i], i, ports[i],
+					       IORESOURCE_IO);
+		if (i < num_addrs && addrs[i])
+			ipmi_hardcode_init_one(si_type[i], i, addrs[i],
+					       IORESOURCE_MEM);
+	}
+}
 
-		if (ports[i]) {
-			/* An I/O port */
-			io.addr_data = ports[i];
-			io.addr_type = IPMI_IO_ADDR_SPACE;
-		} else if (addrs[i]) {
-			/* A memory port */
-			io.addr_data = addrs[i];
-			io.addr_type = IPMI_MEM_ADDR_SPACE;
-		} else {
-			pr_warn("Interface type specified for interface %d, but port and address were not set or set to zero\n",
-				i);
-			continue;
-		}
+void ipmi_si_hardcode_exit(void)
+{
+	unsigned int i;
 
-		io.addr = NULL;
-		io.regspacing = regspacings[i];
-		if (!io.regspacing)
-			io.regspacing = DEFAULT_REGSPACING;
-		io.regsize = regsizes[i];
-		if (!io.regsize)
-			io.regsize = DEFAULT_REGSIZE;
-		io.regshift = regshifts[i];
-		io.irq = irqs[i];
-		if (io.irq)
-			io.irq_setup = ipmi_std_irq_setup;
-		io.slave_addr = slave_addrs[i];
-
-		ret = ipmi_si_add_smi(&io);
+	for (i = 0; i < SI_MAX_PARMS; i++) {
+		if (ipmi_hc_pdevs[i])
+			platform_device_unregister(ipmi_hc_pdevs[i]);
 	}
-	return ret;
+}
+
+/*
+ * Returns true of the given address exists as a hardcoded address,
+ * false if not.
+ */
+int ipmi_si_hardcode_match(int addr_type, unsigned long addr)
+{
+	unsigned int i;
+
+	if (addr_type == IPMI_IO_ADDR_SPACE) {
+		for (i = 0; i < num_ports; i++) {
+			if (ports[i] == addr)
+				return 1;
+		}
+	} else {
+		for (i = 0; i < num_addrs; i++) {
+			if (addrs[i] == addr)
+				return 1;
+		}
+	}
+
+	return 0;
 }
diff --git a/drivers/char/ipmi/ipmi_si_intf.c b/drivers/char/ipmi/ipmi_si_intf.c
index ae99d6a14789..abbd526626d5 100644
--- a/drivers/char/ipmi/ipmi_si_intf.c
+++ b/drivers/char/ipmi/ipmi_si_intf.c
@@ -1865,6 +1865,18 @@ int ipmi_si_add_smi(struct si_sm_io *io)
 	int rv = 0;
 	struct smi_info *new_smi, *dup;
 
+	/*
+	 * If the user gave us a hard-coded device at the same
+	 * address, they presumably want us to use it and not what is
+	 * in the firmware.
+	 */
+	if (io->addr_source != SI_HARDCODED &&
+	    ipmi_si_hardcode_match(io->addr_type, io->addr_data)) {
+		dev_info(io->dev,
+			 "Hard-coded device at this address already exists");
+		return -ENODEV;
+	}
+
 	if (!io->io_setup) {
 		if (io->addr_type == IPMI_IO_ADDR_SPACE) {
 			io->io_setup = ipmi_si_port_setup;
@@ -2097,7 +2109,7 @@ static int try_smi_init(struct smi_info *new_smi)
 	return rv;
 }
 
-static int init_ipmi_si(void)
+static int __init init_ipmi_si(void)
 {
 	struct smi_info *e;
 	enum ipmi_addr_src type = SI_INVALID;
@@ -2105,11 +2117,9 @@ static int init_ipmi_si(void)
 	if (initialized)
 		return 0;
 
-	pr_info("IPMI System Interface driver\n");
+	ipmi_hardcode_init();
 
-	/* If the user gave us a device, they presumably want us to use it */
-	if (!ipmi_si_hardcode_find_bmc())
-		goto do_scan;
+	pr_info("IPMI System Interface driver\n");
 
 	ipmi_si_platform_init();
 
@@ -2121,7 +2131,6 @@ static int init_ipmi_si(void)
 	   with multiple BMCs we assume that there will be several instances
 	   of a given type so if we succeed in registering a type then also
 	   try to register everything else of the same type */
-do_scan:
 	mutex_lock(&smi_infos_lock);
 	list_for_each_entry(e, &smi_infos, link) {
 		/* Try to register a device if it has an IRQ and we either
@@ -2307,6 +2316,8 @@ static void cleanup_ipmi_si(void)
 	list_for_each_entry_safe(e, tmp_e, &smi_infos, link)
 		cleanup_one_si(e);
 	mutex_unlock(&smi_infos_lock);
+
+	ipmi_si_hardcode_exit();
 }
 module_exit(cleanup_ipmi_si);
 
diff --git a/drivers/char/ipmi/ipmi_si_platform.c b/drivers/char/ipmi/ipmi_si_platform.c
index 15cf819f884f..f8f85416d47a 100644
--- a/drivers/char/ipmi/ipmi_si_platform.c
+++ b/drivers/char/ipmi/ipmi_si_platform.c
@@ -128,8 +128,6 @@ ipmi_get_info_from_resources(struct platform_device *pdev,
 		if (res_second->start > io->addr_data)
 			io->regspacing = res_second->start - io->addr_data;
 	}
-	io->regsize = DEFAULT_REGSIZE;
-	io->regshift = 0;
 
 	return res;
 }
@@ -137,7 +135,7 @@ ipmi_get_info_from_resources(struct platform_device *pdev,
 static int platform_ipmi_probe(struct platform_device *pdev)
 {
 	struct si_sm_io io;
-	u8 type, slave_addr, addr_source;
+	u8 type, slave_addr, addr_source, regsize, regshift;
 	int rv;
 
 	rv = device_property_read_u8(&pdev->dev, "addr-source", &addr_source);
@@ -149,7 +147,7 @@ static int platform_ipmi_probe(struct platform_device *pdev)
 	if (addr_source == SI_SMBIOS) {
 		if (!si_trydmi)
 			return -ENODEV;
-	} else {
+	} else if (addr_source != SI_HARDCODED) {
 		if (!si_tryplatform)
 			return -ENODEV;
 	}
@@ -169,11 +167,23 @@ static int platform_ipmi_probe(struct platform_device *pdev)
 	case SI_BT:
 		io.si_type = type;
 		break;
+	case SI_TYPE_INVALID: /* User disabled this in hardcode. */
+		return -ENODEV;
 	default:
 		dev_err(&pdev->dev, "ipmi-type property is invalid\n");
 		return -EINVAL;
 	}
 
+	io.regsize = DEFAULT_REGSIZE;
+	rv = device_property_read_u8(&pdev->dev, "reg-size", &regsize);
+	if (!rv)
+	    io.regsize = regsize;
+
+	io.regshift = 0;
+	rv = device_property_read_u8(&pdev->dev, "reg-shift", &regshift);
+	if (!rv)
+	    io.regshift = regshift;
+
 	if (!ipmi_get_info_from_resources(pdev, &io))
 		return -EINVAL;
 
@@ -193,7 +203,8 @@ static int platform_ipmi_probe(struct platform_device *pdev)
 
 	io.dev = &pdev->dev;
 
-	pr_info("ipmi_si: SMBIOS: %s %#lx regsize %d spacing %d irq %d\n",
+	pr_info("ipmi_si: %s: %s %#lx regsize %d spacing %d irq %d\n",
+		ipmi_addr_src_to_str(addr_source),
 		(io.addr_type == IPMI_IO_ADDR_SPACE) ? "io" : "mem",
 		io.addr_data, io.regsize, io.regspacing, io.irq);
 
@@ -358,6 +369,9 @@ static int acpi_ipmi_probe(struct platform_device *pdev)
 		goto err_free;
 	}
 
+	io.regsize = DEFAULT_REGSIZE;
+	io.regshift = 0;
+
 	res = ipmi_get_info_from_resources(pdev, &io);
 	if (!res) {
 		rv = -EINVAL;
@@ -421,6 +435,7 @@ static int ipmi_remove(struct platform_device *pdev)
 
 static const struct platform_device_id si_plat_ids[] = {
     { "dmi-ipmi-si", 0 },
+    { "hardcode-ipmi-si", 0 },
     { }
 };
 
-- 
2.17.1

