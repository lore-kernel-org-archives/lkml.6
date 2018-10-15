Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2499C070C3
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 01:36:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EAEE2086A
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 01:36:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d0Hi7z7L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EAEE2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726594AbeJOJTK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 05:19:10 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:45700 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726186AbeJOJTK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 05:19:10 -0400
Received: by mail-pl1-f196.google.com with SMTP id y15-v6so8452535plr.12;
        Sun, 14 Oct 2018 18:36:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=149Vx0D2W8mjcNCJKL70YPlmOsdKJvPAZQnKIp1X6OQ=;
        b=d0Hi7z7L2oPLOyfir+GZ9ueKFAOJV3K4jOuP7EJgDNAw8bJ2OGU3mbxaOjmRFN4GpM
         MmblDaRpgMK5nXyqz8FxvSM+v+Gck8DoeB1LcpQVnO45ZTm5C/zAuWZlFr4f8L+yPsSR
         htx70FAeZPqNhXiIPyFYQNyV3lwYXWLfHPEWJsrK+gGYdqDw+ttg9VLs3TQQnZrdP/i/
         pMgPMnNPiHfGgE+/zLcNlE4xh9o4a+zCKdljJfzaX1ORcXcjFbizaHZD2tcSJp5oXJrs
         IipgNUgmxhojp4rF4D2E94kuDRUSUvRAj0wOQf+wSOMzYCUgI2tGhpLMb3aVydJH7DDx
         UCKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=149Vx0D2W8mjcNCJKL70YPlmOsdKJvPAZQnKIp1X6OQ=;
        b=Pq2E3CMTj5dnUlvrmwSoW784kOQfgx8f/JA2HpNIbSx8sBf/8Km2uqO8KnzsRJFMaT
         lQpBRY2dvspC7EBeYO+Cv8xqFkH4L1Ud08/KLKGqm3Hu+S4mi1IWGi5FwcjcM7eXoNok
         sFPxVKifa4wP7oG8kEkcRimIZBdj00iwXiBV2+dYcAgK/K63fkzJwWZjg4yjilsAuNY4
         qdOg2EuaYRXxIgt0Omr25KPoa5LOX1vwwQXLuK+rUAJBpuseDYt8uaoAAJmHu84fjuBv
         W6H8Xf1kAKA5l0XVgr+ZYsTCtE6O7LPrBsJokplILJRe7zBYHM08Fgom0BMlzIC5SksW
         CwPA==
X-Gm-Message-State: ABuFfoiiL2F62pW1HJxZ0rS6Kl+MoMpEyrL8hqHAqOOJHzERizrCIX91
        CnwYnNdm26+n8OAlOtELbio=
X-Google-Smtp-Source: ACcGV62iIaVd8HAyKcQO4B289vTJaiW1rBOQOBWOAk4/ml9pQ22yhiTwgyip1nnVjIXzAqdbP80CdA==
X-Received: by 2002:a17:902:930b:: with SMTP id bc11-v6mr15220216plb.101.1539567369882;
        Sun, 14 Oct 2018 18:36:09 -0700 (PDT)
Received: from localhost.localdomain (c-24-6-192-50.hsd1.ca.comcast.net. [24.6.192.50])
        by smtp.gmail.com with ESMTPSA id l2-v6sm9221350pgp.20.2018.10.14.18.36.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 14 Oct 2018 18:36:09 -0700 (PDT)
From:   frowand.list@gmail.com
To:     Rob Herring <robh+dt@kernel.org>, pantelis.antoniou@konsulko.com,
        Pantelis Antoniou <panto@antoniou-consulting.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        geert@linux-m68k.org, Alan Tull <atull@kernel.org>
Subject: [PATCH] of: overlay: user space synchronization
Date:   Sun, 14 Oct 2018 18:34:42 -0700
Message-Id: <1539567282-1326-1-git-send-email-frowand.list@gmail.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frank Rowand <frank.rowand@sony.com>

When an overlay is applied or removed, the live devicetree visible in
/proc/device-tree/, aka /sys/firmware/devicetree/base/, reflects the
changes.  There is no method for user space to determine whether the
live devicetree was modified by overlay actions.

Provide a sysfs file, /sys/firmware/devicetree/tree_version,  to allow
user space to determine if the live devicetree has remained unchanged
while a series of one or more accesses of /proc/device-tree/ occur.

The use of both dynamic devicetree modifications and overlay apply and
removal are not supported during the same boot cycle.  Thus non-overlay
dynamic modifications are not reflected in the value of tree_version.

Example shell use:

	done=1

	while [ $done = 1 ] ; do

		pre_version=$(cat /sys/firmware/devicetree/tree_version)
		version=$pre_version
		while [ $(( ${version} & 1 )) != 0 ] ; do
			# echo is optional, sleep value can be tuned
 			echo "${version}  sleeping"
 			sleep 2;
 			pre_version=$(cat /sys/firmware/devicetree/tree_version)
 			version=${pre_version}
		done

		# 'critical region'
		# access /proc/device-tree/ one or more times

		post_version=$(cat /sys/firmware/devicetree/tree_version)

		if [ ${post_version} = ${pre_version} ] ; then
			done=0
		fi

	done

Signed-off-by: Frank Rowand <frank.rowand@sony.com>
---
 Documentation/ABI/testing/sysfs-firmware-ofw | 64 ++++++++++++++++++++++++---
 drivers/of/base.c                            | 66 ++++++++++++++++++++++++++++
 drivers/of/of_private.h                      |  2 +
 drivers/of/overlay.c                         | 12 +++++
 4 files changed, 137 insertions(+), 7 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-firmware-ofw b/Documentation/ABI/testing/sysfs-firmware-ofw
index edcab3ccfcc0..4111797e8ed5 100644
--- a/Documentation/ABI/testing/sysfs-firmware-ofw
+++ b/Documentation/ABI/testing/sysfs-firmware-ofw
@@ -1,4 +1,10 @@
-What:		/sys/firmware/devicetree/*
+What:		/sys/firmware/devicetree/
+Date:		November 2013
+Contact:	Frank Rowand <frowand.list@gmail.com>, devicetree@vger.kernel.org
+Description:
+		Top level Open Firmware, aka devicetree, sysfs directory.
+
+What:		/sys/firmware/devicetree/base
 Date:		November 2013
 Contact:	Grant Likely <grant.likely@arm.com>, devicetree@vger.kernel.org
 Description:
@@ -6,11 +12,6 @@ Description:
 		hardware, the device tree structure will be exposed in this
 		directory.
 
-		It is possible for multiple device-tree directories to exist.
-		Some device drivers use a separate detached device tree which
-		have no attachment to the system tree and will appear in a
-		different subdirectory under /sys/firmware/devicetree.
-
 		Userspace must not use the /sys/firmware/devicetree/base
 		path directly, but instead should follow /proc/device-tree
 		symlink. It is possible that the absolute path will change
@@ -20,13 +21,62 @@ Description:
 		filesystem support, and has largely the same semantics and
 		should be compatible with existing userspace.
 
-		The contents of /sys/firmware/devicetree/ is a
+		The /sys/firmware/devicetree/base directory is the root
+		node of the devicetree.
+
+		The contents of /sys/firmware/devicetree/base is a
 		hierarchy of directories, one per device tree node. The
 		directory name is the resolved path component name (node
 		name plus address). Properties are represented as files
 		in the directory. The contents of each file is the exact
 		binary data from the device tree.
 
+What:		/sys/firmware/devicetree/tree_version
+Date:		October 2018
+KernelVersion:	4.20
+Contact:	Frank Rowand <frowand.list@gmail.com>, devicetree@vger.kernel.org
+Description:
+		When an overlay is applied or removed, the live devicetree
+		visible in /proc/device-tree/, aka
+		/sys/firmware/devicetree/base/, reflects the changes.
+
+		tree_version provides a way for user space to determine if the
+		live devicetree has remained unchanged while a series of one
+		or more accesses of /proc/device-tree/ occur.
+
+		The use of both dynamic devicetree modifications and overlay
+		apply and removal are not supported during the same boot
+		cycle.  Thus non-overlay dynamic modifications are not
+		reflected in the value of tree_version.
+
+		Example shell use of tree_version:
+
+		done=1
+
+		while [ $done = 1 ] ; do
+
+		   pre_version=$(cat /sys/firmware/devicetree/tree_version)
+		   version=$pre_version
+		   while [ $(( ${version} & 1 )) != 0 ] ; do
+		      # echo is optional, sleep value can be tuned
+		      echo "${version}  sleeping"
+		      sleep 2;
+		      pre_version=$(cat /sys/firmware/devicetree/tree_version)
+		      version=${pre_version}
+		   done
+
+		   # 'critical region'
+		   # access /proc/device-tree/ one or more times
+
+		   post_version=$(cat /sys/firmware/devicetree/tree_version)
+
+		   if [ ${post_version} = ${pre_version} ] ; then
+		      done=0
+		   fi
+
+		done
+
+
 What:		/sys/firmware/fdt
 Date:		February 2015
 KernelVersion:	3.19
diff --git a/drivers/of/base.c b/drivers/of/base.c
index 466e3c8582f0..ec0428e47577 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -151,9 +151,71 @@ int of_free_phandle_cache(void)
 late_initcall_sync(of_free_phandle_cache);
 #endif
 
+#define show_one(object)						\
+	static ssize_t show_##object					\
+	(struct kobject *kobj, struct attribute *attr, char *buf)	\
+	{								\
+		return sprintf(buf, "%u\n", object);			\
+	}
+
+struct global_attr {
+	struct attribute attr;
+	ssize_t (*show)(struct kobject *kobj,
+			struct attribute *attr, char *buf);
+	ssize_t (*store)(struct kobject *a, struct attribute *b,
+			 const char *c, size_t count);
+};
+
+#define define_one_global_ro(_name)		\
+static struct global_attr attr_##_name =	\
+__ATTR(_name, 0444, show_##_name, NULL)
+
+/*
+ * tree_version must be unsigned so that at maximum value it wraps
+ * from an odd value (4294967295) to an even value (0).
+ */
+static u32 tree_version;
+
+show_one(tree_version);
+
+define_one_global_ro(tree_version);
+
+static struct attribute *of_attributes[] = {
+	&attr_tree_version.attr,
+	NULL
+};
+
+static const struct attribute_group of_attr_group = {
+	.attrs = of_attributes,
+};
+
+/*
+ * internal documentation
+ * tree_version_increment() - increment base version
+ *
+ * Before starting overlay apply or overlay remove, call this function.
+ * After completing overlay apply or overlay remove, call this function.
+ *
+ * caller must hold of_mutex
+ *
+ * Userspace can use the value of this variable to determine whether the
+ * devicetree has changed while accessing the devicetree.  An odd value
+ * means a modification is underway.  An even value means no modification
+ * is underway.
+ *
+ * The use of both (1) dynamic devicetree modifications and (2) overlay apply
+ * and removal are not supported during the same boot cycle.  Thus non-overlay
+ * dynamic modifications are not reflected in the value of tree_version.
+ */
+void tree_version_increment(void)
+{
+	tree_version++;
+}
+
 void __init of_core_init(void)
 {
 	struct device_node *np;
+	int ret;
 
 	of_populate_phandle_cache();
 
@@ -172,6 +234,10 @@ void __init of_core_init(void)
 	/* Symlink in /proc as required by userspace ABI */
 	if (of_root)
 		proc_symlink("device-tree", NULL, "/sys/firmware/devicetree/base");
+
+	ret = sysfs_create_group(&of_kset->kobj, &of_attr_group);
+	if (ret)
+		pr_err("sysfs_create_group of_attr_group failed: %d\n", ret);
 }
 
 static struct property *__of_find_property(const struct device_node *np,
diff --git a/drivers/of/of_private.h b/drivers/of/of_private.h
index 216175d11d3d..adf89f6bad81 100644
--- a/drivers/of/of_private.h
+++ b/drivers/of/of_private.h
@@ -31,6 +31,8 @@ struct alias_prop {
 extern struct list_head aliases_lookup;
 extern struct kset *of_kset;
 
+void tree_version_increment(void);
+
 #if defined(CONFIG_OF_DYNAMIC)
 extern int of_property_notify(int action, struct device_node *np,
 			      struct property *prop, struct property *old_prop);
diff --git a/drivers/of/overlay.c b/drivers/of/overlay.c
index eda57ef12fd0..53b1810b1e03 100644
--- a/drivers/of/overlay.c
+++ b/drivers/of/overlay.c
@@ -770,6 +770,9 @@ static int of_overlay_apply(const void *fdt, struct device_node *tree,
 	of_overlay_mutex_lock();
 	mutex_lock(&of_mutex);
 
+	/* live tree may change after this point, user space synchronization */
+	tree_version_increment();
+
 	ret = of_resolve_phandles(tree);
 	if (ret)
 		goto err_free_tree;
@@ -832,6 +835,9 @@ static int of_overlay_apply(const void *fdt, struct device_node *tree,
 	free_overlay_changeset(ovcs);
 
 out_unlock:
+	/* live tree change complete, user space synchronization */
+	tree_version_increment();
+
 	mutex_unlock(&of_mutex);
 	of_overlay_mutex_unlock();
 
@@ -1028,6 +1034,9 @@ int of_overlay_remove(int *ovcs_id)
 
 	mutex_lock(&of_mutex);
 
+	/* live tree may change after this point, user space synchronization */
+	tree_version_increment();
+
 	ovcs = idr_find(&ovcs_idr, *ovcs_id);
 	if (!ovcs) {
 		ret = -ENODEV;
@@ -1083,6 +1092,9 @@ int of_overlay_remove(int *ovcs_id)
 	free_overlay_changeset(ovcs);
 
 out_unlock:
+	/* live tree change complete, user space synchronization */
+	tree_version_increment();
+
 	mutex_unlock(&of_mutex);
 
 out:
-- 
Frank Rowand <frank.rowand@sony.com>

