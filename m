Return-Path: <SRS0=j7Hi=ME=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55AEAC433F4
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 19:59:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09B272150F
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 19:59:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NbnibF8i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09B272150F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728189AbeIWByV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Sep 2018 21:54:21 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:33253 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726791AbeIWByU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Sep 2018 21:54:20 -0400
Received: by mail-io1-f68.google.com with SMTP id l25-v6so1826004ioj.0;
        Sat, 22 Sep 2018 12:59:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VbrvP1uNTuDknwrXIilfCxny03oQS5m2jQLCjO29mbI=;
        b=NbnibF8i1bCKCMzn2+sbgoOeVUotm709aaSDmvUsBBp3QK/vduoCUSUxvnTn/cd3Lu
         mOMbrVHgoMCIWZxjQoDGDqHIV1OdeQVzabIeRAteeidXoXkrqjB8yuIWCItzLUTWSt+Y
         IFDqfyHkOVI8ldqMDCMBPWkzL4zn/sDIt68kQsPv3iN6WbXdqPx7PgtYA7YkLZ7v0BdI
         idki9xH8oVE47arqdUpCJI0sUAO4rlHB0U56zPYEHvM9gIzMEy4mqH2GGSjQTw1QYOkk
         WoJmX45OaL/eAW8KuQC54WLRyq1sAHBveIjg19v6vY9v53fq4pMr+H0IF2DWYuuTryEe
         Op6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=VbrvP1uNTuDknwrXIilfCxny03oQS5m2jQLCjO29mbI=;
        b=JJFMB38yxc9cdY+sZIfaM3fzueY8SF6JRQ5na7XVJgPjR0sxJVnNuFUd5b7M8lLCmO
         iZDxnG8sIDqteDI0xYirwqZHoyZNftEKjhJ2EFyApZne+MhtS/we65ctyXuknDvwZAzq
         ln0vfhcKdbtdwZ8fx+L18EuP40ac7crc9Uz39Dsg4rd1gh0tgFnmOt0xmasPR6MRWGdr
         tjry5JtOkfrqQIN97MEPFre9pnVuySTW0kyyhhRSZz7Ax9Vybilh+8rRFd07zbRoX+Xh
         8UmTCdjF65l6AiVlkpZcsnmlKj6dd0TOn599mPh79ms0TDCuQZSLLQoW/4WB5ETT6VdV
         HHHg==
X-Gm-Message-State: ABuFfogBHlXONo6qww5Se3RuoeG4RBJeOB9IgeE0dak0fRFegFsn+CIK
        TfTV2nY/iwzBS+YsSNcyzg==
X-Google-Smtp-Source: ACcGV63E6/zPlHalaUlfnsLtJO+s8HgbKpGMq8V/65Aw4q2TbBN/U7Qp/dVpfMistvHi0c6cSuCoMQ==
X-Received: by 2002:a6b:1842:: with SMTP id 63-v6mr2203279ioy.40.1537646375202;
        Sat, 22 Sep 2018 12:59:35 -0700 (PDT)
Received: from localhost.localdomain (CPE1cabc0918a93-CM1cabc0918a90.cpe.net.cable.rogers.com. [99.229.26.117])
        by smtp.gmail.com with ESMTPSA id h66-v6sm1095021ita.22.2018.09.22.12.59.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 22 Sep 2018 12:59:34 -0700 (PDT)
From:   ryang <decatf@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        ryang <decatf@gmail.com>
Subject: [PATCH v2 2/2] iio: light: bh1750: Add device tree support
Date:   Sat, 22 Sep 2018 15:59:22 -0400
Message-Id: <20180922195922.24791-2-decatf@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180922195922.24791-1-decatf@gmail.com>
References: <20180922195922.24791-1-decatf@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device tree support for ROHM BH1750 series ambient light sensors.

Signed-off-by: ryang <decatf@gmail.com>
---
Changes in v2:
     - Export module device table

 drivers/iio/light/bh1750.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/iio/light/bh1750.c b/drivers/iio/light/bh1750.c
index c3a481452b67..ffe2e6d9c2e4 100644
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
+		.of_match_table = of_match_ptr(bh1750_of_match),
 		.pm = &bh1750_pm_ops,
 	},
 	.probe = bh1750_probe,
-- 
2.17.1

