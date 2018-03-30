Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752591AbeC3HWz (ORCPT <rfc822;w@1wt.eu>);
        Fri, 30 Mar 2018 03:22:55 -0400
Received: from smtp57.i.mail.ru ([217.69.128.37]:43752 "EHLO smtp57.i.mail.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751085AbeC3HWx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Mar 2018 03:22:53 -0400
From: Sergey Suloev <ssuloev@orpaltech.com>
To: Mark Brown <broonie@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>
Cc: linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Sergey Suloev <ssuloev@orpaltech.com>
Subject: [PATCH 0/6] spi: Add support for DMA transfers in sun6i SPI driver
Date: Fri, 30 Mar 2018 10:22:37 +0300
Message-Id: <20180330072243.19368-1-ssuloev@orpaltech.com>
X-Mailer: git-send-email 2.16.2
Authentication-Results: smtp57.i.mail.ru; auth=pass smtp.auth=ssuloev@orpaltech.com smtp.mailfrom=ssuloev@orpaltech.com
X-7FA49CB5: 0D63561A33F958A5E661AEA9A400726ABC0A8B6031D50A0087F0100672248076725E5C173C3A84C39D7D3120FB43BDE35133B6664BA740BAF3CCD8A865B74A75C4224003CC836476C0CAF46E325F83A50BF2EBBBDD9D6B0F05F538519369F3743B503F486389A921A5CC5B56E945C8DA
X-Mailru-Sender: C5364AD02485212F3ACDC11E67D84917A363CF345EC485165E7F4CCF5BDD76AA069BFC61DABEEB110841D3AAAB1726C63DDE9B364B0DF289264D2CD8C2503E8C22A194DADEED8EEDCA01A23BA9CD1BE7ED14614B50AE0675
X-Mras: OK
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following patchset provides corrections for PIO-mode
and support for DMA transfers in sun6i SPI driver.

Sergey Suloev (6):
  spi: sun6i: coding style/readability improvements
  spi: sun6i: handle chip select polarity flag
  spi: sun6i: restrict transfer length in PIO-mode
  spi: sun6i: use completion provided by SPI core
  spi: sun6i: introduce register set/unset helpers
  spi: sun6i: add DMA transfers support

 drivers/spi/spi-sun6i.c | 501 ++++++++++++++++++++++++++++++++++++------------
 1 file changed, 378 insertions(+), 123 deletions(-)

-- 
2.16.2
