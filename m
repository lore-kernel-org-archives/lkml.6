Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C07CCC4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 06:27:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83BC4208A6
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 06:27:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83BC4208A6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728570AbeHUJpu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 05:45:50 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:56426 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726228AbeHUJpt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 05:45:49 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 659CBBE1;
        Tue, 21 Aug 2018 06:27:02 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Movie Song <MovieSong@aten-itlab.cn>,
        Johan Hovold <johan@kernel.org>
Subject: [PATCH 4.14 19/29] USB: serial: pl2303: add a new device id for ATEN
Date:   Tue, 21 Aug 2018 08:21:12 +0200
Message-Id: <20180821055109.160720001@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180821055108.333930282@linuxfoundation.org>
References: <20180821055108.333930282@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Movie Song <MovieSong@aten-itlab.cn>

commit 29c692c96b3a39cd1911fb79cd2505af8d070f07 upstream.

Signed-off-by: Movie Song <MovieSong@aten-itlab.cn>
Cc: Johan Hovold <johan@kernel.org>
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/serial/pl2303.c |    2 ++
 drivers/usb/serial/pl2303.h |    1 +
 2 files changed, 3 insertions(+)

--- a/drivers/usb/serial/pl2303.c
+++ b/drivers/usb/serial/pl2303.c
@@ -55,6 +55,8 @@ static const struct usb_device_id id_tab
 		.driver_info = PL2303_QUIRK_ENDPOINT_HACK },
 	{ USB_DEVICE(ATEN_VENDOR_ID, ATEN_PRODUCT_UC485),
 		.driver_info = PL2303_QUIRK_ENDPOINT_HACK },
+	{ USB_DEVICE(ATEN_VENDOR_ID, ATEN_PRODUCT_UC232B),
+		.driver_info = PL2303_QUIRK_ENDPOINT_HACK },
 	{ USB_DEVICE(ATEN_VENDOR_ID, ATEN_PRODUCT_ID2) },
 	{ USB_DEVICE(ATEN_VENDOR_ID2, ATEN_PRODUCT_ID) },
 	{ USB_DEVICE(ELCOM_VENDOR_ID, ELCOM_PRODUCT_ID) },
--- a/drivers/usb/serial/pl2303.h
+++ b/drivers/usb/serial/pl2303.h
@@ -29,6 +29,7 @@
 #define ATEN_VENDOR_ID2		0x0547
 #define ATEN_PRODUCT_ID		0x2008
 #define ATEN_PRODUCT_UC485	0x2021
+#define ATEN_PRODUCT_UC232B	0x2022
 #define ATEN_PRODUCT_ID2	0x2118
 
 #define IODATA_VENDOR_ID	0x04bb


