Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC694C07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 10:10:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 752BC20989
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 10:10:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544177445;
	bh=73hi6wVsYUlvLgXmMFt5b9vg8t7cv1wo4HtI8LKkHVo=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=Jn3M3gFM2tOqPA8yvCYcfnrzSEGI/0cTdWLqLoEg9W7NlQXJ421hQmhrI6OamH4dY
	 PATufMTgxmezi/ajUm+KAfo733lABuVgGBanoOzl4iqI9Jq17xYNri0+1Wg0fNOsdV
	 Yc8U7BufDfTrB8mlAbI5xnuSmWHPeP0FLO3kKW18=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 752BC20989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726051AbeLGKKo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 05:10:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:56066 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725976AbeLGKKn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 05:10:43 -0500
Received: from PC-kkoz.proceq.com (unknown [213.160.61.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 442BC2083D;
        Fri,  7 Dec 2018 10:10:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544177443;
        bh=73hi6wVsYUlvLgXmMFt5b9vg8t7cv1wo4HtI8LKkHVo=;
        h=From:To:Cc:Subject:Date:From;
        b=BP4WWdnlWti1xchPTllvkY8jHVJiddQNYbBuMfrxyU40sBSeHu9r/QAQeLAi9/nRz
         MfaICo130JSKvtwliJc4Uo1Nb25cJmU4MwYkxmAoLV2JD+ITIPxeuRpRYvMGgS6noc
         ZhGmGWSze+M+y1lIE2psBErr+MBZUwdksZRWyJ8Q=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH] leds: gpio: Drop unneeded manual of_node assignment
Date:   Fri,  7 Dec 2018 11:10:06 +0100
Message-Id: <1544177406-24752-1-git-send-email-krzk@kernel.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts the main change of commit bff23714bc36 ("leds: leds-gpio:
Set of_node for created LED devices") because of_node assignment is
handled by core since commit 7ea79ae86c28 ("leds: gpio: use OF variant
of LED registering function").  Basically the code was overwriting the
of_node with same value.

No functional change expected.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/leds/leds-gpio.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/leds/leds-gpio.c b/drivers/leds/leds-gpio.c
index 45e012093865..998f2ff6914d 100644
--- a/drivers/leds/leds-gpio.c
+++ b/drivers/leds/leds-gpio.c
@@ -190,7 +190,6 @@ static struct gpio_leds_priv *gpio_leds_create(struct platform_device *pdev)
 			fwnode_handle_put(child);
 			return ERR_PTR(ret);
 		}
-		led_dat->cdev.dev->of_node = np;
 		priv->num_leds++;
 	}
 
-- 
2.7.4

