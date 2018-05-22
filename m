Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752478AbeEVLnz (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 07:43:55 -0400
Received: from mail-dm3nam03on0082.outbound.protection.outlook.com ([104.47.41.82]:62385
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751621AbeEVLmT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 07:42:19 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=George.Cherian@cavium.com;
From: George Cherian <george.cherian@cavium.com>
To: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc: rjw@rjwysocki.net, viresh.kumar@linaro.org,
        George Cherian <george.cherian@cavium.com>
Subject: [PATCH] cpufreq / CPPC: Add cpuinfo_cur_freq support for CPPC
Date: Tue, 22 May 2018 04:42:04 -0700
Message-Id: <1526989324-4183-1-git-send-email-george.cherian@cavium.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [50.233.148.156]
X-ClientProxiedBy: CO2PR05CA0010.namprd05.prod.outlook.com
 (2603:10b6:102:2::20) To SN6PR07MB4928.namprd07.prod.outlook.com
 (2603:10b6:805:a5::29)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:SN6PR07MB4928;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR07MB4928;3:hUqCAskI+RXEJEymUCZKRXwzAYyT98b5IA/xWJ4wC/MjN43yHflT1DwyXcLhPXTg5HxHoKGprSA5+OZW1GWL795w8lngjtyEtynguB33RjTsXDa45eE5GuBSLusnf0Py99gGnKPqGjYdcM/2nfm6CoAfTajzlaFJo+p6lPwItPRLimWBSv7Y2Y3czRXTz3s58kjhuXRyjUVDdpZz1xDuhfte5WOh4htIRGZuR4mMLoBsTy78WkuR5/u6CVBwxHti;25:SkXvPoki0QFwVr+wQifx/oCugLo1QHtRp2mW65offoYw6p0bEI1IvEmiz5NGERpnjLPD6QSM1vbVO++0G7fonHbElPuT/nRFakNNrfac+uiO5O1tzl+sI3JMvaMhwa9Jnnnf/aVqKdCuxfGLpiDFtjLdynaJ6I19fKtM+vhPUgP/bHpFwZp3df/J8RXWOrIfbbFYTanQuIUbjhyvkm1rtddzC+UV0ZC707EvVwA0yL5mjPw9THLVD/wZ0AD8pudyna0VC4fc6VYCu834F9ba5VLH1lxgZpkHYd/Lz5orF/kPEXBCPjvHssOAaQ3F8bYpY0azviUHKjHkL0srO3A/VQ==;31:Kfx9/USDdG1pRH5/rTdG3S6UBJG5moNEwWpT9TbH+81GK+c/rYdVhVZy7w11LRSkDQvVG7el4UHa/sY/UILfygRYAOjTtrG/fGDWpJMEuSo4aPATWxM5AAtXuifhkb8sk9tlBCA1zHFq/ITydkWa1l8dWSW290klI95YrIgegfqL2VFcx8mfrU/UhnKZNQ1ShJXY2dht5abRRxS/minzc/pFIM98YDuxvdhXnoO9wt4=
X-MS-TrafficTypeDiagnostic: SN6PR07MB4928:
X-Microsoft-Exchange-Diagnostics: 1;SN6PR07MB4928;20:jqiVWIcB8g7nYkfMH47UXvV3IAhTex7xa8WlfwPT7sSby4W4ZXIpJsldatHTHTW95JsoMUog3GPq+o1mmPC/N0ZLO2vAmmOon8K2ZOKvb9/pp5H0u4Wx9sTvT8mKXAz0iV6/b+w11c/7MQ16EovsTFR2mvSbNl1awiqdtmwJ/yVdAgO7W8V30+OsURS3geBIWbGAbgzFSxhXp47pcnEABoznf5CvGHxnrNT8JedMl2kQgcPdw5bUI5xHL6+we8J8db6ZIxB+t0j77v1lqJ/shZfo8lxOl9zd1v1uPXl4rAhtHXvMi13KBvl7EN32HPpVFwTFGd6z2c/TiPQW29uamQ0GjrbrDTepyDfsWj3AerO5BT9WtR08IZ89NUzmnnQ+gS4owNhZFFrPGn2B5X+xK+t9/28Po6I9/06Ny6uwpgwIw+W1Fv6PDf0DKdA7V6ZAOTLCEK9dK+FTxa/xuU+2VOw7Wrk6sx3e2QZCZ3q2Eo5beb5+Z23hwvlj0yVmkg0g;4:ZOA9eklO0ZRJCbM0G4DHP21b2fQCqH69WHXziycchsYgoI+Exdz7IrYEmE5hEPLdLjASELVwMfWkjZZG2IbxUW8wkGPfqfyRUECDpidagUjQivZT1NF92GePFEQaPfOy6HmZfiyUUXASXYffposfve0vh7pcZzcxWB05fhWrMgma1UbhfA7BtK2r/1SrTwiVHXdMRejTIXYI1c4BAlq9JXDuMP3dQbhTV9ZMIT+1tCN+5FOHhpIFaITcEmyN/TSnHC8OtuN1Ma/nurfKAGNkUA==
X-Microsoft-Antispam-PRVS: <SN6PR07MB4928C77348A8C1EFF55ED01AF9940@SN6PR07MB4928.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231254)(944501410)(52105095)(93006095)(93001095)(149027)(150027)(6041310)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:SN6PR07MB4928;BCL:0;PCL:0;RULEID:;SRVR:SN6PR07MB4928;
X-Forefront-PRVS: 0680FADD48
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(346002)(376002)(366004)(39380400002)(39860400002)(396003)(199004)(189003)(97736004)(86362001)(476003)(956004)(2616005)(4720700003)(6666003)(68736007)(6506007)(386003)(53416004)(25786009)(186003)(16526019)(16586007)(305945005)(8676002)(44832011)(7736002)(316002)(486006)(59450400001)(52116002)(5660300001)(81166006)(81156014)(51416003)(50226002)(8936002)(36756003)(48376002)(1857600001)(6486002)(6512007)(478600001)(6116002)(3846002)(107886003)(4326008)(72206003)(66066001)(106356001)(26005)(2906002)(53936002)(47776003)(50466002)(69596002)(105586002);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR07MB4928;H:sbr2s-28.caveonetworks.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN6PR07MB4928;23:QOET4czaPhfHyVXmqELkXS9nz3U5Rj0lhxBVE/MNd?=
 =?us-ascii?Q?zL4/ounsq+91QjuKyrVkxyXLXH8865H1ieqRh7Dn32FXht6x07jCfzSOVbjH?=
 =?us-ascii?Q?B03OnKGCJ5ozfBRYRJN35WfBCJuNRogNAJUFM0glhAkwMFNp+Emvn3OZYtkd?=
 =?us-ascii?Q?WsIst4OLBwN4yfDbpxNymZqA9wLIUG6reBPTpckuaw9ZBQ1ZQnJQyFydnMDU?=
 =?us-ascii?Q?9mbvunA8nlc6K2yPVlkL5Wz7CgqoEL91eq/3/vx0lw3jNpR/sentT2cyeSpW?=
 =?us-ascii?Q?oKZ7RgCBPjKpq6vb+WwOvEHOUrEh5psVvkM3dV65RYGgLqA9Iew59S3uP3bL?=
 =?us-ascii?Q?zVjA2OTZaeh1/t+Nyp3gAaMq52RomOGFIpI0LPq/ZiCIa9uuwYuONvbMnpIm?=
 =?us-ascii?Q?bMdTSPwZXWNVfvwPbtp05UoehDKhh5omOS6mc1y2KsJqIzjs+rAfk2fLyzqJ?=
 =?us-ascii?Q?C0+aaoI2g7WY0yTGcGWN1xRW/2N6/1tDsx520xMX6PD3Hfqj+Hro9a7lHgox?=
 =?us-ascii?Q?RSuhE347v1JC5EuUYCl4CyW/1QDirgqwZ8YBr4+Hrq/gqwTR0JWyp8L455dz?=
 =?us-ascii?Q?7bEACuIA3Ggw6pfl7gssJRpvG7kZTDwvNT4cS60g+ZQmvlqEe0rUoQyB9OT1?=
 =?us-ascii?Q?x9wLtPbublxG5/R0lHaNV2cWk7QHKtY1eECNfy9FISh3eyNd5ct6Z5KLB4Ap?=
 =?us-ascii?Q?XbnGLXuMEq/kXgDBtJwTyG5t5KuOPAQE+0Dj6aKPnuuwjmArJUYP02uHnqxB?=
 =?us-ascii?Q?95A5+QdTeuCKeNelS3J1qcAMf7wV98cDQ8KCZboMfs6WIePg+PNYVU0eyUpn?=
 =?us-ascii?Q?mkdnrXyeD8RJMZZPHg8Dcr2CvCMuPiLTZjm3RWtDbsa1RkQPqhUrqYhrOcYC?=
 =?us-ascii?Q?Dfzq0mStFebxhMg35En86/u4I7cp1TaPJKbJyb5wuth7lcUryuTN5fF9rAsg?=
 =?us-ascii?Q?iAtc46xUHQErE6RArsUeSL5KF7QkC9YFQYM+bwZ2CNzKMwRYKulQl2TESQy8?=
 =?us-ascii?Q?DIcaaQ3SBOXx25/aB5lzFcAufS5JQBuauWE2/lq6SBLVq8fb9ncnAmQSFR8H?=
 =?us-ascii?Q?D7GO5WvSOPK1XD5/HRCYGFvpyGPxrOR3DWaYKXgRccffGes+5jBSPNjruOAE?=
 =?us-ascii?Q?ltlSPRoGE5O9j10OA3uaAx7wEqjqm2O/1uiHmOvQE1tRnRCvYSFSDm2mpNpE?=
 =?us-ascii?Q?SBDzxgzG2kEormByHQIYPpflSD0RLj6Ybi5AM2yUUrG7g/VmzAOPS5cHRKlk?=
 =?us-ascii?Q?W7KPUgwCMjqHzMzhpAVpr3DLbMk5Cge5tt9iliQaaPzqJVi16NSYPtLf0z1T?=
 =?us-ascii?B?QT09?=
X-Microsoft-Antispam-Message-Info: wgojFHjwM5OnsiPK0jRpxQR4y2yPA5UCG5ceiivqi9P4mqHIZ52DyJbP1SQx9noArPOYQpkjRfuJmrF0LI+sZDu5eEX9mh18TpQfYwlUz8PMigi9aP9bVfhTPf73vIxgiEtmgWG7p7+pibu7JgddsE+qjfLcs0bZ9Wd9fZ8pvtil5cZ4CwEoThlgL5kDILLb
X-Microsoft-Exchange-Diagnostics: 1;SN6PR07MB4928;6:PSC2g/t6GXqDFlEEsJNsttyVDMXLYcf4cnb7qFyaYZ7OG//3LQW7WXJJAzVDOyrfaLqtZy5OLxNG3U2tEC3WIcYJ0DkZBcb8SBPKt1gBaspC5dIlVJ5FauXiDpMV+DxH9s8kPoFkvaNvg8YvLy1vRf2IaeAfJC6qjW4hWEKm7n3vUEHCq8VirL1As25gLfpW3ZlPZNzBbHcjnaDHBU53su0uWyTW5HHf85znzp2OxNBaF8Ul7u5GSohae7jRBqW9d2kNeq3UXWo4DGoM2bUi+BVRWJCCmtzprw6FpVwnCAKnb50qpGo8Ox2EDgz33Lodr9zqhCvj8wWmfcXVAKCjue7ahGJgLtqsYntunfu/eTc0Un5qo0mPsJJSPKz+z1zsahDN9yu3FLbKAzLH7Cmf6KbXAg07ajWddq+/YRSZTz6vGSmWXH96COEfteiL5tE0wQ+nwEPOEuTpJHetvDT41Q==;5:NU4uJKd23SIdDkOyN7Vdwt5DxUPeo0g29ovll/uEffGvAB3agGygYS5A7YV18UP+62vVVeGHAGMUCf/OncreB2O8WLavxFivPfA507gyCx5YB/QjT/M6+ZX7vMgeb4L6SFfAOGF1qe5EOEn8V06uZJ1LbZ4TiDRKevfl6/e+v8w=;24:fRHACY+jKH8/30/aCOPgvFFv+TU2lUOy5JkJ1+O0/vf35H49Pj4RRhBjcoYnba3p5U/qMKXRhjd7ggpf/w10YbAGyrq4mKILlgQCYDVnh/g=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN6PR07MB4928;7:bFEysYXSoNAiG8sd+r4IX20m62igIskCn5KD/B8FgGdoMnT2/BN+oI52CDhz1Mu/fikHPnxpNVUluW1NSlLZ7d0D7G7nOW5P43C95teCQnE4OyHKIJFn/y0n4b5dXrpAev+1a+8lxdrz6dKaMkJcvATNyrrNxnU253U6HWlXmwrAiEOCT4Rjx3lgIFqD+WgaAqRrUgeJImSTzH6wU+1zpNZTxsUygeWeRHYNdZJPtX9Fie9klFucgUjCnWLgsLqL
X-MS-Office365-Filtering-Correlation-Id: a7dd8ac9-606c-470e-204c-08d5bfd911f3
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2018 11:42:16.7864 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a7dd8ac9-606c-470e-204c-08d5bfd911f3
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR07MB4928
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Per Section 8.4.7.1.3 of ACPI 6.2, The platform provides performance
feedback via set of performance counters. To determine the actual
performance level delivered over time, OSPM may read a set of
performance counters from the Reference Performance Counter Register
and the Delivered Performance Counter Register.

OSPM calculates the delivered performance over a given time period by
taking a beginning and ending snapshot of both the reference and
delivered performance counters, and calculating:

delivered_perf = reference_perf X (delta of delivered_perf counter / delta of reference_perf counter).

Implement the above and hook this to the cpufreq->get method.

Signed-off-by: George Cherian <george.cherian@cavium.com>
---
 drivers/cpufreq/cppc_cpufreq.c | 44 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index b15115a..a046915 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -240,10 +240,54 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
 	return ret;
 }
 
+static int cppc_get_rate_from_fbctrs(struct cppc_perf_fb_ctrs fb_ctrs_t0,
+				     struct cppc_perf_fb_ctrs fb_ctrs_t1)
+{
+	u64 delta_reference, delta_delivered;
+	u64 reference_perf, ratio;
+
+	reference_perf = fb_ctrs_t0.reference_perf;
+	if (fb_ctrs_t1.reference > fb_ctrs_t0.reference)
+		delta_reference = fb_ctrs_t1.reference - fb_ctrs_t0.reference;
+	else /* Counters would have wrapped-around */
+		delta_reference  = ((u64)(~((u64)0)) - fb_ctrs_t0.reference) +
+					fb_ctrs_t1.reference;
+
+	if (fb_ctrs_t1.delivered > fb_ctrs_t0.delivered)
+		delta_delivered = fb_ctrs_t1.delivered - fb_ctrs_t0.delivered;
+	else /* Counters would have wrapped-around */
+		delta_delivered  = ((u64)(~((u64)0)) - fb_ctrs_t0.delivered) +
+					fb_ctrs_t1.delivered;
+
+	if (delta_reference)  /* Check to avoid divide-by zero */
+		ratio = (delta_delivered * 1000) / delta_reference;
+	else
+		return -EINVAL;
+
+	return (reference_perf * ratio) / 1000;
+}
+
+static unsigned int cppc_cpufreq_get_rate(unsigned int cpunum)
+{
+	struct cppc_perf_fb_ctrs fb_ctrs_t0 = {0}, fb_ctrs_t1 = {0};
+	int ret;
+
+	ret = cppc_get_perf_ctrs(cpunum, &fb_ctrs_t0);
+	if (ret)
+		return ret;
+
+	ret = cppc_get_perf_ctrs(cpunum, &fb_ctrs_t1);
+	if (ret)
+		return ret;
+
+	return cppc_get_rate_from_fbctrs(fb_ctrs_t0, fb_ctrs_t1);
+}
+
 static struct cpufreq_driver cppc_cpufreq_driver = {
 	.flags = CPUFREQ_CONST_LOOPS,
 	.verify = cppc_verify_policy,
 	.target = cppc_cpufreq_set_target,
+	.get = cppc_cpufreq_get_rate,
 	.init = cppc_cpufreq_cpu_init,
 	.stop_cpu = cppc_cpufreq_stop_cpu,
 	.name = "cppc_cpufreq",
-- 
1.8.3.1
