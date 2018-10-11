Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9593DC677FC
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 16:52:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C5C72098A
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 16:52:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="pwEOmJaA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C5C72098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730633AbeJLATj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 20:19:39 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:35782 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730549AbeJLATi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 20:19:38 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id w9BGpR9Z030856;
        Thu, 11 Oct 2018 11:51:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1539276687;
        bh=ARrCk9ClvrBselvof++Pvm/H7uhSwUkXfYJbwlz8k0g=;
        h=From:To:CC:Subject:Date;
        b=pwEOmJaAWeowt9du3WjpLxN9GYpsmOJsWDgSolp9bpA9cDSnPm6f0PVmjezeGdZIZ
         kG0f3oA5mAl3o+VBSNJmg8k9mZ7dO2h7BYQeWLjggjUw/BT7LO9790hftIExuDPjGT
         NOQ28f+N4PaPsNR6dbUPfO0cslTFAREf8bKQiByQ=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w9BGpR8q026716;
        Thu, 11 Oct 2018 11:51:27 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Thu, 11
 Oct 2018 11:51:27 -0500
Received: from dflp32.itg.ti.com (10.64.6.15) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Thu, 11 Oct 2018 11:51:27 -0500
Received: from legion.dal.design.ti.com (legion.dal.design.ti.com [128.247.22.53])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w9BGpQwm006923;
        Thu, 11 Oct 2018 11:51:26 -0500
Received: from localhost (a0272616local-lt.dhcp.ti.com [172.22.172.124])
        by legion.dal.design.ti.com (8.11.7p1+Sun/8.11.7) with ESMTP id w9BGpQx20791;
        Thu, 11 Oct 2018 11:51:26 -0500 (CDT)
From:   Dan Murphy <dmurphy@ti.com>
To:     <robh+dt@kernel.org>, <jacek.anaszewski@gmail.com>, <pavel@ucw.cz>
CC:     <lee.jones@linaro.org>, <tony@atomide.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-leds@vger.kernel.org>, Dan Murphy <dmurphy@ti.com>
Subject: [PATCH v3 0/9] TI LMU common Framework
Date:   Thu, 11 Oct 2018 11:51:14 -0500
Message-ID: <20181011165123.32198-1-dmurphy@ti.com>
X-Mailer: git-send-email 2.12.2
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All

I have updated the patch set and addressed some of the comments.
Thanks to Pavel, he found the lm3639 back light driver that is similar
enough to the LM3632 device.  So I removed that device from this patch series.

I am in the process of adding the LM3632 to the LM3639 back light driver as well
as adding additional improvements to that driver.

Dan

Dan Murphy (8):
  dt-bindings: ti-lmu: Remove LM3697
  mfd: ti-lmu: Remove support for LM3697
  dt-bindings: leds: Add bindings for lm3697 driver
  leds: lm3697: Introduce the lm3697 driver
  dt-bindings: ti-lmu: Remove LM3633
  mfd: ti-lmu: Remove support for LM3633
  dt-bindings: leds: Add support for the LM3633
  leds: lm3633: Introduce the lm3633 driver

Pavel Machek (1):
  leds: add TI LMU backlight driver

 .../devicetree/bindings/leds/leds-lm3633.txt  | 102 ++++
 .../devicetree/bindings/leds/leds-lm3697.txt  |  98 +++
 .../devicetree/bindings/mfd/ti-lmu.txt        |  72 ---
 drivers/leds/Kconfig                          |  22 +
 drivers/leds/Makefile                         |   3 +
 drivers/leds/leds-lm3633.c                    | 556 ++++++++++++++++++
 drivers/leds/leds-lm3697.c                    | 381 ++++++++++++
 drivers/leds/ti-lmu-led-common.c              | 138 +++++
 drivers/mfd/Kconfig                           |   2 +-
 drivers/mfd/ti-lmu.c                          |  38 --
 include/linux/mfd/ti-lmu-register.h           |  44 --
 include/linux/mfd/ti-lmu.h                    |   1 -
 include/linux/ti-lmu-led-common.h             |  59 ++
 13 files changed, 1360 insertions(+), 156 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/leds/leds-lm3633.txt
 create mode 100644 Documentation/devicetree/bindings/leds/leds-lm3697.txt
 create mode 100644 drivers/leds/leds-lm3633.c
 create mode 100644 drivers/leds/leds-lm3697.c
 create mode 100644 drivers/leds/ti-lmu-led-common.c
 create mode 100644 include/linux/ti-lmu-led-common.h

-- 
2.19.0

