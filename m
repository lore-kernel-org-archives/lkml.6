Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A330C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 16:55:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D12E121A74
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 16:55:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="wXQigp1J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D12E121A74
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752965AbeGDQzL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 12:55:11 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:52159 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752237AbeGDQzH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 12:55:07 -0400
Received: by mail-wm0-f67.google.com with SMTP id s12-v6so6980404wmc.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jul 2018 09:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=FesjHPANBPbdH3s1jXgldghWjOMBeHx2glA5oPm0Hks=;
        b=wXQigp1JEZK8qb6HwpR+KrSy0a7COpzt1RxbWBiTLhqAC3rRERtEYw/uULM8Yk+XEV
         xe6MTyhnmqAkcsrfgCqkxKmqT9rpZeIlCeJOkWkB44+RFacWDVSTXZVZJtcHWRPuCocu
         ZXNLd+yuxlujupqrQ0vBoeEIKmSahwOzfl9C+QnnCWbcZNKGsXWVMEouqYcTACqPc5v+
         hw9sgeHDVhTElPGoYfatp6pdvaIpceCZfrhyk6mPVZ8BhyulwuFgcDbeiYYE6KKHzfbP
         OShmjt5nqqGsIbeO3jsJzHsEe8aBR63g0C4yAvAS6moTHnjE8SPNhTAqRCMBvkRjZS14
         us3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=FesjHPANBPbdH3s1jXgldghWjOMBeHx2glA5oPm0Hks=;
        b=U2tDm1+Dw87hBiIHnuHnXCSVmqIjN50UD9jDQc+W3d1mYUN2DU2nIoe2S3DB9D1zk7
         IVMrJ9soYyYzWqXfN2qWZMcuMuuHCXJ6aulvVF0ui2Soyc5Kudn7IG7IiK5yAYTDpXyQ
         vm8rW9LHk8BH47242JtS2QPT+OQNN3z9aKyuWVopiTk8+qCosfjivfp7axG5td9CkmPJ
         kANQ+ZmovbHQss98X9E4fmZzNaZJ9cjrNOe+odCTHLVTJ8FNiah27DnW4Ppo9jmnJNFA
         9EwVJQA0ZFTqT10sAcgXrwReT8HQi8lnkZuxf8LcmGNSWlTsHH/ghOa0dF+D0tz0hyAo
         tYqw==
X-Gm-Message-State: APt69E1pmMXHsPO5/tFGks1kFOhYU13FdLsbZlXeOXwKL1U2lbxdHtPO
        p1FgbKFiq2YQ6k+NllF6Dk/DYA==
X-Google-Smtp-Source: AAOMgpfuVcKtXToUnsyiTRCHtSwaq3HtPEhYmEdWVhxlHCPGeg0ngjo6SiK1yKyFsfaUbPGdiQjOhA==
X-Received: by 2002:a1c:7eca:: with SMTP id z193-v6mr2079617wmc.139.1530723306276;
        Wed, 04 Jul 2018 09:55:06 -0700 (PDT)
Received: from boomer.baylibre.local ([90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id d102-v6sm7927618wma.10.2018.07.04.09.55.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 04 Jul 2018 09:55:05 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] clk: meson: add gen_clk
Date:   Wed,  4 Jul 2018 18:54:55 +0200
Message-Id: <20180704165458.24149-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.14.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds GEN_CLK, which a very useful clock for debugging.
It allows to output most of the SoC plls through one of the SoC pad.

In the future, we could even use clk_measure with it to access the
vast majority of the SoC clocks.

Jerome Brunet (3):
  clk: meson: gxbb: remove HHI_GEN_CLK_CTNL duplicate definition
  clk: meson: expose GEN_CLK clkid
  clk: meson: add gen_clk

 drivers/clk/meson/axg.c               | 64 ++++++++++++++++++++++++++++++++-
 drivers/clk/meson/axg.h               |  4 ++-
 drivers/clk/meson/gxbb.c              | 66 +++++++++++++++++++++++++++++++++++
 drivers/clk/meson/gxbb.h              |  5 +--
 include/dt-bindings/clock/axg-clkc.h  |  1 +
 include/dt-bindings/clock/gxbb-clkc.h |  1 +
 6 files changed, 137 insertions(+), 4 deletions(-)

-- 
2.14.4

