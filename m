Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14154C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 19:53:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFDA12075E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 19:53:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="rhfQt8yB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFDA12075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030714AbeFSTxz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 15:53:55 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:56644 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030665AbeFSTxY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 15:53:24 -0400
X-Greylist: delayed 578 seconds by postgrey-1.27 at vger.kernel.org; Tue, 19 Jun 2018 15:53:20 EDT
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id w5JJiMMN021388;
        Tue, 19 Jun 2018 14:44:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1529437462;
        bh=llhxev1/m9uQv5dpbGtR/7KszBrG2DlEfrlqDrBSWG4=;
        h=From:To:CC:Subject:Date;
        b=rhfQt8yBKOfAysBHhgePCW8QE00Y9+0HIZ3n4Dpxv9L8jooxtz8hkxmBbfkqYSqZP
         7tZazDe8AdALOYsgJSn2dnDUVD5WQp9QxtVBEgUp4eH7BhVtZyScx8xqeEJDdLzoDN
         +ZDzNKWNh04WDIz6YqsscA+6rYkB+ypd38pvNS7E=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w5JJiMJX010269;
        Tue, 19 Jun 2018 14:44:22 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Tue, 19
 Jun 2018 14:44:21 -0500
Received: from dlep32.itg.ti.com (157.170.170.100) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Tue, 19 Jun 2018 14:44:22 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w5JJiLFO017973;
        Tue, 19 Jun 2018 14:44:21 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Tero Kristo <t-kristo@ti.com>
CC:     Nishanth Menon <nm@ti.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 0/2] firmware: ti_sci: Add host-id as an optional parameter
Date:   Tue, 19 Jun 2018 14:44:19 -0500
Message-ID: <20180619194421.3432-1-nm@ti.com>
X-Mailer: git-send-email 2.15.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Please find attached series to enable host-id as an optional dt property.

Changes Since RFC:
* Updated commit message based on feedback from Rob.

The series is based on v4.18-rc1 and is available here:
https://github.com/nmenon/linux-2.6-playground/commits/upstream/v4.18-rc1/k3-1-am6-tisci

Consolidated all patches (including all series) are available here:
https://github.com/nmenon/linux-2.6-playground/commits/upstream/v4.18-rc1/k3-am6-integ

Full Boot log (integrated of all series for AM654) is available here:
   https://pastebin.ubuntu.com/p/bBFmnzYtCd/

Nishanth Menon (2):
  Documentation: dt: keystone: ti-sci: Add optional host-id parameter
  firmware: ti_sci: Provide host-id as an optional dt parameter

 .../devicetree/bindings/arm/keystone/ti,sci.txt    |  4 ++++
 drivers/firmware/ti_sci.c                          | 24 ++++++++++++++++++----
 2 files changed, 24 insertions(+), 4 deletions(-)

-- 
2.15.1

