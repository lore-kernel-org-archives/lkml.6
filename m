Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EB02C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:27:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2484F2183F
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:27:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547216862;
	bh=lVwKFuuQldEECV03oROt0bIzwGNNQ5Lo3pIjywtEG1E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LMgRw57B8vnOE4FTMX2TPV8H46jOAD0m4O4S9jjfyXpydCn+kdSI6cTDxL5x6oOfo
	 tLhgHowUC7KpiPleeDCqtos3fGoDpRR+3P+TKPyz49sEkisM5liZEV4aDxbrIsWBau
	 /+WCfjtRrRdGhy+RFac6Ib2cz9LGi5En/ue/tvnE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388364AbfAKO1k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:27:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:45894 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731722AbfAKO1g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:27:36 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7698C2133F;
        Fri, 11 Jan 2019 14:27:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547216855;
        bh=lVwKFuuQldEECV03oROt0bIzwGNNQ5Lo3pIjywtEG1E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WKgo5WxECew9wZ3yrmIAPmX7t4yv7T7WpuzRfdXyzX4B2dotkm59nCvOPB5DY8j3t
         3fUU1SKRe7VCCSKTXTixU/br5Pdq4NFM3JeWgOCVqJF8bcgOo6P5gjv3NkaFHtyUs5
         4ODhNJM7CwDKYOVvb5AHbAZHP1m2eiu60bpJCe1g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Varun Prakash <varun@chelsio.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 16/63] scsi: target: iscsi: cxgbit: add missing spin_lock_init()
Date:   Fri, 11 Jan 2019 15:14:19 +0100
Message-Id: <20190111131048.564440779@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190111131046.387528003@linuxfoundation.org>
References: <20190111131046.387528003@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 9e6371d3c6913ff1707fb2c0274c9925f7aaef80 ]

Add missing spin_lock_init() for cdev->np_lock.

Signed-off-by: Varun Prakash <varun@chelsio.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/target/iscsi/cxgbit/cxgbit_main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/target/iscsi/cxgbit/cxgbit_main.c b/drivers/target/iscsi/cxgbit/cxgbit_main.c
index ad26b9372f10..d55261e1d522 100644
--- a/drivers/target/iscsi/cxgbit/cxgbit_main.c
+++ b/drivers/target/iscsi/cxgbit/cxgbit_main.c
@@ -58,6 +58,7 @@ static void *cxgbit_uld_add(const struct cxgb4_lld_info *lldi)
 		return ERR_PTR(-ENOMEM);
 
 	kref_init(&cdev->kref);
+	spin_lock_init(&cdev->np_lock);
 
 	cdev->lldi = *lldi;
 
-- 
2.19.1



