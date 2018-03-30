Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751932AbeC3Mu6 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 30 Mar 2018 08:50:58 -0400
Received: from smtp58.i.mail.ru ([217.69.128.38]:36822 "EHLO smtp58.i.mail.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751118AbeC3Mu4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Mar 2018 08:50:56 -0400
From: Sergey Suloev <ssuloev@orpaltech.com>
To: Mark Brown <broonie@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>
Cc: linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Sergey Suloev <ssuloev@orpaltech.com>
Subject: [PATCH v2 0/6] spi: Add support for DMA transfers in sun6i SPI driver
Date: Fri, 30 Mar 2018 15:50:41 +0300
Message-Id: <20180330125047.13936-1-ssuloev@orpaltech.com>
X-Mailer: git-send-email 2.16.2
Authentication-Results: smtp58.i.mail.ru; auth=pass smtp.auth=ssuloev@orpaltech.com smtp.mailfrom=ssuloev@orpaltech.com
X-7FA49CB5: 0D63561A33F958A5A428AE05D2C4E58A26FD46E76099F7CDF94BCAF8487875F4725E5C173C3A84C3EBF4D8D28E8B6903343DA6383E413BE442F54486E6D6388DC4224003CC836476C0CAF46E325F83A50BF2EBBBDD9D6B0F5D41B9178041F3E72623479134186CDE6BA297DBC24807EABDAD6C7F3747799A
X-Mailru-Sender: C5364AD02485212F3ACDC11E67D849173F43A4836EDFB444F9AF4BB23CD0907F069BFC61DABEEB110841D3AAAB1726C63DDE9B364B0DF289264D2CD8C2503E8C22A194DADEED8EEDCA01A23BA9CD1BE7ED14614B50AE0675
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

Sergey Suloev (6):
  spi: sun6i: coding style/readability improvements
  spi: sun6i: handle chip select polarity flag
  spi: sun6i: restrict transfer length in PIO-mode
  spi: sun6i: use completion provided by SPI core
  spi: sun6i: introduce register set/unset helpers
  spi: sun6i: add DMA transfers support

 drivers/spi/spi-sun6i.c | 507 ++++++++++++++++++++++++++++++++++++------------
 1 file changed, 381 insertions(+), 126 deletions(-)

-- 
2.16.2
