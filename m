Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 062FCC468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 02:31:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B593F20BF2
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 02:31:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sholland.org header.i=@sholland.org header.b="hMh3Bqz5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="X6XAnanT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B593F20BF2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sholland.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403944AbeGLCi1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 22:38:27 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:55819 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2391262AbeGLCiY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 22:38:24 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id ADA3821C97;
        Wed, 11 Jul 2018 22:25:19 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Wed, 11 Jul 2018 22:25:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:content-transfer-encoding:content-type:date:from:message-id
        :mime-version:subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=PUJniQSENfcHsEJIR92J+GeDBXddkL5kxfRaagfbuGc=; b=hMh3Bqz5
        MmErwUTLGkjWWIMTFRX3CDIUpjiel/vCTnNonJnmOXm5zqNfzBodpwWO8xMB4QwP
        /Ija6gxZv9TEhuESfMUuqWUmyCp+DaHeCxq4PuK45+lcnrC3sJGTidl99eClMa7U
        4BLy4Xi0Qa5lUtv/O5RgLGSkoqHmLiGhslAAbXvqSGRdgOpKy6945bwyAa/IE/qR
        h8VhRapz2OFvHsxjzY+h/pobA/PeVb1uanW//rlDRJiq9p4UTvyx/JHeXZRXRBdi
        2lHZgrJCNnBl5eRoc9Bkbw6foWCkO+OlecQWZ6czL8JT3oKV9hnkNNnbrmBZ5Fb0
        gLPHKNcCRvX7nw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:message-id:mime-version:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; bh=PUJniQSENfcHsEJIR92J+GeDBXddk
        L5kxfRaagfbuGc=; b=X6XAnanTcRuUrT/ON/cpFrMMn89DZ5imeZ5cgiITGTLx4
        yyySTP9PeAbktqPhvx17wcuUZ1nE42B4gNNTIANV96WFojvz2RNe84RcVYrXRIDF
        7tWlDYpxlTIi93mcTq6rFjddweljhxpkF0SS5fdZMbei9wcr+QTYQzhIuMM2s9ev
        S30Bu1I3FWFk9PuobWjCn228TIMgFXYPKx8hwClkMJEqFcH0XrP0JHTCAo+SUMeQ
        MpxOr3msvKDRoqvKXfvB95cNz7x2One5/HfRLCQ/ARIDeLokQ4e5+2204MhyXMl2
        7/EfJ1dtuZz++ITU1Nx7qBHIoyuW08l2dQfhARr3g==
X-ME-Proxy: <xmx:D7xGW-v-oBr_gNag63tyEhxZWgfI2WTsjxK_uiSENxlQD9iIGMG0HQ>
    <xmx:D7xGW700lctIuTBP3Rf3F2HYIWrXUxIjXoVvGM8E3h3brXVTw9f6GQ>
    <xmx:D7xGW0CIXOGReC-fNfOantKankFYTdUkAeSih_XvIPTb6rtCmjMtHA>
    <xmx:D7xGW9yMrkndXwQjO1tudMIeuBpW6-SZ2MdhQYE36fpPDGC8m8qXGA>
    <xmx:D7xGW8Qgt6qA_GHD1qJ_RS8sRdbHmePuVe_3I5xyIIGSGqdYid2ncQ>
    <xmx:D7xGW1qe5HiyTyab-DIBy3T9HRioqyvE7L0SfqMHqej2Z-P5aC4pcA>
X-ME-Sender: <xms:D7xGW0vagKB5iWwdk64ubWDrVcUDv1_ailbfp8pI-44hPCCKWCl-cA>
Received: from indium.zzz.sholland.net (mobile-107-77-172-88.mobile.att.net [107.77.172.88])
        by mail.messagingengine.com (Postfix) with ESMTPA id 3ACEFE4519;
        Wed, 11 Jul 2018 22:25:17 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Mark Rutland <Mark.Rutland@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com, Samuel Holland <samuel@sholland.org>
Subject: [PATCH v2 0/2] Allwinner A64 timer workaround
Date:   Wed, 11 Jul 2018 21:25:13 -0500
Message-Id: <20180712022515.7255-1-samuel@sholland.org>
X-Mailer: git-send-email 2.16.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Several people (including me) have experienced extremely large system
clock jumps on their A64-based devices, apparently due to the
architectural timer going backward, which is interpreted by Linux as
the timer wrapping around after 2^56 cycles.

Investigation led to discovery of some obvious problems with this SoC's
architectural timer, and this patch series introduces at least a partial
workaround. It covers up small-scale instability in the timer, which
reduces the incidence of the large system clock jumps. More details are
in the commit message for patch 1. Patch 2 simply enables the workaround
in the device tree.

I chose not to send this to stable, since it is most likely not a
complete solution.

Thanks,
Samuel

changes since v1:
- Add an iteration limit like most other arch timer workarounds
- Added Andre's Tested-by

Samuel Holland (2):
  arm64: arch_timer: Workaround for Allwinner A64 timer instability
  arm64: dts: allwinner: a64: Enable A64 timer workaround

 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi |  1 +
 drivers/clocksource/Kconfig                   | 11 +++++++
 drivers/clocksource/arm_arch_timer.c          | 43 +++++++++++++++++++++++++++
 3 files changed, 55 insertions(+)

-- 
2.16.1

