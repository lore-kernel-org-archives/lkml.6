Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932118AbeCIQu5 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 11:50:57 -0500
Received: from mout.web.de ([212.227.17.12]:43103 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751159AbeCIQu4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 11:50:56 -0500
Subject: [PATCH v2 17/17] mfd: viperboard: Delete an error message for a
 failed memory allocation in vprbrd_probe()
From: SF Markus Elfring <elfring@users.sourceforge.net>
To: kernel-janitors@vger.kernel.org, Lee Jones <lee.jones@linaro.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
        =?UTF-8?Q?Lars_P=c3=b6schel?= <poeschel@lemonage.de>,
        Samuel Ortiz <sameo@linux.intel.com>
References: <c5d9751e-3ae8-0b66-821a-0e7f45bb8e1c@users.sourceforge.net>
Message-ID: <1ebf63da-0b54-73a2-2256-9b932ed2ab0a@users.sourceforge.net>
Date: Fri, 9 Mar 2018 17:50:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <c5d9751e-3ae8-0b66-821a-0e7f45bb8e1c@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:WmwDksRkFXFDV9rOYLCiPmW0svb+hvA1JkfXghC/EwnNtlcfh2Q
 cn/c/fvunvA6btj4JXn66qMAaKx/C2K/KiHe5ciwK8gaSh5coJ26OEQG3lR4pxPvB/hSekk
 CjVhgeWu/Yw3h8miK+upCNdr/932MXm7h7I/P5Ul+KmmgPBoJ/8ncc/zWY7RvvurkOHwyJs
 A+AQVSQ4q2BQHdCgJO1GA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:mEmlF01SQrE=:B6fQ+b9TgNyk8dMXE1N4t7
 mo9EbEp2BsL2eje+mIXy2fXkxUImmfHBWppj05ngt0pD7v0IJdJQgWn1w+690n0ddpiDTzm1N
 zSHOv5bV/RRn5ZGJcpTBUwPd6ieKriZURVb9NfovVebrEcEGD0+ZcbWV/gYl6Mv8P4T6oUnc5
 K/gM4jKp7ui5A7+mYL+o+yPQnXc+vPgiQmbUr7YF5ex+iYWR7ftZ9/bfHt5FQ75eC8qzkQUAn
 d7RuHbrDcdK94T3HJDwVLqxME3DL/WU4Vl4sB6vR0uwaPmjMpo37MURZl9aCGdcV7bEPtXdMp
 7nUtthi0UewPi66XRZmJ3PQSqMRbteIVr22ELt8UAdU0fEqeFSGTZHOEy4Mw3xOfOSgsbvLGj
 gYl0yfX+Fp/+LmLDYCHI+3PBhX9j84zAvf7g1Wh3OVRCeyzzNtxQFBRA3p3DuNjd1ef80J9v7
 y7hhX61JGITqyHS5UXXa5fT0k2pDAiebOvnXy17kTQvHqnrVUNHgqv/w9+lXXbOib2lR/OVxf
 CtT1V+i7O4efnSmo+mKamTtWDNS6Ls3trt3q6msHHRRilk6Z1v7SCZ3A3dTk1a+eMvByF5wSd
 oF1RZOiiemWK9azkh/lWPL7//Wm6DlGmcgtQznvlWSWj0cP5u1vAWgUeRvhd9d8N0E1u52nLm
 nkG13xo4Oga+toReOQbSK+ATKCPgMkwUTDRqeW5xdIGPPd+bau+ProsjjFEMy4y9zx6+fQ8OW
 ly3qbZBv5DKb8FL7bxFdfZTzA6vNa0/r/afR/6t3+KyylHg4696kEIW6FUv6YikHPPm3mncHB
 v1jjJLZmOOD7E5YGzVYjsUapLe5uKkDg64+vFMejQ8Mqpg/Fy0=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 9 Mar 2018 09:56:31 +0100

Omit an extra message for a memory allocation failure in this function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---

v2:
Lee Jones requested a resend for this patch. The change was rebased
on source files from Linux next-20180308.

 drivers/mfd/viperboard.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/mfd/viperboard.c b/drivers/mfd/viperboard.c
index e6b3c70aeb22..e9f61262d583 100644
--- a/drivers/mfd/viperboard.c
+++ b/drivers/mfd/viperboard.c
@@ -59,10 +59,8 @@ static int vprbrd_probe(struct usb_interface *interface,
 
 	/* allocate memory for our device state and initialize it */
 	vb = kzalloc(sizeof(*vb), GFP_KERNEL);
-	if (vb == NULL) {
-		dev_err(&interface->dev, "Out of memory\n");
+	if (!vb)
 		return -ENOMEM;
-	}
 
 	mutex_init(&vb->lock);
 
-- 
2.16.2
