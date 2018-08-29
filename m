Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94664C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 08:15:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 570A220684
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 08:15:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 570A220684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728515AbeH2MKy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 08:10:54 -0400
Received: from mout.perfora.net ([74.208.4.194]:58289 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727712AbeH2MKx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 08:10:53 -0400
Received: from localhost.localdomain.toradex.int ([46.140.72.82]) by
 mrelay.perfora.net (mreueus001 [74.208.5.2]) with ESMTPA (Nemesis) id
 0Mgdfd-1gFSet46tD-00O2ZF; Wed, 29 Aug 2018 10:15:05 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 24/31] ARM: tegra: colibri_t20: add gpio hog to unreset usb ethernet chip
Date:   Wed, 29 Aug 2018 10:14:00 +0200
Message-Id: <20180829081407.11304-25-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180829081407.11304-1-marcel@ziswiler.com>
References: <20180829081407.11304-1-marcel@ziswiler.com>
X-Provags-ID: V03:K1:jboC2MwkxduzcYNkSWIyTrqOBQsZZxBkQm1OdR7KTcWvQFqUZlg
 8Dl48A8GUB0kAIGvvUPwNF1H2ukVam5JMeNTd1JIM0Qw4oD3TRcu2IRtiK86fJW2PI+Ur6J
 kbIf7R1Hg32svPK6WZKe3/qkK1Mk4uxrITNZKycAbu6IgntIhQQ5SZ5kBw80xZrn4f19U1L
 6TsY/0Bq6TyhVFNrqInhA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:6gwtAR1Dje4=:T3HDNv44o0oAIS08+35N4G
 BD70Pq2Lmn/UK9NW4Jei2sVTiXQkTrveh680ldLxEaZkVTmsN5dQnSJ7E5Cq/2aeH9YdUwinO
 hgxUJudq9Kd4a87QYiaXOQcYNXWxmlhjEKn3UtY7chrCr8qmwY9cdbSMfCQHHs7NnEAr7mW7G
 0fcEcRNN59XGvexipYnndLDAn92kZXgjf3VyBie8YMOIBo0qVktnFY2t+Iki+7vxdbx/8R1Ce
 NooIeTCiX5OnlUUBYu1cieml7K4Gz5wwWyX1r2i/UuzAg6ItGZatjN4WyauRf/oJqZYah9lBq
 P1usae2AjBBj7aO5lCPVTL9+6SHyeMym9Bqyu8oTm1GduogJ+DnfE0mCcbeUUxej4ODJWVGyi
 +msLPShCEbf1OXiSLoXF+7+e/GEKkAWioZcYwF/9GsiyFaDrLdE1L5NVN8RoKeiljowUOU9JN
 Oy7O50wI0TaPgUDXZAijnrRvM8huS/+o4pvEaCguz4KxK2YqzFl4+MOM5rm6oum4Wtp0UoLo+
 WXeZgSPkI7gggCxte+xbq1Y5EUfg1tfIYsab6NNjhSLNJl3mn8N90e6vZmibWPWtRVGLvYUWr
 n2H7cNoE9s8murkT8y5suv9n8Bf5hUD3ktC1Vkkpg26mrodqEIcOV4QD3rrrGPabCskRy9J1p
 AsPf5HkMh7i0v9UdxkeJkzvQkNlJxzmjkYdwunn64HY6uw5P5iPCQkOFMfCcstfvkjTw=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Add GPIO hog to unreset ASIX AX88772B USB Ethernet chip.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

 arch/arm/boot/dts/tegra20-colibri.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/tegra20-colibri.dtsi b/arch/arm/boot/dts/tegra20-colibri.dtsi
index 470ef1f09167..339316dd57e9 100644
--- a/arch/arm/boot/dts/tegra20-colibri.dtsi
+++ b/arch/arm/boot/dts/tegra20-colibri.dtsi
@@ -749,3 +749,12 @@
 		clock-names = "pll_a", "pll_a_out0", "mclk";
 	};
 };
+
+&gpio {
+	lan_reset_n {
+		gpio-hog;
+		gpios = <TEGRA_GPIO(V, 4) GPIO_ACTIVE_HIGH>;
+		output-high;
+		line-name = "LAN_RESET#";
+	};
+};
-- 
2.14.4

