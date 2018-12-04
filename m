Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C983C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 16:53:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 502D02082B
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 16:53:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="aKSGKmWM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 502D02082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727153AbeLDQxS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 11:53:18 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41752 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726367AbeLDQxR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 11:53:17 -0500
Received: by mail-wr1-f66.google.com with SMTP id x10so16711334wrs.8
        for <linux-kernel@vger.kernel.org>; Tue, 04 Dec 2018 08:53:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=R3lu1O3dzevjwf1kiOi6nnvjRZAndn2B6xOh4odokpA=;
        b=aKSGKmWM8td3reog3gZJIfKDs07EBcHOCuCLVlvinTdBPUNsU6lkv3yhZave9icP91
         YBC4na8hj2iyTj3c+9rkxteLCChZ457hZIG3r22LfghWpyT/DuacUQV+RmAGJIniwa5G
         e8T/YEPTxbEc5v0xYen/HBZZribpWxuJJgOEl0YCtTsIdlSk+091C/eZL8oUJNjhBvrW
         9nts0Ix7e3NPZKTMQGM+YMjQjrn28ngecRB1abZWpoX9Ir/askXlpRqlTWpsHoQnYOhI
         x6pcz4v6ltm2g2JpaFkygU00ny7/VR8RWWJrUzrbxsOLxIjsHiLzH9jIQm+Wyp09p/Ul
         OzwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=R3lu1O3dzevjwf1kiOi6nnvjRZAndn2B6xOh4odokpA=;
        b=fU5ipwbmq4R08LeQsIutdmZKorF54Y3qvI025d2Oec4pz+RgNSPDGXxNvQCqY1sq6O
         A/8Qi6H3zmopzrzXw59b8KFe+a2W5ebjInvh1zoogo+vBFQCHpUnhszRKxwlR/HqeuYO
         AsSbLdmokfQB60+cUn+GYn32HW58dsZiw8PfEG5tnMMEuvRDSnIIr+RFA+v4mpNRmL+w
         N1Apm9Snbn75XmbSZElf89+OaOGnY4TYnfjKDf/IaS2u8KEwsNJX+acOA/Er5PHgNlZv
         KxucEcQU1svaIHL0q8HOVpNDVipRBCB8kUqYfOFBKmF02nH2IyDorEMGah/qW8vM/iqb
         4r8g==
X-Gm-Message-State: AA+aEWa+6lX0nWhspraBx3D6qLB/5JC2YarGSipCRpSqYwCXLaDUGuFG
        R84XWm09JcaA+sM0SPtX5QolGw==
X-Google-Smtp-Source: AFSGD/WTlf/YYHhc3QbpNCj8zrSV4Lrqsmr2YgfWNABBTkDANhfVDao/uept4NdNhVCcdYo9Q5XzAQ==
X-Received: by 2002:adf:8464:: with SMTP id 91mr19884579wrf.251.1543942395942;
        Tue, 04 Dec 2018 08:53:15 -0800 (PST)
Received: from boomer.local ([2a01:e34:eeb6:4690:106b:bae3:31ed:7561])
        by smtp.googlemail.com with ESMTPSA id s66sm11581633wmf.34.2018.12.04.08.53.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 04 Dec 2018 08:53:15 -0800 (PST)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, linux-clk@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH 0/5] clk: meson: axg: add 32k clock generation
Date:   Tue,  4 Dec 2018 17:53:05 +0100
Message-Id: <20181204165310.20806-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The goal of this patchset is to add the internal generation of the
32768Hz clock within the axg AO clock controller.

This was initially added has the CEC clock on gxbb. To properly
integrate it on the axg, a simpler 'dual divider' driver is added.
Then gxbb AO clock controller is reworked to use it. Finally the 32k
clock tree is added to the AXG.

This patchset requires depends on this CCF change [0]

[0]: https://lkml.kernel.org/r/20181204163257.32085-1-jbrunet@baylibre.com

Jerome Brunet (5):
  dt-bindings: clk: meson: add ao slow clock path ids
  clk: meson: clean-up clock registration
  clk: meson: add dual divider clock driver
  clk: meson: gxbb-ao: replace cec-32k with the dual divider
  clk: meson: axg-ao: add 32k generation subtree

 drivers/clk/meson/Makefile              |   3 +-
 drivers/clk/meson/axg-aoclk.c           | 175 +++++++++++++++--
 drivers/clk/meson/axg-aoclk.h           |  13 +-
 drivers/clk/meson/clk-dualdiv.c         | 130 +++++++++++++
 drivers/clk/meson/clkc.h                |  19 ++
 drivers/clk/meson/gxbb-aoclk-32k.c      | 193 -------------------
 drivers/clk/meson/gxbb-aoclk.c          | 238 +++++++++++++++++++-----
 drivers/clk/meson/gxbb-aoclk.h          |  20 +-
 drivers/clk/meson/meson-aoclk.c         |  15 +-
 include/dt-bindings/clock/axg-aoclkc.h  |   7 +-
 include/dt-bindings/clock/gxbb-aoclkc.h |   7 +
 11 files changed, 527 insertions(+), 293 deletions(-)
 create mode 100644 drivers/clk/meson/clk-dualdiv.c
 delete mode 100644 drivers/clk/meson/gxbb-aoclk-32k.c

-- 
2.19.1

