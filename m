Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031133AbeBPP7O (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 10:59:14 -0500
Received: from mout.web.de ([212.227.17.12]:43723 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1030647AbeBPP7M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 10:59:12 -0500
Subject: [PATCH 2/3] pata_arasan_cf: Delete an unnecessary variable
 initialisation in arasan_cf_probe()
From: SF Markus Elfring <elfring@users.sourceforge.net>
To: linux-ide@vger.kernel.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Tejun Heo <tj@kernel.org>, Viresh Kumar <vireshk@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
References: <d492f9d2-ed64-e858-441a-fa554369032c@users.sourceforge.net>
Message-ID: <3b6bfa0f-3356-2fb9-07ae-bf52c1ccc47e@users.sourceforge.net>
Date: Fri, 16 Feb 2018 16:59:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <d492f9d2-ed64-e858-441a-fa554369032c@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:Sd0e6KrfF5fEHrCbbbetVXPkiH1eXf5GyGVGVOxpUwJ/E1W8TRz
 HPE3ReSIzkYAnfC9gf7y659A9drTXb6IQr2YeZ+6taDnCqXCd4Lb/P3MvbsLq8OL6t0ivdE
 GUujBYocNfrQYWm6vnd1CQ0o19LOPGuv2cyHdLWeqvIVJyhmDGrO98FtbLvseWVzQEUa183
 J+MHuIqR0Gqd+UyPv/C1w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:RPtHQoKdhKw=:PzHTUALg45fn55dzSJiADv
 M0wYblOoQSMsHA2xc4FgF1L4oNmivfLYHEEq1QcxRUBTa+53cL3xayFe0xKPKhVfCcQZhc0Eh
 L70foyUKqEeHmv1JqQ64TCfNUX3d0khqi0gt00G1la21uvRxVfCz+WtTXEsh6PQAn6vuWU1nK
 h7wQQCDFKYYbs8E916HoZb+NTLTTUp5xfGCoaNiJyzWoGRfPuDmGLDWT80qSuzGGzKhZ3XJTM
 Cf+Tnbxird13hus+7PCKbVYug3jo6Bk9iRRjCIjnkHvhkkjyusn1qorK6OKQIqlkzxXLUcZBF
 NTSzOsIIOFlcmFOpUqTWafq41ypF59rnsHm6f2hoybnyvsNE8srZx0fwT7p+y3Q0mEVjfrC4z
 3av54loiJQpOE2+WUqX6OdPnd4zvL0j15kpx5LDZ5A2KgCbXJXKTO+i+z1jn9pUz4BhT1sMcS
 ZiGMaFv/o4X18MnGCt2S/rOLZUB0ciI36QtXSGswScNxB03QXsR54ree5UBH6TaVULU5nrIsm
 ynsYrWbygy6HuG9lYTML85Hdvyh4mlsyAbmrG6L4tzh5I6UlKtZs+P0yVCcTrzu5HbDyZ/jZV
 72IQqnVtkkci2eDJVfVvxG88eEDbKBB2jPG5zG54AJO47XtGUSm5XGZaq/ErgXbhRNu1b36Ns
 q/BltwI4SFopjpAJGv35DN7qGYxdFBaAGYvOjZW/3labum0hgCsq4Dg9AdsAVta3jTxR3HTHA
 Dmcodk/fy/0YYjH4jxdkw26BRQWsRFVAa45d2CcQ6y17RWWuZiQiKg5Y/zOXf2Rgy5IU5QMYt
 v5n/LP3jIcjxO3CmcX6So0INIPJ9oj+CWAIlxlKy3TfhzILg9A=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 16 Feb 2018 16:28:23 +0100

The local variable "ret" will eventually be set to an appropriate value
a bit later. Thus omit the explicit initialisation at the beginning.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/ata/pata_arasan_cf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/pata_arasan_cf.c b/drivers/ata/pata_arasan_cf.c
index be5fbcedecbf..ebecab8c3f36 100644
--- a/drivers/ata/pata_arasan_cf.c
+++ b/drivers/ata/pata_arasan_cf.c
@@ -796,7 +796,7 @@ static int arasan_cf_probe(struct platform_device *pdev)
 	struct resource *res;
 	u32 quirk;
 	irq_handler_t irq_handler = NULL;
-	int ret = 0;
+	int ret;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!res)
-- 
2.16.1
