Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1426311AbeBOQk7 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 11:40:59 -0500
Received: from mout.web.de ([212.227.17.11]:47139 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1423484AbeBOQkz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 11:40:55 -0500
To: linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Krzysztof Kozlowski <krzk@kernel.org>, Kukjin Kim <kgene@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>
From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH] cpufreq: s3c24xx: Delete an error message for a failed memory
 allocation in two functions
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
Message-ID: <201722ce-019d-a5b4-fc00-74679d82b64f@users.sourceforge.net>
Date: Thu, 15 Feb 2018 17:40:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:nohtQDWarD1ZUwY/h8OEhg1mWvVDMRyO1VTS+GAU56foLJZii4D
 vY/uHRXJkPYHbLO2Rtbn6ijBNdzM/8rZCm1a3vPzF1Ok+/PSxI8DEYSlKea/GnVG2pv+BxT
 ZxU2WU8GHBHj0EFz02Hcngk6XPBGmr5DuKRgSYKDl7XDtDYEmv6U4zU9Zrz00aytnlAHq+M
 6XMlTOHUPEatgtkPqtTTw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:uKRLPDQ8utg=:SfQbeG9zbK/jpF+6biEjzI
 aOlOmcwiHf8SzFXvt8/b0t//Xqbc+UqvF4pEv3eAXslHG7S0Fhd4HHD5ZEXZ6LWF+2vyL3GsJ
 27xNf9eEXb7s+jplFWz8psLf2oBNnGqks/OFlFdJZIFhcSsv+t9B9eF4B/YSU0+ioF3vllmYN
 e2Mabis8nqDITFRtjGIsEDO6nk7EUVLkellZInjybjWmMOF+anj6NJVjjpRmQulx+YjNg0hfa
 hxSjeq7g5vxz3wkRx8nQWu131yj4TDsezZAo5aYiCXEpHeeThrQ5BlsqXDpbs+zpkul/JmxbI
 A0H92UJKCIA4/KkWqzovRriAiMF4bJxxAsm8DfgwWprdYLd6RA83St3naxFNJyRzS9s4Ebv1t
 49vyGrLlA1rAQqnAYa4/JjdvfkU+kfKGxjyYQrhq6v+1P6jFYI//fHWqfezPP5QwCqPQoC0ok
 W5dyRKEoy3whQbK0W1lONJjuVkuwUEUj+hilQmpoRpQAs5ULo7DgyLdX2j/7GvU9qb1aAtxX0
 OpNFgmm2/ynG2+f4FQFtprXtWf+T/rPXCwWLAUpq/+T8UjCyP8GRjuL9s7mFQVss9s1qjoVEs
 v5sx1YjHOUaiZY0IKwx/FMDaWehCctLhB3/YYC78BDPlKQSFu5s7/osgNQhUyHALj37nKUAkc
 8X2yqcsfSqt/AYOxywVEUio9VnRglQg9CVGPdkIOHOtGpuqJ3COf0FB3GF0jmMneORsvzwMQR
 UsYB5v1XmlO7nOdZRRRrr8K0HjIzgGZjsHkzczxUoNbHoR+LcFkyVFmC6DcqlKXZEPG1r/O/O
 rplhx1UaGiG50tD71GhB5k1RnowE/10n9yBhWKl8r9c9TUGohA=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Thu, 15 Feb 2018 17:28:40 +0100

Omit an extra message for a memory allocation failure in these functions.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/cpufreq/s3c24xx-cpufreq.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/cpufreq/s3c24xx-cpufreq.c b/drivers/cpufreq/s3c24xx-cpufreq.c
index 7b596fa38ad2..024afd0b9458 100644
--- a/drivers/cpufreq/s3c24xx-cpufreq.c
+++ b/drivers/cpufreq/s3c24xx-cpufreq.c
@@ -473,10 +473,8 @@ int __init s3c_cpufreq_setboard(struct s3c_cpufreq_board *board)
 	 * initdata. */
 
 	ours = kzalloc(sizeof(*ours), GFP_KERNEL);
-	if (ours == NULL) {
-		pr_err("%s: no memory\n", __func__);
+	if (!ours)
 		return -ENOMEM;
-	}
 
 	*ours = *board;
 	cpu_cur.board = ours;
@@ -562,10 +560,8 @@ static int s3c_cpufreq_build_freq(void)
 	size++;
 
 	ftab = kzalloc(sizeof(*ftab) * size, GFP_KERNEL);
-	if (!ftab) {
-		pr_err("%s: no memory for tables\n", __func__);
+	if (!ftab)
 		return -ENOMEM;
-	}
 
 	ftab_size = size;
 
-- 
2.16.1
