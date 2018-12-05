Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30AFFC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 19:28:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E73E22082D
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 19:28:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="IWHXfWMU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E73E22082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728432AbeLET2l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 14:28:41 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:37850 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727297AbeLET2l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 14:28:41 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id wB5JSXrk084577;
        Wed, 5 Dec 2018 13:28:33 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1544038113;
        bh=M8WamxRXWRW48RHmKdb0jfqihc93imEMwB1ztH+Njok=;
        h=From:To:CC:Subject:Date;
        b=IWHXfWMUlfb+qehCTqTN9K4ZtDAsz+HFWJRttElZStWrz8GE7c3V9F1eTY8UJQ14U
         nAWgKyPR/nhi2rcjBeQnOa4P4dMRGeDIHTTN+Sqgt6rRwGjPr/x2l7ROpHZTABdvZL
         zsaTp82r4keXyMfx2dx/SIX044g8LrVVEQwWhThs=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wB5JSXxe027117
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 5 Dec 2018 13:28:33 -0600
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Wed, 5
 Dec 2018 13:28:32 -0600
Received: from dlep32.itg.ti.com (157.170.170.100) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Wed, 5 Dec 2018 13:28:33 -0600
Received: from legion.dal.desgin.ti.com (legion.dal.design.ti.com [128.247.22.53])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id wB5JSWOU015675;
        Wed, 5 Dec 2018 13:28:32 -0600
Received: from localhost (a0272616local-lt.dhcp.ti.com [172.22.72.36])
        by legion.dal.desgin.ti.com (8.11.7p1+Sun/8.11.7) with ESMTP id wB5JSWU29744;
        Wed, 5 Dec 2018 13:28:32 -0600 (CST)
From:   Dan Murphy <dmurphy@ti.com>
To:     <wg@grandegger.com>, <mkl@pengutronix.de>, <davem@davemloft.net>
CC:     <linux-can@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Dan Murphy <dmurphy@ti.com>
Subject: [[RFC] PATCH v2 0/4] M_CAN framework patches
Date:   Wed, 5 Dec 2018 13:28:21 -0600
Message-ID: <20181205192825.11555-1-dmurphy@ti.com>
X-Mailer: git-send-email 2.12.2
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All

This patch series contains no code modifications.  Based on Wolfgangs advice
I moved the files to different names and committe them independently so they
can be reviewed easier.

The first patch create the framework code abstracted from the main m_can.c.
The second patch adapts the m_can.c to use the framework code
The final patches add the TCAN device to the use the m_can framework.

Again these patches are RFC and no code modifications were made in v2.
I will be updating the code based on this version.

Dan

Dan Murphy (4):
  can: m_can: Create a m_can platform framework
  can: m_can: Migrate the m_can code to use the framework
  dt-bindings: can: tcan4x5x: Add DT bindings for TCAN4x5X driver
  can: tcan4x5x: Add tcan4x5x driver to the kernel

 .../devicetree/bindings/net/can/tcan4x5x.txt  |  34 ++
 drivers/net/can/m_can/Kconfig                 |  18 +
 drivers/net/can/m_can/Makefile                |   4 +-
 drivers/net/can/m_can/m_can.c                 | 479 +++++++++---------
 drivers/net/can/m_can/m_can_platform.c        | 168 ++++++
 drivers/net/can/m_can/m_can_platform.h        | 100 ++++
 drivers/net/can/m_can/tcan4x5x.c              | 321 ++++++++++++
 7 files changed, 870 insertions(+), 254 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/can/tcan4x5x.txt
 create mode 100644 drivers/net/can/m_can/m_can_platform.c
 create mode 100644 drivers/net/can/m_can/m_can_platform.h
 create mode 100644 drivers/net/can/m_can/tcan4x5x.c

-- 
2.20.0.rc2.7.g965798d1f2

