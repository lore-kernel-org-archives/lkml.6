Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27B64C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 22:55:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFC792086A
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 22:55:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wwm/jcIp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFC792086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730291AbeKQJKA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 04:10:00 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:32779 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725819AbeKQJJ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 04:09:59 -0500
Received: by mail-pf1-f195.google.com with SMTP id v68-v6so12073332pfk.0;
        Fri, 16 Nov 2018 14:55:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ScFtGBrlajRSaqOZKDSi+ZNN1qxF/nK+tAQqaxfHfNw=;
        b=Wwm/jcIphCQaNwfGsoFjT9lOWd8mFqBLZm5Aai14EP89GfRdmJn1BXs1lC7Z/Hisc1
         tUEPr9inAp3cM77mriqGB1Dn1CyPuwAiY2Rm63Ce62gzGsoJRbhvncg7hgAtysfwBmIy
         OzMvRTqz55CLXrY/aHvqGn0tXDZxFBXTjjS8/wYNkd1ZOqhg5gCFlZppimf61y3VbSss
         nnDPwsp07ntCu7I9sgx2loUgWe/b8CX/ErYjZlyk2rPwz3nF0f6MvVdv8GpNKoRknVeT
         X8Ke+b0P2AdCCtkyrDstQXTVS2aWYw8GjMGSdp/+Tj7U2bytZF25GF3ThFpS0tOBDTkd
         OgOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ScFtGBrlajRSaqOZKDSi+ZNN1qxF/nK+tAQqaxfHfNw=;
        b=P8QEdP9FTq3XcdKHcpxlHYNENH5D7swBYDUvFcx085K1ftLw+/n72QodeO14zypO4m
         UbGf4XSdpr91bfwLIw+6XGqT7K34kcNCSJrqzbLZUV2lBPJUaFLDpNUlDihzShu1ataT
         cVx6socU+xqtnefuSQgx7FZKxa4JzdlCGNCQrbJ3eg2LPSKdc4Pn4sMxIw3bR7HI/G3l
         z8MFvRz1/nKn9bEizQqSRXa0HZhUd+MrXBWleb5rh6NBVbBgXi3eAnUofcfkqYIECWa8
         prTgQgLZQ7VZnLcVrDJjcVkAXvY+6ympCDYzvNRSlmDhFA4ZOfDSHBw5jGfjD7O2EsGj
         /JiA==
X-Gm-Message-State: AGRZ1gJxdZ3pED0MSbyjS6Q/kMSEq2bw9/NZAUp46PRAdLF6aJx9HYQG
        gRbd16C/0uDr+jICOD0xjZ4=
X-Google-Smtp-Source: AJdET5cOgpOTr3kIxCvdlgh0MIwUlv3dxdxNTcthdlCOfD2CKVjqaGU+rZGQHVF81Cyn/QZWErchTQ==
X-Received: by 2002:a62:7504:: with SMTP id q4mr12828805pfc.180.1542408943102;
        Fri, 16 Nov 2018 14:55:43 -0800 (PST)
Received: from localhost.localdomain ([103.212.140.154])
        by smtp.gmail.com with ESMTPSA id u19-v6sm35754093pfh.153.2018.11.16.14.55.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Nov 2018 14:55:42 -0800 (PST)
From:   Shreeya Patel <shreeya.patel23498@gmail.com>
To:     lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        knaack.h@gmx.de, pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/7] Staging: iio: adt7316: Add of_device_id table
Date:   Sat, 17 Nov 2018 04:25:37 +0530
Message-Id: <20181116225537.24723-1-shreeya.patel23498@gmail.com>
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
Hence to be able to use device tree for ADT7316, add of_device_id
table which specifies the supported devices through compatible
property.
Note that there is a fall back path in i2c that will result
in i2c_device_id table being used if there is no of_devcie_id table.

Signed-off-by: Shreeya Patel <shreeya.patel23498@gmail.com>
---
 drivers/staging/iio/addac/adt7316-i2c.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/staging/iio/addac/adt7316-i2c.c b/drivers/staging/iio/addac/adt7316-i2c.c
index 473e5e34ec00..d4b5060c18ee 100644
--- a/drivers/staging/iio/addac/adt7316-i2c.c
+++ b/drivers/staging/iio/addac/adt7316-i2c.c
@@ -126,6 +126,18 @@ static const struct i2c_device_id adt7316_i2c_id[] = {
 
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
-- 
2.17.1

