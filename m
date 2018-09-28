Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD436C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 00:30:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81E8A215E4
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 00:30:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rM57r7uX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81E8A215E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728672AbeI1GvP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 02:51:15 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:37412 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725924AbeI1GvO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 02:51:14 -0400
Received: by mail-io1-f68.google.com with SMTP id v14-v6so3183939iob.4;
        Thu, 27 Sep 2018 17:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8fYX/tru7SU4upt3mATveHwXLBh2N/bLbdz5+sc27+Q=;
        b=rM57r7uXkp6mUseEzOk4bMojRrSKEmfmb1bEnLl76wUtlzvokCdomZDcBoREyfiGS/
         oo6ozwrJdH6wjJQ4/y0iYTMsMqaOgc/xfL6QZ/Q90riWKjtfbrUf8IlhjnpKELCDHwkn
         /nRrxODUFl3Yq5bRZhgrl6BNw/GwK3gYh7iy9E0zjttFeNeD5TNVJcmAA18WpiIJqqQJ
         ZiBuE85Hk3lECj3HD0H7QEGCfkvuQXAGc9oemaiFURfxk7IKRLoeGG1ramhRWEmTnm5U
         xEAyzful7SFZ+MYIdVQLcPbn+KganA2HgLF0w8+z9izi2UgeA0s+WeBTCfxrBh0qqDEq
         lc9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8fYX/tru7SU4upt3mATveHwXLBh2N/bLbdz5+sc27+Q=;
        b=QMX1JUIYzTmWxIsrMU4nji6d7pR36J4biipwA7zFaqH3WRLwdtjw+nzuWomq6FcEeg
         gksIUe6ov8s7rMt+Z9RE7K1uV3VNhbFqhomMjCTH5bMNWmic63pVYlikdNKJFfDMG2ne
         rAzjML5ehjB/SNVBrgmtCQahMHpqltAlaoZE9bYRpIG33HkD9HVup+4nSkpQYVB88St6
         mECzDPFwVXWv5b1YOW5scDCFhFz/muGXi9iaXfhCZoJWFa24o/OhljGakjHESTWlqEr9
         oMG747OvexI1ufAhMguRkGejlzsbXcBofi0v71spBWdbyjavu1djL5HCH9jPbuW+nHyx
         tURg==
X-Gm-Message-State: ABuFfoh48ovQTzk2oh+7GOf8cTZA3kJJDYMXfpYGrMHNxFJfn8OTblPc
        ieLeAnQnhkyhu+GlzGbtMg==
X-Google-Smtp-Source: ACcGV613h0pOzjIrc1b0bLX0Pbnh3JQz+9kYuuurRtZf63n66iVctN4BPM50OjeG+9ySTT3eIlyp2g==
X-Received: by 2002:a6b:c917:: with SMTP id z23-v6mr10417912iof.297.1538094616421;
        Thu, 27 Sep 2018 17:30:16 -0700 (PDT)
Received: from localhost.localdomain (CPE1cabc0918a93-CM1cabc0918a90.cpe.net.cable.rogers.com. [99.229.26.117])
        by smtp.gmail.com with ESMTPSA id i8-v6sm1355106ioa.6.2018.09.27.17.30.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Sep 2018 17:30:15 -0700 (PDT)
From:   ryang <decatf@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        ryang <decatf@gmail.com>
Subject: [PATCH v4 2/2] iio: light: bh1750: Add device tree support
Date:   Thu, 27 Sep 2018 20:29:58 -0400
Message-Id: <20180928002958.3935-2-decatf@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180928002958.3935-1-decatf@gmail.com>
References: <20180928002958.3935-1-decatf@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device tree support for ROHM BH1750 series ambient light sensors.

Signed-off-by: ryang <decatf@gmail.com>
---
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

