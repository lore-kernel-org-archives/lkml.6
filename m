Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94B5BC32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 12:31:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 529152077C
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 12:31:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 529152077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mleia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727846AbeJKT60 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 15:58:26 -0400
Received: from mleia.com ([178.79.152.223]:54658 "EHLO mail.mleia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726537AbeJKT60 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 15:58:26 -0400
Received: from mail.mleia.com (localhost [127.0.0.1])
        by mail.mleia.com (Postfix) with ESMTP id B7CBB41F2B5;
        Thu, 11 Oct 2018 13:31:25 +0100 (BST)
From:   Vladimir Zapolskiy <vz@mleia.com>
To:     arm@kernel.org, Joachim Eastwood <manabian@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] MAINTAINERS: Assign myself as a maintainer of ARM/LPC18XX architecture
Date:   Thu, 11 Oct 2018 15:31:16 +0300
Message-Id: <20181011123116.24885-1-vz@mleia.com>
X-Mailer: git-send-email 2.17.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-49551924 
X-CRM114-CacheID: sfid-20181011_133125_773404_97FC10B1 
X-CRM114-Status: GOOD (  11.57  )
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To all appearance Joachim Eastwood abandoned the maintenance of NXP
LPC18xx/LPC43xx archtecture about two years ago, and for me it would be
possible to continue the support, fortunately the quality of platform
drivers written by Joachim is exceptionally high.

The change is based on https://lkml.org/lkml/2018/9/24/1398 discussion.

At the same time two redundant explicit driver file paths are dropped
from the list, clk-lpc18xx* drivers are covered by "lpc18xx" search
pattern and timer-lpc32xx driver is covered by "lpc32xx" pattern and it
goes into ARM/LPC32XX entry, which is also under my wing, in other words
LPC18xx/LPC43xx clocksource and CCF drivers will remain maintained.

Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
Cc: Joachim Eastwood <manabian@gmail.com>
---
 MAINTAINERS | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 57e78e400fd3..15c4abb7bda6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1653,12 +1653,10 @@ L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 
 ARM/LPC18XX ARCHITECTURE
-M:	Joachim Eastwood <manabian@gmail.com>
+M:	Vladimir Zapolskiy <vz@mleia.com>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 F:	arch/arm/boot/dts/lpc43*
-F:	drivers/clk/nxp/clk-lpc18xx*
-F:	drivers/clocksource/timer-lpc32xx.c
 F:	drivers/i2c/busses/i2c-lpc2k.c
 F:	drivers/memory/pl172.c
 F:	drivers/mtd/spi-nor/nxp-spifi.c
-- 
2.17.1

