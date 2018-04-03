Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751926AbeDCP3M (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 11:29:12 -0400
Received: from smtp54.i.mail.ru ([217.69.128.34]:55854 "EHLO smtp54.i.mail.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751434AbeDCP3K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 11:29:10 -0400
From: Sergey Suloev <ssuloev@orpaltech.com>
To: Mark Brown <broonie@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>
Cc: linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Sergey Suloev <ssuloev@orpaltech.com>
Subject: [PATCH v2 0/6] spi: Add support for DMA transfers in sun4i SPI driver
Date: Tue,  3 Apr 2018 18:28:59 +0300
Message-Id: <20180403152905.1524-1-ssuloev@orpaltech.com>
X-Mailer: git-send-email 2.16.2
Authentication-Results: smtp54.i.mail.ru; auth=pass smtp.auth=ssuloev@orpaltech.com smtp.mailfrom=ssuloev@orpaltech.com
X-7FA49CB5: 0D63561A33F958A5CF92BCBD4E106AD2FD153644D6503B5886FBC7D9D424934E725E5C173C3A84C3A1C30C8AFC676C8BC54B4A3D9DA81217CC4B623DB76FBBCBC4224003CC836476C0CAF46E325F83A50BF2EBBBDD9D6B0F05F538519369F3743B503F486389A921A5CC5B56E945C8DA
X-Mailru-Sender: C5364AD02485212F3ACDC11E67D84917423DD33A7258B93345D63C342C77BFB0069BFC61DABEEB110841D3AAAB1726C63DDE9B364B0DF289264D2CD8C2503E8C22A194DADEED8EEDCA01A23BA9CD1BE7ED14614B50AE0675
X-Mras: OK
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following patchset provides corrections for PIO-mode
and support for DMA transfers in sun4i SPI driver.

Changes in v2:
1) Restored processing of 3/4 FIFO full interrupt.

2) Debug log enhancements.

Sergey Suloev (6):
  spi: core: handle timeout error from transfer_one()
  spi: sun4i: restrict transfer length in PIO-mode
  spi: sun4i: coding style/readability improvements
  spi: sun4i: use completion provided by SPI core driver
  spi: sun4i: introduce register set/unset helpers
  spi: sun4i: add DMA transfers support

 drivers/spi/spi-sun4i.c | 442 +++++++++++++++++++++++++++++++++++++-----------
 drivers/spi/spi.c       |   5 +-
 2 files changed, 347 insertions(+), 100 deletions(-)

-- 
2.16.2
