Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEAB2C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 08:36:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93121217D8
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 08:36:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726536AbeLRIgX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 03:36:23 -0500
Received: from mail2.skidata.com ([91.230.2.91]:32220 "EHLO mail2.skidata.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726505AbeLRIgW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 03:36:22 -0500
X-IronPort-AV: E=Sophos;i="5.56,367,1539640800"; 
   d="scan'208";a="1873948"
From:   Richard Leitner <richard.leitner@skidata.com>
To:     <dmitry.torokhov@gmail.com>, <mark.rutland@arm.com>
CC:     <robh+dt@kernel.org>, <linux-input@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <richard.leitner@skidata.com>
Subject: [RESEND PATCH v2 0/8] Input: sx8654 - reset-gpio, sx865[056] support, etc.
Date:   Tue, 18 Dec 2018 09:35:58 +0100
Message-ID: <20181218083606.25795-1-richard.leitner@skidata.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.111.252]
X-ClientProxiedBy: sdex3srv.skidata.net (192.168.111.81) To
 sdex5srv.skidata.net (192.168.111.83)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add reset-gpio, sx8654[056] and common of_touchscreen functions support
for the sx8654 driver.

Changes RESEND v2:
	- added "Reviewed-by: Rob Herring <robh@kernel.org>" tags

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

