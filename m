Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76379C43444
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 10:21:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4763220659
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 10:21:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="WCWW2S/Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726653AbfANKVS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 05:21:18 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:36628 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726064AbfANKVR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 05:21:17 -0500
Received: by mail-pg1-f196.google.com with SMTP id n2so9270712pgm.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 02:21:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yxCl8KASROd/ypLyaZ23DK2nTV9xmxQ5lybfWhMjKwY=;
        b=WCWW2S/ZjFTW6FLCyacIhioNMyweYfdFqfyoN5VeLCOZj4OzsxhB0aDGq6kTYdhz+r
         vEDh6r0eeJvAZB/SBBTMQ+pAC6DUX6z0iVAW17AH8bkYJR9uWn3VhilhrDlYpinr4WeJ
         T2Rf5KH/17o/UnXIu2jZT8qr2ry81Xil65ocw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=yxCl8KASROd/ypLyaZ23DK2nTV9xmxQ5lybfWhMjKwY=;
        b=VjBGg2zeYl9YRPBCDaogHweoBCvGJuRrP83BDN3j3vgM1bgKD9v/dA106U29vXMQo2
         lVEbA62stjj8qE/gzEKUer/DW6b8Yzz8xTiJ43g5GbowQx8Y3w7j/uOvGgf6xSYEKdXl
         C1mcjAdQtmF7OyBzhB7LOdxPsefBNsGTnnmjgI3QTtK6/YgK9olOX00Km9E1mMgvuJEk
         eJbswKcZaG0ZmT/ExFDBMU0+DuaP8+sXho0L7MnVomb2YIYH7/KjZNBzpDW04+4y+y2X
         dD2QOClrherMeTT+b5cHZrY7BDxJKU+wpNbyOVpzXCpE+i51nWbHXYxgTwdqFFGWB5fj
         LYtA==
X-Gm-Message-State: AJcUukfnj1MRoxRQHhP1QzNgGu8wgJsTurkhXBltI1ay6cvFbojoxOhw
        5+laTnGl2DTqnXAmEc9/vZC3
X-Google-Smtp-Source: ALg8bN5f45Bf4gwEl3pHiDHb9Nrd21QDIKmoyoJBHoB4eEWSkRmE1H8gtYxiCra8KuijJWmlAQyv6g==
X-Received: by 2002:a62:444b:: with SMTP id r72mr25048552pfa.184.1547461277296;
        Mon, 14 Jan 2019 02:21:17 -0800 (PST)
Received: from localhost.localdomain ([2409:4072:6306:f12b:7d9b:d1a4:6536:aa21])
        by smtp.gmail.com with ESMTPSA id 15sm36429pfr.55.2019.01.14.02.21.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 14 Jan 2019 02:21:16 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     shawnguo@kernel.org, leoyang.li@nxp.com, robh+dt@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, a.tropschug@ebs-systart.com,
        m.bittner@ebs-systart.com, amit.kucheria@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 2/3] dt-bindings: arm: fsl: Add devicetree binding for Oxalis
Date:   Mon, 14 Jan 2019 15:50:52 +0530
Message-Id: <20190114102053.16013-3-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190114102053.16013-1-manivannan.sadhasivam@linaro.org>
References: <20190114102053.16013-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add devicetree binding for Oxalis board in JSON format. While adding
that, let's fix the description for LS1012A also.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 Documentation/devicetree/bindings/arm/fsl.yaml | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index d34fe0749199..0f30142fe316 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -173,12 +173,13 @@ properties:
               - fsl,vf610
               - fsl,vf610m4
 
-      - description: LS1021A based Boards
+      - description: LS1012A based Boards
         items:
           - enum:
               - fsl,ls1012a-rdb
               - fsl,ls1012a-frdm
               - fsl,ls1012a-qds
+              - ebs-systart,oxalis
           - const: fsl,ls1021a
 
       - description: LS1043A based Boards
-- 
2.17.1

