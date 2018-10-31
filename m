Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F47BECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 08:30:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E7A920880
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 08:30:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E7A920880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fi.rohmeurope.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727597AbeJaR1M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 13:27:12 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:35602 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727420AbeJaR1L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 13:27:11 -0400
Received: by mail-lj1-f193.google.com with SMTP id x85-v6so9788096ljb.2;
        Wed, 31 Oct 2018 01:30:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=J86aAgGejyXGR4d0DwCOqCZU/jYNSzK0ZBDTevgbO7k=;
        b=VMZiopSUdaq+f8d41IlFJ2IOCz/TKuC0/Po1IM2B+ljY2BInC+aN54yRhO9qEt8Kmu
         kwge4Bgra4mfD2iCxpLGxTrCUiYeaPV/D1srvSlSDKYFFeoGivIL+5/mW79+LjfEe/vp
         Q13YDqj7JnDaOMNRLaUAOoUvMR8mykvvxZnJLpt4sGOCta0wFvINVpV3apLKfjKaU5eB
         5zhXKkOgERWU7Vvi3jek26tUHwFmm7gb/RcyWLWBpjeDRnzwIwZbxrtdhW7/3uANXhpr
         60ZAysNeVWr1vj2HFBRgDh/tEJmsYFPD4Kux8NqYaLcyJjCNGB622Qbi5tfSUpl5Ab5R
         5l9w==
X-Gm-Message-State: AGRZ1gISJqH+0QVG1Z7kfUCZM2QXBIDUlIO4eCxzOjbUKDok+3eKqFQw
        otW66a6E98h7aZ9cp43F5l4=
X-Google-Smtp-Source: AJdET5e7vg1bM5i6SW182p0qKsty5NsWsnVeXqu530iDwvT8ODVLEG2wr3fQlgi/31k/Lw0tasWFVQ==
X-Received: by 2002:a2e:5b93:: with SMTP id m19-v6mr1147367lje.115.1540974602567;
        Wed, 31 Oct 2018 01:30:02 -0700 (PDT)
Received: from localhost.localdomain ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id t73-v6sm3630712lje.23.2018.10.31.01.30.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 31 Oct 2018 01:30:01 -0700 (PDT)
Date:   Wed, 31 Oct 2018 10:29:53 +0200
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
Subject: [PATCH 0/8] clk: clkdev: managed clk lookup and provider
 registrations
Message-ID: <cover.1540970653.git.matti.vaittinen@fi.rohmeurope.com>
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
registrations and cleans up few drivers. There is no intended functional
changes besides adding clean-ups at remove or simplifying the clean-up
code by using devm. So this patch series is not fixing any potential
issues on binding the cleanups to parent device - this series only
changes the cleanup to be done using devm.

Driver clean-up patches have not been tested as I lack the HW. All testing
and comments if driver/device removal is even possible for changed drivers
is highly appreciated. If removal is not possible I will gladly drop the
relevant patches from series - although leaking lookups may serve as bad
example for new developers =)

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
 include/linux/clk-provider.h           |   4 ++
 include/linux/clkdev.h                 |   4 ++
 12 files changed, 151 insertions(+), 82 deletions(-)

-- 
2.14.3


-- 
Matti Vaittinen
ROHM Semiconductors
~~~ "I don't think so," said Rene Descartes.  Just then, he vanished ~~~
