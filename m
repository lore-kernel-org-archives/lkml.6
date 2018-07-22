Return-Path: <SRS0=OrLK=KG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B64F5C6778A
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 16:50:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70A5420874
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 16:50:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70A5420874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731443AbeGVRsE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Jul 2018 13:48:04 -0400
Received: from mout.perfora.net ([74.208.4.197]:45573 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731398AbeGVRsB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jul 2018 13:48:01 -0400
Received: from localhost.localdomain.ziswiler.net ([89.217.215.226]) by
 mrelay.perfora.net (mreueus001 [74.208.5.2]) with ESMTPA (Nemesis) id
 0LfAKc-1gMtmQ3nXE-00ojh9; Sun, 22 Jul 2018 18:50:39 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 27/28] ARM: tegra: apalis_t30: fix pcie switch vendor compatible
Date:   Sun, 22 Jul 2018 18:49:35 +0200
Message-Id: <20180722164936.20581-28-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180722164936.20581-1-marcel@ziswiler.com>
References: <20180722164936.20581-1-marcel@ziswiler.com>
X-Provags-ID: V03:K1:J27JfE6Rr9FD+PZOpGEQ1LcY6Vw/bobPknY620KYrSakOd9GngT
 +Ixs6LPhp0h/KmgR3UYHLax9JgCJNqmPuFweiuNf55Pf2jqIgZIjEtCPJJS6NCWuHGsnHKa
 xO/bRLlnXVzMUhY6ySYUNimeuByC6lO0KS/x7v2TMCTTes+q9Ks0bN1EOdD/piAB0VZZb5z
 Q85cMmkQUQJVWMjMy2Igw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:wQNkHcrcpMA=:AOUE+BW9+9KnxYNyCL4MDu
 swdp6oZYGBrKOlsdCjgcm+w5SIta5bdLrZMvqV+LE0BRg1SzUREUqCfZ+7anSSjHw+fEc4zga
 Y0FAzaUsX0upVN1OqXUlxgEX8z8CNxH/VgFT9r0Jz9FCJhQlsEn41V7bzojCceD5ieFIBht+z
 12NWpwsFzy2H755VswABFf0OKUOImjg7nVIuOgQe2K3iDbg1RB7xrnLypWnrzNzixExQ2dJMZ
 tJxKqBl6T5mHc9VRTZd0a06EDdczdUmyImM39CopuWUgGjP0WJDEHnnRAvvUjTzEYxCZouZOW
 FtelB12QNVLYYhaW5Q6w3tJuuFu4alj2NZCJAvbH/3kbsnzQCqW/wocS2qF9d4TIxF+JvzpLY
 DwQ8qnh4jfJrwyvhOa8+Ta0SjFrOZ6dQmi1CCQpYPj2e/Ayn8Y1ZybudOWeEZ30qywCZkDmEc
 U+eSCwp6tyE+Kv7IiZwVeso2xO8xFs90y9LVC7XCid9oFZTOS3GKWfbUPapI5iC6Ks3jt8cHo
 dI2EuWp4KkkwQ5oxb+LKi/LGngu50FVuQG70HaJ3It22auxYYGUiyOsYKZf2i3FFD4qotfD5W
 Ma/mdf9uRvXDL0bKntxWLqma7hd7fPGwAW5q2LJYlMs5ZswmSdGOT/iJxdE1ilxmNbsUwlk6N
 et4GiiG6Vzunbubic8x+OZS6aTiCATYe0BEzU/5wQfCBRLky04LkOAzIXZXvlkPw+CAA=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

PLX got bought by Broadcom therefore fix device tree compatible string
vendor which silences the following checkpatch.pl warning:

WARNING: DT compatible string vendor "plx" appears un-documented
 -- check ./Documentation/devicetree/bindings/vendor-prefixes.txt

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

 arch/arm/boot/dts/tegra30-apalis-eval.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/tegra30-apalis-eval.dts b/arch/arm/boot/dts/tegra30-apalis-eval.dts
index 83949ac3cc07..2c4fee53425e 100644
--- a/arch/arm/boot/dts/tegra30-apalis-eval.dts
+++ b/arch/arm/boot/dts/tegra30-apalis-eval.dts
@@ -88,7 +88,7 @@
 		clock-frequency = <400000>;
 
 		pcie-switch@58 {
-			compatible = "plx,pex8605";
+			compatible = "brcm,pex8605";
 			reg = <0x58>;
 		};
 
-- 
2.14.4

