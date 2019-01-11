Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15968C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:32:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAC5921841
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:32:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547217171;
	bh=QodTYQd1JYLk4RDp/7sOReBikLEJtVL66aYfLyqK0cQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=a8fXO7MVSsAkTCm8y8HSXe5B/oP25AeQmCp3smMRV8eEj/L1tM1UB/Es1TqbYKo0v
	 tH/dEqnmwVL9Ou9Ee2H3WXeYoxf7zu/b0ADnXwPYe2zuTAVMrfxhrT5TlpXjlE1pOu
	 pbN1j5tSBYs4llp0tcoQLu6PY0aCi/QDzvL//XdE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389524AbfAKOcv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:32:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:52882 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388889AbfAKOcs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:32:48 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9779D21841;
        Fri, 11 Jan 2019 14:32:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547217168;
        bh=QodTYQd1JYLk4RDp/7sOReBikLEJtVL66aYfLyqK0cQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=C+CpMIowBSbfWleEI9mQU5aWq6Mx1Rn6gzzxSm/wPX0KQBcWHtpziy58GYD3wA61Y
         mM/lclrsnbTOnOdV04brX7m2o5938JpsnfWAMPkkVU4v+0rTW/WnVM06yc2P4C/V8c
         QTtntTpRO4W4Qr8N4593yj2z+VyIuqXTzC1V0ZU4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 029/105] drivers: net: xgene: Remove unnecessary forward declarations
Date:   Fri, 11 Jan 2019 15:14:00 +0100
Message-Id: <20190111131105.779600259@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190111131102.899065735@linuxfoundation.org>
References: <20190111131102.899065735@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

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
index 3b889efddf78..50dd6bf176d0 100644
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



