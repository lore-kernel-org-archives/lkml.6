Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F2C3C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 20:57:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03A6021855
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 20:57:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VTpMHj4R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726881AbfAWU5j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 15:57:39 -0500
Received: from mail-pl1-f201.google.com ([209.85.214.201]:39189 "EHLO
        mail-pl1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726774AbfAWU5f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 15:57:35 -0500
Received: by mail-pl1-f201.google.com with SMTP id v2so2353020plg.6
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jan 2019 12:57:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Ek5tAZVik4G9S7yKc/57HwUfLe97vNLtRwX9GtGPda0=;
        b=VTpMHj4RkCyPjddfwWYChBEF6JtKg4Q1eRQkTwA27oOOlHIvp+SAeTjMjde6gpC7I2
         ZNxlywaGpPSFn8NYZb1a0CAo3YqnkjNfYVa5m2ZwTgP5BdmvpmIv5/q1a2uDXvmzJGDc
         1LzueglMwUK2Ei9iMx72XtQK6vBb4ssvinjqgWh+Dhe9if/OSOMGA6igayEMFHBU7XmY
         2Tcxo6skC0lS/1KhpnuG/zy/x51+wt0K9AMgKj0b32kkRufy5MuWGqn0qizkt8kaUuL8
         KGWzXjdSzqr7GrwOBHIO5oSX/BZdEbOBs9DnKfYJnIRcxsu5SxisWt1hEqk17R3P3wBy
         kHhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Ek5tAZVik4G9S7yKc/57HwUfLe97vNLtRwX9GtGPda0=;
        b=hTqlMcQuB69sddriPDQ2YLF21Ix3eB/7Akkqrzknf4y8TuSZ7WSQDH70AylQUPlpBu
         THRq0LEXI2DhPBhTrGf9sdUZsz1PHosdyCkyuBTv3J8q9oAvlPkOJWF0EgfJZETRfSkp
         6G4Dy1QKrUVDmv98mMvzBwyDtY+rXzw+9jb16u7h+cr9EsV44WzObVhQ/mfL9pHOw1Z5
         ++iudZNSt3UjnLJkgFe0IF3o/gP8/aO3/XfxsX4Ybp+Dm6cb6lAz03p9KNGAVmkL6RrD
         ij5e00vUDpZOQ6ih0+6FuznKx/Bnk7BNhFfSOsBtdJQx52g1hgMac/gY2NyHFdPJUbdL
         f/PA==
X-Gm-Message-State: AJcUukdQbeaikir7feskgp2lfrw/9Lax3d4L4Rz0b2EAKqqZwUUidt7N
        zreWPFKX5oA6OFqmXFUtQ0TgWJROWGgR
X-Google-Smtp-Source: ALg8bN5heWrQHKZ5AW/1jiRDx0O+rkQFFKfIx2BOCX8lXbDR+ILchcN0iFY5FLMuLrU8ZI/tw8mUxfakaB+N
X-Received: by 2002:a17:902:5e3:: with SMTP id f90mr1271204plf.51.1548277054611;
 Wed, 23 Jan 2019 12:57:34 -0800 (PST)
Date:   Wed, 23 Jan 2019 12:57:23 -0800
In-Reply-To: <20190123205725.239661-1-rajatja@google.com>
Message-Id: <20190123205725.239661-2-rajatja@google.com>
Mime-Version: 1.0
References: <20181117010748.24347-1-rajatja@google.com> <20190123205725.239661-1-rajatja@google.com>
X-Mailer: git-send-email 2.20.1.321.g9e740568ce-goog
Subject: [PATCH v5 2/4] usb: assign ACPI companions for embedded USB devices
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
v5: same as v4
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

