Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 110A0C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:54:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4EC82147C
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:54:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551131671;
	bh=AaXh60RPRW+Z5UyBHth3b/HzQxsEpP0SwutJAHElEa0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KcmIXFpPF8w/zw7uU2SriaGzhxJaaoEkl46rVfICZUC7N2/l8+JKfJaf2Cgyx5yYl
	 PaI8u5Bx6HtlueLVhpn0y0stVK9af1mNNrXm86XJ54mzh7bUk3P32anQtjvXIL3pXe
	 Zd0QBB+oyfeuGJRPAufkSklM+djb+0dP8gn74iH4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730914AbfBYVya (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:54:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:56174 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729650AbfBYVWI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:22:08 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6013621841;
        Mon, 25 Feb 2019 21:22:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551129727;
        bh=AaXh60RPRW+Z5UyBHth3b/HzQxsEpP0SwutJAHElEa0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cMKtfdGgiF/vRVWq3Big/V0j7b4yTBNePyVL+UXfBTd+xHNo837eMHUqRAS9oCntW
         7NGZUKbCaX0ikZL2GZ89pPzYIF3hw09HiIdlH2gqC40pKPQU99Pq9HT4aPDNAR2/Sx
         oM7MYkVf3oeUZbJDuke/19Z0O/5LDu/WvQjN5WFQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, YueHaibing <yuehaibing@huawei.com>,
        Manish Rangankar <mrangankar@marvell.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 048/152] scsi: qla4xxx: check return code of qla4xxx_copy_from_fwddb_param
Date:   Mon, 25 Feb 2019 22:10:40 +0100
Message-Id: <20190225195046.989475027@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190225195043.645958524@linuxfoundation.org>
References: <20190225195043.645958524@linuxfoundation.org>
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

[ Upstream commit 72b4a0465f995175a2e22cf4a636bf781f1f28a7 ]

The return code should be check while qla4xxx_copy_from_fwddb_param fails.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Acked-by: Manish Rangankar <mrangankar@marvell.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/qla4xxx/ql4_os.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/scsi/qla4xxx/ql4_os.c b/drivers/scsi/qla4xxx/ql4_os.c
index 0e13349dce570..575445c761b48 100644
--- a/drivers/scsi/qla4xxx/ql4_os.c
+++ b/drivers/scsi/qla4xxx/ql4_os.c
@@ -7237,6 +7237,8 @@ static int qla4xxx_sysfs_ddb_tgt_create(struct scsi_qla_host *ha,
 
 	rc = qla4xxx_copy_from_fwddb_param(fnode_sess, fnode_conn,
 					   fw_ddb_entry);
+	if (rc)
+		goto free_sess;
 
 	ql4_printk(KERN_INFO, ha, "%s: sysfs entry %s created\n",
 		   __func__, fnode_sess->dev.kobj.name);
-- 
2.19.1



