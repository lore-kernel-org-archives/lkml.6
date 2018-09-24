Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9594CECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 17:27:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FC65208D9
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 17:27:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FC65208D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732957AbeIXXay (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 19:30:54 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:37682 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728916AbeIXXay (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 19:30:54 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1g4Ue2-0008Ab-Fa; Mon, 24 Sep 2018 17:27:38 +0000
From:   Colin King <colin.king@canonical.com>
To:     Christian Benvenuti <benve@cisco.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] IB/usnic: fix spelling mistake "unvalid" -> "invalid"
Date:   Mon, 24 Sep 2018 18:27:38 +0100
Message-Id: <20180924172738.3508-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Trivial fix to spelling mistake in usnic_err error message.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/infiniband/hw/usnic/usnic_transport.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/usnic/usnic_transport.c b/drivers/infiniband/hw/usnic/usnic_transport.c
index e0a95538c364..82dd810bc000 100644
--- a/drivers/infiniband/hw/usnic/usnic_transport.c
+++ b/drivers/infiniband/hw/usnic/usnic_transport.c
@@ -121,7 +121,7 @@ void usnic_transport_unrsrv_port(enum usnic_transport_type type, u16 port_num)
 	if (type == USNIC_TRANSPORT_ROCE_CUSTOM) {
 		spin_lock(&roce_bitmap_lock);
 		if (!port_num) {
-			usnic_err("Unreserved unvalid port num 0 for %s\n",
+			usnic_err("Unreserved invalid port num 0 for %s\n",
 					usnic_transport_to_str(type));
 			goto out_roce_custom;
 		}
-- 
2.17.1

