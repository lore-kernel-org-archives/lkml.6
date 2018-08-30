Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB614C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 19:21:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C23820839
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 19:21:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KuRxhWtV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C23820839
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727359AbeH3XZc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 19:25:32 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:37558 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726690AbeH3XZc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 19:25:32 -0400
Received: by mail-lf1-f66.google.com with SMTP id j8-v6so8099439lfb.4;
        Thu, 30 Aug 2018 12:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=hC7PyoN1h340qjr9/mIrZ1lIvPPivHR/QStPiBJOQ+Y=;
        b=KuRxhWtVQn2AkxTDiFqq2CCFZWHN/WA+y2KkoMFvFMb50RGAScjlULAoRyVVbYGKMd
         nPwwZe2gGLGdZDMYkx0qnQGvcd8p72/+RK9npYFxA0j6WPDg3mCbf8OothKaxYqyLWnI
         Da86xR1ntgO/dV0cInxq7h4MBa1ErNG53Lg/sHUwes23nsDGk0WOAZSgXWPbHPgEafXJ
         ffzDWa5alf2YAzDxlnB/CsKgPCERvZ83HUfUzRUJ53edRd1MJ2Y4wBIPo4aLwFchHIWq
         VYOMvnHzYFOsidIxlAzE89HWVsWLwfONAGJZ0Ji9px9a2CdmPfRvNWy19cZcy189XzbD
         T4Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=hC7PyoN1h340qjr9/mIrZ1lIvPPivHR/QStPiBJOQ+Y=;
        b=XpXTcYYC2xMfu96b4KoV7VwGk2552lfI7f6sXPC6K9yhIfNTudlQ9WlfrJ7Y3sDkPW
         wSjGOOD62rYM4khJS4L8wl5fnpoB211x5JmDxXUyuod0kxhlI6PWDiQ9ZXkPrT/9LL1+
         5a1tuZ5lNRMiqK7oBBPkXKFWaRf7y7jNIC0OXS3UFRcYoiSwpAlRkTGZ5cWtSEZNx/4r
         zEPgFwjROqIcJzWEKE1XMDiw1NIvriY6zhXPjf/9p7STd5u1MLvPRuFGln+zsK6/8H+i
         1zYfrVoXBgzViVbY/6zQjzJ7sFF7Z9DklZYvg93b2HJpgm3mW1w9qrgaKNyXrF00Jl5F
         LcdQ==
X-Gm-Message-State: APzg51AjK4aI6PlLVQ+W//m8bI/UWJtU/UbPye5FjQ2Fys/bHAgsHT4r
        wsp/Tr90krmwjTZpEFl+P5Q=
X-Google-Smtp-Source: ANB0VdZieCk1rPNaFYo77NHUOAl/WS64kvcE3b+2EveAaWUJeBjwWvK1PrYWSxJKrLb4bmbkcxxzmA==
X-Received: by 2002:a19:ce50:: with SMTP id e77-v6mr6138050lfg.81.1535656909375;
        Thu, 30 Aug 2018 12:21:49 -0700 (PDT)
Received: from localhost.localdomain (109-252-90-13.nat.spd-mgts.ru. [109.252.90.13])
        by smtp.gmail.com with ESMTPSA id o11-v6sm1403291lfl.1.2018.08.30.12.21.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Aug 2018 12:21:48 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/3] CPU clock changes for Tegra20/30
Date:   Thu, 30 Aug 2018 22:20:42 +0300
Message-Id: <20180830192045.11017-1-digetx@gmail.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This series is a prerequisite for the CPUFREQ driver patches, it can be
applied separately. CPUFREQ will be supported on Tegra30 once this and
the CPUFREQ patch-series will be applied.

Dmitry Osipenko (3):
  clk: tegra: Convert CCLKG mux to mux + clock divider on Tegra30
  clk: tegra: Add more rates to Tegra30 PLLX frequency table
  clk: tegra: Poll PLLX lock-status on resume from suspend on Tegra20/30

 drivers/clk/tegra/clk-super.c    |  16 +++-
 drivers/clk/tegra/clk-tegra20.c  |  51 ++++++++++--
 drivers/clk/tegra/clk-tegra210.c |   2 +-
 drivers/clk/tegra/clk-tegra30.c  | 131 +++++++++++++++++++++----------
 drivers/clk/tegra/clk.h          |   9 ++-
 5 files changed, 156 insertions(+), 53 deletions(-)

-- 
2.18.0

