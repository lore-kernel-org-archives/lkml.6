Return-Path: <SRS0=kg8+=LP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 108E2C433F4
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 12:07:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3F7F2083C
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 12:07:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UMkFI4cZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3F7F2083C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727438AbeIAQS5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Sep 2018 12:18:57 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:39927 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726827AbeIAQS5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Sep 2018 12:18:57 -0400
Received: by mail-pl1-f194.google.com with SMTP id w14-v6so6631023plp.6;
        Sat, 01 Sep 2018 05:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=b23Nqqyj+9e5GBF3CkPk94BgRpPSH1QdAHCJyHp24zA=;
        b=UMkFI4cZTOylKLoHt5T2ITzrI6ufilmUO1YZUzEtRy5d+W39y7Cnq0ZbOOHeFzsaCN
         utiPueZpoMBQaiKapc3h9jF7AENEy4XRY17H3DLZYWov4yMXv9b8MPW1R3EEJQgszHMx
         QgmdDVXkoBaHfy+hELAjzAC/Pne7MDnjI70ObtAbKWauow5g+1tk9K6p1rsf3f6pRpa/
         yipo0wg8e4xGa5cjFckxdRz4gtYycKp3P8Dyt2q9it63BJOmljrUAnOgbSBvpnAGpe31
         aUEfo1EuT0XRlJirJEJIOfXdJRsrM0y04NRuhSenkCie6Ki/agLDQYYIERlFWtm5q58N
         vI2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=b23Nqqyj+9e5GBF3CkPk94BgRpPSH1QdAHCJyHp24zA=;
        b=ERLRFVZUvnWIIu60V3l+aLcETz12iEGLDgAwg/P6p3s8gBFqhJECC0VRVe0sKTvpUs
         NCJ2uAmuqvLsZse89tDqXdLpgGnUjz9hbtbzJbT0R1fSmLUuyNdQzUSAb3vtA6vfSS5Z
         UO+ozGoJT0PCBzqGU7dmpsxE9p0Q6huKlZJnWkr9KMHAHFx+aPG7MT1Mtsf2SwmpqUYd
         1pUuEHve7UU/BZYIpplWkCNj6Z2Eo9ZmI2nIiR6wjQbzmKCeaXyTZS8qeKascN809UDH
         8BbyOdX1WfA466KMMs6jyP/QggSS33RnmywG3TY47HWDakA1EgcUmAOVFcyKbTD0PZsR
         3qIA==
X-Gm-Message-State: APzg51AMxM4eM8pq6A9eJ/V9kkHSR19kNt1rV9mB1ryH2GOoFuGt8sm2
        Wg15WmuRFZ701bH2QhL8x24=
X-Google-Smtp-Source: ANB0Vdbgd4HnBGTLbPGBCZ0RGyQjB94FtOblMAXi7JYx8TqEVu+w3ZD7Yb8GrT7UotMJKexnB1vM2A==
X-Received: by 2002:a17:902:6b89:: with SMTP id p9-v6mr19527718plk.272.1535803627630;
        Sat, 01 Sep 2018 05:07:07 -0700 (PDT)
Received: from localhost.localdomain ([2402:f000:1:4414:2913:cd09:aee0:380])
        by smtp.gmail.com with ESMTPSA id b17-v6sm21296192pfb.31.2018.09.01.05.07.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 01 Sep 2018 05:07:07 -0700 (PDT)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
To:     dledford@redhat.com, jgg@ziepe.ca, leon@kernel.org,
        ira.weiny@intel.com, pravin.shedge4linux@gmail.com,
        hal@mellanox.com, parav@mellanox.com, haakon.bugge@oracle.com,
        bart.vanassche@sandisk.com
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] infiniband: core: mad: Fix a sleep-in-atomic-context bug in ib_mad_recv_done()
Date:   Sat,  1 Sep 2018 20:06:59 +0800
Message-Id: <20180901120659.32509-1-baijiaju1990@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver may sleep with holding a spinlock.

The function call paths (from bottom to top) in Linux-4.16 are:

[FUNC] alloc_mad_private(GFP_KERNEL)
drivers/infiniband/core/mad.c, 2264: 
	alloc_mad_private in ib_mad_recv_done
drivers/infiniband/core/cq.c, 45: 
	[FUNC_PTR]ib_mad_recv_done in __ib_process_cq
drivers/infiniband/core/cq.c, 77: 
	__ib_process_cq in ib_process_cq_direct
drivers/infiniband/ulp/srp/ib_srp.c, 2010: 
	ib_process_cq_direct in __srp_get_tx_iu
drivers/infiniband/ulp/srp/ib_srp.c, 2353: 
	__srp_get_tx_iu in srp_queuecommand
drivers/infiniband/ulp/srp/ib_srp.c, 2352: 
	_raw_spin_lock_irqsave in srp_queuecommand

[FUNC] alloc_mad_private(GFP_KERNEL)
drivers/infiniband/core/mad.c, 2264: 
	alloc_mad_private in ib_mad_recv_done
drivers/infiniband/core/cq.c, 45: 
	[FUNC_PTR]ib_mad_recv_done in __ib_process_cq
drivers/infiniband/core/cq.c, 77: 
	__ib_process_cq in ib_process_cq_direct
drivers/infiniband/ulp/srp/ib_srp.c, 2010: 
	ib_process_cq_direct in __srp_get_tx_iu
drivers/infiniband/ulp/srp/ib_srp.c, 2903: 
	__srp_get_tx_iu in srp_send_tsk_mgmt
drivers/infiniband/ulp/srp/ib_srp.c, 2902: 
	spin_lock_irq in srp_send_tsk_mgmt

To fix this bug, GFP_KERNEL is replaced with GFP_ATOMIC.

This bug is found by my static analysis tool DSAC.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/infiniband/core/mad.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/mad.c b/drivers/infiniband/core/mad.c
index f742ae7a768b..0db954f6958a 100644
--- a/drivers/infiniband/core/mad.c
+++ b/drivers/infiniband/core/mad.c
@@ -2263,7 +2263,7 @@ static void ib_mad_recv_done(struct ib_cq *cq, struct ib_wc *wc)
 		goto out;
 
 	mad_size = recv->mad_size;
-	response = alloc_mad_private(mad_size, GFP_KERNEL);
+	response = alloc_mad_private(mad_size, GFP_ATOMIC);
 	if (!response)
 		goto out;
 
-- 
2.17.0

