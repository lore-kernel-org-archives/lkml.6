Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E918C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 08:42:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1671208B0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 08:42:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="qL99QskN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1671208B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932903AbeFTImw (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 04:42:52 -0400
Received: from mail-eopbgr10074.outbound.protection.outlook.com ([40.107.1.74]:2620
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750793AbeFTImr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 04:42:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=grqkmLvSGFX74E1aUfx7ZR0c9gd/AhI/Vm9EJSjVe/0=;
 b=qL99QskNEFeFTeYcX12qVwLDlmeiXzesVFOsxc547VKA3svBBwj9Kguya3IYoCUad3bWRtlvJ+2X98GqzMwntX7w6MsohmmMi8+9RYmjcN9w7ps69LogVk0Csl9nYbqiQEbSbhHj2bRmSlWuJduOUohcXENQJSgZktV7mbrdIC0=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
Received: from anson-OptiPlex-790.ap.freescale.net (119.31.174.66) by
 DB5PR04MB1320.eurprd04.prod.outlook.com (2a01:111:e400:51cc::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.863.16; Wed, 20 Jun
 2018 08:42:39 +0000
From:   Anson Huang <Anson.Huang@nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        fabio.estevam@nxp.com, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     Linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: dts: imx6sll: declare src module to be compatible to imx51's src
Date:   Wed, 20 Jun 2018 16:38:37 +0800
Message-Id: <1529483917-18057-1-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: HK0PR03CA0006.apcprd03.prod.outlook.com
 (2603:1096:203:2e::18) To DB5PR04MB1320.eurprd04.prod.outlook.com
 (2a01:111:e400:51cc::11)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7ab34330-2d97-4fd9-3023-08d5d689ca3c
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(711020)(2017052603328)(7153060)(7193020);SRVR:DB5PR04MB1320;
X-Microsoft-Exchange-Diagnostics: 1;DB5PR04MB1320;3:C2HEyu+UJCTRRhpkCdlZEOBcXmUHeZD2dzxCIw1nyba8ddU72+zRA/OFzA6scg+3mgE3gFhWZFvShCKb4haazgapypIBVCSvU3rXtkP7vZ3vuEe50r7PLaYcg60EMmL6I0ej91Z9+PdBA2AxKQ8P+HShKq9bbUG5wrSNKvs8HH0xDeDK4ck8zBOXC+SrICLT1Jj1i6I1CICn+YN90DZqb2jixZyKrIhDLr30mFTgt0PNtQ0sl/v7cz2NcFfFzy6U;25:WMYFSaHnL+6ms2XhVnlPzUeWvlRY4THsYcd/77grARXqWQQ+kzEscclAYi/w8ohmaLBSYRLDFxLRjGYsfnFbDZ9mlgQaAGQrvltbNVNL0Ipt/N6hbD6tJGzau9fpcx3DqNEO7c1ru4JRLXoytJ1Um6+UzlCe1SXsSQPGpm4SV10YJ5Ce0mZcTuekZOcD+t6WcZNbMglV2Y/lw+Cnv8co4bWDqOolxSob+mE9atMnS3kj9KjZEWyURhjkP9f4kqIErtWpqYoVGL1aOdz8n4nlUM0ip5WrBGjqgnod4PfMPxFXdYZuW7twSRSi0nbs0sDdUCjtfhKHTkUSm57kBTz0tg==;31:zVAshliAwGla2W/LPUwAzg5VacGWTynBD6RB42j6qG/QovLQfEPzZg8UGjzrbTk6CELYLYTPByQ0ID1S9EEn0WvwvLI9obJF+6TU+4ug/+qqDm/w/0B9Hra7O/qgxLNvPsb1onnwil0rr+FzB2p9nn4/n348blENskmH0z1fElvVzKr/6wj2eGW7+iML6RcscI4jLSeICRucsz0uQvxvCvY+Q65MVgi9kKw9LBZwy1o=
X-MS-TrafficTypeDiagnostic: DB5PR04MB1320:
X-Microsoft-Exchange-Diagnostics: 1;DB5PR04MB1320;20:DSDX+3yjtROAjIr7UVCOCZn2KSRuFtBOKkwa7sInX1vMTfW8OWAgTH+vpOKgKRi2NuU9MYBolG6TGc8m4X3A4Vg1rypgY2CESvQMhW+Mi1cq1LIoHh6hV1WeM3tLrzBGaOnERfN+6ErfS/lpLE5f/IetmF2V5IIiSPVuwj6eGpBGudruEbw1HJRTDDO11Bj3vNnUK1BfLOYDX2yilhzGEJwXka04v32P1OFuWoZU3rFSerTvGqdyGzxv4pCZ/jtrM5ZNWn+6sAoN3rBXzU5gi5F2fRJHXVpkeAbI2y+JYnSIA0Gwu7YPXMyHzlNDXyFTsv45VmAoqH0vLQ6r+SowPnNKjaSUjPIeWKgcaZSIJ1ZtJq4EV/Nllu3wA2yJN+5LpGk0Y7RDwaKJJ7dIBoJE1OtdcErYCQOWzRSOl+Cwwp5DNEXyQDD0nBMEwa36ZMHF7xOBqCLamJBfFU0unLGQ8173YRiiIAfZ8aRPMZbc2dXMWoKvDoQ9ZOibNVqiEIKk;4:vPB1H4zHfAvWWBXdDQ3Q9t50rdCsTBaAqedhinG8afFmKww4lmvQONVFR/XPpSMy2F45VSnju2y2F53ECOSsGJ/KSvETrCs9vnHKaxeExhTm+M4/bdaom9l2hfGeMSOyVbbOwI2EakO52u+JdWc/KXxDelsrwpE/hZfJ72xTGCC1x2lrZ6EvH9XJG63K+H2mZmRVfryoaY3kY3xIrKy5uM44HboBnodhpI7ixzbO5XjTj7x7V0Q2qNU5/z+SeWPzjj0hnk39iPVp6EOFuVV7L5NFL0rgOuHKoj6MkwBtccvhAe/j4aN2aw2C44iDQxiG
X-Microsoft-Antispam-PRVS: <DB5PR04MB1320B6FED424BF553145F617F5770@DB5PR04MB1320.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:DB5PR04MB1320;BCL:0;PCL:0;RULEID:;SRVR:DB5PR04MB1320;
X-Forefront-PRVS: 070912876F
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(396003)(376002)(346002)(39380400002)(39860400002)(189003)(199004)(575784001)(316002)(16586007)(8676002)(476003)(486006)(2616005)(6486002)(36756003)(86362001)(956004)(8936002)(478600001)(66066001)(16526019)(1857600001)(186003)(48376002)(2906002)(3846002)(26005)(47776003)(5660300001)(106356001)(50466002)(105586002)(50226002)(97736004)(59450400001)(6512007)(7736002)(81166006)(51416003)(68736007)(386003)(53936002)(6506007)(81156014)(52116002)(4326008)(305945005)(6116002)(25786009)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB5PR04MB1320;H:anson-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB5PR04MB1320;23:rXgY4BIF0WwT7UdarT1qG6xR+GZJofsNDGa9yGaO/?=
 =?us-ascii?Q?zA01pKGmESZOB2uxt35/8E4Yio2VM3kf60SZxQawfmRBhqKmooU1qEJuLcnd?=
 =?us-ascii?Q?HTrnB+5ogJ7MMfgiZjTxge+cgLpv0L7mZu4DrH5TkIOZCUNpQyNuUtut6vlW?=
 =?us-ascii?Q?aonrLTR67/kJyG8Q8HomlaJ9weVALF0w1226LEZvPl0ETx0iXqjOdeyKaO1A?=
 =?us-ascii?Q?o3ZauLdpzKbwv3oFZzye8k5rV+JCjWj5ktlRFV3i8r7fzbvOG3y5NA4oPqaq?=
 =?us-ascii?Q?oDCWHYKFagXt7YjGkN49hiZjFcF8NiIOyqBdNfGsT2s34y2NDcf+u+7l4rrL?=
 =?us-ascii?Q?27ymwAUBqwh5MVyNvPPzFXiyAOAqvg3Gg25X63PqWZ0AmK6OPRZvvOuKWQQO?=
 =?us-ascii?Q?hzv4oAUUftI0MU0KE9k0BPRyoHPsybDZ/ba3jkwvQ7NY+wmosPrOqKl7breZ?=
 =?us-ascii?Q?Q/bfW8hwGjctihr0HKEV9w5t9aYbiyo+yw0wJWgWEzof9AWRU2Eu3uWyl9Ci?=
 =?us-ascii?Q?4l+B1VVGQpVoJTV+xQKB9gFAosqAJteaFQ//ATwp6R+0K63xD0HrYNf/Wfdu?=
 =?us-ascii?Q?6A9SpefZBkDqKLQbDB0HnzrhTWztw/rflWw8r82Bx7YteqPiuJW9mWJF68UN?=
 =?us-ascii?Q?PX+d8+dywtcW6QzoHt3yn0TlsAQmCysCn62IUhg0lQrqmb6fT/oVraDBdLSy?=
 =?us-ascii?Q?JZVWYrogAzKZuBeehQneWlYeO9piYI52c6hRnTIygDndFI045pKvJ6inzLZX?=
 =?us-ascii?Q?Gk4TEE6QWx6OxHm5Enx+Cm0WKevSgNHuXTUD46k4GM57khXxtfr2LJ7gxHVE?=
 =?us-ascii?Q?KqmdLGlY2W90TSBCGK+ydjPG3lndQk4S94c2MisUC04OgJBYmbxrAnsXBide?=
 =?us-ascii?Q?3jd7gcSk26csTJZlBb0CPvFont231L/HWxsyQj3dsHJunb6JleQaPHG/94WA?=
 =?us-ascii?Q?wWMbpsWk2l8zB8DuVevBjgAenjGTUtkLkkF13Unm6tuFBDzFhTJnvlAvY2A7?=
 =?us-ascii?Q?taaNaEUAdrZgVDJgC8mKc+L+kUBZobECvhvJHt2ppE8dkIOKgt/sZXI6A1kj?=
 =?us-ascii?Q?NhVgdMUOBmbUalT1rN6ejlV1LZ2dCCCXDgNzwR3kVeGsaQoHF7lA/BCaaodb?=
 =?us-ascii?Q?gZEUf4rn2wSfVxRrll55bAigjDJlBosxopUjQ6D8fj7yzWsliuWc13cLIlBS?=
 =?us-ascii?Q?UKQIL8+fIG8xSs=3D?=
X-Microsoft-Antispam-Message-Info: 3GdDmX+9gqYfjs1sE4I+rliCLVTvZrRvGVllroSvdPm3sYt3ZU9YCXLKx5aasHyfHCOyObiIaIwZzVjTG3h73hbtxHjHcG9o8Rrnb+OcRC3XX0MY/B1EGmSTrCggDNY06WWpzRbQDelghXbfmb/LWmkPcuyjmEsuMj2KEB5U724+v0/xhLu7zc5mjHz0HL+nvUCT4gpw97ENSlQm2tgQI2znhzc1TC2lGQMXjMOrl3kxvmGobTyHtrlJsiSSWYwlKdHzZ26e47Cl42AWyl9U+IUwFzAGN9ngFr611wgFi5UQ81XmFJ7AkaBoK1RZKTzZ
X-Microsoft-Exchange-Diagnostics: 1;DB5PR04MB1320;6:Jzquwv2cHpDyKbIC/IuhafjbcO3TGLCF15/+qftl2PZDwvNgkBl+aTLUAwVvwQwb7JbMvJ0P+/ozrANKd8qNTVjsmQ4FNp4iQgHT7bKJAnXaJUXpr8fFxKQN5dEAr7fam19zVbMPhWT2BA0a/c4m4C6Tsg7rzlKejBUAGWVjoQVE8zrhlYM4djMYi4nA3r+vv0qh7D/xYoSTDcVomrC4nL2yvUpsEqvzhQbFw/SXAnGdifS1t5CiiaTZAfQkUkgtP75qHFH2beAQ+RVth7OXklnBiw0/Ay4+E1F7jlVBNo6D5qg5vY6joLGoZS1z1drsicnfRHHi9JY2ckgR7RJQa/Cpctx/F0CeRLZ5blfu3ZI9JR+CUYN9azec3gW8NrpLhB8hBMrKDD4W7I11dEq7M56eVB1K40xBrmAIx2rGn7X/9doyKqkQ/14fdZ6jESa91CA1ByuO3Cd0SgEO+faHvA==;5:YxcZ1KXj2ynmGYfDcuefs12I66dccJgVynIDphw1jUKJWFFYr9KLRn9gexC9geb57OjnKMYIIzYTkp7nh5P16h6YYKcsBmN+fPIUoXSUaOQo4VCB/L9h2Hjvim+grv3S75GeadLcppSa8KcUwoEE6wzkGZbmn7xhH8x7wGXvIzk=;24:jytIhU41qgrts2ZnLQgOSsPA7uyShS87u6k7jRs8RlaXuMkVIrffeX452C1DKiQ3XBAkPDbY5TpdSqvFOxqferOFDEAVYp5K0bJXXMi0MfY=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB5PR04MB1320;7:kJqLJi0OdLm6k/298wIQ+/YYlew0XIJ7gq+7YAD00Ha4GiThoPSBGpX7iZezXntUK80ew8w3XhgFJ22dUPJ3/enBBhLtceIgaVrSHYVQirdpEgaqKczKoAfcNilh5ijhtnxK7kQNuKtOxzyyauYZf+2O4RirfNSwzgmMwZsJ1qk1FFzqFkqzpRflo4kFH/qC/XXiIy9H7HyfxAzrGXexnc83n4Ghg0NbItX76wBeye3hyecnsG4dRf3sRWMxeYfL
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2018 08:42:39.5555
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ab34330-2d97-4fd9-3023-08d5d689ca3c
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR04MB1320
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

i.MX6SLL uses same SRC module as i.MX51, add "fsl,imx51-src"
compatible string to enable SRC driver to support setting
CPU resume address for cpu-idle and suspend/resume.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 arch/arm/boot/dts/imx6sll.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx6sll.dtsi b/arch/arm/boot/dts/imx6sll.dtsi
index c9b0ccc..000e613 100644
--- a/arch/arm/boot/dts/imx6sll.dtsi
+++ b/arch/arm/boot/dts/imx6sll.dtsi
@@ -548,7 +548,7 @@
 			};
 
 			src: reset-controller@20d8000 {
-				compatible = "fsl,imx6sll-src";
+				compatible = "fsl,imx6sll-src", "fsl,imx51-src";
 				reg = <0x020d8000 0x4000>;
 				interrupts = <GIC_SPI 91 IRQ_TYPE_LEVEL_HIGH>,
 					     <GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>;
-- 
2.7.4

