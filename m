Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB62EC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 02:33:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8A7620840
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 02:33:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550198018;
	bh=8UN0B3TRD+hX+0lpLPRtGT187EZVzcIQSZfk1WFAYjg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dR9VmqimVTWb6baGDPWdLgpSy8DskGdBhPk8astVd4Bk94DjYhCWFND/cFFbj7Yf0
	 CK1O+RQnjiFECwzzdqgz6IsLo50t1m1FKoiWdHYhpy1pWlSe535BpOIVO1UWFphYxD
	 0MYLdCkI+JqF03dL6P8Lsg/Ns6JAN10EIH7E+IL8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388359AbfBOCdb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 21:33:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:52030 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390908AbfBOCL6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 21:11:58 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D6C1F222D4;
        Fri, 15 Feb 2019 02:11:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550196718;
        bh=8UN0B3TRD+hX+0lpLPRtGT187EZVzcIQSZfk1WFAYjg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BfHg64CvHYwe6vYmUQa5C9Dv57Gq81Re0cfBdeuAsMW7SjZ82ZrdAWyqBvwsna3WG
         jDER50bg4ggLVD4MIBnSJwONeH5+iZ+EUMjEQ8yO8Hi1VIk42pAI+050udpSsZUSkN
         +czOtny3yTvLYaW854amB0xxi4NZbz7w3Oj7BNpk=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Yang Yingliang <yangyingliang@huawei.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 24/65] irqchip/gic-v3-mbi: Fix uninitialized mbi_lock
Date:   Thu, 14 Feb 2019 21:10:40 -0500
Message-Id: <20190215021121.177674-24-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190215021121.177674-1-sashal@kernel.org>
References: <20190215021121.177674-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yang Yingliang <yangyingliang@huawei.com>

[ Upstream commit c530bb8a726a37811e9fb5d68cd6b5408173b545 ]

The mbi_lock mutex is left uninitialized, so let's use DEFINE_MUTEX
to initialize it statically.

Fixes: 505287525c24d ("irqchip/gic-v3: Add support for Message Based Interrupts as an MSI controller")
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/irqchip/irq-gic-v3-mbi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-gic-v3-mbi.c b/drivers/irqchip/irq-gic-v3-mbi.c
index ad70e7c416e3..fbfa7ff6deb1 100644
--- a/drivers/irqchip/irq-gic-v3-mbi.c
+++ b/drivers/irqchip/irq-gic-v3-mbi.c
@@ -24,7 +24,7 @@ struct mbi_range {
 	unsigned long		*bm;
 };
 
-static struct mutex		mbi_lock;
+static DEFINE_MUTEX(mbi_lock);
 static phys_addr_t		mbi_phys_base;
 static struct mbi_range		*mbi_ranges;
 static unsigned int		mbi_range_nr;
-- 
2.19.1

