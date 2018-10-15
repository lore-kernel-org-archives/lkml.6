Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32E32C04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 13:54:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB1A120652
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 13:54:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mdUo6n6d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB1A120652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726628AbeJOVkS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 17:40:18 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:46051 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726499AbeJOVkS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 17:40:18 -0400
Received: by mail-pl1-f196.google.com with SMTP id y15-v6so9343802plr.12;
        Mon, 15 Oct 2018 06:54:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=wCLAU2g9iExaZQ+F167JQjQ6DEeUE6FIHBUKstooC18=;
        b=mdUo6n6dcsvxt5uQwPZIZrd6vfNsnq5hy8DHZa7ecW6E+vBx3VB0vti9b5+wo9yuTh
         QX5NkXtvjd8SF8qnmpmYVSPkt67K28hmZPUDxMD0TsVMJpLD4gN1uqh2Je7FiGcATa0H
         vj3qvuV6aT8yEWNZiO/za3AbIgQZAPQUCRvWjdfZQa5dbVB+IbRQZ6pbTvlrasphAIfj
         aLV75qNu0FX31cuGD1YEqkOooKu9T7ms38z9lGspdXECotXaZGbrQW0B5Bg/27KwDrMq
         ep4iGbBNKEl0LnNtXJ6k5YDXy05BpKi3cO9peFLO45F+limYYgYjDhHhHER1b3ngM/LM
         bF7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=wCLAU2g9iExaZQ+F167JQjQ6DEeUE6FIHBUKstooC18=;
        b=jRiECafDjVKbKg9nfsLmn4SROpvbVsjAr5yurs3uI4XI8W/OqWC9JrkKkHavJl8529
         YMCi6Uuh+jcaUvyRDWTSJBh7AvQEyPVO9wh912i2X2qtqzRJqTM6zz1YlmYQaaDWq4Ki
         qk+zzXFYXzIA5odbf6WKh5Vpxsz7ZqlVJL4fjYj0YF63F9vL9peRsxDK5L8gJfVdy+Lc
         YihmK9bLJIq8sHNuB4pCaYkOnGACwDHwyEjh0Woy6kIlJaLiuob+o0/va/MFVpRnKVqB
         1hAkkWAq99oGGzGEGLtyp32e3GLmn+S+Dl4U0x9yTGWBlJQKx/QwCKrghQ/s2iDP69p/
         e0cg==
X-Gm-Message-State: ABuFfohwjDZDgDDbqJT2mobdRwhcMEpdVTqHz5fduun28/N6xFl85qAq
        accFzfNU4jqBvkaMUZYwPA==
X-Google-Smtp-Source: ACcGV60lTd8+cH8q5FTIufu2yCJletkpXb9DB3NMOcCdTyVyaJvnJPCZoZpKw8gRSj5E1608AH4JGg==
X-Received: by 2002:a17:902:a618:: with SMTP id u24-v6mr17109661plq.77.1539611693798;
        Mon, 15 Oct 2018 06:54:53 -0700 (PDT)
Received: from localhost.localdomain ([157.49.208.47])
        by smtp.gmail.com with ESMTPSA id v26-v6sm7688015pfg.43.2018.10.15.06.54.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Oct 2018 06:54:53 -0700 (PDT)
From:   Parikshit Pareek <purohit4891@gmail.com>
Cc:     purohit4891@gmail.com, Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Vincent Pelletier <plr.vincent@gmail.com>,
        Jerry Zhang <zhangjerry@google.com>,
        =?UTF-8?q?Micha=C5=82=20Nazarewicz?= <mina86@mina86.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Jack Pham <jackp@codeaurora.org>,
        John Keeping <john@metanate.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] usb: gadget: f_fs: add the support for alternate interface setting
Date:   Mon, 15 Oct 2018 19:24:05 +0530
Message-Id: <20181015135416.4512-1-purohit4891@gmail.com>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In FFS the support for multiple alternate interface settings are not present.
This patch implements the due support. The user application is required to
write interface descriptors to ep0 file of function fs, one for each alternate
interface setting of the same interface, with bAlternateSetting set to different
alt setting values. The order of interface descriptors associated with different
alternate interface settings is same as mentioned by the usb standard. For
example, interface descriptor with alt-setting as 0, followed by it's endpoint
descriptors, then interface descriptor of alt-setting 1, followed by endpoint
descriptors of this alternate interface settings, and so on.
Since alternate setting support is implemented, ffs_func_get_alt function is
also implemented to get alternate interface settings.

Signed-off-by: Parikshit Pareek <purohit4891@gmail.com>
---
 drivers/usb/gadget/function/f_fs.c | 304 ++++++++++++++++++++++++++++++-------
 1 file changed, 253 insertions(+), 51 deletions(-)

diff --git a/drivers/usb/gadget/function/f_fs.c b/drivers/usb/gadget/function/f_fs.c
index 3ada83d..1986c51 100644
--- a/drivers/usb/gadget/function/f_fs.c
+++ b/drivers/usb/gadget/function/f_fs.c
@@ -88,7 +88,6 @@ static struct ffs_function *ffs_func_from_usb(struct usb_function *f)
 
 
 static void ffs_func_eps_disable(struct ffs_function *func);
-static int __must_check ffs_func_eps_enable(struct ffs_function *func);
 
 static int ffs_func_bind(struct usb_configuration *,
 			 struct usb_function *);
@@ -1868,46 +1867,6 @@ static void ffs_func_eps_disable(struct ffs_function *func)
 	spin_unlock_irqrestore(&func->ffs->eps_lock, flags);
 }
 
-static int ffs_func_eps_enable(struct ffs_function *func)
-{
-	struct ffs_data *ffs      = func->ffs;
-	struct ffs_ep *ep         = func->eps;
-	struct ffs_epfile *epfile = ffs->epfiles;
-	unsigned count            = ffs->eps_count;
-	unsigned long flags;
-	int ret = 0;
-
-	spin_lock_irqsave(&func->ffs->eps_lock, flags);
-	while(count--) {
-		ep->ep->driver_data = ep;
-
-		ret = config_ep_by_speed(func->gadget, &func->function, ep->ep);
-		if (ret) {
-			pr_err("%s: config_ep_by_speed(%s) returned %d\n",
-					__func__, ep->ep->name, ret);
-			break;
-		}
-
-		ret = usb_ep_enable(ep->ep);
-		if (likely(!ret)) {
-			epfile->ep = ep;
-			epfile->in = usb_endpoint_dir_in(ep->ep->desc);
-			epfile->isoc = usb_endpoint_xfer_isoc(ep->ep->desc);
-		} else {
-			break;
-		}
-
-		++ep;
-		++epfile;
-	}
-
-	wake_up_interruptible(&ffs->wait);
-	spin_unlock_irqrestore(&func->ffs->eps_lock, flags);
-
-	return ret;
-}
-
-
 /* Parsing and building descriptors and strings *****************************/
 
 /*
@@ -1966,7 +1925,10 @@ static int __must_check ffs_do_single_desc(char *data, unsigned len,
 			pr_vdebug("invalid entity's value\n");		\
 			return -EINVAL;					\
 		}							\
-		ret = entity(FFS_ ##type, &val, _ds, priv);		\
+		if (entity)						\
+			ret = entity(FFS_ ##type, &val, _ds, priv);	\
+		else							\
+			ret = 0;					\
 		if (unlikely(ret < 0)) {				\
 			pr_debug("entity " #type "(%02x); ret = %d\n",	\
 				 (val), ret);				\
@@ -2100,6 +2062,67 @@ static int __must_check ffs_do_descs(unsigned count, char *data, unsigned len,
 	}
 }
 
+static int do_function_enable_interface(enum ffs_entity_type type, u8 *valuep,
+					struct usb_descriptor_header *desc,
+					void *priv);
+
+static int do_function_disable_interface(enum ffs_entity_type type, u8 *valuep,
+					struct usb_descriptor_header *desc,
+					void *priv);
+
+static int __must_check ffs_do_descs_alt_intf(unsigned int count, char *data,
+					unsigned int len, unsigned int intf,
+					unsigned int alt, void *priv)
+{
+	const unsigned int _len = len;
+	unsigned long num = 0;
+	struct usb_descriptor_header *_ds;
+	struct usb_interface_descriptor *idecs;
+	ffs_entity_callback entity = NULL;
+
+	ENTER();
+
+	for (;;) {
+		int ret;
+
+		if (num == count)
+			data = NULL;
+
+		if (!data) {
+			pr_vdebug("%s Exiting. No more Data\n", __func__);
+			return _len - len;
+		}
+
+		_ds = (void *)data;
+		if (_ds->bDescriptorType == USB_DT_INTERFACE) {
+			idecs = (void *)_ds;
+
+			/*Check the interface no to deal with */
+			if (idecs->bInterfaceNumber == intf) {
+				if (idecs->bAlternateSetting == alt)
+					entity = do_function_enable_interface;
+				else
+					entity = do_function_disable_interface;
+			} else if (entity &&
+					(idecs->bInterfaceNumber != intf)) {
+				pr_vdebug(
+				"%s Exiting.Moved past the interface no\n",
+								__func__);
+				return _len - len;
+			}
+		}
+		ret = ffs_do_single_desc(data, len, entity, priv);
+		if (unlikely(ret < 0)) {
+			pr_err("%s Exiting with err %d\n", __func__, ret);
+			return ret;
+		}
+
+		len -= ret;
+		data += ret;
+		++num;
+	}
+}
+
 static int __ffs_data_do_entity(enum ffs_entity_type type,
 				u8 *valuep, struct usb_descriptor_header *desc,
 				void *priv)
@@ -2805,16 +2828,33 @@ static int __ffs_func_bind_do_nums(enum ffs_entity_type type, u8 *valuep,
 		/* Handled in previous pass by __ffs_func_bind_do_descs() */
 		return 0;
 
-	case FFS_INTERFACE:
+	case FFS_INTERFACE: {
+
+		struct usb_interface_descriptor *ds = (void *)desc;
+		int id = -EINVAL;
+
 		idx = *valuep;
-		if (func->interfaces_nums[idx] < 0) {
-			int id = usb_interface_id(func->conf, &func->function);
-			if (unlikely(id < 0))
+
+		if (!ds->bAlternateSetting &&
+			(func->interfaces_nums[idx] < 0)) {
+			id = usb_interface_id(func->conf,
+					&func->function);
+
+			if (unlikely(id < 0)) {
+				pr_err("%s wrong intf value allocated%d\n",
+								__func__, id);
 				return id;
+			}
 			func->interfaces_nums[idx] = id;
+		} else if (func->interfaces_nums[idx]  < 0) {
+			pr_err("%s Intf not assigned for alt %d intf no %d\n",
+					__func__, ds->bAlternateSetting, idx);
+			return id;
 		}
+
 		newValue = func->interfaces_nums[idx];
 		break;
+	}
 
 	case FFS_STRING:
 		/* String' IDs are allocated when fsf_data is bound to cdev */
@@ -2925,6 +2965,107 @@ static int __ffs_func_bind_do_os_desc(enum ffs_os_desc_type type,
 	return length;
 }
 
+/* Enables the endpint by it's Endpointaddress.
+ * We need to selectively enable the endpoints
+ * belonging to a particular interface setting.
+ */
+static int ffs_func_ep_en_by_epadd(struct ffs_function *func,
+					int ep_add, int enable)
+{
+	struct ffs_data *ffs      = func->ffs;
+	struct ffs_ep *ep         = func->eps;
+	struct ffs_epfile *epfile = ffs->epfiles;
+	unsigned int count            = ffs->eps_count;
+	unsigned long flags;
+	int ret = 0;
+
+	spin_lock_irqsave(&func->ffs->eps_lock, flags);
+	do {
+		struct usb_endpoint_descriptor *ds;
+		int desc_idx;
+
+		if (ffs->gadget->speed == USB_SPEED_SUPER)
+			desc_idx = 2;
+		else if (ffs->gadget->speed == USB_SPEED_HIGH)
+			desc_idx = 1;
+		else
+			desc_idx = 0;
+
+		/* fall-back to lower speed if desc missing for current speed */
+		do {
+			ds = ep->descs[desc_idx];
+		} while (!ds && --desc_idx >= 0);
+
+		if (!ds) {
+			spin_unlock_irqrestore(&func->ffs->eps_lock, flags);
+			return -EINVAL;
+		}
+
+		if (ep_add == ds->bEndpointAddress) {
+			if (enable) {
+
+				ep->ep->driver_data = ep;
+				ep->ep->desc = ds;
+				ret = usb_ep_enable(ep->ep);
+				if (likely(!ret)) {
+					epfile->ep = ep;
+					epfile->in = usb_endpoint_dir_in(ds);
+					epfile->isoc =
+						usb_endpoint_xfer_isoc(ds);
+				}
+				wake_up_interruptible(&ffs->wait);
+			}
+
+			else {
+				/* pending requests get nuked */
+				if (likely(ep->ep))
+					usb_ep_disable(ep->ep);
+
+				if (epfile)
+					epfile->ep = NULL;
+			}
+			break;
+		}
+		++ep;
+		++epfile;
+	} while (--count);
+	spin_unlock_irqrestore(&func->ffs->eps_lock, flags);
+
+	return ret;
+}
+
+
+static int do_function_en_dis_interface(enum ffs_entity_type type, u8 *valuep,
+					struct usb_descriptor_header *desc,
+					void *priv, int enable)
+{
+	struct usb_endpoint_descriptor *ds = NULL;
+	struct ffs_function *func = priv;
+	int ret = 0;
+
+	if (type != FFS_ENDPOINT)
+		return 0;
+
+	ds = (void *)desc;
+	pr_vdebug("%s EP %s ds %p\n", enable ? "enabled" : "disabled", ds);
+	ret = ffs_func_ep_en_by_epadd(func, ds->bEndpointAddress, enable);
+	return ret;
+}
+
+static int do_function_enable_interface(enum ffs_entity_type type, u8 *valuep,
+					struct usb_descriptor_header *desc,
+					void *priv)
+{
+	return do_function_en_dis_interface(type, valuep, desc, priv, true);
+}
+
+static int do_function_disable_interface(enum ffs_entity_type type, u8 *valuep,
+					struct usb_descriptor_header *desc,
+					void *priv)
+{
+	return do_function_en_dis_interface(type, valuep, desc, priv, false);
+}
+
 static inline struct f_fs_opts *ffs_do_functionfs_bind(struct usb_function *f,
 						struct usb_configuration *c)
 {
@@ -3155,6 +3296,19 @@ static int ffs_func_bind(struct usb_configuration *c,
 
 /* Other USB function hooks *************************************************/
 
+/* Clear the previous alt setting mapped from BIT8-15.
+ * Let the Interface no remain intact in BIT0-7
+ */
+#define FFS_SET_INTF_ALT_SET(intf, alt) do {		\
+	if (intf > -1) {				\
+		func->interfaces_nums[intf]  &= 0xFF;	\
+		func->interfaces_nums[intf] =		\
+			func->interfaces_nums[intf] |	\
+			(short)((alt & 0xff) << 8);	\
+	}						\
+}							\
+while (0)
+
 static void ffs_reset_work(struct work_struct *work)
 {
 	struct ffs_data *ffs = container_of(work,
@@ -3162,12 +3316,32 @@ static void ffs_reset_work(struct work_struct *work)
 	ffs_data_reset(ffs);
 }
 
+static int ffs_func_get_alt(struct usb_function *f,
+			unsigned int interface)
+{
+
+	int intf;
+	struct ffs_function *func = ffs_func_from_usb(f);
+
+	intf = ffs_func_revmap_intf(func, interface);
+
+	if (unlikely(intf < 0))
+		return intf;
+
+	return (func->interfaces_nums[intf] >> 8) & 0xff;
+}
+
+
 static int ffs_func_set_alt(struct usb_function *f,
 			    unsigned interface, unsigned alt)
 {
 	struct ffs_function *func = ffs_func_from_usb(f);
 	struct ffs_data *ffs = func->ffs;
-	int ret = 0, intf;
+	int ret = 0, intf = -1;
+	unsigned int count = 0;
+	struct usb_descriptor_header  **desc_p = NULL;
+
+	pr_vdebug("%s intf %d alt %d\n", __func__, interface, alt);
 
 	if (alt != (unsigned)-1) {
 		intf = ffs_func_revmap_intf(func, interface);
@@ -3175,7 +3349,7 @@ static int ffs_func_set_alt(struct usb_function *f,
 			return intf;
 	}
 
-	if (ffs->func)
+	if (ffs->func && ((alt == -1) || (ffs->state != FFS_ACTIVE)))
 		ffs_func_eps_disable(ffs->func);
 
 	if (ffs->state == FFS_DEACTIVATED) {
@@ -3195,9 +3369,36 @@ static int ffs_func_set_alt(struct usb_function *f,
 	}
 
 	ffs->func = func;
-	ret = ffs_func_eps_enable(func);
-	if (likely(ret >= 0))
+	if (ffs->gadget->speed == USB_SPEED_SUPER) {
+		count = ffs->ss_descs_count;
+		desc_p = func->function.ss_descriptors;
+	}
+	if (!count && !desc_p && ffs->gadget->speed == USB_SPEED_HIGH) {
+		count = ffs->hs_descs_count;
+		desc_p = func->function.hs_descriptors;
+	}
+	if (!count && !desc_p && ffs->gadget->speed == USB_SPEED_FULL) {
+		count = ffs->fs_descs_count;
+		desc_p = func->function.fs_descriptors;
+	}
+
+	if (desc_p && count)
+		ret = ffs_do_descs_alt_intf(count, (void *)desc_p[0],
+		ffs->raw_descs_length, interface, alt, func);
+	else
+		ret = -ENODEV;
+
+	if (unlikely(ret < 0))
+		pr_err("%s err %d\n", __func__, ret);
+	else
+		ret = 0;
+
+	if (likely(ret >= 0)) {
+
+		FFS_SET_INTF_ALT_SET(intf, alt);
 		ffs_event_add(ffs, FUNCTIONFS_ENABLE);
+	}
+
 	return ret;
 }
 
@@ -3315,7 +3516,7 @@ static int ffs_func_revmap_intf(struct ffs_function *func, u8 intf)
 	unsigned count = func->ffs->interfaces_count;
 
 	for (; count; --count, ++nums) {
-		if (*nums >= 0 && *nums == intf)
+		if (((*nums & 0xff) >= 0) && ((*nums & 0xff) == intf))
 			return nums - func->interfaces_nums;
 	}
 
@@ -3506,6 +3707,7 @@ static struct usb_function *ffs_alloc(struct usb_function_instance *fi)
 	func->function.bind    = ffs_func_bind;
 	func->function.unbind  = ffs_func_unbind;
 	func->function.set_alt = ffs_func_set_alt;
+	func->function.get_alt = ffs_func_get_alt;
 	func->function.disable = ffs_func_disable;
 	func->function.setup   = ffs_func_setup;
 	func->function.req_match = ffs_func_req_match;
-- 
1.9.1

