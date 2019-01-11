Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3F1AC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:32:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 786372177B
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:32:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547217167;
	bh=nNaY28+qBPg1glAKqkK3U+9waK3Dqiv+6mt3dG+klkA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PHfqdnD+K40figkOcJvUbxlhQpQFQ8aECG1PJeZr3QcDRKTU5/5lKBHwiH53lC1J7
	 qaBYgrZG722OfzOkF9Kyov4e4B852QV4G+XC9LXkKtfDV1LApi1PsqWVDyHS8PJRZS
	 9wiSmFO7vH9es1q2TawdIqbff33gmysYbKhlbmmQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389497AbfAKOcq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:32:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:52810 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389477AbfAKOcn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:32:43 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9CC4C2177B;
        Fri, 11 Jan 2019 14:32:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547217163;
        bh=nNaY28+qBPg1glAKqkK3U+9waK3Dqiv+6mt3dG+klkA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GVhXxGYVuaJJ4RArM2o0HaoMshoAoqV0qDmPT24m6BgSEdF03blNmI3IA7gK9GZbD
         sDNJivRdCvLRMb9P8l4lMLgquLO5x6U0LJuRnh77H6gPJtDxfhM/c+uZhJk3D8l5m6
         4OUb8GDAKQ5SYD8DfW3xAcS7ipzWgZg9B7EqGApY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Varun Prakash <varun@chelsio.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 027/105] scsi: target: iscsi: cxgbit: add missing spin_lock_init()
Date:   Fri, 11 Jan 2019 15:13:58 +0100
Message-Id: <20190111131105.644733087@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190111131102.899065735@linuxfoundation.org>
References: <20190111131102.899065735@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

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
index 4fd775ace541..6340e2e7ffbe 100644
--- a/drivers/target/iscsi/cxgbit/cxgbit_main.c
+++ b/drivers/target/iscsi/cxgbit/cxgbit_main.c
@@ -58,6 +58,7 @@ static void *cxgbit_uld_add(const struct cxgb4_lld_info *lldi)
 		return ERR_PTR(-ENOMEM);
 
 	kref_init(&cdev->kref);
+	spin_lock_init(&cdev->np_lock);
 
 	cdev->lldi = *lldi;
 
-- 
2.19.1



