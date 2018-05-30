Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968534AbeE3BeS (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 21:34:18 -0400
Received: from mail-eopbgr40049.outbound.protection.outlook.com ([40.107.4.49]:34197
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S968236AbeE3BeQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 21:34:16 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com;
From: Anson Huang <Anson.Huang@nxp.com>
To: shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        fabio.estevam@nxp.com, andrew.smirnov@gmail.com
Cc: Linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2] soc: imx: gpcv2: correct PGC offset
Date: Wed, 30 May 2018 09:30:42 +0800
Message-Id: <1527643842-17643-1-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: HK0P153CA0014.APCP153.PROD.OUTLOOK.COM
 (2603:1096:203:18::26) To AM3PR04MB1316.eurprd04.prod.outlook.com
 (2a01:111:e400:586f::11)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:AM3PR04MB1316;
X-Microsoft-Exchange-Diagnostics: 1;AM3PR04MB1316;3:uoikqG3HCnjDl/GZIsCw756MJD3Qkx+rPVtS/SqzQbVUPUEZxWkrmidGUEE9tnZcEO8tImoDWhRDs2aai5TN6WmPqRkUZXflfyRFv7LUuOchs8/bSe74IeRBwX4PNza07dlF1EZ14LSy60mH+7Na/62B5Li7I3187sQyQChDi8zc8ZvNq2FjEn0S5ZVCmhTRlhcQeXCceaPNGMmEuN3pm7uSIY6tisLmmVZo8Kb9vhuLRcAkgk2pq2r1JcROi7If;25:vFSEKiYA3fAM4mk8xuvWC/0uMu+c378VwFUk6TIBlVIsjj8IZxyxuNeRg2BQGo56S84Fn1i4DPOC199fKPr1s23IjXRgqdHH4dQLkZgguylS1jJ+9ZrGkjrK47rzOVLcT9FaQtLYLwmxJWPaMw1/M4hg+DBlVxSFcbr+xK9QYRzWhd+aH7fZ6+jZvLJYRhyyNdTn5hAcJj+CsaTPzWUdFBTw/UdEO4eMiOOEILOsc/2vAD8+a0UF8zjXGKiTBzataypL4UMeZ5QmSa9pjLHOmh0+Nf1ixYWRqHvklflphb7zVC3MVav48TmESFPQYwVteE0+BQztgcgXPLJjcRfoww==;31:Zc/UViKkZ0BSk3iLQgfXFBIsW6wBwSv6VxKFmrTFE8f5fBSD6QlDMoeANA2ePA3jPSgPvGfO9o0nqCr/ufmmMbhIvA5o5DSCi0B2HmVhwSF0k35wEdO80hVwYWNo+9eR8o4+STCPOJFp+z/ZMaSxuz9GESu5oX6Ac5fOWlb+w5WAEsSbRtBWbPfzGtiJYGdS9tulntEV1745f8oVqQOvuQuQfDUiE4m7mJ2vopFhcew=
X-MS-TrafficTypeDiagnostic: AM3PR04MB1316:
X-Microsoft-Exchange-Diagnostics: 1;AM3PR04MB1316;20:2y4Q7kjbpXz+cAD/boatVmqvsIKdwi9UimvKcGNSQL0oxqcQr+jGDfG1XBCYclkDxlTEOdlUhFjwgPF37gk9yHtSvgQ1nsC2DLbUP5VrDTaWZrnJm6b+aXzz2w9OgIn5fRqwv69osqgFg6AYSs/kpfotuh3DKMKFjV/It2uzG5DtzUDQjZrl2/btRVcQL8dax3WgTdw9CwLRXmMEWzdX78AfUia1ZqQCz9orxz9UFIgk1bOGzGfid2CvZXNdWTntEBS4L1EuaID0HMCYAULUvgmAW7WBzbPT7iSVhxJ29Vx66g1pNQyrYlZojGdXoAIzhv2y9azJF33NLuXzBjWus/Ye7p5qoDvOXAnXgNVUM6YvpF3l5WbV012Nrum/vkHd/gP2zR9nk8xkZLcPCdnfFtk3CH6xw9JCikwB/INNeoIRDGi3te2wNAxbjHmzUeOA3EEW/dZiJp1O8NGXDGv5QgQzN2nBDnvlvGFVPwJ/DXmQRbWcj9ebUYE2tniSuKRc;4:OR3AtAIH3l0o49IMNdvOkMZQqn/TCy9IHqfnYkGjLw4WhPjA4gjrd8y39QgPycif81QlRrPKuRroC56pUsSIclO1jFf9kXwcZUfGGc/4bHQdUl2qkB1/E7YwWQEMPkCSJvHITboVeUGSdTHhSY2kJzV5fXnkrGC73tMelIXTSK8OdZ+XMf6J2fiTnDc1DJLJ+p/iB6Z5MtmwClxHCmpx+TagHS/+lpn7nNEw7xT/TXowYKPFKhpd/FOFcGpyP0qKiDB3HioP+d8hih8oYWcn//euYaszzRMPIqH5/FVJMlfzvuAHpLggkBHuQAcUIfwVJh+BEmUTe/OYHeBbM0Bn6w==
X-Microsoft-Antispam-PRVS: <AM3PR04MB13161418BB433A38153D0CD0F56C0@AM3PR04MB1316.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197)(85827821059158);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(10201501046)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:AM3PR04MB1316;BCL:0;PCL:0;RULEID:;SRVR:AM3PR04MB1316;
X-Forefront-PRVS: 0688BF9B46
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(376002)(366004)(396003)(39380400002)(346002)(39860400002)(189003)(199004)(105586002)(36756003)(106356001)(6666003)(5660300001)(50466002)(48376002)(86362001)(39060400002)(16586007)(316002)(6486002)(2906002)(97736004)(25786009)(4326008)(6512007)(956004)(476003)(2616005)(26005)(7736002)(53936002)(3846002)(6116002)(68736007)(486006)(478600001)(50226002)(47776003)(186003)(6506007)(16526019)(305945005)(8936002)(66066001)(8676002)(386003)(52116002)(81156014)(51416003)(81166006);DIR:OUT;SFP:1101;SCL:1;SRVR:AM3PR04MB1316;H:anson-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM3PR04MB1316;23:SoAjRzBxsMl1c492eMZYhQJgHhkvnTsqimpvL9L8Q?=
 =?us-ascii?Q?dZbrlk0rIJYrmIA9Pi5reZxc4ADO6qqLQz2uy6GMAcOTTyQBCNJGuGy7G7aU?=
 =?us-ascii?Q?zy1YO9o7HpBtjEOCux+by2SzSMC9E3PYPiNvaZTgTmB9WdMVM70yn0V4j6zM?=
 =?us-ascii?Q?ah9qGaCPcZ6GOW2womUPNK+3sxFfiuIoo70zwy4CMPdw4vsHlXFI+7Z9w51L?=
 =?us-ascii?Q?10645/lkSQCQLa5dWNF7KJSQx0P7a4DZLwPW+/mEvJ083SLSDFKE7rZI/9n1?=
 =?us-ascii?Q?nUiF3fzO4KgNnsIJ3mzLcS7vXwh7WmV81Ha3IqGLkGu9S0yMyLtFDwvjUYCW?=
 =?us-ascii?Q?qe3T48hLmum6lkiMChw794TZ+1VBtRzlYMR6vLjaxgzmDrFS3rnMHXDE1OkA?=
 =?us-ascii?Q?ZPpMTMNyfB+6vHs8+/68qEOThfQWOA1sBe2NsJHtjVcfDsi7iFes/SUdGAhX?=
 =?us-ascii?Q?/y6p6q8JjlnVav+SJNkJAMliYPyggYbLgj/wm1n7GNl3vENxt4LlSM5zX2ot?=
 =?us-ascii?Q?ceupwqveJPBRY7tHU6ywv8YWtgTmVw5oCmhmnMRBPss6QbHBSWFR3BemK7LX?=
 =?us-ascii?Q?vBBL46pzoRfnWAbuPQ0uJq2rT7DkeMNAtZbTGMe+BmsmMuv6tr/S1PeCRUbD?=
 =?us-ascii?Q?ScCpHZYNb9nuze2Xr1Uid0/URoe7sz4fXHJspZrzGd/Qb3xbsvcw7TaRFLP/?=
 =?us-ascii?Q?g4FXysMSRaf8U8AWdK6STsUrPqyqAlg03aN7RAurocSiL9m8vrDmCgjcx9k5?=
 =?us-ascii?Q?c3v7JEnuVC2b4bi91DU2eCWY9Z0C+lCmHRIul2SofA4WYIwxGVD5AfVmoCWf?=
 =?us-ascii?Q?MSd9LsWt5KscnbvxYia799PpbAxdJILx6Qn/c189MVVMUlgtcLNg1HqZSlLT?=
 =?us-ascii?Q?Dv5qeF/j5LfgM0Ayhx1mqfrkS5yQGkr9WkQtX4WAw5+j5Jf+xdto8F0jNyGX?=
 =?us-ascii?Q?AWnQcVPkZB9pa+evAwpZnEhGpEx/s1MCdV9WmTnxxNIRHXq6UH2IKXV3PjIF?=
 =?us-ascii?Q?aGBJWqo+wxIMDF/GSyU7rWiKRoeqcXajGVgrP75t7dASnSIn6ugsvgdCfVq2?=
 =?us-ascii?Q?gmCFtWK0OVOhHRoSumlQozlB11xhJ8ZZkh8gd3zFZjOq71YZ50CXIQfECrcY?=
 =?us-ascii?Q?WHmuolO3YU=3D?=
X-Microsoft-Antispam-Message-Info: G/PeAMYNgLR/fBBP1uQQHA3thIdcsyrBoLbb2hMjmapAQN7IWN1sN2+YP3CcCIUsY2kqoWHucIXr/4g6jrqWFbnQsWnMt5R8wFjqk4+gcP5LeNeDZK8hS2kCjFNgtO/1WYE/OAdicELY9TVchTrXcLQjinrpTk+7kgG3W5/L5Yt37MhdhEOlJ4+9wTM5TDto
X-Microsoft-Exchange-Diagnostics: 1;AM3PR04MB1316;6:taEkJs7uvOPy09bYVsRnYKul+YrR54C65XC2N4SKWLDblQor7XOjeHvdImb/Ltk66faGFih245+88Ck6LYrr44duPkURaT1iJM8LuiLqQ1uKxljEQfIjCzjy5u+DXJmHzRkrhdYzC8fkfm33r/D0kk9uexmSuKsbLgbdnUZ7gVUlEYzct4/Cmkaza9U5tYlFp+G7/UtKR3rdszuQzM+TkLvchN7pcrZOYXNbyTWmkW3esJF3DIuSy1qvNqd0Ux8p/3nQSJohoV2+HvGC4NxW2NSpYEqPIeoew1K87m3hBPS5LcdgYpc5kksmYF1riVgzryYhH05qNa3YGB8gNS1fK9MJ9QxcoSCN5C+vkfPmNJlLX4yEe4HdwFtXcxEW+2gaMQmDuOX8CaxcBzhcbxk1Fdq+YcFtlRRccFaFpwLbWHJhCIVLWtpCIOm3wFwyXBEBS3dRuBpmzN2T/iVgLMIeGw==;5:g3ufIYgABG97CyckLsoTgGv7CTKeZlNCyTs39NWM+Jv1UYd03OrLFJqIcwRRGF5K9MmSwvuVSl3+ss2kEkSM/BNIfnJvRhXlSGa+/48aT7waNr7KjHnP+0bVUhw09I8CJ/aIzSrlfDnng9YX6HiCawv4duQB4ARq5RdJjPCTgL0=;24:D2ebVKg3NF5GjwWkWD4H2TCIP/CqfOuqrmaM+p77qGjzOZI2CRUuAK963ovZoRvKJ2fdDwLQBcNX+mf2QmKFtE59bGr79GeaKIxTwpoGzhA=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM3PR04MB1316;7:VksCDIwnjhOp+EXklbVbDCKs5WxTPpSkbxeEha5iaa1C5kv55KWmwKyEV4N/2JkWJ+wv7SGzgBnxqKdNsajsdU2BRFhPMR2FqHkb2SKIFXbh+v4CC0JzpO+34XR2mAWSpOgPbw/8QP6HAC/mU4X3sNP2R57f36cnvr6hxvITglcKr5XuxLjCYwk0h5J09+GgE7iR2zccEyaBzh7k0+3y+qQI71SWiDZh3vQDK+ZOp/X5n32Ex0QSGT24I8GJw+8R
X-MS-Office365-Filtering-Correlation-Id: a9e43616-721d-4a0b-455b-08d5c5cd72c8
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2018 01:34:10.1116
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a9e43616-721d-4a0b-455b-08d5c5cd72c8
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM3PR04MB1316
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Correct MIPI/PCIe/USB_HSIC's PGC offset based on
design RTL, the values in the Reference Manual
(Rev. 1, 01/2018 and the older ones) are incorrect.

The correct offset values should be as below:

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
Acked-by: Andrey Smirnov <andrew.smirnov@gmail.com>
---
changes since V1:
	add comment in code to make it more readable;
	improve the commit message.
 drivers/soc/imx/gpcv2.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/soc/imx/gpcv2.c b/drivers/soc/imx/gpcv2.c
index f4e3bd4..6ef18cf 100644
--- a/drivers/soc/imx/gpcv2.c
+++ b/drivers/soc/imx/gpcv2.c
@@ -39,10 +39,15 @@
 
 #define GPC_M4_PU_PDN_FLG		0x1bc
 
-
-#define PGC_MIPI			4
-#define PGC_PCIE			5
-#define PGC_USB_HSIC			8
+/*
+ * The PGC offset values in Reference Manual
+ * (Rev. 1, 01/2018 and the older ones) GPC chapter's
+ * GPC_PGC memory map are incorrect, below offset
+ * values are from design RTL.
+ */
+#define PGC_MIPI			16
+#define PGC_PCIE			17
+#define PGC_USB_HSIC			20
 #define GPC_PGC_CTRL(n)			(0x800 + (n) * 0x40)
 #define GPC_PGC_SR(n)			(GPC_PGC_CTRL(n) + 0xc)
 
-- 
2.7.4
