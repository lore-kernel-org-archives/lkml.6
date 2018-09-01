Return-Path: <SRS0=kg8+=LP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B221EC433F4
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 11:40:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DDC42083F
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 11:40:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QFClXFjK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DDC42083F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727271AbeIAPvl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Sep 2018 11:51:41 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:36231 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726430AbeIAPvl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Sep 2018 11:51:41 -0400
Received: by mail-pf1-f194.google.com with SMTP id b11-v6so6688751pfo.3;
        Sat, 01 Sep 2018 04:39:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=mi+hw9mk3Z/J7/fU0plW5Uvm7iOTyHvlmITO5aQv+dI=;
        b=QFClXFjK50mb9brs7BGgPn11x8BzE/Jd/mhmKaEY9UWUXk4dCAnnWUrRKK9zEItZ28
         0X8ZeA7yvK3JrC/tDNMivMad82is16xhvVG3JRin/nIQrbELN/A3zDsH/Rs4ZVdX/mpz
         bXyCS5Xy08pSJ9PH8dvSl6noucsWIEvnFc4wqMTUby5avmmkqDMYeJecHGs+oDLK65aq
         6uKRkHZdYB2VJLKbGWzjKNbOa1Ae/MxZ1UEAMmlkeJ/k8sDomoedZrqMoZUiuf9HYpQI
         FCALpoVt0n+hfc1fkdzzmC6cfG8ndETBg0oZ3F/lDvwiI2QgK/jBa8vFRX/dA88Ws1P6
         NP6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=mi+hw9mk3Z/J7/fU0plW5Uvm7iOTyHvlmITO5aQv+dI=;
        b=et0JmCT7RGh66TCB6wajyR7m/ATib4zcbmwtA2y2RQATrFpmRdxLlv8rc73nykSrIQ
         0jXMxO3iUsHLlo/mhFimqLCMB1UHa1SDnff2fEsX9ZbOgDsNBZv/N5H8jp9VJ9TvZyq5
         h01RRloovzSVjlcFdoljPsSDJDriJZ9CBrGo78AtHGJ8iO7BZ+x5AaUR9Q5wU5D2ev+7
         kPCzsnKAMI6xLC2eSCJnEOJ59srHIwHTPaOLUwtJwxvDRWW44JjXZL7w9SxiB3+iNh8E
         /ZhC97ztklLftOfcse15hOPhHjlVtSUJ5PckNVrDD9IV0PIATH+rPJuA9wMBgmwT7Rm8
         aW/g==
X-Gm-Message-State: APzg51DoFkNjaQ0HO7VHs0i8V4eR+avSNzyDnxRzchnV5BETqD4RnfAi
        yVPinkZhzTH7WsoX06tNzGttwArz
X-Google-Smtp-Source: ANB0VdZ7Jhf9trd5uSsNFOoD6zZnAZsnGuEzCyi+WlXjVLeokQ9w4NYWBiAiDEeNLArYAawreY9v6A==
X-Received: by 2002:a65:6086:: with SMTP id t6-v6mr3604257pgu.424.1535801997449;
        Sat, 01 Sep 2018 04:39:57 -0700 (PDT)
Received: from localhost.localdomain ([2402:f000:1:4414:2913:cd09:aee0:380])
        by smtp.gmail.com with ESMTPSA id c78-v6sm21586620pfc.188.2018.09.01.04.39.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 01 Sep 2018 04:39:57 -0700 (PDT)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
To:     oulijun@huawei.com, xavier.huwei@huawei.com, dledford@redhat.com,
        jgg@ziepe.ca
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] infiniband: hw: hns: Fix a sleep-in-atomic-context bug in hns_roce_set_hem()
Date:   Sat,  1 Sep 2018 19:39:48 +0800
Message-Id: <20180901113948.28967-1-baijiaju1990@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver may sleep with holding a spinlock.

The function call paths (from bottom to top) in Linux-4.16 are:

drivers/infiniband/hw/hns/hns_roce_hem.c, 345: 
	msleep in hns_roce_set_hem
drivers/infiniband/hw/hns/hns_roce_hem.c, 330: 
	_raw_spin_lock_irqsave in hns_roce_set_hem

To fix this bug, msleep() is replaced with mdelay().

This bug is found by my static analysis tool DSAC.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/infiniband/hw/hns/hns_roce_hem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hem.c b/drivers/infiniband/hw/hns/hns_roce_hem.c
index 63b5b3edabcb..8c142676c589 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hem.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hem.c
@@ -342,7 +342,7 @@ static int hns_roce_set_hem(struct hns_roce_dev *hr_dev,
 			} else {
 				break;
 			}
-			msleep(HW_SYNC_SLEEP_TIME_INTERVAL);
+			mdelay(HW_SYNC_SLEEP_TIME_INTERVAL);
 		}
 
 		bt_cmd_l = (u32)bt_ba;
-- 
2.17.0

