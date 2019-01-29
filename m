Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDB24C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:39:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F7C62148E
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:39:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548761976;
	bh=67BygEHAoeqg/ZES9oCVbfuJ8pOWI8EWWLh7kuvl6GY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tMyNxC19rmjwgkFTTN5LSZlImc1Gr6PgqotljjWXQ6jrLj8aI0yVy5RuogpPCbj3f
	 JOX+P2SkEuOcQ9B2rqHc1XEOncnmY/Nb4DKgCkllHkJbr5HT7/cXHwY/sZDTtKKRga
	 gaJ0NBZl3l/kf3LEMTihBEA7ey+1Ovv5YoF/YgX8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729465AbfA2Lje (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 06:39:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:56222 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728861AbfA2Ljb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 06:39:31 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 19D0620857;
        Tue, 29 Jan 2019 11:39:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548761970;
        bh=67BygEHAoeqg/ZES9oCVbfuJ8pOWI8EWWLh7kuvl6GY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mxColH90DCx/x/jotXT7mvMJafDfT5fQupe0bQGdLklup9bWFeis69a+3QCTGAM/+
         iSOaJrDvhfeWYJTxr7yCCrnq1u+/X15aLw3s/RPppStbMtI6fF+D6+Q8tJDtHakcTB
         nhJBBEU9SypdK7Fj90XGEfu95TMuOX14vr6/7PsM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Charles Yeh <charlesyeh522@gmail.com>,
        Johan Hovold <johan@kernel.org>
Subject: [PATCH 4.20 030/117] USB: serial: pl2303: add new PID to support PL2303TB
Date:   Tue, 29 Jan 2019 12:34:41 +0100
Message-Id: <20190129113209.147108471@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190129113207.477505932@linuxfoundation.org>
References: <20190129113207.477505932@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

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


