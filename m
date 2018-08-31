Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29DA1C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 09:05:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6EB320837
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 09:05:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="tj6AMEsK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6EB320837
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728035AbeHaNMA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 09:12:00 -0400
Received: from mail-ve1eur01on0067.outbound.protection.outlook.com ([104.47.1.67]:64800
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727703AbeHaNMA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 09:12:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xoM/W/pnDrDICSM03ZPdfkhcJ/XaOury2+BzaFD0U2Q=;
 b=tj6AMEsKHmKFQ6GELsrJl/DyBmVEOg2+F33c6Lt9AoYkCV+YYcd8excaMwNVsyGzJb7BMQ51K7a4ZkJ6UIuoo40a39HlmKtheWlIb5vYXLE+nHj7bIsw04f+3Kr1X0SEx0zObXDl7G62oNHVu2Si9X55BYyoRVxAC/uC2xnsxLI=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=yogeshnarayan.gaur@nxp.com; 
Received: from idcbfarm.ap.freescale.net (14.143.30.134) by
 DB5PR04MB1032.eurprd04.prod.outlook.com (2a01:111:e400:510c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1080.17; Fri, 31 Aug
 2018 09:05:23 +0000
From:   Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
To:     linux-mtd@lists.infradead.org, boris.brezillon@bootlin.com,
        linux-spi@vger.kernel.org, marek.vasut@gmail.com
Cc:     computersforpeace@gmail.com, frieder.schrempf@exceet.de,
        linux-kernel@vger.kernel.org, david.wolfe@nxp.com,
        Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
Subject: [PATCH 2/2] mtd: spi-nor: add entry for mt35xu512aba flash
Date:   Fri, 31 Aug 2018 14:33:02 +0530
Message-Id: <1535706182-26804-3-git-send-email-yogeshnarayan.gaur@nxp.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1535706182-26804-1-git-send-email-yogeshnarayan.gaur@nxp.com>
References: <1535706182-26804-1-git-send-email-yogeshnarayan.gaur@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [14.143.30.134]
X-ClientProxiedBy: SG2PR06CA0128.apcprd06.prod.outlook.com
 (2603:1096:1:1d::30) To DB5PR04MB1032.eurprd04.prod.outlook.com
 (2a01:111:e400:510c::18)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 475f7161-5dea-47f7-ff96-08d60f20e484
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB5PR04MB1032;
X-Microsoft-Exchange-Diagnostics: 1;DB5PR04MB1032;3:NN3ERNK0CchsXoH5rwMnpfD+mWQoO8GQmyDzNng1K+k9bN4UV3Ef0/aC25iq1Xf/C8BjK12BszzBQ9nqZNcD3GGGEvEe3hu0xr25QhA6/oai6+ILuy1eytXcCM0DIFGK83WaK+VBne9PTEqf/sbBTPRAYK+sHW+16gVxE7YS5Vt4ut2XIpHUrf8V3mxxNt+0ACJ4BHy2q1KzR1SGw2SCBtS/OHqMnYki6UHHMNtRc7d92UgLTyFkGIlYIms1m5Ut;25:tAaECMJanA5nWxHkdGxR71ceMF+2NjsZppBysLd9UtW3NqYnnOpwg4e7GlkG8gpAjOlk+VGVDELfyrb48FRz1ldrWyGI5L99442hWgksoqfZYL2iObE7QlEBlVtL1QSzOYZUQuovAqBNESn/osr7XToX21UuXxgKZRLzUWp9TblPJN0fRdWpPef3AwOMWTdfh0mK3rDit9w/ht67ODmGNwSEq8HPMP8Xk18vmivUE7AEOvf7GEiEvHTKrTVEBiLlvvaah/jxZ8cB0u3l3vxI+x8jr4Kd2ZObD3JfEL6baLtB5yBOdrZoWaTbOd9QotEYqUTzUxTgW6OcDarrnj/qtw==;31:YsMBs4Skl7BVjDx8WxZmZZS07tu/Ymy+p+rxrNXbWKJXOi7GvoYglTIlavAuBbvw3Izr/Vbr2GpOzBFOybw4tCG7Cp3L+/mIoxag9dkSTzTckd/37kb4gb5CDC8aRASRJi6UkuaQyBuuLaoWMczH6fVES4t07MK9zZRXQRcNg8ieP2RHyiXRCimOUZA0bXp0q4mQ7L01eO/Bf52HRfVh0++pVUw6Mwlma7Yox5cCDtk=
X-MS-TrafficTypeDiagnostic: DB5PR04MB1032:
X-Microsoft-Exchange-Diagnostics: 1;DB5PR04MB1032;20:MsoLf++YTc/9dySV8KaynXWrPt778CzFIPXZ0SzUM4h1RbPg+4fzYZpCGObjE5TVURR3NhuOc0WEp6b8y0WhiV4/+ipNUIIPh3m/Jc2clZ6xa1XYbj9KkPdzbDTKnMEIdJEL78NMgpN9JQ82EvYpj4EWKSvr2nVNZknLb6i0MLp1TaQBd3RgUQtWOgPGlJ1FB6LpzSioWsv45gm9fkfMv8K3lmmdOzy+HvrXvAWDIyyQ6DuGcn9+XjmnYI2ZS6IntR8Asy91SyRAw/U1GdDwHcbaGkSEo/ONSgSPXnxwNmny/BGW3IHlSao3Av4wriEEcPxyW2LAQe/34m3HcicmiQQ3Lbq+ZGaTnucZxDTmgBj4P7plMyeRzxZnX4HoFLI+nv5fI86zhr4/CLeAWlU60LRk/aFH2irEn/vCp21HxLYKGHCY/tPeL7OnO4JM64rYik75+gKVBTz4oksiqOO2ovHsoUbcVl4mpLhElD6Qq8XB8yq3tSdkHHJMWLPl+rkz;4:UPpfWO1ZbJgsrOOSdKBXTvhErlGO4/ceh5IOj3Yaws+SI9O0a5SOhIGzyfLAcLHlJz9WT2/HcRUxy2pKQkTjJ0f+YpFdwuU2wC4m9vA621x305Q0Ix/1dhNHvRUuiJu6DHGwR5w8OZs5XHVNSxfb0EMH4Zs+1MLU6Ue/vGdVNo2RRg0Aa8UewHiA5I5jMyHNKWUQlZocktFLkrVrk1MDh4iFrOtCCgbOUe5mlbWHT8pVhwkWZhOiyFfjvV5r9x1VQTR0c7nNpatbYbhl2pKfh+vhM/QLGBRr6gl4Z1mKJ8mIEnFoZJ0GCHqFVk1DHrj1
X-Microsoft-Antispam-PRVS: <DB5PR04MB103236BAEDC562E60B681DBB990F0@DB5PR04MB1032.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823301075)(10201501046)(3002001)(3231311)(944501410)(52105095)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(201708071742011)(7699016);SRVR:DB5PR04MB1032;BCL:0;PCL:0;RULEID:;SRVR:DB5PR04MB1032;
X-Forefront-PRVS: 07817FCC2D
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39860400002)(136003)(376002)(346002)(396003)(366004)(199004)(189003)(316002)(6512007)(6116002)(55236004)(8936002)(52116002)(5660300001)(26005)(76176011)(51416003)(6506007)(386003)(6666003)(50466002)(305945005)(7736002)(3846002)(2906002)(53936002)(81166006)(81156014)(5009440100003)(106356001)(8676002)(105586002)(48376002)(68736007)(478600001)(4326008)(47776003)(486006)(6486002)(11346002)(446003)(476003)(86362001)(50226002)(66066001)(16586007)(16526019)(36756003)(39060400002)(956004)(14444005)(186003)(2616005)(97736004)(25786009)(110426005);DIR:OUT;SFP:1101;SCL:1;SRVR:DB5PR04MB1032;H:idcbfarm.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB5PR04MB1032;23:5NAsSQLVYmzOHWtWEhQ/xWrFAa/WeM0FyUzt4VQsg?=
 =?us-ascii?Q?fsn1fmVl4WBvlS2cQ0tyaaWAw1Z9vsmt2K+DIBxF2uELeTaMM0HEh2XPdx5i?=
 =?us-ascii?Q?xeMslwyjqUzi0xjKvIg+6dzQF65ww6jniACwdHVw2dvuzi4SAB+R5Xdg9JmI?=
 =?us-ascii?Q?9u+tplZSpT/nBy52gGRpKpA/hajC/66rKhZzZVlL02zoE8mhI3tg8hmywiiy?=
 =?us-ascii?Q?h/z6YkrjN/cP2lb3JDCk54Fs3hA8cy3BRZIR70E9PAeVhthWmZl0Xc9ZsW7D?=
 =?us-ascii?Q?qx5zWuxX5e0oPq2r9p0eEtH9JyhBgyuJ1GXt//66I2TzLQFNBVTEp69SL0p7?=
 =?us-ascii?Q?NxziH+yHxoDU8fF4spejlrlyJfOZ9LzTeG1q5yaVDp+Dtot4vAB9x9rxbjMz?=
 =?us-ascii?Q?9maTAbMv2mt63WMk8/zmHaC94iBoN2Taa67kD6rOm6+9uKfQ6QEz7u2iiOgU?=
 =?us-ascii?Q?R6i6zlRUdEvjDHK0BVsUzT0csgvfRV/JPJoeUhnpFBRerfweif3ncKAEX6os?=
 =?us-ascii?Q?seaS15S2z1jF4P6cFkP2slH3rVpqyMicvDPvpBOk8r8Kw+jkAgGaUswfVOlC?=
 =?us-ascii?Q?tqumbcyoL8yjDZwaDb2hB8e1B7abWO87eta12BuD6MPL36tERnjc6itc5gyq?=
 =?us-ascii?Q?4dR+duFwOu2n2PX6ftdD8AR7RQYNNdyxzDHLcfTBiJkQBcw3yMwL07JjNo9l?=
 =?us-ascii?Q?w/jE9PuXEuvoJly+lGZIIxneC64exWd66I6PqKw7ULnYTASIhS4beszIV1lp?=
 =?us-ascii?Q?QQiFG8l00iP7PCfIFdjth3hevr9zifjpz1d2ox75pO268ojd/qb50X+1c9EC?=
 =?us-ascii?Q?/Q4GI2PcDVENQAnw6DT1U/NeR3uJD8joAGR3VvnKEXxH0H0831FkMrim1To4?=
 =?us-ascii?Q?EWOouhtYN2ntDZaYjiOpIQ3EeBD5S+A3EmKmD1/W8gmyoVtzwrt00kmhNO7f?=
 =?us-ascii?Q?HJ4fbIoLKggTF33k9LGZ3ALf9IRB/kBI9f9vC7DYoLihQWG5fA4WPXqDfd12?=
 =?us-ascii?Q?NIpMxF2RI4vgSRoolbS5X8UJIzIpVl25SlHrcOdl0mn4/N64o4tSl0TW/ysi?=
 =?us-ascii?Q?7ALr9TGOSvVSFRQit3hAc3aK1qJQlQr7zhwAssLSA84jKd7aWzv2rBq8ki1Y?=
 =?us-ascii?Q?1mY19owbvAafBlYiwMElSnRRLJJjb99xSlKxff4qaA+b/thqhlp3ce0VUQAV?=
 =?us-ascii?Q?l1U9Ne0e+ZYRanBM9cHYCQDN0EskjBl/KGahXd0n10iqSxySk5/VCF/o0SSM?=
 =?us-ascii?Q?Px+fnDqd+NQu9yHjZ60/3mG9jA6gkmMfoW7vQRo?=
X-Microsoft-Antispam-Message-Info: VQ+jvxHjz0XGvJVX4JuOSu5e0/OtvX8T9EHh/wA3+uly0ryPb25C//2zsMYxXiSqKXqwAA8GaRpS4+0sXFmZvB0o3ykW11bFxg+7ty+d0jkit3LIeXtqvtM2IunR7qi2TtNAI1sIc/v074z6NZWeYPmcwW2nQDFZTL666dofQFLQl+i2IqU3fy5jNU1/GnrtH0C7xsNWD5mxY8JsNW7xQ/vwnmqsAy8uqoZbmBhD/ph33XSCkE5BnWD4VblZXpqNwz9eZX1H5YcMY55LFodorfObj2HpDWKZ131GxgkF2NbF+UVsn0l3xejZz/RcCS6lVQ+4mP38+PmMO95GTI/ru7Pl92f7iCU2xN2K5yq96gc=
X-Microsoft-Exchange-Diagnostics: 1;DB5PR04MB1032;6:soo5UVl5oheLeK81nF3PJ0sjJmumDljexTvvtzQnNGicZ8AbwM0g9V1EBJNZiZuqq3eppWSKHvnETZg8I7a9KfxUDZxb7ylSXCyAXq56Uw63iaaE64XkstizcMAXsgRRA1Eq+weIGGjAf7wbdYOcleZjBRaz0jloQ7tay+MZcBiRGlegkeJwri7AwvCdsk0z/LWYN+43phg4xHSZn1UO2C2bt9jqOsOeEb8blOnkH1PRCPRzJeDS+oAbaQ8olSd0wwmoqNAc7qkZpUZiNtvk1jS/Psm8XhZfNMxbw0ZOqt6WKPqONP1SLhNr0cuZ2kGPW5hJU96d2ilH+TxmvlVCqheNc912SwWx9a7MpsE5C9yUOa6ZtTmh5BvYXiGuDDfEdkabX/Idyh7BNJWBqjmHammEcK+MRjq2FV5+c5rq3dhZo32ifImT75ifWCNXuyoaDo3XX3qBp1IkBYSTi/BchQ==;5:CkiprXA6w3limosxpQPX1ns7YXWlt1Vt6pngIj34e3AeAn+MN+2Ckv+hbuH01XPXRrEafWTYeSBK6a+hOOpqIiTTK4KiWUa2fBFysUxWi3Ay2zRLsHr3aX1dgPjk7iKqjhfRmIRsgUfEUVelZa7EZGjdq4TyxOupJ7LifgTkF/Q=;7:VdGxQ9+nTnByMOC5pkSJJrf16dOv5NFcaMmY5W+43EqsRxLHdXBPGUgtaRJ33shA+5rs55Fl2RjB07BZYvGXNH9jOUks9bS+hXe8bgf74LJj0P938skV6hmcJC9xiKJFE3CmVb0BLCBlQfP+G7WAa9i8blckOgYGux20DdnJj01CfTnEcdg0C1Le6cJfig9cZNrZ0Oz63174K973C6mHHpQ2x8iRO4wuz8L+yDZe/MJs2H8+ErTrWaNikTOGycA5
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2018 09:05:23.4189
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 475f7161-5dea-47f7-ff96-08d60f20e484
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR04MB1032
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add entry for mt35xu512aba Micron NOR flash.
This flash is having uniform sector erase size of 128KB, have
support of FSR(flag status register), flash size is 64MB and
supports 4-byte commands.

Signed-off-by: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
---
 drivers/mtd/spi-nor/spi-nor.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index 33a55bc..6042df8 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -1113,6 +1113,9 @@ static int spi_nor_is_locked(struct mtd_info *mtd, loff_t ofs, uint64_t len)
 	{ "n25q00a",     INFO(0x20bb21, 0, 64 * 1024, 2048, SECT_4K | USE_FSR | SPI_NOR_QUAD_READ | NO_CHIP_ERASE) },
 	{ "mt25qu02g",   INFO(0x20bb22, 0, 64 * 1024, 4096, SECT_4K | USE_FSR | SPI_NOR_QUAD_READ | NO_CHIP_ERASE) },
 
+	/* Micron */
+	{ "mt35xu512aba", INFO(0x2c5b1a, 0, 128 * 1024, 512, SECT_4K | USE_FSR | SPI_NOR_4B_OPCODES) },
+
 	/* PMC */
 	{ "pm25lv512",   INFO(0,        0, 32 * 1024,    2, SECT_4K_PMC) },
 	{ "pm25lv010",   INFO(0,        0, 32 * 1024,    4, SECT_4K_PMC) },
-- 
1.9.1

