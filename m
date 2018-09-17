Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52B17ECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 18:16:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD3C4214EE
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 18:16:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xpzyg0q5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD3C4214EE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728409AbeIQXol (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 19:44:41 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:35992 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727375AbeIQXok (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 19:44:40 -0400
Received: by mail-pg1-f193.google.com with SMTP id d1-v6so8058982pgo.3;
        Mon, 17 Sep 2018 11:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=d3fIP0OMtgTjhkPYLUxyTxunfUZOBZasBX82KtlY6aY=;
        b=Xpzyg0q5COUrFAz3refnOhFQG3PSsxhDQvq5VYGY1sw8L36O3kSW8diK+aVnBFurha
         0euYR05HvKlZuAyY0Vo6Wt0Saidl6fND9WNQWrmzT7U94cy7iv4+Mlx7ELwQq1pi1iyy
         uZmnykj+HtSUTzi6vVvlCHrc18Z/aHGAZ7aEHc9DezmntCV9aYYasDkWiDx0tR6DV5vR
         g1XDWMnrxsM0IZ56HlCSl9mysQSBEMyo6GTjHujdYogcYvI7sfxBn5qobr6oTs/VmYPM
         EIae5Q8w2S0FtH8tVUrRGkhcj3RsrAlPZKbkBcoyEVco4xnRd8JuCEKUUkwXsAx+nXC+
         hqvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=d3fIP0OMtgTjhkPYLUxyTxunfUZOBZasBX82KtlY6aY=;
        b=hLnAuwInpPOx41glnO0ViB3DIh5Ikh3olEDAYKAA0ntAP2ugpRnH9wPnfT2ddP4HxA
         /tV3e3wpjKg9/LH75gaMunt4ISXUEjl1wLhJk6D2IWrp+0PJPB9jZN5xRqAQ1EykpZHZ
         it3+1LNeBc0tj2pQYNsqKqrM0OMCKOPPGa9KTIy65aRJ6iiVU6RoZqche1HexOOQqGHS
         Oa/J+eRUW3hcqbvyNEIVm63iIRM5QRCIc9hsIuDdTpgjkFNdDvqZfFqrW/1kiOjTVR9D
         zgjLYlipED+k+CkhS4Wmyscxdaq4hxJG+7g4F/LuJffUewQ50BtG+of1ol4PW3oSoCr+
         O4Qg==
X-Gm-Message-State: APzg51CkSCglgA4/GOBgCYNg+/E2H6iUyoexjs6/j9S2weC0g1qaFDYU
        slrVQ3xzv/CcWHNMjTII6Bc=
X-Google-Smtp-Source: ANB0VdYHh/i3AlkXhPshV2gFml2RGL8TK6UGyIB/FFfx4F4FPsIT9bFFmvvxUGzEWRx2PBcN/S1+Qg==
X-Received: by 2002:a62:4898:: with SMTP id q24-v6mr27357439pfi.22.1537208168904;
        Mon, 17 Sep 2018 11:16:08 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id 74-v6sm24076366pfv.33.2018.09.17.11.16.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Sep 2018 11:16:07 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Cc:     linux-input@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [RFC/PATCH 1/5] device property: split generic properties and property sets
Date:   Mon, 17 Sep 2018 11:15:59 -0700
Message-Id: <20180917181603.125492-2-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.19.0.397.gdd90340f6a-goog
In-Reply-To: <20180917181603.125492-1-dmitry.torokhov@gmail.com>
References: <20180917181603.125492-1-dmitry.torokhov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/base/property.c became a bit of a kitchen sink, with code handling
generic device/fwnode properties intermingled with code handling static
properties (pset). Let's split them apart to not pollute each other.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/base/Makefile        |   4 +-
 drivers/base/property.c      | 525 ----------------------------------
 drivers/base/pset_property.c | 540 +++++++++++++++++++++++++++++++++++
 3 files changed, 542 insertions(+), 527 deletions(-)
 create mode 100644 drivers/base/pset_property.c

diff --git a/drivers/base/Makefile b/drivers/base/Makefile
index 704f44295810..5f72cd5ab8ba 100644
--- a/drivers/base/Makefile
+++ b/drivers/base/Makefile
@@ -5,8 +5,8 @@ obj-y			:= component.o core.o bus.o dd.o syscore.o \
 			   driver.o class.o platform.o \
 			   cpu.o firmware.o init.o map.o devres.o \
 			   attribute_container.o transport_class.o \
-			   topology.o container.o property.o cacheinfo.o \
-			   devcon.o
+			   topology.o container.o cacheinfo.o \
+			   property.o pset_property.o devcon.o
 obj-$(CONFIG_DEVTMPFS)	+= devtmpfs.o
 obj-y			+= power/
 obj-$(CONFIG_ISA_BUS_API)	+= isa.o
diff --git a/drivers/base/property.c b/drivers/base/property.c
index 240ab5230ff6..d57df94e396c 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -18,236 +18,6 @@
 #include <linux/etherdevice.h>
 #include <linux/phy.h>
 
-struct property_set {
-	struct device *dev;
-	struct fwnode_handle fwnode;
-	const struct property_entry *properties;
-};
-
-static const struct fwnode_operations pset_fwnode_ops;
-
-static inline bool is_pset_node(const struct fwnode_handle *fwnode)
-{
-	return !IS_ERR_OR_NULL(fwnode) && fwnode->ops == &pset_fwnode_ops;
-}
-
-#define to_pset_node(__fwnode)						\
-	({								\
-		typeof(__fwnode) __to_pset_node_fwnode = __fwnode;	\
-									\
-		is_pset_node(__to_pset_node_fwnode) ?			\
-			container_of(__to_pset_node_fwnode,		\
-				     struct property_set, fwnode) :	\
-			NULL;						\
-	})
-
-static const struct property_entry *
-pset_prop_get(const struct property_set *pset, const char *name)
-{
-	const struct property_entry *prop;
-
-	if (!pset || !pset->properties)
-		return NULL;
-
-	for (prop = pset->properties; prop->name; prop++)
-		if (!strcmp(name, prop->name))
-			return prop;
-
-	return NULL;
-}
-
-static const void *property_get_pointer(const struct property_entry *prop)
-{
-	switch (prop->type) {
-	case DEV_PROP_U8:
-		if (prop->is_array)
-			return prop->pointer.u8_data;
-		return &prop->value.u8_data;
-	case DEV_PROP_U16:
-		if (prop->is_array)
-			return prop->pointer.u16_data;
-		return &prop->value.u16_data;
-	case DEV_PROP_U32:
-		if (prop->is_array)
-			return prop->pointer.u32_data;
-		return &prop->value.u32_data;
-	case DEV_PROP_U64:
-		if (prop->is_array)
-			return prop->pointer.u64_data;
-		return &prop->value.u64_data;
-	case DEV_PROP_STRING:
-		if (prop->is_array)
-			return prop->pointer.str;
-		return &prop->value.str;
-	default:
-		return NULL;
-	}
-}
-
-static void property_set_pointer(struct property_entry *prop, const void *pointer)
-{
-	switch (prop->type) {
-	case DEV_PROP_U8:
-		if (prop->is_array)
-			prop->pointer.u8_data = pointer;
-		else
-			prop->value.u8_data = *((u8 *)pointer);
-		break;
-	case DEV_PROP_U16:
-		if (prop->is_array)
-			prop->pointer.u16_data = pointer;
-		else
-			prop->value.u16_data = *((u16 *)pointer);
-		break;
-	case DEV_PROP_U32:
-		if (prop->is_array)
-			prop->pointer.u32_data = pointer;
-		else
-			prop->value.u32_data = *((u32 *)pointer);
-		break;
-	case DEV_PROP_U64:
-		if (prop->is_array)
-			prop->pointer.u64_data = pointer;
-		else
-			prop->value.u64_data = *((u64 *)pointer);
-		break;
-	case DEV_PROP_STRING:
-		if (prop->is_array)
-			prop->pointer.str = pointer;
-		else
-			prop->value.str = pointer;
-		break;
-	default:
-		break;
-	}
-}
-
-static const void *pset_prop_find(const struct property_set *pset,
-				  const char *propname, size_t length)
-{
-	const struct property_entry *prop;
-	const void *pointer;
-
-	prop = pset_prop_get(pset, propname);
-	if (!prop)
-		return ERR_PTR(-EINVAL);
-	pointer = property_get_pointer(prop);
-	if (!pointer)
-		return ERR_PTR(-ENODATA);
-	if (length > prop->length)
-		return ERR_PTR(-EOVERFLOW);
-	return pointer;
-}
-
-static int pset_prop_read_u8_array(const struct property_set *pset,
-				   const char *propname,
-				   u8 *values, size_t nval)
-{
-	const void *pointer;
-	size_t length = nval * sizeof(*values);
-
-	pointer = pset_prop_find(pset, propname, length);
-	if (IS_ERR(pointer))
-		return PTR_ERR(pointer);
-
-	memcpy(values, pointer, length);
-	return 0;
-}
-
-static int pset_prop_read_u16_array(const struct property_set *pset,
-				    const char *propname,
-				    u16 *values, size_t nval)
-{
-	const void *pointer;
-	size_t length = nval * sizeof(*values);
-
-	pointer = pset_prop_find(pset, propname, length);
-	if (IS_ERR(pointer))
-		return PTR_ERR(pointer);
-
-	memcpy(values, pointer, length);
-	return 0;
-}
-
-static int pset_prop_read_u32_array(const struct property_set *pset,
-				    const char *propname,
-				    u32 *values, size_t nval)
-{
-	const void *pointer;
-	size_t length = nval * sizeof(*values);
-
-	pointer = pset_prop_find(pset, propname, length);
-	if (IS_ERR(pointer))
-		return PTR_ERR(pointer);
-
-	memcpy(values, pointer, length);
-	return 0;
-}
-
-static int pset_prop_read_u64_array(const struct property_set *pset,
-				    const char *propname,
-				    u64 *values, size_t nval)
-{
-	const void *pointer;
-	size_t length = nval * sizeof(*values);
-
-	pointer = pset_prop_find(pset, propname, length);
-	if (IS_ERR(pointer))
-		return PTR_ERR(pointer);
-
-	memcpy(values, pointer, length);
-	return 0;
-}
-
-static int pset_prop_count_elems_of_size(const struct property_set *pset,
-					 const char *propname, size_t length)
-{
-	const struct property_entry *prop;
-
-	prop = pset_prop_get(pset, propname);
-	if (!prop)
-		return -EINVAL;
-
-	return prop->length / length;
-}
-
-static int pset_prop_read_string_array(const struct property_set *pset,
-				       const char *propname,
-				       const char **strings, size_t nval)
-{
-	const struct property_entry *prop;
-	const void *pointer;
-	size_t array_len, length;
-
-	/* Find out the array length. */
-	prop = pset_prop_get(pset, propname);
-	if (!prop)
-		return -EINVAL;
-
-	if (!prop->is_array)
-		/* The array length for a non-array string property is 1. */
-		array_len = 1;
-	else
-		/* Find the length of an array. */
-		array_len = pset_prop_count_elems_of_size(pset, propname,
-							  sizeof(const char *));
-
-	/* Return how many there are if strings is NULL. */
-	if (!strings)
-		return array_len;
-
-	array_len = min(nval, array_len);
-	length = array_len * sizeof(*strings);
-
-	pointer = pset_prop_find(pset, propname, length);
-	if (IS_ERR(pointer))
-		return PTR_ERR(pointer);
-
-	memcpy(strings, pointer, length);
-
-	return array_len;
-}
-
 struct fwnode_handle *dev_fwnode(struct device *dev)
 {
 	return IS_ENABLED(CONFIG_OF) && dev->of_node ?
@@ -255,51 +25,6 @@ struct fwnode_handle *dev_fwnode(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(dev_fwnode);
 
-static bool pset_fwnode_property_present(const struct fwnode_handle *fwnode,
-					 const char *propname)
-{
-	return !!pset_prop_get(to_pset_node(fwnode), propname);
-}
-
-static int pset_fwnode_read_int_array(const struct fwnode_handle *fwnode,
-				      const char *propname,
-				      unsigned int elem_size, void *val,
-				      size_t nval)
-{
-	const struct property_set *node = to_pset_node(fwnode);
-
-	if (!val)
-		return pset_prop_count_elems_of_size(node, propname, elem_size);
-
-	switch (elem_size) {
-	case sizeof(u8):
-		return pset_prop_read_u8_array(node, propname, val, nval);
-	case sizeof(u16):
-		return pset_prop_read_u16_array(node, propname, val, nval);
-	case sizeof(u32):
-		return pset_prop_read_u32_array(node, propname, val, nval);
-	case sizeof(u64):
-		return pset_prop_read_u64_array(node, propname, val, nval);
-	}
-
-	return -ENXIO;
-}
-
-static int
-pset_fwnode_property_read_string_array(const struct fwnode_handle *fwnode,
-				       const char *propname,
-				       const char **val, size_t nval)
-{
-	return pset_prop_read_string_array(to_pset_node(fwnode), propname,
-					   val, nval);
-}
-
-static const struct fwnode_operations pset_fwnode_ops = {
-	.property_present = pset_fwnode_property_present,
-	.property_read_int_array = pset_fwnode_read_int_array,
-	.property_read_string_array = pset_fwnode_property_read_string_array,
-};
-
 /**
  * device_property_present - check if a property of a device is present
  * @dev: Device whose property is being checked
@@ -759,256 +484,6 @@ int fwnode_property_get_reference_args(const struct fwnode_handle *fwnode,
 }
 EXPORT_SYMBOL_GPL(fwnode_property_get_reference_args);
 
-static void property_entry_free_data(const struct property_entry *p)
-{
-	const void *pointer = property_get_pointer(p);
-	size_t i, nval;
-
-	if (p->is_array) {
-		if (p->type == DEV_PROP_STRING && p->pointer.str) {
-			nval = p->length / sizeof(const char *);
-			for (i = 0; i < nval; i++)
-				kfree(p->pointer.str[i]);
-		}
-		kfree(pointer);
-	} else if (p->type == DEV_PROP_STRING) {
-		kfree(p->value.str);
-	}
-	kfree(p->name);
-}
-
-static int property_copy_string_array(struct property_entry *dst,
-				      const struct property_entry *src)
-{
-	const char **d;
-	size_t nval = src->length / sizeof(*d);
-	int i;
-
-	d = kcalloc(nval, sizeof(*d), GFP_KERNEL);
-	if (!d)
-		return -ENOMEM;
-
-	for (i = 0; i < nval; i++) {
-		d[i] = kstrdup(src->pointer.str[i], GFP_KERNEL);
-		if (!d[i] && src->pointer.str[i]) {
-			while (--i >= 0)
-				kfree(d[i]);
-			kfree(d);
-			return -ENOMEM;
-		}
-	}
-
-	dst->pointer.str = d;
-	return 0;
-}
-
-static int property_entry_copy_data(struct property_entry *dst,
-				    const struct property_entry *src)
-{
-	const void *pointer = property_get_pointer(src);
-	const void *new;
-	int error;
-
-	if (src->is_array) {
-		if (!src->length)
-			return -ENODATA;
-
-		if (src->type == DEV_PROP_STRING) {
-			error = property_copy_string_array(dst, src);
-			if (error)
-				return error;
-			new = dst->pointer.str;
-		} else {
-			new = kmemdup(pointer, src->length, GFP_KERNEL);
-			if (!new)
-				return -ENOMEM;
-		}
-	} else if (src->type == DEV_PROP_STRING) {
-		new = kstrdup(src->value.str, GFP_KERNEL);
-		if (!new && src->value.str)
-			return -ENOMEM;
-	} else {
-		new = pointer;
-	}
-
-	dst->length = src->length;
-	dst->is_array = src->is_array;
-	dst->type = src->type;
-
-	property_set_pointer(dst, new);
-
-	dst->name = kstrdup(src->name, GFP_KERNEL);
-	if (!dst->name)
-		goto out_free_data;
-
-	return 0;
-
-out_free_data:
-	property_entry_free_data(dst);
-	return -ENOMEM;
-}
-
-/**
- * property_entries_dup - duplicate array of properties
- * @properties: array of properties to copy
- *
- * This function creates a deep copy of the given NULL-terminated array
- * of property entries.
- */
-struct property_entry *
-property_entries_dup(const struct property_entry *properties)
-{
-	struct property_entry *p;
-	int i, n = 0;
-
-	while (properties[n].name)
-		n++;
-
-	p = kcalloc(n + 1, sizeof(*p), GFP_KERNEL);
-	if (!p)
-		return ERR_PTR(-ENOMEM);
-
-	for (i = 0; i < n; i++) {
-		int ret = property_entry_copy_data(&p[i], &properties[i]);
-		if (ret) {
-			while (--i >= 0)
-				property_entry_free_data(&p[i]);
-			kfree(p);
-			return ERR_PTR(ret);
-		}
-	}
-
-	return p;
-}
-EXPORT_SYMBOL_GPL(property_entries_dup);
-
-/**
- * property_entries_free - free previously allocated array of properties
- * @properties: array of properties to destroy
- *
- * This function frees given NULL-terminated array of property entries,
- * along with their data.
- */
-void property_entries_free(const struct property_entry *properties)
-{
-	const struct property_entry *p;
-
-	for (p = properties; p->name; p++)
-		property_entry_free_data(p);
-
-	kfree(properties);
-}
-EXPORT_SYMBOL_GPL(property_entries_free);
-
-/**
- * pset_free_set - releases memory allocated for copied property set
- * @pset: Property set to release
- *
- * Function takes previously copied property set and releases all the
- * memory allocated to it.
- */
-static void pset_free_set(struct property_set *pset)
-{
-	if (!pset)
-		return;
-
-	property_entries_free(pset->properties);
-	kfree(pset);
-}
-
-/**
- * pset_copy_set - copies property set
- * @pset: Property set to copy
- *
- * This function takes a deep copy of the given property set and returns
- * pointer to the copy. Call device_free_property_set() to free resources
- * allocated in this function.
- *
- * Return: Pointer to the new property set or error pointer.
- */
-static struct property_set *pset_copy_set(const struct property_set *pset)
-{
-	struct property_entry *properties;
-	struct property_set *p;
-
-	p = kzalloc(sizeof(*p), GFP_KERNEL);
-	if (!p)
-		return ERR_PTR(-ENOMEM);
-
-	properties = property_entries_dup(pset->properties);
-	if (IS_ERR(properties)) {
-		kfree(p);
-		return ERR_CAST(properties);
-	}
-
-	p->properties = properties;
-	return p;
-}
-
-/**
- * device_remove_properties - Remove properties from a device object.
- * @dev: Device whose properties to remove.
- *
- * The function removes properties previously associated to the device
- * secondary firmware node with device_add_properties(). Memory allocated
- * to the properties will also be released.
- */
-void device_remove_properties(struct device *dev)
-{
-	struct fwnode_handle *fwnode;
-	struct property_set *pset;
-
-	fwnode = dev_fwnode(dev);
-	if (!fwnode)
-		return;
-	/*
-	 * Pick either primary or secondary node depending which one holds
-	 * the pset. If there is no real firmware node (ACPI/DT) primary
-	 * will hold the pset.
-	 */
-	pset = to_pset_node(fwnode);
-	if (pset) {
-		set_primary_fwnode(dev, NULL);
-	} else {
-		pset = to_pset_node(fwnode->secondary);
-		if (pset && dev == pset->dev)
-			set_secondary_fwnode(dev, NULL);
-	}
-	if (pset && dev == pset->dev)
-		pset_free_set(pset);
-}
-EXPORT_SYMBOL_GPL(device_remove_properties);
-
-/**
- * device_add_properties - Add a collection of properties to a device object.
- * @dev: Device to add properties to.
- * @properties: Collection of properties to add.
- *
- * Associate a collection of device properties represented by @properties with
- * @dev as its secondary firmware node. The function takes a copy of
- * @properties.
- */
-int device_add_properties(struct device *dev,
-			  const struct property_entry *properties)
-{
-	struct property_set *p, pset;
-
-	if (!properties)
-		return -EINVAL;
-
-	pset.properties = properties;
-
-	p = pset_copy_set(&pset);
-	if (IS_ERR(p))
-		return PTR_ERR(p);
-
-	p->fwnode.ops = &pset_fwnode_ops;
-	set_secondary_fwnode(dev, &p->fwnode);
-	p->dev = dev;
-	return 0;
-}
-EXPORT_SYMBOL_GPL(device_add_properties);
-
 /**
  * fwnode_get_next_parent - Iterate to the node's parent
  * @fwnode: Firmware whose parent is retrieved
diff --git a/drivers/base/pset_property.c b/drivers/base/pset_property.c
new file mode 100644
index 000000000000..08ecc13080ae
--- /dev/null
+++ b/drivers/base/pset_property.c
@@ -0,0 +1,540 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Handling of device properties defined in legacy board files.
+ *
+ * Copyright (C) 2014, Intel Corporation
+ * Authors: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
+ *          Mika Westerberg <mika.westerberg@linux.intel.com>
+ */
+
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/export.h>
+#include <linux/kernel.h>
+#include <linux/property.h>
+#include <linux/slab.h>
+
+struct property_set {
+	struct device *dev;
+	struct fwnode_handle fwnode;
+	const struct property_entry *properties;
+};
+
+static const struct fwnode_operations pset_fwnode_ops;
+
+static inline bool is_pset_node(const struct fwnode_handle *fwnode)
+{
+	return !IS_ERR_OR_NULL(fwnode) && fwnode->ops == &pset_fwnode_ops;
+}
+
+#define to_pset_node(__fwnode)						\
+	({								\
+		typeof(__fwnode) __to_pset_node_fwnode = __fwnode;	\
+									\
+		is_pset_node(__to_pset_node_fwnode) ?			\
+			container_of(__to_pset_node_fwnode,		\
+				     struct property_set, fwnode) :	\
+			NULL;						\
+	})
+
+static const struct property_entry *
+pset_prop_get(const struct property_set *pset, const char *name)
+{
+	const struct property_entry *prop;
+
+	if (!pset || !pset->properties)
+		return NULL;
+
+	for (prop = pset->properties; prop->name; prop++)
+		if (!strcmp(name, prop->name))
+			return prop;
+
+	return NULL;
+}
+
+static const void *property_get_pointer(const struct property_entry *prop)
+{
+	switch (prop->type) {
+	case DEV_PROP_U8:
+		if (prop->is_array)
+			return prop->pointer.u8_data;
+		return &prop->value.u8_data;
+	case DEV_PROP_U16:
+		if (prop->is_array)
+			return prop->pointer.u16_data;
+		return &prop->value.u16_data;
+	case DEV_PROP_U32:
+		if (prop->is_array)
+			return prop->pointer.u32_data;
+		return &prop->value.u32_data;
+	case DEV_PROP_U64:
+		if (prop->is_array)
+			return prop->pointer.u64_data;
+		return &prop->value.u64_data;
+	case DEV_PROP_STRING:
+		if (prop->is_array)
+			return prop->pointer.str;
+		return &prop->value.str;
+	default:
+		return NULL;
+	}
+}
+
+static void property_set_pointer(struct property_entry *prop, const void *pointer)
+{
+	switch (prop->type) {
+	case DEV_PROP_U8:
+		if (prop->is_array)
+			prop->pointer.u8_data = pointer;
+		else
+			prop->value.u8_data = *((u8 *)pointer);
+		break;
+	case DEV_PROP_U16:
+		if (prop->is_array)
+			prop->pointer.u16_data = pointer;
+		else
+			prop->value.u16_data = *((u16 *)pointer);
+		break;
+	case DEV_PROP_U32:
+		if (prop->is_array)
+			prop->pointer.u32_data = pointer;
+		else
+			prop->value.u32_data = *((u32 *)pointer);
+		break;
+	case DEV_PROP_U64:
+		if (prop->is_array)
+			prop->pointer.u64_data = pointer;
+		else
+			prop->value.u64_data = *((u64 *)pointer);
+		break;
+	case DEV_PROP_STRING:
+		if (prop->is_array)
+			prop->pointer.str = pointer;
+		else
+			prop->value.str = pointer;
+		break;
+	default:
+		break;
+	}
+}
+
+static const void *pset_prop_find(const struct property_set *pset,
+				  const char *propname, size_t length)
+{
+	const struct property_entry *prop;
+	const void *pointer;
+
+	prop = pset_prop_get(pset, propname);
+	if (!prop)
+		return ERR_PTR(-EINVAL);
+	pointer = property_get_pointer(prop);
+	if (!pointer)
+		return ERR_PTR(-ENODATA);
+	if (length > prop->length)
+		return ERR_PTR(-EOVERFLOW);
+	return pointer;
+}
+
+static int pset_prop_read_u8_array(const struct property_set *pset,
+				   const char *propname,
+				   u8 *values, size_t nval)
+{
+	const void *pointer;
+	size_t length = nval * sizeof(*values);
+
+	pointer = pset_prop_find(pset, propname, length);
+	if (IS_ERR(pointer))
+		return PTR_ERR(pointer);
+
+	memcpy(values, pointer, length);
+	return 0;
+}
+
+static int pset_prop_read_u16_array(const struct property_set *pset,
+				    const char *propname,
+				    u16 *values, size_t nval)
+{
+	const void *pointer;
+	size_t length = nval * sizeof(*values);
+
+	pointer = pset_prop_find(pset, propname, length);
+	if (IS_ERR(pointer))
+		return PTR_ERR(pointer);
+
+	memcpy(values, pointer, length);
+	return 0;
+}
+
+static int pset_prop_read_u32_array(const struct property_set *pset,
+				    const char *propname,
+				    u32 *values, size_t nval)
+{
+	const void *pointer;
+	size_t length = nval * sizeof(*values);
+
+	pointer = pset_prop_find(pset, propname, length);
+	if (IS_ERR(pointer))
+		return PTR_ERR(pointer);
+
+	memcpy(values, pointer, length);
+	return 0;
+}
+
+static int pset_prop_read_u64_array(const struct property_set *pset,
+				    const char *propname,
+				    u64 *values, size_t nval)
+{
+	const void *pointer;
+	size_t length = nval * sizeof(*values);
+
+	pointer = pset_prop_find(pset, propname, length);
+	if (IS_ERR(pointer))
+		return PTR_ERR(pointer);
+
+	memcpy(values, pointer, length);
+	return 0;
+}
+
+static int pset_prop_count_elems_of_size(const struct property_set *pset,
+					 const char *propname, size_t length)
+{
+	const struct property_entry *prop;
+
+	prop = pset_prop_get(pset, propname);
+	if (!prop)
+		return -EINVAL;
+
+	return prop->length / length;
+}
+
+static int pset_prop_read_string_array(const struct property_set *pset,
+				       const char *propname,
+				       const char **strings, size_t nval)
+{
+	const struct property_entry *prop;
+	const void *pointer;
+	size_t array_len, length;
+
+	/* Find out the array length. */
+	prop = pset_prop_get(pset, propname);
+	if (!prop)
+		return -EINVAL;
+
+	if (!prop->is_array)
+		/* The array length for a non-array string property is 1. */
+		array_len = 1;
+	else
+		/* Find the length of an array. */
+		array_len = pset_prop_count_elems_of_size(pset, propname,
+							  sizeof(const char *));
+
+	/* Return how many there are if strings is NULL. */
+	if (!strings)
+		return array_len;
+
+	array_len = min(nval, array_len);
+	length = array_len * sizeof(*strings);
+
+	pointer = pset_prop_find(pset, propname, length);
+	if (IS_ERR(pointer))
+		return PTR_ERR(pointer);
+
+	memcpy(strings, pointer, length);
+
+	return array_len;
+}
+
+static bool pset_fwnode_property_present(const struct fwnode_handle *fwnode,
+					 const char *propname)
+{
+	return !!pset_prop_get(to_pset_node(fwnode), propname);
+}
+
+static int pset_fwnode_read_int_array(const struct fwnode_handle *fwnode,
+				      const char *propname,
+				      unsigned int elem_size, void *val,
+				      size_t nval)
+{
+	const struct property_set *node = to_pset_node(fwnode);
+
+	if (!val)
+		return pset_prop_count_elems_of_size(node, propname, elem_size);
+
+	switch (elem_size) {
+	case sizeof(u8):
+		return pset_prop_read_u8_array(node, propname, val, nval);
+	case sizeof(u16):
+		return pset_prop_read_u16_array(node, propname, val, nval);
+	case sizeof(u32):
+		return pset_prop_read_u32_array(node, propname, val, nval);
+	case sizeof(u64):
+		return pset_prop_read_u64_array(node, propname, val, nval);
+	}
+
+	return -ENXIO;
+}
+
+static int
+pset_fwnode_property_read_string_array(const struct fwnode_handle *fwnode,
+				       const char *propname,
+				       const char **val, size_t nval)
+{
+	return pset_prop_read_string_array(to_pset_node(fwnode), propname,
+					   val, nval);
+}
+
+static const struct fwnode_operations pset_fwnode_ops = {
+	.property_present = pset_fwnode_property_present,
+	.property_read_int_array = pset_fwnode_read_int_array,
+	.property_read_string_array = pset_fwnode_property_read_string_array,
+};
+
+static void property_entry_free_data(const struct property_entry *p)
+{
+	const void *pointer = property_get_pointer(p);
+	size_t i, nval;
+
+	if (p->is_array) {
+		if (p->type == DEV_PROP_STRING && p->pointer.str) {
+			nval = p->length / sizeof(const char *);
+			for (i = 0; i < nval; i++)
+				kfree(p->pointer.str[i]);
+		}
+		kfree(pointer);
+	} else if (p->type == DEV_PROP_STRING) {
+		kfree(p->value.str);
+	}
+	kfree(p->name);
+}
+
+static int property_copy_string_array(struct property_entry *dst,
+				      const struct property_entry *src)
+{
+	const char **d;
+	size_t nval = src->length / sizeof(*d);
+	int i;
+
+	d = kcalloc(nval, sizeof(*d), GFP_KERNEL);
+	if (!d)
+		return -ENOMEM;
+
+	for (i = 0; i < nval; i++) {
+		d[i] = kstrdup(src->pointer.str[i], GFP_KERNEL);
+		if (!d[i] && src->pointer.str[i]) {
+			while (--i >= 0)
+				kfree(d[i]);
+			kfree(d);
+			return -ENOMEM;
+		}
+	}
+
+	dst->pointer.str = d;
+	return 0;
+}
+
+static int property_entry_copy_data(struct property_entry *dst,
+				    const struct property_entry *src)
+{
+	const void *pointer = property_get_pointer(src);
+	const void *new;
+	int error;
+
+	if (src->is_array) {
+		if (!src->length)
+			return -ENODATA;
+
+		if (src->type == DEV_PROP_STRING) {
+			error = property_copy_string_array(dst, src);
+			if (error)
+				return error;
+			new = dst->pointer.str;
+		} else {
+			new = kmemdup(pointer, src->length, GFP_KERNEL);
+			if (!new)
+				return -ENOMEM;
+		}
+	} else if (src->type == DEV_PROP_STRING) {
+		new = kstrdup(src->value.str, GFP_KERNEL);
+		if (!new && src->value.str)
+			return -ENOMEM;
+	} else {
+		new = pointer;
+	}
+
+	dst->length = src->length;
+	dst->is_array = src->is_array;
+	dst->type = src->type;
+
+	property_set_pointer(dst, new);
+
+	dst->name = kstrdup(src->name, GFP_KERNEL);
+	if (!dst->name)
+		goto out_free_data;
+
+	return 0;
+
+out_free_data:
+	property_entry_free_data(dst);
+	return -ENOMEM;
+}
+
+/**
+ * property_entries_dup - duplicate array of properties
+ * @properties: array of properties to copy
+ *
+ * This function creates a deep copy of the given NULL-terminated array
+ * of property entries.
+ */
+struct property_entry *
+property_entries_dup(const struct property_entry *properties)
+{
+	struct property_entry *p;
+	int i, n = 0;
+
+	while (properties[n].name)
+		n++;
+
+	p = kcalloc(n + 1, sizeof(*p), GFP_KERNEL);
+	if (!p)
+		return ERR_PTR(-ENOMEM);
+
+	for (i = 0; i < n; i++) {
+		int ret = property_entry_copy_data(&p[i], &properties[i]);
+		if (ret) {
+			while (--i >= 0)
+				property_entry_free_data(&p[i]);
+			kfree(p);
+			return ERR_PTR(ret);
+		}
+	}
+
+	return p;
+}
+EXPORT_SYMBOL_GPL(property_entries_dup);
+
+/**
+ * property_entries_free - free previously allocated array of properties
+ * @properties: array of properties to destroy
+ *
+ * This function frees given NULL-terminated array of property entries,
+ * along with their data.
+ */
+void property_entries_free(const struct property_entry *properties)
+{
+	const struct property_entry *p;
+
+	for (p = properties; p->name; p++)
+		property_entry_free_data(p);
+
+	kfree(properties);
+}
+EXPORT_SYMBOL_GPL(property_entries_free);
+
+/**
+ * pset_free_set - releases memory allocated for copied property set
+ * @pset: Property set to release
+ *
+ * Function takes previously copied property set and releases all the
+ * memory allocated to it.
+ */
+static void pset_free_set(struct property_set *pset)
+{
+	if (!pset)
+		return;
+
+	property_entries_free(pset->properties);
+	kfree(pset);
+}
+
+/**
+ * pset_copy_set - copies property set
+ * @pset: Property set to copy
+ *
+ * This function takes a deep copy of the given property set and returns
+ * pointer to the copy. Call device_free_property_set() to free resources
+ * allocated in this function.
+ *
+ * Return: Pointer to the new property set or error pointer.
+ */
+static struct property_set *pset_copy_set(const struct property_set *pset)
+{
+	struct property_entry *properties;
+	struct property_set *p;
+
+	p = kzalloc(sizeof(*p), GFP_KERNEL);
+	if (!p)
+		return ERR_PTR(-ENOMEM);
+
+	properties = property_entries_dup(pset->properties);
+	if (IS_ERR(properties)) {
+		kfree(p);
+		return ERR_CAST(properties);
+	}
+
+	p->properties = properties;
+	return p;
+}
+
+/**
+ * device_remove_properties - Remove properties from a device object.
+ * @dev: Device whose properties to remove.
+ *
+ * The function removes properties previously associated to the device
+ * secondary firmware node with device_add_properties(). Memory allocated
+ * to the properties will also be released.
+ */
+void device_remove_properties(struct device *dev)
+{
+	struct fwnode_handle *fwnode;
+	struct property_set *pset;
+
+	fwnode = dev_fwnode(dev);
+	if (!fwnode)
+		return;
+	/*
+	 * Pick either primary or secondary node depending which one holds
+	 * the pset. If there is no real firmware node (ACPI/DT) primary
+	 * will hold the pset.
+	 */
+	pset = to_pset_node(fwnode);
+	if (pset) {
+		set_primary_fwnode(dev, NULL);
+	} else {
+		pset = to_pset_node(fwnode->secondary);
+		if (pset && dev == pset->dev)
+			set_secondary_fwnode(dev, NULL);
+	}
+	if (pset && dev == pset->dev)
+		pset_free_set(pset);
+}
+EXPORT_SYMBOL_GPL(device_remove_properties);
+
+/**
+ * device_add_properties - Add a collection of properties to a device object.
+ * @dev: Device to add properties to.
+ * @properties: Collection of properties to add.
+ *
+ * Associate a collection of device properties represented by @properties with
+ * @dev as its secondary firmware node. The function takes a copy of
+ * @properties.
+ */
+int device_add_properties(struct device *dev,
+			  const struct property_entry *properties)
+{
+	struct property_set *p, pset;
+
+	if (!properties)
+		return -EINVAL;
+
+	pset.properties = properties;
+
+	p = pset_copy_set(&pset);
+	if (IS_ERR(p))
+		return PTR_ERR(p);
+
+	p->fwnode.ops = &pset_fwnode_ops;
+	set_secondary_fwnode(dev, &p->fwnode);
+	p->dev = dev;
+	return 0;
+}
+EXPORT_SYMBOL_GPL(device_add_properties);
-- 
2.19.0.397.gdd90340f6a-goog

