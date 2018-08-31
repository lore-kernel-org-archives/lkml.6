Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAC6BC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 15:11:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D99D2083C
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 15:11:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D99D2083C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728187AbeHaTTo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 15:19:44 -0400
Received: from mail.bootlin.com ([62.4.15.54]:46958 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727433AbeHaTTo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 15:19:44 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 8C0022071E; Fri, 31 Aug 2018 17:11:47 +0200 (CEST)
Received: from localhost (242.171.71.37.rev.sfr.net [37.71.171.242])
        by mail.bootlin.com (Postfix) with ESMTPSA id 5484C20828;
        Fri, 31 Aug 2018 17:11:27 +0200 (CEST)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Wolfram Sang <wsa@the-dreams.de>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        James Hogan <jhogan@kernel.org>,
        Paul Burton <paul.burton@mips.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Allan Nielsen <allan.nielsen@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH v5 0/7] Add support for MSCC Ocelot i2c
Date:   Fri, 31 Aug 2018 17:11:07 +0200
Message-Id: <20180831151114.25739-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.19.0.rc1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Because the designware IP was not able to handle the SDA hold time before
version 1.11a, MSCC has its own implementation. Add support for it and then add
i2c on ocelot boards.

I would expect patches 1 to 5 to go through the i2c tree.

Pathces 6-7 can go through the mips tree now that the bindings have been
reviewed.

Changes in v5:
 - rebased on v4.19-rc1
 - collected review, test and ack tags
 - renamed the bindings documentation patch

Changes in v4:
 - collected review and ack tags
 - split bindings to a separate patch

Changes in v3:
 - collected review tags
 - fixed build warnings on 64bit machines

Changes in v2:
 - removed first patch as a similar one is in i2c-next
 - rebase on top of i2c-next
 - Added two patches to implement ideas from Andy


Alexandre Belloni (7):
  i2c: designware: use generic table matching
  i2c: designware: move #ifdef CONFIG_OF to the top
  i2c: designware: allow IP specific sda_hold_time
  dt-bindings: i2c: designware: document MSCC Ocelot bindings
  i2c: designware: add MSCC Ocelot support
  MIPS: dts: mscc: Add i2c on ocelot
  MIPS: dts: mscc: enable i2c on ocelot_pcb123

 .../bindings/i2c/i2c-designware.txt           |  7 ++-
 arch/mips/boot/dts/mscc/ocelot.dtsi           | 19 ++++++
 arch/mips/boot/dts/mscc/ocelot_pcb123.dts     |  6 ++
 drivers/i2c/busses/i2c-designware-common.c    |  2 +
 drivers/i2c/busses/i2c-designware-core.h      |  4 ++
 drivers/i2c/busses/i2c-designware-platdrv.c   | 63 +++++++++++++++----
 6 files changed, 87 insertions(+), 14 deletions(-)

-- 
2.19.0.rc1

