Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C33DC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 22:54:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E483F21741
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 22:54:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545864867;
	bh=rdgHqCpADzgrDZmyvXGprubDV0RcsPiPFTdZU9w4Gds=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Uy06Bs2KR1NgnS+YhDlbcxKz0nFPK0eqTRh0X99naePdMw0DFdRMUGCsjdbYSPVog
	 PpcpnTgb2CeiQtgBR5EY8Lc0HpE7NmlFrQqByxxe8KD9eAbDzVcTtv88/rTvFcQ1jm
	 HOQ1ocPypXinF8iR7BIStuF4V8k9cIaEHW1u/4t0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728607AbeLZWy0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 17:54:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:55660 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730100AbeLZWyT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 17:54:19 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B82AE21741;
        Wed, 26 Dec 2018 22:54:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545864858;
        bh=rdgHqCpADzgrDZmyvXGprubDV0RcsPiPFTdZU9w4Gds=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Qdp0XYsSEIoWdVhWZCRZBzwPn3fNzq07mg7OYh6TpxyUNgb2H3Nh53GyYXqyV1TWV
         7gor1YwyzTZodvgTL4BPnbVgh9dXqbQH2WcDMsTgiCjOqwDRo8JQFusMpWBecH3XYv
         lvnqbNBavD1x3xits2eoojKlkoX3YAQaFmzBDCdk=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 18/35] drivers: net: xgene: Remove unnecessary forward declarations
Date:   Wed, 26 Dec 2018 17:41:25 -0500
Message-Id: <20181226224142.150866-18-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181226224142.150866-1-sashal@kernel.org>
References: <20181226224142.150866-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nathan Chancellor <natechancellor@gmail.com>

[ Upstream commit 2ab4c3426c0cf711d7147e3f559638e4ab88960e ]

Clang warns:

drivers/net/ethernet/apm/xgene/xgene_enet_main.c:33:36: warning:
tentative array definition assumed to have one element
static const struct acpi_device_id xgene_enet_acpi_match[];
                                   ^
1 warning generated.

Both xgene_enet_acpi_match and xgene_enet_of_match are defined before
their uses at the bottom of the file so this is unnecessary. When
CONFIG_ACPI is disabled, ACPI_PTR becomes NULL so xgene_enet_acpi_match
doesn't need to be defined.

Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/apm/xgene/xgene_enet_main.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/net/ethernet/apm/xgene/xgene_enet_main.c b/drivers/net/ethernet/apm/xgene/xgene_enet_main.c
index fca2e428cd86..de4b5d267c30 100644
--- a/drivers/net/ethernet/apm/xgene/xgene_enet_main.c
+++ b/drivers/net/ethernet/apm/xgene/xgene_enet_main.c
@@ -29,9 +29,6 @@
 #define RES_RING_CSR	1
 #define RES_RING_CMD	2
 
-static const struct of_device_id xgene_enet_of_match[];
-static const struct acpi_device_id xgene_enet_acpi_match[];
-
 static void xgene_enet_init_bufpool(struct xgene_enet_desc_ring *buf_pool)
 {
 	struct xgene_enet_raw_desc16 *raw_desc;
-- 
2.19.1

