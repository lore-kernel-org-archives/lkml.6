Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9781CECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 10:52:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50E2620875
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 10:52:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I1JTxPej"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50E2620875
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387968AbeGWLx3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 07:53:29 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37642 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387815AbeGWLx3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 07:53:29 -0400
Received: by mail-wr1-f66.google.com with SMTP id q10-v6so231942wrd.4
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jul 2018 03:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=SljYlLx9vuqJRCmQm4WsAgKQ/v4WCYbeMzWfC03y7Ts=;
        b=I1JTxPejfBj2GJCNmuU5XeX6hRoIvgTErZaH6nTWnFbWTeskdryoBCbOs1XCs+QXbw
         zE/MO7dVvleAR3EJnDQ1kQy2uLucGENXNOp/HK0pCuv/25Uy8iCkKoAGT9Gm7OCu8C8G
         oNLipCpdcNaVuD/iQ10JSXCS8zbo0+YXGswkhkt9X7Cj8eMV5yZNEP7v7eb+21N8Lv01
         zhhL/GaJA4FjsvkqMK/xAjEvqxf0MhymOprAC4DHbzYTvw80rA8b0OP+bz7MgrVXyQgv
         pb77SexONb4sCcyraRURwrD+SVLvoFphE+GFbez+2FOx7vO739FJpy96FHUFCJt2JZjO
         YbSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=SljYlLx9vuqJRCmQm4WsAgKQ/v4WCYbeMzWfC03y7Ts=;
        b=pBd/3Q0DR7SiYfk2RYrTL9eYJ7HWBJYQFyDmFMrxS4pQCUuggtPjLlQA0EexuH3vJB
         W5sUle2W9ECC3I3QjwPnfph4r98rLmiQRPO8MpbZcXrXyJ8lJV6Pz6USCqh0q4qfl+HP
         61BRmzDcC2al3uhhRSHriWEjC1SuU7Jk9/Mi4FXQk7yHgjxJFWROB9y1PUNgEoY4yMuI
         gfOEdkZ0U07l3ihZaKJLmtoysZ31Q08DeF4S4CwcdD9Am+5weD4CNpG14KqVFW1vnvK+
         ZgniQYZx+qKFRUtU1QiEaB6wjMHDCEvmsh9CrL7L/YM2EWutYldb5utJJYIkqXGZ9arn
         uAvg==
X-Gm-Message-State: AOUpUlGNbsy6kpIhPW5TtciK+D1lS3uQaz8OPcMsGwfS02uHLWKc8Keq
        B5cubfb97CAViw25945K0lU=
X-Google-Smtp-Source: AAOMgpdjpVJPGsvRPTG1iiOJkK1szqwRNtZbbhs3R/7nBbaJyo0U0ARwPFI5PTjiFL2VJkEYnOZLTg==
X-Received: by 2002:adf:c4a7:: with SMTP id m36-v6mr8180078wrf.103.1532343171714;
        Mon, 23 Jul 2018 03:52:51 -0700 (PDT)
Received: from minipc.home ([2a00:23c4:9115:8700:622a:51b1:f14a:b2fd])
        by smtp.gmail.com with ESMTPSA id w204-v6sm1846577wmw.5.2018.07.23.03.52.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Jul 2018 03:52:51 -0700 (PDT)
Date:   Mon, 23 Jul 2018 11:54:29 +0100
From:   Laurence Rochfort <laurence.rochfort@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christian Gromm <christian.gromm@microchip.com>,
        linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org
Cc:     laurence.rochfort@gmail.com
Subject: [PATCH] staging: most: Use NULL pointer not plain integer
Message-ID: <20180723105429.GA7428@minipc.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix sparse warning: Using plain integer as NULL pointer

Signed-off-by: Laurence Rochfort <laurence.rochfort@gmail.com>
---
 drivers/staging/most/dim2/dim2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/most/dim2/dim2.c b/drivers/staging/most/dim2/dim2.c
index fe90a7c..31fbc1a 100644
--- a/drivers/staging/most/dim2/dim2.c
+++ b/drivers/staging/most/dim2/dim2.c
@@ -785,7 +785,7 @@ static int dim2_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	dev->disable_platform = pdata ? pdata->disable : 0;
+	dev->disable_platform = pdata ? pdata->disable : NULL;
 
 	dev_info(&pdev->dev, "sync: num of frames per sub-buffer: %u\n", fcnt);
 	hal_ret = dim_startup(dev->io_base, dev->clk_speed, fcnt);
-- 
2.9.5

