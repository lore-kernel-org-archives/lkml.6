Return-Path: <>
X-Google-Smtp-Source: AH8x227zPTC2lTktYvEuNx1DRanXNx0SSwk4XkmYrVeiGIvlTTHujgd/5ZVbPe10PJGoFxuAhf/n
ARC-Seal: i=1; a=rsa-sha256; t=1518487509; cv=none;
        d=google.com; s=arc-20160816;
        b=lxDSpmxOduMemIPgNivqNEoMq/Wz3RqTv6nJOu3dHibN3vqR9YNVkO2CHPCa0i7zos
         qVNAXp253yirK+Tax55jxl5bNiA0H93vC9Kj8XUZEmceEzIGP3gTOVHEgAUmN+FsQCGL
         KICMX3aSTO7wjHPR5nlHAQY38ABLg6FlBwlsZCdfdXQhhuJ2Sd95rfB1pyvVyq7O1PVM
         9aysrolmcLfHsHsfg0tNRZbqeCIp+/O303iUps4Hc0Clr8Pxgkbdo87cAEkkrcjwGzJo
         qvod48R9lVJ1wsZe2UnNTvWxyQGGNb/LrC0ATJ0r8quAU5ir/x1rtDUHdXamCHV0tlsI
         D+wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput:mime-version:message-id
         :date:subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=uFMyhCFuKriWLuyMYSbiRr+y+c4ymsuzQa12FR8fVZc=;
        b=GLg8bDtA8pv19z1yV0sM8qS1wm7wtwf2yhKY9dgkYrsTxsiS8DtllgPsMjpjYelkkS
         L0dIfE1oDzJg/Ye5p4Yc+78ZN1AXg7IY8w6GDX0tDHZWpjSFGyrEqDO3IH0lErrRrj2S
         s57lAlyoVBa8oK6/ntOFWC2nnFOI6Wj+bMlkv0mks2DAZNVxKhVZiMqAm1JaAKd8Arcb
         Sy1vTCNI0IiBLTIkhST200QBELsySvaq0wLoagjiV4RJMYuEo45uKe+4SPD6hmOSeKYJ
         yoS77DIcQc73afVrHmPM/3rwHWtRJqzlBZrzcetOqUN8gpiOpEW2X8QlMXL75iuBGKdI
         aHMg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@renesasgroup.onmicrosoft.com header.s=selector1-renesas-com header.b=HUH5ruHQ;
       spf=pass (google.com: best guess record for domain of postmaster@relmlie3.idc.renesas.com designates 210.160.252.174 as permitted sender) smtp.helo=relmlie3.idc.renesas.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@renesasgroup.onmicrosoft.com header.s=selector1-renesas-com header.b=HUH5ruHQ;
       spf=pass (google.com: best guess record for domain of postmaster@relmlie3.idc.renesas.com designates 210.160.252.174 as permitted sender) smtp.helo=relmlie3.idc.renesas.com
X-IronPort-AV: E=Sophos;i="5.46,505,1511794800";
   d="scan'208";a="270993745"
Authentication-Results: spf=none (sender IP is ) smtp.mailfrom=<>; 
From: Gaku Inami <gaku.inami.xh@renesas.com>
To: gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org
Cc: dietmar.eggemann@arm.com,
	sudeep.holla@arm.com,
	juri.lelli@redhat.com,
	psodagud@codeaurora.org,
	Gaku Inami <gaku.inami.xh@renesas.com>
Subject: [PATCH v2] Revert "base: arch_topology: fix section mismatch build warnings"
Date: Tue, 13 Feb 2018 11:06:40 +0900
Message-Id: <1518487600-5740-1-git-send-email-gaku.inami.xh@renesas.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [211.11.155.142]
X-ClientProxiedBy: OSAPR01CA0002.jpnprd01.prod.outlook.com
 (2603:1096:603:2a::14) To PS1PR06MB1755.apcprd06.prod.outlook.com
 (2a01:111:e400:c6d2::29)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 810b8fa0-781c-4806-b06a-08d572862cd9
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:PS1PR06MB1755;
X-Microsoft-Exchange-Diagnostics: 1;PS1PR06MB1755;3:k2n3v2bGSR3tCSzFJUFKbGKgn1Kq3GX/r7Y99YIxsUZ+1NDBGLQVlU2CU7x0ZRUzIl4XkJFL3k5OGwNf+J1eythQ1Mt8X4xle7qQKPebc3gddsbn3MZzJhyKQn8cf6eWI26+DwGC9ch92SXUviKrHIjMov1PlBi/SRbPkP65NhbDdzk3LoI6lXip4LtTtXvlDNARcEFSsfvoOsuGaKlw7XELnyG6HKdkmUJPaYveaJs5yh8dRE170IyYY1WrMh4K;25:kBaFvBY+x+OmgIcDKNdqDSTjuaN5WcepI+ibIuEB5aKFw437A/N9VP/OMiL22PQp9Wi2bZ6tqiMDH9XlOk5lkNnCHy4nLZyL6NAK/Z/YdFLoSbkZxvVQnoMBvcLzSNVyQRdXE7YoiBqOQAMNtliHi5z5SNCeEbmHlkA5ZKvsJ5rleNfvuDVtG/sfmKwiWwk0oaKArwXQvTiLqJZu5j4L0HDlf7zt55b2BOQdvPi4pAlpAi6NY/a+ZXp2knS4m7s1NCYic3VZEdFba/1v1LJoQCvldB+6hHwqW0DS9q7smICzDRXz3vJnT6PPe8UwgRtisukHv/kT0EM8R2KKmS3dZA==;31:dZmRAoT5REXQPJdMYnh3zcRgofwNT3P5D8HylcgCoNyUJqMNnkE59xxbXF54xBnpxWyBeQ7NFyEkPhQCXvT2T/vyPmNaMH1z5is/DjWW0zMvME1nRX8W8rrQXSKBb6Ra8GuMbdcqqGg5YdORqB/x/3fI8rgIDyxgBXv68KKkKb1emFCZfBUza9FQ39j30p5JdxwZItebF0/tMNnlFyJk0iGZpauk0jSALUwaztB4NTg=
X-MS-TrafficTypeDiagnostic: PS1PR06MB1755:
X-Microsoft-Exchange-Diagnostics: 1;PS1PR06MB1755;20:g4CcPUMACfNrxHvgg23RHhaxQ5HH38Roqysi6cXxZ/TZ7KxOAq15Kve8UE9ADn8sA+e4urWAI3Bggxp08dlHUsM6+Wx2pnmbV8VWLYlE+4rHkojrXkr6EwUJYn1ONrLhs2NpW7ZYsrUeH92qWe3Fv1Qt1uy+/um7TNcAGaD8yFkp/Re+P7M4LWiqXLYDud0uakfATUoQPLhaa8A+pD21T14wy6QR7A/LHGhR8bF5Cqhj9/WPOBE1qnOe8euMZKjDZP/B5vs+RJvrM8HwVYcYS6DD6WoIvmYLavc5pNTL7eB3CPmH/hyaWVymxEwP0kJrmflDX7+kFAm+4j+4DD6oZ8qtZiEfPOXydrG6nseXfVPGPYrn6mOWp2fycHZ0g6MPFUaUCCTuNpPb/4Il4dFANbFm4vDmKgwg9GS1i5q/6Jc7eX+m276jepw+kVnFCcxGC1Xvd2hxZEPr3Z9Twn72SthylgvBHHWKdBWY+8ogK5jwtSAvIHkO+Xv7LZ9tzbJr;4:052YjKNWihKpL0avog4FyFEXSMGsQJHK+NdujmI1dmD9NGWyQvHHNMHhT15ZMGq3PUXnA58f+k/9lHn/F5Bh1NWybl/WiSJBB2ffu8vTGg3irIymsQ+f2+lQ40L/Y9zsnwaORQrRsGlUHqYhLpwkSyRangKx/jyw7JwN1NtuxUeowluu3fLBCdzX2pOmtjzZnrpI6WI7WifHDXF/84cuyOLz3z43k8qM5H+Z+rtvOcvi7wANhjrrz8U6UJSW8WGLYmJAwtk+TZqbuk31q1J+KdlUX7riJd06d3/71r2+D+/X70UILqRYt8Mzc/WKPTDf
X-Microsoft-Antispam-PRVS: <PS1PR06MB1755C4F886B485B8A7CE1D69B8F60@PS1PR06MB1755.apcprd06.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(180628864354917);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(8121501046)(5005006)(10201501046)(3231101)(2400082)(944501161)(3002001)(93006095)(6055026)(6041288)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061750153)(20161123558120)(20161123564045)(6072148)(201708071742011);SRVR:PS1PR06MB1755;BCL:0;PCL:0;RULEID:;SRVR:PS1PR06MB1755;
X-Forefront-PRVS: 0582641F53
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(376002)(346002)(39380400002)(366004)(396003)(39860400002)(189003)(199004)(25786009)(305945005)(7736002)(5660300001)(6486002)(81166006)(106356001)(4326008)(2906002)(53936002)(68736007)(3846002)(6116002)(97736004)(26005)(50466002)(47776003)(16526019)(66066001)(81156014)(8676002)(48376002)(107886003)(8936002)(16586007)(316002)(498600001)(36756003)(105586002)(42882006)(51416003)(78352004)(7696005)(52116002)(50226002)(6666003)(575784001)(59450400001)(386003)(3720700003);DIR:OUT;SFP:1102;SCL:1;SRVR:PS1PR06MB1755;H:dhzpc054.mu.renesas.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:0;A:0;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;PS1PR06MB1755;23:Kyd3UKxANqmtViqFNBIh4ok9WoEhUvsi4/54eTGSS?=
 =?us-ascii?Q?Lb0AT1Hajz1hWKOicjaJmvYLR0OVPSwpZ5zpk0xev/11hT4VKCULJfinyBwe?=
 =?us-ascii?Q?PmP544zjoqnPogWbr3uR7N87xaPUI0SnD4FC/AEg8ksx4w83NXaNfmKTS2T7?=
 =?us-ascii?Q?eE+OsVcLv3CQjwt3XlXBkjN1z+m4ZAfZ5sVP3XXqFjdmiMAzNGG+TmsG6hsa?=
 =?us-ascii?Q?+/DpV4MZ8SmhGaaKpZbpqsBoMky7wTwzRxxQBarL8NodWxbz6GRbAna/rSCP?=
 =?us-ascii?Q?gTzlGsraDAa+mDBsXlHbyTjBlKFp/zlueDvAoQvGZOukaDO7K9UVWlX3mTx2?=
 =?us-ascii?Q?fNM+InVTHUvWYpx1UOcv32lMLfGvR73AJtmrPJDBatZfMcZm94Rq/iS8z1G7?=
 =?us-ascii?Q?8J4mXRWQckkot/V64z+XVMl2FSE7Yr/uWAFfZpoFqlEPDJG9/su4NiERnigu?=
 =?us-ascii?Q?/pEMPeszAPLV3Xncqln712ln+T7FPnxDxJMm1cQO03wy/zxQXVeVyPgiXKTS?=
 =?us-ascii?Q?A81PAymaDUCKACYciTTeH1FZU8T2a08OJ9qFDUUXklU2iwTZMXYjoEmw3G5X?=
 =?us-ascii?Q?6Q2cmZ6bwYmX0gSNwfKjJzlWrQgsHIfFlcL9TdV34fabG9FeRmSoXdkUHBgN?=
 =?us-ascii?Q?OBulKtvzWCnFJnUIb3Z/8AGy9mvlFjeREhtbAT0wZ2ksdGFTuyUr53izF4jq?=
 =?us-ascii?Q?zfYRq8X57EiLd44Z1C9YMXQB274bHM3ydhNtuelldlr095QkY9AF6zdtDWIU?=
 =?us-ascii?Q?rkFLYMRxQMb/3dTZgg4k7dQ/Kxv0w9xWBM4wfTsY1hQJb4P68yri0YzVH/GS?=
 =?us-ascii?Q?IRkEISAmoiKkcbSJxMdzr7M0Z46/NwQXUCf47pneWYhWdnf42vKPMZHMzctu?=
 =?us-ascii?Q?exLwCgp043oDf7vS635pzS2yP6LwwN38j8+4gosV3CBAKURb7LKKSMX1+xdF?=
 =?us-ascii?Q?buTJGX5j95cNxrdDSsphhMSaQoZsWXVm6y/phT84ZHsSfm/AdFVuggtcErsK?=
 =?us-ascii?Q?XS9atnnENbcmpxvCpL6H7FfPx67wjd4U+FUzF4Y5c00XRKa1ZTG63plQT7UY?=
 =?us-ascii?Q?LLR9Lgs1OgNhF/eGaZeAw8JWqS6JRkHN9Q+EcCYTiFWwKkrk1Jqz/HsFnBxQ?=
 =?us-ascii?Q?FO0LtMICSw=3D?=
X-Microsoft-Exchange-Diagnostics: 1;PS1PR06MB1755;6:Z00Af3uLTMLwUWYtPVUdk8irpElZnMVihcYiEQnDoRr0pN5MXiSWoNHg5tFOIqmL8UZXo3SqlZ6t4Kzor2+Yvn2y4xIfsDaVkWtsx56rWGGA5dxe4w4R1j65/S4cL9+2U2SYJLL++UbhThAjtISHUh/n+9xjDQ8RhF1SZgz35MEZMv6DZegkmc4T6eWmKyFEVRl/owIBZHmMtwX1zdYjY9beYILV28DEfGzL4ccPMXV19kva99Mj2R/5qfI2w5yIX0U+xyLropSxaXsO+mPLHghDZUDAUhOxrTFVLaqOpgJsksgkwPUnw+t1g5ZMyaQYXGg+aaePxMjpAd8wX/g/wXutZl5Bf/EX68OvlnYiq0g=;5:qSExdTeeX8dNX8lte1EpmdzrTxDZZIezd0SYVT6w/b4bw5Bm+6qo9BzUzUqUx5L++dLSpvWxIllW0qsXfGW77iXHIAV6AFqCz+hsye3frBUi1U1kqYbKfrJwqwn4zCngWze/wKCHJ5sqwaOViV5Lkq3s+AOy9Hmxqe2W3U9qvaw=;24:N336pXpXK9G7ei0mz6N+2pq/06EBiBK6M7rwlincBIa0LUY4Eg3L0mvyn+G8u3m4BuJJdoSzYReNB8Enwq49VtXp7Sz4iCxURN8RsEBr0Xw=;7:s0PpVkJtfBUWIXf1Z2rzuB0vf1NvRj69CPogGNWKGz5LHDw7hWhgUpbs8DARwb9JpxHEDB9mZYQFjG9IzFSsTFrcV7Yeq9+59Mqi2U1d9Mx4hi7gWU5Xb8MBTtPg1temKG+eWW7xvItT7pVIdLHnqbJuAPTHhj5QCilD26loBtr5vQ+QAB5EJgZW3fZO/viThdHGSlRhJfPiigJnaJS0/eaS2Gr+yHJVQbriF917AoL0FWINPVOBp3qfKleYGTyT
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;PS1PR06MB1755;20:vp7DO+IpbNYbQPsbsXGdCGjEBDbzHkxZBlB86hqtsx/0q73Q34McIG9EfMGaCuebmTq8KcYGE+On5x44M0fPeSTaNwmnUmHo4vKfAr/wfKr8GQ7dhmhEQGHyLcRp9PNUalzP5WRwQ/W7FnU2dO6BfqZMbESqMSXptmVfvLyc6M4=
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2018 02:04:52.9253 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 810b8fa0-781c-4806-b06a-08d572862cd9
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PS1PR06MB1755
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591730231008876964?=
X-GMAIL-MSGID: =?utf-8?q?1592249557622799118?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This reverts commit 452562abb5b7 ("base: arch_topology: fix section
mismatch build warnings"). It causes the notifier call hangs in some
use-cases.

In some cases with using maxcpus, some of cpus are booted first and
then the remaining cpus are booted. As an example, some users who want
to realize fast boot up often use the following procedure.

  1) Define all CPUs on device tree (CA57x4 + CA53x4)
  2) Add "maxcpus=4" in bootargs
  3) Kernel boot up with CA57x4
  4) After kernel boot up, CA53x4 is booted from user

When kernel init was finished, CPUFREQ_POLICY_NOTIFIER was not still
unregisterd. This means that "__init init_cpu_capacity_callback()"
will be called after kernel init sequence. To avoid this problem,
it needs to remove __init{,data} annotations by reverting this commit.

Also, this commit was needed to fix kernel compile issue below.
However, this issue was also fixed by another patch: commit 82d8ba717ccb
("arch_topology: Fix section miss match warning due to
free_raw_capacity()") in v4.15 as well.
Whereas commit 452562abb5b7 added all the missing __init annotations,
commit 82d8ba717ccb removed it from free_raw_capacity().

WARNING: vmlinux.o(.text+0x548f24): Section mismatch in reference
from the function init_cpu_capacity_callback() to the variable
.init.text:$x
The function init_cpu_capacity_callback() references
the variable __init $x.
This is often because init_cpu_capacity_callback lacks a __init
annotation or the annotation of $x is wrong.

Fixes: 82d8ba717ccb ("arch_topology: Fix section miss match warning due to free_raw_capacity()")
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Gaku Inami <gaku.inami.xh@renesas.com>
Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Tested-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Acked-by: Sudeep Holla <sudeep.holla@arm.com>
---

Changes from v1:
 - rebase on v4.16-rc1
 - add short tags for fixes.
 - add tested-by, review-by and acked-by tags. 

 drivers/base/arch_topology.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
index 52ec517..e7cb0c6 100644
--- a/drivers/base/arch_topology.c
+++ b/drivers/base/arch_topology.c
@@ -169,11 +169,11 @@ bool __init topology_parse_cpu_capacity(struct device_node *cpu_node, int cpu)
 }
 
 #ifdef CONFIG_CPU_FREQ
-static cpumask_var_t cpus_to_visit __initdata;
-static void __init parsing_done_workfn(struct work_struct *work);
-static __initdata DECLARE_WORK(parsing_done_work, parsing_done_workfn);
+static cpumask_var_t cpus_to_visit;
+static void parsing_done_workfn(struct work_struct *work);
+static DECLARE_WORK(parsing_done_work, parsing_done_workfn);
 
-static int __init
+static int
 init_cpu_capacity_callback(struct notifier_block *nb,
 			   unsigned long val,
 			   void *data)
@@ -209,7 +209,7 @@ init_cpu_capacity_callback(struct notifier_block *nb,
 	return 0;
 }
 
-static struct notifier_block init_cpu_capacity_notifier __initdata = {
+static struct notifier_block init_cpu_capacity_notifier = {
 	.notifier_call = init_cpu_capacity_callback,
 };
 
@@ -242,7 +242,7 @@ static int __init register_cpufreq_notifier(void)
 }
 core_initcall(register_cpufreq_notifier);
 
-static void __init parsing_done_workfn(struct work_struct *work)
+static void parsing_done_workfn(struct work_struct *work)
 {
 	cpufreq_unregister_notifier(&init_cpu_capacity_notifier,
 					 CPUFREQ_POLICY_NOTIFIER);
-- 
2.7.4
