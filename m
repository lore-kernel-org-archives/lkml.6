Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751952AbeBUT2O (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 14:28:14 -0500
Received: from mail-qk0-f195.google.com ([209.85.220.195]:37453 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751401AbeBUT2M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 14:28:12 -0500
X-Google-Smtp-Source: AG47ELtQ/GdHah9zwOnKsYXcE8kxtX86T8IXtuSIVIZFALhW1rpSDinzwtF2tpD7GvnGblAhqNyzQQ==
Date: Wed, 21 Feb 2018 16:28:07 -0300
From: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc: daniel.baluta@nxp.com, linux-iio@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] iio:dummy: Replace S_IWUSR by 0200
Message-ID: <20180221192807.qfyhp7z27f6r6p47@smtp.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the checkpatch.pl warning:

drivers/iio/dummy/iio_dummy_evgen.c:151: WARNING: Symbolic permissions
'S_IWUSR' are not preferred. Consider using octal permissions '0200'.
...

Signed-off-by: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
---
Changes in v2:
  - Make the commit message clearer.
  - Fix just a single part of the code.

 drivers/iio/dummy/iio_dummy_evgen.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/dummy/iio_dummy_evgen.c b/drivers/iio/dummy/iio_dummy_evgen.c
index efd0005f59b4..16ea547f79f0 100644
--- a/drivers/iio/dummy/iio_dummy_evgen.c
+++ b/drivers/iio/dummy/iio_dummy_evgen.c
@@ -148,16 +148,16 @@ static ssize_t iio_evgen_poke(struct device *dev,
 	return len;
 }
 
-static IIO_DEVICE_ATTR(poke_ev0, S_IWUSR, NULL, &iio_evgen_poke, 0);
-static IIO_DEVICE_ATTR(poke_ev1, S_IWUSR, NULL, &iio_evgen_poke, 1);
-static IIO_DEVICE_ATTR(poke_ev2, S_IWUSR, NULL, &iio_evgen_poke, 2);
-static IIO_DEVICE_ATTR(poke_ev3, S_IWUSR, NULL, &iio_evgen_poke, 3);
-static IIO_DEVICE_ATTR(poke_ev4, S_IWUSR, NULL, &iio_evgen_poke, 4);
-static IIO_DEVICE_ATTR(poke_ev5, S_IWUSR, NULL, &iio_evgen_poke, 5);
-static IIO_DEVICE_ATTR(poke_ev6, S_IWUSR, NULL, &iio_evgen_poke, 6);
-static IIO_DEVICE_ATTR(poke_ev7, S_IWUSR, NULL, &iio_evgen_poke, 7);
-static IIO_DEVICE_ATTR(poke_ev8, S_IWUSR, NULL, &iio_evgen_poke, 8);
-static IIO_DEVICE_ATTR(poke_ev9, S_IWUSR, NULL, &iio_evgen_poke, 9);
+static IIO_DEVICE_ATTR(poke_ev0, 0200, NULL, &iio_evgen_poke, 0);
+static IIO_DEVICE_ATTR(poke_ev1, 0200, NULL, &iio_evgen_poke, 1);
+static IIO_DEVICE_ATTR(poke_ev2, 0200, NULL, &iio_evgen_poke, 2);
+static IIO_DEVICE_ATTR(poke_ev3, 0200, NULL, &iio_evgen_poke, 3);
+static IIO_DEVICE_ATTR(poke_ev4, 0200, NULL, &iio_evgen_poke, 4);
+static IIO_DEVICE_ATTR(poke_ev5, 0200, NULL, &iio_evgen_poke, 5);
+static IIO_DEVICE_ATTR(poke_ev6, 0200, NULL, &iio_evgen_poke, 6);
+static IIO_DEVICE_ATTR(poke_ev7, 0200, NULL, &iio_evgen_poke, 7);
+static IIO_DEVICE_ATTR(poke_ev8, 0200, NULL, &iio_evgen_poke, 8);
+static IIO_DEVICE_ATTR(poke_ev9, 0200, NULL, &iio_evgen_poke, 9);
 
 static struct attribute *iio_evgen_attrs[] = {
 	&iio_dev_attr_poke_ev0.dev_attr.attr,
-- 
2.16.2
