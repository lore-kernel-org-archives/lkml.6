Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3705427-1523492079-2-13122225154504451046
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES ensk.us-ascii,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523492078; b=loaY1JNiFqrpkzuoE/hhhhr43RMHvUi3dXMun6Bhae0yMDKWFw
    HDbUKiRIQA/ZqZp56gwTb3pa3vr4/cDAd1vtYG4IOk01y0aqbMkwaHkrwEpFChxK
    9bhEAjum87SYgV0ZOYpfqYNH2lIM2thqiWm06x52yA5Ciayt10XcUY3o5qS75iFt
    zIMNm8qxAsJxLoK25I5oxUj/cMRSqyH4qeiGp7OkH7nUFB//av6a8yCfQlNl9Dcs
    /ldjRAbT7qrXhxsXVQhLr2lLDaCxLQjYCeBBYl9YXJ1Z59yK5iGD+9XdFVSfyXXe
    CT+3m+Q+ggR4JS8KhxJNG17hrOXA9scI34kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:in-reply-to:references:sender:list-id;
    s=fm2; t=1523492078; bh=LLGOJCbVPkX/zY2EmKwmPxifIH9bEfj6dXUm3fT
    n6PQ=; b=ID/a6/PEScztFC/FTDNyfod7YnSNxaCcZrJk9HZ0WvKnkaU9dfumbRZ
    Tab5GUPjRHH+SNZza3b2ynowzbVFIEA/LSUZg76V6p3ZAIxcuUPtr+8Qq3EpLJoa
    8qGUi68YJNVaC+jTtQxZD49s6p7+NGZdgcCZ/YOwY3LMs3L4ZhWQfj6WXlCo1RyM
    QP53JNFqkOpYHXlxsTvmuxc41rk4fXq7rkYVZiGyvXsKBwrVp5Ll96hPPXarkTQD
    +0PFpdvkZJPSAddVRR031TonwtEdGWV7P7uOGNnzIh1vYLFy8gUyOUjUZCiDeDk9
    YQKmmdyRKPjgAGSPorPAq5oK2ZbiUNw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=osg.samsung.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=osg.samsung.com header.result=pass header_org.domain=samsung.com header_org.result=pass header_is_org_domain=no;
    x-vs=clean score=25 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=osg.samsung.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=osg.samsung.com header.result=pass header_org.domain=samsung.com header_org.result=pass header_is_org_domain=no;
    x-vs=clean score=25 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfKrBRr6akjJrYBczMCq2WfM53PkVTo8q6fI3Xnw8OmXq8O1j+PaYssPH8H5qNeRD81lG5KAgMn2wSFfcSzX6AM6ITpyJNayDW8ZAFKA2je2XF/ZWVY7/
    RhyvPT59I+NK/+3X9nUflKvaoxpDpqN9cRMV6J2dRUcAhV3e0UYw7B43k6QK3SO1Gif19DKlhMkfk1o3dd42oX1UdnX1z88uXSDm7wUUdRUA9L63A6lAzhbV
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=hD80L64hAAAA:8
    a=VwQbUJbxAAAA:8 a=0WkJ3gViCowLhjC-u8sA:9 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752369AbeDLAOZ (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 20:14:25 -0400
Received: from osg.samsung.com ([64.30.133.232]:55601 "EHLO osg.samsung.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751870AbeDLAN6 (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Wed, 11 Apr 2018 20:13:58 -0400
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
From: Shuah Khan <shuahkh@osg.samsung.com>
To: valentina.manea.m@gmail.com, shuah@kernel.org,
        gregkh@linuxfoundation.org
Cc: Shuah Khan <shuahkh@osg.samsung.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] usbip: usbip_host: run rebind from exit when module is removed
Date: Wed, 11 Apr 2018 18:13:32 -0600
Message-Id: <89e7cd96307e6dd057510e66f045213d77b5fc4d.1523488629.git.shuahkh@osg.samsung.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <b6765a8e7116246649f6a90c56b12fc65bff9b14.1523488629.git.shuahkh@osg.samsung.com>
References: <b6765a8e7116246649f6a90c56b12fc65bff9b14.1523488629.git.shuahkh@osg.samsung.com>
In-Reply-To: <cover.1523488629.git.shuahkh@osg.samsung.com>
References: <cover.1523488629.git.shuahkh@osg.samsung.com>
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

After removing usbip_host module, devices it releases are left without
a driver. For example, when a keyboard or a mass storage device are
bound to usbip_host when it is removed, these devices are no longer
bound to any driver.

Fix it to run device_attach() from the module exit routine to restore
the devices to their original drivers. This includes cleanup changes
and moving device_attach() code to a common routine to be called from
rebind_store() and usbip_host_exit().

Signed-off-by: Shuah Khan <shuahkh@osg.samsung.com>
---
 drivers/usb/usbip/stub_dev.c  |  6 +----
 drivers/usb/usbip/stub_main.c | 60 ++++++++++++++++++++++++++++++++++++-------
 2 files changed, 52 insertions(+), 14 deletions(-)

diff --git a/drivers/usb/usbip/stub_dev.c b/drivers/usb/usbip/stub_dev.c
index 7813c1862941..9d0425113c4b 100644
--- a/drivers/usb/usbip/stub_dev.c
+++ b/drivers/usb/usbip/stub_dev.c
@@ -448,12 +448,8 @@ static void stub_disconnect(struct usb_device *udev)
 	busid_priv->sdev = NULL;
 	stub_device_free(sdev);
 
-	if (busid_priv->status == STUB_BUSID_ALLOC) {
+	if (busid_priv->status == STUB_BUSID_ALLOC)
 		busid_priv->status = STUB_BUSID_ADDED;
-	} else {
-		busid_priv->status = STUB_BUSID_OTHER;
-		del_match_busid((char *)udev_busid);
-	}
 }
 
 #ifdef CONFIG_PM
diff --git a/drivers/usb/usbip/stub_main.c b/drivers/usb/usbip/stub_main.c
index fb46bd62d538..587b9bc10042 100644
--- a/drivers/usb/usbip/stub_main.c
+++ b/drivers/usb/usbip/stub_main.c
@@ -14,6 +14,7 @@
 #define DRIVER_DESC "USB/IP Host Driver"
 
 struct kmem_cache *stub_priv_cache;
+
 /*
  * busid_tables defines matching busids that usbip can grab. A user can change
  * dynamically what device is locally used and what device is exported to a
@@ -169,6 +170,51 @@ static ssize_t match_busid_store(struct device_driver *dev, const char *buf,
 }
 static DRIVER_ATTR_RW(match_busid);
 
+static int do_rebind(char *busid, struct bus_id_priv *busid_priv)
+{
+	int ret;
+
+	/* device_attach() callers should hold parent lock for USB */
+	if (busid_priv->udev->dev.parent)
+		device_lock(busid_priv->udev->dev.parent);
+	ret = device_attach(&busid_priv->udev->dev);
+	if (busid_priv->udev->dev.parent)
+		device_unlock(busid_priv->udev->dev.parent);
+	if (ret < 0) {
+		dev_err(&busid_priv->udev->dev, "rebind failed\n");
+		return ret;
+	}
+	return 0;
+}
+
+static void stub_device_rebind(void)
+{
+#if IS_MODULE(CONFIG_USBIP_HOST)
+	struct bus_id_priv *busid_priv;
+	int i;
+
+	/* update status to STUB_BUSID_OTHER so probe ignores the device */
+	spin_lock(&busid_table_lock);
+	for (i = 0; i < MAX_BUSID; i++) {
+		if (busid_table[i].name[0] &&
+		    busid_table[i].shutdown_busid) {
+			busid_priv = &(busid_table[i]);
+			busid_priv->status = STUB_BUSID_OTHER;
+		}
+	}
+	spin_unlock(&busid_table_lock);
+
+	/* now run rebind */
+	for (i = 0; i < MAX_BUSID; i++) {
+		if (busid_table[i].name[0] &&
+		    busid_table[i].shutdown_busid) {
+			busid_priv = &(busid_table[i]);
+			do_rebind(busid_table[i].name, busid_priv);
+		}
+	}
+#endif
+}
+
 static ssize_t rebind_store(struct device_driver *dev, const char *buf,
 				 size_t count)
 {
@@ -189,16 +235,9 @@ static ssize_t rebind_store(struct device_driver *dev, const char *buf,
 	/* mark the device for deletion so probe ignores it during rescan */
 	bid->status = STUB_BUSID_OTHER;
 
-	/* device_attach() callers should hold parent lock for USB */
-	if (bid->udev->dev.parent)
-		device_lock(bid->udev->dev.parent);
-	ret = device_attach(&bid->udev->dev);
-	if (bid->udev->dev.parent)
-		device_unlock(bid->udev->dev.parent);
-	if (ret < 0) {
-		dev_err(&bid->udev->dev, "rebind failed\n");
+	ret = do_rebind((char *) buf, bid);
+	if (ret < 0)
 		return ret;
-	}
 
 	/* delete device from busid_table */
 	del_match_busid((char *) buf);
@@ -323,6 +362,9 @@ static void __exit usbip_host_exit(void)
 	 */
 	usb_deregister_device_driver(&stub_driver);
 
+	/* initiate scan to attach devices */
+	stub_device_rebind();
+
 	kmem_cache_destroy(stub_priv_cache);
 }
 
-- 
2.14.1

