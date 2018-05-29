Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932217AbeE2IGY (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 04:06:24 -0400
Received: from mail-eopbgr30040.outbound.protection.outlook.com ([40.107.3.40]:12544
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755026AbeE2IF7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 04:05:59 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com;
From: Anson Huang <Anson.Huang@nxp.com>
To: shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        fabio.estevam@nxp.com
Cc: Linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] soc: imx: gpcv2: correct PGC offset
Date: Tue, 29 May 2018 16:02:24 +0800
Message-Id: <1527580944-10043-1-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: HK2PR04CA0065.apcprd04.prod.outlook.com
 (2603:1096:202:14::33) To VI1PR04MB1326.eurprd04.prod.outlook.com
 (2a01:111:e400:5187::12)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB1326;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB1326;3:c1wTzYlD4ZVrM0zmy6wwCEMBLpAaqi2ZsvhKElBKc8sS/joRg7fd3lciQ722lGi9mCtLIUA5qX4cyGrc01WDt2CgKHu3hDkV24WqOxcrQqGFffRs2MUK7CK3q2dhv1FPsZWaqcmulbmiRnIOkf413cqmfZw8jDnX/0mja7WrwIBE3JhsRW5zMces8LgQ5fD0ji0rG3/DryrhrxKz6RkWeqodJi/yY/wa+9bCgi7v9ozu5HJtRYze7kYZtzryCZKW;25:kC+2RdQhkOdRUeENPmA6YE+z8f/ezL8GS9wWcDlRdM7/9ok0UVZ4MBc7d0RG9QGkCAmgH5UItZTs6+hQcXBplnNccdoYXQkDV27Dq1s1K+p652jFsT+AKsLWMHzy0mzVr/eD6mWNOb0KsBO2QpKK/VbMV54v/b5V13bFIV7Nk1dpH5rEwZnsdBkDxP7aIevsbdcGfinLxD1NCpPmmBWD7HNjSL9tygtXJr3J/ij/F1KxYFn9kbdZUEK4aHQgbEYOTyK5HUb2Me/i8b5yvDlYtOq8s0Jzd8370vMvby89DR9jFvAT7ivlaMtn1wp0cLus/40mNVZKCWqVFWBtT3JRew==;31:feEuivFf49O48lE2fBHg5C9Y7qzodzXrjnPWYnZ5n3453tv5PsfOeF7gIhs23DJPquZQTWpIpq9r+oFS7XJAKnxWD6UiUltFD3O9qq4IbtORC+3vc+aOFWisoRx+C1w8UHB5XWcdmrCTApBZR280vFTD+4cOHKPaDd8sLXeROYMpaRIUNfQ/36qcP3eb8hok4U3OmdYCD8njdw/yKgbNAqrfHZNqP19xGsGHuONdTEs=
X-MS-TrafficTypeDiagnostic: VI1PR04MB1326:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB1326;20:PND+xNj1iZ4PvvKMstO3/qXhAvCPqhW4ePY2B5KILTj0kIWZNMmMjjmF7NO+jUntWPqYRSXjwytNYy4uHoF6zipePiEHHycwdwLdi9L3MqCYMd7Vlmdz05Mo+DlkT5Pl3/R4GxpfsbHjSeC7Pv1kv/QLy7oH3zdH0QtJJGTqSV5dvX4I3orsysxinyJF9r+78AgT2nPTaMMKT0tZoPRfIkepDOzr4P0g9IgYptzEbex/MmW6OK1pwepxDsTtAmnB/uHI6WP/ngWlGKOH54ZOibRHwT1InJDUJasbmh2v6uyBOpK/svsogKmfzi4qkKtdrDCB24LVLK8/imLE2EaTwE+I13wBgQ0evmmMHjLqY2qYqZSHXAqCdtbIXhN3w8sIKVI6mOk3ZhS7d2pzLbva9VAYTlKEbbRfY4DGxEo5rymMcjUVIhRZmgeRgZZvwFDNxMGgDAVFBbP4LuBxGJf6J06C8HX+7OZheEOz0eJ6QLIhhF99Nge0rMe2njfx5ozt;4:VTfQ/0zA4PTKzLDFWxaaO4Nl9513hUBfhLStvWghiV088HC/u0xvg8s5eNu1fWZrJr7SC70yDb2/oflclgy/SUzjyPgvjHY/eq6T/Fx3yWzCjByixJOg2qkHPqx5RA4TTI3g1Wlh8tzX75sJk1Qobau/ZQ0lCnRwrDfTeHoybDBC+1c/z9pO79A8dOuDxYbeT2kUXOVukC96BOL0lSSuWPiyjOsJT2t4Mvx38bNA8Gdv90+uII+AzBzvEva/SMfOMD6V3miRJ3GR5Ao92x4rprUXoY8sMMnGaLm5axkSHmxIVV/fnQQlVorBgHdKINu+
X-Microsoft-Antispam-PRVS: <VI1PR04MB13268A9E59EF227A068BFFBAF56D0@VI1PR04MB1326.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231254)(944501410)(52105095)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:VI1PR04MB1326;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB1326;
X-Forefront-PRVS: 0687389FB0
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(346002)(39380400002)(39860400002)(376002)(396003)(366004)(189003)(199004)(97736004)(36756003)(6506007)(386003)(316002)(47776003)(26005)(16586007)(186003)(51416003)(66066001)(50226002)(956004)(4326008)(8936002)(25786009)(52116002)(53936002)(2616005)(6512007)(106356001)(486006)(7736002)(81166006)(81156014)(476003)(6116002)(3846002)(8676002)(305945005)(6636002)(2906002)(6666003)(86362001)(105586002)(1857600001)(5660300001)(16526019)(6486002)(50466002)(478600001)(48376002)(68736007);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB1326;H:anson-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR04MB1326;23:xfdIgqyttr4BdMHCn09sv2jMe3GNLCd2a0XFGekFL?=
 =?us-ascii?Q?YeO7J5+zU9o31fc7dDfcbeGcW2LLWhBa57JhdZ2WRbb7Zl4z3vcE56v4vBfh?=
 =?us-ascii?Q?4vpQRt2jt0OKMUJlMeRtv8ERvaWhSRjdV8/Tc/xMjDIrwPw1S5W1jRnDWwV1?=
 =?us-ascii?Q?RRt6Hbiiq/tzrrBsqtucIEzR2LZC+N00B6/BOCqMt3leugbx/+6h6WnAuaHO?=
 =?us-ascii?Q?B6A2TC8+ZfC4o8x/N8qozV/9gXMJ/uSE+FhO3ZXtJmfGpaPLdZXmER+f1PPO?=
 =?us-ascii?Q?m/YVVDcpVBSW6UclHtmNNoi180T3QBw2OQfWKM1xZJ/knCX6V5QmYMqKgfsI?=
 =?us-ascii?Q?RyiXz/3AcpWj0jCZngkE/zjtIlveo1+y9X/S0VWOUEpt/i+tuSuAwc8BzqkX?=
 =?us-ascii?Q?zFxgsesuLOPodHlJWNYEGo7aSlQ9uU5g9O87SMtLo4/7YlaC7WNwkKa0sliA?=
 =?us-ascii?Q?Wh88/U4lXkXoLVsO7vu2DWMi0v5y9vXoOfltej4ZwO8DlMOqrCz0WcAhiOPq?=
 =?us-ascii?Q?ccc3SKihc9DAZxh1f0Cn9uH3Xbn57jzafqEbGWuLFv+huNs+XUnnSGNt+Kfp?=
 =?us-ascii?Q?BQvB0jgZ1XGQoPCUW9u2sjSCHZr/NFU3Oi+uzJlwDpRa4Ll+dd8Ys8dR0I9e?=
 =?us-ascii?Q?XbgqeZJlM86D7pqKCuYfmXWCWnGaA5267nAam6nyllKolPx5BR045o7FcUMs?=
 =?us-ascii?Q?FkKwxREbw0pUwNuiaFaxEoTXZKyTbFrHhnbWYtlMdCIzyntjFAy8Ul7kG0vR?=
 =?us-ascii?Q?cfGLtdqmNFpI5zNaOmcY4zYh42zWhTJ4qOAtgIj3/+3/wPDSKN8SfhnnweaK?=
 =?us-ascii?Q?XMAYWnSjbGhchM44cj7OHptJPC1GayEeiIaXXPXZdEWawvPx/qFRMSTtcXCL?=
 =?us-ascii?Q?hpvbwP5nO6uQPzGJDii9M7DNEIRktbdD8ViIZ3WS8VEDKk8FGpiLkwJcIIs9?=
 =?us-ascii?Q?iAKrcs8S0Z2K6IGYhaPcGiistzKTlmi+7IfNgCAeFgOO77aIh67dlsqaWgpI?=
 =?us-ascii?Q?Cy3Z512nfeMHEjs3KGzkGcVy7mOR8U6UDeKmYIWeRZWhDKcjtDONfts6+XO9?=
 =?us-ascii?Q?r/alXhkBJ8ICegKxU8kONKXM5nHqJfBbvwKX823/Xl92QP5TUPOuiONrpB7R?=
 =?us-ascii?Q?dh9dpkeqi94WmyGtr+jBmhF7i+yj5i3?=
X-Microsoft-Antispam-Message-Info: IQ8iTm5iOTczvgOSMQRNb7HMdY7N6IRypSvok7pUrGBDKKSCaFMKIs0JgvAks9URJyIw1dEPJit66iXmS9z3nAcCTd8OlLbWx3ztwOR2oaOcbD2zUyX7v8WfiTDZkytYEFwQ7DqglvUBid/V6inSmY7E8/R/jzWLnuBaJgI0Gu4Rrs5Jcrefak+0JXOdyDKp
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB1326;6:nwHsjhiN9S1Ey3xopux7SpF7UqYaJU3vKLSx+AkaJYcTEg/pFkXDMdbzMbWMA56H/sGNOXz8HVUk00wtVigvN8Lk4iMWpfCbXUIwBahi65HF5XkLN59adVoULBklFqxS5BY5OF6Y8GB/ngcYTX8rNve8jDnh+AS+LEzakdIeLzZaSud3BILkZIg2hscE8yFGsfi0G+8JL4I/WqLWUfE3sfFa1DY9YxZqnH0heSC4L6ye37CUW+8EQXyjhRhHEa7trgQcAC2zagiAkE0RnnEkF6KgOiJKipM7nbQxZBnv6W3tNGqUju6BXz5mnOpNKiq2npBKy9UzYrdDJ/0IwSgASyvo9vG0f7csDdIkv0LI7IvJ4a9dndnx0wTujpKY/uYL0ml383orV+ZRd5BQTANHY663U6X/FUFvZD1cxfSKCwgxzls2EV1fxWvLuZY1N8pK0U1Z7J9Z2fDuzq+nA4TbPA==;5:SxOMaGHE1CC2b2a6p5iY2Jvwn6ySyvfJrSnRYRdJNQ7l8pbacrVjimAP+g19ubVRjDQOwMRwbpVQvVIeruyRjtSM//elPektzb3nXhzoXpaRu+JHqOI3DZILgRYvU3YbzfsQe/2mBNbD4foNRTzZ+DjWd4hpksiwtXI+DtUCHcY=;24:20qpm2e5peb9bg4R4Gly229PU+uUpFDTlS6Mf7WdV+zkuB6VzuMp5APIr/MT3WrSut9a+ceRGUEy43qFNP1IP4f32bnGQMH6gGV68I4iNIo=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB1326;7:bYuY013VbW0Ngu6O89qkU6DhFPT3Gj6PbnXZSarVSYHlZCmb5jJ61TQQvGGL/6zVwNY4driuBsjoNvy72CHEkzsyoTw3ONypgADZ+Sw2yqLILZvWhahoQo8o4m4/hprzK6XNnpz6RBiaKrPqkwOnLZRKdItug3Sirvf5jrVVUuwVNv+NtHxXkdVv6ZxKCLuOYwsBaxy0wE2gDNUW/4lChPulCfGwVYlNsmLxhT5lRiffnU0N9ZnmzZNuwJ7u5FNr
X-MS-Office365-Filtering-Correlation-Id: c6ff7a6d-e225-4651-5e14-08d5c53b00ee
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2018 08:05:52.8406
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c6ff7a6d-e225-4651-5e14-08d5c53b00ee
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB1326
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Correct MIPI/PCIe/USB_HSIC's PGC offset based on
design RTL, the value on Reference Manual are incorrect.

The correct offset should be as below:

0x800 ~ 0x83F: PGC for core0 of A7 platform;
0x840 ~ 0x87F: PGC for core1 of A7 platform;
0x880 ~ 0x8BF: PGC for SCU of A7 platform;
0xA00 ~ 0xA3F: PGC for fastmix/megamix;
0xC00 ~ 0xC3F: PGC for MIPI PHY;
0xC40 ~ 0xC7F: PGC for PCIe_PHY;
0xC80 ~ 0xCBF: PGC for USB OTG1 PHY;
0xCC0 ~ 0xCFF: PGC for USB OTG2 PHY;
0xD00 ~ 0xD3F: PGC for USB HSIC PHY;

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 drivers/soc/imx/gpcv2.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/soc/imx/gpcv2.c b/drivers/soc/imx/gpcv2.c
index afc7ecc..132c946 100644
--- a/drivers/soc/imx/gpcv2.c
+++ b/drivers/soc/imx/gpcv2.c
@@ -40,9 +40,9 @@
 #define GPC_M4_PU_PDN_FLG		0x1bc
 
 
-#define PGC_MIPI			4
-#define PGC_PCIE			5
-#define PGC_USB_HSIC			8
+#define PGC_MIPI			16
+#define PGC_PCIE			17
+#define PGC_USB_HSIC			20
 #define GPC_PGC_CTRL(n)			(0x800 + (n) * 0x40)
 #define GPC_PGC_SR(n)			(GPC_PGC_CTRL(n) + 0xc)
 
-- 
2.7.4
