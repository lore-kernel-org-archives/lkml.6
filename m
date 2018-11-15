Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC1DDC04EBF
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 22:41:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90FF22084C
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 22:41:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="U22yi4f2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90FF22084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729045AbeKPIvC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 03:51:02 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33697 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725860AbeKPIvC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 03:51:02 -0500
Received: by mail-wr1-f66.google.com with SMTP id u9-v6so22903859wrr.0;
        Thu, 15 Nov 2018 14:41:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NLD4R/YTd5NWWNTehYtqzH5Sq5bxq2erjxwvS1xEomw=;
        b=U22yi4f2wIug/BioQ6kbNV9DzJTtnymid7OR/PdGJeYZfbnPtDcAjK2QhYPPzOPlNs
         1hEignwcLuvg2kPY50/MSq3yowoL3vGCIGXy69/9XRnYRUcBI67IXoyQLbhwwOc7lwNT
         6t+SjizLIrbwlcN8ResSrZ4nqzWCRdkShHDC+iuJOzRBnP70qC3I8hgNs5Uf+uxnCF1N
         1MxdaAtOjJ0ymy5Nrc+BODHttmrKZRE1V6lGULAmwC8LIn0ZfLweOkwDszkXyVY9ruLv
         1RtlPCD0ebJ57CiM0FJqNJAzqFPwaVUXx9s92DO4iObRf3XWNTvEVW6lYZKdKnKbRvNP
         ypGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NLD4R/YTd5NWWNTehYtqzH5Sq5bxq2erjxwvS1xEomw=;
        b=M9dzBJq+pFtyb5ZWMhIa+cuHAicFN8oW9a7QTIWb1RWXFkSyvjNS+vSPqx/9N439bO
         s9gtFEg3bbUYR3+OKHIJSejMi4WQxDZwRh/XWtKnsUGBNpPbPeeoaKJRXl/Xm2jE5GTW
         DDw9DLeLVUuaC8RvGevgRgaNsGTCzROXTExvXAQ6e6XC8Z8GlFJlGi/f7zobIHfDLfCu
         YY/aTkc04/h6FtL9k2qu5ZCgXdo9bgxRya1bHdLiBk7bIZ82SQP5z0gPceuHpyMjQaK2
         saWwjiUzpbHoQ/v2BFXzfG41GNM79gJpXTvo6qghqlR3JGfeYsYIjyO/gL2WNRQAPQZR
         CQ1w==
X-Gm-Message-State: AGRZ1gLlOCYQsXjIiuxi6B9g1+Rxt9JWWHiUsPFGhO59vSxkOa+kGdNw
        h8YPekM68FBDaSuKCYJnXOU=
X-Google-Smtp-Source: AJdET5dn1s4TNWp9jGt+hYCrFPzvZi+gLem1uvxYrP5ayF7rXlCNsbhhCIvxHu+5duhouh+F05O9nA==
X-Received: by 2002:a5d:418b:: with SMTP id m11mr7136326wrp.8.1542321675486;
        Thu, 15 Nov 2018 14:41:15 -0800 (PST)
Received: from blackbox.darklights.net (p200300DCD717A100B85ACE585A885C51.dip0.t-ipconnect.de. [2003:dc:d717:a100:b85a:ce58:5a88:5c51])
        by smtp.googlemail.com with ESMTPSA id x12sm2076388wmc.37.2018.11.15.14.41.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Nov 2018 14:41:14 -0800 (PST)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        jbrunet@baylibre.com, narmstrong@baylibre.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v2 0/6] Meson8b: make the CPU clock mutable
Date:   Thu, 15 Nov 2018 23:40:42 +0100
Message-Id: <20181115224048.13511-1-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This allows changing the CPU clock on the 32-bit Amlogic Meson SoCs
(Meson8, Meson8b and Meson8m2).
CPU frequency scaling will be enabled with a separate series by adding
the CPU clock and the OPP tables to meson8.dtsi and meson8b.dtsi.

While changing the CPU frequency (sys_pll or any of it's post-dividers)
we need to run the CPU clock off the XTAL clock. Otherwise the system
will lock up because we need to disable the sys_pll to change it's
rate.

This also makes the clk-pll's .enable hook a no-op if the clock is
already enabled. Otherwise we're getting lockups when calling the
first clk_{prepare_}enable on the sys_pll or any of it's children (as
the CCF propagates the enable event up to the sys_pll). This is because
the .enable hook unconditionally disables and enables the clock.
However, we can't disable that clock (not even temporarily) if the CPU
is running off sys_pll.

Additionally this adds support for more M/N combinations in sys_pll to
achieve all of the OPPs on Meson8b and all OPPs <= 1608 MHz on Meson8
and Meson8m2.

Compared to Amlogic's 3.10 kernel there's one notable difference: we
are actually allowing changes to the sys_pll. Amlogic's kernel sets
sys_pll to a fixed rate during boot and then uses a timer generate a
"virtual clock rate" by toggling between various dividers (for example:
sys_pll is set to 1536MHz. to achieve 1008MHz they are toggling every
2500us between 1536MHZ and 768MHz so the average over <period, for
example one second> is 1008MHz).
I could reproduce any situation where changing sys_pll failed (for
example due to high temperature). To prove that I ran "stress --cpu 4"
for multiple hours and then cycled through all available CPU
frequencies (while keeping "stress" running in the background). This
worked fine on my Meson8b Odroid-C1 and EC-100 boards as well as my
Meson8m2 board.


Dependencies:
This series is built on top of the latest clk-meson.git tree and the
patches from my other series [1] "Meson8b: fixes for the cpu_scale_div
clock".


Changes since v1 at [0]:
- re-ordered patches as suggested by Jerome: keep all fixes first, then
  the new "features"
- squashed patches "clk-pll: check if the clock is already enabled" and
  "clk-pll: add the is_enabled function in the clk_ops". This also
  allows calling clk_hw_is_enabled() from meson_clk_pll_enable()
  instead of calling meson_clk_pll_is_enabled() directly (this matches
  the implementation of sclk-div.c)
- documented the dependencies of this series in the cover-letter
- dropped "RFC" prefix
- collected Jerome's Acked-/Reviewed-by's (thanks for the quick
  response!)


[0] https://patchwork.kernel.org/cover/10683317/
[1] https://patchwork.kernel.org/cover/10617617/


Martin Blumenstingl (6):
  clk: meson: clk-pll: check if the clock is already enabled
  clk: meson: meson8b: do not use cpu_div3 for cpu_scale_out_sel
  clk: meson: meson8b: mark the CPU clock as CLK_IS_CRITICAL
  clk: meson: meson8b: add support for more M/N values in sys_pll
  clk: meson: meson8b: run from the XTAL when changing the CPU frequency
  clk: meson: meson8b: allow changing the CPU clock tree

 drivers/clk/meson/clk-pll.c | 19 ++++++++
 drivers/clk/meson/meson8b.c | 94 +++++++++++++++++++++++++++++++++----
 2 files changed, 104 insertions(+), 9 deletions(-)

-- 
2.19.1

