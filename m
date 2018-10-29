Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E40A4C6786F
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 03:04:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DD5A2082D
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 03:04:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=steffenvogel.de header.i=@steffenvogel.de header.b="SYvTcf/K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DD5A2082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=steffenvogel.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729239AbeJ2Lv2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 07:51:28 -0400
Received: from nag.0l.de ([207.154.252.120]:44446 "EHLO nag.0l.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729129AbeJ2Lv1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 07:51:27 -0400
From:   Steffen Vogel <post@steffenvogel.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=steffenvogel.de;
        s=2017; t=1540782275;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DX8PPXrEALGb0OuuZFIwd2Cyt1EMbWpIMBGhPBTmcAA=;
        b=SYvTcf/Kz3VumIFldviy2tbnMiHqmofUSFup9/dlzMKWbldC5twwLpbTBLY1nHw8LHM4kI
        x93uUkXB+zXVbKT5hdgnFwUjRn/0LoFcD7uLiqYGlXwTGyFP7K6ngqg8DRIBLwbiKQOXQ9
        ceIHIv6eTDNfXkT0sfIuM7vfmMKv/An+WlyBLfJw8gTllxRN7R94SFsXss74Afa8BKIgHD
        GI07Gjd+m2zeqijpGOa+aIKeg9a2Vqut5UDhrnfZAmI/jj7fkJoIPr8XyTNmI7DU9pbyVr
        f+dlGs/kvqc2BQSNB/K99efTdI7sWGkXazqB5KEmtUvbadW9WNtHbxoORDRTiA==
To:     linux-kernel@vger.kernel.org
Cc:     Evgeniy Polyakov <zbr@ioremap.net>, Joe Perches <joe@perches.com>,
        Steffen Vogel <post@steffenvogel.de>
Subject: [PATCH v2 02/12] w1: improve code-style by adhering tp 80 columns per line limit
Date:   Mon, 29 Oct 2018 04:03:32 +0100
Message-Id: <2478e296182ededd13ee071abe85b3aed63c9cb1.1540782140.git.post@steffenvogel.de>
In-Reply-To: <cover.1540782140.git.post@steffenvogel.de>
References: <cover.1540782140.git.post@steffenvogel.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=steffenvogel.de;
        s=2017; t=1540782275;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DX8PPXrEALGb0OuuZFIwd2Cyt1EMbWpIMBGhPBTmcAA=;
        b=unRmBm4+jAOIfy0SvchOdRrIo/3ycej8EBXpgcJ4hwisdVERhit8PbduAgbQjSA4P/u0qy
        MOvUMmci6vGqfdDmYK3oOIoq0b6a5uGpaYI5NLs2KgB3de42Z25ttdikGoH0SqeBzJE1my
        R4jfyPPNYIoXkMH2KBBhEpxPUMoLkVglvoPzK87JgNw/7ll38qIbL6IXE2HOX314pi46ox
        USabhRezraNCKeF6fy96j3xwE4xLt3ZbdfUUP/TIFXz4vMcrm2ywvZUEQDAKfbxeKsN/ek
        6vob/zApPtKnhEk4kFvu67fCrHj4752CEuQMcrnr7dTjgxyOp6yoLs8FbFlV6A==
ARC-Seal: i=1; s=2017; d=steffenvogel.de; t=1540782275; a=rsa-sha256;
        cv=none;
        b=Zpu1SQfvU7Mr3RF7/3R9BU//Bw0JSXbYzFaQxeSTW+k2/etdSBzp79n649g7ETR4Nx6S+WrvufK9NzbCbjlajBrlMTW0OnjEvf13OID9ehIrYpI5n+uqJicGQHPi6RQ4Ckv8xBuT59obmycBmKVof3tCLQwtkQIzAAtca/AZERles8nNWYwfysF1BXu9QXcHy00u1y61aD+ISECFK5y8MyrNcgRy+60jNggIv9O8L3tqxv6wZvjp2Zp3UYnXNwFkYgdQrCUR+bkkFk0agFvQlrFS0KsWkBu73VeBQI21Lv9Qcf2cSUr9mbvnXr731UhcDm0yTmSEgUtwxHGC5lTarA==
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=stv0g@0l.de smtp.mailfrom=post@steffenvogel.de
Authentication-Results: ORIGINATING;
        auth=pass smtp.auth=stv0g@0l.de smtp.mailfrom=post@steffenvogel.de
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Furthermore indentation of broken lines has been fixed.
This fixes several warnings raised by the checkpatch.pl script.

Signed-off-by: Steffen Vogel <post@steffenvogel.de>
---
 drivers/w1/w1.c         | 160 +++++++++++++++++++++++++++---------------------
 drivers/w1/w1_family.c  |   2 +-
 drivers/w1/w1_int.c     |  15 ++---
 drivers/w1/w1_io.c      |  33 ++++++----
 drivers/w1/w1_netlink.c |  42 ++++++++-----
 5 files changed, 145 insertions(+), 107 deletions(-)

diff --git a/drivers/w1/w1.c b/drivers/w1/w1.c
index 2c64655b603c..6b3cdc5a09fb 100644
--- a/drivers/w1/w1.c
+++ b/drivers/w1/w1.c
@@ -45,13 +45,11 @@ MODULE_PARM_DESC(timeout_us,
  */
 int w1_max_slave_count = 64;
 module_param_named(max_slave_count, w1_max_slave_count, int, 0);
-MODULE_PARM_DESC(max_slave_count,
-	"maximum number of slaves detected in a search");
+MODULE_PARM_DESC(max_slave_count, "maximum number of slaves detected in a search");
 
 int w1_max_slave_ttl = 10;
 module_param_named(slave_ttl, w1_max_slave_ttl, int, 0);
-MODULE_PARM_DESC(slave_ttl,
-	"Number of searches not seeing a slave before it will be removed");
+MODULE_PARM_DESC(slave_ttl, "Number of searches not seeing a slave before it will be removed");
 
 DEFINE_MUTEX(w1_mlock);
 LIST_HEAD(w1_masters);
@@ -85,7 +83,8 @@ static void w1_slave_release(struct device *dev)
 	sl->master->slave_count--;
 }
 
-static ssize_t name_show(struct device *dev, struct device_attribute *attr, char *buf)
+static ssize_t name_show(struct device *dev,
+			 struct device_attribute *attr, char *buf)
 {
 	struct w1_slave *sl = dev_to_w1_slave(dev);
 
@@ -94,7 +93,7 @@ static ssize_t name_show(struct device *dev, struct device_attribute *attr, char
 static DEVICE_ATTR_RO(name);
 
 static ssize_t id_show(struct device *dev,
-	struct device_attribute *attr, char *buf)
+		       struct device_attribute *attr, char *buf)
 {
 	struct w1_slave *sl = dev_to_w1_slave(dev);
 	ssize_t count = sizeof(sl->reg_num);
@@ -203,9 +202,10 @@ struct device w1_slave_device = {
 	.driver = &w1_slave_driver,
 	.release = &w1_slave_release
 };
-#endif  /*  0  */
+#endif
 
-static ssize_t w1_master_attribute_show_name(struct device *dev, struct device_attribute *attr, char *buf)
+static ssize_t w1_master_attribute_show_name(struct device *dev,
+					     struct device_attribute *attr, char *buf)
 {
 	struct w1_master *md = dev_to_w1_master(dev);
 	ssize_t count;
@@ -217,9 +217,9 @@ static ssize_t w1_master_attribute_show_name(struct device *dev, struct device_a
 	return count;
 }
 
-static ssize_t w1_master_attribute_store_search(struct device * dev,
+static ssize_t w1_master_attribute_store_search(struct device *dev,
 						struct device_attribute *attr,
-						const char * buf, size_t count)
+						const char *buf, size_t count)
 {
 	long tmp;
 	struct w1_master *md = dev_to_w1_master(dev);
@@ -286,7 +286,9 @@ static ssize_t w1_master_attribute_show_pullup(struct device *dev,
 	return count;
 }
 
-static ssize_t w1_master_attribute_show_pointer(struct device *dev, struct device_attribute *attr, char *buf)
+static ssize_t w1_master_attribute_show_pointer(struct device *dev,
+						struct device_attribute *attr,
+						char *buf)
 {
 	struct w1_master *md = dev_to_w1_master(dev);
 	ssize_t count;
@@ -297,7 +299,9 @@ static ssize_t w1_master_attribute_show_pointer(struct device *dev, struct devic
 	return count;
 }
 
-static ssize_t w1_master_attribute_show_timeout(struct device *dev, struct device_attribute *attr, char *buf)
+static ssize_t w1_master_attribute_show_timeout(struct device *dev,
+						struct device_attribute *attr,
+						char *buf)
 {
 	ssize_t count;
 	count = sprintf(buf, "%d\n", w1_timeout);
@@ -305,7 +309,8 @@ static ssize_t w1_master_attribute_show_timeout(struct device *dev, struct devic
 }
 
 static ssize_t w1_master_attribute_show_timeout_us(struct device *dev,
-	struct device_attribute *attr, char *buf)
+						   struct device_attribute *attr,
+						   char *buf)
 {
 	ssize_t count;
 	count = sprintf(buf, "%d\n", w1_timeout_us);
@@ -313,7 +318,9 @@ static ssize_t w1_master_attribute_show_timeout_us(struct device *dev,
 }
 
 static ssize_t w1_master_attribute_store_max_slave_count(struct device *dev,
-	struct device_attribute *attr, const char *buf, size_t count)
+							 struct device_attribute *attr,
+							 const char *buf,
+							 size_t count)
 {
 	int tmp;
 	struct w1_master *md = dev_to_w1_master(dev);
@@ -330,7 +337,9 @@ static ssize_t w1_master_attribute_store_max_slave_count(struct device *dev,
 	return count;
 }
 
-static ssize_t w1_master_attribute_show_max_slave_count(struct device *dev, struct device_attribute *attr, char *buf)
+static ssize_t w1_master_attribute_show_max_slave_count(struct device *dev,
+							struct device_attribute *attr,
+							char *buf)
 {
 	struct w1_master *md = dev_to_w1_master(dev);
 	ssize_t count;
@@ -338,10 +347,13 @@ static ssize_t w1_master_attribute_show_max_slave_count(struct device *dev, stru
 	mutex_lock(&md->mutex);
 	count = sprintf(buf, "%d\n", md->max_slave_count);
 	mutex_unlock(&md->mutex);
+
 	return count;
 }
 
-static ssize_t w1_master_attribute_show_attempts(struct device *dev, struct device_attribute *attr, char *buf)
+static ssize_t w1_master_attribute_show_attempts(struct device *dev,
+						 struct device_attribute *attr,
+						 char *buf)
 {
 	struct w1_master *md = dev_to_w1_master(dev);
 	ssize_t count;
@@ -349,10 +361,13 @@ static ssize_t w1_master_attribute_show_attempts(struct device *dev, struct devi
 	mutex_lock(&md->mutex);
 	count = sprintf(buf, "%lu\n", md->attempts);
 	mutex_unlock(&md->mutex);
+
 	return count;
 }
 
-static ssize_t w1_master_attribute_show_slave_count(struct device *dev, struct device_attribute *attr, char *buf)
+static ssize_t w1_master_attribute_show_slave_count(struct device *dev,
+						    struct device_attribute *attr,
+						    char *buf)
 {
 	struct w1_master *md = dev_to_w1_master(dev);
 	ssize_t count;
@@ -364,7 +379,8 @@ static ssize_t w1_master_attribute_show_slave_count(struct device *dev, struct d
 }
 
 static ssize_t w1_master_attribute_show_slaves(struct device *dev,
-	struct device_attribute *attr, char *buf)
+					       struct device_attribute *attr,
+					       char *buf)
 {
 	struct w1_master *md = dev_to_w1_master(dev);
 	int c = PAGE_SIZE;
@@ -387,7 +403,8 @@ static ssize_t w1_master_attribute_show_slaves(struct device *dev,
 }
 
 static ssize_t w1_master_attribute_show_add(struct device *dev,
-	struct device_attribute *attr, char *buf)
+					    struct device_attribute *attr,
+					    char *buf)
 {
 	int c = PAGE_SIZE;
 	c -= snprintf(buf+PAGE_SIZE - c, c,
@@ -396,7 +413,7 @@ static ssize_t w1_master_attribute_show_add(struct device *dev,
 }
 
 static int w1_atoreg_num(struct device *dev, const char *buf, size_t count,
-	struct w1_reg_num *rn)
+			 struct w1_reg_num *rn)
 {
 	unsigned int family;
 	unsigned long long id;
@@ -408,8 +425,7 @@ static int w1_atoreg_num(struct device *dev, const char *buf, size_t count,
 	 * print it either.  It would be unreasonable for the user to then
 	 * provide it.
 	 */
-	const char *error_msg = "bad slave string format, expecting "
-		"ff-dddddddddddd\n";
+	const char *error_msg = "bad slave string format, expecting ff-dddddddddddd\n";
 
 	if (buf[2] != '-') {
 		dev_err(dev, "%s", error_msg);
@@ -428,7 +444,7 @@ static int w1_atoreg_num(struct device *dev, const char *buf, size_t count,
 
 #if 0
 	dev_info(dev, "With CRC device is %02x.%012llx.%02x.\n",
-		  rn->family, (unsigned long long)rn->id, rn->crc);
+		 rn->family, (unsigned long long)rn->id, rn->crc);
 #endif
 
 	return 0;
@@ -438,14 +454,14 @@ static int w1_atoreg_num(struct device *dev, const char *buf, size_t count,
  * Note: must not hold list_mutex
  */
 struct w1_slave *w1_slave_search_device(struct w1_master *dev,
-	struct w1_reg_num *rn)
+					struct w1_reg_num *rn)
 {
 	struct w1_slave *sl;
 	mutex_lock(&dev->list_mutex);
 	list_for_each_entry(sl, &dev->slist, w1_slave_entry) {
 		if (sl->reg_num.family == rn->family &&
-				sl->reg_num.id == rn->id &&
-				sl->reg_num.crc == rn->crc) {
+		    sl->reg_num.id == rn->id &&
+		    sl->reg_num.crc == rn->crc) {
 			mutex_unlock(&dev->list_mutex);
 			return sl;
 		}
@@ -455,8 +471,8 @@ struct w1_slave *w1_slave_search_device(struct w1_master *dev,
 }
 
 static ssize_t w1_master_attribute_store_add(struct device *dev,
-						struct device_attribute *attr,
-						const char *buf, size_t count)
+					     struct device_attribute *attr,
+					     const char *buf, size_t count)
 {
 	struct w1_master *md = dev_to_w1_master(dev);
 	struct w1_reg_num rn;
@@ -484,7 +500,8 @@ static ssize_t w1_master_attribute_store_add(struct device *dev,
 }
 
 static ssize_t w1_master_attribute_show_remove(struct device *dev,
-	struct device_attribute *attr, char *buf)
+					       struct device_attribute *attr,
+					       char *buf)
 {
 	int c = PAGE_SIZE;
 	c -= snprintf(buf+PAGE_SIZE - c, c,
@@ -513,7 +530,7 @@ static ssize_t w1_master_attribute_store_remove(struct device *dev,
 			result = count;
 	} else {
 		dev_info(dev, "Device %02x-%012llx doesn't exists\n", rn.family,
-			(unsigned long long)rn.id);
+			 (unsigned long long)rn.id);
 		result = -EINVAL;
 	}
 	mutex_unlock(&md->mutex);
@@ -596,7 +613,7 @@ static int w1_uevent(struct device *dev, struct kobj_uevent_env *env)
 	}
 
 	dev_dbg(dev, "Hotplug event for %s %s, bus_id=%s.\n",
-			event_owner, name, dev_name(dev));
+		event_owner, name, dev_name(dev));
 
 	if (dev->driver != &w1_slave_driver || !sl)
 		goto end;
@@ -643,11 +660,13 @@ static int w1_family_notify(unsigned long action, struct w1_slave *sl)
 			}
 		}
 		if (IS_REACHABLE(CONFIG_HWMON) && fops->chip_info) {
-			struct device *hwmon
-				= hwmon_device_register_with_info(&sl->dev,
-						"w1_slave_temp", sl,
-						fops->chip_info,
-						NULL);
+			struct device *hwmon =
+				hwmon_device_register_with_info(&sl->dev,
+								"w1_slave_temp",
+								sl,
+								fops->chip_info,
+								NULL);
+
 			if (IS_ERR(hwmon)) {
 				dev_warn(&sl->dev,
 					 "could not create hwmon device\n");
@@ -657,8 +676,7 @@ static int w1_family_notify(unsigned long action, struct w1_slave *sl)
 		}
 		break;
 	case BUS_NOTIFY_DEL_DEVICE:
-		if (IS_REACHABLE(CONFIG_HWMON) && fops->chip_info &&
-			    sl->hwmon)
+		if (IS_REACHABLE(CONFIG_HWMON) && fops->chip_info && sl->hwmon)
 			hwmon_device_unregister(sl->hwmon);
 		if (fops->remove_slave)
 			sl->family->fops->remove_slave(sl);
@@ -682,12 +700,12 @@ static int __w1_attach_slave_device(struct w1_slave *sl)
 						sl->family->of_match_table);
 
 	dev_set_name(&sl->dev, "%02x-%012llx",
-		 (unsigned int) sl->reg_num.family,
-		 (unsigned long long) sl->reg_num.id);
+		     (unsigned int)sl->reg_num.family,
+		     (unsigned long long)sl->reg_num.id);
 	snprintf(&sl->name[0], sizeof(sl->name),
 		 "%02x-%012llx",
-		 (unsigned int) sl->reg_num.family,
-		 (unsigned long long) sl->reg_num.id);
+		 (unsigned int)sl->reg_num.family,
+		 (unsigned long long)sl->reg_num.id);
 
 	dev_dbg(&sl->dev, "%s: registering %s as %p.\n", __func__,
 		dev_name(&sl->dev), sl);
@@ -741,7 +759,7 @@ int w1_attach_slave_device(struct w1_master *dev, struct w1_reg_num *rn)
 	atomic_inc(&sl->master->refcnt);
 	dev->slave_count++;
 	dev_info(&dev->dev, "Attaching one wire slave %02x.%012llx crc %02x\n",
-		  rn->family, (unsigned long long)rn->id, rn->crc);
+		 rn->family, (unsigned long long)rn->id, rn->crc);
 
 	/* slave modules need to be loaded in a context with unlocked mutex */
 	mutex_unlock(&dev->mutex);
@@ -753,8 +771,8 @@ int w1_attach_slave_device(struct w1_master *dev, struct w1_reg_num *rn)
 	if (!f) {
 		f= &w1_default_family;
 		dev_info(&dev->dev, "Family %x for %02x.%012llx.%02x is not registered.\n",
-			  rn->family, rn->family,
-			  (unsigned long long)rn->id, rn->crc);
+			 rn->family, rn->family,
+			 (unsigned long long)rn->id, rn->crc);
 	}
 	__w1_family_get(f);
 	spin_unlock(&w1_flock);
@@ -764,7 +782,7 @@ int w1_attach_slave_device(struct w1_master *dev, struct w1_reg_num *rn)
 	err = __w1_attach_slave_device(sl);
 	if (err < 0) {
 		dev_err(&dev->dev, "%s: Attaching %s failed.\n", __func__,
-			 sl->name);
+			sl->name);
 		dev->slave_count--;
 		w1_family_put(sl->family);
 		atomic_dec(&sl->master->refcnt);
@@ -855,8 +873,8 @@ struct w1_slave *w1_search_slave(struct w1_reg_num *id)
 		mutex_lock(&dev->list_mutex);
 		list_for_each_entry(sl, &dev->slist, w1_slave_entry) {
 			if (sl->reg_num.family == id->family &&
-					sl->reg_num.id == id->id &&
-					sl->reg_num.crc == id->crc) {
+			    sl->reg_num.id == id->id &&
+			    sl->reg_num.crc == id->crc) {
 				found = 1;
 				atomic_inc(&dev->refcnt);
 				atomic_inc(&sl->refcnt);
@@ -880,8 +898,8 @@ void w1_reconnect_slaves(struct w1_family *f, int attach)
 
 	mutex_lock(&w1_mlock);
 	list_for_each_entry(dev, &w1_masters, w1_master_entry) {
-		dev_dbg(&dev->dev, "Reconnecting slaves in device %s "
-			"for family %02x.\n", dev->name, f->fid);
+		dev_dbg(&dev->dev, "Reconnecting slaves in device %s for family %02x.\n",
+			dev->name, f->fid);
 		mutex_lock(&dev->mutex);
 		mutex_lock(&dev->list_mutex);
 		list_for_each_entry_safe(sl, sln, &dev->slist, w1_slave_entry) {
@@ -890,9 +908,9 @@ void w1_reconnect_slaves(struct w1_family *f, int attach)
 			 * connected.  If the family is going away, devices
 			 * matching that family are reconneced.
 			 */
-			if ((attach && sl->family->fid == W1_FAMILY_DEFAULT
-				&& sl->reg_num.family == f->fid) ||
-				(!attach && sl->family->fid == f->fid)) {
+			if ((attach && sl->family->fid == W1_FAMILY_DEFAULT &&
+			     sl->reg_num.family == f->fid) ||
+			     (!attach && sl->family->fid == f->fid)) {
 				struct w1_reg_num rn;
 
 				mutex_unlock(&dev->list_mutex);
@@ -905,8 +923,8 @@ void w1_reconnect_slaves(struct w1_family *f, int attach)
 				mutex_lock(&dev->list_mutex);
 			}
 		}
-		dev_dbg(&dev->dev, "Reconnecting slaves in device %s "
-			"has been finished.\n", dev->name);
+		dev_dbg(&dev->dev, "Reconnecting slaves in device %s has been finished.\n",
+			dev->name);
 		mutex_unlock(&dev->list_mutex);
 		mutex_unlock(&dev->mutex);
 	}
@@ -951,7 +969,8 @@ void w1_slave_found(struct w1_master *dev, u64 rn)
  * See "Application note 187 1-wire search algorithm" at www.maxim-ic.com
  *
  */
-void w1_search(struct w1_master *dev, u8 search_type, w1_slave_found_callback cb)
+void w1_search(struct w1_master *dev, u8 search_type,
+	       w1_slave_found_callback cb)
 {
 	u64 last_rn, rn, tmp64;
 	int i, slave_count = 0;
@@ -1002,9 +1021,15 @@ void w1_search(struct w1_master *dev, u8 search_type, w1_slave_found_callback cb
 		for (i = 0; i < 64; ++i) {
 			/* Determine the direction/search bit */
 			if (i == desc_bit)
-				search_bit = 1;	  /* took the 0 path last time, so take the 1 path */
+				/* took the 0 path last time,
+				 * so take the 1 path
+				 */
+				search_bit = 1;
 			else if (i > desc_bit)
-				search_bit = 0;	  /* take the 0 path on the next branch */
+				/* take the 0 path
+				 * on the next branch
+				 */
+				search_bit = 0;
 			else
 				search_bit = ((last_rn >> i) & 0x1);
 
@@ -1015,7 +1040,7 @@ void w1_search(struct w1_master *dev, u8 search_type, w1_slave_found_callback cb
 			if ( (triplet_ret & 0x03) == 0x03 )
 				break;
 
-			/* If both directions were valid, and we took the 0 path... */
+			/* If both directions were valid, and we took the 0 path */
 			if (triplet_ret == 0)
 				last_zero = i;
 
@@ -1043,7 +1068,7 @@ void w1_search(struct w1_master *dev, u8 search_type, w1_slave_found_callback cb
 		}
 
 		if (!last_device && slave_count == dev->max_slave_count &&
-			!test_bit(W1_WARN_MAX_COUNT, &dev->flags)) {
+		    !test_bit(W1_WARN_MAX_COUNT, &dev->flags)) {
 			/* Only max_slave_count will be scanned in a search,
 			 * but it will start where it left off next search
 			 * until all ids are identified and then it will start
@@ -1051,16 +1076,15 @@ void w1_search(struct w1_master *dev, u8 search_type, w1_slave_found_callback cb
 			 * last id as the first id (provided it is still on the
 			 * bus).
 			 */
-			dev_info(&dev->dev, "%s: max_slave_count %d reached, "
-				"will continue next search.\n", __func__,
-				dev->max_slave_count);
+			dev_info(&dev->dev, "%s: max_slave_count %d reached, will continue next search.\n",
+				__func__, dev->max_slave_count);
 			set_bit(W1_WARN_MAX_COUNT, &dev->flags);
 		}
 	}
 }
 
 void w1_search_process_cb(struct w1_master *dev, u8 search_type,
-	w1_slave_found_callback cb)
+			  w1_slave_found_callback cb)
 {
 	struct w1_slave *sl, *sln;
 
@@ -1108,7 +1132,7 @@ int w1_process_callbacks(struct w1_master *dev)
 	/* The list can be added to in another thread, loop until it is empty */
 	while (!list_empty(&dev->async_list)) {
 		list_for_each_entry_safe(async_cmd, async_n, &dev->async_list,
-			async_entry) {
+					 async_entry) {
 			/* drop the lock, if it is a search it can take a long
 			 * time */
 			mutex_unlock(&dev->list_mutex);
@@ -1192,15 +1216,13 @@ static int __init w1_init(void)
 
 	retval = driver_register(&w1_master_driver);
 	if (retval) {
-		pr_err("Failed to register master driver. err=%d.\n",
-			retval);
+		pr_err("Failed to register master driver. err=%d.\n", retval);
 		goto err_out_bus_unregister;
 	}
 
 	retval = driver_register(&w1_slave_driver);
 	if (retval) {
-		pr_err("Failed to register slave driver. err=%d.\n",
-			retval);
+		pr_err("Failed to register slave driver. err=%d.\n", retval);
 		goto err_out_master_unregister;
 	}
 
diff --git a/drivers/w1/w1_family.c b/drivers/w1/w1_family.c
index ee90a6733472..f351defbef23 100644
--- a/drivers/w1/w1_family.c
+++ b/drivers/w1/w1_family.c
@@ -72,7 +72,7 @@ void w1_unregister_family(struct w1_family *fent)
 
 	while (atomic_read(&fent->refcnt)) {
 		pr_info("Waiting for family %u to become free: refcnt=%d.\n",
-				fent->fid, atomic_read(&fent->refcnt));
+			fent->fid, atomic_read(&fent->refcnt));
 
 		if (msleep_interruptible(1000))
 			flush_signals(current);
diff --git a/drivers/w1/w1_int.c b/drivers/w1/w1_int.c
index 507eea535d43..efe03b9e23f5 100644
--- a/drivers/w1/w1_int.c
+++ b/drivers/w1/w1_int.c
@@ -22,8 +22,8 @@ static int w1_enable_pullup = 1;
 module_param_named(enable_pullup, w1_enable_pullup, int, 0);
 
 static struct w1_master *w1_alloc_dev(u32 id, int slave_count, int slave_ttl,
-				       struct device_driver *driver,
-				       struct device *device)
+				      struct device_driver *driver,
+				      struct device *device)
 {
 	struct w1_master *dev;
 	int err;
@@ -31,7 +31,8 @@ static struct w1_master *w1_alloc_dev(u32 id, int slave_count, int slave_ttl,
 	/*
 	 * We are in process context(kernel thread), so can sleep.
 	 */
-	dev = kzalloc(sizeof(struct w1_master) + sizeof(struct w1_bus_master), GFP_KERNEL);
+	dev = kzalloc(sizeof(struct w1_master) +
+		sizeof(struct w1_bus_master), GFP_KERNEL);
 	if (!dev) {
 		pr_err("Failed to allocate %zd bytes for new w1 device.\n",
 			sizeof(struct w1_master));
@@ -121,7 +122,7 @@ int w1_add_master_device(struct w1_bus_master *master)
 	} while (found);
 
 	dev = w1_alloc_dev(id, w1_max_slave_count, w1_max_slave_ttl,
-		&w1_master_driver, &w1_master_device);
+			   &w1_master_driver, &w1_master_device);
 	if (!dev) {
 		mutex_unlock(&w1_mlock);
 		return -ENOMEM;
@@ -141,8 +142,8 @@ int w1_add_master_device(struct w1_bus_master *master)
 	if (IS_ERR(dev->thread)) {
 		retval = PTR_ERR(dev->thread);
 		dev_err(&dev->dev,
-			 "Failed to create new kernel thread. err=%d\n",
-			 retval);
+			"Failed to create new kernel thread. err=%d\n",
+			retval);
 		mutex_unlock(&w1_mlock);
 		goto err_out_rm_attr;
 	}
@@ -197,7 +198,7 @@ void __w1_remove_master_device(struct w1_master *dev)
 
 	while (atomic_read(&dev->refcnt)) {
 		dev_info(&dev->dev, "Waiting for %s to become free: refcnt=%d.\n",
-				dev->name, atomic_read(&dev->refcnt));
+			 dev->name, atomic_read(&dev->refcnt));
 
 		if (msleep_interruptible(1000))
 			flush_signals(current);
diff --git a/drivers/w1/w1_io.c b/drivers/w1/w1_io.c
index bc7d1f7a1222..caf07bda18d1 100644
--- a/drivers/w1/w1_io.c
+++ b/drivers/w1/w1_io.c
@@ -73,7 +73,8 @@ static void w1_write_bit(struct w1_master *dev, int bit)
 {
 	unsigned long flags = 0;
 
-	if(w1_disable_irqs) local_irq_save(flags);
+	if (w1_disable_irqs)
+		local_irq_save(flags);
 
 	if (bit) {
 		dev->bus_master->write_bit(dev->bus_master->data, 0);
@@ -87,7 +88,8 @@ static void w1_write_bit(struct w1_master *dev, int bit)
 		w1_delay(10);
 	}
 
-	if(w1_disable_irqs) local_irq_restore(flags);
+	if (w1_disable_irqs)
+		local_irq_restore(flags);
 }
 
 /**
@@ -101,9 +103,9 @@ static void w1_write_bit(struct w1_master *dev, int bit)
 static void w1_pre_write(struct w1_master *dev)
 {
 	if (dev->pullup_duration &&
-		dev->enable_pullup && dev->bus_master->set_pullup) {
+	    dev->enable_pullup && dev->bus_master->set_pullup) {
 		dev->bus_master->set_pullup(dev->bus_master->data,
-			dev->pullup_duration);
+					    dev->pullup_duration);
 	}
 }
 
@@ -192,9 +194,10 @@ static u8 w1_read_bit(struct w1_master *dev)
  */
 u8 w1_triplet(struct w1_master *dev, int bdir)
 {
-	if (dev->bus_master->triplet)
-		return dev->bus_master->triplet(dev->bus_master->data, bdir);
-	else {
+	if (dev->bus_master->triplet) {
+		return dev->bus_master->triplet(dev->bus_master->data,
+			bdir);
+	} else {
 		u8 id_bit   = w1_touch_bit(dev, 1);
 		u8 comp_bit = w1_touch_bit(dev, 1);
 		u8 retval;
@@ -298,9 +301,10 @@ u8 w1_read_block(struct w1_master *dev, u8 *buf, int len)
 	int i;
 	u8 ret;
 
-	if (dev->bus_master->read_block)
-		ret = dev->bus_master->read_block(dev->bus_master->data, buf, len);
-	else {
+	if (dev->bus_master->read_block) {
+		ret = dev->bus_master->read_block(dev->bus_master->data,
+			buf, len);
+	} else {
 		for (i = 0; i < len; ++i)
 			buf[i] = w1_read_8(dev);
 		ret = len;
@@ -320,7 +324,8 @@ int w1_reset_bus(struct w1_master *dev)
 	int result;
 	unsigned long flags = 0;
 
-	if(w1_disable_irqs) local_irq_save(flags);
+	if (w1_disable_irqs)
+		local_irq_save(flags);
 
 	if (dev->bus_master->reset_bus)
 		result = dev->bus_master->reset_bus(dev->bus_master->data) & 0x1;
@@ -346,7 +351,8 @@ int w1_reset_bus(struct w1_master *dev)
 		msleep(1);
 	}
 
-	if(w1_disable_irqs) local_irq_restore(flags);
+	if (w1_disable_irqs)
+		local_irq_restore(flags);
 
 	return result;
 }
@@ -363,7 +369,8 @@ u8 w1_calc_crc8(u8 * data, int len)
 }
 EXPORT_SYMBOL_GPL(w1_calc_crc8);
 
-void w1_search_devices(struct w1_master *dev, u8 search_type, w1_slave_found_callback cb)
+void w1_search_devices(struct w1_master *dev, u8 search_type,
+		       w1_slave_found_callback cb)
 {
 	dev->attempts++;
 	if (dev->bus_master->search)
diff --git a/drivers/w1/w1_netlink.c b/drivers/w1/w1_netlink.c
index 0f2c6ed94b0f..7ef46d8ab059 100644
--- a/drivers/w1/w1_netlink.c
+++ b/drivers/w1/w1_netlink.c
@@ -65,7 +65,7 @@ static void w1_unref_block(struct w1_cb_block *block)
 		u16 len = w1_reply_len(block);
 		if (len) {
 			cn_netlink_send_mult(block->first_cn, len,
-				block->portid, 0, GFP_KERNEL);
+					     block->portid, 0, GFP_KERNEL);
 		}
 		kfree(block);
 	}
@@ -82,8 +82,10 @@ static void w1_unref_block(struct w1_cb_block *block)
 static void w1_reply_make_space(struct w1_cb_block *block, u16 space)
 {
 	u16 len = w1_reply_len(block);
+
 	if (len + space >= block->maxlen) {
-		cn_netlink_send_mult(block->first_cn, len, block->portid, 0, GFP_KERNEL);
+		cn_netlink_send_mult(block->first_cn, len,
+				     block->portid, 0, GFP_KERNEL);
 		block->first_cn->len = 0;
 		block->cn = NULL;
 		block->msg = NULL;
@@ -110,7 +112,8 @@ static void w1_netlink_check_send(struct w1_cb_block *block)
 static void w1_netlink_setup_msg(struct w1_cb_block *block, u32 ack)
 {
 	if (block->cn && block->cn->ack == ack) {
-		block->msg = (struct w1_netlink_msg *)(block->cn->data + block->cn->len);
+		block->msg = (struct w1_netlink_msg *)
+			(block->cn->data + block->cn->len);
 	} else {
 		/* advance or set to data */
 		if (block->cn)
@@ -131,7 +134,7 @@ static void w1_netlink_setup_msg(struct w1_cb_block *block, u32 ack)
  * the results.
  */
 static void w1_netlink_queue_cmd(struct w1_cb_block *block,
-	struct w1_netlink_cmd *cmd)
+				 struct w1_netlink_cmd *cmd)
 {
 	u32 space;
 	w1_reply_make_space(block, sizeof(struct cn_msg) +
@@ -158,8 +161,9 @@ static void w1_netlink_queue_cmd(struct w1_cb_block *block,
  * copied.
  */
 static void w1_netlink_queue_status(struct w1_cb_block *block,
-	struct w1_netlink_msg *req_msg, struct w1_netlink_cmd *req_cmd,
-	int error)
+				    struct w1_netlink_msg *req_msg,
+				    struct w1_netlink_cmd *req_cmd,
+				    int error)
 {
 	u16 space = sizeof(struct cn_msg) + sizeof(*req_msg) + sizeof(*req_cmd);
 	w1_reply_make_space(block, space);
@@ -170,7 +174,9 @@ static void w1_netlink_queue_status(struct w1_cb_block *block,
 	block->msg->len = 0;
 	block->msg->status = (u8)-error;
 	if (req_cmd) {
-		struct w1_netlink_cmd *cmd = (struct w1_netlink_cmd *)block->msg->data;
+		struct w1_netlink_cmd *cmd =
+			(struct w1_netlink_cmd *) block->msg->data;
+
 		memcpy(cmd, req_cmd, sizeof(*cmd));
 		block->cn->len += sizeof(*cmd);
 		block->msg->len += sizeof(*cmd);
@@ -189,8 +195,9 @@ static void w1_netlink_queue_status(struct w1_cb_block *block,
  * Use when a block isn't available to queue the message to and cn, msg
  * might not be contiguous.
  */
-static void w1_netlink_send_error(struct cn_msg *cn, struct w1_netlink_msg *msg,
-	int portid, int error)
+static void w1_netlink_send_error(struct cn_msg *cn,
+				  struct w1_netlink_msg *msg,
+				  int portid, int error)
 {
 	struct {
 		struct cn_msg cn;
@@ -286,7 +293,7 @@ static int w1_get_slaves(struct w1_master *dev, struct w1_netlink_cmd *req_cmd)
 }
 
 static int w1_process_command_io(struct w1_master *dev,
-	struct w1_netlink_cmd *cmd)
+				 struct w1_netlink_cmd *cmd)
 {
 	int err = 0;
 
@@ -311,7 +318,7 @@ static int w1_process_command_io(struct w1_master *dev,
 }
 
 static int w1_process_command_addremove(struct w1_master *dev,
-	struct w1_netlink_cmd *cmd)
+					struct w1_netlink_cmd *cmd)
 {
 	struct w1_slave *sl;
 	int err = 0;
@@ -345,7 +352,7 @@ static int w1_process_command_addremove(struct w1_master *dev,
 }
 
 static int w1_process_command_master(struct w1_master *dev,
-	struct w1_netlink_cmd *req_cmd)
+				     struct w1_netlink_cmd *req_cmd)
 {
 	int err = -EINVAL;
 
@@ -385,11 +392,12 @@ static int w1_process_command_master(struct w1_master *dev,
 }
 
 static int w1_process_command_slave(struct w1_slave *sl,
-		struct w1_netlink_cmd *cmd)
+				    struct w1_netlink_cmd *cmd)
 {
 	dev_dbg(&sl->master->dev, "%s: %02x.%012llx.%02x: cmd=%02x, len=%u.\n",
-		__func__, sl->reg_num.family, (unsigned long long)sl->reg_num.id,
-		sl->reg_num.crc, cmd->cmd, cmd->len);
+		__func__, sl->reg_num.family,
+		(unsigned long long) sl->reg_num.id, sl->reg_num.crc, cmd->cmd,
+		cmd->len);
 
 	return w1_process_command_io(sl->master, cmd);
 }
@@ -496,7 +504,7 @@ static void w1_process_cb(struct w1_master *dev, struct w1_async_cmd *async_cmd)
 }
 
 static void w1_list_count_cmds(struct w1_netlink_msg *msg, int *cmd_count,
-	u16 *slave_len)
+			       u16 *slave_len)
 {
 	struct w1_netlink_cmd *cmd = (struct w1_netlink_cmd *)msg->data;
 	u16 mlen = msg->len;
@@ -662,7 +670,7 @@ static void w1_cn_callback(struct cn_msg *cn, struct netlink_skb_parms *nsp)
 				dev = sl->master;
 		} else {
 			pr_notice("%s: cn: %x.%x, wrong type: %u, len: %u.\n",
-				__func__, cn->id.idx, cn->id.val,
+				  __func__, cn->id.idx, cn->id.val,
 				msg->type, msg->len);
 			err = -EPROTO;
 			goto out_cont;
-- 
2.11.0

