Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23BC5C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 15:11:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED85421736
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 15:11:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728347AbfBSPLl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 10:11:41 -0500
Received: from relmlor2.renesas.com ([210.160.252.172]:53861 "EHLO
        relmlie6.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726110AbfBSPLl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 10:11:41 -0500
X-IronPort-AV: E=Sophos;i="5.58,388,1544454000"; 
   d="scan'208";a="8078071"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 20 Feb 2019 00:11:38 +0900
Received: from renesas-VirtualBox.ree.adwin.renesas.com (unknown [10.226.37.56])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 1CF0A4485B11;
        Wed, 20 Feb 2019 00:11:35 +0900 (JST)
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
Subject: [PATCH v2 0/2] dt: i2c: Add support for bus clock
Date:   Tue, 19 Feb 2019 15:10:40 +0000
Message-Id: <1550589042-11096-1-git-send-email-gareth.williams.jx@renesas.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Synopsys I2C Controller has a bus clock that some SoCs require to access
the registers. This series also details the new clock property in the bindings
documentation.

v2:
 - Use new devm_clk_get_optional() function as it simplifies handling when
   the optional clock is not present.

Phil Edworthy (2):
  dt: snps,designware-i2c: Add clock bindings documentation
  i2c: designware: Add support for a bus clock

 Documentation/devicetree/bindings/i2c/i2c-designware.txt |  9 +++++++++
 drivers/i2c/busses/i2c-designware-common.c               | 12 +++++++++++-
 drivers/i2c/busses/i2c-designware-core.h                 |  1 +
 drivers/i2c/busses/i2c-designware-platdrv.c              |  5 +++++
 4 files changed, 26 insertions(+), 1 deletion(-)

-- 
2.7.4

