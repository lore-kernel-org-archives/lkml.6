Return-Path: <SRS0=kg8+=LP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 810A8C433F5
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 08:13:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 446B720841
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 08:13:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 446B720841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727515AbeIAMY0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Sep 2018 08:24:26 -0400
Received: from mout.perfora.net ([74.208.4.197]:40013 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727490AbeIAMYZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Sep 2018 08:24:25 -0400
Received: from localhost.localdomain.ziswiler.net ([89.217.215.226]) by
 mrelay.perfora.net (mreueus003 [74.208.5.2]) with ESMTPA (Nemesis) id
 0LoXFc-1fOc191Ooc-00gWHy; Sat, 01 Sep 2018 10:13:09 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v2 05/34] ARM: tegra: colibri_t30: annotate uarts and move compatible to board
Date:   Sat,  1 Sep 2018 10:12:19 +0200
Message-Id: <20180901081248.22639-6-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180901081248.22639-1-marcel@ziswiler.com>
References: <20180901081248.22639-1-marcel@ziswiler.com>
X-Provags-ID: V03:K1:6CX9m+S4BwqNQyEZjM7ndugL7WYJsuKyt6N9Y/ABY4NVZmVbihV
 Z5N0jZoO5uv/Ww7fcTmISJQD9tgyqgL6FfMdAlY3kxyc0kDglLL6s1v/BBT59DBwumTTbny
 aPC9z9erF3ZBsgzLqPStiPabHIR7ay7EcF/tUUmCX6PVkEALMSFXYsGNIneHbLi5P0yHL1K
 ExKN7ssJvlhIwOxWzOG3g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:o35qm40Z5BU=:hc4sFsewxoQ1SQfuzdnGRo
 hshL1UYQQddbPuxJz3HVa0BUd5v+Za3piXMz2DcGDcFlFr54RE7Lvx9mDeVctOMTbsfaEg1hp
 5gY79Kp4k3gaMl9eKke5y5OB8rJfZnDHVNwHKvwTSkODg7mui6docb0PWi7lFLdpT3RrtZFvE
 W1YfBzBmWASyCIGxHF4eE9KJ8n3IB1J6hiTW6KRWjE9fWDFC4Ve90efZ0gjj5hDRVYE5HFi3f
 ywd7M2CsCgOdt5Sw6TDmoACzFEU4fcoPCeZyJzGJmCZc2grtbap3IBx/+Dbh1wGolzWxXM59p
 T0EiOWDEkevOaEGMBJi7eQ4TuCHVGkhQxymV2h9Xf3NTjJG2PKOXGaTTVwJ1zRNs6mcRVucuJ
 xirw7VxU1GqapKhRY14Q6euDUE8pTGud/YHculwz/oM6hESFT7kzkoo1OV1t7yukkoSCYy1xe
 noJhCENO4tJODmwmKwkYrXAxzqa8Qg7RgUtqXoc632/b2qyOwfH2Y0IW5qFIYrysU5ARBh2Fj
 6HIAKa6Y57CZ9ewlKI0JDg7WXtNVIUoopLfeLDYxcawyzT2ai20CGpws3EgWxEmOjqaNzy/I6
 3SkcZnutPTK3V6rqsHTF1Wg4qaB/q8Knp4GdGa1NzuQ77/pkR6MdLyXa7EuMZLU7FE8YRmM8L
 07hS6+ZSU719dedFwqGxassbmSI+d3w1u4gksvPSuNdQKUdo7hXAasYh/3E9eeIzrGY8=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Annotate UARTs and move the serial UART "nvidia,tegra30-hsuart"
compatible definitions from the carrier board to the module level device
trees. One could still override this in a custom carrier board device
tree if required.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

Changes in v2:
- Also move serial UART "nvidia,tegra30-hsuart" compatible to module
  level device trees.

 arch/arm/boot/dts/tegra30-colibri-eval-v3.dts | 5 +++--
 arch/arm/boot/dts/tegra30-colibri.dtsi        | 8 ++++++++
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/tegra30-colibri-eval-v3.dts b/arch/arm/boot/dts/tegra30-colibri-eval-v3.dts
index 1c057b285153..682ea4ffce83 100644
--- a/arch/arm/boot/dts/tegra30-colibri-eval-v3.dts
+++ b/arch/arm/boot/dts/tegra30-colibri-eval-v3.dts
@@ -33,17 +33,18 @@
 		};
 	};
 
+	/* Colibri UART-A */
 	serial@70006000 {
 		status = "okay";
 	};
 
+	/* Colibri UART-C */
 	serial@70006040 {
-		compatible = "nvidia,tegra30-hsuart";
 		status = "okay";
 	};
 
+	/* Colibri UART-B */
 	serial@70006300 {
-		compatible = "nvidia,tegra30-hsuart";
 		status = "okay";
 	};
 
diff --git a/arch/arm/boot/dts/tegra30-colibri.dtsi b/arch/arm/boot/dts/tegra30-colibri.dtsi
index dc54eb734f64..a9b9db0a87f8 100644
--- a/arch/arm/boot/dts/tegra30-colibri.dtsi
+++ b/arch/arm/boot/dts/tegra30-colibri.dtsi
@@ -213,6 +213,14 @@
 		};
 	};
 
+	serial@70006040 {
+		compatible = "nvidia,tegra30-hsuart";
+	};
+
+	serial@70006300 {
+		compatible = "nvidia,tegra30-hsuart";
+	};
+
 	hdmiddc: i2c@7000c700 {
 		clock-frequency = <10000>;
 	};
-- 
2.14.4

