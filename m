Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9864C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 11:27:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9591A2083B
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 11:27:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="F2K3f2ZS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728572AbfBLL15 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 06:27:57 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:43156 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726044AbfBLL14 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 06:27:56 -0500
Received: by mail-pf1-f193.google.com with SMTP id q17so1146672pfh.10
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 03:27:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Rzokbk+wz76sGQMAmevDLIXGhgL63d+iuhiO2QFXfxM=;
        b=F2K3f2ZS3IJxNWHW/HwihilKIrtG5DecxlrDMajwJyOVKKub2gDk6/Kni83jBx4L4H
         WKJfJ1/utHQvxN9Ms/HGST43SyxQTxiWbyoRFDOmwHbrtIYJq8pu6HznC5PUga1dl11K
         jAUr2kP4BSMzb+sogiFDS/03t6N3UAs+SVeCI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Rzokbk+wz76sGQMAmevDLIXGhgL63d+iuhiO2QFXfxM=;
        b=ATGaOcGe3Z9oLt+DgN+GAVm2N/lKtQLUmvMCE+wWdGOTkziVRsRshzR8vz78aIj4c+
         s/gcNPUyIFZy5f8zM8bUbMLYchCmDDYjMDsEEEe8Q7T5FSGbokPb5p/6cbog4nd3QKcR
         WRDt5QTgq5QtyHL8L3hGlgXzP9hCjUdbd48TQIZ2HRCErM822JB5ONoWeDM86IEPQ01a
         UsAIX1ymwhie4476NoXKxN24VjaHEwXbLQlt+X6EpEX/GxTqPE4R5HFF9jluNK4ZsT+m
         uxVb11VFY1HYpvNnL3B1nMagoYRKPmRFp1J79F5Pcr9yzMg/gtGW/uAuP01a2w6HPYAP
         9qcw==
X-Gm-Message-State: AHQUAuY4t/dD2TCdbWAa62NrUjmp51PSOnV37bmnfA1XWg8mntaHKzDH
        u8+QEm1yhSHc3sHvV0enzDL/Vg==
X-Google-Smtp-Source: AHgI3Ia7SBV/4Tv5sdP4/VRZmcWahgKhLLlXId3/auG4dee7yloH4Fg8dYImrbEidVE8o0Xbygj15Q==
X-Received: by 2002:a63:4703:: with SMTP id u3mr3192030pga.298.1549970875967;
        Tue, 12 Feb 2019 03:27:55 -0800 (PST)
Received: from localhost.localdomain ([115.97.184.151])
        by smtp.gmail.com with ESMTPSA id g7sm9863066pfm.10.2019.02.12.03.27.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Feb 2019 03:27:55 -0800 (PST)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v2] dt-bindings: Add vendor prefix for techstar
Date:   Tue, 12 Feb 2019 16:57:44 +0530
Message-Id: <20190212112744.2332-1-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add vendor prefix for techstar, known as
Shenzhen Techstar Electronics Co., Ltd. a known producer for LCD modules.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
Changes for v2:
- rebase for master

 Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index 7eae7a95ab2a..a5ad57eaee20 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -397,6 +397,7 @@ tcl	Toby Churchill Ltd.
 technexion	TechNexion
 technologic	Technologic Systems
 tempo	Tempo Semiconductor
+techstar	Shenzhen Techstar Electronics Co., Ltd.
 terasic	Terasic Inc.
 thine	THine Electronics, Inc.
 ti	Texas Instruments
-- 
2.18.0.321.gffc6fa0e3

