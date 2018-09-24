Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC47CECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:24:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8233721486
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:24:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8233721486
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732790AbeIXS0R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 14:26:17 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:56788 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732146AbeIXS0R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 14:26:17 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 363A71094;
        Mon, 24 Sep 2018 12:24:24 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Noa Osherovich <noaos@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 108/173] net/mlx5: Add missing SET_DRIVER_VERSION command translation
Date:   Mon, 24 Sep 2018 13:52:22 +0200
Message-Id: <20180924113124.006393880@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180924113114.334025954@linuxfoundation.org>
References: <20180924113114.334025954@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Noa Osherovich <noaos@mellanox.com>

[ Upstream commit 0f4039104ee61e14ac4771a2181c2a20572f4ec9 ]

When translating command opcodes to a string, SET_DRIVER_VERSION
command was missing.

Fixes: 42ca502e179d0 ('net/mlx5_core: Use a macro in mlx5_command_str()')
Signed-off-by: Noa Osherovich <noaos@mellanox.com>
Signed-off-by: Saeed Mahameed <saeedm@mellanox.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/cmd.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/net/ethernet/mellanox/mlx5/core/cmd.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/cmd.c
@@ -449,6 +449,7 @@ const char *mlx5_command_str(int command
 	MLX5_COMMAND_STR_CASE(SET_HCA_CAP);
 	MLX5_COMMAND_STR_CASE(QUERY_ISSI);
 	MLX5_COMMAND_STR_CASE(SET_ISSI);
+	MLX5_COMMAND_STR_CASE(SET_DRIVER_VERSION);
 	MLX5_COMMAND_STR_CASE(CREATE_MKEY);
 	MLX5_COMMAND_STR_CASE(QUERY_MKEY);
 	MLX5_COMMAND_STR_CASE(DESTROY_MKEY);


