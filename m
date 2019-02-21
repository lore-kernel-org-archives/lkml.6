Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5438C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 13:17:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73B292084D
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 13:17:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="EoMOwzwh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727972AbfBUNRj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 08:17:39 -0500
Received: from mail-eopbgr760052.outbound.protection.outlook.com ([40.107.76.52]:53079
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725845AbfBUNRi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 08:17:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uNsYpGHAvoCWUbhWjZeoTTbnuSxiGLVE1SeAF2MVw5s=;
 b=EoMOwzwhl5CuPulxmIw0rzdW6H5h7UFcYcFzK8+81KozcPewHTvQ7MAWAQhhFzN9aFiZUln9uIfP2nE51pGimsvMo1qFewah10AEaLk5cMuKYuJt1GIBm0OgR2XyRuYc1oDZ12GDVAjIAOY835r+mRNpGL1FTOEFJ/liz++srOo=
Received: from MWHPR03CA0048.namprd03.prod.outlook.com (2603:10b6:301:3b::37)
 by SN6PR03MB3518.namprd03.prod.outlook.com (2603:10b6:805:41::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1643.14; Thu, 21 Feb
 2019 13:17:33 +0000
Received: from BL2NAM02FT003.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::207) by MWHPR03CA0048.outlook.office365.com
 (2603:10b6:301:3b::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1622.16 via Frontend
 Transport; Thu, 21 Feb 2019 13:17:33 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.55)
 smtp.mailfrom=analog.com; gmx.de; dkim=none (message not signed)
 header.d=none;gmx.de; dmarc=bestguesspass action=none header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 BL2NAM02FT003.mail.protection.outlook.com (10.152.76.204) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1643.11
 via Frontend Transport; Thu, 21 Feb 2019 13:17:33 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id x1LDHWID003580
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Thu, 21 Feb 2019 05:17:32 -0800
Received: from linux.ad.analog.com (10.50.1.179) by NWD2HUBCAS7.ad.analog.com
 (10.64.69.107) with Microsoft SMTP Server id 14.3.408.0; Thu, 21 Feb 2019
 08:17:32 -0500
From:   Stefan Popa <stefan.popa@analog.com>
To:     <jic23@kernel.org>, <robh+dt@kernel.org>
CC:     Stefan Popa <stefan.popa@analog.com>,
        <Michael.Hennerich@analog.com>, <knaack.h@gmx.de>,
        <lars@metafoo.de>, <pmeerw@pmeerw.net>,
        <gregkh@linuxfoundation.org>, <linux-kernel@vger.kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH v2 2/5] iio: imu: adis16480: Add OF device ID table
Date:   Thu, 21 Feb 2019 15:15:03 +0200
Message-ID: <1550754906-24640-3-git-send-email-stefan.popa@analog.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1550754906-24640-1-git-send-email-stefan.popa@analog.com>
References: <1550754906-24640-1-git-send-email-stefan.popa@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(2980300002)(3190300001)(199004)(189003)(2616005)(2906002)(476003)(498600001)(126002)(446003)(76176011)(336012)(356004)(426003)(7696005)(54906003)(4326008)(51416003)(16586007)(6666004)(72206003)(48376002)(11346002)(486006)(44832011)(116002)(36756003)(106002)(50466002)(8936002)(110136005)(305945005)(7636002)(246002)(8676002)(26005)(5660300002)(77096007)(106466001)(50226002)(47776003)(186003);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR03MB3518;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bbfb5fcc-05ae-49de-9d14-08d697fef093
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605104)(4608103)(4709054)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060);SRVR:SN6PR03MB3518;
X-MS-TrafficTypeDiagnostic: SN6PR03MB3518:
X-Microsoft-Exchange-Diagnostics: 1;SN6PR03MB3518;20:pT8DR23778gG2Bq4xrGE5UEIPQsAJKHkNZiB0yHwvNHXPjfgde4HnoAHgb9Z+Hpv4SgpkspiRZ+Uo+rJbdJwokUhDe9N3sME0l7Tit4akzaAvkthQ0IySBRRCKyd9XCK5S/jMSqk930lyHfVIZva+kYrlUY1x3dCXkQLgbG1up1KlhfkZMn2mqD8NhOPQ38e5H7UW/WHXPQcGWshNfDxOCHL1jfMkLOJFFeY+zBdP61RaBjMmoQNyh0m/e+Gza/7LY7Nx5E+o/urXGqf+wnf6neTM1o113OmHC4p1vMcqM1n1Gjd2N5RiuB9UwYBlNOIa6MChj6ZsH3mAGOBOZm2xwawIljlPVwtx6Rg/kdce2DG34ZaGPNlUxXkjPmh6PeTD02pKqj3c6M1x/GX6AUuXcPWPw/k72ImUp6o7TpLMOv3lKyNspNd64geiw7G5lX+95e4zshJ16HlZUKwkAHC4JD2347D/ebijZ+8Ysrp+sapLzIwgm6yUcXRcz+lRlm5
X-Microsoft-Antispam-PRVS: <SN6PR03MB351848A153054C0C4A7B7DDB9D7E0@SN6PR03MB3518.namprd03.prod.outlook.com>
X-Forefront-PRVS: 09555FB1AD
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN6PR03MB3518;23:DmrasLAXkAH39WpRzAfIfr28NBOQag1qdd7CIGOpx?=
 =?us-ascii?Q?YaUD47Wwu1j23ZJ8yTERxc3ZDeNZy32prDPrR6YJMcUjRlq+IBX1+kmuymm2?=
 =?us-ascii?Q?Dz4P4upCIP8dtN8hRNRuOw76+GiGhKinVxvb4KpP+avlvvIaZnfo6wxGUM6W?=
 =?us-ascii?Q?I0A1JTAiirZlHSMmcv0Lp/4x+eptoPU1vL74t0e1WjwuzviyaO9OC95WKRwZ?=
 =?us-ascii?Q?RLQwk8rKxvQiPPf3LnesqIg85TFnMVHsKKFfiVA59K2YtTyywNZTntqMUVr2?=
 =?us-ascii?Q?QCM29SWtAtFTYetSSxYrDYnCoct2JfYUDco5g3USw5pYT7+36pV7TQvtpulF?=
 =?us-ascii?Q?oKDUsZQ85Zdwe/hvkjDdCM68iZ1014GGW0bKlIyWOP8Woxe1JAVH2ulT4+LV?=
 =?us-ascii?Q?cFKnGvDtqVOZipL/d45p7KBF4wnhtOl/whChtdyCCZY/byapGTdssl4T+j6U?=
 =?us-ascii?Q?lFJUeam4kTKgcxUSeVmBxh9dDbpMBa244vaCb39beqLjbL/YKJRuKQC8tUT6?=
 =?us-ascii?Q?YseUJ8ufLY2FueR+Mqsb0ZwUBSyo8gd9Wcvl8tHX5GHiUFumpX1enNbzAxi2?=
 =?us-ascii?Q?i8Qr4ki0YdIUDWGh/FZbmlYpZt31NEt2Gana3R1ZAwnH2HLdE8BxskQXpMUl?=
 =?us-ascii?Q?z02PehIXghNsEY5v7lmIcPbURqjKJCYPFkFg4M1xhRVj++YXx+hakyJq8672?=
 =?us-ascii?Q?4JA19qgkvigerXFi78lBGm4VxxN+GPhmawwur0EVptctJlWZqripF/MJKRIe?=
 =?us-ascii?Q?JBHRg8O8VHsequmaZ7icd8KhHRhzO74NdsyJ9XhEuOc4BjSbCql31ELtXglt?=
 =?us-ascii?Q?Be1UhFgjPUN0AF0aV0iV5y0VYJJqqUH/LFL42Lfl1agAzKWmdb0a6BJIdwfE?=
 =?us-ascii?Q?UhPTmbQ3BmazpXrhFRgaLgeU4a2cKUOBONQVjBqrLHEMMIxyAh6ZPS6ncHc5?=
 =?us-ascii?Q?orvaxqu+eGhoQp7SyJ5?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: iv1DszJYcYKRDbE9dm9tylDK9uK9i42XKGGDKaUmDhSYeoU5M+uEJIxzuVdKuOcdCLspQpMBJcM90ypM90Q5WoP5wR0gQmkCElFzmpIVlVuhgtxMenuqkllYjcREO3aAPiV15Y6FGLiGv3Bznbq/ZxeLt/JPnaECud0vPcNarobvpb3gwB9IzdnqepPe4IfjWCLiB/FuLVuy7AfPoSaF9dzW5NKaOlmRdCVqUmO0z36JO+umDcTIEFjqMikJlp9J+MWShHpfxNUKa7tg6M9IDSFiU0KObXt5QnPelv5UwEG9m2ZD36crNPNDvCSn38gIh9irkNo5DfLRkIg97Dun5gFZ/wJxmQ9htbOLRqQztL83zon/U7rsZ9YIVmidSHNvXKzquJrBiX0q8/kHi0Bc8Nvq8/wx7u0YZ2G7haXMceY=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2019 13:17:33.1926
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bbfb5fcc-05ae-49de-9d14-08d697fef093
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR03MB3518
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver does not have a struct of_device_id table, but supported
devices are registered via Device Trees. This patch adds OF device ID
table.

Signed-off-by: Stefan Popa <stefan.popa@analog.com>
---
 drivers/iio/imu/adis16480.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/iio/imu/adis16480.c b/drivers/iio/imu/adis16480.c
index 98a23ac..150d814 100644
--- a/drivers/iio/imu/adis16480.c
+++ b/drivers/iio/imu/adis16480.c
@@ -991,9 +991,19 @@ static const struct spi_device_id adis16480_ids[] = {
 };
 MODULE_DEVICE_TABLE(spi, adis16480_ids);
 
+static const struct of_device_id adis16480_of_match[] = {
+	{ .compatible = "adi,adis16375" },
+	{ .compatible = "adi,adis16480" },
+	{ .compatible = "adi,adis16485" },
+	{ .compatible = "adi,adis16488" },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, adis16480_of_match);
+
 static struct spi_driver adis16480_driver = {
 	.driver = {
 		.name = "adis16480",
+		.of_match_table = adis16480_of_match,
 	},
 	.id_table = adis16480_ids,
 	.probe = adis16480_probe,
-- 
2.7.4

