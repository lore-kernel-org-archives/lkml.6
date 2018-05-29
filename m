Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966502AbeE2TkJ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 15:40:09 -0400
Received: from mail-ve1eur01on0055.outbound.protection.outlook.com ([104.47.1.55]:44901
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966034AbeE2Tjh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 15:39:37 -0400
From: Leonard Crestez <leonard.crestez@nxp.com>
To: Andrey Smirnov <andrew.smirnov@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Lucas Stach <l.stach@pengutronix.de>,
        Richard Zhu <hongxing.zhu@nxp.com>, linux-pci@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Anson Huang <Anson.Huang@nxp.com>, Jingoo Han <jingoohan1@gmail.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, Abel Vesa <abel.vesa@nxp.com>
Subject: [PATCH 1/2] reset: imx7: Fix always writing bits as 0
Date: Tue, 29 May 2018 22:39:16 +0300
Message-Id: <c441872d7dd355ae09e945447441389e93e3b888.1527621510.git.leonard.crestez@nxp.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <cover.1527621510.git.leonard.crestez@nxp.com>
References: <cover.1527621510.git.leonard.crestez@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [95.76.156.53]
X-ClientProxiedBy: AM5PR0502CA0013.eurprd05.prod.outlook.com
 (2603:10a6:203:91::23) To AM0PR04MB4289.eurprd04.prod.outlook.com
 (2603:10a6:208:67::16)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB4289;
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4289;3:AVRF0EpeHS3iFuEawDyEkXTDwZCC3r5QIx6gD4l5j2asUUOb/eyucvY273MwGAvRuFb/lo0onc6NNFamKU3x8Dw7IN5DloyXLcOG1aOyRPrtrxHaR/IsgGl4VxHeBLpMyb0L7q6alI8dftIUSQLzTuoqwAznEDSYY2JQTS0MP0p0vd0vFKIN5r6MnG2symXF950UIyT4qrb4IFEFwDigfI9J2BjIFzpalObN5cj89etxqb7ktIyCzfCEvLqVm3qm;25:0d5lK25W2zkrmMpQe2uWGoLwxdNqWmk9ERaMB1nx+yYxJm+qJd+/MEP1/jpJIlLMlm2GG6RN1AxF/uWePt87aGYEgmPOYtAH/KTpF1uNH7FswwwZb+DHXXDPeyWwiBtDoRS6jFg+pgcwLA0Kg+GSLCiQjDxhtDvnOKX4yb5LA0kbHzzOTJNP5vD6S1Prz/3Ix4PRsWUOeod1PyGjo78+U2XJ7K0l97dnJ+egqoTIOyt5MpJaYnGMTM7gTigQz+PvSb0QlN1HkzsQWIYX3WgAs6V9bVZldzMqNW1WKZAXEZ65lzTxt8E0Woi3t7xpNvqM7TMIS66J8hwzAVM6m0EcdQ==;31:TtHCaBCwxMfUBNAKC9tJWwukWjFpQIfEn2GRDp1f14h7hNl5x0BdWIEER6CpF61u4lp0wvOzecr0snkgwP3JTp3ipL9RHgNkI2yhSC1U11FVmFTPrdS5UxOV93wLOJ1/yOrwRiq/i2xuKU+ieLfpIdtWe7TawKm9ls9s3Qrf7CG5h4+BWNCVFpKsF/FDE5ZSyI5NnklcdePN5GQ1gq3HqqeHzufShOMn8fN8BznQKxA=
X-MS-TrafficTypeDiagnostic: AM0PR04MB4289:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com;
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4289;20:vo/d3k4p8Qt6ToefOIlJoSLHbZqgAJF3HG3bjp2MEUAW3YIiKeAUsnYAJzl1BJfu/GV9vOH9jveLIRibeFAvDfROB6vJynmgNSXPNUS2judGvMdUz1X/vPxdjnh0MhZlotVwJqb6kzJqdZZW976obpQcEEtrDfpfWzKj3Gn5g02stnVTF9DTts5PiwhZ/egbREhmdivfKg+qid8udshko2wMRj4u+PA/ubl2HXRALO3gSnxRMjzSdW/YdaWWiukLraF0WPmGAmlWW+Ll81jSg9qvdicHpYs5gtc24ULH10VnlSAecjp8j0HXXPyBX5wsyf47aZD9sZT/Y94rHfeqkJfNpsMDWTeyqnxxqbWD95wEjNXi4eFvGw9P9WhQOySo95CgF94HqVqu0xFyJ3DyF0XjOOcCXeKjs/PYgGkoakwIYev7swvF6axwWPFhdwSSTzesGNeuw36YwqKLKXlOz3hN/H+pw2x4pLkzR68y8hUXh2B6NAVsb5/X75i4LNCo;4:wrPqkGZxB56A2ZaMrPvC8oyezHSDQ8fmZB6GVqLDtJJFJyShdfX9JCP5H89iP9r33v5P9liWlUqYnzmLSYdgVsZWa5b8dCr3mLBPMTYfByBXnwXEU3OSipXgwrtYHHSGb6iylYSsRBIVHK3CekapalmPMs6sM6/ACWUTK8cTZORA2pegVyyZ3WTDrYN0+VPM/GCTki10ECnOf+/7Yjj2passA7B4KqKZy0mTvMcTgVO3puOH0Ea23UnqGCZrUsidlckgaBV0tZa+Ny3xfW9DD2oxgbJaq8FzXdl19Ok5baIUE6JVauN6NimJK/yZhYb7
X-Microsoft-Antispam-PRVS: <AM0PR04MB4289BA281DF6440BD33AC70BEE6D0@AM0PR04MB4289.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(10201501046)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:AM0PR04MB4289;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB4289;
X-Forefront-PRVS: 0687389FB0
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(39380400002)(396003)(376002)(346002)(366004)(39860400002)(189003)(199004)(2906002)(3846002)(50466002)(16586007)(48376002)(59450400001)(8676002)(81156014)(105586002)(106356001)(50226002)(476003)(6116002)(86362001)(81166006)(118296001)(305945005)(7736002)(8936002)(44832011)(16526019)(186003)(66066001)(486006)(26005)(54906003)(76176011)(36756003)(110136005)(6506007)(386003)(52116002)(11346002)(47776003)(51416003)(446003)(316002)(4326008)(25786009)(6486002)(956004)(2616005)(6666003)(68736007)(53936002)(5660300001)(7416002)(39060400002)(6512007)(478600001)(97736004);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4289;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM0PR04MB4289;23:pxGhje6/j+evgjKaZ9182l1vfBxvK1rDiBH1+iq1Q?=
 =?us-ascii?Q?E0IpepUHYnmVEl6fTw1vaQTgaOl86sHJHn9baB9wMkwyNvx5rFpWtxpDn0oG?=
 =?us-ascii?Q?f/7Dup8e8dGCT7s3tCyJLAwlKT7VJ9BQ8/9aSk1Jmg4MMN0Vpy+f2JXnV8TS?=
 =?us-ascii?Q?U9w+f4GKrpWkp3MlzZgCPcvtIGMLkUrihvQyTi/O91WOinbIrJHkIF4Wrzxv?=
 =?us-ascii?Q?uHZYg5sVD20U/SQ/DLNyo7tLSdYTKSNb7B7V5P4Vc374daqikmWpNm3gcYyZ?=
 =?us-ascii?Q?oCJW6ZKu+j28JZjeQ5hUzxVxa+Usj8/01BjAjq4G/kZDVt6JNgv1i2q5JcoC?=
 =?us-ascii?Q?D10bJzVshNW5t/QKMToQkKc2VZUWeZva3Q1ey4/T8y4KqGBhTpYrXw9JWfdZ?=
 =?us-ascii?Q?piqP1Qy1rFTPVU+JqFiRcPTQVgG6i8mspWZ6cjxGYwiLu1nIE29qKW9LIvX4?=
 =?us-ascii?Q?c0f4rxwalLv2WG/Cu3hPJp44m6S05Y7Dh86IU0YNsUZDkTE16AA/CjWckWXQ?=
 =?us-ascii?Q?dfWxEct6xQLqs5KJL3kcZAHrDTnDHNcoipqwx4dxIxyTklJUgzN4CGI6nmL1?=
 =?us-ascii?Q?JzHa6o8Iubl80PwNEDMuoc1xEggC+62PFJauqFWlqHxHrzBIQI99AY4KpRYC?=
 =?us-ascii?Q?KjMqnwU77zhxYoq1ep2UWUYgN9lbjzpyhxHUsz8pf6TQMLKFztTfNkIqu8c/?=
 =?us-ascii?Q?DkCnky2f8Kzb+keV5uuwXQ0b823dNaZoIcE6amKpRvpwBsI7rpJYuSpbznqJ?=
 =?us-ascii?Q?VVXgYyj4KUxxhf+4J/rp/98en60zrzb0J6cs53Ysm/YPDgHOYI93E2LOegYk?=
 =?us-ascii?Q?p1DrKIeRn+o8x1oQ1ZzitxXnrmZw0eTutZis05KgEQbFbxRLsKiyXUnrF8HX?=
 =?us-ascii?Q?f9mW/b1lhvR4lQdNJsDwNzYT2MgBxGYvDURL1mAKNdNn7F8isLhTSFUNp+0H?=
 =?us-ascii?Q?nsIOVMnJyGPHT+NsSrIYoIMF+hbjg5Dj6mx5sPPezr1+KoaWqIU4+QsXgiYu?=
 =?us-ascii?Q?zGitaXOGBo0QgSwCoHQSq3DpbY3njHDYBurxVxwK8Uh9h3sCLunxc5OfKLz/?=
 =?us-ascii?Q?Pumk6kz8w2/QbCg0irXFD6fUqmwnpo0J12HvQU3vVwR7Qr9xsnGemp//9Fgq?=
 =?us-ascii?Q?Kd2gKfksoYXWvEFKmpl2NvnJNIFOcfvHz405uUn3iFSNTUqsloPnGPmVoorb?=
 =?us-ascii?Q?zgUa3KRkFKVOiUok6unH8kcR8AnKxTpfJAIo49bkYugorbhqsXKegHRI5/vb?=
 =?us-ascii?Q?+23athijLQybOPDGaod5eXnIRmBLQkjfWpuVrIbVC/ytMH3oG8HrL+Zm4QPZ?=
 =?us-ascii?Q?C+MSoZ+x8aZ8pvxRF0DRsMyvfKZFCr8vwiEp0Ebrm4Q?=
X-Microsoft-Antispam-Message-Info: CwfydNASLgn+gKjNFOxKsn8cqmh18k8VnT+WhITWVOtqEkj8oO0xNUtXQ4PIIw0U7OTqwHEKV2B0mjp1Bd7qRe1hTR4cZsnrqiQsC9Ixd7WIU5bnR60aj0ZM3LuYE3e+SLxS/iDQguOzc9p8TxqmPTAYm1wi3R8H9hTxLOLOxfU43cW0x1HAycDT+7EjgS+w
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4289;6:AzKlS43LhBob2uXWDtnxeHLF3ibICotUvUKn3mQ2yZECvgcDTG5MX3BRMpW2d8R11HNLjc+V6RXH4jBTx9EHSPCaYhKXLzCpz7DEyUrBWxayTh4BDwPk6jzZM5RivHmMzOU0kR43kJfueGc5EGYqYwrStLRQ5WkEvG9sT9OgrQbwo5FdPRCl+vlS4MCWzEffMRQ4k+jmnLu2cEfSjiDWAm89pIJxDbh1QTy9Cl/n5Ys0EzxQLI6oKJJKbzYVv6TVVctiEl6ei/If+AJFBKTqvuf29DSuDEhzIEC4rvi6lqb/W7i+n2+xY5sxFT2suDQnUBlj4ZHAfSg7qTCY5cpe7cvSBVNvOVxiRhjK4HDcy/aiIWmBUaCjRGFhQvxR461ifzciQrv2JFv5T63VHqtX3hn26uxC5Us0Yr4ym6qS4Pz9AafAtPoSW1GiiueCf9RcgPza5fR6SUC6QgI8UTZOZg==;5:BtxjbKJM3zWlT6ieKxzJhQo1wPyeAk6drUrHtELx4+ZfeNyt5osdIqi034as0vZhJR4F9B7IJO+EqtBTuU/Ivr1KWQ2l0lvQOQ0pV1+j4aqKwOPBDNIJAiUqM6K4vMiwCbBSvfCu/auwaRhPy+/ExiVSfBgm5esycq4Csc3vKFA=;24:CQM2Cocw5Rv7x8uHVB8H7JrEhW34OHWAoiBIm0EsE3UNs7V9x4ljZj6x/Ai9JyTEFytAd6Gj33hNAsQ43R69WMvau5CzUVl9qHv5MNra15o=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4289;7:iHQS4x0ppRK4Cm/uXfsKZcl6ZGjjk2EwHdX7ceewfTI29/9tP4IWldF6/UJzpi2Hu+tFvKv6cIJFhPOysUuypP9LVO9oiX9thZEre74VpiJE5SZjLaMCTvKWi9O9ifFOm8eiezIN1TkHbCbvN1hZquVaQ3UlcYXsZJCL4HsJl17G14BSP2xY6AFunflZUdxHQE46UJtAQA6/swnJTGbUTtvM6q2Q2Z4/8KSvWXjBuNQ55n7H4x186GfqmXHWmBeu
X-MS-Office365-Filtering-Correlation-Id: bc73b204-16ee-41d6-5a15-08d5c59be7d6
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2018 19:39:33.6135 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bc73b204-16ee-41d6-5a15-08d5c59be7d6
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4289
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Right now the only user of reset-imx7 is pci-imx6 and the
reset_control_assert and deassert calls on pciephy_reset don't toggle
the PCIEPHY_BTN and PCIEPHY_G_RST bits as expected. Fix this by writing
1 or 0 respectively.

The reference manual is not very clear regarding SRC_PCIEPHY_RCR but for
other registers like MIPIPHY and HSICPHY the bits are explicitly
documented as "1 means assert, 0 means deassert".

The values are still reversed for IMX7_RESET_PCIE_CTRL_APPS_EN.

Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
---
 drivers/reset/reset-imx7.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/reset/reset-imx7.c b/drivers/reset/reset-imx7.c
index 4db177bc89bc..fdeac1946429 100644
--- a/drivers/reset/reset-imx7.c
+++ b/drivers/reset/reset-imx7.c
@@ -78,11 +78,11 @@ static struct imx7_src *to_imx7_src(struct reset_controller_dev *rcdev)
 static int imx7_reset_set(struct reset_controller_dev *rcdev,
 			  unsigned long id, bool assert)
 {
 	struct imx7_src *imx7src = to_imx7_src(rcdev);
 	const struct imx7_src_signal *signal = &imx7_src_signals[id];
-	unsigned int value = 0;
+	unsigned int value = assert ? signal->bit : 0;
 
 	switch (id) {
 	case IMX7_RESET_PCIEPHY:
 		/*
 		 * wait for more than 10us to release phy g_rst and
-- 
2.17.0
