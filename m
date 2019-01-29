Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC490C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 12:25:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7116D20870
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 12:25:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548764720;
	bh=sP4MVbejWowzzrzlolRsAI9mqp4ZYc1ZdNhWi447+XQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=13SOvo2WBErsP97mEmXHTMs6H82E0MBiN9u3Vxr7j+RO5xpxlsgIBTAwRNcILk7z/
	 5Lm90DsLPfdvyBpwdZxMhaX7kphS4Z3MB9e5AV4lhMT7g5ebTVep7FCPswBZdqKCDI
	 UxfTmrKgLjhQDPxkjW7g1kMX1hhyVQPljIplTLR0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729020AbfA2MZT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 07:25:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:36110 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728976AbfA2MZS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 07:25:18 -0500
Received: from localhost.localdomain (unknown [60.186.218.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9CCE920870;
        Tue, 29 Jan 2019 12:25:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548764717;
        bh=sP4MVbejWowzzrzlolRsAI9mqp4ZYc1ZdNhWi447+XQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=I95Qt8amzjsk1Icdfcy3/kXRAftM7OjKZ4k3lW2ifLmnjFiUJ0wxL+czBWYk9DFJH
         wdNhRhGDi8mwxlVTQTYdX8lsDpJw9j5S2BTeYHTJtQI+RVRy0LShmheG5L0FPcHXXK
         wBcll3TSh56ZPlmj8wVehu0MGl+Aslk5Og/FvpUU=
From:   guoren@kernel.org
To:     arnd@arndb.de, robh+dt@kernel.org, marc.zyngier@arm.com
Cc:     linux-kernel@vger.kernel.org, guoren@kernel.org,
        linux-arch@vger.kernel.org, Guo Ren <ren_guo@c-sky.com>
Subject: [PATCH 09/10] dt-bindings: csky,apb-intc: Add vector irq mode
Date:   Tue, 29 Jan 2019 20:24:28 +0800
Message-Id: <1548764669-16656-9-git-send-email-guoren@kernel.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1548764669-16656-1-git-send-email-guoren@kernel.org>
References: <1548764669-16656-1-git-send-email-guoren@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <ren_guo@c-sky.com>

Add csky,support-vector-irq for irq-csky-apb-intc.

Signed-off-by: Guo Ren <ren_guo@c-sky.com>
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

