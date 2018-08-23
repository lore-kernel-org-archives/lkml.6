Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 371D0C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:52:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9F9D20839
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:52:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9F9D20839
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387848AbeHWMUz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 08:20:55 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:51708 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728555AbeHWMUz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 08:20:55 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 426F5C5C;
        Thu, 23 Aug 2018 08:52:15 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Olof Johansson <olof@lixom.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.17 132/324] arm64: dts: uniphier: fix widget name of headphone for LD11/LD20 boards
Date:   Thu, 23 Aug 2018 09:53:18 +0200
Message-Id: <20180823075002.567919081@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180823074955.885811006@linuxfoundation.org>
References: <20180823074955.885811006@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>

[ Upstream commit 86676c4685f774d818f7a6c401c925bbf2a92903 ]

This patch fixes wrong name of headphone widget for receiving events
of insert/remove headphone plug from simple-card or audio-graph-card.

If we use wrong widget name then we get warning messages such as
"asoc-audio-graph-card sound: ASoC: DAPM unknown pin Headphones"
when the plug is inserted or removed from headphone jack.

Fixes: fb21a0acaa2b7 ("arm64: dts: uniphier: add sound node")
Signed-off-by: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Signed-off-by: Olof Johansson <olof@lixom.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/boot/dts/socionext/uniphier-ld11-global.dts |    2 +-
 arch/arm64/boot/dts/socionext/uniphier-ld20-global.dts |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

--- a/arch/arm64/boot/dts/socionext/uniphier-ld11-global.dts
+++ b/arch/arm64/boot/dts/socionext/uniphier-ld11-global.dts
@@ -54,7 +54,7 @@
 	sound {
 		compatible = "audio-graph-card";
 		label = "UniPhier LD11";
-		widgets = "Headphone", "Headphone Jack";
+		widgets = "Headphone", "Headphones";
 		dais = <&i2s_port2
 			&i2s_port3
 			&i2s_port4
--- a/arch/arm64/boot/dts/socionext/uniphier-ld20-global.dts
+++ b/arch/arm64/boot/dts/socionext/uniphier-ld20-global.dts
@@ -54,7 +54,7 @@
 	sound {
 		compatible = "audio-graph-card";
 		label = "UniPhier LD20";
-		widgets = "Headphone", "Headphone Jack";
+		widgets = "Headphone", "Headphones";
 		dais = <&i2s_port2
 			&i2s_port3
 			&i2s_port4


