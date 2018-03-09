Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932199AbeCIQRL (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 11:17:11 -0500
Received: from mout.web.de ([217.72.192.78]:54249 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751120AbeCIQRK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 11:17:10 -0500
Subject: [PATCH v2 07/17] mfd: smsc-ece1099: Improve a size determination in
 smsc_i2c_probe()
From: SF Markus Elfring <elfring@users.sourceforge.net>
To: kernel-janitors@vger.kernel.org, Lee Jones <lee.jones@linaro.org>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <c5d9751e-3ae8-0b66-821a-0e7f45bb8e1c@users.sourceforge.net>
Message-ID: <1d0b572d-ed39-972e-dda6-4019d92e135d@users.sourceforge.net>
Date: Fri, 9 Mar 2018 17:17:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <c5d9751e-3ae8-0b66-821a-0e7f45bb8e1c@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:wJ8vME+ApXp2gTCEgaa8F1W7eiTOuu6G0+4LzRxpOqGIwRZyx1L
 RF9aIv49plW4JU0QGNhyW+X3lA5xyNlqnLA+pWHbtUB8nEgms9Gf3uWcz2acx8W1kp3YZhb
 NJpYDObg6HHZiQeycivqfvKQm8+i8s9n67IorQiWxkU0nVFhRkS8LK1K2BvQBdCPryhE8gA
 oCNuPImuJKsAkagNy1bQQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:BhIMZJjp+mA=:6f9H5kBaCHLj+d+NUqkkH+
 FyyjUZtK9yxtTBJy7RGukVL6fviZYyrbKvMwl/BC76iEfSbLtPXMJCwFC4lmomxfXdwazkJSr
 8QXRmDiF5OiXkwh9AXiRuh60hsMD3j9MR4UUuZYCkzX3Xv3fbgv0FabgCgM9O6/fS5Y23f7s7
 ZbEg6AdmvSntVTqyWkBd8n2BBF+NTMgBFttBDXTiNOJ5hcTmL7+FfN15gcHramPjKCZMCxsvF
 8YSWGjPlPdHU3oQrsitInsf/AZo/wBYFrS59+JV6FQo2O72F0oHUYV/37WzU0YNezJT7mi9ja
 o1pWJ1eIUA01XnVOGudxKdQhWC9tkH4bQgpbo2JNNJn1Bx6JTDmAz467mseqfO9t/WJzt53OX
 plBzqPt6puMj57/7mfSpJiub1DoGK2v5hcVsLFVyamtE8d8KgsnaDCDwXYpYEFKN2mdGtowEQ
 u2SfMcy1mHrxCGxvaJcCgbotZjgOc19BY6IgV30hJO8NaJs3aCarWAoyBd4LQVhSFnlh6HIFa
 9xqnRYLnM2JTQhVVCZaETvzFXgff+j2MeytI5QOn1WGL7W9QdQelELJW4k5HP4GaIxtl8Mmqc
 QLVwqr9GkQyVfByqJt0ay0u15X5GagBLJXUj/7X6onnIJqufLHurgkHNCyCrdtjrKvDZfOGrl
 j+K9LUdUSV0IWjn1So7QXlA3asKDPVUKtRNH9Y0epvxWmeTe1QhCcpaNmNQA7y5/klZErmHMN
 UHRKuxHEDTlAfkMADk2293Hh1Lbg4fEH11P6U3OytDl4So26b6tHNCQ5v6Lgs9zah512B7QEO
 +s20tfKFEYgzyMbsJGXbfWMKBdq4iIWoFIWVOjpHdhsEMEk0Jc=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Thu, 8 Mar 2018 15:05:16 +0100

Replace the specification of a data structure by a pointer dereference
as the parameter for the operator "sizeof" to make the corresponding size
determination a bit safer according to the Linux coding style convention.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---

v2:
Lee Jones requested a different source code layout for this transformation.
The change was rebased on source files from Linux next-20180308.

 drivers/mfd/smsc-ece1099.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/mfd/smsc-ece1099.c b/drivers/mfd/smsc-ece1099.c
index b9d96651cc0d..57b792eb58fd 100644
--- a/drivers/mfd/smsc-ece1099.c
+++ b/drivers/mfd/smsc-ece1099.c
@@ -37,8 +37,7 @@ static int smsc_i2c_probe(struct i2c_client *i2c,
 	int devid, rev, venid_l, venid_h;
 	int ret;
 
-	smsc = devm_kzalloc(&i2c->dev, sizeof(struct smsc),
-				GFP_KERNEL);
+	smsc = devm_kzalloc(&i2c->dev, sizeof(*smsc), GFP_KERNEL);
 	if (!smsc)
 		return -ENOMEM;
 
-- 
2.16.2
