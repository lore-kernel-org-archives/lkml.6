Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88597C282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 06:19:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54B4F2145D
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 06:19:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="KsVeM1El"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727879AbfBEGTR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 01:19:17 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:33233 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727133AbfBEGTP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 01:19:15 -0500
Received: by mail-ed1-f68.google.com with SMTP id p6so1955053eds.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Feb 2019 22:19:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=AK104Dr/qrW4/sFcXOd9y68fEzu0AcfzXkX+YAtBebU=;
        b=KsVeM1El9FDVE4wVpMDo3+uFExTe5bsQTBIf5wMoAdyp1okaxvtEv91IkWyckEoqjc
         J2JNVPjZ411OOPAe9goVzzEy6PXn3OS2TuRK5L9y79hQJlHPu8iwMIhyDTg2AJEXZ538
         yB72oUIrtChUuhp7+h+EdhqQjzn7un94ih2Ks=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=AK104Dr/qrW4/sFcXOd9y68fEzu0AcfzXkX+YAtBebU=;
        b=kutxJ3GyNgw9loYo9A21DqRDc1WBW3xAR+wkGCRa55yTbdeT6gHMtiZxWTDaIkYRUQ
         /wiv8YEY5n6DUHU9Yt6vY5iixVD7pwNykE1aOOqi79C21xBXp0dAUGGe37Z56zo+dNa9
         gM2u/P5yR1gmyheq46u+qIp508OdZQnz5rtJ8lvmZf408/bWPm++kJ8dQgBUUqW8f36p
         MsgGUjO46npOq1LivsHJVWyAejgenGTDBQOi46plBwG08IYUjISew4eBmxpchm7/d/Wn
         9xnij4S7eV9uda+73kmOd3sMtlH9qjILaC2QsrssyKZDN7p45zBP+829O4joMhD9+I3C
         bISg==
X-Gm-Message-State: AHQUAuZPxv9MXErksSJTBKIod4XS6uxqs99Hx+U4MeroLE7dhuI4BAK+
        7qDRNuO24rQE5DWUzXNBDz+lZA==
X-Google-Smtp-Source: AHgI3IZo94iE/x/23FLD8i0N49E2GcOuXzOPPK3EVLGZVOygjemZMvUMnD9X1rPoD1rBXGfxj5Kxmw==
X-Received: by 2002:a50:af43:: with SMTP id g61mr2408690edd.286.1549347553694;
        Mon, 04 Feb 2019 22:19:13 -0800 (PST)
Received: from mannams-OptiPlex-7010.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id t26sm2835120ejs.48.2019.02.04.22.19.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 04 Feb 2019 22:19:13 -0800 (PST)
From:   Srinath Mannam <srinath.mannam@broadcom.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Srinath Mannam <srinath.mannam@broadcom.com>
Subject: [PATCH 1/2] dt-bindings: usb-xhci: Add usb-phy-port-reset property
Date:   Tue,  5 Feb 2019 11:48:53 +0530
Message-Id: <1549347534-11320-2-git-send-email-srinath.mannam@broadcom.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1549347534-11320-1-git-send-email-srinath.mannam@broadcom.com>
References: <1549347534-11320-1-git-send-email-srinath.mannam@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add usb-phy-port-reset optional property to set quirk in xhci platform
driver which forces USB port PHY reset on port disconnect event.

Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
Reviewed-by: Ray Jui <ray.jui@broadcom.com>
---
 Documentation/devicetree/bindings/usb/usb-xhci.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/usb/usb-xhci.txt b/Documentation/devicetree/bindings/usb/usb-xhci.txt
index fea8b15..ecbdb15 100644
--- a/Documentation/devicetree/bindings/usb/usb-xhci.txt
+++ b/Documentation/devicetree/bindings/usb/usb-xhci.txt
@@ -40,6 +40,7 @@ Optional properties:
   - usb3-lpm-capable: determines if platform is USB3 LPM capable
   - quirk-broken-port-ped: set if the controller has broken port disable mechanism
   - imod-interval-ns: default interrupt moderation interval is 5000ns
+  - usb-phy-port-reset: set this to do USB PORT PHY reset while disconnect
   - phys : see usb-hcd.txt in the current directory
 
 additionally the properties from usb-hcd.txt (in the current directory) are
-- 
2.7.4

