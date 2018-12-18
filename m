Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C785C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 03:42:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5903D20815
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 03:42:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="e9/jx4XX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726568AbeLRDmJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 22:42:09 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:38205 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726276AbeLRDmI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 22:42:08 -0500
Received: by mail-pl1-f193.google.com with SMTP id e5so7157334plb.5
        for <linux-kernel@vger.kernel.org>; Mon, 17 Dec 2018 19:42:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OZbNRq4vPh2tMrFA0qvMX9547LZd+ov7go0ZcVd3YcY=;
        b=e9/jx4XXBBHsykTDH2Pg1At46RxQPhk4s4s582HcW0woZhCBJeh2WF4J/SnCJEx6Vr
         SKgK83oEUvb9ghchldx33SbcpX6V/qUDki52nurNu0UWvFJJuo0GcCTzv4pbInpFaAyr
         dAmqqjInUY0oRBX0gBw/t5r2UfAle+Q1aVjF0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OZbNRq4vPh2tMrFA0qvMX9547LZd+ov7go0ZcVd3YcY=;
        b=G9c6ARPl0LuIYLoS4P0Gge67ZR7w5XhSBvEWiqCoVN82EvdBwyWhA4al22iTkOkDIK
         LTmHmeadl8d2cxuTLNCZjAjt86MAWe9ZkWiXHxdb867KkBJS59Tjibx9KLRMHbBjxk9G
         +kMhsMrnZwPUDHtMjrmUuahHN6nknWo/ZfOgGhJMLYLiHIEzhz7jftnkMtYWnBQKMKTF
         3BPXZTqZ0Dnm6CIlmaNIMWy3oevgCHxXujbWQ+tjsaLMSJL5X+3lKMD9jsUdqesl1wRD
         QBhxuVixsFPQIYhfgFBvjHKXm3MlUMIZTa1QuGwhJSqAs99N9Q8jocB1teL/7TjWwC79
         BUwA==
X-Gm-Message-State: AA+aEWar4aCwFLGAy0V0Sw1ERdz5AI+0ICrnV1sNUwpvBocwAUTtVPrh
        QfrgC/7AuQdYjCPqsNmSwU1N
X-Google-Smtp-Source: AFSGD/UbMW5hZvBiHPXTEj5uqfAcMJbc+8Epu3NcsSd9vdipdWB48S7j7jOIBLBOpfmDQ7b1WLbe5Q==
X-Received: by 2002:a17:902:4c85:: with SMTP id b5mr14311123ple.226.1545104527493;
        Mon, 17 Dec 2018 19:42:07 -0800 (PST)
Received: from localhost.localdomain ([2409:4072:702:382e:8c68:d268:ed20:5f25])
        by smtp.gmail.com with ESMTPSA id b202sm25255422pfb.88.2018.12.17.19.42.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Dec 2018 19:42:06 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     olof@lixom.net, arnd@arndb.de, robh+dt@kernel.org,
        gregkh@linuxfoundation.org, jslaby@suse.com
Cc:     linux-unisoc@lists.infradead.org, afaerber@suse.de,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-serial@vger.kernel.org,
        amit.kucheria@linaro.org, linus.walleij@linaro.org,
        zhao_steven@263.net,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v5 01/11] dt-bindings: Add RDA Micro vendor prefix
Date:   Tue, 18 Dec 2018 09:11:22 +0530
Message-Id: <20181218034132.5070-2-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181218034132.5070-1-manivannan.sadhasivam@linaro.org>
References: <20181218034132.5070-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andreas Färber <afaerber@suse.de>

Add vendor prefix for RDA Micro which now merged into Unisoc
Communications Inc.

Signed-off-by: Andreas Färber <afaerber@suse.de>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index 4b1a2a8fcc16..37826fac7684 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -320,6 +320,7 @@ ralink	Mediatek/Ralink Technology Corp.
 ramtron	Ramtron International
 raspberrypi	Raspberry Pi Foundation
 raydium	Raydium Semiconductor Corp.
+rda	Unisoc Communications, Inc.
 realtek Realtek Semiconductor Corp.
 renesas	Renesas Electronics Corporation
 richtek	Richtek Technology Corporation
-- 
2.17.1

