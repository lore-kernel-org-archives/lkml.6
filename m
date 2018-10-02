Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDB36C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 10:00:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DA7F2089A
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 10:00:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="rLq9InWl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DA7F2089A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727315AbeJBQnQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 12:43:16 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46000 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726617AbeJBQnP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 12:43:15 -0400
Received: by mail-wr1-f65.google.com with SMTP id q5-v6so1444314wrw.12
        for <linux-kernel@vger.kernel.org>; Tue, 02 Oct 2018 03:00:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=x1sV5Ho9M1FjJsCAF1wSjOmoe+873VqaWr8OAI7FbqQ=;
        b=rLq9InWl6h5qcew5g8x9bVAK/SVJPJXYhRugZhwpJxk2uCn8zwJDYPTXPhYnEVDL5W
         lNFlwlNwkGxsHhDCkxsaoS6d5zxlwqsZ5F6ybrtnSCdgV3OVUFV3PyXi58VXOlpbZd+y
         dKZOr5cZwd4/GzjxQA6xIiiETfUH9kO1frasSVDHMv5nkXNTxgphtkfW39D61/jjic/C
         AvmnG4yv52bffo1Y20ssqKmrs9iEqqgJiB8q00fdoJ+0kG0HoA7T8bxw5e/4u+HhbBIY
         9mk+YFoBeobO8wAJDO97HBBTe5y5/YZ7vdKQpcc3fx9NNYT+wuNMXHtixqKcQiztthi2
         N7aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=x1sV5Ho9M1FjJsCAF1wSjOmoe+873VqaWr8OAI7FbqQ=;
        b=bYiK3JuMw+mg5PSZjo5ZlnRX5BJeilc2zep2/WgEb0EB20boslIl2khqTAPORXkwJV
         uMneGZxRZ+4xsYcjvJkKEizif/fsUb6OHSM2mwBlIMgkyDxdOd0C2aJTqQwExRBQ00m1
         31XQQVZO7nR6dwJKc8p0eobjIakVZL2VC3JIyjG9YzsxrHjM5SP1znQOvDd2mRDEWVws
         iAPlDm5HPvrkXf9K+4w//L/69l1Bg394lMcXRzhyqSVLdOdwscxt9Eii4wfQ3vq6SWBX
         Qn7DsQ43/YAtmvExp0HV5JUip2oO1Xh4kiVSJbaGijEWdOhdLrfsQbRnpkcl/+2rs3LS
         HQig==
X-Gm-Message-State: ABuFfog2v7EpnC1Pc0SdGSrfLPekYdhz2a8yzmTCJALJpEACQeaZMr6C
        5LT9LyJXcU5ohK2qiTN3YMagxQ==
X-Google-Smtp-Source: ACcGV62oA4QZCr12vN9SX8dfosOSiA22kgbqC0qw2wAgWspFbHzw9eSiriFQ9Zw2C6Gd2GhxWve0lA==
X-Received: by 2002:a5d:6a8d:: with SMTP id s13-v6mr9402747wru.44.1538474446921;
        Tue, 02 Oct 2018 03:00:46 -0700 (PDT)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:217b:7d7b:52aa:bc53])
        by smtp.gmail.com with ESMTPSA id s26-v6sm11139109wmh.44.2018.10.02.03.00.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Oct 2018 03:00:46 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Joachim Eastwood <manabian@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, Greg KH <greg@kroah.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH] nvmem: lpc18xx_eeprom: remove unused variable
Date:   Tue,  2 Oct 2018 12:00:37 +0200
Message-Id: <20181002100037.32378-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Remove a variable that's no longer used from lpc18xx_eeprom_remove().

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/nvmem/lpc18xx_eeprom.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/nvmem/lpc18xx_eeprom.c b/drivers/nvmem/lpc18xx_eeprom.c
index b42dbaddb419..66cff1e2147a 100644
--- a/drivers/nvmem/lpc18xx_eeprom.c
+++ b/drivers/nvmem/lpc18xx_eeprom.c
@@ -255,7 +255,6 @@ static int lpc18xx_eeprom_probe(struct platform_device *pdev)
 static int lpc18xx_eeprom_remove(struct platform_device *pdev)
 {
 	struct lpc18xx_eeprom_dev *eeprom = platform_get_drvdata(pdev);
-	int ret;
 
 	clk_disable_unprepare(eeprom->clk);
 
-- 
2.19.0

