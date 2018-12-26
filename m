Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BB93C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 02:56:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32F612171F
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 02:56:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="pF3+Uk/M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727027AbeLZC4J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Dec 2018 21:56:09 -0500
Received: from mta-p6.oit.umn.edu ([134.84.196.206]:43072 "EHLO
        mta-p6.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726948AbeLZC4I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Dec 2018 21:56:08 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p6.oit.umn.edu (Postfix) with ESMTP id 3F32BBC9
        for <linux-kernel@vger.kernel.org>; Wed, 26 Dec 2018 02:56:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p6.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p6.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id CQq1faal7zm6 for <linux-kernel@vger.kernel.org>;
        Tue, 25 Dec 2018 20:56:07 -0600 (CST)
Received: from mail-it1-f198.google.com (mail-it1-f198.google.com [209.85.166.198])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p6.oit.umn.edu (Postfix) with ESMTPS id 110D8BDC
        for <linux-kernel@vger.kernel.org>; Tue, 25 Dec 2018 20:56:07 -0600 (CST)
Received: by mail-it1-f198.google.com with SMTP id i12so17565343ita.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Dec 2018 18:56:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=IpHCPony0Yw91k/Xth9ZNoao1j2soIv/Kezjj2ATXyQ=;
        b=pF3+Uk/M71PHl2gDU3siqxEdeHXX+0D9yne5Z9UH6+Nmt+0JrDQ6lTITqKKevS4ivN
         2HP+0siRbmJP6Tl6PiGcMpVr63mHIGvxeR6pN/uRGrfNuHLREgWMyjy1cwwwW4s5UTyX
         NNn6JmTZk+AXQT88J01WobBGgH2gz7KVdXfDn4IEyK3nux521vskcRoGYh53GKZ4WqFW
         wl4MvH679wIR6fsVHjEyCB1YRz0BjwF0l6vWPihxrCcUDWf9oj9a/4JpchpXN0FY3A2d
         1Cy4aViE6vvwE4rdZcRI+O0ZvfFmI411pkuFMDtA7VmnCEFQEsPjmoTTwfg1oXndBNtB
         cB5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=IpHCPony0Yw91k/Xth9ZNoao1j2soIv/Kezjj2ATXyQ=;
        b=H7P6uRfx7uOjVMoryKmtJ6yZFBAwjK1jrfIGL+L4m20le6wvannpNFY3EjoGORXz6h
         DiGOO6tvS/dcEv4yUp0WWUQ+aCWUputpW8fu6GF/gaP8OPQ3RE9NKDNG4Z5rodfAyCf7
         HjZtVoNWoQ2WzT1dOVAbQ1mbjtrXjnqNlb3h1rgVGgQ31B5HPeqsSXa9z2XSw5QJiyAh
         01UC1DAZYMZqjp4LXuiWSe6fOUPoNUcTauZoKj5KMuKp8VQc/+1vsNBcck+IpFhmBZ6M
         Y1Hg9WvjYBlXlyj9bm21dxKlBSB45lsjHMa9gpM+uAQg52w5TnPYbG74NHCN46zLA4hO
         U+gA==
X-Gm-Message-State: AJcUukd4CFq4aaXDNXxAXTn7K3Nth4+3OkqxYxqSugUr2O3DpDruZ6Bv
        52FoB1O3YtnhgjMou8h+Ffa8PLi0UTO2JsKTc+sCetgmHv9Yf5B8sy3oox16gndM0qyYqsMnUN7
        SLhmv9otlHqnJ4JQjTxvwSeyjGJCm
X-Received: by 2002:a6b:7602:: with SMTP id g2mr11703699iom.135.1545792966683;
        Tue, 25 Dec 2018 18:56:06 -0800 (PST)
X-Google-Smtp-Source: ALg8bN6UJP1xtIqVNabcTTcF4DvsB6ls+x/X5R6I9B1qxZu+OakChf7NUCPq6cPYuxkAs8/FKY4b9A==
X-Received: by 2002:a6b:7602:: with SMTP id g2mr11703695iom.135.1545792966465;
        Tue, 25 Dec 2018 18:56:06 -0800 (PST)
Received: from localhost.localdomain (host-173-230-104-22.mnmigsc.mn.minneapolis.us.clients.pavlovmedia.net. [173.230.104.22])
        by smtp.gmail.com with ESMTPSA id x79sm11504816ita.34.2018.12.25.18.56.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 25 Dec 2018 18:56:05 -0800 (PST)
From:   Kangjie Lu <kjlu@umn.edu>
To:     kjlu@umn.edu
Cc:     pakki001@umn.edu, "David S. Miller" <davem@davemloft.net>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        =?UTF-8?q?Hern=C3=A1n=20Gonzalez?= <hernan@vanguardiasur.com.ar>,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] net: (cpts) fix a missing check of clk_prepare
Date:   Tue, 25 Dec 2018 20:55:37 -0600
Message-Id: <20181226025539.72561-1-kjlu@umn.edu>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

clk_prepare() could fail, so let's check its status, and if it fails,
return its error code upstream.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
 drivers/net/ethernet/ti/cpts.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/ti/cpts.c b/drivers/net/ethernet/ti/cpts.c
index b96b93c686bf..4f644ac314fe 100644
--- a/drivers/net/ethernet/ti/cpts.c
+++ b/drivers/net/ethernet/ti/cpts.c
@@ -572,7 +572,9 @@ struct cpts *cpts_create(struct device *dev, void __iomem *regs,
 		return ERR_CAST(cpts->refclk);
 	}
 
-	clk_prepare(cpts->refclk);
+	ret = clk_prepare(cpts->refclk);
+	if (ret)
+		return ERR_PTR(ret);
 
 	cpts->cc.read = cpts_systim_read;
 	cpts->cc.mask = CLOCKSOURCE_MASK(32);
-- 
2.17.2 (Apple Git-113)

