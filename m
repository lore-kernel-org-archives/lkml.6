Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1B1CECE566
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 22:51:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84B322083A
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 22:51:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J25mLYv3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84B322083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387529AbeITEbv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 00:31:51 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:34737 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731471AbeITEbv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 00:31:51 -0400
Received: by mail-lj1-f194.google.com with SMTP id f8-v6so6572065ljk.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Sep 2018 15:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=TNGVV5souHhukOKfQeLzkV9PzOLzU8pgOf/s7Xdccu0=;
        b=J25mLYv3m1wZ5rN7TGwl2gHVN7aLEsLkP8uNqnqcma3DUhPy0LNpvI43btD/iu39Ti
         coPPW7Tk9hATv2wLQqGbX1WoE33CxAx01Swjmw3pXtLFJTzLLBhcEs396DwOlhK1wt7x
         wX7DvyJ0qV9ULHgsIUrOwstUslp5uCPG08uHr6JU4Loz8VEzVvrNW65nELIlTkpTWSTH
         Yy/oub3v8A5X6Sfb1bqmk+OwpJGhPF5Kuod+Hx/rnkhyHq6u1OwZPPp4eVhRb1oIkYai
         ywP9BtqjAshFns8zP8RiDPqvMNhF6w2NtWHriFiLSPWEZT81EdI6YFrrFfxkjeyS0+mD
         INdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=TNGVV5souHhukOKfQeLzkV9PzOLzU8pgOf/s7Xdccu0=;
        b=CFeLG7diKY/z1KObgcRdRTQi0ss7HvY3ZpZ5xwIYI/fRsOhUkX99kflXcnr1ssHlN8
         j+yPfAAs55vohFdhB6NDkMXY+RKFZ4u20BZOaidtbiE7ddKrEhPjhhCw0KA4SbzuDe7I
         x5Vm3omUqlQ/1LOQniRjDWx4E5dwfZr0eYeYke3k/o8/ukBCliHRLvDCz2v3stzVSheK
         hBKUD/9JF0SGIL4JFQLxd1I53Ak2S+VQ4tmjGL72W4iHf3M+vx2B1rhEMsQU6O7dtgof
         op93CS3GlbUyJmq/kxywpOrEo9Yd9b1jz182XCPSTTDJfAh5HXYXawR8RIOdXGjevHu7
         jU+A==
X-Gm-Message-State: APzg51D2tQLCRwkhwNxvx1Yi/y0vMq8PAJ5z2/O5Xdzx3/ulHSlpSucK
        yq34VCGmdWVCB77xg6qdfps=
X-Google-Smtp-Source: ANB0VdZSKK+Sz6r5ZEUOkVwwAOhFnQWHIevs2c5cJEIUJd5EnH4FY+VR/ZSbv6k91dXa+ihCleyrBg==
X-Received: by 2002:a2e:360c:: with SMTP id d12-v6mr23200372lja.88.1537397501642;
        Wed, 19 Sep 2018 15:51:41 -0700 (PDT)
Received: from z50.lan (93-181-165-181.internetia.net.pl. [93.181.165.181])
        by smtp.gmail.com with ESMTPSA id q22-v6sm1249211lff.10.2018.09.19.15.51.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Sep 2018 15:51:41 -0700 (PDT)
From:   Janusz Krzysztofik <jmkrzyszt@gmail.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Boris Brezillon <boris.brezillon@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 1/3] mtd: rawnand: ams-delta: show parent device in sysfs
Date:   Thu, 20 Sep 2018 00:52:53 +0200
Message-Id: <20180919225255.31175-2-jmkrzyszt@gmail.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180919225255.31175-1-jmkrzyszt@gmail.com>
References: <20180820213904.13475-1-jmkrzyszt@gmail.com>
 <20180919225255.31175-1-jmkrzyszt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix a bug where parent device symlinks aren't shown in sysfs.

While at it, make use of the default owner set by mtdcore.

Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Reviewed-by: Boris Brezillon <boris.brezillon@bootlin.com>
---
 drivers/mtd/nand/raw/ams-delta.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/raw/ams-delta.c b/drivers/mtd/nand/raw/ams-delta.c
index a2d2dfc55984..efe12066dfbc 100644
--- a/drivers/mtd/nand/raw/ams-delta.c
+++ b/drivers/mtd/nand/raw/ams-delta.c
@@ -160,7 +160,7 @@ static int ams_delta_init(struct platform_device *pdev)
 	}
 
 	ams_delta_mtd = nand_to_mtd(this);
-	ams_delta_mtd->owner = THIS_MODULE;
+	ams_delta_mtd->dev.parent = &pdev->dev;
 
 	/*
 	 * Don't try to request the memory region from here,
-- 
2.16.4

