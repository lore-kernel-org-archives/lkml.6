Return-Path: <SRS0=hmx+=JJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C72BC43142
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 06:29:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07DAC24B47
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 06:29:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07DAC24B47
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751474AbeFWG3d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Jun 2018 02:29:33 -0400
Received: from smtprelay0253.hostedemail.com ([216.40.44.253]:51536 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751402AbeFWG3c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jun 2018 02:29:32 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id DE89C211D6;
        Sat, 23 Jun 2018 06:29:31 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: run76_35f9b93c7393b
X-Filterd-Recvd-Size: 1667
Received: from joe-laptop.perches.com (unknown [47.151.150.235])
        (Authenticated sender: joe@perches.com)
        by omf01.hostedemail.com (Postfix) with ESMTPA;
        Sat, 23 Jun 2018 06:29:30 +0000 (UTC)
From:   Joe Perches <joe@perches.com>
To:     linux-kernel@vger.kernel.org
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org
Subject: [PATCH] MIPS: ath25: Convert random_ether_addr to eth_random_addr
Date:   Fri, 22 Jun 2018 23:29:28 -0700
Message-Id: <2a63f5c5d19e51471347a1a45b5b5cd4697dcb23.1529735299.git.joe@perches.com>
X-Mailer: git-send-email 2.15.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

random_ether_addr is a #define for eth_random_addr which is
generally preferred in kernel code by ~3:1

Convert the uses of random_ether_addr to enable removing the #define

Signed-off-by: Joe Perches <joe@perches.com>
---
 arch/mips/ath25/board.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/mips/ath25/board.c b/arch/mips/ath25/board.c
index 6d11ae581ea7..989e71015ee6 100644
--- a/arch/mips/ath25/board.c
+++ b/arch/mips/ath25/board.c
@@ -146,10 +146,10 @@ int __init ath25_find_config(phys_addr_t base, unsigned long size)
 			pr_info("Fixing up empty mac addresses\n");
 			config->reset_config_gpio = 0xffff;
 			config->sys_led_gpio = 0xffff;
-			random_ether_addr(config->wlan0_mac);
+			eth_random_addr(config->wlan0_mac);
 			config->wlan0_mac[0] &= ~0x06;
-			random_ether_addr(config->enet0_mac);
-			random_ether_addr(config->enet1_mac);
+			eth_random_addr(config->enet0_mac);
+			eth_random_addr(config->enet1_mac);
 		}
 	}
 
-- 
2.15.0

