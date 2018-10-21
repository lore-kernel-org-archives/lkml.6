Return-Path: <SRS0=f4JY=NB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04647ECDE43
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 20:58:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 958432083C
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 20:58:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rw2tQjTl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 958432083C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728265AbeJVFNo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 01:13:44 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:39813 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727256AbeJVFNn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 01:13:43 -0400
Received: by mail-lj1-f194.google.com with SMTP id p1-v6so35104947ljg.6;
        Sun, 21 Oct 2018 13:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Pv/G0di8Mwsay4RuOefTK+BnGNoln+BN6sXYOrGqT98=;
        b=Rw2tQjTl7SxbT+mz+a2GObz1Of3KasyMGvlDBDKIY3BMHdl10nqMuQ4C+pCDqsBvhy
         c+tj/lxrZKJ9lzDBKmZgUFayKf4QWe5gm760P8sebP1efRIfKZJckJBVkGFkH/yMxck2
         d7gMTtGLPB7e1YNPqgcDVilPg1Qfj5ESZfYQF6YbEf8ttmWw24XvAB+z62xVM6Jegtpo
         4qeh8mdfxgqu3tz90Agb4G/86nrQgs5MY7NkSKZkHEVepR07odiABc3j/aAJsMgu6uxB
         cAH9CMUEK1sr3Nzd/j6Yv5Ti84tA7X0oukDzwTCBb1FFshosOkg6dJUh17jlC2lTU5yt
         uWtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Pv/G0di8Mwsay4RuOefTK+BnGNoln+BN6sXYOrGqT98=;
        b=HI5dY3B2vJgWlwDBXz4v1GwSejDT7Hj49n0q/jMGmgsJ0c47dO8Edi/KXUI4pjzqr8
         wa6hiyJ8+/hL8N/qEfF24CZDVPmzMYOC3Gu8KHXhPgR7s4TZF45OeQ1L8rPGdsSFf2Wq
         N44unHlPrXPR5QhM8vYFlHicU9k0FvKwbrdmcfPYSOb0W29dCMvWj96cmt9zr+ChnHOk
         J60Iu+VNXF+KEQfTXNg1fmXdu8fcBL4d82nqqq2OhNEqWgnFNUTGZ/V9131hC+wbXret
         gkFVySlaLKl5EazDJM3WmpHMi3ftG5XEbVFGImUvSnPCMAjtEvVk5JoMHl5ToekxyVk3
         2DCw==
X-Gm-Message-State: ABuFfoiX5VjXCPho1UA9NKs/oRxA9te5pJhgFZGSJvkfqzC6Cumr2vEU
        ZVsb4yak6mt5aItnv9w/Lzo=
X-Google-Smtp-Source: ACcGV60VBia/uuR1diWfcY54qQotgVyQeafbR/nzaEUcwx2XDyPqzvRbn8t7F5jdE6pvi8LhnT80lQ==
X-Received: by 2002:a2e:9993:: with SMTP id w19-v6mr16033971lji.165.1540155483817;
        Sun, 21 Oct 2018 13:58:03 -0700 (PDT)
Received: from localhost.localdomain (109-252-91-118.nat.spd-mgts.ru. [109.252.91.118])
        by smtp.gmail.com with ESMTPSA id p63-v6sm6515919lfg.46.2018.10.21.13.58.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 21 Oct 2018 13:58:03 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>
Cc:     linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2 00/17] CPUFREQ OPP's, DVFS and Tegra30 support by tegra20-cpufreq driver
Date:   Sun, 21 Oct 2018 23:54:44 +0300
Message-Id: <20181021205501.23943-1-digetx@gmail.com>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This series adds support for CPU frequency/voltage scaling on Tegra20/30,
it adds device tree support that allow to specify clock rate/voltages per
board and to implement thermal throttling. The tegra20-cpufreq driver has
been re-worked to support that all.

Note that this series depends on in-progress clock [0] and regulator [1]
patches.

Changelog:

v2:
    - Implemented DVFS support. Currently only CPU rail changes voltage,
      while CORE/RTC locked to maximum. The CORE can be unlocked once all
      of peripheral drivers will gain support for DVFS. See "TODO" comment
      in the driver. On Tegra20 CPU temperature is lower by 5-6 C during
      idling with DVFS. On Tegra30 CPU temperature is lower by 1-2 C, and
      it drops by 6-7 C if CORE rail scaling is unlocked.

    - Device-tree binding has been reworked to support voltage regulators
      and HW versioning. Now CPU OPP's are specified per HW version and
      include voltage entry. OPP values are taken from downstream kernel
      [2][3]. The "backup" clock has been renamed to "intermediate".

[0] https://lkml.org/lkml/2018/8/30/960
[1] https://lkml.org/lkml/2018/10/5/682
[2] https://nv-tegra.nvidia.com/gitweb/?p=linux-2.6.git;a=blob;f=arch/arm/mach-tegra/tegra2_dvfs.c;hb=l4t/l4t-r16-r2
[3] https://nv-tegra.nvidia.com/gitweb/?p=linux-2.6.git;a=blob;f=arch/arm/mach-tegra/tegra3_dvfs.c;hb=l4t/l4t-r16-r2

Dmitry Osipenko (17):
  OPP: Allow to request stub voltage regulators
  soc/tegra: fuse: Export tegra_get_chip_id()
  dt-bindings: cpufreq: Add binding for NVIDIA Tegra20/30
  cpufreq: tegra20: Support OPP, thermal cooling, DVFS and Tegra30
  ARM: tegra: Create tegra20-cpufreq device on Tegra30
  ARM: dts: tegra20: Add CPU Operating Performance Points
  ARM: dts: tegra30: Add CPU Operating Performance Points
  ARM: dts: tegra20: colibri: Setup voltage regulators for DVFS
  ARM: dts: tegra20: harmony: Setup voltage regulators for DVFS
  ARM: dts: tegra20: paz00: Setup voltage regulators for DVFS
  ARM: dts: tegra20: seaboard: Setup voltage regulators for DVFS
  ARM: dts: tegra20: tamonten: Setup voltage regulators for DVFS
  ARM: dts: tegra20: ventana: Setup voltage regulators for DVFS
  ARM: dts: tegra30: apalis: Setup voltage regulators for DVFS
  ARM: dts: tegra30: beaver: Setup voltage regulators for DVFS
  ARM: dts: tegra30: cardhu: Setup voltage regulators for DVFS
  ARM: dts: tegra30: colibri: Setup voltage regulators for DVFS

 .../cpufreq/nvidia,tegra20-cpufreq.txt        |  96 ++
 arch/arm/boot/dts/tegra20-colibri.dtsi        |  31 +-
 arch/arm/boot/dts/tegra20-harmony.dts         |  31 +-
 arch/arm/boot/dts/tegra20-paz00.dts           |  31 +-
 arch/arm/boot/dts/tegra20-seaboard.dts        |  27 +-
 arch/arm/boot/dts/tegra20-tamonten.dtsi       |  31 +-
 arch/arm/boot/dts/tegra20-ventana.dts         |  31 +-
 arch/arm/boot/dts/tegra20.dtsi                | 277 ++++++
 arch/arm/boot/dts/tegra30-apalis.dtsi         |  19 +-
 arch/arm/boot/dts/tegra30-beaver.dts          |  19 +-
 arch/arm/boot/dts/tegra30-cardhu.dtsi         |  19 +-
 arch/arm/boot/dts/tegra30-colibri.dtsi        |  19 +-
 arch/arm/boot/dts/tegra30.dtsi                | 688 +++++++++++++++
 arch/arm/mach-tegra/tegra.c                   |   4 +
 drivers/cpufreq/Kconfig.arm                   |   2 +
 drivers/cpufreq/cpufreq-dt-platdev.c          |   2 +
 drivers/cpufreq/cpufreq-dt.c                  |   2 +-
 drivers/cpufreq/tegra20-cpufreq.c             | 832 +++++++++++++++---
 drivers/cpufreq/ti-cpufreq.c                  |   3 +-
 drivers/opp/core.c                            |   9 +-
 drivers/soc/tegra/fuse/tegra-apbmisc.c        |   1 +
 include/linux/pm_opp.h                        |   4 +-
 22 files changed, 2006 insertions(+), 172 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/cpufreq/nvidia,tegra20-cpufreq.txt

-- 
2.19.0

