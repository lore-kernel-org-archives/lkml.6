Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932166AbeCIQB7 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 11:01:59 -0500
Received: from mout.web.de ([212.227.17.11]:40223 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751096AbeCIQB5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 11:01:57 -0500
Subject: [PATCH v2 01/17 1/3] mfd: abx500-core: Delete an error message for a
 failed memory allocation in abx500_register_ops()
From: SF Markus Elfring <elfring@users.sourceforge.net>
To: Linus Walleij <linus.walleij@linaro.org>,
        Lee Jones <lee.jones@linaro.org>, linux-arm-kernel@lists.infradead.org
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
References: <c5d9751e-3ae8-0b66-821a-0e7f45bb8e1c@users.sourceforge.net>
 <6c8ff539-9e9d-635b-22a8-df8100ac8156@users.sourceforge.net>
Message-ID: <4948c6d9-af42-8c95-af38-fc448a8e25a2@users.sourceforge.net>
Date: Fri, 9 Mar 2018 17:01:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <6c8ff539-9e9d-635b-22a8-df8100ac8156@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:W4NNCz8Tr4As0FnF297humGUJEH3ZiJ0oInQ58F6O9iXox1b+is
 PogWUL/1QTIjWglvCm4yx0Ucvw0RCGkmlq7JYY5rGjxPg0ZWhpPDa8Oa9Gpz6aAgeMFRKV1
 TCDaLVhX9wUYc6LnqFz+lQDRz1FPoKXIAnUXwrXr3h3YatrYbBhJ1OMPhv+7YStgceGCO/1
 o0k+TEljKLgurLyVSmiGQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:TPJwqtbaTO0=:T9pfSToeKzkZ9ve0Yt4oWQ
 Py/P7tG6MICkCgLiDJUYgMQvtY5a7pnyOtIKB24SWyWG0ujXNcERBn5+L6zQpPRBKwdeyLG2O
 jCngAJMM//6gDr/BuG5IAEqDVGEEmLFu13iP174QRlOmE+w26tw8f1ASCfu5ZXB2tT0LkMUmn
 P77EcoqxUMaQ9jmKxseczZpCz7rxUjgTcyAN1SGODHMATaoVQnKABi/SF4KFRKdrsSs2dAyHw
 EIQQcu5lmO+0w+eCY39pS32y4ds4q5V5sMFFZhhoQL3dmQlPdg1Tpn4g5qhw+UbfPNE4HtG5S
 FeH/f6eGzsxtHo+KQRAKNKDWKhSEyDDOOzwQ2+U/DcuPd9c41+SfzQCgESra2Pqt43N8BUgca
 da6ZSyXy7CyNrnqVmx1iQD+viIz9JrGyJHFx3ERZrnmSkBwx2nc0eWhn7GbiTPNqWLCBZgxPW
 Ultu8cu9GihkPNbztJAhTL2s2IXGitpMzz1OG5/UKoCDfWwNOu3aBmSlGoblN7eCF1GsJq64j
 jV6Ly/btxzVDH+SyApkr/guG7ihnjdi5PfM92oCQfZcUUjTOblv3F6uPn0D8CFTlc2JglNtH8
 7IJQDa2Ol6UcxUhGL0gW80Wc9+rHaBoOFFVCqHRTo3s2CZbzjgBD2YVSs7uo1RzHDpFPI3C0v
 5Tfl4Y7uTbnr0jRoJ837uNaIPGHO/iasNPnFT+s/onMQ2uC/JWe/8rd+4lQm5rvfdUKwKS38e
 455KRF28bibmxbW+w0a9JcPfrhr1zPvABFYZX0s6pTuYk3JXplK2Y2364h7f+Dd2UzWcTsF2e
 IRpqCyF3TzpdbEQOY7atgpHaV2MGqwzmv8MayzaVA5XqLxEM60=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Thu, 8 Mar 2018 11:44:33 +0100

Omit an extra message for a memory allocation failure in this function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---

v2:
Lee Jones requested a resend for this patch. The change was rebased
on source files from Linux next-20180308.

 drivers/mfd/abx500-core.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/mfd/abx500-core.c b/drivers/mfd/abx500-core.c
index 0d3846a4767c..c8c9d41abcaa 100644
--- a/drivers/mfd/abx500-core.c
+++ b/drivers/mfd/abx500-core.c
@@ -40,10 +40,9 @@ int abx500_register_ops(struct device *dev, struct abx500_ops *ops)
 	dev_entry = devm_kzalloc(dev,
 				 sizeof(struct abx500_device_entry),
 				 GFP_KERNEL);
-	if (!dev_entry) {
-		dev_err(dev, "register_ops kzalloc failed");
+	if (!dev_entry)
 		return -ENOMEM;
-	}
+
 	dev_entry->dev = dev;
 	memcpy(&dev_entry->ops, ops, sizeof(struct abx500_ops));
 
-- 
2.16.2
