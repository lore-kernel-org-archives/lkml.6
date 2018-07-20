Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8A2CECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 10:11:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 570BF20673
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 10:11:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="x8M6o0Oa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 570BF20673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728252AbeGTK72 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 06:59:28 -0400
Received: from mail-eopbgr10060.outbound.protection.outlook.com ([40.107.1.60]:1732
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727518AbeGTK72 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 06:59:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LzIZbbBfo+KzKDbsj+xiePLIH4Kh7SnKYiXdXyIjWPw=;
 b=x8M6o0OafOpreE7SiMZOGJM1TBa5lWSXBFjQQHLumwtGWUPsynCYfLlNyw3GHncaIvaX1NgYpdTUHgjsEkEbi4YGlk0RuLvmxAj0WVG9UPNhmT49dPK7ti1dm5Phg0/Z1hmdTrYjkKeM90HHPba4LQrFMy5F13+32X9VdOWNyjY=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
Received: from anson-OptiPlex-790.ap.freescale.net (119.31.174.66) by
 AM3PR04MB1315.eurprd04.prod.outlook.com (2a01:111:e400:586e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.952.19; Fri, 20 Jul
 2018 10:11:45 +0000
From:   Anson Huang <Anson.Huang@nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        fabio.estevam@nxp.com, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH] ARM: dts: imx6sll: add gpio-ranges property
Date:   Fri, 20 Jul 2018 18:06:57 +0800
Message-Id: <1532081217-17538-1-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: HK0PR04CA0011.apcprd04.prod.outlook.com
 (2603:1096:203:36::23) To AM3PR04MB1315.eurprd04.prod.outlook.com
 (2a01:111:e400:586e::13)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f87508d3-98bb-495c-fa0b-08d5ee2934f1
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600053)(711020)(48565401081)(2017052603328)(7153060)(7193020);SRVR:AM3PR04MB1315;
X-Microsoft-Exchange-Diagnostics: 1;AM3PR04MB1315;3:nPQgHGIOqR1JZVkL2miwH2HGm4krsCQqmhkuF9ccqw5u1hEH1+Cqvpk9KRROFN6ixmkiZ6Vk/kFOCCT1iFeSag4dN09CHMZigz4tjBcMtqpxpCiYpLYHiKqguFJbG1utkp8zxSxNt7VM/7EGa7SwC+aGqcLNhlHF0iYYtukQ+H1/grYRYBMCvo1FXQ9/Va6Lg5madALKZ3CDkXUFmy/E1MqX8RZ1ezBkRY+hfc7IVi5fWzXTZWLPe8SdjetjH0NL;25:l8PzAtWFNlXy0i+9z7OqA2HyBTKrMmkuHHVZmzqBVbJMh75LvwsGawr0xlOsRyjI8ggK+AB9xGGSaClGAk22mOz7l4Ni5fm18bBBKIMCxu2hVAK2IC8vXdiPaAFJw/JibT97pCTu18ZBdZr7/Pt+KQ1hGI4nq+SXOFDHrXz5so+sl8E83TkolOeBDZCqxvk+o59ctWvAZ+JFQ3htnCmKa55BlMyhIJkNwF8SRw+irMn67XvLIgLy1aJBHxkJsVuw4HHiSjwFdYH3gn3CveJfkbJ/5z4EnjPL8elaZYtEf8wLjP8NwXMVRwC2N5Awwrm1YUA3LGg4Xj0TBRtp/5Oekw==;31:AolvsOhSbLlLHf96yi7My0HnKEMUtDA+WuQOri1R+8+joajIJ7GcTkD+3bTwS+L5SsbNoB8dNpVJ9FOImHbbhJay+vRoKkeDL/sJlrS1xMlyOxaA2Kct+x5kloLUSYTKnZ/DOgSCm2hwVbkW65PpxdD+2WkGCc1U2d/j6vWEFxbgtpyOxdoVzfSbFYk9/VVNZQdzSQw56SfgMMv6h9j4qVdvt0cCmDjiE6rbAYx0qPQ=
X-MS-TrafficTypeDiagnostic: AM3PR04MB1315:
X-Microsoft-Exchange-Diagnostics: 1;AM3PR04MB1315;20:MBj7TcJ3hs/WgAv+/AMX1/0xbGjEBiHy50GS2AMQV0ntGhxQobxLdfHYzUHfjRkFfeLFcBk1Zec98A6Mm6n+gEjvGbVtSe4w/ycg3erM/srl4D0quW8wm9Ki9IuF/4Z9QqFqzabLpslZK0rzl93I/CLaD9S1fIMSFJJlvUBirfmsw/pol92WcGQzEu3eWgz9lfcvHD1mK4/cbytSR+zrpEPLN777M3R6ekAAIJxGL2VMbDg6TdEmeU3dT3hsDLxRMYs6uViNN25FUR9rxM18eRmq+fXXQvSQhBzOUVni+1kTEs4eeArpCuXeKAj+5N6GU7X5M1biQJUlw3ZxKLR8hpB9Bwc4V7poEuAUKDn33ieRBqQR5krdWdpK7R1rluoDHhaigPvA0ZYK+VCjkAWu0mOduEGUYLQzPWjZA1ganxSLg/Y0f+AYY4Cb0e9zgSnksaO2XCgNovpm8h0B7yoXrY/9qg1A+OydAeli1E3ySSTUglNi+lQhXO+NgHj3E8zg;4:AyxkunMXx+lr+htTk9ydrPzp7aGP8ADA0zWnLHv8oKPkaUMJxsN+wEgXl0ehhmD9L7/0NOr0IgGk5+DkD9gi/YPNzGQR9fxuVPsOZjepcYvCAuXlFuOKyIfmcFXZYbfXZ3KaXAt2BJmzGafrA8LamWMCnmlszH358D1z1MnI36mXp1HKdi0bMT9kSKBWxVClnXmSQHIxfmvPe0PjMDre/IDQQ7X0cWSlfy1dOyamzqSh3Ep6TKQgfQHs1fwBvxm3X0UrW7qbgk2mgKl+PNF7wrHioPF9UUdZA/dpKLIXBs64ZVd9VebuyUcpTbr0liQU
X-Microsoft-Antispam-PRVS: <AM3PR04MB13156C505D1B15E6D1620555F5510@AM3PR04MB1315.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231311)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:AM3PR04MB1315;BCL:0;PCL:0;RULEID:;SRVR:AM3PR04MB1315;
X-Forefront-PRVS: 073966E86B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(136003)(346002)(366004)(396003)(376002)(39860400002)(189003)(199004)(1857600001)(6666003)(386003)(6506007)(50226002)(6116002)(8936002)(8676002)(68736007)(81166006)(81156014)(16586007)(305945005)(316002)(97736004)(52116002)(6486002)(3846002)(7736002)(51416003)(5660300001)(476003)(16526019)(86362001)(53936002)(956004)(186003)(2616005)(2906002)(486006)(26005)(478600001)(36756003)(25786009)(47776003)(106356001)(6512007)(105586002)(50466002)(4326008)(48376002)(66066001)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM3PR04MB1315;H:anson-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:3;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM3PR04MB1315;23:RNnlwf1HJosffcmkokih8Bo3NLSrP1QB7vWrkaM9c?=
 =?us-ascii?Q?SK4GWOwi+CpQAtbLsb9d+/TacUDNxWedwHTQ8BUq/VQORNtlbYaABojBQp+M?=
 =?us-ascii?Q?jELNPchpkIufRimqgspPopNrbMjrsQ07uvjjttpkf31HZ1OXyqF/YOhXgCXT?=
 =?us-ascii?Q?8FcEeE74H2H8b6zCpahP5sabkOE99ap+WVlpuZJ7qd8PnKlF6UVv7x5/N/H+?=
 =?us-ascii?Q?HyZhiCeE0MJJKk9T9Vn4uoZAklVhNNPttEEbNuDnS1euXbCG17HCzPiEe/7A?=
 =?us-ascii?Q?xfPmJmr0hL9nV7rx+QgA+k07k5bb55IPJr0q9MW+HhPFBv0pRhfmB91qxl2a?=
 =?us-ascii?Q?DCNs75/fuUDVlksXSZZJETGzd+r8KhW+SWy0DkQg9H2RqAmyTI+3CnJaZqpC?=
 =?us-ascii?Q?aYmj/fX2Bm4VDLT+uctUvupyooq7F17+5VlFPtpI8px4CniO0njwSAekCyKr?=
 =?us-ascii?Q?i4FB7HCWMWA1bbvfOSS6mSf+gnSnowRskBKRI8mh8YyFVWsJl7c9SnjKpP2f?=
 =?us-ascii?Q?bvspVE4u7WeUv5MVghdBYNU2GTRGwOeKuF5DAcfGAdMBIzR4HWX9ydTy/ZRx?=
 =?us-ascii?Q?uBHJtMqCwjLXc8T6AgSxW4UV4RPSjQI96OfRWOOarnhGW1+QDtBScWPqtZIM?=
 =?us-ascii?Q?Z3buT0S9FU8fVERkAwlbHVmfxGZbMW1Ll+Ve5gEe8ST9pLGsLDRDW+MRBymW?=
 =?us-ascii?Q?dtS9yDxYH7D7TV4Yti5InufMJpqf6p0dHfKyqAgHfwMR1DgnNQo5odBnHWID?=
 =?us-ascii?Q?Sa38v915VxXwOrsEliMNaAODG1VERE9ISBQfVAd7+WIzzmUpalg8ufmmfW3R?=
 =?us-ascii?Q?sFpOxS9QF59t4x3xAy+r8JJKp6qOh7BA+sNq6SsuwhzSAbdYRemZy+zhWM5Z?=
 =?us-ascii?Q?YHb21lnToFkISFBQyKfCkqSnjBoyLerqD6mvW/n430DVu3f5eoPGmCXsOCmH?=
 =?us-ascii?Q?G94XcxhlYL3aDg+tORDPwloVet86TwS/PRmzFHoAkxWbPxbTUTF9vTRpQS/0?=
 =?us-ascii?Q?WaK5k6mHmrjtMKWPSn7t4zIRZEkj/OygY4k2tF5srOcL1qPQkzv2d1AoBXbB?=
 =?us-ascii?Q?SvGq9aanLnlO/BQEEDkqKVUAJAi35VUPG2VKerrFp5e2ViEGfSTMRG35JHrW?=
 =?us-ascii?Q?GPM26NlaHrVYt8jQ+/kmOkkLXA6P9JU?=
X-Microsoft-Antispam-Message-Info: FPUdkpkc9GClf8xlB6GsbXLWp/jSABjwMpT/8/IPp8GL/lhhFoB1dtG0iYINaGWEbuesbXrOr3qBsAkLhiUdAf2WpI6PoNictq6yX5jj+G2o5NSO0/sqBp4pkymJ+Hogf7gEKJ+cSWSF5SQYUa7R30wYowH96xJHRDPF4yGt9MIANvQmNv4ofxPfJw/aEPgrId7QZjjcpuQW4d+blWRKtJEyhejTvqmgnrVGme36DPUtncrXgNn1fwH+/n6cDILK6/EMI+Vl9DRR4KwKEBgG/L0btIPzrFp6VuO8DbKQeTai7l2MGx9rjzfyWvc0VNDr5Gh8eqJVSaWR+EL/wHIIXeG/WnnfX7p7Bl5Updf27QI=
X-Microsoft-Exchange-Diagnostics: 1;AM3PR04MB1315;6:bgloSChLIj6Si472lQlOjKqBb4Yzx8DXkDldaF4RUxxfbLdgmKyLeMXR03oNBOke1pjEjJrbvAdlzseXXuQi1Pa9AGpM8qd58fS0rs8OeQgyJch2bPa/AER3ibRfzb+xC0K6QYKHhqjaB/8HbcJnLFG8zIxBmxGjV3PXm91LdmCeX0u+m+ZrB0mj72ZfEBF1JvqAabk+gnb2duU6YmCa4aNRXY5jWD7hqJ9xWby4XJy3oIjq2lHmRVs/Cp9zc5PeJ6UErpztC/NlK8P3RR1BTY9S65pphFEDit6HJDJriQEn4ZGKHaxSVQouX4H0S+xEgTGvugAKKwGagPsI4gwbN/D1P0i0JP4WhFpJq2xwyK4EDV6wWxQagqoroR7jlK+X9Ns8jlcwFg96Fkc4YvwWOW3eYQl/x9r/esuQxoucuEE4lJobeQqFOnyqRXJXTDxrtalxfvA/MwBBAS8xBC8A+g==;5:Y1ZhMa7IwBUf7xMi5DrX+rojb/q2jEcSMP0dmnki5fcSJX2yQNFzsX3uYsM7GbyNGTWgUML1ztpDdfdNHgRuPqxVowxBcTaqQyh3J8g6lYuG38+5CA/hJBVdI259qQsk6Qkg2WW8+M3p9A+4SrkMdHVgPHc17vfX1Mjf741pO/U=;24:0ZTpXSd/pXYw3W54I2gQElkxuYX0u7nr/GJSe0w6zWDmLBgCyujGCbFN7QeNsyE0ZH/nqRJD8O0Rvl/WNFve9OxQhwbQlL/C9TtnXrIhYHU=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM3PR04MB1315;7:unJHFtevbPrT+G5fdasyBGchuX8hX6Tl0LTO7//V91MIw88DsbbWUT9u1D3z9pyuy+Ft7S6gMD9C22R2qDKKi9wkWtRInVUtywr51bsdi5XctJWs02aToFQzZ7TFPjTLlkexDhYMD7g3d3EfUbLywzngBpcxfJZxXEOBG+9MxyAycEk/c1oJbLwglciBnutyktMYpnz9sn64oVOTO65IGFAkXYTvSd+pCeakf2Dn9vOyd7GDlQ30iHZLrqXamEtc
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2018 10:11:45.4035
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f87508d3-98bb-495c-fa0b-08d5ee2934f1
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM3PR04MB1315
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add "gpio-ranges" property to establish connections between GPIOs
and PINs on i.MX6SLL pinctrl driver, for details, please refer to
Documentation/devicetree/bindings/gpio/gpio.txt of "gpio-ranges"
property.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 arch/arm/boot/dts/imx6sll.dtsi | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/arm/boot/dts/imx6sll.dtsi b/arch/arm/boot/dts/imx6sll.dtsi
index 000e613..a3cf282 100644
--- a/arch/arm/boot/dts/imx6sll.dtsi
+++ b/arch/arm/boot/dts/imx6sll.dtsi
@@ -379,6 +379,7 @@
 				#gpio-cells = <2>;
 				interrupt-controller;
 				#interrupt-cells = <2>;
+				gpio-ranges = <&iomuxc 0 94 7>, <&iomuxc 7 25 25>;
 			};
 
 			gpio2: gpio@20a0000 {
@@ -390,6 +391,7 @@
 				#gpio-cells = <2>;
 				interrupt-controller;
 				#interrupt-cells = <2>;
+				gpio-ranges = <&iomuxc 0 50 32>;
 			};
 
 			gpio3: gpio@20a4000 {
@@ -401,6 +403,9 @@
 				#gpio-cells = <2>;
 				interrupt-controller;
 				#interrupt-cells = <2>;
+				gpio-ranges = <&iomuxc 0 82 12>, <&iomuxc 12 103 4>,
+					      <&iomuxc 16 101 2>, <&iomuxc 18 5 1>,
+					      <&iomuxc 21 6 11>;
 			};
 
 			gpio4: gpio@20a8000 {
@@ -412,6 +417,15 @@
 				#gpio-cells = <2>;
 				interrupt-controller;
 				#interrupt-cells = <2>;
+				gpio-ranges = <&iomuxc 0 17 8>, <&iomuxc 8 107 8>,
+					      <&iomuxc 16 151 1>, <&iomuxc 17 149 1>,
+					      <&iomuxc 18 146 1>, <&iomuxc 19 144 1>,
+					      <&iomuxc 20 142 1>, <&iomuxc 21 143 1>,
+					      <&iomuxc 22 150 1>, <&iomuxc 23 148 1>,
+					      <&iomuxc 24 147 1>, <&iomuxc 25 145 1>,
+					      <&iomuxc 26 152 1>, <&iomuxc 27 125 1>,
+					      <&iomuxc 28 131 1>, <&iomuxc 29 134 1>,
+					      <&iomuxc 30 129 1>, <&iomuxc 31 133 1>;
 			};
 
 			gpio5: gpio@20ac000 {
@@ -423,6 +437,17 @@
 				#gpio-cells = <2>;
 				interrupt-controller;
 				#interrupt-cells = <2>;
+				gpio-ranges = <&iomuxc 0 135 1>, <&iomuxc 1 128 1>,
+					      <&iomuxc 2 132 1>, <&iomuxc 3 130 1>,
+					      <&iomuxc 4 127 1>, <&iomuxc 5 126 1>,
+					      <&iomuxc 6 120 1>, <&iomuxc 7 123 1>,
+					      <&iomuxc 8 118 1>, <&iomuxc 9 122 1>,
+					      <&iomuxc 10 124 1>, <&iomuxc 11 117 1>,
+					      <&iomuxc 12 121 1>, <&iomuxc 13 119 1>,
+					      <&iomuxc 14 116 1>, <&iomuxc 15 115 1>,
+					      <&iomuxc 16 140 2>, <&iomuxc 18 136 1>,
+					      <&iomuxc 19 138 1>, <&iomuxc 20 139 1>,
+					      <&iomuxc 21 137 1>;
 			};
 
 			gpio6: gpio@20b0000 {
-- 
2.7.4

