Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751881AbeBWRAT (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 12:00:19 -0500
Received: from mail-eopbgr30108.outbound.protection.outlook.com ([40.107.3.108]:25861
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751702AbeBWRAL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 12:00:11 -0500
From: Alexander Sverdlin <alexander.sverdlin@nokia.com>
To: Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: Alexander Sverdlin <alexander.sverdlin@nokia.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, Steven Miao <realmz6@gmail.com>,
        Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
        James Hogan <jhogan@kernel.org>, Michal Simek <monstr@monstr.eu>,
        Ralf Baechle <ralf@linux-mips.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, "David S. Miller" <davem@davemloft.net>,
        Chris Metcalf <cmetcalf@mellanox.com>,
        Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>,
        x86@kernel.org, adi-buildroot-devel@lists.sourceforge.net,
        linux-ia64@vger.kernel.org, linux-metag@vger.kernel.org,
        linux-mips@linux-mips.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org
Subject: [PATCH 2/3] ARM: PLT: Move struct plt_entries definition to header
Date: Fri, 23 Feb 2018 17:58:48 +0100
Message-Id: <20180223165849.16388-3-alexander.sverdlin@nokia.com>
X-Mailer: git-send-email 2.13.2
In-Reply-To: <20180223165849.16388-1-alexander.sverdlin@nokia.com>
References: <20180223165849.16388-1-alexander.sverdlin@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [131.228.2.20]
X-ClientProxiedBy: VI1PR0202CA0036.eurprd02.prod.outlook.com
 (2603:10a6:803:14::49) To AM4PR07MB1316.eurprd07.prod.outlook.com
 (2a01:111:e400:59ec::14)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 79bc3cf2-13c1-4635-6e8d-08d57adee484
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603307)(7193020);SRVR:AM4PR07MB1316;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR07MB1316;3:7Q8Jh8QPnLmRs29Ipk1+WyeIYskGVh1MOLr/d51RyVl+Hli4zYTAXKnZnJCbQnQsIWctwE9x6C8+LfHeANpA0l4mvCAprY+kgdmBCzGSxBCNTosvPfxh9EGBkONGPF+BmviofEAk06moNFNDd98j1ple77PkXFmDhLYXnTC2lg04hOzQpuEy3s6kGBWarWzbpMCTHLABqiY4PFBj3GMt/OPCZl4QigxarfB9rqavxwjlXdZRQrT1/g6wejGWnxXz;25:rfJk7hwNw5R+Z2BYJcwezb5Tg49LS0v16gdpVDuxx7zAh2Iw7TWAH9jQIC4nWIzj0yzZrGId0aV966gnoone1mNljVGnhqo5qSG4btIlXwjzUyX5iEOboP6a+ems2KiyfystOwCwyHHekN+Ho2DGt+VRdJHC6sipZ8rqQISKTSDn2ZPG1vwtMYb0tPsoqRt6fA2jf4iSBCyOffXF/QHuuYJTgnXjM3Axt9S36SHDH81Au9U1ntU1U01EO6g/ueOm+UkwlMBeS7dK80xNxHCtilMR7rTe/B6OxNf0tRitw8ZZqZ4Qhih9YIiIx+paegisrVeXYo/sP9ZY6Q59QTyzQg==;31:BK0K15Rie0YWI/V7bZZ/A7fe7Jk8pdoyjDrzRiMtC6jJtJPyNwSJpOi1vuBV98ts4mN5r7U4A9Y5gRlBOJZiUhlB2leutpBRGuaNhkurK2KwA8ii7SZeYzTTqLGJcnxhXsLLm1xHEgzg81tjThW05dNiIVreRMGMjd5W6acSE1Nsu3exDpLwESqdIeRygv+p+DSkPPUvkl3V+i/+pBn2TdjrTL1cUxsAR9Si7O/V53E=
X-MS-TrafficTypeDiagnostic: AM4PR07MB1316:
X-Microsoft-Exchange-Diagnostics: 1;AM4PR07MB1316;20:ergzrdy9bFJTepNR3AVFpMgUbzzrfJXxK0Ys1YXMx3QXU8k4u61dkYI91mIRXpbcPtW7CV/o6HShh9D3K/ADtDkx5nQyT/7tVW7VF4AEQ2DETb8p8tTbbWOI9jL/lWnsBJ5CQFrcehbmxcNcCiL9GbBS/B8rTaNgK5qSamR0RR4RbN3jticmxkkMr7sFFDo+fYR1AQ/nfIWBGislBle0VI+js7vaVL8LrTAbol5V8s3TJ9SwFej5NGIfDRZgED9L7V7GqPc96d9KW/mHQUy27WxxuTIpJEAg7Twwmui2u+ba11BfsMQMsknLAAVOFspdcTOvqhvBdUoM0S0RK6Vdf8XyWtfUGOcKIawKpy1ZvIbUBP2XcPOId1+R1JkH7QU8sUnP2nBIlx8W6I8BSArVUailhNEBtvam/RNd1dgRhqnyGTvxGL9mzIWx5n4/K5iYJ2PW6yXD43f9EmhGjuEppXQojK3N9SD4U7NMe4Ai+OclZ4/Dzi71XUWrAgTqmOudFX54714NKmxKujBVe1o90Fnpul01+6wUQmEZ/KXITp9qvDqOZIhN10qULC+EI8FMuxdoBYYCZ1gdW/mFuoiKzELJFnylkw8n0jugfISc6IE=;4:PEcAxu+kFLBwQBVx1hs8vusmCPnbIwhb/RqQUNVfFLVje2yjsFpD+ZxUdqX9EUn/h+XkZZKWU5CDRgLMiX4bHWdCnn9xEQHxB60LcEVQ5i94hvKD8aWOgv0phcnt8U4QYNrvJVFZqRJAaK5eN7uHH6+BbFU2O0ES7KPWY59tX4d1/+PqBTYi9ME0EbnPTJGVJbVBRtJCErXdiXhf5FkaV/6qi60/FhjwEIrPzmk/fmo6Sv/Qzan8qBEs1bXchRFJV/PIIfRX3U281hqSYJVRtJ8/2wMORpP76uamq5qoDmx9kgwl1n3vQ7ccKldndkJq
X-Microsoft-Antispam-PRVS: <AM4PR07MB131606FCAC3F5DE6EC8D187988CC0@AM4PR07MB1316.eurprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(82608151540597);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231192)(11241501184)(806099)(944501161)(52105095)(6055026)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(6072148)(201708071742011);SRVR:AM4PR07MB1316;BCL:0;PCL:0;RULEID:;SRVR:AM4PR07MB1316;
X-Forefront-PRVS: 0592A9FDE6
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(396003)(376002)(39860400002)(39380400002)(366004)(346002)(199004)(189003)(52116002)(6506007)(386003)(7736002)(305945005)(2950100002)(76176011)(1076002)(7406005)(7416002)(97736004)(5660300001)(6666003)(6116002)(39060400002)(3846002)(16526019)(186003)(50226002)(105586002)(478600001)(106356001)(81166006)(81156014)(66066001)(6346003)(8936002)(47776003)(68736007)(26005)(8676002)(86362001)(575784001)(50466002)(4326008)(53936002)(51416003)(25786009)(6486002)(48376002)(54906003)(110136005)(16586007)(6512007)(316002)(2906002)(36756003);DIR:OUT;SFP:1102;SCL:1;SRVR:AM4PR07MB1316;H:ulegcpsvdell.emea.nsn-net.net;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=alexander.sverdlin@nokia.com;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM4PR07MB1316;23:2dQ9vo/Yb3QFqmThYwu36D/IP78Y83yUppaRD+74q?=
 =?us-ascii?Q?XIlkSJZsOnGeS1tn2JH3xuNk/vezro85EigYRNiZDM8YkWDoDetiATohQebj?=
 =?us-ascii?Q?9BjCgzppI1A3Y84cIOUxPv/VJa8ltZnlJML3oZmQG2vAivyCJ1mo6tpuorbM?=
 =?us-ascii?Q?dvR3NNHCe1ErETiwhZBYqvNpzzKbjUINBpqHABkpldzAkjLW7JSe+tN2maey?=
 =?us-ascii?Q?Ax6QYfMb8UmdJNSlDvUDt0Wuj35NwfnibxvfvDZzNshF5TqY7BG0vNMaPvl3?=
 =?us-ascii?Q?7P1h8WJ78HUXxty8jOzftZsrTO3RIwBv/E9b68yj+vzntU36TueIlCvoCPfT?=
 =?us-ascii?Q?RtLgtlx9cLJXsnUw4PU1I9uCaKXBaeMjhfzPXG4x3OF2EvTqtJ5sWGAOHen7?=
 =?us-ascii?Q?TeiziUySlJS6aFu5cHEOfEpjVYsz+g2D4ZzqzuTHeuJ5mFo0Zn+KER2vBhm1?=
 =?us-ascii?Q?gDIAD3hz9tS+vtCwnKat8qrir1r/5PSZolpX+Jpou9cSrWx3hWXExGa7DcMK?=
 =?us-ascii?Q?bEHQaVl+9pWZDVenMg3iMdSiTioLk3jJEYKbV5F2cW/PBFF5gyK7/xp4ejYy?=
 =?us-ascii?Q?Ey0OMczPZj9t1sL7a4hdBFBT3yPehxNg/Qom733gf2FGM9+qo79Wg2I2ngb3?=
 =?us-ascii?Q?XT8hd8zRF9Ksc17d3Eff9zTfOkNUzWM8ZSDhHSrc6StTAsf21+FZm2Eq1Tw+?=
 =?us-ascii?Q?9Jd01MY+9H57I9IbwQAzVx22xVYXgTeIetFaGC7wz7+OQ+/J6su5xZrW1sKO?=
 =?us-ascii?Q?s4fWovYAzerxyr/KlPQ5oDIJG4d7Zf1/IJOkSo5q+XItfokpQkOU57rcK283?=
 =?us-ascii?Q?rZwECGfMLMUiK+8f67dNLf58tHMUE0my/rR0Qcd0jCuwiKrmpH7kZNwHl7Hy?=
 =?us-ascii?Q?7t4zGUEqUDel1wZ6NmBKIkDid2jjo5621fk/ZnNvM7JAy5V4ccMcM1IYrRRN?=
 =?us-ascii?Q?VkmaZjyitSOIV84bs3aODo9dXO8wPa1/147Rybp9EXdZJO84sBudrHe/7JY3?=
 =?us-ascii?Q?tj+5tAvqESv2h2nI687xi+WodSUMB3CFWTx0Hu3x0dEtZ4OKcxSoxVVgZ9WQ?=
 =?us-ascii?Q?v1Q/dpjnheBRAvPLdXPjfrLzfu5HhIf7wMNfnnbfdEYGQBQEGHfUURLeByKF?=
 =?us-ascii?Q?eMJeO9ZkHOnwcvx3f5fzcQwE2CmbL75lFgOwS21G4WEJ4SmsJIz+IL1eLWdS?=
 =?us-ascii?Q?kugy2ORZ/s8Xjg7QexwGQPpCGbbcxcCMFYsrO4VK5/LN0ZFeRc6Qumw/yojV?=
 =?us-ascii?Q?paWAumB2BcIObPFCh0=3D?=
X-Microsoft-Antispam-Message-Info: FyXxymlteNzITjb92QjiuuuC/1tmTakZAIz+DfV2fV8pmI/BkeUoGN8F2pfjrF1SxxSIPB08BakhNK17gjVhvA==
X-Microsoft-Exchange-Diagnostics: 1;AM4PR07MB1316;6:3nHDfInwYhbdZr0yD6JjrbfAjnmwppmRL3rPQIf300ohaEItiwL4F60fGCqHsrweoB0Z/lMK7AwGkgto2D4GTwyZQjq/wQZcrxFCJ6a2P9KmFk7C//sa66S1Qsng2TnVfMMlz3gE+7M8thghu5/Akpdf9IGWJHoRya4kiiv+Z/zFNW2q4vWi8z5efsbSsp4D2wbMRUW7omFHHL1bauylocOFifozkAiDLoFUqyivPkfjNYwSn7o1JzNzDY7PZq81j+82+TlxdmU0fuLUMIyFNTV2l6copRaSF7D7uxD6lZ4piXfntcPG1sGgRJby5pUih8RZi9mk+DmBo798BG+o1d2c+i/iYd6qsj3qEh52KDY=;5:NuUUM4lvXxnrAr/nvFZbe6hLc/8lYUVzHSmfUkdZR+RiTnots5oXdnlBSYN4ZNFCGaz7CvfstGhG/Dl7gZtzLVwwe+t3bcubl2UARrm3+JGsrzU8GT9M+jnb+7pZLY+KzPSct6PCLpL5SHrQGCW36HhIJLY/TIiMC06uXfE0e94=;24:cGo9FHurz9C7iw443mL3nt650Cuv/3ltbhbfIoMADD+WeAmHPW23glaSXFZuCNtNKX/mGP3R8ztqAA8sZ5G3MDnBo3i2W4/AqNLns0uVl2c=;7:7sv+CWo1iPGqnnZFb1KUJ4CaqPwmtgJo79W3KITKE9Le7vF8xePJRVmaLyjWQNaZfhxSwdznxA0VfyGhM1BnQoSmgvuR/McB25O5b1PKHtqz8MbBo9qTSlGZ1Debmsp4X++RWVONODh6qgBXa1qZwQmeq/VoPKR/tS1OCGl0wxyAiufECzjKkRhQgB9CochzD5IK+88mS1Gn7Hj63kMxTO0XlNB2N3ByFLMyidTgrNmlzq4RJhRmpB0gImXA55xW
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2018 17:00:04.3036 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 79bc3cf2-13c1-4635-6e8d-08d57adee484
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR07MB1316
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No functional change, later it will be re-used in several files.

Signed-off-by: Alexander Sverdlin <alexander.sverdlin@nokia.com>
---
 arch/arm/include/asm/module.h | 9 +++++++++
 arch/arm/kernel/module-plts.c | 9 ---------
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/arm/include/asm/module.h b/arch/arm/include/asm/module.h
index 89ad059..6996405 100644
--- a/arch/arm/include/asm/module.h
+++ b/arch/arm/include/asm/module.h
@@ -19,6 +19,15 @@ enum {
 };
 #endif
 
+#define PLT_ENT_STRIDE		L1_CACHE_BYTES
+#define PLT_ENT_COUNT		(PLT_ENT_STRIDE / sizeof(u32))
+#define PLT_ENT_SIZE		(sizeof(struct plt_entries) / PLT_ENT_COUNT)
+
+struct plt_entries {
+	u32	ldr[PLT_ENT_COUNT];
+	u32	lit[PLT_ENT_COUNT];
+};
+
 struct mod_plt_sec {
 	struct elf32_shdr	*plt;
 	int			plt_count;
diff --git a/arch/arm/kernel/module-plts.c b/arch/arm/kernel/module-plts.c
index 3d0c2e4..f272711 100644
--- a/arch/arm/kernel/module-plts.c
+++ b/arch/arm/kernel/module-plts.c
@@ -14,10 +14,6 @@
 #include <asm/cache.h>
 #include <asm/opcodes.h>
 
-#define PLT_ENT_STRIDE		L1_CACHE_BYTES
-#define PLT_ENT_COUNT		(PLT_ENT_STRIDE / sizeof(u32))
-#define PLT_ENT_SIZE		(sizeof(struct plt_entries) / PLT_ENT_COUNT)
-
 #ifdef CONFIG_THUMB2_KERNEL
 #define PLT_ENT_LDR		__opcode_to_mem_thumb32(0xf8dff000 | \
 							(PLT_ENT_STRIDE - 4))
@@ -26,11 +22,6 @@
 						    (PLT_ENT_STRIDE - 8))
 #endif
 
-struct plt_entries {
-	u32	ldr[PLT_ENT_COUNT];
-	u32	lit[PLT_ENT_COUNT];
-};
-
 static bool in_init(const struct module *mod, unsigned long loc)
 {
 	return loc - (u32)mod->init_layout.base < mod->init_layout.size;
-- 
2.4.6
