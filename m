Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CF3BECE566
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 00:04:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FB4721536
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 00:04:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RSwk+f8I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FB4721536
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388761AbeIUFuh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 01:50:37 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51731 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725887AbeIUFug (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 01:50:36 -0400
Received: by mail-wm1-f68.google.com with SMTP id y2-v6so1231439wma.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Sep 2018 17:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0VWtOhxSxcDkhKHKAPN3U6d1ZKz+2t9Z+u5cjxlXx8s=;
        b=RSwk+f8If/aOGWJ2yeelFjPyTGluKSA1Jb8d109fSdphkmGDdh3eXOrz2EGZ/hCFVC
         pAhoZ9A9lQPT03JwQBAnnVegTHVHJZkNXYaDicAL+mlk8Y0JspXDoVfxwiP7iI7EVxHl
         QfrwEZesQVGKMv8y6nmK+npH9Xo8ejm2JJQjzNmuqLI6gAqZOmDSTMdZAOKzv9V0Q4Fv
         hZv9UJhwzgIu/nobOjpyVOETxo+78LA0jmQn2UDUNAXmSqc9t3AU+RbgkA2ejUe4YCG+
         vYRhO1Mqbbls8hCmL/w3koatfkby0oRmZQFQIoMAhrJZ62kM42qnlevZ6WKzP6ivZFq2
         uxwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0VWtOhxSxcDkhKHKAPN3U6d1ZKz+2t9Z+u5cjxlXx8s=;
        b=uDuQSddFHY826b7Ziv7NMM8p67AkuWCE3WJdLje5NOBFu5+r8SPyi//Gp8O35ACKme
         0o6vTePRnwDocZSoyrAm9v2ejAY0AQhnXXQNsyWjgDhk27Y0z/2vhK9HdQUVGjAyV/gM
         lsjn3ym52cnti4ocoMTDjaPMjObVmv1bPiLeTyIm1F51UcI8PoqX4kqiBwQ9YDX0PQtM
         QD4PTLXo2fqPZJ1PuuXB1cLrvGzgt3NuInJb+RKtvkdQZvFai+lRbtT3ztdWwVkCHZaM
         BXJs1NtbisnFFz2ZslZVwmHcHac6N60jJJLX5AHakcE7NbYt5f0TT8UGPZFFMF+99Rdi
         vKfg==
X-Gm-Message-State: APzg51C9CfzTNbq3B+6mgEitUgroXKaobRYDpRQdgrgUtH8+HjB/mxQH
        XhY4HBulqo5Eio7KxoqohIGtfg+uib2OUg==
X-Google-Smtp-Source: ANB0VdbOFmkHqEXNH9HxJezdIqjRRR+DJWaSXKJDVIULM5nSqg43DxbUAlVF3mDw72pNtwPEm3E7bQ==
X-Received: by 2002:a1c:8f0e:: with SMTP id r14-v6mr4700022wmd.79.1537488271391;
        Thu, 20 Sep 2018 17:04:31 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id q5-v6sm24813921wru.79.2018.09.20.17.04.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Sep 2018 17:04:30 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Support Opensource <support.opensource@diasemi.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] regulator: da905{2,5}: Remove unnecessary array check
Date:   Thu, 20 Sep 2018 17:04:20 -0700
Message-Id: <20180921000420.8740-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang warns that the address of a pointer will always evaluated as true
in a boolean context:

drivers/regulator/da9052-regulator.c:423:22: warning: address of array
'pdata->regulators' will always evaluate to 'true'
[-Wpointer-bool-conversion]
        if (pdata && pdata->regulators) {
                  ~~ ~~~~~~~^~~~~~~~~~
drivers/regulator/da9055-regulator.c:615:22: warning: address of array
'pdata->regulators' will always evaluate to 'true'
[-Wpointer-bool-conversion]
        if (pdata && pdata->regulators) {
                  ~~ ~~~~~~~^~~~~~~~~~

Link: https://github.com/ClangBuiltLinux/linux/issues/142
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 drivers/regulator/da9052-regulator.c | 2 +-
 drivers/regulator/da9055-regulator.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/da9052-regulator.c b/drivers/regulator/da9052-regulator.c
index 9ececfef42d6..37e4025203e3 100644
--- a/drivers/regulator/da9052-regulator.c
+++ b/drivers/regulator/da9052-regulator.c
@@ -420,7 +420,7 @@ static int da9052_regulator_probe(struct platform_device *pdev)
 	config.dev = &pdev->dev;
 	config.driver_data = regulator;
 	config.regmap = da9052->regmap;
-	if (pdata && pdata->regulators) {
+	if (pdata) {
 		config.init_data = pdata->regulators[cell->id];
 	} else {
 #ifdef CONFIG_OF
diff --git a/drivers/regulator/da9055-regulator.c b/drivers/regulator/da9055-regulator.c
index f40c3b8644ae..588c3d2445cf 100644
--- a/drivers/regulator/da9055-regulator.c
+++ b/drivers/regulator/da9055-regulator.c
@@ -612,7 +612,7 @@ static int da9055_regulator_probe(struct platform_device *pdev)
 	config.driver_data = regulator;
 	config.regmap = da9055->regmap;
 
-	if (pdata && pdata->regulators) {
+	if (pdata) {
 		config.init_data = pdata->regulators[pdev->id];
 	} else {
 		ret = da9055_regulator_dt_init(pdev, regulator, &config,
-- 
2.19.0

