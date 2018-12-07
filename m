Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D822C64EB1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 11:09:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E29A22083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 11:09:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E29A22083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fi.rohmeurope.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726034AbeLGLJV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 06:09:21 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:36952 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725987AbeLGLJU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 06:09:20 -0500
Received: by mail-lj1-f195.google.com with SMTP id e5-v6so3213156lja.4;
        Fri, 07 Dec 2018 03:09:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=5n7FOSEyksrh57PJHjGDlxFPGVAgAQo+DVFsEwiRMpk=;
        b=lhyyjoErkSm8rjS3OUThBXc+/cqiVblm1tQ8PfiR/wA0RA9RLKUjqFdrOr+alTixz7
         LrU7tpOhGCC/8B0tLk/7x4S6Ga0mF7voTvt7KW7BTzSSTJJPxV18tTi9wTdD5ILJRkyU
         8Dky5P8EEgfq77gcYYEKZ7qENT+5e+J+GhbCop6nErojvXfMCeJce8Ft6mKGjSo8FXkR
         AqRWCiBBuKmwn9B99YO4NEDiaXwVcmajPVcXe3KWZ9pK0wRB1L53FbnQdlFtwbh8jAYR
         ldwl2fdqh8SI+aogLpmU9UE8/JN5iTclBzCFSEyKANc1QEZB1n/lf4J8ER8P1mt/QhQd
         LZUg==
X-Gm-Message-State: AA+aEWZPB/z83ak52hnfi/91dmS0+WxTgCUb+yUcTTJcvs2YtLi3eIpc
        4NhmWVBV1BjiIQgASZR6gdY=
X-Google-Smtp-Source: AFSGD/Ufo7GqJGm42DR6pVbm7eD6mEnCYjdnJZH/Y4hw9wPEYTprrMmrEseKHgmyetwRmPz6iTCGmg==
X-Received: by 2002:a2e:974a:: with SMTP id f10-v6mr1211286ljj.61.1544180958271;
        Fri, 07 Dec 2018 03:09:18 -0800 (PST)
Received: from localhost.localdomain (84-253-205-125.bb.dnainternet.fi. [84.253.205.125])
        by smtp.gmail.com with ESMTPSA id x18-v6sm552608lji.27.2018.12.07.03.09.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 07 Dec 2018 03:09:17 -0800 (PST)
Date:   Fri, 7 Dec 2018 13:09:00 +0200
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     matti.vaittinen@fi.rohmeurope.com, mazziesaccount@gmail.com,
        corbet@lwn.net, cw00.choi@samsung.com, krzk@kernel.org,
        b.zolnierkie@samsung.com, mturquette@baylibre.com,
        sboyd@kernel.org, linux@armlinux.org.uk, pombredanne@nexb.com,
        sre@kernel.org, vkoul@kernel.org, linux@roeck-us.net, pavel@ucw.cz,
        sjhuang@iluvatar.ai, andrew.smirnov@gmail.com,
        djkurtz@chromium.org, akshu.agrawal@amd.com,
        rafael.j.wysocki@intel.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v7 0/3] clk: clkdev add managed lookup registrations
Message-ID: <cover.1544177090.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Series adds managed clkdev lookup interfaces and cleans few drivers

Few clk drivers appear to be leaking clkdev lookup registrations at
driver remove. The patch series adds devm versions of lookup
registrations and cleans up few drivers. Driver clean-up patches have
not been tested as I lack the HW. All testing and comments if
driver/device removal is even possible for changed drivers is highly
appreciated. If removal is not possible I will gladly drop the patches
from series - although leaking lookups may serve as bad example for new
developers =)

Changed drivers are:
clk-max77686 and clk-st

Please note that the patch #2 requires this change to work correctly:
https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git/commit/?h=clk-next&id=05502bf9eb7a7297f5fa6f1d17b169b3d5b53570

Changelog v7:
- rewmoved already applied of_provider patches and
  now independent bd718x7 patch from the series.
- No functional changes.

Changelog v6
- Drop 'devm_of_clk_add_parent_hw_provider'. Change
  'devm_of_clk_add_hw_provider' to look the parent device node for
  provider information if device's own node does not contain
  #clock-cells - property.
- Add kerneldoc in own patch.
- Remove NULL checks from devres match function for clkdev releasing
- Clean styling issues from clkdev.c

Changelog v5
- Split v4 patch 1. Place clkdev stuff to patch 1 and clk provider to patch 2
- Remove devm_clk_release_clkdev from devres.txt
- Added kerneldoc for managed provider registrations.
- Cleaned styling issues.

Changelog v4
- Add support for ROHM bd718x7 PMIC clock gate. Included in this patch
  series because it depends on managed interfaces added in patch 1.

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

Matti Vaittinen (3):
  clkdev: add managed clkdev lookup registration
  clk: clk-max77686: Clean clkdev lookup leak and use devm
  clk: clk-st: avoid clkdev lookup leak at remove

 Documentation/driver-model/devres.txt |   1 +
 drivers/clk/clk-max77686.c            |  28 ++-------
 drivers/clk/clkdev.c                  | 111 +++++++++++++++++++++++++++-------
 drivers/clk/x86/clk-st.c              |   3 +-
 include/linux/clkdev.h                |   4 ++
 5 files changed, 101 insertions(+), 46 deletions(-)

-- 
2.14.3
