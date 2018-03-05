Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933072AbeCEIdv (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 03:33:51 -0500
Received: from mout.web.de ([212.227.17.11]:47469 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751395AbeCEIdt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 03:33:49 -0500
Subject: [PATCH 3/4] scsi: hpsa: Delete an unnecessary initialisation in
 hpsa_big_passthru_ioctl()
From: SF Markus Elfring <elfring@users.sourceforge.net>
To: linux-scsi@vger.kernel.org, esc.storagedev@microsemi.com,
        Don Brace <don.brace@microsemi.com>,
        "James E. J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
References: <f013341a-e3b2-69a7-4918-8bb3d109f0cc@users.sourceforge.net>
Message-ID: <c8183b17-d228-5bac-938f-16e751726d81@users.sourceforge.net>
Date: Mon, 5 Mar 2018 09:33:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <f013341a-e3b2-69a7-4918-8bb3d109f0cc@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:s21ow7SPSDkODZOcoULJ9qnoY9P9W39VFuYes2K8s48ZBTXeczU
 5qVuWNb2kJWZhiQfnriZMvS+aTm6Ofuy7bHtnAMgOhTXX4X+J1Nn5ZZ+0UBZQncv06SnF7v
 20K+9U/mqDrS8rvHu4/8jgth8Px9/Iz8I/WrskIHcgu6Xt7JKwRZ0c1IZjWR30nQ2UUuqXL
 G7glcvkvwCyJARQ2OtNiA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:xPUA2bZ8WaU=:FGeCceqvdf6i94fuvBubv0
 GecJPT+DGBNxBw/KORET364Uy5GAMKtfKDbEM/Rx+DLjZYVtE49NJsvkQDREdKgf0o6JxBno6
 N8hpKVEm2MgyvGKN0ynl3Niyx6VzhEbv5jmCnlBsrPpxFKx6KBZLVlFXuXdL8X/Xy1aPLAH/h
 ye7OylqxCdb+iapHqYUiG01Hesyxzpgz674IgDLI64dbPOkE/mpCpHV1JkN2KLmno4MK0NjMv
 wo/N9rcb5dKoMCWZ+3dsPC/mlPMcEW383A9GUv7OoGDZY3pbKfgbjQeqToE19/P5UWRwG9nO5
 H4Q+cIQS9NRNR+hqQjIoF8d4/SHH1abjyD1/ii3VQXgGjjMr9QOX871kTKrE4UwacHyBGSXam
 OyEqIx3gJBrhs5OhTjKil+gxcnbph+0DGuvHigBtDYeWM0k4H+r3IfG/KDPy0Xyip68z2TTAE
 8bu9kQr3WS2Yj+kq3Agd0yBvCuUqmb5jpje/xgvq8mm2ewAlAnraCWNFlczvdLR70XX8EhEH6
 YCJpzOBDQAzHMm1RUe0E/65CRxSoWmiXG+VlzLwHIgDFbXnrjrI95EMoNgtqq9ELFqY1EAVpb
 Kr1ALPco06b2+EqDyYIDPYh4rkOfTumJs+kgzdZmn3HTmXryf6IcE3jaKeaXW6mRa0sE+15mP
 uhifE/k9QbC5VlawrRsNNUmaqog+M+VsCxyIOxaHF/0q03GXhczHP0vNrM8Lgy39aoc/iT0Fx
 mTbnukZrpGF0/ZlIWsLx1AVC/e+qg4p000lLNIda31uvx740LZMgUhTk/B7NOenw7qZG0R+GB
 +1EyizqhK01ZcJDhk/okcBRlCcZ0BgfQ4m0c931gXuKIEatrS8=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 4 Mar 2018 22:02:10 +0100

The variable "status" will be set to an appropriate value a bit later.
Thus omit the explicit initialisation at the beginning.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/scsi/hpsa.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/hpsa.c b/drivers/scsi/hpsa.c
index 45177ead811f..86d371ab39e7 100644
--- a/drivers/scsi/hpsa.c
+++ b/drivers/scsi/hpsa.c
@@ -6381,7 +6381,7 @@ static int hpsa_big_passthru_ioctl(struct ctlr_info *h, void __user *argp)
 	int *buff_size;
 	u64 temp64;
 	BYTE sg_used = 0;
-	int status = 0;
+	int status;
 	u32 left;
 	u32 sz;
 	BYTE __user *data_ptr;
-- 
2.16.2
