Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 619A8C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 11:55:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F8CA223DD
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 11:55:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F8CA223DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fi.rohmeurope.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732720AbeKMVwt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 16:52:49 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:33391 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726659AbeKMVws (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 16:52:48 -0500
Received: by mail-lf1-f67.google.com with SMTP id i26so8604897lfc.0;
        Tue, 13 Nov 2018 03:54:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=bOFHv/3c0GNoHkJbBBBaRUpNSxnB5JpuxdTZIm5ceDA=;
        b=Y79gH0fi8KN9aTt3TDurnX3/lHiztX451eBRlwpQepDO+a2/H/6eUyGFBB//3Hyp8W
         6qplxuNHtoGQM2S/G36acs2btAXDV7AzuZAxIugbzw4OBfN98q+wYqjmpoL+Blmg8tVx
         9yuDd3z5AaHiivIYhRJEisKK5fjkUxrhMNcNx4M5AQJhu4HKSNSYwpL9fc1Td2aE2e73
         hoPQLFZdoScKlf1QroHHpyM8gZ/PLN/HKQ21zON5SlFvjohONAhuKDh0innvZXVv/CMe
         6wiNsWkpZ2Xo0PtK3wuP/msSaxO/021cSF9TzpaJj7R88bwjcppndAf1iSzSNECXqt55
         y3xg==
X-Gm-Message-State: AGRZ1gKUYsSdg8VPONByVwOagnvsma9k9N2LRLFfbBsj5+C4nNCtWLDW
        aRvyhAYhQ+TbopSPbtWREvI=
X-Google-Smtp-Source: AJdET5dYHSCeSosjptwTLJYJUE1VV1G3T4MwBaisndIsMJoRSWnO0igwRIYZzp0QFkMO+bEI5zJHOg==
X-Received: by 2002:a19:2b54:: with SMTP id r81mr2928543lfr.34.1542110098569;
        Tue, 13 Nov 2018 03:54:58 -0800 (PST)
Received: from localhost.localdomain ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id q8-v6sm1943292lji.69.2018.11.13.03.54.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 13 Nov 2018 03:54:57 -0800 (PST)
Date:   Tue, 13 Nov 2018 13:54:48 +0200
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     mazziesaccount@gmail.com
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Russell King <linux@armlinux.org.uk>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Huang Shijie <sjhuang@iluvatar.ai>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Daniel Kurtz <djkurtz@chromium.org>,
        Akshu Agrawal <akshu.agrawal@amd.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org
Subject: [PATCH v4 0/8] clk: clkdev: managed clk lookup and provider
 registrations
Message-ID: <cover.1542107769.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Series add bd71837/bd71837 PMIC clock support + managed interfaces

Few clk drivers appear to be leaking clkdev lookup registrations at
driver remove. The patch series adds devm versions of lookup
registrations and cleans up few drivers. Driver clean-up patches have
not been tested as I lack the HW. All testing and comments if
driver/device removal is even possible for changed drivers is highly
appreciated. If removal is not possible I will gladly drop the patches
from series - although leaking lookups may serve as bad example for new
developers =)

Patch 8 adds support for clock gate in ROHM bd71837 and bd71847 PMICs.
This change is included in the series because it depends on new managed
interfaces introduced in this series.

bd718x7 driver and devm interfaces are tested on BeagleBoneBlack and 
bd71837 break-out board. Clk area register interface of bd71847 is
identical to bd71837.

Changed drivers are:
clk-max77686, clk-st, clk-hi655x, rk808, clk-twl6040
and apcs-msm8916. New driver is clk-bd718x7

This series has been discussed for a while now. For those who want to
see whole discussion:

The bd71837 driver was originally proposed here
https://lore.kernel.org/lkml/d99c8762b0fbbcb18ec4f4d104191364c0ea798c.1528117485.git.matti.vaittinen@fi.rohmeurope.com/

clk portion was separated from that series and devm variants were
proposed here
https://lore.kernel.org/linux-clk/cover.1535630942.git.matti.vaittinen@fi.rohmeurope.com/

Cleanup to other drivers was initiated in this series while waiting for
MFD portions of bd718x7 to be applied. And now when MFD dependencies are in-tree
his version (4) combines bd718x7 driver back to this series.

Changelog (for this series) v4
- Add support for ROHM bd718x7 PMIC clock gate. Included in this patch
  series because it depends on managed interfaces added in patch 1.

Changelog (for this series) v3
Address issues spotted by Krzysztof Kozlowski
- Drop patch 3 for clk-s3c2410-dclk as this device can never be removed
- Fix indentiation for clk-max77686
- Rest  of the patches are unchanged.

Changelog (for this series) v2
Issue spotted by 0-Day test suite
- Add a stub function 'devm_of_clk_add_parent_hw_provider' for no OF config.
- patches 2-8 are unchanged.

This patch series is based on clk-next

---

Matti Vaittinen (8):
  clk: clkdev/of_clk - add managed lookup and provider registrations
  clk: clk-max77686: Clean clkdev lookup leak and use devm
  clk: clk-st: avoid clkdev lookup leak at remove
  clk: clk-hi655x: Free of_provider at remove
  clk: rk808: use managed version of of_provider registration
  clk: clk-twl6040: Free of_provider at remove
  clk: apcs-msm8916: simplify probe cleanup by using devm
  clk: bd718x7: Initial support for ROHM bd71837/bd71847 PMIC clock

 Documentation/driver-model/devres.txt |   3 +
 drivers/clk/Kconfig                   |   7 ++
 drivers/clk/Makefile                  |   1 +
 drivers/clk/clk-bd718x7.c             | 131 ++++++++++++++++++++++++++++++++++
 drivers/clk/clk-hi655x.c              |   4 +-
 drivers/clk/clk-max77686.c            |  29 ++------
 drivers/clk/clk-rk808.c               |  15 +---
 drivers/clk/clk-twl6040.c             |   5 +-
 drivers/clk/clk.c                     |  28 ++++++--
 drivers/clk/clkdev.c                  | 122 ++++++++++++++++++++++++-------
 drivers/clk/qcom/apcs-msm8916.c       |   5 +-
 drivers/clk/x86/clk-st.c              |   3 +-
 include/linux/clk-provider.h          |  11 +++
 include/linux/clkdev.h                |   4 ++
 14 files changed, 292 insertions(+), 76 deletions(-)
 create mode 100644 drivers/clk/clk-bd718x7.c

-- 
2.14.3


-- 
Matti Vaittinen
ROHM Semiconductors

~~~ "I don't think so," said Rene Descartes.  Just then, he vanished ~~~
