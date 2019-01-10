Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 897CFC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 09:26:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51C93206B6
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 09:26:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="xf5ZbMJh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727863AbfAJJ03 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 04:26:29 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:34451 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727780AbfAJJ03 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 04:26:29 -0500
Received: by mail-pg1-f195.google.com with SMTP id j10so4606553pga.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jan 2019 01:26:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=99uW8qSbYlplz1kdDTYJ062EIilv2Ag6Pm0Aw3d5iD0=;
        b=xf5ZbMJhZHBHYvo/cKv8ZfJEWswkteLaLOWcT8gIFGSwRtqdZXZJzGmxoMwMDn7apK
         xCMiZX4UTsFIcBxK8pvd2LH6sfjsKTwQllfycjda69p7Xe1oUMklxCMqR/wJ26I5tZmh
         YicDNtRbFeon6Ab7VJgoVw5ApKfjM8Ej5r7F2YxQ3MSenqOgyMt6B+d3H7m336dKbVUl
         eyuHl70oycpMt5LbNpck3jFchi58RpyI1Fl+WG/f+y8ao8ZaZ8JkwtDGTKtZD/6TuNqa
         JcqpDEooP3EzqukZKgtTq3YxoVRW8c1Por92T+jVkri1fZ1lXa3HgvkeeAbb4RAnlYds
         eSIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=99uW8qSbYlplz1kdDTYJ062EIilv2Ag6Pm0Aw3d5iD0=;
        b=W6Fs4CsAvyDK26GUdqFE1OBMdI8dcB0CQj5fNOvULB0mNBQaDz91m7dqFtq3UZaOK8
         vLTNA6ZaGB0Oq6O7BljD2lvIIBhu/jDrhRZQxlZrZCYaWQk3XODKPCDYXtS7N4IVs91H
         sn1qjS7Z/p8B8wEUmjWMFlUYIQT/SDGO/IeFxREmyVlDpymegIWfPwYdtFiCo+hIMUCQ
         HtxHjH/d4z4WsnC931HsJ0Mh6qfk+DHQgf/XUMAB1KKFHTWaO2kyyYRx/xDE4fkZtv9R
         bxrdXGvVdsoQhC/0MRbGzpsz2nnkZ6f+nhUMpwosXPJ48OEZsy44iPxd9CwY7Vq+nHgm
         8rYw==
X-Gm-Message-State: AJcUukeLlLjwYwEnRIHUHp4CWXagGSvwh7cYjZqop/8QqUNlP+RCKTpc
        1HeZofACzkFYvqHCD/lpqwwrqQ==
X-Google-Smtp-Source: ALg8bN7aogmIhyfYWtxXfdlL1yZYEx74nu53nopuQ6phO0MrJG/MXKPoVVSBWNdVdml8MVHRZZpSGw==
X-Received: by 2002:a63:e302:: with SMTP id f2mr8789421pgh.320.1547112387906;
        Thu, 10 Jan 2019 01:26:27 -0800 (PST)
Received: from localhost.localdomain (36-239-240-185.dynamic-ip.hinet.net. [36.239.240.185])
        by smtp.gmail.com with ESMTPSA id v13sm100615881pff.20.2019.01.10.01.26.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Jan 2019 01:26:26 -0800 (PST)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Wenyou Yang <wenyou.yang@atmel.com>,
        Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] regulator: act8865: Fix act8600_sudcdc_voltage_ranges setting
Date:   Thu, 10 Jan 2019 17:26:16 +0800
Message-Id: <20190110092616.14669-1-axel.lin@ingics.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The act8600_sudcdc_voltage_ranges setting does not match the datasheet.

The problems in below entry:
  REGULATOR_LINEAR_RANGE(19000000, 191, 255, 400000),

1. The off-by-one min_sel causes wrong volatage calculation.
   The min_sel should be 192.
2. According to the datasheet[1] Table 7. (on page 43):
   The selector 248 (0b11111000) ~ 255 (0b11111111) are 41.400V.

Also fix off-by-one for ACT8600_SUDCDC_VOLTAGE_NUM.

[1] https://active-semi.com/wp-content/uploads/ACT8600_Datasheet.pdf

Fixes: df3a950e4e73 ("regulator: act8865: Add act8600 support")
Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
Hi Wenyou and Zubair,
I don't have this h/w for test, so please help to review and test the patch.
Thanks,
Axel

 drivers/regulator/act8865-regulator.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/act8865-regulator.c b/drivers/regulator/act8865-regulator.c
index 21e20483bd91..e0239cf3f56d 100644
--- a/drivers/regulator/act8865-regulator.c
+++ b/drivers/regulator/act8865-regulator.c
@@ -131,7 +131,7 @@
  * ACT8865 voltage number
  */
 #define	ACT8865_VOLTAGE_NUM	64
-#define ACT8600_SUDCDC_VOLTAGE_NUM	255
+#define ACT8600_SUDCDC_VOLTAGE_NUM	256
 
 struct act8865 {
 	struct regmap *regmap;
@@ -222,7 +222,8 @@ static const struct regulator_linear_range act8600_sudcdc_voltage_ranges[] = {
 	REGULATOR_LINEAR_RANGE(3000000, 0, 63, 0),
 	REGULATOR_LINEAR_RANGE(3000000, 64, 159, 100000),
 	REGULATOR_LINEAR_RANGE(12600000, 160, 191, 200000),
-	REGULATOR_LINEAR_RANGE(19000000, 191, 255, 400000),
+	REGULATOR_LINEAR_RANGE(19000000, 192, 247, 400000),
+	REGULATOR_LINEAR_RANGE(41400000, 248, 255, 0),
 };
 
 static struct regulator_ops act8865_ops = {
-- 
2.17.1

