Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752111AbeBBUZx (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 15:25:53 -0500
Received: from mout.web.de ([212.227.15.4]:55301 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752089AbeBBUZo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 15:25:44 -0500
To: kernel-janitors@vger.kernel.org,
        Arvind Yadav <arvind.yadav.cs@gmail.com>,
        Sebastian Reichel <sre@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>
From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH] hsi_char: Delete an error message for a failed memory
 allocation in hsc_probe()
Message-ID: <afea2865-4862-c252-ad38-0f23842e5553@users.sourceforge.net>
Date: Fri, 2 Feb 2018 21:25:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:4fiiH1LFs9qE6Bu8ykYD36J3STOy5n8NXuN6YRCmbWzzp73RYDi
 kAMd4S3VfqYWXqtMeaPgG28q6uRLImzaN31ISG8G8QFu0suYfqPkJJJ0xEwJrbJyMgC3Abp
 EYZI+AYA/zwD6Y7JWbsJ5i0EOR4Pw5KeNpgvNEJWb3s0/b8M7o8WahufrH9PQpPB3UEPJ4I
 Wp9ohogrSsagpZk7wcGeA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:86eCPAQGUF0=:rliDbfvNqwNhzpGIwXWSPl
 wALdbPlVTMng+J5qrB/jGIWONzJLhrzCkJMoGHyq46B8yALVLL0cfzXAKmHQciLvBhci20cCv
 06ZOf7cCx7mXQ9IoufAo5BGQeYAWHaGBAZ8qlSeV2sj5DBnXZFGPKqu0Y6rA/7jdGetxnEKL6
 60rifRq7KF52yA/T8TDKYE1dKGAguSJcO39Dmgx87Y/0FjTBalKRxcYLvUtCzDGVQ6MYww26z
 IG7UWAmKe4greBG83FFT24a+uCB/6b8UsvIvwah9hODnhbzGxdeLcmTxCTDcwCngt4sWHbkRK
 N3Lxi51GjCaKNtIIvw3IN8Yt/VA8Ear6+3xtVl3uHMPfwB0d5s+aBE9n6deRT5q+g2b/wNyUu
 uV73KjXQLtxMr+d7NEBiIDoT3tsHY3qf56q0enzazYHs4NBVgEiSvmiSKsIGJA2G1EzAQVOMS
 /uxWPDTqmbCSyEdSzu5mo4MJLqPU5v2KbYwQtVL04iRPEPPx04LJVLpeU8VE67Acx3kvoCb1y
 XbVDAOrSAtiM8OY8cuhhBvO1lI4HFqwIswW1p9wDmh1Y5S53ypKtdnLgR1QwXr+lFqX8ru3bn
 aZZryCEpYG45LAaC+6PRsoe7xZnNCM+cixKyOFYdURQ6+dfATf/kz1QZUcFI8965kS8BaJ4WD
 zgMNGJARkuh64fKHQBnxAFKAuYnLS25ukCaICoX/d1trByLdRBAROLNY3b9T0HY6wxUy4kbqE
 zmQxXLrRcpKWzVIMXw0f5VozECucRZRvjb2/EhSFm7xXUfUA5GMa9LlGEK0oNO68ffMHaa8dF
 86pNKqfNVvgra2OqMdkDHqCVNvIDyaMjlaKJnwQibVixWWxChQ=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 2 Feb 2018 21:21:12 +0100

Omit an extra message for a memory allocation failure in this function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/hsi/clients/hsi_char.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/hsi/clients/hsi_char.c b/drivers/hsi/clients/hsi_char.c
index cf9c2a332ad8..9d2a6d64dfb8 100644
--- a/drivers/hsi/clients/hsi_char.c
+++ b/drivers/hsi/clients/hsi_char.c
@@ -697,10 +697,9 @@ static int hsc_probe(struct device *dev)
 	int i;
 
 	cl_data = kzalloc(sizeof(*cl_data), GFP_KERNEL);
-	if (!cl_data) {
-		dev_err(dev, "Could not allocate hsc_client_data\n");
+	if (!cl_data)
 		return -ENOMEM;
-	}
+
 	hsc_baseminor = HSC_BASEMINOR(hsi_id(cl), hsi_port_id(cl));
 	if (!hsc_major) {
 		ret = alloc_chrdev_region(&hsc_dev, hsc_baseminor,
-- 
2.16.1
