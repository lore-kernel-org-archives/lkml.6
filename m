Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D0EFECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 17:02:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40231206B7
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 17:02:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lsitec-org-br.20150623.gappssmtp.com header.i=@lsitec-org-br.20150623.gappssmtp.com header.b="e8X+uUgp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40231206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lsitec.org.br
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729721AbeGQRfh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 13:35:37 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:44539 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729686AbeGQRfh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 13:35:37 -0400
Received: by mail-ed1-f65.google.com with SMTP id f23-v6so1802693edr.11
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 10:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lsitec-org-br.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=II8G7DF8YJv3MVxcD1/sjIvbzw/COx9EzfLiLBSZbRY=;
        b=e8X+uUgpj6SN/fNVBCnDzn9OqNnwNgjmSBRiLwcdMCpmjM/tpw7Sk105pDA92p477G
         5QvvyfJ8tMubRifart8Gga1htFybYn5ne9/BW9ZOo7fnphkSn271bs4eTvRdDrhg5+w0
         LzNJNIn+dsqZUh30CVX1tQVzjjk6MGmCI5V/CqAIHkNBYOOx+CNKOvfJMwDfq9LBdbNl
         xVgeTP56xxNFQYHh/1gfyZwlkeGrV7rhYv3NhGGO7pDbrdfZLp+0guVNVXWaDbLwNDtw
         xSu0fRyBhTPfFzjIQ12gBqOlR29yU8nSGJG/g8NmmklOVGMKlZfGY+xFABPcLEoDRNPB
         xN3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=II8G7DF8YJv3MVxcD1/sjIvbzw/COx9EzfLiLBSZbRY=;
        b=By9S2CcPmVIA+VMcBGTrQLBDfqWbt5oiuHDH5MLztwLVcEELzR1Q+ZsUH8e9Vz/OiJ
         tW+MLzBW2gAurpS5Cg2yU2ram6Sp96B6H6/H3Z+VZR+5AbagDKwMdgR8sfLSjxLjIoTe
         sAvodLxJk95PXFt/uF1ktIdPwfzDwrWgqXk5ST1S/4JqAjb2nWMzJbi4UbLDfMG7+yIG
         QdQ46cXTBUbIo0w/6V9/lG+NDTeeBLHXAgIcpOOkBIDUROQZsrdY5BubCTGQKyD9nMKJ
         PHoz/9nkp1Tm7okEef0Uuem/6y9dqDlJ1eW1TtHkDf+QankQqMZ+G3rdVW4mtmYbaigB
         0MOg==
X-Gm-Message-State: AOUpUlG+DSEBM2PNFFAqVoQAh0u4l+0yap2DUn0iQme36vAsaQFkKFhB
        9MPTKX14w0A52+bn4AzdnDsN/NTixo/WMQy2wZ8xAg==
X-Google-Smtp-Source: AAOMgpcS2ZJCxbf1nXaBxK6NUZvQlZET5YDeeUNQIYx8b9M0YZSWBC+W2+Gbe+IoNWYw+S8ZiqExcfKMPDTGjPjSpoA=
X-Received: by 2002:a50:9aa4:: with SMTP id p33-v6mr3464536edb.218.1531846921379;
 Tue, 17 Jul 2018 10:02:01 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:906:d1cd:0:0:0:0 with HTTP; Tue, 17 Jul 2018 10:02:00
 -0700 (PDT)
From:   Edgar Bernardi Righi <edgar.righi@lsitec.org.br>
Date:   Tue, 17 Jul 2018 14:02:00 -0300
Message-ID: <CADHB5bAztBFgWe-1v5vFfsxJgW1S3OOpV1Jkjrgk2h+pJBFw9w@mail.gmail.com>
Subject: [PATCH] clk: actions: Add custom delay option to Actions Semi OWL pll
 clock driver
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        daniel.lezcano@linaro.org, linux@armlinux.org.uk,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        =?UTF-8?Q?Guilherme_G=2E_Sim=C3=B5es?= 
        <guilherme.simoes@lsitec.org.br>,
        Jon maddog Hall <jon.maddog.hall@gmail.com>,
        mkzuffo@lsi.usp.br,
        =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        sboyd@kernel.org, mark.rutland@arm.com, linux@cubietech.com,
        support@cubietech.com, catalin.marinas@arm.com,
        mturquette@baylibre.com, will.deacon@arm.com,
        thomas liau <thomas.liau@actions-semi.com>,
        darren@cubietech.com, robh+dt@kernel.org,
        jeff.chen@actions-semi.com, pn@denx.de, mp-cs@actions-semi.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds custom delay support to Actions Semi OWL pll clock driver.
It is required for future Actions Semi Owl series S500 SoC clock support

Currently, the driver waits a fixed amount of time defined by the
macro PLL_STABILITY_WAIT_US.
The default delay (50us) is not enough for Actions Semi Owl S500 SoC.
It needs up to 150us.
A new field called "delay" was added to "struct owl_pll_hw". The rest
of the code was updated accordingly.
Old macros "OWL_PLL_HW", "OWL_PLL" and "OWL_PLL_NO_PARENT" were kept
(same usage), but updated to set "delay" value to
PLL_STABILITY_WAIT_US (50us).
New macros "OWL_PLL_HW_DELAY", "OWL_PLL_DELAY" and
"OWL_PLL_NO_PARENT_DELAY" were created with an extra argument to set a
custom "delay".
This does not break S700 and S900 code and was tested on S500 based
Lemaker Guitar Board.

Signed-off-by: Edgar Bernardi Righi <edgar.righi@lsitec.org.br>

diff -uprN -X vanilla/Documentation/dontdiff
vanilla/drivers/clk/actions/owl-pll.c
linux/drivers/clk/actions/owl-pll.c
--- vanilla/drivers/clk/actions/owl-pll.c    2018-07-17 13:07:16.667704000 -0300
+++ linux/drivers/clk/actions/owl-pll.c    2018-07-17 13:42:07.396785603 -0300
@@ -179,7 +179,7 @@ static int owl_pll_set_rate(struct clk_h

     regmap_write(common->regmap, pll_hw->reg, reg);

-    udelay(PLL_STABILITY_WAIT_US);
+    udelay(pll_hw->delay);

     return 0;
 }
diff -uprN -X vanilla/Documentation/dontdiff
vanilla/drivers/clk/actions/owl-pll.h
linux/drivers/clk/actions/owl-pll.h
--- vanilla/drivers/clk/actions/owl-pll.h    2018-07-17 13:07:16.667704000 -0300
+++ linux/drivers/clk/actions/owl-pll.h    2018-07-17 13:42:11.116765089 -0300
@@ -27,6 +27,7 @@ struct owl_pll_hw {
     u8            width;
     u8            min_mul;
     u8            max_mul;
+    u32            delay;
     const struct clk_pll_table *table;
 };

@@ -35,6 +36,51 @@ struct owl_pll {
     struct owl_clk_common    common;
 };

+#define PLL_STABILITY_WAIT_US    (50)
+
+#define OWL_PLL_HW_DELAY(_reg, _bfreq, _bit_idx, _shift,            \
+           _width, _min_mul, _max_mul, _table, _delay)            \
+    {                                \
+        .reg        = _reg,                    \
+        .bfreq        = _bfreq,                \
+        .bit_idx    = _bit_idx,                \
+        .shift        = _shift,                \
+        .width        = _width,                \
+        .min_mul    = _min_mul,                \
+        .max_mul    = _max_mul,                \
+        .table        = _table,                \
+        .delay        = _delay,                \
+    }
+
+#define OWL_PLL_DELAY(_struct, _name, _parent, _reg, _bfreq, _bit_idx,    \
+        _shift, _width, _min_mul, _max_mul, _table, _flags, _delay)    \
+    struct owl_pll _struct = {                    \
+        .pll_hw    = OWL_PLL_HW_DELAY(_reg, _bfreq, _bit_idx, _shift,    \
+                     _width, _min_mul,            \
+                     _max_mul, _table, _delay),            \
+        .common = {                        \
+            .regmap = NULL,                    \
+            .hw.init = CLK_HW_INIT(_name,            \
+                           _parent,            \
+                           &owl_pll_ops,        \
+                           _flags),            \
+        },                            \
+    }
+
+#define OWL_PLL_NO_PARENT_DELAY(_struct, _name, _reg, _bfreq, _bit_idx,    \
+        _shift, _width, _min_mul, _max_mul, _table, _flags, _delay)    \
+    struct owl_pll _struct = {                    \
+        .pll_hw    = OWL_PLL_HW_DELAY(_reg, _bfreq, _bit_idx, _shift,    \
+                     _width, _min_mul,            \
+                     _max_mul, _table, _delay),            \
+        .common = {                        \
+            .regmap = NULL,                    \
+            .hw.init = CLK_HW_INIT_NO_PARENT(_name,        \
+                           &owl_pll_ops,        \
+                           _flags),            \
+        },                            \
+    }
+
 #define OWL_PLL_HW(_reg, _bfreq, _bit_idx, _shift,            \
            _width, _min_mul, _max_mul, _table)            \
     {                                \
@@ -46,6 +92,7 @@ struct owl_pll {
         .min_mul    = _min_mul,                \
         .max_mul    = _max_mul,                \
         .table        = _table,                \
+        .delay        = PLL_STABILITY_WAIT_US,\
     }

 #define OWL_PLL(_struct, _name, _parent, _reg, _bfreq, _bit_idx,    \
@@ -78,7 +125,6 @@ struct owl_pll {
     }

 #define mul_mask(m)        ((1 << ((m)->width)) - 1)
-#define PLL_STABILITY_WAIT_US    (50)

 static inline struct owl_pll *hw_to_owl_pll(const struct clk_hw *hw)
 {
