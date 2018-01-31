Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751898AbeAaUnn (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 15:43:43 -0500
Received: from mout.web.de ([212.227.15.3]:49865 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751737AbeAaUnk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 15:43:40 -0500
To: linux-iio@vger.kernel.org, linux-input@vger.kernel.org,
        Hartmut Knaack <knaack.h@gmx.de>, Jiri Kosina <jikos@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH] hid-sensor-gyro-3d: Delete an error message for a failed
 memory allocation in hid_gyro_3d_probe()
Message-ID: <e3308896-dd91-1af0-912f-32cc0794361e@users.sourceforge.net>
Date: Wed, 31 Jan 2018 21:43:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:bW8OlT1sFOuqBmOVquRWGsBcOjsGxz1FSz7/RoGL+d7Ui/qAP/D
 7/NEWOvrJG5i4Tiqgq9nDFsEN0PVbTCQlDHSCOaudt8rQ/2e9IQwOMeSZXnHTqxuOgTk49C
 PLVeeZAJKhYoXCP3MoJBXTHxG4fuAc11jQUTSzUKByPzSqVSnq/w+WE2P4lb0Z/z1Ke5gKW
 FODGextCo1hkGiOv/Br0g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:4BHnivZAgvo=:g5d5soyAUPrMFA0NNLxjha
 Cx7WGekwsakFZhkguTNLRBANqdqElc9DHjhsyokO83DnFv/mHvkVEJ7WFZolfjLUSCF63SDC4
 lyrp0CnUmNkuEihwtZ4jdn8NBi546cHo5TC3R3x6jTwR4mMWQ8ntZG/F9NAHd3HdUzcnJaS8d
 V7riSAOfAOpEFon9LuDOW07LU3sM1Jw1aQLpwCwYZZkAkrG/qOsiKGv3vNsTDMK9pRLFyfhsp
 Fy9rJ+UtqnCQL4FBb7A7a3krBz6kUe32OZmaLlWCE9D16WSSSqvAsUJkS8cnVe5POC/smtk7Q
 3cg/FgY4EIiSikz7AArfZh8DfpoLX7sXsvL5xj3qc+ViJfDCQD6YCIKrH41OChV+nydIaHljj
 svP+oAvf0jlsfPE+8uSjMzmupDZV5YpP3d/Rq3YW3j5R1lhwTZOJtZK2itCHuZ27BEBYM5oRv
 4UqqXud5GaxYBcfCz1YfT6/Aj7NDubsvZK2JBh1dKQ5aPtAuruCdl1qM8kajM1xeGxJ5f2+eQ
 Hx0vLDcSC29M0ZcJj+AacikCgP+ygG1BI91zPxIfqkvmCkYznI0Hr6XZDsGoiDzKnKE7CiBci
 v+hkm2ILHFHbcPLFOBxxnmr0qyMZiYN9yQqoE/6uvIFr33YDXxiIhQJEU9ZMLWex3aG5F4vRA
 24gqzP1CVD7vckPH/w6j76UYn3q/APOldzBSWAuoWeE6wjy95v6ribau69VZamWwGYzTGhObL
 ns5LEr4fyROnU/uCWNT+/ZoUXqRVHNzDqFx7GDuApTUSiGeOYXKLznqpSmzQVuBSlXa4EfBFO
 2wOmW8fYnL7sMARqFMplNX2JvuK2KflcaOvjxyCgJH449uH6xU=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Wed, 31 Jan 2018 21:36:53 +0100

Omit an extra message for a memory allocation failure in this function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/iio/gyro/hid-sensor-gyro-3d.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/iio/gyro/hid-sensor-gyro-3d.c b/drivers/iio/gyro/hid-sensor-gyro-3d.c
index f59995a90387..93465816c5c7 100644
--- a/drivers/iio/gyro/hid-sensor-gyro-3d.c
+++ b/drivers/iio/gyro/hid-sensor-gyro-3d.c
@@ -317,10 +317,8 @@ static int hid_gyro_3d_probe(struct platform_device *pdev)
 
 	indio_dev->channels = kmemdup(gyro_3d_channels,
 				      sizeof(gyro_3d_channels), GFP_KERNEL);
-	if (!indio_dev->channels) {
-		dev_err(&pdev->dev, "failed to duplicate channels\n");
+	if (!indio_dev->channels)
 		return -ENOMEM;
-	}
 
 	ret = gyro_3d_parse_report(pdev, hsdev,
 				   (struct iio_chan_spec *)indio_dev->channels,
-- 
2.16.1
