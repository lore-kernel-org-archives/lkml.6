Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 546F3C6786E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 11:38:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01C0A20824
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 11:38:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vftN02I9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01C0A20824
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727593AbeJZUPH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 16:15:07 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:46093 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727469AbeJZUPG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 16:15:06 -0400
Received: by mail-pf1-f196.google.com with SMTP id r64-v6so385188pfb.13;
        Fri, 26 Oct 2018 04:38:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Qfdsm65N+TkoHRZ3C7uU7emhwoMURKbDMGXeS9V7VJE=;
        b=vftN02I9KX5exXORIa/+PRT7BnE8kEF7FZvI7xOozEs46N1b9G7qLtM/Eq5W+ebe1m
         HeR9e9lxamK8ASH8jm2O2hXPwL+xVYj8TCAepZFVRPI4bQ7yuUfpE3ZS83zUZQ5ijjAW
         DINgeaNJXhKjnBF90FKnccCfpcMzIx53WXV6krl3xeIRQUfOnKmnYHeoc4gtNGSAj/ay
         ToxMRUe3pl1tlOh11DmjVu8q+dAeCqIwbfr/slXN6H9t63tD11jCY7Kdoupdz01bJAj7
         3Vmk1FeLn/PEjckQv7VJ2cn6d1qvmmJaJwjX7GgLjBYK90VQdetXWSuGqrlVoMY6KUHz
         KGVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Qfdsm65N+TkoHRZ3C7uU7emhwoMURKbDMGXeS9V7VJE=;
        b=OGOfZfwp/zezceQvnhOlu2uG+Il3q+NKOi9VBfDHiGGwrtDc4zsKeq6aBeakhA8+dY
         Sq93W/bqCU9wdf4yfAOZ6NusbvLJ2ljwC8z6FgkOjksJb4IoqM4wnGw/nwWNfYT9Znys
         tGvBm31achd+h05GJWBpLRZPbvGuUTpNMWqkJ8FtONxBSlFKwfm2kmId/tBcwGm9IQnR
         NL1o5yAD7fVS2Z/LwwCJ6kxHLro81+0bVRNbpt/DBaFPYEQE1JMjzAEDhjkSGQen3Zmi
         apaShQMxW/4SPyQGXcfrt8jCp79r6rBg9pNvlauVaAfctFSMoXO4hHSI9na57nalIKTm
         kaTw==
X-Gm-Message-State: AGRZ1gK1OpXbUo8skXR2ua6EuXJnV2xqyOIYzDKM+DOwVypySls9pSfE
        INCmUTyjsRqZg+pomSs+6xbhGi8l5570Dg==
X-Google-Smtp-Source: AJdET5exrIEynH0/gXnEdyv0U/zdsssWd7n+mJ8oFCxJcyXgxCM1N13Lqq3BLSXpDOJBaziSJiCbcw==
X-Received: by 2002:a63:a16:: with SMTP id 22mr2874151pgk.318.1540553900587;
        Fri, 26 Oct 2018 04:38:20 -0700 (PDT)
Received: from localhost.localdomain ([45.56.155.182])
        by smtp.gmail.com with ESMTPSA id g65-v6sm14412823pfg.98.2018.10.26.04.38.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Oct 2018 04:38:20 -0700 (PDT)
From:   Dashi Cao <dscao999@gmail.com>
To:     linux-usb@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        Dashi Cao <dscao999@gmail.com>
Subject: [PATCH] Add support of TI ICDI to USB simple serial device
Date:   Fri, 26 Oct 2018 19:38:07 +0800
Message-Id: <20181026113807.20735-1-dscao999@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TI In-Circuit Debug Interface (ICDI) is a debugging interface for TI ARM microcontrollers. It has four USB interfaces and the first two of them are presented as standard ACM serial device. The 3rd interface is the debugging interface and it can be driven as a Linux USB simple serial device. With it, debugging sessions and firmware up/down loading are supported on Linux.

Signed-off-by: Dashi Cao <dscao999@gmail.com>
---
 drivers/usb/serial/usb-serial-simple.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/usb/serial/usb-serial-simple.c b/drivers/usb/serial/usb-serial-simple.c
index 4d0273508043..ae43088b659e 100644
--- a/drivers/usb/serial/usb-serial-simple.c
+++ b/drivers/usb/serial/usb-serial-simple.c
@@ -109,6 +109,11 @@ DEVICE(suunto, SUUNTO_IDS);
 	{ USB_DEVICE(0x908, 0x0004) }
 DEVICE(siemens_mpi, SIEMENS_IDS);
 
+/* TI In-Circuit Debug Interface */
+#define ICDI_IDS()              \
+	{ USB_DEVICE_INTERFACE_CLASS(0x1cbe, 0x00fd, USB_CLASS_VENDOR_SPEC) }
+DEVICE(ti_icdi, ICDI_IDS);
+
 /* All of the above structures mushed into two lists */
 static struct usb_serial_driver * const serial_drivers[] = {
 	&carelink_device,
@@ -124,6 +129,7 @@ static struct usb_serial_driver * const serial_drivers[] = {
 	&hp4x_device,
 	&suunto_device,
 	&siemens_mpi_device,
+	&ti_icdi_device,
 	NULL
 };
 
@@ -141,6 +147,7 @@ static const struct usb_device_id id_table[] = {
 	HP4X_IDS(),
 	SUUNTO_IDS(),
 	SIEMENS_IDS(),
+	ICDI_IDS(),
 	{ },
 };
 MODULE_DEVICE_TABLE(usb, id_table);
-- 
2.11.0

