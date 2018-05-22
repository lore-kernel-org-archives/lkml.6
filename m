Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751436AbeEVQUH (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 12:20:07 -0400
Received: from gateway36.websitewelcome.com ([192.185.185.36]:19276 "EHLO
        gateway36.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751236AbeEVQUG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 12:20:06 -0400
X-Authority-Reason: nr=8
Date: Tue, 22 May 2018 11:20:01 -0500
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] media: dib0700: add code comment
Message-ID: <20180522162001.GA28579@embeddedor.com>
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
X-Source-IP: 187.192.46.223
X-Source-L: No
X-Exim-ID: 1fLA17-002gRj-Ad
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [187.192.46.223]:36892
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 11
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add FIXME code comment:
/* FIXME: check if it is fe_adap[1] */

It is likely that it should be adap->fe_adap[1].fe in the second clause,
but this has never been verified.

Suggested-by: Mauro Carvalho Chehab <mchehab@kernel.org>
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/media/usb/dvb-usb/dib0700_devices.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/media/usb/dvb-usb/dib0700_devices.c b/drivers/media/usb/dvb-usb/dib0700_devices.c
index c53a969..091389f 100644
--- a/drivers/media/usb/dvb-usb/dib0700_devices.c
+++ b/drivers/media/usb/dvb-usb/dib0700_devices.c
@@ -1745,6 +1745,7 @@ static int dib809x_tuner_attach(struct dvb_usb_adapter *adap)
 		if (dvb_attach(dib0090_register, adap->fe_adap[0].fe, tun_i2c, &dib809x_dib0090_config) == NULL)
 			return -ENODEV;
 	} else {
+		/* FIXME: check if it is fe_adap[1] */
 		if (dvb_attach(dib0090_register, adap->fe_adap[0].fe, tun_i2c, &dib809x_dib0090_config) == NULL)
 			return -ENODEV;
 	}
-- 
2.7.4
