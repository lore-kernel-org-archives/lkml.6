Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8957C43142
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 10:00:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F1FB271BA
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 10:00:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="SEjpgwYJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F1FB271BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935343AbeF1KAi (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 06:00:38 -0400
Received: from mail-wr0-f178.google.com ([209.85.128.178]:40990 "EHLO
        mail-wr0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934223AbeF1J57 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 05:57:59 -0400
Received: by mail-wr0-f178.google.com with SMTP id h10-v6so4850228wrq.8
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jun 2018 02:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/wnqUWa/fmVurTaOdeLuPDbfe93Sg0riCJfNwUvWb+Q=;
        b=SEjpgwYJVOespCxTL5ELp6zLhMLOkQzt5b6iYQPVYz64yElFO/rhNmGGOGzi2uMtkr
         JyA5oOZiaX8G2S8CinJi5ugZRMhuU019hfkPy+g6GMcZ2qDMY9rSDBOTDmcOjBgCaHd5
         zqp/P/YD3RQqAMyURb6u+QPwAkAwF317MeVZNfjHkTwLBaBCQk/3hAo9dHwCYTpNsFYz
         Fx/cgLO2Oky3QP2gz3f4el/EkYns+IdOvUlPTUjjUX47mifF2NUkToF73sZUEKDxhX0t
         kNXaSW6JcfBWQzO8e3S3c19vK5nyAvIjE2AphQoArWj7J2hGm/vtNK8tKtzT1qQMdp8i
         o0Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/wnqUWa/fmVurTaOdeLuPDbfe93Sg0riCJfNwUvWb+Q=;
        b=eIoV4eWtnaLQKUuH6tf8/FYyPxIhNbJd7AjCvTHmt3b6gkk9zmlv9JzZZuKoDqDcC8
         uswSKrsnAP6AsmDJugt6at1Zzm8dKBG5WHV+FAF58Z4CwlVNXuS/fE/a02CTGZHMVm6z
         F5JPi4OTWn13Y5KG8Nb83yrDEa3wu6b4wlBuOMvQC6OYz/GG1Ybm5H5kezu+E77OOAvd
         D59APg/4WZbJ1V6TEY7/Cxk6NzHqCoFFknQhgsSnSCk0ar6WxhHm4h7raz/T1ZtuG/C8
         S8OVa4GcXl5Te+XV+cKZHUXWbbmwDxsJHoe2h3H8q3knBkFnh7/tgOQpx6ZJrTt1KsB/
         zg+A==
X-Gm-Message-State: APt69E2OlyuhCJ8nMKGoV3VVYc527vugBJwGlUDC3071F8FPdFCg4X1N
        7bK7TPnh8PsvoscwqYo56muvUA==
X-Google-Smtp-Source: AAOMgpdeLXE5B38bC6KVN7y6sZn0Q7q+fHO87EFvGWaGPaSlhZoD7nQtnXbT8FPpwn1XzuAdIqVYJg==
X-Received: by 2002:adf:dd07:: with SMTP id a7-v6mr8460411wrm.2.1530179878254;
        Thu, 28 Jun 2018 02:57:58 -0700 (PDT)
Received: from brgl-bgdev.baylibre.local (AStLambert-681-1-87-41.w90-86.abo.wanadoo.fr. [90.86.29.41])
        by smtp.gmail.com with ESMTPSA id s8-v6sm1550352wrm.84.2018.06.28.02.57.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Jun 2018 02:57:57 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        David Lechner <david@lechnology.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v3 02/13] clk: davinci: psc-dm365: use two lookup entries for the aemif clock
Date:   Thu, 28 Jun 2018 11:57:37 +0200
Message-Id: <20180628095748.4462-3-brgl@bgdev.pl>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180628095748.4462-1-brgl@bgdev.pl>
References: <20180628095748.4462-1-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

We want to be able to get the clock both from the board file by its
con_id and from the aemif driver by dev_id.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Reviewed-by: David Lechner <david@lechnology.com>
---
 drivers/clk/davinci/psc-dm365.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/davinci/psc-dm365.c b/drivers/clk/davinci/psc-dm365.c
index 8c73086cc676..c75424f4ea3b 100644
--- a/drivers/clk/davinci/psc-dm365.c
+++ b/drivers/clk/davinci/psc-dm365.c
@@ -21,7 +21,8 @@ LPSC_CLKDEV1(mmcsd1_clkdev,		NULL,		"da830-mmc.1");
 LPSC_CLKDEV1(asp0_clkdev,		NULL,		"davinci-mcbsp");
 LPSC_CLKDEV1(usb_clkdev,		"usb",		NULL);
 LPSC_CLKDEV1(spi2_clkdev,		NULL,		"spi_davinci.2");
-LPSC_CLKDEV1(aemif_clkdev,		"aemif",	NULL);
+LPSC_CLKDEV2(aemif_clkdev,		"aemif",	NULL,
+					NULL,		"ti-aemif");
 LPSC_CLKDEV1(mmcsd0_clkdev,		NULL,		"da830-mmc.0");
 LPSC_CLKDEV1(i2c_clkdev,		NULL,		"i2c_davinci.1");
 LPSC_CLKDEV1(uart0_clkdev,		NULL,		"serial8250.0");
-- 
2.17.1

