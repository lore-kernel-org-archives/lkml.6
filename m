Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965266AbeBMQdi (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 11:33:38 -0500
Received: from mout.web.de ([212.227.15.4]:38193 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965066AbeBMQdf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 11:33:35 -0500
To: linux-efi@vger.kernel.org, Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH] efi: Delete an error message for a failed memory allocation
 in efivar_init()
Message-ID: <13c1274c-cff4-5056-cd06-353663af58e1@users.sourceforge.net>
Date: Tue, 13 Feb 2018 17:33:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:okpTwdd8IKROHU/L1dodheZaa3CGBZw1X9GA0JugbZFNclotyv4
 JcO1czfk5Fc+s50uhlYgs/iQZZ0WGEPQD/OLfwwHxmxoNc2ksdcTywz+BIy7aTn0IdLDusV
 ljY8eY7WtIO4UDn/52nm9kfjSSE6794/7DveE8UWbQRQG/xtJp8NNlJyGUVCpQ+XSbC3JtL
 lBbwhRJrMOiaRv32LeuOQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:qdzInoXia+0=:WYu3I0a079cXFZZIwUZKW6
 CByF/SXqfprAvtYksDAcniuRzLCBsIOAxRfarh9QXhCf3zgvXj3Y6sEITDsFMgek4eZfnYUeX
 7iTHoj9CzVu4KCDYkZk/71+mSy8gzIhH3t1/1Z+awFHaG+vVJ1BHxC+Y3K1CCByP+RMTOieiJ
 uwo3Cp3/WdaS6AblJUrKxmp5/VVDrHA0ua4p5NS/fz4OYiV3/BNjZh0vZIX74B9MFkYICaMZf
 bv+C59EotbITFMclYDJPAw518ynpwMzFqpHiNJwFFh27XunGR6z4PsGEmwykOeVvVeG1FKmiU
 4gztRbtwbiXy1SD6Zbcw0n8mLVn7iKT/1RFVg9mjr7jdGnmjB5bza9wmWce/I9/4w/3HBtpnc
 nNBcdNtGKYdV9SiWvfxrbpMP3S3yUVanBCXKgmiQ46GGVHhXpq37FLt67kC3LeAW0mFWHVyum
 VaFC4qannMky7WKDrGOiVHLj4djbmwR9b4NstZUXeqfRxnIWfV4YZ7+aS58XmxxE4zvJS2LxE
 bT6x/RYlPjuk82PsdgHBzlwW31fdse+V34BQPrf7Rtfz4epDyH9b0hYzmTYgGc3/KzhwugDK8
 03Kjh3PRFfvAVieveD6wNtWCgxsSRpZNdXqFxojcGBqyeSJd0jMCpjit3PK1C73yLq80hN895
 +EmVKv1Gic2goHo+JdoPvQR3LFo/7beTqsjWrO94qWosOhy1+SCSDpX1xXV/vC+UUelqGqcME
 s7pGi0uitYhZD335zwkNB2G+T6vIE+Ghcr/EQV1oK1UZtPN6Ov7vdu6MoYs26YwpLW51Y7242
 gMvW8We0Par2IYwrEIpDDEJEmfhxybYa2UVxUvzAWTj33Pr190=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 13 Feb 2018 17:28:22 +0100

Omit an extra message for a memory allocation failure in this function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/firmware/efi/vars.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/firmware/efi/vars.c b/drivers/firmware/efi/vars.c
index 9336ffdf6e2c..ffdbc5bc3c56 100644
--- a/drivers/firmware/efi/vars.c
+++ b/drivers/firmware/efi/vars.c
@@ -437,10 +437,8 @@ int efivar_init(int (*func)(efi_char16_t *, efi_guid_t, unsigned long, void *),
 	int err = 0;
 
 	variable_name = kzalloc(variable_name_size, GFP_KERNEL);
-	if (!variable_name) {
-		printk(KERN_ERR "efivars: Memory allocation failed.\n");
+	if (!variable_name)
 		return -ENOMEM;
-	}
 
 	if (down_interruptible(&efivars_lock)) {
 		err = -EINTR;
-- 
2.16.1
