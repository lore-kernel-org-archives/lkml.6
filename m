Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-356304-1524842090-2-2832498328839606458
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524842089; b=TM7v0aPyq4oopuXjoEkfUu51Z/FbhT3MJKupYaVV1ESLQdjic0
    jhIeFm+mNY51Ptnj3H8fEJYA7nmrtycQGkxCOOvDdiKLFcE69I7OhiBw4JNbhZfK
    pVo70Ofs93OC7oDP+9EIjcvkYk5pyWultduIo+3Au45WzH4/cdymxN1jimB7inPF
    4mSdgjUTU2hx/vkAsTzZDvVtgkNI3I8Jr8FZpR5Tnk6gxakayK+VM5zdIceIK7xc
    udnTJeWKH4xJAEk7YQzfmoU/kaOifci5eqAULtYInsQ0HJiHSNAJuH3K1pa8MO6J
    rlKZldQjazcaDddjZvKWoKQqDh8JTLdlpwyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1524842089; bh=9Pn4TWeOt2Y5lwcQeZbRf2LxCYkLZG
    7NdVMeQMVVDAI=; b=V0FCA+Urj10XHDgpYvKCHd1wdr9U4kJVAOJBDrvmO3N3gZ
    IOx05MuKK4dOp4iGgtMSoVrnCFuxC9Gmap0x7dz1eEfR/3nzsdDKUvfbCWGv4hK2
    KqhCRfLEwv9qjjaACsTdg4nmA2M4otGNKoxPnIpimXx/tLIxIM1Lnhz7R7NyJN5d
    EVNCEH8e9yDDmij0aBQsJ6btvs//OJh0RcqVqo6KIi5J9DW90ShsJW+qsB5ACVFm
    W/N3VGU/JmboN6mpaTP0qGG2iimALj+OvcyUMFFfkBzT28U+G+IqSHU+r2HZ2QQl
    d6JoTvxppKl0iOScdZMDnpBUnWL1WmA7QnY313LA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfGxtSHzdpBJ4p9QfSqDIJFivm5RoZwYQxKTah9dszqTkmxveURgrSHG1gJmajPsJr6vyE6wElrBXQG0+6gDW4O8Z4wysRIeRhYysoXhBKsljKd8DYvGd
    xrA/teyYuIK675MSB3tJGXiXo1sqpwf2aq2YUWBDUYhDzYnXcAOVO0b8UBRw+rl3v9osNqedayIwR6DHrMAQOAq/4hAKt9Po+iVdZPVXzqsVO/LjyOQsE4Rc
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=yPCof4ZbAAAA:8 a=vQBBkBfzAAAA:8 a=KKAkSRfTAAAA:8 a=ag1SF4gXAAAA:8
    a=kgX1SPd-Y8VvySS0JRsA:9 a=QEXdDO2ut3YA:10 a=jIce5Xh-_3wA:10
    a=NGXS0kB0m_rannUenejW:22 a=cvBusfyB2V15izCimMoJ:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933637AbeD0POk (ORCPT <rfc822;greg@kroah.com>);
        Fri, 27 Apr 2018 11:14:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:50262 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932835AbeD0ODs (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 27 Apr 2018 10:03:48 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A309621890
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        Amit Pundir <amit.pundir@linaro.org>
Subject: [PATCH 4.9 14/74] [media] stk-webcam: fix an endian bug in stk_camera_read_reg()
Date: Fri, 27 Apr 2018 15:58:04 +0200
Message-Id: <20180427135710.494001755@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180427135709.899303463@linuxfoundation.org>
References: <20180427135709.899303463@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dan Carpenter <dan.carpenter@oracle.com>

commit d08876f524a605d64c7ca32cb8e9f5be3839e82e upstream.

We pass an int pointer to stk_camera_read_reg() but only write to the
highest byte.  It's a bug on big endian systems and generally a nasty
thing to do and doesn't match the write function either.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Cc: Amit Pundir <amit.pundir@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/media/usb/stkwebcam/stk-sensor.c |    6 +++---
 drivers/media/usb/stkwebcam/stk-webcam.c |   11 ++++++-----
 drivers/media/usb/stkwebcam/stk-webcam.h |    2 +-
 3 files changed, 10 insertions(+), 9 deletions(-)

--- a/drivers/media/usb/stkwebcam/stk-sensor.c
+++ b/drivers/media/usb/stkwebcam/stk-sensor.c
@@ -228,7 +228,7 @@
 static int stk_sensor_outb(struct stk_camera *dev, u8 reg, u8 val)
 {
 	int i = 0;
-	int tmpval = 0;
+	u8 tmpval = 0;
 
 	if (stk_camera_write_reg(dev, STK_IIC_TX_INDEX, reg))
 		return 1;
@@ -253,7 +253,7 @@ static int stk_sensor_outb(struct stk_ca
 static int stk_sensor_inb(struct stk_camera *dev, u8 reg, u8 *val)
 {
 	int i = 0;
-	int tmpval = 0;
+	u8 tmpval = 0;
 
 	if (stk_camera_write_reg(dev, STK_IIC_RX_INDEX, reg))
 		return 1;
@@ -274,7 +274,7 @@ static int stk_sensor_inb(struct stk_cam
 	if (stk_camera_read_reg(dev, STK_IIC_RX_VALUE, &tmpval))
 		return 1;
 
-	*val = (u8) tmpval;
+	*val = tmpval;
 	return 0;
 }
 
--- a/drivers/media/usb/stkwebcam/stk-webcam.c
+++ b/drivers/media/usb/stkwebcam/stk-webcam.c
@@ -144,7 +144,7 @@ int stk_camera_write_reg(struct stk_came
 		return 0;
 }
 
-int stk_camera_read_reg(struct stk_camera *dev, u16 index, int *value)
+int stk_camera_read_reg(struct stk_camera *dev, u16 index, u8 *value)
 {
 	struct usb_device *udev = dev->udev;
 	unsigned char *buf;
@@ -163,7 +163,7 @@ int stk_camera_read_reg(struct stk_camer
 			sizeof(u8),
 			500);
 	if (ret >= 0)
-		memcpy(value, buf, sizeof(u8));
+		*value = *buf;
 
 	kfree(buf);
 	return ret;
@@ -171,9 +171,10 @@ int stk_camera_read_reg(struct stk_camer
 
 static int stk_start_stream(struct stk_camera *dev)
 {
-	int value;
+	u8 value;
 	int i, ret;
-	int value_116, value_117;
+	u8 value_116, value_117;
+
 
 	if (!is_present(dev))
 		return -ENODEV;
@@ -213,7 +214,7 @@ static int stk_start_stream(struct stk_c
 
 static int stk_stop_stream(struct stk_camera *dev)
 {
-	int value;
+	u8 value;
 	int i;
 	if (is_present(dev)) {
 		stk_camera_read_reg(dev, 0x0100, &value);
--- a/drivers/media/usb/stkwebcam/stk-webcam.h
+++ b/drivers/media/usb/stkwebcam/stk-webcam.h
@@ -129,7 +129,7 @@ struct stk_camera {
 #define vdev_to_camera(d) container_of(d, struct stk_camera, vdev)
 
 int stk_camera_write_reg(struct stk_camera *, u16, u8);
-int stk_camera_read_reg(struct stk_camera *, u16, int *);
+int stk_camera_read_reg(struct stk_camera *, u16, u8 *);
 
 int stk_sensor_init(struct stk_camera *);
 int stk_sensor_configure(struct stk_camera *);
