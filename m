Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752628AbeDILAJ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 07:00:09 -0400
Received: from mail-db5eur01on0133.outbound.protection.outlook.com ([104.47.2.133]:4416
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752487AbeDIK77 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 06:59:59 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
From: Peter Rosin <peda@axentia.se>
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Boris Brezillon <boris.brezillon@free-electrons.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 5/5] drm/atmel-hlcdc: fix broken release date
Date: Mon,  9 Apr 2018 12:59:18 +0200
Message-Id: <20180409105918.20792-6-peda@axentia.se>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180409105918.20792-1-peda@axentia.se>
References: <20180409105918.20792-1-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: AM5P190CA0024.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:206:14::37) To DB6PR0202MB2775.eurprd02.prod.outlook.com
 (2603:10a6:4:a8::21)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 53950e86-f52c-4367-1f20-08d59e090815
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4604075)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:DB6PR0202MB2775;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0202MB2775;3:lJkAtdzzEUVS4pVyywgfet5uwJ3YI6RnXhhLrlu3FRgyMfD3s4Qa3ngH3Yn7SxctklHkpcah43v+cGuC5bh6NvY6RUE/OPPPLAp5AI90QBKthL+4pEXvKzvAMcb6i4AkpB+K4OS+dG4vkOfb/l/i4d2QsNIMzqbBZCsR+y66ai/MnuOSYQ7ep7y1c7s4oiUkSHJ2O5834j+E1FfndH6W8f2wGQwmpAjCs4vl9v5u4Q9TXZiri9jyF2LI62KVkFvM;25:qgDdlab2pY4AQV7FLX62vZgh2uzr3LG0PSGkxSuD/gXoUYX4B6zT6XS04kiV+heIwdekuGkMNWts2ekbZDiD7U0cMhTXVq36Z8ptm9/37MZqPbfLylon1/pFBxpo15CqNr9oo4cp+C4JxZ7u92TuHjyXklwA6pRjneTZnlu27HpA80hGS+ApgMrdqa/LO9yKquOx1d+zvMgE8TreUIwKjoATYH6uULLJh11XEDsyH/n3yikdvF3CocZYISzRO23n5qaQe1KyJ4ZuT45m416gA1STCBmqrg0vE1iiKtw1aKEgiP45/8wQiJj4pwARuqF6Q5v+3Bvf0MNK+4ZkRUmmSQ==;31:LOQ3K/o6CWw08d4QM7jwauD3iOw5Gl2fBdys9grzMyJg6/ljSCDG4T8BOJyf4k/Dj9YTujLuuELaP1dusHVoSLbd6xwFMCw1jBEjxRGqgKKJP55r4LkTVYIqXvXJiTF26ZF/YsGamZKz2K+J/Pi+g3La8Yd/gcJfYeL/HpKooIOWFWUerJctYNkd6nGfjiYHjHYKUxdJHXt7rq0m4mSia/2YKuVQCYVssCZ0zMC0ojQ=
X-MS-TrafficTypeDiagnostic: DB6PR0202MB2775:
X-Microsoft-Antispam-PRVS: <DB6PR0202MB27759AF579711899804A5AC5BCBF0@DB6PR0202MB2775.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231221)(944501327)(52105095)(6041310)(20161123560045)(2016111802025)(20161123558120)(20161123562045)(20161123564045)(6043046)(6072148)(201708071742011);SRVR:DB6PR0202MB2775;BCL:0;PCL:0;RULEID:;SRVR:DB6PR0202MB2775;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0202MB2775;4:D79m0jqCQrQwuPDkWRxAStFCUN4zRz//Lje5ZnOmyvhcX2/TVWiGE8oeDOWyEqnVVHFaQ5NFc/xV83e1HIKZAUplsR/zcHGOVIT3NPt8ljY8m5vF2vf3nwp2tdGftkt/3VH8KcfCKfumhxP5jmt87vgi/OvcrhncAZEdqKWGfLEUmZHbA7p504AGCLnRGDyW6+17aPX0Xj6R14H3Un4E4FgEYHR01IAGQVjgqrNGV6GeUjlcjRcrIb+BsMYLZ0dB2ZzGy6yfYlWSFM1UzlpJvQ==
X-Forefront-PRVS: 0637FCE711
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(376002)(39380400002)(346002)(39830400003)(396003)(366004)(199004)(189003)(575784001)(86362001)(68736007)(26005)(106356001)(478600001)(186003)(2351001)(16526019)(2361001)(74482002)(446003)(48376002)(16586007)(50466002)(76176011)(54906003)(386003)(6506007)(316002)(52116002)(51416003)(6666003)(6916009)(2906002)(6116002)(1076002)(105586002)(66066001)(47776003)(97736004)(7736002)(6512007)(7416002)(305945005)(11346002)(53936002)(5660300001)(8676002)(3846002)(81156014)(81166006)(36756003)(8936002)(476003)(2616005)(486006)(50226002)(4326008)(6486002)(25786009)(956004)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:DB6PR0202MB2775;H:orc.pedanet;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB6PR0202MB2775;23:al1cJhIuZA4QkxN7AKrVVtBcvlMXJTtArnvkrhE?=
 =?us-ascii?Q?S9kiHmEW4zTWmQ8cIyeG623OzU9rd7Cfs7vhg79V5aZDo7uIMr2sfNwsfDlM?=
 =?us-ascii?Q?VwiatQpPhTkCwOXurgYHxLKRqhwQULtGdYpPF08a+LO1LXnW3w4O6eqH88e6?=
 =?us-ascii?Q?imlNbotpr0mBnKvOz7mjbwBv//MHav9myN6/1KvQjcpPDA+bcSmwmGTayRp5?=
 =?us-ascii?Q?xBspdI0Qp31wDtwAIzfMOYVeoE6AXQtzBDTaui9Q8F7D8zKvk4i3C/iM7qgw?=
 =?us-ascii?Q?6i3yOyb9Oxa57mxGKIukN/wJaYoNBLlzCOFYQ2OR/cxgTbSUJUYze6bvxP2v?=
 =?us-ascii?Q?t1T+3F+1lAIHAqKVyUGdm2NqtC+viKs7BirfdaERCsBIOJdHs6pG6ru8JONa?=
 =?us-ascii?Q?sqBhz8uHuUe7juswac+3vkSCR139nICLWNJKFzvxynKr+tUXQUk9LQcu5Vw8?=
 =?us-ascii?Q?AMsgTa8PXimWliUBIOOV7GCpX8B9BaiIQKwoY3RxAVJOoFPR0TriNO+2+3CL?=
 =?us-ascii?Q?wGa6k0mMvS/trh0RRjkiC0WODINtAHLr+CNvQJUEe/G3d2ugD0DAgQMsQypu?=
 =?us-ascii?Q?cFxoY1YHv86ALkkKEzNuu2q638U2p4oC1pmWn4OPjaH6Hx6Ghwsr7SXFr4Sd?=
 =?us-ascii?Q?ciqjsNVdrercdODbCqIfT6ZCU83mpOJ2A8OkXw0bVL+0KwpCMJJl2Pl2AL2v?=
 =?us-ascii?Q?nuS5s9MSatR+sEUBuvnTnOm7A+pxWZuXZyztt89boxgPmbfKMwYEaj/CU1bG?=
 =?us-ascii?Q?OqZRADsqWQxXcHQUl2paPvBh7LnbEmcXh2ZrRCSHtPg120ZlZFq35tCeaZKX?=
 =?us-ascii?Q?bjyY/P7xufUOlKOYJGfYdU1v+ghfnxJNm5VYm1GhaF6vAdjdMrOsyABPaAWG?=
 =?us-ascii?Q?a+3UueSka7JnjM2BYYBE5CY/C8KWCoRAEIygTO64izIba/SM87xXGrbM1DU5?=
 =?us-ascii?Q?O7iUJmY97AYK44Sld+hyk9Bb9yXQlf9dHZSARPhh16NMwfty69FY6S2tROjQ?=
 =?us-ascii?Q?IziWpun/h+OJhRDIHOhkTPlc8FmnOMrtUGhV5F4Tknkuau8Q44uTroD2I2fL?=
 =?us-ascii?Q?NNpuVPKu7angvXljf9XVSgXl57VLlbjE2pSAZeO6lvNzdS/bP1mQpKGTY8JE?=
 =?us-ascii?Q?b9QDDKUOuroe1Nekju3nFICwcgj3H4FSXnKXzdB9IGCUNQ+XmXDtSL04rctp?=
 =?us-ascii?Q?xDbawrBa6ql5JXmENch+dtY6G8qOHigblFxNtW2zf0CYz8sy2jEmMIahdZOK?=
 =?us-ascii?Q?piGGXFFpE0TZWmnwtx3Ncg3I7VZMYyo9GuP1SaxyesnfRYHgPfSh/T4tesYR?=
 =?us-ascii?Q?m91erIKkxzDpncmwFCj0rAUu8atd8zyxdAoDItKrxrpAi?=
X-Microsoft-Antispam-Message-Info: /39fQc7aP1sv81IYe4kImc42SFZcO5F4708YBqjfMMYFC9WJ6L+qNmt/fB8O24dZOI5c4Ct2W7pprqPSLjxlnCpZ01rRzOkn1uXRjNr6HxgxekjuwQzGKltxPaqTntJk8Tdz/A/T8nWijiLr0nX5vJaLxBmp26RBOSNW8dze46KWX8P9s1zjllXp22TjMSlO
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0202MB2775;6:DjvTJAJUmTsbppkDbU8bXmzkX1+zJoyhVNCrjalh+k++HmMQh0zODxm/tVaLqlzWfNrU0BYiFlHdLCifEOWoVqcQNzoC5VhzxjlbKyymrDrNx43kUwsCi0E1RFfZfHBWJlUY6bVajr5OYgKQKaT/C1eTaEguQYUqVm010r/3+EYbFuOo8HDTmMDir6ldrVjzKRNN+Y0EPZZiWk7NfNp/SKn9vZr0A77S7C0n7lTgLaRJJB+uk/EOmTRsYjOPcI0Pu3OJYtWI2ffjGJsmVZ0gHJ9COmuYwdBbO71iYadW2b7ClTjM8wGKeai+WbVi8Ub2IN/OapB0R8hmLdC3w4FJm6viOHYiQwcWFL/XdMktheP9gApHR68jaWGmLFQvgyaSkGUtb0V9JfRW7YzVliav7l6BMazLPnqSwmVMmKwTQkaz+iCHMJ/GvN1sIpVhttPG8VEhEhjlVwMcUOEY80gd3w==;5:Nt7kvpRg3A/nnDr1ZUnvL2w4bC9ZXLICck7qPQ5Tr4XNnUS9wExYfHlKrAqjfbFtANgYFos3IhK5e6TtM7yyamPxSGQY11bq5+Pz/Nf8OeXasJ2iW9pLQGUMxJCy+h2oN6h9iL4ZeAiQYB58AMczTUOejPczarkc46zHnGEK2Qo=;24:nQeEglmbyvOgTKW61GwNO5y1qhIo7hvv1BXT8aRZaL7Si9iwGtkoaQpj1qL+PtOG4D0GZG0RmmVQC7lZ7+VXQhHHfGLfgHUYjZEZamceHpo=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0202MB2775;7:Z181EaB4QBAY9wfa3TGifuAYAmP3jZkOcoKgY0AP55zLnQlG3xiu5NRHgJHu5FqGnyHWhhhZ8jZT8NMEdPibiqvLEPdv8Fbc55vH7oR90AghqamNk4uyMcO2My5fjO6znXAKhnDoidbOvN4xVfbpXUqFGBQ83WypE5Jq0F5Ku7LYxKLRmtaJO92yZUHzZqXhCxqTqpQEwzZYWUYsIZoFyo2/N7xUQjZZhtk9gznb6nVzpEAGWPVDMMBZC6OsrVWb
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2018 10:59:56.4039 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 53950e86-f52c-4367-1f20-08d59e090815
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0202MB2775
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bump the minor version while at it.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c
index b411038890a9..aec0e0e05edb 100644
--- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c
+++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c
@@ -782,9 +782,9 @@ static struct drm_driver atmel_hlcdc_dc_driver = {
 	.fops = &fops,
 	.name = "atmel-hlcdc",
 	.desc = "Atmel HLCD Controller DRM",
-	.date = "20141504",
+	.date = "20180409",
 	.major = 1,
-	.minor = 0,
+	.minor = 1,
 };
 
 static int atmel_hlcdc_dc_drm_init(struct platform_device *pdev)
-- 
2.11.0
