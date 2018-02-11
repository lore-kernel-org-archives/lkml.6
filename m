Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753784AbeBKV0e (ORCPT <rfc822;w@1wt.eu>);
        Sun, 11 Feb 2018 16:26:34 -0500
Received: from mout.web.de ([217.72.192.78]:41857 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753689AbeBKV0c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Feb 2018 16:26:32 -0500
To: kernel-janitors@vger.kernel.org, Jean Delvare <jdelvare@suse.de>
Cc: LKML <linux-kernel@vger.kernel.org>
From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH] firmware-gsmi: Delete an error message for a failed memory
 allocation in gsmi_buf_alloc()
Message-ID: <9cea2b6a-f260-a578-b3ed-6c118795907f@users.sourceforge.net>
Date: Sun, 11 Feb 2018 22:26:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:ZSTYg+yD+xN4ciso9gp3S/aPpMxNp9RVB8JiSW84nZZLQvFE5K4
 XMzrAvvheTufkkp5CyzAx+X1j79uU2BZV/FxwuUsp3HUVkQEVEJC0nc8bdcblkrT56BMKum
 gbibodp6P9OfbB1UMr1YJBnOiK/BWB1V86DLNdH5ws1mTQyzmAgH+2p5cUFERDQRw5w+Fsd
 qQUs8AdGWMfuykRCwk0wQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:tZq0Jnp8uoI=:+7dPQ+FN3sAlWLGVkKkkRv
 xybgQUvdkUvlyknMo0S0nOiY9UhK0X0hn/OC3dWKhArZCfVa2fR6EhPss//ynql8rK229229c
 FhoCJJZuszkSBMiItHTtdpzNQ4tcOEniJzu9FGvWmXO4M57CC46Pa+BGxz79jfcb6/qfZVYnH
 HPfBsRRWHflG1kYSlPlyYcnoBVXXQYQDhIPAXBQAfqEJAvMTuNsns9Dorpb8pE8JEb4jbS9vw
 e5Zyn8Fo1xhoneKcWiNT8RvL87uIIYdIoLPgEmd+wsVP9MeIggIhFt7zrlhMo4ocr7OWSBvGh
 x9Ur+z8zQbflhKUMQOyyxhzIFSViM856Dv10kyB1RX0b50E8b0XjUMq6Y0/IQDvUvvtrQ1OZS
 TlSSPafT98bsEP3FLSFzQcLz84HG8VJJslWpqHWhNozFBTuWjGXdkwS/aIRRNx8/ZXgw7FBbQ
 c0oRBS2eIW6TtLEdBwSV2FuK3F8a0zV0OYlEs3dwiiw/E36bBql+V0AsvHqAxDcbRX1KZ9h+R
 NJhYKnrDBu0vQK+WJ26yeqo+PWXfCWYFIAv62NZZg82awbF+c0F9AVM9/IVn10a0PECEupV8D
 ZE4JeXFQmkBBHu3uD8lRwlU23nCNG/s+LgKspNHl4CQl6iSc7hNb50brHR839bVYghpkq7Zen
 RS4k7HckxsiFnO+zi3cGwQ+76LK4E99bnYBDTbckkngNWuRYUaYfDbrLpv/ZWQ1XkwY2TOphb
 gvgdlGAU/rUKPlNRUWt1gCo5kun8mwdHtiAh8bwQW9wUSCotVXRwtDAQ9X1pBHxpZxAaCTLKK
 cgmVFzK3sbAXL0owHpwZ6RZ/wIvW/M7onpkK9MMCuwf7WMswGQ=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 11 Feb 2018 22:22:02 +0100

Omit an extra message for a memory allocation failure in this function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/firmware/google/gsmi.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/firmware/google/gsmi.c b/drivers/firmware/google/gsmi.c
index c8f169bf2e27..fbf661e0b784 100644
--- a/drivers/firmware/google/gsmi.c
+++ b/drivers/firmware/google/gsmi.c
@@ -138,10 +138,8 @@ static struct gsmi_buf *gsmi_buf_alloc(void)
 	struct gsmi_buf *smibuf;
 
 	smibuf = kzalloc(sizeof(*smibuf), GFP_KERNEL);
-	if (!smibuf) {
-		printk(KERN_ERR "gsmi: out of memory\n");
+	if (!smibuf)
 		return NULL;
-	}
 
 	/* allocate buffer in 32bit address space */
 	smibuf->start = dma_pool_alloc(gsmi_dev.dma_pool, GFP_KERNEL,
-- 
2.16.1
