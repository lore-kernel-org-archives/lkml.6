Return-Path: <SRS0=t4yP=K2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19F1CC46460
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 09:11:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1BA021EF3
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 09:11:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iw1Bji3o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1BA021EF3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727361AbeHKLou (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Aug 2018 07:44:50 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:44189 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727205AbeHKLou (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Aug 2018 07:44:50 -0400
Received: by mail-lj1-f195.google.com with SMTP id q127-v6so8881135ljq.11;
        Sat, 11 Aug 2018 02:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=v7zWKwfs4hznW1ZszTpX7qLrB6NIuISnP564aFpN8bU=;
        b=iw1Bji3oPG8SUMX9wmkWPmu/5pHwivurATZD8z6BSk8koF5BgJlSSEJPNpk9+CAP8r
         pdQJGmosfIGDxqGNo6U/RbcnSF4wSzJaIMF0J8PdwwMbmPTvce/nENszMvPwsjbgP3DV
         xumBsAgXtSB5Wvhqg4COder6PQHsWqm/rJGMGa2XCnw06kYrDwBC45FSvPFLIl3VnkVL
         hHc4foAH2XotuinsfFH1ggTlqx4ZGYnaWDVuSKfQ9n9e0vwc4nHvicOeUoJ8BIvrw6OC
         A6AUsddIjIHg/dMaueyseom22lqo1CZtj4HnKg7aLzywIMPm5M0DAz3ft1BnfBmFrDiz
         VgmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=v7zWKwfs4hznW1ZszTpX7qLrB6NIuISnP564aFpN8bU=;
        b=PZzXBGMkk7nP+e2UYb3CSyJ5WzdlMEHGZsmDqWPabGmbLnxj4bMRp5OaIsEeYGwUTC
         G2h4ZgBcaa6vIWAypjScG0YNvFvEUdFf9WC6M3lLKc3B1E96mgUsCffQq5vr7uwyavz+
         onbXF/xZFNRGqEz4hIs7YHAW8KiB5t705v90kjA3AoGxmxEh0yG+GBPX0zBuiYXvFFaq
         eVSamhXQTCzwgT6Lk3DdGfsEE0YuL1o9k2pBMT8mGmcAfJDQmRXzcyrF0/gGS8Sl11Z8
         dfAN5L5GfFahV4JScOwrVmIhrqdnNu0BRA3m/umOeHtIYocgifCUTASPBroV8cuykWtj
         sG6w==
X-Gm-Message-State: AOUpUlEDEcTr746PIvSq+mv7uGpvtaYJTRettlcPkZAz4M3CtvlmFbbW
        rxX1RqjV2FfixS8/9UeD83A=
X-Google-Smtp-Source: AA+uWPyYCtx/pkG2DvChdITZEKKGAA6uw2MYL/EZThq2On4x9PB1DWib2zXzRU4ZKVeTdk2YCWvuHg==
X-Received: by 2002:a2e:5d1c:: with SMTP id r28-v6mr6827993ljb.89.1533978675503;
        Sat, 11 Aug 2018 02:11:15 -0700 (PDT)
Received: from localhost.localdomain (c-2ec2e3af-74736162.cust.telenor.se. [46.194.227.175])
        by smtp.gmail.com with ESMTPSA id p134-v6sm2351287lfe.11.2018.08.11.02.11.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 11 Aug 2018 02:11:14 -0700 (PDT)
From:   Marcus Folkesson <marcus.folkesson@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Marcus Folkesson <marcus.folkesson@gmail.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RESEND PATCH] iio: dac: mcp4725: avoid using CONFIG_PM_SLEEP
Date:   Sat, 11 Aug 2018 10:47:25 +0200
Message-Id: <20180811084725.6742-1-marcus.folkesson@gmail.com>
X-Mailer: git-send-email 2.11.0.rc2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is already handled by SIMPLE_DEV_PM_OPS().

Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
---
Somehow git-send-email messed up (?!) the format for (at least) gmail, so resend it.
Mutt still read the mail correct though.

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

