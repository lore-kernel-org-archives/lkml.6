Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753264AbeC2Ui7 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 16:38:59 -0400
Received: from fallback13.m.smailru.net ([94.100.179.30]:59974 "EHLO
        fallback.mail.ru" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752156AbeC2Uet (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 16:34:49 -0400
From: Sergey Suloev <ssuloev@orpaltech.com>
To: Mark Brown <broonie@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>
Cc: linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Sergey Suloev <ssuloev@orpaltech.com>
Subject: [PATCH 0/6] spi: Add support for DMA transfers in sun4i SPI driver
Date: Thu, 29 Mar 2018 21:59:01 +0300
Message-Id: <20180329185907.27281-1-ssuloev@orpaltech.com>
X-Mailer: git-send-email 2.16.2
X-7FA49CB5: 0D63561A33F958A5C04AD6509EBA4AFFA67B693F76D0AEE7985958D3EF2919B0725E5C173C3A84C3ADE50F0DA4A4E48C795F307EB1CF8B746C9A9530EBF72002C4224003CC836476C0CAF46E325F83A50BF2EBBBDD9D6B0F05F538519369F3743B503F486389A921A5CC5B56E945C8DA
X-Mailru-Sender: C5364AD02485212F3ACDC11E67D84917EE9AA5DB12BA4F2BB24DB51B1963E797069BFC61DABEEB110841D3AAAB1726C63DDE9B364B0DF289264D2CD8C2503E8C22A194DADEED8EEDCA01A23BA9CD1BE7ED14614B50AE0675
X-Mras: OK
X-7FA49CB5: 0D63561A33F958A557E1F21B1BEB3E48A7C7F622B2A954F0E0B7CE59E272E8B7462275124DF8B9C9A939490BDF5DFC32E5BFE6E7EFDEDCD789D4C264860C145E
X-Mailru-Sender: A5480F10D64C9005631A4012884FA16352B0F6778DC341109E5A6DC32282A1BD6F332C5845F46A745FC78D3D9DFD682EC77752E0C033A69E3DF03E4AFE169B847187F6D0DA2124709F6F601AB1435FA63CDA0F3B3F5B9367
X-Mras: OK
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following patchset provides corrections for PIO-mode
and support for DMA transfers in sun4i SPI driver.

Sergey Suloev (6):
  spi: core: handle timeout error from transfer_one()
  spi: sun4i: restrict transfer length in PIO-mode
  spi: sun4i: coding style/readability improvements
  spi: sun4i: use completion provided by SPI core driver
  spi: sun4i: introduce register set/unset helpers
  spi: sun4i: add DMA transfers support

 drivers/spi/spi-sun4i.c | 443 ++++++++++++++++++++++++++++++++++++------------
 drivers/spi/spi.c       |   5 +-
 2 files changed, 341 insertions(+), 107 deletions(-)

-- 
2.16.2
