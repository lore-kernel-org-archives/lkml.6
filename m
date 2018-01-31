Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753189AbeAaV0h (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 16:26:37 -0500
Received: from mout.web.de ([212.227.15.4]:50414 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751674AbeAaV0f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 16:26:35 -0500
To: linux-iio@vger.kernel.org, linux-input@vger.kernel.org,
        Hartmut Knaack <knaack.h@gmx.de>, Jiri Kosina <jikos@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH] hid-sensor-accel-3d: Delete an error message for a failed
 memory allocation in hid_accel_3d_probe()
Message-ID: <0406765c-bdd1-1a82-cf66-1c248063ae4f@users.sourceforge.net>
Date: Wed, 31 Jan 2018 22:26:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:GyNLTsejwyzRjMjVIBAhV7ueMdmMsQOPSQMWiJdnxoqcv7LcUR1
 8Vv6g9zLm6UBHZj9AsNMI1SG9n4vsND11HYWn+cxrzLVBtsg+8YSR7mBa+xanOqyiUsJ++T
 iuLb326J3NRWdHN1X9QnGJD7LPHEsuYeUXk5zmMq2rslSRi1EmOKtljoyk0C8LaIqrio2MM
 shAZysaCjy6Z216llp/Aw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:a0W/ES+goc8=:+gVpupWmIAQGsnc2ggft1F
 kI2xrWJ0eYA1m/adRiis3Y4k3XP3SfotFhGn2n17vZfi8i8ZIn2F9GvmroGlXPnk7/K/tMtsk
 LwykjQ2z+q3zio0DARz1SuG7jteJZtZIS2MozqfeU/NN+52dNibrZQhT32PipvS1CHNw4uZn9
 dj53qPYrIIgeLNdrhUpfYwSGdUAgnBdcyUzGbX+DiMvuebv2gFn+AodSiAqlc0o8izbunfQ6S
 QDMVzS87GGyErEvE0WdrccjuGZlYGVbCQCLQXwOZ07JcROmrlfLUxr+yUT/f3EuaKjIc9UHIt
 HPQa26rsFs0bTGUAaVNOOcFymkGrZoHlD/ifttYpbZoWeO/4xiGs2oHo7fTMzCvPDVr4mq7YE
 V+BQLTPgheUzh5QpfXnV/6Ib0kwx4uHBmE2l0oQQJmUYGHsEzfPfQViiQ6sIsG/auIvs6auX4
 Fw0a9n/cZmTCONHPfGx46YMWDfAb6YqpRMEURcHKlASvK/TzXVucURzui+7qBNSj2tVQxqgda
 zmK0/hQZBgp7TFeZpKzQrEC7ZWBi3hncaZD0tNhJ5OX1rYZmCMRXPVteOUzSRgZTW10fUq7h2
 791cNMKh98hlzWCHpzRlwmxdHbJ9/a0fRNbl2OZJ7Y0etCSMtZJdjLinwBa8/Jx8/8kNJhDys
 IhYA4rcZEEhY/KpKdCep3I8+5ubOhLu+ykJkJmnLtSN02/GJrnrgyduc6QiirebGbOmmmHKNU
 fTvc/uaHihKEy3Z+BWZHlm60UvF0C2v42MNv4TxacMWCuCNbH1qSYiWzQPxBvFgAKoQmFaNPd
 NPfKnsxXER3ugi4tZwBcWlL7x2eK4QjQd9QTE6lY/Up9h7Fe6Q=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Wed, 31 Jan 2018 22:20:56 +0100

Omit an extra message for a memory allocation failure in this function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/iio/accel/hid-sensor-accel-3d.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/accel/hid-sensor-accel-3d.c b/drivers/iio/accel/hid-sensor-accel-3d.c
index c066a3bdbff7..3d0acde40285 100644
--- a/drivers/iio/accel/hid-sensor-accel-3d.c
+++ b/drivers/iio/accel/hid-sensor-accel-3d.c
@@ -383,11 +383,9 @@ static int hid_accel_3d_probe(struct platform_device *pdev)
 		return ret;
 	}
 	indio_dev->channels = kmemdup(channel_spec, channel_size, GFP_KERNEL);
-
-	if (!indio_dev->channels) {
-		dev_err(&pdev->dev, "failed to duplicate channels\n");
+	if (!indio_dev->channels)
 		return -ENOMEM;
-	}
+
 	ret = accel_3d_parse_report(pdev, hsdev,
 				(struct iio_chan_spec *)indio_dev->channels,
 				hsdev->usage, accel_state);
-- 
2.16.1
