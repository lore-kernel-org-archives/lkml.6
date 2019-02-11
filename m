Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B952DC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 09:21:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8906B20863
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 09:21:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oQMjz2Ti"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727150AbfBKJVv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 04:21:51 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:33681 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727067AbfBKJVu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 04:21:50 -0500
Received: by mail-wm1-f65.google.com with SMTP id h22so13925159wmb.0;
        Mon, 11 Feb 2019 01:21:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KC/AZsTOApyaTqdtOdp5tkyz0s01W2GX9aJLAHDbvJE=;
        b=oQMjz2Ti6vIJSwIPb1JjTvnEkDvE4WmacA/olAy5EXdv1BJcFqSUV3fYWQ8Nm0gv+q
         2G7CvPwo1POSa/E/7vStj6zIC1YTnBhYvkJYh3CYbwoySIM/WvmLUfy9Wl031rQ+TBfJ
         GBZNAufAnUy0Sw9CJNjHfkbZeneUqwFBYP1IdTkGHYeJftcgGe6dzsJE02hHa27u/ZYE
         /EST1NN6r63Dmw72dWuC9GX5W2e3+F5eylGhlwx7wJ9TSu3OrD19ZHg3PQMeysV8w41J
         MLT4bDNGjEOkWMl2qzYfOgaHOh0rxd03lvBXjLyiV2BYDbsABkNHZ35BajRjC4ciQNeT
         8nUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=KC/AZsTOApyaTqdtOdp5tkyz0s01W2GX9aJLAHDbvJE=;
        b=HfMNTmRB5dB3UESNAi9q9EgkBrbfkM6mDkJvER/Vhbg6vrjedTt+/qcGM5m1He5vAk
         Rg0Z5HCYSROg9403B9p6LQVUXB8ZGnevfMOnOrHudgV2EaeVIVIJ/IfNgfabIDsmPLBD
         3MSw1gpZV4RCd00deSmYBI7k7c8ctcah2lUJgN1Uvp4AXSFjdCfICraCaq+iTCv1YWSd
         RG+8R7F1wSrmZ3IxuPFw4dt+c0SdsVMCDXRpg6s7HrnaUtxg2TDfkGZWrdJbqzMz7k2N
         J3Q7IkQXaDupJestZoavSSRo1bu337RVBb6RktNOwa0mUNnSESh6qL3Se87Kn5l6a/WW
         1FsQ==
X-Gm-Message-State: AHQUAuZipGn+syQ8UDhpZeSvsFEsDEF00rEQ70XhsUrAojJ1s+7YykD7
        DM9Gk6ppOWfhgD6y7oVcbnZBbEOL2vw=
X-Google-Smtp-Source: AHgI3Iav4KUl6LXM67xdIp/EY3zzphMUhHg7AMKdPC5yWa7zgAoIgZMlhZkrFCBd4/uhYjyzZHPGcA==
X-Received: by 2002:a1c:f613:: with SMTP id w19mr8322318wmc.0.1549876908205;
        Mon, 11 Feb 2019 01:21:48 -0800 (PST)
Received: from ThinkPad.gtu.edu.tr ([193.140.134.118])
        by smtp.gmail.com with ESMTPSA id o7sm11388979wmc.44.2019.02.11.01.21.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 11 Feb 2019 01:21:47 -0800 (PST)
From:   Mesih Kilinc <mesihkilinc@gmail.com>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-sunxi@googlegroups.com
Cc:     Mesih Kilinc <mesihkilinc@gmail.com>,
        Maxime Ripard <maxime.ripard@free-electrons.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Icenowy Zheng <icenowy@aosc.io>,
        Rob Herring <robh+dt@kernel.org>
Subject: [PATCH 2/7] clocksource: sun4i: add a compatible for suniv
Date:   Mon, 11 Feb 2019 12:21:08 +0300
Message-Id: <3de720ad1d2b47bf987fa56076d570de8043ed35.1549875778.git.mesihkilinc@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1549875778.git.mesihkilinc@gmail.com>
References: <cover.1549875778.git.mesihkilinc@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The suniv (new F-series) chip has a timer with less functionality than
the A10 timer, e.g. it has only 3 channels.

Add a new compatible for it. As we didn't use the extra channels on A10
either now, the code needn't to be changed.

The suniv chip is based on ARM926EJ-S CPU, thus it has no architecture timer.

Register sun4i_timer as sched_clock on it.

Signed-off-by: Mesih Kilinc <mesihkilinc@gmail.com>
Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>
Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/timer-sun4i.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/clocksource/timer-sun4i.c b/drivers/clocksource/timer-sun4i.c
index 6e0180a..65f38f6 100644
--- a/drivers/clocksource/timer-sun4i.c
+++ b/drivers/clocksource/timer-sun4i.c
@@ -186,7 +186,8 @@ static int __init sun4i_timer_init(struct device_node *node)
 	 */
 	if (of_machine_is_compatible("allwinner,sun4i-a10") ||
 	    of_machine_is_compatible("allwinner,sun5i-a13") ||
-	    of_machine_is_compatible("allwinner,sun5i-a10s"))
+	    of_machine_is_compatible("allwinner,sun5i-a10s") ||
+	    of_machine_is_compatible("allwinner,suniv-f1c100s"))
 		sched_clock_register(sun4i_timer_sched_read, 32,
 				     timer_of_rate(&to));
 
@@ -218,3 +219,5 @@ static int __init sun4i_timer_init(struct device_node *node)
 }
 TIMER_OF_DECLARE(sun4i, "allwinner,sun4i-a10-timer",
 		       sun4i_timer_init);
+TIMER_OF_DECLARE(suniv, "allwinner,suniv-f1c100s-timer",
+		       sun4i_timer_init);
-- 
2.7.4

