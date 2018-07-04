Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2DCBC3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 11:45:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 940C121456
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 11:45:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="EE53yBX5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 940C121456
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934424AbeGDLpW (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 07:45:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:38688 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934330AbeGDLpU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 07:45:20 -0400
Received: from localhost.localdomain (unknown [122.167.70.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5D53220841;
        Wed,  4 Jul 2018 11:45:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1530704719;
        bh=vqVofvapwrG8ciliKflyyjljd3etyLgYjITOT4LK8ZQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EE53yBX5sI3x3DwMj6YhGreT+qBFDzqnCp7gHVewO4/HUGAbqfcaKgP8RPoSi1ZCb
         YFaRV/GL7tRyPW9+OCbZF68LrXst8U6auAW0QjXdXUPJ1rrKAUmhlQ72FDzSPNSKl0
         Yq0HpUPTqCD8cfHLh5r8A4bA2GYn+tCe0NoFpHU4=
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
Subject: [PATCH v4 4/6] dt-bindings: crypto: Add new compatible qcom,prng-ee
Date:   Wed,  4 Jul 2018 17:14:25 +0530
Message-Id: <20180704114427.29953-5-vkoul@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180704114427.29953-1-vkoul@kernel.org>
References: <20180704114427.29953-1-vkoul@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Later qcom chips support v2 of the prng, which exposes an EE
(Execution Environment) for OS to use so add new compatible
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

