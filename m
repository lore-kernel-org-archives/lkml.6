Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.7 required=3.0 tests=DATE_IN_PAST_03_06,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DFFAECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 16:07:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E34CC2150D
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 16:07:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E34CC2150D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=skidata.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727851AbeJRADy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 20:03:54 -0400
Received: from mail1.skidata.com ([91.230.2.99]:30706 "EHLO mail1.skidata.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727014AbeJRADy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 20:03:54 -0400
X-IronPort-AV: E=Sophos;i="5.54,393,1534802400"; 
   d="scan'208";a="12919527"
From:   Richard Leitner <richard.leitner@skidata.com>
To:     <dmitry.torokhov@gmail.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>
CC:     <linux-input@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Richard Leitner <richard.leitner@skidata.com>
Subject: [PATCH v2 0/7] Input: sx8654 - reset-gpio, sx865[056] support, etc.
Date:   Wed, 17 Oct 2018 14:51:08 +0200
Message-ID: <20181017125116.20077-1-richard.leitner@skidata.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.111.252]
X-ClientProxiedBy: sdex5srv.skidata.net (192.168.111.83) To
 sdex5srv.skidata.net (192.168.111.83)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add reset-gpio, sx8654[056] and common of_touchscreen functions support
for the sx8654 driver.

Changes v2:
	- use devm_gpiod_get_optional in probe instead of in #ifdef CONFIG_OF
	- convert flags to BIT() in a separate patch
	- replace hrtimer with "regular" timer
	- use of_device_get_match_data instead of of_match_device
	- add driver data to i2c_device_id table for non-DT fallback
	- fix sequence of common touchscreen initialization
	- div. minor stlye changes

Richard Leitner (8):
  dt-bindings: input: touchscreen: sx8654: add reset-gpio property
  Input: sx8654 - add reset-gpio support
  dt-bindings: input: touchscreen: sx8654: add compatible models
  Input: sx8654 - add sx8655 and sx8656 to compatibles
  dt-bindings: input: touchscreen: sx8654: add sx8650 to comatibles
  Input: sx8654 - add sx8650 support
  Input: sx8654 - use common of_touchscreen functions
  Input: sx8654 - convert #defined flags to BIT(x)

 .../bindings/input/touchscreen/sx8654.txt          |  10 +-
 drivers/input/touchscreen/sx8654.c                 | 245 ++++++++++++++++++---
 2 files changed, 229 insertions(+), 26 deletions(-)

-- 
2.11.0

