Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752774AbeBFQSJ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 11:18:09 -0500
Received: from mout.web.de ([212.227.15.14]:63470 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752699AbeBFQRy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 11:17:54 -0500
Subject: [PATCH 2/3] HID: lenovo: Improve a size determination in
 lenovo_probe_tpkbd()
From: SF Markus Elfring <elfring@users.sourceforge.net>
To: linux-input@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Jiri Kosina <jikos@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
References: <06e2d590-f980-0022-c476-6b999239ff9f@users.sourceforge.net>
Message-ID: <4c71a06e-3c13-81e6-42a3-43bae24fe1cf@users.sourceforge.net>
Date: Tue, 6 Feb 2018 17:17:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <06e2d590-f980-0022-c476-6b999239ff9f@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:/ASCWqGwvupVzKn9bEcEtYQtkCxIeCuPKXATveY1zMHeia6Kex8
 ypouEEfkTI4AZwxy4HeM1OhkhHOOHg4Smq80r8Fx2hcmjDFF7aQEqBAjRCHgXkE9iBk3CED
 4Zb1QVnDiOJy8wLH/obF28OzOi5snp46nK+YqOBt2uiU8nY9BfbNk5f/EyE6FXy2xg7KDNi
 gd+UZwtbJRZBsm0z4ywRg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:SkJtQhQLIY4=:QBW4xbnDI7UaoP0rCwfiO1
 wGdGUjz3XTwp2S+hS9bs1wwhATunYos23yj7+WGNITCkI7cUCVVlxYLb2p/eObf/TtKEK4qBD
 G/8Buc1a/9klI7qwNoFReGJWoldtFBb1rLoAQ79Kdb+Ywuusg/B5MalE8hc617NhDWjW7Im+f
 B6krN1XDtd8xbAXsdF43cW8qT62ScHZRUnNaThBzU7sULUT5x/hJNmiJthylSXIzsIKpZDZDV
 GXNoS8anIGbt2XN8N1mLIzQK1Vuo3NBWfpf8AopMgmruyNR5ZOl3zneX70eardGNGuyH58lv9
 mtyAmunbOE1s7qbWH7Nd8U957LPeU0S3FpEryX0Z/tLQ4eqXxxG9jJ9CHIyN403uFwPm+0wbf
 smGLNqwvchooAqp8rujEAkqM1M2Ko2ovKP0jQaeAWYQiVYglA9Ig1hwfv7mlYBFMzv+BkWItN
 zHXTr2VuV5KxXgS3ereB+hTrg1/75JkuZYLBCpWVEf3y8BntPyt8KKtvC+JMU34gnvLSrCkq8
 veyvVELlkqrHihCAwSbcpptnzA1c9p1t5/VE1yS9VEQ6FIEl0QVFreltIFHzY9smyzRIYm9uF
 wEF7PCg/P/8B3VShP+WPvkRn2Qv28TXglq43SpBGBC3BcADh2zEBETglj6LvSaWT3AZlZXiVX
 2p0A/7tCpBzrjI7LoYLktbpNQFpiTE6eDqUstPJxKmYER01DqO5vt+vTwthzXL42dazJ2k5Ed
 hDVKRhDAjBYJViVmyP9skFCTmhvoJYZQS02OB7zxtRO5M8FJ9U+Kcua8TU5hU3w4ux6AxNaYd
 yEfj388+JIrleaSzJT0o1tSvaufqj2Sk1eE5vKo5Q8cWzgcR7o=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 6 Feb 2018 16:52:58 +0100

Replace the specification of a data structure by a pointer dereference
as the parameter for the operator "sizeof" to make the corresponding size
determination a bit safer according to the Linux coding style convention.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/hid/hid-lenovo.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/hid-lenovo.c b/drivers/hid/hid-lenovo.c
index 549b84d01b46..f863b94f3476 100644
--- a/drivers/hid/hid-lenovo.c
+++ b/drivers/hid/hid-lenovo.c
@@ -685,7 +685,7 @@ static int lenovo_probe_tpkbd(struct hid_device *hdev)
 		hid_warn(hdev, "Could not create sysfs group: %d\n", ret);
 
 	data_pointer = devm_kzalloc(&hdev->dev,
-				    sizeof(struct lenovo_drvdata_tpkbd),
+				    sizeof(*data_pointer),
 				    GFP_KERNEL);
 	if (data_pointer == NULL) {
 		ret = -ENOMEM;
-- 
2.16.1
