Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C68D6ECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 08:20:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E7DD2064D
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 08:20:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E7DD2064D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728265AbeGTJHo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 05:07:44 -0400
Received: from mail.bootlin.com ([62.4.15.54]:38175 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727572AbeGTJHn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 05:07:43 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id BE735207AD; Fri, 20 Jul 2018 10:20:35 +0200 (CEST)
Received: from localhost (unknown [37.170.73.107])
        by mail.bootlin.com (Postfix) with ESMTPSA id A897620618;
        Fri, 20 Jul 2018 10:20:33 +0200 (CEST)
Date:   Fri, 20 Jul 2018 10:20:30 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        arm@kernel.org
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] ARM: at91: SoC for 4.19
Message-ID: <20180720082030.GA22561@piout.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd, Olof,

Here is the SoC PR for 4.19. It is a cleanup of pm.c and the addition of
a new low power mode.

The following changes since commit ce397d215ccd07b8ae3f71db689aedb85d56ab40:

  Linux 4.18-rc1 (2018-06-17 08:04:49 +0900)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git tags/at91-ab-4.19-soc

for you to fetch changes up to d7484f5c6b3b0565d2395aece2862f183581e1c1:

  ARM: at91: pm: configure wakeup sources for ULP1 mode (2018-07-17 15:08:12 +0200)

----------------------------------------------------------------
AT91 SoC for 4.19:

 - New low power mode for sama5d2: ULP1

----------------------------------------------------------------
Boris Brezillon (1):
      MAINTAINERS: Remove the AT91 clk driver entry

Claudiu Beznea (3):
      ARM: at91: pm: Use ULP0 naming instead of slow clock
      ARM: at91: pm: add PMC fast startup registers defines
      ARM: at91: pm: configure wakeup sources for ULP1 mode

Wenyou Yang (1):
      ARM: at91: pm: Add ULP1 mode support

 MAINTAINERS                     |   5 --
 arch/arm/mach-at91/pm.c         | 187 +++++++++++++++++++++++++++++++++-------
 arch/arm/mach-at91/pm.h         |   6 +-
 arch/arm/mach-at91/pm_suspend.S | 142 +++++++++++++++++++++++++-----
 include/linux/clk/at91_pmc.h    |  15 ++++
 5 files changed, 297 insertions(+), 58 deletions(-)

-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
