Return-Path: <SRS0=OrLK=KG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0606ECDFB8
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 16:50:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A45AD20874
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 16:50:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A45AD20874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731368AbeGVRr4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Jul 2018 13:47:56 -0400
Received: from mout.perfora.net ([74.208.4.196]:52249 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729936AbeGVRrx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jul 2018 13:47:53 -0400
Received: from localhost.localdomain.ziswiler.net ([89.217.215.226]) by
 mrelay.perfora.net (mreueus001 [74.208.5.2]) with ESMTPA (Nemesis) id
 0LtH6j-1gAbxn32nT-012qSi; Sun, 22 Jul 2018 18:50:29 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 22/28] ARM: tegra: apalis_t30: add i2c-thermtrip
Date:   Sun, 22 Jul 2018 18:49:30 +0200
Message-Id: <20180722164936.20581-23-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180722164936.20581-1-marcel@ziswiler.com>
References: <20180722164936.20581-1-marcel@ziswiler.com>
X-Provags-ID: V03:K1:xhbqJ+m/lbCKpY7ODcHscpuB+Vm38eEqryPLXMOuYnO5eLnHs3n
 +3t/yPlPU1ehQsD4raFEdfHZKnwJ+m5jlFuaIGHzuuFzu+NascrRUlttD2S7O9UFjmbwZF1
 fZBTdeHrQfVgdrlEZX+Q8hHjxNL/lmr/F8gQVdG11rqFJ24ti4bNCyh9UOY06tGcoGGVm9X
 Ci3q+zxKcmPF28FP5+hcA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:4pBafLTe+v0=:rUgs2J69lYEkU8sAsQ5+Hb
 EnfqKQW+w2ZuAGjm2TnWF4k74SnvknZZF3iG+FGX2P82gGKv3YZtldB1kgZkBi7UtBs4r6zty
 J8OkntL4LcjfOsS+ejYRlfbX5ePIYrU+isYmBl+S3EgvOU4TpTEyGfACwgza3SXtwdw4TFK+W
 6StlmsIEKkVZ8yaIWnVwiT/k3zeqxNeIUpk+ya4FerRgQI5H+2AolJLtBbsDR+7IPlqHGZVfd
 WuKEy7uWt5aNwZgHwoAyZ/aaQhoC4HgWlyxbHOhWrIXeaKiX7TFZD1xE86wQSOAV3Ueb4oDGx
 ofGKn/HYqnKvRxBrlUK3xv3+VX5N+cnB5MnNYtnMFLJxeLiuEpTAFIpqcgWBJY9ir5rTkopk9
 aBR6ZN58cQzR3Bmacgh64MPRxS7uVXBl4XAnUJvT8h75UZmYlnhVPrHMeLZyJTkv2Z7rjxtJ/
 XTtYCHYPky2dTvbLgFdSRiv08paZ3TRKzaVSqmK3sBmnTzMCFSTltifvPzzS0zdXzbkHvI8lE
 enaWMxWV7MEynL5r3O160CPH0NIKwMQA5RV8OaWC6WAB0QUHSPA8vLoZQazq/eG1EckI6cD0p
 XEdkGIXDm1qEUmz7eoVX4mJdnwQnCEiaXJOR5tXaFcTCXM0sSGSrwBsFDfyw5WBmZp2mxpbtE
 imnoNIHGAXw9Y6Zkmf4/BmgjeUjnLdNPNLn4okYhGUfO5GDNuuxyrNpDTPUiWjOqajbc=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Add i2c-thermtrip which would set the DEV_OFF bit in the DCDC control
register of the TPS65911 PMIC.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

 arch/arm/boot/dts/tegra30-apalis.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/tegra30-apalis.dtsi b/arch/arm/boot/dts/tegra30-apalis.dtsi
index 4e8ea1a8d9ec..f8caf3f07fff 100644
--- a/arch/arm/boot/dts/tegra30-apalis.dtsi
+++ b/arch/arm/boot/dts/tegra30-apalis.dtsi
@@ -1055,6 +1055,14 @@
 		nvidia,core-pwr-off-time = <0>;
 		nvidia,core-power-req-active-high;
 		nvidia,sys-clock-req-active-high;
+
+		/* Set DEV_OFF bit in DCDC control register of TPS65911 PMIC */
+		i2c-thermtrip {
+			nvidia,i2c-controller-id = <4>;
+			nvidia,bus-addr = <0x2d>;
+			nvidia,reg-addr = <0x3e>;
+			nvidia,reg-data = <0x1>;
+		};
 	};
 
 	ahub@70080000 {
-- 
2.14.4

