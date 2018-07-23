Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63688ECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 17:53:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2120320856
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 17:53:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="T3GeC1Kt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2120320856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388355AbeGWSz7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 14:55:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:39166 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388181AbeGWSz6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 14:55:58 -0400
Received: from localhost.localdomain (xdsl-188-155-58-14.adslplus.ch [188.155.58.14])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 13D7820880;
        Mon, 23 Jul 2018 17:53:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532368417;
        bh=kX0mV+jHv86U8yvvpRO55TWW88fI73gaSoTVKDgP8cg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=T3GeC1Kt5v2G6kMhveRSzGtc7FX5yX1GOtMh0Jd8IRvzxqgyiR4l5wO9BL4P9UIfS
         usBrN1Bgb0smqIAJ+beOHdpXkEycrVHoUEglE7VH4w6MuVxHmAgyPP2BBV7RO5euq+
         89tcZeafJ2KzfCunZazgL+xg8BuAvHKeha6LJfac=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Tomasz Figa <tomasz.figa@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kukjin Kim <kgene@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>,
        Sylwester Nawrocki <snawrocki@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Pankaj Dubey <pankaj.dubey@samsung.com>
Subject: [RFT v2 02/10] pinctrl: samsung: Document suspend and resume members
Date:   Mon, 23 Jul 2018 19:52:54 +0200
Message-Id: <20180723175302.22535-3-krzk@kernel.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180723175302.22535-1-krzk@kernel.org>
References: <20180723175302.22535-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing documentation for suspend and resume members of struct
samsung_pin_ctrl and samsung_pinctrl_drv_data.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Tomasz Figa <tomasz.figa@gmail.com>
Cc: Sylwester Nawrocki <snawrocki@kernel.org>
Acked-by: Tomasz Figa <tomasz.figa@gmail.com>
---
 drivers/pinctrl/samsung/pinctrl-samsung.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/pinctrl/samsung/pinctrl-samsung.h b/drivers/pinctrl/samsung/pinctrl-samsung.h
index f0cda9424dfe..aac16cc8362a 100644
--- a/drivers/pinctrl/samsung/pinctrl-samsung.h
+++ b/drivers/pinctrl/samsung/pinctrl-samsung.h
@@ -223,6 +223,10 @@ struct samsung_retention_data {
  *	interrupts for the controller.
  * @eint_wkup_init: platform specific callback to setup the external wakeup
  *	interrupts for the controller.
+ * @suspend: platform specific suspend callback, executed during pin controller
+ *	device suspend, see samsung_pinctrl_suspend()
+ * @resume: platform specific resume callback, executed during pin controller
+ *	device suspend, see samsung_pinctrl_resume()
  */
 struct samsung_pin_ctrl {
 	const struct samsung_pin_bank_data *pin_banks;
@@ -255,6 +259,10 @@ struct samsung_pin_ctrl {
  * @pin_base: starting system wide pin number.
  * @nr_pins: number of pins supported by the controller.
  * @retention_ctrl: retention control runtime data.
+ * @suspend: platform specific suspend callback, executed during pin controller
+ *	device suspend, see samsung_pinctrl_suspend()
+ * @resume: platform specific resume callback, executed during pin controller
+ *	device suspend, see samsung_pinctrl_resume()
  */
 struct samsung_pinctrl_drv_data {
 	struct list_head		node;
-- 
2.14.1

