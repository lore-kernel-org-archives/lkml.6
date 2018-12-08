Return-Path: <SRS0=1bfu=OR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67320C64EB1
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 17:59:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2961D2083D
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 17:59:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (4096-bit key) header.d=lemmela.net header.i=@lemmela.net header.b="mXtkYHG+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2961D2083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lemmela.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726246AbeLHR7V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Dec 2018 12:59:21 -0500
Received: from mail1.kuutio.org ([92.222.216.83]:49848 "EHLO mail1.kuutio.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726214AbeLHR7U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Dec 2018 12:59:20 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail1.kuutio.org (Postfix) with ESMTP id B91701FB8E;
        Sat,  8 Dec 2018 18:59:18 +0100 (CET)
Authentication-Results: mail1.kuutio.org (amavisd-new);
        dkim=pass (4096-bit key) reason="pass (just generated, assumed good)"
        header.d=lemmela.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lemmela.net; h=
        references:in-reply-to:x-mailer:message-id:date:date:subject
        :subject:from:from:received:received; s=dkim; t=1544291958; x=
        1546883959; bh=FEz0nsVKSaLBwqA5dsmv8l5C/dvOKL7zrVXtZd7irzw=; b=m
        XtkYHG+05zGkeEl/LhUyn5mc6LoIne5orvK2jiKhcd2qmDbrtYAwjQ6wcTStnWog
        uuY5fLqk34rdG8XgrjlFZ6hDqNC2DFCqgXqg3/Hb/cGk2Lbb+JnIz0wAqSyN5uar
        RPICzyDJTC8FczMYHcCGNR46T3TdTrK2kem6qldqwlJuj5a09uWzHmq3+8XeROxK
        nVzjq0XN3u/EqhHELQcRupMQY6Jm2ZhJax81aNGMQltWboLGANYaTjat58eERofb
        782VOuFA2uh1fn1DAHc0DEvZ/Fqz9ol4iA6bP8GWQypEkW7H52VQP0ZmXV9lVEs+
        R9as1yaK6nC4wnAuZedWU4bol0NhXXHnk9NZKGzKBntGxlOsv+A/B9e0iWBmFGyp
        5AHwOCzZfp/AX0TUbIMg6p7qkGPNQcekYyrm8DnD/7Gx/s5T1KiOetjkO0zHTm4j
        zXj2GKp+iSJ3YZRLWPo86JwAu/7iU0XlXej7jmy8QqvDC9C9uE2O9DFhwbsBGbnC
        +KHoLsv43KmZVyu2CCh7WchawqHu0x7WIxbTF35xPgwx8x48kArkfrFfJRZnpdx/
        NEJObRqpjdDAvpLaA8DoCE5I3w0PCBh3nKpDV8YERrBkoNCw4HdhUt7YUsXjyb6Q
        cGEB+u8iltnP1JT/iSIAlHhR2s5FHWexnxlmH5bcT4=
X-Virus-Scanned: amavisd-new at kuutio.org
Received: from mail1.kuutio.org ([127.0.0.1])
        by localhost (mail1.kuutio.org [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id Q5A0YphZYhBZ; Sat,  8 Dec 2018 18:59:18 +0100 (CET)
Received: from build.kuutio.org (unknown [IPv6:2001:998:13:e4::69])
        by mail1.kuutio.org (Postfix) with ESMTPSA id E52321F96B;
        Sat,  8 Dec 2018 18:59:17 +0100 (CET)
From:   Oskari Lemmela <oskari@lemmela.net>
To:     Chen-Yu Tsai <wens@csie.org>, Lee Jones <lee.jones@linaro.org>
Cc:     Quentin Schulz <quentin.schulz@bootlin.com>,
        linux-kernel@vger.kernel.org, Oskari Lemmela <oskari@lemmela.net>
Subject: [PATCH v8 2/2] mfd: axp20x: Add supported cells for AXP803
Date:   Sat,  8 Dec 2018 19:58:47 +0200
Message-Id: <20181208175847.32068-3-oskari@lemmela.net>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181208175847.32068-1-oskari@lemmela.net>
References: <20181208175847.32068-1-oskari@lemmela.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Parts of the AXP803 are compatible with their counterparts on the AXP813.
These include the GPIO, ADC, AC and battery power supplies.

Signed-off-by: Oskari Lemmela <oskari@lemmela.net>
Reviewed-by: Chen-Yu Tsai <wens@csie.org>
Tested-by: Vasily Khoruzhick <anarsoul@gmail.com>
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/mfd/axp20x.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
index 8037b4e01ed6..f8e0fa97bb31 100644
--- a/drivers/mfd/axp20x.c
+++ b/drivers/mfd/axp20x.c
@@ -726,6 +726,20 @@ static const struct mfd_cell axp803_cells[] = {
 		.name		= "axp221-pek",
 		.num_resources	= ARRAY_SIZE(axp803_pek_resources),
 		.resources	= axp803_pek_resources,
+	}, {
+		.name		= "axp20x-gpio",
+		.of_compatible	= "x-powers,axp813-gpio",
+	}, {
+		.name		= "axp813-adc",
+		.of_compatible	= "x-powers,axp813-adc",
+	}, {
+		.name		= "axp20x-battery-power-supply",
+		.of_compatible	= "x-powers,axp813-battery-power-supply",
+	}, {
+		.name		= "axp20x-ac-power-supply",
+		.of_compatible	= "x-powers,axp813-ac-power-supply",
+		.num_resources	= ARRAY_SIZE(axp20x_ac_power_supply_resources),
+		.resources	= axp20x_ac_power_supply_resources,
 	},
 	{	.name		= "axp20x-regulator" },
 };
-- 
2.17.1

