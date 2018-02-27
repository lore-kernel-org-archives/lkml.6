Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753972AbeB0OsC (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 09:48:02 -0500
Received: from mail-qk0-f193.google.com ([209.85.220.193]:39973 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753381AbeB0OsA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 09:48:00 -0500
X-Google-Smtp-Source: AG47ELuMCuLHz+kkYk+P3IV8YnKvwVGC8u30B07IHM2AqO/uORjTP5l7JuYVrjS2iWhWs+eqtRxvcQ==
Date: Tue, 27 Feb 2018 11:47:55 -0300
From: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc: daniel.baluta@nxp.com, kernel-janitors@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] iio:magnetometer: Replace magic number 0 by IIO_CHAN_INFO_RAW
Message-ID: <20180227144755.ifbzn5gekm345nk5@smtp.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function magn_3d_read_raw has a switch statement handling multiple
cases per channel. The first case statement uses the magic number 0,
which means IIO_CHAN_INFO_RAW. Additionally, the iio_chan_spec for
magn_3d_channels is configured to be IIO_CHAN_INFO_RAW. Therefore, this
patch replaces the magic number 0 for the appropriate IIO_CHAN_INFO_RAW.

Signed-off-by: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
---
 drivers/iio/magnetometer/hid-sensor-magn-3d.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/magnetometer/hid-sensor-magn-3d.c b/drivers/iio/magnetometer/hid-sensor-magn-3d.c
index a1fd9d591818..d55c4885211a 100644
--- a/drivers/iio/magnetometer/hid-sensor-magn-3d.c
+++ b/drivers/iio/magnetometer/hid-sensor-magn-3d.c
@@ -167,7 +167,7 @@ static int magn_3d_read_raw(struct iio_dev *indio_dev,
 	*val = 0;
 	*val2 = 0;
 	switch (mask) {
-	case 0:
+	case IIO_CHAN_INFO_RAW:
 		hid_sensor_power_state(&magn_state->magn_flux_attributes, true);
 		report_id =
 			magn_state->magn[chan->address].report_id;
-- 
2.16.2
