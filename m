Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031266AbeBNPZb (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 10:25:31 -0500
Received: from mout.web.de ([212.227.15.4]:37563 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1031151AbeBNPZ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 10:25:29 -0500
Subject: [PATCH 1/2] crypto: omap: Delete an error message for a failed memory
 allocation in three functions
From: SF Markus Elfring <elfring@users.sourceforge.net>
To: linux-crypto@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Joel Fernandes <joelf@ti.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
References: <28780631-d093-a581-8690-3868f8fa327e@users.sourceforge.net>
Message-ID: <d6a0efa2-3056-de6f-269f-ddf5cdee62fb@users.sourceforge.net>
Date: Wed, 14 Feb 2018 16:25:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <28780631-d093-a581-8690-3868f8fa327e@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:vPCs1rqYcZ9CIu1RuGywYm5yC740k1Y503TqYYplQzyWryQJd8q
 PE+36qPhL8t2jYXTM6tUJU/MPzoIEl5ApCEwZd9QBaxyaYD6I3Kt9QrgdPa1LZkC1+hGDwS
 TnhOkMA9Qi2d1W8KYpl2O+bbRCMzD+x6pmPlFAG7nk6vCEeCA2VsIUfJNktEcf2xjbmxrrm
 88AVTiEGGTBGTRD0Ajn+w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:W0nSakxUyI8=:jsAmPSMzZKIam5pASLeAQE
 2r58d6g8/q2flQKjgXzdcweA35cLZ+UxyB3j3weCUmT1dnL5RThjJ641OCr4sRZSWytdUclz4
 G5NG11XfgFVNsE+gNMR8w/p7Ut1hIk4OsjoN+kXyNvUOks6f+OWb9JG0x88Sjdhfm8BOUf8th
 EKpHlNM0uuygqQ2xAS2v6qA60Yntg3zS2F8xWcpbEk0umGexgwGZ7hpOXvCr9eZV8Fma8gn4y
 Zuu/ylIuwXAVKjubhRJtjs9InGJnK/EjQKzcXBMvBBo+qqRKJQSc42xtl998sq4qvPvVOSoW0
 DEqBJVWwOalB5JpPuHV8dbJ0ctLLYVSa4S3gUjQbQ6K6etMpIw0lyocxcFup6yt1PJfFMhqBc
 ndLQYnggHK0BW8wO3GitbQKcL188HU5UHitfokGtynx9okSlCOTKd2vz8Q3EIyzTJvG9zFa/n
 0wnYBnuEsxsl/j5/LgRmKBEV7hfBN/wPWlP/BrQnxJffkmMkSM1hoTDWDPQb+rtYYSvU4r3Jv
 6VPDEswOPUPYbduo2eJ6/KxwGy0tKlfzHcQdri2w1ghSjQqEIdiisBcc7gofmNFs/Ded2eAz5
 sl4KsqRFqdx2pjxIsK6jhMo5vK58Tk3QS2NkZIU4OO4dccfW+8xNQZnZjfMhzKTo6NCBvhUPb
 w35zZ4Ws6shzRHnOXgeL0VoMitpJWyNY0DqyEjjO5ClYGjlTPTkoSIEoHm29fywc/N7m4Py43
 xehr8C0cSiKhh7qxKQ+6YXmDHkbT7/pNgVV4FLP+hSnce+MS2aAEW+412eLvFAwHMgy4KhKjR
 ruWfiL4urpwz0C7NxWrApWuUyHU9KpA+U13h1tIK0T3BGUauh0=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Wed, 14 Feb 2018 16:00:33 +0100

Omit an extra message for a memory allocation failure in these functions.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/crypto/omap-aes.c  | 5 ++---
 drivers/crypto/omap-des.c  | 5 ++---
 drivers/crypto/omap-sham.c | 1 -
 3 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/crypto/omap-aes.c b/drivers/crypto/omap-aes.c
index fbec0a2e76dd..a2bac3b869b6 100644
--- a/drivers/crypto/omap-aes.c
+++ b/drivers/crypto/omap-aes.c
@@ -1040,10 +1040,9 @@ static int omap_aes_probe(struct platform_device *pdev)
 	u32 reg;
 
 	dd = devm_kzalloc(dev, sizeof(struct omap_aes_dev), GFP_KERNEL);
-	if (dd == NULL) {
-		dev_err(dev, "unable to alloc data struct.\n");
+	if (!dd)
 		goto err_data;
-	}
+
 	dd->dev = dev;
 	platform_set_drvdata(pdev, dd);
 
diff --git a/drivers/crypto/omap-des.c b/drivers/crypto/omap-des.c
index ebc5c0f11f03..f4199be783a9 100644
--- a/drivers/crypto/omap-des.c
+++ b/drivers/crypto/omap-des.c
@@ -964,10 +964,9 @@ static int omap_des_probe(struct platform_device *pdev)
 	u32 reg;
 
 	dd = devm_kzalloc(dev, sizeof(struct omap_des_dev), GFP_KERNEL);
-	if (dd == NULL) {
-		dev_err(dev, "unable to alloc data struct.\n");
+	if (!dd)
 		goto err_data;
-	}
+
 	dd->dev = dev;
 	platform_set_drvdata(pdev, dd);
 
diff --git a/drivers/crypto/omap-sham.c b/drivers/crypto/omap-sham.c
index 86b89ace836f..7aa4eb50ebc9 100644
--- a/drivers/crypto/omap-sham.c
+++ b/drivers/crypto/omap-sham.c
@@ -2024,7 +2024,6 @@ static int omap_sham_probe(struct platform_device *pdev)
 
 	dd = devm_kzalloc(dev, sizeof(struct omap_sham_dev), GFP_KERNEL);
 	if (dd == NULL) {
-		dev_err(dev, "unable to alloc data struct.\n");
 		err = -ENOMEM;
 		goto data_err;
 	}
-- 
2.16.1
