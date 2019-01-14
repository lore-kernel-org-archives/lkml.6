Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 662CFC43444
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 17:29:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38532206B7
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 17:29:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547486979;
	bh=+lxSRAEHv34rgXn7TI4kZ05mg2nIbsd43f7RUJgOiYQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=E94CbmBxKBSGqlId97L0Kj2Wyzpt+GHALtP5MDyLPJTiExHb0tEYSTbH9DdK2B3Et
	 rZArnKhYPoLa01ekvSHq7qrWJjrTolcUuNRN9awD99nv9gxHh3UPjCyS52aiakXGL+
	 LtvsrJX9aBJydmyZi4dNxz6INApeENf1R8b+KhHo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726868AbfANR3i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 12:29:38 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:34646 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726742AbfANR3e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 12:29:34 -0500
Received: by mail-ot1-f66.google.com with SMTP id t5so20045555otk.1;
        Mon, 14 Jan 2019 09:29:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DF4z7G+bPH8HV6nw+yBbgDSaink2L0Ol0QaxTDjc1VM=;
        b=CEntkucDXko/v4RsUfKTtEivGyqpebi28tzRTbaxuLG53FoT+ywtZ20ft/j2GDO6rL
         hSc8hJxfl+P0iYO0GnclgXzYG2KO90J4DHUb9uv+1wZr3RZTn+2ilDrJQ+RST5TyEG99
         L3Y1oVvfTRKIOIw8vsgFYM2JeJzHA/NEGwyUhdJDyFNIbdR0w/U2m6zeyl4HLEEuKoAa
         7vz330ze9np0sUv5l+B1jCNO1yVyqai31BrdS5Zd0vpsEzY4D6eA1zqwM1lzuoBfs8Er
         5u88b/gM5ugcZBl6WY13eYbS8GhRezkXED6fXg/X9FvCHfAUjoLZBNYe7KRD1nNYNru9
         FYXA==
X-Gm-Message-State: AJcUukdiA8qTSS3Zj+4Bmlx7waxERcnPJudAJ9jGvuRZHYEmc/cNNCTz
        jb06SycOmjsJEOiUVXP7yIer85Y=
X-Google-Smtp-Source: ALg8bN4pmOi0C8up0DV2pW8pwDav+lVcgVUYYTxoX7vhQ280XI/0C1cMGpj+6ZkCAHbJpSaupiGJkw==
X-Received: by 2002:a9d:58c:: with SMTP id 12mr17875282otd.33.1547486973014;
        Mon, 14 Jan 2019 09:29:33 -0800 (PST)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id 31sm943609otw.55.2019.01.14.09.29.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 14 Jan 2019 09:29:32 -0800 (PST)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Simon Horman <horms+renesas@verge.net.au>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org
Subject: [PATCH v2 2/2] dt-bindings: serial: Move renesas,rzn1-uart into the snps-dw-apb-uart binding
Date:   Mon, 14 Jan 2019 11:29:30 -0600
Message-Id: <20190114172930.7508-2-robh@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190114172930.7508-1-robh@kernel.org>
References: <20190114172930.7508-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The renesas,rzn1-uart binding only differs in compatible string from the
snps-dw-apb-uart binding. Move it there, converting it to json-schema in
the process.

Cc: Phil Edworthy <phil.edworthy@renesas.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Rob Herring <robh@kernel.org>
---
v2:
- Move Renesas compatible strings to this patch

 .../devicetree/bindings/serial/renesas,rzn1-uart.txt   | 10 ----------
 .../devicetree/bindings/serial/snps-dw-apb-uart.yaml   |  5 +++++
 2 files changed, 5 insertions(+), 10 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/serial/renesas,rzn1-uart.txt

diff --git a/Documentation/devicetree/bindings/serial/renesas,rzn1-uart.txt b/Documentation/devicetree/bindings/serial/renesas,rzn1-uart.txt
deleted file mode 100644
index 8b9e0d4dc2e4..000000000000
--- a/Documentation/devicetree/bindings/serial/renesas,rzn1-uart.txt
+++ /dev/null
@@ -1,10 +0,0 @@
-Renesas RZ/N1 UART
-
-This controller is based on the Synopsys DesignWare ABP UART and inherits all
-properties defined in snps-dw-apb-uart.txt except for the compatible property.
-
-Required properties:
-- compatible : The device specific string followed by the generic RZ/N1 string.
-   Therefore it must be one of:
-   "renesas,r9a06g032-uart", "renesas,rzn1-uart"
-   "renesas,r9a06g033-uart", "renesas,rzn1-uart"
diff --git a/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml b/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
index 3e90c790d720..b42002542690 100644
--- a/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
+++ b/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
@@ -15,6 +15,11 @@ allOf:
 properties:
   compatible:
     oneOf:
+      - items:
+          - enum:
+              - renesas,r9a06g032-uart
+              - renesas,r9a06g033-uart
+          - const: renesas,rzn1-uart
       - items:
           - enum:
               - rockchip,px30-uart
-- 
2.19.1

