Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03D82C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 15:48:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C26BF2133F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 15:48:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H7NGXjiP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387809AbeLQPsK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 10:48:10 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:36446 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387785AbeLQPsH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 10:48:07 -0500
Received: by mail-it1-f194.google.com with SMTP id c9so20622995itj.1;
        Mon, 17 Dec 2018 07:48:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=TrIXZ/21JXhBKAnyXh04Tha2y/BgJRmdZetivqpxDd8=;
        b=H7NGXjiP7LiYBRDwdLFjU3UrOI9hrgpNL/zIOe9nJeMYdH97UNuDfnyGEt75Bu/PAj
         adr9TLha3EWBFmXEH9+N7P9jSGrVWwFAmtaTq+5NehqBisAyiGQaPQWQV1mvQ4TcvuQW
         +R3lxVpTzAd6jF40kPHx4CMgxI05lFNkGOovdUlpOXpLCSmBPAuf1pcRa7CcO0JDZ1go
         1x1E6GuyCacR1mrlGykrk3SiZaXxpra/BXZMZydwqIDEnPPrdUrM/c8TnmeR+LgFAzoj
         485RltklpQhWZWDqLrXZtZmJub3QwSQI2v3CEXlxk/7iZwEGfeljwrDSZdWpsRaKnxJJ
         QTRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=TrIXZ/21JXhBKAnyXh04Tha2y/BgJRmdZetivqpxDd8=;
        b=QAotUYHXrJ7li2aLdsNDFzJme3dZsg6iKCLS1DcvJheM11vF29ujHibO35QDg+NFL2
         wA4l5qXj7ZX/bMspuUPNfe7bBCWCo9J/E0tB8QgPq6DdgFiOcFltCauJFbmrjC7UDnep
         KqNcbWmPfkOxoPSd3z6Wv7ejN7gh1DDuaVgZIMTdEKdMsRbhlcTCJMuksmwt7Um22NMr
         FIg8yTBmH5aKTBLJenzl1rjs4EA1PiRMBZnjHCusVCiLHMg7JbnMUZv9g9XgnasSKN+g
         eR8Tw4b6MNwuV42ys0Q2bq3dfrErsg57aVwLU5wJ6v7LmPJpPLPDC3jYdu7ztDJqqw6d
         WdWw==
X-Gm-Message-State: AA+aEWYNabAj4s8G8uxzK07y2/huXHF3zpRniZPNAjKw8mXdvK9+9Tb6
        8ROHbK000BeQ2NjAXoKHLsI=
X-Google-Smtp-Source: AFSGD/VZx2+m6p4ZZfPl8FW95WfTy+Q3iDSNa+Gd2MNWpGQUMAS2XwzxSvP88Wd9y034cH6UuAwg9Q==
X-Received: by 2002:a24:5d5:: with SMTP id 204mr12989432itl.122.1545061685939;
        Mon, 17 Dec 2018 07:48:05 -0800 (PST)
Received: from svens-asus.arcx.com ([184.94.50.30])
        by smtp.gmail.com with ESMTPSA id y23sm18824174ita.1.2018.12.17.07.48.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Dec 2018 07:48:05 -0800 (PST)
From:   Sven Van Asbroeck <thesven73@gmail.com>
X-Google-Original-From: Sven Van Asbroeck <TheSven73@googlemail.com>
To:     TheSven73@googlemail.com, Shawn Guo <shawnguo@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>,
        devicetree@vger.kernel.org
Subject: [PATCH v4 1/3] dt-bindings: bus: imx-weim: document multiple address ranges per child node
Date:   Mon, 17 Dec 2018 10:47:58 -0500
Message-Id: <20181217154800.7448-2-TheSven73@googlemail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181217154800.7448-1-TheSven73@googlemail.com>
References: <20181217154800.7448-1-TheSven73@googlemail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The imx-weim driver was patched to allow correct WEIM configuration
when multiple address ranges are used in a child node.
Update the dt-bindings to reflect this.

Reviewed-by: Rob Herring <robh@kernel.org>
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

