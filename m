Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FD78ECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 05:16:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E5C2208E5
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 05:16:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Tl7B8Pi9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E5C2208E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728030AbeGQFri (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 01:47:38 -0400
Received: from mail-eopbgr80079.outbound.protection.outlook.com ([40.107.8.79]:41871
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726983AbeGQFri (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 01:47:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jNR2AEFHTuAhPnevTb7Q0sIFy2754Uf/MeL1Yj89EuQ=;
 b=Tl7B8Pi935ylvEbL7qsbDKRLNJF05UjWRf1sioVjP/wuGaGluTHOYkh+WthZXr9iISNyxgE+e3yulpfg5LWHfwnpWAgFslJUfPH4XvNSt9esH6XlglYR34onOS/5rKuC1esm9E+Q0XuiPoVTUY8eX4CwC7Tj+EG2PVjYuWxBauQ=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
Received: from anson-OptiPlex-790.ap.freescale.net (119.31.174.66) by
 AM3PR04MB1315.eurprd04.prod.outlook.com (2a01:111:e400:586e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.952.19; Tue, 17 Jul
 2018 05:16:45 +0000
From:   Anson Huang <Anson.Huang@nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        fabio.estevam@nxp.com, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, yibin.gong@nxp.com
Cc:     Linux-imx@nxp.com
Subject: [PATCH 1/4] ARM: dts: imx6qdl-sabresd: make pfuze100 sw4 always on
Date:   Tue, 17 Jul 2018 13:12:02 +0800
Message-Id: <1531804325-3476-1-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: HK0P153CA0020.APCP153.PROD.OUTLOOK.COM
 (2603:1096:203:18::32) To AM3PR04MB1315.eurprd04.prod.outlook.com
 (2a01:111:e400:586e::13)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 173bcede-3e38-43dd-af7e-08d5eba47f63
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(48565401081)(2017052603328)(7153060)(7193020);SRVR:AM3PR04MB1315;
X-Microsoft-Exchange-Diagnostics: 1;AM3PR04MB1315;3:9YTkt0aUhPlQsFTCtUWaXWMbIe5JarcFUxEaaO6Dafbc0DJqoDWGipxaBk2Zao6djU8M3VDf7ChdJ3Kpce8hnVRPZQWXYGHFzUB/Mu9p0GzZAXxLA7Rk8JDgRjjyhZIUZE+2vSQeG2kfj2MkJwd/F794QixO+yBq7nSyatyPMdBT8X6bSW7liQh9X+6gpHpNXfk7aGWFzj8wxLw+TqlFtvg8knfqN43lo3KKs39160YqwQhfNLfkuToitNvB5gwc;25:mzCspAEKSDgEZb02ksryhVpbpK933UBXQ8ngjd6d5I+YxvmvTefpHWBNZuGkfz1uHVjswQHgAG4/USkpOvKgRT+YuT4t4mHgf2/ilsA+FoES+gb3UL2jy44tXgBbX0MCQqUQr5jads9tJTKtW7Rf1uptw5Si+OGkdTMDKdB7pzrdgjfKFVNJnnOlIt+BU7NYNMW7tLoccBK2eH6kY7/fSvZbA+4QCJ/PS+Q4E32ORHw7UDFeh1YUQhonGTVaGrCt+800IDz/4D8PTKddZ56wTnsYIq8N2ewoHQRCdD+dJy1DeiBQ9CTxNfezZn5jpNfo2GBzAje3k0pD8+hGAfkkKw==;31:U6vLHZjk94EGX/pBf4JDHp58CO5M0iBoSKl76IWIOVHMYYB+2EpcPMvO/IL78KmkQ5pLJb0R2euokIF+y65o+oI/yNFmhBctgQmrz5OThN8D5XC+JSLlVn68cxFFwyaho3of8xBhLPRgC+eExJ0VI6Hiprv6Fh6UDAMHDOtjOlKyeof3AJ5LkvFPj41U/qUHwIRbIcjZDVq2rA4MJ0qsqSsCIHZe/ZeI4Vq5PXD1hOE=
X-MS-TrafficTypeDiagnostic: AM3PR04MB1315:
X-Microsoft-Exchange-Diagnostics: 1;AM3PR04MB1315;20:l2EZhQEWKnrSb1JWjwwYrI34GTVnmlGuyGDeZXcL6pZxdlkjzKuZ2Ef14aV5Jn11PrX7p09NxWd8krMikQmx3bE9p+Wvyn9kiHwVNdo4uUlPkQjAL62XBx2sVMpGsRPXqKRiQczYG/E8iintoWAsVl1Z8LeRWV+dYEElUMsrxtOXtLMHx6snE/vAiRZHibcVudiq9fTa8qQDKdCQGM3H0m7TDd2jQYWEQEkC3CE10gfiCCAX5+ZqznRqvYzv0GIabTkMOeV+uLSrO1X/zYIMDSxD77JpYFB2415tvVkZeVaS2n9mch3LDC6tPpc63dGYM07lTVKgnSsVfB6R/RWzyRXuHFomBT+inFuScV24yC+VQNxwvjya/VVh1EzE9jKEXvVPG06qzBQIEBLuRKNVhUFOjX83w09gfLohjtaiFOa2H0qK1iwoZpsTmGc98xK6Q/1hOzKLFnIobo5x6MBRertGnQcm8xJSqExODRCGdKsg4UxOZe2xX0AS/b/qkMf5;4:3BtVvc/Gh0Sqpbqku/o+7h+ZQU4+KnA4tRAmsflKukv+ULAf1SubhS5VRUto1UfC+RLZ/iTkUlaaAkIQc8dhqkEKLB9pZ3UuE8KsRMqqtkcHvKexxOuK1WrYz5zlUdqqvgXT+syBwWLk70K3lL58apgoIuSTJTdcWestGXNY/R3+Wl5u9wcmsaNNrFs4B4JyDvW+eOmph7Ip9MTnb92fC5CrIJvdTBGywgxO3wlNUd/LICQBeiWGBH1G6z8fpz8ldNfQxQPIb+Pk/j7I7sU0ztUxastJDkphGigasqp9gIR4QdLxIGoXtih1NZZmzrU6
X-Microsoft-Antispam-PRVS: <AM3PR04MB131552A0F2F247C374C2A41EF55C0@AM3PR04MB1315.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(93006095)(93001095)(3231311)(944501410)(52105095)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:AM3PR04MB1315;BCL:0;PCL:0;RULEID:;SRVR:AM3PR04MB1315;
X-Forefront-PRVS: 073631BD3D
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(396003)(376002)(39860400002)(136003)(346002)(189003)(199004)(50226002)(66066001)(486006)(6506007)(25786009)(2906002)(47776003)(16586007)(68736007)(478600001)(6636002)(86362001)(316002)(6666003)(36756003)(50466002)(386003)(26005)(5660300001)(48376002)(106356001)(956004)(2616005)(3846002)(476003)(81166006)(81156014)(105586002)(53936002)(8676002)(8936002)(6486002)(6116002)(16526019)(4326008)(51416003)(7736002)(186003)(97736004)(305945005)(52116002)(6512007)(32563001)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM3PR04MB1315;H:anson-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM3PR04MB1315;23:vuSCF7eQ0AwF2LuYQ50zDfEkKmok71mNp/SYChboz?=
 =?us-ascii?Q?Bd6Pvg6eNDFaq6jbf8ywI+fBjBC/AodE9hj8BStMFE9kFmYLUysrhYfQhAgQ?=
 =?us-ascii?Q?upifjXJAU4mmDInd+jtsVeQLrexMpq/bAeox1+xz9lDrQe91PYdnic2R/MG+?=
 =?us-ascii?Q?iGiG8c8FLZDLLziCOcc+2gUNXLRyx+8o5NId8K9BanZ3lZWV18JsXLyeKyTc?=
 =?us-ascii?Q?y3XaV2xXB6akWh+NYL3UQGtCo9tSsCkDKVV1WaM0IUhVB761MoUXvi/7nv9U?=
 =?us-ascii?Q?Su1ynIcmLXhhfliqNS7rahqJFz9t1zpffyKR27rJp4INB+c1eG5ou/fa5TNq?=
 =?us-ascii?Q?mjJStPC6ISK0UfxVy7SJvoDxGlfqG6UwGPSm+LX9JitsYbnKRCrCskRfeQT3?=
 =?us-ascii?Q?BQdkobRpMye/5c3ZGyWdjyH5RVWmegTbT8PmkLHb63hlllgsIZIqpx8xgmzp?=
 =?us-ascii?Q?elLznF1I4Vv07D+emQT3Hw5dSGZ4JEbYsbVN+bHgx5lFJ+91CPiFbeNt0aSq?=
 =?us-ascii?Q?NMyLlA9NjuhPX5RVZlA2H5RBcZG6MGicOxPQ1UWV7h+VYqFcctR5sljs1zkE?=
 =?us-ascii?Q?wFxRBYE0ftyPRtbwSoVcFM0is29JueF3p8gfr/e1xQJKwzzRWso9bwqsqMNb?=
 =?us-ascii?Q?PXoMkikbEpyxkgM7ZBKhxRgwkzQNjoS0bWxolQXq4jRJN/j2NiZJmI82QU1+?=
 =?us-ascii?Q?IZWLOfxQLhBeWAFa/dBdh0vH/1eZtfmZBgVjt5cnbi+z0HVsoxQslN9+rPbf?=
 =?us-ascii?Q?SSvAtXzqbpdArpGvfcCM0BeNR/2WOlbsVLVq7hj5VZ0evV1rufTYYv2WBBN7?=
 =?us-ascii?Q?Xb4Jsf/cHhiWdc3z6Ql+88pGRmG3JaKUL6wn0GVemIi+iEVdaUJjRHktjirf?=
 =?us-ascii?Q?U+Adlwui8Ky+jrnVUQEb0uZ39cWordxDjtf8zkxOxUu1W9i83hRcN8UnyNdW?=
 =?us-ascii?Q?/dU/yUbf4YfsHDVxPRMajhmoNEgEVFG1eTNsUKaBm9IgxLqM38IjaiCJd+5h?=
 =?us-ascii?Q?mPLb4sMrV/7zJTeZpphppT2eQEYhkjFsS8TnZk7MlpIWKZAQXecD8I3Nf8d/?=
 =?us-ascii?Q?+ZdzrelFzcnX78plk+ahE6dKugZEaCIQSF2kZ27+/J/EZBYt7FVk7YRPFMNg?=
 =?us-ascii?Q?+0RVehnEQTisCjh9AeT052IaBjaR9xV5mSAd/Km+Z83JlM95r2ExA=3D=3D?=
X-Microsoft-Antispam-Message-Info: P4ga1Stg0qBNabGx0XqZQpASsLgH3AFaXXCCfV6ELzPp1VlPKPrj329iF09DVNEvF7bR8A1U6b0rralzGNGyenDmShAzTpvV2B21h+SHkcJhVkSkL/btfmPcFlaJRgD2v+0J2lo1v25e5St5zRTyeuBQBW6Jl2vIo6CcMvqaOPh2J/R4kgyHz3mMSg7arEkINVqZV+XcQ2sddPnKkwpYGxZE6ewt4EpLuEJAJic+3d7mDOls18IOAwTxRawof1Hnbp/LHX5AgtRyYF7BbKcg9EbGcwC7tbG5wy3IXOqKNMpczmX4PTgHtzORf5dHxshuHZDqIcsZ9aEZb/yaiTyj+rU599F4DwZwmKf1XOU2fIc=
X-Microsoft-Exchange-Diagnostics: 1;AM3PR04MB1315;6:HJsTlvyK5fBsJaWjKWsLsGXy/yN7B4termlb2duXytsnsqgZ8aoF9FtBXZ4UC6etRM31vcPryjBLHFAsT8WQ3jgsODAhEOTlF9DTwuE62IuXeJJDVCAfNVTY8SdWVXYufHjIw+NrYPESwxKsI4sRt3RdtKsu/j+Go44xNjSMuUR0tPV7X9WTpxfoZp3YlVkI6B9aGpSZx+pqZguQR4R9j6BuM4NqH1ZP5UfT6w9cTm2LMhZmwm4HUccCMT3Vz+8xW0hb3fbKLyCJgc+bZZiz1/s43kZ6KLzzRrV2ToizQ7Oi9dpj5aXHP/jFuBx3sq0y56L9aX/48FNC21/ItqlOjqpkmwc6PYUDYyD7me0tAEY5zJIxBugk9W4l7W2Nih8ddAVkDy7KzemiLITUPXb9JAem4KIzDxrkiWsxhMIkqnbIP4td1wXBCq2bnsiHyrmFsJoaByAC3YNbP/IlHW/Pvg==;5:7Z1rLTiP1strg3csqHq2sPGy05/Tio//oxqYG/nNaZU4he7rPivc5XZrWwvtLt0zLnPrBWvIou6agMOPbVHfVlfXLHfvWmMvY/L2qCcx/snbtF8mKih46IpC4AIuQ2Bbhqx+RJp1wF0YFa/NdmMNg2GiKFJ/wRdXpPD7SnUFb+A=;24:iLrnZqces8Ln18WvyBNubacupsaKAcrgjX/DgO4pi1lmVefK0pLX+7+sXLal/Jdc2fT2DEPvrwaAPKWozXV8oFxqOwK2cvoyCKvgc3OK+tE=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM3PR04MB1315;7:zhO//dUV6gb62xcJBvH8LDNsOdkWrhMkuUyTG0WKZiiFEkT6bE/XcA0Eiu41/zmtSwVYKuKRII1nHZlZmAT/O9hglEn+a4Uu1mUFQbi6+2luH+TnxFYitNuBtTno7VyFNGH06Z7hhJz1H7YmQU/SQJVfteCUENPbjr+Z/czcwfW0JVW8ZdX7dobXFCtLlHQvAicy3JBJ1leNOZ9h5bpg8x69DQhkQYXMlZDFyNY0FowxYCbmFpVII+58box2XRzv
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2018 05:16:45.3618
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 173bcede-3e38-43dd-af7e-08d5eba47f63
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM3PR04MB1315
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On i.MX6QDL Sabre-SD board, pfuze100 sw4 supplies
GPS, touch and RGMII etc., these modules do NOT
implement power domain control, so pfuze100 sw4
needs to be always on to make sure these modules
work normally.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 arch/arm/boot/dts/imx6qdl-sabresd.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
index 15744ad..6e46a19 100644
--- a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
@@ -341,6 +341,7 @@
 			sw4_reg: sw4 {
 				regulator-min-microvolt = <800000>;
 				regulator-max-microvolt = <3300000>;
+				regulator-always-on;
 			};
 
 			swbst_reg: swbst {
-- 
2.7.4

