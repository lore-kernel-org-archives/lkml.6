Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752509AbeBBPBU (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 10:01:20 -0500
Received: from mout.web.de ([212.227.15.3]:34059 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751646AbeBBPBM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 10:01:12 -0500
Subject: [PATCH 1/2] i2c-puv3: Delete an error message for a failed memory
 allocation in puv3_i2c_probe()
From: SF Markus Elfring <elfring@users.sourceforge.net>
To: linux-i2c@vger.kernel.org, Guan Xuetao <gxt@mprc.pku.edu.cn>,
        Wolfram Sang <wsa@the-dreams.de>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
References: <2fbd709c-2790-af6c-4fd4-0c8ec6b5b3d7@users.sourceforge.net>
Message-ID: <3bf9bdc5-3bcc-373a-10c3-1d7c77633b5b@users.sourceforge.net>
Date: Fri, 2 Feb 2018 16:01:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <2fbd709c-2790-af6c-4fd4-0c8ec6b5b3d7@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:aFJlNwVqR8J4amyHh0Loslc4/dKVKe+hVPuRPYBTObbNeQPPJ2n
 NSpqlAtsimNNJLL+X3Nhk71s2rUhsTPBfwE1PI+sVegrOQnL543jzj+oo2s4H18PF6nUX/H
 daYZbGJMW9aACIArJCpj3j0S97KLnxmNd/EpFoxRNRkNqymP9/PDLdoefr7dplIVa19eT4w
 rpS3Jj7+d3oFZeHhJRrgg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:q8zXC3ufyIk=:h1+Z+eeqTz7Q4YOBsL8i7v
 UBjf8Z3G27G1QlcEEHm/RdR/Qg1vSjpa8tMqIAjvvtUyC3msZoUGzs04zitKWwvSRm7lZLJQo
 yBiauAPJ94f+wmVwmM/P34zhgn4/kzqZpKhv8KPIwS5iNEn2AcSGpOixnR+SZaRj90DgexfGl
 rRkf8VumO8eJ0PDaZy8oV8eygLoVk/dMYoRofrWEE7cnnqzY28zz2r7hjNBMHI09xXDN4mXId
 vs8q6Le5wLqGnhiF9D+mEH8S8tYAOjegaxXbj82TNdqa2pdjpRTI4Xk7pHbOoJHxXCkeew5o1
 WOtvHYukCplRRggYTYb+N+WVOkH+/I90XfGnOvk+v+CplY1w2q0y1A43ZhFAqfJpUyl6PszoA
 8rw+vIf3hn9LvqHdP+Y1FFvllO63YAvRIuIjiY0KiSGgRCpfjMrXAu5+lt+G/WktueSc83ncB
 vdcHuVT54w/Kuw4i9zWXiExMjyHpvymrUAQ6JiVzzm/OjQoBWeufhMFXVO/XOX9ACv4qmyCTR
 jvzNuXEAdFFsDby3CHRIx9vhS6QaBmb2ditnzpwssgbp1vk43Wh5o0YoKCXoTmWDGFQt758je
 hUvEGmi4MCpyndGJedj765Gsb6l4Qyw5yN2Ay8lbA4B0m3tHaKb+Yny+TIANcXnxMtpO5C6+V
 48icd2BAxzOPpnVleqPwx2H03O3Cep+xgEmbNYg6kSbv5f8Mki1LS/Hq/1LgUEUSq6notaIFW
 yPDehmEtwzj1/50NDJs2/DOxROtU8Jp8EDLniHMiy2EM9k3BCfXta0sC74rJ0aValbqBl4q/G
 U8MjdP7ipcAgJ2oIPeb7uT3e1fO6VK5emKCF4jQpCyZTWM3X9M=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 2 Feb 2018 15:41:26 +0100

Omit an extra message for a memory allocation failure in this function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/i2c/busses/i2c-puv3.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-puv3.c b/drivers/i2c/busses/i2c-puv3.c
index 287088b8c4c8..5bd001d01bef 100644
--- a/drivers/i2c/busses/i2c-puv3.c
+++ b/drivers/i2c/busses/i2c-puv3.c
@@ -198,7 +198,6 @@ static int puv3_i2c_probe(struct platform_device *pdev)
 
 	adapter = kzalloc(sizeof(struct i2c_adapter), GFP_KERNEL);
 	if (adapter == NULL) {
-		dev_err(&pdev->dev, "can't allocate interface!\n");
 		rc = -ENOMEM;
 		goto fail_nomem;
 	}
-- 
2.16.1
