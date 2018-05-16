Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753225AbeEPKPw (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 06:15:52 -0400
Received: from mail-he1eur01on0107.outbound.protection.outlook.com ([104.47.0.107]:22847
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752101AbeEPKPr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 06:15:47 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
From: Peter Rosin <peda@axentia.se>
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org,
        Jyri Sarha <jsarha@ti.com>, Daniel Vetter <daniel@ffwll.ch>
Subject: [PATCH v3 05/26] drm/bridge: cdns-dsi: provide an owner .odev device
Date: Wed, 16 May 2018 12:14:49 +0200
Message-Id: <20180516101510.13215-6-peda@axentia.se>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180516101510.13215-1-peda@axentia.se>
References: <20180516101510.13215-1-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1PR0102CA0013.eurprd01.prod.exchangelabs.com
 (2603:10a6:7:14::26) To AM4PR0202MB2772.eurprd02.prod.outlook.com
 (2603:10a6:200:8c::22)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:AM4PR0202MB2772;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2772;3:8ZtdEclX9z5ytKTWYYVfnc3iY7K07MsXc6NqLS5PBtoXG1pD3poVuQd8d6jUOVnlYFJpAODx2AyPH4qFLOtN0SXbrsdCoWrWaZ0IaG26QxvmSXke9AxqMNcBCChcs5dJ3XK48ab3AgNWf00rrxYg2y8R2g76lH/ukRanoselL+mm6fo4pmRt3GgW2vANibXilY4HJs2zMOwwg7DCnmNGQ/WSjjD5Iz5F81YpGEO7NhVOX2LdJVhAsxh6B3XvzGna;25:iDHzcpE1fz0lnlqsWZgm04o/dggU/6HoXvTBAAhcyhZR0XNdO7tE9yBpipFq9LApa/Pt9wT194A4K3lPsmz6ygmgs6FqMwWO5xk2wMrE3Xe23+FLvkzp+TjOlH80FVjTfHLWSd4rsBDixwDbUJ36ZEGQ+87a7tYw4jBETuD0adLirIzTOxeEQlioTYoIRFR7ZteRVNUZcCWRgUFYH0mFc255XZRawno+TNA9BL6CiMZZFAZ0ix78sePCbVQ2BaVkH6r0y55EER+OKnB5v2GyadGS5/7OkR/PqSGPtfkqgP6a4bc0CMhhvnVh9hWPm2icZuI46mPIVWvuHoIugQRvhg==;31:Tlw3bkdMi1pVoPamFENc7YHLuiOWEBx94Fb5T2/Fh4jnB6GZzXre6UTR4bWFkHDZE6ojnsAefqBPyiCSf0oeIpWydn9dS7IXj99DGuUF+cMIVqracTTzc21aqJgQym6xGqWStyrgKx/yPs5ZDFxeQVT6rB4FqhFmUbn+OgRUFtU+iUc0yeRrzYvtMevOEsKTOrvyQ4B55dpI7ChbLMNUXzzH+Fpq7ZNSJfZ7nRCJqog=
X-MS-TrafficTypeDiagnostic: AM4PR0202MB2772:
X-Microsoft-Antispam-PRVS: <AM4PR0202MB27723300039633ED6B017EA7BC920@AM4PR0202MB2772.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(149027)(150027)(6041310)(2016111802025)(20161123558120)(20161123562045)(20161123560045)(20161123564045)(6072148)(6043046)(201708071742011);SRVR:AM4PR0202MB2772;BCL:0;PCL:0;RULEID:;SRVR:AM4PR0202MB2772;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2772;4:OK974mUhPTMmdxgO7X2yVec5AXkjbBHg3Ayv6hEhuZC43LiJQRB8DWaXgYirICl3E2HkYRRMvSo3PQ6eR47wW0pkhB5Ti4lCS3i2ln/od/+311Qp8beTJUlTNt8GUueyiIPmk/AbylEyCSWtiw3exrKs38twlG5Q3ghKQ1sDODG4ppnngXIMqV8SfBtZ/hjWuj8rTYJIUGPhdEMO8DQFJdSNEXt2kWumFhXwlRM2Kq6jBTNCMnwrXsUkqyu7QbChpY9zmDldkgr9fID4uWIbcA==
X-Forefront-PRVS: 0674DC6DD3
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(39380400002)(396003)(346002)(376002)(39840400004)(366004)(189003)(199004)(86362001)(25786009)(48376002)(50466002)(68736007)(36756003)(2906002)(105586002)(97736004)(6916009)(74482002)(2351001)(3846002)(6116002)(1076002)(478600001)(106356001)(316002)(16586007)(2361001)(7736002)(50226002)(53936002)(6512007)(305945005)(51416003)(8936002)(52116002)(8676002)(16526019)(76176011)(446003)(66066001)(5660300001)(54906003)(47776003)(81156014)(476003)(2616005)(956004)(81166006)(186003)(386003)(6506007)(26005)(59450400001)(4326008)(11346002)(486006)(6486002)(142923001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:AM4PR0202MB2772;H:orc.pedanet;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM4PR0202MB2772;23:AIV5O4SCTDcYqF+ccTBeHfTRtZWLfAeJ/1QhMpx?=
 =?us-ascii?Q?hYr+TR9AinOmPjMkz/t1Yz7DsvMENKQain1BZEjeoSx+KUgt2A++g9/+HQNY?=
 =?us-ascii?Q?fTA2TQHyI6xULyKTZ5SHV9HRBAv/JPVASV9v348cAWWTaZHT1XzT7zW3w6GC?=
 =?us-ascii?Q?ln3CxHJeLGghXatjJns7IwZzNN1BkhS0sXvOQCcqFEZNb/5a6xfUGRmm4l3S?=
 =?us-ascii?Q?c59wAY+aFExESFIYesyJ4duNvsISA6g/mYJ2mc5dx2Yk9FkfUjAk+4oWBpN/?=
 =?us-ascii?Q?IubkK6mkUcfzBfTd+E6w4NJAGzKorAUw/c73iZVgY2n3Je4Gx2pd9O6VLRMV?=
 =?us-ascii?Q?uH/BuiyRBdmQF+75EEOTcMfIdh4kUaPp+2SPsi59h3dQBgI4HqxazCmiFyzT?=
 =?us-ascii?Q?NdJ9/xISz/b70FqSrA4WPazpD1eN51RAAC4er7QUZC1x28TmRSOKBW2BWZsG?=
 =?us-ascii?Q?8jpv1Z+tZSyPXZzd5yN28BlQCrNqZM3r2iCkBhziyxqqc/G2NUSYgposzuTX?=
 =?us-ascii?Q?T4E/Izvy6cJDFkwtnIVOwqrxJDo715p4lOSqgBbkHVetEwoKtjsWFy6/PXH5?=
 =?us-ascii?Q?1rTmSjbSoB7RNNj0rN9D8Mak4W4ycnkcwX7b3HwtqkPcmKU+EL9OrKFWYzWK?=
 =?us-ascii?Q?j5wwXLBBDYVVJncuzjqdbfs0Y8jNbjgM5mSD8xzrDT08HTzaF7L/Ve0O6p2S?=
 =?us-ascii?Q?0ElNcm1QEUsq1Mdey1yQ2x0v45yaf2o6b1JyJTHpH99uIJcqGKLIWCI4lULh?=
 =?us-ascii?Q?eKMrQucdvGyzQ4vVrkJbKxaT2mYa57Yxz7ZNiv1DJmn8k3thW2Q3a4zMHkQK?=
 =?us-ascii?Q?QJjYzQbDFFBJ6sBxOVUXCMH4dCsZBZuAJonTCzGpI5Akwb9nUtd79IuFDts5?=
 =?us-ascii?Q?cw0vmAmh3CI2rONlqSFDtPSbZMzQhsHLwQAJ9pUsb/cHzM7k5+2ZqZb6MKvs?=
 =?us-ascii?Q?2x8cR0Qc3jSKIF7eewUy2fvYc6TaP0XiejjcPk53cpnFLNuD5kN/8vZhfqaR?=
 =?us-ascii?Q?q32c6s/m7NsE1moUFm/tbB/PtZG2ZLkECToNEuU+HrHRCRARz6gB4bh9dWoE?=
 =?us-ascii?Q?0WmFQ7q1r9OpWllnoAhUtElFLHM0e25wpSvzH9trCTqMISKfRGvG1oaBe/wX?=
 =?us-ascii?Q?gKqQPwmSIJHT0d3rC9I1qtjgnvT6BHmm+Imy+INRqdZdW6QOJXkZ57Td1iAF?=
 =?us-ascii?Q?xs8D/thNtBra3UjVj7WhMFzM/0y99kikNn6XKNPWN8WcCptcyMC+PxxGD3nW?=
 =?us-ascii?Q?RzIav4yg2E9QQyDyvJnrlPcXRXdbjDHm7Ac6cEeJD/BPh69nehlzFKihd0H/?=
 =?us-ascii?Q?g26kgDB7+CfuzOmH7S5QHJ01dsjc7VQRlJ+HlH3qKHT1U?=
X-Microsoft-Antispam-Message-Info: 76GjhS7NaYrTETH2QZ2TSjHCzk7N221zFFk9UbaNNzoGSobaJ9M3rKOL2BzQo1x3YjhnrV6fRGNx7JhPIvTfK6uHjleVki68r9Fxl7Wftns07pFkvFtddyb5iEsLgmH9ipNHTcPbHki3LL19Kc1Nvh+eb2NBlwDtt5veknCHD7kd96TGGlu7lW6H32H+OHeh
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2772;6:VOtE3ETYfcpVra6bxP2WeC7I3zV37bjxOiGnlQg7/8q2pdRk/3/W1bE50bJ2J0Fl+YII+UwjqdRg5g1DxmvuWQUVYj+10NbEcJocyHu3Pa8mZ+W9/svTVKU9zUX8ITCLDpIgjAkaymZM8zCgv5KvcMIXOVearzMZ2uyF6312WQIidhi68rHtMAxd7O4wM8iWk5Di16DlyhkYgJEXZ5gBjTjD5F9N/+OeeRXBcKrZK/+wLJ6Z4ScMNVzJSRHyQKaBNidaFmzqfm1DR5Xx5P96Nh05YsJIzMG8Bbq8fS20i6EmTzXD/gICtmo52jTTUnkZN1B+bdKM3H5SftGpz0hOuHqRWym8P/z2b50Gdy+seiItbhRjhnqJnRSg/yloDuKhGZTBKZ7dVYxERTe9/gICUCn0iiYwKv1cb/7cW8iutN7mvftLZ6eplup66YdymWPCbpNbh93JDWzHqnpPO7CKyg==;5:1jj1BZoRzzNI0+UvfbuPh5mIE3wQaio6zVrka5rqFTym3PTEZnDHWbR9oXOSD8wt0ityCWmPrpjdlDZvRlmiSdbIRxKeS0ZAvDVF8Zl8gDwzCb3IHRweZbLFX63J3bOLunwytXFT1W1BMSiVQeg8Sl45J5Zw6Vl8vmjvTlbjQPo=;24:89eZyU55wYV9y2VnhaworvCfZqI2hbf0GXlPpnc3++LU3IC+JJ7TAvMC7z5m5BXrO9HOIwWjPeY4hOUvCiYJ2WThVlyjcgjINuj/u3ZCoXc=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2772;7:NEhDxNpg3TsznHYID+/IFiGviVWWfwBdcdbMvq8jRnf0xlkZqCGyWpHlvla3pxRfgFnO2v7SADoYGhYcowjfyTDz3jVv+gLvBnghCt5QO1jbIVtjHK8w2C0BqvshF+Z4HtSTIkMfD5nsOndVKhGYdLubhZRfCjhGNKqqSADw5huDDZ0KmrNWRYlbjM8coNlaFLgRaeHrtd7NybAjSWkf27PLsLtJyfBihJJM+e49GrFb48re0GfGaVX47tF28nex
X-MS-Office365-Filtering-Correlation-Id: 8d286bae-b673-4a74-c455-08d5bb15fc7f
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2018 10:15:44.1437 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d286bae-b673-4a74-c455-08d5bb15fc7f
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0202MB2772
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The .of_node member is going away.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/gpu/drm/bridge/cdns-dsi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/cdns-dsi.c b/drivers/gpu/drm/bridge/cdns-dsi.c
index c255fc3e1be5..e9be5c3f0284 100644
--- a/drivers/gpu/drm/bridge/cdns-dsi.c
+++ b/drivers/gpu/drm/bridge/cdns-dsi.c
@@ -1548,8 +1548,8 @@ static int cdns_dsi_drm_probe(struct platform_device *pdev)
 	 * CDNS_DPI_INPUT.
 	 */
 	input->id = CDNS_DPI_INPUT;
+	input->bridge.odev = &pdev->dev;
 	input->bridge.funcs = &cdns_dsi_bridge_funcs;
-	input->bridge.of_node = pdev->dev.of_node;
 
 	/* Mask all interrupts before registering the IRQ handler. */
 	writel(0, dsi->regs + MCTL_MAIN_STS_CTL);
-- 
2.11.0
