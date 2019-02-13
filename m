Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E36E0C282CA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 02:39:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB112222CE
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 02:39:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550025579;
	bh=8mvszyBeviXoWnkYXFKrjsYjy6ba0YEf2LICjkrC3+4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pinIzM5hlRZiNiheuWGVyH1GqD1sIi8a3PHOzBV9VoKrVvkblpr+BBF4vTU7q9Igi
	 S89hfFHocaxV0zTkwA0zLPIfBjjDTkEcJdyMTyxGNdmWabvTHzDYNOgLn8BB8y55SD
	 F/ypIQrqq0xwOJ1TRfS7gDAMI5YI2BpgRg2X98VY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388813AbfBMCji (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 21:39:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:43144 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388775AbfBMCjd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 21:39:33 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 41DF5222CE;
        Wed, 13 Feb 2019 02:39:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550025573;
        bh=8mvszyBeviXoWnkYXFKrjsYjy6ba0YEf2LICjkrC3+4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MOe1bszqvIH7tvPE2Nfv7M1rwu8c/uTDrUUEDCS9kBHVTMVFlQ8ZFGfIY6pF6f54k
         CmGrep2YLO8E6N5PZ3j6ixqNvzLL/Tt26fe2tDhfwDzlw/UaIsji9MSzSfjb++cepK
         AGjAaUUmrJR7waeDvlAx9+SlB05uQ54uF0uL3aEw=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Nir Dotan <nird@mellanox.com>, Ido Schimmel <idosch@mellanox.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 78/83] mlxsw: pci: Return error on PCI reset timeout
Date:   Tue, 12 Feb 2019 21:36:56 -0500
Message-Id: <20190213023701.20286-78-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190213023701.20286-1-sashal@kernel.org>
References: <20190213023701.20286-1-sashal@kernel.org>
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

