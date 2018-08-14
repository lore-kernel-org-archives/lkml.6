Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F42BC46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 14:07:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62A242172C
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 14:07:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62A242172C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732595AbeHNQyd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 12:54:33 -0400
Received: from mout.perfora.net ([74.208.4.196]:46431 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731162AbeHNQyd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 12:54:33 -0400
Received: from localhost.localdomain.toradex.int ([46.140.72.82]) by
 mrelay.perfora.net (mreueus001 [74.208.5.2]) with ESMTPA (Nemesis) id
 0LamcQ-1gI0t23U1A-00kM1c; Tue, 14 Aug 2018 16:06:37 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        linux-kernel@vger.kernel.org,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Stefan Agner <stefan@agner.ch>,
        Tony Lindgren <tony@atomide.com>,
        Eric Anholt <eric@anholt.net>,
        Russell King <linux@armlinux.org.uk>,
        Simon Horman <horms+renesas@verge.net.au>
Subject: [RESEND PATCH 3/6] ARM: multi_v7_defconfig: enable dynamic debug
Date:   Tue, 14 Aug 2018 16:06:09 +0200
Message-Id: <20180814140612.12554-3-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180814140612.12554-1-marcel@ziswiler.com>
References: <20180814140612.12554-1-marcel@ziswiler.com>
X-Provags-ID: V03:K1:44s+pxNkrcHfgqTBHgK7ITMqV6VEDWdqDWF+tDzX6uM6xCYhAtG
 ThFUGQiQ7k0egbICio2ubP83VCAoo2YEaRE75XgcanbD3TOH6fJiZQhnz9FY35E2HZopBHO
 STLZnrDTimFdnPCDmV+1gwf98d/gfk6zLl97eCGx8EyQVrKNBuwnJZqAM/96JoHe2alOoYv
 cT4kLhRyB6Z4EU0pk32Fg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:aCC3U0JaqpA=:u3Gzi8fZKoGGRajPLB9B1c
 Mfcd85naxrfsn338CWypPjUZ3JYoBdPPUSKZ+2vdCNZ6mI5TUhUanLoeA/LwzSVsdvV7Qn3o1
 NqLrf68G4y6uhP1XMo7PfsTsVieir025Y/CMCOmvXAIl+eb4xynGt7lrNQgFPGfZMlO+oVB/P
 ehYFfVs+Fsuop1JpylM6W2QrlLoStDi2ytAkCymsl3wSRxPmIFnd6TzsPgiHNg96BfG2/NXj8
 0+NkDR/9PHMaZC8gIR17K1J4NJwzvSOs8GRVdAgmuvBx5DxJTDpc6bM9lVMgaJMYmij0r72dB
 nk+vV8BxCny8OP8VDGdmtn2WHUMdZYZ1zPmFFsFriFVdLxyUYWKCOpI1o66CGCEZnal+CB5zP
 el/Dq+OO59EUugX+Z7omErxYJjJgpxwzkU02GFrHB2P91uFwIHI6FIaBzC+lX3qhTwDddshWf
 oL1p3XYgATMykfjgkap86kOlEVQ1uqj9h3ZbrxgpgqmBtzAOuzP+CF234tF4gPOOUv5is0qQ4
 Ro6g6z7qURLE+bN95z8iQwrRdj/ru0lMjpHlrsDF/DoMCjlcQuaapAwVCuZDUnM9FWgl7ye5d
 xMEveyOerOhFzOw4Xqdu6Icb27L6w3dRtp5y1zIGVpXl8JyrmqjcWbEKq0yngLuEyKL0+gqe4
 MG54TFuZimv1vXSDG5JDrjy2wAEs/9Y0Dc7JctcweA9/XeWRJSs9Edo0ljymdq6RVsic=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Dynamic debug is really helpful.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

 arch/arm/configs/multi_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 1299c0cf2f3a..65646b39430b 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -976,6 +976,7 @@ CONFIG_NLS_CODEPAGE_437=y
 CONFIG_NLS_ISO8859_1=y
 CONFIG_NLS_UTF8=y
 CONFIG_PRINTK_TIME=y
+CONFIG_DYNAMIC_DEBUG=y
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_CRYPTO_USER=m
 CONFIG_CRYPTO_USER_API_HASH=m
-- 
2.14.4

