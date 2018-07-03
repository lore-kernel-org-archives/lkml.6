Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17F6DC6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 06:05:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C912122B3E
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 06:05:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="p5sD5TRX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C912122B3E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932702AbeGCGFZ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 02:05:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:48854 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754330AbeGCGFW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 02:05:22 -0400
Received: from localhost.localdomain (unknown [171.61.87.109])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 217F12246B;
        Tue,  3 Jul 2018 06:05:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1530597921;
        bh=2IhEIIRf6Cx5Zq+mCUnfDKcATI/JcyGTvi6tERLZZHc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=p5sD5TRXj7xnkV/FS6qHPL4KHk/V3yraoTt3D8lN0Bsh9Y7P10PhZM+2DosLW5H3s
         /NIZHj38XJhPvOUo0oyGaaZwiJ9J3/x2YVQBktUrUbWw/Y3cneq2sY8D4yiWfgSatp
         uU6rqSQkbpCbR6EkyRFTRXZwPAO6jFnmMrSDSduQ=
From:   Vinod Koul <vkoul@kernel.org>
To:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Matt Mackall <mpm@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-msm@vger.kernel.org, Stephen Boyd <swboyd@chromium.org>,
        Timur Tabi <timur@codeaurora.org>,
        Vinod Koul <vkoul@kernel.org>
Subject: [PATCH v3 4/6] dt-bindings: crypto: Add new compatible qcom,prng-ee
Date:   Tue,  3 Jul 2018 11:34:32 +0530
Message-Id: <20180703060434.19293-5-vkoul@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180703060434.19293-1-vkoul@kernel.org>
References: <20180703060434.19293-1-vkoul@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Later qcom chips support v2 of the prng, which exposes an EE
(Execution Enviornment) for OS to use so add new compatible
qcom,prng-ee for this.

Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 Documentation/devicetree/bindings/crypto/qcom,prng.txt | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/crypto/qcom,prng.txt b/Documentation/devicetree/bindings/crypto/qcom,prng.txt
index 8e5853c2879b..7ee0e9eac973 100644
--- a/Documentation/devicetree/bindings/crypto/qcom,prng.txt
+++ b/Documentation/devicetree/bindings/crypto/qcom,prng.txt
@@ -2,7 +2,9 @@ Qualcomm MSM pseudo random number generator.
 
 Required properties:
 
-- compatible  : should be "qcom,prng"
+- compatible  : should be "qcom,prng" for 8916 etc
+              : should be "qcom,prng-ee" for 8996 and later using EE
+		(Execution Environment) slice of prng
 - reg         : specifies base physical address and size of the registers map
 - clocks      : phandle to clock-controller plus clock-specifier pair
 - clock-names : "core" clocks all registers, FIFO and circuits in PRNG IP block
-- 
2.14.4

