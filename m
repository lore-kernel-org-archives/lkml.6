Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82180C282CD
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:36:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 509902147A
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:36:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="eL0OqY1M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729941AbfA1RgT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 12:36:19 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55981 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729850AbfA1PzN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 10:55:13 -0500
Received: by mail-wm1-f68.google.com with SMTP id y139so14414720wmc.5
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 07:55:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lBFH16G24nu4YB67dt1sl6z4UKIl9qGdXLFE8KrZbCM=;
        b=eL0OqY1M94ki7CFOX8th19DbRBmvm2E2XuEXfkfkgqyY1YgzbJi8svnjCwgdYQ/Pu8
         gFzlSYaETp+oMyx6MdbfszC5y64vXad3XcBhNB1yJStJcA52XTTnC7SNynO9edUuLmX5
         S+exfaN2++GQbztJZz8B0kHpCWMPFdBJqCTgI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lBFH16G24nu4YB67dt1sl6z4UKIl9qGdXLFE8KrZbCM=;
        b=OrSSKxLPI4whGz6jvBq8iIaIsxEXk/YL8RGCNmbQc3GMSC9nqGtbd4SAipVPMVuz+7
         4+BK1JJQNxjDjaDTpWaaa1o4p69D7x12PNip46ipNsqDegPxnokTwUrAbSJwCKNJgOmg
         V2fR3B3XqwqJ54NFd1RnI8IKZjSkjDsBgQ+ZNOMslg0hTi+b3/4QW2I/RiAmO4S5GVaF
         OmwyKOAi2CzaANHLy59ePXJdInREOL39738TJUuKFro6AWuSFKPb0kEOeqqXu2nIxcnZ
         SdH1LieNT3mIMcYMFN/XsCfZN19MBG1v7lxQef/jRFakTJSQYpCPtH12U3td6BEw7Dee
         TjUw==
X-Gm-Message-State: AJcUukfyAAbBFFi5OKGPPVicJSFfT3IeOe7dBKkM12aVd4OEBagMUDV9
        8l+36hoVsAp+bLqWMi7ejdS+sQ==
X-Google-Smtp-Source: ALg8bN6c8F0m/m/jHFZzb4uOfJmpYi4p6pCJYmfDayJK/njfhDdwafnbY3cXHJu3Nclosrtz+T2xnQ==
X-Received: by 2002:a1c:6e06:: with SMTP id j6mr18350492wmc.3.1548690911956;
        Mon, 28 Jan 2019 07:55:11 -0800 (PST)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id p6sm145140485wrx.50.2019.01.28.07.55.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 28 Jan 2019 07:55:11 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 03/13] dt-bindings: nvmem: imx-ocotp: add compatible string for i.MX7ULP
Date:   Mon, 28 Jan 2019 15:54:56 +0000
Message-Id: <20190128155506.25566-4-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190128155506.25566-1-srinivas.kandagatla@linaro.org>
References: <20190128155506.25566-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anson Huang <anson.huang@nxp.com>

Add new compatible string for i.MX7ULP SOC.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 Documentation/devicetree/bindings/nvmem/imx-ocotp.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/nvmem/imx-ocotp.txt b/Documentation/devicetree/bindings/nvmem/imx-ocotp.txt
index 792bc5fafeb9..ff389cf1606e 100644
--- a/Documentation/devicetree/bindings/nvmem/imx-ocotp.txt
+++ b/Documentation/devicetree/bindings/nvmem/imx-ocotp.txt
@@ -11,6 +11,7 @@ Required properties:
 	"fsl,imx6ul-ocotp" (i.MX6UL),
 	"fsl,imx7d-ocotp" (i.MX7D/S),
 	"fsl,imx6sll-ocotp" (i.MX6SLL),
+	"fsl,imx7ulp-ocotp" (i.MX7ULP),
 	followed by "syscon".
 - #address-cells : Should be 1
 - #size-cells : Should be 1
-- 
2.20.1

