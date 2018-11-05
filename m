Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CFC6C46465
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 20:06:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50A0720685
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 20:06:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="H2LH2mB7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50A0720685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730106AbeKFF1T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 00:27:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:44000 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727464AbeKFF1T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 00:27:19 -0500
Received: from localhost.localdomain (cpe-70-114-128-244.austin.res.rr.com [70.114.128.244])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E17292086A;
        Mon,  5 Nov 2018 20:05:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541448359;
        bh=pxNPqHgdHQzEXqYeIga0Pe6lSRYgKNqk/dBPhFdufH0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=H2LH2mB7+B0G8V09kxZlvxgtoX2vorF+NYpvJ0comw3Rd3Ljc24Xc1UuovjvqRPEj
         FnVsgoZFZrG14VAkut08y0S6CUq3JGROQGouEy249ssxzimTu86+s+AwXDBIb6JhWO
         iJtYXPbsJvu0wyqWJf21O52OuMd+M9EaRMYTXhQY=
From:   Dinh Nguyen <dinguyen@kernel.org>
To:     p.zabel@pengutronix.de
Cc:     dinguyen@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] ARM: socfpga: dts: document "altr,stratix10-rst-mgr" binding
Date:   Mon,  5 Nov 2018 14:05:49 -0600
Message-Id: <20181105200549.17159-3-dinguyen@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181105200549.17159-1-dinguyen@kernel.org>
References: <20181105200549.17159-1-dinguyen@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"altr,stratix10-rst-mgr" is used for the Stratix10 reset manager.

Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
---
 Documentation/devicetree/bindings/reset/socfpga-reset.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/reset/socfpga-reset.txt b/Documentation/devicetree/bindings/reset/socfpga-reset.txt
index 98c9f560e5c5..38fe34fd8b8a 100644
--- a/Documentation/devicetree/bindings/reset/socfpga-reset.txt
+++ b/Documentation/devicetree/bindings/reset/socfpga-reset.txt
@@ -1,7 +1,8 @@
 Altera SOCFPGA Reset Manager
 
 Required properties:
-- compatible : "altr,rst-mgr"
+- compatible : "altr,rst-mgr" for (Cyclone5/Arria5/Arria10)
+	       "altr,stratix10-rst-mgr","altr,rst-mgr" for Stratix10 ARM64 SoC
 - reg : Should contain 1 register ranges(address and length)
 - altr,modrst-offset : Should contain the offset of the first modrst register.
 - #reset-cells: 1
-- 
2.17.1

