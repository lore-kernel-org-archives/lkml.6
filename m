Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56438C46464
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 19:15:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E16922450
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 19:15:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sB0jwnL1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E16922450
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727345AbeHJVqN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 17:46:13 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:42156 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726982AbeHJVqN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 17:46:13 -0400
Received: by mail-lj1-f194.google.com with SMTP id f1-v6so7957775ljc.9;
        Fri, 10 Aug 2018 12:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=o4CIS/PJ43brDR41dgrSNT2DwCqVA4nKrYsTlMbzZ1o=;
        b=sB0jwnL1fIxOGoN3lEHAz2fE0nzttrxjwC4A6QxCskwQb4a6OJPw0oahiw+gX37MyR
         A9caiFmTYIUuld8Qtfnn9qvlzDv1pGdaS0jJCrhW24i83+9fhcKAyb9QKqfyCCuvz1sI
         gl68T7VqqC+tZ0yMHqsP71St2pVg2Cli6ToyKcQ18bfmP93V7PF3x87GltBY9T+qq8BI
         jo6o9oWl4Bb6u3tRAhA9vc6/7P0Qs9KhJMpydmauvADpOFJFaGuFSMhm9uOf/npsbo+J
         iV7eDjwDjOp3oAyM77p8tHqH5h4/6SgmZU3MvsQm+IQrWT6u+w++hpGT1580DU64P3sq
         XAOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=o4CIS/PJ43brDR41dgrSNT2DwCqVA4nKrYsTlMbzZ1o=;
        b=s/UsSyEzExEU2q3YJu3Ako3yqq/aQWQTOjhE3a00GqJF/1CjGnwLV4S4G3LJgmWXaE
         7/GmXrpkoy2+yOujcP9reUCH7Z8cVzDlx5g85BF/HalYgS6J7VegSzTWvcnqC+qDodmH
         JuOgasbniXgNTHMGVvqOT5fNGKK6fsrSAVtnSelt8s3b8/F+/RIA/ZzY/MotS6WipCxV
         Ed69TqHXea2KATtPL9RcFjH3VoE3XzYCBQFrrEb2b4C09S/xD6lAvWDlL2jJS34BNlzI
         s6C0R3pOZZviygIbXveGxS8kXhB10x+2dwwPgf6wiZ2hGYOh1gfki1tmYnDtjwH4Lm2E
         Ag9A==
X-Gm-Message-State: AOUpUlH0NHNeAxN0XaEbEaSGfky+QaePeQx1jGTWyxjG2jkjFLW6hfMn
        04bANu2Gb8/KoDb1qgmT5nQ=
X-Google-Smtp-Source: AA+uWPx/o4z4oSsmVxdCjrMF+CskXi3F3lAgmN7E9e2Y8NnGuiWySWdSEzUVZA+qHZQaAGAWBMx1mg==
X-Received: by 2002:a2e:21d5:: with SMTP id h82-v6mr5496010lji.46.1533928502202;
        Fri, 10 Aug 2018 12:15:02 -0700 (PDT)
Received: from localhost.localdomain (c-2ec24faa-74736162.cust.telenor.se. [46.194.79.170])
        by smtp.gmail.com with ESMTPSA id d23-v6sm1734931ljg.17.2018.08.10.12.15.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Aug 2018 12:15:00 -0700 (PDT)
From:   Marcus Folkesson <marcus.folkesson@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Marcus Folkesson <marcus.folkesson@gmail.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] iio: dac: max517: avoid using CONFIG_PM_SLEEP
Date:   Fri, 10 Aug 2018 20:51:08 +0200
Message-Id: <20180810185110.12710-1-marcus.folkesson@gmail.com>
X-Mailer: git-send-email 2.11.0.rc2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SIMPLE_DEV_PM_OPS() is already doing this.

Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
---
 drivers/iio/dac/max517.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/dac/max517.c b/drivers/iio/dac/max517.c
index 1d853247a205..451d10e323cf 100644
--- a/drivers/iio/dac/max517.c
+++ b/drivers/iio/dac/max517.c
@@ -113,15 +113,14 @@ static int max517_write_raw(struct iio_dev *indio_dev,
 	return ret;
 }
 
-#ifdef CONFIG_PM_SLEEP
-static int max517_suspend(struct device *dev)
+static int __maybe_unused max517_suspend(struct device *dev)
 {
 	u8 outbuf = COMMAND_PD;
 
 	return i2c_master_send(to_i2c_client(dev), &outbuf, 1);
 }
 
-static int max517_resume(struct device *dev)
+static int __maybe_unused max517_resume(struct device *dev)
 {
 	u8 outbuf = 0;
 
@@ -129,10 +128,6 @@ static int max517_resume(struct device *dev)
 }
 
 static SIMPLE_DEV_PM_OPS(max517_pm_ops, max517_suspend, max517_resume);
-#define MAX517_PM_OPS (&max517_pm_ops)
-#else
-#define MAX517_PM_OPS NULL
-#endif
 
 static const struct iio_info max517_info = {
 	.read_raw = max517_read_raw,
@@ -229,7 +224,7 @@ MODULE_DEVICE_TABLE(i2c, max517_id);
 static struct i2c_driver max517_driver = {
 	.driver = {
 		.name	= MAX517_DRV_NAME,
-		.pm		= MAX517_PM_OPS,
+		.pm	= &max517_pm_ops,
 	},
 	.probe		= max517_probe,
 	.remove		= max517_remove,
-- 
2.11.0.rc2

