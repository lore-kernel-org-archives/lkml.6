Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 461D0C43444
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 17:33:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D02C20870
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 17:33:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="dfSy863R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388479AbfAKRdF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 12:33:05 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:47012 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387507AbfAKRdB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 12:33:01 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x0BHWore096404;
        Fri, 11 Jan 2019 11:32:50 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1547227970;
        bh=c+IiZbaHvpokgG+a9KsLRRzFAtSotSWXO48E0HPUsz4=;
        h=From:To:CC:Subject:Date;
        b=dfSy863RR7nkFTuTm6AiyRRimW7YTwakrvBTEWlAPiCF7Uxwe/h/TuDEdScmOnd5U
         6J5IDEzUWtm7NlerpvUSRcVbyqg7CKuyneqSiEbLezAI41qlPkcUO5gWTPDe4USoHd
         7vNc/+5yL0VnCiNkmepgYZ0EeAX0dq+wg38bgFCQ=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x0BHWoR6104300
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 11 Jan 2019 11:32:50 -0600
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Fri, 11
 Jan 2019 11:32:49 -0600
Received: from dlep33.itg.ti.com (157.170.170.75) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Fri, 11 Jan 2019 11:32:49 -0600
Received: from legion.dal.desgin.ti.com (legion.dal.design.ti.com [128.247.22.53])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x0BHWnB9015627;
        Fri, 11 Jan 2019 11:32:49 -0600
Received: from localhost (a0272616local-lt.dhcp.ti.com [172.22.88.224])
        by legion.dal.desgin.ti.com (8.11.7p1+Sun/8.11.7) with ESMTP id x0BHWnU03632;
        Fri, 11 Jan 2019 11:32:49 -0600 (CST)
From:   Dan Murphy <dmurphy@ti.com>
To:     <wg@grandegger.com>, <mkl@pengutronix.de>, <davem@davemloft.net>,
        <b29396@freescale.com>
CC:     <linux-can@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Dan Murphy <dmurphy@ti.com>
Subject: [PATCH v3 0/4] M_CAN Framework
Date:   Fri, 11 Jan 2019 11:32:32 -0600
Message-ID: <20190111173236.14329-1-dmurphy@ti.com>
X-Mailer: git-send-email 2.12.2
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All

Well it has taken me a while to get this working and ported to a provide a
m_can framework that manages the Bosch m_can stack and abstracts away devices
to use that framework.

The m_can.c is the framework that devices register to.

The device abstractions can provide read/write capability as well as bit timings
and also provide any other initializations that are device specific.

The m_can platform code will need to be updated as I have not tested this code.
The tcan code is working.

Dan

Dan Murphy (4):
  can: m_can: Create a m_can platform framework
  can: m_can: Migrate the m_can code to use the framework
  dt-bindings: can: tcan4x5x: Add DT bindings for TCAN4x5X driver
  can: tcan4x5x: Add tcan4x5x driver to the kernel

 .../devicetree/bindings/net/can/tcan4x5x.txt  |  37 +
 drivers/net/can/m_can/Kconfig                 |  18 +
 drivers/net/can/m_can/Makefile                |   4 +-
 drivers/net/can/m_can/m_can.c                 | 765 +++++++++---------
 drivers/net/can/m_can/m_can_platform.c        | 212 +++++
 drivers/net/can/m_can/m_can_platform.h        | 163 ++++
 drivers/net/can/m_can/tcan4x5x.c              | 458 +++++++++++
 7 files changed, 1253 insertions(+), 404 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/can/tcan4x5x.txt
 create mode 100644 drivers/net/can/m_can/m_can_platform.c
 create mode 100644 drivers/net/can/m_can/m_can_platform.h
 create mode 100644 drivers/net/can/m_can/tcan4x5x.c

-- 
2.20.1.98.gecbdaf0899

