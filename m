Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1F55C10F00
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 17:14:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A74A921773
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 17:14:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="lLofcL3q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729395AbfBSROI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 12:14:08 -0500
Received: from mail-eopbgr690085.outbound.protection.outlook.com ([40.107.69.85]:60938
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726147AbfBSROI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 12:14:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hUcKSSmRZvchsTHeAYorNW0oO51HXeuifKIhyiTvXe0=;
 b=lLofcL3q1zYpfTGIrst54jXu9L4kB5B352+co5wnr1B+RdVcZKh6UsnPsbpCfH5R0P6RYDljIWJ3Z4iorcwdNXbPWHjj8lV1B8FQE9CFL5okEYBurzAtC7qUGINKJO/Wg8IqAqT9LL9Ejikh8sl50wK6lE2nOG1s+h85Vk4ORP8=
Received: from BN6PR03CA0058.namprd03.prod.outlook.com (2603:10b6:404:4c::20)
 by DM5PR03MB3065.namprd03.prod.outlook.com (2603:10b6:4:3c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1622.16; Tue, 19 Feb
 2019 17:13:56 +0000
Received: from CY1NAM02FT053.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::205) by BN6PR03CA0058.outlook.office365.com
 (2603:10b6:404:4c::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1622.16 via Frontend
 Transport; Tue, 19 Feb 2019 17:13:56 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.55)
 smtp.mailfrom=analog.com; gmx.de; dkim=none (message not signed)
 header.d=none;gmx.de; dmarc=bestguesspass action=none header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 CY1NAM02FT053.mail.protection.outlook.com (10.152.74.165) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1643.11
 via Frontend Transport; Tue, 19 Feb 2019 17:13:55 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id x1JHDsKw009449
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Tue, 19 Feb 2019 09:13:54 -0800
Received: from linux.ad.analog.com (10.50.1.179) by NWD2HUBCAS7.ad.analog.com
 (10.64.69.107) with Microsoft SMTP Server id 14.3.408.0; Tue, 19 Feb 2019
 12:13:54 -0500
From:   Stefan Popa <stefan.popa@analog.com>
To:     <jic23@kernel.org>, <robh+dt@kernel.org>
CC:     Stefan Popa <stefan.popa@analog.com>,
        <Michael.Hennerich@analog.com>, <knaack.h@gmx.de>,
        <lars@metafoo.de>, <pmeerw@pmeerw.net>,
        <gregkh@linuxfoundation.org>, <linux-kernel@vger.kernel.org>,
        <linux-iio@vger.kernel.org>
Subject: [PATCH 3/6] iio: imu: adis16480: Add OF device ID table
Date:   Tue, 19 Feb 2019 19:12:15 +0200
Message-ID: <1550596338-24220-4-git-send-email-stefan.popa@analog.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1550596338-24220-1-git-send-email-stefan.popa@analog.com>
References: <1550596338-24220-1-git-send-email-stefan.popa@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(346002)(136003)(396003)(376002)(2980300002)(3190300001)(199004)(189003)(16586007)(186003)(110136005)(11346002)(446003)(106466001)(316002)(77096007)(8936002)(7636002)(44832011)(426003)(336012)(106002)(50466002)(47776003)(6666004)(356004)(478600001)(54906003)(26005)(116002)(126002)(305945005)(476003)(2616005)(48376002)(486006)(2906002)(50226002)(51416003)(246002)(8676002)(5660300002)(76176011)(7696005)(72206003)(36756003)(4326008);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR03MB3065;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eb7c9752-ecf8-4544-58d5-08d6968da13a
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(4608103)(4709054)(2017052603328)(7153060);SRVR:DM5PR03MB3065;
X-MS-TrafficTypeDiagnostic: DM5PR03MB3065:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR03MB3065;20:XJiLDBNg81rTpEJwMGFxv4an7h58S+/WS0hUVephvYSAs3xaji26PUeiQsyhzmWgchiZIHKwzUaUTnOkqFAJ/aMykStwBFOsK71Z5A1+b+Dtn+F59jAGtjMTdFHjVYr5L0BfMkjOdFBr12aLjqVjME7rcVNNREJCPXm+A5dnlTMKTuZ2M9xB7uETZJwBSUORMaDbRx1k0ojs2ePhkRhOhGDdJXYr8w4lOJ6+Omo4hmlEMlJC3zYqozmeHCd26YJ5152eqsVlIHUy1rX09aCJK9Uiub6bIFS9DTY9+RE0tjSUyy/r/2gz3QCZ36sD0SEWfa4I5nZO1e47cuzSxc7UkRP+YfGVLsHUOBreQRhkgVtI8kQT7g4Uv2uTjgGr3zJZOoUVLOQKKUhPm+FMuw55KFMjl7nqC2Qkeh5bG/fu9EmXXnSdmuWRf7drDYGxHBkbkpLhNyowdyYWL8E/kbuwlA0BRX0CWWabYH735wVdEm52PS9ExqEH8cNsLI19ez3o
X-Microsoft-Antispam-PRVS: <DM5PR03MB3065B2C70BD8A60F34403C299D7C0@DM5PR03MB3065.namprd03.prod.outlook.com>
X-Forefront-PRVS: 09538D3531
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5PR03MB3065;23:VRG68TUxEZEmDl2BJVtp5BDxeKX3AFnY/d2fRUYZF?=
 =?us-ascii?Q?aAMknjclokLz+FrjEeBbrfzUevI4HTMoYBzakMheXCyxTM9yvhlAw4Hyz7f4?=
 =?us-ascii?Q?sReM8MbzzrCEWhVOrw8XlWa1wJsyz8h73ADkxH8TyvuGa10KCgE81oCZvLBJ?=
 =?us-ascii?Q?sUFRmn2nHbq+opgzezurEGWDPnMQmIPqIm6gfYI9PbBw1JAizvodEU5x0ql7?=
 =?us-ascii?Q?CdwQk9Nf8eXNDU1SBTdF3UTw0LMv8HHZZqj2f6+9L6CFBBemkTmsbbbUdJKs?=
 =?us-ascii?Q?MearyBAdO3U4gtz15TPEmw1geZfyxlPltAQTVFsXrtIdfk4rQDmHZzAtCAcR?=
 =?us-ascii?Q?qsn0eIqxK40Bs5xWsdKFs9j1TzVM6Th9nrG51WK4zea4d7qbOD7YxaimEs3r?=
 =?us-ascii?Q?DN9bjUNpXj+/fXn4s/mqSnNFwIs71pxffWm39IqNa85WwuRivtk+Mj+ZxxSf?=
 =?us-ascii?Q?33sfAgwKDc2HFxrmEo+MgaghW7Kpj8B9DtHuK29aslgCQH+g6UTvvDikth5/?=
 =?us-ascii?Q?PqGY60hL7CPKBXOWLel5Vm5S46F82mN/xMumdBsjQuE+I8cT3DG8oNEV8D8D?=
 =?us-ascii?Q?qTAMLENf0GR0cacPyGHnxOlN48UStC7g6Lu5ngt1uxbn22zioC8HnNxP8Asm?=
 =?us-ascii?Q?KxWSinwbb1k8ew7Pz0EeBc92bx/MEnlr84ZSb2XLCSW8DXTnOUmh/00fX4lt?=
 =?us-ascii?Q?7Rvp7za5idXpGjncTB0oJfD5JAomdnfrdabHl4+yrte3aXdp72nON8Gfgo07?=
 =?us-ascii?Q?ytGLPEC4A+AnrgxMiEr+AKQBStqL1sjkFcTK08eZvWEugiyyfvvJMvah+A7j?=
 =?us-ascii?Q?Y6MDfnBkiQw+/bv/+94Ft9muCoo+RBrlbSwpTa7Tm9i+SHhzDuLwGrZrI2PR?=
 =?us-ascii?Q?WmgsFaMf7ZmvNgSqyWmpo3EdvRl4fII3BSADQiQgmV2VXnqLJhy129qXI1Vd?=
 =?us-ascii?Q?s7sL5V2jFAXT4ehsoCg1VPvPdAsbeQ3wmnhoApfWLGYUDQ2aSDzDEU1fYzzR?=
 =?us-ascii?Q?lWV0XXAZtPOG8m6gtZQSwQd37wwWg2oSo6FzgkmIvUL+7n9vIGcIveQwowD9?=
 =?us-ascii?Q?EkKJME=3D?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: /A+bpFM6T0QmU1eQ8FZ1LuNx5d5/re+EStl1qYDd8ALNgUMXUFHWdKhRzRf1AFwQzhv58jxHd+dE1LXQHvxSvW1JIQZgRK30TrIyDFYMb3IOxsRu/V2KiyC2he4Nu7JwynhdEPx6ZuFeyw2QlG7OznZ1sR+UJ9hA+ka3xJJlJR9kebVv970GE1RIWktxX+GJCQDxBMWsafnVDV7gUQE/q8tBjNL669wf+IP5pcBN3DgpWonQ4ZgjGr9Ydwxd/rhpyvvSXK4MzVfv7yrjKZkmcbgLbtADLnDMYl7hkRPCetx+db2w6E7d5kef1wwV5QpxmFPbqmYU6nVIGTu4LTzmSM/aGF878pes+jCBTa+20gqid6efJTPTt+CqzIdFemvacBh3x0+ichVdEFii2sBjeRvT+xDr/akbyLEuS05l1O0=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2019 17:13:55.4851
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eb7c9752-ecf8-4544-58d5-08d6968da13a
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR03MB3065
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
index 38ba0c1..7ae71f4 100644
--- a/drivers/iio/imu/adis16480.c
+++ b/drivers/iio/imu/adis16480.c
@@ -988,9 +988,19 @@ static const struct spi_device_id adis16480_ids[] = {
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

