Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0400C4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 10:11:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BEF221534
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 10:11:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="KMbOZfx6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BEF221534
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axentia.se
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726260AbeHTN0r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 09:26:47 -0400
Received: from mail-eopbgr20115.outbound.protection.outlook.com ([40.107.2.115]:20647
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725948AbeHTN0q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 09:26:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aHRi7lMq+EF2rADg+PaOAzqnSO/dTGxdtgB1RNPajNE=;
 b=KMbOZfx6GkP5nbW/Jbu1FqOWxiQx6eVbPBM/YqFQaOGAU78otRUZ4FfYum9tqPu9RaDfmWnGgptgvJx11CMttuAf0CmGsPjVLVn8qesog7w27bVAHAw4rKoVtgLlBuWO4goIqxYWKYjTudZrFqqP0BVJOhGRyQkWSm8HMjoe7WE=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
Received: from orc.pedanet (85.226.244.23) by
 VI1PR0201MB2462.eurprd02.prod.outlook.com (2603:10a6:800:54::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1059.19; Mon, 20 Aug
 2018 10:11:41 +0000
From:   Peter Rosin <peda@axentia.se>
To:     linux-kernel@vger.kernel.org
Cc:     Peter Rosin <peda@axentia.se>,
        Mircea Caprioru <mircea.caprioru@analog.com>
Subject: [PATCH] mux: adgs1408: use the correct MODULE_LICENSE
Date:   Mon, 20 Aug 2018 12:11:32 +0200
Message-Id: <20180820101132.23205-1-peda@axentia.se>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1PR05CA0294.eurprd05.prod.outlook.com
 (2603:10a6:7:93::25) To VI1PR0201MB2462.eurprd02.prod.outlook.com
 (2603:10a6:800:54::22)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ed37be8f-c70a-4723-456e-08d60685537d
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(7021125)(8989137)(4534165)(7022125)(4603075)(4627221)(201702281549075)(8990107)(7048125)(7024125)(7027125)(7028125)(7023125)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:VI1PR0201MB2462;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0201MB2462;3:yhWaU/HM9c9MhpVk8r3C9Rq1imZUV6mimU8CVBjphX8wW5cuyyKy/NVqmNOmhXKOkeRxjkttoq7370worWLfVslevVhpu4hV6ASS2gq8lMexSsKpQJ5e/Qr81J1HoMNj/AJfW1AdtGmO/s2gtaB7NQt7vIUqci0Us9K4gDX2+Fw2WeJXmmNVQd9bJcHAp5fkBcWmuzHFE77Yz+MWCXPzYvH1OedpZtXndUGlfmi6HVwxkHpQ4jOVWDkipsuc+Zll;25:HJg3JioaUY/9A6j7okl5+/XOdC9UBOEKbEcmFWzTlzhiMgMDl57pk1hGfsvvTB0kuxtm3mc/e28jm+6GtQ7tOi4TXv/hSfyA1QZLlN3+JmbxyqfLRGtHGtpiYKF7Kte+0gmMVZqvpLP8L/ZDp4kWCnl15GdEQdrNtRgDQraAFMCcJ6eIfku3S/4k5Rx9g3rKKOoi5IrfZ3hYkSGyxtyybiVFEE4oWvJKgYW25QHgeMrvHJxPm2WpZSNqW6dA5v7T23mPMp1MBPyCHpvuOzIsawIJoQ5nsDb/hx0pMUS+L0DFlBTrzbBj9tHNsqEkcMuRan7JnD5RcSpiYSs1SF94mg==;31:wQ9Oqxo9bcy8MqGgvx2OKYLN1v2YzqRtlFKDDYYGLgIN9/uYPaVeZlRQnrUSdAwf2BequSFd8/JGwz2wFBdXW58aYhIAwrhdy7B7pvkiuz4vg5UW1NeHBCxr9lCFsVqKGCi2cxBeIPgwCo74EAUzNIX2+wODwNQnEcjYDya7gx8nM0V1kscUPUq2d3PbCJpGSJB1n5CbzyQ79NmN9iw1uKlVSWfV9gWNIR/deR+tqhE=
X-MS-TrafficTypeDiagnostic: VI1PR0201MB2462:
X-Microsoft-Antispam-PRVS: <VI1PR0201MB246273C641A4D725A6CA5AE4BC320@VI1PR0201MB2462.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(232431446821674);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(10201501046)(3231311)(944501410)(52105095)(149027)(150027)(6041310)(2016111802025)(20161123562045)(20161123558120)(20161123560045)(20161123564045)(6043046)(201708071742011)(7699016);SRVR:VI1PR0201MB2462;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0201MB2462;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0201MB2462;4:ow6N8QRxVjbwvHE82A7HwlaH/ZPPypPioCzbEm4/kE8JlQrXxQipKBcbA/qpQJrkwAtClc89eAn7dch+r7LLc7r/SJZNsvNrzv9maCMBPvboIv0IlkujqfAJx9sDVnuUlDiJbotk8gJw/i2ky9yS6raxr+eKA8S9fevcl9KS6PwgLmbucXpBsfrMvpyqZd3oPL9byYkUCxQa1aX7VA7HqXWqZy/eZyyBdMR0ipJ3fgeL21wdWtI62p27SeUfxago5n/bB4JJFgN0yuzIUZvEbpSnHLUb15Slle2wj9dv27GTn61JE9CLkHf1gWzofuUA
X-Forefront-PRVS: 0770F75EA9
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(39830400003)(396003)(136003)(366004)(346002)(376002)(199004)(189003)(6916009)(4326008)(5660300001)(48376002)(16586007)(25786009)(54906003)(6666003)(52116002)(97736004)(51416003)(2906002)(476003)(956004)(486006)(106356001)(74482002)(105586002)(2616005)(316002)(6486002)(2351001)(68736007)(8676002)(478600001)(50466002)(8936002)(186003)(16526019)(1076002)(3846002)(6116002)(86362001)(1857600001)(26005)(53936002)(47776003)(66066001)(2361001)(7736002)(36756003)(14444005)(6512007)(50226002)(6506007)(386003)(81166006)(81156014)(305945005)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0201MB2462;H:orc.pedanet;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR0201MB2462;23:Xnc4nJgdNJ127LooIWlceLCyB/oRa1Sb/yMITKU?=
 =?us-ascii?Q?w3XdZzR4lvd2CN80nemxO6KtuwlrvybpfBbrl0W8ibDWAw108KDZW/R8kfvD?=
 =?us-ascii?Q?LLl4dV4GI/se01idpt6U4McqxHPXS6wC4RPstdtkA0MJFIRhYzNmr41Se1Jt?=
 =?us-ascii?Q?pAD+FVtagqRUb0iP1ypUfoe5+oW80MEq57GPSxOrCXFem9GyeEuR/B6a1bhJ?=
 =?us-ascii?Q?/qB07We+gu6/+0FLhHda8Cv1UVEnO2HU+JHETL+t255FA2gOE4f3phKQatT7?=
 =?us-ascii?Q?cgVrDs44O4/FB6MiahTvAMn9NDLkg2bUVfs7U6PYN/4xzAM/Bd/oC49SRGt0?=
 =?us-ascii?Q?Dhw+nev6R9p8ztytYV23J5m49wNBzGi5ZGxf8JWvgy2zOscv642DXTurvyIC?=
 =?us-ascii?Q?q4xMSrar8n+RIPRANVVQaax+CJWcfRb2t6zeQZUfaVFSTELeDXHBwmPBtP9k?=
 =?us-ascii?Q?7DdDr/pNXJZei+nYOVFNAjbjG/87dWjl7nG8fU6aFenuG7G0lsZLKaRVzoKh?=
 =?us-ascii?Q?TQjcpwxosTnELD3BL7KOLMc0cXPJAuh9CwF8j45ZmpLukUnuhyBb8WrdiBz7?=
 =?us-ascii?Q?fBIzjEQUNLASw8V+k59PMyOVrezES2cTDrfhfUkBOT7a7WfacGklUC4QLYjZ?=
 =?us-ascii?Q?M+i8qo5hn9RFxL7Wm60ReWMGkSvU2RL7olYldl+fOC2a0c1CBDKWjKJMS/SL?=
 =?us-ascii?Q?etts5zqWP+i7BBYpFQJH6FNfE2ryJyp/0suh867plNjqnZtqyXanqo4uKGWJ?=
 =?us-ascii?Q?b1rBkLCKQlQP/TKIfNBgPUQUbV/PEcv1T2qadGdbizncgA79WiEQ++KWkxhK?=
 =?us-ascii?Q?o53xr67aVo0J8KxoK2+yXV1Z0hePgtf+T1ahkZLpTpVnEHOWkOWdVA3MRJB5?=
 =?us-ascii?Q?SOLy9Kj+J6zGmE5uiLA/+7bOzMLY/J7LR9YLnIJxck6vnJmQIAK5K0ALzoVx?=
 =?us-ascii?Q?QaGZkBTfQJJPsPln9CiWiIdQ1DwOsoCYdU+UzYZXCleYYzNduzH6PM1Pi26J?=
 =?us-ascii?Q?1TA1TWiFpO5umZ+pnryERojTfO0qIys5iYVr2dI+A7NaqoWsz4ETtHT4WoAC?=
 =?us-ascii?Q?2fLMUZghh6YIdgbvQACl+tBg+7wq83QbrPFydUicYtjEwPRMeFMeDbWuGyxN?=
 =?us-ascii?Q?AQyvOaVIzIMI191AljzXDzVOkLXBpMBbq27rAc7hMfloWMiBq59rIcnUFuar?=
 =?us-ascii?Q?gSsK/0RrVfumhqFqxq+pbXFoqf7D8xS9CIKjR7g+ZLbyNwIVjyQoGTYmW4kb?=
 =?us-ascii?Q?9csjmWeqDGzNtk3kD6k6fRDdYFSAd7iHTZT+2WVz6?=
X-Microsoft-Antispam-Message-Info: IYpejrngy4PSHdvhGtYtMrk3rt0IL4v6mzExmqI+t6QLLNzb7/9vCZklOmNbcGJLp0VstIH/l1Qa85/DttD2j+BWXRhl5EhyXh8V3C5LWpHqFq+Cg/EsbCZWc7hGFCumHYfFChOKBitr39gcg0GKNF+dCXSdACGZDg1THheZ3OrprGSbwAJ+4bb3kglXEieXXshL6rRnn+v6Nrr8zG6azlnimd9D2s36UydyHsN5mpmIDrBngXLBhdk1hiqZgswCGZJ8eGlZ05B3Vytu3RRL5JdF8AwCWWw2W1eqmwXKxR8/eU42RCtFn99/tM3a3gW6VMsbp8M2WLOk4iaZuyMQZa15ekiLcBFsWm4/puPpVwI=
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0201MB2462;6:wQPy8egmWd22A5fImSX5mzCvVstuPXMZ0846bDCd72uHzekCWodmRmLjhrOyiFaJvBvGm4c2Hm3vMAEn7ceEZ1IlUvhoMnHId+D2Xtafrb10NW942cIvvzyFQA8fNTr6YlzaM/2VAJylY6hrEJ/Bg3N1sTE7SWuQTLzaXgmknoc90qhL5OXqaRsexdJmDXfOyc2p+uth3nn3P29r1jDJDqOKNbTXCYrBAjSdc2LXh5KfF+ke+tTad1ci/kk2gTN/yzZZY+I4wih/8l9Lglzr/XATlJA/GQCJyf8ZnI9c04Q/xHfbMav0mhMhp4fB4pWanAlY2QzylnaAeTT0J/8EJNehAa/ShjHiBKTmlVtzyyVml+hD7JjSKd6K+N3KbEybMsZSk7XZTso7yFUGyJdiHvsNJfOxWpfItXN1yXWFGWLBVUHYVsd/i18hxiGMejLeUFi8OcDFwO6XroB1YRDIYg==;5:EXMvvTd/QJNm+Uia8/ZVkxsCjxPP6MFegF2JbA4DJRj3gS0DE3ulXcWkD9mdrhXfD/TVy9T0I8wlw36aya/DZpEesV9mpxICS+dOUmBsIbcJm20vsRIldPqg6jEMdpXXRRDDbetjwZgW4Klg16jD4I5SKyLtymRCKTFeXtA+IFM=;7:sApxCZl6sq2tzJcZV4QIbxYeP2ZjXJT0L860xQDcWtt3NL/htmn0B1rWzJFsrCt1E0zu80anhmlB+MKhtyzSgH9/Ey9HpYeYJB4MPrAFFI2rrRhTzT43NeHW2tkNiVkvJ4hCPFc6To3HFL/BGzVd3hJDOWOAi/YY4uqlvPHs4aOISzqMz0JptVxDoLkbAeCSvuNCLNgjKh4JyU0J7/uA7w0sDq/clKafuRo5U4m4LddeDxZvZ/ZSIl3yVLEdN6Qw
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2018 10:11:41.7567 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ed37be8f-c70a-4723-456e-08d60685537d
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0201MB2462
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The file is GPL v2 or later.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/mux/adgs1408.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Hi Mircea!

I just noticed a discrepancy in the license annotations in your
driver. The SPDX license identifier says GPL-2.0-or-later, and
I assume that is correct and that MODULE_LICENSE("GPL") without
the v2 specifier, as in this patch, is the correct thing to do?

Cheers,
Peter

diff --git a/drivers/mux/adgs1408.c b/drivers/mux/adgs1408.c
index 0f7cf54e3234..89096f10f4c4 100644
--- a/drivers/mux/adgs1408.c
+++ b/drivers/mux/adgs1408.c
@@ -128,4 +128,4 @@ module_spi_driver(adgs1408_driver);
 
 MODULE_AUTHOR("Mircea Caprioru <mircea.caprioru@analog.com>");
 MODULE_DESCRIPTION("Analog Devices ADGS1408 MUX driver");
-MODULE_LICENSE("GPL v2");
+MODULE_LICENSE("GPL");
-- 
2.11.0

