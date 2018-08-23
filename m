Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46697C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:46:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E70832077B
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:46:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="QjWZoRgq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E70832077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732933AbeHWMOj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 08:14:39 -0400
Received: from mail-eopbgr10047.outbound.protection.outlook.com ([40.107.1.47]:36156
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732864AbeHWMOi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 08:14:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EgOcUnwHg+5U+IJGPCK5r7kMIPIDW4+f4sTrrBibscg=;
 b=QjWZoRgqIJyG1gNPjcrFxicEftW/6LIkBVnnfJz/KzDifBi3cpT3p51fIUNUQq/AWtgbpqr/nGhXkyi9hRU3DvqKeOp1cMDiN3KwXgIV1KcgkzkbmcMCx4UEc5f0EDY+e+w4bdFi533VT6HUwoAbMFsJ/1tXWGtrgNaL0M937B8=
Received: from anson-OptiPlex-790.ap.freescale.net (119.31.174.66) by
 VI1PR0402MB3918.eurprd04.prod.outlook.com (2603:10a6:803:22::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1080.14; Thu, 23 Aug
 2018 08:45:53 +0000
From:   Anson Huang <Anson.Huang@nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        fabio.estevam@nxp.com, robh+dt@kernel.org, mark.rutland@arm.com,
        stefan.wahren@i2se.com, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH V2 2/2] dt-bindings: arm: add missing compatible for i.MX boards
Date:   Thu, 23 Aug 2018 16:41:14 +0800
Message-Id: <1535013674-21356-2-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1535013674-21356-1-git-send-email-Anson.Huang@nxp.com>
References: <1535013674-21356-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: HK0PR03CA0085.apcprd03.prod.outlook.com
 (2603:1096:203:72::25) To VI1PR0402MB3918.eurprd04.prod.outlook.com
 (2603:10a6:803:22::31)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2b76eaad-582f-4e81-bff7-08d608d4d868
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR0402MB3918;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0402MB3918;3:hH9x337v88B6PXv1C5NVERyf2ku9sME3iRFzzj9t/rT6VLKrJbzd8Qq4MEQh7phpBOwX9pc+aB0Ayjx/hTRK21/c4DbqxOKNiBo4hf0FqqyhUxO4/0tbXDZ/6IrD0U9ykNg8ax/AeyM0Cg/2wK/th4k3mboGP3fTzxZw3DfwKYmnXrQZyz2z3qHZulGd9wSmyrSIYug9vRy4ijMNBaUj0JCF2hXkl9nntEkWAbtJEi08TqWbtkcpw7J419NXulZV;25:JAxFA6FFkyvSEFIe4+Qo5CdENxYvYaVxavjqApWZ0F7tXahaZugCrgmu+y44RkUpxqePOfXWFC/+ldQirHM6agOTWm12TsbgL/QC8PYsugKfP4Z/bG/9a8LwJX4fLpk8ob5nOxj2z0Tk5GqIW68dlYJ/8w4BLvdlRCeYP11MFpHDEntP62ZXphoWxsXm9W9AGPuMuQbXyjEZJZdhVOYlzoInfZP+RpT6nzPKoalUr23sRDEzxeB7T04llDuNo45losEohMKPBoZoej1oQAnEfnIcWUYFHVYajNW+0EtTsNyt3bSLzggvvlsKMFezQDYpQeNw3/U5f1BkjNfV8NAmtw==;31:3UhI5tVMtbZlQCKa1DRApEheooHtuPhsw9i+HeYyQFK1E20Msa9WJm9ZBpn3+l1K8P1+O4dPhIldzawcINQwPr7anoA70SAcQSqhcaDMgHLGcrehOrZ8S9HEh2iUMk9ufDpuz9uXRH6JmVd8MtyTMhoer23Z4DL2WZWyUY//GqUmciw6cc3AGitZStg7X5Ozsuq+DLhCOiwZyfaKuOOyKz5ILubikrn9zh2Cmm1phSE=
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3918:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0402MB3918;20:kV/NLMKpWdTaWbtD0RXcZuabDXdcMsNwLxD7OC6qwggtDrhtpXCEKWrZXAY0tj6QHyFXEWr/wtYPdc0/OmUYmXk5kNEShAnNR52I6RQkkstiUvXgyPbiLOGzes/kjh9TC7vHFvIGTj6TaGMM8/4f8LuCwxegsuiOJdGC6qCYElG6NHiNg2Vc8AAsXI352fR0wtRq9MIWYtmZasWGjArBD10pokyfiKWjS4L3uZpTRqN7ziU1SfOLO5ygeXcok/p+SnCDPCjsd5Zf5UMnRiVj/ML3LyhnO/IMmqiQRF92a8suLoEpC/JbdpCKps3POgUrL9jhc2pEiSBoeOs2OpCngc3uneADr4LBpaY3XDySboyD6RCf2Ut/373XefZILBhS3PegU9uZehb859XDc3n6q2F+603+0P5tR3GK0zJQakTP7f+ELbnIu8TOk15S5i/9F1jUHPfdahK2OgbaPrby367YIn55s9YNfwEVWj2/BdmlKzXqcJQjFFnopjvswyZa;4:tzI6Ax68Z2Zzk6VXNELxIbEFuftypIBKTMGK6rpmM8u1NoEFfxczH68C+eIRxHNLk0jelJL3yzZEV9rqsxV8wKo9SnUb1Y+RdCXFIG3kHaKYXyZKrdf3zu4j9skHBLL+JDvNrlDfx37eQcgAAJdMA9POYI6j+zd8oC+MjLsqmFUofMdiE36xq0BW2NVVqpoDj0XSeohfdOTmdPzWkdn7SkhpgzlHA804upcSiYAcdn8gHPukDCJFqLv0XxhorQDB50wMCl2BXCVgLFbCGoBX6mYbrgDD6RyVVju1l8w4BfYxOupnJyIf3Qm6QibFhJCj
X-Microsoft-Antispam-PRVS: <VI1PR0402MB3918AD4F9A7B34D7652C7CF0F5370@VI1PR0402MB3918.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823301075)(93006095)(93001095)(3231311)(944501410)(52105095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123560045)(20161123558120)(201708071742011)(7699016);SRVR:VI1PR0402MB3918;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0402MB3918;
X-Forefront-PRVS: 0773BB46AC
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(136003)(366004)(39860400002)(346002)(376002)(396003)(189003)(199004)(6512007)(6666003)(186003)(16586007)(16526019)(305945005)(478600001)(25786009)(53936002)(6486002)(8676002)(446003)(86362001)(11346002)(7736002)(386003)(6346003)(51416003)(76176011)(26005)(6506007)(52116002)(316002)(2906002)(486006)(5660300001)(36756003)(956004)(2616005)(476003)(105586002)(97736004)(106356001)(68736007)(81166006)(8936002)(50226002)(81156014)(47776003)(4326008)(48376002)(66066001)(50466002)(3846002)(6116002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB3918;H:anson-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR0402MB3918;23:GTmdi18CnRkh1P+xLg6Leew4kkyWb41DzcSoebz?=
 =?us-ascii?Q?Nj2oiTyS84AsYu7IgObM1jkIt5HkYcXLWAFpe8YxkxGjY+mjhcCNV+jhhH0f?=
 =?us-ascii?Q?DVElIN9mGgN+vZ8d2IRXkIZQ0NeVYrp1dBhIi7E7SWRk6gZGJrS2dvRQKFeK?=
 =?us-ascii?Q?sO3Aodn9C3KjlTFgBzrx8ksaq1yD7Vx7FiL3zElOU1dhNdty/ezW0G77fO7v?=
 =?us-ascii?Q?7S3CmVFPL5cx6ltAIZoAb0Wki0KFI+IZkZVmoDzddGhvu+qDIeYULHthcApH?=
 =?us-ascii?Q?D1u6RiEhy76E5FkVqw8E3pFE/vb532t09F4ETyqnQ74myylTB5gmUosOVBlI?=
 =?us-ascii?Q?BgPYBf09imd9SjxczKzr+6YYAGE0WqORANiiOC6YxF/OeOKejbO3InOM8v3P?=
 =?us-ascii?Q?oNSwlBv5vMjVtPii5Fh5LU71GQp6/HN4sfskhfQtHnHXAkMDhCKwoBxZSurK?=
 =?us-ascii?Q?k/8CkMybVY+Y10o7pg/JiagnUHvqixSjCsiLlLlvmeSXeK9vYJYuA+HKh4Vh?=
 =?us-ascii?Q?/4r/XP53c+S8dG4YnNPWBosZ4bNWY37ubMstrPdYZlNpVJHb3PozV4Xm9TCt?=
 =?us-ascii?Q?BlLYU4XHYFAZTc20RJpatdWyfMMVNeLTDqmg1ZohISyCYrqzxuvhw4I+GC41?=
 =?us-ascii?Q?IQF/qKuk5ueqSacF8erqINJyJI8PvInYg+Me7BpXdM9sqbrHBVlEdQqGMRic?=
 =?us-ascii?Q?SrNDBiZnzTy0ygBF9chnX4Ed8+dEY6EjL7bHe/tdGTRRFym+CIZW+6pD8Tom?=
 =?us-ascii?Q?Oj8tjWEaZpPzZbN7LeB9TaCVgm6/tC19TqEI+2dsJ4N8jGqExp2Il21wLTbM?=
 =?us-ascii?Q?gOvfneeJM56RJX7jQ6rrhURRu6oLzsiscqp8cPsu4Ut/vwBrOsE0Hy80fIMr?=
 =?us-ascii?Q?Kd9zbPl6kjx10Rn9BtN6LV58hiG3VC1SgENwLcQUPhKJNs5W2ydOlDenj4R2?=
 =?us-ascii?Q?/5MAUul/66oxWrLrRsABIe0gpHl9eiP/ldCjDkXdBhgXJ83rBI08lQ5FMx5B?=
 =?us-ascii?Q?sRiLnPlYt3wPDIaz5diWWNFT4J+oueejuQB7YKNPj2iL6uw+Yl1zghxE5Ml6?=
 =?us-ascii?Q?598ydl9ISyHBvtlr47mqUFtwoHOZZU40aPATGBTSpaCT4MXf03YC7QUChgqy?=
 =?us-ascii?Q?wL2BM9vIC+lhihSdHfnWCVvjeddHJJxK/HR/r+zEJmfmD4nSlwBrHs6I+65W?=
 =?us-ascii?Q?cfBktuqh4dkQ9Jqw1L6Jx7pp8IsI4HYsROkbP?=
X-Microsoft-Antispam-Message-Info: EQkJKymUutZ2lQUPPFOGuAjd4h0qLI422Q7r2N23dTdF7xbBgynMWnMbaxPV2DzkbkeJ7l8iOkrdH0yiFpT+EakQuDjPE0YGR5DHhooc0Vrmwpn+p4CwxUl82cNbRVcxwevfcYm3MJJWEOLsjeHLccWKd6jqDRiagyr3CH6znXJLkXgYKQis47G3U+bC99ioa1EQbFn7LbzobQcnTrLugheGu9TKZ9qDHnenRj8JfpA2nbhW145OVi8oD3CDIsvDJQtPThNyc6fXkTe7vmlIOWPhnrds5v9jNiPDT85PjbWE5ZwSqOi+f69La580I41IKeFDABWCGE6N9Qstmy3VmP2/EMTcOOskaWlWf4Gj8cY=
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0402MB3918;6:bDR3m9/+MFjjkb/pgboqukWl2jmxevzV893YmwJh/E5IW3RwL5FVw81z5tl7aUPUSyoD5uNRVrk/0QQVQn1e0wYTDTnpg42WE7eU0pt/SNJ0JVLjJAyA8JyFCBPAl7A8O5dlegn9/N3SgZZ+wFt/YcVSA4Ddr4UpMNiSODTTkfm5159Rjy8naeCqbx+sr7BP9i11M7P/vvzD3N4nMoUPpUpmmcg8Z6z9WlR30VQgsSMih2UMHngFhIPOfqxclHYFK/F5fzDVcZDH5jb3jLDMbptosA9K6uLmd3Rlz3vB37PYbvdTxl2t5jx6StlW3MplTyQK0lZjb+x9jlYQbaPLLo3Fjshv8XKNKcQCHiRgAJ9fjeFYrQO7a2zxEefUR3FC6vLyEghM2eyFVw6NZhlhhRhZ8zGlLgXm9W4n5DUuMJ2wpRvKvPfND6bi0dzZR0hjz6yyzeK2MTm/9B7EyntCPg==;5:HM6AoI5brF7QgzJiosVPZ+VJ+iMuPsPmGjKyTmtOfNzx3p2i0tUvPv8hXzQke2zHaxEgGd9KSP3xUIyH74klwTjjfHw3uilfBN3upoT/QvBUpZ/yNhRy6LMvU5L4W28sqjXwZKv5RSmoFRt7eXwQP9E48/cABn6UnKiEFBbDdBE=;7:CTywAJ/ZjKOJ2mhBIWacLyuhMx1M0Ty+8hQiaiXdGGsgoJ4hcq843zygHDvArkAZvSer2IB5YMwX8DxerT3Uf49fQBNLkjWpfz9KAZ4aONnphI5UR7hzYYhKiLhYXQ+xOt1iD5de8ILrHJtjYhrO540b2fZ9nwtzxEz7+kLSMcSJw9pqyU8RffdBgCBReE8dCG1xRD63KMmfzN/hjvccgMsjJxFEIEE1F9IPd27jEAtO2r04jqK7TLEz3O/cXiUX
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2018 08:45:53.4617 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b76eaad-582f-4e81-bff7-08d608d4d868
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3918
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds missing compatible for i.MX boards.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 Documentation/devicetree/bindings/arm/fsl.txt | 40 +++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.txt b/Documentation/devicetree/bindings/arm/fsl.txt
index 8a1baa2..968f238 100644
--- a/Documentation/devicetree/bindings/arm/fsl.txt
+++ b/Documentation/devicetree/bindings/arm/fsl.txt
@@ -57,6 +57,46 @@ i.MX6SLL EVK board
 Required root node properties:
     - compatible = "fsl,imx6sll-evk", "fsl,imx6sll";
 
+i.MX6 Quad Plus SABRE Smart Device Board
+Required root node properties:
+    - compatible = "fsl,imx6qp-sabresd", "fsl,imx6qp";
+
+i.MX6 Quad Plus SABRE Automotive Board
+Required root node properties:
+    - compatible = "fsl,imx6qp-sabreauto", "fsl,imx6qp";
+
+i.MX6 DualLite SABRE Smart Device Board
+Required root node properties:
+    - compatible = "fsl,imx6dl-sabresd", "fsl,imx6dl";
+
+i.MX6 DualLite/Solo SABRE Automotive Board
+Required root node properties:
+    - compatible = "fsl,imx6dl-sabreauto", "fsl,imx6dl";
+
+i.MX6 SoloLite EVK Board
+Required root node properties:
+    - compatible = "fsl,imx6sl-evk", "fsl,imx6sl";
+
+i.MX6 UltraLite 14x14 EVK Board
+Required root node properties:
+    - compatible = "fsl,imx6ul-14x14-evk", "fsl,imx6ul";
+
+i.MX6 UltraLiteLite 14x14 EVK Board
+Required root node properties:
+    - compatible = "fsl,imx6ull-14x14-evk", "fsl,imx6ull";
+
+i.MX6 SoloX SDB Board
+Required root node properties:
+    - compatible = "fsl,imx6sx-sdb", "fsl,imx6sx";
+
+i.MX6 SoloX Sabre Auto Board
+Required root node properties:
+    - compatible = "fsl,imx6sx-sabreauto", "fsl,imx6sx";
+
+i.MX7 SabreSD Board
+Required root node properties:
+    - compatible = "fsl,imx7d-sdb", "fsl,imx7d";
+
 Generic i.MX boards
 -------------------
 
-- 
2.7.4

