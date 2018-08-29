Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D716CC433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 08:15:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FFA52086B
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 08:15:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FFA52086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728504AbeH2MKw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 08:10:52 -0400
Received: from mout.perfora.net ([74.208.4.197]:47753 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727712AbeH2MKv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 08:10:51 -0400
Received: from localhost.localdomain.toradex.int ([46.140.72.82]) by
 mrelay.perfora.net (mreueus001 [74.208.5.2]) with ESMTPA (Nemesis) id
 0M7Imm-1fg7pw38S6-00x6Ce; Wed, 29 Aug 2018 10:15:03 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 23/31] ARM: tegra: colibri_t20: add i2c-thermtrip
Date:   Wed, 29 Aug 2018 10:13:59 +0200
Message-Id: <20180829081407.11304-24-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180829081407.11304-1-marcel@ziswiler.com>
References: <20180829081407.11304-1-marcel@ziswiler.com>
X-Provags-ID: V03:K1:nEpgXAdmIyxaTfzy28/DMtqo1iPqLbltasFqP+NZXQMMVcgTahd
 ynuixmgs/jfYtnCdiouq8mFHX23O84vzCm/h44HQvK3syelg7AhweUIP4ZmcyWaPMgNtYXn
 jGjE9wsa7s6wOJvk5Js1dMDQui/Q5aS+hnRX7f/lybJgEDXuKraEn9nJfBjvTbgoZ56BMH/
 FaNe+cJGhseDKfBaycL5A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:/qEUGH2HDaw=:40wGAcYh8S8bBpCStph9Zh
 GyApNEoQBVe878WABjKgcNB06BVGJzeuFh6EUuQN+7FxT3pWGZGgc1iCmLiKgQrLetxmauAqH
 jekNgqJoC8IPVdyOawZiRpwxL0cv8Kuz49h1s1ONYp3UnkYdUo7MMdRp0Eb40b/Cob3Duxbqd
 PbUMhP1wBcfUvwg/vACYcthdpKtrzg94c6QzBruYTZ8FWhmmtfv67BQDCEDYqwKc0tCBAYrF0
 YqLzKKCrdRWkUIAiI3O7zEUL1zc9rBfVkkEnWx9OMHWAbSet4JvI/MpqJjcgXLNTmB/nhVRmJ
 ySNQTJ4cT/pkMaZdo1CYxo/2ZfcMVI7ns12VhZwgLwNO+C2Uqly6bl0Wxig86e/Av0phRwewY
 ZJ8j9/d8Nvv1z62l6MKRKbEmM9JBOR80yKc8ZcZl9P2nCoURN8se7+DQLfnQ2HoP2cqv7xkM6
 JxCfs0SMefHywu4IMxQTO4pdtmBWK47a1uQr/Xy3glfndNTwig9aPbWTFDlaqaq8RSokKaS+e
 HTOXyJxVKWJISbzcTV4gCENTrl+8Z2ITVx7AIW/6swlm4VMACjE56KQ11KES/qP1vLaqq0Vl1
 gIo9EXPU8lnhxqT7ylgErNf34iiv3yy/sYwYQQ/rgWRgotDzKoWlpCQ7zsOY+N6n9X1PDw4NO
 F1uRSt8w25ToTAASQyPiK3wp9B8yA9Ps5kccpeL4Y3c/qJgl/j/I2MEH01382UmCjG80=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Add i2c-thermtrip which would set the SLEEP MODE bit in the SUPPLYENE
register of the TPS658643 PMIC.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

 arch/arm/boot/dts/tegra20-colibri.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/tegra20-colibri.dtsi b/arch/arm/boot/dts/tegra20-colibri.dtsi
index d03b2a290303..470ef1f09167 100644
--- a/arch/arm/boot/dts/tegra20-colibri.dtsi
+++ b/arch/arm/boot/dts/tegra20-colibri.dtsi
@@ -598,6 +598,14 @@
 		nvidia,core-pwr-good-time = <3845 3845>;
 		nvidia,core-pwr-off-time = <3875>;
 		nvidia,sys-clock-req-active-high;
+
+		/* Set SLEEP MODE bit in SUPPLYENE register of TPS658643 PMIC */
+		i2c-thermtrip {
+			nvidia,i2c-controller-id = <3>;
+			nvidia,bus-addr = <0x34>;
+			nvidia,reg-addr = <0x14>;
+			nvidia,reg-data = <0x8>;
+		};
 	};
 
 	memory-controller@7000f400 {
-- 
2.14.4

