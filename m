Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11B4CC43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:50:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D240D20651
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:50:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546865400;
	bh=TNbPkR/p5zG9Fawy6vR9XHqrWCYQub5ocFpa4ldxKP4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=OLDoAYCdAUdAbtra6zJGl9fYT79X9qb8zF5spPvqOEbwrVD9cjqimr6gJk7DM84/7
	 zzKOj7+txLMSy5yTjhZvVUmEgBcYcJN4NQW+YAOsfoILpby/ety1MQdxI94456JBG4
	 5PlMMQo7aTmadba/gCXCq+J+SHxSYoEh0S25u1Qw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729522AbfAGMt7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 07:49:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:40744 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728562AbfAGMt5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 07:49:57 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2FF2D20651;
        Mon,  7 Jan 2019 12:49:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546865396;
        bh=TNbPkR/p5zG9Fawy6vR9XHqrWCYQub5ocFpa4ldxKP4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=G3/bTUPLFFWx7BY5S5Z26yttGfhi1RU0OFlbN1G2c3dw72DDLUBoYKWePXj+qwrml
         REJnSFaMNrar8UomhB4FF2Dut2xwhSmKJ1yzfL5q66CKPy9Hu42u+BPm47FunDWABq
         IQhiQ6UUKvSmJlCI+HW9y7Hk0UboNpGYgUXppKVY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Scott Chen <scott@labau.com.tw>,
        Johan Hovold <johan@kernel.org>
Subject: [PATCH 4.19 077/170] USB: serial: pl2303: add ids for Hewlett-Packard HP POS pole displays
Date:   Mon,  7 Jan 2019 13:31:44 +0100
Message-Id: <20190107104502.163267107@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190107104452.953560660@linuxfoundation.org>
References: <20190107104452.953560660@linuxfoundation.org>
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

From: Scott Chen <scott@labau.com.tw>

commit 8d503f206c336677954160ac62f0c7d9c219cd89 upstream.

Add device ids to pl2303 for the HP POS pole displays:
LM920:   03f0:026b
TD620:   03f0:0956
LD960TA: 03f0:4439
LD220TA: 03f0:4349
LM940:   03f0:5039

Signed-off-by: Scott Chen <scott@labau.com.tw>
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/serial/pl2303.c |    5 +++++
 drivers/usb/serial/pl2303.h |    5 +++++
 2 files changed, 10 insertions(+)

--- a/drivers/usb/serial/pl2303.c
+++ b/drivers/usb/serial/pl2303.c
@@ -91,9 +91,14 @@ static const struct usb_device_id id_tab
 	{ USB_DEVICE(YCCABLE_VENDOR_ID, YCCABLE_PRODUCT_ID) },
 	{ USB_DEVICE(SUPERIAL_VENDOR_ID, SUPERIAL_PRODUCT_ID) },
 	{ USB_DEVICE(HP_VENDOR_ID, HP_LD220_PRODUCT_ID) },
+	{ USB_DEVICE(HP_VENDOR_ID, HP_LD220TA_PRODUCT_ID) },
 	{ USB_DEVICE(HP_VENDOR_ID, HP_LD960_PRODUCT_ID) },
+	{ USB_DEVICE(HP_VENDOR_ID, HP_LD960TA_PRODUCT_ID) },
 	{ USB_DEVICE(HP_VENDOR_ID, HP_LCM220_PRODUCT_ID) },
 	{ USB_DEVICE(HP_VENDOR_ID, HP_LCM960_PRODUCT_ID) },
+	{ USB_DEVICE(HP_VENDOR_ID, HP_LM920_PRODUCT_ID) },
+	{ USB_DEVICE(HP_VENDOR_ID, HP_LM940_PRODUCT_ID) },
+	{ USB_DEVICE(HP_VENDOR_ID, HP_TD620_PRODUCT_ID) },
 	{ USB_DEVICE(CRESSI_VENDOR_ID, CRESSI_EDY_PRODUCT_ID) },
 	{ USB_DEVICE(ZEAGLE_VENDOR_ID, ZEAGLE_N2ITION3_PRODUCT_ID) },
 	{ USB_DEVICE(SONY_VENDOR_ID, SONY_QN3USB_PRODUCT_ID) },
--- a/drivers/usb/serial/pl2303.h
+++ b/drivers/usb/serial/pl2303.h
@@ -119,10 +119,15 @@
 
 /* Hewlett-Packard POS Pole Displays */
 #define HP_VENDOR_ID		0x03f0
+#define HP_LM920_PRODUCT_ID	0x026b
+#define HP_TD620_PRODUCT_ID	0x0956
 #define HP_LD960_PRODUCT_ID	0x0b39
 #define HP_LCM220_PRODUCT_ID	0x3139
 #define HP_LCM960_PRODUCT_ID	0x3239
 #define HP_LD220_PRODUCT_ID	0x3524
+#define HP_LD220TA_PRODUCT_ID	0x4349
+#define HP_LD960TA_PRODUCT_ID	0x4439
+#define HP_LM940_PRODUCT_ID	0x5039
 
 /* Cressi Edy (diving computer) PC interface */
 #define CRESSI_VENDOR_ID	0x04b8


