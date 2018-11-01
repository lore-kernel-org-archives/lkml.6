Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F5F5ECDE44
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 01:52:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25E7320823
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 01:52:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25E7320823
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727604AbeKAKxo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 06:53:44 -0400
Received: from mout.perfora.net ([74.208.4.197]:38407 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725970AbeKAKxn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 06:53:43 -0400
Received: from localhost.localdomain.ziswiler.net ([188.155.129.42]) by
 mrelay.perfora.net (mreueus001 [74.208.5.2]) with ESMTPA (Nemesis) id
 0M0BFi-1fQC3P243I-00uMgE; Thu, 01 Nov 2018 02:52:48 +0100
Received: from localhost.localdomain.ziswiler.net ([188.155.129.42]) by
 mrelay.perfora.net (mreueus001 [74.208.5.2]) with ESMTPA (Nemesis) id
 0M0BFi-1fQC3P243I-00uMgE; Thu, 01 Nov 2018 02:52:48 +0100
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org
Subject: [PATCH v1 2/3] clk: tegra: ignore unused vfir clock shared with uartb
Date:   Thu,  1 Nov 2018 02:52:29 +0100
Message-Id: <20181101015230.27310-3-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.5
In-Reply-To: <20181101015230.27310-1-marcel@ziswiler.com>
References: <20181101015230.27310-1-marcel@ziswiler.com>
X-Provags-ID: V03:K1:e1CqOHOEs4M1SEgX2DGOkF4v5MBlnjgBGN6pOrvzsFMZau68mgk
 I3MOAy0uxuM/gvReS6pEuk3A8GgCGWbQbLjBBmn6xhcRRmYVhiSNzxuDf4Z1JUzNqbUl0Lu
 R8UnMNUPtTBGOgmvzC8KIApvwsner9n2bUvD2AF2WFldL5SXH95Qftj6UIotxBwDhwNjNyO
 AJb3qusc7vmymucHWpddA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Mqa6rCbUyBA=:bDJjKru8mG+HIh4wwtJ0nS
 4ulkAJWNMo5Tb8NJ2kwuSUTOXD/Vyj/i1XDpjK+lykndj9wg7KVLGqj9w9U1wMXR2a5nwkbEj
 W0aIhksC46hSi8/eBZOzH3W4CvF8r5EZ18qDNZYadWlOPc4XkVNYZxHTCDqZrAyXnqKzyHg79
 4eMt500TOsWSwhPjk7iej77lh73Y5ddXsk4PO+fR+kQ4QhkN6DBAn3bMPttjBzUm6z4VKONbq
 oz2XYu2noMNcK89zP8kifFboY5+y5EZVOMG0gcTSwcXz99fujtiqCDdXzcuGKaE5Q+o9EQGwU
 BpnVEgKzWbXvMFF87FMRLVToNCF9cmhP+6K9NVmUSDiMph8neEXowGYZFAwiWp//34/BV8LGw
 h3vl0Rgqf5Hslt/NycWn1SHxajRBoRBafzMg1PLdqam4sXFZajSUz6kwBuggDVHGUBbHTsIT0
 i8ckuWQIb079NmG6y6mbkZMJy2NtHTnLO/y5dl+PD+u4QW3XY9LJ6FR6ijCX0tFloPbwJXyFk
 dfcXaDWY2/m7Jg3YSw3Zizg9PMqcTFtrUb1jH4eIIxKpIkq7jCFKASPqYKOBreeStJit6Dtpp
 3+6DAyjZELspdhtEljK+wYDDrh3Mpf6k2G6JjSPMTYbVOYDn14TQAi85mocHqcDYRIiKV1tzI
 pF2YMyNOmlBimziafvdyQeSwt0tPfyD2aJpTG/eQ8MCtR22rlUddDCC2vEdYcEOZE6Ng=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

As UARTB and VFIR share their clock enable bit it is rather unwise for
the kernel to turn off the VFIR one should that be unused (and
potentially vice versa but so far there anyway is no VFIR driver).

Without this patch trying to use UARTB with the regular 8250 driver
will freeze as soon as ttyS1 is accessed after boot. Luckily, using the
high-speed Tegra serial driver won't exhibit the issue as clocks are
dynamically enabled/disabled on every access.

This has been reproduced both on Apalis T30 as well as Apalis TK1 but
may be an issue on all Tegra UARTB's which share the clock enable with
VFIR.

Reported-by: Kory Swain <kory.swain@trapezegroup.com>
Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

 drivers/clk/tegra/clk-tegra-periph.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/tegra/clk-tegra-periph.c b/drivers/clk/tegra/clk-tegra-periph.c
index cc5275ec2c01..116c74340fb7 100644
--- a/drivers/clk/tegra/clk-tegra-periph.c
+++ b/drivers/clk/tegra/clk-tegra-periph.c
@@ -668,7 +668,7 @@ static struct tegra_periph_init_data periph_clks[] = {
 	MUX("hda", mux_pllp_pllc_clkm, CLK_SOURCE_HDA, 125, TEGRA_PERIPH_ON_APB, tegra_clk_hda_8),
 	MUX("hda2codec_2x", mux_pllp_pllc_pllm_clkm, CLK_SOURCE_HDA2CODEC_2X, 111, TEGRA_PERIPH_ON_APB, tegra_clk_hda2codec_2x),
 	MUX8("hda2codec_2x", mux_pllp_pllc_plla_clkm, CLK_SOURCE_HDA2CODEC_2X, 111, TEGRA_PERIPH_ON_APB, tegra_clk_hda2codec_2x_8),
-	MUX("vfir", mux_pllp_pllc_pllm_clkm, CLK_SOURCE_VFIR, 7, TEGRA_PERIPH_ON_APB, tegra_clk_vfir),
+	MUX_FLAGS("vfir", mux_pllp_pllc_pllm_clkm, CLK_SOURCE_VFIR, 7, TEGRA_PERIPH_ON_APB, tegra_clk_vfir, CLK_IGNORE_UNUSED),
 	MUX("sdmmc1", mux_pllp_pllc_pllm_clkm, CLK_SOURCE_SDMMC1, 14, TEGRA_PERIPH_ON_APB, tegra_clk_sdmmc1),
 	MUX("sdmmc2", mux_pllp_pllc_pllm_clkm, CLK_SOURCE_SDMMC2, 9, TEGRA_PERIPH_ON_APB, tegra_clk_sdmmc2),
 	MUX("sdmmc3", mux_pllp_pllc_pllm_clkm, CLK_SOURCE_SDMMC3, 69, TEGRA_PERIPH_ON_APB, tegra_clk_sdmmc3),
-- 
2.14.5

