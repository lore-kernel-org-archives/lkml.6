Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2001C282CB
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 23:16:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C4FD2081B
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 23:16:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="FIKgrVow"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728873AbfBDXQy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 18:16:54 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:43028 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728747AbfBDXQ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 18:16:28 -0500
Received: by mail-pl1-f195.google.com with SMTP id gn14so638029plb.10
        for <linux-kernel@vger.kernel.org>; Mon, 04 Feb 2019 15:16:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=a7MzBPjh33iBCLs/1GM1JkRcNR8aZ6QrK9iw1qmq9bg=;
        b=FIKgrVowW6CfM0Y9NwQ082rA4bqUiM8F5ayBQQdQx9KezoF/7lvegKdpr+U+Sq6yFc
         Xa1EtvxEuO814TC7tSUEw9/ipcVJeTLOSX+tnIFG0Oo6ZXypo0NjwcqnjYh/SfEVJNRL
         Qs1PFTydyPvNLCHAu8JcKoPVZbZThlNEGQLaI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=a7MzBPjh33iBCLs/1GM1JkRcNR8aZ6QrK9iw1qmq9bg=;
        b=NOdnXMqBeOmJiEHkWPqyTzAXXarvxszw04v6zhMM+2cF6W+Vlr7iQIQLg1YActo783
         xyUfKbf3qeS4UoIHe/S5qg/EgWwoMAYQvqU6L4iId9dKtIRCaLaXqawt9suV3C5qutMn
         yxGO4f5YphbY+UUeoWSdqoAf7t0z2k97TX/cdCVSqVdFf1I2UCduJwleltToknySU6Z5
         VmzO9ooYSko6xZk4nUD7D+BJVcXgZcRWXxCzNw2iq0j484kj6pvfkqbOBCnbMqTNovOQ
         cvyIuD184tCsjJbA5qE/CffRBeB7dZLAFe+yMdzWQNSvsJZvzZwlQw5BVLdUcroK++r7
         ldTw==
X-Gm-Message-State: AHQUAuZvzte4cZLo2FDnyCp46ztXrc3JaMgHWRZJxEpFMTef91+imOyv
        zJ7WPjQ78xYAzdzfFJoioZgVUQ==
X-Google-Smtp-Source: AHgI3Ib23vBnlx4Cct0sztg0qclMcEJbcJJu7Mkp0p/uxl0JTAIGFkmeNFcRmn+c1nOIQymn9ttIuQ==
X-Received: by 2002:a17:902:1101:: with SMTP id d1mr1929664pla.136.1549322187393;
        Mon, 04 Feb 2019 15:16:27 -0800 (PST)
Received: from rj-aorus.ric.broadcom.com ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id z14sm1281499pgv.47.2019.02.04.15.16.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Feb 2019 15:16:26 -0800 (PST)
From:   Ray Jui <ray.jui@broadcom.com>
To:     Wolfram Sang <wsa@the-dreams.de>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
        Ray Jui <ray.jui@broadcom.com>
Subject: [PATCH v4 6/8] dt-bindings: i2c: iproc: add "brcm,iproc-nic-i2c" compatible string
Date:   Mon,  4 Feb 2019 15:15:52 -0800
Message-Id: <20190204231554.87666-7-ray.jui@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190204231554.87666-1-ray.jui@broadcom.com>
References: <20190204231554.87666-1-ray.jui@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>

Update iProc I2C binding document to add new compatible string
"brcm,iproc-nic-i2c". Optional property "brcm,ape-hsls-addr-mask" is
also added that allows configuration of the host view into the APE's
address for "brcm,iproc-nic-i2c"

Signed-off-by: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
Signed-off-by: Ray Jui <ray.jui@broadcom.com>
---
 Documentation/devicetree/bindings/i2c/brcm,iproc-i2c.txt | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/i2c/brcm,iproc-i2c.txt b/Documentation/devicetree/bindings/i2c/brcm,iproc-i2c.txt
index d3a3620b1f06..02e82d20239e 100644
--- a/Documentation/devicetree/bindings/i2c/brcm,iproc-i2c.txt
+++ b/Documentation/devicetree/bindings/i2c/brcm,iproc-i2c.txt
@@ -3,7 +3,7 @@ Broadcom iProc I2C controller
 Required properties:
 
 - compatible:
-    Must be "brcm,iproc-i2c"
+    Must be "brcm,iproc-i2c" or "brcm,iproc-nic-i2c"
 
 - reg:
     Define the base and range of the I/O address space that contain the iProc
@@ -24,6 +24,9 @@ Optional properties:
     Should contain the I2C interrupt. If unspecified, driver will fall back to
     polling mode
 
+- brcm,ape-hsls-addr-mask:
+    Required for "brcm,iproc-nic-i2c". Host view of address mask into the
+    'APE' co-processor
 
 Example:
 	i2c0: i2c@18008000 {
-- 
2.17.1

