Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DDB3C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:59:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E76C920847
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:59:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E76C920847
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387759AbeHWM1o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 08:27:44 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:53044 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727293AbeHWM1n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 08:27:43 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 73973C83;
        Thu, 23 Aug 2018 08:59:01 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Xue Liu <liuxuenetmail@gmail.com>,
        Stefan Schmidt <stefan@datenfreihafen.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.17 190/324] ieee802154: mcr20a: add missing includes
Date:   Thu, 23 Aug 2018 09:54:16 +0200
Message-Id: <20180823075005.662280677@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180823074955.885811006@linuxfoundation.org>
References: <20180823074955.885811006@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnd Bergmann <arnd@arndb.de>

[ Upstream commit a6032120d341badd9b034cb64411e7089d8f4285 ]

Without CONFIG_GPIOLIB, some headers are not included implicitly,
leading to a build failure:

drivers/net/ieee802154/mcr20a.c: In function 'mcr20a_probe':
drivers/net/ieee802154/mcr20a.c:1347:13: error: implicit declaration of function 'irq_get_trigger_type'; did you mean 'irq_get_irqchip_state'? [-Werror=implicit-function-declaration]

This includes gpio/consumer.h and irq.h directly rather through the
gpiolib header.

Fixes: 8c6ad9cc5157 ("ieee802154: Add NXP MCR20A IEEE 802.15.4 transceiver driver")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Xue Liu <liuxuenetmail@gmail.com>
Signed-off-by: Stefan Schmidt <stefan@datenfreihafen.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ieee802154/mcr20a.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/net/ieee802154/mcr20a.c
+++ b/drivers/net/ieee802154/mcr20a.c
@@ -15,10 +15,11 @@
  */
 #include <linux/kernel.h>
 #include <linux/module.h>
-#include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/spi/spi.h>
 #include <linux/workqueue.h>
 #include <linux/interrupt.h>
+#include <linux/irq.h>
 #include <linux/skbuff.h>
 #include <linux/of_gpio.h>
 #include <linux/regmap.h>


