Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46ED9C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 13:27:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 207E120C01
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 13:27:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728167AbfBTN1f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 08:27:35 -0500
Received: from relmlor1.renesas.com ([210.160.252.171]:47262 "EHLO
        relmlie5.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725836AbfBTN1f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 08:27:35 -0500
X-IronPort-AV: E=Sophos;i="5.58,391,1544454000"; 
   d="scan'208";a="8389304"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 20 Feb 2019 22:27:33 +0900
Received: from renesas-VirtualBox.ree.adwin.renesas.com (unknown [10.226.37.56])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 5E4B040C46FE;
        Wed, 20 Feb 2019 22:27:30 +0900 (JST)
From:   Gareth Williams <gareth.williams.jx@renesas.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Gareth Williams <gareth.williams.jx@renesas.com>,
        devicetree@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/2] i2c: designware: Add support for a bus clock
Date:   Wed, 20 Feb 2019 13:25:46 +0000
Message-Id: <1550669148-6027-1-git-send-email-gareth.williams.jx@renesas.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Synopsys I2C Controller has a bus clock that some SoCs require to access
the registers. This series also details the new clock property in the bindings
documentation.

v3:
 - busclk renamed to pclk.
 - Added comment with dw_i2c_dev struct definition describing pclk.
 - Added enable rollback of first clock if second fails to enable.
 - Changed clocks and clock-names sections to use term "peripheral clock"
   (pclk) instead of "bus clock" (busclk) in dt-bindings documentation.
v2:
 - Use new devm_clk_get_optional() function as it simplifies handling when
   the optional clock is not present.

Phil Edworthy (2):
  dt: snps,designware-i2c: Add clock bindings documentation
  i2c: designware: Add support for a bus clock

 .../devicetree/bindings/i2c/i2c-designware.txt         |  9 +++++++++
 drivers/i2c/busses/i2c-designware-common.c             | 18 ++++++++++++++++--
 drivers/i2c/busses/i2c-designware-core.h               |  2 ++
 drivers/i2c/busses/i2c-designware-platdrv.c            |  5 +++++
 4 files changed, 32 insertions(+), 2 deletions(-)

-- 
2.7.4

