Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72FA4C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 23:28:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A459218A6
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 23:28:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="txV6W1Zt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728345AbfAXX2V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 18:28:21 -0500
Received: from mail-pf1-f202.google.com ([209.85.210.202]:50109 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728063AbfAXX2U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 18:28:20 -0500
Received: by mail-pf1-f202.google.com with SMTP id x67so5930522pfk.16
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jan 2019 15:28:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=D/n+iLRONY/z6dZgG+EgYqvlkP4ooj+2tYEzHi4XON8=;
        b=txV6W1ZtraQlt92o41uu1lgVNKxl2QudDXVTpqZUX1sEpcpYGASapdFDOP9Tp4EuUs
         TV73GzGOZrUzx+fP3gd7iRe77Fl+NiW8iyDU2+BbJck6Re40dDYsLxuFY7n6aFV2ET/w
         HGVo/O7C9mit0ZagtYTYyvS6NpNAlh4kcCeFkk374tEf07QTFlexStj1z+970VSBkNm2
         9jZRImP/0EDw1w4NDB6B6Q+J6u97QmVoKRGQCk8I9naVbseIVOeQ9gQ7bTRbxuNzQWfz
         oTXatJWHh0KY0qpJVFM03TF8A0+nnB5wZe1tpQCdiF7I6lw5UMfpo79IPVrhsr75O7cH
         xqzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=D/n+iLRONY/z6dZgG+EgYqvlkP4ooj+2tYEzHi4XON8=;
        b=SX3Gdbn5hK3EF78DNJqZQ0GY+jXCAnOLIgbMXGKPRRNhR3t2t6ruof7IH2KK7OYJ2H
         Cd99s01lNMfzDx2PkQjlF0MMNoBd0kBOqmeUDWiHoG9d6ZWQnN9l9c6cz4kFQV4dzQQb
         F9NqBEP+mvMUZIq6OaXI1es/GnpVRcvUWBXd7BJ5D+cqhZKq4Chfj1E8JXUbk//vfn1l
         DaiKvkPc7DhugYGpFUj9BNGb/lF75frd+izzpHHVUBflwfiE0Ffi0AFTiKZ/xYuiCayt
         z7bkKhvvNtQzAWX1wFQy9g012Yrv8HJ34O7alkgiIqObqMtwJwgarclf70i0nU7oaLnM
         LuFA==
X-Gm-Message-State: AJcUukccsJLpz60hDfnLBoq6D5D5yx4aUJqmdq0pY2DZ8nfxxCNWmGR8
        ecYgNu3SO3zkeEpOaM40AOem3ry0kEhS
X-Google-Smtp-Source: ALg8bN6HHHD2nMkSDU1L8mSuEWBGcMe9KW51EMyzOioDKV6Cqj7V505GT7KeSuUfz7QfElfy2qXxsIQGLGmL
X-Received: by 2002:a63:790f:: with SMTP id u15mr3805073pgc.125.1548372499784;
 Thu, 24 Jan 2019 15:28:19 -0800 (PST)
Date:   Thu, 24 Jan 2019 15:28:11 -0800
In-Reply-To: <20181117010748.24347-1-rajatja@google.com>
Message-Id: <20190124232814.252661-1-rajatja@google.com>
Mime-Version: 1.0
References: <20181117010748.24347-1-rajatja@google.com>
X-Mailer: git-send-email 2.20.1.321.g9e740568ce-goog
Subject: [PATCH v6 1/4] usb: split code locating ACPI companion into port and device
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
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Tested-by: Sukumar Ghorai <sukumar.ghorai@intel.com>
---
v6: same as v4
v5: same as v4
v4: Add Acked-by and Tested-by in signatures.
v3: same as v1
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
2.20.1.321.g9e740568ce-goog

