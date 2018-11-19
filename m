Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FB23C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:42:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36484214D9
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:42:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="siHC+rrp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36484214D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387736AbeKTDGu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 22:06:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:40738 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732796AbeKTDGt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 22:06:49 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0398A21104;
        Mon, 19 Nov 2018 16:42:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542645759;
        bh=FO8Qj5KtLWRrCyTtHRlx+/3bD4BL0JbY/3HPZgXQMtc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=siHC+rrpeftWcaLQQXJbs5F6n+hoixo+j92BO3JdEB2TYBghw6VuyaifZhi2BUuUL
         2yW5+IUSHHy5I0+cRcsyrnODM1Y3WOXdVOYoFON9psh0ceaWxYiGVIZtoeERsWply1
         WMhag9L4C/edfsdFoJYAG7bomqCFWpvK0mEm3xjA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Quinn Tran <quinn.tran@cavium.com>,
        Himanshu Madhani <himanshu.madhani@cavium.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 4.18 041/171] scsi: qla2xxx: Remove stale debug trace message from tcm_qla2xxx
Date:   Mon, 19 Nov 2018 17:27:17 +0100
Message-Id: <20181119162626.439404899@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181119162618.909354448@linuxfoundation.org>
References: <20181119162618.909354448@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Quinn Tran <quinn.tran@cavium.com>

commit 7c388f91ec1a59b0ed815b07b90536e2d57e1e1f upstream.

Remove stale debug trace.

Fixes: 1eb42f965ced ("qla2xxx: Make trace flags more readable")
Cc: stable@vger.kernel.org #4.10
Signed-off-by: Quinn Tran <quinn.tran@cavium.com>
Signed-off-by: Himanshu Madhani <himanshu.madhani@cavium.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/scsi/qla2xxx/tcm_qla2xxx.c |    4 ----
 1 file changed, 4 deletions(-)

--- a/drivers/scsi/qla2xxx/tcm_qla2xxx.c
+++ b/drivers/scsi/qla2xxx/tcm_qla2xxx.c
@@ -718,10 +718,6 @@ static int tcm_qla2xxx_queue_status(stru
 	cmd->sg_cnt = 0;
 	cmd->offset = 0;
 	cmd->dma_data_direction = target_reverse_dma_direction(se_cmd);
-	if (cmd->trc_flags & TRC_XMIT_STATUS) {
-		pr_crit("Multiple calls for status = %p.\n", cmd);
-		dump_stack();
-	}
 	cmd->trc_flags |= TRC_XMIT_STATUS;
 
 	if (se_cmd->data_direction == DMA_FROM_DEVICE) {


