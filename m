Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB195C282CA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 11:52:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A009217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 11:52:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="lyC9fH+H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728978AbfBLLwr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 06:52:47 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:43014 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725916AbfBLLwr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 06:52:47 -0500
Received: by mail-pg1-f193.google.com with SMTP id v28so1133087pgk.10
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 03:52:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bHjcYouDUwGmYADd2nQo1JQfRUDKDl/5dUGsqZC02YA=;
        b=lyC9fH+HVS8pwNgQwHAJHNF62bOHJAEOq2H9ZUeA5eYLyuH8IoePItDYHNvHHTWC02
         QLNcPyjDQgayofr2pogSrMFZ3Tvw8RSm2YGhfzM8inhKjUxkFQRFUJA+/be3zSJD6usu
         FiHzojz6xlHvqsy0ot851H7mdev0dnZVWaFrw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bHjcYouDUwGmYADd2nQo1JQfRUDKDl/5dUGsqZC02YA=;
        b=rWfCJSh/A2VECn5M2isyZmXGTGMo6Lf65WkArBBL0P2JUA80rbXsVijtwcC62rXGAX
         h0ueiPuEavs9ZXiIOijCmLZ6AOsbOWkMQtoOk7GJyrLXqEDtNcZ+wQb11e8wTSEWg4I1
         /ZbY/OqmT5I6cH7cCYZJKSml1BsfQ6GgsLwv4FGwu5G+RmsylJUPgv3Ke8pbWVCLBNR9
         5r5uvQDtZRhl0TAOPibqGfBQfSQeqVtViUEXety2TQmTxIqW5USH3v4JdJetFzehMAgk
         xSTltYTKjCZy/zk7ysotMxiCfEQvrNwFtIiFbi3GX2F09x5i5uRt10bk6shHpz3+Iy+z
         Qc0A==
X-Gm-Message-State: AHQUAuZ37YhzXfIX+ZaSJ0TkyLubgtB7/DLOZCiSHlbvsjSEo4Bw4YTD
        PV8TXtaJtNWD70HySkzn/hqHXg==
X-Google-Smtp-Source: AHgI3IaKqQHIlQSbHjCIef9SP96WPBF+7Gbf0eBjwsGtNk0oWCABSQ0xiCz9fzqtvArDk7ppl+w7Dw==
X-Received: by 2002:a63:65c7:: with SMTP id z190mr3278040pgb.249.1549972366416;
        Tue, 12 Feb 2019 03:52:46 -0800 (PST)
Received: from localhost.localdomain ([115.97.184.151])
        by smtp.gmail.com with ESMTPSA id 10sm24244632pfq.146.2019.02.12.03.52.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Feb 2019 03:52:45 -0800 (PST)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH] dt-bindings: Add vendor prefix for feiyang
Date:   Tue, 12 Feb 2019 17:22:32 +0530
Message-Id: <20190212115232.4532-1-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add vendor prefix for feiyang, known as
Shenzhen Fly Young Technology Co.,LTD. a known producer for LCD modules.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
Note: notation about using 'feiyang' is based on the datasheet 
http://files.pine64.org/doc/datasheet/pine64/FY07024DI26A30-D_feiyang_LCD_panel.pdf

 Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index a5ad57eaee20..f42e12eb9d64 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -140,6 +140,7 @@ fairphone	Fairphone B.V.
 faraday	Faraday Technology Corporation
 fastrax	Fastrax Oy
 fcs	Fairchild Semiconductor
+feiyang	Shenzhen Fly Young Technology Co.,LTD.
 firefly	Firefly
 focaltech	FocalTech Systems Co.,Ltd
 friendlyarm	Guangzhou FriendlyARM Computer Tech Co., Ltd
-- 
2.18.0.321.gffc6fa0e3

