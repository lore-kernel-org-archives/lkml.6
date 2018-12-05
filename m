Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E194C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 15:14:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35A4A2082D
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 15:14:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ptYZZa1j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35A4A2082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728035AbeLEPOt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 10:14:49 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:50212 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727103AbeLEPOs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 10:14:48 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id wB5FEiAC085344;
        Wed, 5 Dec 2018 09:14:44 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1544022884;
        bh=dnagYtuRo0dIQKwIRbpAbfKIeuq+ltUbg0liXdY9UK8=;
        h=From:To:CC:Subject:Date;
        b=ptYZZa1jmghrB4L662wH6pwZ8ml036aJ7+iVX36aex76uGCbwnaBXHdR0RGwewKzA
         mgrRguaqvX51XHeFjRi7crl4/33YjU8UmWnHXyCx8d1CYJ8mS04s/IuGDWBZ+7+eJa
         dmhOh+MHlGm8MxguPrv5WeL9sYsvfWx5nT5VD5G0=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wB5FEiG3096391
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 5 Dec 2018 09:14:44 -0600
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Wed, 5
 Dec 2018 09:14:43 -0600
Received: from dlep33.itg.ti.com (157.170.170.75) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Wed, 5 Dec 2018 09:14:43 -0600
Received: from dlelxv97.itg.ti.com (dlelxv97.itg.ti.com [172.17.2.193])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id wB5FEhCA029097;
        Wed, 5 Dec 2018 09:14:43 -0600
Received: from localhost.localdomain (vboxa0400828d.dhcp.ti.com [172.22.237.247])
        by dlelxv97.itg.ti.com (8.14.3/8.13.8) with ESMTP id wB5FEeUf025212;
        Wed, 5 Dec 2018 09:14:40 -0600
From:   Roger Quadros <rogerq@ti.com>
To:     <balbi@ti.com>
CC:     <tony@atomide.com>, <robh+dt@kernel.org>, <nsekhar@ti.com>,
        <t-kristo@ti.com>, <vigneshr@ti.com>, <linux-omap@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <rogerq@ti.com>
Subject: [PATCH 0/3] usb: dwc3: Add support for AM654 USB
Date:   Wed, 5 Dec 2018 17:14:36 +0200
Message-ID: <1544022879-5704-1-git-send-email-rogerq@ti.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Felipe,

TI's AM654 USB SoC has 2 instances of the DWC3 controller.
This series adds AM654 USB wrapper support to the keystone-usb driver.

cheers,
-roger

Roger Quadros (3):
  usb: dwc3: gadget: Fix OTG events when gadget driver isn't loaded
  dt-bindings: usb: keystone-usb: Add ti,am654-dwc3 support
  usb: dwc3: keystone: Add support for ti,am654-dwc3

 Documentation/devicetree/bindings/usb/keystone-usb.txt |  4 ++--
 drivers/usb/dwc3/Kconfig                               |  6 +++---
 drivers/usb/dwc3/dwc3-keystone.c                       | 11 ++++++++++-
 drivers/usb/dwc3/gadget.c                              |  2 ++
 4 files changed, 17 insertions(+), 6 deletions(-)

-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

