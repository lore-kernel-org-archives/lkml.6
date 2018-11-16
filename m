Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E89B0C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 22:51:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A32162086A
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 22:51:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fhTFvyia"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A32162086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729536AbeKQJFy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 04:05:54 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:39882 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725995AbeKQJFy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 04:05:54 -0500
Received: by mail-pf1-f193.google.com with SMTP id c72so7373819pfc.6;
        Fri, 16 Nov 2018 14:51:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id;
        bh=OwHcst+enILOIrmgfby8FDaIChOrcGZVIxgWGuwQJZI=;
        b=fhTFvyiamH4EGxbnSXyG3JpZ/JBP3STklHfIMitnqr5oTszVyRaxmHSQcCykJvOBqh
         dQGqM7vWiapOwwMcqg993RUvn4gvR4FEP2EupK5fgA9pUWYilizKgPHdyuEFjOnaPSwD
         KdL6Zd6pLKQwYk0eSMZ2wERA5wzf5BA55nEV+Td3vfFrlubPw7tMb+sgoET6SuUCvklB
         iC9ADUjIyA6Y2fn4UQLEixH37m40KQvEKMb5+d1zni2cdr6JCbZUfMw6bvxFHjGg6ca+
         8oJZqhle5ylkC13k3P091wmWQ50c7d55KStG9gSh2d/ZFSFd39TlhwWaEniLHKo1HNkK
         YbQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=OwHcst+enILOIrmgfby8FDaIChOrcGZVIxgWGuwQJZI=;
        b=PJ8O9o3K+qpkWs4zeheXNPnFAUMEAPC3lqRwyzsgxWBL31T8r4Q1X1PuIs7zaqDaVR
         wA9hT5now5uI1sTwPWp17JIsdKjOCYRegPQxxnXVfHuXAp5FdovnSK/ClLhWde087l+1
         88BV+KN1lcWhEoB/cUVt0jqLYpBEvlHsIuT5t5yLZJJnqwoH1QwMpqpT+cUbE2NOUMWj
         DncEzAiY+onWaKIilJpmrsE77tzIkpREUuOBe2MGnWQczGjtwAst7n3AbsiIbzaKFMAc
         Qw/876rTldr/HHZ6Ghw0q+Vvkp8XQAnMTuW9ewhilLsVKrV0OMCBO3lRaF7MXiEpT8+/
         cEdA==
X-Gm-Message-State: AGRZ1gKMHEXzrp9nzde+UW/TqdWOPPjQRItQiiE2DzgUBEYbmoizI07c
        rNgPGJomXVQ8K9FJleMjo/M=
X-Google-Smtp-Source: AJdET5eXpe8zD0VAjobO2dAI69cHXfF4WKLOS1vSatOQXdxpU9T4phi3NMZbDgn80/NuWN4zSjXAKg==
X-Received: by 2002:a63:4e41:: with SMTP id o1mr11889942pgl.282.1542408698201;
        Fri, 16 Nov 2018 14:51:38 -0800 (PST)
Received: from localhost.localdomain ([103.212.140.154])
        by smtp.gmail.com with ESMTPSA id 34sm47407359pgp.90.2018.11.16.14.51.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Nov 2018 14:51:37 -0800 (PST)
From:   Shreeya Patel <shreeya.patel23498@gmail.com>
To:     lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        knaack.h@gmx.de, pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/7] Staging: iio: adt7316: Add an extra check for 'ret' equals to 0
Date:   Sat, 17 Nov 2018 04:21:32 +0530
Message-Id: <20181116225132.24459-1-shreeya.patel23498@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ret = 0 indicates a case of no error but no data read from
the bus which is an invalid case. This case doesn't ever happen
in reality. It should perhaps be handled for correctness though.

Signed-off-by: Shreeya Patel <shreeya.patel23498@gmail.com>
---
 drivers/staging/iio/addac/adt7316-i2c.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/staging/iio/addac/adt7316-i2c.c b/drivers/staging/iio/addac/adt7316-i2c.c
index 856bcfa60c6c..473e5e34ec00 100644
--- a/drivers/staging/iio/addac/adt7316-i2c.c
+++ b/drivers/staging/iio/addac/adt7316-i2c.c
@@ -30,6 +30,10 @@ static int adt7316_i2c_read(void *client, u8 reg, u8 *data)
 	}
 
 	ret = i2c_smbus_read_byte(client);
+
+	if (!ret)
+		return -EIO;
+
 	if (ret < 0) {
 		dev_err(&cl->dev, "I2C read error\n");
 		return ret;
-- 
2.17.1

