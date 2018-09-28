Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85791C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 18:30:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F38620685
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 18:30:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="BRUTIq0M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F38620685
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726378AbeI2AzE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 20:55:04 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:37608 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726118AbeI2AzE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 20:55:04 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id w8SITwFb001953;
        Fri, 28 Sep 2018 13:29:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1538159398;
        bh=2tOaFHwxytnShzYfnJwFZzkaEbEUaaCUU9uj8VSrjX4=;
        h=From:To:CC:Subject:Date;
        b=BRUTIq0MXSAtqbo/j46fuxJnk1WydkBx2Vj0Yw8UnLNkwxFlxXSGltk/vKoZNxE0N
         /3aMq42CaoWQk7RoOJiWInHk4Ck9jCBlhizth+xlB/QyMpb+wEOswbTkb33wCXVBYi
         NWLJqe+sBY3v7SIaGljbmX3pC3XiLHrYSyOaTzUg=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w8SITwlA001784;
        Fri, 28 Sep 2018 13:29:58 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Fri, 28
 Sep 2018 13:29:58 -0500
Received: from dflp33.itg.ti.com (10.64.6.16) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Fri, 28 Sep 2018 13:29:58 -0500
Received: from legion.dal.design.ti.com (legion.dal.design.ti.com [128.247.22.53])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w8SITwKg014919;
        Fri, 28 Sep 2018 13:29:58 -0500
Received: from localhost (a0272616local-lt.dhcp.ti.com [172.22.149.181])
        by legion.dal.design.ti.com (8.11.7p1+Sun/8.11.7) with ESMTP id w8SITvx27694;
        Fri, 28 Sep 2018 13:29:57 -0500 (CDT)
From:   Dan Murphy <dmurphy@ti.com>
To:     <robh+dt@kernel.org>, <jacek.anaszewski@gmail.com>, <pavel@ucw.cz>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <lee.jones@linaro.org>, <linux-omap@vger.kernel.org>,
        <linux-leds@vger.kernel.org>, Dan Murphy <dmurphy@ti.com>
Subject: [RFC PATCH v2 0/9] TI LMU and Dedicated Drivers
Date:   Fri, 28 Sep 2018 13:29:45 -0500
Message-ID: <20180928182954.25446-1-dmurphy@ti.com>
X-Mailer: git-send-email 2.12.2
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All

The following v2 patchset has been debugged and updated to support the
LM3697, LM3632 and LM3633.  The TI LMU common code has been used and can
be extended where need be.  If this approach is acceptable I will make code
changes based on review and submit v3 with additional bindings updates for
full review and merge.

These 3 LED drivers should be functional to provide basic lighting experiences.
Other features like PWM support will be included later and maybe part of the
common code.

I usually list all the deltas in my patch sets but due to the major rip in the
drivers I would repeat myself just saying that there are too many changes to
list.

Dan

Dan Murphy (8):
  dt-bindings: ti-lmu: Remove LM3697
  mfd: ti-lmu: Remove support for LM3697
  dt-bindings: leds: Add bindings for lm3697 driver
  leds: lm3697: Introduce the lm3697 driver
  dt-bindings: leds: Add support for the LM3633
  leds: lm3633: Introduce the lm3633 driver
  dt-bindings: leds: Add the LM3632 LED dt binding
  leds: lm3632: Introduce the TI LM3632 driver

Pavel Machek (1):
  leds: add TI LMU backlight driver

 .../devicetree/bindings/leds/leds-lm3632.txt  |  53 ++
 .../devicetree/bindings/leds/leds-lm3633.txt  | 102 +++
 .../devicetree/bindings/leds/leds-lm3697.txt  |  98 +++
 .../devicetree/bindings/mfd/ti-lmu.txt        |  26 +-
 drivers/leds/Kconfig                          |  30 +
 drivers/leds/Makefile                         |   4 +
 drivers/leds/leds-lm3632.c                    | 646 ++++++++++++++++++
 drivers/leds/leds-lm3633.c                    | 557 +++++++++++++++
 drivers/leds/leds-lm3697.c                    | 382 +++++++++++
 drivers/leds/ti-lmu-led-common.c              | 138 ++++
 drivers/leds/ti-lmu-led-common.h              |  54 ++
 drivers/mfd/Kconfig                           |   2 +-
 drivers/mfd/ti-lmu.c                          |  17 -
 include/linux/mfd/ti-lmu-register.h           |  44 --
 include/linux/mfd/ti-lmu.h                    |   1 -
 15 files changed, 2066 insertions(+), 88 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/leds/leds-lm3632.txt
 create mode 100644 Documentation/devicetree/bindings/leds/leds-lm3633.txt
 create mode 100644 Documentation/devicetree/bindings/leds/leds-lm3697.txt
 create mode 100644 drivers/leds/leds-lm3632.c
 create mode 100644 drivers/leds/leds-lm3633.c
 create mode 100644 drivers/leds/leds-lm3697.c
 create mode 100644 drivers/leds/ti-lmu-led-common.c
 create mode 100644 drivers/leds/ti-lmu-led-common.h

-- 
2.19.0

