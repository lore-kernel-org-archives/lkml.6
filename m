Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07E4AC46460
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 16:51:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FFBC21729
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 16:51:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="otZsUAS0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FFBC21729
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733057AbeHNTjM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 15:39:12 -0400
Received: from mail-eopbgr60088.outbound.protection.outlook.com ([40.107.6.88]:21050
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732984AbeHNTjK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 15:39:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+oLewsuNZT4YdYfTR0i5yd8o3+tWyyP96GNt/2JGS+k=;
 b=otZsUAS0ZmXC5NAjvIeyLL3AvZUwXvn4E3e4RENY6WmZDy27XlOd1PkJ87rTtpgu/TUC2GMm/l4YTMJOkvYOtn2tpIrlZsLnsAdH/nXRCQAtAJppDuXNVw1KWQJbwYx2Am8J9TM/UigHPjZCg8TVtU/jz60sk4qJ9fO09Jey71Y=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
Received: from localhost.localdomain (95.76.156.53) by
 AM6PR04MB4293.eurprd04.prod.outlook.com (2603:10a6:209:4f::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1038.22; Tue, 14 Aug 2018 16:51:03 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Lucas Stach <l.stach@pengutronix.de>
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        linux-pci@vger.kernel.org, linux-imx@nxp.com,
        kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v4 4/6] dt-bindings: imx6q-pcie: Add turnoff reset for imx7d
Date:   Tue, 14 Aug 2018 19:50:18 +0300
Message-Id: <e4e35d89f8e393cd291cb612a95faf1653a26f9b.1534264292.git.leonard.crestez@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1534264292.git.leonard.crestez@nxp.com>
References: <cover.1534264292.git.leonard.crestez@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [95.76.156.53]
X-ClientProxiedBy: VI1PR0102CA0077.eurprd01.prod.exchangelabs.com
 (2603:10a6:803:15::18) To AM6PR04MB4293.eurprd04.prod.outlook.com
 (2603:10a6:209:4f::31)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cbe96e33-afda-4d52-a63e-08d602061fd7
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR04MB4293;
X-Microsoft-Exchange-Diagnostics: 1;AM6PR04MB4293;3:vGmaPpdwcnNOxecIAS0K7HAOBQakg6bAK+Kr82EeoP+naRXoPiWxPqlpfuLfeH32C6cOcI/hr4W0n+dcoVXqyErf1yO2JBB7wKfKYcWUbqBnoF+K4EWRDOzME+gaO4PHsFHNvmeQCtqT2V9wsH6zE8Dr8QnBqfC7yzVHW+H5nl0z3yi88aVT+WlaOKKsaMlbQyyJPjSpk//WmfYH4P2Ehr5L7N/NEgqInAvDVR25yVlsj9n0GZiKgPgTmxRzSzt1;25:UoD7oNCD7gb1TqlCcDMD0wtXk8wRj7i+sP/ona6NZLRmEDTtBaimfITMoMrS3FnFKVERo+QiJkVVQ/Vg9TO9FBggUF/xGyx7vPheHWklUiZU1TeitkcuC8pAqhoy5NHOVk9EKX2/RAeY4NIaNZdEKv8HVU2YeWxlrBGaMR1KvfzJtddS+y3w7jxYnA3yf+Pswuprl23CGezh2wZXwZMtWsQWT5BiOkGAUDHMTdReNCfN8IR0QuGFey/NZgOGruoIQuupGn2/IY5ECFE9390Cl8nai0Ova4raw4E/OaswWGpLYeCDdUAutSVMTN3iYCT1Bt6ZLXiWU+Kyelh/cLREZw==;31:3ESLz3l9/lhjIdBf3lhDBTGgF44dccBSsIcq16TaCyvYCOdD4tuUGXyQXbTNSUcMZ0IAgGVcU7MnSP2Ui8U2xiot5d/DJ3sKxmiqoFQhqoltCKWproeRI/m+3X1o7tyuDlZ+xGQzlbW6NdSW5jjYVMAbp7r3qreC2p0mvC7QGT73YMqXBw3ay/Y6KQn/bjsyci6psQb0HaWzeea6cEuS5DabVwwvE2KJ7xEw2W2v6zw=
X-MS-TrafficTypeDiagnostic: AM6PR04MB4293:
X-Microsoft-Exchange-Diagnostics: 1;AM6PR04MB4293;20:LrxiQlfJKANQ4tG8wpJq6cfG07h/t4Yik8kPCUkxegixHjq80+qnHNF6NPyQJNxAGVKjHl9QH1uedG6tttZIPd+otlTxiMCuiHCMf22Re6l/i1UTSIJuUqdbVh+5iUIK5jotfmYPjKLafHMC5AdVT3EFaQdjMGpses+PLLYAlTj3p6uixHsTvmXbi+z27ES4o8f35P/RKj9sux/Pk2bbqLaj98c6NRmh6Bmt3UMrsRsPQ2a0PU6im8W7DsQ+nHKr3HzV3EZjxgUc16+ESrGS09i2Dt4Dc1CkxdIHTw3U6tRnjvfk5Wi1CkYJX/amGuXEkxieOAlBWMvSojq8U1HcinLot7M1bMVYvPjerT+6+DYsE1MuK54oo6fa0CAqu+ABQlBOElUlVH8ZxlKGpjNFpCw1QrkBI3y78XOCKMzEUGwYPjhsu5GJ2uUe28jJo8g/U7Y4h/DfB1c7bfdi6s7gYIIJqDl9MzZ/8EEdBt8B0VBcMoekW4qFsf6BIDCzLISq;4:fda91goF1P31O+netDOaOc+nmwJpHv1NG/ZKTza3iK9qC0Ut7XwonyMrZ4gtBrxumz11hRSQ7wSLolZ3oOAbkS0Rw8BXoWhFm+rHEeW8sQabN/XqfvKX8XJB3X/o2ekMIj6mEhHQhkbATSfwuVQ8jkkIugtTS8csaFai4vond5h1fkm/zgSXS8+QzQP+NlXjqnTgfyBIKHONX9In6Zl3ewXboi+TpkD+hDkJQfqmuQEmWzPPFGMHflkYX5t9K0lP/g4S37ZNJqtvtxnWFOCn2cSdPN19oMRU+lXIEGJGly/WzGBtzx9KoFUP68W3scIb
X-Microsoft-Antispam-PRVS: <AM6PR04MB4293AB63B22B353BDAF740E5EE380@AM6PR04MB4293.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231311)(944501410)(52105095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:AM6PR04MB4293;BCL:0;PCL:0;RULEID:;SRVR:AM6PR04MB4293;
X-Forefront-PRVS: 0764C4A8CD
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(396003)(366004)(136003)(376002)(39860400002)(346002)(189003)(199004)(118296001)(16586007)(6116002)(3846002)(50226002)(478600001)(36756003)(16526019)(316002)(386003)(26005)(186003)(97736004)(6506007)(86362001)(2906002)(68736007)(76176011)(54906003)(8676002)(81166006)(81156014)(8936002)(110136005)(66066001)(25786009)(50466002)(48376002)(446003)(11346002)(105586002)(106356001)(47776003)(486006)(44832011)(476003)(2616005)(6486002)(53936002)(51416003)(52116002)(7736002)(956004)(5660300001)(6666003)(4326008)(7416002)(305945005)(39060400002)(6512007)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB4293;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM6PR04MB4293;23:KU1/jfJYKg3xUoHfUYhMxHan3ALObCsO4v26RZSTu?=
 =?us-ascii?Q?3Pkxna9ogJDhkXLGNvzXX8ONhZv2zRSFlurfEbk2t7D2RTK/VPL+PjcQyHBF?=
 =?us-ascii?Q?tltv8gHy3mnBkWaH5UDP9pPCE1ZjJzoU6pWcgxbiuIOfD7d4DawSCN1adZBu?=
 =?us-ascii?Q?sqlpU+CaV7PS4JasP9ksxH6Ga3kM9jKVbTyl25h55vXnf59U+hadWnUsOlwB?=
 =?us-ascii?Q?rSlG30+NzNy3co+CMBB/tIqxY+WdesSxoYuqnobzvP6gXRm7F+Mnp9JA03R1?=
 =?us-ascii?Q?iQK7opa405z8FKQttql5lL8q4JF0jDWOmH/Uq8jJOEClD7OPpGzaDETCbJ1F?=
 =?us-ascii?Q?VmEAq1crP4WB1L2cHJnycK0fyrXe08BhfY0e+/zSQ0bZKHfyQqskL97EjWJy?=
 =?us-ascii?Q?XYhyhn3fq/6L7rH+jy54i6EkNOyL8ajtbbpl+7Rp+4QaSovQNEkjrNCJ3Jzo?=
 =?us-ascii?Q?+9nuzta34PWkfHcIvJkvaj0Glg9fnXMehDHM6MM4Ws282wtkY34g5+jO3KZt?=
 =?us-ascii?Q?JUutnS1CONmQyeiuQj4NFj0cGNse1FZPDYxX/61X8v+UCxdfXdBL0Cm/NpT8?=
 =?us-ascii?Q?IYrTNclBx0PLY4kRTJ9xevnwRCmh3oiqOoEY9S6qA0f6obK+mqEOo+onf2xj?=
 =?us-ascii?Q?dLRE4v9+QRNgALAEvnyRpRIq3v+I+cwnJYz5vht+BDD4LWWaSrS7RzFxepgB?=
 =?us-ascii?Q?nIADQP6GKPQNvfilifqHvM2UlZVb+c3vBbj+k1TOkn2nCGITo68oSongvJ30?=
 =?us-ascii?Q?D6zZ3qxrj5zUS3jM1Pv8kxJUNyfR78AHJZdtm0Pcu2OCGbmhUjCF+fp7NzZt?=
 =?us-ascii?Q?ttIf5BhE6mRGyZHpybDn1iV0vkh6gqfciWQV34J7tpvrJYtfk2Z4CAXdEcJt?=
 =?us-ascii?Q?NREzSy3QYCiL7OB6BSl3gjLiIVQlx+LGwUMp4M6pBtK0ls/DyQoU1/NN1lFj?=
 =?us-ascii?Q?4YS6FcqUNCT/0C2QIQGbPD1tvShrhT/tQmkxTWy+4CJ9cz26Gjz3718c2Gwm?=
 =?us-ascii?Q?ldZ8qiRVNMfDs3j6AGY4skHrJyXCPhcriTpZZ0hXPXdHt+K36C3auCPf95+I?=
 =?us-ascii?Q?g0GIOgqOfbg5EmqnwgTNkzvI3NY8VjzclBANyIksU82JWC91jatqjt2y4foa?=
 =?us-ascii?Q?zvXxBlQb2je23JJX+1DsMs11O60pCiITZ1S3EIHN9LK5i11pFuTHOzF0SNOe?=
 =?us-ascii?Q?pxGbzmdMLCT60Twu9bXDYjO4sB3pc+S/SqWOgs7/jtFzNlKahbVFPx/WOIAV?=
 =?us-ascii?Q?djJgdSyVdZaXlzJSnsZMwvms/hJy2jOpJJldS1PgWJrRIy1FUmRk1MJTeqZn?=
 =?us-ascii?Q?6v06C5UcMFCcxhcwlUVHF8=3D?=
X-Microsoft-Antispam-Message-Info: lwt3reYyyAkRM9iCQiqN40W9D+iKrJJq4a5UCGS9JpY9ULO4+nkgO1Sn/D8ByAwLsIdGUh5uByynISwuRTI5LOKegjqPV0rwAzEGO0KXF6Uj4cUcTSFl5TCX8D2oDsv6vrXntj0uQ8wpmm/5Woj20UDVwPzhDp4+GH9IGAQIwq/c3mLRE7kbQ7DfV0LK1Mgl72SbJeCln0pcqN2Dst+P36x5gE2x5d5TIS04jDtRwvK8j+I0ckzu8ytGLC+JEnAPZ19NymA/T0MyPUCb60bAkwD+DocEM2kPT9FkvEx2KYo8Yk8liIbmkNGRRMSLTNZDiCTKmVLAb45W0L5s2DAe9cVl+Cxl7eYO6jzhH854gfA=
X-Microsoft-Exchange-Diagnostics: 1;AM6PR04MB4293;6:W8Al5ZkAfwX9ZFksTHs3MXgolIz50jbDsB959JSOa0mQB/iRCRoEpowd8s2IaV3kBg5f+MKP4Rt2IQ8jeykz7W8ICxNhsX8EhKv6XwJfemmKY9J1bn/83yP6Rk4tcqRPNcaEuwQiBrAAN5ngbZ0YDIf09BCbCmwFLbbpN1xoU5+I3SWNoH+dx6HhGp9IuQ5L/hNvonBnoy3BqXy7OxTNeI2MvlCe2dkH8uB2ElqXGI54vLOqB4K7iTsMe5cwtyimEUJeAlHBeg1BoQI9FbwqoiEsto5G7PTnoqy0XXwgW255yuNyqxrqmY2fAxgc+mzhKkZOWuSnDzGQBXuHtjSjTdEdMJp182fINjIUbgTat+6SXhclFGyoLVQ5epyzAbMYEYTEk4mmaJfQzwzsqqH4hR6W/YlR94nzYuvLpr4tX3m6ScR8/FsXX3o7r0LVUmee4o3kU8oncfF/6t2E7G3s2Q==;5:RP3jer3pD5PPywlVBFgbU1bV5IvEdUxa2j5TXWp3YBEUsOfHdKJWNVCCk+eEEaXkKA9hSiRUfki6Nrrx3DiHcbItxjemoxTS8NxRP13MfRDJ/ZR/qF2sfKrog39TxUAYlWDjOsuoCno7o22D0ksqDvwtWVXNrdZItUEEW4Yw3Rw=;7:zAfJRzSLQVQJA2mqiXOTGuS6sTz3wdLcrm1Thju3naXRtuiod8wXvrtnrDjoWHhncZJYc3jD0DGSm7XNrlZZ1B8RRwZpFgPOGvrjkX525Qn/AZ5VNzUQ9O4cz5tOSvo18CFcOawcQD3SWtMcA1IGqmYkOxsa4C/uTZ6/w3b3aGHVEgcPixX2G3N7ARAm9/Odbg8cE3cUHgECqiAI5e/vxSXfBmXTp4xEP+gUSKufoQW4E0gGn9wIgRCiyf4qq6v0
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2018 16:51:03.5641
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cbe96e33-afda-4d52-a63e-08d602061fd7
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4293
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is documented as "required" but won't be present in old dtbs.

These resets are also present on other imx chips but right now only
imx7d implements them through the reset controller subsystem.

Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
---
 Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
index cb33421184a0..f37494d5a7be 100644
--- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
+++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
@@ -48,10 +48,11 @@ Additional required properties for imx7d-pcie:
 - resets: Must contain phandles to PCIe-related reset lines exposed by SRC
   IP block
 - reset-names: Must contain the following entires:
 	       - "pciephy"
 	       - "apps"
+	       - "turnoff"
 
 Example:
 
 	pcie@01000000 {
 		compatible = "fsl,imx6q-pcie", "snps,dw-pcie";
-- 
2.17.1

