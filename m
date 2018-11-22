Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F091DC04EBB
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 21:40:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1A7E20659
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 21:40:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="c+0FW+Us"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1A7E20659
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404942AbeKWIVl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 03:21:41 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40048 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392303AbeKWIVk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 03:21:40 -0500
Received: by mail-wm1-f67.google.com with SMTP id q26so10283420wmf.5;
        Thu, 22 Nov 2018 13:40:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lEf8ew0Ss4HaxFBLQGgMBaQ8orjd3JGzoZQYwrnpOho=;
        b=c+0FW+UsFQsYAXLL+CBALS5Zo99mFTdv/eaOWmTVmpZ/pybf+1wawSeZSY9tkNwe1y
         Q01BoMR9EoM/oVOlQKrdLnvRdCz/k0YiQlxY3eN/jXeKMLQZrI20FM0e0B35o+Ib0xgm
         OKh2yV0oC88h3+YPPZ8Hp4pIjPH1nKtdHrFluDOd90Txgqm1/TXY/bAlgqm3WtKS7L5x
         EJDAPeBDUSumtXKBLRLRFkAdYoT8da3RxK1ZBxIis23EL3HCQ7z2vI0FRMcJMgCoNSC/
         D5BtVV9/m1F8v7490+B2SkMytpFlySd7/5aEMGYBbs41RKdT4bEvUhDtRqRsrwCLm8Rt
         hHwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lEf8ew0Ss4HaxFBLQGgMBaQ8orjd3JGzoZQYwrnpOho=;
        b=TxFPF4LQAywO/TTvuMnW3oaay5vd5yooGuHciIvYsQlQevFJt+abDDJzauNfU4xEXJ
         G974k6JIXFNrQyQGbiNEAIvpRw2yAFvGw51mNvKEZFJfGugynvOfsYetizxOYjTyoVwg
         baDJG6+xb0KdgbbtpHljTm4nFG7EDajnOHiTUD6Q/bBfacKZUwZ43xC9Fd5Ig4GOvx46
         JqN557V2/S5QLbxx5Rd3ZiPdH6WjO8HVQ1iS82UXARM9F3vsvzLn/esODtD9ONqLpDgu
         f4lCAthfA3w7CbHgvUcvVaKplakB5DxgwH/7ZJyb7EO8hhNczVOJ19wH6gRTmnoLHEF8
         +oUg==
X-Gm-Message-State: AA+aEWbpARnvbBToByJy0bonoDW6QgD9Pfelx59v4RZNvlhDCn+GIklY
        MUybiDPXSwZ2poz9ZIjDJZU=
X-Google-Smtp-Source: AFSGD/VfvVHFl0/Y2tUX0BQO4pqUG7sfex/TALv9EU7wYgCJsc7WmP5OsDuSMae1TqDcHMtUp2KgjA==
X-Received: by 2002:a1c:bb42:: with SMTP id l63mr9652709wmf.47.1542922824760;
        Thu, 22 Nov 2018 13:40:24 -0800 (PST)
Received: from blackbox.darklights.net (p200300DCD732F5007DE18DA1F72FF8D9.dip0.t-ipconnect.de. [2003:dc:d732:f500:7de1:8da1:f72f:f8d9])
        by smtp.googlemail.com with ESMTPSA id x14sm29755554wrm.65.2018.11.22.13.40.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Nov 2018 13:40:24 -0800 (PST)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org, narmstrong@baylibre.com,
        jbrunet@baylibre.com
Cc:     mturquette@baylibre.com, sboyd@kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v2 0/4] Meson8b: add the CPU clock post-dividers
Date:   Thu, 22 Nov 2018 22:40:13 +0100
Message-Id: <20181122214017.25643-1-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the successor to my previous series "meson8b: add the CPU_DIV16
clock for the ARM TWD" from [0]. I decided to not send this as v2 of
the original series because the PERIPH clock is not the CPU_DIV16 clock.
It's not clear whether a CPU_DIV16 clock exists.

With this series we get all the CPU_CLK post-dividers as listed in the
public S805 datasheet [1] on pages 31 and 32:
- ABP
- PERIPH (used as input for the ARM global timer and ARM TWD timer)
- AXI
- L2 DRAM

Each of these clocks has a register called "..._CLK_DIS" which is
documented as a "just in case" bit:
"Set to 1 to manually disable the [...] clock when changing the mux
selection. Typically this bit is set to 0 since the clock muxes can
switch without glitches."
Since we're not supposed to touch that register we're using the new
read-only gate clk_ops to ensure that nothing accidentally modifies
these bits.

The result of this is that we can use the PERIPH clock which clocks
the ARM TWD timer. I will send a separate series to add the TWD timer.


changes since v1 at [2]:
- added new patch 2 "clk: meson: clk-regmap: add read-only gate ops"
- switched from CLK_IS_CRITICAL to the new clk_regmap_gate_ro_ops
  so we're consistent with all other read-only clocks
- collected Jerome's Acked-by tags (thanks!)


[0] http://lists.infradead.org/pipermail/linux-amlogic/2018-July/007890.html
[1] https://dn.odroid.com/S805/Datasheet/S805_Datasheet%20V0.8%2020150126.pdf
[2] https://patchwork.kernel.org/cover/10687023/


Martin Blumenstingl (4):
  dt-bindings: clock: meson8b: export the CPU post dividers
  clk: meson: clk-regmap: add read-only gate ops
  clk: meson: meson8b: rename cpu_div2/cpu_div3 to
    cpu_in_div2/cpu_in_div3
  clk: meson: meson8b: add the CPU clock post divider clocks

 drivers/clk/meson/clk-regmap.c           |   5 +
 drivers/clk/meson/clk-regmap.h           |   1 +
 drivers/clk/meson/meson8b.c              | 264 ++++++++++++++++++++++-
 drivers/clk/meson/meson8b.h              |  17 +-
 include/dt-bindings/clock/meson8b-clkc.h |   4 +
 5 files changed, 278 insertions(+), 13 deletions(-)

-- 
2.19.1

