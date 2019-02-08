Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83C11C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 11:52:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59F9F20857
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 11:52:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727359AbfBHLwF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 06:52:05 -0500
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:57075 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726522AbfBHLwE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 06:52:04 -0500
X-Originating-IP: 90.88.22.177
Received: from localhost (aaubervilliers-681-1-80-177.w90-88.abo.wanadoo.fr [90.88.22.177])
        (Authenticated sender: thomas.petazzoni@bootlin.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 6056F6000E;
        Fri,  8 Feb 2019 11:52:02 +0000 (UTC)
From:   Thomas Petazzoni <thomas.petazzoni@bootlin.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH 0/3] gpio: drop a few unneeded irq_{request,release}_resources implementations
Date:   Fri,  8 Feb 2019 12:51:58 +0100
Message-Id: <20190208115201.7518-1-thomas.petazzoni@bootlin.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Three GPIO drivers in the tree implement the
irq_{request,release}_resources hooks with what is in fact the default
implementation provided by the GPIO core, making this driver-specific
code redundant.

It is worth mentioning that I do not own any of the affected
platforms, to the three patches have only been built-tested. Each is
Cc'ed to the appropriate maintainer, except gpio-em that has no
platform-specific maintainer.

Best regards,

Thomas Petazzoni

Thomas Petazzoni (3):
  gpio: bcm-kona: drop ->irq_{request,release}_resources hooks
  gpio: dwapb: drop ->irq_{request,release}_resources hooks
  gpio: em: drop ->irq_{request,release}_resources hooks

 drivers/gpio/gpio-bcm-kona.c | 16 ----------------
 drivers/gpio/gpio-dwapb.c    | 27 ---------------------------
 drivers/gpio/gpio-em.c       | 25 -------------------------
 3 files changed, 68 deletions(-)

-- 
2.20.1

