Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84DEAC1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 03:55:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D63620693
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 03:55:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BvU4AN0z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D63620693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754433AbeFTDzN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 23:55:13 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:35986 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754331AbeFTDzE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 23:55:04 -0400
Received: by mail-pg0-f67.google.com with SMTP id m5-v6so832708pgd.3;
        Tue, 19 Jun 2018 20:55:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=EsdU5kluQMf1rXJS2hF6uW+T5S0HXqxcpa9E9XmD+/w=;
        b=BvU4AN0zzyVK7+2xSqpYww5DDMLtCXCaUWh9VaIQ/6VeVUMMkAvuhJkxtYTtM6AXuD
         hwWXdC9n6k9GooUOjaiTd5LoUvtVnjLrWuAcThlUCY1k/84crl7r8IIXJbWibtr15pgf
         /FFUvlUaa2tziODQ/p+PadTPjPPz9dlUwHgVZzdd+XsihBeTT26xyugL3tzQKOSIQ0uy
         51z1kunFH366j906Ce2sFz4rRzh7VcikBMdpXI4tyeKTzP5O3+f/0UcUVx3WVVGTOJxq
         Hn8EA1cQ+eqK7jFOW6z86+kyG3yUDh+9XCK/5VlS7IZYqC/VQ81vYGkLbttzUsWQLaMc
         8hMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=EsdU5kluQMf1rXJS2hF6uW+T5S0HXqxcpa9E9XmD+/w=;
        b=pl4XT7QuXUTY8dfndBT8tdyHGUvUhkXFJdJjYM/PQRS0gpIZj77m/Z4Te28D5rcJ+G
         DfFWtRnOH7wRQidhEqnVUzBbd6AuOTxDukXFgzmqNm/2MQbkGRFtzEsx4fhqRaCo9LHH
         TYdENGLofa1gIuek94Gf5k67QjyaDFQWfzrslXhfXfeQBjNYdvy3/FlnPlLlFnrmjvmt
         WdNKNHimcwF6u1c5Hwma079qqJbJuAnxIk5mcYaXfvtwcGP+V2KbqhmUOuhgIna60lDP
         ZE3DTQIBpRL+xv973C5yJroywJfhjtOaFPg2lX8jOl6hO8XISmHHKsEWBLp14DR+WOTx
         Kowg==
X-Gm-Message-State: APt69E2pYpQN8KFA5Lwmtvc7JzRjCvLnX6+pKGs+9Bt2mPbqiLfBCO2a
        jvuQkt1QFEpcg1QLFqLMgdc=
X-Google-Smtp-Source: ADUXVKLTp7Cyojd++ETzvhmp6l2as94tfbUH6agtcxfvbj9cQbQankLdcYRWPR+yDt1Gn8zoEJZ75A==
X-Received: by 2002:a63:6741:: with SMTP id b62-v6mr17379352pgc.5.1529466903990;
        Tue, 19 Jun 2018 20:55:03 -0700 (PDT)
Received: from oslab.tsinghua.edu.cn ([2402:f000:1:4413:d85e:ce7f:5f7a:fdfe])
        by smtp.gmail.com with ESMTPSA id 76-v6sm1682059pfr.172.2018.06.19.20.55.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Jun 2018 20:55:03 -0700 (PDT)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
To:     balbi@kernel.org, gregkh@linuxfoundation.org,
        nicolas.ferre@microchip.com, keescook@chromium.org,
        robert.jarzmik@free.fr, allen.lkml@gmail.com
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH 1/2] usb: gadget: r8a66597: Fix two possible sleep-in-atomic-context bugs in init_controller()
Date:   Wed, 20 Jun 2018 11:54:53 +0800
Message-Id: <20180620035453.7721-1-baijiaju1990@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver may sleep with holding a spinlock.
The function call paths (from bottom to top) in Linux-4.16.7 are:

[FUNC] msleep
drivers/usb/gadget/udc/r8a66597-udc.c, 839: 
		msleep in init_controller
drivers/usb/gadget/udc/r8a66597-udc.c, 96: 
		init_controller in r8a66597_usb_disconnect
drivers/usb/gadget/udc/r8a66597-udc.c, 93: 
		spin_lock in r8a66597_usb_disconnect

[FUNC] msleep
drivers/usb/gadget/udc/r8a66597-udc.c, 835: 
		msleep in init_controller
drivers/usb/gadget/udc/r8a66597-udc.c, 96: 
		init_controller in r8a66597_usb_disconnect
drivers/usb/gadget/udc/r8a66597-udc.c, 93: 
		spin_lock in r8a66597_usb_disconnect

To fix these bugs, msleep() is replaced with mdelay().

This bug is found by my static analysis tool (DSAC-2) and checked by
my code review.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/usb/gadget/udc/r8a66597-udc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/gadget/udc/r8a66597-udc.c b/drivers/usb/gadget/udc/r8a66597-udc.c
index a3ecce62662b..24ee9867964b 100644
--- a/drivers/usb/gadget/udc/r8a66597-udc.c
+++ b/drivers/usb/gadget/udc/r8a66597-udc.c
@@ -832,11 +832,11 @@ static void init_controller(struct r8a66597 *r8a66597)
 
 		r8a66597_bset(r8a66597, XCKE, SYSCFG0);
 
-		msleep(3);
+		mdelay(3);
 
 		r8a66597_bset(r8a66597, PLLC, SYSCFG0);
 
-		msleep(1);
+		mdelay(1);
 
 		r8a66597_bset(r8a66597, SCKE, SYSCFG0);
 
-- 
2.17.0

