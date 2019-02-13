Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A4DEC282C4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 02:58:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CCCF20835
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 02:58:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550026714;
	bh=8mvszyBeviXoWnkYXFKrjsYjy6ba0YEf2LICjkrC3+4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=V9u1yP/k4++aclomMOQs6rqIkQouWuiAvj/lMcNPfzVWeMwoH0wAeM8Xry3yIX9vw
	 TY0UKImmk8aJ3Ai1lPTAoCA8KFYt1qIGs2ObvpJCl3Cs64HTVw5tQpTDHzJ4/LASwd
	 a5E7W8osuk7V0hZ+095//i/VhxlBkchPBB54z/R8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390043AbfBMC6c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 21:58:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:40164 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729458AbfBMCga (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 21:36:30 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8DA99222CF;
        Wed, 13 Feb 2019 02:36:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550025390;
        bh=8mvszyBeviXoWnkYXFKrjsYjy6ba0YEf2LICjkrC3+4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=I3rW9grHdyu5sQamSSYzVHs/1aIoSTjrqgO/X2wpC4tDJ3xfngpnqh6NyxPN7E8eX
         7nLKOAguuAKc3qMorz//3IiSK+EkHNMjIYQMGSH9Huhl2WOmWBDrM10dKrxRXI2fxJ
         gVyJU1E9/OFBtLcuI2CF+416d7iGl9vjgJu5K4DI=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Nir Dotan <nird@mellanox.com>, Ido Schimmel <idosch@mellanox.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.20 098/105] mlxsw: pci: Return error on PCI reset timeout
Date:   Tue, 12 Feb 2019 21:33:29 -0500
Message-Id: <20190213023336.19019-98-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190213023336.19019-1-sashal@kernel.org>
References: <20190213023336.19019-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nir Dotan <nird@mellanox.com>

[ Upstream commit 67c14cc9b35055264fc0efed00159a7de1819f1b ]

Return an appropriate error in the case when the driver timeouts on waiting
for firmware to go out of PCI reset.

Fixes: 233fa44bd67a ("mlxsw: pci: Implement reset done check")
Signed-off-by: Nir Dotan <nird@mellanox.com>
Acked-by: Jiri Pirko <jiri@mellanox.com>
Signed-off-by: Ido Schimmel <idosch@mellanox.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/mellanox/mlxsw/pci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/pci.c b/drivers/net/ethernet/mellanox/mlxsw/pci.c
index c7901a3f2a79..a903e97793f9 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/pci.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/pci.c
@@ -1367,10 +1367,10 @@ static int mlxsw_pci_sw_reset(struct mlxsw_pci *mlxsw_pci,
 		u32 val = mlxsw_pci_read32(mlxsw_pci, FW_READY);
 
 		if ((val & MLXSW_PCI_FW_READY_MASK) == MLXSW_PCI_FW_READY_MAGIC)
-			break;
+			return 0;
 		cond_resched();
 	} while (time_before(jiffies, end));
-	return 0;
+	return -EBUSY;
 }
 
 static int mlxsw_pci_alloc_irq_vectors(struct mlxsw_pci *mlxsw_pci)
-- 
2.19.1

