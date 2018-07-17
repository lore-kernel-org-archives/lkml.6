Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EB40ECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 09:56:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBD4E20C0E
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 09:56:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="bnVFtQv4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBD4E20C0E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730180AbeGQK2K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 06:28:10 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41259 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729652AbeGQK2J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 06:28:09 -0400
Received: by mail-wr1-f68.google.com with SMTP id j5-v6so597214wrr.8
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 02:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=WOY/lEJiGJKSZxDYh+TqY5NCpNHto9BQ1ytET61YrzI=;
        b=bnVFtQv4axdyVCtMn9WUImMlnmVQWZIW8JnGOMoGXxmBvuholpE3lP3Tq8IZGkFkr2
         3Vqcy2Yj8qexgcwcFN1J+j8t9s7MRnpBSPdAs2Mm5UCSxr2ghu8ArvFQRX8BGS3tlyat
         5MbM4xv/Y+2ijyW9gssXbkbYktCFD+0qFJ6+2vDro7sQynBiQ2TPEFQ4JWv/58yrJiNB
         P0p1zJK0WRHSyukixye4aa45LZqRmQqd90uDDyENPTOV2F38HLW2neH2KEPwurYNlU8E
         SXYzoeKjMVejk0kbx0UVHlILDL03TlZCCxN4n1e0dT0DztdpShBbzA+uZIba7NqjGGjc
         SBAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=WOY/lEJiGJKSZxDYh+TqY5NCpNHto9BQ1ytET61YrzI=;
        b=l+c0hJte+cxSu+IozvGYUm3oGhxyXWQAEoTDxcToEFFi8glQ8oVHj4aKVW9+56LkYZ
         bgoJNbqi0UpHgLvt9x7G3BDvECqRl13t85ZGkQHje/ApLqN7NwVNMwQKlwcZxjbmgH3t
         n/cI6RSvRowSyJ6XqTIb84Q7im0z+iFrjcqO1N4b3+6l42qIA9vxLDozYiO6D8ndVhed
         U368SxF+COzbn+C3+7JvzdhaiebqsJ9yj+KRLETlvJR9a/uwASqWosDoZHVtODsOtwkE
         IIw2vvQ08QCp4FnAOFGoStARGbrU36yrZYrmLUFvEC7oS4iHwEVebDuIEJgrq2xVnhXC
         EOKw==
X-Gm-Message-State: AOUpUlEmMMhvV4NVqNWqaUFJRyzwBhkvhjlduJwf6g9bT2a4mm5wnzQC
        3TYhHHAir+EUe/SZEQ0C9tpApQ==
X-Google-Smtp-Source: AAOMgpfxWk3LXO1+PKvOV99p8bhh6J8LfcX2GbMyqSpn+I0gmOh4HUcHNUcNIjH2OQoCrN1MMhL74g==
X-Received: by 2002:adf:8103:: with SMTP id 3-v6mr806017wrm.213.1531821380979;
        Tue, 17 Jul 2018 02:56:20 -0700 (PDT)
Received: from boomer.baylibre.local ([90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id b10-v6sm1199249wrp.49.2018.07.17.02.56.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 17 Jul 2018 02:56:20 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 0/3] clk: meson: clk-pll driver update
Date:   Tue, 17 Jul 2018 11:56:14 +0200
Message-Id: <20180717095617.12240-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.14.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset is yet another round of update to the amlogic pll driver.

 1) Enable bit is added so we don't rely on the bootloader or the init
    value to enable to pll device.
 2) OD post dividers are removed from the pll driver. This simplify the
    driver and let us provide the clocks which exist between those
    dividera. Some device are actually using these clocks.
 3) The rates hard coded in parameter tables are remove. Instead, we
    only rely on the parent rate and the parameters to calculate the
    output rate, which is a lot better.

This series has been tested on the gxl libretech cc and axg s400.
I did not test it on meson8b yet.

Jerome Brunet (3):
  clk: meson: clk-pll: add enable bit
  clk: meson: clk-pll: remove od parameters
  clk: meson: clk-pll: drop hard-coded rates from pll tables

 drivers/clk/meson/axg.c     | 320 ++++++++++++++++------------
 drivers/clk/meson/axg.h     |   8 +-
 drivers/clk/meson/clk-pll.c | 156 +++++++++-----
 drivers/clk/meson/clkc.h    |  16 +-
 drivers/clk/meson/gxbb.c    | 504 ++++++++++++++++++++++----------------------
 drivers/clk/meson/gxbb.h    |  10 +-
 drivers/clk/meson/meson8b.c | 167 ++++++++-------
 drivers/clk/meson/meson8b.h |   5 +-
 8 files changed, 648 insertions(+), 538 deletions(-)

-- 
2.14.4

