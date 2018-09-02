Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 134DBC433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 10:10:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC87F20841
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 10:10:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC87F20841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727787AbeIBOZ2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 10:25:28 -0400
Received: from mout.perfora.net ([74.208.4.196]:45689 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727727AbeIBOZY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 10:25:24 -0400
Received: from localhost.localdomain.ziswiler.net ([89.217.215.226]) by
 mrelay.perfora.net (mreueus001 [74.208.5.2]) with ESMTPA (Nemesis) id
 0MdMQ9-1gDFUW2991-00IdMe; Sun, 02 Sep 2018 12:10:04 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v2 25/37] ARM: tegra: colibri_t20: add gpio hogs for gmi_wr_n buffers
Date:   Sun,  2 Sep 2018 12:08:54 +0200
Message-Id: <20180902100906.25792-26-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180902100906.25792-1-marcel@ziswiler.com>
References: <20180902100906.25792-1-marcel@ziswiler.com>
X-Provags-ID: V03:K1:MdY14yE8XR9FlqYu3hFYaJMvW+9myzzQcy2gKNmifn/k+us9vat
 llMOqITR9wMjXD/hpPk65UZyivDBdmCA91+zmSwTzoYAGNm/mz12SXf/LPBupLeioKLEVPc
 /i0F0xgUeDLQBKbiaVjchg7MCkRCwZ7LuzCZ19g5hfrnYp3QUSrSmU3ZJeYUY0nJgDguxCQ
 KWwqr0vb0Sy0+LLqZnVLA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:+Y+ca8vidq8=:1W4smz63ssxYWmZJVGFL07
 a/qTemBV+xpp4Z+MDipa5zn6ZGImYdYM4fACtW+tJEh7qK2TmXo3kR9AAd5D+C9VUOhlE6231
 8qUPW+2juD0oKf6zYzqvEjOtEJjVGo6fYhAYugvkLJMPKK2WGiWgdHCdMjgK3JLoI7+a+BTEX
 UEB5DWpFe4+e4y3S0r8AaUO4cDS2MSyJq47q34Y3GDIDFazFEtkdsC3m4Dk/ZUJaDy6RhH0RD
 oimYXkoMZKkR7nLP2rG5limUsLFdFEg8/jJRV5zfuKKeNzYbYkqpiIaHd9lhJ6FGHyq08PpGF
 aMdL/FUqLaQh3q6Nmew4QRAFt+gWjNkMCxQF8i5Fm/1HO/hxPaJJvO6+CCtlRi3YvlyeJEVIs
 r7aHuP19AnrY2t2J658DlGMHh1JRoZDOxVvBXXM5wEfZhFj2H4f16RSq3/4Fgb7sAI+v/trmU
 9px/n4RiTq6hxk+jkqDOZ08z70/qo44V/gXSN0Eqy9PELPAF+q7Qs1Sz+qnvl6lk6a7a+QTqQ
 3hrbGWdpWd+92XxmWN087talNgVJ60UzXhAbYilv5uEBrxlpOBAeVeLIPNgkytID4sNd10YDF
 m47h+jWnS6syxyW8TyMF0TXA+Hua1hjmkM1P21S1dxtdQQcvGIkU6IgsO6X/lbMZrLCy5p6q9
 CwhBYKy6XfOTXSRTGGZBCghFTOHAbg0LuNcvZte1WZsDGx2GAL313I389MGw3bS60tbY=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Add GPIO hogs for GMI_WR_N buffers:
- tri-stating GMI_WR_N on SODIMM pin 99 nPWE
- not tri-stating GMI_WR_N on SODIMM pin 93 RDnWR

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

Changes in v2: None

 arch/arm/boot/dts/tegra20-colibri.dtsi | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm/boot/dts/tegra20-colibri.dtsi b/arch/arm/boot/dts/tegra20-colibri.dtsi
index 281e0dd11565..aba56b447bcd 100644
--- a/arch/arm/boot/dts/tegra20-colibri.dtsi
+++ b/arch/arm/boot/dts/tegra20-colibri.dtsi
@@ -757,4 +757,20 @@
 		output-high;
 		line-name = "LAN_RESET#";
 	};
+
+	/* Tri-stating GMI_WR_N on SODIMM pin 99 nPWE */
+	npwe {
+		gpio-hog;
+		gpios = <TEGRA_GPIO(T, 5) GPIO_ACTIVE_HIGH>;
+		output-high;
+		line-name = "Tri-state nPWE";
+	};
+
+	/* Not tri-stating GMI_WR_N on SODIMM pin 93 RDnWR */
+	rdnwr {
+		gpio-hog;
+		gpios = <TEGRA_GPIO(T, 6) GPIO_ACTIVE_HIGH>;
+		output-low;
+		line-name = "Not tri-state RDnWR";
+	};
 };
-- 
2.14.4

