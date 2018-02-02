Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752135AbeBBPj7 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 10:39:59 -0500
Received: from mout.web.de ([212.227.15.14]:63765 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751674AbeBBPjm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 10:39:42 -0500
Subject: [PATCH 1/2] i2c-nomadik: Delete an error message for a failed memory
 allocation in nmk_i2c_probe()
From: SF Markus Elfring <elfring@users.sourceforge.net>
To: linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Wolfram Sang <wsa@the-dreams.de>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
References: <97f41346-6abb-1c14-f536-ad12bbcb4c60@users.sourceforge.net>
Message-ID: <9448237a-67cb-0e7c-0837-ad1b89fc41a1@users.sourceforge.net>
Date: Fri, 2 Feb 2018 16:39:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <97f41346-6abb-1c14-f536-ad12bbcb4c60@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:otdY9/ix+RfulwXPQKf61rTs7GsPjHm2eD/ABcHgMRxt4Rx4708
 xMmxPI/3Uiz0J4Q0nGzdn7F8d1kxPZqdPgGsgT8KONuKcn6+X8nt+h7cYUCbepk2JeSz+YT
 AH5YZzqe3WH5wFLIVCvrx+v74AK+KI4lLdGeMcgTo1H22CtCQ19ZOY2Y2Lyk8/8QFHi8kXA
 G76zReG64ttw5h+dNvFCA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:7d9hcx7BDQg=:gXeIpuG8udduZy01hBhRiN
 sp0EmsggepGlZQSLwaYoUr9zsYT/XdXcOnN3O4UGNtAkTcUNu4XN7hv/kESTDFoZexFgxEsIP
 B93Jv+eRP0KLiW46RlnkmdwsgFcUYduxt4O6CGiw4/Y2TjGJfxHfBTql84l06/fZDeftDOfbk
 muvCZaQB0RJObhKlHQxZgB1XQ0utBHPRmCBqVmIO8A8PiSpyZFfogEeg92xMWxFf2M1KEd/lI
 QCBaVcqmgU296zRkOIm1ZFfBUZDIr2dOwu0NCd77fzXJu8Qjqv1AIlPlZK6veHGLuk+y2cumq
 CvQVP9NYmTmEQWOm7/keEOXOYjIqhBJcjBkk1VHQQfNynHWwntpag9WJq2D0ugDDziHRKuo3S
 +BGCBwxiKbhXQMAQ9q5ogWatv+kk1EnTH3cD/k4yNuCIwTD6PJ3YuQsj1U3aCyzGY/gi7kChR
 8Gv1zyyQ0pF5gPa1FiCskY1Te0sgvbZKnpMHzjcXeeuQSXVJQH4nTZsKJZ9IuYiR3gnBUaEpn
 OMZrJc3felA8Qh29rHkpO7mJuwwj1eP5fo1CGRF4baTNWKqhoBvOCaIMt4a0FcWOl3mDmd4N8
 SLMjuG7TGDOH9b3u0vF93GiMsdpJ5cY/fRcp4psKfxeapAcRpFQNF8yG9dcDCwo5jOesd5Cv9
 IIuecTymX5oa66sGJ2B8FMhx3qksFrt93/DfTD1SS4VSOuW1DiWmfE8gL8d3oqVZR0i/3uVAJ
 ZxLV+pLHAexcJAMZOF7bbXPF/naBe3jfjfa/Lfkc9aZjvEZz+6GqcqmZd0hzoLhUq0f9WnFzm
 uJUfyL+fzBJbwaDAwKmBRyoHqUnvNhn+2s081ZbRSa+dBnlzVA=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 2 Feb 2018 16:25:14 +0100

Omit an extra message for a memory allocation failure in this function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/i2c/busses/i2c-nomadik.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-nomadik.c b/drivers/i2c/busses/i2c-nomadik.c
index 49c7c0c91486..a783ad25fe19 100644
--- a/drivers/i2c/busses/i2c-nomadik.c
+++ b/drivers/i2c/busses/i2c-nomadik.c
@@ -975,7 +975,6 @@ static int nmk_i2c_probe(struct amba_device *adev, const struct amba_id *id)
 
 	dev = devm_kzalloc(&adev->dev, sizeof(struct nmk_i2c_dev), GFP_KERNEL);
 	if (!dev) {
-		dev_err(&adev->dev, "cannot allocate memory\n");
 		ret = -ENOMEM;
 		goto err_no_mem;
 	}
-- 
2.16.1
