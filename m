Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752465AbeBFOr6 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 09:47:58 -0500
Received: from mout.web.de ([212.227.15.14]:60275 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751834AbeBFOru (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 09:47:50 -0500
Subject: [PATCH 3/3] hid-lg4ff: Delete an error message for a failed memory
 allocation in lg4ff_init()
From: SF Markus Elfring <elfring@users.sourceforge.net>
To: linux-input@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Jiri Kosina <jikos@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
References: <5c76a767-b1cb-2486-f24d-0d5a220b8985@users.sourceforge.net>
Message-ID: <fadaaa7a-a632-ecb8-de75-05a85132a171@users.sourceforge.net>
Date: Tue, 6 Feb 2018 15:47:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <5c76a767-b1cb-2486-f24d-0d5a220b8985@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:t7Ynhuj3fa0ZwdW7QOx/Ew7XwiQB33yLdhLmqVKN2QOW+Qb8TaQ
 72mi5vZR3kEclLFxLK+YYLrbciYb/bAj5z8IRSCdm0P386NA++Zs4J7+BeENHpCstyy2ZkU
 ljK2D8SnoHdrjWIULf0f3ZkQZ7ee4V0wLOy+RpessP+RRzua7XsB23xTsY6d0LZyyL/u9jX
 ftCdRV/uw7SqWCwzBA8yg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:jxUJXiSz/uM=:ZoAy2NOBMZYOOKzptyYard
 FPKs6PBamkX+1K7AMcWIdi4u7X9XG8PtYJkqEHKqnZpa/k6cGFPN0+bzzBNZnhkkJvpeTZl6r
 e860rUFFgdYVf4GVDN8Obo15l5viv0b0vq5RX9L8+wIs1q3uOSTa3UzpmlLE8R7/rtXtwBBWH
 C2Ju4Esfu39eejX70v6xbg5zD3AeGdXxYeDqKf0E1FZUe9cOA+O4MBaa35Yw4Wz0ZnzTgHJ/i
 TCV/uwPcYEOE9N2XhIuT1XlAIyV274KYWWi2A8zDX2hNj3M8WQKmqQ5q4Lc5UUrp9zLSFjlxL
 mOsR7Elg/1XgVlIH5FpQ2iAxM8CrkOq2YVCr2usEYrVE0aOPU3ycjjLgF8Had5XvMus7iK6yM
 RIo+cvaMsMbGM9vtmgsGiDGUo5K44ktpGeS4gxwk1b99T4lpjvvLeRWEGwA7AuQrKETGqr2XN
 l2NDkrHNz5oYwbtvVa6yLAjQe5x6Lgmq8qJyfnWnJhASWOYPBRhgnZRaMLzunHHn0FDcMq16o
 HXolZ1SjIBDNgnCZK9n/HkQ7SIwJH8RJyTEEG3hQnk7YkfamWCqHjcPjtGJ7JRbXsWQSlWKTt
 kxF2DKRkQ6t1zd7aoRTALlcNkfJaZYc9urZsWxYeeqS2jj0kTwabaZrb1kPB8gj2e+oGrIMCA
 jcjHSqeCeQe5QKNai7Jpr8KsY+pSXzIm+hYF2G4YUtG+lYObxN1C0wAftEdm4hMTaj+paj8+X
 xHtDrn5mIPAKCBTSjSLMPYs/ZzVFIFrjHdG+hvYHhdnCcV01j/kMPVTKsOjXMlKUzZbuyD+x3
 I2bvuijzujQm1hjNhxbqYHCqu8lJyQPGtvNCjic8bPYqUcA4u0=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 6 Feb 2018 15:26:06 +0100

Omit an extra message for a memory allocation failure in this function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/hid/hid-lg4ff.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/hid/hid-lg4ff.c b/drivers/hid/hid-lg4ff.c
index 512d67e1aae3..ec6b94bb3fd8 100644
--- a/drivers/hid/hid-lg4ff.c
+++ b/drivers/hid/hid-lg4ff.c
@@ -1401,10 +1401,8 @@ int lg4ff_init(struct hid_device *hid)
 
 		for (j = 0; j < 5; j++) {
 			led = kzalloc(sizeof(struct led_classdev)+name_sz, GFP_KERNEL);
-			if (!led) {
-				hid_err(hid, "can't allocate memory for LED %d\n", j);
+			if (!led)
 				goto err_leds;
-			}
 
 			name = (void *)(&led[1]);
 			snprintf(name, name_sz, "%s::RPM%d", dev_name(&hid->dev), j+1);
-- 
2.16.1
