Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2F3FC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 02:05:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CE5F218D8
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 02:05:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550455521;
	bh=NX/OXQp8TRJj4lBr989AvSAH429ayEHLjUJomOhsw88=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=P7LlC5K7f7YcEKQ0PD2nlAEK60y1ivJF4rSoosfvlQzbuAOvMisuXaa64ZUKvyONn
	 Fw21zrZd2sThoqCCi+2yLAp37PuAOyUPKzpcUcXNRofAgBBgnj2/mX+dWrIiyUPL+x
	 Qvjk9/yNbwKPiiQry29YT601zrXGmdPGOHT7RMUM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728367AbfBRCFK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Feb 2019 21:05:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:53048 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728333AbfBRCFF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Feb 2019 21:05:05 -0500
Received: from localhost.localdomain (unknown [122.234.57.149])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7AB59218D8;
        Mon, 18 Feb 2019 02:05:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550455505;
        bh=NX/OXQp8TRJj4lBr989AvSAH429ayEHLjUJomOhsw88=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1Qj9h3wAdOlRSfiXLFg841ipLm2uxXmxS01o1kGwQWBlN5G5kk4oBinY+iqFtPI51
         Q9ZAi/IOzZ0opMCmWYS8IZ26vXbkVqS26Dvd3Azns9HyR8nKJwLVn3d9mdGDhPsAcn
         TF4o2/PRnd4h7d5zRvu1oUuAWj6x7ajhB9sLV9Hs=
From:   guoren@kernel.org
To:     marc.zyngier@arm.com, tglx@linutronix.de, robh+dt@kernel.org
Cc:     linux-kernel@vger.kernel.org, guoren@kernel.org,
        Guo Ren <ren_guo@c-sky.com>
Subject: [PATCH V2 6/7] dt-bindings: csky,apb-intc: Add vector irq mode
Date:   Mon, 18 Feb 2019 10:04:42 +0800
Message-Id: <1550455483-11710-6-git-send-email-guoren@kernel.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1550455483-11710-1-git-send-email-guoren@kernel.org>
References: <1550455483-11710-1-git-send-email-guoren@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <ren_guo@c-sky.com>

Add csky,support-vector-irq for irq-csky-apb-intc.

Signed-off-by: Guo Ren <ren_guo@c-sky.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Rob Herring <robh+dt@kernel.org>
---
 .../devicetree/bindings/interrupt-controller/csky,apb-intc.txt         | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/csky,apb-intc.txt b/Documentation/devicetree/bindings/interrupt-controller/csky,apb-intc.txt
index 63bc9dc..0f9fa88 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/csky,apb-intc.txt
+++ b/Documentation/devicetree/bindings/interrupt-controller/csky,apb-intc.txt
@@ -37,6 +37,9 @@ intc node bindings definition
 	- csky,support-pulse-signal:
 		Usage: select
 		Description: to support pulse signal flag
+	- csky,support-vector-irq:
+		Usage: select
+		Description: to support vector irq mode
 
 Examples:
 ---------
-- 
2.7.4

