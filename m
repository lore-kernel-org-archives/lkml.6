Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81E05C282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:24:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52CD320844
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:24:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549895087;
	bh=WhRkoC3lvAS22VggjVNab/kV9lepe93AJThLGCg8yfM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hQPEjZr0NpPfcrguanV4FQ0p7vxERImD/0c760eG/J4c73fsjH3yFb+bIRC5TmhOq
	 cPfjkhu3BvBiNzBE8Kmc7Oz+4mnc2cAp9ErsL4f5CX+zmgIU2LZmRNteA6UiXAFQcn
	 TpfKYe2+75aBPKuqLNgp6/T3H9FJKmElhG8/JwCY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729269AbfBKOYq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:24:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:57972 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729242AbfBKOYm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:24:42 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 79B4920844;
        Mon, 11 Feb 2019 14:24:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549895082;
        bh=WhRkoC3lvAS22VggjVNab/kV9lepe93AJThLGCg8yfM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gurRGSPsmv1XLHk+FaIkHU8kmdAf/WEbzM7drk9WEsHlnLzqhewfFPiXxSuRcYGYO
         HozrPF2Kd4TfvC9ks+Ax6IPVczmLVacYeJskSwm3GSAJQksqYZvvPEXt8eAhzrxl/H
         Yz18aAIU5aaj2eXe8NDymyYt287hbUPnNbBphaJs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, YueHaibing <yuehaibing@huawei.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 086/352] net: aquantia: return err if set MPI_DEINIT state fails
Date:   Mon, 11 Feb 2019 15:15:13 +0100
Message-Id: <20190211141851.432715577@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141846.543045703@linuxfoundation.org>
References: <20190211141846.543045703@linuxfoundation.org>
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

[ Upstream commit 4e3c7c00bba0636b97eb23d582c20b0f5d95ce20 ]

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_utils.c:260:7:
 warning: variable 'err' set but not used [-Wunused-but-set-variable]

'err' should be returned while set MPI_DEINIT state fails
in hw_atl_utils_soft_reset.

Fixes: cce96d1883da ("net: aquantia: Regression on reset with 1.x firmware")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_utils.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_utils.c b/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_utils.c
index 7def1cb8ab9d..22cbf8dc6fa9 100644
--- a/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_utils.c
+++ b/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_utils.c
@@ -263,6 +263,8 @@ int hw_atl_utils_soft_reset(struct aq_hw_s *self)
 		AQ_HW_WAIT_FOR((aq_hw_read_reg(self, HW_ATL_MPI_STATE_ADR) &
 				HW_ATL_MPI_STATE_MSK) == MPI_DEINIT,
 			       10, 1000U);
+		if (err)
+			return err;
 	}
 
 	if (self->rbl_enabled)
-- 
2.19.1



