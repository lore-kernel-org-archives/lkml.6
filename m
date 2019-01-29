Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2514AC169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 06:10:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E096E2175B
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 06:10:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548742246;
	bh=fmSRU4c+3VYxyHTO+gXsJNTOFI+9uoGhMdrxeyAoZsI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zkEH8MDTGfnRNImGE/A8KDtQDSfA5/L1/5GyJ9Js5o+CqfNkbRwcLj6hcgQYe2hsh
	 ugZF+tBOKOPIN4bWt1K1Z+w+UTflDwZQDqMmd6n4FMuQmdUVYDC6NzSf1DSTluIq8x
	 m2jWqbQsIdSUgJhwQTPK8SSlaAjBoBZMHIQippdo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727668AbfA2GKo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 01:10:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:33440 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727476AbfA2GK0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 01:10:26 -0500
Received: from mail.kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C7C0321874;
        Tue, 29 Jan 2019 06:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548742226;
        bh=fmSRU4c+3VYxyHTO+gXsJNTOFI+9uoGhMdrxeyAoZsI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=APN81oJi/xQ1YdfJsr4jlz+OONKN+ClQZUc1zP6/LyT3oCf3kG679uOEttJZAJgou
         8U59tHv6Qbgzuc3WO5uNROYFEdQIamanhPmszmQw4rJ/k25NkjVomX8BsTv/KGbrgj
         WfLAKIqZtQnnskv0LW5bhH+k0Fm8vWckPiS28T4c=
From:   Stephen Boyd <sboyd@kernel.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Russell King <linux@armlinux.org.uk>
Subject: [PATCH 9/9] arm64: dts: qcom: Specify XO clk as input to GCC node
Date:   Mon, 28 Jan 2019 22:10:21 -0800
Message-Id: <20190129061021.94775-10-sboyd@kernel.org>
X-Mailer: git-send-email 2.20.1.495.gaa96b0ce6b-goog
In-Reply-To: <20190129061021.94775-1-sboyd@kernel.org>
References: <20190129061021.94775-1-sboyd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an example patch to show how DT nodes are updated to specify the
clocks which are external to the clock controller can be specified in DT
and then found by the clk core to do parent-child linkage.

Cc: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Michael Turquette <mturquette@baylibre.com>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
---
 arch/arm64/boot/dts/qcom/sdm845.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index b72bdb0a31a5..46e0b467b411 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -338,6 +338,8 @@
 			#clock-cells = <1>;
 			#reset-cells = <1>;
 			#power-domain-cells = <1>;
+			clocks = <&rpmhcc RPMH_CXO_CLK>;
+			clock-names = "xo";
 		};
 
 		qfprom@784000 {
-- 
Sent by a computer through tubes

