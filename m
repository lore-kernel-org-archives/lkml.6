Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EE2DC43140
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 10:03:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3523E208A1
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 10:03:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h2cw19pO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3523E208A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932883AbeFUKDN (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 06:03:13 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:43330 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932677AbeFUKDK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 06:03:10 -0400
Received: by mail-wr0-f194.google.com with SMTP id d2-v6so2505486wrm.10;
        Thu, 21 Jun 2018 03:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=zvAF20370KRFtU7R5XRl3XItVW+wFe/RfjYVs9MJzfI=;
        b=h2cw19pO2d+Bm4GrJwoT7ZfhdC8EV6+aX2WqNdB01nYKUfcsM70fS4YMjkkVsqb50v
         fTBpGXcHUvrnc+gxAikf4YwKpjVBWDynagY6jKFGpC8lh2SnhGZNntExvprs9uucQjRE
         9rmdIKwLn2rL3M3fhuxPG+fU/WByORqkBhtZH6h+UtLQjAL5TMWA8kpu7wy5lbgCWs51
         wHZmdUTxt0rFBilG9I/S7hydPk/JPFbPgsuk6vnO3gAmim3PRwgohPRsCnugnoM75Q+j
         5FypySm+Gvyuo7q4weo5WTQqPWxfjvvxE8FAm61W385RwlVnBpLOISC7gZ7BZ+5oFO9F
         g43Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=zvAF20370KRFtU7R5XRl3XItVW+wFe/RfjYVs9MJzfI=;
        b=r4kk97np3nh2J0Mtr7y4ITXQEp4JXrx2ZwMEIa3P1bWMsRkiqHsTjLpVRH9pRcFNin
         AlTfnuvn+KPbE+unY77ijdATkFC0+UmEZFZ1fO4spDHGhtgS/YWJGGMLDQVZHnUZn5g+
         8mLxfCNN/XHgpKmOaFsSM8py7WjIu8+59q1ObY8fbAeqhbDRXDoiIfkFUh1NHXX7pc6p
         WzTAAHTzywjbViy5T70LQXVAyiGT66xpO8a2Xny20SCx2ltXP5B/AhU2WuObcK6KjG79
         mnpRSG+c1cYMM3p0UX+fF+euFoHr++aFetah5pSiS04IP34WhQi0qsu/FJOmSqsw031L
         XXaQ==
X-Gm-Message-State: APt69E3AnTrBc7neKvE+d492iuqK/dVbkbHzi1dLBgvmGQLnZbdp2Y8U
        ZP63r+g6wA//Ktgi8RL6iw==
X-Google-Smtp-Source: ADUXVKLSfPUbx5wBq2At60MxNehfiMsmR0uxBcIN9ekfqZ9t3aApq/wAmzVKZ6JXg7lU4NhIc8ejfQ==
X-Received: by 2002:adf:fd05:: with SMTP id e5-v6mr20168969wrr.280.1529575388675;
        Thu, 21 Jun 2018 03:03:08 -0700 (PDT)
Received: from sesnaco ([196.43.135.103])
        by smtp.gmail.com with ESMTPSA id h4-v6sm6840819wre.89.2018.06.21.03.03.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Jun 2018 03:03:08 -0700 (PDT)
Date:   Thu, 21 Jun 2018 13:02:56 +0300
From:   Mawanda Henry <mawandahenrynaco@gmail.com>
To:     mawanda111@gmail.com
Cc:     linux-kernel@vger.kernel.org, wsa@the-dreams.de,
        linux-i2c@vger.kernel.org
Subject: [PATCH] drivers/i2c: include SPDX-license header
Message-ID: <20180621100255.GA5564@sesnaco>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SPDX license headers makes it easy for developers and machines to know
the license that is governing that file

Signed-off-by: Mawanda Henry <mawandahenrynaco@gmail.com>
---
 drivers/i2c/i2c-core-slave.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/i2c/i2c-core-slave.c b/drivers/i2c/i2c-core-slave.c
index 883ca836..fd6a405 100644
--- a/drivers/i2c/i2c-core-slave.c
+++ b/drivers/i2c/i2c-core-slave.c
@@ -1,13 +1,9 @@
-// SPDX-License-Identifier: GPL-2.0
+// SPDX-License-Identifier: GPL-2.0+
 /*
  * Linux I2C core slave support code
  *
  * Copyright (C) 2014 by Wolfram Sang <wsa@sang-engineering.com>
  *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License as published by the Free
- * Software Foundation; either version 2 of the License, or (at your option)
- * any later version.
  */
 
 #include <dt-bindings/i2c/i2c.h>
-- 
2.7.4

