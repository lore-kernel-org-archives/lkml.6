Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ACCBC282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 14:53:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C25CF2082C
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 14:53:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="EO8VTU8+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729855AbfBAOxy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 09:53:54 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36267 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728650AbfBAOxx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 09:53:53 -0500
Received: by mail-wr1-f67.google.com with SMTP id u4so7410712wrp.3
        for <linux-kernel@vger.kernel.org>; Fri, 01 Feb 2019 06:53:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8eEdYNzMTYNh/Q6rC2KUrA/noaDZ+qRIqzEIbeziGHs=;
        b=EO8VTU8+S3rRiziKAMlCUFtrA6MNQaKttQlZLe3Rq0CetsF5MisgygwomPcHKIQgK4
         utC8KaJ04hxFAmSA9OAFdRJLY3+9ift7vOAKHL8Q9l+7OVCcn+tixdWJOk8xyJt7sRCh
         YYGRLj4U1llQgxJErxlpIiSiSH9xmINA/cyIoTi8tnVt/+Osyr3muEBM3uELmqgQqyEM
         hH8kePo03ZOD/pyEpBHXT7Z015QXOEl5FozEkB8x+DFsJrSCnCiBqwwxTH7ac92JCbd9
         3BcAsOofCNstV40QUS66jkwYqnHuJ9EtwRc82h/HIxTxQR7m9u+Ftuo6wscJS6q2ArwU
         q5qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8eEdYNzMTYNh/Q6rC2KUrA/noaDZ+qRIqzEIbeziGHs=;
        b=m1d/FhE2tDc899lryid0MoPiMUzLI2xKq0qkLDP8LP7iVVLrZrbnjP5H8PSfxguqxs
         /HrGpxu/RjsCU/jUBYxUVW9s7TaVKNMvSMrP1GNzKVHsdluAlyiVaNF6V1Z9siB+p6y2
         rDdfeFzrIzE1RIilGtQyj9iETIKtAokKLoMUR4vuI+eXoBUe9PGoQP5Nr3zFC27aqtka
         P8bfLBxAuxST1UGV/HVgN0zIumZTZQkQWWzY4OhnH6GNpVfMYvCghLQpEpPfoCWnjYYQ
         fYvRjqcd1WNCvnhoLGvoZpCfFjBelTU0+a2hbbqPpyREJwQGEXd5ZuyQL+Aid1ns2QA7
         0cyw==
X-Gm-Message-State: AHQUAubM8oFZyscMh+f/mHnNYoL62jccZotuSFvUEowRUB6HFcvOfl50
        2hWmuxzHyMR3PO9s8QKiazLosA==
X-Google-Smtp-Source: AHgI3IZuERyBKP8OahiXgqpaCWRLiGGMzi4ZUEP8uy6TsXIiOiRKqDK28ODJjhL51DHOVn11yh4nHg==
X-Received: by 2002:a05:6000:14c:: with SMTP id r12mr1487232wrx.172.1549032831578;
        Fri, 01 Feb 2019 06:53:51 -0800 (PST)
Received: from boomer.local ([2a01:e34:eeb6:4690:106b:bae3:31ed:7561])
        by smtp.googlemail.com with ESMTPSA id x186sm4754644wmg.41.2019.02.01.06.53.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 01 Feb 2019 06:53:50 -0800 (PST)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, Jian Hu <jian.hu@amlogic.com>
Subject: [PATCH v6 0/4] clk: meson-g12a: Add EE clock controller driver
Date:   Fri,  1 Feb 2019 15:53:41 +0100
Message-Id: <20190201145345.6795-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This purpose of this patchset is to the main clock controller of the
g12a SoC family

This patchset depends on the recent rework the meson clock directory [7].

Changes since v5 [6]:
 * use clock input driver until something better comes along in CCF
 * fix pll fractional param size
 * fix broken gp0 and hifi pll param (<55)
 * add hdmi pll
 * fix fdiv2p5
 * add mpll_50m
 * fix mpll clock tree (missing fix 2 divider)
 * add missing sdio clocks
 * add vpu clocks
 * add some RO clock gates
 * rabase on clk-meson tree

Changes since v4 [5]:
 * add bypass clock "g12a_ee_core" from DT
 * fix Kconfig description
 * change g12a_mpll0_div/g12a_mpll1_div/g12a_mpll2_div/g12a_mpll3_div
   clock's parent name as fixed_pll_dco
 * drop CLK_SET_RATE_PARENT flag for pll clock
 * drop CLK_GET_RATE_NOCACHE flag for pll_dco clock
 * delete usless note
 * enable G12A clock driver

Changes since v3 [4]:
 * add fixed clocks clk_regmap definition

Changes since v2 [2]:
 * fix fixed clock descriptions
 * fix alignment
 * add enable bit for plls base on [3] patches
 * add fixed clock gate bit

Changes since v1 [1]:
 * fix typo of 'Everything'.
 * change the word 'AmLogic' to 'Amlogic'
 * squash patch 1 and 2.
 * delete usless message of "Trying obsolete regs".
 * delete the empty line in include/dt-bindings/clock/g12a-clkc.h.
 * rebase on top of the "next/drivers" branch, and add g12a clock patch.
 * add CLK_MUX_ROUND_CLOSEST for g12a_sd_emmc_b_clk0_sel and
   g12a_sd_emmc_c_clk0_sel.

[1]: https://lkml.kernel.org/r/1531133549-25806-2-git-send-email-jian.hu@amlogic.com
[2]: https://lkml.kernel.org/r/1531728707-192230-2-git-send-email-jian.hu@amlogic.com
[3]: https://lkml.kernel.org/r/20180717095617.12240-1-jbrunet@baylibre.com
[4]: https://lkml.kernel.org/r/1533890858-113020-1-git-send-email-jian.hu@amlogic.com
[5]: https://lkml.kernel.org/r/1541511349-121152-1-git-send-email-jian.hu@amlogic.com
[6]: https://lkml.kernel.org/r/1543498917-98605-1-git-send-email-jian.hu@amlogic.com
[7]: https://lkml.kernel.org/r/20190201125841.26785-1-jbrunet@baylibre.com

Jerome Brunet (2):
  clk: meson: pll: update driver for the g12a
  clk: meson: factorise meson64 peripheral clock controller drivers

Jian Hu (2):
  dt-bindings: clk: meson: add g12a periph clock controller bindings
  clk: meson: g12a: add peripheral clock controller

 .../bindings/clock/amlogic,gxbb-clkc.txt      |    1 +
 drivers/clk/meson/Kconfig                     |   21 +-
 drivers/clk/meson/Makefile                    |    2 +
 drivers/clk/meson/axg.c                       |   59 +-
 drivers/clk/meson/clk-pll.c                   |  203 +-
 drivers/clk/meson/clk-pll.h                   |   10 +-
 drivers/clk/meson/clk-regmap.h                |    9 +-
 drivers/clk/meson/g12a.c                      | 2359 +++++++++++++++++
 drivers/clk/meson/g12a.h                      |  175 ++
 drivers/clk/meson/gxbb.c                      |  272 +-
 drivers/clk/meson/meson-eeclk.c               |   63 +
 drivers/clk/meson/meson-eeclk.h               |   25 +
 include/dt-bindings/clock/g12a-clkc.h         |  135 +
 13 files changed, 3147 insertions(+), 187 deletions(-)
 create mode 100644 drivers/clk/meson/g12a.c
 create mode 100644 drivers/clk/meson/g12a.h
 create mode 100644 drivers/clk/meson/meson-eeclk.c
 create mode 100644 drivers/clk/meson/meson-eeclk.h
 create mode 100644 include/dt-bindings/clock/g12a-clkc.h

-- 
2.20.1

