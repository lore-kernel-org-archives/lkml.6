Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95F66C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 23:06:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 661A2222A1
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 23:06:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395200AbfBMXGd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 18:06:33 -0500
Received: from shell.v3.sk ([90.176.6.54]:58234 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389971AbfBMXGb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 18:06:31 -0500
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id D3C36100E98;
        Thu, 14 Feb 2019 00:06:28 +0100 (CET)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id S3SJCkpOvypg; Thu, 14 Feb 2019 00:06:26 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 42FF8100E9A;
        Thu, 14 Feb 2019 00:06:26 +0100 (CET)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id VRYAobHfSJnL; Thu, 14 Feb 2019 00:06:25 +0100 (CET)
Received: from nedofet.lan (ip-89-102-31-34.net.upcbroadband.cz [89.102.31.34])
        by zimbra.v3.sk (Postfix) with ESMTPSA id 70B95100E98;
        Thu, 14 Feb 2019 00:06:25 +0100 (CET)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Robert Jarzmik <robert.jarzmik@free.fr>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lubomir Rintel <lkundrak@v3.sk>, Pavel Machek <pavel@ucw.cz>
Subject: [PATCH] gpio: pxa: avoid attempting to set pin direction via pinctrl on MMP2
Date:   Thu, 14 Feb 2019 00:06:18 +0100
Message-Id: <20190213230618.1907-1-lkundrak@v3.sk>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Similarly to PXA3xx, pinctrl-single can't set pin direction on MMP2 eithe=
r.
See also: commit 9dabfdd84bdfa ("gpio: pxa: disable pinctrl calls for
PXA3xx")

Fixes: a770d946371e ("gpio: pxa: add pin control gpio direction and reque=
st")
Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
Acked-by: Pavel Machek <pavel@ucw.cz>
---
 drivers/gpio/gpio-pxa.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpio/gpio-pxa.c b/drivers/gpio/gpio-pxa.c
index e9600b556f39..bcc6be4a5cb2 100644
--- a/drivers/gpio/gpio-pxa.c
+++ b/drivers/gpio/gpio-pxa.c
@@ -245,6 +245,7 @@ static bool pxa_gpio_has_pinctrl(void)
 {
 	switch (gpio_type) {
 	case PXA3XX_GPIO:
+	case MMP2_GPIO:
 		return false;
=20
 	default:
--=20
2.20.1

