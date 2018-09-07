Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97E49C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 19:42:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3523E20844
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 19:42:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="TQIXWelO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3523E20844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727701AbeIHAZP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 20:25:15 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35988 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726534AbeIHAYt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 20:24:49 -0400
Received: by mail-wr1-f65.google.com with SMTP id e1-v6so6961460wrt.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Sep 2018 12:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JFYpgkjurOn5tmIBQ+dDUH58mJKnAsBPAOfrxOzN6iY=;
        b=TQIXWelODRVSiPQ1z6vXHfC1udi5JDzdCckJgRlI7LysNR3HiNBdKFDI0WyQNkPk26
         jMRm3qL1h6R7MhB6YgU/kPgvCv7loiAQd8MwbNgNRiRv5ovtL7tkNgHvEOqlVEsGLn0p
         GNB0J+8wTRb4rKKqytrUJ9CiEarvo9oZaPYMLx/vGEGYdLiLbRuQXE9ESGZq+LcLelwX
         mUcPWfZDIik78yFR6lt7lR49Pg0wRUMEIQZQXBlj7KF0niSxl80Ykf1zePPtKZU8Nm9J
         ohSOrRpGMeaNGRZmlHhB9tSo0RWzrcDbkN4TLhX7KUjt5qHpnlWKJedbCsERMiW5b5TB
         ec3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=JFYpgkjurOn5tmIBQ+dDUH58mJKnAsBPAOfrxOzN6iY=;
        b=rFJvNusmIarxtTkwslCdM+4as5qpARTTAXTVttVQEi9XNCUcunjPBXd/U8hNnShZWJ
         DR8ALxk/C0hy3x5rfUQInkMLjXS9S7FGfsB+wlRZAjJRVMbEEd19IUNC2+gQq/v/SpZr
         pKfXQVScQvdCCKkHQ9yfb7ZNDfecKTjvMsh62GqDWG8KdV94Z3U0KfpuEUb5theLd1Wh
         0Fxo4Q4ej8mDBjx6JVpo9acUjBLW7NFE1HhZOkEYWLZKFyfpe4GrTN9+9KFYagaZcPwG
         ouAqggqI+Z9f8I6SAmKINGUSq80jftNs5YvG9o3DgdZVzSSsU+1YPiYVr0Aa/tYfdOMo
         hj4w==
X-Gm-Message-State: APzg51A+mPRg7uIA5mIjR88ssWR4mhEIznLJM/aRX6yMEicCOXCnn0zX
        jeq/41KUoLVI1+Hp90kCYLUZEw==
X-Google-Smtp-Source: ANB0VdaeT/7k4vrW+qU+pcUKpK095ooyQEUGRADWbnIIV9Cd2YDUgabaggGShYpQ6DKteAdP2vS4uA==
X-Received: by 2002:a5d:6a0e:: with SMTP id m14-v6mr7474939wru.192.1536349342718;
        Fri, 07 Sep 2018 12:42:22 -0700 (PDT)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id y17-v6sm11700133wrh.49.2018.09.07.12.42.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 07 Sep 2018 12:42:21 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     Gilles.Muller@lip6.fr, Julia.Lawall@lip6.fr, agust@denx.de,
        alexandre.torgue@st.com, alistair@popple.id.au,
        benh@kernel.crashing.org, carlo@caione.org, davem@davemloft.net,
        galak@kernel.crashing.org, joabreu@synopsys.com,
        khilman@baylibre.com, maxime.ripard@bootlin.com,
        michal.lkml@markovi.net, mpe@ellerman.id.au,
        mporter@kernel.crashing.org, nicolas.palix@imag.fr,
        oss@buserror.net, paulus@samba.org, peppe.cavallaro@st.com,
        tj@kernel.org, vitb@kernel.crashing.org, wens@csie.org
Cc:     cocci@systeme.lip6.fr, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        netdev@vger.kernel.org, linux-sunxi@googlegroups.com,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH RFC 3/5] coccinelle: add xxxsetbitsXX converting spatch
Date:   Fri,  7 Sep 2018 19:41:45 +0000
Message-Id: <1536349307-20714-4-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1536349307-20714-1-git-send-email-clabbe@baylibre.com>
References: <1536349307-20714-1-git-send-email-clabbe@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch add a spatch which convert all open coded of setbits32/clrbits32/clrsetbits32
and their 64 bits counterparts.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 scripts/coccinelle/misc/setbits.cocci | 423 ++++++++++++++++++++++++++++++++++
 1 file changed, 423 insertions(+)
 create mode 100644 scripts/coccinelle/misc/setbits.cocci

diff --git a/scripts/coccinelle/misc/setbits.cocci b/scripts/coccinelle/misc/setbits.cocci
new file mode 100644
index 000000000000..c01ab6d75eb4
--- /dev/null
+++ b/scripts/coccinelle/misc/setbits.cocci
@@ -0,0 +1,423 @@
+virtual context
+
+@pclrsetbits32a@
+identifier rr;
+expression reg;
+expression set;
+expression clear;
+@@
+
+  u32 rr;
+  ...
+- rr = readl(reg);
+- rr &= ~clear;
+- rr |= set;
+- writel(rr, reg);
++ clrsetbits32(reg, clear, set);
+
+@pclrsetbits32b@
+identifier rr;
+expression reg;
+expression set;
+expression clear;
+@@
+
+  u32 rr;
+  ...
+- rr = readl(reg);
+- rr |= set;
+- rr &= ~clear;
+- writel(rr, reg);
++ clrsetbits32(reg, clear, set);
+
+@pclrbits32@
+identifier rr;
+expression reg;
+expression clear;
+@@
+
+  u32 rr;
+  ...
+- rr = readl(reg);
+- rr &= ~clear;
+- writel(rr, reg);
++ clrbits32(reg, clear);
+
+@psetbits32@
+identifier rr;
+expression reg;
+expression set;
+@@
+
+  u32 rr;
+  ...
+- rr = readl(reg);
+- rr |= set;
+- writel(rr, reg);
++ setbits32(reg, set);
+
+@psetbits32b@
+identifier rr;
+expression reg;
+expression set1;
+expression set2;
+@@
+
+  u32 rr;
+  ...
+- rr = readl(reg);
+- rr |= set1;
+- rr |= set2;
+- writel(rr, reg);
++ setbits32(reg, set1 | set2);
+
+@pclrsetbits64a@
+identifier rr;
+expression reg;
+expression set;
+expression clear;
+@@
+
+  u64 rr;
+  ...
+- rr = readq(reg);
+- rr &= ~clear;
+- rr |= set;
+- writeq(rr, reg);
++ clrsetbits64(reg, clear, set);
+
+@pclrsetbits64b@
+identifier rr;
+expression reg;
+expression set;
+expression clear;
+@@
+
+  u64 rr;
+  ...
+- rr = readq(reg);
+- rr |= set;
+- rr &= ~clear;
+- writeq(rr, reg);
++ clrsetbits64(reg, clear, set);
+
+@pclrbits64@
+identifier rr;
+expression reg;
+expression clear;
+@@
+
+  u64 rr;
+  ...
+- rr = readq(reg);
+- rr &= ~clear;
+- writeq(rr, reg);
++ clrbits64(reg, clear);
+
+@psetbits64@
+identifier rr;
+expression reg;
+expression set;
+@@
+
+  u64 rr;
+  ...
+- rr = readq(reg);
+- rr |= set;
+- writeq(rr, reg);
++ setbits64(reg, set);
+
+@@
+expression dwmac;
+expression reg;
+expression mask;
+expression value;
+@@
+
+- meson8b_dwmac_mask_bits(dwmac, reg, mask, value);
++ clrsetbits32(dwmac->regs + reg, mask, value);
+
+@ppclrsetbits32a@
+identifier rr;
+expression reg;
+expression set;
+expression clear;
+@@
+
+- u32 rr = readl(reg);
+- rr &= ~clear;
+- rr |= set;
+- writel(rr, reg);
++ clrsetbits32(reg, clear, set);
+
+@ppclrsetbits32b@
+identifier rr;
+expression reg;
+expression set;
+expression clear;
+@@
+
+- u32 rr = readl(reg);
+- rr |= set;
+- rr &= ~clear;
+- writel(rr, reg);
++ clrsetbits32(reg, clear, set);
+
+@ppclrbits32@
+identifier rr;
+expression reg;
+expression clear;
+@@
+
+- u32 rr = readl(reg);
+- rr &= ~clear;
+- writel(rr, reg);
++ clrbits32(reg, clear);
+
+@ppsetbits32@
+identifier rr;
+expression reg;
+expression set;
+@@
+
+- u32 rr = readl(reg);
+- rr |= set;
+- writel(rr, reg);
++ setbits32(reg, set);
+
+@ppclrsetbits64a@
+identifier rr;
+expression reg;
+expression set;
+expression clear;
+@@
+
+- u64 rr = readq(reg);
+- rr &= ~clear;
+- rr |= set;
+- writeq(rr, reg);
++ clrsetbits64(reg, clear, set);
+
+@ppclrsetbits64b@
+identifier rr;
+expression reg;
+expression set;
+expression clear;
+@@
+
+- u64 rr = readq(reg);
+- rr |= set;
+- rr &= ~clear;
+- writeq(rr, reg);
++ clrsetbits64(reg, clear, set);
+
+@ppclrbits64@
+identifier rr;
+expression reg;
+expression clear;
+@@
+
+- u64 rr = readq(reg);
+- rr &= ~clear;
+- writeq(rr, reg);
++ clrbits64(reg, clear);
+
+@ppsetbits64@
+identifier rr;
+expression reg;
+expression set;
+@@
+
+- u64 rr = readq(reg);
+- rr |= set;
+- writeq(rr, reg);
++ setbits64(reg, set);
+
+@pif_set_clr@
+identifier rr;
+expression reg;
+expression set;
+expression clear;
+@@
+
+  u32 rr;
+  ...
+- rr = readl(reg);
+  if (...)
+- rr |= set;
++ setbits32(reg, set);
+  else
+- rr &= ~clear;
++ clrbits32(reg, clear);
+- writel(rr, reg);
+
+@pifclrset@
+identifier rr;
+expression reg;
+expression set;
+expression clear;
+@@
+
+  u32 rr;
+  ...
+- rr = readl(reg);
+  if (...)
+- rr &= ~clear;
++ clrbits32(reg, clear);
+  else
+- rr |= set;
++ setbits32(reg, set);
+- writel(rr, reg);
+
+@pif_set_clr64@
+identifier rr;
+expression reg;
+expression set;
+expression clear;
+@@
+
+  u64 rr;
+  ...
+- rr = readq(reg);
+  if (...)
+- rr |= set;
++ setbits64(reg, set);
+  else
+- rr &= ~clear;
++ clrbits64(reg, clear);
+- writeq(rr, reg);
+
+@pif_clr_set64@
+identifier rr;
+expression reg;
+expression set;
+expression clear;
+@@
+
+  u64 rr;
+  ...
+- rr = readq(reg);
+  if (...)
+- rr &= ~clear;
++ clrbits64(reg, clear);
+  else
+- rr |= set;
++ setbits32(reg, set);
+- writeq(rr, reg);
+
+
+@p_setbits32_m2@
+identifier rr;
+expression reg;
+expression set;
+@@
+
+  u32 rr;
+  ...
+- rr = readl(reg);
+- writel(rr | set, reg);
++ setbits32(reg, set);
+
+@p_clrbits32_m2@
+identifier rr;
+expression reg;
+expression mask;
+@@
+
+  u32 rr;
+  ...
+- rr = readl(reg);
+- writel(rr & ~mask, reg);
++ clrbits32(reg, mask);
+
+
+@p_setbits_oneliner@
+expression addr;
+expression set;
+@@
+- writel(readl(addr) | set, addr);
++ setbits32(addr, set);
+
+@p_clrbits_oneliner@
+expression addr;
+expression mask;
+@@
+- writel(readl(addr) & ~mask, addr);
++ clrbits32(addr, mask);
+
+@p_clrsetbits_oneliner_a@
+expression addr;
+expression set;
+expression mask;
+@@
+- writel(readl(addr) | set & ~mask, addr);
++ clrsetbits32(addr, mask, set);
+
+@p_clrsetbits_oneliner_b@
+expression addr;
+expression set;
+expression mask;
+@@
+- writel(readl(addr) & ~mask | set, addr);
++ clrsetbits32(addr, mask, set);
+
+@p_clrsetbits_oneliner_a2@
+expression addr;
+expression set;
+expression mask;
+@@
+- writel((readl(addr) | set) & ~mask, addr);
++ clrsetbits32(addr, mask, set);
+
+@p_clrsetbits_oneliner_b2@
+expression addr;
+expression set;
+expression mask;
+@@
+- writel((readl(addr) & ~mask) | set, addr);
++ clrsetbits32(addr, mask, set);
+
+
+
+
+
+
+
+
+
+
+
+// sub optimal way to add header
+@header1 depends on psetbits32 || pclrbits32 || pclrsetbits32a || pclrsetbits32b || psetbits64 || pclrbits64 || pclrsetbits64a || pclrsetbits64b || ppsetbits32 || ppclrbits32 || ppclrsetbits32a || ppclrsetbits32b || ppsetbits64 || ppclrbits64 || ppclrsetbits64a || ppclrsetbits64b@
+@@
+  #include <linux/io.h>
++ #include <linux/setbits.h>
+
+@header2 depends on (psetbits32 || pclrbits32 || pclrsetbits32a || pclrsetbits32b || psetbits64 || pclrbits64 || pclrsetbits64a || pclrsetbits64b || ppsetbits32 || ppclrbits32 || ppclrsetbits32a || ppclrsetbits32b || ppsetbits64 || ppclrbits64 || ppclrsetbits64a || ppclrsetbits64b) && !header1@
+@@
+  #include <linux/interrupt.h>
++ #include <linux/setbits.h>
+
+@header3 depends on (psetbits32 || pclrbits32 || pclrsetbits32a || pclrsetbits32b || psetbits64 || pclrbits64 || pclrsetbits64a || pclrsetbits64b || ppsetbits32 || ppclrbits32 || ppclrsetbits32a || ppclrsetbits32b || ppsetbits64 || ppclrbits64 || ppclrsetbits64a || ppclrsetbits64b) && !header2@
+@@
+  #include <linux/of.h>
++ #include <linux/setbits.h>
+
+@@
+expression base;
+expression offset;
+expression value;
+@@
+
+- mtu3_setbits(base, offset, value);
++ setbits32(base + offset, value);
+
+@@
+expression base;
+expression offset;
+expression mask;
+@@
+
+- mtu3_clrbits(base, offset, mask);
++ clrbits32(base + offset, mask);
+
-- 
2.16.4

