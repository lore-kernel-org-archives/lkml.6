Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10CF6C6778A
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 18:15:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C94AB258E8
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 18:15:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C94AB258E8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965436AbeGASPd (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 14:15:33 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33964 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965356AbeGAQ0o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 12:26:44 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 1A9D092B;
        Sun,  1 Jul 2018 16:26:43 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Leon Romanovsky <leonro@mellanox.com>,
        Doug Ledford <dledford@redhat.com>
Subject: [PATCH 4.9 039/101] RDMA/mlx4: Discard unknown SQP work requests
Date:   Sun,  1 Jul 2018 18:21:25 +0200
Message-Id: <20180701160758.731045435@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180701160757.138608453@linuxfoundation.org>
References: <20180701160757.138608453@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Leon Romanovsky <leonro@mellanox.com>

commit 6b1ca7ece15e94251d1d0d919f813943e4a58059 upstream.

There is no need to crash the machine if unknown work request was
received in SQP MAD.

Cc: <stable@vger.kernel.org> # 3.6
Fixes: 37bfc7c1e83f ("IB/mlx4: SR-IOV multiplex and demultiplex MADs")
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
Signed-off-by: Doug Ledford <dledford@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/infiniband/hw/mlx4/mad.c |    1 -
 1 file changed, 1 deletion(-)

--- a/drivers/infiniband/hw/mlx4/mad.c
+++ b/drivers/infiniband/hw/mlx4/mad.c
@@ -1897,7 +1897,6 @@ static void mlx4_ib_sqp_comp_worker(stru
 					       "buf:%lld\n", wc.wr_id);
 				break;
 			default:
-				BUG_ON(1);
 				break;
 			}
 		} else  {


