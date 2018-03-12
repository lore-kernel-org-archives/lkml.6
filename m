Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3340693-1520824392-2-11480296997757985458
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enro,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520824391; b=j9DprH6qGZHFGQhiFxmn9fb1kx78txyuDZSiJn/JCUd7nwa
    bp4vxVF2C7DROoH6gcyht7Zcp0PTw0UEFPJHF8RUHY3ztaQrCXoFichQpRKCT2kx
    XYTilhPs1suosKiz/bHUVNTqVwgPPQ4rj0yw4kl4Yeqa3ZrpevW0VsnR8keGhFH5
    pBnUhSN2R2rbRbghQskSzAPxpWmTKhpHFY/y55YMeiMTxaIglp1dnQTVxlu1OEhg
    EESoAZmuWHIpgo2YjEubIuKd1YGxBdEYZrR2DQQ46p+DvR96HuQ094+daL4jQDWJ
    TZgvTgWH3qeFJGImBQq7cxwkhTtFDC17gHvMMeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1520824391; bh=ozNYaKEfhrMrhTPI259
    eFi5enhKsSADUQVpR7Sasqvk=; b=sXlR+a4eQBaukSvbjffxzjnzQZNUjugRVyC
    a1rXnN+sy9lifL8eeGlWHQeHwn3ZLYQAoHLJvvl3bGeFxMM+M4c1D+pCPYftOYrk
    49yjJWi6Ksscyz4/hO4BMpnplUUesuuIjTueGadLpQT2/pbgHCrCmHysS+J4rwkC
    pbNKvJFRUkYemcwdQZQD6krKxf9jc4qvDyIC/JUKOWQQaAhdtNpxWShNwfjtvtns
    c8d4d3LLCQQAI1WoiKuuX8y43E38C/ojChgSdFBTKmiAd6bsF7fJui/T4MyEcef3
    Swo/aTFYbDm4R1GGXp4OZa4lW4TDtXqaFPB0jXCauq9PcFKYJzQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932799AbeCLDNK (ORCPT <rfc822;greg@kroah.com>);
        Sun, 11 Mar 2018 23:13:10 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41532 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932792AbeCLDHv (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 11 Mar 2018 23:07:51 -0400
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Konrad Rzeszutek Wilk" <konrad.wilk@oracle.com>,
        "Will Deacon" <will.deacon@arm.com>,
        "David Woodhouse" <dwmw@amazon.co.uk>,
        "Dave Hansen" <dave.hansen@intel.com>,
        "Peter Zijlstra" <peterz@infradead.org>,
        "Linus Torvalds" <torvalds@linuxfoundation.org>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Borislav Petkov" <bp@alien8.de>
Date: Mon, 12 Mar 2018 03:06:12 +0000
Message-ID: <lsq.1520823972.587823849@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 10/76] sysfs/cpu: Add vulnerability folder
In-Reply-To: <lsq.1520823971.5976735@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.16.56-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Gleixner <tglx@linutronix.de>

commit 87590ce6e373d1a5401f6539f0c59ef92dd924a9 upstream.

As the meltdown/spectre problem affects several CPU architectures, it makes
sense to have common way to express whether a system is affected by a
particular vulnerability or not. If affected the way to express the
mitigation should be common as well.

Create /sys/devices/system/cpu/vulnerabilities folder and files for
meltdown, spectre_v1 and spectre_v2.

Allow architectures to override the show function.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Linus Torvalds <torvalds@linuxfoundation.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: David Woodhouse <dwmw@amazon.co.uk>
Link: https://lkml.kernel.org/r/20180107214913.096657732@linutronix.de
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 Documentation/ABI/testing/sysfs-devices-system-cpu | 16 ++++++++
 drivers/base/Kconfig                               |  3 ++
 drivers/base/cpu.c                                 | 48 ++++++++++++++++++++++
 include/linux/cpu.h                                |  7 ++++
 4 files changed, 74 insertions(+)

--- a/Documentation/ABI/testing/sysfs-devices-system-cpu
+++ b/Documentation/ABI/testing/sysfs-devices-system-cpu
@@ -224,3 +224,19 @@ Description:	Parameters for the Intel P-
 		frequency range.
 
 		More details can be found in Documentation/cpu-freq/intel-pstate.txt
+
+What:		/sys/devices/system/cpu/vulnerabilities
+		/sys/devices/system/cpu/vulnerabilities/meltdown
+		/sys/devices/system/cpu/vulnerabilities/spectre_v1
+		/sys/devices/system/cpu/vulnerabilities/spectre_v2
+Date:		Januar 2018
+Contact:	Linux kernel mailing list <linux-kernel@vger.kernel.org>
+Description:	Information about CPU vulnerabilities
+
+		The files are named after the code names of CPU
+		vulnerabilities. The output of those files reflects the
+		state of the CPUs in the system. Possible output values:
+
+		"Not affected"	  CPU is not affected by the vulnerability
+		"Vulnerable"	  CPU is affected and no mitigation in effect
+		"Mitigation: $M"  CPU is affetcted and mitigation $M is in effect
--- a/drivers/base/Kconfig
+++ b/drivers/base/Kconfig
@@ -193,6 +193,9 @@ config GENERIC_CPU_DEVICES
 config GENERIC_CPU_AUTOPROBE
 	bool
 
+config GENERIC_CPU_VULNERABILITIES
+	bool
+
 config SOC_BUS
 	bool
 
--- a/drivers/base/cpu.c
+++ b/drivers/base/cpu.c
@@ -418,10 +418,58 @@ static void __init cpu_dev_register_gene
 #endif
 }
 
+#ifdef CONFIG_GENERIC_CPU_VULNERABILITIES
+
+ssize_t __weak cpu_show_meltdown(struct device *dev,
+				 struct device_attribute *attr, char *buf)
+{
+	return sprintf(buf, "Not affected\n");
+}
+
+ssize_t __weak cpu_show_spectre_v1(struct device *dev,
+				   struct device_attribute *attr, char *buf)
+{
+	return sprintf(buf, "Not affected\n");
+}
+
+ssize_t __weak cpu_show_spectre_v2(struct device *dev,
+				   struct device_attribute *attr, char *buf)
+{
+	return sprintf(buf, "Not affected\n");
+}
+
+static DEVICE_ATTR(meltdown, 0444, cpu_show_meltdown, NULL);
+static DEVICE_ATTR(spectre_v1, 0444, cpu_show_spectre_v1, NULL);
+static DEVICE_ATTR(spectre_v2, 0444, cpu_show_spectre_v2, NULL);
+
+static struct attribute *cpu_root_vulnerabilities_attrs[] = {
+	&dev_attr_meltdown.attr,
+	&dev_attr_spectre_v1.attr,
+	&dev_attr_spectre_v2.attr,
+	NULL
+};
+
+static const struct attribute_group cpu_root_vulnerabilities_group = {
+	.name  = "vulnerabilities",
+	.attrs = cpu_root_vulnerabilities_attrs,
+};
+
+static void __init cpu_register_vulnerabilities(void)
+{
+	if (sysfs_create_group(&cpu_subsys.dev_root->kobj,
+			       &cpu_root_vulnerabilities_group))
+		pr_err("Unable to register CPU vulnerabilities\n");
+}
+
+#else
+static inline void cpu_register_vulnerabilities(void) { }
+#endif
+
 void __init cpu_dev_init(void)
 {
 	if (subsys_system_register(&cpu_subsys, cpu_root_attr_groups))
 		panic("Failed to register CPU subsystem");
 
 	cpu_dev_register_generic();
+	cpu_register_vulnerabilities();
 }
--- a/include/linux/cpu.h
+++ b/include/linux/cpu.h
@@ -39,6 +39,13 @@ extern void cpu_remove_dev_attr(struct d
 extern int cpu_add_dev_attr_group(struct attribute_group *attrs);
 extern void cpu_remove_dev_attr_group(struct attribute_group *attrs);
 
+extern ssize_t cpu_show_meltdown(struct device *dev,
+				 struct device_attribute *attr, char *buf);
+extern ssize_t cpu_show_spectre_v1(struct device *dev,
+				   struct device_attribute *attr, char *buf);
+extern ssize_t cpu_show_spectre_v2(struct device *dev,
+				   struct device_attribute *attr, char *buf);
+
 #ifdef CONFIG_HOTPLUG_CPU
 extern void unregister_cpu(struct cpu *cpu);
 extern ssize_t arch_cpu_probe(const char *, size_t);
