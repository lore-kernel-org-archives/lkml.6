Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1676AC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 22:34:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D013D218B0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 22:34:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551220496;
	bh=lp9aT8Nx4CezWWs8w8r9pEsH6j2LSLhXkfDtgxl/e4Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=HMQRXXzx6LWNtRPBZXfud8pcbIHiPIDf5ChCaGqBNkXJsywdWklYBIqzAlbUJwua3
	 gYI6HWV24PDwwW6B9lWMEQ1n/19yByqpySJRBDrr1u1TDt+RLZpgPf42KsaGihFMeu
	 7LYfrJePYls+8nHrscGxV8uVprSTq90Rr9H++lsk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729442AbfBZWeu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 17:34:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:48284 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729335AbfBZWee (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 17:34:34 -0500
Received: from mail.kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CB05D218AE;
        Tue, 26 Feb 2019 22:34:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551220474;
        bh=lp9aT8Nx4CezWWs8w8r9pEsH6j2LSLhXkfDtgxl/e4Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Gtbza7RskGcHjPjiFncJ0VIsopE9jw37Tk5i9Y1d37JmD/6ickiubgs2PtG291Msb
         CjlHtqUb0Qagv1GtQfbbOyx48cELAVKHa2mMFecvx9M1PdX1e2HHTI+3R4tBOr/VOk
         0YzeM1sIbhwHADcRk/C/i06Bkb+DmChNOkgKcASE=
From:   Stephen Boyd <sboyd@kernel.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Russell King <linux@armlinux.org.uk>,
        Jeffrey Hugo <jhugo@codeaurora.org>,
        Chen-Yu Tsai <wens@csie.org>
Subject: [PATCH v2 8/8] arm64: dts: qcom: Specify XO clk as input to GCC node
Date:   Tue, 26 Feb 2019 14:34:29 -0800
Message-Id: <20190226223429.193873-9-sboyd@kernel.org>
X-Mailer: git-send-email 2.21.0.rc2.261.ga7da99ff1b-goog
In-Reply-To: <20190226223429.193873-1-sboyd@kernel.org>
References: <20190226223429.193873-1-sboyd@kernel.org>
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
Cc: Jeffrey Hugo <jhugo@codeaurora.org>
Cc: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
---
 arch/arm64/boot/dts/qcom/sdm845.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index c27cbd3bcb0a..2409241ad4ae 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -339,6 +339,8 @@
 			#clock-cells = <1>;
 			#reset-cells = <1>;
 			#power-domain-cells = <1>;
+			clocks = <&rpmhcc RPMH_CXO_CLK>;
+			clock-names = "xo";
 		};
 
 		qfprom@784000 {
-- 
Sent by a computer through tubes

