Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1C53C2F3A0
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 13:48:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 822472063F
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 13:48:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548078519;
	bh=fgq0UORjTfIQ+gtYjmuItDwJToMdaiaoj2Zc+S0soRw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VQqoNEED4/WorFyO2KDEUxUuf8IwaxJmZeVeqOsDpu4dsgG3PcN82Xh+sVKrycIEo
	 u4zg0dBo4sMmyGFuD+J8aWpso5As9fHqPI5i6D4HQtddvpXK3gsk2TA36HABCBlFRk
	 8Qm6pN/+LO5Y1Ub3WGNHNQvpDjwkc8sSBjBC5KCc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729990AbfAUNsh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 08:48:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:58570 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729970AbfAUNse (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 08:48:34 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E44B120861;
        Mon, 21 Jan 2019 13:48:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548078513;
        bh=fgq0UORjTfIQ+gtYjmuItDwJToMdaiaoj2Zc+S0soRw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yGQH2Bd/it3hF0kzj6kO8TjL4piaNuHQwU0MuhAtbeHSfZmbsP5kvUtECQOnl1XF9
         7Ds+OHmfS60BtCdHS5vDiBrj45y/JKJo8vN8IeV+3jslekfB5nCv2xoZqDRH5i/Wiv
         RzQ39GJ+w2qNBktfHi6kgFqlB/3BtoqUKcqoIZEM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ruishuang Wang <ruishuangw@vmware.com>,
        Bryan Tan <bryantan@vmware.com>,
        Vishnu Dasa <vdasa@vmware.com>,
        Adit Ranadive <aditr@vmware.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Subject: [PATCH 4.20 059/111] RDMA/vmw_pvrdma: Return the correct opcode when creating WR
Date:   Mon, 21 Jan 2019 14:42:53 +0100
Message-Id: <20190121122502.405508184@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190121122455.819406896@linuxfoundation.org>
References: <20190121122455.819406896@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Adit Ranadive <aditr@vmware.com>

commit 6325e01b6cdf4636b721cf7259c1616e3cf28ce2 upstream.

Since the IB_WR_REG_MR opcode value changed, let's set the PVRDMA device
opcodes explicitly.

Reported-by: Ruishuang Wang <ruishuangw@vmware.com>
Fixes: 9a59739bd01f ("IB/rxe: Revise the ib_wr_opcode enum")
Cc: stable@vger.kernel.org
Reviewed-by: Bryan Tan <bryantan@vmware.com>
Reviewed-by: Ruishuang Wang <ruishuangw@vmware.com>
Reviewed-by: Vishnu Dasa <vdasa@vmware.com>
Signed-off-by: Adit Ranadive <aditr@vmware.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/infiniband/hw/vmw_pvrdma/pvrdma.h    |   35 ++++++++++++++++++++++++++-
 drivers/infiniband/hw/vmw_pvrdma/pvrdma_qp.c |    6 ++++
 include/uapi/rdma/vmw_pvrdma-abi.h           |    1 
 3 files changed, 41 insertions(+), 1 deletion(-)

--- a/drivers/infiniband/hw/vmw_pvrdma/pvrdma.h
+++ b/drivers/infiniband/hw/vmw_pvrdma/pvrdma.h
@@ -427,7 +427,40 @@ static inline enum ib_qp_state pvrdma_qp
 
 static inline enum pvrdma_wr_opcode ib_wr_opcode_to_pvrdma(enum ib_wr_opcode op)
 {
-	return (enum pvrdma_wr_opcode)op;
+	switch (op) {
+	case IB_WR_RDMA_WRITE:
+		return PVRDMA_WR_RDMA_WRITE;
+	case IB_WR_RDMA_WRITE_WITH_IMM:
+		return PVRDMA_WR_RDMA_WRITE_WITH_IMM;
+	case IB_WR_SEND:
+		return PVRDMA_WR_SEND;
+	case IB_WR_SEND_WITH_IMM:
+		return PVRDMA_WR_SEND_WITH_IMM;
+	case IB_WR_RDMA_READ:
+		return PVRDMA_WR_RDMA_READ;
+	case IB_WR_ATOMIC_CMP_AND_SWP:
+		return PVRDMA_WR_ATOMIC_CMP_AND_SWP;
+	case IB_WR_ATOMIC_FETCH_AND_ADD:
+		return PVRDMA_WR_ATOMIC_FETCH_AND_ADD;
+	case IB_WR_LSO:
+		return PVRDMA_WR_LSO;
+	case IB_WR_SEND_WITH_INV:
+		return PVRDMA_WR_SEND_WITH_INV;
+	case IB_WR_RDMA_READ_WITH_INV:
+		return PVRDMA_WR_RDMA_READ_WITH_INV;
+	case IB_WR_LOCAL_INV:
+		return PVRDMA_WR_LOCAL_INV;
+	case IB_WR_REG_MR:
+		return PVRDMA_WR_FAST_REG_MR;
+	case IB_WR_MASKED_ATOMIC_CMP_AND_SWP:
+		return PVRDMA_WR_MASKED_ATOMIC_CMP_AND_SWP;
+	case IB_WR_MASKED_ATOMIC_FETCH_AND_ADD:
+		return PVRDMA_WR_MASKED_ATOMIC_FETCH_AND_ADD;
+	case IB_WR_REG_SIG_MR:
+		return PVRDMA_WR_REG_SIG_MR;
+	default:
+		return PVRDMA_WR_ERROR;
+	}
 }
 
 static inline enum ib_wc_status pvrdma_wc_status_to_ib(
--- a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_qp.c
+++ b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_qp.c
@@ -721,6 +721,12 @@ int pvrdma_post_send(struct ib_qp *ibqp,
 		    wr->opcode == IB_WR_RDMA_WRITE_WITH_IMM)
 			wqe_hdr->ex.imm_data = wr->ex.imm_data;
 
+		if (unlikely(wqe_hdr->opcode == PVRDMA_WR_ERROR)) {
+			*bad_wr = wr;
+			ret = -EINVAL;
+			goto out;
+		}
+
 		switch (qp->ibqp.qp_type) {
 		case IB_QPT_GSI:
 		case IB_QPT_UD:
--- a/include/uapi/rdma/vmw_pvrdma-abi.h
+++ b/include/uapi/rdma/vmw_pvrdma-abi.h
@@ -78,6 +78,7 @@ enum pvrdma_wr_opcode {
 	PVRDMA_WR_MASKED_ATOMIC_FETCH_AND_ADD,
 	PVRDMA_WR_BIND_MW,
 	PVRDMA_WR_REG_SIG_MR,
+	PVRDMA_WR_ERROR,
 };
 
 enum pvrdma_wc_status {


