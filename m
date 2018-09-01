Return-Path: <SRS0=kg8+=LP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F9B1C433F5
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 08:14:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA28520841
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 08:14:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA28520841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728048AbeIAMZO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Sep 2018 08:25:14 -0400
Received: from mout.perfora.net ([74.208.4.197]:33793 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728030AbeIAMZO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Sep 2018 08:25:14 -0400
Received: from localhost.localdomain.ziswiler.net ([89.217.215.226]) by
 mrelay.perfora.net (mreueus003 [74.208.5.2]) with ESMTPA (Nemesis) id
 0MGyFo-1g8iMm3OKI-00Dl3K; Sat, 01 Sep 2018 10:13:59 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v2 30/34] ARM: tegra: colibri_t30: fix mcp2515 can controller interrupt polarity
Date:   Sat,  1 Sep 2018 10:12:44 +0200
Message-Id: <20180901081248.22639-31-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180901081248.22639-1-marcel@ziswiler.com>
References: <20180901081248.22639-1-marcel@ziswiler.com>
X-Provags-ID: V03:K1:20wxu5T6bpaAK4uq6KFiv9BYAXTAgIeqbRnp3H2TD5y+Azbwo8r
 kuW44I6GNm/wWnA5DZNN8cz1hrwIT9nnD6uYg9xio7HOLmUNHi2i7YOEgOIf4EhpXaZBQgu
 uiPGNQ1YjfBTbqtrAAKJoMNtJHfTI/JH9pwHw4ze+NMLmKD2kqqOqTIwcNM8LPiwSpCSyIj
 w7giaReVQiT8RrKRcRG8Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:nVO1S79G96Y=:JF/NbOcfBKN6yyYTj6Jugl
 Fh3sl4dnuANwlNA9gWxbT7JMzsdAJX9V0FzZajvxXeLaI/KBGH9cfVz3rRMT0Su1o0MX2XyYi
 rVDN4Fg1xx4vwjyA89oaH9oOCa2NGVIK6vBAFeJy47K9w58hXqfIftQ97Mnya5x0FavZNBmXL
 p8QMG0FpnDMoroA1686gY66gdrtsoidYuchW1t9IgEPgTVASCp+lCJkijKXcSgEnQHNwARy8R
 pfchvXQOlBHvW69nqjI81qk/gVar9ycon+ewARjfvW9cjzq2YvVlxa3o3YlOD8m/hfFOtCuGI
 CrpEwV2oI1AdKddunP4a1o63jGLi2qlhdVFwo0f3uRaPA3pbX5RLow6m6Xj3XBRSVQ8TVH94m
 2RwI4UOiMSPzvh+IvUuYR0doINLuIR1yYVrOdfutvBSfhcHV5X7m0HDQ1c94P+5Taft+i1Q0V
 IU8vGKzMxXA7LE5bilNSUOQh3rIkv3cJH+xWoC40cVy9gGOCNDk66XAlXmML3tfwuOD7Shdfn
 a5HO5N8PYZSGN//TdWv8A9ACnGRXKyAaMARgx/FPrVZtZFsf1+cOt2zu0qJLY6k6nKE1/kWTF
 OcEtbL5A1N+pIQa2+PGMfNKQydwJgdm9tuQuWju6xr+h+8h9aDaZLgRUkanrhnGt1CnKiABZi
 /rZ8PusZKXohBRrcFTbhWBoj4YJPv1nZr7PgKvYvXVT44WD3ajpAbHTnzbPZUeo/iC8c=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Fix the MCP2515 SPI CAN controller interrupt polarity which according
to its datasheet defaults to low-active aka falling edge.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

Changes in v2:
- New patch.

 arch/arm/boot/dts/tegra30-colibri-eval-v3.dts | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/tegra30-colibri-eval-v3.dts b/arch/arm/boot/dts/tegra30-colibri-eval-v3.dts
index c63ef3aedb7a..ee0a3e5df5b8 100644
--- a/arch/arm/boot/dts/tegra30-colibri-eval-v3.dts
+++ b/arch/arm/boot/dts/tegra30-colibri-eval-v3.dts
@@ -85,7 +85,8 @@
 			reg = <0>;
 			clocks = <&clk16m>;
 			interrupt-parent = <&gpio>;
-			interrupts = <TEGRA_GPIO(S, 0) IRQ_TYPE_EDGE_RISING>;
+			/* CAN_INT */
+			interrupts = <TEGRA_GPIO(S, 0) IRQ_TYPE_EDGE_FALLING>;
 			spi-max-frequency = <10000000>;
 		};
 	};
-- 
2.14.4

