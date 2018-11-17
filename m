Return-Path: <SRS0=6aQE=N4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E18BC43441
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 01:08:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B920206B2
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 01:08:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VoTZcDlK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B920206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730866AbeKQLWn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 06:22:43 -0500
Received: from mail-pl1-f202.google.com ([209.85.214.202]:50946 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730286AbeKQLWm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 06:22:42 -0500
Received: by mail-pl1-f202.google.com with SMTP id d11-v6so18377892plo.17
        for <linux-kernel@vger.kernel.org>; Fri, 16 Nov 2018 17:08:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=s3V1He2Zj5wng/11t7K3HEWj/4wZGpXZr3vO1JV3B7s=;
        b=VoTZcDlK+vJS5EdgLM8TokoaYkl1BgjquuNWLN560DpIJoU8cTccEOBZb0dyCqJwzN
         39fteUJOWxdSIDetnAJYERMadSBBhZRFD3fSExO4UQrlWBf8YisCo1zT+5/xtA7GQHLW
         JefAYZ9XiCf2CIa3Ypzngk4KgvISSKXfv2gtPkCDcIZp9Pumw4a/PziS47Tx5tP0jaiN
         PPeLBOr0U6oFM6HqQwrdnRkqHFYC1xFqPVGGMZNf+xeKeWtP4JZryYmD2Ka9QR6EOJLL
         HTyTWHh6QpqmQiO0TaqcKxYDSAWJV4hWgoPuN9YX8oSCjXG1lLCt3RaQD+vHGrYfOeP8
         hvsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=s3V1He2Zj5wng/11t7K3HEWj/4wZGpXZr3vO1JV3B7s=;
        b=oakqG33zKAIH1ec4zHLhjaHKNDCkdWPjsajhCFcQ0NqWT6BZhpx9tLv3kQ6s/Kxhyp
         vNuNz944hbvCf4MNF+hw13Aa7YhcNp29UMojvZKRhuZ1Rp+5fwZ5h5bJr/mzZd1ODmZz
         HY9kindp38vr7lxRPd8rj9tet1Umvv0NuRUaiK4bSUBmIO1zZos/CtUKfEQ2SF2t5DnK
         yPxwUqj18lwo55qNfYlno7sWn8DwqCQ6Zm1aSXh3pobXM9KyFYTEWau+hZeWALET6vP+
         5BZSgYZ5Z+9Yj8CiUbil/AmQ9mBEiBcdu7I1ajWcxTOrRs9IOuV5O20a9twLaHRuv82j
         q11w==
X-Gm-Message-State: AGRZ1gKn3tAQmlmoD3nxjTDKSTTpTy2LrK0ClKTezA7+l1g/lM0ff49g
        n0ie/gcqP5GPjUAovM/V7caYDoY4vYz5
X-Google-Smtp-Source: AJdET5fT21G7Mst65AWLTtqZDKa2Kxm5bUKbPAIVj2Mk2Av80SRcUeA7bJ33k04/S8D3kGmbtP06CQBXFq36
X-Received: by 2002:aa7:8157:: with SMTP id d23-v6mr186165pfn.136.1542416881178;
 Fri, 16 Nov 2018 17:08:01 -0800 (PST)
Date:   Fri, 16 Nov 2018 17:07:45 -0800
In-Reply-To: <20181117010748.24347-1-rajatja@google.com>
Message-Id: <20181117010748.24347-3-rajatja@google.com>
Mime-Version: 1.0
References: <20181117010748.24347-1-rajatja@google.com>
X-Mailer: git-send-email 2.19.1.1215.g8438c0b245-goog
Subject: [PATCH 2/5] usb: assign ACPI companions for embedded USB devices
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

