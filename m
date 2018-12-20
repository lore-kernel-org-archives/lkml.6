Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FROM,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1794BC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 17:20:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB4C3217D9
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 17:20:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vO5RMFmV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387970AbeLTRUm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 12:20:42 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:41725 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387945AbeLTRUg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 12:20:36 -0500
Received: by mail-ed1-f67.google.com with SMTP id g19so2394309edy.8
        for <linux-kernel@vger.kernel.org>; Thu, 20 Dec 2018 09:20:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Kb1ONw/VBWCjH6WMyY0wKwigCD+4iKfVXK3FwoyHWPM=;
        b=vO5RMFmVBxsl/ubbx+QR4JA1VWJ+aL55Hk/aOOotP1LlE2ryUA0ZYLr1CIXgBUltx3
         vb4pFC35xC/kFVcUQAEsyG2pBa93rF0HXZF4B1fcmeVYsxKRjU/v56qPbwDusa3zaYIe
         EZkkhHaIpwZCBiuGeZlF+orgFJLnffMfNh3jsivP3VmK1NSykdCrvn4Wir7WtWXmYvF7
         A2i+d7iVr9yGW1rReljfN0/Pxmh1JbMIUAhp6HwkzNsUGEPxcE6+LIOSVnCuhBwHh56A
         6cVhsvvSFPEy9U60lB5+TSFNM2HcsoNiV1vzA+RtOmQBmCqiYjMim6by2Vu5Z/cKfJ+T
         3v+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Kb1ONw/VBWCjH6WMyY0wKwigCD+4iKfVXK3FwoyHWPM=;
        b=keYbS/L/r4bbRWs0/3vjQDCy8keujniS6HtofxDQQaVqcdBLmxavZpicnPBF9KFukq
         FFGlkm/ZcvkFuKVOdpqwNmOu3qwEQ/Z54FCWv83Qa3kT9MLk0K4964T6Z/Iq/MlqAClw
         RQcilbbn1006ECScl/91jWeHl8mIGXvEKf9dck2McJCaxJ2/GWpCy/JxKtFfg6IfV565
         AaWYbTgq06LYLjBHxBTO0GWPeTZb3sekXJf1grMaWz2GYb3HoNauGgkLZzgaW1ns4ZU0
         tmLTZAU4pvD42mhljSoVhliyfxihwl1ySMjqJyCSk6JjzCOCdzUEYxjx0L+/DK39dIHz
         827g==
X-Gm-Message-State: AA+aEWav5zV0z/h0AC6eZa2OV8jYX6+ozroQXG6bSn/GDb0Je/QZlKst
        8iXkvawrN0TLIfQ8PCrLUxo=
X-Google-Smtp-Source: AFSGD/U5+sGLdz5x8V3Aa7C8Ux7SaLXzgfCvrqxdGjEdc1Efi8vH328uW2hJ8ddreWxGjUQ/DB+CaQ==
X-Received: by 2002:a50:98a6:: with SMTP id j35mr24146219edb.141.1545326434477;
        Thu, 20 Dec 2018 09:20:34 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
        by smtp.gmail.com with ESMTPSA id y53sm6253086edd.84.2018.12.20.09.20.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Dec 2018 09:20:33 -0800 (PST)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Jassi Brar <jassisinghbrar@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Nishanth Menon <nm@ti.com>
Subject: [PATCH v3 19/19] mailbox: ti-msgmgr: Use device-managed registration API
Date:   Thu, 20 Dec 2018 18:20:02 +0100
Message-Id: <20181220172002.9016-20-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181220172002.9016-1-thierry.reding@gmail.com>
References: <20181220172002.9016-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

Get rid of some boilerplate driver removal code by using the newly added
device-managed registration API.

Cc: Nishanth Menon <nm@ti.com>
Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/mailbox/ti-msgmgr.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/mailbox/ti-msgmgr.c b/drivers/mailbox/ti-msgmgr.c
index 6f6addd51d14..88047d835211 100644
--- a/drivers/mailbox/ti-msgmgr.c
+++ b/drivers/mailbox/ti-msgmgr.c
@@ -817,26 +817,15 @@ static int ti_msgmgr_probe(struct platform_device *pdev)
 	mbox->of_xlate = ti_msgmgr_of_xlate;
 
 	platform_set_drvdata(pdev, inst);
-	ret = mbox_controller_register(mbox);
+	ret = devm_mbox_controller_register(dev, mbox);
 	if (ret)
 		dev_err(dev, "Failed to register mbox_controller(%d)\n", ret);
 
 	return ret;
 }
 
-static int ti_msgmgr_remove(struct platform_device *pdev)
-{
-	struct ti_msgmgr_inst *inst;
-
-	inst = platform_get_drvdata(pdev);
-	mbox_controller_unregister(&inst->mbox);
-
-	return 0;
-}
-
 static struct platform_driver ti_msgmgr_driver = {
 	.probe = ti_msgmgr_probe,
-	.remove = ti_msgmgr_remove,
 	.driver = {
 		   .name = "ti-msgmgr",
 		   .of_match_table = of_match_ptr(ti_msgmgr_of_match),
-- 
2.19.1

