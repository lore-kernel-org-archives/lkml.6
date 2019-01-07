Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AA7DC43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:55:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40DF5206BB
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:55:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546865743;
	bh=1Nejq1qtW3Fa7KtiSj8qpdpaxlsmvPfhynv3fM+sHMI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qX9XRzjEbXVE1AtF/W9rcKejeLPSFV7Bexj/+Wc+HUqlCZc5ncmtuCxOq13ziaIYy
	 +s5g9bWtsqBu78VEqQ98B6KfXEY4lcFHLhj056MHM+2WHpj6hpGQvG/oEL0AdrwYWp
	 EvgJ4DI2FeqDZ2Vt4Ypa4IyEuANJdaly+HCRpWFQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729081AbfAGMsC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 07:48:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:38400 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729062AbfAGMr5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 07:47:57 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0ED1E206BB;
        Mon,  7 Jan 2019 12:47:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546865276;
        bh=1Nejq1qtW3Fa7KtiSj8qpdpaxlsmvPfhynv3fM+sHMI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AZKjFyPwtR+3LAw+/Wf8jbvEN0E88JH0Z/1CZ8ZTFLYpqrbnUxyljhlb33G3u80jg
         4w0kbNncYbgvaC0ykJmz8fJ1iDiwsk+Sii0u8NYuY+JiSfq6ImofF3C9/KSCahLajQ
         +pzSV0j7neLmJd0nYJM88hxJAZWegOG9LSVH0tWQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yuval Avnery <yuvalav@mellanox.com>,
        Daniel Jurgens <danielj@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>
Subject: [PATCH 4.19 041/170] net/mlx5: Typo fix in del_sw_hw_rule
Date:   Mon,  7 Jan 2019 13:31:08 +0100
Message-Id: <20190107104458.089363193@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190107104452.953560660@linuxfoundation.org>
References: <20190107104452.953560660@linuxfoundation.org>
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

From: Yuval Avnery <yuvalav@mellanox.com>

[ Upstream commit f0337889147c956721696553ffcc97212b0948fe ]

Expression terminated with "," instead of ";", resulted in
set_fte getting bad value for modify_enable_mask field.

Fixes: bd5251dbf156 ("net/mlx5_core: Introduce flow steering destination of type counter")
Signed-off-by: Yuval Avnery <yuvalav@mellanox.com>
Reviewed-by: Daniel Jurgens <danielj@mellanox.com>
Signed-off-by: Saeed Mahameed <saeedm@mellanox.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/fs_core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
@@ -432,7 +432,7 @@ static void del_sw_hw_rule(struct fs_nod
 
 	if ((fte->action.action & MLX5_FLOW_CONTEXT_ACTION_FWD_DEST) &&
 	    --fte->dests_size) {
-		modify_mask = BIT(MLX5_SET_FTE_MODIFY_ENABLE_MASK_DESTINATION_LIST),
+		modify_mask = BIT(MLX5_SET_FTE_MODIFY_ENABLE_MASK_DESTINATION_LIST);
 		update_fte = true;
 	}
 out:


