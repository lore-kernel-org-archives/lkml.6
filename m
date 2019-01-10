Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FA4DC43444
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 15:04:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F7802177B
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 15:04:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="utQT85j+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729418AbfAJPEn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 10:04:43 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:40788 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729367AbfAJPEl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 10:04:41 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x0AF4dCs121111;
        Thu, 10 Jan 2019 09:04:39 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1547132679;
        bh=aP0E3G7TwFFVHxmyykcYNLKeXL6TOHP7yXqwGzacnHs=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=utQT85j+UL7kXrewjYtHcC23p9N/8GPgLCAMcgA2CCWDHd10Fbdxz+iPjQFg1lrJE
         lBBYRJS9gu0NO8kCpanbf/xW7b9UM5tJDmYIQPfnllLIxvNo+rzZRS7uqavXhZ/AOb
         5EtPv9uPd4HvJpMKzEW2K43U8jzJziBESW6dQF9g=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x0AF4dm4018024
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 10 Jan 2019 09:04:39 -0600
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Thu, 10
 Jan 2019 09:04:38 -0600
Received: from dflp33.itg.ti.com (10.64.6.16) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Thu, 10 Jan 2019 09:04:38 -0600
Received: from localhost.localdomain (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x0AF4VPh006681;
        Thu, 10 Jan 2019 09:04:36 -0600
From:   Roger Quadros <rogerq@ti.com>
To:     <balbi@kernel.org>
CC:     <vigneshr@ti.com>, <robh+dt@kernel.org>, <nsekhar@ti.com>,
        <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Roger Quadros <rogerq@ti.com>
Subject: [PATCH v2 2/3] dt-bindings: usb: keystone-usb: Add ti,am654-dwc3 support
Date:   Thu, 10 Jan 2019 17:04:29 +0200
Message-ID: <1547132670-5908-3-git-send-email-rogerq@ti.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1547132670-5908-1-git-send-email-rogerq@ti.com>
References: <1547132670-5908-1-git-send-email-rogerq@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The AM654 SoC from TI contains a DWC3 controller. Add
support for it.

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 Documentation/devicetree/bindings/usb/keystone-usb.txt | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/usb/keystone-usb.txt b/Documentation/devicetree/bindings/usb/keystone-usb.txt
index f96e09f..77df82e 100644
--- a/Documentation/devicetree/bindings/usb/keystone-usb.txt
+++ b/Documentation/devicetree/bindings/usb/keystone-usb.txt
@@ -3,7 +3,9 @@ TI Keystone Soc USB Controller
 DWC3 GLUE
 
 Required properties:
- - compatible: should be "ti,keystone-dwc3".
+ - compatible: should be
+		"ti,keystone-dwc3" for Keystone 2 SoCs
+		"ti,am654-dwc3" for AM654 SoC
  - #address-cells, #size-cells : should be '1' if the device has sub-nodes
    with 'reg' property.
  - reg : Address and length of the register set for the USB subsystem on
@@ -21,7 +23,7 @@ SoCs only:
 - clock-names:		Must be "usb".
 
 
-The following are mandatory properties for Keystone 2 66AK2G SoCs only:
+The following are mandatory properties for 66AK2G and AM654:
 
 - power-domains:	Should contain a phandle to a PM domain provider node
 			and an args specifier containing the USB device id
-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

