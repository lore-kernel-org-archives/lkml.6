Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752508AbeBJVav (ORCPT <rfc822;w@1wt.eu>);
        Sat, 10 Feb 2018 16:30:51 -0500
Received: from mout.web.de ([212.227.15.3]:33603 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751115AbeBJVat (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Feb 2018 16:30:49 -0500
To: linux-gpio@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH] gpio-ml-ioh: Delete an error message for a failed memory
 allocation in ioh_gpio_probe()
Message-ID: <0da1b5a4-ccd6-98f6-3546-e466b3f10524@users.sourceforge.net>
Date: Sat, 10 Feb 2018 22:30:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:Yhxv8PhuccgzBZBGJwRtF5O6LsoVw5RsvVO0f/p8/g2EAKiIjrj
 6rz7AJHALQfM9OuPYNY6c9c3n9HugxYRjFiEsjemGOr47qpE/vUQvaXulCabkspa4E2S1Ck
 gg9CbvxlM8h02DFUqUhTnfw2vPe6DZOZDEV0BEFvZe4tFZRLKDiXDEpASbCWQ+thvVkeyxu
 qY42OW1pu5MCWYOd9tHrw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:38CU95PfBRk=:AiCjgfnawIRFXw7SttW+vC
 8bAmMqQYjRiQWDxUXlv7thHr9WIwiV2dp+nZqMoE9lOMFxSBoc2UJ6TwCVOyKFdxPFRRy78ph
 TYxRvj6CHGXBTIfgNgrvUaR215XZt6iH3mMkCAXinUnblGV/1zLH9U7hDsfogRws/ZqQrNqyo
 WKB55RmvoWUUMBQFod3POR5aqhf2MYpJJcYKo1cNZUhlgu3TS5G1SzpC1T5apnTfuBm+KuO3R
 3h6VP+tJE2xUKagAUafzq/JVj/iZmHqiptvQGLnFuU9tIGYWz3xczavuYJpamQi9rPRLYi/Wm
 JSd54vUjW67WxASwSh65iV88eL2mgvicMIP3MvVtbAGaa5mCDOrT492X22qWKhfvn+clfQW6Y
 y0f4Z662UX7L5Bcx1fLMLHhu7EgS0T96RiZhcNyUWj48ZjKkfZFCQLwan+a+Vbv6BU8VZcVif
 jEmF6PAP3MbFIHDeYc7yyOdK3Lwc13GdhyUQQtSB8WcJBbYcO/gCEFJLSSzwJNnJAwrMbeYei
 gblICGMX8pz2hXgkOKH4puVpTrC0O7kvizSichfmxuz+ACahgEjcBDM4nhyAXlbi889xCqrox
 vju2dvOZ2VHYRFc299/etL3kMXGPJqtsgupAvvJOEQhlI5zFll+GPzEw3xBdJ91a8RakRzW3u
 C6cFlPSn+FOrnbMPqI+g2YIZj+fNB+Ju6wb9RFuGGUi9prHFml5IyLq8Ln8SA44Cn3U6t5wc9
 4CfI2kqafcmnw9WVwzoZW92EDFZ81g+rY9029Ilq+Q8D6PV2KJDgYmhkr9JdQmQU6x//LyYMn
 dQD4QKd2nRlggit10cCEw2w6+lFKh7Kj3xm9idZCumNix7C8p0=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 10 Feb 2018 22:27:15 +0100

Omit an extra message for a memory allocation failure in this function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/gpio/gpio-ml-ioh.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpio/gpio-ml-ioh.c b/drivers/gpio/gpio-ml-ioh.c
index 4b80e996d976..b3678bd1c120 100644
--- a/drivers/gpio/gpio-ml-ioh.c
+++ b/drivers/gpio/gpio-ml-ioh.c
@@ -445,7 +445,6 @@ static int ioh_gpio_probe(struct pci_dev *pdev,
 
 	chip_save = kzalloc(sizeof(*chip) * 8, GFP_KERNEL);
 	if (chip_save == NULL) {
-		dev_err(&pdev->dev, "%s : kzalloc failed", __func__);
 		ret = -ENOMEM;
 		goto err_kzalloc;
 	}
-- 
2.16.1
