Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E095C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 19:46:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE1E020835
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 19:46:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IsG7MO7W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE1E020835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727497AbeH3Xuk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 19:50:40 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:42784 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727247AbeH3Xuk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 19:50:40 -0400
Received: by mail-lf1-f65.google.com with SMTP id z11-v6so8145336lff.9;
        Thu, 30 Aug 2018 12:46:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=esjqYp3n8y1d1xl2ywXbOaUiMj4WlHD2l76aattkZ9k=;
        b=IsG7MO7WR/d2TpMageIrtWtnXSU/Yls9tfmQT9miAaAzxEBwhI93n/NWFuuQpR+6ct
         sByS/EQJ1aXFxQEnBsSVHqPUUVz7TF8T6gBgALr0jy4/diTtAjertPRKTKmJTA2o0pzU
         9EJ5sxVcA+PxI4lH20bs4wv72AlOFgsRDqSPonJ0v2jzlv/Vg19+FK0GUcxLN/6rt6fC
         U97tgxvWocXEQn2Uw13wp6qytO+uLrEGKc6a55ysxAbZ9HGKNKKJ9nTxCc4m9UAOIegQ
         PvkYzeZcFD35fBhjLAWmKPdf5RVTojfYHebhXG6Ax2AIWVLZNKlr18UUK/YuRHGQ/ndm
         xZ8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=esjqYp3n8y1d1xl2ywXbOaUiMj4WlHD2l76aattkZ9k=;
        b=ByCR96TeAZYwAcLPRpDka70EYK8pQZTrADooeTcy6+RPMq00LEG7jamWDTsR5C9APn
         R35cedb0PQQ/P7PQeK44VIzp3SqkqWqaCMGq7rHvr5grd9bngfNHQGIrltuTaJRINeND
         htadg4vf3RGUwURpqGPhgs1Z5XfqXqR2Kfar94QGyCuhEoH8IcBnZE6Y5A05gAGJeMVQ
         ke/srpgqnDSXuWr8vCntXVMSQKGP7T1yYpEbdbrGcrodnM9+ij6Dm9nEO5FNMGdrKb7V
         +aRbZcacnstJd/j3gO6JYxpHM5eWjPtWcGmgilLvwCSFB/eh3kZtzXOZgrjqIDgB9HY9
         BWjQ==
X-Gm-Message-State: APzg51DqC+cAAH8WHjp0zm/3WfCD98xZO/eV2M+e6j+obcMYzHkkP42X
        6/u0AnrTqQISfr2SbDMuOiI=
X-Google-Smtp-Source: ANB0VdasdASTHu+k4lHWewxKQVElvQ5wqGTqBT+Fti2zujkv11KvEXuloeiz/pts8DtE+N1Qv5q0wg==
X-Received: by 2002:a19:aa52:: with SMTP id t79-v6mr8640617lfe.85.1535658411561;
        Thu, 30 Aug 2018 12:46:51 -0700 (PDT)
Received: from localhost.localdomain (109-252-90-13.nat.spd-mgts.ru. [109.252.90.13])
        by smtp.gmail.com with ESMTPSA id x3-v6sm1381191ljb.25.2018.08.30.12.46.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Aug 2018 12:46:50 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/5] CPUFREQ OPP's and Tegra30 support by tegra20-cpufreq driver
Date:   Thu, 30 Aug 2018 22:43:51 +0300
Message-Id: <20180830194356.14059-1-digetx@gmail.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This series adds support for CPU frequency scaling on Tegra30 and device
tree support that allows to implement thermal throttling and customize
available CPU frequencies per-board. The tegra20-cpufreq driver has been
re-worked to support that all.

Note that Tegra30 support not strictly depends on the clock patches that
are under review now, CPUFREQ driver will fail to probe until CCLKG clock
will get exposed by the clock driver. Hence this series can be applied
independently of the clock patches, CPUFREQ will start to work on Tegra30
once both patchsets will be applied.

Dmitry Osipenko (5):
  dt-bindings: cpufreq: Add binding for NVIDIA Tegra20/30
  cpufreq: tegra20: Support OPP, thermal cooling and Tegra30
  ARM: tegra: Create tegra20-cpufreq device on Tegra30
  ARM: dts: tegra20: Add CPU Operating Performance Points
  ARM: dts: tegra30: Add CPU Operating Performance Points

 .../cpufreq/nvidia,tegra20-cpufreq.txt        |  38 ++
 arch/arm/boot/dts/tegra20.dtsi                |  58 +++
 arch/arm/boot/dts/tegra30.dtsi                |  65 ++++
 arch/arm/mach-tegra/tegra.c                   |   4 +
 drivers/cpufreq/Kconfig.arm                   |   2 +
 drivers/cpufreq/cpufreq-dt-platdev.c          |   2 +
 drivers/cpufreq/tegra20-cpufreq.c             | 334 +++++++++++++-----
 7 files changed, 422 insertions(+), 81 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/cpufreq/nvidia,tegra20-cpufreq.txt

-- 
2.18.0

