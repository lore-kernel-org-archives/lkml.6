Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id F1BE4C004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 12:25:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5AA2208B9
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 12:25:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BBZHpHaY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5AA2208B9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935504AbeFMMZU (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 08:25:20 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:36439 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935274AbeFMMZS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 08:25:18 -0400
Received: by mail-pl0-f66.google.com with SMTP id a7-v6so1461691plp.3;
        Wed, 13 Jun 2018 05:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=pgk3IoLh3nElkMaPFEhIWoZW8qdutvag60YqwdVLfIE=;
        b=BBZHpHaYptM8sZFun+0hrviCyWybfISKeRvNFx4ey/O6QaTwp4/8j0vnrPeFXxta8F
         pwYZ+FEYO7KKu/hJoDleGLspi/7zVI05PAnb3hWbDkc7axFG8U1kPB9U3zqNRqiT38Wt
         rjKAuBgKIO+6u4JL7xkeRjnHaK7tkS6+QwnxXB1jJqEbBkcizou5jaTO2uWhdn5qQSa5
         HIz7Eza1kxVeKFQfOG+ML7PGWZYHpXy9yS85XvcNhXznGd4F+Pme3UQOQEXLOx5uWJQh
         cwTneBtJxcdQwzEMx+wj2F/Te1sr0cpGlgXi7Bv7A70OU2K1pY9MH5ENeQd3xKMcRWgL
         DSnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=pgk3IoLh3nElkMaPFEhIWoZW8qdutvag60YqwdVLfIE=;
        b=F1GhlrEbmwoBNCSMLaROc5SHP3OF3l68c/KQnDdWDlF2OivCMfRjm7mWfLupOxnoh5
         r14dp0vJKO7N00ACQaQGIj66bjAMrLoVIrKruxNEjd9gOlpbJAUH9BW/WIS2cJpcaZv7
         CTroG3BnLRzYVAOysJhSVWkjyEigmmeOV5Enpgomp19/d39hfAIyKcr0IzvDP/eGkFUc
         4U8PFPMTg0mGGN93CFj6CrLPf/hedRXru4eb/dr9CSzeQPKl8sK3ZGAuW8/BjBAk+UTY
         RYmcH1ntpybch7of8NUmIHTV/j1XRWU64H/f/dpI6sQhrvWPG5FCvZl6LtgO2WOQKehP
         rf+g==
X-Gm-Message-State: APt69E0Jg2FaKT/XWi6Z7A/gm47iIOIEt23mGksANcMK3Gam4UU7a11v
        taJvElooy+3UrKNIDafLlqQ=
X-Google-Smtp-Source: ADUXVKIfmYi0WRIjl21y6770UuaKr0N73eyco7Yf+osO+bPcCeTHgU45WISV9dIz5quJC+cbDJvXOA==
X-Received: by 2002:a17:902:bccc:: with SMTP id o12-v6mr4978282pls.169.1528892718326;
        Wed, 13 Jun 2018 05:25:18 -0700 (PDT)
Received: from parths1.sibshivalik.com.com ([219.65.63.222])
        by smtp.gmail.com with ESMTPSA id v36-v6sm7642628pgn.34.2018.06.13.05.25.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 13 Jun 2018 05:25:17 -0700 (PDT)
From:   Parth Y Shah <sparth1292@gmail.com>
To:     balbi@kernel.org, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Parth Y Shah <sparth1292@gmail.com>
Subject: [PATCH] Fixed an indentation error
Date:   Wed, 13 Jun 2018 17:55:10 +0530
Message-Id: <1528892710-14928-1-git-send-email-sparth1292@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Parth Y Shah <sparth1292@gmail.com>
---
 drivers/usb/gadget/configfs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/gadget/configfs.c b/drivers/usb/gadget/configfs.c
index efba66c..0675b4a 100644
--- a/drivers/usb/gadget/configfs.c
+++ b/drivers/usb/gadget/configfs.c
@@ -1217,8 +1217,8 @@ static void purge_configs_funcs(struct gadget_info *gi)
 			list_move_tail(&f->list, &cfg->func_list);
 			if (f->unbind) {
 				dev_dbg(&gi->cdev.gadget->dev,
-				         "unbind function '%s'/%p\n",
-				         f->name, f);
+						"unbind function '%s'/%p\n",
+						f->name, f);
 				f->unbind(c, f);
 			}
 		}
-- 
2.7.4

