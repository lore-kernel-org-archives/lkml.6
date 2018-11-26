Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8563CC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 11:06:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EE9C2089F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 11:06:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="durPv4bF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EE9C2089F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731645AbeKZWA1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 17:00:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:47342 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729543AbeKZWA0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 17:00:26 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 193AD20989;
        Mon, 26 Nov 2018 11:06:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543230400;
        bh=NCTlmHG+X8wnNuTmJmrAZe5q7SZ9PRFgW6aPHFKS7cI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=durPv4bFbF+eoBHSqBdE9y1X98WAYmQXCLf4x3+Tyz3SIbrbStufz0mSxm5aMHzM/
         2fbyNw4HGDv6t4Ouq49rQ9fip+wNsQsL9yFhwPAHBDWYRBTM2k7LmcdS1l2aLLHEfc
         9TcJKb/DLDp+7ttoK6OevRGcQhKNlcrOK9590XGA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sebastian Parschauer <sparschauer@suse.de>,
        Jiri Kosina <jkosina@suse.cz>
Subject: [PATCH 4.19 115/118] HID: Add quirk for Primax PIXART OEM mice
Date:   Mon, 26 Nov 2018 11:51:49 +0100
Message-Id: <20181126105106.406080300@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181126105059.832485122@linuxfoundation.org>
References: <20181126105059.832485122@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sebastian Parschauer <sparschauer@suse.de>

commit fb862c3b199d28bee238d52e8270eae8650d6cb0 upstream.

The PixArt OEM mice are known for disconnecting every minute in
runlevel 1 or 3 if they are not always polled. So add quirk
ALWAYS_POLL for two Primax mice as well.

0x4e22 is the Dell MS111-P and 0x4d0f is the unbranded HP Portia
mouse HP 697738-001. Both were built until approx. 2014.
Those were the standard mice from those vendors and are still
around - even as new old stock.

Reference: https://github.com/sriemer/fix-linux-mouse/issues/11

Signed-off-by: Sebastian Parschauer <sparschauer@suse.de>
CC: stable@vger.kernel.org
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/hid/hid-ids.h    |    2 ++
 drivers/hid/hid-quirks.c |    2 ++
 2 files changed, 4 insertions(+)

--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -1198,6 +1198,8 @@
 #define USB_DEVICE_ID_PRIMAX_MOUSE_4D22	0x4d22
 #define USB_DEVICE_ID_PRIMAX_KEYBOARD	0x4e05
 #define USB_DEVICE_ID_PRIMAX_REZEL	0x4e72
+#define USB_DEVICE_ID_PRIMAX_PIXART_MOUSE_4D0F	0x4d0f
+#define USB_DEVICE_ID_PRIMAX_PIXART_MOUSE_4E22	0x4e22
 
 
 #define USB_VENDOR_ID_RISO_KAGAKU	0x1294	/* Riso Kagaku Corp. */
--- a/drivers/hid/hid-quirks.c
+++ b/drivers/hid/hid-quirks.c
@@ -128,6 +128,8 @@ static const struct hid_device_id hid_qu
 	{ HID_USB_DEVICE(USB_VENDOR_ID_PIXART, USB_DEVICE_ID_PIXART_OPTICAL_TOUCH_SCREEN), HID_QUIRK_NO_INIT_REPORTS },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_PIXART, USB_DEVICE_ID_PIXART_USB_OPTICAL_MOUSE), HID_QUIRK_ALWAYS_POLL },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_PRIMAX, USB_DEVICE_ID_PRIMAX_MOUSE_4D22), HID_QUIRK_ALWAYS_POLL },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_PRIMAX, USB_DEVICE_ID_PRIMAX_PIXART_MOUSE_4D0F), HID_QUIRK_ALWAYS_POLL },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_PRIMAX, USB_DEVICE_ID_PRIMAX_PIXART_MOUSE_4E22), HID_QUIRK_ALWAYS_POLL },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_PRODIGE, USB_DEVICE_ID_PRODIGE_CORDLESS), HID_QUIRK_NOGET },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_QUANTA, USB_DEVICE_ID_QUANTA_OPTICAL_TOUCH_3001), HID_QUIRK_NOGET },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_QUANTA, USB_DEVICE_ID_QUANTA_OPTICAL_TOUCH_3003), HID_QUIRK_NOGET },


