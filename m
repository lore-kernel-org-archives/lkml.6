Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE3B7C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 16:41:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AACBB20658
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 16:41:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AACBB20658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728812AbeHaUtT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 16:49:19 -0400
Received: from mout.perfora.net ([74.208.4.197]:34745 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728747AbeHaUr3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 16:47:29 -0400
Received: from localhost.localdomain.ziswiler.net ([89.217.215.226]) by
 mrelay.perfora.net (mreueus003 [74.208.5.2]) with ESMTPA (Nemesis) id
 0MD7RC-1g7qjS1UNw-00GUxd; Fri, 31 Aug 2018 18:39:02 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v2 19/34] ARM: tegra: apalis_t30: use proper irq-gpio for stmpe811
Date:   Fri, 31 Aug 2018 18:38:01 +0200
Message-Id: <20180831163817.23970-20-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180831163817.23970-1-marcel@ziswiler.com>
References: <20180831163817.23970-1-marcel@ziswiler.com>
X-Provags-ID: V03:K1:D7WeFe4i+kOTFCWtY3+3ryIHY8VNVSuX7UMCs583Lvsc62ktclo
 XfauGIqUKhdALwY4gsRxcDbIj2v960KvnGUZtPFcYKXzWps48WpcPORSUq9GXMHx+2usGr6
 ip3CccOedSNsPrPbNlscweKaQgMNWjsoxoFz8JvKZs5UqhZQv19JoIhkCSBPg8mshhJ0BMx
 WrkHTZ6cHrBY4In28d7jw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:sJ/KbWKxr0o=:lUV46FrhfZkG5TZ14f7iiF
 FGzqy6wb9LvLzpfKJn0gWbbRdKjz0ieaeptCv75j5jDOSmgxZTmb+2vfrJGYtZPCXhQqPMpjI
 GQOWF1vCvFgVBgTl2HiQePnHC9JkIfT6sj528V5lniq9fdwgC/bd/WemzoVo/aCaM+8DE9Axy
 d/y0Yx0+xjVOPV31Vb9wyIFjHF3+jpO47zexf22tQKkbHoXUWjtxFWdaetWJUKGUEa35tQijk
 cz8E39xng8B5ToEqulSI0TxfZmCJbfmAnhxwhfs5O04NL+sy2ySd+BvvK2mun7nQNHXePZhAS
 5D2ZP5SamRlw7lG25SwuPCpEciiSwWOf8CYc9l2zF9KVhuTjgBdH54jATPD8nGXXTh1Rztd0C
 RVeDFU192/JbvWo+rWXJxwNUX8o/q96OoBjnaM8LyvYT9Q7TA/63lBCRWv4qKsUVjPOFBNseg
 F3WwoARhlpwMoNX+rLgjHrrcYF6aAyZkl2bCgn7m0ldxC0xvSYlfRayv5fwB4qnFuL5/vlNVf
 wGczJQJUob959pBzJJZulsjKSwnLtcyZpHzbwLgQSYNYwl+ToDiYNiDkBSAun+nTQ2F8zK7K0
 dP7YOm7MPsIYzzkzJiVu/kFfWrKzUNhsCE7V8uctwIvrMnbFdyhDspVQFNCYQibrijb2A3sl6
 Z/FDjRFODiILxNX4NteEdPL1D8kBpZiiR5s/W1AUcuq+aA3Gt56HHKUR01yN3BmGJ2JQ=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Use proper irq-gpio for stmpe811 touch controller.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

Changes in v2: None

 arch/arm/boot/dts/tegra30-apalis.dtsi | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/tegra30-apalis.dtsi b/arch/arm/boot/dts/tegra30-apalis.dtsi
index e37d22e2ceef..43d914f754e8 100644
--- a/arch/arm/boot/dts/tegra30-apalis.dtsi
+++ b/arch/arm/boot/dts/tegra30-apalis.dtsi
@@ -975,8 +975,7 @@
 		stmpe811@41 {
 			compatible = "st,stmpe811";
 			reg = <0x41>;
-			interrupts = <TEGRA_GPIO(V, 0) IRQ_TYPE_LEVEL_LOW>;
-			interrupt-parent = <&gpio>;
+			irq-gpio = <&gpio TEGRA_GPIO(V, 0) IRQ_TYPE_LEVEL_LOW>;
 			interrupt-controller;
 			id = <0>;
 			blocks = <0x5>;
-- 
2.14.4

