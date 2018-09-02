Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A2AFC43334
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 10:11:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C145720841
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 10:11:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C145720841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727608AbeIBOZM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 10:25:12 -0400
Received: from mout.perfora.net ([74.208.4.194]:35895 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727586AbeIBOZL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 10:25:11 -0400
Received: from localhost.localdomain.ziswiler.net ([89.217.215.226]) by
 mrelay.perfora.net (mreueus001 [74.208.5.2]) with ESMTPA (Nemesis) id
 0MTheY-1gMq7y3IPY-00Qe7f; Sun, 02 Sep 2018 12:09:51 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v2 18/37] ARM: tegra: colibri_t20: iris: add uart-c
Date:   Sun,  2 Sep 2018 12:08:47 +0200
Message-Id: <20180902100906.25792-19-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180902100906.25792-1-marcel@ziswiler.com>
References: <20180902100906.25792-1-marcel@ziswiler.com>
X-Provags-ID: V03:K1:sK6IA29pbpZ7tSQ7FwXPKba2XCgK2e4BurvU5TmJhj7UcUygCKC
 lvpOnTxUXV8b1z7yoQwcJX2XGHdJyGxaQJRtRckPYHtoewYrDLY3ikJV0p+NztDxeX6BFK6
 9mwUTMWpuvGd4vDzb/IxAJSOWEgnldhAbXqVOc4oT5ST6/rS7kRfMqUhWYnMYTx08GKPMwW
 runhcm/0pduHyMiSTU7qw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:exCsDJuhvtQ=:gTOP8lHgQRs5yzKs70IDYj
 W2fBe3LFNnCBBYN1xzQ78OPvsAvIoyKlAHozj9KodsumemsABQ67YqrvyFOj850AWoEPpXsS+
 Q0XAWPtADBAjeZQIexyL5wPA0FRMbDwXPPRTbkAy7804w11gEsIrGhEn2bH/UayM4z/Sh5ChO
 CzZo4FZIAXvimO6SccNsCL9bCQV11R01sxOcFWp73ZLB9eMpok5PuK/1rOXGV4MZfd27ogL02
 mj+M4rq3ZuvaIv1nM2Y8k4fanz0VSCg5vN2y9BEgie5E25I0D1Vd2ZSiCe4hK7mcLF8zpbvDe
 EnqdFxBSZ8+ylN8V6dPsGxfCIgfkRns9DJhjqqOM2xFw/wkTGDDYkU4UsUQa9U75KmmXnzSCM
 PQ4Xzu6Ipb6MeGhc79EmL5utTwIDpMyaDBbAvqsDRtAQ8A7/GogGLpFEdERc9SlPpakHaeuEH
 8RHJ/iiiXiiCwNPYUBy3Jg61i3MV51hu8VhRi95BV9OPG0549K08SOt4zfUVQjfCr4OzQM3PO
 3AvZ9iqEJVn8z+/LsxmDH6LG17UyHAQQFD66lLLwa1Z7RWQkXymZH8f19fLk0hIeYP8wjgJIl
 7n1s1PtErewOdX92kmLVbPyZa7BCxPaDfZrEcB6TefpiAS/3hR2C8B6SS4wvqTAG0YBLXdsaW
 +Djb7S8oNyMuK9RzhfYJmYhoPV7J5QDJbwgcdcrxZPnNCzjZe2fKzQL7ulzB/u3N/TdA=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Add UART-C.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

Changes in v2: None

 arch/arm/boot/dts/tegra20-colibri-iris.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/tegra20-colibri-iris.dts b/arch/arm/boot/dts/tegra20-colibri-iris.dts
index cb3c82287223..cb7b11567437 100644
--- a/arch/arm/boot/dts/tegra20-colibri-iris.dts
+++ b/arch/arm/boot/dts/tegra20-colibri-iris.dts
@@ -103,6 +103,11 @@
 		status = "okay";
 	};
 
+	/* Colibri UART-C */
+	serial@70006040 {
+		status = "okay";
+	};
+
 	/* Colibri UART-B */
 	serial@70006300 {
 		status = "okay";
-- 
2.14.4

