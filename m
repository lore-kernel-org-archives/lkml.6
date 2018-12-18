Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B27DC43444
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 21:30:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BC8E21871
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 21:30:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="WvAnzJLS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727552AbeLRV3b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 16:29:31 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35230 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727486AbeLRV32 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 16:29:28 -0500
Received: by mail-wm1-f68.google.com with SMTP id c126so4282044wmh.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Dec 2018 13:29:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LlG9LbRT/Q0m531ljY3ISX/R0czf+ZPbNjDuaHFc7o0=;
        b=WvAnzJLS0Mxed7LeSLADxAaD86uwMLV6aWRSnmDdS2z/i3d1Ksk+7oDzGQufnNOgxy
         M56XnrUU2TqYjebdd+mTdWwbRzs2K1xvvKMNYj9aYds5nJv9xguRG04SuPVLY7s/VeVx
         EqKx8EjYsNIIH+2DEx34TmF/HzPShezKX9ukY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LlG9LbRT/Q0m531ljY3ISX/R0czf+ZPbNjDuaHFc7o0=;
        b=LBpPZcnJMkoC+0Cy3eX7r73eXTtwrQeu4pyWBc6p3a9Ql0xWddCipx27e0/P9eArNW
         69EATmPG+t5NDU0SNBxN0w9CVL7QwU03yrtUkLqZTB7Ql8ffMUIXWkNO/V6kBf89fBiW
         V/06h8POt5POBQv7JCz78OyVbf5WbswFE4vA6u+/7PKFx0/00GrANUZMK4mYMKBprwEr
         3YI2CHfJJPovkMPaUzcdZYXi8GbqtAH31nyQQHUQURv+KRN5hfyzqjqRs3Us28JHfYLU
         NOvA/U3pzVOytE33Fw7vlprkhxt9SllFcj+WGPjXYobqElbqJ0SttHH2dAbh86PVSvaR
         NrZA==
X-Gm-Message-State: AA+aEWb8Yo1Psaa2Om3rbEV4BBo6n7mDxuWCxtpnB7nqf9NTHPJH67hv
        lYvEjw0dmJf/Vvil7iZ7AANHsHIxjOo=
X-Google-Smtp-Source: AFSGD/WT5fMthMB4+qNGZEU4GcL1Co7KCOCBeg7HRJNkXrKHGtOqO2DrRqHz2aCBXpCpYltT/w+S2Q==
X-Received: by 2002:a1c:cf0d:: with SMTP id f13mr4587525wmg.70.1545168565959;
        Tue, 18 Dec 2018 13:29:25 -0800 (PST)
Received: from localhost.localdomain (105.50.92.92.rev.sfr.net. [92.92.50.105])
        by smtp.gmail.com with ESMTPSA id o4sm4153485wrq.66.2018.12.18.13.29.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Dec 2018 13:29:25 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, Biju Das <biju.das@bp.renesas.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS)
Subject: [PATCH 11/25] dt-bindings: timer: renesas, cmt: Document r8a77470 CMT support
Date:   Tue, 18 Dec 2018 22:28:29 +0100
Message-Id: <20181218212844.30445-11-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181218212844.30445-1-daniel.lezcano@linaro.org>
References: <d3f1255a-592d-13d9-5d3f-bd3ec7a36742@linaro.org>
 <20181218212844.30445-1-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Biju Das <biju.das@bp.renesas.com>

Document SoC specific compatible strings for r8a77470. No driver change
is needed as the fallback strings will activate the right code.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 Documentation/devicetree/bindings/timer/renesas,cmt.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/timer/renesas,cmt.txt b/Documentation/devicetree/bindings/timer/renesas,cmt.txt
index 6de27b60b51a..eb602c599341 100644
--- a/Documentation/devicetree/bindings/timer/renesas,cmt.txt
+++ b/Documentation/devicetree/bindings/timer/renesas,cmt.txt
@@ -28,6 +28,8 @@ Required Properties:
     - "renesas,r8a7744-cmt1" for the 48-bit CMT1 device included in r8a7744.
     - "renesas,r8a7745-cmt0" for the 32-bit CMT0 device included in r8a7745.
     - "renesas,r8a7745-cmt1" for the 48-bit CMT1 device included in r8a7745.
+    - "renesas,r8a77470-cmt0" for the 32-bit CMT0 device included in r8a77470.
+    - "renesas,r8a77470-cmt1" for the 48-bit CMT1 device included in r8a77470.
     - "renesas,r8a7790-cmt0" for the 32-bit CMT0 device included in r8a7790.
     - "renesas,r8a7790-cmt1" for the 48-bit CMT1 device included in r8a7790.
     - "renesas,r8a7791-cmt0" for the 32-bit CMT0 device included in r8a7791.
-- 
2.17.1

