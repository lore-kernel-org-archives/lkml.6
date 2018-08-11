Return-Path: <SRS0=t4yP=K2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BE2EC46460
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 09:11:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E374021EF3
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 09:11:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PT0+ZS07"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E374021EF3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727280AbeHKLof (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Aug 2018 07:44:35 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:43737 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727205AbeHKLof (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Aug 2018 07:44:35 -0400
Received: by mail-lj1-f195.google.com with SMTP id r13-v6so8911951ljg.10;
        Sat, 11 Aug 2018 02:11:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=EwupacQb4K3SPBWiDR1+Rm7eobOyYCEn+mlT86BvGHg=;
        b=PT0+ZS07mIQKLoPWzCxz5xaSHSSTC7l0GsJJ+IpJHCjn88vS23emndvCHXXP0yjgl4
         vIhnCDJRwTMqKjGsYgozJOiKZPkv/NtvJ9913wkYHkvqm0nYt6om8j4GnXTLOMEH0oBH
         A4s4kPYj45ktRkVO/hiquPCZafbBFFnmZH+MhS5xSLtJtcNCelaZ3LeqLoIH95gd9YRZ
         ovtqjLjuONzFudpsYRa4dkQnDzbN0McXdX8uDUkGiD0YnPMepRL64FHbWaMiCJwx+5+k
         r6U8LIjV0HOg2Uqwn9HDZtd9YXAjmwJ3zqh1a/jeewFOI67r4Bkrn6suxtujc5hJS0LE
         iu3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=EwupacQb4K3SPBWiDR1+Rm7eobOyYCEn+mlT86BvGHg=;
        b=jaNblASjMJ6AKgnvLbqfdxvj3JQqjP1NVyP/3Cl7z+HjObS6Wky25MWCN+CeWvSLeR
         1JB9zk4Zvi52bKOQOkh9c7DLbFq+fFMrlPSgTS8GKYAoY50muC+Sju7bH148w2LL17aq
         wo95ISmbPea8whW7cHy1UEDHTJ6Z0lejT8Jvv68TeQoru9cB/vnRplSD9uGHu1++plSd
         w/a1JyWUz7dzQ5gzftEF4Qr1S4+bAwjWRxE7oKnLiBBNCPlkEYKNmFHPyIq0/BVROi30
         252KX+ReBZGAcD317MOOlU5r0wLw8vOHdo3r5O6pKwKfLiGgIq9of/kVanZXLTml1oyR
         Tdng==
X-Gm-Message-State: AOUpUlGUl7uquw1Kq3L0UGiRL4HYgmCCH7wi+kSuWJ3vLfrOpMRiE0NK
        ulj9jlMzdyVDLxwsQD4Ff/k=
X-Google-Smtp-Source: AA+uWPztHT1Koat9kXeNFm/mML0T09tIuo9ZyQ5+hoFsx/A62ZHsYfuFNZJlCSw/Xt83L1AKmpB96Q==
X-Received: by 2002:a2e:4557:: with SMTP id s84-v6mr6850110lja.47.1533978660759;
        Sat, 11 Aug 2018 02:11:00 -0700 (PDT)
Received: from localhost.localdomain (c-2ec2e3af-74736162.cust.telenor.se. [46.194.227.175])
        by smtp.gmail.com with ESMTPSA id j140-v6sm2332939lfg.16.2018.08.11.02.10.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 11 Aug 2018 02:10:59 -0700 (PDT)
From:   Marcus Folkesson <marcus.folkesson@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Marcus Folkesson <marcus.folkesson@gmail.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RESEND PATCH] iio: dac: max517: avoid using CONFIG_PM_SLEEP
Date:   Sat, 11 Aug 2018 10:47:09 +0200
Message-Id: <20180811084709.6640-1-marcus.folkesson@gmail.com>
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

