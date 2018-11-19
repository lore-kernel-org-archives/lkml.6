Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC4FBC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 23:04:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91C002145D
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 23:04:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NTzqh7Xq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91C002145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732065AbeKTJaV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 04:30:21 -0500
Received: from mail-io1-f74.google.com ([209.85.166.74]:52332 "EHLO
        mail-io1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731624AbeKTJaV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 04:30:21 -0500
Received: by mail-io1-f74.google.com with SMTP id h7so18025546iof.19
        for <linux-kernel@vger.kernel.org>; Mon, 19 Nov 2018 15:04:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ht0KyOh1qyTCyJTWR8FJ0kQ4r9NOG2ZYRU0qkbwdVxg=;
        b=NTzqh7XqPizW3LKbTLltZA7fs5TZVy6YJa+uBgWCyXcCuDjwNOHnE90YECCJFl8FvE
         uoXHXt67YbqemX5mGaAADP2IVDXGQSkq/IHOC734rhxeKtpB3211zgGt5coW7/2ot0I9
         x8ByhgXEXPiRtYbSi2e8cc+vg2Sb/L2aYJbfYJp+NQYgqZ12i0hEs3ORn1nvzcQR0Ora
         oCJFdJUTOZSVtGWZOSG7iMuoxmw76YL85sTE08wsAPfPvWIYorai0xvULf2Qcw5jtzMT
         aFIZMsrXaY2SbiA2xoIAu2VF6QhKq1gCZ6RjYD+s7tFSq0oCmMB3INb7JXeCAmEr+VZg
         kqRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ht0KyOh1qyTCyJTWR8FJ0kQ4r9NOG2ZYRU0qkbwdVxg=;
        b=HmFPsA80gjq0qVzLTOcvzWgxYcs0BVxOh56bMIrefUmcwq8yvAUIQoC8NjceuOjPqU
         LY+HZUa5b3NslI9+Aib4UIzLa74/60oPuGLCuVJAhFWlLKNbZrQy8PpO6ca4Xvx27BF3
         S91nuFsoU5iesUU8nBGOXbNhrQlccQciGgBjUlAB3SZrK91+cRMXWKhU2ySv3YDvyWL6
         i5lzZeCLocVAMNhT4klpGcw2CpyuXCnyspKdFxeTAHCqj/FBeUK3IiV2sf9bCi+B6XFW
         y+c7ZuECzSS4Rq4P8UHFaWpsrGGd9J477s82FeRZXFVk1ZahwyZSROUoKaIviw7AShj9
         lj4w==
X-Gm-Message-State: AA+aEWYUG1LDL6x8mdTQf5I80b4V+3SS+Oq3pLyIVi8OOQvW8O/41RU8
        Tt0DilRXjQyeO8gXD4ROub6AacXj51Gl
X-Google-Smtp-Source: AJdET5epn00g1R5JWP1cMzk7X7UcKhiKt2pnk87nH5GZlOdyRhKGMBnmCcHOOT0PbwbEFr++W09Y8yN8z+bu
X-Received: by 2002:a24:6cb:: with SMTP id 194-v6mr55049itv.18.1542668663035;
 Mon, 19 Nov 2018 15:04:23 -0800 (PST)
Date:   Mon, 19 Nov 2018 15:04:05 -0800
In-Reply-To: <20181117010748.24347-1-rajatja@google.com>
Message-Id: <20181119230409.258121-1-rajatja@google.com>
Mime-Version: 1.0
References: <20181117010748.24347-1-rajatja@google.com>
X-Mailer: git-send-email 2.19.1.1215.g8438c0b245-goog
Subject: [PATCH v2 1/5] usb: split code locating ACPI companion into port and device
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

In preparation for handling embedded USB devices let's split
usb_acpi_find_companion() into usb_acpi_find_companion_for_device() and
usb_acpi_find_companion_for_port().

Signed-off-by: Dmitry Torokhov <dtor@chromium.org>
Signed-off-by: Rajat Jain <rajatja@google.com>
---
v2: same as v1

 drivers/usb/core/usb-acpi.c | 133 +++++++++++++++++++-----------------
 1 file changed, 72 insertions(+), 61 deletions(-)

diff --git a/drivers/usb/core/usb-acpi.c b/drivers/usb/core/usb-acpi.c
index e221861b3187..8ff73c83e8e8 100644
--- a/drivers/usb/core/usb-acpi.c
+++ b/drivers/usb/core/usb-acpi.c
@@ -139,12 +139,79 @@ static struct acpi_device *usb_acpi_find_port(struct acpi_device *parent,
 	return acpi_find_child_device(parent, raw, false);
 }
 
-static struct acpi_device *usb_acpi_find_companion(struct device *dev)
+static struct acpi_device *
+usb_acpi_get_companion_for_port(struct usb_port *port_dev)
 {
 	struct usb_device *udev;
 	struct acpi_device *adev;
 	acpi_handle *parent_handle;
+	int port1;
+
+	/* Get the struct usb_device point of port's hub */
+	udev = to_usb_device(port_dev->dev.parent->parent);
+
+	/*
+	 * The root hub ports' parent is the root hub. The non-root-hub
+	 * ports' parent is the parent hub port which the hub is
+	 * connected to.
+	 */
+	if (!udev->parent) {
+		adev = ACPI_COMPANION(&udev->dev);
+		port1 = usb_hcd_find_raw_port_number(bus_to_hcd(udev->bus),
+						     port_dev->portnum);
+	} else {
+		parent_handle = usb_get_hub_port_acpi_handle(udev->parent,
+							     udev->portnum);
+		if (!parent_handle)
+			return NULL;
+
+		acpi_bus_get_device(parent_handle, &adev);
+		port1 = port_dev->portnum;
+	}
+
+	return usb_acpi_find_port(adev, port1);
+}
+
+static struct acpi_device *
+usb_acpi_find_companion_for_port(struct usb_port *port_dev)
+{
+	struct acpi_device *adev;
+	struct acpi_pld_info *pld;
+	acpi_handle *handle;
+	acpi_status status;
+
+	adev = usb_acpi_get_companion_for_port(port_dev);
+	if (!adev)
+		return NULL;
+
+	handle = adev->handle;
+	status = acpi_get_physical_device_location(handle, &pld);
+	if (!ACPI_FAILURE(status) && pld) {
+		port_dev->location = USB_ACPI_LOCATION_VALID
+			| pld->group_token << 8 | pld->group_position;
+		port_dev->connect_type = usb_acpi_get_connect_type(handle, pld);
+		ACPI_FREE(pld);
+	}
 
+	return adev;
+}
+
+static struct acpi_device *
+usb_acpi_find_companion_for_device(struct usb_device *udev)
+{
+	struct acpi_device *adev;
+
+	if (!udev->parent)
+		return NULL;
+
+	/* root hub is only child (_ADR=0) under its parent, the HC */
+	adev = ACPI_COMPANION(udev->dev.parent);
+	return acpi_find_child_device(adev, 0, false);
+}
+
+
+static struct acpi_device *usb_acpi_find_companion(struct device *dev)
+{
 	/*
 	 * In the ACPI DSDT table, only usb root hub and usb ports are
 	 * acpi device nodes. The hierarchy like following.
@@ -158,66 +225,10 @@ static struct acpi_device *usb_acpi_find_companion(struct device *dev)
 	 * So all binding process is divided into two parts. binding
 	 * root hub and usb ports.
 	 */
-	if (is_usb_device(dev)) {
-		udev = to_usb_device(dev);
-		if (udev->parent)
-			return NULL;
-
-		/* root hub is only child (_ADR=0) under its parent, the HC */
-		adev = ACPI_COMPANION(dev->parent);
-		return acpi_find_child_device(adev, 0, false);
-	} else if (is_usb_port(dev)) {
-		struct usb_port *port_dev = to_usb_port(dev);
-		int port1 = port_dev->portnum;
-		struct acpi_pld_info *pld;
-		acpi_handle *handle;
-		acpi_status status;
-
-		/* Get the struct usb_device point of port's hub */
-		udev = to_usb_device(dev->parent->parent);
-
-		/*
-		 * The root hub ports' parent is the root hub. The non-root-hub
-		 * ports' parent is the parent hub port which the hub is
-		 * connected to.
-		 */
-		if (!udev->parent) {
-			struct usb_hcd *hcd = bus_to_hcd(udev->bus);
-			int raw;
-
-			raw = usb_hcd_find_raw_port_number(hcd, port1);
-
-			adev = usb_acpi_find_port(ACPI_COMPANION(&udev->dev),
-						  raw);
-
-			if (!adev)
-				return NULL;
-		} else {
-			parent_handle =
-				usb_get_hub_port_acpi_handle(udev->parent,
-				udev->portnum);
-			if (!parent_handle)
-				return NULL;
-
-			acpi_bus_get_device(parent_handle, &adev);
-
-			adev = usb_acpi_find_port(adev, port1);
-
-			if (!adev)
-				return NULL;
-		}
-		handle = adev->handle;
-		status = acpi_get_physical_device_location(handle, &pld);
-		if (ACPI_FAILURE(status) || !pld)
-			return adev;
-
-		port_dev->location = USB_ACPI_LOCATION_VALID
-			| pld->group_token << 8 | pld->group_position;
-		port_dev->connect_type = usb_acpi_get_connect_type(handle, pld);
-		ACPI_FREE(pld);
-
-		return adev;
-	}
+	if (is_usb_device(dev))
+		return usb_acpi_find_companion_for_device(to_usb_device(dev));
+	else if (is_usb_port(dev))
+		return usb_acpi_find_companion_for_port(to_usb_port(dev));
 
 	return NULL;
 }
-- 
2.19.1.1215.g8438c0b245-goog

