Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752555AbeBJVIi (ORCPT <rfc822;w@1wt.eu>);
        Sat, 10 Feb 2018 16:08:38 -0500
Received: from mout.web.de ([212.227.15.14]:44563 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752498AbeBJVIg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Feb 2018 16:08:36 -0500
Subject: [PATCH 2/2] gpio: omap: Improve a size determination in
 omap_gpio_probe()
From: SF Markus Elfring <elfring@users.sourceforge.net>
To: linux-gpio@vger.kernel.org, linux-omap@vger.kernel.org,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Kevin Hilman <khilman@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Santosh Shilimkar <ssantosh@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
References: <8ec31664-badc-5454-b759-ae9132833589@users.sourceforge.net>
Message-ID: <422a4c63-5ffc-2b40-4d9a-cf947d4af2fd@users.sourceforge.net>
Date: Sat, 10 Feb 2018 22:08:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <8ec31664-badc-5454-b759-ae9132833589@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:ax4hthMaPQTzzjdJou8ZCtM1v1qqVKmYBRdn7poY8ecLVn4oXwE
 RzJDt3eGB0/TbHZpYlC6ICoo2V1pwJfQqvOBCHOOF88jpnSYuqA3GW8p0h0w6EIDPj+2cR5
 qO3oDJGT91ahF3kf/mC5kGzrZmBs1pC34I4qxgl92VPqUZTt+nTKcF2smJO4nQ8jFTBNIzf
 ZpvS8zP5ctY3WQK6rip5A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:isfcWtWLal4=:mJcD+M+uo9B21pe0i3empd
 yu4Di+vgnxwDrc8fiy0rpkRkQsmiYl1PU6xOs5FZE5BIy7yxtXfoaSzsNaQlNuaLlS4WhBjxg
 elJgx9WP/+7/AnPnF4qAX710l1/n2Qv2yrpAWxo48W2Ug1z0iyvU2iscKOqQfserMPw8OJ0pb
 q6ASarIjK7uB7nM8LccrcQrCl7EEMOi6zee7t6a/pSkqljJ1XEpGF5pVtNPoD84jmCmOCZHZ0
 8ZpKkhDKBsh4dN5rVMrSFBgGzh0fh3KRZIHAopkPIKmo3qwhiBD6c3Y3bs3eQgk91NGyHQZq7
 d7NWZLG9RxBd+yxtm4Qp5CSMkW+lecmPBs2DLItSvQGX/5D0fvBbnAMudKaydP7B1GJGrst4Y
 J4hmfO5IhCMMMYvI53gpr9W2HYeAZQnvTeCsbyhC7tH8vl+Et9urhV0rZKThivK3lk3Ssqfe0
 LG9JutDa5RHQf+3w58ykGsk+2fsaNViDdFOI3M/x6vy0jYToEQIROU7CgTwDQVd7RLnAY1OBJ
 IzXk3+8Ju7TVlqULSKdNMQdf/xlFrcuU1IP6ljUsiI71fcE8JYA3ArBaYGh6TT/QhbqAgE6c4
 8zfWw+HKSeo8vLI2mlBAWJQhgYMbJtLOWVD5CI7O2QtziJ48CNc0cEYB/tQxeDsuY5cyHXDc3
 w/BWQDdDj9H/WfKM+JSJVTKhFlOZybVjb1lO25pqllKjd9MDu/eeMgYe0wuT8NotTXZWrr1AW
 h5ut5sBr9tX+jWV6QkkttwC0pj3mw1ZLn+CowtPNQx+EJi3StVLLuwD2tUyZZhCSD4SH7DscW
 7CQDSve+bG1DY2TSa8tr+KlA4AP+QKeDny5ezEuoZOFJjgc/jY=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 10 Feb 2018 21:49:22 +0100

Replace the specification of a data structure by a pointer dereference
as the parameter for the operator "sizeof" to make the corresponding size
determination a bit safer according to the Linux coding style convention.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/gpio/gpio-omap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index 4db6f13fa133..35971a341c40 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -1157,7 +1157,7 @@ static int omap_gpio_probe(struct platform_device *pdev)
 	if (!pdata)
 		return -EINVAL;
 
-	bank = devm_kzalloc(dev, sizeof(struct gpio_bank), GFP_KERNEL);
+	bank = devm_kzalloc(dev, sizeof(*bank), GFP_KERNEL);
 	if (!bank)
 		return -ENOMEM;
 
-- 
2.16.1
