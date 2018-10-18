Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C68CDC67863
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 23:45:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87FA92087A
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 23:45:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="nExKmF6i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87FA92087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727285AbeJSHsh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 03:48:37 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:40374 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726935AbeJSHsg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 03:48:36 -0400
Received: by mail-pg1-f194.google.com with SMTP id n31-v6so14921218pgm.7
        for <linux-kernel@vger.kernel.org>; Thu, 18 Oct 2018 16:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=A2MPfrcipe6KjyzuOTKm79jYFeEpW7P2PfxdGu7lFRo=;
        b=nExKmF6iGC5wCAYr0rpd37bS9TW2CGDiDLpdfPmlRUqQuOiNGfNeSIhtqz1DG5lrxN
         4KvZ3odsuoOc8kwJZtWDL2Lf4OTKY6ejPVOLQgRSWREZIntzzii/j5N8/1RmZBQZhuJ8
         wlC1ZyytAj2K+Uuzwq9qiGS0DXY/1W+mhuf+58wwcPExWAaFJAnVj5RLE5Cw9xuRRYYi
         ABrLRWCKux2yat+trPx0HRV2QBf1vyZKFhdtlczf3FPXrxdQFCKhp+sgCIe+gQetLRNz
         jpFObOQUAGXKWR6uAIYP6Nnaw2+1ppSqJXc7AK5zNPL1rXa+J6+odqmgAFBy7NgqrJcH
         QHUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=A2MPfrcipe6KjyzuOTKm79jYFeEpW7P2PfxdGu7lFRo=;
        b=gJZuyLr97BdTLllJuMqXGARdr5c8mtmwYwIKDqLb0WRWi4XFc6oNUo9GUFy6AGSBzM
         CcoO2FzwtNx7gRWnItiUkcXp90upgnlPhIDuSB5hDCY9ucwzFQVlNWSqhFdyfQz+Dgvh
         OuuTpMYLh6QpfTpemrW1wfCARRCcC+qgYA8DIgu64ZYveCviUxErZtXz5ibd0FmMnsLX
         7LS4x48n4vQyk+dbdR2BvJw+tXMTPYzUe32LErd+nCzl6Jpz3nOVramF2LJhdpYhe2Eu
         8D80XWK+LTXXSbjoUGJEpWzhk79aE6aGhBeu0NSDUSCLM/1Lr+316PCocBLRoRRsIflO
         yL1w==
X-Gm-Message-State: ABuFfoicK9os6uDfqNyeJe4XuJG2/RDckAtgPpQwyb0U5r7WQS6SRRuF
        +pGRoEid2FI4XSlUU42MpTZQJw==
X-Google-Smtp-Source: ACcGV62M1pK7o5k11hm+dfuIQKOeXNHFeAUMuF/Po+BX1DwKriMxinpXJF0+qR/MnzFP3iOw299k6g==
X-Received: by 2002:a65:6295:: with SMTP id f21-v6mr30637759pgv.167.1539906316265;
        Thu, 18 Oct 2018 16:45:16 -0700 (PDT)
Received: from viisi.internal.sifive.com ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id u77-v6sm35701784pfj.40.2018.10.18.16.45.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Oct 2018 16:45:15 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
To:     linux-serial@vger.kernel.org
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 1/2] dt-bindings: serial: add documentation for the SiFive UART driver
Date:   Thu, 18 Oct 2018 16:43:53 -0700
Message-Id: <20181018234352.26788-2-paul.walmsley@sifive.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181018234352.26788-1-paul.walmsley@sifive.com>
References: <20181018234352.26788-1-paul.walmsley@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add DT binding documentation for the Linux driver for the SiFive
asynchronous serial IP block.  Nothing too exotic.

Cc: linux-serial@vger.kernel.org
Cc: devicetree@vger.kernel.org
Cc: linux-riscv@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Palmer Dabbelt <palmer@sifive.com>
Signed-off-by: Paul Walmsley <paul.walmsley@sifive.com>
Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 .../bindings/serial/sifive-serial.txt         | 21 +++++++++++++++++++
 1 file changed, 21 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/serial/sifive-serial.txt

diff --git a/Documentation/devicetree/bindings/serial/sifive-serial.txt b/Documentation/devicetree/bindings/serial/sifive-serial.txt
new file mode 100644
index 000000000000..8982338512f5
--- /dev/null
+++ b/Documentation/devicetree/bindings/serial/sifive-serial.txt
@@ -0,0 +1,21 @@
+SiFive asynchronous serial interface (UART)
+
+Required properties:
+
+- compatible: should be "sifive,fu540-c000-uart0" or "sifive,uart0"
+- reg: address and length of the register space
+- interrupt-parent: should contain a phandle pointing to the SoC interrupt
+    controller device node that the UART interrupts are connected to
+- interrupts: Should contain the UART interrupt identifier
+- clocks: Should contain a clock identifier for the UART's parent clock
+
+
+Example:
+
+uart0: serial@10010000 {
+	compatible = "sifive,uart0";
+	interrupt-parent = <&plic0>;
+	interrupts = <80>;
+	reg = <0x0 0x10010000 0x0 0x1000>;
+	clocks = <&prci PRCI_CLK_TLCLK>;
+};
-- 
2.19.1

