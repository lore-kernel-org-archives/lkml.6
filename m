Return-Path: <SRS0=j7Hi=ME=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37FD4ECE560
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 20:58:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E43C92150F
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 20:58:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DkR/JujG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E43C92150F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728354AbeIWCxo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Sep 2018 22:53:44 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:45490 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727864AbeIWCxm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Sep 2018 22:53:42 -0400
Received: by mail-io1-f66.google.com with SMTP id e12-v6so14950791iok.12;
        Sat, 22 Sep 2018 13:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=IHsv1kVPjHiFN5CDlRUXNfvFEO14wRvjZvBGLfsjNrM=;
        b=DkR/JujGC6QZq7kfnWQQqTt91/Kgjfiu5RXrScIz+dJibGoo53UjxUHicbdKFk5izg
         t03xYzy2NwUX5gbjUD1NYEAqMq/3V1xhpPUSsp/uSOZaWQZ4/cGSYqRtukDA3wh1eziW
         9VX60W3LD9/lGO53Md1wvDVMNehMbB7/HRx1o/lXybX36LbJGtUSizcxU78oIyCtQj5a
         WfjLOwwiXTV1HD6U1cGzTqi/rH0D1jINskphnQQRYB/d0CfB5lo11Oivj6CO22t93RUo
         5YkVwFJcIyvneRY8QC8ut74PsLDYUHhHNi5Y5muP0m65Xi9ogDJyPjDKrutKmhm/uSXp
         7mhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=IHsv1kVPjHiFN5CDlRUXNfvFEO14wRvjZvBGLfsjNrM=;
        b=Z9ZAC45rrYvwNPpW/hOAlLZPNeGtusjjghXJSBLI0V4HsstPYyOB93Mn8zeiSFoW4G
         oQu3PVwh8BZmL0dkZVJ5B4TWoVPCWtzCQUJBnlUIdHqByqt/A1qYQ0Wyjpa8DLlxASqo
         SPfk8A+fnoOgD7kz0KgcBJJLVej9yBlpsBXYpDmg4iytvpIYODotg3xX1gg3fHdKyJaX
         DUGg9MlIybx6A4+owNbh5M6TS83c603GheK0uNS92w6kIyNn1pc7EnyI9ROhOo96pkoT
         qRgfCuBi62avGRoBlh0BuzXuJsmPN5awIrK6wQmDMyloQi5+832mjK5sW3+ncHzKlhPZ
         EGxA==
X-Gm-Message-State: ABuFfoj6m6bjmagfeGxUNZraO8JNrs+JUoLwDCgf83/mEJTlot5lgZL7
        EPE/OMAqFz6x0ilLKI9EGg==
X-Google-Smtp-Source: ACcGV60ImIWGagy29ibxHcRQQYAg3cndP6SHcbTl12kX34RkH3FeINWvyzI00CPhlVXAMjS4eaau6A==
X-Received: by 2002:a6b:c085:: with SMTP id q127-v6mr2896530iof.255.1537649927138;
        Sat, 22 Sep 2018 13:58:47 -0700 (PDT)
Received: from localhost.localdomain (CPE1cabc0918a93-CM1cabc0918a90.cpe.net.cable.rogers.com. [99.229.26.117])
        by smtp.gmail.com with ESMTPSA id k62-v6sm4465306itc.21.2018.09.22.13.58.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 22 Sep 2018 13:58:46 -0700 (PDT)
From:   ryang <decatf@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        ryang <decatf@gmail.com>
Subject: [PATCH v3 2/2] iio: light: bh1750: Add device tree support
Date:   Sat, 22 Sep 2018 16:57:54 -0400
Message-Id: <20180922205754.6100-2-decatf@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180922205754.6100-1-decatf@gmail.com>
References: <20180922205754.6100-1-decatf@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device tree support for ROHM BH1750 series ambient light sensors.

Signed-off-by: ryang <decatf@gmail.com>
---
Changes in v2:
     - Export module device table
Changes in v3:
     - Remove of_match_ptr so that bh1750_of_match is available
       without CONFIG_OF.

 drivers/iio/light/bh1750.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/iio/light/bh1750.c b/drivers/iio/light/bh1750.c
index c3a481452b67..28347df78cff 100644
--- a/drivers/iio/light/bh1750.c
+++ b/drivers/iio/light/bh1750.c
@@ -307,9 +307,20 @@ static const struct i2c_device_id bh1750_id[] = {
 };
 MODULE_DEVICE_TABLE(i2c, bh1750_id);
 
+static const struct of_device_id bh1750_of_match[] = {
+	{ .compatible = "rohm,bh1710", },
+	{ .compatible = "rohm,bh1715", },
+	{ .compatible = "rohm,bh1721", },
+	{ .compatible = "rohm,bh1750", },
+	{ .compatible = "rohm,bh1751", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, bh1750_of_match);
+
 static struct i2c_driver bh1750_driver = {
 	.driver = {
 		.name = "bh1750",
+		.of_match_table = bh1750_of_match,
 		.pm = &bh1750_pm_ops,
 	},
 	.probe = bh1750_probe,
-- 
2.17.1

