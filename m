Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1A7CC4646D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 19:15:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FED822450
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 19:15:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UXsvJfvd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FED822450
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727426AbeHJVqS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 17:46:18 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:38140 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727395AbeHJVqR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 17:46:17 -0400
Received: by mail-lj1-f196.google.com with SMTP id p6-v6so7964461ljc.5;
        Fri, 10 Aug 2018 12:15:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8IyWERHgMQT0Bw51KugCBU4wS7zbQmLV4VerGSJPGaU=;
        b=UXsvJfvdFdhMz5OyiSN1Ls3MibXU2wvjj60g5yD3rSP2IaQSeg1ICNjr98RkcbryDS
         lhBpqrJzhuzaIrXWeOIox9ZVr+9wUvMZ+8BEJ210e8trrZ9O/189PEf8R/wFLIzhwy8D
         CpifF6G9xUpiaRCOIOlLXpiPH2AOCR4sBZwsOHNn765deW1ec6uBJJQSVNMxAtqonkY4
         9M/EmmPHxNEtmf5+mXWcKWqZMuB6Nz5Pf2lyfMPjXFvUZ4EZVfBhz/FAEgw740+F5gDE
         iBiZWS+9l4CW2P6Qe7V2K0BmzmMfxi7kCRh/YMaUMY9KP+nZybauS7nGgJGqHMDBunAc
         ZBjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8IyWERHgMQT0Bw51KugCBU4wS7zbQmLV4VerGSJPGaU=;
        b=rf3SdNIiVqFoIRDKGjESk41iBsEODnVMb2JjBCa+ND2qUtlFFnVIhQebJBt/j87Wro
         CWGJpj6npQjVC2BrBIJQW5l/IIapclprY1q4mPQiKH8ztbjraRsmq+ar4fVJdvzzd7RW
         olAarL/UEmGtobrRAgodsjAr7nuAWVFSkXqzObeyjpQ63ckbz8xG59wZlKIxcBF62qZx
         bQM6XkUgSSk1Uk0oO5qWwoW4PVu9BcMsKNSCDvdO2eDykJ7EdhOWFRAxEkdJ5sR9wZhC
         mr227eVisI4DPhEsttxsjMOKM/i8ilsSVgYouw0KiuWmphnQOaQcz2SW25Y8kbKcI2Rg
         LfHQ==
X-Gm-Message-State: AOUpUlHMvOSv00og1ki+6AbAoBtHJYJXGWW637FBX9nbmPRNvMVe2MFu
        CEoetrsrbei+RZO1CJpzwd0=
X-Google-Smtp-Source: AA+uWPxYcTjb3lr8D6KQl5oXH1tue2ihZ0cDl8oD0KJjxPzHKYGBkslV1qGliopy+70KCrccPEa2EA==
X-Received: by 2002:a2e:5c4:: with SMTP id 187-v6mr5360367ljf.28.1533928506066;
        Fri, 10 Aug 2018 12:15:06 -0700 (PDT)
Received: from localhost.localdomain (c-2ec24faa-74736162.cust.telenor.se. [46.194.79.170])
        by smtp.gmail.com with ESMTPSA id d23-v6sm1734931ljg.17.2018.08.10.12.15.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Aug 2018 12:15:04 -0700 (PDT)
From:   Marcus Folkesson <marcus.folkesson@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Marcus Folkesson <marcus.folkesson@gmail.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] iio: dac: mcp4725: avoid using CONFIG_PM_SLEEP
Date:   Fri, 10 Aug 2018 20:51:10 +0200
Message-Id: <20180810185110.12710-3-marcus.folkesson@gmail.com>
X-Mailer: git-send-email 2.11.0.rc2
In-Reply-To: <20180810185110.12710-1-marcus.folkesson@gmail.com>
References: <20180810185110.12710-1-marcus.folkesson@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SIMPLE_DEV_PM_OPS() is already doing this.

Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
---
 drivers/iio/dac/mcp4725.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/dac/mcp4725.c b/drivers/iio/dac/mcp4725.c
index 8b5aad4c32d9..6d71fd905e29 100644
--- a/drivers/iio/dac/mcp4725.c
+++ b/drivers/iio/dac/mcp4725.c
@@ -45,7 +45,7 @@ struct mcp4725_data {
 	struct regulator *vref_reg;
 };
 
-static int mcp4725_suspend(struct device *dev)
+static int __maybe_unused mcp4725_suspend(struct device *dev)
 {
 	struct mcp4725_data *data = iio_priv(i2c_get_clientdata(
 		to_i2c_client(dev)));
@@ -58,7 +58,7 @@ static int mcp4725_suspend(struct device *dev)
 	return i2c_master_send(data->client, outbuf, 2);
 }
 
-static int mcp4725_resume(struct device *dev)
+static int __maybe_unused mcp4725_resume(struct device *dev)
 {
 	struct mcp4725_data *data = iio_priv(i2c_get_clientdata(
 		to_i2c_client(dev)));
@@ -71,13 +71,7 @@ static int mcp4725_resume(struct device *dev)
 
 	return i2c_master_send(data->client, outbuf, 2);
 }
-
-#ifdef CONFIG_PM_SLEEP
 static SIMPLE_DEV_PM_OPS(mcp4725_pm_ops, mcp4725_suspend, mcp4725_resume);
-#define MCP4725_PM_OPS (&mcp4725_pm_ops)
-#else
-#define MCP4725_PM_OPS NULL
-#endif
 
 static ssize_t mcp4725_store_eeprom(struct device *dev,
 	struct device_attribute *attr, const char *buf, size_t len)
@@ -547,7 +541,7 @@ static struct i2c_driver mcp4725_driver = {
 	.driver = {
 		.name	= MCP4725_DRV_NAME,
 		.of_match_table = of_match_ptr(mcp4725_of_match),
-		.pm	= MCP4725_PM_OPS,
+		.pm	= &mcp4725_pm_ops,
 	},
 	.probe		= mcp4725_probe,
 	.remove		= mcp4725_remove,
-- 
2.11.0.rc2

