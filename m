Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46970C4160E
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 22:34:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B85D2054F
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 22:34:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jzPixTH7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730095AbfARWeW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 17:34:22 -0500
Received: from mail-pl1-f202.google.com ([209.85.214.202]:42264 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730017AbfARWeU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 17:34:20 -0500
Received: by mail-pl1-f202.google.com with SMTP id p3so9004906plk.9
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jan 2019 14:34:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=5Vf/zxYwOeYnNWL3N0nFW9n1v8wnzmKf0NaeVZgXiaM=;
        b=jzPixTH7zJ1yIIX5bZzrUQThN590v6DWlfCKamohvLlKx5xj3PTGaNlXRFdk3O6anO
         mzvDL3vYXDynePF8uuET9rXYuf00lUdxjkTA7vdbPjEMTOo38mP+zEMUe6bMK7qVNww2
         vapy/RgoUXYRI/Qi2zpUXc27WocMAQtoJxAwksTDgm7enmKfcwB0ciKFiY7lilL6doaT
         +29l3cZ4rfjw6YpRQz+TA6AVwOdXWOPY8LgScYw4iEp5qJHilmJ3ZwE+7ei5/GGjKz0c
         PBBRloe/D57GSfFJz22Ui/IYngZoDhuVRQjwwsGny6F3ZaPeJ2ItTxPzZ55XpXjse6sI
         TedA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=5Vf/zxYwOeYnNWL3N0nFW9n1v8wnzmKf0NaeVZgXiaM=;
        b=oh+Z9pB9Dg9inc4kgDyLKcK7zIUZ+qTb0nTfEKUi2IaWR1iWSm8nTZvkHmAVlgyl6L
         6FFcPPz5imKamNzPCHJ90xAB4yEAzKO+JgcVxUlVQPflZUMIleRri6vNNrJgV0Mo34t/
         Pfmou5EQhLAXx6sQvKiD9onC2DxtOCaRZPrrTfESJE/yoBnoVjVjIpIOWzspiLnKVtcP
         pbyiXY1hXJQF7hl4dCcrMDwq9B51EH4B7PwFoIsyb99MFOvFyRgCBvpe/F3CtTgHaZ34
         OMbjWIkIi4w70DybbjqYSOTFaFpHxyFVhqL6XdNr/ihfzX17iTDtzU4WVJrIp1HksyDp
         PW7A==
X-Gm-Message-State: AJcUukeDNnrnr+Sx+enFK7ue5x5FULViJEIksx5QZ5KQDqrFAurW88h1
        VLcB1o7BuN1ZeBOUgVT9yG/l7hsl8Eo8
X-Google-Smtp-Source: ALg8bN6thYeoMCSIyboFDVOgiChvDQtw39+2XeK8itXMoEr8A7Hmc4UB4lWL/ifImlNAu5t+wmuXpmEVFPNz
X-Received: by 2002:a62:679d:: with SMTP id t29mr8166391pfj.90.1547850860134;
 Fri, 18 Jan 2019 14:34:20 -0800 (PST)
Date:   Fri, 18 Jan 2019 14:34:04 -0800
In-Reply-To: <20190118223407.64818-1-rajatja@google.com>
Message-Id: <20190118223407.64818-2-rajatja@google.com>
Mime-Version: 1.0
References: <20181117010748.24347-1-rajatja@google.com> <20190118223407.64818-1-rajatja@google.com>
X-Mailer: git-send-email 2.20.1.321.g9e740568ce-goog
Subject: [PATCH v4 2/5] usb: assign ACPI companions for embedded USB devices
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
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Tested-by: Sukumar Ghorai <sukumar.ghorai@intel.com>
---
v4: Add Acked-by and Tested-by in signatures.
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
2.20.1.321.g9e740568ce-goog

