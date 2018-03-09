Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932215AbeCIQU0 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 11:20:26 -0500
Received: from mout.web.de ([217.72.192.78]:34707 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751143AbeCIQUY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 11:20:24 -0500
Subject: [PATCH v2 09/17] mfd: tps65090: Delete an error message for a failed
 memory allocation in tps65090_i2c_probe()
From: SF Markus Elfring <elfring@users.sourceforge.net>
To: kernel-janitors@vger.kernel.org, Lee Jones <lee.jones@linaro.org>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <c5d9751e-3ae8-0b66-821a-0e7f45bb8e1c@users.sourceforge.net>
Message-ID: <7d7253de-7bc9-93a5-9e6b-a0ebf66fb2d0@users.sourceforge.net>
Date: Fri, 9 Mar 2018 17:20:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <c5d9751e-3ae8-0b66-821a-0e7f45bb8e1c@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:VnB+oLHxFFdORdssW7YKIIpvH+tR88y/QknUqqp6ilm2WK37ezw
 SVbFldhvEHoLNCQufOG0MpZd4bF6/YuOGjpAclMLvQBYAIG3LTjtIPhGkFJwUntZhHfN/9I
 1/MdGP6VFC7zuEUvqgDywNwIJcMgw+iRQylZ+Q3LGBdZsHFHLcpGagGIZ6dzwxnurRqJ5cR
 LSQod6oIqkI9H23FHUq3w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:LDr8L1yPxrM=:nJ6ndCrhq/qNUB26PTX+Tl
 9NChBXHIzpFtc+dOzCP1QWlhNqNkcKOAduilmV1Iwdj3VPocuaWfns0SFmAUUJAZcVVRnX1bK
 all9paj8wBPMSs1jPJNLyWsripp15gai4DIzn+Vfkfx8OI/8nF8tgvAPwVXK4Tajwd5NZtRq6
 4lH67rS4GLQ4YiK19gUbC6T92zwMIf/m9Q647Mel7D7i0DYgMPswwV65xvZThOB0fHTrsfAFT
 rEBAfSRhMfvD437uhLSwQGQFkOKoThALPVtlP9gmI9amlNNQDO3WV62DfxhH24molRgVDLkzN
 u5z4y4lGwz0QGomEIvGe5FCXinlctvHyhhiR2ZJn4mfinAUXNM6GfHm54TrlmfLSLBW3XZKfY
 CXpoZEh1RhIYlw5rH3xTLUv8wklWajpT9tv6imR6Y+pfAaXtpqcKo5nSjdk9N1unm85tuFUV5
 dkVxhMwcnD6AzFgWQiuR24kOkHhLzg1jgX2TEBJrp9j7BQkD8+2ZwQyGyXAuNKHFqIP5pJFQ3
 O6w5zejatk7rGSNWnOz/lwDkzBsnSrMGlueP+70FNrBTxUY9/aszkko8Qq00ruS/ZSI/Al71R
 3H//3Tt+Wo4ETxGyOlxBdIiSP/AIvLk5oZ/jfIjy/KNN/bVJoziRbtAMJ2o8SQQWpSSuYLZtr
 NRTIwXhyrayMwiPfb9xJiXvvIw/Tt0cS02Ua4n4j7YoUka4F6O8PApezxyjJrvIjLMbuP3tUt
 GpO9AJ2nVjf1PbwOuwXrrnaonrjEV40HwG+YxLpHRJJdbu4g/lfusdeZS1OrPwcq0VwaxjAWS
 Eb4XyV7yhIEf+0RUlkhWeogBffRcNRj4tdGJvpiA1fRhjLP+e8=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Thu, 8 Mar 2018 15:25:58 +0100

Omit an extra message for a memory allocation failure in this function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---

v2:
Lee Jones requested a resend for this patch. The change was rebased
on source files from Linux next-20180308.

 drivers/mfd/tps65090.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/mfd/tps65090.c b/drivers/mfd/tps65090.c
index d7ec318c40c3..f13e4cd06e89 100644
--- a/drivers/mfd/tps65090.c
+++ b/drivers/mfd/tps65090.c
@@ -192,10 +192,8 @@ static int tps65090_i2c_probe(struct i2c_client *client,
 		irq_base = pdata->irq_base;
 
 	tps65090 = devm_kzalloc(&client->dev, sizeof(*tps65090), GFP_KERNEL);
-	if (!tps65090) {
-		dev_err(&client->dev, "mem alloc for tps65090 failed\n");
+	if (!tps65090)
 		return -ENOMEM;
-	}
 
 	tps65090->dev = &client->dev;
 	i2c_set_clientdata(client, tps65090);
-- 
2.16.2
