Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CF32C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:30:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A18E21848
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:30:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551130236;
	bh=8bJoB9kKFMz1rP9alqCN+Z7nBzngLJE5LXHekd66Ysk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tSIx46XtUiHvEpLGbE2AosJLuSyv+95J7kWmvaEoUUhHeMYq6k5JsFGP2yNf2dswq
	 LVBCPu4LR92bs4X22MRLogqTcO25EKefsil+yQ3a4lvAUTFpuUPRGUohZLj72z+L3A
	 zGrfjY307QxM8j0ZXbtokWbRPfD2UOcWrXdSEO/g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732167AbfBYVaf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:30:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:36160 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730028AbfBYVab (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:30:31 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4EF7B217F5;
        Mon, 25 Feb 2019 21:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551130230;
        bh=8bJoB9kKFMz1rP9alqCN+Z7nBzngLJE5LXHekd66Ysk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CP49IfBKxspmOfglow44Z76n2zXpKKi7upKPmu0lxY0BfJrsOR/+JoJGZpIdb2v1r
         nBDq4FIaj1FW0XKib+fzOp+anFKc3X+R3w9e7sUEin8TKSa4TKofrQONPbJeAYmdpj
         FEVHF7Fo5dH2vlJQ3MLLqlL3spfCxw35TUzR3cAQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ido Schimmel <idosch@mellanox.com>,
        kbuild test robot <lkp@intel.com>,
        Petr Machata <petrm@mellanox.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 054/183] mlxsw: spectrum: Add VXLAN dependency for spectrum
Date:   Mon, 25 Feb 2019 22:10:27 +0100
Message-Id: <20190225195103.609316030@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190225195054.748060397@linuxfoundation.org>
References: <20190225195054.748060397@linuxfoundation.org>
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
index 8a291eb36c64c..7338c9bac4e6a 100644
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



