Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19183C46460
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 14:07:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C15152172C
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 14:07:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C15152172C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732628AbeHNQyh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 12:54:37 -0400
Received: from mout.perfora.net ([74.208.4.196]:42759 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731162AbeHNQyh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 12:54:37 -0400
Received: from localhost.localdomain.toradex.int ([46.140.72.82]) by
 mrelay.perfora.net (mreueus001 [74.208.5.2]) with ESMTPA (Nemesis) id
 0MFrSS-1fcv2Z1YRi-00ErYo; Tue, 14 Aug 2018 16:06:45 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Olof Johansson <olof@lixom.net>, linux-kernel@vger.kernel.org,
        Stefan Agner <stefan@agner.ch>,
        Tony Lindgren <tony@atomide.com>,
        Eric Anholt <eric@anholt.net>,
        Russell King <linux@armlinux.org.uk>,
        Simon Horman <horms+renesas@verge.net.au>
Subject: [RESEND PATCH 5/6] ARM: multi_v7_defconfig: enable tegra raw nand driver
Date:   Tue, 14 Aug 2018 16:06:11 +0200
Message-Id: <20180814140612.12554-5-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180814140612.12554-1-marcel@ziswiler.com>
References: <20180814140612.12554-1-marcel@ziswiler.com>
X-Provags-ID: V03:K1:sMxs87CR4jHP29/DSP6Fq+dZTD6/I3hjFDLU3FH1W7CU4oGbKuy
 m344IDfhgMvQoDP9A2rssVmVIVYuqL7opW2DPXH6QQP7LUf5A8uVOVusG3g8tIYyGfU/yHC
 N+pgeatEJmsIRiY/UfWwFc1XR9zF2abd0i6jXW51+MTaN1ViDRDpizZ/hCDQN5m5Di6FNUp
 M6BqNGKa6kj5r0Aq+pt8g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:19n7JeRW3PI=:/TCDT4LTxNBwo3vh3zm0R/
 MoXhthSOllG0ofUMjQHrtbZnGbrrgHdOf78pa2TIen1kwdFWv932Fo99ohIIH4t+CW1nhifU/
 id7Ep9xNAUj5T6filozongS+CIMp1HRWH4xzPRLA6qWrKGN4sCLdPMZT38dFrbI3Z67X0de5v
 MjHht423Xnfnj72U2iHCefCLNRjo89blpNhJkC4kN+x8WMk19CdU4b8kMCIdp+2AzhGYVOAkL
 OIMuCvQo9zn4NKsCG+6jx2wawKf2XhiqrewXzVSxmTimMtrzgJcsduJ+j8fsi6q1FCQ5MY/pR
 d2lo1gCEbJCtDlaEA6nZsL3/XC8hNVJHJElyr4hPE/TjHHWHQfIkw0rEDRXnKf/SAAU6Qa1+T
 pXFR4C8EzutyOzdzO5YH0EXrc4YrOMjwlA22LqWBl7i5F/11akiziXeKtZcZ1rvz4o0+qWuUM
 G6nSE1mh+PBI1ZX0WMkGo7GbOjqsGMYDNaiARZUGxSDIkR3FmmtSHH0ivANi+OZmmPtZGjeET
 +SPeGM/LKL8TCyCnvdohsLlcO9St2C7BY2tHdR0qMRKw1meH22Jc4qU016eJjx8yeMRn7KVlV
 7QrymUUJS2Jz8dxw2fAIOEVhJFMDpKYLkr/ij95TNa2dKUaHSwJhYw6F4aTlxk+aj14BlF3gE
 ZttyLabjRipxIGnj/j/UsADt2LadqLpdO6jG5fmFzNrqwUqmJXVw+MpbKpCjRMLLdyi0=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Now with everything being merged actually enable it.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

 arch/arm/configs/multi_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 65646b39430b..5420b48ded2a 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -190,6 +190,7 @@ CONFIG_MTD_NAND_GPMI_NAND=y
 CONFIG_MTD_NAND_BRCMNAND=y
 CONFIG_MTD_NAND_VF610_NFC=y
 CONFIG_MTD_NAND_DAVINCI=y
+CONFIG_MTD_NAND_TEGRA=y
 CONFIG_MTD_SPI_NOR=y
 CONFIG_SPI_FSL_QUADSPI=m
 CONFIG_MTD_UBI=y
-- 
2.14.4

