Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18B4DC43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 07:33:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0EA720878
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 07:32:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iFXlWKSu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0EA720878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727355AbeJBOOZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 10:14:25 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:37011 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727261AbeJBOOX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 10:14:23 -0400
Received: by mail-lj1-f193.google.com with SMTP id 63-v6so830691ljs.4;
        Tue, 02 Oct 2018 00:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kLCREbleYStu1XkmLup2nB4ZT0oPHzqGd5NP0nf22A8=;
        b=iFXlWKSuoLOy3dc/baIRkMk/768TAlHmLhlm8TgnJgBkORhu20VvZ/mGB56VGBKreP
         1aSIM0QuO3gTA2wQFrcr3XaLyIHrXvjgk3ouevcneGyDlw0HuuR5TTPx2GN9vbt2Qnxl
         pPlItqEuKfoH1EZE08FerEjc4t4l1CBXcHfgASMJmML3GrcAR98LBOziMRUS1QzOyjuJ
         EvrzShOR6N6EOiXug+N511i8Ypr95NMDKCyBCsyoXu/2/qKo24XULYp+bQ7IVbP2aTJ/
         aTdlnDGTLWEjLGph0FoIU4UP7r4YK/qjEQLQmKEy9F1KQ4mm0G4yxDZk3q9amgrNN4he
         PAqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kLCREbleYStu1XkmLup2nB4ZT0oPHzqGd5NP0nf22A8=;
        b=EanWG17+DWq+jZqYa2hmK7UV6/Cy8mHAEXPXx9K9New/iVRi6koH5KJZ8JY9sDtAFV
         cdudaen8Ye5WttsIuxqpUHPWwZR/eQjVzQZ+GdWB2sEqxba5TTBrdFJ9HLcKMJZ2YUYL
         9mqrkkEKUlnfdWA+YX5OlTOVatXJTL/1WhV0QgvQMzabyUtwsJEccnWEuhK5RGf1K667
         nJJ/8qoFicGO5bHx5Z6I4uYSh7OD/IxOALvEQXK3fxTTEtn63Fn4mQChw5Phq81kJoWe
         o6HHiqllFrVfdH48c9Wc8mi2AP+mbZDnivCWFr+6x+7LPPLd9qzcggoWKOcMQIDt9I2f
         ZrdA==
X-Gm-Message-State: ABuFfoiZlInTd/nrasfHbwSyeJs7xJMLcd0ZlGPkYlnj6x+AE/hng1D8
        zW5e2cWNfvhyKdU7nQWc2vM=
X-Google-Smtp-Source: ACcGV616E8x/SfKAEKURiBmDmj91BRDbHJffJv+axTqlGK1MXtYVBq7rTXfb2/mTRRKSkDiOEA+G5Q==
X-Received: by 2002:a2e:2b08:: with SMTP id q8-v6mr8724236lje.128.1538465550138;
        Tue, 02 Oct 2018 00:32:30 -0700 (PDT)
Received: from neopili.qtec.com (cpe.xe-3-0-1-778.vbrnqe10.dk.customer.tdc.net. [80.197.57.18])
        by smtp.gmail.com with ESMTPSA id d17-v6sm1242246lfj.9.2018.10.02.00.32.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Oct 2018 00:32:28 -0700 (PDT)
From:   Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
To:     Pavel Machek <pavel@ucw.cz>, Sakari Ailus <sakari.ailus@iki.fi>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: [PATCH v5 4/6] [media] ad5820: Add support for of-autoload
Date:   Tue,  2 Oct 2018 09:32:20 +0200
Message-Id: <20181002073222.11368-4-ricardo.ribalda@gmail.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181002073222.11368-1-ricardo.ribalda@gmail.com>
References: <20181002073222.11368-1-ricardo.ribalda@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since kernel 4.16, i2c devices with DT compatible tag are modprobed
using their DT modalias.
Without this patch, if this driver is build as module it would never
be autoprobed.

There is no need to mask it with CONFIG_OF to allow ACPI loading, this
also builds find with CONFIG_OF=n.

Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Acked-by: Pavel Machek <pavel@ucw.cz>
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 drivers/media/i2c/ad5820.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/media/i2c/ad5820.c b/drivers/media/i2c/ad5820.c
index 97eb05e65833..4ae4e6a776fd 100644
--- a/drivers/media/i2c/ad5820.c
+++ b/drivers/media/i2c/ad5820.c
@@ -372,12 +372,19 @@ static const struct i2c_device_id ad5820_id_table[] = {
 };
 MODULE_DEVICE_TABLE(i2c, ad5820_id_table);
 
+static const struct of_device_id ad5820_of_table[] = {
+	{ .compatible = "adi,ad5820" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, ad5820_of_table);
+
 static SIMPLE_DEV_PM_OPS(ad5820_pm, ad5820_suspend, ad5820_resume);
 
 static struct i2c_driver ad5820_i2c_driver = {
 	.driver		= {
 		.name	= AD5820_NAME,
 		.pm	= &ad5820_pm,
+		.of_match_table = ad5820_of_table,
 	},
 	.probe		= ad5820_probe,
 	.remove		= ad5820_remove,
-- 
2.19.0

