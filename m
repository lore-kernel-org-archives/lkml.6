Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F3BEECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 11:48:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 105C5208E3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 11:48:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 105C5208E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731404AbeGQMU6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 08:20:58 -0400
Received: from mail.bootlin.com ([62.4.15.54]:35950 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727877AbeGQMU6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 08:20:58 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id E272C207B4; Tue, 17 Jul 2018 13:48:40 +0200 (CEST)
Received: from localhost (242.171.71.37.rev.sfr.net [37.71.171.242])
        by mail.bootlin.com (Postfix) with ESMTPSA id B5B0420765;
        Tue, 17 Jul 2018 13:48:40 +0200 (CEST)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Wolfram Sang <wsa@the-dreams.de>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        James Hogan <jhogan@kernel.org>
Cc:     Paul Burton <paul.burton@mips.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Allan Nielsen <allan.nielsen@microsemi.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 0/5] Add support for MSCC Ocelot i2c
Date:   Tue, 17 Jul 2018 13:48:32 +0200
Message-Id: <20180717114837.21839-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Because the designware IP was not able to the the SDA hold time, MSCC has
its own implementation. Add support for it and then add i2c on ocelot
boards.

I would expect patches 1 to 3 to go through the i2c tree and 4-5 through
the mips tree once patch 3 has been reviewed by the DT maintainers.

Alexandre Belloni (5):
  i2c: designware: factorize setting SDA hold time
  i2c: designware: allow IP specific sda_hold_time
  i2c: designware: add MSCC Ocelot support
  mips: dts: mscc: Add i2c on ocelot
  mips: dts: mscc: enable i2c on ocelot_pcb123

 .../bindings/i2c/i2c-designware.txt           |  5 ++-
 arch/mips/boot/dts/mscc/ocelot.dtsi           | 19 +++++++++++
 arch/mips/boot/dts/mscc/ocelot_pcb123.dts     |  5 +++
 drivers/i2c/busses/i2c-designware-common.c    | 33 +++++++++++++++++++
 drivers/i2c/busses/i2c-designware-core.h      |  3 ++
 drivers/i2c/busses/i2c-designware-master.c    | 22 +------------
 drivers/i2c/busses/i2c-designware-platdrv.c   | 20 +++++++++++
 drivers/i2c/busses/i2c-designware-slave.c     | 22 +------------
 8 files changed, 86 insertions(+), 43 deletions(-)

-- 
2.18.0

