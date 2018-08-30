Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9916C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 08:10:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85F312054F
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 08:10:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Ca/K5LgJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85F312054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727659AbeH3MLJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 08:11:09 -0400
Received: from mail-eopbgr40047.outbound.protection.outlook.com ([40.107.4.47]:19072
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727588AbeH3MLJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 08:11:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RsTwLzZTOnItbR0mNfjKvlpUzZoxj5Jn+V2Ad5AwHbI=;
 b=Ca/K5LgJk5YFBjnIOSB0isx5qsPH3WdX8EvWdqjz+19aWHIHa5TpPMCaFnb8t8lXGqA35/SXed1BmOEFyZo+l2JDeA52IytrqHHUkdN/bdYMtSKCrbvntKq3gu6vKFvh6FCNoc5Wd+VV/BElKosyeP6OO16GBGezI14UC/Ggyds=
Received: from anson-OptiPlex-790.ap.freescale.net (119.31.174.66) by
 VI1PR0402MB3918.eurprd04.prod.outlook.com (2603:10a6:803:22::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1101.14; Thu, 30 Aug
 2018 08:09:55 +0000
From:   Anson Huang <Anson.Huang@nxp.com>
To:     p.zabel@pengutronix.de, robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH] dt-bindings: reset: imx7: update the compatible string
Date:   Thu, 30 Aug 2018 16:05:25 +0800
Message-Id: <1535616325-17445-1-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: HK0PR01CA0027.apcprd01.prod.exchangelabs.com
 (2603:1096:203:3e::15) To VI1PR0402MB3918.eurprd04.prod.outlook.com
 (2603:10a6:803:22::31)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c5a04b7c-ea61-40ef-85f2-08d60e4ff9bf
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR0402MB3918;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0402MB3918;3:hYrD1YDfEZIpsgNkQ6ydM9j4hUDO6Gf5uo08B/LOyOOQtCHgWmTKh+jUspW4fRd5O8D8So89/ft0LRSnX7+xLXGhkHljJwxsPj2Wvs2fTLCVWetY0EZiXDiG+YKW+YZImNqXFsYJGXp55qGee1iuQHQWjVgJXnxqes65sI1TFG8tAxErlDow/E5I90p+fiosR8uV3G8zgZph74SkarsVtgeKZESwvoW21iLcB1GT5fY0KbO6l7xcMDYq4bDf+wzi;25:ZDHhwwJWZY3jf6LZS/gkMFIfIT6O5Tkuvfpio3oio/qkiLswm0Y3wfy87j+KDjBg0vceZfDm4kQobaKMcSPkf6J5GL3ztRHlGP/yfSO1D3hQJk6CWhpmASTgx1GywaSFx0AEWhyTR72RbkiRCx+iPXG75jD6J7freFAx36WwMq8v9JxbUoDIpb87ZahqJu+m1H+06ON6aVUKcNIk+6Gv/1Qoe8PsNo6Yq9gWP2C6FaHqR015DsR9VDPDFuWAyEy3o+gxxgkkDRk9kojPEnCpujb+IpFAQUl/IpCtb+h8t7SrwJ6tquFTDip6wjnWsqQXBtrVkRymh3sRXXAGHYDLUw==;31:8lLQinfGT5mhIPobXCIQ4XZFmFKMKZAEODO1dzog07FRmJTjKgCEF5yIpsb/Tk4dDmKwuK3zxj/CZJQW5eEsCeuMoeZOZL7YWf3AGrJs9WoVRkBQFYkt+3wq6mZFda/jOKUowEO/LB8Xa6Bnbvw3eX5R5KOOOOeT+dT0TdIn/lYCAFaP/EfL6lKhgM6QXL2EziGc4nV+KWz3m1Xl0Ubjf8PTjZGS58MRVE+QIq676bU=
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3918:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0402MB3918;20:Sve0hjogg1IhSTdpyfQqUHu/sMX06HgWByB+p0l/nZcJdh+typExK11jAwRa3zW5GhmdmkP4IQdKo2RQVDCAt9Rs/wwn4DtFo/GD+FfY8WDWpZcVAQcDIyJ7fKZ0dCc3/DDJq3DzzyaPLf/Jzsp1dObuRbdcOJ2htI432IHPxtJmTb0gha8fmomKCixh2Z7pNeKjdoA4EsgmjXnYnRMBccG2OCTErX41fsHExHus4zbrXQ9kkpCtzXjQSRyUNWsYn1I7ovto5IWJoqlgymom8xf7/1Gpw9tcaexoB481fPSx31/RJtxCImSRvXyBnCAARs6II5urBGls6i5YJ5GD5eQiC7gixp/4FAAjunxJ4LUvUyxf/2bu0DmY+j4iesVdadD1iyyiqdzgHK1Pq1a60TPrCajbXnnJtmpH8icLqeaY8LnwRkVtYrLbtb9dIB2g9VcwCAYnX1TM8X9BnnxwG8C8j7QzN8WE+p/4WDbSzdMpYUm7Ddf8fd/SEOZ0yxED;4:0R6e3Dv3DEMw9bZyiA2NOIjsO/kGu8miK3Bdv+UpoWppgINKRHRnq9Od4Ofh5qka/PNB7y+3dUkeEuKLHiM1XoQZRiJowdUeYjQXiyslH4iDa3Wpjqq89Cqpvvuaj3eAZi4UCx8+WjSJrSw1ejhrN3n1Lk8ufAC9Kc6I2aggvMUnd2Ep+7mLcN4FrQvnciKk4ToMofrWrMIwuTI/xiofy1qtpGdxkILvYXKCHLSBM5uOHDxStlHJfYGn1ow1czKSUTDM7qvu9ql4w6fXjAWSIc7B0t89NfJNzjeYDwHCveWYhhGHvbFMRzkKoOdc3drW
X-Microsoft-Antispam-PRVS: <VI1PR0402MB39181120254A8B8F8C9D9E1AF5080@VI1PR0402MB3918.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(823301075)(10201501046)(93006095)(93001095)(3231311)(944501410)(52105095)(3002001)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699016);SRVR:VI1PR0402MB3918;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0402MB3918;
X-Forefront-PRVS: 07807C55DC
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(396003)(376002)(39860400002)(346002)(136003)(199004)(189003)(16586007)(186003)(16526019)(26005)(316002)(6506007)(386003)(8676002)(53936002)(52116002)(51416003)(6116002)(86362001)(3846002)(956004)(476003)(4326008)(1857600001)(14444005)(478600001)(6486002)(25786009)(6346003)(2616005)(486006)(6512007)(2906002)(97736004)(6666003)(305945005)(66066001)(7736002)(47776003)(36756003)(50466002)(106356001)(105586002)(50226002)(48376002)(81166006)(8936002)(68736007)(5660300001)(81156014);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB3918;H:anson-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR0402MB3918;23:Xw0wvRMLCz5mUVBTdhd0WXxH47JLg9rWDKsn3jp?=
 =?us-ascii?Q?2ZAu1MZj4ixXLLY34BhCvRhYu0B9RXrxu13z00J5OnDCXlYImlH0pBVGLbE+?=
 =?us-ascii?Q?JXz9ulc5q6pYpUaaw+RcWEa/skKKTCEE5EdNmlH+aEIJOuYjWB8kvmvAQu6s?=
 =?us-ascii?Q?txoCG4+5yNyZVbcrO/TojkRYInMUok482ZLs1bTBZ+ZZsIWoPI3GFWv9deye?=
 =?us-ascii?Q?EKX+gHdOYKCSgToRGlJ6/1PI6SJiOYlDV96LXZhDW2Kad+Rt/C1mJUv41ack?=
 =?us-ascii?Q?aDi/gp92dMHG0BXcfBP9y2YqdB471foxsdDdTULUQHrnuUxdNUdOKDjvsAKn?=
 =?us-ascii?Q?BxFm4Pur60BaX4YABmSogdhWaDetrpicCrgX1lYULu81NmKP/KxiQeQ06dEY?=
 =?us-ascii?Q?YGtLLojGhQsSqtU9YU6tsIfwj4ZNmR9D+L0rKQejTOaqw4XWsqha1F+yBjud?=
 =?us-ascii?Q?I8geQeSSPXZrrUaJWPE03J7oc+yUOJ6ZRtSam1cQxDfrYd6dsp7N4kNKpNMn?=
 =?us-ascii?Q?lb2shRIPNnsF8emdKIOMWGZMO+aOt2j8dhEcojc5CgCorGaVmIY3wvjdDfnu?=
 =?us-ascii?Q?PEvsxHPkgYrMKhcuHIPG1LsOG8f79HWEThvuBjPQwf99VY1RcT4767W3zd7g?=
 =?us-ascii?Q?a1788tZ4iMb/oSs1wlRDiCFh9BrPmhQdpvGpWnTZDU9uFKW7sC5Rzd+LXk2s?=
 =?us-ascii?Q?q9ME42cdWR2Vc6q4AumJBAC/KXwJ7lK3PLAqJfvDXEs+nzTVITcPxyISXP3Z?=
 =?us-ascii?Q?B/eovvps93cfTTrHrWkYNX7OcWm7RMPyENcIQs4sDUhb1FVcUSa+h7iR/rLT?=
 =?us-ascii?Q?ZyuirT27qnaUy8Qgy1WIWqu1DogibEhFy/V1rS4OOfxTcAnoQLU3g+4nq4Fm?=
 =?us-ascii?Q?Q+aKNzcQnIbefsZLdWiOQp1jmo96KbzvmXfYIgybz0PdNDdZUgsQtXWCtPiy?=
 =?us-ascii?Q?zLC3JDh/XthNugYUe2xFbCtH6BolsUWMYnAiOOhYJGQD0Q3vVBjASWa4dsH7?=
 =?us-ascii?Q?r4Ulbkc04l3+DAI3/IydiNWJPl/ZMRHmn/2dRoR58ZSqnGGmGRQPvgPO8PBC?=
 =?us-ascii?Q?ylJnVWFIBxftdtaXXJnYDDy/sqtFbo+Bb5UomQt2BNLZ1y53gdGN+LbGWsoE?=
 =?us-ascii?Q?WbpU2jiHDJxmBSVWeW78rER2h1si4sfuXbLgUThNkkcPg8wbhUzYKOQ=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Antispam-Message-Info: FLsbtj5HWHM1khJpymCKon0rtlxCht4uOvt6iNhRgg28tczIa/yniElNNhCSd5WAxdkL1d5jpfGHy9ZMWqvWeb5Z/bSplfWwE2neuShyCvegLUyGgXYOZ8U1qU2DnI5qcTCrldkmx6ZOWYxaaXvK4Xq6FvRUEAa+59x/FyEU4kASpHhJz56IYTuCxA1lEL36PRar2uuyT2UyXezF6xcxgs9W7hO+XLmonOEz2pRIezydeX9cpGoFTYWkRvosSwZ391l+c04E2hItPvJT/LCv6mNy47OOVKP0TYHVmVy/JtqCcu2iGxMT0gL3Y9OCnq3I2Fvt4kUjMWky4u80iBpq47n0tOWcJ8EjrtY/MqM2ubc=
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0402MB3918;6:36DMtZdh1cEA8FYeTMAtuP1iugmeXBpt1JIh6drUTSfptjbgKJT1sIKP/lV+4uFBoDOMUWa7+XVcsZobrMVYz31HM03ryXPYi2eueA84osDCAITCRa8qXKzkwsj9Gni9DY+YshNmDqyR7TxG9tWWksozwR29a5xIaucVM0sPSXAPrJuDVLEOuNxwDhqmgZUpOz1OUT6QkeX0rdHIbR6+OWF+aVyPCKhO3B54/w35XyL6p5bn0TlCaxKjQy8h+t8PoAXjV+RVoxiesqnOf0zqW0VWP2fGsjiTkf7Ri4CyuIzAEuIlNYOn0CsEisFYllQ1RrLBHNTypkGAei794ZPS9d1DqKDZe7a4Pv+jZMlPkH0cah0dZk73DwMTiDzZ+yMhI698Sj8QNiFTaOEt8R0MkheIY80K8vYfzwlq+dunjl5oMAoJVer+JdVba1BUytuuNK4qn7j24q1/ockeywqsXg==;5:FHDtfF0bipUUuvSQxQjWlpAhNY4LyVAwkbCY5RA22gZsEitzmCLKxdkQdKMM5JP+UkDg5YWe1mPfB6gsFoiQKCS0O4ua14buXkNhS+wyzI4nVjGZolCt7E0rGSRMImyTCIT9qzcgAjCmUU0inwe4h9nw5T0emAeDrxCArzJHrlI=;7:ShH623sAxayzAYJU8/8N8LRrzvWsnZFCCd8yJwcmUEOKz8XuGu8YBvRuS+IhwTHTzHVnFLL0QWj/BsAzTPjqg7C74agsUkTnr5ELtkgD/CGvbB5EWGS1dwKjzCIMrGJBHRAh0oCrfcJ0liHVC7u8ec8clvi/+DEsdatR8iTVXJbPiyCaz+nxyo++SymPD4qNZpiLYiGhRsbg+/v0v8kOq2VaGg7yCL3ACNguL3nxNsryJosIsoDk6n1ajNPu1rU5
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2018 08:09:55.1020 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c5a04b7c-ea61-40ef-85f2-08d60e4ff9bf
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3918
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The i.MX7 SRC's compatible string should be "fsl,imx7d-src".

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 Documentation/devicetree/bindings/reset/fsl,imx7-src.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/reset/fsl,imx7-src.txt b/Documentation/devicetree/bindings/reset/fsl,imx7-src.txt
index 5e1afc3..1ab1d10 100644
--- a/Documentation/devicetree/bindings/reset/fsl,imx7-src.txt
+++ b/Documentation/devicetree/bindings/reset/fsl,imx7-src.txt
@@ -5,7 +5,7 @@ Please also refer to reset.txt in this directory for common reset
 controller binding usage.
 
 Required properties:
-- compatible: Should be "fsl,imx7-src", "syscon"
+- compatible: Should be "fsl,imx7d-src", "syscon"
 - reg: should be register base and length as documented in the
   datasheet
 - interrupts: Should contain SRC interrupt
-- 
2.7.4

