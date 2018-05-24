Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031851AbeEXOTZ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 10:19:25 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:45574 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1030516AbeEXOTW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 10:19:22 -0400
From: Gilad Ben-Yossef <gilad@benyossef.com>
To: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
Cc: Ofir Drang <ofir.drang@arm.com>, linux-renesas-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-crypto@vger.kernel.org
Subject: [PATCH v2 0/5] crypto: ccree: cleanup, fixes and R-Car enabling
Date: Thu, 24 May 2018 15:19:05 +0100
Message-Id: <1527171551-21979-1-git-send-email-gilad@benyossef.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch set enables the use of CryptoCell found in some Renesas R-Car
Salvator-X boards and fixes some driver issues uncovered that prevented
to work properly.

Changes from v1:
- Properly fix the bug that caused us to read a bad signature register
  rather than dropping the check
- Proper DT fields as indicated by Geert Uytterhoeven.
- Better clock enabling as suggested by Geert Uytterhoeven.

Note! the last two patches in the set depend on the
"clk: renesas: r8a7795: Add CR clock" patch from Geert Uytterhoeven.

Gilad Ben-Yossef (5):
  crypto: ccree: correct host regs offset
  crypto: ccree: better clock handling
  crypto: ccree: silence debug prints
  clk: renesas: r8a7795: add ccree clock bindings
  arm64: dts: renesas: r8a7795: add ccree binding

 arch/arm64/boot/dts/renesas/r8a7795.dtsi |  9 +++++++++
 drivers/clk/renesas/r8a7795-cpg-mssr.c   |  1 +
 drivers/crypto/ccree/cc_debugfs.c        |  7 +++++--
 drivers/crypto/ccree/cc_driver.c         | 34 ++++++++++++++++++++++++++------
 drivers/crypto/ccree/cc_driver.h         |  2 ++
 drivers/crypto/ccree/cc_host_regs.h      |  6 ++++--
 6 files changed, 49 insertions(+), 10 deletions(-)

-- 
2.7.4
