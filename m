Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF3CDC282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:40:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B730E218FC
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:40:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548358804;
	bh=y/+vDCZCCaVPXEffQByp8uKY3VHyBtMrXhnn4wCh1Uk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1mz40jvx+BIFmwD+tTjeDJG4JXwz/P8SPdgTs0S5Zs2gjbuZV5kCp+HHbPzCImJA3
	 uZmRyXBr8wRMhHN4zCHapnUZwiTwgM13I9iqhJ+agCrcFoIiahsdkq/+3FPQsSKj/I
	 d4AfmHwK+AWnDCKtHCWScochCVOGNaakDoQNY2lw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733189AbfAXTkD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 14:40:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:40144 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733178AbfAXTkA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 14:40:00 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0C6FC20663;
        Thu, 24 Jan 2019 19:39:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548358799;
        bh=y/+vDCZCCaVPXEffQByp8uKY3VHyBtMrXhnn4wCh1Uk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=S0Vq4nTf6rarg9dyRqCP8aqmRfMYlBXQ7EzcnWfQLEoDBor9RMQD/IPhFVFDNAqSL
         P5wU5WwtFl9ywzPRlUbtOivB4XH4dJQhaNSqRxg1IJyj6az6LD/RYE1SwIDQ2Ch7RL
         e83kGt27FIgUiSfWuRCQmxEq6HuiTL0txTfdcA/8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ido Schimmel <idosch@mellanox.com>,
        Jiri Pirko <jiri@mellanox.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.20 003/127] mlxsw: spectrum_switchdev: Set PVID correctly during VLAN deletion
Date:   Thu, 24 Jan 2019 20:19:09 +0100
Message-Id: <20190124190212.171536547@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190124190211.984305387@linuxfoundation.org>
References: <20190124190211.984305387@linuxfoundation.org>
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

From: Ido Schimmel <idosch@mellanox.com>

[ Upstream commit 674bed5df4cab8f96d04f7b99608883a48f9226b ]

When a VLAN is deleted from a bridge port we should not change the PVID
unless the deleted VLAN is the PVID.

Fixes: fe9ccc785de5 ("mlxsw: spectrum_switchdev: Don't batch VLAN operations")
Signed-off-by: Ido Schimmel <idosch@mellanox.com>
Acked-by: Jiri Pirko <jiri@mellanox.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
@@ -1816,7 +1816,7 @@ static void
 mlxsw_sp_bridge_port_vlan_del(struct mlxsw_sp_port *mlxsw_sp_port,
 			      struct mlxsw_sp_bridge_port *bridge_port, u16 vid)
 {
-	u16 pvid = mlxsw_sp_port->pvid == vid ? 0 : vid;
+	u16 pvid = mlxsw_sp_port->pvid == vid ? 0 : mlxsw_sp_port->pvid;
 	struct mlxsw_sp_port_vlan *mlxsw_sp_port_vlan;
 
 	mlxsw_sp_port_vlan = mlxsw_sp_port_vlan_find_by_vid(mlxsw_sp_port, vid);


