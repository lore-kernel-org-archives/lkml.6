Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A74FCECDFD0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 14:40:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51CEB2148E
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 14:40:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="S7jbs5pP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51CEB2148E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728399AbeINTz1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 15:55:27 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:39603 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728342AbeINTzZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 15:55:25 -0400
Received: by mail-wm1-f66.google.com with SMTP id q8-v6so2197812wmq.4
        for <linux-kernel@vger.kernel.org>; Fri, 14 Sep 2018 07:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1PFkzde7HIbembuPSuldz/+wF0MJkUfGiNxQy31YmBk=;
        b=S7jbs5pPQ2x3wKmhl12WP8g1zp9JDwpVIt1QT49EXeR5DLKo2hy3aYJPrmap8/bue3
         w9ldGm6jkuCKD47VfAVUwdnRu4tw+QAo/0nYhqtnUfgsutWPjzs5RpF/M8aSSXiXeA9n
         3nY/g4LSs5XIOgYrvpKap6ONXJuzGMs/aGXx42ZBOXU57gMPeEk3UL7dcFw9arEwS6r0
         Uv3AncCtRfQCoKdt8aiWQZbAylcyKZqRNddTD02zT0HoxMsZGVastn6agIKjmVlKsszX
         tRGR5fg6X4gO1KjhVbUr9Yz9nSiWpRnI329lmZBmxE/XoCfaLvZ5wu8hnqABHuDPdi9S
         aN7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1PFkzde7HIbembuPSuldz/+wF0MJkUfGiNxQy31YmBk=;
        b=J4mTRYvyX0C1fJusVgCvRs/gymyNsU+b9aaKDGF+GGit550PlU3adhG+BrR18N+lnn
         rQHRWU5zgEQpVMOBK3xfzqmwQXfZpOPMrhrVjkwH6cW9RhaRlnKVYNyPXCzCLhE9346H
         YDDsSvyMaGcUBzjBxN+NpPkoTcW79ZzmIwxFAU/+PwgHE90Cw66Qj3mE5usEZyPk+nK0
         NcJezqd0zId6LZLYxDJD47HgCCmMymU1AnkHBDrwPPEaFsJPkmsOmPwXjYRgA6Jg/G82
         j90TMa22xQJi6QAMmnqNTMXIfKu/wFSt2iuxqt7eULUpHImGUxScpn/D8r0CEIZcswoq
         RKlg==
X-Gm-Message-State: APzg51DbfeItPMI8zNc3WgtnrUm3xJIxNW/2+ddjZJJ5x64ylnCAb/q7
        SSsaDhXnZKOXwMVftdwdoJh+6Q==
X-Google-Smtp-Source: ANB0VdbiWxIsIrJKeRP4iH0O3gtnMPpYpzuvzvv/gKbNvuLJuiqaPtjl/n/DkJoHAUaZS7WkLor/xg==
X-Received: by 2002:a1c:b709:: with SMTP id h9-v6mr2482752wmf.130.1536936035500;
        Fri, 14 Sep 2018 07:40:35 -0700 (PDT)
Received: from brgl-bgdev.home ([2a01:cb1d:af:5b00:e837:b8d5:48c1:571b])
        by smtp.gmail.com with ESMTPSA id v46-v6sm10313526wrc.63.2018.09.14.07.40.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Sep 2018 07:40:35 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        "David S . Miller" <davem@davemloft.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Jonathan Corbet <corbet@lwn.net>, Sekhar Nori <nsekhar@ti.com>,
        Kevin Hilman <khilman@kernel.org>,
        David Lechner <david@lechnology.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Andrew Lunn <andrew@lunn.ch>, Alban Bedel <albeu@free.fr>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v4 09/22] nvmem: lpc18xx_eeprom: use devm_nvmem_register()
Date:   Fri, 14 Sep 2018 16:39:58 +0200
Message-Id: <20180914144011.27614-10-brgl@bgdev.pl>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180914144011.27614-1-brgl@bgdev.pl>
References: <20180914144011.27614-1-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Use the managed version of nvmem_register().

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/nvmem/lpc18xx_eeprom.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/nvmem/lpc18xx_eeprom.c b/drivers/nvmem/lpc18xx_eeprom.c
index a9534a6e8636..b42dbaddb419 100644
--- a/drivers/nvmem/lpc18xx_eeprom.c
+++ b/drivers/nvmem/lpc18xx_eeprom.c
@@ -236,7 +236,7 @@ static int lpc18xx_eeprom_probe(struct platform_device *pdev)
 	lpc18xx_nvmem_config.dev = dev;
 	lpc18xx_nvmem_config.priv = eeprom;
 
-	eeprom->nvmem = nvmem_register(&lpc18xx_nvmem_config);
+	eeprom->nvmem = devm_nvmem_register(dev, &lpc18xx_nvmem_config);
 	if (IS_ERR(eeprom->nvmem)) {
 		ret = PTR_ERR(eeprom->nvmem);
 		goto err_clk;
@@ -257,10 +257,6 @@ static int lpc18xx_eeprom_remove(struct platform_device *pdev)
 	struct lpc18xx_eeprom_dev *eeprom = platform_get_drvdata(pdev);
 	int ret;
 
-	ret = nvmem_unregister(eeprom->nvmem);
-	if (ret < 0)
-		return ret;
-
 	clk_disable_unprepare(eeprom->clk);
 
 	return 0;
-- 
2.18.0

