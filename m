Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932416AbeE3U4M (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 16:56:12 -0400
Received: from mail-by2nam03on0041.outbound.protection.outlook.com ([104.47.42.41]:53056
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932238AbeE3U4I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 16:56:08 -0400
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
From: Jolly Shah <jolly.shah@xilinx.com>
To: <ard.biesheuvel@linaro.org>, <mingo@kernel.org>,
        <gregkh@linuxfoundation.org>, <matt@codeblueprint.co.uk>,
        <sudeep.holla@arm.com>, <hkallweit1@gmail.com>,
        <keescook@chromium.org>, <dmitry.torokhov@gmail.com>,
        <mturquette@baylibre.com>, <sboyd@codeaurora.org>,
        <michal.simek@xilinx.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <linux-clk@vger.kernel.org>
CC: <rajanv@xilinx.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Jolly Shah <jollys@xilinx.com>
Subject: [PATCH v7 07/10] firmware: xilinx: Add debugfs for IOCTL API
Date: Wed, 30 May 2018 13:55:22 -0700
Message-ID: <1527713725-1086-8-git-send-email-jollys@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1527713725-1086-1-git-send-email-jollys@xilinx.com>
References: <1527713725-1086-1-git-send-email-jollys@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(39380400002)(396003)(346002)(376002)(2980300002)(438002)(199004)(189003)(4326008)(2906002)(107886003)(54906003)(39060400002)(110136005)(186003)(63266004)(47776003)(72206003)(478600001)(106002)(36386004)(106466001)(9786002)(50466002)(2201001)(48376002)(356003)(59450400001)(316002)(16586007)(26005)(77096007)(76176011)(51416003)(305945005)(7696005)(11346002)(8676002)(126002)(446003)(336012)(36756003)(6666003)(2616005)(81166006)(8936002)(81156014)(5660300001)(7416002)(44832011)(50226002)(486006)(426003)(476003)(921003)(107986001)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2PR0201MB1493;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;SN1NAM02FT062;1:Vb2CjUaLmYylLXZqnAC7t6HIY1XHBEqOM3PHT9qwNFfewT92Obuu4uIh9WawNsZez9T1jt6l9bjk6XXlgbcpUApLwS7vdnSVUQp+FfXLwjXbm9/wpXgE0JiIfDcrU2Zg
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4608076)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060);SRVR:BY2PR0201MB1493;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR0201MB1493;3:kLQpmxJ8m6YxhbyQxSEovplAdOLWhojNhY6NEBE2+u+rG+4dKLSV2WmxxOAGwVT7GGQRd31ewG08A89y5gk3viPjxvycLkAkn7fFAq2iXixUfG2duqvgXZanrBZJZl0kOr7PKVyRt7DJGCcgyRkQ95Fha7NzTAvrOl9u83WliVuLb2o/HRubLTNEJGPWAVKzhXxByMeLyVXEDyivT+vsyipnm9wUy5ijLsBnuYbBM5TUjHOf3IQV2ruO/TlMXEpatmSbliC4Ppyiu26hj8AuXd989dH/YqtL/Y2h1kPCHpKv8A7bf6Kg3pbQOOm7AEh0PxEA7yp6nPXGuGm3/9zV6qkWI5ASw3LZwmMQohxTagA=;25:tcbVGnix33ZXIn/tJDcy8bpUoKKGTUMHSCBFRW7EZt5v1PIngOF2FfY1CdxXGvSL4ENzGsVcsmT9NFJoMLpeZHO6UTOpK7ZGGuUnysdFUE4mmmpTbBnF+rlvokMWC45jTCQv4540X4edB+1DIO+17vLV3I8ZnPi4vEPoi2iM3Z7qhfQrJI7HXOG9CaV+Tb81z0IcoqwMYmckk0JqPyvdE/JuPBDG3chO3QjA/5QK9wCaZbVVpuCsuyJvVrDEoygyxkx0a00c1wHYG1pa+kxh0iVwC6Ov2D1EK98aT0HwJ3a7nKhPxJ5Q4BObwh5LuLjnkuKjDguDLQC3Hv2e3hVuSA==
X-MS-TrafficTypeDiagnostic: BY2PR0201MB1493:
X-Microsoft-Exchange-Diagnostics: 1;BY2PR0201MB1493;31:ziiwg5KdNL5aGUYtS7FU1iGXVgMBQbO+KNxEjXwkymIFjPXcrsiwaAFnlmmDjpliBoqK1mm+5DeZdzgqhYq6WBgCH7xs2AYKzL41acCsc248QndaOR8zYHZBJOe8S0bRtV7EwV3tbSiIOHydQxlB8EtWq41GKqS5RCSp5fYrtKDZFXhda3p45nbH9pprPK8if98gkf/kVvazclB4Ca0BMSyHyNTAMmKeNyxCj58yw0M=;20:g7JHWY50+SJjrEeEdEwO0VmL2MkJtQCzm8AJnQ+wbBwRKIB4mjQSguUfBJrKRe2oShDYIzlhzfy39paGbT9l6697n9TjVJN3YYiLSUablL2Lepwv79vmb/ei7XXKJvpuyT6ojgiF0vkgXykH9AlyV3Ss8/EFyKqB3ba9CujiwOKYsV42NecN2KKcibZ3XGlb2/oGnbDCueK1ZWQG7/gQv6TX/35T44u/n8C/x9roAmUh4usppthHZkt3t76RMGh6bDASFDzWvbI91FWWaGOdFrc64j33GAwdHXZ+wLXa4yNicKms74uF5QtaYXutaXowhGbgWyHJzm06h55V3zJ7iPUqMjF+GfeD10Uxq/SHj55G47pD5GowwJT00p0yUdK8BiaYERdTSPCkdLBVC77M3oJAZ2aaUPyNL7UHo/B6AQXX4QQ7uEUPWjCCf2v82mxt7/nuddKmTsX1p6XZcSwxFWFLPzyo25qNSNHqaDVFG6D/pOZfbZLReiEGtBnvjMAd
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BY2PR0201MB149399EEDE724CD4F8B45C3EB86C0@BY2PR0201MB1493.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231254)(944501410)(52105095)(93006095)(93004095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:BY2PR0201MB1493;BCL:0;PCL:0;RULEID:;SRVR:BY2PR0201MB1493;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR0201MB1493;4:Wo6aZLsjuaF92htBE5CkG8iP1TIgeSxEn1eQrUtaQ/Tfi1gyVYuRyfw01c/e1R5CeuZthTr9y7mNmyPTNW2etNDUId7D6p6fYhnzsDjDyGDeBeDy9lQOpTbFSzJmLZZAUfCLRgEYh7PCWi23qn4FdS9mK72X8HNfinGnarmU+Sy7SjnoZeP+7hoIGtGO0Mvjmq7r4jCb4txZQNYm1uMrfSj2HdPQLRr3UhbQYqEiBIll1TsrxeTWrefWGEsVYaoG84eRW1ULI3iUaepJW2gchtFPNXsaMbqh04RrpmCureZhe9K7dmdWVyarK2Y2YImF
X-Forefront-PRVS: 0688BF9B46
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BY2PR0201MB1493;23:G6FJ/kpG4sEnveCEazSmgm+zzG7fTt6dD1KEkuA?=
 =?us-ascii?Q?3iFhh6xZEWrqgrBu2HbOVjE3PQ4qAL4oeDD0HEAyuhZhMtk+SQET45V81J1q?=
 =?us-ascii?Q?pTJLFiJ8UoDnz8BiMK7afwGhjXvmn6r1d8Zmu8kgBbu0Q10ywzqGNF33wpqt?=
 =?us-ascii?Q?CX0FRqoVJBAMAjCrnboxeOqxPtKRqpLCsyGj0XpNtpaFgRev6mJrKa3rMH/1?=
 =?us-ascii?Q?/l1xLn1G5qLYA7BrcmPrVYzG4lvHMaV3HpRhC9IwyTi71ZfR7nLv4uKnCHFQ?=
 =?us-ascii?Q?ZEotUUsPmpwjVjEIJV8dQC9afG+iYk2itxPaTOsB6DMXLWH6U/tBVvEHBUYn?=
 =?us-ascii?Q?vqhNnka0fH7c9ZQCXvxLEEe5FHHcsmyoDe47rZnivyCfIilx9lwYNzLUoo38?=
 =?us-ascii?Q?qLbLVEA+0wMUZuB8asJz/M90QK2/2Cxhc+k/0Oyedj7FcTeR7rMt71gelI9z?=
 =?us-ascii?Q?quJ2ZoJL2YsxrGIN3JdnCgZGtc5RcKewWaV7stUzBFUnDEpz/cd0MIB4HrP2?=
 =?us-ascii?Q?FsM4KKMT8fejtHKCP2OF4TzGWo5eAjIQtG2ZsKIhBHrneTYOCe/Y36WKJ3D0?=
 =?us-ascii?Q?PMau3yzQDceuQfZr0g3h7fAl6UnXsQiyAGxmZjhYJ7/IwCVrb5yuYtLAKbnQ?=
 =?us-ascii?Q?Rfa+H0Snv+6lMdUhhkyoHnBhMe+90jRDvuJlscHRgCdsxPCrotQd/LosCVM6?=
 =?us-ascii?Q?Kls41tLknQI7C+8Yh4XsFu8cMaDfvc8EL1IJUQA777WsmgoZUmQKVAKvR9/V?=
 =?us-ascii?Q?7ZuBxndKeX5TMCfaGHqweQdlfoR5gUCF1ELowqkQUyOmDeYT8Ov6+aIdzRMb?=
 =?us-ascii?Q?Zm63jiXr24WFeUKL9gxZXUL7ca3r69yyFZIll6g9hHVYQnATK/T34Nz4do1g?=
 =?us-ascii?Q?eut2AewqwSZ4T/EGb6NnlM3lReCh0M4p+TIKtPkG6eUE6ORIoFaDWle5bSQD?=
 =?us-ascii?Q?kf1dvI/R3MuXeDuvQcns6Y0pqtkKHWwzKr3UYhLIgSTuxPHaH53el7ZY5piN?=
 =?us-ascii?Q?BB1TH9DPz6Gl5TKDKDRvYTqX2YkMsygueh3/hHqe2Yy279BYPU3Fu0CfKA+I?=
 =?us-ascii?Q?dpBYTOT9GKKV7UAmCwImiizQW4yNiH01Oq7hFa6+O5xZxeKzyN8ALHkQG7gk?=
 =?us-ascii?Q?QTm3ZxN6YL9JBo/eF6HanXyfzCPitG7cDDF4qyZaI71nRisF2zEKvCHu6e3H?=
 =?us-ascii?Q?b6PJYPgLyvjxcsGdw4kGJMfj9utNns82aobu1cwyv27qynGHYiOE1Mb53438?=
 =?us-ascii?Q?ZkS3QuY9An32d0KoAlXDxKTWv8ihyJAmswZ2BQ9ryyDVCkzB1o7OrOMfhKKM?=
 =?us-ascii?Q?XKw=3D=3D?=
X-Microsoft-Antispam-Message-Info: PBfZuyD590TeYIRqym9aZ+U7x7elwUTs1qG1gFV0ROYIxGU3myp35dY0anGwvLVIC3zkB66dChbMYdQDf3IwmlT/KXXFGrC/4u7l+ldM/ZBS+5nW4mYvJRT3CUDAr6wWwFOFS53cAuIccj8yfTnCwLOwcGzC/dJ9BnqcpcKHwAdrKBX3vQKktL4ygHETlLIW
X-Microsoft-Exchange-Diagnostics: 1;BY2PR0201MB1493;6:dUddvLRqVCH6qaR2AHdkTfNUcfWT2WaNDuDkYlPGC/9fYuW2PyOxuzJE/6BKCD19AUB/GtAW2bS3R4te0VeI1m2FnTlOuJIvaN+tIrXtIprbXxLr+IxB7H7eTTBo/P2IqoW+msbTdgvBTvTU1T3F+yTuV+PQd5EqdbX2Jhk/JkFyHQlLlWuAE1ZgZX2CUhYqSN4QLtaYtnjwwqF8G76WcQ8tv8Wa+Jpn3r8Dd0C62vvL3t1b+uCL3vkSoI+ECCgsWZO2POzeSBQccmrWsrbv/7i2OUCSn9nqfqmyWT44gvBvqIpsiit/qDCqDNqVxwTf6Ji4nFX1nWBTfkqsKUFNMlfVOXqc3QRew2r0NuVxNhlZK4Zva6LvUXzkz5K22qMiKEXeFj08b03s9EldLb5MNL8Q1Ceetm27lX6NTcLtugVCVmcb/+Wbi6NxzdPTyGr1RMTOrSNOaOtVvBdmpwNtJA==;5:GrD/WoU0dBIQXSZTx7ClLk/WkKwuXggJF5JwTejQBCvGQOzFr6fVO5ItYxPn7tIcjLu3Hf0IJbVggnqcGaSRTjywugkzGu/WhqwxZKf/ur9At13Ub/WnYN3caS7vUxNFgNbwyqTZMHcbhJj30gB7hrQEf/Orp6V8aQzBFWWeQMg=;24:ZbtL4ttObHlXksPfTttoGsEYvm1mzvoLQl2/5vdWLEW52dp6PoU+2n9LwaSDL/EpRIuT0AXVmqe5uKLAtAIsSXxZRNmj5GuBn2kAeJUP6R0=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BY2PR0201MB1493;7:abxqjRySaW0myKGlgOHd32mFkdiTgTGd9xmz1iXFEjWC5odqQzuzRrS4IGpv4WScDej+mQl50vp7iYKS/dyWoZiBWxLFUXrQr7gehovCPGlxf2WkQeACc8zVyoQGmVPVRFVb4HveKvTn5q78ijFcK2y/TVGfNDwo8i6K9kkCX5NTPcX5eCU0hXyM90CuMRzh57QhwBB0e/k6Y/XIgNOiDvaLDAnRph40HEr/aM6c9iKOQPuKXiKuMIhfbSI/LdnI
X-MS-Office365-Filtering-Correlation-Id: d7a5fe4c-15d9-4307-b40b-08d5c66fc29a
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2018 20:56:04.5756
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d7a5fe4c-15d9-4307-b40b-08d5c66fc29a
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR0201MB1493
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rajan Vaja <rajanv@xilinx.com>

Add debugfs file to set/get IOCTL using debugfs interface.

Signed-off-by: Rajan Vaja <rajanv@xilinx.com>
Signed-off-by: Jolly Shah <jollys@xilinx.com>
---
 drivers/firmware/xilinx/zynqmp-debug.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/firmware/xilinx/zynqmp-debug.c b/drivers/firmware/xilinx/zynqmp-debug.c
index 4800366..148dbff 100644
--- a/drivers/firmware/xilinx/zynqmp-debug.c
+++ b/drivers/firmware/xilinx/zynqmp-debug.c
@@ -32,6 +32,7 @@ static char debugfs_buf[PAGE_SIZE];
 #define PM_API(id)		 {id, #id, strlen(#id)}
 static struct pm_api_info pm_api_list[] = {
 	PM_API(PM_GET_API_VERSION),
+	PM_API(PM_IOCTL),
 };
 
 /**
@@ -95,6 +96,15 @@ static int process_api_request(u32 pm_id, u64 *pm_api_arg, u32 *pm_api_ret)
 		sprintf(debugfs_buf, "PM-API Version = %d.%d\n",
 			pm_api_version >> 16, pm_api_version & 0xffff);
 		break;
+	case PM_IOCTL:
+		ret = eemi_ops->ioctl(pm_api_arg[0], pm_api_arg[1],
+				      pm_api_arg[2], pm_api_arg[3],
+				      &pm_api_ret[0]);
+		if (!ret && (pm_api_arg[1] == IOCTL_GET_PLL_FRAC_MODE ||
+			     pm_api_arg[1] == IOCTL_GET_PLL_FRAC_DATA))
+			sprintf(debugfs_buf, "IOCTL return value: %u\n",
+				pm_api_ret[1]);
+		break;
 	default:
 		sprintf(debugfs_buf, "Unsupported PM-API request\n");
 		ret = -EINVAL;
-- 
2.7.4
