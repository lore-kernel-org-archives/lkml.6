Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2C01C43444
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 17:33:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7155121917
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 17:33:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390306AbeLURdS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 12:33:18 -0500
Received: from mail.bootlin.com ([62.4.15.54]:36152 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729523AbeLURdS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 12:33:18 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 912592072C; Fri, 21 Dec 2018 18:33:15 +0100 (CET)
Received: from localhost (242.171.71.37.rev.sfr.net [37.71.171.242])
        by mail.bootlin.com (Postfix) with ESMTPSA id 6326720701;
        Fri, 21 Dec 2018 18:33:05 +0100 (CET)
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-arm-kernel@lists.infradead.org,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        =?UTF-8?q?Miqu=C3=A8l=20Raynal?= <miquel.raynal@bootlin.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Nadav Haklai <nadavh@marvell.com>,
        Marcin Wojtas <mw@semihalf.com>
Subject: [PATCH 0/3] Few fix for pins configuration on Armada 37xx
Date:   Fri, 21 Dec 2018 18:32:56 +0100
Message-Id: <20181221173259.8372-1-gregory.clement@bootlin.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

this small series fixes wrong pins configuration we currently have on
Armada 37xx.

For now it is especially annoying it we want to enable suspend to
RAM for PCie.

Gregory

Gregory CLEMENT (2):
  pinctrl: armada-37xx: add missing pin: PCIe1 Wakeup
  pinctrl: dt-bindings: Fix the armada-37xx documentation

Marek Behún (1):
  pinctrl: armada-37xx: Correct mpp definitions

 .../pinctrl/marvell,armada-37xx-pinctrl.txt   | 24 ++++++++++++++-----
 drivers/pinctrl/mvebu/pinctrl-armada-37xx.c   | 11 +++++----
 2 files changed, 25 insertions(+), 10 deletions(-)

-- 
2.19.2

