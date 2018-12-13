Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 857B3C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 12:34:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54A9020645
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 12:34:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54A9020645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729215AbeLMMe2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 07:34:28 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:39001 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728517AbeLMMeT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 07:34:19 -0500
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7] helo=dude.pengutronix.de.)
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1gXQBv-0005iT-Cy; Thu, 13 Dec 2018 13:34:11 +0100
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Dinh Nguyen <dinguyen@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 0/2] reset: socfpga, sunxi: declare _reset_init functions in header files
Date:   Thu, 13 Dec 2018 13:33:56 +0100
Message-Id: <20181213123358.24391-1-p.zabel@pengutronix.de>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

this moves the socpfga_reset_init function declaration into a header
file that is included by both mach-socfpga and reset-socfpga code,
as suggested by Stephen. The second patch does the same for
sun6i_reset_init.

Since the socfpga patch avoids a (trivial) merge conflict with the
arm-soc tree, I'd like to apply this to the reset/next branch before
sending a pull request.

regards
Philipp

Philipp Zabel (2):
  reset: sunxi: declare sun6i_reset_init in a header file
  reset: socfpga: declare socfpga_reset_init in a header file

 arch/arm/mach-socfpga/socfpga.c | 3 +--
 arch/arm/mach-sunxi/sunxi.c     | 2 +-
 drivers/reset/reset-socfpga.c   | 2 +-
 drivers/reset/reset-sunxi.c     | 1 +
 include/linux/reset/socfpga.h   | 7 +++++++
 include/linux/reset/sunxi.h     | 7 +++++++
 6 files changed, 18 insertions(+), 4 deletions(-)
 create mode 100644 include/linux/reset/socfpga.h
 create mode 100644 include/linux/reset/sunxi.h

-- 
2.19.1

