Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 22D06C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 21:55:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBAC2208D7
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 21:55:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DhbgrvMp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBAC2208D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964895AbeFNVzP (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 17:55:15 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:54571 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755513AbeFNVzH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 17:55:07 -0400
Received: by mail-wm0-f68.google.com with SMTP id o13-v6so391822wmf.4;
        Thu, 14 Jun 2018 14:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Kc8qla+tTdf6nd1HGdNbFuVptOgJFtXfSV7Ss0PQcj0=;
        b=DhbgrvMpPLhC6yypfBVQQBjpa9RA8qzIyIwTGp/s4Nkot2lbqoBKS90qFmvesHZWAH
         M4kYFM+4wpWnoJfavEZhvWVTwB/dChhBKNTsxt/S41bUegEsazykjQpQ6HzaG3VaFnJZ
         rLia//OKfiqFhPSfpkxGouIavKToSbMsqe7TLq85lHturvLKD4F2V7246agb12czwFZP
         L1QdrbQhqqo2ojVNNERGgzKhrGCNEi/cOQCg+7onptjbB9dE/Cv3ljZeyUI1FsnxJfGW
         7VOrBxeZ+TZOx0NedU1trKi3wU2O6Atz3hXE4LqJT2FCEU8SnzDbIpueSCmPJ5UabeZc
         DEGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Kc8qla+tTdf6nd1HGdNbFuVptOgJFtXfSV7Ss0PQcj0=;
        b=JT/GW1xfexDLEWUcAjvCIYopSn1I18VwqwuEfakqAR7sKZUvfb8a3A/7bR0nQhRQLg
         slZJYiwmv5SZaKx+gHJZCR9s9YH/ZQ+Atzv1kSKPrq3BzmdxMXadNiAG+ENob0Fup7/M
         md5P79Jl8MDHr9PoRxsV//f4VnhZ0H0o71GX28+Gxz+BcDE1d2rrF4MND5BXQX9RBOrC
         aIb39ieEAxSVe8oo+a2vmQJQ7gCKiVgHk9PmXXbfHS/Cmv+Wdx05IgXbsTRKlY9UDgHE
         jxZu47GVXlmNd02xZRymp23X8+vQdxOdB1+bvtRXsXozA+jhL8xJF45SWU+eWvc4ZVd8
         ScdA==
X-Gm-Message-State: APt69E0jR2OzjhO7eUPWnMpLksLEchUa0oK/CAtY8oCb6zL6n8KyYNSP
        VUa/QGpAOvmAypjgWte8PnE=
X-Google-Smtp-Source: ADUXVKI+0F/N/IPwiNj0NoIC0LNqIG/uk1pg97uvFt4g4hO9g1KClN/cMy5ns1AWIhfBQdI9kj1CVg==
X-Received: by 2002:a1c:3bc4:: with SMTP id i187-v6mr3340901wma.57.1529013305181;
        Thu, 14 Jun 2018 14:55:05 -0700 (PDT)
Received: from gcc67.tetaneutral.net (gcc67.tetaneutral.net. [2a03:7220:8080:c00::1])
        by smtp.gmail.com with ESMTPSA id i76-v6sm285367wmd.20.2018.06.14.14.55.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Jun 2018 14:55:03 -0700 (PDT)
From:   ilia.lin@gmail.com
To:     ilia.lin@gmail.com
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Will Deacon <will.deacon@arm.com>,
        Ilia Lin <ilialin@codeaurora.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v13 0/8] Clock for CPU scaling support for msm8996
Date:   Thu, 14 Jun 2018 23:53:47 +0200
Message-Id: <20180614215358.11264-1-ilia.lin@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ilia Lin <ilia.lin@gmail.com>

[v13]
 * Rebased

[v12]
 * Addressed the kbuild fail on arm architecture

[v11]
 * Split the series into domains

[v9]
 * Addressed comments from Viresh and Russel about the error handling

[v8]
 * Reordered the patch series into 4 groups
 * Addressed comments from Amit about the comments and commit messages
 * Addressed comments from Amit and Viresh about the resourses deallocation

[v7]
 * Addressed comments from Viresh about resourses deallocation and DT compatible

[v6]
 * Addressed comments from Viresh about:
  ** Comments style
  ** Kconfig bool instead of tristate
  ** DT and documentation style
  ** Resourses deallocation on an error
  ** Typos

[v5]
 * Rebased
 * Addressed comments from Bjorn about SPDX style, functions and parameters naming
 * Addressed comments from Viresh DT properties and style, comments style, resourses deallocation, documentation placement
 * Addressed comments from Sricharan about unnessesary include
 * Addressed comments from Nicolas
 * Addressed comments from Rob about the commit messages and acks
 * Addressed comments from Mark

[v4]
 * Adressed all comments from Stephen
 * Added CPU regulator support
 * Added qcom-cpufreq-kryo driver

[v3]
 * Rebased on top of the latest PLL driver changes
 * Addressed comment from Rob Herring for bindings

[v2]
 * Addressed comments from Rob Herring for bindings
 * Addressed comments from Mark Rutland for memory barrier
 * Addressed comments from Julien Thierry for clock reenabling condition
 * Tuned the HW configuration for clock frequencies below 600MHz

SOC (1/15):
Extracts the kryo l2 accessors driver from the QCOM PMU driver

Clocks (2/15-9/15):
This series adds support for the CPU clocks on msm8996 devices.
The driver uses the existing PLL drivers and is required to control
the CPU frequency scaling on the MSM8996.

Ilia Lin (5):
soc: qcom: Separate kryo l2 accessors from PMU driver
clk: Use devm_ in the register fixed factor clock
clk: qcom: Add CPU clock driver for msm8996
dt-bindings: clk: qcom: Add bindings for CPU clock for msm8996
clk: qcom: Add ACD path to CPU clock driver for msm8996

Rajendra Nayak (3):
clk: qcom: Make clk_alpha_pll_configure available to modules
clk: qcom: cpu-8996: Add support to switch to alternate PLL
clk: qcom: cpu-8996: Add support to switch below 600Mhz

.../devicetree/bindings/clock/qcom,kryocc.txt      |  17 +
drivers/clk/clk-fixed-factor.c                     |   2 +-
drivers/clk/qcom/Kconfig                           |  10 +
drivers/clk/qcom/Makefile                          |   1 +
drivers/clk/qcom/clk-alpha-pll.c                   |   1 +
drivers/clk/qcom/clk-alpha-pll.h                   |   6 +
drivers/clk/qcom/clk-cpu-8996.c                    | 510 +++++++++++++++++++++
drivers/perf/Kconfig                               |   1 +
drivers/perf/qcom_l2_pmu.c                         |  90 +---
drivers/soc/qcom/Kconfig                           |   3 +
drivers/soc/qcom/Makefile                          |   1 +
drivers/soc/qcom/kryo-l2-accessors.c               |  56 +++
include/soc/qcom/kryo-l2-accessors.h               |  12 +
13 files changed, 643 insertions(+), 67 deletions(-)
create mode 100644 Documentation/devicetree/bindings/clock/qcom,kryocc.txt
create mode 100644 drivers/clk/qcom/clk-cpu-8996.c
create mode 100644 drivers/soc/qcom/kryo-l2-accessors.c
create mode 100644 include/soc/qcom/kryo-l2-accessors.h

-- 
2.11.0

