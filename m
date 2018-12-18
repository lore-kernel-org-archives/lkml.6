Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 426D6C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 21:30:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 114CE21871
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 21:30:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="RuD/SFuK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727631AbeLRVaz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 16:30:55 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51622 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727464AbeLRV30 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 16:29:26 -0500
Received: by mail-wm1-f65.google.com with SMTP id b11so4032513wmj.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Dec 2018 13:29:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pjswlD1e23GIOGqnqshs9PZr7BcQjfG+UIdQM34K8RM=;
        b=RuD/SFuKJ0SQK+SEHh3UFZXRGOhJ5+nnf0iFBceirjtS36EGEM+Bx2RDpoRCtTPDvU
         vmxWTldWoK2s9YcdZgsdnC0n/s0l9w92N4e+B8/hPJAcDbAbOrXf+V24mxBsQPEe3xZN
         9OyzSv0u+I/wNbHnUazPDFsoD4gj/ywkLNlOE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pjswlD1e23GIOGqnqshs9PZr7BcQjfG+UIdQM34K8RM=;
        b=LxjGYoefZqTVPAs534zuid6uo+pm33GK35VuhOvSRimGogUHBXUwVWf/EBLiO9+I1U
         qtXrEswH0rlLunww3Rv8KAxlg4+GbeCK1MKDMoqDifqgV8d8QTXIyUXS9Gw7vngUPQmG
         Gs8NtHPDjKDiQ+7U79nOG+1lVXBwld5USxRvS5a5FrYJJqaagjOqRSaLRl0h27ED7/OW
         W2igSgKHAit9446sPwNpu6JnV13zqkbYkE3fMu69sBeoxQO3IkhJBZOqwQ3mZEEZhowZ
         ZHPymOuj+M3UWmU/FsAJkb3yPdYsZqZqPIFSmARkWhsn0E6a0mQzpUNuEwH5LHtJpP8C
         8v6A==
X-Gm-Message-State: AA+aEWYHQQWAIk70d+o6jREvv5IXweL6f82mQeftogiB2P+HHVJQ5tSW
        eQq3LG2tRAL2PxXDpXWnJ6dH1g==
X-Google-Smtp-Source: AFSGD/W3kJgJHYUMfnx2guzmBg3qa/KwMhZ1HpWubVmtDkM8Gr+LaIYI+64OkcFUMgHMP5KnWnN6dA==
X-Received: by 2002:a1c:6508:: with SMTP id z8mr4762889wmb.28.1545168564417;
        Tue, 18 Dec 2018 13:29:24 -0800 (PST)
Received: from localhost.localdomain (105.50.92.92.rev.sfr.net. [92.92.50.105])
        by smtp.gmail.com with ESMTPSA id o4sm4153485wrq.66.2018.12.18.13.29.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Dec 2018 13:29:23 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, Biju Das <biju.das@bp.renesas.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS)
Subject: [PATCH 10/25] dt-bindings: timer: renesas, cmt: Document r8a7796 CMT support
Date:   Tue, 18 Dec 2018 22:28:28 +0100
Message-Id: <20181218212844.30445-10-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181218212844.30445-1-daniel.lezcano@linaro.org>
References: <d3f1255a-592d-13d9-5d3f-bd3ec7a36742@linaro.org>
 <20181218212844.30445-1-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Biju Das <biju.das@bp.renesas.com>

Document SoC specific bindings for R-Car M3-W (r8a7796) SoC.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 Documentation/devicetree/bindings/timer/renesas,cmt.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/timer/renesas,cmt.txt b/Documentation/devicetree/bindings/timer/renesas,cmt.txt
index 33992679a8bd..6de27b60b51a 100644
--- a/Documentation/devicetree/bindings/timer/renesas,cmt.txt
+++ b/Documentation/devicetree/bindings/timer/renesas,cmt.txt
@@ -36,6 +36,8 @@ Required Properties:
     - "renesas,r8a7793-cmt1" for the 48-bit CMT1 device included in r8a7793.
     - "renesas,r8a7794-cmt0" for the 32-bit CMT0 device included in r8a7794.
     - "renesas,r8a7794-cmt1" for the 48-bit CMT1 device included in r8a7794.
+    - "renesas,r8a7796-cmt0" for the 32-bit CMT0 device included in r8a7796.
+    - "renesas,r8a7796-cmt1" for the 48-bit CMT1 device included in r8a7796.
     - "renesas,r8a77970-cmt0" for the 32-bit CMT0 device included in r8a77970.
     - "renesas,r8a77970-cmt1" for the 48-bit CMT1 device included in r8a77970.
     - "renesas,r8a77980-cmt0" for the 32-bit CMT0 device included in r8a77980.
-- 
2.17.1

