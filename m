Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53EF7C5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 17:56:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1931B2145D
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 17:56:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="tX7Qv0Cu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1931B2145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728621AbeJSB6i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 21:58:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:46330 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726132AbeJSB6h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 21:58:37 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1D0ED204FD;
        Thu, 18 Oct 2018 17:56:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539885393;
        bh=dzyhhRnmwIaCw+K8ILRQDku1jXjmOJGqopwKUUrf09o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tX7Qv0Cuo2s9BBt0EAGWP5k+P6N9/mIRSLxridGMK0w2zhdiLY6lDyUl+aRKLnQyi
         LMpHzqMaoJXBXoFUxYtqGwSRs2+NQZH8O+KAR87wXknEM/Ur/edTw0XJa6wUU9boWP
         zNea7WmWKO+fHDwjSF5vXamx5w/xpnwe/5aamFWo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Steve Wise <swise@opengridcomputing.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 16/53] cxgb4: fix abort_req_rss6 struct
Date:   Thu, 18 Oct 2018 19:54:09 +0200
Message-Id: <20181018175419.715480573@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181018175416.561567978@linuxfoundation.org>
References: <20181018175416.561567978@linuxfoundation.org>
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

From: Steve Wise <swise@opengridcomputing.com>

[ Upstream commit 9f34519a82356f6cf0ccb8480ee0ed99b3d0af75 ]

Remove the incorrect WR_HDR field which can cause a misinterpretation
of ABORT CPL by ULDs, such as iw_cxgb4.

Fixes: a3cdaa69e4ae ("cxgb4: Adds CPL support for Shared Receive Queues")
Signed-off-by: Steve Wise <swise@opengridcomputing.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/chelsio/cxgb4/t4_msg.h |    1 -
 1 file changed, 1 deletion(-)

--- a/drivers/net/ethernet/chelsio/cxgb4/t4_msg.h
+++ b/drivers/net/ethernet/chelsio/cxgb4/t4_msg.h
@@ -753,7 +753,6 @@ struct cpl_abort_req_rss {
 };
 
 struct cpl_abort_req_rss6 {
-	WR_HDR;
 	union opcode_tid ot;
 	__u32 srqidx_status;
 };


