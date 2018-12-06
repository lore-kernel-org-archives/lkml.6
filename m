Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0FC3C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 09:11:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91BAD20892
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 09:11:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="DbrdIKiA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91BAD20892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=analog.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729327AbeLFJLp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 04:11:45 -0500
Received: from mail-eopbgr800084.outbound.protection.outlook.com ([40.107.80.84]:21110
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727575AbeLFJLo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 04:11:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WyarRSOV1f4lA5z6kpYOmMNoQDx9VUy7WrEGYg+mZbM=;
 b=DbrdIKiAOcw1JfCLFdO2wJ8Z0GIID3ZH4UuUC1+cV2+vV3Qns41nO0NU64plX3cFOF87F6s1wcgMAJReeydV0/Irlbe1l155DZ6zodncQYuQgH1xe91R/iJhLA22IAi6AEwE5F6+UnbPQgVRX1v8qHFLtUFIpceCcHTxkOIVrWI=
Received: from BN3PR03CA0112.namprd03.prod.outlook.com (2603:10b6:400:4::30)
 by SN2PR03MB2271.namprd03.prod.outlook.com (2603:10b6:804:d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1404.19; Thu, 6 Dec
 2018 09:11:25 +0000
Received: from BN1AFFO11FD010.protection.gbl (2a01:111:f400:7c10::178) by
 BN3PR03CA0112.outlook.office365.com (2603:10b6:400:4::30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1404.17 via Frontend Transport; Thu, 6 Dec 2018 09:11:25 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.57)
 smtp.mailfrom=analog.com; gmx.de; dkim=none (message not signed)
 header.d=none;gmx.de; dmarc=bestguesspass action=none header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta2.analog.com;
Received: from nwd2mta2.analog.com (137.71.25.57) by
 BN1AFFO11FD010.mail.protection.outlook.com (10.58.52.70) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1404.13
 via Frontend Transport; Thu, 6 Dec 2018 09:11:24 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id wB69BNcu032418
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Thu, 6 Dec 2018 01:11:23 -0800
Received: from mircea-Latitude-E6540.analog.com (10.50.1.101) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Thu, 6 Dec 2018 04:11:23 -0500
From:   Mircea Caprioru <mircea.caprioru@analog.com>
To:     <jic23@kernel.org>
CC:     <Michael.Hennerich@analog.com>, <knaack.h@gmx.de>,
        <lars@metafoo.de>, <pmeerw@pmeerw.net>,
        <gregkh@linuxfoundation.org>, <linux-kernel@vger.kernel.org>,
        <linux-iio@vger.kernel.org>, <devel@driverdev.osuosl.org>,
        Mircea Caprioru <mircea.caprioru@analog.com>
Subject: [PATCH 2/2] staging: iio: adc: ad7192: Add clock output option
Date:   Thu, 6 Dec 2018 11:10:52 +0200
Message-ID: <20181206091052.7644-2-mircea.caprioru@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181206091052.7644-1-mircea.caprioru@analog.com>
References: <20181206091052.7644-1-mircea.caprioru@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(346002)(39860400002)(376002)(396003)(2980300002)(199004)(189003)(53416004)(36756003)(16586007)(54906003)(316002)(48376002)(2906002)(478600001)(7636002)(305945005)(6916009)(107886003)(47776003)(50466002)(2351001)(106466001)(1076002)(72206003)(4326008)(5660300001)(106002)(8676002)(51416003)(486006)(246002)(7696005)(26005)(50226002)(8936002)(77096007)(356004)(6666004)(186003)(2616005)(426003)(446003)(336012)(11346002)(86362001)(76176011)(14444005)(126002)(44832011)(476003);DIR:OUT;SFP:1101;SCL:1;SRVR:SN2PR03MB2271;H:nwd2mta2.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;BN1AFFO11FD010;1:H/U8RFamT0/uaENW0CCbOGmeiB10iyAPZ5xfWpQRWRFY3cIk8+eP/QoakzNiddttGg+qMukprdBJQJz+iHMnMeDe4Ecfr9+Ml9vwB/Fk2OVI2nPo6w1Fy9tqTKK4+66l
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bd9372ad-d73a-494c-b28d-08d65b5acc34
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:SN2PR03MB2271;
X-Microsoft-Exchange-Diagnostics: 1;SN2PR03MB2271;3:FE5x4glBQq7u/fg38f3orUfdDxNV1IP7kziSOv8zgbTRbO2DD0BZ2/gtXNhbmkv3V9OPK7lAZ23SpCKFdhP6DX0Mp8olAF0UqfiwIKYNGBw+hhg27WJOmjT6fNWwl+7k8jcbgI+hkhTbbCb/cKh/8yeUHw+Pgo5uHmDkV+4NNAMB26sZR3CGi9QwglGBtMCJyo/lvEfBKNwqcJvW4PxpGChAMOIjMkJeUDZ92qYpBgfB0fk8frRKxKoVNyWF8jJizbqO5UPgd8IODQXvAKOjd+1H6mKkzC6z2+GRXIrRV5Do8XQalLmOe/SzE9lZqsTiIBf12Jtsf055A31u2jlGEaOWILk6o31Uzm0TY7Gu9as=;25:M5+PbyrEut2kYAqo4dqFq0zucpDER5cc29Kj4RY+NnOd1OI6NLWY/p8IXlyK4kBggjkM40k/XLAS15jkHAeJ0xnKScDMoHbd7FThmaRHIp26cWgQMUbuqwf/O1D8hbQrhO96utpy/A7okuKDY2kOfsC5vGUegSG4xg/uWYMScVayi7/98tMjZYQ8GMPKOMZecGVWWkC9bK99WKoAT4543i2AMJkUud5QRrEYLPIDCskl2sz13BM6iU7t0F57+dWveW/21Vg//GdpdB/TNLRVraUgYoHYgUNtOcr3ITiPEYzUoFCOXN3rwiQ0Fz9D+PGqfz0CCaGMw1cGL85Sm20hzg==
X-MS-TrafficTypeDiagnostic: SN2PR03MB2271:
X-Microsoft-Exchange-Diagnostics: 1;SN2PR03MB2271;31:2cyoHFqzXAmSdMOT9Y2+kHOsy43QUctzqspwccRBlD73KMGF/zvr8EQpih9kw9tp8gQLazIK1biWg9wHBZmVXbYxYLa33Bsf3fPBK/r5G2oGGtwnuN9xlFaHHobiqIk5TNkXa5Lo1G84w85EiDrLQnPEEz3YEeWgk8BNjwrYbBQGaaYKZKNCuG5392gb/xx3WgqW5r5Clw3GEqlVQasxSkN9io1ycTaAWrsaYqn7fxE=;20:FRfuP28iSRCyINrjbcLOB50/Ryse09GQd7MseGOufKWwEGfxS8piRZyPvKhC4bh+f/0seTrnwf2r/LCbN3Pcjy3bY6pkf6fI+colo+H/5p9VIsT8qqmDGnc8l+JDynd189LTUjvMxoaUTAovKlJZTQei17UNkF/5K+cRjmmnTNSGdDLNopxNrhxWk+1dJ+D19Zu1nU+J+lqknVqh4qYfCiiX0USE5V96IGTvdO95AGdpLQCNKzDXYxyu7+1zCTygrX9X3mUnOd0S4A9zYRvvVz5GSVRHk2uuFQ3q0bnzEgcfNoplxtUhBLtxBU/g0h9yFsMnjcDtR8+6dtVWunInk4fpr0rrxtnDMyvAGksKBt4iVjdKfRPq2goRiMPz2KvGtXb18+oK7kMaZ+sSR60WKeRdwHvPvQ+ba0gViyVD7T/xrwqLuRAok2rkYwsEogTvFWk7Yp79bKRtYL1OKhni5clgX2wkQ/X4mvzCwjDJq0LQB3euJ5kxDhmCzuyhdeiD
X-Microsoft-Antispam-PRVS: <SN2PR03MB2271745FEB4657BA74FD6D1C81A90@SN2PR03MB2271.namprd03.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(93006095)(93004095)(3231455)(999002)(944501520)(52105112)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:SN2PR03MB2271;BCL:0;PCL:0;RULEID:;SRVR:SN2PR03MB2271;
X-Microsoft-Exchange-Diagnostics: 1;SN2PR03MB2271;4:ecDVCQ213mOOCtJU/g0TwJJK6paFiIVECqmOOVeqUSxnW/QtOCaTBAr3iJ1LvM7L00I3kQYf4JIa0SuT1uh5IvOo+dkQ7DNMLBkHdITyDyIhtgiDR9F1vpKiMfEU/iCPWwq22Mo64dfgo3JO1AuikuLP65ujg9LcgNv2zHqaN/SK/w9DHDh2tpd7+IwXZ7Vc9MJvMLmmQmy79k6Tw8T4L4iBmy28YU+eV0p63jSwguSZYehqjlz5F2qDYAQcrA8Jy45Vcf3On8pqsHVTxlJoNA==
X-Forefront-PRVS: 087894CD3C
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN2PR03MB2271;23:UrZ+O7rw3X+rQrvS2ueT3Z8WRrij6eBW4GFmnLi9i?=
 =?us-ascii?Q?ZbbdciK2YWp+Y5GpPuyZcuV0mhrLe80cfGd3ZdFAuh0wqbM4idBLPnLCXK1W?=
 =?us-ascii?Q?2/qL4VXHbdeX99BdC/AmxowfR3SFIIQos5wt8df6IwhSAVlXOontXibijw5+?=
 =?us-ascii?Q?XRJld/AUvdoAJAXSNQ/RLsO/Gpcjcuuf0ofFuwqyrzQ1TLv6vw5fyoAwOEtx?=
 =?us-ascii?Q?MqbTYTJqmyVuW2TQpiat2y8V9tvPqwDq76EbljXFqc96gIZ8ZaCmyaDn7pJb?=
 =?us-ascii?Q?IhCpdfjeiOKWUSWO8SHSB1qOebHpfcxIoTBf1xvYercS1yUMIY12AaNO6j65?=
 =?us-ascii?Q?OTCHy9Tiyn3PnDcoQMdFR/dsHx+sTXI8qTykqekxo+mk7Xno2kHSKUBytyz6?=
 =?us-ascii?Q?1VTDWtfSOYYfLBBBSvGAySu7QNzbuiRth7xvP88AQw1JFI8sPXTp3QORMyHq?=
 =?us-ascii?Q?kvGTmMwFVMJh86DMs1Ubk1cRmSnrUuHtS1tJi/zfSU6465owbWFuEE9VDxfd?=
 =?us-ascii?Q?dfhpXB9fhaTFVf8pPz4xA1kybHcwxK87c9DbUqOSiEgGNhv0ipH533vL99Ft?=
 =?us-ascii?Q?D9syjdneoRclhwJTdphkP6OcnRZ4f21CDfDj4avBNZmTfNUCA1fRw8WFc3dg?=
 =?us-ascii?Q?ccwwbReDfv3hpk/rmwKrwN+bCq135C08h5eGxPz6Js+SSFJIXbf6/rm4vtfW?=
 =?us-ascii?Q?DMfbgCuTH1EqK7NAT8df9WT/RW+szcl09suX4ol+XQWppZ/gQGesWzy5w2VW?=
 =?us-ascii?Q?TPGIWSaN6dA9QQK7mnEmFoVaUfhnAGqJA95bRbtISWGs/LSovo9n81Lo6r4J?=
 =?us-ascii?Q?5wb96ComRlfi8sZkeUEMq/upfk7bCQKar/Qyt0MrxWHiJ49g9CW+U7VK14dC?=
 =?us-ascii?Q?5Yb9SDWpQtaLhvjl6clfwr4378QSTypintYUmXW8cBXCLE7nFfnCtrb3naNR?=
 =?us-ascii?Q?x2uwW0091p1da2RiRLDQdzYBt/TS/T6z9r4UNMdGVKZn1MJuDuY6YJYTfRWn?=
 =?us-ascii?Q?XTNBUN50hNjaqHgDMfBR0LVoIhSpN9Rfb/qcr39/SDmAqMZr2Ux9GuFeT81K?=
 =?us-ascii?Q?ONNOanr6Idc8GRkIDkQ7isazfpwdnzDTlF7lDRVgTrJtfRRflG8SA6KPkdkY?=
 =?us-ascii?Q?ImhlKCdKqc1zkKWevjeqMDoB3usCkdH?=
X-Microsoft-Antispam-Message-Info: aHYmC48CnC5LJNFbYewvmUCsoQqmW8jSVOv0MJsQJ5kivbjs2osNL4vf55KKH+oyZjcgygBmHTjMsnaTwD+6HQM6zlLnWJJpZPekVbZBsRvhQZMXhiHz/an0AcI4vVEm/PreClsTV7NwYvOM9bQPtKw9pdaRRiTcelHAGzud2lJ8wRRJo9MT22kAPW9RLK2+IvaGEaqNI12oA7b+oQtwZ3ZfyhpUkIjphAyqLPilifjRISRiXWjakobWgzY6Rga9Y4AlyL/wGPUhceRx34EQQzIOBuLyAgF5uB/vX5Re01Cnyo2DdL/I4qz9FsiMfToO1qqZBNUqLQmOJitE6K5gzA4lBkMeQeyiHyG0XUZ8+kU=
X-Microsoft-Exchange-Diagnostics: 1;SN2PR03MB2271;6:CfsFO4/zlrPPQmdkiQMHXxDUt6GMQgTSfN8iRNuH3iop2mbGAbVdwY/U7NDPnFkMN+o/Q/ur6nR8dgUJHWMHbJonN1gg/YgHhbbjt1T+z+SntJ06uV8WLsgt/NFxhHUXHjObZfEPAdPPEgj+VwC1wzRJ08eq5KSV3T+l7sWJeEalz0teJTO3c+8woBBqj4bZ/kZuHuJWTyQFh055R8D5Nn3Q6iuaBr+8O8ZqJij9ordIzAf8qr9wQ1kqI/dnraFgfxBoyhghrywaZ5Cwk0YLGef9Rbpyi1n47SLuINuKgpp+mqtbVEcWTS1KTdnthD2gXTyh658a1JIdfhkakiYuSO6qQL8j5sgRJplqSFsuXg3cc4ndFW/K4GpDxQbhJmwtxMCvU9Eavws5aBPzfRcWJyLbpKBwxDKdu+8fbFUYtpkSw/DicGSXdaGy/zvu23WfB9ouUjGsoWZZVJqCiAcdWA==;5:LLID6B1NrgwxJg25fyenUzeFDZgjOXrstMsVe8hwt/55vjzuLVe9sipMV5l7Is38VsqvlKpmKVeH99tup7x3lxBPdEAYg2AhcQYJwjyTqGSni/B72LJrEgL7lqLFmp/5n4t3hJGZoZt3CpEFchzCMo7x94JfbXVFJDpYnsqPbsE=;7:SDyZOQS0hB3b8wKvaFCE9rzw++0g2s2AItsRqLnqit07KGMPR+//glol9HHq43VZio+Qvf5UFhLZqc1MVEob2KpdjGMsYNM7foznIIOZC7jLgvavjqN0XP10R/HdnDxioaZZ9dMPObEvENhYdL3yXA==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2018 09:11:24.9599
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bd9372ad-d73a-494c-b28d-08d65b5acc34
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN2PR03MB2271
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When using the internal clock the device has an option in which the clock
output is available on MCLK2 pin. This patch adds a dt binding for enabling
this property.

Signed-off-by: Mircea Caprioru <mircea.caprioru@analog.com>
---
 drivers/staging/iio/adc/ad7192.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/iio/adc/ad7192.c b/drivers/staging/iio/adc/ad7192.c
index 8a4e6ede42b3..a11c8a82bb7c 100644
--- a/drivers/staging/iio/adc/ad7192.c
+++ b/drivers/staging/iio/adc/ad7192.c
@@ -611,6 +611,10 @@ static const struct iio_chan_spec ad7193_channels[] = {
 static int ad7192_clock_select(struct spi_device *spi, struct ad7192_state *st)
 {
 	int ret;
+	bool clock_out_en;
+
+	clock_out_en = of_property_read_bool(spi->dev.of_node,
+					     "adi,int-clock-output-enable");
 
 	st->clock_sel = AD7192_CLK_EXT_MCLK2;
 	st->mclk = devm_clk_get(&spi->dev, "clk");
@@ -626,7 +630,10 @@ static int ad7192_clock_select(struct spi_device *spi, struct ad7192_state *st)
 				return PTR_ERR(st->mclk);
 
 			/* use internal clock */
-			st->clock_sel = AD7192_CLK_INT;
+			if (!clock_out_en)
+				st->clock_sel = AD7192_CLK_INT;
+			else
+				st->clock_sel = AD7192_CLK_INT_CO;
 			st->fclk = AD7192_INT_FREQ_MHZ;
 		}
 	}
-- 
2.17.1

