Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90390C6786F
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 07:17:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FE852064C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 07:17:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FE852064C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fi.rohmeurope.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728131AbeKAQT2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 12:19:28 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:41848 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727816AbeKAQT1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 12:19:27 -0400
Received: by mail-lf1-f65.google.com with SMTP id c16so13496697lfj.8;
        Thu, 01 Nov 2018 00:17:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=tuTJsoBlJAz/Od17VS3XqtNOnWZ0QDYhBOZPEMrB3cY=;
        b=qin6mLpp088d43uT1C38l6yCqG8PCSJvFpS76lEckDvYRPfPkhrz5bVHiGRtDjOsB6
         7n/hdQG+X6fLtBG73hm9KQKGnWHHZAo94y+xABQMAxOZeBsb3SfaeAGAwGeEq7VPyLcd
         FuAlwWcrLNpwZThvDVLxOAv1QDIPwUpjaqQ75QsuI98+8L3AG1E79wNfmj9zm86MTo4K
         wnc3ysHIUQclWicvTPx03Yxlz43BIOtWVTqfYtNHEqj3dOZlKN8776/I7+QnIN5JxrOL
         FKUbkfeHHtiOjNWNyb6dfD+Bzl7q3sPyWr8BXnLJBZVITQIEbyleX5wxUOl6EopqYeaK
         eUEA==
X-Gm-Message-State: AGRZ1gLCMRtB/PRZwiBuaSda4GGFAsedG+8FpUcx+c7b9q/5WT4QdR8v
        DsMNjQsvYQsUnkfLNIsKrrU=
X-Google-Smtp-Source: AJdET5c1a+hcUyKREw4h1DqWorReK39x9I3q7Lw7IWZWDL7EUEHCNtKaeAgyNeIKgrM7GoZmj75ivg==
X-Received: by 2002:a19:fc09:: with SMTP id a9mr3921623lfi.21.1541056658953;
        Thu, 01 Nov 2018 00:17:38 -0700 (PDT)
Received: from localhost.localdomain ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id d17-v6sm4596754lfg.97.2018.11.01.00.17.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 01 Nov 2018 00:17:38 -0700 (PDT)
Date:   Thu, 1 Nov 2018 09:17:25 +0200
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     Jonathan Corbet <corbet@lwn.net>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Russell King <linux@armlinux.org.uk>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Kukjin Kim <kgene@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        Sebastian Reichel <sre@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh@kernel.org>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Huang Shijie <sjhuang@iluvatar.ai>,
        Akshu Agrawal <Akshu.Agrawal@amd.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Daniel Kurtz <djkurtz@chromium.org>, mazziesaccount@gmail.com
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        matti.vaittinen@fi.rohmeurope.com
Subject: [PATCH v2 0/8] clk: clkdev: managed clk lookup and provider
 registrations
Message-ID: <cover.1541054985.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch series adding managed clkdev and of_provider registrations

Few clk drivers appear to be leaking clkdev lookup registrations at
driver remove. The patch series adds devm versions of lookup
registrations and cleans up few drivers. Driver clean-up patches have
not been tested as I lack the HW. All testing and comments if
driver/device removal is even possible for changed drivers is highly
appreciated. If removal is not possible I will gladly drop the patches
from series - although leaking lookups may serve as bad example for new
developers =)

Changed drivers are:
clk-max77686, clk-s3c2410-dclk, clk-st, clk-hi655x, rk808, clk-twl6040
and apcs-msm8916.

New devm registration variants have been tested on BeagleBoneBlack
using ROHM BD71837 PMIC driver.

Same devm variants were earlier proposed together with BD71837/BD71847
PMIC clk driver in this series:
https://lore.kernel.org/linux-clk/cover.1535630942.git.matti.vaittinen@fi.rohmeurope.com/

The BD71837/BD71847 work is currently pending for related MFD commits to
get merged in clk-tree and the devm functions are now submitted in this
series.

Changelog v2
Issue spotted by 0-Day test suite
- Add a stub function 'devm_of_clk_add_parent_hw_provider' for no OF config.
- patches 2-8 are unchanged.

This patch series is based on clk-next

---

Matti Vaittinen (8):
  clk: clkdev/of_clk - add managed lookup and provider registrations
  clk: clk-max77686: Clean clkdev lookup leak and use devm
  clk: clk-s3c2410-dclk: clean up clkdev lookup leak
  clk: clk-st: avoid clkdev lookup leak at remove
  clk: clk-hi655x: Free of_provider at remove
  clk: rk808: use managed version of of_provider registration
  clk: clk-twl6040: Free of_provider at remove
  clk: apcs-msm8916: simplify probe cleanup by using devm

 Documentation/driver-model/devres.txt  |   3 +
 drivers/clk/clk-hi655x.c               |   4 +-
 drivers/clk/clk-max77686.c             |  25 ++-----
 drivers/clk/clk-rk808.c                |  15 +---
 drivers/clk/clk-twl6040.c              |   5 +-
 drivers/clk/clk.c                      |  28 ++++++--
 drivers/clk/clkdev.c                   | 122 ++++++++++++++++++++++++++-------
 drivers/clk/qcom/apcs-msm8916.c        |   5 +-
 drivers/clk/samsung/clk-s3c2410-dclk.c |  15 ++--
 drivers/clk/x86/clk-st.c               |   3 +-
 include/linux/clk-provider.h           |  11 +++
 include/linux/clkdev.h                 |   4 ++
 12 files changed, 158 insertions(+), 82 deletions(-)

-- 
2.14.3


-- 
Matti Vaittinen
ROHM Semiconductors

~~~ "I don't think so," said Rene Descartes.  Just then, he vanished ~~~
