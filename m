Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7C7BC67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 08:01:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DC7F20862
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 08:01:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nhzD9d4a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DC7F20862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729897AbeG0JWj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 05:22:39 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:35672 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726034AbeG0JWi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 05:22:38 -0400
Received: by mail-pl0-f65.google.com with SMTP id w3-v6so1987464plq.2;
        Fri, 27 Jul 2018 01:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=EI69yLVdDj7UAZOqlO5OAY+ggiLk3XFjCLFwcvq8HrY=;
        b=nhzD9d4ahxI4Wfy1xADj1WbCJes4JeyYm6hPyhtS06xMZOf0eCC2obWOKXqJxiRd8V
         A+eWjzvT5atwAHkEBkL6cE1TCycwfuwygJ2dzcCZhnkvhzMby7GnvfjQb1HsmWFu63QB
         oqqtcu3hBrpjJEH2WlfoZE21wMNz3i1rUygJ1H3mnVsoZBDqV1OIPInK1H7aHFxHyefa
         ioJ83pxWIHKjnPtsXhe8Ywg5IEkvcCSWsgRXHhWmcDpuVTiRpAEUrFji4O1KrU7/n/B5
         pVySalFiqVEcOKYPPCOTnDOhrWvMS68ShHWRaWOvzA5wcj+6sbySG7XG5WyhYnMZOmFQ
         3ysw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=EI69yLVdDj7UAZOqlO5OAY+ggiLk3XFjCLFwcvq8HrY=;
        b=eh9Z/jpuU4+EQ7dC8rlsEkoMUBnWO9/uefkXTZzdWiH9snbYCwFlmdJNe3CnnNUgsL
         OoZdzvnzYLHU3YY4kOabte6uKEBWd7sszJ/zUdm+70X2h5X3HNpxOreHIrQqiXp+zWbQ
         R63UpN6pJUUxKwhWLeoZFrPz1PXAUyWIqtoZYhN53KZpzdYvUL/P4nl8SUJT919kYM4O
         Hf1Yhl1SA7oRWJ2sn2Ks2Xa/tbfIdSsQJjE3KlioWTjj99UhNOQqVqB57TB04CG8WGGE
         FJZHImf02haX/AgGbCb35lAMjYLOTi+wb1xf/EB4fgyDOX+ojYsPXrDb/VWJGTBVKja9
         HXnQ==
X-Gm-Message-State: AOUpUlEHgRVhG3m9u8AuzGCWIQOkOrKpj0hMk4Z1HS5i+y8B9l8lckJI
        a0U7fQmZZuE932KMK1R0xtI=
X-Google-Smtp-Source: AAOMgpfhEKMuPZPoRqMBmuy56Mir6BN9lNfURRYzROqySHBHquC46dNUfW46+Vok6NUjtDdYgtXrSg==
X-Received: by 2002:a17:902:26c:: with SMTP id 99-v6mr4915982plc.341.1532678516831;
        Fri, 27 Jul 2018 01:01:56 -0700 (PDT)
Received: from localhost.localdomain ([2402:f000:1:4414:6c14:7712:e625:1be4])
        by smtp.gmail.com with ESMTPSA id m20-v6sm5927595pfg.61.2018.07.27.01.01.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Jul 2018 01:01:56 -0700 (PDT)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
To:     yisen.zhuang@huawei.com, salil.mehta@huawei.com,
        davem@davemloft.net, linyunsheng@huawei.com, joe@perches.com,
        pombredanne@nexb.com, bianpan2016@163.com, shenjian15@huawei.com,
        keescook@chromium.org
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] net: hisilicon: hns: Replace mdelay() with msleep()
Date:   Fri, 27 Jul 2018 16:01:41 +0800
Message-Id: <20180727080141.3079-1-baijiaju1990@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hns_ppe_common_init_hw() and hns_xgmac_init() are never 
called in atomic context.
They call mdelay() to busily wait, which is not necessary.
mdelay() can be replaced with msleep().

This is found by a static analysis tool named DCNS written by myself.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_ppe.c   | 4 ++--
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_xgmac.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_ppe.c b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_ppe.c
index 93e71e27401b..866e4cec423d 100644
--- a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_ppe.c
+++ b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_ppe.c
@@ -203,9 +203,9 @@ static int hns_ppe_common_init_hw(struct ppe_common_cb *ppe_common)
 	enum dsaf_mode dsaf_mode = dsaf_dev->dsaf_mode;
 
 	dsaf_dev->misc_op->ppe_comm_srst(dsaf_dev, 0);
-	mdelay(100);
+	msleep(100);
 	dsaf_dev->misc_op->ppe_comm_srst(dsaf_dev, 1);
-	mdelay(100);
+	msleep(100);
 
 	if (ppe_common->ppe_mode == PPE_COMMON_MODE_SERVICE) {
 		switch (dsaf_mode) {
diff --git a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_xgmac.c b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_xgmac.c
index 51e7e9f5af49..fbccd1fd94b0 100644
--- a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_xgmac.c
+++ b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_xgmac.c
@@ -215,10 +215,10 @@ static void hns_xgmac_init(void *mac_drv)
 	u32 port = drv->mac_id;
 
 	dsaf_dev->misc_op->xge_srst(dsaf_dev, port, 0);
-	mdelay(100);
+	msleep(100);
 	dsaf_dev->misc_op->xge_srst(dsaf_dev, port, 1);
 
-	mdelay(100);
+	msleep(100);
 	hns_xgmac_lf_rf_control_init(drv);
 	hns_xgmac_exc_irq_en(drv, 0);
 
-- 
2.17.0

