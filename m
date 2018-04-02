Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754163AbeDBDWu (ORCPT <rfc822;w@1wt.eu>);
        Sun, 1 Apr 2018 23:22:50 -0400
Received: from mail-bl2nam02on0074.outbound.protection.outlook.com ([104.47.38.74]:35214
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754048AbeDBDWr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Apr 2018 23:22:47 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com;
Date: Mon, 2 Apr 2018 11:22:29 +0800
From: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To: David Miller <davem@davemloft.net>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/2] net: mvneta: improve suspend/resume
Message-ID: <20180402112229.508e1feb@xhacker.debian>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [124.74.246.114]
X-ClientProxiedBy: TY1PR01CA0179.jpnprd01.prod.outlook.com (2603:1096:402::31)
 To BN6PR03MB2625.namprd03.prod.outlook.com (2603:10b6:404:59::8)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 35a4f4b9-fe0e-4faf-cfe5-08d59849011e
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:BN6PR03MB2625;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR03MB2625;3:uwNhHBJlNDcR7J2liZiu5xctPfQ4ZvZyAWagCZYX05AHPXYbs8vCvULmF27C/F2CLAoMa7ynayt4FA+5yS7wg54YOek5g4WgdfVdNOQtlQ/Gn79cHSGVyk/2bJdvHp344bbxRS8nOBYcz87w3Oiyrw4g+j5w1EbNmCY+16ADgMoX3NrSMrHoTwUwEZ3A34wkHdXlKtYYh62cjFVkpoyDCyZNFvij8vsowyARXa0EVHlFMnLaf3ZpHzO9z+yTrex1;25:uMBizVHBYAU1BN4d53U1XQc7H88uayEvNrU4MIFCatAVoK+IEda+qDe7jlp/4AfOF9lW2lBSnnJQkFLlUxIGc2y+rYRpUsMslZJs2tq/2ndjNXjExQjiru30YmQ4Fn6S5YDQCdsU1QojeD7KKzvSmVNaeR1kU/y9hNN/F7OxI/ItCR9zXgSAOhbUnbSa7R72vYuH3UGIKthOyYLGeddWVydh1PJcj9nEV1F40EJlAFQ8w48/B9sijneZbj3YsG+3aZE0HBbMR8l2vFQXiRGWEF+WOFCw5QkGcOnPCRmutrS2vyjdmhARTOf80zJxAEIvyO2/xjbZh9I6LMHLoGyjlg==;31:m5c/sBgUU/QOYOHCEZm8jdUcFZ9qW3p5NXQDMPKg9xS/HswFQCyUvyiO0bdk7n1FajRcc1pv9ounGbUP+5X0eZcz4cNmz10vuVInwjgYYKgp1HEorg3yLKkq2RKD0AH8qdOvyABejGBGOfZNlkeYjdNwDa3KZ/gVUCsOh/iteeTZHDG4ey6ABjHi0n5wkk2gyEAAwyNShrok8a5iJSi5MGzQksGjLSvqmwmmGoNxviw=
X-MS-TrafficTypeDiagnostic: BN6PR03MB2625:
X-Microsoft-Exchange-Diagnostics: 1;BN6PR03MB2625;20:j+xS8ikXpXXf811D6B+jZi8jE+dTP2TggPHspAIBICXCgpgLmaMtRlsDcxdlKkVvzYpcR3KJm+rl4Vfwde01j7Ke16+OId4DOXgfBmTI4sRhm1RnJdpEwJNqBWZjnsfFfw4EGYeAlTlQiwVR8UIQVq9a5/TbFu/KJZq1xijE+36JjhPxTK/zVnvy1gHAyC6OI/00neTkVeMARZzEGZ2nuPq/PBEp7txMRz1pVqbrayBMBrkF8S3HVyTi3vQj+3hKsjy7rIqOcMIfIca+XQIv55AosX5bqyQHBaE3dktEXvDA2HZbvh1uOD7iQ8r+uXPDc8zCdFo4/bKwX+urT5moev8nl0wrrx625lqYASJWl9KdFJUnDzza4/kS0gxv6otuFNVMG9fk4PXKlllxPyTeYDYg2lavvCN+TW88KlMgH4BQEpoQIaSsDeHV35JaYzp9WIwY07cQ1ocCpOH9muETGE4Nf7zTh4xgOEc1BSeKPmjROMGEiWqVaUBSn4ktzTyS;4:U1aLNryIyUlAQkVZybiaNRu+F64sfBB+EGahcOtgwQxOr9/WwXkNQezlGaP8QUIiXoA2MuTIiMOWZZqOzsIPlBlPJpv9CSgO8ZOcYdR07ltZrZluAcoGKNnqng9nWRrUrLnPJ4UxFA5aOs0mP/L834rPCDqY/Nwo5f+4JRb5OuX6yTN/0uMXfgz2wj3ruifOexhFXj9rJSUiEws/6ZNsy8oJFIk6H1x/8GCdY6E4ReyaXjZj3CePINj342eEDK/84vQkmAjSOg/l8c8wd0YK+g==
X-Microsoft-Antispam-PRVS: <BN6PR03MB2625AD992879B08A35F748ACEDA60@BN6PR03MB2625.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231221)(944501327)(52105095)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011);SRVR:BN6PR03MB2625;BCL:0;PCL:0;RULEID:;SRVR:BN6PR03MB2625;
X-Forefront-PRVS: 0630013541
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39850400004)(396003)(366004)(39380400002)(376002)(346002)(189003)(199004)(55016002)(26005)(7736002)(6116002)(3846002)(66066001)(105586002)(50226002)(4326008)(25786009)(47776003)(186003)(16526019)(8936002)(230700001)(81156014)(81166006)(8676002)(53936002)(72206003)(9686003)(305945005)(5660300001)(106356001)(476003)(50466002)(386003)(68736007)(6506007)(110136005)(1076002)(23726003)(316002)(59450400001)(33896004)(956004)(486005)(486005)(15650500001)(86362001)(97736004)(478600001)(6666003)(52116002)(2906002)(7696005)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR03MB2625;H:xhacker.debian;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN6PR03MB2625;23:eEb6iPR72o4bxoDJ0i7KGBfs/WlH+Pix2l6XhcUfJ?=
 =?us-ascii?Q?wM6P0jaeyXqWy8TXbwWfVnRZ5Royk0wgQ+5xLniebwTN6HFaopXo5Wf4aGwJ?=
 =?us-ascii?Q?MInkoZ7a/i/3TtENIpcpJnMBXQazZUT1ACTTZEGBavO8q3OVhKVL8CVd/m37?=
 =?us-ascii?Q?Vemxn/aIBGf/iIC8+gwrfx9dHYRFtw8x1A02LArQuhIHfOwatuJiSVdPhan3?=
 =?us-ascii?Q?QStzDBXf+GcbEN7zHigFe0LYpEjsaZSBql6r3rndPlApzF9XDrWZ4Len0y4q?=
 =?us-ascii?Q?TwGl4wOUsSMW2NGpX44K5nI+ecTQ41rcqdtITuQMLsMhT0qexFaGHt2ih/J3?=
 =?us-ascii?Q?hNlsepjiVwAyMF60Nry0IBvm117JbuZaEP0b/kuOeVJMqbi8u2ZN4L3UgY4y?=
 =?us-ascii?Q?Dis8LkLMoAN6nxsYuNVEnvTKb4X7a7YkIa7RGctwSFlb/VByhGcVcBj1PjaS?=
 =?us-ascii?Q?DW4rbFfIaeYTeuFzyOlJNIPz5ZpH4rpQv8HlJZwjpjt3yQBhCm2qgOtneaeP?=
 =?us-ascii?Q?F2zvJV3DMkNcVY17tpRDcvlpbWX+3kE4S3p9rJZWR76dcf8ZCBomKBK9JbQw?=
 =?us-ascii?Q?6AXqtfTe+s0ITUCm66BHGRcXRYCNPyDx15MB7p3j8kzU/SAofZ6R+wafMU1D?=
 =?us-ascii?Q?1mNm70pgU2EW+DnlpNO6GfaaHCBGIhoYBWvvwNhkOq8I/Y4hI5j09XKDVH5E?=
 =?us-ascii?Q?p4qC/tyaTO/4mME1r82izZGvJtDHTnwWn2EMVWaFcvYX5YxawTMk3bREQjc9?=
 =?us-ascii?Q?LBfws4FLssHA5ZVpSM6NKggqDorXmLV5G1vWRdfBGphzhAjXIOD/MnfBHZLe?=
 =?us-ascii?Q?FWSI9rDRrTNpIfdaDTTkOHDtVBpoRq9pAA/HLe9FFFnn0ajhWmXDysD6q0x2?=
 =?us-ascii?Q?BXIzJ0w9IhY5TW7hxRfc6AoTsFRjP1obvBR0QwijTMBLr+ajdBn+FriFhpcw?=
 =?us-ascii?Q?0PUjKey/88H/sJJKa5iZcjGCLrYKw+OZ9ey65M95ocK+dB9yRWH7xPwZzaX7?=
 =?us-ascii?Q?JP3ZQC46CuJiPsKhTMXOKkgieLhPcLWTnLfQRxx924CAt5Xh/dLV7mB5DBHi?=
 =?us-ascii?Q?/LN1OHAQTX2IyTo0W8R64MUyzht5gJJfeOHhiAquq6mEQts6cZCANckjlNxN?=
 =?us-ascii?Q?n+zF1J8M8z2fwXNuCjjTln0J3+F2H/kB9oYrDCPEcbCLEtRalHW9XYIeLIFk?=
 =?us-ascii?Q?9yYKvK6oGTNSxYdcjyKALV8Y1n6/4AduTdEZz+Zb/MsItjJa1gI9iioTRC2j?=
 =?us-ascii?Q?ZXKRp87a6A4p5rSFzM=3D?=
X-Microsoft-Antispam-Message-Info: +67V7cxBg4WvpxFv5aVfJkY6JiTTlq0vjr+oD5iOuIMzK2ekP+dvqL02H0zOI49Y1yXpCBm+JqPXLbHV3lXHucuSwPwlxtvEHeKOz2UNPleBgQ56IYTbo/f5qSf2kEf+mW/M5yJh7kihCw/h6Co1fpLzIA3ae2ISZqpMtmV5tVR2mwHPs57HAfWP0lAmqc1x
X-Microsoft-Exchange-Diagnostics: 1;BN6PR03MB2625;6:cVek/qc53sOhroWbMxDz1AmXk5+6oD84GHTM0LbUK0bUIeQZv4xJsK21l5we2+I4RwWRq2cwsDflIcsT9ZXLcVZW6so4kAYM1eH73QRt/jYLmroUSgRduYRyjmzyLZQmxDh2MbenmmheOiEtnXjGeRS7hc3WMttdF50aSBNjhXRmMVRU7z5QWrPQcTfa+XitDsxwOflEYRX6hC2YNkPCmsZkpAIIDmxkNCFrMGOtK+OcmX+vafm4omR6fJ4zj3GV4Ntv4zVfwZEvt6SlZkF1e8gU0LsBbj8tXGnA3dPBOWvc4DFrEF3JQbaWk/tplEGDE0D45PqBoLtGd7bAuZEJ85RyCba62DhLEaOyKrDCnNXLYNf6geSG3AB0BHAfMjQearuFPpzovnUCcrLemnaXxws4RS4n8H5fSlkkKNIjidEo20Vp8CrqHwkBWkES6/SQjp33+KQBemthT/3tt2h63Q==;5:gtnpjMwNFbFaVC8Cwz095IZp0NUY6ugP8fdtlHDF/cihYU+DsFXrj/mCsdtwlb7x6YLHb67S9cRf62mon0KmJ6PYk316dxFfowOGoVxhEHcreHDYBUuVFoQ2yNsAAL9cwNXf0o50ZQ4TK/NQioXXqab57Wl6mh9cHrrpOww7aeM=;24:xP4MrKvcey3M0x9Z0X5oaAibvl1MjMn6sxdjqzeavtFc3/EwJt8W4MtbLQnyb7k9DDg4ifj3CMM4XQ+rc+tdX08UiSHzSpwiypOuMAwg+eU=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN6PR03MB2625;7:vggHeTghvcC920V0uF/4OJrOYBuzljDIExqrB32UNxHAeCYYTT3FmygGZVmjBl1FKavEIGy+tYuyHzXroMw/NBEMFdyU9z0R51EaFy0IjOe6vixtizaVxt0MbVv3Jt0iNiG0TTOoP7LxM5SbZSmBE21pxKFXyzvFylvEVzVzBWQGjWXjlYLtLsjShG+uefFiMtSeXT+oljwBnYUbs64h4YMFKFJya+Gzh/FNBBBeb42sMLbJacKY3+CbZoNkpt/4
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2018 03:22:44.2979 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 35a4f4b9-fe0e-4faf-cfe5-08d59849011e
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR03MB2625
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series tries to optimize the mvneta's suspend/resume
implementation by only taking necessary actions.

Since v2:
 - keep rtnl lock when calling mvneta_start_dev() and mvneta_stop_dev()
   Thank Russell for pointing this out

Since v1:
 - unify ret check
 - try best to keep the suspend/resume behavior
 - split txq deinit into sw/hw parts as well
 - adjust mvneta_stop_dev() location

I didn't add Thomas's Ack tag to patch1, because in v2, I add new code
to split the txq deinit into two parts.

Jisheng Zhang (2):
  net: mvneta: split rxq/txq init and txq deinit into SW and HW parts
  net: mvneta: improve suspend/resume

 drivers/net/ethernet/marvell/mvneta.c | 154 ++++++++++++++++++++++++++++------
 1 file changed, 128 insertions(+), 26 deletions(-)

-- 
2.16.3
