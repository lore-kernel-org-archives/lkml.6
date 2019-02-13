Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59477C282C4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 02:34:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D774222C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 02:34:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550025268;
	bh=1miTDHn0iscEgj419BlJXWuiRcPb1GNrsMh+aOxWeNE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CXaWss8yOLerrh5IJFzHtD7LzGtW7tnJhPYsLY9A9RIvyZYDbpBN5Gh66rHktRWpe
	 OtvnPy5pLWFBMUpIIgWHf/V7kSi9+OSrN9cC2/WFufTEOVsu4QbSpC2Vh4xBu930VJ
	 hNuMOTggv6hsRXwoloF2RlcusVlhlbRrorau0Vu0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387720AbfBMCe0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 21:34:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:37880 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387675AbfBMCeT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 21:34:19 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 78299222CC;
        Wed, 13 Feb 2019 02:34:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550025259;
        bh=1miTDHn0iscEgj419BlJXWuiRcPb1GNrsMh+aOxWeNE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UC/GC37gpX00Aozg7a8zzSqE4t+OBjlKp835xRDyAfz575XNYCReUCtPJkQErK8II
         FNFAAu9iBN8aQJEUqLqTc56i6ZR20eU8+DpZtRVuqgIgvGmTg5wkO93f7d2cQvbDAq
         20MdgS9QEj/vBrkCmSaLNdVdCOWwrjc0xgkKM3PE=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Ido Schimmel <idosch@mellanox.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.20 036/105] mlxsw: spectrum: Add VXLAN dependency for spectrum
Date:   Tue, 12 Feb 2019 21:32:27 -0500
Message-Id: <20190213023336.19019-36-sashal@kernel.org>
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

From: Ido Schimmel <idosch@mellanox.com>

[ Upstream commit 143a8e038ac599ca73c6354c8af6a8fdeee9fa7d ]

When VXLAN is a loadable module, MLXSW_SPECTRUM must not be built-in:

drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c:2547: undefined
reference to `vxlan_fdb_find_uc'

Add Kconfig dependency to enforce usable configurations.

Fixes: 1231e04f5bba ("mlxsw: spectrum_switchdev: Add support for VxLAN encapsulation")
Signed-off-by: Ido Schimmel <idosch@mellanox.com>
Reported-by: kbuild test robot <lkp@intel.com>
Reviewed-by: Petr Machata <petrm@mellanox.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/mellanox/mlxsw/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/Kconfig b/drivers/net/ethernet/mellanox/mlxsw/Kconfig
index 8a291eb36c64..7338c9bac4e6 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/Kconfig
+++ b/drivers/net/ethernet/mellanox/mlxsw/Kconfig
@@ -78,6 +78,7 @@ config MLXSW_SPECTRUM
 	depends on IPV6 || IPV6=n
 	depends on NET_IPGRE || NET_IPGRE=n
 	depends on IPV6_GRE || IPV6_GRE=n
+	depends on VXLAN || VXLAN=n
 	select GENERIC_ALLOCATOR
 	select PARMAN
 	select MLXFW
-- 
2.19.1

