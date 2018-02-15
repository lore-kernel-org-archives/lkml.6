Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1146594-1518691252-2-11715328908585471980
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518691251; b=QWaCLz+utGDoTW9cpy07Ec41wFDkUV6AaawGDC7aG8rZgd0
    kHzw/oAfACSeEgU7Sqk4HRCCOzPrBooRduL0WBYXKe/NmKIry7qVksmq0g/p8abP
    pu53ol5c8NwREtksc+1G++f009FvyfVAJHPgUNpYyJljRdoCWSIDTPxlUiumvTCm
    ChduJvodRcnRKnfxbFRT/i/heUP2+78rzGzaq3ie8tJ6/t0X9j+Ca6lq2BBHu8WL
    fGtIc/QIKy+iJ93cbbSOWopVOgrQJbL9dMIYHoYsu3D6e1alDJ8nmkbCVuxs6JmP
    PxhlMEyl4wd2MizyHqwhep4/a5plLUyCmXNLVDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1518691251;
    bh=mr7gf62V4U79ARIUVqoHcehBY8W4+5Q5P3QG9FN85nA=; b=gg59Wme4LEVS
    KsQymp0CELnOYxsSYZyy1cIqe+ubamt47uISNgpD3cTDSnYlpSkNedZKnLNzon0M
    +k126N6c4Rx5LutVgxlM1/dRbjSr9SzZQaEgaZ1VwUca56s+4F7aYtAc9Xco2fBZ
    5ZSlmhKAb3HDnejUZMv8mPaFOgt3sZgBUd+HEhl3xqYIm1fEHPUMbb9MLJacbJYA
    pA9vH5jQvYclDyEQwiEZgXHQ7sfGuARKhvnZcvc+DjVUvNQHKbzC2C2arm9B31ok
    BLNfM6M4JI6xrzmnWaMECSyK1azyJxXq0ck+3splSwySQOrr8xNdTTWhJY906n6H
    lSRlEih81A==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=samsung.com header.i=@samsung.com header.b=MKGwdyCT x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=mail20170921;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=samsung.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=samsung.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=samsung.com header.i=@samsung.com header.b=MKGwdyCT x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=mail20170921;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=samsung.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=samsung.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755515AbeBOKkh (ORCPT <rfc822;greg@kroah.com>);
        Thu, 15 Feb 2018 05:40:37 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:50953 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755389AbeBOKjg (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Thu, 15 Feb 2018 05:39:36 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20180215103934euoutp022b704cd55adbb500dabf13d333840873~TeZOOgJF61269412694euoutp02d
X-AuditID: cbfec7f4-b4fc79c0000043e4-d8-5a8563612542
From: Andrzej Hajda <a.hajda@samsung.com>
To: devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS)
Cc: Andrzej Hajda <a.hajda@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        dri-devel@lists.freedesktop.org, Inki Dae <inki.dae@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Archit Taneja <architt@codeaurora.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-usb@vger.kernel.org
Subject: [RFC PATCH v2 5/6] extcon: add possibility to get extcon device by
 OF node
Date: Thu, 15 Feb 2018 11:39:19 +0100
Message-id: <20180215103920.32017-6-a.hajda@samsung.com>
X-Mailer: git-send-email 2.16.1
In-reply-to: <20180215103920.32017-1-a.hajda@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrEIsWRmVeSWpSXmKPExsWy7djP87qJya1RBrefmVrcWneO1aKp4y2r
        xcYZ61ktrn95zmox/whQ7MrX92wWk+5PYLE4f34Du0XnxCXsFpseX2O1uLxrDpvFjPP7mCwW
        LWtltlh75C67xdLrF5ksWvceYXcQ8Fgzbw2jx+W+XiaP2R0zWT02repk87jffZzJY/OSeo++
        LasYPT5vkgvgiOKySUnNySxLLdK3S+DKOHtjB3vBZ6mKQ8++MjUwHhfrYuTkkBAwkdjTtIa9
        i5GLQ0hgBaPEpP8nWCCcz4wSl1oPsMNUtS7exgqRWMYo0fhiOZTzH6jl7To2kCo2AU2Jv5tv
        gtkiArES7y7tYgYpYha4wCJx4fQrsFHCAqES665tZgWxWQRUJXasbgazeQUsJFpa5jFDrJOX
        OPymCSjOwcEpYCkxZb4FyBwJgdtsEjvWX2GFqHGROHBwN9R5whKvjm+BsmUkOjsOMkE0dDNK
        nNrXyQzhTGGUOP/qMhNElbXE4eMXwSYxC/BJTNo2nRlkm4QAr0RHmxBEiYfEg0NHGCFsR4kl
        639AA6aHUWLFvqvMExilFjAyrGIUTy0tzk1PLTbKSy3XK07MLS7NS9dLzs/dxAhMCaf/Hf+y
        g3HXn6RDjAIcjEo8vAY2LVFCrIllxZW5hxglOJiVRHg/RrVGCfGmJFZWpRblxxeV5qQWH2KU
        5mBREueN06iLEhJITyxJzU5NLUgtgskycXBKNTCyP/+j/MKo1Wimx6fLt6aU/eHLW3P6YtU9
        tbMrxOu7tYQWZ8fGm3q7eDlv8X31cgdzJNN885wZzV+MXOdoMMpnN9k1rY47y2Y5vb6Ey7ZM
        oMXrbOCD/Md7s94WzmlZnBe9JFl0a+HC5ndztptdK/jGf3DGvsoL/14FLtr97ofPJ2+/xKkT
        5rcrsRRnJBpqMRcVJwIAxLQEMAUDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrILMWRmVeSWpSXmKPExsVy+t/xq7oJya1RBmfWClrcWneO1aKp4y2r
        xcYZ61ktrn95zmox/whQ7MrX92wWk+5PYLE4f34Du0XnxCXsFpseX2O1uLxrDpvFjPP7mCwW
        LWtltlh75C67xdLrF5ksWvceYXcQ8Fgzbw2jx+W+XiaP2R0zWT02repk87jffZzJY/OSeo++
        LasYPT5vkgvgiOKySUnNySxLLdK3S+DKOHtjB3vBZ6mKQ8++MjUwHhfrYuTkkBAwkWhdvI0V
        xBYSWMIo0fROr4uRC8huZJKYd/QyM0iCTUBT4u/mm2wgtohArMTbU5+ZQYqYBS6wSPyeOJMd
        JCEsECqx4cBnsEksAqoSO1Y3g9m8AhYSLS3zmCG2yUscftMEFOfg4BSwlJgy3wJisYXExsnz
        WCcw8ixgZFjFKJJaWpybnltsqFecmFtcmpeul5yfu4kRGLDbjv3cvIPx0sbgQ4wCHIxKPLwG
        Ni1RQqyJZcWVuYcYJTiYlUR4P0a1RgnxpiRWVqUW5ccXleakFh9ilOZgURLnPW9QGSUkkJ5Y
        kpqdmlqQWgSTZeLglGpgZMjb1/auWf4cd125YIO8ya7LW/guGYf4HPCymBqgpmd6Y9G0qzHX
        WXz7Lv27cnXLGQXGxP6Yj2rTOYON5u87l/ArwnjhpkijaZkz/zX3XtgX+v3jWWW+mRGXAlMa
        Jx1OKVzodKLx+Z1M57vWJTZb9907X+fwTMUmumurvmbPznYX94+bHa/8VWIpzkg01GIuKk4E
        AMz8QntUAgAA
X-CMS-MailID: 20180215103928eucas1p1b2ef8630cf86f2799b4689d6786bdf4e
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180215103928eucas1p1b2ef8630cf86f2799b4689d6786bdf4e
X-RootMTR: 20180215103928eucas1p1b2ef8630cf86f2799b4689d6786bdf4e
References: <20180215103920.32017-1-a.hajda@samsung.com>
        <CGME20180215103928eucas1p1b2ef8630cf86f2799b4689d6786bdf4e@eucas1p1.samsung.com>
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Since extcon property is not allowed in DT, extcon subsystem requires
another way to get extcon device. Lets try the simplest approach - get
edev by of_node.

Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
Acked-by: Chanwoo Choi <cw00.choi@samsung.com>
---
v2: changed label to follow local convention (Chanwoo)
---
 drivers/extcon/extcon.c | 44 ++++++++++++++++++++++++++++++++++----------
 include/linux/extcon.h  |  6 ++++++
 2 files changed, 40 insertions(+), 10 deletions(-)

diff --git a/drivers/extcon/extcon.c b/drivers/extcon/extcon.c
index cb38c2747684..c4972c4cb3bd 100644
--- a/drivers/extcon/extcon.c
+++ b/drivers/extcon/extcon.c
@@ -1336,6 +1336,28 @@ void extcon_dev_unregister(struct extcon_dev *edev)
 EXPORT_SYMBOL_GPL(extcon_dev_unregister);
 
 #ifdef CONFIG_OF
+
+/*
+ * extcon_get_edev_by_of_node - Get the extcon device from devicetree.
+ * @node	: OF node identyfying edev
+ *
+ * Return the pointer of extcon device if success or ERR_PTR(err) if fail.
+ */
+struct extcon_dev *extcon_get_edev_by_of_node(struct device_node *node)
+{
+	struct extcon_dev *edev;
+
+	mutex_lock(&extcon_dev_list_lock);
+	list_for_each_entry(edev, &extcon_dev_list, entry)
+		if (edev->dev.parent && edev->dev.parent->of_node == node)
+			goto out;
+	edev = ERR_PTR(-EPROBE_DEFER);
+out:
+	mutex_unlock(&extcon_dev_list_lock);
+
+	return edev;
+}
+
 /*
  * extcon_get_edev_by_phandle - Get the extcon device from devicetree.
  * @dev		: the instance to the given device
@@ -1363,25 +1385,27 @@ struct extcon_dev *extcon_get_edev_by_phandle(struct device *dev, int index)
 		return ERR_PTR(-ENODEV);
 	}
 
-	mutex_lock(&extcon_dev_list_lock);
-	list_for_each_entry(edev, &extcon_dev_list, entry) {
-		if (edev->dev.parent && edev->dev.parent->of_node == node) {
-			mutex_unlock(&extcon_dev_list_lock);
-			of_node_put(node);
-			return edev;
-		}
-	}
-	mutex_unlock(&extcon_dev_list_lock);
+	edev = extcon_get_edev_by_of_node(node);
 	of_node_put(node);
 
-	return ERR_PTR(-EPROBE_DEFER);
+	return edev;
 }
+
 #else
+
+struct extcon_dev *extcon_get_edev_by_of_node(struct device_node *node)
+{
+	return ERR_PTR(-ENOSYS);
+}
+
 struct extcon_dev *extcon_get_edev_by_phandle(struct device *dev, int index)
 {
 	return ERR_PTR(-ENOSYS);
 }
+
 #endif /* CONFIG_OF */
+
+EXPORT_SYMBOL_GPL(extcon_get_edev_by_of_node);
 EXPORT_SYMBOL_GPL(extcon_get_edev_by_phandle);
 
 /**
diff --git a/include/linux/extcon.h b/include/linux/extcon.h
index 6d94e82c8ad9..b47e0c7f01fe 100644
--- a/include/linux/extcon.h
+++ b/include/linux/extcon.h
@@ -230,6 +230,7 @@ extern void devm_extcon_unregister_notifier_all(struct device *dev,
  * Following APIs get the extcon_dev from devicetree or by through extcon name.
  */
 extern struct extcon_dev *extcon_get_extcon_dev(const char *extcon_name);
+extern struct extcon_dev *extcon_get_edev_by_of_node(struct device_node *node);
 extern struct extcon_dev *extcon_get_edev_by_phandle(struct device *dev,
 						     int index);
 
@@ -283,6 +284,11 @@ static inline struct extcon_dev *extcon_get_extcon_dev(const char *extcon_name)
 	return ERR_PTR(-ENODEV);
 }
 
+static inline struct extcon_dev *extcon_get_edev_by_of_node(struct device_node *node)
+{
+	return ERR_PTR(-ENODEV);
+}
+
 static inline struct extcon_dev *extcon_get_edev_by_phandle(struct device *dev,
 				int index)
 {
-- 
2.16.1

