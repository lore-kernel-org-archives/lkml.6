Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 370BBC43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 07:32:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F221E21471
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 07:32:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fxjwbUaL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F221E21471
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727398AbeJBOO2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 10:14:28 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:45977 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726890AbeJBOO0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 10:14:26 -0400
Received: by mail-lj1-f193.google.com with SMTP id x16-v6so802921ljd.12;
        Tue, 02 Oct 2018 00:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Wmog6lAgqKOhpPrEYXjVkbDL7dvr+abZ89S+iJGxfPU=;
        b=fxjwbUaLGwRZ6dZJknYfqV2FfhvYr6xgQyif+yYApN6icSgkBIBfBB370kHk76VVkV
         Q6p2RDhWNF0dpBcVo6tuZh9SYzMIq6nrMTCRqiqqR185ilIUd+j3hT69rGTHBCYVMjBr
         W7t7eHVrnXHSJ2MdE3UlgtXOReMxFqwK4Z9kqDyVDOxUoUJKmkZEuvrwdJ7Ze4qGaD8q
         3lo5nYx6rf5CKaH974u9LVZLssf/u59zs43ln9Qb8b08kFDDNo6Qmot57SCtALv2UZpB
         r36ajRmpYAGN2VjS8OoQVTRe5PdjCLBKqV+cZr3NH34AGIkCIsMXRzUpqyfzmO+74q+v
         zvow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Wmog6lAgqKOhpPrEYXjVkbDL7dvr+abZ89S+iJGxfPU=;
        b=Nf21oLlJcGzMyTifiQcrI593HGo7QwYUxQnl80NRKyzWjuHOLOqKgWX7S/4BJuZ2oa
         X6bJmm/6yCnbSPfxMCgSkWF8ZLeWC4EqV5SjPEdyILixQekSZgx4s724mRaAskEMTmaY
         kUTBlBTkmfCS1yj7CH34vQcwh5Bw4YBVzEw3+wuEsXYSzQFjX/yef/Gmo1gTXlcu7+k6
         67LyYkzhmhX+ebZRHmlN3L7VS9vKc2h3pcobFPldccOs1EGb0dn8bsxMAw+xZyAn65I2
         ZGTXzakWq4z4s0/5NKQBAxeXC9hITyU/lITumc9DFHPmEpo7emLIwec3F89FYHM+lhec
         UFMg==
X-Gm-Message-State: ABuFfohoFrLJW/BBo0uAJbSkMfJRhWLehzdvgeGcNOzSjp2YFfXadwLd
        x+2RjlDAC/VZsjUOyp5B5+QIJKZV
X-Google-Smtp-Source: ACcGV63qYPFA1s8otWAUMxBFgdoDgVdLJaR3Jvjp7hGmbWZoEC4JFf7+dxbMRhE+pEhikRmhQSYrzA==
X-Received: by 2002:a2e:50e:: with SMTP id 14-v6mr7824895ljf.152.1538465553647;
        Tue, 02 Oct 2018 00:32:33 -0700 (PDT)
Received: from neopili.qtec.com (cpe.xe-3-0-1-778.vbrnqe10.dk.customer.tdc.net. [80.197.57.18])
        by smtp.gmail.com with ESMTPSA id d17-v6sm1242246lfj.9.2018.10.02.00.32.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Oct 2018 00:32:32 -0700 (PDT)
From:   Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
To:     Pavel Machek <pavel@ucw.cz>, Sakari Ailus <sakari.ailus@iki.fi>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Subject: [PATCH v5 6/6] [media] ad5820: Add support for ad5821 and ad5823
Date:   Tue,  2 Oct 2018 09:32:22 +0200
Message-Id: <20181002073222.11368-6-ricardo.ribalda@gmail.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181002073222.11368-1-ricardo.ribalda@gmail.com>
References: <20181002073222.11368-1-ricardo.ribalda@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to the datasheet, both AD5821 and AD5820 share a compatible
register-set:
http://www.analog.com/media/en/technical-documentation/data-sheets/AD5821.pdf

Some camera modules also refer that AD5823 is a replacement of AD5820:
https://download.kamami.com/p564094-OV8865_DS.pdf

Suggested-by: Pavel Machek <pavel@ucw.cz>
Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
---
 drivers/media/i2c/ad5820.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/media/i2c/ad5820.c b/drivers/media/i2c/ad5820.c
index 4ae4e6a776fd..2c0dd9960268 100644
--- a/drivers/media/i2c/ad5820.c
+++ b/drivers/media/i2c/ad5820.c
@@ -33,8 +33,6 @@
 #include <media/v4l2-device.h>
 #include <media/v4l2-subdev.h>
 
-#define AD5820_NAME		"ad5820"
-
 /* Register definitions */
 #define AD5820_POWER_DOWN		(1 << 15)
 #define AD5820_DAC_SHIFT		4
@@ -367,13 +365,17 @@ static int ad5820_remove(struct i2c_client *client)
 }
 
 static const struct i2c_device_id ad5820_id_table[] = {
-	{ AD5820_NAME, 0 },
+	{ "ad5820", 0 },
+	{ "ad5821", 0 },
+	{ "ad5823", 0 },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, ad5820_id_table);
 
 static const struct of_device_id ad5820_of_table[] = {
 	{ .compatible = "adi,ad5820" },
+	{ .compatible = "adi,ad5821" },
+	{ .compatible = "adi,ad5823" },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, ad5820_of_table);
@@ -382,7 +384,7 @@ static SIMPLE_DEV_PM_OPS(ad5820_pm, ad5820_suspend, ad5820_resume);
 
 static struct i2c_driver ad5820_i2c_driver = {
 	.driver		= {
-		.name	= AD5820_NAME,
+		.name	= "ad5820",
 		.pm	= &ad5820_pm,
 		.of_match_table = ad5820_of_table,
 	},
-- 
2.19.0

