Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DEB1C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 12:02:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3B1620880
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 12:02:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548763339;
	bh=wXp6vexW0dabKvW9xhzaHZv4NGM+RdTYpuhsb7BQUGI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jL2IFaAeL+shVUr8wgNtlljl4VAhA56pju5K4WvxLrU8oQ2tD3/slDoWEF7h0enD4
	 18rV7pSz95hlAUzYz5So5YWb4sWC36XHU5FUQ/JgU741i1dhAT3xhV1L2n9TtGqdt2
	 h2i5hCkTWPK3sw8aDDSOOsRfgQ1/lxBD6IGt5P3M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730893AbfA2MCQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 07:02:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:35404 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730667AbfA2LpA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 06:45:00 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8C49C214DA;
        Tue, 29 Jan 2019 11:44:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548762300;
        bh=wXp6vexW0dabKvW9xhzaHZv4NGM+RdTYpuhsb7BQUGI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=I4tI4F/ecTdLdc8A8gMFdt7y/IHnls0zq/nQH4ZLvGTl4ckXxl1FrbGoGPCKF09TL
         V2YwXwY3biv+EHo1PGNpRvvDnXwoaOyTq5+LBHp1pI0F0l2AmZyHaoZUW62NDaEWyM
         w03e+ghnCPMf9Q2vk6bBCBmKWTfKBhU2pDQcmtvI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Charles Yeh <charlesyeh522@gmail.com>,
        Johan Hovold <johan@kernel.org>
Subject: [PATCH 4.19 026/103] USB: serial: pl2303: add new PID to support PL2303TB
Date:   Tue, 29 Jan 2019 12:35:03 +0100
Message-Id: <20190129113201.148142703@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190129113159.567154026@linuxfoundation.org>
References: <20190129113159.567154026@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Charles Yeh <charlesyeh522@gmail.com>

commit 4dcf9ddc9ad5ab649abafa98c5a4d54b1a33dabb upstream.

Add new PID to support PL2303TB (TYPE_HX)

Signed-off-by: Charles Yeh <charlesyeh522@gmail.com>
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/serial/pl2303.c |    1 +
 drivers/usb/serial/pl2303.h |    2 ++
 2 files changed, 3 insertions(+)

--- a/drivers/usb/serial/pl2303.c
+++ b/drivers/usb/serial/pl2303.c
@@ -46,6 +46,7 @@ static const struct usb_device_id id_tab
 	{ USB_DEVICE(PL2303_VENDOR_ID, PL2303_PRODUCT_ID_HCR331) },
 	{ USB_DEVICE(PL2303_VENDOR_ID, PL2303_PRODUCT_ID_MOTOROLA) },
 	{ USB_DEVICE(PL2303_VENDOR_ID, PL2303_PRODUCT_ID_ZTEK) },
+	{ USB_DEVICE(PL2303_VENDOR_ID, PL2303_PRODUCT_ID_TB) },
 	{ USB_DEVICE(IODATA_VENDOR_ID, IODATA_PRODUCT_ID) },
 	{ USB_DEVICE(IODATA_VENDOR_ID, IODATA_PRODUCT_ID_RSAQ5) },
 	{ USB_DEVICE(ATEN_VENDOR_ID, ATEN_PRODUCT_ID),
--- a/drivers/usb/serial/pl2303.h
+++ b/drivers/usb/serial/pl2303.h
@@ -8,6 +8,7 @@
 
 #define PL2303_VENDOR_ID	0x067b
 #define PL2303_PRODUCT_ID	0x2303
+#define PL2303_PRODUCT_ID_TB		0x2304
 #define PL2303_PRODUCT_ID_RSAQ2		0x04bb
 #define PL2303_PRODUCT_ID_DCU11		0x1234
 #define PL2303_PRODUCT_ID_PHAROS	0xaaa0
@@ -20,6 +21,7 @@
 #define PL2303_PRODUCT_ID_MOTOROLA	0x0307
 #define PL2303_PRODUCT_ID_ZTEK		0xe1f1
 
+
 #define ATEN_VENDOR_ID		0x0557
 #define ATEN_VENDOR_ID2		0x0547
 #define ATEN_PRODUCT_ID		0x2008


