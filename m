Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BEE4ECE560
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 17:42:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D99BD20881
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 17:42:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EgLPgBKI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D99BD20881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727805AbeIOXCU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 19:02:20 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:37034 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727690AbeIOXCU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 19:02:20 -0400
Received: by mail-io1-f65.google.com with SMTP id v14-v6so8473965iob.4;
        Sat, 15 Sep 2018 10:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=l4VD3BspkK8BubwQU6AvhOg5G3OK97wGcnQLkeUe9yw=;
        b=EgLPgBKItRo5xcpExBw/L9+fp84DTPAJ8vz0RMxWn8ll5qPaGHl99k0QQ5IYiPF+5k
         S2JdC5AnKtz3hqaXCRTNDjr5gAbFePKFJ07oU3JAzlP03ye5FqJkPMVLbwyu40IESGC9
         +pBwuH54/YdgjM8rJls+osfxrtHNnZSMVSUMo8mE9YFKX237imzLKnGIuQxryWsIOzeM
         6oHQzCiHNCkfzse+NDDlDap/GQwHbKdAC8/2d61VuS0BTCHulgrMdTeSn+S/2+zQhgxx
         s7VBOTFSyCWg82uX103jImhtbryuo63J7L0WQw8Zl1kPAk19BXaxkAHcRa2CY13dQkWn
         mZIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=l4VD3BspkK8BubwQU6AvhOg5G3OK97wGcnQLkeUe9yw=;
        b=J5KlmCcbhZNkrGiBe3YoG9o/Ir6jzrGoZyYpFWJEx/igClPr22oUAKJ4dE66rEtQLS
         Y1DcyVysgW8AsBONfwhkBpeZtdqaJ0aCqNau7VnWliocsFZDrEThvOc967a9IpRDFjnH
         nctKPB1r1k7N1b8ClJqdWuq/LFIGoX+0tWQ09cevA3b+cQxTOEe10eq0BKSizYe7v73h
         TU2T/bKCv23AFrJOnnpG7ls+qCX8pHD4LuFGRGXHJC5f9pFBox38UaArffdcMW5SlFX0
         elrf8B2pmYgYRR/LUZuhKwkspW7TsfJvwJ08xmdQ6Ye1+vtIA8Zxso34K58Eo2lI8Or9
         9HzA==
X-Gm-Message-State: APzg51Bxo+gUekqyNwUxsXiqLYFaZn2FqcdhtLW6SK2Cj/BfWZQuMnxH
        nyDMrQGYMGYP+0nBHsvdog==
X-Google-Smtp-Source: ANB0VdYaTs4fREPJyNayWVyJ+i9XJaenV/5m7VKl5+1+7F1fiEnW50Ba7XgX2Awl1lqtfFWFkbV8Lw==
X-Received: by 2002:a6b:f316:: with SMTP id m22-v6mr14143374ioh.271.1537033354312;
        Sat, 15 Sep 2018 10:42:34 -0700 (PDT)
Received: from localhost.localdomain (CPE1cabc0918a93-CM1cabc0918a90.cpe.net.cable.rogers.com. [99.229.26.117])
        by smtp.gmail.com with ESMTPSA id t187-v6sm1150250ita.28.2018.09.15.10.42.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 15 Sep 2018 10:42:33 -0700 (PDT)
From:   ryang <decatf@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        ryang <decatf@gmail.com>
Subject: [PATCH 2/2] iio: light: bh1750: Add device tree support
Date:   Sat, 15 Sep 2018 13:42:14 -0400
Message-Id: <387c145949692c0318f90d98426be95c82ea2e58.1537033044.git.decatf@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <c414a26cdc176d9982f3c609fa39cf245ac939be.1537033044.git.decatf@gmail.com>
References: <c414a26cdc176d9982f3c609fa39cf245ac939be.1537033044.git.decatf@gmail.com>
In-Reply-To: <c414a26cdc176d9982f3c609fa39cf245ac939be.1537033044.git.decatf@gmail.com>
References: <c414a26cdc176d9982f3c609fa39cf245ac939be.1537033044.git.decatf@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device tree support for ROHM BH1750 series ambient light sensors.

Signed-off-by: ryang <decatf@gmail.com>
---
 drivers/iio/light/bh1750.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/iio/light/bh1750.c b/drivers/iio/light/bh1750.c
index a814828e69f5..50b599abb383 100644
--- a/drivers/iio/light/bh1750.c
+++ b/drivers/iio/light/bh1750.c
@@ -315,9 +315,19 @@ static const struct i2c_device_id bh1750_id[] = {
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
+
 static struct i2c_driver bh1750_driver = {
 	.driver = {
 		.name = "bh1750",
+		.of_match_table = of_match_ptr(bh1750_of_match),
 		.pm = BH1750_PM_OPS,
 	},
 	.probe = bh1750_probe,
-- 
2.17.1

