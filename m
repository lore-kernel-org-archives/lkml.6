Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 022F8C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 15:14:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAEAF20878
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 15:14:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ILyHrf3c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAEAF20878
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728090AbeLEPOy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 10:14:54 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:40208 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728036AbeLEPOv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 10:14:51 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id wB5FEn1o020514;
        Wed, 5 Dec 2018 09:14:49 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1544022889;
        bh=iFrr0VICgTTqdRPtbpUuJ6fdJVlGNcoVpZIma6uw7f8=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=ILyHrf3c4EZQALrT4YabNpwbOnUFYvXxPUaEmLdDtv30Qrk/a10LY0j/r3Teo1wR6
         m1yTznOkWLaqcytwI3QPzMoBgxkVKdx6RVzxMpVdLyiTtyl64v8KyB17azoweqTbrL
         Yg67Awjgn03VILRxllamm2C25h+0Ys1K1/5xp9HQ=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wB5FEn7h040993
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 5 Dec 2018 09:14:49 -0600
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Wed, 5
 Dec 2018 09:14:48 -0600
Received: from dflp33.itg.ti.com (10.64.6.16) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Wed, 5 Dec 2018 09:14:48 -0600
Received: from dlelxv97.itg.ti.com (dlelxv97.itg.ti.com [172.17.2.193])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id wB5FEmDq014725;
        Wed, 5 Dec 2018 09:14:48 -0600
Received: from localhost.localdomain (vboxa0400828d.dhcp.ti.com [172.22.237.247])
        by dlelxv97.itg.ti.com (8.14.3/8.13.8) with ESMTP id wB5FEeUh025212;
        Wed, 5 Dec 2018 09:14:46 -0600
From:   Roger Quadros <rogerq@ti.com>
To:     <balbi@ti.com>
CC:     <tony@atomide.com>, <robh+dt@kernel.org>, <nsekhar@ti.com>,
        <t-kristo@ti.com>, <vigneshr@ti.com>, <linux-omap@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <rogerq@ti.com>
Subject: [PATCH 2/3] dt-bindings: usb: keystone-usb: Add ti,am654-dwc3 support
Date:   Wed, 5 Dec 2018 17:14:38 +0200
Message-ID: <1544022879-5704-3-git-send-email-rogerq@ti.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1544022879-5704-1-git-send-email-rogerq@ti.com>
References: <1544022879-5704-1-git-send-email-rogerq@ti.com>
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
 Documentation/devicetree/bindings/usb/keystone-usb.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/usb/keystone-usb.txt b/Documentation/devicetree/bindings/usb/keystone-usb.txt
index f96e09f..fa29ff8 100644
--- a/Documentation/devicetree/bindings/usb/keystone-usb.txt
+++ b/Documentation/devicetree/bindings/usb/keystone-usb.txt
@@ -3,7 +3,7 @@ TI Keystone Soc USB Controller
 DWC3 GLUE
 
 Required properties:
- - compatible: should be "ti,keystone-dwc3".
+ - compatible: should be "ti,keystone-dwc3" or "ti,am654-dwc3".
  - #address-cells, #size-cells : should be '1' if the device has sub-nodes
    with 'reg' property.
  - reg : Address and length of the register set for the USB subsystem on
@@ -21,7 +21,7 @@ SoCs only:
 - clock-names:		Must be "usb".
 
 
-The following are mandatory properties for Keystone 2 66AK2G SoCs only:
+The following are mandatory properties for 66AK2G and AM654:
 
 - power-domains:	Should contain a phandle to a PM domain provider node
 			and an args specifier containing the USB device id
-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

