Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-62429-1526463945-5-1339838298425669579
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES roen,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='de', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526463944; b=ZEb/ZJnLf8WX7EteGqh5KiZLuu4DyWYeznAdruS/gFgvn73JqH
    WLnF+dfny20jlLO5NVTTouhjYFQGFvElBRSg7xD6qIq69A6QQqZMuViM+FxUg/Rn
    whR0q32OOdLbcHTlGWGsPhogdoS11kUS6XNykreVCf7359GzjMnhtFQZpJFz6unq
    qELihtp5HocJLagY6ZA4IKk7iGz5DznW5i2Emz/mlpm/K3tBDhSrwudMEc9AoT2r
    1lXCPhsvTnA7NSSQkDe2cbIsNfBVXoVi01W8+YvmHLeWb2yB2uj5E/JVqnnvc4zm
    2HWu16s7u6UYq5ApBuW5IxoazC1B8YPLQ2wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1526463944; bh=oqMJd
    oUIIVV5C7PK2KFjF1kTjgyRvDR0OK61WKWYfBI=; b=claVQSaqgQlvk/two92uD
    fKdTm6iB3iT/B+hI88/IpjJry0T6pf0KDPzeIEVwVvmIUf0PCpGpgiNCyAg/1hX8
    adynKGTs9G1MrZEiY7Vf2KwlkG2Dw8UYosbeBqI787VJNteEI0hlsMRTsHvFKjmw
    k3kMnbzhkidDcqsspY3k9kIuMstkmB1heC0hBPcXlnTJirr01UIHpO9k5qGBCyzT
    FpJrLaDlcAZKJglORu1M44PaxVcM8Zn7hgtGPxm9Qew3W5XPB4Rcm45RAZiDwp/B
    wMNint06PyCeYZG1JucYvuQkMX+VgFvD2z885cNPC9cX7EpXye0185AF9oDwVx2p
    A==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=infradead.org header.i=@infradead.org header.b=cuZ2lUjG
    x-bits=2048 x-keytype=rsa x-algorithm=sha256
    x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lst.de;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
    smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
    smtp_is_org_domain=yes header.domain=lst.de header.result=pass
    header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=infradead.org header.i=@infradead.org header.b=cuZ2lUjG
      x-bits=2048 x-keytype=rsa x-algorithm=sha256
      x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lst.de;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
      smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
      smtp_is_org_domain=yes header.domain=lst.de header.result=pass
      header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfLnaz0xROPAT09+pOQ04NE7qzYIqPYkqiY01H/T0ruX1g5Cvg/q42FyU0rtDAG81VQ2HNcOI50JqwspSdOi+Rarl1Vf/pi1k6JDAo3qwqBKCkQxr7erv
    jadlGvyxZOzAj0z39rv6JKSxM9acLTNNtqgLVERKEzET8BFKCpZf2Q4GcdwVHchz+k7HAAMc9VgYR3azVeb5eMkFSMv9l+JeMCMJOA2o44kg/gtfABcI0A3B
    wkJldrIU4+jSGbUs+jchEg==
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=kIo7DnY5WRu98hpln7do/g==:117
    a=kIo7DnY5WRu98hpln7do/g==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=QyXUC8HyAAAA:8 a=DDOyTI_5AAAA:8
    a=VZ5YYm9GFCgLQQVbN8oA:9 a=CjuIK1q_8ugA:10 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Christoph Hellwig <hch@lst.de>
To: Andrew Morton <akpm@linux-foundation.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 19/42] acpi/battery: simplify procfs code
Date: Wed, 16 May 2018 11:43:23 +0200
Message-Id: <20180516094346.20506-20-hch@lst.de>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180516094346.20506-1-hch@lst.de>
References: <20180516094346.20506-1-hch@lst.de>
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
