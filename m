Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFE62C5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 10:23:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D34D20BEC
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 10:23:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="CmqkEFMP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D34D20BEC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732392AbeGKK0e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 06:26:34 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:52877 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726504AbeGKK0d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 06:26:33 -0400
Received: by mail-wm0-f68.google.com with SMTP id w16-v6so1892941wmc.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 03:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JbTJrwC5rqHIw+uLTouZ2T09vFohtXcwEOVbo4tHubY=;
        b=CmqkEFMPfKaD5l6ZCjdPzlvc3tFJ0OdXGmrXJqtA2AjcTIVkltbOrmvp57yuf267Bb
         juCwfZVczOQtQrCMLzfQa7NLOmZ27Ya8sdKBLUY9sXhJ4vlDI0tyQC2Z9ihmgOlIMY5F
         R5PSXDWXdzkPQAwcmabkOxffE0/FA7+Cbf7OE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=JbTJrwC5rqHIw+uLTouZ2T09vFohtXcwEOVbo4tHubY=;
        b=q79kge+sfW0L7MaGJ27qZn8Vb5/QWjNyu21xpogpGhHVN1ioSRwIpsuhGIZiwfv1D5
         quki4ViA/yblTumlzULxgMFYnrZsiOE48GPu4MXdZuRLGxmQZAoKeUmENWqsC6Jk+Rkd
         qMrppgSCLHmeCM1ToFvPCQzRtw58pUHDGsxsiJUeysyfidQRuyhAgBZgGQEW0HSygHKZ
         BuOz/+Z2XfWZt9Nk8vpG+UbZRWWHX5snWO3TsBJOlCVAVzrdOSnBbJIBWsEjPCxtxVMQ
         BL0HsopuLOXUSKhRqPOFOWSSAjb34NbmKDQEDJNwjO8mh2sHgPawdJxXVOLZKPsoiYdz
         b19g==
X-Gm-Message-State: APt69E1jbzIEE7vO173Jqt2jHOYziSLePP/pNRLYaUxnJMJuhy/9LrXx
        CMnZkxS20tj/xERXX9yRHdFCFQ==
X-Google-Smtp-Source: AAOMgpd3NIcJedxbI6f71G3prIq+5PhVA3tUWdzWeVbhKJosH43Jb8zrxa5rW8CJlzEdlVsJ0C33FQ==
X-Received: by 2002:a1c:8952:: with SMTP id l79-v6mr16153189wmd.7.1531304575590;
        Wed, 11 Jul 2018 03:22:55 -0700 (PDT)
Received: from localhost.localdomain (cpc90716-aztw32-2-0-cust92.18-1.cable.virginm.net. [86.26.100.93])
        by smtp.gmail.com with ESMTPSA id 73-v6sm2462032wmu.37.2018.07.11.03.22.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 11 Jul 2018 03:22:54 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, srinivas.kandagatla@linaro.org,
        Anson Huang <Anson.Huang@nxp.com>
Subject: [PATCH 3/4] dt-bindings: nvmem: imx-ocotp: add compatible string for imx6sll
Date:   Wed, 11 Jul 2018 11:20:42 +0100
Message-Id: <20180711102043.24079-4-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180711102043.24079-1-srinivas.kandagatla@linaro.org>
References: <20180711102043.24079-1-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anson Huang <Anson.Huang@nxp.com>

Add new compatible string for i.MX6SLL SOC.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 Documentation/devicetree/bindings/nvmem/imx-ocotp.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/nvmem/imx-ocotp.txt b/Documentation/devicetree/bindings/nvmem/imx-ocotp.txt
index 729f6747813b..792bc5fafeb9 100644
--- a/Documentation/devicetree/bindings/nvmem/imx-ocotp.txt
+++ b/Documentation/devicetree/bindings/nvmem/imx-ocotp.txt
@@ -1,7 +1,7 @@
 Freescale i.MX6 On-Chip OTP Controller (OCOTP) device tree bindings
 
 This binding represents the on-chip eFuse OTP controller found on
-i.MX6Q/D, i.MX6DL/S, i.MX6SL, i.MX6SX and i.MX6UL SoCs.
+i.MX6Q/D, i.MX6DL/S, i.MX6SL, i.MX6SX, i.MX6UL and i.MX6SLL SoCs.
 
 Required properties:
 - compatible: should be one of
@@ -10,6 +10,7 @@ Required properties:
 	"fsl,imx6sx-ocotp" (i.MX6SX),
 	"fsl,imx6ul-ocotp" (i.MX6UL),
 	"fsl,imx7d-ocotp" (i.MX7D/S),
+	"fsl,imx6sll-ocotp" (i.MX6SLL),
 	followed by "syscon".
 - #address-cells : Should be 1
 - #size-cells : Should be 1
-- 
2.16.2

