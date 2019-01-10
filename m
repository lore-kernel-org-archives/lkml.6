Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38F8BC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 22:20:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 054B0208E3
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 22:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547158826;
	bh=WXV90ccBtYQ2r/iiFrrc9ColyrT4tpGh3kLj2fGdOQ0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fBbP3ExXVO4C8lgmPKEu42LHrKxfqBrPQszRTWD9JTMdO/rrk8vcpoiilh9PUKXvi
	 YFavRSzhAXwHCyPj5PKMkKPuKwC5p9ZKtSfjs992UTbrLG6RAfLoWe+FzcqUZ3zfh8
	 WL8WjaMQpPaG99ufQpe41LoWV2aKTXBEuUgBNjPM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729372AbfAJWUZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 17:20:25 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:40186 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728273AbfAJWUU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 17:20:20 -0500
Received: by mail-oi1-f195.google.com with SMTP id t204so10619087oie.7;
        Thu, 10 Jan 2019 14:20:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=geb12u7e4XRhFs13qoybO1gzavO0P03TiMHBlXSczXU=;
        b=Svrp3ZibNWEKXVccPunQar2eVELzIwDWKH7Yo6/OkYpVk9FdTJ2J4OLXMS8Se0gMSr
         M1CW1GTekvbsOhnKQ/e3Z87PCVvkDfrz6EocJnCWnzw5SeWYqG31f5JUkk3JAoE1JJfw
         uRdWzhdUDOeO5vg9aNpGwxOLAsZk3XtSo3D3VhW8Ilch69UtpHCR77mpDdAutVR5OEZk
         0ZRx+5Z4uYNNHXy3ticHSJPyTx/KxEX634FUjeJzc8o0H4RTxMf+Ll+HraCJTIWuvnhd
         HKeqY7ifiwQbNPkCmTmqz9ow99+kgR5ZZ8MnHBsoJ7BlJ2V7HB8JT4SzxT4CEwqFUi34
         B24w==
X-Gm-Message-State: AJcUukd6ZUx1dNuGfyM2kp6Bi+sVv5Fxjrl+WRpy4VZ3EgDKi1hPi9uC
        NsQLIxu9rf7M30/7HV4Ppmx+iYQ=
X-Google-Smtp-Source: ALg8bN7tzlHqc0WzLzazssRGfsL6iwDmPQiAHP75XceXpJhZj/Ur2PN5+bjEKYP/p9wjYJwwAIJpfQ==
X-Received: by 2002:aca:dc46:: with SMTP id t67mr7272029oig.279.1547158819561;
        Thu, 10 Jan 2019 14:20:19 -0800 (PST)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id r9sm41471303otq.81.2019.01.10.14.20.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Jan 2019 14:20:18 -0800 (PST)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org
Subject: [PATCH 2/2] dt-bindings: serial: Move renesas,rzn1-uart into the snps-dw-apb-uart binding
Date:   Thu, 10 Jan 2019 16:20:17 -0600
Message-Id: <20190110222017.6390-2-robh@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190110222017.6390-1-robh@kernel.org>
References: <20190110222017.6390-1-robh@kernel.org>
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
Cc: Simon Horman <horms+renesas@verge.net.au>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/serial/renesas,rzn1-uart.txt   | 10 ----------
 1 file changed, 10 deletions(-)
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
-- 
2.19.1

