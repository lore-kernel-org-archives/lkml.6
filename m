Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26CFFC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:27:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E75BC2087C
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:27:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551130057;
	bh=quylh/ki4slfoPTDnEY3s7ts5OJ/ur+dkfpwwup/piM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BL8ylQTfZoqWn5W+/+l//YVSpcy0ej8zq2AhkrTYXLTFonFVml2DOuiUxh/PmP+Sa
	 WzrEM3n6Lns4Bbw/TXpAjb0uDjNLy9QilRj9hj5dFLPQP+lDuj01z1ZbotPXmyPdSf
	 CD4Ut6paQqE1N61UKtz1cAyY8+twdikkjyWRLYBU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730422AbfBYV1f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:27:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:33424 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727605AbfBYV1b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:27:31 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B6688213A2;
        Mon, 25 Feb 2019 21:27:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551130051;
        bh=quylh/ki4slfoPTDnEY3s7ts5OJ/ur+dkfpwwup/piM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lWJqHGODJxHZ6wn7B2LZo3k4flaXZCc+TdiYcfT+3pjHQg5kvCi9wyjVren8NspZh
         nHTgo88IHAYUodJ+LjT6rHmbjImahbcAHf3xGYWlFEt+peqmBqoviq/8dqggugtVCY
         5UAq9JK10vMZ3uCi1vE5PtwC55oq89kQfFQBXEO4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 4.19 152/152] pinctrl: max77620: Use define directive for max77620_pinconf_param values
Date:   Mon, 25 Feb 2019 22:12:24 +0100
Message-Id: <20190225195055.621801915@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190225195043.645958524@linuxfoundation.org>
References: <20190225195043.645958524@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

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


