Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752529AbeAaUWH (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 15:22:07 -0500
Received: from mout.web.de ([212.227.15.4]:58583 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751988AbeAaUWE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 15:22:04 -0500
To: linux-iio@vger.kernel.org, linux-input@vger.kernel.org,
        Archana Patni <archana.patni@linux.intel.com>,
        Hartmut Knaack <knaack.h@gmx.de>, Jiri Kosina <jikos@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH] iio/light: Delete an error message for a failed memory
 allocation in two functions
Message-ID: <377187b2-abb5-b693-2e95-8674748854c1@users.sourceforge.net>
Date: Wed, 31 Jan 2018 21:21:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:XT1DOLCZ43NqWwyzCawLuADPZwWwmQeBid2ol/UH3pkFo4k0q8s
 aAf46csaLuK13ltyu0GV6Y/jYYwYTSWbbDpIPH5aL8kct+IrqwV2L5irhUPqrjy4oqODoTb
 kZzFq1zUPUIO6SXpGyM+sh4nkxP0WOG0IBTSt/bL3N2EI0biUJSkHEHcndalC8vkGFvuC7d
 dgrJ1p2ANuZOJQtBJU5Rg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:nKPknm9Fi4Y=:haMqt9zgX4l+5P/6RpzDeu
 IxcEAJk7p+IBvkfnitccIo6yWezbNgZPyfLT9LMIGqZrLpkFmQwHZmYama9QJs4F4jg+SoCgz
 FiyBCPoj75v/RCItkCDP6BJhaVCcCdIBP9dMEyk9E/+k7bO/Kn72/Nmm7rJv3cOdpv25ku0JO
 MFdMguRrUT1LPOTy8mEOXM/Rd1xD5dsFCarqWMCc+w3I6zVJF4fFVR6y75kPijnbcHsxfDJNZ
 yafLJ5LEoN/pR2FdGC/ckDYzs7UIZMAQMbmv1Jmlprgg3lSiLkWgDq9TNCw4Iukgci90sSNqn
 gcR8VJpk4APBdDwGum0BGG1/zjm2Irs/WmJCiDJpCIDboXUhhhfEVhcxNk0yMXe3kLzjSZD3Q
 1cnAxoQ4RgK/0DN+1AMZq/t3jw4lXmCDmV3VyRYPjGaitW8lA1tnCZysE0A41DNel6FcdD2me
 t+n1KZhlFsd9aCnhThWVY1mvBjNTy2WkjKEvEURMzpLxP6iP78GMHHyBLyKwp+294pnxZcBI0
 fl/Komo9ZUtDNG/3lvHT0QPWSkUq9+Umi6MjRDzxJENE4OhwJP3fnMhYxBDLrFeXP/dRQEFYl
 9Tz/CuA4v9R6l4uaLqp4zMcg+ia4buAThZeGfXtVLt4HEJEuBhmMtj0sPWMBiPv8IoOKEsLHA
 56BVqMkYuzFo8qEPBL8icRWI+2SSIOpXaBqa/vmu7R8Rx3995x/BTYSY2nJH3qCBsxM9IIowk
 SwPyK0J3Bpuvzu9LOsSTIvJ7wAaedvmkBXoZjJaVUfKT/0RP1+mHauNpzZ+2+37jIddVOa4uJ
 e4aqSxKxUxFdMKfG0aDzkZK2k9kKoKll/+M5RJ2alsMpXGNf9c=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Wed, 31 Jan 2018 21:12:09 +0100

Omit an extra message for a memory allocation failure in these functions.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/iio/light/hid-sensor-als.c  | 4 +---
 drivers/iio/light/hid-sensor-prox.c | 4 +---
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/light/hid-sensor-als.c b/drivers/iio/light/hid-sensor-als.c
index befd693a4a31..83654156d952 100644
--- a/drivers/iio/light/hid-sensor-als.c
+++ b/drivers/iio/light/hid-sensor-als.c
@@ -299,10 +299,8 @@ static int hid_als_probe(struct platform_device *pdev)
 
 	indio_dev->channels = kmemdup(als_channels,
 				      sizeof(als_channels), GFP_KERNEL);
-	if (!indio_dev->channels) {
-		dev_err(&pdev->dev, "failed to duplicate channels\n");
+	if (!indio_dev->channels)
 		return -ENOMEM;
-	}
 
 	ret = als_parse_report(pdev, hsdev,
 			       (struct iio_chan_spec *)indio_dev->channels,
diff --git a/drivers/iio/light/hid-sensor-prox.c b/drivers/iio/light/hid-sensor-prox.c
index 45107f7537b5..f4487620e08b 100644
--- a/drivers/iio/light/hid-sensor-prox.c
+++ b/drivers/iio/light/hid-sensor-prox.c
@@ -277,10 +277,8 @@ static int hid_prox_probe(struct platform_device *pdev)
 
 	indio_dev->channels = kmemdup(prox_channels, sizeof(prox_channels),
 				      GFP_KERNEL);
-	if (!indio_dev->channels) {
-		dev_err(&pdev->dev, "failed to duplicate channels\n");
+	if (!indio_dev->channels)
 		return -ENOMEM;
-	}
 
 	ret = prox_parse_report(pdev, hsdev,
 				(struct iio_chan_spec *)indio_dev->channels,
-- 
2.16.1
