Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2EEDC64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 08:50:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69EB9213A2
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 08:50:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="gqjrdffb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69EB9213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727857AbeJDPnH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 11:43:07 -0400
Received: from mail-eopbgr20074.outbound.protection.outlook.com ([40.107.2.74]:64779
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727569AbeJDPnF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 11:43:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CQt4hdsLJ6GKXAK02mUWAXMz6usudWF8b6gKf+mgUvs=;
 b=gqjrdffbUlOHE9tTPZsmYL7UItv24FUZan6+zlog/U2p8fP9zfFQ6RYCo7+kMt3eT/WEDwqUvb8ZVzLzzm6T1KN+2sYAazUjeHOwrNqRQp5pgHs9tpRllQO6TWqNNZLGqw8m+29afuPvEnclxo7vf3WKrBEV46agjak/7RvVJ9o=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=yogeshnarayan.gaur@nxp.com; 
Received: from idcbfarm.ap.freescale.net (14.143.30.134) by
 AM2PR04MB1025.eurprd04.prod.outlook.com (2a01:111:e400:8442::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1185.25; Thu, 4 Oct
 2018 08:50:43 +0000
From:   Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
To:     linux-mtd@lists.infradead.org, boris.brezillon@bootlin.com,
        marek.vasut@gmail.com, vigneshr@ti.com, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     robh@kernel.org, mark.rutland@arm.com, shawnguo@kernel.org,
        linux-arm-kernel@lists.infradead.org, computersforpeace@gmail.com,
        frieder.schrempf@exceet.de, linux-kernel@vger.kernel.org,
        Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
Subject: [PATCH 4/4] arm64: dts: lx2160a: update fspi node
Date:   Thu,  4 Oct 2018 14:18:40 +0530
Message-Id: <1538642920-3843-5-git-send-email-yogeshnarayan.gaur@nxp.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1538642920-3843-1-git-send-email-yogeshnarayan.gaur@nxp.com>
References: <1538642920-3843-1-git-send-email-yogeshnarayan.gaur@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [14.143.30.134]
X-ClientProxiedBy: SG2PR06CA0156.apcprd06.prod.outlook.com
 (2603:1096:1:1f::34) To AM2PR04MB1025.eurprd04.prod.outlook.com
 (2a01:111:e400:8442::11)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 460e8173-013c-43c1-2807-08d629d67a49
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM2PR04MB1025;
X-Microsoft-Exchange-Diagnostics: 1;AM2PR04MB1025;3:vL4N9jWtIJEUe4Pc5kP22CSk7VNA/67tAwZgAtr6XYV7uKwhNisC1EZHE5ESIcLW1m4yB3n1WbKyPKyYV3xd59WBOl2px3XGQgfGD3a/hT3RRZosVO+UffyKOq85im+ydkINh6ALdiF34fWj9OKtYbOl86tUIhhPjSzqZE/I3BZrj1LIawSLYsT+vglSCmb/iNzu8N8FyioWaEfq5z10wvZ7h/zj+Z1DhF3nadfH/RUeFpPIiwXCgPiNJ8mvPY08;25:o/fErEmWGXajUazwH6sMy6RffnaGfViu0hTMdDLOmvcaSyxN5Z3ggybOXdxcnRb5crURE83yHbXjsVvc65F37K5gPZOisWo6Cl/pey9SWlrYfgI1/jVSTN9TdyaSNXK9gHbxYvutD1RbLoFk5eSC+VUTvIIzIRQHXtA6YFP21FOjXHNl0XWjgWSFvulpgeg/Ji6+VjfokNIFDCfkq3ZUhhKIaipEciFVtrTgWOd41ZrCl8fAXoDtuVbdwvZ+ycCdVWtQ41EOFF13E9AGKYSaaISl2U2rOWss59pbz3RVwRGs0PyT+n5oN7GmdQ5DA7EVBmtv+ujLBRgyUNYk/iw9uA==;31:7bJ5i/0cSK6f4yZodT/tQPxQrtMIdNJ73Qh8AjtHcoJ/XzQzzEqIgpReorNT4cvhUHFTanja59KSEEm5jeLfCFRkrysECDVA41wjEMRWrwg/4jctrfT8RI0q4Pie1pvk90C5pwgRL0gBaGukxorOE53PwGhlhevfAjt6G6l7AoX0Jxl+M1oZ0s+dpBvROOKA6h4MCtwwu/3oUlaaFNsZF8HwvSQ/XmMRhjjw2NYM0lg=
X-MS-TrafficTypeDiagnostic: AM2PR04MB1025:
X-Microsoft-Exchange-Diagnostics: 1;AM2PR04MB1025;20:1PXj3i4Owkdr9xjc8YcEzHvN3Uv9JGW0ms2hl6TKcP1/10wwSFNCGOB0uTHC3seNP0Lb7yLwyQFvpr9iTKzfGoVcjx+MIJVX1D8G1Wownnofspv1ea+PpdRQHeKrNUZBc50CwVNs7wD0iN4IGdMh77mQSGiIfJ0wPzyLR/u7auJgXEfK7mBeg9DK6KHndd9s006EBtiVwCIm8/FWVySSlOfnLewKEPJL6pi0sQdv843cD4QpwUWqbxx0N5f2lyTgfEHdigmyY+OtIPlEkLn2JL5FPHoeIQ8vZhS4j6gsIaG4BJ/qRl/qGI85MymL/V7PC9WuQUM9QFFaOK2v/VC4tbVNluNjuwD3yq7Ie6DrhKCCB+lxMoWd1TT5UBkI0a+WFyIaDH/WespfLaX+BJfQXrXVnPLnf6pj7rpHPiSBej9QWq1IETCGPdYGQVUgkTI5DDettV0s0ccLpi06nIHw/HBebNW9W/9IWRUS563kZy/1Y1qBuPn+tO/SWwVlkB9m;4:iZfQFpYTC7d31I8Y34trRglkpID/x0y+3OpFNURha7eQ5i18hfdQi/ukcyy02w3t4XS+2aDGOIeMPT8q+IVvNB0ii1sBngbPveJO6rGjSwBWUc2IcFGXxgjkXI25DaYN8HCP+WzZNuKH7XlzcW55/R+rAPd0a6iEOpyaBLwsCIDp2Kc8SCaubgUCXoqto7WfED/k7DoaeEPPHROWKSYVYEGdCSJqOH7ZCg4tta1SmXqaHDwZajX71ytAcUrKP5qO0/rR3P1sIpYI9hBfXAmjWGU5kUzstexlovc6mXqjQ92eqGfLd/jgTb4oia0u3oQi
X-Microsoft-Antispam-PRVS: <AM2PR04MB102587FAB62B2C7691429E7199EA0@AM2PR04MB1025.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3002001)(3231355)(944501410)(52105095)(6055026)(149066)(150057)(6041310)(20161123558120)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(201708071742011)(7699051);SRVR:AM2PR04MB1025;BCL:0;PCL:0;RULEID:;SRVR:AM2PR04MB1025;
X-Forefront-PRVS: 0815F8251E
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(39860400002)(396003)(136003)(346002)(376002)(189003)(199004)(6512007)(8676002)(3846002)(6116002)(7416002)(476003)(11346002)(2616005)(956004)(446003)(66066001)(386003)(52116002)(16586007)(51416003)(6506007)(81156014)(81166006)(6486002)(486006)(68736007)(8936002)(316002)(106356001)(105586002)(25786009)(26005)(48376002)(7736002)(76176011)(2906002)(50466002)(186003)(16526019)(478600001)(53936002)(47776003)(50226002)(97736004)(36756003)(305945005)(5009440100003)(39060400002)(55236004)(4326008)(86362001)(5660300001)(110426005);DIR:OUT;SFP:1101;SCL:1;SRVR:AM2PR04MB1025;H:idcbfarm.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM2PR04MB1025;23:q++1JvBOR5gg4gFa6ZXu9+svK814zDGI4/x6LSW2G?=
 =?us-ascii?Q?OdwqQypFUYVjbkuVZh6gsfPfjvP0W2iWJ1nznIJ9TiVelurxx0/H4pzklU+I?=
 =?us-ascii?Q?+nBSUR9FSMzSazGbJNumhTerpHayzkkfD1ThY1NFBnBnW8WYkj8N9DQPEwiZ?=
 =?us-ascii?Q?LR47CVybJnfxjaXWekUG5Y+xvLXk9RbO3FyzX9O6cSx3k4X+HqgyMg7Se6MQ?=
 =?us-ascii?Q?zrQ1EgH+SBzdFfWl/80L+5iloaKdHFwcCfJKVciAS4rVauUz5ywq7ovySxJf?=
 =?us-ascii?Q?6APmEy4VK9mqtzNu38NRO5NCz0w6/T1+JlBJf4q4TpYjXdIvfMqgACQ/fTk7?=
 =?us-ascii?Q?5Lz+t8srThCZrCcORwpq8GCgZkBszQTVl2GDb9L75Ps1rdkzFIs8jMF/b/G8?=
 =?us-ascii?Q?BZ82bBLcaGmFiNbd6irAJZzoJgMLWZ9q8ZF2TGp/ZYt3pMonu1qPSZ06VkkW?=
 =?us-ascii?Q?98k1HbVp5cxuFsUJzHbgvduOijgQHqWst3GXFlQHLHoy4PqxYzRbNjTAqtWs?=
 =?us-ascii?Q?IWj2TK2f5Zkxcx7zNJa9dvOE4+Kmr5RUx0s0eUs4LcNzRN3wTmR/sCj5L1b0?=
 =?us-ascii?Q?RA8ZnazpaiKOj7zASGJkjDrVMoI4qbiDskl6LT5k0WfpFhlupKBW+Xl91OKr?=
 =?us-ascii?Q?pFGYx3vf4SSRESb8s10nUVzPeth6fzDNUL3e3V3nbudW/ykBMrcIHHaiCRW+?=
 =?us-ascii?Q?dl+xkbsUNiklDfdA+cYVugB4Sa4YV1Zq46zLsQBh6ciAUVxL+ZnIM/ecKZks?=
 =?us-ascii?Q?6qSHc+gegdQ/3B/2/TXPW0TV+B0ysfneq9BnBFm0Rtxhz25TzbrdT64KPjqd?=
 =?us-ascii?Q?F8QUgZA2PeEg30CtzqgOwUuDSl0bFj/c+MVhv/3uwphGb7jg/vLUv1GRmmND?=
 =?us-ascii?Q?d6Qeczl8ZVLrdRVBBrhbwOesm/kH/jmzst3DK+SuK0yj5YUfaKgvtrRgpb2J?=
 =?us-ascii?Q?qhOOqgpgfnTxXnjdob8UcK3K4G4r5n79jooUkTuquQzK4YjwV+36EKcO7bWF?=
 =?us-ascii?Q?pg9+TgFgBXu/HN3zI1+pBPU/9OcdabzwY9VJkw/v03qQlxg8SrmTPwPK5MLk?=
 =?us-ascii?Q?3vb2exNaPqGwIG1jFDRfpOzitj7TQgi0iT/0lcbndnphj0eSwVdRF2YsEo5k?=
 =?us-ascii?Q?a+fIzX708fpG/vmdISANgT09LM46dxAP/aQeodWSFFt5iKf3q0k3s/2ocoKB?=
 =?us-ascii?Q?l1bkuMg9IpZnenjpNrA2/Z6QMlB7BOOjEM9C1XGBGxCM+hfdwcm96OXBg+q2?=
 =?us-ascii?Q?7tIxVbFl33pzFZgb/w=3D?=
X-Microsoft-Antispam-Message-Info: yplrAqn8MWuOYvWir2KgLk7TnoQ8sAbbdFLKnOrFlPeMtxfooofs7nNvSkOkYHtnjE2WUw/eoyieOupVHNqLfHQdwQDn8bJA+xELDOw8Z2FxCKXii+INTXDXimtmyM9dRwzPzWahYprq7pdO+phYhwqsHPOQD2hWEXbKL1D901RQeG4Hg+kvYLltNNUQp96MLV6DpOsQFj2uheeoDUc8twsD6CHkQnq2BWcoHHNsmLSFQGeWQyRRXcg6i/pIi8AaUDW8eDycyHidxHZjdhPh+mjs76hcxA6qtS/pwZkaXg2y1joZ6W9s5ck4iw2l7GwIQU8YLxsoacUtvofXwQ/Kr9sY0lcbZUcxxls3NyvAd28=
X-Microsoft-Exchange-Diagnostics: 1;AM2PR04MB1025;6:/rBC1Aw+5mJYxGJDtUl3BlPd9Rx3WoCFZheo4Iml+wMGC2NF04i2Me4sEXzTOdaXNuL5+5MJFRcMJQeiq8XUba9bBRmY1e9alI4MfuOVcXFkEjuLHFHUNuKDN0+G+9RxwF2+LJBMmH2PYB/akmzuPg4r+tqqUnFwgZuJVwlWH5yrM+hbeSPaMWcsAniRc/eBwcWdn0mrYiVICUGpR9XgXjULOKfu92q9uEISUomeUX97utZCeiP/7+ajBTwwGvn3QqqD4Vg2PdFrgHDr3Xg7LZ47vJIE6k3MpnKg1v+kDyFGSQMG/n+XG7G2GE1mgk2yuoX3IZ2TJHuM9MBgl66BgShwYAuSg3L/iYh9XvydJABwAV9zMXxZs70Necp7mSGPTYtcO4oEQgNIGOTpgQ2w4SUhasSnDobVc6wgV88Ky1VX4hMIC3KGZVzyxjxKZ7kDUfsFkGoXbWTrqRAxc/OCVg==;5:o+bIzha+DpvS/gVWEqTW5mvm8B1clQona8kbEYYZeSZRbtsexyzOzOyRZ0Mc6C+XB5AiE4KlpJRz97bAxbNLM3RScAXPVFW/sJPI5MMtl09oU9ADjP1UGmKy9bnyO+Uu802O/KnawDObDQOjGhvz6jDIoJWxcENPoyxtaKINSVE=;7:rgscNKcYDMtKK1qavLgWiSXer18atmirWhjX6aZJFGpvb3TVydDUhaYTiTw48Uxy6oFb6+Vuf9GFEBosp2ksB2phu4hH7fNpVi/xzk0WQaBhgkiyexxc6iTGOtdYWLShnImenvhhd9bK4MV3ZmAQqdfX1cd/IeKBGoAA0mnoh9JYvEc7K2tIG+XhhJZD3M14RtEHjQNG2O2JKKBqnRBeWJGIzP3k6OXlfEfdHdnPru4hVr9DzR9RUZEbumqRxfEY
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2018 08:50:43.0388
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 460e8173-013c-43c1-2807-08d629d67a49
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM2PR04MB1025
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Flash mt35xu512aba connected to FlexSPI controller supports
1-1-8 protocol.
Added flag spi-rx-bus-width and spi-tx-bus-width with values as
8 and 1 respectively for both flashes connected at CS0 and CS1.

Signed-off-by: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts b/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts
index 901ca346..817175a 100644
--- a/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts
@@ -42,6 +42,8 @@
 		m25p,fast-read;
 		spi-max-frequency = <20000000>;
 		reg = <0>;
+		spi-rx-bus-width = <8>;
+		spi-tx-bus-width = <1>;
 	};
 
 	mt35xu512aba1: flash@1 {
@@ -51,6 +53,8 @@
 		m25p,fast-read;
 		spi-max-frequency = <20000000>;
 		reg = <1>;
+		spi-rx-bus-width = <8>;
+		spi-tx-bus-width = <1>;
 	};
 };
 
-- 
2.7.4

