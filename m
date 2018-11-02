Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1582C65C22
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 12:34:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF8742082E
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 12:34:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF8742082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fi.rohmeurope.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727525AbeKBVlp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 17:41:45 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:34189 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726008AbeKBVlp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 17:41:45 -0400
Received: by mail-lf1-f66.google.com with SMTP id n26-v6so1238393lfl.1;
        Fri, 02 Nov 2018 05:34:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=ynh9STkpWY6Mq3ED/crgVidCuu+blQH1TC7rguiYoAw=;
        b=B1cSmOzPTYGtwCd/3Mnc4qdRy+J7teIWSDVeQD1qsa8WHmhmHlCfEnrwBgg75VWope
         xUre6pYZ++IvNg5G1U+nhAUjDdyTaIc5eGhInQF8iqfetYybE780qhX3kXCBroKqm56d
         xqc3YtWC9kzo6G0ENuUjKl8in7TmnJwm0nU1VY03WJp4Zlg0twkZvQhQl2j+o6KXRo8e
         5EMF/AtuPQCskfeD72+cdl+YfFmjBR0aNWKyxzNQ5r+kld7yZVqUm6nHo68j7K9f5ucu
         aDCMU5fJ7F7BwIEKohwhHBh9/EYx6RYBx2OEBHScsLJMkTBpDMr95I7fFTbGTq7PN8Ls
         Xvsg==
X-Gm-Message-State: AGRZ1gJNSQBMZ4RVIXwpQQWxI335riMQyideC2xvf7XHSnsOL2Drt2Ea
        u6slU3MsuMSArbr1knRzfFM=
X-Google-Smtp-Source: AJdET5f9eDJeDHvBGgPTNqx5dPEm1OHTqF6IqxDGufbMtYIkmC2Cx5TIIn4eWgy61qnow99/n33R1g==
X-Received: by 2002:a19:ae03:: with SMTP id f3mr958335lfc.86.1541162080611;
        Fri, 02 Nov 2018 05:34:40 -0700 (PDT)
Received: from localhost.localdomain ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id q5-v6sm5306022ljh.60.2018.11.02.05.34.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 02 Nov 2018 05:34:39 -0700 (PDT)
Date:   Fri, 2 Nov 2018 14:34:26 +0200
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
Subject: [PATCH v3 0/7] clk: clkdev: managed clk lookup and provider
 registrations
Message-ID: <cover.1541161503.git.matti.vaittinen@fi.rohmeurope.com>
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
clk-max77686, clk-st, clk-hi655x, rk808, clk-twl6040
and apcs-msm8916.

New devm registration variants have been tested on BeagleBoneBlack
using ROHM BD71837 PMIC driver.

Same devm variants were earlier proposed together with BD71837/BD71847
PMIC clk driver in this series:
https://lore.kernel.org/linux-clk/cover.1535630942.git.matti.vaittinen@fi.rohmeurope.com/

The BD71837/BD71847 work is currently pending for related MFD commits to
get merged in clk-tree and the devm functions are now submitted in this
series.

Changelog v3
Address issues spotted by Krzysztof Kozlowski
- Drop patch 3 for clk-s3c2410-dclk as this device can never be removed
- Fix indentiation for clk-max77686
- Rest  of the patches are unchanged.

Changelog v2
Issue spotted by 0-Day test suite
- Add a stub function 'devm_of_clk_add_parent_hw_provider' for no OF config.
- patches 2-8 are unchanged.

This patch series is based on clk-next

---

Matti Vaittinen (7):
  clk: clkdev/of_clk - add managed lookup and provider registrations
  clk: clk-max77686: Clean clkdev lookup leak and use devm
  clk: clk-st: avoid clkdev lookup leak at remove
  clk: clk-hi655x: Free of_provider at remove
  clk: rk808: use managed version of of_provider registration
  clk: clk-twl6040: Free of_provider at remove
  clk: apcs-msm8916: simplify probe cleanup by using devm

 Documentation/driver-model/devres.txt |   3 +
 drivers/clk/clk-hi655x.c              |   4 +-
 drivers/clk/clk-max77686.c            |  29 ++------
 drivers/clk/clk-rk808.c               |  15 +----
 drivers/clk/clk-twl6040.c             |   5 +-
 drivers/clk/clk.c                     |  28 ++++++--
 drivers/clk/clkdev.c                  | 122 ++++++++++++++++++++++++++--------
 drivers/clk/qcom/apcs-msm8916.c       |   5 +-
 drivers/clk/x86/clk-st.c              |   3 +-
 include/linux/clk-provider.h          |  11 +++
 include/linux/clkdev.h                |   4 ++
 11 files changed, 153 insertions(+), 76 deletions(-)

-- 
2.14.3


-- 
Matti Vaittinen
ROHM Semiconductors

~~~ "I don't think so," said Rene Descartes.  Just then, he vanished ~~~
