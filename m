Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752466AbeEQHbF (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 03:31:05 -0400
Received: from mail-db5eur01on0088.outbound.protection.outlook.com ([104.47.2.88]:62368
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751017AbeEQHbA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 03:31:00 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com;
From: Anson Huang <Anson.Huang@nxp.com>
To: lgirdwood@gmail.com, broonie@kernel.org
Cc: Linux-imx@nxp.com, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] regulator: pfuze100: add enable/disable for switch
Date: Thu, 17 May 2018 15:27:21 +0800
Message-Id: <1526542042-28485-1-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: HK2PR02CA0208.apcprd02.prod.outlook.com
 (2603:1096:201:20::20) To HE1PR04MB1322.eurprd04.prod.outlook.com
 (2a01:111:e400:5889::12)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:HE1PR04MB1322;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1322;3:H+r6xN8CkEzxEMLX2Q6qQpL8CdMRnlJR1ShB7bL0CmUN/v2Dt2sSUqNxebVEQq6PrYgOTL8wZJDuxwzLfv+4ZxxEcIkAFJdhi9sNXkWRFuh74tgDgAexSXkv7lx9re8RsUBNqSDBaMrI8D0dlnWdxeHwFfNC4883Okq8j4+k5qk1bTMLcaocUwM7ZTsD0OOl4siRnxQ1zq+4cqQYGtZYXkvgejyLuOhVHigYjgKpXNkZljcPmRfzwDZMvryEeIiM;25:hFudvyiG/dRcyaokVaXsmkwfL1UQWNRC8F2Hr3WkwFsgAACFc9o2yqG+mI1nIN+BwBZ0GwLfFtLUjf+cO7/wr7vB9rntewLtEH/7QWpCFL/GrQeHvrHuOaAA9uBVYUnvSpy5yhv6sZppAeG4OM2amQDE0RUB3H92cUJPZU5PupPQR48T4s4PMpQNns8fbQdG29PZIoRtIluhhmBc2WnBlSOlK0+sVqtvTQnLeAZLEfdZr5wH5P2h0M+B1Gx8i3b0B9BV+B3RsbNDf8oCKy60pMI6WoahuIKsa/htw0p1lvRSU26dj/rBl6z63QOT11WLzrWPl/tqnmub/ksxJ6HjEg==;31:8SxIZjGhgcvxI5phzMQdx/S60hn/DncPgBQCnc7X5POQjd8VNeTbpi3F77WF03i0DjZZx6SzQxFZsW/Iv73SQUiX/ljjk/wbESvVXE9Duzvde1UgxxR61SmMGs0QzTgMx0HHu/feVHw9gGCTpHNBJHLSHpmSGXbgSTe1B0CKANL2BPZLHk7/BrhsVN4i+kMQkOQixiZBIa5cWppCF1GngRxc0yj/rGPXe1f207Dnf6w=
X-MS-TrafficTypeDiagnostic: HE1PR04MB1322:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1322;20:Mw0OUeBS6QoB2xY75dn5e/R+ajEQRhWMWWLnsTg9KoghFSum6MPmhpxJINaqMUD2pTKHwEH3KGctXneYAUqUS2sCX4FJMClb0hLBYdowU+IK0//NpvAzGBa/Cw2Da1XNtrNpj4suRwtybMYhK9VAksp6Cm3OmlOI+3Ng6B4E+b7RvnwhPioW7omlyUa3EWH298tguFIe93SxoiZhnUf3POUZ1ZJecrPT8b50aBXsW8ZrYOaVGaifnCZYnTMBZrLrawnMuyTOtiM6A5xxbV+UHC2gUU9qTQfQt8/4oGolXsY0EBWBivf8q/V6NnPEvzlBMgLoP5Y1VPsooxC/Jg6WaABPF9bCbA8pcA5U48So4u9ZRBIRAhsO7VlQpbJsDij7n9iDakmb9OgyLDNXzo3z2Eeln96CSgcbLZbY9syeVCa2KIAXrDX3VVJ/HAE6/5+3RzhgN1aeXP8Hg+DbDkSj2TP88JANzlEtHRq2lZWp2x3pt4ARnj/UZGzD7nBwv/u1;4:ta0H+S+MpmeGDdn6AbsIiPRt2+2Ubm8QOA3NKUYXtY0B6+WPVVWEYwKVCNkcRumQIQ8XYgrHi5Q50sqx0AH5t+MOwXKXhhKa9w6rRkShqp42d3Q/iNe6zBImrnjBChar/6zmyIPwWI8ZxTVRc/s+DJQrGGJtvTyc4GdOtop1WOUHgMI71Rlxmj/92FZyVBc15ELBgKCveKizjxRzD1F4YyMI9WNczZixhSRpvSbtAczHADHb1t0oiH+14lLmmoXK2RBWpGM6JM1SOEENs4a57K8LI4rRBoDqyyagd/fXu3KoCETT9xoweLkdJpxnGvE+
X-Microsoft-Antispam-PRVS: <HE1PR04MB1322CD2CB8817F4D77D66EE5F5910@HE1PR04MB1322.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(10201501046)(93006095)(93001095)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123558120)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:HE1PR04MB1322;BCL:0;PCL:0;RULEID:;SRVR:HE1PR04MB1322;
X-Forefront-PRVS: 067553F396
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(346002)(376002)(39380400002)(366004)(199004)(189003)(478600001)(25786009)(2906002)(39060400002)(66066001)(36756003)(2616005)(6486002)(47776003)(68736007)(486006)(6666003)(476003)(956004)(51416003)(86362001)(52116002)(50466002)(7736002)(316002)(16586007)(97736004)(106356001)(48376002)(3846002)(53936002)(6116002)(8676002)(105586002)(81156014)(6512007)(81166006)(50226002)(186003)(386003)(8936002)(305945005)(16526019)(5660300001)(26005)(6506007)(4326008);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR04MB1322;H:anson-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;HE1PR04MB1322;23:tHuIF5TbPtA0nDSvdXF3m+OMtMSa55MfSZZIqw4Rp?=
 =?us-ascii?Q?ms80zbpPZYVY2nS+wdHBDmZriRZGwdCSDgCPR8h1q/pn9EnuRXI8/4cIde3G?=
 =?us-ascii?Q?/khtu296AP08ZqULSjd1ez8a/an6D00ydaUSf2Fna0pxObIEUB3rAWOLkenI?=
 =?us-ascii?Q?5JdHwdMMZFye2JKA+4KYNNEPcJqryj/a9ZTy5xV5uQ22pIeCp1Chq+V+lJCd?=
 =?us-ascii?Q?T4m+H83OdaARIBW44uOb1kiihH+NN5xeRjVso6zbfAXy2uXaOuHHh7H8UnYV?=
 =?us-ascii?Q?3RMX/BSsmbLKRvhvXe1FfjwmyAe8MmDoXu0CtZ46CD1t/XoIdCamykHcPGsM?=
 =?us-ascii?Q?D1Ui6IvUFrku+P1yzarGkaIC0ko78oMfUzgTwHIvJ9I3uLrMoPAaklPTaksk?=
 =?us-ascii?Q?NJjRP2K6CiPWFxfW/hp1ahnwrMV9DssvfAhZCub6kUWFeJS5FC2xw2nydWrW?=
 =?us-ascii?Q?eQIsOnW8E0SRglDjvvtOib67qZV9c5FGyQJneiXF5NNXZb7WHcyTl3DSU9T4?=
 =?us-ascii?Q?nB+cIUIyP6UJWvDuJTWO0xtiyopPhQ2oyFJL6yLKmu5va/pBVH1lB3Owowvt?=
 =?us-ascii?Q?DC6TQOvCFCFbVqpLF1gZKwsZf2fLkc/HC/X8pBDIAeAwWmJXhuYQtvn12X+0?=
 =?us-ascii?Q?WImIZRPvSaqTJvS4Bck0/T70udNKmkLKslAh8QHbaHud2kD9WX7qGWqAH/h1?=
 =?us-ascii?Q?qd5cYK6QYRE9IOSCfjGuQbQaHhHWT3x7ZGGkP/PHWyCpoHCZECzNgPMvu/G3?=
 =?us-ascii?Q?gM5f3FpHxr4uZDiqEXVBnTyf+pDSABZbBUFPOKOKB5Fpggjbeosm6TK5Rx50?=
 =?us-ascii?Q?6KEkP8PSHb/HCHvGNdQ15CBMUt0YatdUfIKClpNRTvZUegTWwnqE0iRfijJl?=
 =?us-ascii?Q?2xcKolVD9lNcxwIiIc3d5f7i4OYaCFDT3YkUvcQH5/wARufU4SG88todc74j?=
 =?us-ascii?Q?8YVQ1VUbUw3adgCuCZVTtzPoEcPrErS0mWiCs9J8V4ZEuSRxJbDOwNRmzUw8?=
 =?us-ascii?Q?64a4/eD+LsCvihVuRbutLZ5ETxaNfKEpsDsWhJgGChVhsHDmVsqqPOBBS2LM?=
 =?us-ascii?Q?w1I/O9veOTN5uVGma3Z3wfjE5lqvCjq+K9r/D+TojTQyZa4TUeQXyGP8mEKF?=
 =?us-ascii?Q?XCyheke69w=3D?=
X-Microsoft-Antispam-Message-Info: AGDAwIjnD4kDtMaxb5qvB84J/1r5qoRBo0No6sd0foYg0JzwJFGHTatZKvrsnzLp36GHfUgzdmN0dCzD3ijTQReORUtOrS/TflFMt8cPpK73iJL/o2Lvs5d2GpsOQkZ87K5tsL+3+d/L3mIBrwEM9hJsc3Duql4JW5rWbmNSzsF2jU31NNwOFeXcFwCaYlVP
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1322;6:b+IfD/kdqU5aQhiWroMKj64fibar2LaZ+JHj/6Se1r+W/CxSOpZvuOpNOJqYriEkyG0VL1B+JAeBIn3/UqUlg8W14eosZwk40RMqUGepRBxvNeytoaiewlS+skN5Jkxq5Ri3dDfyO/ptE+Y7VI/dWDV4y4/Ye7/a7u0TwxUYJ5RkBeFTxYMixvxuSI1isaNpQmJMRM/zxpl39+76GWPBpmG1+IZLtLWmHkIUnK4UbdmDZwixYY183Lm5tNaeo6wtnGntPwi9XMCtymUmmQ8Qkw7ryEixvGKTr+7nt5k+nkaGQqoYoE1PczvL9suelsbRKEsR8fIEbC8HlVqoarUVHZaR73H7Vd/nRtteqYzX0tSvQaGNSOctvBBwlx5JbKpRCG1+SxwhvHKQrUS3O3uzhOaXaw+kGzqb0pl+zzGgJt/3nka8SeuItZTREox0wB48qZfV6EhxryNugwtsM833uA==;5:6di1OvcRyL79279L+f3RfO2HbeVD/jc7q4kzdN2x/yCnZjhvnWetPDSlTIDQPoWUeorcL9g6Xz2p0aNF2rJTVib//9dIC+uzJg+JvqXR8CF0vWYhieO8zxvv2GCekda/G4egL2Cht7TU8yPDBK2NafRMZE3PhiqSvqAKEVbC75s=;24:ax6GV44OqIZxVtLhzrCva6cxfKVyVoWKWlgh58RFEl2U2P97KF0S/SRBvpQnbeBVv6OScGCqxq7LbV3UOp85GIurGEZiducyhFOTCMQfpxU=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1322;7:L0C4LdihP3669Ee8fuovlAkSFE0jyNgR8YBBRWFuCt5Whbd+nZm2bGVBgC5bXWSGp9+UM1Pn9dti9bvXwEX531xI1y75sU92HNFYbGfSKohiuGwgS29jRjzjSFVVqlsVKgSuKX3zDAncTgPGPLNjcwS8TaD183jDmjLDm4m7hEcuC83UJ0PLUtNsY82X7/r+eD5wJuDS9rIWt0WgM6SAS6UJy3X7kPx626C4RG6y0nvpGobW0VR8FtYzaa5+h0y7
X-MS-Office365-Filtering-Correlation-Id: 056d2aa1-3b9d-4f1a-92f3-08d5bbc82139
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2018 07:30:55.1660
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 056d2aa1-3b9d-4f1a-92f3-08d5bbc82139
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR04MB1322
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add enable/disable support for switch regulator on pfuze100.

Based on Robin Gong's patch from the NXP kernel tree.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 drivers/regulator/pfuze100-regulator.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/regulator/pfuze100-regulator.c b/drivers/regulator/pfuze100-regulator.c
index 680f076..053eb1e 100644
--- a/drivers/regulator/pfuze100-regulator.c
+++ b/drivers/regulator/pfuze100-regulator.c
@@ -155,6 +155,9 @@ static const struct regulator_ops pfuze100_fixed_regulator_ops = {
 };
 
 static const struct regulator_ops pfuze100_sw_regulator_ops = {
+	.enable = regulator_enable_regmap,
+	.disable = regulator_disable_regmap,
+	.is_enabled = regulator_is_enabled_regmap,
 	.list_voltage = regulator_list_voltage_linear,
 	.set_voltage_sel = regulator_set_voltage_sel_regmap,
 	.get_voltage_sel = regulator_get_voltage_sel_regmap,
@@ -200,6 +203,11 @@ static const struct regulator_ops pfuze100_swb_regulator_ops = {
 			.uV_step = (step),	\
 			.vsel_reg = (base) + PFUZE100_VOL_OFFSET,	\
 			.vsel_mask = 0x3f,	\
+			.enable_reg = (base) + PFUZE100_MODE_OFFSET,	\
+			.enable_val = 0xc,	\
+			.disable_val = 0x0,	\
+			.enable_mask = 0xf,	\
+			.enable_time = 500,	\
 		},	\
 		.stby_reg = (base) + PFUZE100_STANDBY_OFFSET,	\
 		.stby_mask = 0x3f,	\
-- 
2.7.4
