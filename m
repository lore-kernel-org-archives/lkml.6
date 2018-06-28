Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C570C43142
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 09:58:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA0632719F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 09:58:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="AzgYwwiU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA0632719F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935254AbeF1J6F (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 05:58:05 -0400
Received: from mail-wr0-f178.google.com ([209.85.128.178]:36972 "EHLO
        mail-wr0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935134AbeF1J6B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 05:58:01 -0400
Received: by mail-wr0-f178.google.com with SMTP id k6-v6so4859882wrp.4
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jun 2018 02:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ORUO3Jx0NIj7th+JdFndVgsL+HT7OGuaxBq0lYbXpQ0=;
        b=AzgYwwiUBsaJJG5jhWimHMd+dA717lf+Q5QdvNeV9BpI518nTdZ6LR9+lyBQuu6pw6
         fOTclI4mbreClt0vjk2f/HFTpKWzizjYWsPM4Zcp2bKbRcYRgqHDW5Sfp2/b6nbS43Rr
         xeA1tkaqdvQnc+XWz8WAlQzCWluWEvXNaPLBZmJ3zDCoo27PVnLXz/dMdXgA/TQbR9Gf
         S/uIN7TvydNXnU9wR4h61WWw+iXQv72nWBV9lf5BI3xuYMPR3ZbIkxL3yikLwgSjWBox
         3YDNyTlmK0E/mXZPEi+gzbze4Nv0dijpfgQO2RUXIsByk7hH7osvm4ecA5xEFB8xDICU
         QNwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ORUO3Jx0NIj7th+JdFndVgsL+HT7OGuaxBq0lYbXpQ0=;
        b=bZaEBjtTP9amK5A0WSoCbR1hlTWhnDBs1eyzWA6gb0DebWy2CzEjvZXkZE/H7/k/dN
         GEInhsPF3BJ2fpfa0uz8xn/NGmPj3j2y4UKjCp9Sr+C6Rrgw/QtYArAXoDVd0oljWXOY
         9CAryyJe+tXIoh3xDLwKbRh9ESb6siS5IXjWP9LjgCkGVk2NnCjlX/gK+IBycMkpqMNr
         pKnGfADoLjx7gkAxpD1Xzjhn9r4UdohgzIf0KDn4Lk1K4NyMLG7A/RigI3SVX5lU06L8
         m7oz9Xf5pWcJv0eiYAIMeO+pQzP/WN9Mqx4IdL2N5T+QcalIVk1ozirxaZI/6JtRVCD8
         OlWg==
X-Gm-Message-State: APt69E2/KW64YnVlDTzCKdEGapivwFCVsA7yXoX3A44JpGBuYfyxckK9
        7/sdXXCMpYgXObCfk9emIQU0GQ==
X-Google-Smtp-Source: AAOMgpeBJbVuqgC0qe+W55C+o09SmvzWyA+xTuxHuA0iIAjob/qldD7RHLTerZHpBvRnnKi4b8qeOg==
X-Received: by 2002:adf:a706:: with SMTP id c6-v6mr8374033wrd.61.1530179880353;
        Thu, 28 Jun 2018 02:58:00 -0700 (PDT)
Received: from brgl-bgdev.baylibre.local (AStLambert-681-1-87-41.w90-86.abo.wanadoo.fr. [90.86.29.41])
        by smtp.gmail.com with ESMTPSA id s8-v6sm1550352wrm.84.2018.06.28.02.57.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Jun 2018 02:57:59 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        David Lechner <david@lechnology.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v3 04/13] clk: davinci: psc-dm646x: use two lookup entries for the aemif clock
Date:   Thu, 28 Jun 2018 11:57:39 +0200
Message-Id: <20180628095748.4462-5-brgl@bgdev.pl>
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
 drivers/clk/davinci/psc-dm646x.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/davinci/psc-dm646x.c b/drivers/clk/davinci/psc-dm646x.c
index c3f82ed70a80..20012dc7471a 100644
--- a/drivers/clk/davinci/psc-dm646x.c
+++ b/drivers/clk/davinci/psc-dm646x.c
@@ -18,7 +18,8 @@
 LPSC_CLKDEV1(ide_clkdev,	NULL,		"palm_bk3710");
 LPSC_CLKDEV2(emac_clkdev,	NULL,		"davinci_emac.1",
 				"fck",		"davinci_mdio.0");
-LPSC_CLKDEV1(aemif_clkdev,	"aemif",	NULL);
+LPSC_CLKDEV2(aemif_clkdev,	"aemif",	NULL,
+				NULL,		"ti-aemif");
 LPSC_CLKDEV1(mcasp0_clkdev,	NULL,		"davinci-mcasp.0");
 LPSC_CLKDEV1(mcasp1_clkdev,	NULL,		"davinci-mcasp.1");
 LPSC_CLKDEV1(uart0_clkdev,	NULL,		"serial8250.0");
-- 
2.17.1

