Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753530AbeCFMDD (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 07:03:03 -0500
Received: from mail-vk0-f65.google.com ([209.85.213.65]:38461 "EHLO
        mail-vk0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750817AbeCFMDB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 07:03:01 -0500
X-Google-Smtp-Source: AG47ELvEj8hGIFsL2iMmSLfaxxECbHEE6EW/DgEqxXJN4Na48zTB4y1Zi9n1TfTtb9VlojlAy+tMPw==
Date: Tue, 6 Mar 2018 09:02:57 -0300
From: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: daniel.baluta@nxp.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] iio: Replace occurrences of magic number 0 by
 IIO_CHAN_INFO_RAW
Message-ID: <20180306120257.eo6kh3b65qmpotoe@smtp.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Usually, functions responsible for reading raw data typically relies on
values from iio_chan_info_enum to correctly identify the type of data to
be read. There is a set of a device driver that uses the magic number 0
instead of IIO_CHAN_INFO_RAW. This patch improves the readability by
replaces the magic number 0 for the appropriate IIO_CHAN_INFO_RAW in six
devices driver in the IIO subsystem.

Signed-off-by: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
---
 drivers/iio/accel/hid-sensor-accel-3d.c | 2 +-
 drivers/iio/dac/ad5380.c                | 2 +-
 drivers/iio/dac/ad5764.c                | 2 +-
 drivers/iio/gyro/hid-sensor-gyro-3d.c   | 2 +-
 drivers/iio/light/hid-sensor-als.c      | 2 +-
 drivers/iio/light/lm3533-als.c          | 2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/accel/hid-sensor-accel-3d.c b/drivers/iio/accel/hid-sensor-accel-3d.c
index c066a3bdbff7..41d97faf5013 100644
--- a/drivers/iio/accel/hid-sensor-accel-3d.c
+++ b/drivers/iio/accel/hid-sensor-accel-3d.c
@@ -155,7 +155,7 @@ static int accel_3d_read_raw(struct iio_dev *indio_dev,
 	*val = 0;
 	*val2 = 0;
 	switch (mask) {
-	case 0:
+	case IIO_CHAN_INFO_RAW:
 		hid_sensor_power_state(&accel_state->common_attributes, true);
 		report_id = accel_state->accel[chan->scan_index].report_id;
 		address = accel_3d_addresses[chan->scan_index];
diff --git a/drivers/iio/dac/ad5380.c b/drivers/iio/dac/ad5380.c
index 845fd1c0fd9d..873c2bf637c0 100644
--- a/drivers/iio/dac/ad5380.c
+++ b/drivers/iio/dac/ad5380.c
@@ -158,7 +158,7 @@ static unsigned int ad5380_info_to_reg(struct iio_chan_spec const *chan,
 	long info)
 {
 	switch (info) {
-	case 0:
+	case IIO_CHAN_INFO_RAW:
 		return AD5380_REG_DATA(chan->address);
 	case IIO_CHAN_INFO_CALIBBIAS:
 		return AD5380_REG_OFFSET(chan->address);
diff --git a/drivers/iio/dac/ad5764.c b/drivers/iio/dac/ad5764.c
index 033f20eca616..9333177062c0 100644
--- a/drivers/iio/dac/ad5764.c
+++ b/drivers/iio/dac/ad5764.c
@@ -168,7 +168,7 @@ static int ad5764_read(struct iio_dev *indio_dev, unsigned int reg,
 static int ad5764_chan_info_to_reg(struct iio_chan_spec const *chan, long info)
 {
 	switch (info) {
-	case 0:
+	case IIO_CHAN_INFO_RAW:
 		return AD5764_REG_DATA(chan->address);
 	case IIO_CHAN_INFO_CALIBBIAS:
 		return AD5764_REG_OFFSET(chan->address);
diff --git a/drivers/iio/gyro/hid-sensor-gyro-3d.c b/drivers/iio/gyro/hid-sensor-gyro-3d.c
index f59995a90387..36941e69f959 100644
--- a/drivers/iio/gyro/hid-sensor-gyro-3d.c
+++ b/drivers/iio/gyro/hid-sensor-gyro-3d.c
@@ -115,7 +115,7 @@ static int gyro_3d_read_raw(struct iio_dev *indio_dev,
 	*val = 0;
 	*val2 = 0;
 	switch (mask) {
-	case 0:
+	case IIO_CHAN_INFO_RAW:
 		hid_sensor_power_state(&gyro_state->common_attributes, true);
 		report_id = gyro_state->gyro[chan->scan_index].report_id;
 		address = gyro_3d_addresses[chan->scan_index];
diff --git a/drivers/iio/light/hid-sensor-als.c b/drivers/iio/light/hid-sensor-als.c
index befd693a4a31..406caaee9a3c 100644
--- a/drivers/iio/light/hid-sensor-als.c
+++ b/drivers/iio/light/hid-sensor-als.c
@@ -97,7 +97,7 @@ static int als_read_raw(struct iio_dev *indio_dev,
 	*val = 0;
 	*val2 = 0;
 	switch (mask) {
-	case 0:
+	case IIO_CHAN_INFO_RAW:
 		switch (chan->scan_index) {
 		case  CHANNEL_SCAN_INDEX_INTENSITY:
 		case  CHANNEL_SCAN_INDEX_ILLUM:
diff --git a/drivers/iio/light/lm3533-als.c b/drivers/iio/light/lm3533-als.c
index 36208a3652e9..ff5a3324b489 100644
--- a/drivers/iio/light/lm3533-als.c
+++ b/drivers/iio/light/lm3533-als.c
@@ -199,7 +199,7 @@ static int lm3533_als_read_raw(struct iio_dev *indio_dev,
 	int ret;
 
 	switch (mask) {
-	case 0:
+	case IIO_CHAN_INFO_RAW:
 		switch (chan->type) {
 		case IIO_LIGHT:
 			ret = lm3533_als_get_adc(indio_dev, false, val);
-- 
2.16.2
