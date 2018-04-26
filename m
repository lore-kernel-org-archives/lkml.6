Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756927AbeDZRfU (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 13:35:20 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([81.169.146.165]:33074 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754582AbeDZRfQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 13:35:16 -0400
X-RZG-AUTH: :JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9o12DNO4Ij0Jfyqs9nA==
X-RZG-CLASS-ID: mo00
From: "H. Nikolaus Schaller" <hns@goldelico.com>
To: galak@codeaurora.org, andy.shevchenko@gmail.com,
        Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alexandre Courbot <gnurou@gmail.com>
Cc: devicetree@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, letux-kernel@openphoenux.org,
        kernel@pyra-handheld.com, "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [PATCH v4 0/7] pcal6524 extensions and fixes for pca953x driver
Date: Thu, 26 Apr 2018 19:34:55 +0200
Message-Id: <cover.1524764101.git.hns@goldelico.com>
X-Mailer: git-send-email 2.12.2
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

V4:
* introduced PCA_LATCH_INT constant to make of_table more
  readable (suggested by Andy Shevchenko)
* converted all register constants to hex in a separate
  patch (suggested by Andy Shevchenko)
* separated additional pcal953x and pcal6524 register
  definitions into separate patches (suggested by Andy Shevchenko)
* made special pcal6524 address adjustment more readable
  (suggested by Andy Shevchenko)
* moved gpio-controller and interrupt-controller to the
  "required" section (reviewed by Rob Herring)

2018-04-10 18:07:07: V3:
* add Reported-by: and Reviewed-by:
* fix wording for bindings description and example
* convert all register offsets to hex
* omit the LEVEL-IRQ RFC/hack commit

2018-04-04 21:00:27: V2:
* added PCA_PCAL flags if matched through of-table
* fix address calculation for extended PCAL6524 registers
* hack to map LEVEL_LOW to EDGE_FALLING to be able to
  test in combination with ts3a227e driver
* improve description of bindings for optional vcc-supply
  and interrupt-controller;

2018-03-10 09:32:53: no initial description

H. Nikolaus Schaller (7):
  gpio: pca953x: convert register constants to hex
  gpio: pca953x: add more register definitions for pcal953x
  gpio: pca953x: add more register definitions for pcal6524
  gpio: pca953x: define masks for addressing common and extended
    registers
  gpio: pca953x: fix address calculation for pcal6524
  DTS: Bindings: pca953x add an optional vcc-supply property
  DTS: Bindings: pca953x: add example how to use interrupt-controller
    and gpio-controller

 .../devicetree/bindings/gpio/gpio-pca953x.txt      | 34 ++++++++++++++
 drivers/gpio/gpio-pca953x.c                        | 53 ++++++++++++++--------
 2 files changed, 69 insertions(+), 18 deletions(-)

-- 
2.12.2
