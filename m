Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932851AbeCEXxm (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 18:53:42 -0500
Received: from gateway32.websitewelcome.com ([192.185.145.100]:30220 "EHLO
        gateway32.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932444AbeCEXxl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 18:53:41 -0500
Date: Mon, 5 Mar 2018 17:53:39 -0600
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To: Laxman Dewangan <ldewangan@nvidia.com>,
        Mark Brown <broonie@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc: linux-spi@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Subject: [PATCH] spi: tegra20-slink: use true and false for boolean values
Message-ID: <20180305235339.GA646@embeddedgus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.175.117.58
X-Source-L: No
X-Exim-ID: 1eszvI-003lL7-6e
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedgus) [189.175.117.58]:46136
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 22
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Assign true or false to boolean variables instead of an integer value.

This issue was detected with the help of Coccinelle.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/spi/spi-tegra20-slink.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-tegra20-slink.c b/drivers/spi/spi-tegra20-slink.c
index 3e12d5f..6f7b946b 100644
--- a/drivers/spi/spi-tegra20-slink.c
+++ b/drivers/spi/spi-tegra20-slink.c
@@ -276,10 +276,10 @@ static unsigned tegra_slink_calculate_curr_xfer_param(
 	tspi->bytes_per_word = DIV_ROUND_UP(bits_per_word, 8);
 
 	if (bits_per_word == 8 || bits_per_word == 16) {
-		tspi->is_packed = 1;
+		tspi->is_packed = true;
 		tspi->words_per_32bit = 32/bits_per_word;
 	} else {
-		tspi->is_packed = 0;
+		tspi->is_packed = false;
 		tspi->words_per_32bit = 1;
 	}
 	tspi->packed_size = tegra_slink_get_packed_size(tspi, t);
-- 
2.7.4
