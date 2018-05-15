Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1829694-1526352651-2-471393793002043279
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, MAILING_LIST_MULTI -1, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5,
  LANGUAGES enrosk.us-ascii, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526352650; b=CAwqDnzgneaY9Ce6OdUiz8URkIC9ZwTqKWo7aMegUZ1DtmDPuQ
    ovOWlg/ut+BAoy9dJYgLD/NfZmdhuy8i1sG0AW9zdfTn2osBeRJEfuhJ9RHjMnn8
    NSNo11GkR8c1LIkyMf2ATaXcImbxkvgKFIqPy9lh8IKgjqQXR/HuKMARUnC5ZIU4
    RgDv083oAnBB3EDuCCTGbvnE9c0eE/9YzY7OlP9z8Wx5QYFr+sz3Bb6vWuNi2/d4
    lcM653+gIj/wG0ShT9oy0NaEA+qRazxspdvkoTn4MBtar819a88EZsuLl+jrl7Fb
    daEKm/LWGypZMq3Hj690teaLmc0MqkmKL/aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=fm2; t=1526352650; bh=iwtlJjIEELOVJX4X3wGrG6bmaAalk5
    NkAxv0NRaKuqM=; b=ANpcZwBHU6LmpgtZxuLjNsJn4V1Yc4kLlATQ+qPp30OPwk
    sJAqGPhfQSyzURnsjIyWvga71eOj/rKgTbMMM6GN+QmNM/2lLe1hQioeXiX13J1c
    3UiAYhlOKs2ZKALI0gzUdwRbpS1h9q2VfXO2gM3qEb+Ge4YQO3/RBut2F1oPOztO
    GzhoAGAsp/HIMF0xSOHbx1NTmh5D/2CqaZrdNJE7GHtD0lqMjabiZ7m5+R2CAQOo
    dR0u7sLf+NebRmWSObXxkpDVnn2iOAgGSb0RhMxGJSSKP49HPtUAv8GcbreDXC+W
    F9we+bKKCqt5CkdXWQSuIe9KdtsvduRPf1Q+DGEA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJ+yzh0G4bvwxoijMVUnxeEd9m1xm5jDIKiwDPjxrqkEJDxNWhlkmtEwUy3J0rUHLFGnijjvhxdSWuh9iEXofMe1kHoSiFM1DXlOjJLS2QI+vuQuiKec
    hmTnvEePvjito8dvb3YOycUpdydipDuHgIbKXuv/awuF93HAPZ7+erRDdaK9oxTvBxzb+n6RepHWPrBY/E+2jh0x36MvIO/yaf9IefZRx4fgOY/xZT04JLvM
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=VwQbUJbxAAAA:8
    a=ebg8JBIvteSYkOY_OKcA:9 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752060AbeEOCu3 (ORCPT <rfc822;greg@kroah.com>);
        Mon, 14 May 2018 22:50:29 -0400
Received: from mailout.easymail.ca ([64.68.200.34]:55564 "EHLO
        mailout.easymail.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752044AbeEOCu3 (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Mon, 14 May 2018 22:50:29 -0400
From: "Shuah Khan (Samsung OSG)" <shuah@kernel.org>
To: valentina.manea.m@gmail.com, shuah@kernel.org,
        gregkh@linuxfoundation.org
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] usbip: usbip_host: fix NULL-ptr deref and use-after-free errors
Date: Mon, 14 May 2018 20:49:58 -0600
Message-Id: <20180515024958.3961-1-shuah@kernel.org>
X-Mailer: git-send-email 2.14.1
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

usbip_host updates device status without holding lock from stub probe,
disconnect and rebind code paths. When multiple requests to import a
device are received, these unprotected code paths step all over each
other and drive fails with NULL-ptr deref and use-after-free errors.

The driver uses a table lock to protect the busid array for adding and
deleting busids to the table. However, the probe, disconnect and rebind
paths get the busid table entry and update the status without holding
the busid table lock. Add a new finer grain lock to protect the busid
entry. This new lock will be held to search and update the busid entry
fields from get_busid_idx(), add_match_busid() and del_match_busid().

match_busid_show() does the same to access the busid entry fields.

get_busid_priv() changed to return the pointer to the busid entry holding
the busid lock. stub_probe(), stub_disconnect() and stub_device_rebind()
call put_busid_priv() to release the busid lock before returning. This
changes fixes the unprotected code paths eliminating the race conditions
in updating the busid entries.

Signed-off-by: Shuah Khan (Samsung OSG) <shuah@kernel.org>
---
 drivers/usb/usbip/stub.h      |  2 ++
 drivers/usb/usbip/stub_dev.c  | 33 +++++++++++++++++++++++----------
 drivers/usb/usbip/stub_main.c | 40 +++++++++++++++++++++++++++++++++++-----
 3 files changed, 60 insertions(+), 15 deletions(-)

diff --git a/drivers/usb/usbip/stub.h b/drivers/usb/usbip/stub.h
index 14a72357800a..35618ceb2791 100644
--- a/drivers/usb/usbip/stub.h
+++ b/drivers/usb/usbip/stub.h
@@ -73,6 +73,7 @@ struct bus_id_priv {
 	struct stub_device *sdev;
 	struct usb_device *udev;
 	char shutdown_busid;
+	spinlock_t busid_lock;
 };
 
 /* stub_priv is allocated from stub_priv_cache */
@@ -83,6 +84,7 @@ extern struct usb_device_driver stub_driver;
 
 /* stub_main.c */
 struct bus_id_priv *get_busid_priv(const char *busid);
+void put_busid_priv(struct bus_id_priv *bid);
 int del_match_busid(char *busid);
 void stub_device_cleanup_urbs(struct stub_device *sdev);
 
diff --git a/drivers/usb/usbip/stub_dev.c b/drivers/usb/usbip/stub_dev.c
index 9d0425113c4b..c0d6ff1baa72 100644
--- a/drivers/usb/usbip/stub_dev.c
+++ b/drivers/usb/usbip/stub_dev.c
@@ -300,7 +300,7 @@ static int stub_probe(struct usb_device *udev)
 	struct stub_device *sdev = NULL;
 	const char *udev_busid = dev_name(&udev->dev);
 	struct bus_id_priv *busid_priv;
-	int rc;
+	int rc = 0;
 
 	dev_dbg(&udev->dev, "Enter probe\n");
 
@@ -317,13 +317,15 @@ static int stub_probe(struct usb_device *udev)
 		 * other matched drivers by the driver core.
 		 * See driver_probe_device() in driver/base/dd.c
 		 */
-		return -ENODEV;
+		rc = -ENODEV;
+		goto call_put_busid_priv;
 	}
 
 	if (udev->descriptor.bDeviceClass == USB_CLASS_HUB) {
 		dev_dbg(&udev->dev, "%s is a usb hub device... skip!\n",
 			 udev_busid);
-		return -ENODEV;
+		rc = -ENODEV;
+		goto call_put_busid_priv;
 	}
 
 	if (!strcmp(udev->bus->bus_name, "vhci_hcd")) {
@@ -331,13 +333,16 @@ static int stub_probe(struct usb_device *udev)
 			"%s is attached on vhci_hcd... skip!\n",
 			udev_busid);
 
-		return -ENODEV;
+		rc = -ENODEV;
+		goto call_put_busid_priv;
 	}
 
 	/* ok, this is my device */
 	sdev = stub_device_alloc(udev);
-	if (!sdev)
-		return -ENOMEM;
+	if (!sdev) {
+		rc = -ENOMEM;
+		goto call_put_busid_priv;
+	}
 
 	dev_info(&udev->dev,
 		"usbip-host: register new device (bus %u dev %u)\n",
@@ -369,7 +374,9 @@ static int stub_probe(struct usb_device *udev)
 	}
 	busid_priv->status = STUB_BUSID_ALLOC;
 
-	return 0;
+	rc = 0;
+	goto call_put_busid_priv;
+
 err_files:
 	usb_hub_release_port(udev->parent, udev->portnum,
 			     (struct usb_dev_state *) udev);
@@ -379,6 +386,9 @@ static int stub_probe(struct usb_device *udev)
 
 	busid_priv->sdev = NULL;
 	stub_device_free(sdev);
+
+call_put_busid_priv:
+	put_busid_priv(busid_priv);
 	return rc;
 }
 
@@ -417,7 +427,7 @@ static void stub_disconnect(struct usb_device *udev)
 	/* get stub_device */
 	if (!sdev) {
 		dev_err(&udev->dev, "could not get device");
-		return;
+		goto call_put_busid_priv;
 	}
 
 	dev_set_drvdata(&udev->dev, NULL);
@@ -432,12 +442,12 @@ static void stub_disconnect(struct usb_device *udev)
 				  (struct usb_dev_state *) udev);
 	if (rc) {
 		dev_dbg(&udev->dev, "unable to release port\n");
-		return;
+		goto call_put_busid_priv;
 	}
 
 	/* If usb reset is called from event handler */
 	if (usbip_in_eh(current))
-		return;
+		goto call_put_busid_priv;
 
 	/* shutdown the current connection */
 	shutdown_busid(busid_priv);
@@ -450,6 +460,9 @@ static void stub_disconnect(struct usb_device *udev)
 
 	if (busid_priv->status == STUB_BUSID_ALLOC)
 		busid_priv->status = STUB_BUSID_ADDED;
+
+call_put_busid_priv:
+	put_busid_priv(busid_priv);
 }
 
 #ifdef CONFIG_PM
diff --git a/drivers/usb/usbip/stub_main.c b/drivers/usb/usbip/stub_main.c
index 587b9bc10042..41c7b9de2a92 100644
--- a/drivers/usb/usbip/stub_main.c
+++ b/drivers/usb/usbip/stub_main.c
@@ -26,6 +26,8 @@ static spinlock_t busid_table_lock;
 
 static void init_busid_table(void)
 {
+	int i;
+
 	/*
 	 * This also sets the bus_table[i].status to
 	 * STUB_BUSID_OTHER, which is 0.
@@ -33,6 +35,9 @@ static void init_busid_table(void)
 	memset(busid_table, 0, sizeof(busid_table));
 
 	spin_lock_init(&busid_table_lock);
+
+	for (i = 0; i < MAX_BUSID; i++)
+		spin_lock_init(&busid_table[i].busid_lock);
 }
 
 /*
@@ -44,15 +49,20 @@ static int get_busid_idx(const char *busid)
 	int i;
 	int idx = -1;
 
-	for (i = 0; i < MAX_BUSID; i++)
+	for (i = 0; i < MAX_BUSID; i++) {
+		spin_lock(&busid_table[i].busid_lock);
 		if (busid_table[i].name[0])
 			if (!strncmp(busid_table[i].name, busid, BUSID_SIZE)) {
 				idx = i;
+				spin_unlock(&busid_table[i].busid_lock);
 				break;
 			}
+		spin_unlock(&busid_table[i].busid_lock);
+	}
 	return idx;
 }
 
+/* Returns holding busid_lock. Should call put_busid_priv() to unlock */
 struct bus_id_priv *get_busid_priv(const char *busid)
 {
 	int idx;
@@ -60,13 +70,21 @@ struct bus_id_priv *get_busid_priv(const char *busid)
 
 	spin_lock(&busid_table_lock);
 	idx = get_busid_idx(busid);
-	if (idx >= 0)
+	if (idx >= 0) {
 		bid = &(busid_table[idx]);
+		/* get busid_lock before returning */
+		spin_lock(&bid->busid_lock);
+	}
 	spin_unlock(&busid_table_lock);
 
 	return bid;
 }
 
+void put_busid_priv(struct bus_id_priv *bid)
+{
+	spin_unlock(&bid->busid_lock);
+}
+
 static int add_match_busid(char *busid)
 {
 	int i;
@@ -79,15 +97,19 @@ static int add_match_busid(char *busid)
 		goto out;
 	}
 
-	for (i = 0; i < MAX_BUSID; i++)
+	for (i = 0; i < MAX_BUSID; i++) {
+		spin_lock(&busid_table[i].busid_lock);
 		if (!busid_table[i].name[0]) {
 			strlcpy(busid_table[i].name, busid, BUSID_SIZE);
 			if ((busid_table[i].status != STUB_BUSID_ALLOC) &&
 			    (busid_table[i].status != STUB_BUSID_REMOV))
 				busid_table[i].status = STUB_BUSID_ADDED;
 			ret = 0;
+			spin_unlock(&busid_table[i].busid_lock);
 			break;
 		}
+		spin_unlock(&busid_table[i].busid_lock);
+	}
 
 out:
 	spin_unlock(&busid_table_lock);
@@ -108,6 +130,8 @@ int del_match_busid(char *busid)
 	/* found */
 	ret = 0;
 
+	spin_lock(&busid_table[idx].busid_lock);
+
 	if (busid_table[idx].status == STUB_BUSID_OTHER)
 		memset(busid_table[idx].name, 0, BUSID_SIZE);
 
@@ -115,6 +139,7 @@ int del_match_busid(char *busid)
 	    (busid_table[idx].status != STUB_BUSID_ADDED))
 		busid_table[idx].status = STUB_BUSID_REMOV;
 
+	spin_unlock(&busid_table[idx].busid_lock);
 out:
 	spin_unlock(&busid_table_lock);
 
@@ -127,9 +152,12 @@ static ssize_t match_busid_show(struct device_driver *drv, char *buf)
 	char *out = buf;
 
 	spin_lock(&busid_table_lock);
-	for (i = 0; i < MAX_BUSID; i++)
+	for (i = 0; i < MAX_BUSID; i++) {
+		spin_lock(&busid_table[i].busid_lock);
 		if (busid_table[i].name[0])
 			out += sprintf(out, "%s ", busid_table[i].name);
+		spin_unlock(&busid_table[i].busid_lock);
+	}
 	spin_unlock(&busid_table_lock);
 	out += sprintf(out, "\n");
 
@@ -204,7 +232,7 @@ static void stub_device_rebind(void)
 	}
 	spin_unlock(&busid_table_lock);
 
-	/* now run rebind */
+	/* now run rebind - no need to hold locks. driver files are removed */
 	for (i = 0; i < MAX_BUSID; i++) {
 		if (busid_table[i].name[0] &&
 		    busid_table[i].shutdown_busid) {
@@ -234,6 +262,8 @@ static ssize_t rebind_store(struct device_driver *dev, const char *buf,
 
 	/* mark the device for deletion so probe ignores it during rescan */
 	bid->status = STUB_BUSID_OTHER;
+	/* release the busid lock */
+	put_busid_priv(bid);
 
 	ret = do_rebind((char *) buf, bid);
 	if (ret < 0)
-- 
2.14.1

