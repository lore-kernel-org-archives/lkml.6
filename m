Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D7F9C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:32:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 215D021527
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:32:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 215D021527
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fi.rohmeurope.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726649AbeLDLcD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 06:32:03 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:34268 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726588AbeLDLcC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 06:32:02 -0500
Received: by mail-lf1-f66.google.com with SMTP id p6so11680599lfc.1;
        Tue, 04 Dec 2018 03:31:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=kjxNwEyz1R+Ns0y3pp8C4CCcoiI7PvRqDsKN5BrbHUk=;
        b=q8UCZLTKh/fxaeXQFC8zqd7MlhQTGEe1NhkQJFc451x2YDOAoANY6XcuvAghs/GHbb
         qgZmmqKWa/LAotxdTD8mAQqqVtjUsYoBZU5WsxYW7OaA7pKkZhLdWM+duDG2aAzjrwaG
         odrjTYfgxZJ6OxwmlDabLOrUS7VGVBf4VfAtM1R37SakWUDJW8PcpN3sDUn4yRT/FLCE
         5pEUYaowhv8oDvOQtvoz6i51WmMMWC9KsLCp7Iu/lkxpEfJycsMADdu/cQpI4vvdjOVy
         NyEN3O7DwmLChS4zddjnTR57OGijGsCPkWg4kPY01X1OwWEyM5rObQ3A4f+Mj5q3WM0X
         bo0A==
X-Gm-Message-State: AA+aEWYntn2lkKicHATTty22cBq5nMUa5YBzajyFwctBUXwFnnyLXii7
        DOiPs9JmZzFeO9rdMuzo5Uw=
X-Google-Smtp-Source: AFSGD/VmLf0/AhVGVPyJT0ZFp9HAzxv0/M59T0QSMyFi77qrPnq/ONJAUvK8xm+OI33Zg4Kw5KS8yg==
X-Received: by 2002:a19:e01e:: with SMTP id x30mr11007203lfg.89.1543923117153;
        Tue, 04 Dec 2018 03:31:57 -0800 (PST)
Received: from localhost.localdomain ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id c22-v6sm3105410lji.89.2018.12.04.03.31.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 04 Dec 2018 03:31:56 -0800 (PST)
Date:   Tue, 4 Dec 2018 13:31:43 +0200
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     mazziesaccount@gmail.com, matti.vaittinen@fi.rohmeurope.com
Cc:     mturquette@baylibre.com, sboyd@kernel.org, cw00.choi@samsung.com,
        krzk@kernel.org, b.zolnierkie@samsung.com, linux@armlinux.org.uk,
        andy.gross@linaro.org, david.brown@linaro.org, pavel@ucw.cz,
        andrew.smirnov@gmail.com, pombredanne@nexb.com,
        sjhuang@iluvatar.ai, akshu.agrawal@amd.com, djkurtz@chromium.org,
        rafael.j.wysocki@intel.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v6 00/10] clk: clkdev/of_clk - add managed lookup and
 provider registrations
Message-ID: <cover.1543922403.git.matti.vaittinen@fi.rohmeurope.com>
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

Patch 10 adds support for clock gate in ROHM bd71837 and bd71847 PMICs.
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
the patch version (4) combined bd718x7 driver back to this series.

Changelog (for this series) v6
- Drop 'devm_of_clk_add_parent_hw_provider'. Change
  'devm_of_clk_add_hw_provider' to look the parent device node for
  provider information if device's own node does not contain
  #clock-cells - property.
- Add kerneldoc in own patch.
- Remove NULL checks from devres match function for clkdev releasing
- Clean styling issues from clkdev.c

Changelog (for this series) v5
- Split v4 patch 1. Place clkdev stuff to patch 1 and clk provider to patch 2
- Remove devm_clk_release_clkdev from devres.txt
- Added kerneldoc for managed provider registrations.
- Cleaned styling issues.

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

Matti Vaittinen (10):
  clkdev: add managed clkdev lookup registration
  clk: Add kerneldoc to managed of-provider interfaces
  clk: of-provider: look at parent if registered device has no provider
    info
  clk: clk-max77686: Clean clkdev lookup leak and use devm
  clk: clk-st: avoid clkdev lookup leak at remove
  clk: clk-hi655x: Free of_provider at remove
  clk: rk808: use managed version of of_provider registration
  clk: clk-twl6040: Free of_provider at remove
  clk: apcs-msm8916: simplify probe cleanup by using devm
  clk: bd718x7: Initial support for ROHM bd71837/bd71847 PMIC clock

 Documentation/driver-model/devres.txt |   1 +
 drivers/clk/Kconfig                   |   7 ++
 drivers/clk/Makefile                  |   1 +
 drivers/clk/clk-bd718x7.c             | 131 ++++++++++++++++++++++++++++++++++
 drivers/clk/clk-hi655x.c              |   4 +-
 drivers/clk/clk-max77686.c            |  28 ++------
 drivers/clk/clk-rk808.c               |  15 +---
 drivers/clk/clk-twl6040.c             |   5 +-
 drivers/clk/clk.c                     |  38 +++++++++-
 drivers/clk/clkdev.c                  | 111 ++++++++++++++++++++++------
 drivers/clk/qcom/apcs-msm8916.c       |   5 +-
 drivers/clk/x86/clk-st.c              |   3 +-
 include/linux/clkdev.h                |   4 ++
 13 files changed, 284 insertions(+), 69 deletions(-)
 create mode 100644 drivers/clk/clk-bd718x7.c

-- 
2.14.3
