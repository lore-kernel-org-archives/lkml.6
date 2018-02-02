Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752203AbeBBPks (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 10:40:48 -0500
Received: from mout.web.de ([212.227.15.4]:63454 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751569AbeBBPke (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 10:40:34 -0500
Subject: [PATCH 2/2] i2c-nomadik: Improve a size determination in
 nmk_i2c_probe()
From: SF Markus Elfring <elfring@users.sourceforge.net>
To: linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Wolfram Sang <wsa@the-dreams.de>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
References: <97f41346-6abb-1c14-f536-ad12bbcb4c60@users.sourceforge.net>
Message-ID: <bca34c12-2139-586d-1e7b-87827dce7c58@users.sourceforge.net>
Date: Fri, 2 Feb 2018 16:40:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <97f41346-6abb-1c14-f536-ad12bbcb4c60@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:YyIlpzs0C6ZKp9YaS9+pr3tGNMOKDIhj50srxdbvfHZMgFHy9zz
 CKYEZ0UOk5FrAlqhV3AEYOmZG/pPUTVMVafAsAtTagiw9Dy8cUxfAqXxOLiRWzrA8OxjKsy
 bflRwRQIAOFSz//hVBGvXNDiDVTj2lshzMaFD8sgsc1XgMLcYolXdB5RRfEwzTDsZmvI7CW
 qWK67z9mxZoYUGbIsHFDA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:WFP1EF0tjgE=:WKJV5PdW3OAXTyRGiXIq+1
 cbMoJrHZrk3JxByTbY8ohb8rD674oKTpphhMtpEQyHIvITKQJrRWhsEUMLA3O8oJDoAuSeux0
 ToR6mT6xDPAtFZyzFO9faNulVulNLLK1Wrvc2GoeSMrhB8lGZ0CKWKdaHHrbzFxNCEQDHwAPb
 oqCWKEh5vExgx+CRN3tuB18WAvRZsiWQvgUEG15LRo8Uk2ujBZFtufM34HaA9/jodBJ/Pep7p
 gtxlsruB/N+nKdQK+qj25e5YMVZF3tT8DONzMAlpUXsw6LAAxOV7y9TMaZeDzPdbTUkQnnOKl
 NIRVmpZzCk+81nUBVQVWY2mbiF7yib4biEoLtGDc6DpWWDY3cSxfzgItbuEO+pvAcsxXG7qni
 bOjL7NipuGavN9dt2t/DRmt0L03JyToIJ1DSOHmzMY/VZqUqwwDOtBurGP/HSurSKElqJsaP9
 DZpPIzZFDWhM/4KWMYWkKCZm0l+qhqddz3o8dueLmtd+EaIrkVPqXrk9xMrJGoYRCBlm+KBUA
 GyjLZktXqkk6lK5pY1rCOxHullS6qoKwE6HQ9R9kYluIE58BkhZMmcTlTzhnKFxR+IkHOF88D
 wEcF5AWWaQu7Xz2k10R7y2JeTwf6AbYw6zKag7dS+HI6J9WkdyqT7ihzd50+RuOa8s51r9mrH
 11WozojIcl+cfrlSprIjPVrkyh2/pd88ywU3BAIMukzCshQYr4ItcjIvBD1RKxgEGUyqlnLZM
 fZ5aWKL1ECT+81t2ApYx04NuvVGIx31vvHq9/vR0S0EvO7oHWFRAHE1RTinGNbkpTavYjcPXK
 TWosvWdos6/AT3OhQyvIN+FRT+748BWd4WVJLpbWXyb7VxP2HA=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 2 Feb 2018 16:28:20 +0100

Replace the specification of a data structure by a pointer dereference
as the parameter for the operator "sizeof" to make the corresponding size
determination a bit safer according to the Linux coding style convention.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/i2c/busses/i2c-nomadik.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-nomadik.c b/drivers/i2c/busses/i2c-nomadik.c
index a783ad25fe19..e353b528140e 100644
--- a/drivers/i2c/busses/i2c-nomadik.c
+++ b/drivers/i2c/busses/i2c-nomadik.c
@@ -973,7 +973,7 @@ static int nmk_i2c_probe(struct amba_device *adev, const struct amba_id *id)
 	struct i2c_vendor_data *vendor = id->data;
 	u32 max_fifo_threshold = (vendor->fifodepth / 2) - 1;
 
-	dev = devm_kzalloc(&adev->dev, sizeof(struct nmk_i2c_dev), GFP_KERNEL);
+	dev = devm_kzalloc(&adev->dev, sizeof(*dev), GFP_KERNEL);
 	if (!dev) {
 		ret = -ENOMEM;
 		goto err_no_mem;
-- 
2.16.1
