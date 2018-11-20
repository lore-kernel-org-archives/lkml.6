Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01F2EC32789
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 16:52:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C233D208E3
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 16:52:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gJguVhw7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C233D208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730252AbeKUDWo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 22:22:44 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:43826 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726557AbeKUDWo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 22:22:44 -0500
Received: by mail-pg1-f195.google.com with SMTP id v28so1140739pgk.10;
        Tue, 20 Nov 2018 08:52:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NA1qthEFQ7/pB53uVIREyL6YfIxumKaRa1YNVVVRolk=;
        b=gJguVhw7fpxjHUNb2bH9a5CrAb8by8pHBriW14mbz2Uoq02/hJ+mISI+KWBNlix4JZ
         2IqRJbwd1cLTIga4pf2T3fv2hCZcMxA7lNElPiO6M9wSlUfmTqK/ymLnVXXMkA4yMfiO
         5n3j/g4o/4qBMyA55iF2Mtsq6cqtLI3uEH4yaML7/eYWZtYPyNJn4hRI8xcxIR22RGzi
         lzYTZ+WsZqkLntzaLn7FHkFvN9unReBD2mdiGExdbyO5EjiE1xGGhb4LYsDUhbbgTPAr
         LrIsp4LQ1k5VYuh49AMBgwDSYM9+vvYQWJYOl60HYSTmmOoptp+bN8MIhHQkAhEiJsfM
         gaxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NA1qthEFQ7/pB53uVIREyL6YfIxumKaRa1YNVVVRolk=;
        b=uTMo666lyTc+wyb1KW7sSd2+bEm5F1lMG374bLeHPjMHG6G2Lvi/HWBUUuBVslEh+8
         CR1bwuXZU2BYXmK/0XkUR6CHIm37L8fPE8/qMPFTaNxprNjpx/yoq+vYjbpo+RU0/C8P
         7t/a+16FyZf+FrytFE8LQiM1LLnNWo4h7ylrepad/8oyG43MH42YD0cxydcnoXsKNynW
         lmXbcVlmY+L7FEH99QWHeMxyrFNTJSUzsSNG7DUBXp9eNR4I54z1Ol3fsc3GkysV4eRR
         ELgDXulmP1icCN/2cK+xsVNqHBdA12xQkJy2PCdZL4FHtSVfg/mC9MntAaXntPAuSzzU
         a+/A==
X-Gm-Message-State: AGRZ1gKejFmlx5t8r/BULiHYzcQYAp9WmtSoc1D62l1vVyEmvSrnMR11
        aoidRl5N2Cp2yII4t9x8A64=
X-Google-Smtp-Source: AJdET5e8Fqdnng6yptrdzlx1ELgZ5XmzowRRYbBBTMw+BYNBS1fmy0JG5up4hmMn8UESKoxGAeb2Ng==
X-Received: by 2002:a62:5e46:: with SMTP id s67-v6mr3060335pfb.122.1542732758124;
        Tue, 20 Nov 2018 08:52:38 -0800 (PST)
Received: from localhost.localdomain ([103.212.140.152])
        by smtp.gmail.com with ESMTPSA id h8sm27048058pgv.27.2018.11.20.08.52.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Nov 2018 08:52:37 -0800 (PST)
From:   Shreeya Patel <shreeya.patel23498@gmail.com>
To:     lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        knaack.h@gmx.de, pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/5] Staging: iio: adt7316: Add of_device_id table
Date:   Tue, 20 Nov 2018 22:22:30 +0530
Message-Id: <20181120165230.7079-1-shreeya.patel23498@gmail.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the kernel starts up, it kicks off compiled-in drivers
that match “compatible” entries it finds in the device tree.
At a later stage (when /lib/modules is available), all kernel modules
that match “compatible” entries in the device tree are loaded.

But if there is no dt table then there should be a fall back path
with which desired kernel modules can be loaded. Hence, add
of_device_id table in the i2c driver to be able to use when there
is no dt table.

Signed-off-by: Shreeya Patel <shreeya.patel23498@gmail.com>
---

Changes in v2:
  - Make the commit message appropriate and assign of_match_table
in the driver structure.

 drivers/staging/iio/addac/adt7316-i2c.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/staging/iio/addac/adt7316-i2c.c b/drivers/staging/iio/addac/adt7316-i2c.c
index 473e5e34ec00..41bc4ca008bc 100644
--- a/drivers/staging/iio/addac/adt7316-i2c.c
+++ b/drivers/staging/iio/addac/adt7316-i2c.c
@@ -126,9 +126,22 @@ static const struct i2c_device_id adt7316_i2c_id[] = {
 
 MODULE_DEVICE_TABLE(i2c, adt7316_i2c_id);
 
+static const struct of_device_id adt7316_of_match[] = {
+	{ .compatible = "adi,adt7316" },
+	{ .compatible = "adi,adt7317" },
+	{ .compatible = "adi,adt7318" },
+	{ .compatible = "adi,adt7516" },
+	{ .compatible = "adi,adt7517" },
+	{ .compatible = "adi,adt7519" },
+	{ },
+};
+
+MODULE_DEVICE_TABLE(of, adt7316_of_match);
+
 static struct i2c_driver adt7316_driver = {
 	.driver = {
 		.name = "adt7316",
+		.of_match_table = adt7316_of_match,
 		.pm = ADT7316_PM_OPS,
 	},
 	.probe = adt7316_i2c_probe,
-- 
2.17.1

