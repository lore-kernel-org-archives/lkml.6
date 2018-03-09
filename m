Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932210AbeCIQmZ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 11:42:25 -0500
Received: from mout.web.de ([212.227.17.12]:58753 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751170AbeCIQmY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 11:42:24 -0500
Subject: [PATCH v2 14/17 4/4] mfd: tps65910: Move an assignment in
 tps65910_sleepinit()
From: SF Markus Elfring <elfring@users.sourceforge.net>
To: Lee Jones <lee.jones@linaro.org>, Tony Lindgren <tony@atomide.com>,
        linux-omap@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
References: <c5d9751e-3ae8-0b66-821a-0e7f45bb8e1c@users.sourceforge.net>
 <a00bda19-c38c-6733-31e7-7e1c44eb6c6b@users.sourceforge.net>
Message-ID: <eb3c38d5-23c3-dcf0-3772-66b917326f0a@users.sourceforge.net>
Date: Fri, 9 Mar 2018 17:42:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <a00bda19-c38c-6733-31e7-7e1c44eb6c6b@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:hp5qPf1tXnUxloUeYWxv3YfOw1HvrjnjM0B/37Wn3qW3soEgud1
 xor052mD7wFPrsPs/CX6aVWoXoo/MoFovDq/FauI3ZEbAJosc+K7Er2xJqd/Y3Pwqb/Kviz
 rf8UfBgLxq4ud+l83uZ6Qb23rufkMagnYi+H0U11wUV2DCn882JOZDhkHYi2uRE/bQIRqOy
 Og16k/3qex6CUNRFq9g+A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:MpSWZYmhxTo=:x3YXWBpfunRG/PKsxWB3eF
 cU1hJ6c8nDSX1TBsaYqJqeWv8c68KYAxu43Cn4iVKb0DzI+J6C/iEpvuiyYrH/za2WcfFK+G/
 L6SyWDq4OdKRN9IhhOiLSyApn+7FR6vLuvgOCmXh8Nxhu3bXHeoiXZ2RWFHVEipDSTySa4468
 KL/dnmv4x7/dji+oU0jDc90lV+I9RQ6dXEsXmBLHw0/uE00VlDktsGV2M2CE9/ISrA5jL8zFP
 XwfFh6oM9w94BEbPvxnTS3krsQPPEgVjqsHNw2O2rFM4S9t0Wic0p8e4DHzZP3ZUtqHiLgH4I
 sDvLBYe8LvYEq4mo4griHvnaKjrDR/UknA4jIcPrW2NeNdLGMUQeybMeOj4vmge8YsC37ni6q
 0dmrkSDSiHnoCyozA1aCkWqyXLm7IyuFhImi4pXm11Dhwzb/M5w+DVvqsWrGPNPslLyUcSwaP
 7K0K3k26sZfYd9u/Vh5pcBfMBVuf6pFHb6IGmwOTqJAIhS0tjZnMJTsm2CTjki5S7sqmpUNP3
 b9J0GyIx91wqG0kr/QuWFLs9ssp/97EbTZd4NZKhAz0sH34Phnnjmg2s124NNYj0z4B1vEhN6
 D8x1MZ7Qgy19MEu6cFSZ+lgZWYbr/zZ7slCWlYNzIQGSicLiiiEnJ5oAHTw7gboFYJBsu2h/x
 rgC2GuKN3dXlswgLtZU1SzknXpCM2i1OLYjLTjT328WkqrZJk5y0VL8d+ty0ktSSgZOYa4+H0
 Ypg7y54444Hb9n72VUODHaAOn618Gi1Le14E6JQrvrOY/3h1NN7Oawcftyllnrae17SCLaMIi
 HqYdT3JVXBcc6f5QfZG2Rbv4RtrpmwDUQTMmo2e3MPZkg5OPuk=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 9 Mar 2018 09:19:42 +0100

Move the assignment for the local variable "dev" so that its setting
will be performed after a configuration check by this function.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---

v2:
Lee Jones requested a resend for this patch. The change was rebased
on source files from Linux next-20180308.

 drivers/mfd/tps65910.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/tps65910.c b/drivers/mfd/tps65910.c
index 7e7d3d1642c6..bf16cbe6fd88 100644
--- a/drivers/mfd/tps65910.c
+++ b/drivers/mfd/tps65910.c
@@ -315,11 +315,11 @@ static int tps65910_sleepinit(struct tps65910 *tps65910,
 	struct device *dev;
 	int ret;
 
-	dev = tps65910->dev;
-
 	if (!pmic_pdata->en_dev_slp)
 		return 0;
 
+	dev = tps65910->dev;
+
 	/* enabling SLEEP device state */
 	ret = tps65910_reg_set_bits(tps65910, TPS65910_DEVCTRL,
 				DEVCTRL_DEV_SLP_MASK);
-- 
2.16.2
