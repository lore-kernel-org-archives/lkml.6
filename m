Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08215C282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:38:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9FF72081B
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:38:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549895923;
	bh=T+0rspLJjpV35mBIUihfxSAUyopRbJr5AKoog/YFrzs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BYYCI6SqctTgYxMslHjZFNO0lcxNW6688CblaT/2e1iUzzuZSE/TE/cqaLDF16d5b
	 BkLEzNvtHPnyXXGjbg/WzDcU16RSl8QBsu2yrcb1g8MHlxrQu+v/lGLjW9pZY+vWrr
	 6lMyQ7UiX8KqF0VCbRvdCsbTeF4edu4Dq7YXYkl8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731729AbfBKOim (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:38:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:48594 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730995AbfBKOik (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:38:40 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E5A4E21B18;
        Mon, 11 Feb 2019 14:38:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549895919;
        bh=T+0rspLJjpV35mBIUihfxSAUyopRbJr5AKoog/YFrzs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fo8K/fe4g3AskHC1MOTFrZLZwx6oMcVhyxxDh7yF7bzAZEVPCAjwKE9iwMV4ue5rb
         84POaLZRT0p7IntHoVvcyfPA4j6FRMjwY2+6khwKi595qA+Iz6JXddClS/8SKZLnzh
         OJXb2KwpP/FSM0NT19kHmzSoPve1Q3oWfgdVOMLw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Rakesh Pillai <pillair@qti.qualcomm.com>,
        Govind Singh <govinds@qti.qualcomm.com>,
        Brian Norris <briannorris@chromium.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 014/313] ath10k: assign n_cipher_suites for WCN3990
Date:   Mon, 11 Feb 2019 15:14:54 +0100
Message-Id: <20190211141854.154410695@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141852.749630980@linuxfoundation.org>
References: <20190211141852.749630980@linuxfoundation.org>
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

[ Upstream commit 2bd345cd2bfc0bd44528896313c0b45f087bdf67 ]

Commit 2ea9f12cefe4 ("ath10k: add new cipher suite support") added a new
n_cipher_suites HW param with a fallback value and a warning log. Commit
03a72288c546 ("ath10k: wmi: add hw params entry for wcn3990") later
added WCN3990 HW entries, but it missed the n_cipher_suites.

Rather than seeing this warning every boot

  ath10k_snoc 18800000.wifi: invalid hw_params.n_cipher_suites 0

let's provide the appropriate value.

Cc: Rakesh Pillai <pillair@qti.qualcomm.com>
Cc: Govind Singh <govinds@qti.qualcomm.com>
Signed-off-by: Brian Norris <briannorris@chromium.org>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/ath/ath10k/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/ath/ath10k/core.c b/drivers/net/wireless/ath/ath10k/core.c
index c40cd129afe7..5210cffb5344 100644
--- a/drivers/net/wireless/ath/ath10k/core.c
+++ b/drivers/net/wireless/ath/ath10k/core.c
@@ -532,6 +532,7 @@ static const struct ath10k_hw_params ath10k_hw_params_list[] = {
 		.hw_ops = &wcn3990_ops,
 		.decap_align_bytes = 1,
 		.num_peers = TARGET_HL_10_TLV_NUM_PEERS,
+		.n_cipher_suites = 8,
 		.ast_skid_limit = TARGET_HL_10_TLV_AST_SKID_LIMIT,
 		.num_wds_entries = TARGET_HL_10_TLV_NUM_WDS_ENTRIES,
 		.target_64bit = true,
-- 
2.19.1



