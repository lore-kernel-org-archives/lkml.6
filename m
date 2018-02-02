Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752266AbeBBSNc (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 13:13:32 -0500
Received: from mout.web.de ([212.227.15.4]:52066 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753924AbeBBSNW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 13:13:22 -0500
Subject: [PATCH 2/2] i2c-bfin-twi: Improve a size determination in
 i2c_bfin_twi_probe()
From: SF Markus Elfring <elfring@users.sourceforge.net>
To: linux-i2c@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
References: <740e31b4-79dd-a4bf-a2f5-001c44864b79@users.sourceforge.net>
Message-ID: <3a856fe7-5217-adcb-1da9-192a578b0422@users.sourceforge.net>
Date: Fri, 2 Feb 2018 19:13:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <740e31b4-79dd-a4bf-a2f5-001c44864b79@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:A9x5WXjtAFktOdvatmvV9aae4Koopm1jcCHiHou+PghlTh+rHRl
 VC0/PtOCP1ld64Z3BFv2SIEB02JcjEBoF9uRnQTAvos77shQRHlwaTLnddj0dEBww+2xhuX
 mmozjy3a9cpfg7/HqluI3PEfP5/HNnK3u43Kkfjhhp8r8cg4TWLkYbXkcSoHs6+qUSU5/3v
 +5JiBS6YuBO6Nxqp0vnXw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:y2FUkeYUUms=:s+QwgsRJEhAqrnrTTXUHdW
 /txlYeigOv7Zn8KnoZ+DS+nZ1KR5+cx0nhOjo6NwSh+NSQu0PcvPF7K0Qj35Z5h/lahR8wBME
 3ABC4AWKCpToeQ26aVu2PhqUg8cMRi0LCNEX5hNaq+v66JWOhdon4x3rwLo0QpEe1EtmD1kdl
 Z6iZXUENk2EogVtkZ5wgDVOPkGa34/TOgsPKmnfWCt+RnN6tdKi+QxeryJa/ZMrY7mH3Xdx8N
 5PRet1+sij3wy1EKQJcaNlcdemen8SjnBFYnQl+rsPPrQ35f+NqPgn/ogv875xfacmhzUASNq
 CoCLx5F+DMpiRFG61EJ78xu9n+H41kgxClhVXq1jXLBoZE3FhFUblX9xT3KKrGmfTGVTWzGFS
 c5exeyRLOvnHWA6S5GkiZ6YZuK7gK3kMddmH8OOXX3qVQVyoDJc01TIf9ikQP16KSHbtwjo8N
 GGarJkY81Zc5dTsXg0SEZgxXrMd++a9wTHHHEEvzjzUoxhwdaHefQdGSTKyGmGHq3QcR6ciJI
 52P6QcHSeresos1E6S2FZ3jx5wO+WZjVl+9ooxWQ9QiPkYFWmEjDaQKEFEKBSn7aU1QTW3YoH
 GYzhKCpGgjPobzxREZPQT1ooxrUv76DfTDlJdcafHMmM70DQTS6kKvr2oO6bWMOqIBoKYoU6u
 62bJlr8iwhyG5lz6xGIhO/oEpq4EmKNURT934rtyMYXqCxatllbdf6g+FcbPX8g+HLlFoXIzb
 IbSYxmS7kZXB5mrHl2iUnG3XwuzXdgUBhbZdYjTyBdcVz1NcsbHMEvIEKrs/g8dwEk84WSaaW
 qZhfwvCJoak1SynTcqRrSvKajZSun4iv/6VmoUz2FXh7UshFDM=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 2 Feb 2018 19:01:14 +0100

Replace the specification of a data structure by a pointer dereference
as the parameter for the operator "sizeof" to make the corresponding size
determination a bit safer according to the Linux coding style convention.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/i2c/busses/i2c-bfin-twi.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-bfin-twi.c b/drivers/i2c/busses/i2c-bfin-twi.c
index ed596fd56b8b..f57e3247f717 100644
--- a/drivers/i2c/busses/i2c-bfin-twi.c
+++ b/drivers/i2c/busses/i2c-bfin-twi.c
@@ -619,8 +619,7 @@ static int i2c_bfin_twi_probe(struct platform_device *pdev)
 	int rc;
 	unsigned int clkhilow;
 
-	iface = devm_kzalloc(&pdev->dev, sizeof(struct bfin_twi_iface),
-			GFP_KERNEL);
+	iface = devm_kzalloc(&pdev->dev, sizeof(*iface), GFP_KERNEL);
 	if (!iface)
 		return -ENOMEM;
 
-- 
2.16.1
