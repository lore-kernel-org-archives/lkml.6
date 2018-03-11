Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751278AbeCKAbu (ORCPT <rfc822;w@1wt.eu>);
        Sat, 10 Mar 2018 19:31:50 -0500
Received: from mx0b-00272701.pphosted.com ([208.86.201.61]:55066 "EHLO
        mx0b-00272701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751161AbeCKAbs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Mar 2018 19:31:48 -0500
Date: Sat, 10 Mar 2018 18:15:08 -0600
From: Nick French <naf@ou.edu>
To: Andy Walls <awalls@md.metrocast.net>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: "Luis R. Rodriguez" <mcgrof@kernel.org>
Subject: [PATCH] media: ivtv: add parameter to enable ivtvfb on x86 PAT
 systems
Message-ID: <20180311001508.GA13581@tivo.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Originating-IP: [155.94.246.64]
X-ClientProxiedBy: DM5PR19CA0021.namprd19.prod.outlook.com
 (2603:10b6:3:151::31) To DM5PR03MB3035.namprd03.prod.outlook.com
 (2603:10b6:3:11e::17)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0f40a591-7914-4070-cfd4-08d586e5285c
X-Microsoft-Antispam: UriScan:(275421118447822);BCL:0;PCL:0;RULEID:(7020095)(4652020)(8989060)(5600026)(4604075)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(8990040)(2017052603328)(7167020)(7153060)(7193020);SRVR:DM5PR03MB3035;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR03MB3035;3:9qxvC4kE0v7+H8IAIRUbQzvuD8Im5zPiz5mkDFhN6KM6Uvv3BftcZ51RUF4OMUIrSoCH/g/kqioODMZUnn4dRsFed/13S3WiVnIEqPLn6cTGZfYMrmoZtISjunWYJ4SDCvpJbi3W6KbtEbMNbQdheLIgJQGxporiJ7gsDp/fUzeJB/1EVAfm3faXoAY4o977cQdwXiFqJPPNVRx1p8/wfYEDIWmruLlZJlsO9QmLokiTJ+C1qsXoFiN+lIKxpiBbCYpLJDU+Rso6fGb0KA/MEDQJ7OpjYq2QolMvz8KSdKQ=;25:zWI4qhRdxZsAgO57FT/R7LWUILSiQK+P3IDrNMiBnlRh3+7Hdva6bbl6xLk+L9KCiicIhNzQa7kTO+8uGS0MUWUE3f1UmF3zr+JA7u08CqE4X2KMa8M6DgyegH/lzzxQ15PJomc1EcE4591k3tgDu4gkCCMPXideY0U7radede/SIqTi2xD6NV1o9d5qCz8J16nwl47+PUafQZDPBMSHi0jEd2uynjGcS4SkP6czQq75+xZrVX5uIHHYFZDmUpUOf4YKWTYmCCf2vmgK9BImOq8Z17Q/+c1V2/u+lpmr6jEYV7p5a/C3BKhhKIIAMt2tRYbgLLqqD1GE19cxPZk2Tw==;31:ytf9ogKaw6Asm4X93scRsG8omqU5aSDK1ZdjDoSj5+6LFUMbz4T6hkNXcTL8X2aT6VcS2Bddu26SljAXtWx1BkVnwv0ikACYzdgq13E/12d5P+hcjPa0XXrjrkFnN4p+7D0kwXgtOUjWSabcsTa+V1PKW8N0UqT30bvVd/FfAmnlbwZuZRjWNc1rgogicpkqmEew7FitrAg61X21M7X3N56GA0hQVUDAarj//tU23xs=
X-MS-TrafficTypeDiagnostic: DM5PR03MB3035:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR03MB3035;20:EbWuGZ7IxukkqkuWMdZROXw87t9yfgUmrJ5x6gMtqYf/MxOM3s6giq26CQ+LWU44yfu0nqk6nemIgA1DlJO+gMsTMXuwEdbxd+Y/y5ICpYM92krotHIF+sRVE//ehNd/ViD6VNU8dmodODPToSfBJyyi6+S6fkQ7TYH6FMPaNTQO2V1xx8yuNHwsjdyMqFriwSVpYqo4ULcoCOeFyuEsNeHB0EfX4AXyujzoLN35HYpKGgDJH3KXUj64otmdbwVaB1YofN6NGDE8UWaAOnbOrJTBFQ64dgsWtvimP/wf3U7j2eR4vhnR7qSP4x+sv3SAopFQLBUnMkOox58yZJDCCDAGyIhJ7mreinFSIj+Tc9RTmUMxyyFHF13yvIIGqtB/HElrYTEh8PXTZ0CaPP1QvI97ByLcIshjgLPlo3IqdG0uIP3+CL9QGxfYoA3Fm/+Q2Wo+pemJxaPRat6lQt/HSvAqIO4kYkd1dzzwQNis2QYaUD0/9S5cAaLCLd7T5+ON;4:qhiBnnU9OBSFPiIK3xAWARufqvYxDDKIt6hvtBxosjI+7MJ8ezaXnouVw/pwpkC6cOvb/4614IyDUG2HM9J/zYBlrco9hUN06b/+AcVLyB5Xb2kCO41FPFtgqK2N1Yy+SOqXlLXCcHSu9jAHvBD60V6+3kANN9Hjvsjk3juZpEi/08v+B+yzJPu7pXUlUAI5oZQD8ly6f0B0j1qriX5O5IrMCN8b59ftqzWIZtR2i0mLjzo7KjTcBQycvfas1O5e0t3jdOVXcjWt9KvBircSio1ZJuTnf0C3GolAPnbNmtEo5P+k9iv71R73pBsRQsO87Nyp3BnUnDoCweJd6LZeMkUvCdk74y+AH+avUvNvQaY=
X-Microsoft-Antispam-PRVS: <DM5PR03MB3035EF36C23109041151EF58D3DC0@DM5PR03MB3035.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(179259710895377)(275421118447822);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(3231220)(944501244)(52105095)(10201501046)(93006095)(93001095)(6041310)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(201703131423095)(201702281529075)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR03MB3035;BCL:0;PCL:0;RULEID:;SRVR:DM5PR03MB3035;
X-Forefront-PRVS: 0608DEDB67
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(376002)(39860400002)(366004)(346002)(396003)(39380400002)(189003)(199004)(23726003)(8936002)(86362001)(3846002)(6116002)(1857600001)(81156014)(81166006)(8676002)(7736002)(75432002)(66066001)(36756003)(305945005)(21086003)(4326008)(1076002)(47776003)(52116002)(7696005)(105586002)(106356001)(478600001)(2906002)(25786009)(55016002)(33656002)(16526019)(69596002)(186003)(88552002)(50466002)(6666003)(6306002)(26005)(68736007)(386003)(316002)(55236004)(5660300001)(6506007)(97736004)(786003)(110136005)(53936002)(59450400001)(9686003)(58126008)(16586007)(2320200001)(18370500001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR03MB3035;H:tivo.lan;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5PR03MB3035;23:45BGMm4uuKliirQoWPuyw1l6X6MrbTemjlrjl0yZV?=
 =?us-ascii?Q?bXqbPATBOBXXiNx+syeeMAVlvZaoMW7b7tXLwb7XUQBiEq8FcijV5RwAauzw?=
 =?us-ascii?Q?TPz1T4BXzrdSp36jy0hAESUzVaqmjciUMZajYouMQnJEx8qnH8/3ESi0JaGw?=
 =?us-ascii?Q?1be7hOEBb8DdvVDwtjufLPa64h3WOo32guKQX9XAfdnh3hl97fdWLrSCBELp?=
 =?us-ascii?Q?KVms8fTzKXUHsMwM7MY25lPtu8S659Di304TZD9R8kub/Dh6dkdDeBt/sWWS?=
 =?us-ascii?Q?fhfjn0Q0hyYKyNLV5moieWXq5hbPktzx7fmtUR1T3YSyW+BXsIGgjeCjqVQE?=
 =?us-ascii?Q?IJTr9MIb9ae1u6ScBBlu6bOU0v5Q/vhQzh/nhZmTfEQlcu5X1NYZYJQst8pM?=
 =?us-ascii?Q?erbTxzIWfBH9/E3JFh1ABXEF7gbsZohgfoV9MOPcn0C/rAykxAkRmonn2N+l?=
 =?us-ascii?Q?few2T3L5iYfwLU8ceuTKUMVzOCCmy6uX/1xINgwq+eiuWFrJd6XM9yCWce4t?=
 =?us-ascii?Q?dPaENr7JAUW0BCwkaNh49o1tOJ0yGbCa10Uhp2VqvTSD1iHq6avkCLtXE0vP?=
 =?us-ascii?Q?5fACoIGOGsuwy9AC9WGIZ/E9w6ttrryO91sjcdL0cT+WCeTYJxrt6ZD6UdBr?=
 =?us-ascii?Q?VznZEkMI1gQqV39qPXDcCft3v+YEy+fI15Bpz/HEGTu/Ub1AecY8sSTBa+xs?=
 =?us-ascii?Q?/wx7nJ5A00A+5VsauvmkN+9VOCwuAzMYFGic+VuAIucTbYfdhW5pGPecah3h?=
 =?us-ascii?Q?64RPQqCBhMfzZWUB74Aot0laCAHtqwZTHr2kXyNYUjh1KkpXZxb52TGtZNkL?=
 =?us-ascii?Q?QITPT2JSBBaHeygzSdIPn9gKLaX+xhT+TyO7MPLntlc+mA9ZnQXx6M3ljwZ8?=
 =?us-ascii?Q?FXL6xtxwwE0tQfIKh4XE2jqLYhdGOgHgsAXOzc6Eo+xkG67IeHb7xjQdh8i/?=
 =?us-ascii?Q?jAPfB0KWgXpcb01LkSNt8Qi1tSq6RUu0zehWrORXC+QgcmpMCobBcfBzduej?=
 =?us-ascii?Q?3SPClhwcSX1g4z66/QrvCcD2XLzmiaD+Yk7HTbUyvBbIVmWiA2j6Gz5S3RRX?=
 =?us-ascii?Q?J0Cq6HClvAXVUBRlYMkjSkfpz4xj+JIEAoGjf8AkoVX8XcGgtG8v6yffQxdc?=
 =?us-ascii?Q?nQICXUJsSnpQVCyNstLNSy+8jUbVk4jqVo8mOHpiqGumrostpIymXmoII2w8?=
 =?us-ascii?Q?LVjduHeB5uRL/qiGSveoCf9n2TNeEqqXIu3O4l7hNQOeXI5JkfbxBW8TjIgL?=
 =?us-ascii?Q?Wl/mb7NUOuO1SNhg3SUFyKgjJ5OCbW4dGe11IBvTlw4Pdjs6QFZMtgu6SfkB?=
 =?us-ascii?Q?ATxt9lRaBvNu66wjEjTua0AdbsTgX9T7DHjPi8TYUXXm3cyZoKRShzFDRYgU?=
 =?us-ascii?Q?uVUqQ=3D=3D?=
X-Microsoft-Antispam-Message-Info: vuxKBShxGAJSF7cSZClb0tW9U9PWdnS/R/tzR0uh+WL9/3SwinWU1V4OeaxmKt0RCuOnXyIiZsveRvBYlA0StbK6+Tcc37jT2vPS4688YRyqGib/KstXg8EGKtxS7qFeVDYQj0P5Qa2dzvPtjI6aTOcSzrAFFcprgZsj+tRzrheWpK65f0VxfLlU9UkMGizY
X-Microsoft-Exchange-Diagnostics: 1;DM5PR03MB3035;6:2WC2edyEbLodEdEryWn2+uMIrpVLfcWiy/vAfbWB9y2Oc9oIYWd9fWegZmgR4KCkrHfrAf1TkeBwKxbqrf3BoeV6bGvIaA6Y7U1vyDDw/UsbcnEKx7zfCQpbdgIr71BlcGw00T95w2EbOseKMQKn4BiUVaARniOYpTqzD4c/EkhaCbCkpXN2rj8if1qRND50v2sZ4ciVt/t+3s5QaDx807d6ELzj72mgHbBaUVOplfRxJBNrjOBXPyHy6TKxPtslBXp9VqCDG7zIVB/UZwIyHo/kRBpLm39xpIi7ZnicgnWGbsqKtv11n1g2rolIcSzr4Dn3BNtQR0kucdS4ucmQdSFKJrfVidDouGtMuYO+vsM=;5:PI9JHmQzFE0J44igaoMAP9fWwCIAOMG1HS8j1QD7FwW4cMi0dQk7sZdBPgE83GgFhVvMW5UxEH6yO0iTz7TwRz4JpdYa4rP+6PNf570T+ev73EX1w/GSygOlmpGWxB8KzCN/4+WumcZMrWoatPMrnWiziS68Ov4uCazry6bBfoM=;24:RMxwpn928S7aqH7ZGqdfSbfjSvr9MO/TGg5OM3IW5ifaFlLiJ6BGJv+wrRkJtu0TNa3zhD4q1W8YC5nLgCvz3WqG9iT47fBFWQ2QUx1ZWN0=;7:Z+BszWtifr8PMcX2C1rmT/Zhiweeu9dOL6M5mhO3gMQZvItSyxBlatVYfusjVK/SQNA1mgZuOHd94lOZFK9R1gNbHIlgkVOaUda/DOSKeqoepygVe2YHBb21OFw8TjPgDbB8jlemxj8F3eyulkYtKbSQqeMz0XO6+rzYPi24GRSeZKngXz10gzfuP+oViipeSu5Xv2ZXAzsytdghBsNpsKeg6iORrfQnyz6dZOyFV0MU0YCDGgEEXQUxBdHgUdEw
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM5PR03MB3035;20:jwq0w/il5+YDcBA9vPCna86YEgE3YeQlMCddxsZ1EOjU+noWuMHro0V3BIRQ2ZD6jjngCilm8do+vQrxYY4Rmlz1aKm8LfPzRVxoJTsv90yDPpsRdUSqzWNv8835IR/qCSc+zgm5KuYEhcB4qfOUXwJOEXkdfICwJOWDFornJHs=
X-OriginatorOrg: ou.edu
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2018 00:15:12.1847 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f40a591-7914-4070-cfd4-08d586e5285c
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 9c7de09d-9034-44c1-b462-c464fece204a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR03MB3035
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-10_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1711220000 definitions=main-1803110001
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
write-combined caching.

Signed-off-by: Nick French <naf@ou.edu>
---
 drivers/media/pci/ivtv/Kconfig  | 19 ++++++++++++++++---
 drivers/media/pci/ivtv/ivtvfb.c | 19 +++++++++++++++++--
 2 files changed, 33 insertions(+), 5 deletions(-)

diff --git a/drivers/media/pci/ivtv/Kconfig b/drivers/media/pci/ivtv/Kconfig
index c72cbbd2d40c..9c63370ed721 100644
--- a/drivers/media/pci/ivtv/Kconfig
+++ b/drivers/media/pci/ivtv/Kconfig
@@ -70,8 +70,21 @@ config VIDEO_FB_IVTV
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
+	  With PAT enabled, the cx23415 framebuffer driver is not able to
+	  utilize write-combined caching on the framebuffer memory.
+	  The default behaviour is to disable the framebuffer completely
+	  when it detects PAT is enabled in the kernel (i.e. not using
+	  the nopat kernel parameter)
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
