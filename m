Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933173AbeCEIeu (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 03:34:50 -0500
Received: from mout.web.de ([212.227.17.12]:38513 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933031AbeCEIes (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 03:34:48 -0500
Subject: [PATCH 4/4] scsi: hpsa: Move a variable assignment in
 hpsa_big_passthru_ioctl()
From: SF Markus Elfring <elfring@users.sourceforge.net>
To: linux-scsi@vger.kernel.org, esc.storagedev@microsemi.com,
        Don Brace <don.brace@microsemi.com>,
        "James E. J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
References: <f013341a-e3b2-69a7-4918-8bb3d109f0cc@users.sourceforge.net>
Message-ID: <b82cc1e8-bea0-c899-6a11-6b54732bdb6f@users.sourceforge.net>
Date: Mon, 5 Mar 2018 09:34:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <f013341a-e3b2-69a7-4918-8bb3d109f0cc@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:+5aL+EfsKkrBKK26qo+BInBS/RRLrH70lzrt9a4lxULfYTLr7kB
 9HnJqktaa3OLy/2KM2ViptB6XvknFGyjJzVRndYIQ4P7qRERhyiLe/bOaQCVI7NFsPDiG8v
 Pq4vHBnAIG5KRF+u89PwThOm9rrM0wvYvMCuPCEP8Dex04ZyYI19UsXFv3m9XovKKfx8Q3q
 TZmNoSGoD7J525otUHV9w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:MkplSZO6ggQ=:PA9RceWX4CUxDNVg0g5Sn1
 kdi0k8HfNZOnLM+wVxwXJKmzFebB6dISWIrgIWVqoa8G0cZ29W9PcQb58eXivX+kWHDfe4H5e
 lisz31XDIJe+isc0PWmXbrbd9YYaWGJm8gRPplhCQua/sBofMZqFazDeWhjRFdAU34eweCkHz
 J3vUYoSN8Mixr90dZY+vJ7uAzAAEvI2TJrr6bEApsvJJfyZIpjxf0+9VFxfv9r3UDvfsrH6z/
 dXcVaxzF6Fv1DSsJP2mZIomLL9icjyJllYZS5u4ELMRfMiSVX+pdgOFtQpzfgdp53QDHqJ/QH
 imSREbqTfqatnbi2B0le7XaIM200Uq00k8vdQdcW4Kq1Agji9QQnbsDOc/lfvnADeYSQ5ix+M
 3zB+9qJVH1beYMA45Cf9BU9Shi0+YM+zaQL8WADjD9rfm4BJ4VbHLvewkLUnZ6AeGhu7LAG+Q
 yYbuIOrFPrcmzF7OW9ycXhSg+ok8LcOtCLVFwH4QIzLDh/1IMSwcWV0DrYI4XJ2ioKDtNbk4J
 H34foltMYaSmW9y6iWvFpBcbl2mknyoq/Vj4S31OeA6nZOz7cAY7sW/jmQM8mTaJ7EUDDmWBT
 SX0zMYjqdAKUg1lpe/xIuvwWGPe1XuXwW9aDJ98sQJ2aVCu8wef0PHRIBJWxHG3WJ9K318fO5
 4LEXoxD4ygO4i1m16agDUqmmtYFC6meNLyIQlE8ZMY2MQLYrID1qavoQDze4Fit/4gQDyARvS
 uoC+419/yTlRTmdVlqXSOaGRLRZjITvrLbXS2oTbHF/aENA/mS5v/ktiM3xZB450Rs4t5efPc
 rYdP9iFTzaa0wsqbZr8zeswwex+jgk3J9FJfxUUfdnFnzJ3eRU=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 4 Mar 2018 22:16:05 +0100

Move an assignment for the local variable "sg_used" so that its setting
will only be performed after corresponding memory allocations succeeded
by this function.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/scsi/hpsa.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/hpsa.c b/drivers/scsi/hpsa.c
index 86d371ab39e7..bb6df194ac31 100644
--- a/drivers/scsi/hpsa.c
+++ b/drivers/scsi/hpsa.c
@@ -6380,7 +6380,7 @@ static int hpsa_big_passthru_ioctl(struct ctlr_info *h, void __user *argp)
 	unsigned char **buff;
 	int *buff_size;
 	u64 temp64;
-	BYTE sg_used = 0;
+	BYTE sg_used;
 	int status;
 	u32 left;
 	u32 sz;
@@ -6420,6 +6420,7 @@ static int hpsa_big_passthru_ioctl(struct ctlr_info *h, void __user *argp)
 	}
 	left = ioc->buf_size;
 	data_ptr = ioc->buf;
+	sg_used = 0;
 	while (left) {
 		sz = (left > ioc->malloc_size) ? ioc->malloc_size : left;
 		buff_size[sg_used] = sz;
-- 
2.16.2
