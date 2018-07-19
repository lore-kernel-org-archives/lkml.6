Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ED3EC468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 16:01:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AD2520858
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 16:01:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="L5o0gddc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AD2520858
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732023AbeGSQpU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 12:45:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:59544 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731524AbeGSQpT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 12:45:19 -0400
Received: from localhost.localdomain (xdsl-188-155-58-14.adslplus.ch [188.155.58.14])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 283DC20857;
        Thu, 19 Jul 2018 16:01:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532016089;
        bh=5bBHxPpz8nwJf099V1DL1EbLbQRgzCDoEhcXGdI5NtM=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=L5o0gddceZD5HsrGvPn3tNc1LQRfaWbWM9KKDYaO62hUzTiC0sfCkesNw48LyNq10
         HyrYNmmK0p9hQ5po+fYnlX5gAc+DweydT14ArOBkuxbIGFwFMqs6N/5iGkELvl0H1Z
         0SKd5uRu6dvPuNin7bWgxn07GDHeIOSRsgrXwQ2U=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Tomasz Figa <tomasz.figa@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kukjin Kim <kgene@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Pankaj Dubey <pankaj.dubey@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFT 02/10] pinctrl: samsung: Document suspend and resume members
Date:   Thu, 19 Jul 2018 18:00:42 +0200
Message-Id: <20180719160050.22566-3-krzk@kernel.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180719160050.22566-1-krzk@kernel.org>
References: <20180719160050.22566-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing documentation for suspend and resume members of struct
samsung_pin_ctrl and samsung_pinctrl_drv_data.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
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

