Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78F4AC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 23:50:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 323662080F
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 23:50:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rfbu1OPu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 323662080F
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390729AbeKVK1H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 05:27:07 -0500
Received: from mail-pl1-f202.google.com ([209.85.214.202]:39822 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388031AbeKVK1F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 05:27:05 -0500
Received: by mail-pl1-f202.google.com with SMTP id v2so260539plg.6
        for <linux-kernel@vger.kernel.org>; Wed, 21 Nov 2018 15:50:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=nltjIZyBe3wkrQeEwGuPazv0ZnVMsX5gwUqKQk+rGtk=;
        b=rfbu1OPuYuBbcI9UB3GpAZNhb0Zb2y+RLFHhv8R1xbJX+7X9PzZptWDqj7sfTuW6bq
         CGpyWgBWgxoI6XoXE+iphyqj5nUuQV4xyXByY++D7Itjr2wteuEGyBBl8DvuRJintewY
         Lu++pXG7olb0WpzZgMsIsAf/FY1NW00KLS2tb0GDDSugt2KgiKQ4v/6D0+rG4Cy+YZNA
         eyhbNIOtvbPLdSG0WBwIanr2goiU3z4mLOTGUJDFjRgsceiEoZHH0Om8Lz0a6FpD3utJ
         ymFAxmJ5tpjL2jpVeMRfFuCR4ozHe+eUfsbdZ+5LOYV2DkA6PNWFfSnUqHQewjvOsMHb
         Hoeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=nltjIZyBe3wkrQeEwGuPazv0ZnVMsX5gwUqKQk+rGtk=;
        b=Yi0bjYwJOYVbZuKD02ThHe/YLx3bvuNS4xlM7DsWk+VM/cO61ghVKfKsSsQRG0PdjK
         wcgvwmnNzEARgn6ZqenKLAM2JKrrdDpObpKkntHFmMYGmhKl/qoLbxRmJHOKNh+JI6NP
         HQZ6VWlisU5WFnQNmrRPEBtFscYj8tm/fcWyynysWtjgCgd0ig2ZiREpjXIRwVOXU7B4
         15ZNFhTGbShtjiXzsCdbGYA+i1jpKbcg1TZhlAERmaVLmUXLbaH2QyxGKitRPs7kd4I2
         nzZJQ4wt5Hy40HAextTifbxPfFyjzVzgC9tjZzCLNX0tZWIQLiikJ2ZvAFXlI4CeC5cd
         tExg==
X-Gm-Message-State: AGRZ1gLadfNiI7VqnxcIlYhY3Y68zkIzNrVn4hqsKx2evhg1NVbv8Ppw
        PE/NRSbf5R6ds3pFSpoyyOhhLJlQLMES
X-Google-Smtp-Source: AJdET5e+SUcQRCWwsuYBdHV52/cHxD6Ta0jykLaj/9/rCiD8/LhlDBQlGJc1FAJIZHQk/wPYN3rFxsM4G3fq
X-Received: by 2002:a62:c07:: with SMTP id u7mr3836130pfi.58.1542844228691;
 Wed, 21 Nov 2018 15:50:28 -0800 (PST)
Date:   Wed, 21 Nov 2018 15:50:17 -0800
In-Reply-To: <20181121235020.29461-1-rajatja@google.com>
Message-Id: <20181121235020.29461-2-rajatja@google.com>
Mime-Version: 1.0
References: <20181117010748.24347-1-rajatja@google.com> <20181121235020.29461-1-rajatja@google.com>
X-Mailer: git-send-email 2.19.1.1215.g8438c0b245-goog
Subject: [PATCH v3 2/5] usb: assign ACPI companions for embedded USB devices
From:   Rajat Jain <rajatja@google.com>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Dmitry Torokhov <dtor@chromium.org>,
        Rajat Jain <rajatja@google.com>,
        Alex Hung <alex.hung@canonical.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, netdev@vger.kernel.org
Cc:     rajatxjain@gmail.com, dtor@google.com, raghuram.hegde@intel.com,
        chethan.tumkur.narayan@intel.com, sukumar.ghorai@intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dmitry Torokhov <dtor@chromium.org>

USB devices permanently connected to USB ports may be described in ACPI
tables and share ACPI devices with ports they are connected to. See [1]
for details.

This will allow us to describe sideband resources for devices, such as,
for example, hard reset line for BT USB controllers.

[1] https://docs.microsoft.com/en-us/windows-hardware/drivers/bringup/other-acpi-namespace-objects#acpi-namespace-hierarchy-and-adr-for-embedded-usb-devices

Signed-off-by: Dmitry Torokhov <dtor@chromium.org>
Signed-off-by: Rajat Jain <rajatja@google.com> (changed how we get the usb_port)
---
v3: same as v1
v2: same as v1

 drivers/usb/core/usb-acpi.c | 44 +++++++++++++++++++++++++++++--------
 1 file changed, 35 insertions(+), 9 deletions(-)

diff --git a/drivers/usb/core/usb-acpi.c b/drivers/usb/core/usb-acpi.c
index 8ff73c83e8e8..9043d7242d67 100644
--- a/drivers/usb/core/usb-acpi.c
+++ b/drivers/usb/core/usb-acpi.c
@@ -200,30 +200,56 @@ static struct acpi_device *
 usb_acpi_find_companion_for_device(struct usb_device *udev)
 {
 	struct acpi_device *adev;
+	struct usb_port *port_dev;
+	struct usb_hub *hub;
+
+	if (!udev->parent) {
+		/* root hub is only child (_ADR=0) under its parent, the HC */
+		adev = ACPI_COMPANION(udev->dev.parent);
+		return acpi_find_child_device(adev, 0, false);
+	}
 
-	if (!udev->parent)
+	hub = usb_hub_to_struct_hub(udev->parent);
+	if (!hub)
 		return NULL;
 
-	/* root hub is only child (_ADR=0) under its parent, the HC */
-	adev = ACPI_COMPANION(udev->dev.parent);
-	return acpi_find_child_device(adev, 0, false);
+	/*
+	 * This is an embedded USB device connected to a port and such
+	 * devices share port's ACPI companion.
+	 */
+	port_dev = hub->ports[udev->portnum - 1];
+	return usb_acpi_get_companion_for_port(port_dev);
 }
 
-
 static struct acpi_device *usb_acpi_find_companion(struct device *dev)
 {
 	/*
-	 * In the ACPI DSDT table, only usb root hub and usb ports are
-	 * acpi device nodes. The hierarchy like following.
+	 * The USB hierarchy like following:
+	 *
 	 * Device (EHC1)
 	 *	Device (HUBN)
 	 *		Device (PR01)
 	 *			Device (PR11)
 	 *			Device (PR12)
+	 *				Device (FN12)
+	 *				Device (FN13)
 	 *			Device (PR13)
 	 *			...
-	 * So all binding process is divided into two parts. binding
-	 * root hub and usb ports.
+	 * where HUBN is root hub, and PRNN are USB ports and devices
+	 * connected to them, and FNNN are individualk functions for
+	 * connected composite USB devices. PRNN and FNNN may contain
+	 * _CRS and other methods describing sideband resources for
+	 * the connected device.
+	 *
+	 * On the kernel side both root hub and embedded USB devices are
+	 * represented as instances of usb_device structure, and ports
+	 * are represented as usb_port structures, so the whole process
+	 * is split into 2 parts: finding companions for devices and
+	 * finding companions for ports.
+	 *
+	 * Note that we do not handle individual functions of composite
+	 * devices yet, for that we would need to assign companions to
+	 * devices corresponding to USB interfaces.
 	 */
 	if (is_usb_device(dev))
 		return usb_acpi_find_companion_for_device(to_usb_device(dev));
-- 
2.19.1.1215.g8438c0b245-goog

