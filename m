Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AF9FC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:36:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D55E421841
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:36:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547217388;
	bh=KQ27JDoXdjwSeEoFUFegrtGC5zemlIwX+cdqef5Xq6o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GplCAFZ5Lv4FCp+OY6+xm24EPnGaXm8b+2FUVaRqkkDTJh+Fk7IMZKdRpelxJiOdD
	 Z0AEbk9XLCCJ9iSfjqYyoviEcjNi/p90AhNeXG6QCyjgJlnk/rfiHfMIqWN6v8nEis
	 Z/31sAfhNRIdzw1BbQc3MOPhgtiWYIY/FrEWBIzA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390384AbfAKOg1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:36:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:56704 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389658AbfAKOgX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:36:23 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 05553204EC;
        Fri, 11 Jan 2019 14:36:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547217382;
        bh=KQ27JDoXdjwSeEoFUFegrtGC5zemlIwX+cdqef5Xq6o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JaSiO+j2ZFINQYfL2Ts6zxG3vwnmHOLnTJ/3SJ/VyloIGd/o2JMlzSJQIyKqTZ8Fu
         ce4voAsRNgJ3a9JvzvxDa8vveO9vVTRSb3wret3XqERPLArGh0nVviAfeVVD4pVZFp
         znFMhDwF23Sf4YU1mr9kMk9rwLODlou5bw6TiWQg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Varun Prakash <varun@chelsio.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 040/148] scsi: target: iscsi: cxgbit: add missing spin_lock_init()
Date:   Fri, 11 Jan 2019 15:13:38 +0100
Message-Id: <20190111131115.889833069@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190111131114.337122649@linuxfoundation.org>
References: <20190111131114.337122649@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

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
index f3f8856bfb68..c011c826fc26 100644
--- a/drivers/target/iscsi/cxgbit/cxgbit_main.c
+++ b/drivers/target/iscsi/cxgbit/cxgbit_main.c
@@ -58,6 +58,7 @@ static void *cxgbit_uld_add(const struct cxgb4_lld_info *lldi)
 		return ERR_PTR(-ENOMEM);
 
 	kref_init(&cdev->kref);
+	spin_lock_init(&cdev->np_lock);
 
 	cdev->lldi = *lldi;
 
-- 
2.19.1



