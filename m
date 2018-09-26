Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A93EC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 13:02:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D49E220684
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 13:02:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D49E220684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728388AbeIZTPV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 15:15:21 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:42677 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726315AbeIZTPU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 15:15:20 -0400
Received: from wuerfel.lan ([109.193.40.16]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.145]) with ESMTPA (Nemesis) id
 1ML9i0-1gMGcp2KOo-00IDrL; Wed, 26 Sep 2018 15:01:41 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] media: imx-pxp: include linux/interrupt.h
Date:   Wed, 26 Sep 2018 15:01:26 +0200
Message-Id: <20180926130139.2320343-1-arnd@arndb.de>
X-Mailer: git-send-email 2.18.0
X-Provags-ID: V03:K1:RXGvj4P/YjKUiKE6/HoZ4HK4U71GNkYXs0/1eESTVmldi6Wl6Bg
 n4fjYkfwa22sI9lb+lf24QgCgbWzU2KC/3aXKXgevUjTp82ugGECDHKeu5XYxSBi1XUKiVo
 CM3XodFjqww4xTmilnqM2vGtJqAbpA7DOv3/W1DAckB37Tv3Ez8KiL4bN5w14Atyqx41n66
 28szDInIOSi+iJ3kSC2kw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:OgXzWp1j770=:sIkb5Kht600B0WwbcfrY0U
 GHvKGc92dS43B+rbqTPLiQT1bXup/fFf/I81i3FXkaKkmLqDJydQvZBsARCs1Ni8o9mgN9PTU
 ju4ecpBUFZ9jiczJde3hqriXc5KGyaTr8X1vTzxSL0YJ2ocKgvSMhSJBtwW9+Qwzhv7w/YN11
 q/iIvaaHN/snkaZFHKg1vwuFBBpHBy5RAG9F9Z2eFVJKhxac1PvxAKD8R/Y9RgMBNCR64dlUL
 Y9BZEuEtLp9VJq397pwXppc1ynE55eoDk7Di7nTzi2Urmwz96EJi1Ec4063ZCvciblL8+ZnbM
 vDkQk13fUKy5fmgygkI2yILFbjWeVs+VRaC18wa31E+0vhFUss0GaxEqYS4Xp/Zn9c/Z78kM9
 n9mj8cNvFYNVmqgnpQ4p6Dghe3q4sdZ7tOXkNliOZ3MIo2D6Vg9lJyPE66+pEMIJDDTXp5hUl
 AJHPg6oQEn0ykpgVKhleCRhtoYh94BMBDvtMnxxEaqUzVQjE94uGivQwcQdYBxuu0W1Es/W7a
 /KQ7xxhnN8vf3MfhHEISuIoSKChx8ojwzl2u5Hha8JPmZFnUZ51GLs3u3NGs+lD8YwI0Lcsjt
 m6mZE8rxKcUjMTjyK89qw4vk0rFL67kxllJl7KRexCfaASIOO2n0pyU+jPJTpbew/SGGd3m7l
 I4T/Pjn5J0hrWMjBMjjTxA28zYUtvoASlOJWflShI0xCQjEZ+/KBshxrbKIo3jxzaEdM=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The newly added driver fails to build in some configurations due to a
missing header inclusion:

drivers/media/platform/imx-pxp.c:988:8: error: unknown type name 'irqreturn_t'
 static irqreturn_t pxp_irq_handler(int irq, void *dev_id)
        ^~~~~~~~~~~
drivers/media/platform/imx-pxp.c: In function 'pxp_irq_handler':
drivers/media/platform/imx-pxp.c:1012:9: error: 'IRQ_HANDLED' undeclared (first use in this function); did you mean 'IRQ_MODE'?
  return IRQ_HANDLED;
         ^~~~~~~~~~~
         IRQ_MODE
drivers/media/platform/imx-pxp.c:1012:9: note: each undeclared identifier is reported only once for each function it appears in
drivers/media/platform/imx-pxp.c: In function 'pxp_probe':
drivers/media/platform/imx-pxp.c:1660:8: error: implicit declaration of function 'devm_request_threaded_irq'; did you mean 'devm_request_region'? [-Werror=implicit-function-declaration]
  ret = devm_request_threaded_irq(&pdev->dev, irq, NULL, pxp_irq_handler,
        ^~~~~~~~~~~~~~~~~~~~~~~~~
        devm_request_region
drivers/media/platform/imx-pxp.c:1661:4: error: 'IRQF_ONESHOT' undeclared (first use in this function); did you mean 'SA_ONESHOT'?
    IRQF_ONESHOT, dev_name(&pdev->dev), dev);

Fixes: 51abcf7fdb70 ("media: imx-pxp: add i.MX Pixel Pipeline driver")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/media/platform/imx-pxp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/media/platform/imx-pxp.c b/drivers/media/platform/imx-pxp.c
index 229c23ae4029..b76cd0e8313c 100644
--- a/drivers/media/platform/imx-pxp.c
+++ b/drivers/media/platform/imx-pxp.c
@@ -16,6 +16,7 @@
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/iopoll.h>
+#include <linux/interrupt.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/sched.h>
-- 
2.18.0

