Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91CFEC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:37:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5875C20578
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:37:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551130663;
	bh=vdM/AAOHl6S6Pupmwn2Ywx7hlHPTwzKOJxXnbchJEqA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NacSaYvfg6l/kHgfN884Bp0m4vWNdoUivGuYFAcdrID6ZUosbSuAgNVIBfetmjVeU
	 j4nircVU3bXH18NWhNtslCBvrbaDpz+dVUK2PMCfKrW5Luty8kbhwc+jGSj9db5p6f
	 2eyiR4pc4gqkqpW5vp8K3auircbfRmGCpFvapnmg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387506AbfBYVhl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:37:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:44710 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387494AbfBYVhg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:37:36 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AB9D520578;
        Mon, 25 Feb 2019 21:37:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551130656;
        bh=vdM/AAOHl6S6Pupmwn2Ywx7hlHPTwzKOJxXnbchJEqA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aOibdSkGrfc4vkzWV2rL0qJ7obg8TsRn9tZIugPNuk/nJIxWdkS6UbZc7o6j8hILB
         mZDPQNuoK4E4n+3NTze7+Cb+Kn6c/MAHOXFHlpwdkOGaN/a1tVG9QDh+MOAVXOns+v
         str+UBnwmGVgfvfuRBz5wnwhN+bYM4K1NEvt4CnU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 4.20 183/183] pinctrl: max77620: Use define directive for max77620_pinconf_param values
Date:   Mon, 25 Feb 2019 22:12:36 +0100
Message-Id: <20190225195126.041721541@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190225195054.748060397@linuxfoundation.org>
References: <20190225195054.748060397@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nathan Chancellor <natechancellor@gmail.com>

commit 1f60652dd586d1b3eee7c4602892a97a62fa937a upstream.

Clang warns when one enumerated type is implicitly converted to another:

drivers/pinctrl/pinctrl-max77620.c:56:12: warning: implicit conversion
from enumeration type 'enum max77620_pinconf_param' to different
enumeration type 'enum pin_config_param' [-Wenum-conversion]
                .param = MAX77620_ACTIVE_FPS_SOURCE,
                         ^~~~~~~~~~~~~~~~~~~~~~~~~~

It is expected that pinctrl drivers can extend pin_config_param because
of the gap between PIN_CONFIG_END and PIN_CONFIG_MAX so this conversion
isn't an issue. Most drivers that take advantage of this define the
PIN_CONFIG variables as constants, rather than enumerated values. Do the
same thing here so that Clang no longer warns.

Link: https://github.com/ClangBuiltLinux/linux/issues/139
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/pinctrl/pinctrl-max77620.c |   14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

--- a/drivers/pinctrl/pinctrl-max77620.c
+++ b/drivers/pinctrl/pinctrl-max77620.c
@@ -34,14 +34,12 @@ enum max77620_pin_ppdrv {
 	MAX77620_PIN_PP_DRV,
 };
 
-enum max77620_pinconf_param {
-	MAX77620_ACTIVE_FPS_SOURCE = PIN_CONFIG_END + 1,
-	MAX77620_ACTIVE_FPS_POWER_ON_SLOTS,
-	MAX77620_ACTIVE_FPS_POWER_DOWN_SLOTS,
-	MAX77620_SUSPEND_FPS_SOURCE,
-	MAX77620_SUSPEND_FPS_POWER_ON_SLOTS,
-	MAX77620_SUSPEND_FPS_POWER_DOWN_SLOTS,
-};
+#define MAX77620_ACTIVE_FPS_SOURCE		(PIN_CONFIG_END + 1)
+#define MAX77620_ACTIVE_FPS_POWER_ON_SLOTS	(PIN_CONFIG_END + 2)
+#define MAX77620_ACTIVE_FPS_POWER_DOWN_SLOTS	(PIN_CONFIG_END + 3)
+#define MAX77620_SUSPEND_FPS_SOURCE		(PIN_CONFIG_END + 4)
+#define MAX77620_SUSPEND_FPS_POWER_ON_SLOTS	(PIN_CONFIG_END + 5)
+#define MAX77620_SUSPEND_FPS_POWER_DOWN_SLOTS	(PIN_CONFIG_END + 6)
 
 struct max77620_pin_function {
 	const char *name;


