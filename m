Return-Path: <>
X-Google-Smtp-Source: AH8x224idfdkZoCpjpFZ+Ei8wZBtL9AIVR2LxdgPr1H1gsJfHYHmrKi41VKKNrPNNf82+h+pH++e
ARC-Seal: i=1; a=rsa-sha256; t=1517992239; cv=none;
        d=google.com; s=arc-20160816;
        b=H4YfBdttbqowS3qT1Qfza98Mc8rVL/YrUKa3Ez+MmXdXMmwhJDs1zmTTdZHNnCHQq4
         1rKPASza91EqAiuy8Ecgj278RMsfi8j6fwQXC0riUlzxRzRfrbhPtyIzTb8+YhkrcsAB
         o/r66vlzMooP09bCqOkvt7hVJLM04vh4hlZOmK/tbSw778AqmN6jshKZ6vlJZnx3COJd
         +qHYynf4zg+h61j4hAnmZszS1134XLiCg2oMkm9M7flNae+k9FpIk4tp/I+RmaIgnIXx
         e4QUuiMcPEkhbQgw7oGsC0rXxjyITd4pWkAQadtj4aIHHWH70tmXoGAiNWx1Gu2+eUi3
         zi4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput:mime-version:message-id
         :date:subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=iKxv0TzYje4vJT2xbqtr/phIwpvubQmyfBsGHl0ZwCU=;
        b=q/LznR6g8ed+fOeA6W7kJt6Ovevk0I0qJYhdeNWj0ZxymzmPMre2bZWWPep2cimCKF
         k2gZbkBcH33AzqjcysrOdoofLuJuxXMsETzs0cC2TSnJZc9lepg6Yhqur1qx86eyT+WP
         oJVAYd9OyUOavjEz9aRJ4gVoBxshfJkHonh3PlfRby3rprxlMEcWMw56GFbqpgGS+NO7
         WtDEbAN6UK8y7qIADCyE2e46Zjhjhph6BNeaOiBUIDrwmMI2w+hVM0VttIQ7hmV6MzLI
         w5Let59E9zVOg273XBo3FbwklbkfhXumfwSzomMRTsBAuX7hJ23prylOpqHOQnHhafFo
         OVxw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@renesasgroup.onmicrosoft.com header.s=selector1-renesas-com header.b=XDrZ//dg;
       spf=pass (google.com: best guess record for domain of postmaster@relmlie3.idc.renesas.com designates 210.160.252.174 as permitted sender) smtp.helo=relmlie3.idc.renesas.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@renesasgroup.onmicrosoft.com header.s=selector1-renesas-com header.b=XDrZ//dg;
       spf=pass (google.com: best guess record for domain of postmaster@relmlie3.idc.renesas.com designates 210.160.252.174 as permitted sender) smtp.helo=relmlie3.idc.renesas.com
X-IronPort-AV: E=Sophos;i="5.46,471,1511794800";
   d="scan'208";a="271857577"
Authentication-Results: spf=none (sender IP is ) smtp.mailfrom=<>; 
From: Gaku Inami <gaku.inami.xh@renesas.com>
To: gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org
Cc: dietmar.eggemann@arm.com,
	sudeep.holla@arm.com,
	juri.lelli@redhat.com,
	psodagud@codeaurora.org,
	Gaku Inami <gaku.inami.xh@renesas.com>
Subject: [PATCH] Revert "base: arch_topology: fix section mismatch build warnings"
Date: Wed,  7 Feb 2018 17:32:08 +0900
Message-Id: <1517992328-3559-1-git-send-email-gaku.inami.xh@renesas.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [211.11.155.142]
X-ClientProxiedBy: KAXPR01CA0047.jpnprd01.prod.outlook.com
 (2603:1096:402:1a::33) To HK2PR06MB1748.apcprd06.prod.outlook.com
 (2603:1096:201:13::26)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 4e318bb1-8fb7-4b9a-f658-08d56e050fc5
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(8559017)(48565401081)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:HK2PR06MB1748;
X-Microsoft-Exchange-Diagnostics: 1;HK2PR06MB1748;3:k/Emn/28liJJeURcpvflB8Lg5ylNWzW6drqGpAOOrLLJWtbh/tXcsPVX8+Elrm/D13P2MgzdMR0n5x1ISH+uJ8aE1eTVS5z2LhfK10+PZPp8nrjEy2lUI88YxIOu1xHoKZ/2VPdqoy7vyRnutu497xpBWujdiQqcnEjumCXT0vRbMvw/jkeyH06VCCd2f8N9UF8ifhq83+5zYRmgCfQqFDpn/ouBtYdU5TdiXic1gueJzi3Dt7XUJBNkICJRlgG0;25:fUvrEQKT+qD1oZcTkdDTwKy6rjzjWy9ysO2HMvKOt+1SS1y8QZ++WmYnBdCuvDwIoiwGj/StUtB+FGOUGa0UsUgrsDq2xsXA+a8bfXCJ90pvSXswD3vZ9an6jlIeoCvbeqtCIryDQTKldwgQyJEAaBuzwTEyeJwsPt6+jHgsgq843utb4Gnl3qTm3eItVJpsJEtwfrUkM32unayI0wkrQeUnhPtm2pF8sHfszUkApjdgGhX8NgJkZxfERuAI94q0pyhVr0NLsdrFWBXew6ZgwWcJ0nhWxaXSpQfTw+5gn5GA3cUcP7jO0EiKaSvY8ptiSrmgZRuDCXm11e35lhTHeg==;31:ep99O47pqlsdontDgfTWnvBfkrwLDOv3wMWZQxpvpapPiFpjiDV/hDFYX5xNtxwx2obcFk6alQFGfZ3CBTY+HFSuDN2p10mFCeqHb+dCpFuW0U/iapD1975oBybc6SOTHwsG0l4Y4hn2MLDvOiccBpQ245bEQ8sgPk7YH5iMhv04PyHcoekl98SCvIlWClwENp3jaQVX7uyhfIool4RYS6GqMX43KwcizPt4fqWRrIg=
X-MS-TrafficTypeDiagnostic: HK2PR06MB1748:
X-Microsoft-Exchange-Diagnostics: 1;HK2PR06MB1748;20:Xc9qcvrALcSrxIFwoC34hbAEkEkpDcIE/TpG5WSMbuUhOJQP/cApA/DpD1q7+GCyStUxe6DQSgyYFSs3EETNdt3odPCXyErAEpucNpl0hGo4Wb/mcGLWdgxxjVVsA054L14bm7tTmjqgG3DqvulBcNAy1Yp0mmK6dWZKctcaFPdZAHaIb/nWBeta8MhpKJT19MzOsKCRoybtgaQccIowwKjldW48oozHYeywnUIe5q/b1xgWo4Jp7b2OygMKWwd1ZczlS+4w9LMIyH56fiWxZYMWX8t9ZYYYRP98CPSCMSTFex+Pv5+LNtaMg9gmEQyXme0xlX/qPOVaxJac+fpjgNGSg4mrh3EqYHz7xeDJ0hYxgdA/lNN84F1q7uxpTJVS3fYKT92HkiojFI985gHXKNGCNawx/Wf8h79BcfyYvXTS2byKw1wSv/5Vk4R+ibZ3hpmO/dHCSxwiRJnxACn446nY8ylhKtT1DIkowRFc9MjjPhsmG5iZ5JZLKm8UKRlU;4:ObE4ov7bRVQcNzJ6QUcEixvrXFs2T24wifWQc7bQ1w+R9d6Sld6U0ablPumlj09XFfXNaOKXVj571s5DZ/TLwgQJBpIvqIAVDKVrMbh7DaqxY2jMkEHRhXR/MYqY5aI442K3O1l4DdZLun5KOkv+KmPJyDr+A0Lg5YocRUfm8L62e1DAwHq4MYhD8U0vIP0Y4bAzyYQ2NADokqBp0H+PlQj2BUF1hSRzjZVOzpl5CM/ize7qQQfxNGxvHvPum5FsZ3DZ9TQsW+ml3hJGQ3BfcA==
X-Microsoft-Antispam-PRVS: <HK2PR06MB174854EE071B5F72056AEEF5B8FC0@HK2PR06MB1748.apcprd06.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(8121501046)(5005006)(93006095)(10201501046)(3231101)(2400082)(944501161)(3002001)(6055026)(6041288)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061750153)(6072148)(201708071742011);SRVR:HK2PR06MB1748;BCL:0;PCL:0;RULEID:;SRVR:HK2PR06MB1748;
X-Forefront-PRVS: 0576145E86
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(346002)(396003)(39380400002)(39860400002)(366004)(376002)(189003)(199004)(81156014)(8676002)(81166006)(1857600001)(8936002)(25786009)(50226002)(78352004)(4326008)(7696005)(51416003)(52116002)(53936002)(5660300001)(42882006)(36756003)(6666003)(386003)(16526019)(68736007)(59450400001)(107886003)(105586002)(26005)(48376002)(498600001)(50466002)(7736002)(3846002)(6116002)(106356001)(305945005)(6486002)(16586007)(316002)(66066001)(2906002)(47776003)(97736004)(3720700003);DIR:OUT;SFP:1102;SCL:1;SRVR:HK2PR06MB1748;H:dhzpc054.mu.renesas.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:0;A:0;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;HK2PR06MB1748;23:Imhh6JUeL8qLfTFzbcgcavVrJPWb9nC+SH9ZqOwsr?=
 =?us-ascii?Q?VuTltbESenLVJdXmYKFEACNgYr258MDxpgipnypor4+icOYbB92v9cTiCxR4?=
 =?us-ascii?Q?PAe+hnHBNPrFb4sbQRswHomxDQi0NpXj5TN1mtPxJskgk8pG77EzNxn/IA5u?=
 =?us-ascii?Q?zxh2xHO7eqO5VC14Eqd1joWyYUXP1XiElhCc/6yHQXBoNY4PUs2XhJB9zZqD?=
 =?us-ascii?Q?mdnimXsq8UNRnTnn/Ja9W+UhHLkv60BjsChzsDyxZ+kAKv9rki//pv9g537o?=
 =?us-ascii?Q?5b7RQogOTTLNGYkezJ1gd39GyWjERzbVbI1PgEsKfFRlNIFAjOkfft2HzT2o?=
 =?us-ascii?Q?n8krkhPlWsre4pruZAZaoH5b1jAKe10+L4wJnoHoS12ivLokMri+fHnrPCg9?=
 =?us-ascii?Q?0Sx3WBYbkOq+feRnvy8ObH3e4mCSew4UMRsgifKRPrqQXVqywFknp5xMDQwz?=
 =?us-ascii?Q?s/9jivyb+OpylLrlGNduv9sImzN7K7rtd0pNCp/98b7La7fbbmK1ik0UfkK/?=
 =?us-ascii?Q?fF8iwbp6upQzuWG4yHIlywycIyLOVBujKscamLOddbI3PSK+Tdcs7aEn2eyK?=
 =?us-ascii?Q?Mkoxx6Fb4a5cRHBdFGSMfYQEQT5D5ehm/kU5mH8paYC/65+qUWsTu9RXYo6c?=
 =?us-ascii?Q?/Ms3+QKBAJt8RrZ3MS71SGHrGqNyU85Tc1DJ9UTAFL4q35xI8BfhFP7vhxDT?=
 =?us-ascii?Q?crrCCZ/BFUdVJ2EYo4XO6GA5MTBU3gADgtHTDnwZ9YOBKI7UqYxGdUBm2g36?=
 =?us-ascii?Q?okPqdKIQXWoqZsultEB6q7WrWTi9QW4pVmg+ihQOkXG+PdPsNrYcl6ZpTSun?=
 =?us-ascii?Q?BbxDYposJjpzmhn80mj4gdomeFVXI3qVNNVD4NchK+IGuOPnIZi7LCj40aWQ?=
 =?us-ascii?Q?DxMj7O7oBv4Oo+ZSKfd4oKvmrHPdTj19WtZKvaqmi0vnfhn17AIlBMRgXBz0?=
 =?us-ascii?Q?2vrIsGSxolfcDG7FAHgmETF7T/wVrU58+/ZX8wpnoOxGHE774ujr22FyF7Jl?=
 =?us-ascii?Q?2i5PykdFSUsueI+Jzo0NoscW2Qa6cWuSTnSbjRoabYQERmCg9n8/NJjog76S?=
 =?us-ascii?Q?dGvUNEaUQswc8M/QbN1x1yQHZx4fsqNZTR0UB6Ok3C0rsfSd1IPbuLzxC1rp?=
 =?us-ascii?Q?up4e230saA=3D?=
X-Microsoft-Exchange-Diagnostics: 1;HK2PR06MB1748;6:AjxMENrUuLDMOC/+WBeFvcpbrQSoxz98+HMDPQGSzczTxPIpbxq1J7SpJjfUgwmzXrdTdlmHl87QOhI9iS0rRN9ANcqKjbFA19OjtZJ/0S0tKsvlqGc8BMpPKoj+KGUPackBjuHhhFSCKDOeF1luatVKwbD1JxeltoUcfFu/VG0Enkbz9S6s830R58tEg6vcgrWyGS8fZ2zoN6CGqFwqtSRJX5NHoqSRURw+507W8eG63nO55opazSk4zoc7y8/9hoenOCAvb2iuPGGlzB5YzTVZnDgSCOYqekK8zCOWWAO4AV8Nm6TvmzNZFQjL503izqZFemhSfZTn1zDZO4rxSN6ZgDOhW5BcaagZnuAV0Go=;5:q/IfxKZlEODNU5wvDxyDTqLpH40sjc8WnTK5haMfSFRrygCKCV0hjJ+UsxW13tj7G1eQSRZaMTAnIDkpQd0APzCUFm2u6iFLee6X+IjulVkXrJ+4u0AxK1WxoRLhoL5EBv5MWWfmZsX3Fc+C709XWsjow/vFt4YiWw3ZL2FUlgw=;24:OAaS5yGVP+9Xw6A8M+60ZlC2FNWGRXHW3hfOv2TMTyBhL84sGxUxpojkR6+7HbxNDiRRUFRI41EGb3Fhn4ZfQPo7oCxOlDMdqBAbBzebUuA=;7:KA8metJFcWfvBqFYR44cEw2ptDNahCNiEoapY1IdKDwkZ2Yhd7t21v2DUJgWPJDYoY9TvlfyRlkm/sHZvLdtqSrrU9KOgSru+ZcoWCZEs8JJCrvhYpUcWnFmEmWdE/2Lqs6j3tlQKi4kvmhORcoFg6yNdk9phcXjcavnrqLy9dPvefVuUsBLt6CtEmwr7NHry5sl+p3BE4f4yYwyJOyJ0CvbIIb6g5hIS/jlqbMF9se2L2Kwjh4C7wM49Nry7GDf
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HK2PR06MB1748;20:1N1AQaCPUC8W8P7lGFqAAB6PkndiAHmCXmV6aTh2km/i4I10B7rWXR/dK9PZI29ezJluhYpoaFkWwXemmJYuh7ZbRxb77UPcj8NejhDrBHYG5xp+CgEz29xSpgttFgIMIhOyG9xE2BnvuOFF1usrcmV7g3yW1gU2aNjoAj+M+k0=
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2018 08:30:35.5535 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e318bb1-8fb7-4b9a-f658-08d56e050fc5
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK2PR06MB1748
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591730231008876964?=
X-GMAIL-MSGID: =?utf-8?q?1591730231008876964?=
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

Signed-off-by: Gaku Inami <gaku.inami.xh@renesas.com>
---
 drivers/base/arch_topology.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
index 4de87b0..8bfd498 100644
--- a/drivers/base/arch_topology.c
+++ b/drivers/base/arch_topology.c
@@ -175,11 +175,11 @@ bool __init topology_parse_cpu_capacity(struct device_node *cpu_node, int cpu)
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
@@ -215,7 +215,7 @@ init_cpu_capacity_callback(struct notifier_block *nb,
 	return 0;
 }
 
-static struct notifier_block init_cpu_capacity_notifier __initdata = {
+static struct notifier_block init_cpu_capacity_notifier = {
 	.notifier_call = init_cpu_capacity_callback,
 };
 
@@ -248,7 +248,7 @@ static int __init register_cpufreq_notifier(void)
 }
 core_initcall(register_cpufreq_notifier);
 
-static void __init parsing_done_workfn(struct work_struct *work)
+static void parsing_done_workfn(struct work_struct *work)
 {
 	cpufreq_unregister_notifier(&init_cpu_capacity_notifier,
 					 CPUFREQ_POLICY_NOTIFIER);
-- 
2.7.4
