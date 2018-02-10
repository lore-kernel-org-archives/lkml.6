Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752464AbeBJUd4 (ORCPT <rfc822;w@1wt.eu>);
        Sat, 10 Feb 2018 15:33:56 -0500
Received: from mout.web.de ([212.227.15.4]:51725 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752222AbeBJUdy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Feb 2018 15:33:54 -0500
Subject: [PATCH 2/2] gpio: timberdale: Improve a size determination in
 timbgpio_probe()
From: SF Markus Elfring <elfring@users.sourceforge.net>
To: linux-gpio@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
References: <da77f86c-a366-0a0f-10fd-9b7cfd879391@users.sourceforge.net>
Message-ID: <df13123f-5c90-03e0-edb6-0ab9751b7aa2@users.sourceforge.net>
Date: Sat, 10 Feb 2018 21:33:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <da77f86c-a366-0a0f-10fd-9b7cfd879391@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:om60do2Q1c8cEsndG4HZxxdUmHm2RzoOeZKia50L+M2SFX6ZtIP
 7K+DgTMwSCgmFccURP4hojz/Me/s0LTiR0IFpoX3IZN7gssRK3quzfnxYlCBuXj2s0GSO8L
 XnHRRz+nWWrMHgMClZDRbqrbrA/pjGpoyRoQdE3fDJsofseJO92SEyj3vdf1pINKTdSW0Jv
 F/YFiH66U0hoaPkWe8+9w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:LOMqgAI+Mgo=:4ZIgvlYeaps1MZ+zS8rSVf
 eGaRTJiWJUOaUU5UCtY0zBzKaVWKwK+us3e5JXW1vPLMEfYO74OpdEps0fBoi4DwVXZqdiWuD
 aPb0mMx0AdjETvUNi2QVXMx9u/ipOQYarinB+C98U1UOeixb7a1EgYrUxu9mDCFcUc2FS91OM
 hYFoF7SqJODFieQgDzrUGy28ts+EOUOEvutTUJyOEdMnf7131+1yla62XpAFbjJOLRoZQfmBh
 3lvpMFQtxsbEmNVeqDoU6NToTpnSp2cJ2KGfTRdmoLVIEVxJq+QNAI5jKQQVDS5aN9qbleREL
 Q1QnsUKND0Nmu/Pg3dN2E3UIBg3VG2LFqc73tUyJbiX708JILUv+QYQf7Sm7q9UCqRcvLycx2
 JaCciJsRVahfdqH7J+VJ7Lvu19R+2PBI+H8ybqBAthk6f6PaTtaJXwCIpZ86QAfkwQlJ6V9XV
 vytqyYnMlSjwx/nDBYC/37tHjkVW4R4v2LZmgmAh/RY2NYuPwfWySO/fMkzbmTzNbYqXxfKyc
 1QHrw5L8oe2+B/1oCyvEPfKXur0Ru79VDtClUAB09oRKSkZYhe40jZlcsDbSXIZ49oYavD44q
 8k1ZGa1csdqIUW7YYhV4FMpkujd+U42z+W3tcSIYXgCwnD4gpxcfYf14i+RQMQ/1ac1RmNl2+
 cgihOsLtV/ijy+gWnPt0ifSbn8JJ2WyxWeYBfCtciKbV1VDvWjec6AvHOauFhecgmCYkxk08c
 NJdt7FCXv9NsiGKXLcIbyapbFC1+6IKzMpdWfxgzyvKJq6U6OJyzGxkZmIWC5F92uUnjE8Jb9
 PgwcyzhiSuDnboexdBOM0kemii+1kCFB5U5cDl0q8nRbFKOo7Y=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 10 Feb 2018 21:13:28 +0100

Replace the specification of a data structure by a pointer dereference
as the parameter for the operator "sizeof" to make the corresponding size
determination a bit safer according to the Linux coding style convention.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/gpio/gpio-timberdale.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-timberdale.c b/drivers/gpio/gpio-timberdale.c
index ff155e437210..6520a8475910 100644
--- a/drivers/gpio/gpio-timberdale.c
+++ b/drivers/gpio/gpio-timberdale.c
@@ -238,7 +238,7 @@ static int timbgpio_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	tgpio = devm_kzalloc(dev, sizeof(struct timbgpio), GFP_KERNEL);
+	tgpio = devm_kzalloc(dev, sizeof(*tgpio), GFP_KERNEL);
 	if (!tgpio)
 		return -EINVAL;
 
-- 
2.16.1
