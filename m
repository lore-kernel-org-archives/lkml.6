Return-Path: <ben@decadent.org.uk>
X-Google-Smtp-Source: AG47ELtTfgwIcPLS1SGqCLXeEy3ngv6hpuORb79Lx9+cnG3OhA88dmlI26viMZN8FPAle2TTOlE5
ARC-Seal: i=1; a=rsa-sha256; t=1520824065; cv=none;
        d=google.com; s=arc-20160816;
        b=um+5NuWT++1l/fcUb9AQxscHjrVS11SMG6dAM+Sp2AOKPyHvvYb7yVjiCneH7qrN/Y
         X2E1x3LVdcT1KWAiVT4D9NqiNchIqyAdx/ZyfnvWOKCmq56Bj+/zav2iIULyIZwB4gEO
         azp2omxW/wUba9ovbo3WBB4IZ5UUqMvz0+hMLJTrjTcTwAeT7/2eMverY/J80KOE8LuL
         6VDHvt9NpKVa6uRLoqszdQhRuJGqtXwNiD350FFi0FAMGCIhzkZBjx26IxmMcoRa7sbi
         mVkyyDlJ2vs6mD2NuPQPmTD26V+SIHIB++cIhAySINsCKvGpe1Rj+Nvogg3UvpUqJfqR
         pTVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=in-reply-to:subject:message-id:date:cc:to:from:mime-version
         :content-transfer-encoding:content-disposition
         :arc-authentication-results;
        bh=oMZ3H8yRTAVa/j6nHrSQEvsZ44sjvTfdDZVOaRS9Rqo=;
        b=Vh7U+II5irKxrGQk6ysye4Imzc9oCIP6t91N1qfRI+VDr6/lfp8/6TlyJ/IRl/RJIG
         Cq8OKvPDUrjHuNRh4/0kr3PtcfOopR7eGlrXV/xEHLOpeFiXgd4ikIwFcTyq4j7HG8JH
         YEwcrO+r9yW8OFTMeg7dZF/8b5LsGo83ydD12Y7SUT4IjZi70HmpHWCaNbfa/kUVRgVM
         cZt55XFlRhrWLQ//zu8UlmkBbY55Om54+ME4b+xu7780nv7JS8ql38X8pc6jfG2PA8IN
         JmwDGh0Nmfvi41alVBlftZVhKaDxiz2cm26UvUV27Qb8GrkgmaWgN3PZK+or/EuyIV5j
         XyPg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of ben@decadent.org.uk designates 88.96.1.126 as permitted sender) smtp.mailfrom=ben@decadent.org.uk
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of ben@decadent.org.uk designates 88.96.1.126 as permitted sender) smtp.mailfrom=ben@decadent.org.uk
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
 "David Woodhouse" <dwmw@amazon.co.uk>,
 "Linus Torvalds" <torvalds@linuxfoundation.org>,
 "Peter Zijlstra" <peterz@infradead.org>,
 "Will Deacon" <will.deacon@arm.com>,
 "Borislav Petkov" <bp@alien8.de>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Konrad Rzeszutek Wilk" <konrad.wilk@oracle.com>,
 "Dave Hansen" <dave.hansen@intel.com>,
 "Thomas Gleixner" <tglx@linutronix.de>
Date: Mon, 12 Mar 2018 03:03:34 +0000
Message-ID: <lsq.1520823814.51231615@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 046/104] sysfs/cpu: Add vulnerability folder
In-Reply-To: <lsq.1520823814.606620518@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594699614610491360?=
X-GMAIL-MSGID: =?utf-8?q?1594699614610491360?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.2.101-rc1 review patch.  If anyone has any objections, please let me know.

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
[bwh: Backported to 3.2: CPU device class is a sysdev_class, not a normal device
 class]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 Documentation/ABI/testing/sysfs-devices-system-cpu | 16 ++++++++
 drivers/base/Kconfig                               |  3 ++
 drivers/base/cpu.c                                 | 48 ++++++++++++++++++++++
 include/linux/cpu.h                                |  7 ++++
 4 files changed, 74 insertions(+)

--- a/Documentation/ABI/testing/sysfs-devices-system-cpu
+++ b/Documentation/ABI/testing/sysfs-devices-system-cpu
@@ -201,3 +201,19 @@ Description:	Disable L3 cache indices
 		All AMD processors with L3 caches provide this functionality.
 		For details, see BKDGs at
 		http://developer.amd.com/documentation/guides/Pages/default.aspx
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
@@ -172,6 +172,9 @@ config SYS_HYPERVISOR
 	bool
 	default n
 
+config GENERIC_CPU_VULNERABILITIES
+	bool
+
 source "drivers/base/regmap/Kconfig"
 
 endmenu
--- a/drivers/base/cpu.c
+++ b/drivers/base/cpu.c
@@ -247,6 +247,53 @@ struct sys_device *get_cpu_sysdev(unsign
 }
 EXPORT_SYMBOL_GPL(get_cpu_sysdev);
 
+#ifdef CONFIG_GENERIC_CPU_VULNERABILITIES
+
+ssize_t __weak cpu_show_meltdown(struct sysdev_class *class,
+				 struct sysdev_class_attribute *attr, char *buf)
+{
+	return sprintf(buf, "Not affected\n");
+}
+
+ssize_t __weak cpu_show_spectre_v1(struct sysdev_class *class,
+				   struct sysdev_class_attribute *attr, char *buf)
+{
+	return sprintf(buf, "Not affected\n");
+}
+
+ssize_t __weak cpu_show_spectre_v2(struct sysdev_class *class,
+				   struct sysdev_class_attribute *attr, char *buf)
+{
+	return sprintf(buf, "Not affected\n");
+}
+
+static SYSDEV_CLASS_ATTR(meltdown, 0444, cpu_show_meltdown, NULL);
+static SYSDEV_CLASS_ATTR(spectre_v1, 0444, cpu_show_spectre_v1, NULL);
+static SYSDEV_CLASS_ATTR(spectre_v2, 0444, cpu_show_spectre_v2, NULL);
+
+static struct attribute *cpu_root_vulnerabilities_attrs[] = {
+	&attr_meltdown.attr,
+	&attr_spectre_v1.attr,
+	&attr_spectre_v2.attr,
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
+	if (sysfs_create_group(&cpu_sysdev_class.kset.kobj,
+			       &cpu_root_vulnerabilities_group))
+		pr_err("Unable to register CPU vulnerabilities\n");
+}
+
+#else
+static inline void cpu_register_vulnerabilities(void) { }
+#endif
+
 int __init cpu_dev_init(void)
 {
 	int err;
@@ -256,6 +303,8 @@ int __init cpu_dev_init(void)
 	if (!err)
 		err = sched_create_sysfs_power_savings_entries(&cpu_sysdev_class);
 #endif
+	if (!err)
+		cpu_register_vulnerabilities();
 
 	return err;
 }
--- a/include/linux/cpu.h
+++ b/include/linux/cpu.h
@@ -36,6 +36,13 @@ extern void cpu_remove_sysdev_attr_group
 
 extern int sched_create_sysfs_power_savings_entries(struct sysdev_class *cls);
 
+ssize_t cpu_show_meltdown(struct sysdev_class *class,
+			  struct sysdev_class_attribute *attr, char *buf);
+ssize_t cpu_show_spectre_v1(struct sysdev_class *class,
+			    struct sysdev_class_attribute *attr, char *buf);
+ssize_t cpu_show_spectre_v2(struct sysdev_class *class,
+			    struct sysdev_class_attribute *attr, char *buf);
+
 #ifdef CONFIG_HOTPLUG_CPU
 extern void unregister_cpu(struct cpu *cpu);
 extern ssize_t arch_cpu_probe(const char *, size_t);
