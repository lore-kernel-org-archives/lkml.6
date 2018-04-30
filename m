Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2075229-1525126688-2-3958629070453398189
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, MAILING_LIST_MULTI -1, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5,
  LANGUAGES ensk.us-ascii, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525126688; b=dvHpCv8ZV7eEyEPE27+TEmgJIFJpeQet15pLOR+jZiexpxG/Tm
    JKlB7WnIso8gOiX7xfHCX5Rboz5ymDN5XERCES8IFWQ4dkUtw8i8iTYUwCV7I9n+
    YP50rFuSCa2We0aFL5ZJjl8ze0Viqlqs7+TNoXZTwLwpf0tLcc5WpaSNeS7bOhPo
    X2BTXINqOqaAwb+zbg88AQbr/VsWvnlcS6zkRRV0GroG5BMd74US1h0G/VgMwBOx
    ngLudXvgD/oEhGwqVy6DD4T385qRDySsPkQswuqGdxGEgGytEl19EulsBo+G1Z8I
    CLGRv2E6dJ4uygp3btR9fS+Co4ioW5uFVDMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:in-reply-to:references:sender:list-id;
    s=fm2; t=1525126688; bh=/JAav4AjmzoQzc8oYvw1ouzGZzoz4BcglFfQ9Hh
    LSJQ=; b=Sh3M3IKtRCm//pwb9Df57VkVE+l2nfaCu/0DsNqjDXyvQnnZpJVMIIR
    xUOKqyEI2dTfcbWVdaUyteI2JnKzzj41/BhtIfw1OrQc6jzM4usj0r6nW/xerDt1
    VcSor3MTrYo8sT0cw8Yy9UT8SbI3ivGYLcGpAudjDjovMSe3YRN6lW2dm5UiXEvp
    GQND6ampHEUoFn5YYx7/ZGT3vk/umzRWocu58hdio5g96MGtnfR5PtNqwiJwaoZn
    VNUWGz4YA+2pkNpgHq1R1fBb4x+BAAf8SXkFmCnynXjjuHnn576Yymjto5k946Td
    dp3NaHDWLikrrgtbLAcTFmdmey4WXOQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=25 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=25 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfGa+FMI38qEUhaqkAXrFMGo4Q9K/4cIzWHufKpGzHEAkquxMmmLu4llwM17ApoeVsxVXytbJO/yD5mDo58U65Gm8aKNNfnupVdSUu5UT2NsX2pOZb/yT
    etLSTC/W5f7voNhV3CX4LPWFFDUy8s7HVvzwemNyPLudBK0nkM3tqAXQTjSEUa3hiTfDl/4nIygrdP7ssHnXpdLX43Dphe/NrQOLLN5ciFNcMgbl+GSQfie4
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=VwQbUJbxAAAA:8
    a=q2PgIVKw4fGj3j7AW1QA:9 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755302AbeD3WR6 (ORCPT <rfc822;greg@kroah.com>);
        Mon, 30 Apr 2018 18:17:58 -0400
Received: from mailout.easymail.ca ([64.68.200.34]:43000 "EHLO
        mailout.easymail.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753482AbeD3WR4 (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Mon, 30 Apr 2018 18:17:56 -0400
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
From: "Shuah Khan (Samsung OSG)" <shuah@kernel.org>
To: valentina.manea.m@gmail.com, shuah@kernel.org,
        gregkh@linuxfoundation.org
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [REBASED PATCH 2/2] usbip: usbip_host: run rebind from exit when module is removed
Date: Mon, 30 Apr 2018 16:17:20 -0600
Message-Id: <b83a623aab86df09c49b37010848121f807c3fba.1525115738.git.shuah@kernel.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <9cfffc546fc9774a9e38e81b0f396866a9d8d11f.1525115738.git.shuah@kernel.org>
References: <9cfffc546fc9774a9e38e81b0f396866a9d8d11f.1525115738.git.shuah@kernel.org>
In-Reply-To: <9cfffc546fc9774a9e38e81b0f396866a9d8d11f.1525115738.git.shuah@kernel.org>
References: <9cfffc546fc9774a9e38e81b0f396866a9d8d11f.1525115738.git.shuah@kernel.org>
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

Signed-off-by: Shuah Khan (Samsung OSG) <shuah@kernel.org>
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

