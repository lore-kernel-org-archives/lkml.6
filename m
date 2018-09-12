Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C52CC4646A
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 08:18:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0876F2087F
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 08:18:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="l3wT5Ety"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0876F2087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728010AbeILNVg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 09:21:36 -0400
Received: from mail-eopbgr00089.outbound.protection.outlook.com ([40.107.0.89]:28768
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726442AbeILNVg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 09:21:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wfwyz/1s2pnhy4eyDPPBfTEW7/tGn9M4cbJsZu0vnRA=;
 b=l3wT5EtywSXrvgQ3rZ9PMXkQp3uBrTx8qaOO1SaQIL3beQu9LwuCm4s96BT9LtJZEImsGCEFBq5ZmhrN9WSQMntlyCoR/Z4kdDUYCLeBvWB5Ek9QCuB+S2VFqABr3u8kd9yEydoF1VU5ALKtVJV5+XYGUKawCY+PBtb4i+Dxmx4=
Received: from anson-OptiPlex-790.ap.freescale.net (119.31.174.66) by
 DB3PR0402MB3916.eurprd04.prod.outlook.com (2603:10a6:8:f::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.15; Wed, 12 Sep 2018 08:18:03 +0000
From:   Anson Huang <Anson.Huang@nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        fabio.estevam@nxp.com, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH] ARM: dts: imx6ull: update vdd_soc voltage for 900MHz operating point
Date:   Wed, 12 Sep 2018 16:13:29 +0800
Message-Id: <1536740009-32735-1-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: HK0PR03CA0020.apcprd03.prod.outlook.com
 (2603:1096:203:2e::32) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:f::31)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9aa6326a-5605-487e-7d2b-08d618884557
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3916;
X-Microsoft-Exchange-Diagnostics: 1;DB3PR0402MB3916;3:hcqL5hX0brFLdA3kBXxgMcsEWPZdzRgm0FyVG4LbQA0qNoNTaQrFVWJty7sav77dmU/E5CYDdyFY4vqloyEccJfVgea6rDsF+fqHw/Cp0xTWOLQJSpbl3qtq4sBp0MjH1sy8tnT8ILmjigGfCvd2sy36lWk+NAbz1Y+e7v0lj9ETRUVUiixrMEWKazbYGLq55uf8G3gS4R1pbecAN2y3j4bVkgSG3NPzu/g7GKiMpzGD8KN6jgekGysY7Tfop7dG;25:v+H8WKoP6mo/WMU28FBzMKMNYwvXu9rdF+L1uWaxYrkGPhhV/8o3q2p5IwA8/ibMVb28OzBQ3MFGdx15tXbZDBJhVxAaFkycrmId7gp4dwAtFUcclxj0JLVC+2CMWSH5cc8gKFLV8pG/p6D9ZhagcfN1p0sjZ5vEyOsZp5iW1Ms/e1ubGoG43aAtktcDg6Rn4qx2pJ7Lim8LCRRlGmBb50bE/axZn4MgVrwoIy335AeDwY9bbzkDnYr+3p6v5x7pzMdtuakldeLVWMeUX7H84i4+liDEPMpbJz+JYlYfjYrjGb5dzbhRnH7+Y4ZTxh8qOgh7D0AbNu0Lg0sWLFvLzg==;31:+FKF4iDiV9kkWTPIKyvsV8ZIFvXMMBwIgpzMcqXA/53hw0HQIQsrvvUvgE+BOx2B5gNupFqzLn1iorHtWp6uvYHshqnkQ+ZFqUJdiJDJ/F3ShyP1riqZ5923iXARAHnP91b3k6ss6HSJ660hjhL0/YS0OhplZto6XL7xZCZbFsm0wvFipA1i3v4AYgELwWW+pW5R9TSaN04S+HqNnA2rem5o7Eu2AeREb4Vc82sjYFU=
X-MS-TrafficTypeDiagnostic: DB3PR0402MB3916:
X-Microsoft-Exchange-Diagnostics: 1;DB3PR0402MB3916;20:SRSEot5q61ja3MSmPZENLRQfm8KxVg1e2/NJYIUfTGxJvlFfWrXVm4sixTbONOLFKRX29XQW1Lw9155F9/sSvFCbXbAWASxjr2id/h4PB3U5IsJFmt/7tjCDVXGD8wBskZVtQBs/qcIJDlnIdxMqWcDAxS0rRK3iqeHoYguyLBSVN6DeaZQFQkDnZAeWToyBDX0LlQ2jtln7iK4Y8V3zKcmtoahJXS5lPtV2WX8xvCkyTOsp8qDqMtanMHzo+Zy5MTxtq+bq+mdHX6Od4JHIw8oYdmcHqFlY7AgMa3ZVaF7aaU8l+AnmhPCOqQbrH9SX4+CdCSXTKfQ/D4eDfV+Q5Sc4mRY8Cp55UjHytJQV8Rw2TszhLAYHOMo6nFQIduhWLS7cK2pw+0LaG9lW2MYI/xf7cUF6BSpEP3EkuuWs491h25XoLhXHdwt0XxcOLz0COiG5IBSZzDmtPUGhCOvp0KMYJSS9mQRxwQY2P/fANaf/SN0bfzJhQlkAhcAi6vqb;4:WThfSU2BW4nhix1rDQ8vIqUcApRlDYqwPgDtLtW26itUrSScDTSPErVhXtzNa9tJOr57hDiDwyLtJG6tezMKQ3qoTpQRAWPkKl6YBZ1jLf1S65/mvo8dHOaGgiKHq9eTd2RrPLqU7otZp1RaWnrQcMzLwI2fiUENSxSuWxOKbqQcMYvM49pOEQXcD++8nv0ylmd+iYRye1r64oBQbVcdEAXzlvVpJsnh5bVm2sW7J/z3i6t/p7qEHpsCVzMIk24FB9+rO/riga/Bi0UrYM/TWzsReZglHLmbC799zSJrKrNPfwpVEhK4NIswc2a0iUZf
X-Microsoft-Antispam-PRVS: <DB3PR0402MB39169973662C107086A283DCF51B0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823301075)(10201501046)(93006095)(93001095)(3002001)(3231344)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699050)(76991041);SRVR:DB3PR0402MB3916;BCL:0;PCL:0;RULEID:;SRVR:DB3PR0402MB3916;
X-Forefront-PRVS: 07935ACF08
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39860400002)(376002)(136003)(346002)(366004)(396003)(189003)(199004)(1857600001)(478600001)(52116002)(316002)(50466002)(956004)(2616005)(16586007)(36756003)(14444005)(97736004)(86362001)(25786009)(51416003)(2906002)(4326008)(15650500001)(6486002)(26005)(16526019)(186003)(48376002)(105586002)(106356001)(53936002)(6506007)(7736002)(81156014)(386003)(50226002)(8936002)(8676002)(68736007)(6346003)(6512007)(5660300001)(6666003)(305945005)(81166006)(66066001)(486006)(476003)(47776003)(3846002)(6116002)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3916;H:anson-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB3PR0402MB3916;23:RclarDjdDHK0h8mWAwLpirX12YZTvCoJLNKshTe?=
 =?us-ascii?Q?HPvTqxMsXMGRAgroVJ73DVl51RfERHb3owoO6Vhb5L70CcqLEB38NxHvfLpF?=
 =?us-ascii?Q?3B1khz+MMXkaRUw+GZdRSDTEJIxcq/bSL3B6lbc8MiWspOcihSr4C+D6wmmy?=
 =?us-ascii?Q?j2zjHw/RjCl2W8Kuq3RWiCmxHp+hYgjvtxUJxRo3GSgJa39siJ78J/tJOuST?=
 =?us-ascii?Q?JKyfRJcApIZln5HSJJlsn/2u7TqMg66NB3r6nH5A0RB7AM+wMfYn9YQ+RBVB?=
 =?us-ascii?Q?gP+h3z9gfmVS+uDVB8dkNs6mVCsJzZVM3yKh7zhh1rgRruztRPHMIRnsxp5Y?=
 =?us-ascii?Q?vxRjfR3DusLbqzfPs5E1/FnUYqFE+4gxJHvk/2MFeHrXwR9Ns94MFG+Xn5Xf?=
 =?us-ascii?Q?SdWps5hUg5mNgPBcTz0jKqgszEgIVwO4jRzUwAgftp/z8M0CkAX5qMAQKEvi?=
 =?us-ascii?Q?JTSmaveq25SFPvIwGwcugKpFuxVtz6EXVwcSRDN/hWCTjTh6wAMLOAwDNGkh?=
 =?us-ascii?Q?iyxorK9f3XiNpIxQmV7cdbpPaifd5h47RmjJB8n6RvYiHk8JgYxcyff3mCNe?=
 =?us-ascii?Q?FmvMgGipOQcdME8ePiqEItOjmSJA2zHppFssSoMwIQXA3TNn9FmoiPDaCOwF?=
 =?us-ascii?Q?ZR3h86Y22saV6Nji1QjK33WlqOu1EUZD2qBGlCeyGoCToX+An/LZKpWjmljw?=
 =?us-ascii?Q?XiIiXs8yd0//Avc+9knBwPwKG+bLNlyEq0SVj4raR2Pl6HtMN0PXEyzNa7Nj?=
 =?us-ascii?Q?ntYSVvhE1bosmt65CYgLEuUGv4cOFbXvKp1PTuPj4cLqMykMMkRwPRjl/Njz?=
 =?us-ascii?Q?IursZSCxI88jjI5CNX9/JegTIbDUWuC10ixS7/XWEUOw5uRB+Jp9JgyMa1c9?=
 =?us-ascii?Q?yw3G8D84BsM5vssoYO9cVf3RYXWDuxe7vloa2YbHS+cBYaiybk0jLMAH8K+C?=
 =?us-ascii?Q?wk6x+6hh2Ud5k7PFzBLHQM4feGKqk25f0v1fq5rbqmztz1fILMUDdYxOnXi4?=
 =?us-ascii?Q?W4/U20nnR51BoDTM+Xmwr1UWUkgxfx1bHU3HnO4lil/mxQHe2PjGC3306w2g?=
 =?us-ascii?Q?BDM5Vej2xpgS3L76NumQkul9YPqPQLT2AIa+tx3juT9D5URitv+hVKzCyiZZ?=
 =?us-ascii?Q?85ftdDblGvp9zrUbXWkCjnxtfIzh3PuHNXdKWI4H2W+DPhcMA+q1oPk33jd9?=
 =?us-ascii?Q?hhzrv+azLlnmpgCPnAAupW0epSNEcrvqJHhwT?=
X-Microsoft-Antispam-Message-Info: L168w8CY3g22KSEfNNDehCZKwwkHtmsyAlMgL2djvIRzdwUB0t0krkEuTPtdvTx7q58VshFE+aV7ydNPfUSttYSnqZppUeXpV/VN+iEXI47JdhiRsShOpP17sA8abXzbSgvPsFfT9fMhN28/pr34Qh7kKkSB3hJaRi3K/Nk0Hro8GlTxSNnaReOD9X/vsayn86SwQtjqNQml8mJuD0AjmK0/gteQH98/Bnvum14eNxYq30SkVVTqGKPaND81EB/RRzFQOJxJ616KvCG78xAeghab1YBa15mggUfuThgdgA453Gvwx2d8C7aJp9cuoAg3iSbfKobw4caFGVSfVdat9UYUJrLNPWkrBHSLeQ3V8+4=
X-Microsoft-Exchange-Diagnostics: 1;DB3PR0402MB3916;6:RHqzXBaTZ1/UMDaUO4gW3KEVYvkYq422oVSGWS/4j0ZPmD0usq5U4pmDcdvlfAlNoJ5RcgNjCe+WaQAGI8TNby+dFQq3SxcCRGcXtF/nslaQ5w8App/lZHFqWKRZGteXTuVGtcijGfZhePjV488XV6QS+/e1xYJC9PlIYFFPX7PX9k5B9DS//tBqWkZduGNdPejFB0i7k7IqomZpjIATsjlCzm2+29/sgUlnImqDuGkBpI8XnKQRfv02KpPE0RywT7lYzvspDNnKR/rZyzgvquXG0kVUrF28+TBA2UCtisOicI0tRtsj3ESHkBhttZ7alxm9j1wGwdAVrKJhh/bP9MwKMTPrWVH+EncQKuvZaBhQdTL+b7koywclEjIxHoAJ3GR/UAcOfmlYVmFUtbqFs2qbt2tqdABJ6msieNgrnzCsGf2UzlzoNaJeklKsqxZ55fmUoAf6OQEGbvZtTp1Byw==;5:8UWOZzEME/HrAYMWB7bU0sbq6e3zcqWWpZgqJy0R8U6e+dqspRaRs80cEK5r5KkgJUd/HfhMs35oLKqLRfDmZ87WJg/mOmSoMS502p7WhTMdg4Ub6NGs6PP5e+jjF8qvP6HkHJpLwzkQdgfqq1z78TdY/tb1O0b/x23e7LUieNc=;7:Bi5t9jY9YYTp8jYomzppmqBxEVrnP3BUks6lO1p9wWUbTdu6Mp2ytb8ooIUkyRsgKtDt6LSEJ+UNKheIKOukGN2BnRVL84CgjivegN3yXv/AGEVH3dCuqVY8KXjXBV2NHNq39BDbPSyo/ErvSXC493KdtFttCZPM9zsuMS6XlEjBS63cj4J6Ynm+H4uu9DsYVl38ExwNCe6WHtzs2mfxzevWWutPo/y7cu4Hio52KMZYagcAoJoqFuwT5Ssy2hW/
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2018 08:18:03.9787 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9aa6326a-5605-487e-7d2b-08d618884557
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3916
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update VDD_SOC voltage to 1.25V for 900MHz operating point
according to datasheet Rev. 1.3, 08/2018, 25mV is added to
the minimum allowed values to cover power supply ripple.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 arch/arm/boot/dts/imx6ull.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx6ull.dtsi b/arch/arm/boot/dts/imx6ull.dtsi
index cd1776a..796ed35 100644
--- a/arch/arm/boot/dts/imx6ull.dtsi
+++ b/arch/arm/boot/dts/imx6ull.dtsi
@@ -22,7 +22,7 @@
 	>;
 	fsl,soc-operating-points = <
 		/* KHz	uV */
-		900000	1175000
+		900000	1250000
 		792000	1175000
 		528000	1175000
 		396000	1175000
-- 
2.7.4

