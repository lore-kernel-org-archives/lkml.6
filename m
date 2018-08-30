Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 008B3C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 11:50:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3D54205C9
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 11:50:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3D54205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728605AbeH3PwN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 11:52:13 -0400
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:41731 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728443AbeH3PwN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 11:52:13 -0400
X-IronPort-AV: E=Sophos;i="5.53,306,1531810800"; 
   d="scan'208";a="18692616"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 30 Aug 2018 04:50:27 -0700
Received: from m18063-ThinkPad-T460p.mchp-main.com (10.10.76.4) by
 chn-sv-exch05.mchp-main.com (10.10.76.106) with Microsoft SMTP Server id
 14.3.352.0; Thu, 30 Aug 2018 04:50:26 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <linux@armlinux.org.uk>, <sre@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 0/6] shutdown procedure verification for SAMA5D2
Date:   Thu, 30 Aug 2018 14:50:05 +0300
Message-ID: <1535629811-13403-1-git-send-email-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Patch 1 from this series implement a fix for shutdown procedure
for SAMA5D2.

The rest of the patch are improvements as follows:
patch 2 - use only one function for poweroff
patches 3-6 - cosmetic improvements

The patches are based on latest sys-reset/for-next [1].

Thank you,
Claudiu Beznea

[1] https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git

Claudiu Beznea (6):
  power: reset: at91-poweroff: switch to slow clock before shutdown
  power: reset: at91-poweroff: use only one poweroff function
  power: reset: at91-poweroff: make mpddrc_base part of struct shdwc
  power: reset: at91-poweroff: make sclk part of struct shdwc
  power: reset: at91-poweroff: rename at91_shdwc_base member of struct
    shdwc
  power: reset: at91-poweroff: do not procede if at91_shdwc is allocated

 arch/arm/mach-at91/pm_suspend.S          |   8 +++
 drivers/power/reset/at91-sama5d2_shdwc.c | 119 +++++++++++++++++++++----------
 2 files changed, 88 insertions(+), 39 deletions(-)

-- 
2.7.4

