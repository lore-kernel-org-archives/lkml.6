Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1691122-1527155058-2-16308991348504628826
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES enrosk.us-ascii, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527155057; b=ZBqwkjrrFR33QpJk+LoA+tSu+SmJ6E2TXUp54vbjqiI6O7MmdS
    yjVUMIOekGk2S7Nzgv16M4LcFm6qTWgvKFaF6lgkdZecQIykuj/y7F2pJNmdMLbO
    FBL4AfAgvronELN/wApbhGWHV2eGYF6S8U6q5YQn46qo8SQDKLpfjGqBGGR/RayH
    wQfA1jdR26iAM2+9xrFXBondftnsf4zOvZQ1eRg1cRuPDZqQr66+ubQtho8+n6WR
    sYQB1h+yWT61TwTmO10b2CC/nyof+0kq1pTQ7S/Cq/xdtzObbcf/tQQiLAJAawmL
    V2g3UXkEOXOwzFZgaBUVa/YAm8MtfW+Cmt6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527155057; bh=DTfHDuSGudnLH7Ct0D2HoJcnncZoNf
    oXfVsxBaY9TnQ=; b=R6I+XyqHAHgT2XVAkCoklOOEwk+0cDL5YDWWAX9VZK1Z/g
    Jxbp+uWwaQq3NhvsBQUWVW+yC+HnUNphLdu87XYxQzplCBR57Ef0s8aOHwQBcSHf
    4deMGSIl0QUju4WhKJX6FgUBT0VZ8XDchnZV0ngtgIThTHjcSPSYnBMiglpwLiZZ
    UN+vC+FhJwGaPKnWFR8EC3No6yU7DwFK/AXkeHplwtUxk137eynGy5rQBZMdu6mM
    rJnW98PA0aLk9E9ypWS9JkNYH+mHmsIjs1nic9GRd+TWGM8Dc0uXKlfTTvlcaIVj
    buGd8WozWy80UiwGFjqlvunz3TpK+XI70PlF84qA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=YkXu51QD x-bits=1024 x-keytype=rsa
    x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linuxfoundation.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=YkXu51QD x-bits=1024 x-keytype=rsa
      x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linuxfoundation.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfBA/4mCpJVi4NNqk6cAK538ctG83P5e2z64xOFfxGi661GTXH9jRTxgV/qMDPvy+cN60t0GzcCNYOZQ3SI0OuUxR8hygVIuXu+INxgGb+QM11ZvcD+dv
    dwP9BfmgMBczjZjGg/eB0uDfSnonOG2tSsWXJq/UgltwZks4ZZ3opTlzxVQ6GKHZQgi8X0r5JbFHpYxsTlREoyjlZB92WtvaocSzxWTPsnAjdB68/Z8U6HZA
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=VwQbUJbxAAAA:8 a=ag1SF4gXAAAA:8 a=-2KsmTQV1cPCrS9TMnsA:9 a=QEXdDO2ut3YA:10
    a=AjGcO6oz07-iQ99wixmX:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966182AbeEXJoP (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 05:44:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:55570 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966584AbeEXJoN (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:44:13 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Shuah Khan (Samsung OSG)" <shuah@kernel.org>
Subject: [PATCH 4.4 36/92] usbip: usbip_host: fix NULL-ptr deref and use-after-free errors
Date: Thu, 24 May 2018 11:38:13 +0200
Message-Id: <20180524093202.439476092@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093159.286472249@linuxfoundation.org>
References: <20180524093159.286472249@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Shuah Khan (Samsung OSG) <shuah@kernel.org>

commit 22076557b07c12086eeb16b8ce2b0b735f7a27e7 upstream.

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

Reported-by: Jakub Jirasek
Signed-off-by: Shuah Khan (Samsung OSG) <shuah@kernel.org>
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/usbip/stub.h      |    2 ++
 drivers/usb/usbip/stub_dev.c  |   33 +++++++++++++++++++++++----------
 drivers/usb/usbip/stub_main.c |   40 +++++++++++++++++++++++++++++++++++-----
 3 files changed, 60 insertions(+), 15 deletions(-)

--- a/drivers/usb/usbip/stub.h
+++ b/drivers/usb/usbip/stub.h
@@ -88,6 +88,7 @@ struct bus_id_priv {
 	struct stub_device *sdev;
 	struct usb_device *udev;
 	char shutdown_busid;
+	spinlock_t busid_lock;
 };
 
 /* stub_priv is allocated from stub_priv_cache */
@@ -98,6 +99,7 @@ extern struct usb_device_driver stub_dri
 
 /* stub_main.c */
 struct bus_id_priv *get_busid_priv(const char *busid);
+void put_busid_priv(struct bus_id_priv *bid);
 int del_match_busid(char *busid);
 void stub_device_cleanup_urbs(struct stub_device *sdev);
 
--- a/drivers/usb/usbip/stub_dev.c
+++ b/drivers/usb/usbip/stub_dev.c
@@ -314,7 +314,7 @@ static int stub_probe(struct usb_device
 	struct stub_device *sdev = NULL;
 	const char *udev_busid = dev_name(&udev->dev);
 	struct bus_id_priv *busid_priv;
-	int rc;
+	int rc = 0;
 
 	dev_dbg(&udev->dev, "Enter probe\n");
 
@@ -331,13 +331,15 @@ static int stub_probe(struct usb_device
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
@@ -345,13 +347,16 @@ static int stub_probe(struct usb_device
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
@@ -383,7 +388,9 @@ static int stub_probe(struct usb_device
 	}
 	busid_priv->status = STUB_BUSID_ALLOC;
 
-	return 0;
+	rc = 0;
+	goto call_put_busid_priv;
+
 err_files:
 	usb_hub_release_port(udev->parent, udev->portnum,
 			     (struct usb_dev_state *) udev);
@@ -394,6 +401,9 @@ err_port:
 
 	busid_priv->sdev = NULL;
 	stub_device_free(sdev);
+
+call_put_busid_priv:
+	put_busid_priv(busid_priv);
 	return rc;
 }
 
@@ -432,7 +442,7 @@ static void stub_disconnect(struct usb_d
 	/* get stub_device */
 	if (!sdev) {
 		dev_err(&udev->dev, "could not get device");
-		return;
+		goto call_put_busid_priv;
 	}
 
 	dev_set_drvdata(&udev->dev, NULL);
@@ -447,12 +457,12 @@ static void stub_disconnect(struct usb_d
 				  (struct usb_dev_state *) udev);
 	if (rc) {
 		dev_dbg(&udev->dev, "unable to release port\n");
-		return;
+		goto call_put_busid_priv;
 	}
 
 	/* If usb reset is called from event handler */
 	if (busid_priv->sdev->ud.eh == current)
-		return;
+		goto call_put_busid_priv;
 
 	/* shutdown the current connection */
 	shutdown_busid(busid_priv);
@@ -465,6 +475,9 @@ static void stub_disconnect(struct usb_d
 
 	if (busid_priv->status == STUB_BUSID_ALLOC)
 		busid_priv->status = STUB_BUSID_ADDED;
+
+call_put_busid_priv:
+	put_busid_priv(busid_priv);
 }
 
 #ifdef CONFIG_PM
--- a/drivers/usb/usbip/stub_main.c
+++ b/drivers/usb/usbip/stub_main.c
@@ -40,6 +40,8 @@ static spinlock_t busid_table_lock;
 
 static void init_busid_table(void)
 {
+	int i;
+
 	/*
 	 * This also sets the bus_table[i].status to
 	 * STUB_BUSID_OTHER, which is 0.
@@ -47,6 +49,9 @@ static void init_busid_table(void)
 	memset(busid_table, 0, sizeof(busid_table));
 
 	spin_lock_init(&busid_table_lock);
+
+	for (i = 0; i < MAX_BUSID; i++)
+		spin_lock_init(&busid_table[i].busid_lock);
 }
 
 /*
@@ -58,15 +63,20 @@ static int get_busid_idx(const char *bus
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
@@ -74,13 +84,21 @@ struct bus_id_priv *get_busid_priv(const
 
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
@@ -93,15 +111,19 @@ static int add_match_busid(char *busid)
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
@@ -122,6 +144,8 @@ int del_match_busid(char *busid)
 	/* found */
 	ret = 0;
 
+	spin_lock(&busid_table[idx].busid_lock);
+
 	if (busid_table[idx].status == STUB_BUSID_OTHER)
 		memset(busid_table[idx].name, 0, BUSID_SIZE);
 
@@ -129,6 +153,7 @@ int del_match_busid(char *busid)
 	    (busid_table[idx].status != STUB_BUSID_ADDED))
 		busid_table[idx].status = STUB_BUSID_REMOV;
 
+	spin_unlock(&busid_table[idx].busid_lock);
 out:
 	spin_unlock(&busid_table_lock);
 
@@ -141,9 +166,12 @@ static ssize_t show_match_busid(struct d
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
 
@@ -219,7 +247,7 @@ static void stub_device_rebind(void)
 	}
 	spin_unlock(&busid_table_lock);
 
-	/* now run rebind */
+	/* now run rebind - no need to hold locks. driver files are removed */
 	for (i = 0; i < MAX_BUSID; i++) {
 		if (busid_table[i].name[0] &&
 		    busid_table[i].shutdown_busid) {
@@ -249,6 +277,8 @@ static ssize_t rebind_store(struct devic
 
 	/* mark the device for deletion so probe ignores it during rescan */
 	bid->status = STUB_BUSID_OTHER;
+	/* release the busid lock */
+	put_busid_priv(bid);
 
 	ret = do_rebind((char *) buf, bid);
 	if (ret < 0)
