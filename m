Return-Path: <SRS0=XTOn=JD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5141BC5CFC1
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 05:31:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13FDB208A5
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 05:31:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13FDB208A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tamalin.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754089AbeFQFbU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Jun 2018 01:31:20 -0400
Received: from mout.perfora.net ([74.208.4.196]:59443 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753685AbeFQFbQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jun 2018 01:31:16 -0400
Received: from kahja.local ([73.231.184.107]) by mrelay.perfora.net
 (mreueus002 [74.208.5.2]) with ESMTPSA (Nemesis) id 0MfHEC-1ft5lK3qJ8-00Or4e;
 Sun, 17 Jun 2018 07:31:05 +0200
From:   Quytelda Kahja <quytelda@tamalin.org>
To:     gregkh@linuxfoundation.org, hadess@hadess.net, hdegoede@redhat.com,
        Larry.Finger@lwfinger.net
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Quytelda Kahja <quytelda@tamalin.org>
Subject: [PATCH 10/11] staging: rtl8723bs: Merge workaround conditionals into single else-if.
Date:   Sat, 16 Jun 2018 22:30:39 -0700
Message-Id: <20180617053040.5903-10-quytelda@tamalin.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180617053040.5903-1-quytelda@tamalin.org>
References: <20180617053040.5903-1-quytelda@tamalin.org>
X-Provags-ID: V03:K1:XkaEh5GDrmb4N8PzJt9mwxTFSmo/mRAJkc8WLHYX2GkweWuD/yh
 k/1nYofqAyaqo+hVyYhejoOPBs7BJJnH3ktGED6OBVWHV0tm5wkWlwHeTEky8N2jkRmtjlB
 u4ep/E7F/YTZCB2VCaa2ienGmRAeEJ87LdAbX/Zm7fw67MPPD8TCgkqCDEk38y119SP8BNd
 yQlYT8x31skA2DueABv9g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:gAQhoih3JOg=:mLE2SBSNn0suGq4fPCxELl
 5T0t2y1qUKl0uhBYqMbZmw2XCFlpJc1EXQsGFtGaL7qi+RnwW8SL0fk8wgChCj8Oo1TMvoQLj
 k+Cm9iZ0cfdQnPLc9F8gM9mlU+ffMHxSSzRpBLyZaXiPaFfGyw0gSITj4HTNjAH/HFpN8KHXc
 PFjSkO64XFUFNTFRLBRQwarhJv8xPh20eS1pcKaerEpe92ZbrIqb/SBd0mkzsQegxAbjIzsud
 4ufDdBEwjfROMEeXYtgW1ZMWTj8bxJBvJ1M4oOK2OnJe89Ny0OVtmPHmsi3U+g9Vh4GgJZlQG
 zDPG/9sEpQRE8R9RHtVvT0+1TYpGp11tfiqvdsSSQ7pAnmpJH+9KL1d99/IFrjb1/eZu22y6I
 wcWJxXuhyLy+ju3XVWXZi/VysQod5XL56yTWab6oLv1NctzcCDv3WVMULzu6MFajNv8rUfUcR
 PhpO4gFIEnv02mwGBiWFMLhYKDcEo4AzAytz2Fo4wPju6OiiLkEtj5mrSkQd/VushJSceKjUM
 1EUKh9x7w3xaYy763kQPRBByBelHtWrSZrb9iOpM0kHC5XKSY1+CaraDTRH/G9nqylm40ZcsP
 zI+9UhyULhJi5WrGYwmX3FtWAF02CDcqYjbOitsfz6po04tF7gZwNv7MpXvOYqH9Fhu1TRREz
 g932DI/A2xlr7+3jYLBa6PC8SNoztDLFQhGX0WtcMy378OfLpU3wp4IXGWrrTDEHqndo=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The if conditionals used to work around wrong TX power limit indices
can be condensed into a single if/else-if statement for more concise
expression.

Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>
---
 drivers/staging/rtl8723bs/hal/hal_com_phycfg.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/hal_com_phycfg.c b/drivers/staging/rtl8723bs/hal/hal_com_phycfg.c
index 9e6dc238c028..0e49f0973c12 100644
--- a/drivers/staging/rtl8723bs/hal/hal_com_phycfg.c
+++ b/drivers/staging/rtl8723bs/hal/hal_com_phycfg.c
@@ -1728,15 +1728,12 @@ s8 phy_get_tx_pwr_lmt(struct adapter *adapter, u32 reg_pwr_tbl_sel,
 	/*  workaround for wrong index combination to obtain tx power limit, */
 	/*  OFDM only exists in BW 20M */
 	/*  CCK table will only be given in BW 20M */
+	/*  HT on 80M will reference to HT on 40M */
 	if (idx_rate_sctn == 0 || idx_rate_sctn == 1)
 		idx_bandwidth = 0;
-
-	/*  workaround for wrong index combination to obtain tx power limit, */
-	/*  HT on 80M will reference to HT on 40M */
-	if ((idx_rate_sctn == 2 || idx_rate_sctn == 3) &&
-	    band_type == BAND_ON_5G && idx_bandwidth == 2) {
+	else if ((idx_rate_sctn == 2 || idx_rate_sctn == 3) &&
+		 (band_type == BAND_ON_5G) && (idx_bandwidth == 2))
 		idx_bandwidth = 1;
-	}
 
 	if (band_type == BAND_ON_2_4G || band_type == BAND_ON_5G)
 		channel = phy_GetChannelIndexOfTxPowerLimit(band_type, channel);
-- 
2.17.1

