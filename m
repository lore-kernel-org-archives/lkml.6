Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752309AbeDCPo5 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 11:44:57 -0400
Received: from smtp57.i.mail.ru ([217.69.128.37]:42858 "EHLO smtp57.i.mail.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752075AbeDCPoz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 11:44:55 -0400
From: Sergey Suloev <ssuloev@orpaltech.com>
To: Mark Brown <broonie@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>
Cc: linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Sergey Suloev <ssuloev@orpaltech.com>
Subject: [PATCH v3 0/6] spi: Add support for DMA transfers in sun6i SPI driver
Date: Tue,  3 Apr 2018 18:44:43 +0300
Message-Id: <20180403154449.2443-1-ssuloev@orpaltech.com>
X-Mailer: git-send-email 2.16.2
Authentication-Results: smtp57.i.mail.ru; auth=pass smtp.auth=ssuloev@orpaltech.com smtp.mailfrom=ssuloev@orpaltech.com
X-7FA49CB5: 0D63561A33F958A5F55E3524CD6DD3A3840FE9263A247D770B941C93B49DEED7725E5C173C3A84C3A1C30C8AFC676C8BD5966E8489616130E5B2F3A2B87CD4C8C4224003CC836476C0CAF46E325F83A50BF2EBBBDD9D6B0F05F538519369F3743B503F486389A921A5CC5B56E945C8DA
X-Mailru-Sender: C5364AD02485212F3ACDC11E67D84917E394416E73E9AFE1A34CE6510AE19CDE069BFC61DABEEB110841D3AAAB1726C63DDE9B364B0DF289264D2CD8C2503E8C22A194DADEED8EEDCA01A23BA9CD1BE7ED14614B50AE0675
X-Mras: OK
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following patchset provides corrections for PIO-mode
and support for DMA transfers in sun6i SPI driver.

Changes in v2:
1) Fixed issue with misplacing a piece of code that requires access
to the transfer structure into sun6i_spi_prepare_message() function
where the transfer structure is not available.

2) Fixed issue with passing an invalid argument into devm_request_irq()
function.

Changes in v3:
1) Restored processing of 3/4 FIFO full interrupt.

2) Debug log enhancements.

Sergey Suloev (6):
  spi: sun6i: coding style/readability improvements
  spi: sun6i: handle chip select polarity flag
  spi: sun6i: restrict transfer length in PIO-mode
  spi: sun6i: use completion provided by SPI core
  spi: sun6i: introduce register set/unset helpers
  spi: sun6i: add DMA transfers support

 drivers/spi/spi-sun6i.c | 526 ++++++++++++++++++++++++++++++++++++------------
 1 file changed, 402 insertions(+), 124 deletions(-)

-- 
2.16.2
