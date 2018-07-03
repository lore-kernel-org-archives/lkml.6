Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D24BFC6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 10:06:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88A012251D
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 10:06:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jp2jAJof"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88A012251D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934066AbeGCKGR (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 06:06:17 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:42204 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933954AbeGCKGP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 06:06:15 -0400
Received: by mail-lf0-f66.google.com with SMTP id u202-v6so1123012lff.9
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jul 2018 03:06:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=OvCSyySxoFfyiK/q1Fu0elxgY/6MVAHJXY2l8T5y4KM=;
        b=Jp2jAJof5OUpWgV2zi/F93RLBibYlCnSRNH0u2j5BX1r4WoPD0vc1cSM+U0ZODvGmU
         WFxqsgGuhTngMeD39ZQjKRYk/sXFUR8Ekjum/r4F4TdQn35fcqE6Nws6RZ50gi+ArWfo
         pDXRm28DGKxojFgmia2aWc0dmUEamzpJci/IVpZ1USMvhueNZ8tLZN9rdzH5K6NM2fNH
         ktwRDKhNPIquYR6mfGzllDhxOogWlvMjVBYOmldmfKC0YtNosCphjBKgB27OTARWmIPz
         FozU76/CZFBriB9TYmha1pa3LUPw7rL1gjkdLXfHAQWd+E2pxTbX5fxLSCD42qO2QaAU
         mLng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=OvCSyySxoFfyiK/q1Fu0elxgY/6MVAHJXY2l8T5y4KM=;
        b=Lu1qeWiE/XiOUNjJIvQwLHZ9sj9Sa9FcS+d88SZP5/x8M0O4BbgA/OWxhU2E7MP479
         Yfk3bf707JVEjpA5td1gTiGeOSbTYD/en9XcQgoX8SUj9CBuRQhRtS+5iPfkqpiIeD+a
         FaWgBaoFEvKjkTgoHvFempO0cGgpAjKZVv6LgJgbEJTzyWmIAmj9AWKCn8gt0/Od0vEZ
         Vio7pzS0PjPCu8qUnbrmnfknhobQbp7E4OehM3cPjkZwsNfYItbF2zwejM+/8MiNb8ik
         64Vys55A4g74U4Iqyfb7KqE1eMxvrw7Smgg7PkTY6Y8IYBSEYVFtJEZQHsapwBaTkZY/
         /CYQ==
X-Gm-Message-State: APt69E3dF1a0loOviV/Cbs9u8d3W8YEy0pFd5IqEkx5RE4hJIixKFItU
        f/Ewd7kzW9F2L8KEnPWMG+k=
X-Google-Smtp-Source: AAOMgpfBej9BVjschzqCVqGqAmJbzPskMMG/8UaAMHofKuA623AqB866LqZEo7nC4B73rEAb1qVxKw==
X-Received: by 2002:a19:9b50:: with SMTP id d77-v6mr9723807lfe.108.1530612374012;
        Tue, 03 Jul 2018 03:06:14 -0700 (PDT)
Received: from xi.terra (c-8bb2e655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.178.139])
        by smtp.gmail.com with ESMTPSA id z17-v6sm179314lfb.5.2018.07.03.03.06.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Jul 2018 03:06:12 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@xi.terra>)
        id 1faICD-0007s9-J8; Tue, 03 Jul 2018 12:06:05 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>,
        linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>
Subject: [PATCH 2/2] misc: sram: enable clock before registering regions
Date:   Tue,  3 Jul 2018 12:05:48 +0200
Message-Id: <20180703100548.30214-2-johan@kernel.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180703100548.30214-1-johan@kernel.org>
References: <20180703100548.30214-1-johan@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make sure to enable the clock before registering regions and exporting
partitions to user space at which point we must be prepared for I/O.

Fixes: ee895ccdf776 ("misc: sram: fix enabled clock leak on error path")
Cc: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/misc/sram.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/misc/sram.c b/drivers/misc/sram.c
index 679647713e36..74b183baf044 100644
--- a/drivers/misc/sram.c
+++ b/drivers/misc/sram.c
@@ -391,23 +391,23 @@ static int sram_probe(struct platform_device *pdev)
 	if (IS_ERR(sram->pool))
 		return PTR_ERR(sram->pool);
 
-	ret = sram_reserve_regions(sram, res);
-	if (ret)
-		return ret;
-
 	sram->clk = devm_clk_get(sram->dev, NULL);
 	if (IS_ERR(sram->clk))
 		sram->clk = NULL;
 	else
 		clk_prepare_enable(sram->clk);
 
+	ret = sram_reserve_regions(sram, res);
+	if (ret)
+		goto err_disable_clk;
+
 	platform_set_drvdata(pdev, sram);
 
 	init_func = of_device_get_match_data(&pdev->dev);
 	if (init_func) {
 		ret = init_func();
 		if (ret)
-			goto err_disable_clk;
+			goto err_free_partitions;
 	}
 
 	dev_dbg(sram->dev, "SRAM pool: %zu KiB @ 0x%p\n",
@@ -415,10 +415,11 @@ static int sram_probe(struct platform_device *pdev)
 
 	return 0;
 
+err_free_partitions:
+	sram_free_partitions(sram);
 err_disable_clk:
 	if (sram->clk)
 		clk_disable_unprepare(sram->clk);
-	sram_free_partitions(sram);
 
 	return ret;
 }
-- 
2.18.0

