Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751425AbeDCOCp (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 10:02:45 -0400
Received: from mail-sn1nam02on0058.outbound.protection.outlook.com ([104.47.36.58]:40658
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751233AbeDCOCn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 10:02:43 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Yazen.Ghannam@amd.com;
From: Yazen Ghannam <Yazen.Ghannam@amd.com>
To: x86@kernel.org
Cc: Yazen Ghannam <Yazen.Ghannam@amd.com>, linux-kernel@vger.kernel.org,
        bp@suse.de
Subject: [PATCH v2] x86/smpboot: Don't do mwait_play_dead() on AMD systems
Date: Tue,  3 Apr 2018 09:02:28 -0500
Message-Id: <20180403140228.58540-1-Yazen.Ghannam@amd.com>
X-Mailer: git-send-email 2.14.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [165.204.78.1]
X-ClientProxiedBy: DM5PR16CA0002.namprd16.prod.outlook.com
 (2603:10b6:3:c0::12) To BN6PR12MB1553.namprd12.prod.outlook.com
 (2603:10b6:405:4::14)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e611f79b-c582-4227-1bed-08d5996b90a4
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:BN6PR12MB1553;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1553;3:ZfHvoxiaLPVVpCOwX0XhbsM49wLgnaRG3WrFFh5FXJ5N170qBx6PqCSNl2Tl6neRewLJVCcv6roZUbJ4t2niWaLW02967OiJC9LS62MuBkPjZuNb9Ty0Z7Ft9jbOosyLSYanyrA9J2SWLjtDIzJWlVSW3z5zaTIc4cxgVhWjgkfwGf+nnUGRnGmad3DxWj/40TxuUwdfGW02AvmHSk29UX4dDEogHDr4trfcvYJ81L/geOX5ObedgacHO+KAakn8;25:Gc8vf1ZUSh0khfOOb1+6RC38H64mTYYlr7l0WSuqZIGnLNkJ+gbaEN0oBXReMai8Iavy7JKmpNkByoe4+rkdZ91JrpzKKxsaLeGBJeKt3P5xn+862qEkX+pcE9LiU2+sarH4W41IxBVZ/A/U/zmcI1uQJxQ7tpREo0RSykFmSouEExVce6CYbm21NUt1CfO6JKPiYOEVCxthbrZTIBw5KrymnX2Te8MGmegnm7JBTStkYVaKtlwbaBpMi37DG3h/jLyDeP3LYzZyUaLyTfzdgk+ZtKX7HgwXmERfAgKP3Jxz2kME+Q4G89jiBz1l7riWjuLQISCmPBnUrpy9mf8dAw==;31:J9Sg5WaYtpDa4uUdpbUG9wv5vxbog8vT39O8iHMsdG4ckB48dc4zN17vnvPM9MvJdiPPQvV+lH9dEVXZMMqF1zQNeIscUd1fLHALzCVKvQrcviAwYV3CPW3PymsPyCaVIXukpZHrcHZF1u3RtKqamt7gDK/2q4YWauFuEVs8ZeuTcbprLdCMs4Lgwl9e7LuNvSMzVGnGItHqAhBKnKJvqVR5YWnhmWPxIxxasH4BQuI=
X-MS-TrafficTypeDiagnostic: BN6PR12MB1553:
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1553;20:GbjZMV6KCv3WMunVh6ADHXBI+EWIqj7vGQNpGTPeWA0F40oYhOmf+2q46VANip9he6NhyyYE1kBBqrTRS2vUdJZSKMMeqVout2+Q1wE67QlOtQ7M7rSfvMDmvsIJLKtpZbaiMsbMZnTX1VC9GVafHyGPziQoBKTrgXHpAyVZbgDt6BxgXCGd8hPV5KtNgrqs3tYA6xJxnIMzXWQHOA+HeGsKZqgwIV7nM0+q3v8TwO39iRwGjRPbev8Lk5afl0/uTHIE8Ybbn7dDYTIj/pi6tD4HipaicC/rTgf/jtKkWbPvZ+JXtQblaall+HjJkzqIsnbdbV+JoKFP4K6hSmhAa+6rDL71YLHyJgk9PVuIjqkSajWSQsycqEfEUVsr5+7lIuZS9zex4Kr3gi36vFKnOrYNQax0U15ZB+zMpYsQfb854djEJG65FyF54jUAe0jS7J0gWs37K6cWhhcVb6f54HuHbw4QMol945/qJ2H+72CdHsQr6CqhCwc9rpGtsqcW;4:hTmDsVDJI795EJWKepIoMjtrmKdLYhnbIJZg9FXihwkakGlpub1oTz01S62ZryuWqfdyBtODXwdKS8hCK/4ec2K+IgHhHau7rpIfF0P8A76vmlkKaiIwpKFOlwTtrGQqPCZawZGFrp9YFKPG+7yTK9VCKK8SjIv0g6IT9NKXkSrsRa0lQ/GFeeeSjcEvYxyOPNLgKv9baepH3V2dhXOkQ0nrwTB0eRme60MjWEdJ9gHM2zV5kCSSkJgG7+WB7q9WnzQDu1fvRF2bQd3Ji23EoAkuTDk4poFCE4kYNfiSNgGZkLhxo6qEJrdgQvLw6W1QyEmBc7hOvRR/FdWSdvwc2Q==
X-Microsoft-Antispam-PRVS: <BN6PR12MB155309AA0A5C7EC4CB5FA708F8A50@BN6PR12MB1553.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110)(42068640409301);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501327)(52105095)(10201501046)(93006095)(93001095)(3002001)(6055026)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123564045)(6072148)(201708071742011);SRVR:BN6PR12MB1553;BCL:0;PCL:0;RULEID:;SRVR:BN6PR12MB1553;
X-Forefront-PRVS: 0631F0BC3D
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39380400002)(39860400002)(366004)(346002)(396003)(376002)(199004)(189003)(81156014)(305945005)(81166006)(186003)(5660300001)(2616005)(16526019)(956004)(8936002)(16586007)(1076002)(486005)(53936002)(6306002)(8676002)(476003)(4326008)(486005)(72206003)(106356001)(51416003)(68736007)(53416004)(97736004)(66066001)(25786009)(6916009)(6666003)(52116002)(7696005)(105586002)(48376002)(966005)(386003)(6116002)(50466002)(3846002)(2906002)(50226002)(6486002)(2351001)(26005)(36756003)(86362001)(47776003)(478600001)(7736002)(2361001)(316002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR12MB1553;H:yaz-diesel.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN6PR12MB1553;23:FCyqitJAdOhNoUkB18aCgBOxGYd/2RXdg+0u6IffY?=
 =?us-ascii?Q?YoqW/kV3JSY1b2ZuHc82FAeuBQjgWjSyQepC9Kuso+jQjv6oSq78Z+FhMTW6?=
 =?us-ascii?Q?KPejQn3gHWJwDjwdBRrH4vyCul4xHibMeQ4kwJQAqEDGHNyblwmwAI3HIhAU?=
 =?us-ascii?Q?+Dx6laZi4Fg1uhCw2gJrWH+P5SDxZeJsleP2EfWyNwvwsNNnY4ktyKaRseeq?=
 =?us-ascii?Q?5+mZOw75dzyJGMGkF17XiL57ew4RO+uDYzGMkdV2gkY5fcdhm+C5PR/z6V7S?=
 =?us-ascii?Q?W7+rIvcG57Y0pwJGaxmp0dUwgHS09Dd7NHw4Vbn+kPZiCJFZq24VNtzmy3e8?=
 =?us-ascii?Q?DXIdtjavZsJbOQ99Tg898CTjEp8pQhCEv2khbFOl5i+x3fs7tqLcn6nBc1Vf?=
 =?us-ascii?Q?BhTp6ZQSebzc3yGddFB7Sy2QVh4wLZqowIwUdbTU/SCQIOdCYf840hH/98CA?=
 =?us-ascii?Q?gJHsXlCXeqw17U4zFHPX9mJOcQaIDebddA+G90cPtdztDU1DQpLRsAGMQu19?=
 =?us-ascii?Q?lOUm5ZzAxmvicCkvsirmlsZIIMy2QNtcc4dAivbtxmpZVNY+ws8Rdj1MSV31?=
 =?us-ascii?Q?f4dGxyRnxbOfGJSUjdidP+0KXKHl9A6Sbn9jxSVd5Fg2SiieP1Naaow1qrtc?=
 =?us-ascii?Q?hakaL6JGQ9sZd9/BAPWwvY07GNWai0/vtv0aFsBDk+5i3hm6gQTvIc0M6XwO?=
 =?us-ascii?Q?NasE/XIlkRvPfbGPAjbWsWhbsXYGN3viCwpwXGb2AfKTQ8qNAdsR91tcTAzt?=
 =?us-ascii?Q?xoWHCbIprRteOGCD1ju+e52nDjL2ohwslTc9CGy9UPqO+8Sr1H2wdRjnLX9M?=
 =?us-ascii?Q?tjdP3png3AaBMKlI9CZE+Nm7D4sE+ZyWl3zMAYJrMgnoo5wrbEGyH5yifzRB?=
 =?us-ascii?Q?jUA9uZ15/j/l3SR79/dsxQ3lihbLezKXiHwhG0rD8i8HGEIkRvapAcNFTvCI?=
 =?us-ascii?Q?AG/pMn5CB71HanfS043E69WrUyViNCtdQFDfwExMgSgM/dFxz3WPT2UQofdQ?=
 =?us-ascii?Q?nGVqpE2EdpeQFJlocsUqOzP0ZX/rRJLeJhtWSDHZARCALU4YkFxa4UsUJ7VC?=
 =?us-ascii?Q?nGIv+fQW7sUpXmF5YbQLXXX4Dk133Jg2NZkgr6S68S6u2ThjWFCyIWF6wvNk?=
 =?us-ascii?Q?3xvJsIGHwmwrYxVTJS0B1w9a2Om2fcCnaWawKyx8POEXBaoQqyUHaSgzxgkl?=
 =?us-ascii?Q?93r43So8S3kBTh7FovqH03tAAaTnogNvPubEyCYxHacaFr4gHc2oJ0/aH0Vt?=
 =?us-ascii?Q?EIVGydQc5B1TGZzIuc=3D?=
X-Microsoft-Antispam-Message-Info: nw2vZjL/E+VbLncwwLiDBBCy5qUdcXxPsYEw6pTQ5sS5sb59gA+ADEy5/q5SWDjaYC+5pnNeqpOKEqY3wUZSL7mbQYJcFRXkwczvGnP3BTkWudKwgPKEsFdXPpj0Y3f3J4MdZIF8YqcRF3Ejejv/EgbrdeVQyM6zkhzM5cYQqzOYKPRglzGexJoLIx07rs8e
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1553;6:Ciz/UnbxuPXsaVzlNTDhGwex/7bZoE4RgogCczrjwOW7vCgcePZw7EmeA9XkXSRY4pXR561JzEkxtEvYJvyxLp/RxM5zszqHSaaR21IS5MjiXGh+j3+hY9hHdl/lz0/7vAuEKxc+wmjDC0oTvxlcLAKqNyrE5ubNy9J+wh9waceaQkXDba016YPGhzfMdAlNPVBRYbqMVtXCxvgzPJwaNIwIny44YNBIcylfD+em/1hqD0Bw/PJSMI+y1BQc+3AdRrgnK22sSpyT3EU5GrY8BLYP8qC9JGHZ4JDQe5Hf7atz8E2jytNLfsljfqiDG0Zw7D+aAk0ZiqSIrrZp0Kc32dwNMbl2so7DSEmvrSCL8PT+UsNYkaS7b7ld1/ITvA86RpUnBOWHz9MHWozJkJEgmWd8q1n3Tnis93ArFQ9ef03e238gg2juaPCjoHI34ZVBH2QVDyau0fdb727Z+1Tb2w==;5:art5CyO20ECMNoS+aZDoHxig3Zml5tf3mrColuzbLllm5j5Bo0vdU2ER1FSDSp/efSYhwtbSDK7GI98WpS31ShZ+iPgv4f9fBaxrSKPBlRY/olF67F7tOCPdX8AaBEd/xL2g4Kgp28MeoIDLMRRE1r7hKp+PVTUYKGEGhbAhMj4=;24:NSG0l27RZqrhlUgVltK3SkhanXuVLIoi2GMgwP3eMNwFGkD0N+tu7ZRNbS/QowPnJZbAGgotFNF3LZgk+o+fLOKBjtL5k+zqFdUyFYW9nbI=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1553;7:UR7YkS+0fNGviSGuTCKTj0tYrqrxF54otM5P+ESHeO03mN4CNEafdgLlKPTa01c/Lsf4jCzFAHnJVv83KHYZYbvOfbQAg/7ImLmoiV5Ee2ugu5+gfT27HRbY0rHTHuACGyU7HGxgJhseqi7m731kTbnamoLKXwG4vsZwAOWhS5r/c26ZyAIWQSfwQcLBWPBlnolqtwyXCYvKp8RBbahxEfgCvbEZimlEsZAE0gWZDeCoKIME6SHegUJpyu3Kr1XW;20:QUgIAbS8ozqZu604oMec4Seaz01NJcLUfzjNTyKjZWRiCbBC0EDSrgZIzi2/NaSFj25Y6YAm/MRMuGxHDxHXLgST7qysAe2lj3ZknZLGVrwsoVjHTWz+C/pf8ELlWophv76fOyKG97a0fVFlFRpx2UsXc1/SKFP8Lz5uJQZlN8NltqkCYq+KklRLAR8g/sXiQU9kbOZqqa8gYuIIz9+7s+Aim5IzYNcZMKglD0fksxi5FkU1tTgEzGh7z+Cgv9Qs
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2018 14:02:40.5799 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e611f79b-c582-4227-1bed-08d5996b90a4
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1553
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yazen Ghannam <yazen.ghannam@amd.com>

Recent AMD systems support using MWAIT for C1 state. However, MWAIT will
not allow deeper cstates than C1 on current systems.

With play_dead() we expect the OS to use the deepest state available.
The deepest state available on AMD systems is reached through SystemIO
or HALT. If MWAIT is available, we use it instead of the other methods,
so we never reach the deepest state.

Don't try to use MWAIT to play_dead() on AMD systems. Instead, we'll use
CPUIDLE to enter the deepest state advertised by firmware. If CPUIDLE is
not available then we fallback to HALT.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
Link:
https://lkml.kernel.org/r/20180402183424.48222-1-Yazen.Ghannam@amd.com

v1->v2:
* Drop comment in code.

 arch/x86/kernel/smpboot.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index ff99e2b6fc54..12599e55e040 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -1536,6 +1536,8 @@ static inline void mwait_play_dead(void)
 	void *mwait_ptr;
 	int i;
 
+	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD)
+		return;
 	if (!this_cpu_has(X86_FEATURE_MWAIT))
 		return;
 	if (!this_cpu_has(X86_FEATURE_CLFLUSH))
-- 
2.14.1
