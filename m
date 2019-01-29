Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B2DCC169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 06:53:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BAB82175B
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 06:53:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="KWb62IKX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725799AbfA2GxW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 01:53:22 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:40009 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725267AbfA2GxW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 01:53:22 -0500
Received: by mail-pg1-f194.google.com with SMTP id z10so8352367pgp.7
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 22:53:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LQebTt8H43w58ILFzzWdklfMJ5I40KjUTMdOq7rdPFs=;
        b=KWb62IKXiWKhZpzBR8DwI1E5tKv96JQNKSVA3HWamq/f96y0fgaH5NzT+jDS1NoZB/
         oaJyLCzDdvw3s2D/wYo7uwrPU91JPZJGYh9n67NI51zNYnsjfSaVCk9dtnc0f3co/T08
         I5L4f3ZtV4ruzdK4sRFXMm/MQ0ouqArUBQwP4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LQebTt8H43w58ILFzzWdklfMJ5I40KjUTMdOq7rdPFs=;
        b=hYEodR0FmbHYaJyPK1se9cetseF5o/JASrPROtJ6OC5iQ4h9+vKFFjLl2mWrrMifsC
         czBQcZKE1aZcUnmgLk5asmqAUsqIaLKIemb0C6/ijv8SSKGybcU1zyHCWJi0X5GdJahq
         bordnuCHxcFoe9rgT4AH5he/uvYAwE931G368GH8sRX7aCWRXKivUCg+xTWZCPtlIIJn
         idmabwGw/DAXDygSF1amwxB35vixmx9/wjDx/J42Y4agKqQKiXMNPq5c0jYW/OOpns7J
         91fPHP7S0K+zAA+4cNZyGpBkXYN8pD3rxp4oadV9i3PNM4lueqmeAOAYQtTX1tyHhpcn
         TZJg==
X-Gm-Message-State: AJcUukcs32D9DPK35dG7I3Z4lwtIAUF/fqyJ0MsVrrIYlf1hHmhGDiB9
        IYVG5rgBORs5Qs2zRE6AyrBE3A==
X-Google-Smtp-Source: ALg8bN657+CEbbS0IlTk8zJ2gcvw/FJegOHunz/N5mbCLEFgVXk3+RSwZX3CbEOJTv/xtDnwUaQbYA==
X-Received: by 2002:a65:584e:: with SMTP id s14mr22655054pgr.142.1548744801283;
        Mon, 28 Jan 2019 22:53:21 -0800 (PST)
Received: from localhost.localdomain ([115.97.179.75])
        by smtp.gmail.com with ESMTPSA id d21sm40091825pgv.37.2019.01.28.22.53.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Jan 2019 22:53:20 -0800 (PST)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amarula@amarulasolutions.com,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH] dt-bindings: Add vendor prefix for techstar
Date:   Tue, 29 Jan 2019 12:23:04 +0530
Message-Id: <20190129065304.6396-1-jagan@amarulasolutions.com>
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
 Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index 88dcdc04c8c9..2aa2688b21a5 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -392,6 +392,7 @@ tcl	Toby Churchill Ltd.
 technexion	TechNexion
 technologic	Technologic Systems
 tempo	Tempo Semiconductor
+techstar	Shenzhen Techstar Electronics Co., Ltd.
 terasic	Terasic Inc.
 thine	THine Electronics, Inc.
 ti	Texas Instruments
-- 
2.18.0.321.gffc6fa0e3

