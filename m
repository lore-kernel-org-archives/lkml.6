Return-Path: <SRS0=rRkv=PA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8BE0C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 04:58:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92675218D3
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 04:58:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F+eGxTGy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726630AbeLWE6Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Dec 2018 23:58:24 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:39436 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725267AbeLWE6X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Dec 2018 23:58:23 -0500
Received: by mail-it1-f196.google.com with SMTP id a6so11936428itl.4;
        Sat, 22 Dec 2018 20:58:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BJl9JvtqFLFxHkxk96iUyl94VYQgxphAIRNyaBqFMK8=;
        b=F+eGxTGyi9pFc+XPnyWe37XRKfKBjZ8DZcz/oQXbL+mvtW4LyywBn2nCjiU6wq+7cC
         2Xz51Y1aW2H73+ey3lvrFX4CfEtuT4SJKmnWptxU0Xi0vtFVB0KFY/n9pqkqCpEAk4RY
         lgC1iRYlIL+zjZShfMTvWR3br2h3coeO5orJ7zECSlLkySAkIlLgwvu7ANJWo0U9NLsO
         veFTUwglelhIy+z1B2L0StgWJ2ePYcSG5VGyHuqBQyGRrEkgh4nYzcbmVd4ArOtRD7PK
         1qw47i+l6Pj/80NzdbUc43Zu2BuPXDd4YlW+vZWGCQb6fW7bmBDmuYantkFxSoSg7eoL
         5IaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BJl9JvtqFLFxHkxk96iUyl94VYQgxphAIRNyaBqFMK8=;
        b=ZvqdxqEQW8N9TMXUi0IhcfH/sbxV24nVVITbrGKGXwo6pcJ0bw0Yb0yMa6rCKksku5
         e6b4HCvMR+2jyr0pXHEkpEY315ZQqfVNNAqgIcMbbvuUDN3V9wSyxTYw71wIP/XCqxvZ
         GZKt4ye5BhCEZyoDZiTXz23cTfjqD+pTtMAwaM1Y4XkDncfh5ZY7L9vTn8btggCqk14h
         6vIbxfF5wcjh2grlpRJGTl8Vde0zOQG6FDyu+1DAaVzdsUyxVwcss+ss2iuBE4CQ+Yfe
         dbkDLEkth7+hSmzDySpkuArPQxaymm99mIxSh7HHRRrrSEQMJj9+CKa8yZywxq/nNIPF
         Vn7A==
X-Gm-Message-State: AA+aEWYgGKEedhhQ0/m318Fqxg6MijqtCMuHjEStfW5astgcjysLUYKe
        2kOK+Ov34FJxTVQ87pb3idU=
X-Google-Smtp-Source: AFSGD/WhRN+X/4F1xgy3h+4+bGM8wDiZrVZpw06JUYMTAzTRB2kjeJHl2e6sTuhKhi23A+bmSj2Fnw==
X-Received: by 2002:a02:8244:: with SMTP id q4mr5615297jag.43.1545541102709;
        Sat, 22 Dec 2018 20:58:22 -0800 (PST)
Received: from r2700x.localdomain (c-75-70-96-103.hsd1.co.comcast.net. [75.70.96.103])
        by smtp.gmail.com with ESMTPSA id 15sm8435378itv.11.2018.12.22.20.58.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 22 Dec 2018 20:58:22 -0800 (PST)
From:   Jeremy Fertic <jeremyfertic@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Jeremy Fertic <jeremyfertic@gmail.com>
Subject: [PATCH v2 1/4] staging: iio: adt7316: fix dac_bits assignment
Date:   Sat, 22 Dec 2018 21:57:40 -0700
Message-Id: <20181223045743.10716-2-jeremyfertic@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181223045743.10716-1-jeremyfertic@gmail.com>
References: <20181223045743.10716-1-jeremyfertic@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The value of dac_bits is used in adt7316_show_DAC() and adt7316_store_DAC(),
and it should be either 8, 10, or 12 bits depending on the device in use. The
driver currently only assigns a value to dac_bits in
adt7316_store_da_high_resolution(). The purpose of the dac high resolution
option is not to change dac resolution for normal operation. Instead, it
is specific to an optional feature where one or two of the four dacs can
be set to output voltage proportional to temperature. If the user chooses
to set dac a and/or dac b to output voltage proportional to temperature,
the da_high_resolution attribute can optionally be enabled to use 10 bit
resolution rather than the default 8 bits. This is only available on the
10 and 12 bit dac devices. If the user attempts to read or write dacs a
or b under these settings, the driver's current behaviour is to return an
error. Dacs c and d continue to operate normally under these conditions.
With the above in mind, remove the dac_bits assignments from this function
since the value of dac_bits as used in the driver is not dependent on this
dac high resolution option.

Since the dac_bits assignments discussed above are currently the only ones
in this driver, the default value of dac_bits is 0. This results in incorrect
calculations when the dacs are read or written in adt7316_show_DAC() and
adt7316_store_DAC(). To correct this, assign a value to dac_bits in
adt7316_probe() to ensure correct operation as soon as the device is
registered and available to userspace.

Fixes: 35f6b6b86ede ("staging: iio: new ADT7316/7/8 and ADT7516/7/9 driver")
Signed-off-by: Jeremy Fertic <jeremyfertic@gmail.com>
---
 drivers/staging/iio/addac/adt7316.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/iio/addac/adt7316.c b/drivers/staging/iio/addac/adt7316.c
index 9db49aa186bb..e17c1cb12c94 100644
--- a/drivers/staging/iio/addac/adt7316.c
+++ b/drivers/staging/iio/addac/adt7316.c
@@ -652,17 +652,10 @@ static ssize_t adt7316_store_da_high_resolution(struct device *dev,
 	u8 config3;
 	int ret;
 
-	chip->dac_bits = 8;
-
-	if (buf[0] == '1') {
+	if (buf[0] == '1')
 		config3 = chip->config3 | ADT7316_DA_HIGH_RESOLUTION;
-		if (chip->id == ID_ADT7316 || chip->id == ID_ADT7516)
-			chip->dac_bits = 12;
-		else if (chip->id == ID_ADT7317 || chip->id == ID_ADT7517)
-			chip->dac_bits = 10;
-	} else {
+	else
 		config3 = chip->config3 & (~ADT7316_DA_HIGH_RESOLUTION);
-	}
 
 	ret = chip->bus.write(chip->bus.client, ADT7316_CONFIG3, config3);
 	if (ret)
@@ -2145,6 +2138,13 @@ int adt7316_probe(struct device *dev, struct adt7316_bus *bus,
 	else
 		return -ENODEV;
 
+	if (chip->id == ID_ADT7316 || chip->id == ID_ADT7516)
+		chip->dac_bits = 12;
+	else if (chip->id == ID_ADT7317 || chip->id == ID_ADT7517)
+		chip->dac_bits = 10;
+	else
+		chip->dac_bits = 8;
+
 	chip->ldac_pin = devm_gpiod_get_optional(dev, "adi,ldac", GPIOD_OUT_LOW);
 	if (IS_ERR(chip->ldac_pin)) {
 		ret = PTR_ERR(chip->ldac_pin);
-- 
2.19.1

