Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A24CDC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 18:28:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FF5B21B68
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 18:28:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="NouO1P82"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394112AbfBNS2P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 13:28:15 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:44138 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727593AbfBNS2P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 13:28:15 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x1EIS6js065260;
        Thu, 14 Feb 2019 12:28:06 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1550168887;
        bh=Bv2qskVEC6rIqwOJ9GpChKiHBGnkKp3/CuMKmVIOA+I=;
        h=From:To:CC:Subject:Date;
        b=NouO1P82xbk2tb+yvy+/FmVKd6DygBD0fbtqmzgF5eZ9awDUC3uyXbbifoKBm4cQg
         Zb+OYXArlgOBiq44DvmrJc6E8/ouGqaxQgx141jdZqJW0CXCBD8m648aIqJ1Zr+QtP
         R6XJ+WJd+TeO0kLuVs0gKJguBGTUUDffQ+0+ZyU4=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x1EIS6k3085438
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 14 Feb 2019 12:28:06 -0600
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Thu, 14
 Feb 2019 12:28:06 -0600
Received: from dflp32.itg.ti.com (10.64.6.15) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Thu, 14 Feb 2019 12:28:06 -0600
Received: from legion.dal.desgin.ti.com (legion.dal.design.ti.com [128.247.22.53])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x1EIS6xW029440;
        Thu, 14 Feb 2019 12:28:06 -0600
Received: from localhost (a0272616local-lt.dhcp.ti.com [172.22.120.181])
        by legion.dal.desgin.ti.com (8.11.7p1+Sun/8.11.7) with ESMTP id x1EIS5U11240;
        Thu, 14 Feb 2019 12:28:05 -0600 (CST)
From:   Dan Murphy <dmurphy@ti.com>
To:     <wg@grandegger.com>, <mkl@pengutronix.de>, <davem@davemloft.net>
CC:     <linux-can@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Dan Murphy <dmurphy@ti.com>
Subject: [PATCH v5 0/5]  M_CAN Framework re-write
Date:   Thu, 14 Feb 2019 12:27:49 -0600
Message-ID: <20190214182754.30721-1-dmurphy@ti.com>
X-Mailer: git-send-email 2.12.2
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

OK I did not give up on this patch series just got a little preoccupied with
some other kernel work.  But here is the update per the comments.

It should be understood I broke these out for reviewability.
For instance the first patch does not compile on its own as including this
patch should not change the current functionality and it pulls all the io-mapped
code from the m_can base file to a platfrom file.

The next patch "Migrate the m_can code to use the framework"
is the change to the kernel for the io-mapped conversion from a flat file to use
the framework.  Finally the rename patch just renames the m_can_priv to 
m_can_classdev.  I broke this change out specifically for readability of the
migration patch per comments on the code.

AFAIC the first 3 patches can all be squashed into a single patch.  Or the
first 2 patches in the series can be re-arranged but then m_can functionality is
affected in the migration patch.

Again the first 3 patches here are all just for readability and review purposes.

Dan

Dan Murphy (5):
  can: m_can: Create a m_can platform framework
  can: m_can: Migrate the m_can code to use the framework
  can: m_can: Rename m_can_priv to m_can_classdev
  dt-bindings: can: tcan4x5x: Add DT bindings for TCAN4x5X driver
  can: tcan4x5x: Add tcan4x5x driver to the kernel

 .../devicetree/bindings/net/can/tcan4x5x.txt  |  37 +
 drivers/net/can/m_can/Kconfig                 |  14 +-
 drivers/net/can/m_can/Makefile                |   2 +
 drivers/net/can/m_can/m_can.c                 | 788 +++++++++---------
 drivers/net/can/m_can/m_can.h                 | 159 ++++
 drivers/net/can/m_can/m_can_platform.c        | 198 +++++
 drivers/net/can/m_can/tcan4x5x.c              | 531 ++++++++++++
 7 files changed, 1320 insertions(+), 409 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/can/tcan4x5x.txt
 create mode 100644 drivers/net/can/m_can/m_can.h
 create mode 100644 drivers/net/can/m_can/m_can_platform.c
 create mode 100644 drivers/net/can/m_can/tcan4x5x.c

-- 
2.20.1.390.gb5101f9297

