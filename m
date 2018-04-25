Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-900250-1524671433-2-16006937634477160797
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES roen,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='de', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524671432; b=SatNJOLYz2eWaCO7fnGDoTIoTQltC0PGTVH4oNUIDUPwyzlbZI
    KQxm9Ya2GvHROOyQXUdKUK9mB43zd6xsE30FVBLrFL1myTs9Q1jUwwI4PW7AMUp1
    Ft0GYtF5u2tq3soSsrKhYI/byL8heU6wgAA9+SduvIN15xU3Db0B8FcJbVJvKU6B
    9+2d6Ki4zhLN43zEQaa6jyp+gw+ogqoLq7WCRO36E9r79KKtWwCBMcKbo/XVpv2r
    GO8XQJ5GpiSJgRpBccl9prE8mlZXelOLK+ZkaVQJeLyOdRGtWMUBzZyi9dVLKw89
    g4KYpqwN+iUls0/5WadASGWEtaiTSQ9RF4jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1524671432; bh=oqMJd
    oUIIVV5C7PK2KFjF1kTjgyRvDR0OK61WKWYfBI=; b=ugg4KdiwdnyeDqAcX9uDF
    jOZYBozI+Z2wtQ3nf0m4IKUkYKzHXsm1cuhHuQJnf9ba1DcXAMguiKGiZIxPxT7J
    dQCE7WY0yzdd8sADQo3M516IupqGnq5/O7qzs/bt2v4KFY1jAiBOYI8VuLmZKhgP
    rrXoUd+NqiHh9A4jDwskZF6Y3JqrD//cIV+On3wJ85kfbVZPcqe9tAUyZ2iC7K62
    qqQ8QLc6jRzhLArnTWWXf0101rBr8AOWDwhmMad5JUjd+lEeXDOL1hfvifzZwf4X
    Qo3OQki9asC5/Hab92eAR4hWDxYSEW14yznYataunRDDEVwxrgpCGXmCMrrAhL/h
    w==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=D7rP0qJa x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lst.de;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=lst.de header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=D7rP0qJa x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lst.de;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=lst.de header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfHCKtOz8WOPX9s6wtsWBKOAXlMSRSrRKScXpVPhIUtJXMUynmGj3V4m3Zl/wtYKrpF1YX6nFpPOfPopi+r1U7MZuU4xhIOgDWB/UZAXeiDPDdXx33mMx
    Kv7Au9aSIUp/Hl3IzIWWU3CSZUnOmdMrZV9UGQIuSqf+iRk5StVTSByG4LShQE4ex98IBHaEwtROweme99+pZW6J1Jzuw+WGRViXqJ/p4zjiIqoYX8+1ZO0V
    SJOZkW9ztyMgsL5l05i4eA==
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=FmzrR3azffoSx43hyxYGHg==:117
    a=FmzrR3azffoSx43hyxYGHg==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=QyXUC8HyAAAA:8 a=DDOyTI_5AAAA:8
    a=VZ5YYm9GFCgLQQVbN8oA:9 a=CjuIK1q_8ugA:10 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Christoph Hellwig <hch@lst.de>
To: Andrew Morton <akpm@linux-foundation.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 17/40] acpi/battery: simplify procfs code
Date: Wed, 25 Apr 2018 17:48:04 +0200
Message-Id: <20180425154827.32251-18-hch@lst.de>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180425154827.32251-1-hch@lst.de>
References: <20180425154827.32251-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-BeenThere: driverdev-devel@linuxdriverproject.org
X-Mailman-Version: 2.1.24
 <driverdev-devel.linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Cc: linux-rtc@vger.kernel.org, Alessandro Zummo <a.zummo@towertech.it>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>, devel@driverdev.osuosl.org,
 linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
 linux-ide@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 jfs-discussion@lists.sourceforge.net, linux-afs@lists.infradead.org,
 linux-acpi@vger.kernel.org, netdev@vger.kernel.org,
 netfilter-devel@vger.kernel.org, Jiri Slaby <jslaby@suse.com>,
 linux-ext4@vger.kernel.org, Alexey Dobriyan <adobriyan@gmail.com>,
 megaraidlinux.pdl@broadcom.com, drbd-dev@lists.linbit.com
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Use remove_proc_subtree to remove the whole subtree on cleanup, and
unwind the registration loop into individual calls.  Switch to use
proc_create_seq where applicable.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/battery.c | 121 +++++++++--------------------------------
 1 file changed, 26 insertions(+), 95 deletions(-)

diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index bdb24d636d9a..76550689ce10 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -81,14 +81,6 @@ MODULE_PARM_DESC(cache_time, "cache time in milliseconds");
 #ifdef CONFIG_ACPI_PROCFS_POWER
 extern struct proc_dir_entry *acpi_lock_battery_dir(void);
 extern void *acpi_unlock_battery_dir(struct proc_dir_entry *acpi_battery_dir);
-
-enum acpi_battery_files {
-	info_tag = 0,
-	state_tag,
-	alarm_tag,
-	ACPI_BATTERY_NUMFILES,
-};
-
 #endif
 
 static const struct acpi_device_id battery_device_ids[] = {
@@ -985,9 +977,10 @@ static const char *acpi_battery_units(const struct acpi_battery *battery)
 		"mA" : "mW";
 }
 
-static int acpi_battery_print_info(struct seq_file *seq, int result)
+static int acpi_battery_info_proc_show(struct seq_file *seq, void *offset)
 {
 	struct acpi_battery *battery = seq->private;
+	int result = acpi_battery_update(battery, false);
 
 	if (result)
 		goto end;
@@ -1041,9 +1034,10 @@ static int acpi_battery_print_info(struct seq_file *seq, int result)
 	return result;
 }
 
-static int acpi_battery_print_state(struct seq_file *seq, int result)
+static int acpi_battery_state_proc_show(struct seq_file *seq, void *offset)
 {
 	struct acpi_battery *battery = seq->private;
+	int result = acpi_battery_update(battery, false);
 
 	if (result)
 		goto end;
@@ -1088,9 +1082,10 @@ static int acpi_battery_print_state(struct seq_file *seq, int result)
 	return result;
 }
 
-static int acpi_battery_print_alarm(struct seq_file *seq, int result)
+static int acpi_battery_alarm_proc_show(struct seq_file *seq, void *offset)
 {
 	struct acpi_battery *battery = seq->private;
+	int result = acpi_battery_update(battery, false);
 
 	if (result)
 		goto end;
@@ -1142,82 +1137,22 @@ static ssize_t acpi_battery_write_alarm(struct file *file,
 	return result;
 }
 
-typedef int(*print_func)(struct seq_file *seq, int result);
-
-static print_func acpi_print_funcs[ACPI_BATTERY_NUMFILES] = {
-	acpi_battery_print_info,
-	acpi_battery_print_state,
-	acpi_battery_print_alarm,
-};
-
-static int acpi_battery_read(int fid, struct seq_file *seq)
+static int acpi_battery_alarm_proc_open(struct inode *inode, struct file *file)
 {
-	struct acpi_battery *battery = seq->private;
-	int result = acpi_battery_update(battery, false);
-	return acpi_print_funcs[fid](seq, result);
+	return single_open(file, acpi_battery_alarm_proc_show, PDE_DATA(inode));
 }
 
-#define DECLARE_FILE_FUNCTIONS(_name) \
-static int acpi_battery_read_##_name(struct seq_file *seq, void *offset) \
-{ \
-	return acpi_battery_read(_name##_tag, seq); \
-} \
-static int acpi_battery_##_name##_open_fs(struct inode *inode, struct file *file) \
-{ \
-	return single_open(file, acpi_battery_read_##_name, PDE_DATA(inode)); \
-}
-
-DECLARE_FILE_FUNCTIONS(info);
-DECLARE_FILE_FUNCTIONS(state);
-DECLARE_FILE_FUNCTIONS(alarm);
-
-#undef DECLARE_FILE_FUNCTIONS
-
-#define FILE_DESCRIPTION_RO(_name) \
-	{ \
-	.name = __stringify(_name), \
-	.mode = S_IRUGO, \
-	.ops = { \
-		.open = acpi_battery_##_name##_open_fs, \
-		.read = seq_read, \
-		.llseek = seq_lseek, \
-		.release = single_release, \
-		.owner = THIS_MODULE, \
-		}, \
-	}
-
-#define FILE_DESCRIPTION_RW(_name) \
-	{ \
-	.name = __stringify(_name), \
-	.mode = S_IFREG | S_IRUGO | S_IWUSR, \
-	.ops = { \
-		.open = acpi_battery_##_name##_open_fs, \
-		.read = seq_read, \
-		.llseek = seq_lseek, \
-		.write = acpi_battery_write_##_name, \
-		.release = single_release, \
-		.owner = THIS_MODULE, \
-		}, \
-	}
-
-static const struct battery_file {
-	struct file_operations ops;
-	umode_t mode;
-	const char *name;
-} acpi_battery_file[] = {
-	FILE_DESCRIPTION_RO(info),
-	FILE_DESCRIPTION_RO(state),
-	FILE_DESCRIPTION_RW(alarm),
+static const struct file_operations acpi_battery_alarm_fops = {
+	.owner		= THIS_MODULE,
+	.open		= acpi_battery_alarm_proc_open,
+	.read		= seq_read,
+	.write		= acpi_battery_write_alarm,
+	.llseek		= seq_lseek,
+	.release	= single_release,
 };
 
-#undef FILE_DESCRIPTION_RO
-#undef FILE_DESCRIPTION_RW
-
 static int acpi_battery_add_fs(struct acpi_device *device)
 {
-	struct proc_dir_entry *entry = NULL;
-	int i;
-
 	printk(KERN_WARNING PREFIX "Deprecated procfs I/F for battery is loaded,"
 			" please retry with CONFIG_ACPI_PROCFS_POWER cleared\n");
 	if (!acpi_device_dir(device)) {
@@ -1227,28 +1162,24 @@ static int acpi_battery_add_fs(struct acpi_device *device)
 			return -ENODEV;
 	}
 
-	for (i = 0; i < ACPI_BATTERY_NUMFILES; ++i) {
-		entry = proc_create_data(acpi_battery_file[i].name,
-					 acpi_battery_file[i].mode,
-					 acpi_device_dir(device),
-					 &acpi_battery_file[i].ops,
-					 acpi_driver_data(device));
-		if (!entry)
-			return -ENODEV;
-	}
+	if (!proc_create_single_data("info", S_IRUGO, acpi_device_dir(device),
+			acpi_battery_info_proc_show, acpi_driver_data(device)))
+		return -ENODEV;
+	if (!proc_create_single_data("state", S_IRUGO, acpi_device_dir(device),
+			acpi_battery_state_proc_show, acpi_driver_data(device)))
+		return -ENODEV;
+	if (!proc_create_data("alarm", S_IFREG | S_IRUGO | S_IWUSR,
+			acpi_device_dir(device), &acpi_battery_alarm_fops,
+			acpi_driver_data(device)))
+		return -ENODEV;
 	return 0;
 }
 
 static void acpi_battery_remove_fs(struct acpi_device *device)
 {
-	int i;
 	if (!acpi_device_dir(device))
 		return;
-	for (i = 0; i < ACPI_BATTERY_NUMFILES; ++i)
-		remove_proc_entry(acpi_battery_file[i].name,
-				  acpi_device_dir(device));
-
-	remove_proc_entry(acpi_device_bid(device), acpi_battery_dir);
+	remove_proc_subtree(acpi_device_bid(device), acpi_battery_dir);
 	acpi_device_dir(device) = NULL;
 }
 
-- 
2.17.0

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
