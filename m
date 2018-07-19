Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44C64C468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 08:29:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E95D42084C
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 08:29:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="M0HK0s1+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E95D42084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731362AbeGSJLR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 05:11:17 -0400
Received: from mail-eopbgr20051.outbound.protection.outlook.com ([40.107.2.51]:56797
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727112AbeGSJLR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 05:11:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ynxrsElnsvwMM4GaeF7qYuzyJuxvRyKzFmF04aRqRPk=;
 b=M0HK0s1+t+GAR4trIYMx/yBfGPgQZn5qRHA4hEJnSUofBNW7yDSnEar+lkxyTqegFnKYx3SGLJcqzNRwxUcvR8QFuS0JWeMq0mcOaq5md/95bro31y68TfxDhOeD5p/rhLpeCctLbUshTwn9rhPW552RkTbketrTLLx96fACvKg=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
Received: from anson-OptiPlex-790.ap.freescale.net (119.31.174.66) by
 VI1PR04MB1326.eurprd04.prod.outlook.com (2a01:111:e400:5187::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.973.16; Thu, 19 Jul
 2018 08:29:05 +0000
From:   Anson Huang <Anson.Huang@nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        fabio.estevam@nxp.com, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, viresh.kumar@linaro.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH] ARM: dts: imx7d: remove "operating-points" property for cpu1
Date:   Thu, 19 Jul 2018 16:24:19 +0800
Message-Id: <1531988659-9466-1-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: HK0PR03CA0014.apcprd03.prod.outlook.com
 (2603:1096:203:2e::26) To VI1PR04MB1326.eurprd04.prod.outlook.com
 (2a01:111:e400:5187::12)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5dd86fe3-c136-4c5d-3872-08d5ed51b2fa
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600053)(711020)(48565401081)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB1326;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB1326;3:nuCjl9dKLs+giUxRlq0vcCrlXQLWsfB6dUF6LL/w9LyO2U10qaNS/t2+qmlcE999ulPss9wp4UODSEiwydbh4oNxp78kosVDPhuVVkvMrT2gti0WhbTpB5g6axe+38T++8lAg+eM9H6xq+WguNkWlQAHRUAdmu6tMn7xHe8ySsWTOBIat2AGUQoWvVivKxKKdIlbQLOSMMgspOVFLMwxeN5n3m5MBUVUJvzkrm+5J8+1I24YGd2cIttRgTWUXPIP;25:KpCRH/EzTuFCCDPJM6y6KAZg9fhhoePVZIxogL3AhUCyRZHV5BL8DstXBQT32GipDSSvW5vKEhzSky1vG2O2aZ94bAwTszadWTu9WuZ1n6vAbjtKripUmy+AFV7VUXjLs7lZle7uqemI1UFC5ta/0VIwa88lGI+IqUd9cIZFgU8u5VRUxu8gAPqFQFLDWF5smAGBhyTz9Oo7BqRAxSH+ciWXoGQTLJdMgdgqxxy5oxVEAEvR97ZGqnk4ioLVS7BS2W8+kpZ/bcA3zDG2ni4/NajGdqliAgV/Llp8qeCDUMYrpLLqPuUUlEfjbJr8cLlicd0q+9zd27MWsJwOmO6ueA==;31:hwSp3iThVhl2XINpwVRkzFyPMTkweZIWLVMhagd8tMqNmDOI/NYLR6POwt13dvYFa30Ka7vSGfS/Q4/wvvqHYiKDmnJMoYh2Au+tfmSDwfExS0ZtKCRYKpHL27wKcKmspnrcrFVb+TY9W/7V4dTpfIzYbDI4Wk0suC5JPObm/CYWG46pJG9uS4QJw1VpC1NpfSHD8ENFbFm9kw2FrZ8brqFVCS9UucRpdrbS+gKDb/o=
X-MS-TrafficTypeDiagnostic: VI1PR04MB1326:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB1326;20:/AksqZ8iirtwhPcd+q+nHLzqllirNL2GfR3phwazdLf+Q5FPCadrE5Ji6VfFHvO9VzVPNTnIVBZnxF8ELNaUpdCiQ96Ijguk+eE7XBYXZX/sVltTGkSsQbcisTwDBbk3sLZRdl6HZl8B8fjbwx41w+MqaXkstIHMBbnqXRDkr5ouxqf1wptPGZBErrgRHRAZ6o2flzbd/yLILf4Iy75fr2MQXhxgK3U7qEEuDScR+3ZU5xpaChwgAicbhZjeLpwfE5EmqLksF4jZ0U9egnl1ouhQsdpMHU0fF+UOamAP1vCX0EitJsEG4LEx3sKQeBBLk0euqjtF5Ugs/NQkLSwrizrOIhT921+A9Ywy0fHuP7/SXw+qSv0BJ4jy5ME0vMB6nVJ8DA9fUd2J7wPqEPr9efI+rrS0WbiyqkgCCc/tficF5VUVpBuMuH9K+o94U3U49/9GQNf0el+o0/sOhlp+VmW8uK5E5zGPIfdj2CaEQjqbQb68CHEzgFWl+L/Dwnqj;4:Zc7R9olRJ2gaDdtKKNbhCEGgiGaVWxNio8NRhXX87Yn2wIIBoCrgBf8Sz/iHwUniTUiXtm2c5Ok+zbJ3d848t2HpXku9rZlw6zdRBI6yF1BcyqWO8tCdw07juzCHwTS62ucQE2jovHOsvLClYJKLjm5+QgL8RpQfa2qlifop0jFp3N3yk5W/q+hA/Og1QG3bP3pZSYWbm2dMeRKasmxwZq4VNvaty+t2WDtMbdtLIyLAim4GJEBJy2CMS9lTOzmxM2cXbbLetZ75I2S72oZa6EcEuEXcja0jHk12Dswupi5EOHs4Efhp249/i8wK5P0K
X-Microsoft-Antispam-PRVS: <VI1PR04MB1326B6D2123B57B2BB8DC592F5520@VI1PR04MB1326.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231311)(944501410)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:VI1PR04MB1326;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB1326;
X-Forefront-PRVS: 0738AF4208
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(376002)(136003)(39860400002)(366004)(346002)(396003)(189003)(199004)(53936002)(6506007)(81156014)(81166006)(486006)(26005)(50226002)(478600001)(86362001)(386003)(956004)(7736002)(25786009)(305945005)(16586007)(97736004)(2616005)(8936002)(8676002)(1857600001)(186003)(16526019)(4326008)(476003)(316002)(66066001)(6486002)(6512007)(50466002)(2906002)(106356001)(52116002)(36756003)(5660300001)(105586002)(51416003)(47776003)(68736007)(48376002)(6666003)(3846002)(6116002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB1326;H:anson-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR04MB1326;23:5pZ4lL9gmFpdh/7ad67wqqoh6KwWPw+m8TLf54xTA?=
 =?us-ascii?Q?TfrDVgitmOpr1wJR+UymAVt8fbQvFVQ26aLk1lsjL6YcPNSS8s9JpdNBVaag?=
 =?us-ascii?Q?UED63MBiNdz0X4J3T/G64DCS6+1Rjpr9WhMq+K0xj70lttV1ZZbcPdyDAh6h?=
 =?us-ascii?Q?Iss0d6cuSyOAJp/Kdpc7pwHRKxKxjVK6lp7eKOBijQ0tnD0UBvtlIsiwzeHV?=
 =?us-ascii?Q?rCiO87PwicoXhuJjCVouH6GTG0/rKPhiBuX6Kez9m/zgZ20xaziKsjjk+ed9?=
 =?us-ascii?Q?z6PDb4gHwuG7dkreMia10+O5Nxr+djg2PxX2WyH+/DsMlbb74i3rsJeKvTWP?=
 =?us-ascii?Q?3KgvpTdTiSpCQ/TpFEEd/juHU1Bxu0DDk0naVbkOoAgacvucsJwel0yvQDTF?=
 =?us-ascii?Q?KD2AsmLJCvNhohNqpzyRzMPeY2PmoI78TRqgdUWZJ1wR6aCXST36celYGKYr?=
 =?us-ascii?Q?xLf3Xj+qoD5rS5uKGDZVRkmloxuNHJh2PN4BzYJjDDgWRXBUCy7pkJnSHxBG?=
 =?us-ascii?Q?6G21mijlkWZD8soZx26BhfTDQCvPQfsxvpeptL4Kc9FYtp/tHspP9SbdVwy0?=
 =?us-ascii?Q?isQNuOhO5ABrQNacVcueQ4OWoD0j7uGUqZK4Y03R1N24i/52Hl4Shn/hH8B5?=
 =?us-ascii?Q?OQ4eb5YehigFER4i0Rv3+lVUhAVyjUUWs4SKBNp77KNO84krhGJbovb89Ln3?=
 =?us-ascii?Q?D3aGakxstRvRk9IhlCdpffYzGRSldDuqaJYHsqI1GnoCJVsn0+/S4s3lwvuD?=
 =?us-ascii?Q?xbQTiTDeq7d48Gl6poKd+/2aWDvOZx1ht9EnHrPo4jxFaijUYfmSxB6AkgLB?=
 =?us-ascii?Q?+U/oMhLj6WUy3d56HqwEgZAMjWBxEZL38AWNtI7cxcoksnoPdProCGdm0izq?=
 =?us-ascii?Q?dHmRT748CcLLAe9i6bCGho78A0s2D73g5J+ve+VC/cDUkl87F/kwznChEB4Q?=
 =?us-ascii?Q?HKp6T+NglkuqDg28k8KUpEl+q2suheV8PO2tvihgYniQ6Ymc3tHjIXZnWJ/9?=
 =?us-ascii?Q?CpFyXKmTOnpWy5hAFB0vB8+v4uJ079g68h4JIT7IErcJ7KIlpCMdldlXLiTo?=
 =?us-ascii?Q?PjSQARU0mogk8sd5P2o16LOXeet+Ep1q4w4DLc5kQ5DUD1/z9Y5mMECqpYWU?=
 =?us-ascii?Q?Os37jTT67H8s65M7crZR15cv+6NPILt?=
X-Microsoft-Antispam-Message-Info: VMtovWl4eKy4Hkt0qdOF7q5ZuzSSOrV/8XMAR0wsyvyXpx2N5jiyXVigeTxYFco17qPmYYQp3eQNqYxHeRuhxTgUtzyQnhotAfTz9g0egf22+TUtajMeaO2SDYX6eV/9ps9uQyrtrrWfUEfoS8YoBfEHU6q9mkT7kGhbBAv87pV7fLsv/8XQsUNXs6Xqe7J98oF6oHdQxmak9YOXTFJmaaNLAToNauMrajrbPNzdKs+Is3QxuAygtHGl4TinG5oRu4mrw2KuAGR3hQEV2KfHkF81SQo654w/JsrOltYD5pgcw6+q3ZfCT1x3ecHVSetNzjfBS2gZNibax9jSXZg0+VtEHFtziphr/Ss7qyJBQtA=
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB1326;6:k3rizlBPx7t+M+BKCE48XwUPCazYvZdjfXxDv1M7lbZsfjY+1AoJ3x3ampFLANLWL02Xnzfa1aCjYHpcDqg0q5Y/ZOOCkJ3SSw8InqsMsedAdRY1PxbmNBxPQHtklzcAm1/k+5tZ9/rAN4HRlTp5toOTqfPWEoztGOj2S787MwElIs6zzQdYM2KA3M9GCO+XLeKOFmvttOZURqEFK99eTEJ/73J28PIzVRgNYlndU7nyY+9pttDke8RSNf+FiSKDkU0wBINjjK1+R7/1b2TiStRZakUrTuu00KOrcokpMWGVQTb/NZAGhSLdZQIshUsvAoUZD0vN5FZaRzyr7j4SCp+xfwA8goWz48u6IgUNQ9sx8CdNQH5O+d1rSYbRQb6BRyzJRzRgjAdTu0v4GWwOC/hksklVcw97sFGeoG8w5Ju8XP1YVSZGMLN55v4sLoLMtDhvhB0K/PaUbBvGOklhFg==;5:3mNr6RUpqfv6Q58dEKqcJpsq2n7CsI0gb9dBmG4+xEL3h+Jn27claDZHirZ/y0MJiKDSOFt4MxZfaBh4gUfInM3ckI6W6JP4xpPzDsXB3U1lrsH+hSuaey1swsAixz1VC8jWouzmRUyM35jg8A2BEW2UsPIFHvFCA5UsrcEozeo=;7:o0I6tYc2wxNQs4BYUPoJrio0/nuUX+hhvdMO4RzVKUETowwSYwRz7xwDaPt1HHXL/e3MiyJ52gBIgfc24B2X2eCgifojiMuwSm7hryjGwJxg6SSZhtjGB8Mfg+GHVh+PH+Ax4mbPm9DX+f9Tsw4Yv4UoJSYX5gO9eLUwwaOpNB65icpA5QhS4zOQnDk/Rou9TZL+ET6Vmc5rvEliYyEGieYlI+rfpd/MkRYK96Z4hsk0Ouuvi0AFK7D6yoOeSk4X
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2018 08:29:05.9912
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5dd86fe3-c136-4c5d-3872-08d5ed51b2fa
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB1326
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit b97872d4eb22 ("ARM: dts: imx: Add missing OPP properties for CPUs")
added "operating-points" property for all CPUs, but i.MX7D already has
"operating-points-v2" property on both CPUs, so no need to add
"operating-points" property again, this patch removes it.

Fixes: b97872d4eb22 ("ARM: dts: imx: Add missing OPP properties for CPUs")
Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 arch/arm/boot/dts/imx7d.dtsi | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/arm/boot/dts/imx7d.dtsi b/arch/arm/boot/dts/imx7d.dtsi
index 9a772fc..7cbc2ff 100644
--- a/arch/arm/boot/dts/imx7d.dtsi
+++ b/arch/arm/boot/dts/imx7d.dtsi
@@ -18,11 +18,6 @@
 			compatible = "arm,cortex-a7";
 			device_type = "cpu";
 			reg = <1>;
-			operating-points = <
-				/* KHz	uV */
-				996000	1075000
-				792000	975000
-			>;
 			clock-frequency = <996000000>;
 			operating-points-v2 = <&cpu0_opp_table>;
 		};
-- 
2.7.4

