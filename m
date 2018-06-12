Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 33D1BC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 07:49:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C933920693
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 07:49:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HLsEJBaA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C933920693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933578AbeFLHta (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 03:49:30 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:39806 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933526AbeFLHtQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 03:49:16 -0400
Received: by mail-lf0-f68.google.com with SMTP id t134-v6so34509044lff.6;
        Tue, 12 Jun 2018 00:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=p6D7/5BidEe3XpfScupYNsNQdCy1j4id8nWIUcSG2MQ=;
        b=HLsEJBaAolDWUEaHyFdXd0t8YN3WZiXkDkHSAjufL8YY+XND/Xfmu71+rvo41XGfpR
         F1HfvRRhqqutSgAwXpHxxGM36EcTVpP8IzPfdpzxAqI3X+dNdf3eFo+zr9M1m4nXos0F
         knruo8/cqxOTe1c9y2eP4SA5FctsOc6XEisaLLzkrXtNjIjfqJb/lTQVKzDKXYuOoXMW
         k8Ys5CB9Nf/leERFw2+d1k3X5boe2upES47lKH2r7t2NHeFfhmKp2pKs37FY/pxD0NeN
         Q0HxIG2e+ENEGzNLrcZZK0RY0SmUqIM9ZGqEaTiQRcOTKqi4JTemz6UptbxpBbqwqg01
         5DwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=p6D7/5BidEe3XpfScupYNsNQdCy1j4id8nWIUcSG2MQ=;
        b=ES57yc8sxDrxXwfm4NKLLcPblTjuxLWHFccAZPzPqSSMH328zSL+HE8kQgDVpsKXqv
         hFyF6BnHBty6fAdWCD74e9N6PKBsnoPnltRuHasJtmIiR+V81z0xGEfihAJNC3qTm0IH
         5hrDWW7zJhalKTrP3kOvxA8XIIRLfeCGI4ajdMAWhi5MYgOHzkSMQzBqSJInpmVwq0+n
         3gv+SJbBX6SmTmN+/bTAgVTt0ZVeEgMiZQNRpHVEXIz6F/YAnGkyFrYDofzvp7XcEicV
         mguPyAQJAx/zvdZtde5Zpp2kw9C6fSgj0P83aJTpQsVq90M7gRulPtiX8V6yYAUSslb6
         5pbA==
X-Gm-Message-State: APt69E19wYb9OCC0yzFjlmQghU7kS9NKMod/CR7VJGRq9EZbAqWluUyT
        VjWfv1DFpJN6kSrngJcId/I=
X-Google-Smtp-Source: ADUXVKK3nvXeGAUKrYvr/vIC/+jftg4uUgZx9HTsK1pQq6XJaGv1lP9OxmyxV+KBhB8v/kEpJkYDFw==
X-Received: by 2002:a19:c452:: with SMTP id u79-v6mr1358667lff.5.1528789754536;
        Tue, 12 Jun 2018 00:49:14 -0700 (PDT)
Received: from a2k-HP-ProDesk-600-G2-SFF.kyiv.epam.com (ll-74.141.223.85.sovam.net.ua. [85.223.141.74])
        by smtp.gmail.com with ESMTPSA id b65-v6sm62657lfe.80.2018.06.12.00.49.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 12 Jun 2018 00:49:13 -0700 (PDT)
From:   Oleksandr Andrushchenko <andr2000@gmail.com>
To:     xen-devel@lists.xenproject.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, dmitry.torokhov@gmail.com,
        jgross@suse.com, lyan@suse.com, boris.ostrovsky@oracle.com
Cc:     konrad.wilk@oracle.com, andr2000@gmail.com,
        andrii_chepurnyi@epam.com,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
Subject: [PATCH v5 3/3] Input: xen-kbdfront - allow better run-time configuration
Date:   Tue, 12 Jun 2018 10:48:56 +0300
Message-Id: <20180612074856.28451-4-andr2000@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180612074856.28451-1-andr2000@gmail.com>
References: <20180612074856.28451-1-andr2000@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>

It is now only possible to control if multi-touch virtual device
is created or not (via the corresponding XenStore entries),
but keyboard and pointer devices are always created.
In some cases this is not desirable. For example, if virtual
keyboard device is exposed to Android then the latter won't
automatically show on-screen keyboard as it expects that a
physical keyboard device can be used for typing.

Utilize keyboard and pointer device XenStore feature fields to
configure which virtual devices are created:
 - set "feature-disable-keyboard" to 1 if no keyboard device
   needs to be created
 - set "feature-disable-pointer" to 1 if no pointer device
   needs to be created
Keep old behavior by default.

Signed-off-by: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
Suggested-by: Andrii Chepurnyi <andrii_chepurnyi@epam.com>
Tested-by: Andrii Chepurnyi <andrii_chepurnyi@epam.com>
---
 drivers/input/misc/xen-kbdfront.c | 177 ++++++++++++++++++------------
 1 file changed, 106 insertions(+), 71 deletions(-)

diff --git a/drivers/input/misc/xen-kbdfront.c b/drivers/input/misc/xen-kbdfront.c
index 92d739649022..f50fba1962ec 100644
--- a/drivers/input/misc/xen-kbdfront.c
+++ b/drivers/input/misc/xen-kbdfront.c
@@ -63,6 +63,9 @@ static void xenkbd_disconnect_backend(struct xenkbd_info *);
 static void xenkbd_handle_motion_event(struct xenkbd_info *info,
 				       struct xenkbd_motion *motion)
 {
+	if (unlikely(!info->ptr))
+		return;
+
 	input_report_rel(info->ptr, REL_X, motion->rel_x);
 	input_report_rel(info->ptr, REL_Y, motion->rel_y);
 	if (motion->rel_z)
@@ -73,6 +76,9 @@ static void xenkbd_handle_motion_event(struct xenkbd_info *info,
 static void xenkbd_handle_position_event(struct xenkbd_info *info,
 					 struct xenkbd_position *pos)
 {
+	if (unlikely(!info->ptr))
+		return;
+
 	input_report_abs(info->ptr, ABS_X, pos->abs_x);
 	input_report_abs(info->ptr, ABS_Y, pos->abs_y);
 	if (pos->rel_z)
@@ -97,6 +103,9 @@ static void xenkbd_handle_key_event(struct xenkbd_info *info,
 		return;
 	}
 
+	if (unlikely(!dev))
+		return;
+
 	input_event(dev, EV_KEY, key->keycode, value);
 	input_sync(dev);
 }
@@ -192,7 +201,7 @@ static int xenkbd_probe(struct xenbus_device *dev,
 				  const struct xenbus_device_id *id)
 {
 	int ret, i;
-	unsigned int abs, touch;
+	bool with_mtouch, with_kbd, with_ptr;
 	struct xenkbd_info *info;
 	struct input_dev *kbd, *ptr, *mtouch;
 
@@ -211,93 +220,114 @@ static int xenkbd_probe(struct xenbus_device *dev,
 	if (!info->page)
 		goto error_nomem;
 
-	/* Set input abs params to match backend screen res */
-	abs = xenbus_read_unsigned(dev->otherend,
-				   XENKBD_FIELD_FEAT_ABS_POINTER, 0);
-	ptr_size[KPARAM_X] = xenbus_read_unsigned(dev->otherend,
-						  XENKBD_FIELD_WIDTH,
-						  ptr_size[KPARAM_X]);
-	ptr_size[KPARAM_Y] = xenbus_read_unsigned(dev->otherend,
-						  XENKBD_FIELD_HEIGHT,
-						  ptr_size[KPARAM_Y]);
-	if (abs) {
-		ret = xenbus_write(XBT_NIL, dev->nodename,
-				   XENKBD_FIELD_REQ_ABS_POINTER, "1");
-		if (ret) {
-			pr_warn("xenkbd: can't request abs-pointer\n");
-			abs = 0;
-		}
-	}
+	/*
+	 * The below are reverse logic, e.g. if the feature is set, then
+	 * do not expose the corresponding virtual device.
+	 */
+	with_kbd = !xenbus_read_unsigned(dev->otherend,
+					 XENKBD_FIELD_FEAT_DSBL_KEYBRD, 0);
+
+	with_ptr = !xenbus_read_unsigned(dev->otherend,
+					 XENKBD_FIELD_FEAT_DSBL_POINTER, 0);
 
-	touch = xenbus_read_unsigned(dev->otherend,
-				     XENKBD_FIELD_FEAT_MTOUCH, 0);
-	if (touch) {
+	/* Direct logic: if set, then create multi-touch device. */
+	with_mtouch = xenbus_read_unsigned(dev->otherend,
+					   XENKBD_FIELD_FEAT_MTOUCH, 0);
+	if (with_mtouch) {
 		ret = xenbus_write(XBT_NIL, dev->nodename,
 				   XENKBD_FIELD_REQ_MTOUCH, "1");
 		if (ret) {
 			pr_warn("xenkbd: can't request multi-touch");
-			touch = 0;
+			with_mtouch = 0;
 		}
 	}
 
 	/* keyboard */
-	kbd = input_allocate_device();
-	if (!kbd)
-		goto error_nomem;
-	kbd->name = "Xen Virtual Keyboard";
-	kbd->phys = info->phys;
-	kbd->id.bustype = BUS_PCI;
-	kbd->id.vendor = 0x5853;
-	kbd->id.product = 0xffff;
-
-	__set_bit(EV_KEY, kbd->evbit);
-	for (i = KEY_ESC; i < KEY_UNKNOWN; i++)
-		__set_bit(i, kbd->keybit);
-	for (i = KEY_OK; i < KEY_MAX; i++)
-		__set_bit(i, kbd->keybit);
-
-	ret = input_register_device(kbd);
-	if (ret) {
-		input_free_device(kbd);
-		xenbus_dev_fatal(dev, ret, "input_register_device(kbd)");
-		goto error;
+	if (with_kbd) {
+		kbd = input_allocate_device();
+		if (!kbd)
+			goto error_nomem;
+		kbd->name = "Xen Virtual Keyboard";
+		kbd->phys = info->phys;
+		kbd->id.bustype = BUS_PCI;
+		kbd->id.vendor = 0x5853;
+		kbd->id.product = 0xffff;
+
+		__set_bit(EV_KEY, kbd->evbit);
+		for (i = KEY_ESC; i < KEY_UNKNOWN; i++)
+			__set_bit(i, kbd->keybit);
+		for (i = KEY_OK; i < KEY_MAX; i++)
+			__set_bit(i, kbd->keybit);
+
+		ret = input_register_device(kbd);
+		if (ret) {
+			input_free_device(kbd);
+			xenbus_dev_fatal(dev, ret,
+					 "input_register_device(kbd)");
+			goto error;
+		}
+		info->kbd = kbd;
 	}
-	info->kbd = kbd;
 
 	/* pointing device */
-	ptr = input_allocate_device();
-	if (!ptr)
-		goto error_nomem;
-	ptr->name = "Xen Virtual Pointer";
-	ptr->phys = info->phys;
-	ptr->id.bustype = BUS_PCI;
-	ptr->id.vendor = 0x5853;
-	ptr->id.product = 0xfffe;
-
-	if (abs) {
-		__set_bit(EV_ABS, ptr->evbit);
-		input_set_abs_params(ptr, ABS_X, 0, ptr_size[KPARAM_X], 0, 0);
-		input_set_abs_params(ptr, ABS_Y, 0, ptr_size[KPARAM_Y], 0, 0);
-	} else {
-		input_set_capability(ptr, EV_REL, REL_X);
-		input_set_capability(ptr, EV_REL, REL_Y);
-	}
-	input_set_capability(ptr, EV_REL, REL_WHEEL);
+	if (with_ptr) {
+		unsigned int abs;
+
+		/* Set input abs params to match backend screen res */
+		abs = xenbus_read_unsigned(dev->otherend,
+					   XENKBD_FIELD_FEAT_ABS_POINTER, 0);
+		ptr_size[KPARAM_X] = xenbus_read_unsigned(dev->otherend,
+							  XENKBD_FIELD_WIDTH,
+							  ptr_size[KPARAM_X]);
+		ptr_size[KPARAM_Y] = xenbus_read_unsigned(dev->otherend,
+							  XENKBD_FIELD_HEIGHT,
+							  ptr_size[KPARAM_Y]);
+		if (abs) {
+			ret = xenbus_write(XBT_NIL, dev->nodename,
+					   XENKBD_FIELD_REQ_ABS_POINTER, "1");
+			if (ret) {
+				pr_warn("xenkbd: can't request abs-pointer\n");
+				abs = 0;
+			}
+		}
 
-	__set_bit(EV_KEY, ptr->evbit);
-	for (i = BTN_LEFT; i <= BTN_TASK; i++)
-		__set_bit(i, ptr->keybit);
+		ptr = input_allocate_device();
+		if (!ptr)
+			goto error_nomem;
+		ptr->name = "Xen Virtual Pointer";
+		ptr->phys = info->phys;
+		ptr->id.bustype = BUS_PCI;
+		ptr->id.vendor = 0x5853;
+		ptr->id.product = 0xfffe;
+
+		if (abs) {
+			__set_bit(EV_ABS, ptr->evbit);
+			input_set_abs_params(ptr, ABS_X, 0,
+					     ptr_size[KPARAM_X], 0, 0);
+			input_set_abs_params(ptr, ABS_Y, 0,
+					     ptr_size[KPARAM_Y], 0, 0);
+		} else {
+			input_set_capability(ptr, EV_REL, REL_X);
+			input_set_capability(ptr, EV_REL, REL_Y);
+		}
+		input_set_capability(ptr, EV_REL, REL_WHEEL);
 
-	ret = input_register_device(ptr);
-	if (ret) {
-		input_free_device(ptr);
-		xenbus_dev_fatal(dev, ret, "input_register_device(ptr)");
-		goto error;
+		__set_bit(EV_KEY, ptr->evbit);
+		for (i = BTN_LEFT; i <= BTN_TASK; i++)
+			__set_bit(i, ptr->keybit);
+
+		ret = input_register_device(ptr);
+		if (ret) {
+			input_free_device(ptr);
+			xenbus_dev_fatal(dev, ret,
+					 "input_register_device(ptr)");
+			goto error;
+		}
+		info->ptr = ptr;
 	}
-	info->ptr = ptr;
 
 	/* multi-touch device */
-	if (touch) {
+	if (with_mtouch) {
 		int num_cont, width, height;
 
 		mtouch = input_allocate_device();
@@ -346,6 +376,11 @@ static int xenkbd_probe(struct xenbus_device *dev,
 		info->mtouch = mtouch;
 	}
 
+	if (!(with_kbd | with_ptr | with_mtouch)) {
+		ret = -ENXIO;
+		goto error;
+	}
+
 	ret = xenkbd_connect_backend(dev, info);
 	if (ret < 0)
 		goto error;
-- 
2.17.1

