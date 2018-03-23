Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756291AbeCWKaz (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 06:30:55 -0400
Received: from mail-by2nam01on0043.outbound.protection.outlook.com ([104.47.34.43]:30263
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752874AbeCWKav (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 06:30:51 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=George.Cherian@cavium.com;
From: George Cherian <george.cherian@cavium.com>
To: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: viresh.kumar@linaro.org, rjw@rjwysocki.net,
        George Cherian <george.cherian@cavium.com>
Subject: [PATCH] cpufreq: cppc: Use transition_delay_us depending on the transition_latency
Date: Fri, 23 Mar 2018 03:30:31 -0700
Message-Id: <1521801031-158659-1-git-send-email-george.cherian@cavium.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [50.233.148.156]
X-ClientProxiedBy: CO2PR04CA0104.namprd04.prod.outlook.com
 (2603:10b6:104:6::30) To BL2PR07MB2321.namprd07.prod.outlook.com
 (2a01:111:e400:c753::11)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6bd142e7-7c88-42a9-5f4a-08d590a92517
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:BL2PR07MB2321;
X-Microsoft-Exchange-Diagnostics: 1;BL2PR07MB2321;3:gy8ts8o91ZU1a8rEL+oPHukKPCCCBKWaoZXyNwCWFK6SuhKFzvuTi4CMeBgcA1T7WETSdkefSwTtICOXlB0PmMSenp7THNkJGbAnXCHgL0nN82/odDAs9Ua4kF/PrO2dDYMDyCgwXKr9NNVrgtxREJmqq5SGS3FXNKmloMvvj8fWrflZyx97KNU9yNazN1UQJWYjO97ng2KAfPlgKOykQ7dSAKNjyT+5TY5D8hMTPhi13m9S8aB3XjQZJCqmsEQY;25:eSPc6HxtYySQOZJjjqGg6XOsdbiAXuBIt50wrNSmwht7znPf1dX2/zxuwTa8MFAffu8J6oKllr18TgvJGyGHLaEdTR8VmV0ftzO0sKeu+dVS/f8102XJ9/+MaF0vHVCs1gPEDwL08LXlZkHC9CkbS6DAfrgHg1LB+f3/wNDZnyKtO/Dg089Qthkr/rVaVP9EjCfa7ncGJcqJxzEz2wCMudNP4adFQFSM+4f+fW6NoKkEkS+LANHl6oJZJXhVbJrTcTRHTiLh6Tz44YHfDZfIzyBrYkfrDf7ftHD9QK/Ep3xgvhhZ3SoxNB58dnGKRRRuYo7HyWM6dQ+eljAP1nLxsg==;31:u27AdQrQ2/2Wal/5l+MDYlCDdHi2Bp1NJurYmAx5g9XhLQStFE6x34ZGsbFWeMAAjz822wvIuOzOWrmh+kXah4yOVPoQaOpOtJrMhOSbmlzsf7BP7Q8gbTDU7CFdMutAJQkzO/CVvHuK97oKgN9foocINJvyAAsv5QZKACz0ZoqEJJBoqtgBVNYGmAtCMi+eLV3ByPapCKju+LiY3j3cXQEHm329FxGm7HIqR5abgCQ=
X-MS-TrafficTypeDiagnostic: BL2PR07MB2321:
X-Microsoft-Exchange-Diagnostics: 1;BL2PR07MB2321;20:6YcDRsXr490JSoDKw32PKqAHjUm0DeP0FvlGDB5oTK+fiB2KZqvOKwVm+elvYxLVJAxh0wIEHgfI2UTxirlhyRfWpdlVMy0mBHCgdWtC8zpsYNvYokLGBCFFmZorYSlhNgOi0G7ctmGnXo0dn1n3SWcKcC9/SLq+8eckjLN6O4EjlvwaGPXlU+eUGZU41NGqTnBV6qfc/CMps0s5SJx+WxsQFAwihMmE5zOGWNyhkhcgzliMSQoPlqGV43ibr/8cCiOkH6Ix8kO6JGmjP7OGOsVROJI/ZJ/ZE+XiN2cqIE2PGRsUrrH9xFvk+JQvPWOTDeOTUIQQC1z6/HefsLrhdCQpXni961fmaeAtmKZCk5UHy0fQ4D09IfIUtp2QaVUWnuznOqIZXADQnXV5Es+OwHIT0g67VD6VYcoiaRbRmfB3vQssqgnhycEVz2jCbsawVmE8dpeGEdqnAgQKM6jCHKfDduT8dgFP1LfpyiPSoLhCm3rfooZu/OBrH7Pwjo6u;4:e+DqD4TH9xquxTI/EPNDeXkuRSSZ235SjWFLhOz5NzVNej6hVKFf5u5xzsfsSmf2H2e/owGZD3CNUQ1kEs9jZ6s54tauMxdJZ3LfnR+lt4GY5RN67vJ2xzLq1++/tRsupVq1wuRGdl/Tb/QE14/uihDeEW6Ah/YpfvKYtoofLBFMvsTHtY0u/rqoJqWt05bhbgaopUpLOiOWgrWHCQF0LWywhZfd7QCqh7/HP4QAC5b0n/N6Gq50HUafbTsfpJ7acwovdqyYjeyZgrhHBwXn+g==
X-Microsoft-Antispam-PRVS: <BL2PR07MB23211A08386F90D50545B256F9A80@BL2PR07MB2321.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501327)(52105095)(93006095)(93001095)(10201501046)(3002001)(6041310)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011);SRVR:BL2PR07MB2321;BCL:0;PCL:0;RULEID:;SRVR:BL2PR07MB2321;
X-Forefront-PRVS: 0620CADDF3
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(979002)(39380400002)(396003)(366004)(39860400002)(346002)(376002)(199004)(189003)(478600001)(52116002)(6512007)(16586007)(51416003)(316002)(6116002)(3846002)(53416004)(6486002)(66066001)(107886003)(47776003)(68736007)(26005)(6506007)(186003)(16526019)(69596002)(386003)(1857600001)(53936002)(48376002)(50226002)(50466002)(81166006)(8936002)(36756003)(7736002)(97736004)(5660300001)(2906002)(8676002)(4720700003)(6666003)(105586002)(4326008)(72206003)(25786009)(106356001)(81156014)(305945005)(86362001)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:BL2PR07MB2321;H:sbr2s-28.caveonetworks.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BL2PR07MB2321;23:GfNzASPaccK4/dpCxrZykxkKlGJ+wi9sScuZxVfen?=
 =?us-ascii?Q?DDcQSvesUlvswUWj6HvAWOD26IL7YyKE8tQMpMM2Snd8YIV5Tun33VYHqABR?=
 =?us-ascii?Q?YLFrb2aSgzweB2czcg7xhEfpNayfP4rMqU3Z7hVvb8v/pQn11v/xjYZIYOFl?=
 =?us-ascii?Q?eGbn7xHTeCUYQyiRAyeZUtO19JUUC9bAhQUn5VWRVzfPa7gc4OL1qWbjI3yL?=
 =?us-ascii?Q?4iuY5JdNgaLuawmcB07TiiCiIHxxJ1UHgdUM/SZ1ZVygzAScZFl/lxxgDWA4?=
 =?us-ascii?Q?Yyl0W68g4ndtE3RFjahYdDvm/7befHkEkL/xRRpru2mjLnp1hkiM041p4vuW?=
 =?us-ascii?Q?9hbf9OWfzGJjgtO83trXCayx1bs5sqHTbByxgJgpgak17OgoFAQxmNJ7WmiF?=
 =?us-ascii?Q?MmRNDX5v0M0Ctd/9uRMszkoxsmBpBy9SWMVyJzxGe2ZupIDmYSDdRVjH0d/H?=
 =?us-ascii?Q?nXtZGHkmPAonBdrW+LWYTBTYasTf2WXFt2kHKWNjfRi9y5b7DI6iO6Foa9fl?=
 =?us-ascii?Q?4893maRibfNyWhNuuPT0f1An2Bk+JtTHhGMB3ftzz67ut879r91z/8WVlvqx?=
 =?us-ascii?Q?eugqW/+Z7cvN0o7SXT29IwuRGMS9966FTQYnJLC3pPu/Fz0B+z7oTGY5jMmc?=
 =?us-ascii?Q?ZqFJeMXTGWDCnuOhT5ABebmN7bBerg159C7Kp0M8gFjYPz8QzlxDfOejNjAy?=
 =?us-ascii?Q?XUMhsC/Z5+LDqsYhCup3bdUV+MKNC4wbdFbhaPMUihwgKpKCIO8Qrv249spO?=
 =?us-ascii?Q?WkSlvTob6y3cF1ZTctxCA+5BwgQOnOTYtK+qLGXU6AXlSZbIhvl7dZkQbXx7?=
 =?us-ascii?Q?uvT7bNTK5qxDwMCv0JJUCG4g/iPj0Cwvk2tUhK11TKWqyi9u0pZtZktCYO0s?=
 =?us-ascii?Q?gfYv79CN3KFcQKOs++Ahko86MmfVHhVck0gnzDWyF8sdl6pK8gDNlIOO4xn8?=
 =?us-ascii?Q?wPDDTY+NVBi1OAeQflY9AoKpMZTb6MpPZiTVUilTBa0xMCHbypyUQqX0TbRI?=
 =?us-ascii?Q?gFDpueogpf2CtoK90a6TMENiS21KLdPBMa453glh0m4WJ8i0SVZaohGZRjKG?=
 =?us-ascii?Q?oaWwaMBxulj3AxUy+VvpTr5aGpKGKayyCBZJDooheGiVSOQd2x4KWYiizClO?=
 =?us-ascii?Q?B2oxBY8ZZgBvOhAvIFsxP3sE/sW/XZDq6nif6+8cfaE3ZWwjov13uX7KxtO+?=
 =?us-ascii?Q?szu8gbAZsxpY3DSWa/uwb9/xrSD0eR5b/SrStpv5q1PhY/mRGV9ej2xqtIHg?=
 =?us-ascii?Q?PUW3dg2mBx2qf8TCImlZj/P0bRkNfxBNiTXSz4J?=
X-Microsoft-Antispam-Message-Info: qlBaHkR/l6ZIjjN9UGVngZNph9yVX35mvg2n0p0H7o81uycZcXfyhHJsls3q/kJkg1GGTtDyhgvUjiU8IkMPWKkOeqvqMRnKR4bOY5u/1HGHkW8yZGZSIhxucWp/ZCWLwtnCRov5YV3fqYRsOlsViCoTh2KouOi9ExERU7DG1Vh722TTT2uxobPT54+nHB7z
X-Microsoft-Exchange-Diagnostics: 1;BL2PR07MB2321;6:RWYEL3nJdbP7wKDRVn7cIJVrWqdH19wzhThzLy3qPV0zn4BKfMXfnJ/rCmWKNCHnjKQpVU67s62pa8N29w99JqpCsTOkIeAY55ZEm/FhSFy61KymM2d2kvvMtnoeCGCZ/8E7JqASc1kz7t4dXuICR+iCJc31scADziPaVcGGZXNMIOhMRm7OtaObhagkof9m/xk5Fex82TRLFJNa2SwZ82glFgYQbmchL9f7h2dxQV6t9UecQk15lKaLpX01IJ2XA5lg613Ob24xd23f9XT3MgQTuYjwr8uK0TZ3xAi5URjOXwnCm2MtoaFOh7Y8UnHpqa03iRgWLBpj99udEYU0vLzgGP+1+gUGRFniK+cYj0W37+JdAY828V94x4Ug+VnOF2B6Hpv83gL3QIvvCv/lUlDB2vXfMpUugy8AoBvsGRwlg/MtLByvARAUd8k5c/ZcrZ4CB1TWf6+8PHfP9pr/vw==;5:6GL9LvNZK2WhRj6/Rm0z1X99ErMQ8E+GirRKkrmA9C/AJ6GzpygbwhrPvECCcyeUPcRbLppFtAIF00Oq79zh538C821k7r02igFdifqWxY9BKhF6q3os21nvRZKJWMk1Oid1kGbIRx+aMfnJdWHghVV/7Fd3KZ2cYIpUWh9DPVs=;24:7UHlCwzUs/9ag05eiXxZy8wmNSt7iOnd1X7OxO06cBjuP2qeWrMgLnP4LMrGHXZNaPJ/sXaLjPh2ve9QNzidzSozpgyY9i5t7VKbrFdnxIc=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BL2PR07MB2321;7:r/QRRYbPSEhOa805Bk/1zxUF6TDh/Yrp/4TN5UHeaqy/Cdh5zcNT+IxRHvsZE7Sp7OmF1y4NITGtTvJjgTj0QcXR3xuENrYcMA0QiTUFGAvoJ2UdwyknzDmBAGYmh/7t5oTa+oBsRAgNAabeS2TOARkMXEkWMXf3CyWW/XbsBqWtPU7wK7BCNbbnbsxB/KQSvF6EPoPMiEhC4hid4wRnNRqU9CDGy6KTs85COjMXu+n8rHvC9Cp4liliD2D6k7T8
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2018 10:30:48.2319 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bd142e7-7c88-42a9-5f4a-08d590a92517
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL2PR07MB2321
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With commit e948bc8fbee0 ("cpufreq: Cap the default transition delay
value to 10 ms")  the cpufreq was not honouring the delay passed via
ACPI (PCCT). Due to which on ARM based platforms using CPPC the cpufreq
governor tries to change the frequency of CPU faster than expeted.

This leads to continuous error messages like the following.
" ACPI CPPC: PCC check channel failed. Status=0 "

Earlier (without above commit) the default transition delay was
taken form the value passed from PCCT. Use the same value provided by PCCT
to set the transition_delay_us.

Fixes: e948bc8fbee0 (cpufreq: Cap the default transition delay value to 10 ms)
Signed-off-by: George Cherian <george.cherian@cavium.com>
---
 drivers/cpufreq/cppc_cpufreq.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index a1c3025..dcb1cb9 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -20,6 +20,7 @@
 #include <linux/cpu.h>
 #include <linux/cpufreq.h>
 #include <linux/dmi.h>
+#include <linux/time.h>
 #include <linux/vmalloc.h>
 
 #include <asm/unaligned.h>
@@ -162,6 +163,8 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
 	policy->cpuinfo.max_freq = cppc_dmi_max_khz;
 
 	policy->cpuinfo.transition_latency = cppc_get_transition_latency(cpu_num);
+	policy->transition_delay_us = cppc_get_transition_latency(cpu_num) /
+		NSEC_PER_USEC;
 	policy->shared_type = cpu->shared_type;
 
 	if (policy->shared_type == CPUFREQ_SHARED_TYPE_ANY)
-- 
1.8.3.1
