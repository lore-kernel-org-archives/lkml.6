Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE2D7C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 21:14:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8201924E44
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 21:14:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8201924E44
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753494AbeGBVOF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 17:14:05 -0400
Received: from mga11.intel.com ([192.55.52.93]:11968 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753087AbeGBVOE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 17:14:04 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Jul 2018 14:14:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,300,1526367600"; 
   d="scan'208";a="52145093"
Received: from maru.jf.intel.com ([10.54.51.80])
  by fmsmga008.fm.intel.com with ESMTP; 02 Jul 2018 14:14:03 -0700
From:   Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
To:     Brendan Higgins <brendanhiggins@google.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>, linux-i2c@vger.kernel.org,
        openbmc@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc:     Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        James Feist <james.feist@linux.intel.com>,
        Vernon Mauery <vernon.mauery@linux.intel.com>,
        Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Subject: [PATCH] i2c: aspeed: Add newline characters into message printings.
Date:   Mon,  2 Jul 2018 14:13:59 -0700
Message-Id: <20180702211359.30585-1-jae.hyun.yoo@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are some log printing without a newline character. This
patch adds the missing newline characters.

Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
---
 drivers/i2c/busses/i2c-aspeed.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/i2c/busses/i2c-aspeed.c b/drivers/i2c/busses/i2c-aspeed.c
index 60e4d0e939a3..e3007c1c4ac5 100644
--- a/drivers/i2c/busses/i2c-aspeed.c
+++ b/drivers/i2c/busses/i2c-aspeed.c
@@ -407,7 +407,7 @@ static bool aspeed_i2c_master_irq(struct aspeed_i2c_bus *bus)
 	 */
 	ret = aspeed_i2c_is_irq_error(irq_status);
 	if (ret < 0) {
-		dev_dbg(bus->dev, "received error interrupt: 0x%08x",
+		dev_dbg(bus->dev, "received error interrupt: 0x%08x\n",
 			irq_status);
 		bus->cmd_err = ret;
 		bus->master_state = ASPEED_I2C_MASTER_INACTIVE;
@@ -416,7 +416,7 @@ static bool aspeed_i2c_master_irq(struct aspeed_i2c_bus *bus)
 
 	/* We are in an invalid state; reset bus to a known state. */
 	if (!bus->msgs) {
-		dev_err(bus->dev, "bus in unknown state");
+		dev_err(bus->dev, "bus in unknown state\n");
 		bus->cmd_err = -EIO;
 		if (bus->master_state != ASPEED_I2C_MASTER_STOP)
 			aspeed_i2c_do_stop(bus);
@@ -431,7 +431,7 @@ static bool aspeed_i2c_master_irq(struct aspeed_i2c_bus *bus)
 	 */
 	if (bus->master_state == ASPEED_I2C_MASTER_START) {
 		if (unlikely(!(irq_status & ASPEED_I2CD_INTR_TX_ACK))) {
-			pr_devel("no slave present at %02x", msg->addr);
+			pr_devel("no slave present at %02x\n", msg->addr);
 			status_ack |= ASPEED_I2CD_INTR_TX_NAK;
 			bus->cmd_err = -ENXIO;
 			aspeed_i2c_do_stop(bus);
@@ -451,11 +451,11 @@ static bool aspeed_i2c_master_irq(struct aspeed_i2c_bus *bus)
 	switch (bus->master_state) {
 	case ASPEED_I2C_MASTER_TX:
 		if (unlikely(irq_status & ASPEED_I2CD_INTR_TX_NAK)) {
-			dev_dbg(bus->dev, "slave NACKed TX");
+			dev_dbg(bus->dev, "slave NACKed TX\n");
 			status_ack |= ASPEED_I2CD_INTR_TX_NAK;
 			goto error_and_stop;
 		} else if (unlikely(!(irq_status & ASPEED_I2CD_INTR_TX_ACK))) {
-			dev_err(bus->dev, "slave failed to ACK TX");
+			dev_err(bus->dev, "slave failed to ACK TX\n");
 			goto error_and_stop;
 		}
 		status_ack |= ASPEED_I2CD_INTR_TX_ACK;
@@ -478,7 +478,7 @@ static bool aspeed_i2c_master_irq(struct aspeed_i2c_bus *bus)
 		/* fallthrough intended */
 	case ASPEED_I2C_MASTER_RX:
 		if (unlikely(!(irq_status & ASPEED_I2CD_INTR_RX_DONE))) {
-			dev_err(bus->dev, "master failed to RX");
+			dev_err(bus->dev, "master failed to RX\n");
 			goto error_and_stop;
 		}
 		status_ack |= ASPEED_I2CD_INTR_RX_DONE;
@@ -509,7 +509,7 @@ static bool aspeed_i2c_master_irq(struct aspeed_i2c_bus *bus)
 		goto out_no_complete;
 	case ASPEED_I2C_MASTER_STOP:
 		if (unlikely(!(irq_status & ASPEED_I2CD_INTR_NORMAL_STOP))) {
-			dev_err(bus->dev, "master failed to STOP");
+			dev_err(bus->dev, "master failed to STOP\n");
 			bus->cmd_err = -EIO;
 			/* Do not STOP as we have already tried. */
 		} else {
@@ -520,7 +520,7 @@ static bool aspeed_i2c_master_irq(struct aspeed_i2c_bus *bus)
 		goto out_complete;
 	case ASPEED_I2C_MASTER_INACTIVE:
 		dev_err(bus->dev,
-			"master received interrupt 0x%08x, but is inactive",
+			"master received interrupt 0x%08x, but is inactive\n",
 			irq_status);
 		bus->cmd_err = -EIO;
 		/* Do not STOP as we should be inactive. */
@@ -851,7 +851,7 @@ static int aspeed_i2c_probe_bus(struct platform_device *pdev)
 	bus->rst = devm_reset_control_get_shared(&pdev->dev, NULL);
 	if (IS_ERR(bus->rst)) {
 		dev_err(&pdev->dev,
-			"missing or invalid reset controller device tree entry");
+			"missing or invalid reset controller device tree entry\n");
 		return PTR_ERR(bus->rst);
 	}
 	reset_control_deassert(bus->rst);
-- 
2.17.1

