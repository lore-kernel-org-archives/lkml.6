Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934678AbeEWT1i (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 15:27:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:38866 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934513AbeEWT1e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 15:27:34 -0400
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org
Subject: [GIT PULL] pinctrl: samsung: Stuff for v4.18 (second version)
Date: Wed, 23 May 2018 21:27:04 +0200
Message-Id: <20180523192704.25370-1-krzk@kernel.org>
X-Mailer: git-send-email 2.14.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

This is updated pull request with one additional patch from Marek.
I saw you did not pull my previous pull request for v4.18 so I hope
this update should not be a problem.

Anyway it is on top of previous request (no rebase) so it can be also
applied incrementally.


Best regards,
Krzysztof


The following changes since commit 60cc43fc888428bb2f18f08997432d426a243338:

  Linux 4.17-rc1 (2018-04-15 18:24:20 -0700)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/pinctrl/samsung.git tags/samsung-pinctrl-4.18-2

for you to fetch changes up to 7c24e71c8a6423dfa5a7f19b253726b23af0c507:

  pinctrl: samsung: Fix suspend/resume for Exynos5433 GPF1..5 banks (2018-05-23 21:23:19 +0200)

----------------------------------------------------------------
Samsung pinctrl drivers changes for v4.18

1. Driver expects specific order of GPIO interrupt banks.  For S5Pv220
   and Exynos5410 this order was not preserved so fix and document it.
2. Remove support for Exynos5440 (tree-wide, support is dropped because
   there are no real users of this platform, it also did not get testing
   since long time).
3. Fix lost state of GPF1..5 pins on Exynos5433 during system suspend.

----------------------------------------------------------------
Krzysztof Kozlowski (1):
      pinctrl: samsung: Remove support for Exynos5440

Marek Szyprowski (1):
      pinctrl: samsung: Fix suspend/resume for Exynos5433 GPF1..5 banks

Paweł Chmiel (2):
      pinctrl: samsung: Correct EINTG banks order
      pinctrl: samsung: Document required order of banks

 drivers/pinctrl/samsung/Kconfig                |   10 +-
 drivers/pinctrl/samsung/Makefile               |    1 -
 drivers/pinctrl/samsung/pinctrl-exynos-arm.c   |   30 +-
 drivers/pinctrl/samsung/pinctrl-exynos-arm64.c |   20 +
 drivers/pinctrl/samsung/pinctrl-exynos.h       |    2 +-
 drivers/pinctrl/samsung/pinctrl-exynos5440.c   | 1005 ------------------------
 6 files changed, 51 insertions(+), 1017 deletions(-)
 delete mode 100644 drivers/pinctrl/samsung/pinctrl-exynos5440.c
