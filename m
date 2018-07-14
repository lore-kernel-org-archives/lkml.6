Return-Path: <SRS0=T5ek=J6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F168ECDFAA
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 12:27:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF1332087C
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 12:27:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uKrJDdUS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF1332087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727561AbeGNMp7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Jul 2018 08:45:59 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:33979 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726129AbeGNMp6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jul 2018 08:45:58 -0400
Received: by mail-lj1-f196.google.com with SMTP id f8-v6so8675763ljk.1;
        Sat, 14 Jul 2018 05:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rmGc4y2imt1ExYPAjKYiMse/xhDh77VC3NOODiIkSdg=;
        b=uKrJDdUSDYGZwNX4HKJvB6NJt+Ny0jyu1AiWwX3kExZIkfu3hVBYF+l+gO1/zMPif2
         X6KpmXVSrw8v30NdUMRwArliNzLz/XR/i4gZLYP5cjhhxjIs73jIRqsW2814iyM8xYio
         LBVWWtfSAw7k+jCWTvtmKjxgLHYR9sPWLTQhKtAkjtkauP0bioc3Jkt/ORhek12jB9RS
         Cy2HQCr1ikitzQp9dnyXp7zGOxq+ko+x/2mOrg1iGLjgfVmeC7h+FBbzBMII1GKjeXRl
         AGoELsQ2Lzm1Kx2wBxK72n8yWGbJuv4rVwkcXgS+YIXmut310UvCRyz7GSM+ls3PaMvC
         ezkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rmGc4y2imt1ExYPAjKYiMse/xhDh77VC3NOODiIkSdg=;
        b=dWmng6N/nm5P5I4z9RbGXtb65awX0ouCbZN9HBecQYvHgZ9aeBCHJcLA+vpx1ebfae
         ffyM7bh04VLVGA2esTfSyKDyudp6mXSNs/G09WrCInJf6DfaZ2hJyfdQ3tYvRmwOgxKv
         v8+dyfJM/mdyc7hUfQ5lAJas9QLsd4jN+v6AiEBkvVgZVA9F5yNRhqBnjZrX+cUL7bLh
         I78XSn/Kk7Fmlg0BZoH7t2jcFA1dQeSwIfXBfW7Gl72oK8pRv1wdjb1rnWggAvmqjcWF
         cdbqHbYK8WsJFpWNPKOPxNsdMvCYyC8EF9S4F2+iNKkwjuv1bE8fRDH4ty0W70AW1LCq
         +Lxg==
X-Gm-Message-State: AOUpUlE4QBvkPcvkNK0IZebmV/R3JMz+gsF4QQXvAollXDUdsfE/3cIm
        KbfgS5/utVo1TZBEEoX4WDU=
X-Google-Smtp-Source: AAOMgpcRo6HE5BehfGw2cpES4Ehtg/cAA53f8X3T1KkMfI5eYTWeX+erBzcgD1fq28XltGYStRBnFw==
X-Received: by 2002:a2e:8743:: with SMTP id q3-v6mr5306530ljj.139.1531571220893;
        Sat, 14 Jul 2018 05:27:00 -0700 (PDT)
Received: from localhost.localdomain (user-94-254-174-73.play-internet.pl. [94.254.174.73])
        by smtp.googlemail.com with ESMTPSA id l3-v6sm5860732lfi.36.2018.07.14.05.26.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 14 Jul 2018 05:27:00 -0700 (PDT)
From:   =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, sre@kernel.org,
        lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, Tomasz Figa <tomasz.figa@gmail.com>,
        =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
Subject: [PATCH v2 1/3] power: supply: max8998-charger: Fix platform data retrieval
Date:   Sat, 14 Jul 2018 14:26:51 +0200
Message-Id: <1531571213-30593-2-git-send-email-pawel.mikolaj.chmiel@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1531571213-30593-1-git-send-email-pawel.mikolaj.chmiel@gmail.com>
References: <1531571213-30593-1-git-send-email-pawel.mikolaj.chmiel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tomasz Figa <tomasz.figa@gmail.com>

Since the max8998 MFD driver supports instantiation by DT, platform data
retrieval is handled in MFD probe and cell drivers should get use
the pdata field of max8998_dev struct to obtain them.

Fixes: ee999fb3f17f ("mfd: max8998: Add support for Device Tree")
Signed-off-by: Tomasz Figa <tomasz.figa@gmail.com>
Signed-off-by: Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>
---
 drivers/power/supply/max8998_charger.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/max8998_charger.c b/drivers/power/supply/max8998_charger.c
index b64cf0f14142..66438029bdd0 100644
--- a/drivers/power/supply/max8998_charger.c
+++ b/drivers/power/supply/max8998_charger.c
@@ -85,7 +85,7 @@ static const struct power_supply_desc max8998_battery_desc = {
 static int max8998_battery_probe(struct platform_device *pdev)
 {
 	struct max8998_dev *iodev = dev_get_drvdata(pdev->dev.parent);
-	struct max8998_platform_data *pdata = dev_get_platdata(iodev->dev);
+	struct max8998_platform_data *pdata = iodev->pdata;
 	struct power_supply_config psy_cfg = {};
 	struct max8998_battery_data *max8998;
 	struct i2c_client *i2c;
-- 
2.7.4

