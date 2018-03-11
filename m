Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932231AbeCKT1k (ORCPT <rfc822;w@1wt.eu>);
        Sun, 11 Mar 2018 15:27:40 -0400
Received: from mx0a-00272701.pphosted.com ([67.231.145.144]:43202 "EHLO
        mx0a-00272701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932139AbeCKT1h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Mar 2018 15:27:37 -0400
Date: Sun, 11 Mar 2018 14:27:28 -0500
From: Nick French <naf@ou.edu>
To: Andy Walls <awalls@md.metrocast.net>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: "Luis R. Rodriguez" <mcgrof@kernel.org>
Subject: [PATCH v2] media: ivtv: add parameter to enable ivtvfb on x86 PAT
 systems
Message-ID: <20180311192728.GA4076@tivo.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Originating-IP: [155.94.246.64]
X-ClientProxiedBy: SN4PR0501CA0045.namprd05.prod.outlook.com (10.167.112.150)
 To BN6PR03MB3026.namprd03.prod.outlook.com (10.175.126.144)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f5c5e7dc-157a-4406-e9b2-08d5878622d7
X-Microsoft-Antispam: UriScan:(275421118447822);BCL:0;PCL:0;RULEID:(7020095)(4652020)(8989060)(5600026)(4604075)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(8990040)(2017052603328)(7167020)(7153060)(7193020);SRVR:BN6PR03MB3026;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR03MB3026;3:O+vTEMbGI6c2K7/ftbtOT+jSy1c3R9W7DSkyFXnPHxmAr2wPtGG/3Ufu62zsgY8Vah8GJ/RIBbsueMCGyxpxgrKFMHy4VJo2wRnCCG1ta6eMhJLHfixJvVDfuDMs7jzu9mho0GfknbS2kXOKXlwlH/3nOpoQkoJMxTvgpYeOFl6eKVZFsE6fiMQ7NPPRNZGgNvxtzWGnryXarPuy+a+H6Iffcj8OjWI/OnZVzD4YJzQElyFWeMHYshEtCMCKb/TJwvYPAMEO2qL7+2ueZwI1An9OP56zzc4hN2Re4HYGg5Q=;25:KfAhjjQbikG3hytBX65kRJyF9mzT/Y1JCPXOk6sgOB67IZngYhUmTnsM0RRsmdSgkX4sR/csIUcWC8jHlWI/DYimxosksmFJfLRZ8q1hK6fIqYooLt4RB23CUr0x5YRTj9D8NCKSFDp9uSHp73k9LAiI7wdiR0/KvHFJ8Jlt8tGG6kpnA+/+sX7FlUTPFH6e7f3cNXiO7Lxv74VL0/df4+/8ideO1E94pVDVrG4Ubl6wVgs+tTTpHADepQYy0RK0fMwyEOaSwfAZ2iNJaCYCUsNth2AUqU/34PhSREbaxuVwpgMp7IaIQM6eSeZFuTJZbiYoGsF7jB1ID42QyP5b+w==;31:FZh/xLAo8QQ1izzHPfy/0M4BU/nyANB4QEbu/tg7iuH8RrcY8ZKpZYauUgcyRHCl5eHABEWuBlDaIjmpjRPFhYj1Tk06rVvi92ytwL/wu0yfJbs2zaKF2W899XYOBsv4reO9mbxq8Vd40rekqhpje7TJS/+kC5O0uHVWW3QMq79oZX6+ciAgzGNnedexeajtVYyruHenicB3JhmvCp9uANW3hCmZGSWT+/a9bd9K2UU=
X-MS-TrafficTypeDiagnostic: BN6PR03MB3026:
X-Microsoft-Exchange-Diagnostics: 1;BN6PR03MB3026;20:GW7K7zvjlHo39qLNPp9GGwXzcphvvrI9eSIzwW6Khe3oseeelqvKuixXG2a78aAf/s1Owle9ZcQXwDgZhN+ti3Ta0KktxOd0atuVQsw6DSM6uDBLBHh/FtAtr9uN8UY0k6QqDvM1frCDMDXDuhZWf8cTw/5JfruZMmKUUmuYs1URaGUTqOuL6YBsProE8tAgQQZFl8+X+DF4ZHGFXArwKCQt3IjTFfSnnvG0pkHY5fatG2jrpqlffCu8lErilk8RWH5ZCmmW8mDXnqZYoJfCAKWwbdieY919+Xg68JAoHR0d1KKC2mNmaYxEaw84MEGsQcmaK61ktI5uOay7yK2sE8BvgZ+bmbS4Z4aF5jfiLsO/ZPg1POC7pKLtmRqVoicK+YGPpXomjhwgmfQFpK2iGCUDLy1H8FG0H+V1oNPQI0sRSzqULHcZZlOL86iTsghLTYOi8acdeyxNkbR7LUEnDpQIGe3vpoozGoeI4rwCKnon2Cf9foQA213G1YPPM2iz;4:STZucKYfxcH39Z/fp3I6YatFdCCSdXC/xqSGpfiONft/+Ab/Ad+8uv2LqxtcYUHC6eD2yMoA1KFYmMPlIR490UZuqRqN0dJeB8vB+xD65QczJv02/mpQO4mJf1q9W2EgBNaCQy98N8/gSkoQaUCx3ujRerFoBnEEKt5sDM5Sj+vOEPN6kwGFczGRszDiP256Klv/LxYh2mjxJ1fJar3mef/3qXgZwZqEkbqzrMI/hWXylgjsQSGYaIHWTBk8VPd4XUeVvxoa+mkWrx3Wum8Ih9i2xEKTGuSNi4ZHr5hPq6fudZXGC2d5PNb9eAf7I2SFe36gjyVvVrzJT4lUWSn86zLkHPdAbLYQZ/V3brrAXOE=
X-Microsoft-Antispam-PRVS: <BN6PR03MB3026597683EC4A8C2DB38BA8D3DC0@BN6PR03MB3026.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(179259710895377)(275421118447822);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(10201501046)(3231220)(944501244)(52105095)(6041310)(20161123564045)(201703131423095)(201702281529075)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123558120)(6072148)(201708071742011);SRVR:BN6PR03MB3026;BCL:0;PCL:0;RULEID:;SRVR:BN6PR03MB3026;
X-Forefront-PRVS: 0608DEDB67
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(39860400002)(39380400002)(376002)(366004)(346002)(396003)(199004)(189003)(23726003)(55236004)(105586002)(88552002)(36756003)(6306002)(9686003)(52116002)(55016002)(69596002)(53936002)(68736007)(86362001)(58126008)(16586007)(7736002)(5660300001)(305945005)(110136005)(8936002)(2906002)(81166006)(81156014)(8676002)(106356001)(386003)(6506007)(21086003)(47776003)(4326008)(786003)(6116002)(66066001)(316002)(50466002)(33656002)(75432002)(25786009)(3846002)(16526019)(26005)(6666003)(186003)(1076002)(7696005)(97736004)(478600001)(59450400001)(2320200001)(18370500001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:BN6PR03MB3026;H:tivo.lan;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN6PR03MB3026;23:UiuQ5M/xzLfWBzTFRrsNH43sVDg2nsqO1q7OCaySD?=
 =?us-ascii?Q?kFYF+X7YtWw0Yju6cs+Tf6VpDv3tJQBHk852rAmZq/wixI2aOSricS6XeUCX?=
 =?us-ascii?Q?N0i+j5F1bAbi1zj+ixl7bZr/+ruYeZgOSBPMFm9UBDEJjmNXBVIEki+ac07U?=
 =?us-ascii?Q?bUm2C11eBEWG67D2UppTaW7YbBlFi9p7ergiLGf2zfenXdqCFV9jgjmIFiKh?=
 =?us-ascii?Q?fAbX66Z2zz7KhYh1E0wcayHYYPju5wuNC5hgYihzizqkxPWXVY5XKFsUF3bf?=
 =?us-ascii?Q?4zd+L38Xm7iMcydXN4GAd487nn58SIgfYa1NQAOEpOyVguV4wT/R+WkVaa6m?=
 =?us-ascii?Q?NgJNFtajL0B4J3ab5n+7c0uKoULhG3TL2l5eODM1lNye9Wr4iiblAYRQnbfh?=
 =?us-ascii?Q?NiS9tw+BbU1T4xZcR6qwijFg/kCGtEn31JKyA2bZGyg2SptRFVYv4DNSG5aV?=
 =?us-ascii?Q?yz1fQmmbfSJn9fjMNeyHtbiedJYyl14AmpjcAKrp2FgcIL7gSVE2xGBz7bUW?=
 =?us-ascii?Q?S0No43E6BmbDOIeeB7B7Z/XH1iqHjEVWiIwWevej1SCiE9JDPh8mtP88Qgjx?=
 =?us-ascii?Q?XzDXSYmCWKX0tL2FSwR9e5qSWnaBPD45gbb7DJSriXmcGtfSzAr46HaII9mf?=
 =?us-ascii?Q?B3hl3h3iQ2BhvT2XlY5g6fv8BZ8Z3M+LGW8r0Ibx12LrZAHJMhaaMP8VY4ey?=
 =?us-ascii?Q?xof4sJCCrGzG4r425eWlZ8/vzhxppgz4GMy616L7F9pGvGk6qZKMPVsy+efD?=
 =?us-ascii?Q?XmlbWQFgyTHWvt6L8lEOw5bJ/vraQ9qS5nfUnoLkQb5Fi1uay9BVKIakXvd7?=
 =?us-ascii?Q?1ioN0vY6KFqHdqdTTxeHT1fhu2vQClaQshH0twtIwaR4twhTL56khhXgEgJr?=
 =?us-ascii?Q?mUOUBf9QJ6MxXPMIWrovWIZ1xfBzRxcsDUt7w9vGrQTOSgcLQewpIiN+i+LY?=
 =?us-ascii?Q?E0Om74qcgrf4xk98lC4I42+TPQn6lVHHrlB9XvyQBColxMm0DNQYGSD/c9Dn?=
 =?us-ascii?Q?YtknNzcqxMMyp1USeeyjRTwsPxNsiOkPRf1BsxZw7TWr27FdeI9kHkx8dSq9?=
 =?us-ascii?Q?AEhXxuNPyJSKc9fkhfkhosddKBuc8VcUfEa517Fc8He/LG250nzUoudwxGwP?=
 =?us-ascii?Q?yqetGKKT9i+Rbz4NK4D0gmRnqQYSMe+Tl9Y8ksuISjuHjfZ/F7cKJdrC6Zy2?=
 =?us-ascii?Q?tGXW/kRWvJabCJVGG9p7Om8FxGaG6mxnn8dE/dkuMIBKtxWE+kRo32mI2To1?=
 =?us-ascii?Q?MaQk3g+ee3g9sEP126p9RafBjfqFBTXUYX2tkVXbSkS8R1wYP2UILrup8gFA?=
 =?us-ascii?Q?yp03OCfFdwQuAIrFtaNZJqMw8kVJM/SM2e3tcYii2MF?=
X-Microsoft-Antispam-Message-Info: Tc34/XXh6f9LiTwRcibuWCRQ880nbUSkSoHBZL1kq4pMwPt3kfI4Rv4exlPX+lNrsBNzQ6SMh07SVS598svCBdYbIgW9goM0ua3J5q1ALCEjbngJ3gZfh5zzRtEhvJB/atbks3VrL7XV0PyBo1M5D3yKFOudUVNSDZ16ldmFB33RUWIietRWilYmQzGgRr/e
X-Microsoft-Exchange-Diagnostics: 1;BN6PR03MB3026;6:+gvhD3+mwcuLw7VFC8Fqaacpi3SLCQNGMbBgwuZCp5Gkcy4EcjX52IAClKxCPqlILSvSXjN3Vq4b/PAfuJ+U4sFE3+B96tkDFaSzV17XUvICQjoV3MNdCw/4ny1VtArvAfeabU7MSbtDybGUgVIVq5YiXTQOHzzC3FQOX37szJw2aiKDJS46uJRv1JQawDzCKgffPf+3vhcR0V4fW5Ho6dp2m54XjY75hhbsFRrb1X9KIPf5HInTvHmkWzHFtMbBU2JCcgDcYykKZT2sRrbBPNw9c8U6EvvW0aMUACVODds7tVTHoTuqfgTYuh+NUztGYy70ZN/5ZpVMp4OoNbIOzNEYRsY6MxGqkSm0Ed9Ippc=;5:vd8YHpBsnPJ8m+M0H0fzQgNerLCPVVTU7Qg4NU8Lcgibk7szDz0RnxBsj0rBVAUD4ZExfAOwoqEPqX+wpgiMdsSXlbjIBFzzKJ1OOF51uDMQhh3lM92CQHLjdOfoLGp8d/XW31tTgZwRt8EkYIi8YeM5LAykshzLEdKCHM9S9wg=;24:C2Ie6QgvjASC9ER6WIqA/RiARfyvQaHmoTxIGuVLJ9uRJZMqK8ilC4LyoQgG2yNr5qM93+QKic1uukQoL6gV1BPWMSpTG8rMcIB31KrJY/A=;7:WximXmBvViq+GMn1nPKQOg9SG1M646EWufUUuh8YOYnnJn89bsg30ep+/zFG6stjbwodVeegQljUa0sDzuD5RoxkMZgERDN9lQEU4ucYC9eeZf8tJhC5FBH5mPWJPR8a0+Vn97vlJWjBhetHQajoSAt6SnC3dJ3POVSPLhqCKLPqRn26B4WrOVT2oeJFcPIhGwLdqRZe89kKir8hVpsfXcIrjLCSV102xZhDr7m+krDw+l1I/+nQtjYCblEhOF7R
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN6PR03MB3026;20:Dr2Lqo6z213R+tzis46OUc2J8xF/4EmGN9NSwEp72858BK3QOgCPCBpD/Qi6goLYqWlc/TYcqkVJymj8f+bbpX5OXjxWHwRlOa8YRWFVUjS35ZPOZ0nGUdGtZ/NZ8avb5x0eA14r9W08ZS3hBWqxfl5K3GefKGl8eHBJBvHM7BM=
X-OriginatorOrg: ou.edu
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2018 19:27:31.7267 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f5c5e7dc-157a-4406-e9b2-08d5878622d7
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 9c7de09d-9034-44c1-b462-c464fece204a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR03MB3026
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-11_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1711220000 definitions=main-1803110248
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ivtvfb was previously disabled for x86 PAT-enabled systems
by commit 1bf1735b4780 ("x86/mm/pat, drivers/media/ivtv:
Use arch_phys_wc_add() and require PAT disabled") as a
workaround to abstract MTRR code away from device drivers.

The driver is not easily upgradable to the PAT-aware
ioremap_wc() API since the firmware hides the address
ranges that should be marked write-combined from the driver.
However, since a write-combined cache on the framebuffer
is only a performance enhancement not a requirement for
the framebuffer to function, completely disabling the driver
in this configuration is not necessary.

Add force_pat module parameter and a corresponding kernel
configuration parameter to optionally force initialization
on PAT-enabled x86 systems with a warning about the lack of
write-combined caching, and document the reasons the driver
cannot be easily updated to support wc caching on all systems.

Signed-off-by: Nick French <naf@ou.edu>
---
Changes in v2:
 - Add wording to Kconfig parameter to memorialize the reasoning
   this driver cannot easily be upgraded to use ioremap_wc()

 drivers/media/pci/ivtv/Kconfig  | 23 ++++++++++++++++++++---
 drivers/media/pci/ivtv/ivtvfb.c | 19 +++++++++++++++++--
 2 files changed, 37 insertions(+), 5 deletions(-)

diff --git a/drivers/media/pci/ivtv/Kconfig b/drivers/media/pci/ivtv/Kconfig
index c72cbbd2d40c..e5ebf7ca145c 100644
--- a/drivers/media/pci/ivtv/Kconfig
+++ b/drivers/media/pci/ivtv/Kconfig
@@ -70,8 +70,25 @@ config VIDEO_FB_IVTV
 	  This is used in the Hauppauge PVR-350 card. There is a driver
 	  homepage at <http://www.ivtvdriver.org>.
 
-	  In order to use this module, you will need to boot with PAT disabled
-	  on x86 systems, using the nopat kernel parameter.
-
 	  To compile this driver as a module, choose M here: the
 	  module will be called ivtvfb.
+
+config VIDEO_FB_IVTV_FORCE_PAT
+	bool "force cx23415 frambuffer init with x86 PAT enabled"
+	depends on VIDEO_FB_IVTV && X86_PAT
+	default n
+	---help---
+	  With PAT enabled, the cx23415 framebuffer driver does not
+	  utilize write-combined caching on the framebuffer memory.
+	  For this reason, the driver will by default disable itself
+	  when initializied on a kernel with PAT enabled (i.e. not
+	  using the nopat kernel parameter).
+
+	  The driver is not easily upgradable to the PAT-aware
+	  ioremap_wc() API since the firmware hides the address
+	  ranges that should be marked write-combined from the driver.
+
+	  With this setting enabled, the framebuffer will initialize on
+	  PAT-enabled systems but the framebuffer memory will be uncached.
+
+	  If unsure, say N.
diff --git a/drivers/media/pci/ivtv/ivtvfb.c b/drivers/media/pci/ivtv/ivtvfb.c
index 621b2f613d81..5df74721aa19 100644
--- a/drivers/media/pci/ivtv/ivtvfb.c
+++ b/drivers/media/pci/ivtv/ivtvfb.c
@@ -55,6 +55,7 @@
 /* card parameters */
 static int ivtvfb_card_id = -1;
 static int ivtvfb_debug = 0;
+static bool ivtvfb_force_pat = IS_ENABLED(CONFIG_VIDEO_FB_IVTV_FORCE_PAT);
 static bool osd_laced;
 static int osd_depth;
 static int osd_upper;
@@ -64,6 +65,7 @@ static int osd_xres;
 
 module_param(ivtvfb_card_id, int, 0444);
 module_param_named(debug,ivtvfb_debug, int, 0644);
+module_param_named(force_pat, ivtvfb_force_pat, bool, 0644);
 module_param(osd_laced, bool, 0444);
 module_param(osd_depth, int, 0444);
 module_param(osd_upper, int, 0444);
@@ -79,6 +81,9 @@ MODULE_PARM_DESC(debug,
 		 "Debug level (bitmask). Default: errors only\n"
 		 "\t\t\t(debug = 3 gives full debugging)");
 
+MODULE_PARM_DESC(force_pat,
+		 "Force initialization on x86 PAT-enabled systems (bool).\n");
+
 /* Why upper, left, xres, yres, depth, laced ? To match terminology used
    by fbset.
    Why start at 1 for left & upper coordinate ? Because X doesn't allow 0 */
@@ -1169,8 +1174,18 @@ static int ivtvfb_init_card(struct ivtv *itv)
 
 #ifdef CONFIG_X86_64
 	if (pat_enabled()) {
-		pr_warn("ivtvfb needs PAT disabled, boot with nopat kernel parameter\n");
-		return -ENODEV;
+		if (ivtvfb_force_pat) {
+			pr_info("PAT is enabled. Write-combined framebuffer "
+				"caching will be disabled. To enable caching, "
+				"boot with nopat kernel parameter\n");
+		} else {
+			pr_warn("ivtvfb needs PAT disabled for write-combined "
+				"framebuffer caching. Boot with nopat kernel "
+				"parameter to use caching, or use the "
+				"force_pat module parameter to run with "
+				"caching disabled\n");
+			return -ENODEV;
+		}
 	}
 #endif
 
-- 
2.13.6
