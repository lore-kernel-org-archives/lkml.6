Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0F27C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 15:04:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE8862177B
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 15:04:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="io14ggQF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729340AbfAJPEi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 10:04:38 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:60894 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727753AbfAJPEh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 10:04:37 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x0AF4ZJS055106;
        Thu, 10 Jan 2019 09:04:35 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1547132675;
        bh=mtgnVJ7/fIvbqtWFigH2PGA7aNcmeKR6K3uYBvrjr+0=;
        h=From:To:CC:Subject:Date;
        b=io14ggQFky13s8TwyWeD5J/K+ASkmTqx2hkC4Pf6MkHPLs/L/6Nvrb8JTelH1lNEZ
         63Vz7Y2F8jWanwGZYTxIXz01Jw/Pn6fF5d/m+woWZj5aqYGh8ISf+VqLcGa7s9OIGX
         qYTv6zWVQ5KdYczctFGxKqyGg1OnNKfxg+e7lLuo=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x0AF4Zmk051633
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 10 Jan 2019 09:04:35 -0600
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Thu, 10
 Jan 2019 09:04:34 -0600
Received: from dflp33.itg.ti.com (10.64.6.16) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Thu, 10 Jan 2019 09:04:34 -0600
Received: from localhost.localdomain (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x0AF4VPf006681;
        Thu, 10 Jan 2019 09:04:32 -0600
From:   Roger Quadros <rogerq@ti.com>
To:     <balbi@kernel.org>
CC:     <vigneshr@ti.com>, <robh+dt@kernel.org>, <nsekhar@ti.com>,
        <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Roger Quadros <rogerq@ti.com>
Subject: [PATCH v2 0/3] usb: dwc3: Add support for AM654 USB
Date:   Thu, 10 Jan 2019 17:04:27 +0200
Message-ID: <1547132670-5908-1-git-send-email-rogerq@ti.com>
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

Changelog:
v2:
- Moved compatible to separate lines in DT binding.

cheers,
-roger

Roger Quadros (3):
  usb: dwc3: gadget: Fix OTG events when gadget driver isn't loaded
  dt-bindings: usb: keystone-usb: Add ti,am654-dwc3 support
  usb: dwc3: keystone: Add support for ti,am654-dwc3

 Documentation/devicetree/bindings/usb/keystone-usb.txt |  6 ++++--
 drivers/usb/dwc3/Kconfig                               |  6 +++---
 drivers/usb/dwc3/dwc3-keystone.c                       | 11 ++++++++++-
 drivers/usb/dwc3/gadget.c                              |  2 ++
 4 files changed, 19 insertions(+), 6 deletions(-)

-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

