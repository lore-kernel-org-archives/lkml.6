Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28844C282D7
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 09:22:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED03020863
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 09:21:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k52QZAOH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727224AbfBKJV6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 04:21:58 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38062 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727067AbfBKJVx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 04:21:53 -0500
Received: by mail-wm1-f68.google.com with SMTP id v26so15695631wmh.3;
        Mon, 11 Feb 2019 01:21:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KFyf8oJ/P80QFng2XmVNIgk4v2NDqyqmu8lE59dkrPM=;
        b=k52QZAOHo7AbT5OyQPKCHfV3CiKawusbTn4/wKaOfZJrXI3Ta77pz5eH+uuEFgkORE
         X7ksDFubriatb9JMEif6Id9Ru3m8M1EIlg6QZete8g/VM05dWeFOSK94AwpBBukwDQtS
         LWQLa1ja/9mZF+Xwg/Zxt3vJbnuIMS3fKgnuNsuGTZqYtc9oDZN2R7Fj2Kzc05hPfWTe
         L/cs4p0gMH5asDos/5j76egCzuhDBT5dZASqybnEHGlqfAwKEZT2OIBvETVDNxU5wwDI
         Tm71jdw9/lynt52h5NwWBtuIu/YxmgiViJYIKH9Aq+qkFYpp3wGiQ7whpSMjc8Ps41VU
         2j7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=KFyf8oJ/P80QFng2XmVNIgk4v2NDqyqmu8lE59dkrPM=;
        b=HzQx479eo2Aeg1Ylni4ez0N0ceu8GOLkMrTSi218FCDcpnBZKRqS4ERjIum3boYLf/
         0BW7FgOXegKOu+/+j+sOIWask+viRWJSF0WMvb9nTzL2hTr53rEf8zWE0uJgq+ZOEaAz
         RGch1GVAfDE8mpTkYLbvv8IoifG92K5siRG1ZOsIc493H5WLs4tGVwYNzbAf5MUqZ2JK
         tw4+TQ0Bx1Zim8JrnkmkC2oZMObDLWolDda4cTJfIrhrPmDaJaXn0C0v8u7CCwwBNh/P
         MkGJV8d1KhsToEDFiFLwzPPp4VWIEOW6GWpJLVrucziuOq07nXs6dCoSxKHjgGp3Ib0S
         Q/fw==
X-Gm-Message-State: AHQUAuY963Sx24PO03zquy9bYlCGQcBeCt/o5/+BFX0ei45Qr0kWtWja
        yrftjxUKl/0ibR1+43DIzN7aOuIep2Q=
X-Google-Smtp-Source: AHgI3IYrFXglD95oZuKDOSWkev6zVqyCzSWSTFLDga+C4+miAZoaSPPco6eV4UrLhAi8JUApIHEOjw==
X-Received: by 2002:a7b:c1d7:: with SMTP id a23mr8032175wmj.48.1549876911576;
        Mon, 11 Feb 2019 01:21:51 -0800 (PST)
Received: from ThinkPad.gtu.edu.tr ([193.140.134.118])
        by smtp.gmail.com with ESMTPSA id o7sm11388979wmc.44.2019.02.11.01.21.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 11 Feb 2019 01:21:51 -0800 (PST)
From:   Mesih Kilinc <mesihkilinc@gmail.com>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-sunxi@googlegroups.com
Cc:     Mesih Kilinc <mesihkilinc@gmail.com>,
        Maxime Ripard <maxime.ripard@free-electrons.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Icenowy Zheng <icenowy@aosc.io>,
        Rob Herring <robh+dt@kernel.org>
Subject: [PATCH 4/7] dt-bindings: spi: Add Support for Allwinner F1C100s
Date:   Mon, 11 Feb 2019 12:21:10 +0300
Message-Id: <8d62291fa2f98d07e08d81fe4f54e4c49744c24e.1549875778.git.mesihkilinc@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1549875778.git.mesihkilinc@gmail.com>
References: <cover.1549875778.git.mesihkilinc@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allwinner suniv F1C100s has similar SPI controllers as sun8i H3.
Add compatible string for it.

Signed-off-by: Mesih Kilinc <mesihkilinc@gmail.com>
---
 Documentation/devicetree/bindings/spi/spi-sun6i.txt | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/spi/spi-sun6i.txt b/Documentation/devicetree/bindings/spi/spi-sun6i.txt
index 435a8e0..33f490f 100644
--- a/Documentation/devicetree/bindings/spi/spi-sun6i.txt
+++ b/Documentation/devicetree/bindings/spi/spi-sun6i.txt
@@ -1,7 +1,10 @@
 Allwinner A31/H3 SPI controller
 
 Required properties:
-- compatible: Should be "allwinner,sun6i-a31-spi" or "allwinner,sun8i-h3-spi".
+- compatible: should be:
+	- "allwinner,sun6i-a31-spi"
+	- "allwinner,sun8i-h3-spi"
+	- "allwinner,suniv-f1c100s-spi", "allwinner,sun8i-h3-spi"
 - reg: Should contain register location and length.
 - interrupts: Should contain interrupt.
 - clocks: phandle to the clocks feeding the SPI controller. Two are
-- 
2.7.4

