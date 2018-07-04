Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24DA2C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 11:51:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CED7021738
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 11:51:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CED7021738
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934356AbeGDLuR (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 07:50:17 -0400
Received: from albert.telenet-ops.be ([195.130.137.90]:52814 "EHLO
        albert.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933801AbeGDLuP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 07:50:15 -0400
Received: from ayla.of.borg ([84.194.111.163])
        by albert.telenet-ops.be with bizsmtp
        id 6bqE1y00Q3XaVaC06bqEWB; Wed, 04 Jul 2018 13:50:14 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ayla.of.borg with esmtp (Exim 4.86_2)
        (envelope-from <geert@linux-m68k.org>)
        id 1fagIY-0005pk-CY; Wed, 04 Jul 2018 13:50:14 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1fagIY-0007Jh-Ba; Wed, 04 Jul 2018 13:50:14 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     "David S . Miller" <davem@davemloft.net>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Solarflare linux maintainers <linux-net-drivers@solarflare.com>,
        Edward Cree <ecree@solarflare.com>,
        Bert Kenward <bkenward@solarflare.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 1/3] net: ethernet: Make NET_VENDOR_AURORA default to yes
Date:   Wed,  4 Jul 2018 13:50:11 +0200
Message-Id: <20180704115013.28078-2-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180704115013.28078-1-geert+renesas@glider.be>
References: <20180704115013.28078-1-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enabling NET_VENDOR_* Kconfig options does not directly affect the
kernel build.  Hence NET_VENDOR_AURORA should default to yes, like other
NET_VENDOR_* options.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/net/ethernet/aurora/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/aurora/Kconfig b/drivers/net/ethernet/aurora/Kconfig
index 8ba7f8ff3434000f..392f564d8fd436f2 100644
--- a/drivers/net/ethernet/aurora/Kconfig
+++ b/drivers/net/ethernet/aurora/Kconfig
@@ -1,5 +1,6 @@
 config NET_VENDOR_AURORA
 	bool "Aurora VLSI devices"
+	default y
 	help
 	  If you have a network (Ethernet) device belonging to this class,
 	  say Y.
-- 
2.17.1

