Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 0527EC004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 19:43:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF6D7208D4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 19:43:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=roeck-us.net header.i=@roeck-us.net header.b="knklPU56"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF6D7208D4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935570AbeFMTn4 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 15:43:56 -0400
Received: from bh-25.webhostbox.net ([208.91.199.152]:60801 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935445AbeFMTnz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 15:43:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=roeck-us.net; s=default; h=Message-Id:Date:Subject:Cc:To:From:Sender:
        Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=4ctpdDcn6q56uXYZI0EgQq/kaSPaa2pjFMX+98Ildrg=; b=knklPU567ZqaE1wzNbNZPDAnHS
        bAIc/pU95++OGQmIxhkA3RPWQlMQiraiP8eigEFbUZcS5GuMty1hnNfWi09VuM3hOTtAyH71RVlrC
        YUT9mv2RcVP/C9/NW/8AhZOUP0kQFVM4eN7+5d4T+cVnXLNdDBHx9ZWfDgYh+q0nUE36CthRz6YRL
        lheLQVLv5X+vjCHfWgOFD7lmt6uwKSjUx21INrD/oBciUiIbXE8HdZv8G+nA8pqUC0e0cPEiXB6j0
        JkLdFaU5w+hl6o3BzpTvTViFRTgjU5XT+v+tgZVyEAQRQ33DabtFPypQq7Y5AkH8FxI7ntgneadEm
        u3fKNMnQ==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:59290 helo=localhost)
        by bh-25.webhostbox.net with esmtpa (Exim 4.89)
        (envelope-from <linux@roeck-us.net>)
        id 1fTBgQ-008qY0-Ea; Wed, 13 Jun 2018 19:43:54 +0000
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greentime Hu <green.hu@gmail.com>
Cc:     Vincent Chen <deanbo422@gmail.com>, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>,
        Matt Redfearn <matt.redfearn@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Palmer Dabbelt <palmer@sifive.com>
Subject: [PATCH] nds32: Fix build error caused by incomplete configuration flag rename
Date:   Wed, 13 Jun 2018 12:43:52 -0700
Message-Id: <1528919032-4874-1-git-send-email-linux@roeck-us.net>
X-Mailer: git-send-email 2.7.4
X-Authenticated_sender: guenter@roeck-us.net
X-OutGoing-Spam-Status: No, score=-1.0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-Get-Message-Sender-Via: bh-25.webhostbox.net: authenticated_id: guenter@roeck-us.net
X-Authenticated-Sender: bh-25.webhostbox.net: guenter@roeck-us.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GENERIC_ASHLDI3, GENERIC_ASHRDI3, and GENERIC_LSHRDI3 were renamed to
GENERIC_LIB_ASHLDI3, GENERIC_LIB_ASHRDI3, and GENERIC_LIB_LSHRDI3
without making the matching changes in arch/nds32. This results in
the following build errors.

nds32le-linux-ld: kernel/time/timekeeping.o:
	in function `timekeeping_init':
timekeeping.c:(.init.text+0x140):
	undefined reference to `__ashldi3'
nds32le-linux-ld: timekeeping.c:(.init.text+0x144):
	undefined reference to `__ashldi3'
nds32le-linux-ld: timekeeping.c:(.init.text+0x17e):
	undefined reference to `__lshrdi3'
nds32le-linux-ld: timekeeping.c:(.init.text+0x182):
	undefined reference to `__lshrdi3'
nds32le-linux-ld: drivers/clocksource/mmio.o:
	in function `clocksource_mmio_init':
mmio.c:(.init.text+0x54):
	undefined reference to `__lshrdi3'
nds32le-linux-ld: mmio.c:(.init.text+0x58):
	undefined reference to `__lshrdi3'

Fixes: e3d5980568f ("lib: Rename compiler intrinsic selects to GENERIC_LIB_*")
Cc: Matt Redfearn <matt.redfearn@mips.com>
Cc: James Hogan <jhogan@kernel.org>
Cc: Palmer Dabbelt <palmer@sifive.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 arch/nds32/Kconfig | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/nds32/Kconfig b/arch/nds32/Kconfig
index 6aed974276d8..3a68d9494035 100644
--- a/arch/nds32/Kconfig
+++ b/arch/nds32/Kconfig
@@ -12,9 +12,9 @@ config NDS32
 	select CLONE_BACKWARDS
 	select COMMON_CLK
 	select DMA_NONCOHERENT_OPS
-	select GENERIC_ASHLDI3
-	select GENERIC_ASHRDI3
-	select GENERIC_LSHRDI3
+	select GENERIC_LIB_ASHLDI3
+	select GENERIC_LIB_ASHRDI3
+	select GENERIC_LIB_LSHRDI3
 	select GENERIC_CMPDI2
 	select GENERIC_MULDI3
 	select GENERIC_UCMPDI2
-- 
2.7.4

