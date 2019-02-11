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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1E1EC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:04:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91089222A7
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:04:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hXsy3fRt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390857AbfBKPEp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 10:04:45 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:34575 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390833AbfBKPEj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 10:04:39 -0500
Received: by mail-it1-f196.google.com with SMTP id x124so63539itd.1;
        Mon, 11 Feb 2019 07:04:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=pZPEl0/sDC17Z4YQY1IfnEJUL8r1ewMTipBnKIO1ts4=;
        b=hXsy3fRt38+fV0z0Jv21ApMKl44qYVJOYZZ3Wz7/j1ISYScKHa7efs6CNIf1p6hBKU
         wcKCFSVu8I0ZlEeUH4Qwn2cwabOWr4F5zVtiMysq+ZUlXmifY94JxqFqcvJab/oq/FOA
         yWDuDm3w4J6aPWr8+1H2Q7QilV12drbOc+9rHReK+kncJ2D2sj6H5shMN1wRvwzLJPVq
         YY+qJzv1qMHgAENxFLWhS5AlNnal3ZAWh3LjGtZ71cw2p/SPgfkeaBT1zay3gcMCZMLI
         /JCvUk7ED/B90o7EP2QyV0T9wcGsGLz8v76WxzZNcLlHZq5tXCZhx8v9NZwD79gg3rvK
         zPMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=pZPEl0/sDC17Z4YQY1IfnEJUL8r1ewMTipBnKIO1ts4=;
        b=GlO1PtxCvuCvMMrlHyIQJHC8oEH78DbC5p5BjInibgxih/xsoVXGj4+/rgIeGyz0hi
         dGs/HnJRq4vTjFoO715RXgR0dpz8t3GDSrMNFu0RVVve2nTBqzOlGgNTQ2jlawvCfL95
         NxEzvGwiDcxQZZltRXvhBT8zdqJP/uwf4ADnXc0uVijhVs+ptaBqrPMLGADzCs1ncdvt
         fngxYIAy9gO7Kyi1+nZuz30W3MZIiYiJVmCtv9wXKCKFPU2CLArVShHnvS7b/eaLpNSY
         nxOzXzR2pISUEuMQX8kw9F+FF8Ab5xLTOxMKaxBvQ7hDhxNFW0vdazLBeEWk6/0LWs4F
         dAhA==
X-Gm-Message-State: AHQUAub/KcaGqKcspo6jUgFEjSHCnrantEAZWEk50jroUw+FZec5t2P7
        wM+UiCsiXk3rkvr9Z60HZNY=
X-Google-Smtp-Source: AHgI3IYKmQ7UeVo4uDucUR/bUjczukRPDODAV005DWceMDIyPD5wk6bIriq68D/lW28cuM52GgMU4w==
X-Received: by 2002:a24:25c3:: with SMTP id g186mr280677itg.150.1549897478277;
        Mon, 11 Feb 2019 07:04:38 -0800 (PST)
Received: from svens-asus.arcx.com ([184.94.50.30])
        by smtp.gmail.com with ESMTPSA id t129sm5114299ita.4.2019.02.11.07.04.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Feb 2019 07:04:37 -0800 (PST)
From:   Sven Van Asbroeck <thesven73@gmail.com>
X-Google-Original-From: Sven Van Asbroeck <TheSven73@gmail.com>
To:     Felipe Balbi <balbi@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tony Lindgren <tony@atomide.com>, Bin Liu <b-liu@ti.com>
Subject: [PATCH] usb: phy: twl6030-usb: fix possible use-after-free on remove
Date:   Mon, 11 Feb 2019 10:04:26 -0500
Message-Id: <20190211150426.15285-1-TheSven73@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In remove(), use cancel_delayed_work_sync() to cancel the
delayed work. Otherwise there's a chance that this work
will continue to run until after the device has been removed.

This issue was detected with the help of Coccinelle.

Cc: Tony Lindgren <tony@atomide.com>
Cc: Bin Liu <b-liu@ti.com>
Fixes: b6a619a883c3 ("usb: phy: Check initial state for twl6030")
Signed-off-by: Sven Van Asbroeck <TheSven73@gmail.com>
---
 drivers/usb/phy/phy-twl6030-usb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/phy/phy-twl6030-usb.c b/drivers/usb/phy/phy-twl6030-usb.c
index 183550b63faa..dade34d70419 100644
--- a/drivers/usb/phy/phy-twl6030-usb.c
+++ b/drivers/usb/phy/phy-twl6030-usb.c
@@ -400,7 +400,7 @@ static int twl6030_usb_remove(struct platform_device *pdev)
 {
 	struct twl6030_usb *twl = platform_get_drvdata(pdev);
 
-	cancel_delayed_work(&twl->get_status_work);
+	cancel_delayed_work_sync(&twl->get_status_work);
 	twl6030_interrupt_mask(TWL6030_USBOTG_INT_MASK,
 		REG_INT_MSK_LINE_C);
 	twl6030_interrupt_mask(TWL6030_USBOTG_INT_MASK,
-- 
2.17.1

