Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3970764-1526044774-2-18023637776501406033
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES roen, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526044773; b=S1/mwF3OprySYAFZ85u4IzaadpU2jWUc2LQx63EmnKAGvV8Iad
    7HMDmG+znpKl52T3A7fnQBPeChZptj9NcVGRAPtU5N1hoapMckeXMjnt4ooJ6FSy
    qouk1oOpOz2SoDHh5CUyf49dpWwWaPkeLv1bGLNXFoK056BXJ7qWqWL4qgZNiPub
    xhTknL/kH10BKEK3uUYRjw5NqP3QMsQaJXvPd3N9mopYjHGRgUkwCa53BxDoRpjd
    FZXEe77YhMAFeSUUvU1vtAWgrE9mivk4JCMk2unNJYwf/escywur/MlMsXrYPuDL
    ITPNquKGOmKtwhQozPcLE2qWrpJUhwTa5hhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1526044773; bh=
    c0LuymidwV4xWKv5J7Y5/57PyF/YmN6WclCV1l/BZ1U=; b=mGXBtLqH9K2BHrrm
    mQp4OiW2/DSnR9qs7nyl1/OUtg2ZqxM0ZAtLdudz3y0Wzs9rn/EKDJlyBUQYS/74
    rRgBAD2bNim4r4snn7ZXH6YfpXmX7E+fqvY1eU0pmq4WwKyA9Z5VVidURqWwW0YI
    HJuh4nD8C1ZJ1VcsXoLaWo98lxnQmiqjcbN7SGlWN+55OSp00oKUUOK9ovHBkioN
    wXKW331S4z0+/lkLgaIn2EBbyEj8aZwRKdpNoLQRsnkwjx+ehSS//YtKFvlIdkej
    2f49i4tgFZ+KE5Unlqq/oA8SQg2LsIno0bMuLufs99gkjIBdvss0rT4YpnTJJpL2
    qh6KJA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linux.intel.com header.result=pass
    header_org.domain=intel.com header_org.result=pass
    header_is_org_domain=no;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linux.intel.com header.result=pass
      header_org.domain=intel.com header_org.result=pass
      header_is_org_domain=no;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfNmD4V5Ef/I6yK8YvzfpOHqL1S+EZ4paHm/618hdja4li24mEvvW59YTtg6E/yHxQQwrwykV61Ag4qJF7QMCr7CmDz3lSGvspwJMO8T6X/pn5Sv2SkkH
    0bYLhxumGpu4a9T55Rk39LooELjhOG4Q768GLpJWS9WF+KXg91xZ5yCmned24bLgnJ3RRJY5mGlAIlCwHxe4GV0uWortyrQAMgotSK42+HnnKRktXvi/bGIB
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=QyXUC8HyAAAA:8
    a=VwQbUJbxAAAA:8 a=1UqlgAlDmaZUFq3t2FQA:9 a=z6HfKgcF2zckGAoB:21
    a=hljorpGhmTg2pTMc:21 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753107AbeEKNSt (ORCPT <rfc822;greg@kroah.com>);
        Fri, 11 May 2018 09:18:49 -0400
Received: from mga03.intel.com ([134.134.136.65]:43622 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750758AbeEKNSq (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Fri, 11 May 2018 09:18:46 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,388,1520924400";
   d="scan'208";a="54341736"
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Guenter Roeck <linux@roeck-us.net>,
        Hans de Goede <hdegoede@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jun Li <jun.li@nxp.com>, Mats Karrman <mats.dev.list@gmail.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v3 2/5] usb: typec: Register a device for every mode
Date: Fri, 11 May 2018 16:18:35 +0300
Message-Id: <20180511131838.62064-3-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180511131838.62064-1-heikki.krogerus@linux.intel.com>
References: <20180511131838.62064-1-heikki.krogerus@linux.intel.com>
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Before a device was created for every discovered SVID, but
this will create a device for every discovered mode of every
SVID. The idea is to make it easier to create mode specific
drivers once a bus for the alternate mode is added.

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 drivers/usb/typec/class.c | 172 ++++++++++++--------------------------
 drivers/usb/typec/tcpm.c  |  45 +++++-----
 include/linux/usb/typec.h |  37 ++------
 3 files changed, 83 insertions(+), 171 deletions(-)

diff --git a/drivers/usb/typec/class.c b/drivers/usb/typec/class.c
index 3753950a798d..b8a66babd2cd 100644
--- a/drivers/usb/typec/class.c
+++ b/drivers/usb/typec/class.c
@@ -13,31 +13,20 @@
 #include <linux/usb/typec.h>
 #include <linux/usb/typec_mux.h>
 
-struct typec_mode {
-	int				index;
+struct typec_altmode {
+	struct device			dev;
+	u16				svid;
+	u8				mode;
+
 	u32				vdo;
 	char				*desc;
 	enum typec_port_type		roles;
-
-	struct typec_altmode		*alt_mode;
-
 	unsigned int			active:1;
 
+	struct attribute		*attrs[5];
 	char				group_name[6];
 	struct attribute_group		group;
-	struct attribute		*attrs[5];
-	struct device_attribute		vdo_attr;
-	struct device_attribute		desc_attr;
-	struct device_attribute		active_attr;
-	struct device_attribute		roles_attr;
-};
-
-struct typec_altmode {
-	struct device			dev;
-	u16				svid;
-	int				n_modes;
-	struct typec_mode		modes[ALTMODE_MAX_MODES];
-	const struct attribute_group	*mode_groups[ALTMODE_MAX_MODES];
+	const struct attribute_group	*groups[2];
 };
 
 struct typec_plug {
@@ -177,23 +166,20 @@ static void typec_report_identity(struct device *dev)
 /**
  * typec_altmode_update_active - Report Enter/Exit mode
  * @alt: Handle to the alternate mode
- * @mode: Mode index
  * @active: True when the mode has been entered
  *
  * If a partner or cable plug executes Enter/Exit Mode command successfully, the
  * drivers use this routine to report the updated state of the mode.
  */
-void typec_altmode_update_active(struct typec_altmode *alt, int mode,
-				 bool active)
+void typec_altmode_update_active(struct typec_altmode *alt, bool active)
 {
-	struct typec_mode *m = &alt->modes[mode];
 	char dir[6];
 
-	if (m->active == active)
+	if (alt->active == active)
 		return;
 
-	m->active = active;
-	snprintf(dir, sizeof(dir), "mode%d", mode);
+	alt->active = active;
+	snprintf(dir, sizeof(dir), "mode%d", alt->mode);
 	sysfs_notify(&alt->dev.kobj, dir, "active");
 	kobject_uevent(&alt->dev.kobj, KOBJ_CHANGE);
 }
@@ -220,42 +206,36 @@ struct typec_port *typec_altmode2port(struct typec_altmode *alt)
 EXPORT_SYMBOL_GPL(typec_altmode2port);
 
 static ssize_t
-typec_altmode_vdo_show(struct device *dev, struct device_attribute *attr,
-		       char *buf)
+vdo_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
-	struct typec_mode *mode = container_of(attr, struct typec_mode,
-					       vdo_attr);
+	struct typec_altmode *alt = to_altmode(dev);
 
-	return sprintf(buf, "0x%08x\n", mode->vdo);
+	return sprintf(buf, "0x%08x\n", alt->vdo);
 }
+static DEVICE_ATTR_RO(vdo);
 
 static ssize_t
-typec_altmode_desc_show(struct device *dev, struct device_attribute *attr,
-			char *buf)
+description_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
-	struct typec_mode *mode = container_of(attr, struct typec_mode,
-					       desc_attr);
+	struct typec_altmode *alt = to_altmode(dev);
 
-	return sprintf(buf, "%s\n", mode->desc ? mode->desc : "");
+	return sprintf(buf, "%s\n", alt->desc ? alt->desc : "");
 }
+static DEVICE_ATTR_RO(description);
 
 static ssize_t
-typec_altmode_active_show(struct device *dev, struct device_attribute *attr,
-			  char *buf)
+active_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
-	struct typec_mode *mode = container_of(attr, struct typec_mode,
-					       active_attr);
+	struct typec_altmode *alt = to_altmode(dev);
 
-	return sprintf(buf, "%s\n", mode->active ? "yes" : "no");
+	return sprintf(buf, "%s\n", alt->active ? "yes" : "no");
 }
 
-static ssize_t
-typec_altmode_active_store(struct device *dev, struct device_attribute *attr,
-			   const char *buf, size_t size)
+static ssize_t active_store(struct device *dev, struct device_attribute *attr,
+			    const char *buf, size_t size)
 {
-	struct typec_mode *mode = container_of(attr, struct typec_mode,
-					       active_attr);
-	struct typec_port *port = typec_altmode2port(mode->alt_mode);
+	struct typec_altmode *alt = to_altmode(dev);
+	struct typec_port *port = typec_altmode2port(alt);
 	bool activate;
 	int ret;
 
@@ -266,22 +246,22 @@ typec_altmode_active_store(struct device *dev, struct device_attribute *attr,
 	if (ret)
 		return ret;
 
-	ret = port->cap->activate_mode(port->cap, mode->index, activate);
+	ret = port->cap->activate_mode(port->cap, alt->mode, activate);
 	if (ret)
 		return ret;
 
 	return size;
 }
+static DEVICE_ATTR_RW(active);
 
 static ssize_t
-typec_altmode_roles_show(struct device *dev, struct device_attribute *attr,
-			 char *buf)
+supported_roles_show(struct device *dev, struct device_attribute *attr,
+		     char *buf)
 {
-	struct typec_mode *mode = container_of(attr, struct typec_mode,
-					       roles_attr);
+	struct typec_altmode *alt = to_altmode(dev);
 	ssize_t ret;
 
-	switch (mode->roles) {
+	switch (alt->roles) {
 	case TYPEC_PORT_SRC:
 		ret = sprintf(buf, "source\n");
 		break;
@@ -295,61 +275,13 @@ typec_altmode_roles_show(struct device *dev, struct device_attribute *attr,
 	}
 	return ret;
 }
+static DEVICE_ATTR_RO(supported_roles);
 
-static void typec_init_modes(struct typec_altmode *alt,
-			     const struct typec_mode_desc *desc, bool is_port)
+static void typec_altmode_release(struct device *dev)
 {
-	int i;
-
-	for (i = 0; i < alt->n_modes; i++, desc++) {
-		struct typec_mode *mode = &alt->modes[i];
-
-		/* Not considering the human readable description critical */
-		mode->desc = kstrdup(desc->desc, GFP_KERNEL);
-		if (desc->desc && !mode->desc)
-			dev_err(&alt->dev, "failed to copy mode%d desc\n", i);
-
-		mode->alt_mode = alt;
-		mode->vdo = desc->vdo;
-		mode->roles = desc->roles;
-		mode->index = desc->index;
-		sprintf(mode->group_name, "mode%d", desc->index);
-
-		sysfs_attr_init(&mode->vdo_attr.attr);
-		mode->vdo_attr.attr.name = "vdo";
-		mode->vdo_attr.attr.mode = 0444;
-		mode->vdo_attr.show = typec_altmode_vdo_show;
-
-		sysfs_attr_init(&mode->desc_attr.attr);
-		mode->desc_attr.attr.name = "description";
-		mode->desc_attr.attr.mode = 0444;
-		mode->desc_attr.show = typec_altmode_desc_show;
-
-		sysfs_attr_init(&mode->active_attr.attr);
-		mode->active_attr.attr.name = "active";
-		mode->active_attr.attr.mode = 0644;
-		mode->active_attr.show = typec_altmode_active_show;
-		mode->active_attr.store = typec_altmode_active_store;
-
-		mode->attrs[0] = &mode->vdo_attr.attr;
-		mode->attrs[1] = &mode->desc_attr.attr;
-		mode->attrs[2] = &mode->active_attr.attr;
-
-		/* With ports, list the roles that the mode is supported with */
-		if (is_port) {
-			sysfs_attr_init(&mode->roles_attr.attr);
-			mode->roles_attr.attr.name = "supported_roles";
-			mode->roles_attr.attr.mode = 0444;
-			mode->roles_attr.show = typec_altmode_roles_show;
-
-			mode->attrs[3] = &mode->roles_attr.attr;
-		}
-
-		mode->group.attrs = mode->attrs;
-		mode->group.name = mode->group_name;
+	struct typec_altmode *alt = to_altmode(dev);
 
-		alt->mode_groups[i] = &mode->group;
-	}
+	kfree(alt);
 }
 
 static ssize_t svid_show(struct device *dev, struct device_attribute *attr,
@@ -367,16 +299,6 @@ static struct attribute *typec_altmode_attrs[] = {
 };
 ATTRIBUTE_GROUPS(typec_altmode);
 
-static void typec_altmode_release(struct device *dev)
-{
-	struct typec_altmode *alt = to_altmode(dev);
-	int i;
-
-	for (i = 0; i < alt->n_modes; i++)
-		kfree(alt->modes[i].desc);
-	kfree(alt);
-}
-
 static const struct device_type typec_altmode_dev_type = {
 	.name = "typec_alternate_mode",
 	.groups = typec_altmode_groups,
@@ -395,13 +317,27 @@ typec_register_altmode(struct device *parent,
 		return ERR_PTR(-ENOMEM);
 
 	alt->svid = desc->svid;
-	alt->n_modes = desc->n_modes;
-	typec_init_modes(alt, desc->modes, is_typec_port(parent));
+	alt->mode = desc->mode;
+	alt->vdo = desc->vdo;
+	alt->roles = desc->roles;
+
+	alt->attrs[0] = &dev_attr_vdo.attr;
+	alt->attrs[1] = &dev_attr_description.attr;
+	alt->attrs[2] = &dev_attr_active.attr;
+
+	if (is_typec_port(parent))
+		alt->attrs[3] = &dev_attr_supported_roles.attr;
+
+	sprintf(alt->group_name, "mode%d", desc->mode);
+	alt->group.name = alt->group_name;
+	alt->group.attrs = alt->attrs;
+	alt->groups[0] = &alt->group;
 
 	alt->dev.parent = parent;
-	alt->dev.groups = alt->mode_groups;
+	alt->dev.groups = alt->groups;
 	alt->dev.type = &typec_altmode_dev_type;
-	dev_set_name(&alt->dev, "svid-%04x", alt->svid);
+	dev_set_name(&alt->dev, "%s-%04x:%u", dev_name(parent),
+		     alt->svid, alt->mode);
 
 	ret = device_register(&alt->dev);
 	if (ret) {
diff --git a/drivers/usb/typec/tcpm.c b/drivers/usb/typec/tcpm.c
index 72996cca0fe5..c13b986f9d7b 100644
--- a/drivers/usb/typec/tcpm.c
+++ b/drivers/usb/typec/tcpm.c
@@ -309,8 +309,8 @@ struct tcpm_port {
 
 	/* Alternate mode data */
 	struct pd_mode_data mode_data;
-	struct typec_altmode *partner_altmode[SVID_DISCOVERY_MAX];
-	struct typec_altmode *port_altmode[SVID_DISCOVERY_MAX];
+	struct typec_altmode *partner_altmode[SVID_DISCOVERY_MAX * 6];
+	struct typec_altmode *port_altmode[SVID_DISCOVERY_MAX * 6];
 
 	/* Deadline in jiffies to exit src_try_wait state */
 	unsigned long max_wait;
@@ -998,7 +998,6 @@ static void svdm_consume_modes(struct tcpm_port *port, const __le32 *payload,
 {
 	struct pd_mode_data *pmdata = &port->mode_data;
 	struct typec_altmode_desc *paltmode;
-	struct typec_mode_desc *pmode;
 	int i;
 
 	if (pmdata->altmodes >= ARRAY_SIZE(port->partner_altmode)) {
@@ -1006,32 +1005,28 @@ static void svdm_consume_modes(struct tcpm_port *port, const __le32 *payload,
 		return;
 	}
 
-	paltmode = &pmdata->altmode_desc[pmdata->altmodes];
-	memset(paltmode, 0, sizeof(*paltmode));
+	for (i = 1; i < cnt; i++) {
+		paltmode = &pmdata->altmode_desc[pmdata->altmodes];
+		memset(paltmode, 0, sizeof(*paltmode));
 
-	paltmode->svid = pmdata->svids[pmdata->svid_index];
+		paltmode->svid = pmdata->svids[pmdata->svid_index];
+		paltmode->mode = i;
+		paltmode->vdo = le32_to_cpu(payload[i]);
 
-	tcpm_log(port, " Alternate mode %d: SVID 0x%04x",
-		 pmdata->altmodes, paltmode->svid);
+		tcpm_log(port, " Alternate mode %d: SVID 0x%04x, VDO %d: 0x%08x",
+			 pmdata->altmodes, paltmode->svid,
+			 paltmode->mode, paltmode->vdo);
 
-	for (i = 1; i < cnt && paltmode->n_modes < ALTMODE_MAX_MODES; i++) {
-		pmode = &paltmode->modes[paltmode->n_modes];
-		memset(pmode, 0, sizeof(*pmode));
-		pmode->vdo = le32_to_cpu(payload[i]);
-		pmode->index = i - 1;
-		paltmode->n_modes++;
-		tcpm_log(port, "  VDO %d: 0x%08x",
-			 pmode->index, pmode->vdo);
-	}
-	port->partner_altmode[pmdata->altmodes] =
-		typec_partner_register_altmode(port->partner, paltmode);
-	if (!port->partner_altmode[pmdata->altmodes]) {
-		tcpm_log(port,
-			 "Failed to register alternate modes for SVID 0x%04x",
-			 paltmode->svid);
-		return;
+		port->partner_altmode[pmdata->altmodes] =
+			typec_partner_register_altmode(port->partner, paltmode);
+		if (!port->partner_altmode[pmdata->altmodes]) {
+			tcpm_log(port,
+				 "Failed to register modes for SVID 0x%04x",
+				 paltmode->svid);
+			return;
+		}
+		pmdata->altmodes++;
 	}
-	pmdata->altmodes++;
 }
 
 #define supports_modal(port)	PD_IDH_MODAL_SUPP((port)->partner_ident.id_header)
diff --git a/include/linux/usb/typec.h b/include/linux/usb/typec.h
index 672b39bb0adc..9dbf7f95aa86 100644
--- a/include/linux/usb/typec.h
+++ b/include/linux/usb/typec.h
@@ -93,41 +93,23 @@ int typec_partner_set_identity(struct typec_partner *partner);
 int typec_cable_set_identity(struct typec_cable *cable);
 
 /*
- * struct typec_mode_desc - Individual Mode of an Alternate Mode
- * @index: Index of the Mode within the SVID
+ * struct typec_altmode_desc - USB Type-C Alternate Mode Descriptor
+ * @svid: Standard or Vendor ID
+ * @mode: Index of the Mode
  * @vdo: VDO returned by Discover Modes USB PD command
- * @desc: Optional human readable description of the mode
  * @roles: Only for ports. DRP if the mode is available in both roles
  *
- * Description of a mode of an Alternate Mode which a connector, cable plug or
- * partner supports. Every mode will have it's own sysfs group. The details are
- * the VDO returned by discover modes command, description for the mode and
- * active flag telling has the mode being entered or not.
+ * Description of an Alternate Mode which a connector, cable plug or partner
+ * supports.
  */
-struct typec_mode_desc {
-	int			index;
+struct typec_altmode_desc {
+	u16			svid;
+	u8			mode;
 	u32			vdo;
-	char			*desc;
 	/* Only used with ports */
 	enum typec_port_type	roles;
 };
 
-/*
- * struct typec_altmode_desc - USB Type-C Alternate Mode Descriptor
- * @svid: Standard or Vendor ID
- * @n_modes: Number of modes
- * @modes: Array of modes supported by the Alternate Mode
- *
- * Representation of an Alternate Mode that has SVID assigned by USB-IF. The
- * array of modes will list the modes of a particular SVID that are supported by
- * a connector, partner of a cable plug.
- */
-struct typec_altmode_desc {
-	u16			svid;
-	int			n_modes;
-	struct typec_mode_desc	modes[ALTMODE_MAX_MODES];
-};
-
 struct typec_altmode
 *typec_partner_register_altmode(struct typec_partner *partner,
 				const struct typec_altmode_desc *desc);
@@ -141,8 +123,7 @@ void typec_unregister_altmode(struct typec_altmode *altmode);
 
 struct typec_port *typec_altmode2port(struct typec_altmode *alt);
 
-void typec_altmode_update_active(struct typec_altmode *alt, int mode,
-				 bool active);
+void typec_altmode_update_active(struct typec_altmode *alt, bool active);
 
 enum typec_plug_index {
 	TYPEC_PLUG_SOP_P,
-- 
2.17.0

