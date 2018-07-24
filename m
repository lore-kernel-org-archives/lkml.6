Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A111ECDE5F
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 02:35:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E83320852
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 02:35:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BJitO7L0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E83320852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388410AbeGXDji (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 23:39:38 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:35917 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388201AbeGXDjh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 23:39:37 -0400
Received: by mail-pf1-f195.google.com with SMTP id d14-v6so482547pfo.3;
        Mon, 23 Jul 2018 19:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SwFRG0FL4g5OJ1XDPWrsJB0J2s9evAghzc5zodC55Vw=;
        b=BJitO7L0XwLsHr/2AW2XvpX7AGCQLJjtRct8KjzjD+gtzTQkVKF8h0cWDvaIdWHw1e
         cdgpuhlAdMXYD53gETA8S5k0t5sRWXf/QeG4LkUr6sCmtjNGedq3QgM9EBeGcrD2fhmb
         1fhmn44hDf52ft67J8PdiSpTpbMjlnGntuwB/2jJWT9odBy6BYU0jEEs25eV1/1W9IVU
         uafd040feUz7U8Nek05W368+LQwtEs/oFGkC2guJFpQLYcdlWIlOPFyk218M5sl4R2Pu
         rScps7OMsCS0XCgV84tQWDaRALbfarS5a/A1GywIVSdzBaSx9LpycFsuTAcnAbgf/C/R
         UoSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=SwFRG0FL4g5OJ1XDPWrsJB0J2s9evAghzc5zodC55Vw=;
        b=Vwp5s0/+intVOjSKdXObVF0baRyzTX98dU0zlbGJO9AsSUzZ4aKHVhXCzTIKfbwnrU
         eCLNyN9ElPzhi4bLxiHdcmiQcA2L9De3MZIrjYaSxiD/SPlum3FT2Qh6+OAKT+QZuO8q
         2rAu7SYi/y4Q5xey0p4JCJmzpgBSdSS8U5r83lxCjniF7mRRL383R6QHJcq457B8h38o
         i46C9Ru5r1JO65UJW0uyGXeC3kssRIMrn5MOUBczHxQ6MiItKiL9C54b497k4cXGSN1N
         D40Z2nDT/B0pX9l+K0AgfBHHkLuO86B6OYLhh36XdA02NOXywNAyVEYCXJnSzCRAWQMr
         auzw==
X-Gm-Message-State: AOUpUlHia3JsVPU0dGY2tMuKAlvPmn1SVxOiOOHsQhD29UMytl4GOhe9
        gfZ6j/SMoVH/OnWBpMfUIV0=
X-Google-Smtp-Source: AAOMgpczwll8/pdYvFI9aEYDU7usks+1d8+n+qKlo8S0Dbkp60XkJO4vydCtc2Vm9+/ynPS97RT6ng==
X-Received: by 2002:a62:8a83:: with SMTP id o3-v6mr15864397pfk.12.1532399728551;
        Mon, 23 Jul 2018 19:35:28 -0700 (PDT)
Received: from penguin.lxd ([146.74.94.74])
        by smtp.gmail.com with ESMTPSA id n9-v6sm20540942pfg.21.2018.07.23.19.35.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Jul 2018 19:35:27 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Marcus Folkesson <marcus.folkesson@gmail.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexey Khoroshilov <khoroshilov@ispras.ru>
Subject: [PATCH 4/5] Input: pxrc - do not store unneeded data in driver structure
Date:   Tue, 24 Jul 2018 02:35:19 +0000
Message-Id: <20180724023520.2189-4-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180724023520.2189-1-dmitry.torokhov@gmail.com>
References: <20180724023520.2189-1-dmitry.torokhov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no need to store data buffer size, pointer to the buffer, or endpoint
address in pxrc structure, as they are either only needed during setup, or are
available from elsewhere.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/joystick/pxrc.c | 35 +++++++++++++++++------------------
 1 file changed, 17 insertions(+), 18 deletions(-)

diff --git a/drivers/input/joystick/pxrc.c b/drivers/input/joystick/pxrc.c
index 327b5ef8515f..887a0df9d9a7 100644
--- a/drivers/input/joystick/pxrc.c
+++ b/drivers/input/joystick/pxrc.c
@@ -25,15 +25,13 @@ struct pxrc {
 	struct urb		*urb;
 	struct mutex		pm_mutex;
 	bool			is_open;
-	__u8			epaddr;
 	char			phys[64];
-	unsigned char           *data;
-	size_t			bsize;
 };
 
 static void pxrc_usb_irq(struct urb *urb)
 {
 	struct pxrc *pxrc = urb->context;
+	u8 *data = urb->transfer_buffer;
 	int error;
 
 	switch (urb->status) {
@@ -61,15 +59,15 @@ static void pxrc_usb_irq(struct urb *urb)
 	}
 
 	if (urb->actual_length == 8) {
-		input_report_abs(pxrc->input, ABS_X, pxrc->data[0]);
-		input_report_abs(pxrc->input, ABS_Y, pxrc->data[2]);
-		input_report_abs(pxrc->input, ABS_RX, pxrc->data[3]);
-		input_report_abs(pxrc->input, ABS_RY, pxrc->data[4]);
-		input_report_abs(pxrc->input, ABS_RUDDER, pxrc->data[5]);
-		input_report_abs(pxrc->input, ABS_THROTTLE, pxrc->data[6]);
-		input_report_abs(pxrc->input, ABS_MISC, pxrc->data[7]);
-
-		input_report_key(pxrc->input, BTN_A, pxrc->data[1]);
+		input_report_abs(pxrc->input, ABS_X, data[0]);
+		input_report_abs(pxrc->input, ABS_Y, data[2]);
+		input_report_abs(pxrc->input, ABS_RX, data[3]);
+		input_report_abs(pxrc->input, ABS_RY, data[4]);
+		input_report_abs(pxrc->input, ABS_RUDDER, data[5]);
+		input_report_abs(pxrc->input, ABS_THROTTLE, data[6]);
+		input_report_abs(pxrc->input, ABS_MISC, data[7]);
+
+		input_report_key(pxrc->input, BTN_A, data[1]);
 	}
 
 exit:
@@ -124,6 +122,8 @@ static int pxrc_usb_init(struct pxrc *pxrc)
 {
 	struct usb_device *udev = interface_to_usbdev(pxrc->intf);
 	struct usb_endpoint_descriptor *epirq;
+	size_t xfer_size;
+	void *xfer_buf;
 	unsigned int pipe;
 	int error;
 
@@ -136,10 +136,9 @@ static int pxrc_usb_init(struct pxrc *pxrc)
 		return error;
 	}
 
-	pxrc->bsize = usb_endpoint_maxp(epirq);
-	pxrc->epaddr = epirq->bEndpointAddress;
-	pxrc->data = devm_kmalloc(&pxrc->intf->dev, pxrc->bsize, GFP_KERNEL);
-	if (!pxrc->data)
+	xfer_size = usb_endpoint_maxp(epirq);
+	xfer_buf = devm_kmalloc(&pxrc->intf->dev, xfer_size, GFP_KERNEL);
+	if (!xfer_buf)
 		return -ENOMEM;
 
 	usb_set_intfdata(pxrc->intf, pxrc);
@@ -154,8 +153,8 @@ static int pxrc_usb_init(struct pxrc *pxrc)
 	if (error)
 		return error;
 
-	pipe = usb_rcvintpipe(udev, pxrc->epaddr),
-	usb_fill_int_urb(pxrc->urb, udev, pipe, pxrc->data, pxrc->bsize,
+	pipe = usb_rcvintpipe(udev, epirq->bEndpointAddress),
+	usb_fill_int_urb(pxrc->urb, udev, pipe, xfer_buf, xfer_size,
 			 pxrc_usb_irq, pxrc, 1);
 
 	return 0;
-- 
2.11.0

