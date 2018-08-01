Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D754CC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 14:01:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4392B208A5
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 14:01:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="LSA67vth"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4392B208A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389458AbeHAPqz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 11:46:55 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33206 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389266AbeHAPqy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 11:46:54 -0400
Received: by mail-wm0-f67.google.com with SMTP id r24-v6so13907161wmh.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 Aug 2018 07:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=1lsCfr0edyBjI8ht68vB7dmpAPcMhqkE0gHFLeTnO2E=;
        b=LSA67vthX4SeWVm24dRTmxzTEz53TRcNXpbyG47LPXkaKUY15oIOOJ2GVnLubza6gL
         /2Uf92ONKZu3rkXtZ1IX+9T7dEkfk4pBX6na4kbCKT6Q75EdRMfvXLhbT2LG7g3UXfSs
         p/w3/IeMF1Z5M+pBidD21Hd3EdOANzNq0b+/e2+pWm82EZwmSGn4jNkgpQiNo6zDnzgP
         85skuGyuMGTn1JeYIUGHDTaNkYbOBldkrciKEkXQxXy18aX5G84U3NZc5IKZVmpHYijk
         4rSpS6DHqM25FZDJ2/olw9Q1raEQ6m46MVzkwqL838lI6zf1FBTVSeytKpgEBursH3hM
         DkMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=1lsCfr0edyBjI8ht68vB7dmpAPcMhqkE0gHFLeTnO2E=;
        b=CebdbJyBtPhqOrQb6eiWUTSGvlxACI7Z50rTTD5CZSrjSluppGH0oXNDJNMMWDXQeK
         SRRzaQW/7YEpjppFSAZTFJU3M1R6A2wt+4B/vlOft5b0iCOoYuJLdhC/MuH49TaD4WFH
         hfuIgzGqAGlaQ+M3a7BHhZhdS12NRJrl+jkPWECCoe3J+ykPyJ3akQ7cp2Tp9pCiFjdb
         dc59raqctU1NRiMwvzQqShuhcilG0mQFeQE47CSxJzrnaMv4+DWYrt9x9B3o3RNCI+vd
         9QGkB9mgbXKnboNVIr7EU53Jl+YaCBhFLMuz6X9Gm8mjKFjEpSVM+0lCnFyvOsVo4Q8U
         GFaA==
X-Gm-Message-State: AOUpUlEQiPn+Jzh5zgZgWp1GJXrzT1JXInWJe8SlHJKUyiC+/4KcE3G9
        ThkhzgETvBa8ryysPwAIh1wG4w==
X-Google-Smtp-Source: AAOMgpfatLscTp2H244cvbtMfasiY6ZPJxOlUPS4U4ye8OFt5uat+GV0VoRf74vFfIzaYsEsgSqnxA==
X-Received: by 2002:a1c:2d54:: with SMTP id t81-v6mr3063782wmt.31.1533132059560;
        Wed, 01 Aug 2018 07:00:59 -0700 (PDT)
Received: from boomer.baylibre.local ([90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id d42-v6sm2816309wma.0.2018.08.01.07.00.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 01 Aug 2018 07:00:58 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v2 0/4] clk: meson: clk-pll driver update
Date:   Wed,  1 Aug 2018 16:00:49 +0200
Message-Id: <20180801140053.25899-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset is yet another round of update to the amlogic pll driver.

 1) Enable bit is added so we don't rely on the bootloader or the init
    value to enable to pll device.
 2) Remove unnecessary CLK_GET_RATE_NOCACHE flags.
 3) OD post dividers are removed from the pll driver. This simplify the
    driver and let us provide the clocks which exist between those
    dividers. Some device are actually using these clocks.
 4) The rates hard coded in parameter tables are remove. Instead, we
    only rely on the parent rate and the parameters to calculate the
    output rate, which is a lot better.

This series has been tested on the gxl libretech cc and axg s400.
I did not test it on meson8b yet.

Changes since v1: [0]
 - improve commit description of patch 1
 - remove unnecessary CLK_GET_RATE_NOCACHE flags.
 - add missing CLK_SET_RATE_PARENT.

[0]: https://lkml.kernel.org/r/20180717095617.12240-1-jbrunet@baylibre.com

Jerome Brunet (4):
  clk: meson: clk-pll: add enable bit
  clk: meson: clk-pll: drop CLK_GET_RATE_NOCACHE where unnecessary
  clk: meson: clk-pll: remove od parameters
  clk: meson: clk-pll: drop hard-coded rates from pll tables

 drivers/clk/meson/axg.c     | 326 +++++++++++++----------
 drivers/clk/meson/axg.h     |   8 +-
 drivers/clk/meson/clk-pll.c | 156 +++++++----
 drivers/clk/meson/clkc.h    |  16 +-
 drivers/clk/meson/gxbb.c    | 518 ++++++++++++++++++------------------
 drivers/clk/meson/gxbb.h    |  10 +-
 drivers/clk/meson/meson8b.c | 173 ++++++------
 drivers/clk/meson/meson8b.h |   5 +-
 8 files changed, 665 insertions(+), 547 deletions(-)

-- 
2.17.1

