Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C462AECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 12:38:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 755D720856
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 12:38:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 755D720856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389350AbeGWNjA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 09:39:00 -0400
Received: from mout.perfora.net ([74.208.4.196]:37595 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388464AbeGWNjA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 09:39:00 -0400
Received: from localhost.localdomain.toradex.int ([46.140.72.82]) by
 mrelay.perfora.net (mreueus002 [74.208.5.2]) with ESMTPA (Nemesis) id
 0MCJIF-1fq8np2chl-0098A8; Mon, 23 Jul 2018 14:37:53 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 23/26] ARM: tegra: colibri_t30: enable hda over hdmi
Date:   Mon, 23 Jul 2018 14:36:54 +0200
Message-Id: <20180723123658.980-24-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180723123658.980-1-marcel@ziswiler.com>
References: <20180723123658.980-1-marcel@ziswiler.com>
X-Provags-ID: V03:K1:GVEYRa0FmaMjRIXEn0Cn1am1T5gpZ6VAF1B1GAtUGfYzvpf90Ad
 iHrpg6xnu9ZckOAUQO28uF2rZxiT0i7x1HYqa1dWaFW0DvPV1vMPy9/v/vykh4OzjrzV6N6
 m5OHmnZZ40dwsDf7E7nE9mPSiST2dX26e+v5UpBPflbs5mkaUPYUe+SKlGBe5iEcEu8YfVk
 etDNYKc1syoXWCJ9sOzIw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:JWV66Z9oA2g=:lXOipROw/Fn0hJO3J8HPcN
 lfKry2l5XE4yJSSOEehARuJxH3sXON9p6pz/t0aSirwE94S1TECfuYi5nCpTyhB2Rwhchhhfh
 4V9IdI/n09gx4gFacH7rib/ZgnRZJDIGeX0xZA0+hVHe31fqU9vs9L+H5ABTC95IX3hRbr5+Z
 E/6d3eEJ4whqqoZM50lS/L3KT6khEEw/UPAPyOwg9NExTafgJUyVq2SIoH9bV/ukLx6n/hs1N
 x1yeLccf8qsRUhbpM6w0REvaB/NhxQmshplp3V6YewKdOiHDDVWdTw4UpPVisqZmxnwqxPO9f
 caUjBrSH4s2WT1cPk7ypc9HsOTReXteq/fhnS8sOj63V9XXBwerpyG3FBXTFF5JtQocvi8vG8
 lGoKLjz7kdQu9qRVrgRFED6c5r0K0mYm/Tdc6jUgN/XYLamkyYEk8w7aaPo8GpWAl22AIsTm1
 e6y4fnBqsljYRS20Y8nYVdwUFOUxrNBK2AhKG1JFVK51htEKwpmGawpdqjAuiqRmV6z02C1Hd
 UTJSpEGjtcHfiECHJk5xRUGkyR1syReEq9u0w9PYXfhQ5KnGkSNOe6Z5/qS2L9kQnrPjNTork
 OVxSdnx5tyxoK1NrbNyonRHymh6nU9Elixc9LUao/wyi97wGLbWM367og8HPFeE0BODqVdtzD
 lFQ8ZoY4Csye65M7jwgWrqQLQPdgdUoYDNDuczmUJa7yczh3xpBXBypyKlUD4q628U84=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Enable HDA over HDMI.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

 arch/arm/boot/dts/tegra30-colibri.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/tegra30-colibri.dtsi b/arch/arm/boot/dts/tegra30-colibri.dtsi
index 7f7a693f6e08..d3f72e567d5a 100644
--- a/arch/arm/boot/dts/tegra30-colibri.dtsi
+++ b/arch/arm/boot/dts/tegra30-colibri.dtsi
@@ -911,6 +911,10 @@
 		};
 	};
 
+	hda@70030000 {
+		status = "okay";
+	};
+
 	ahub@70080000 {
 		i2s@70080500 {
 			status = "okay";
-- 
2.14.4

