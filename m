Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CF43C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 21:33:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 760E420818
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 21:33:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726816AbfBUVdf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 16:33:35 -0500
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:50739 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726155AbfBUVde (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 16:33:34 -0500
Received: from Internal Mail-Server by MTLPINE1 (envelope-from sramani@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 21 Feb 2019 23:33:29 +0200
Received: from farm-0002.mtbu.labs.mlnx (farm-0002.mtbu.labs.mlnx [10.15.2.32])
        by mtbu-labmailer.labs.mlnx (8.14.4/8.14.4) with ESMTP id x1LLXQOc009779;
        Thu, 21 Feb 2019 16:33:26 -0500
Received: (from sramani@localhost)
        by farm-0002.mtbu.labs.mlnx (8.14.7/8.13.8/Submit) id x1LLXMCa032128;
        Thu, 21 Feb 2019 16:33:22 -0500
From:   Shravan Kumar Ramani <sramani@mellanox.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc:     Shravan Kumar Ramani <sramani@mellanox.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/1] gpio: add driver for Mellanox BlueField GPIO controller
Date:   Thu, 21 Feb 2019 16:32:54 -0500
Message-Id: <cover.1550783880.git.sramani@mellanox.com>
X-Mailer: git-send-email 2.1.2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes since v3
 - the naming scheme has been fixed to remove double underscores and use
standard variable names
 - the locking has been updated to protect the entire read/modify
operations.

Regarding the suggested use of the generic MMIO library, I noticed that
bgpio_init only allows for either dirin or dirout to be set, never both.
But since our controller has 2 separate registers, using bgpio_init
might not be possible here.

Shravan Kumar Ramani (1):
  gpio: add driver for Mellanox BlueField GPIO controller

 drivers/gpio/Kconfig      |   6 ++
 drivers/gpio/Makefile     |   1 +
 drivers/gpio/gpio-mlxbf.c | 222 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 229 insertions(+)
 create mode 100644 drivers/gpio/gpio-mlxbf.c

-- 
2.1.2

