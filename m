Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33F93C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 19:26:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F086A214DE
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 19:26:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IQcJlsuy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F086A214DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726072AbeLFT0v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 14:26:51 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:33471 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725988AbeLFT0o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 14:26:44 -0500
Received: by mail-io1-f65.google.com with SMTP id t24so1341695ioi.0;
        Thu, 06 Dec 2018 11:26:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XpPLyZ2QZx9zJ8myflnykoqtYXVlfnbgIkHwa0jk1Ws=;
        b=IQcJlsuyLUi3lAJgKn3x/9wObtV4ZCn/dpW8bDvUzk5u/Z2f4m87Oo1i0UyA4xCsRn
         TDOzuYCDQNQP1LzkG9/Wun5O47z0ICwxYbMUtsMQVduOhwwPhwQaYtPwgbBxS7MqooyC
         kDhQxtSCU+maWcIlK7mfqqi43QtGgKVCQ9rS9fEzVF5ex5xjcHy/FIFEG2KoaCnTunAV
         VEzWxaEgF70CwdM9jBmncLL2qimdBhsR4vuafc0i2D+wQdrLdd3SbGUwvEx8hY8L5czN
         GTz3GJ7fPldxOF4X/5r1munvtU4HZoMBUtylgbLOvH7gT3hWCNHkUiPYHxDuO1snRTqK
         ESoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=XpPLyZ2QZx9zJ8myflnykoqtYXVlfnbgIkHwa0jk1Ws=;
        b=cH6ucjiuB/sOvWUjpPvxLPrPp7wM62LAcHhtkKI/Ln0M2qG//5O4kDemgp0hcz0jyZ
         ObzcKd+WASsVoP471ZjKkRsta8ULKlnNIi3ElcNAiXEb/0iPjwZeYHIc9bZp8JBsefrB
         Hcs9uLmff5wdzIxkFnIuT2U/7gY7c4wxc7CPJ6JHHQQFdGcqhvOlvLB3CnQWAG1oKCfh
         E1abOJihoPl4E8bliRNkihrVXyh9kH2iJMYCPwFwL/mBH8xVWFP79cTIQoDiLtTraPQy
         7hJg+PBknoMHcNVVW30pQg0pXKwTxliTDLnxOC9083nrluF2TD8srpL0Rn6euFzLPphi
         PtPg==
X-Gm-Message-State: AA+aEWZoA9134MiRB09MShMo5/P41UvUf/FDGGiA8zI4TneyExDRVvNe
        yNVNEMraZsgd5qUK99kW/Ao=
X-Google-Smtp-Source: AFSGD/UwuY4mhxv4rL3VQqPNKhpSHg9YTDToWzn/2pcqHpU6fF5SD2qX4ckPOU2oRRxkAvzYZCws4g==
X-Received: by 2002:a5e:c107:: with SMTP id v7mr2164969iol.155.1544124403218;
        Thu, 06 Dec 2018 11:26:43 -0800 (PST)
Received: from svens-asus.arcx.com ([184.94.50.30])
        by smtp.gmail.com with ESMTPSA id 195sm819524itm.2.2018.12.06.11.26.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Dec 2018 11:26:42 -0800 (PST)
From:   Sven Van Asbroeck <thesven73@gmail.com>
X-Google-Original-From: Sven Van Asbroeck <TheSven73@googlemail.com>
To:     TheSven73@googlemail.com, Shawn Guo <shawnguo@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Rob Herring <robh@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v3 2/3] dt-bindings: bus: imx-weim: document multiple address ranges per child node
Date:   Thu,  6 Dec 2018 14:26:32 -0500
Message-Id: <20181206192633.25319-3-TheSven73@googlemail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181206192633.25319-1-TheSven73@googlemail.com>
References: <20181206192633.25319-1-TheSven73@googlemail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The imx-weim driver was patched to allow correct WEIM configuration
when multiple address ranges are used in a child node.
Update the dt-bindings to reflect this.

Signed-off-by: Sven Van Asbroeck <TheSven73@googlemail.com>
---
 .../devicetree/bindings/bus/imx-weim.txt      | 32 +++++++++++++++++--
 1 file changed, 29 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/bus/imx-weim.txt b/Documentation/devicetree/bindings/bus/imx-weim.txt
index 683eaf3aed79..dda7d6d66479 100644
--- a/Documentation/devicetree/bindings/bus/imx-weim.txt
+++ b/Documentation/devicetree/bindings/bus/imx-weim.txt
@@ -47,9 +47,9 @@ Optional properties:
 Timing property for child nodes. It is mandatory, not optional.
 
  - fsl,weim-cs-timing:	The timing array, contains timing values for the
-			child node. We can get the CS index from the child
-			node's "reg" property. The number of registers depends
-			on the selected chip.
+			child node. We get the CS indexes from the address
+			ranges in the child node's "reg" property.
+			The number of registers depends on the selected chip:
 			For i.MX1, i.MX21 ("fsl,imx1-weim") there are two
 			registers: CSxU, CSxL.
 			For i.MX25, i.MX27, i.MX31 and i.MX35 ("fsl,imx27-weim")
@@ -80,3 +80,29 @@ Example for an imx6q-sabreauto board, the NOR flash connected to the WEIM:
 					0x0000c000 0x1404a38e 0x00000000>;
 		};
 	};
+
+Example for an imx6q-based board, a multi-chipselect device connected to WEIM:
+
+In this case, both chip select 0 and 1 will be configured with the same timing
+array values.
+
+	weim: weim@21b8000 {
+		compatible = "fsl,imx6q-weim";
+		reg = <0x021b8000 0x4000>;
+		clocks = <&clks 196>;
+		#address-cells = <2>;
+		#size-cells = <1>;
+		ranges = <0 0 0x08000000 0x02000000
+			  1 0 0x0a000000 0x02000000
+			  2 0 0x0c000000 0x02000000
+			  3 0 0x0e000000 0x02000000>;
+		fsl,weim-cs-gpr = <&gpr>;
+
+		acme@0 {
+			compatible = "acme,whatever";
+			reg = <0 0 0x100>, <0 0x400000 0x800>,
+				<1 0x400000 0x800>;
+			fsl,weim-cs-timing = <0x024400b1 0x00001010 0x20081100
+				0x00000000 0xa0000240 0x00000000>;
+		};
+	};
-- 
2.17.1

