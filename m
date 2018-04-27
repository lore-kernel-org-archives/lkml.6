Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759390AbeD0VfK (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 17:35:10 -0400
Received: from mail-cys01nam02on0085.outbound.protection.outlook.com ([104.47.37.85]:62624
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1759374AbeD0VfG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 17:35:06 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Suravee.Suthikulpanit@amd.com;
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: linux-kernel@vger.kernel.org, x86@kernel.org
Cc: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, bp@suse.de,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Janakarajan Natarajan <Janakarajan.Natarajan@amd.com>
Subject: [PATCH v2 2/4] perf/x86/amd/uncore: Fix amd_uncore_llc ID to use pre-defined cpu_llc_id
Date: Fri, 27 Apr 2018 16:34:35 -0500
Message-Id: <1524864877-111962-3-git-send-email-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1524864877-111962-1-git-send-email-suravee.suthikulpanit@amd.com>
References: <1524864877-111962-1-git-send-email-suravee.suthikulpanit@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [165.204.78.1]
X-ClientProxiedBy: MWHPR15CA0030.namprd15.prod.outlook.com
 (2603:10b6:300:ad::16) To SN1PR12MB0141.namprd12.prod.outlook.com
 (2a01:111:e400:5144::12)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:SN1PR12MB0141;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB0141;3:2Rr+4k+RzEiMm/QbpCcjzxPsQnB9bDD2eYrSH4vgxwsG3dGoftPmB21fLsRx2QvUyebFcVl38hXAca+yfltRNFAAuy4JqWpgAVN7F/Q5t8oym/oBAzSvhF2ttSkEQQ9lQCmwdYeYvmnNfnFtrC3N08uXjqhQczDyQCiLmhWwqLxs5KTyw3HvV7lJbz1jxjzIfZlQy49ssczAqNYynR0enzMuw8z+ENbcGAoMJckLZFveoUENFkBntpak+Mgp6ztC;25:lwtJs0TATMRtgJdt0zA5x1GJjVvglX6gT9ug9yCrgihnGdNYCIJYHtxg8JTV2EwOsmUlwAnxpF//GCYwGi+2XHmNDfekTR9WlGSrpNKAv/gu9dNV8tsZNaR24mVd6V4ZZwfgHecdOEy78z1NV3vFz8hCjuK501L2fTUBL5WHZ4MYmnJXbTGPY9OO9g02y0UwpKZT7SS/8FNIa39XNX6JZeKXx3lq/ZK64ZXDFBIn3p3eVix19k5HvnJi7RduZ0Y0knk7A2bmTkEObqhK3ry4PJz98s8nhezC49AKPwo+boin35LzdqCyf+4dFJBrD88GaIQnKKUMW+sVF9KzN1lSfg==;31:/nZhgkOYYfH/96KEisVRjGoSqZeT666FMlB9rHD/hIObyc82bTqalF/7hpk5y+LPRpTBIcx1HEzz6sYsBnBocXuz1IGFi3OEKBfNByG3smQ0W/84lUe0rRDwdsxSefa+EILY9/4B/DV9rzeOMedRDyhhdPIQfDHuYHebyXO5lWoHt1ib1zrNxeDtjgKyprr0dk+n8JQRjqF9RaeK8TxPABjqoSfcom2QXrRTuyKMRX8=
X-MS-TrafficTypeDiagnostic: SN1PR12MB0141:
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB0141;20:XTsoPEArMTDgkFRBjZGBis10WssmN6r7Bm5CdFUIfqGkacJG8O70v6OWJO4og5v9H/wy709XL/6OaGGPJE5VzCiLEw239rYGS+2ZIudDbVOMtrCmQ5EN1+SWey6Rx5n3ipCEaHbyZAUGC6TCcHVp3y6MIdleyiqHOsubAmFGnE52ohp0fPhvUJt4xinXNXLT+MMWYUpdm5Dz7n3kcSO81yyNy5Lv+SXKYQeTi/a8fv0364KC48dnk1b1WufWtE5Wt5mcuRMR7JPDKAS6AVPHDszJME9ONogjTrt3L3d2aJSPvDH4g+Je9OgiwBNiF0wIhBAxal2jUQqynVsRbb7Tkw5js1kPtY/zpZCT1maQMZg6ATJM7EsUxXzldU1TPhRqzv94eCwAkM7gv9lbGIzc7XJ2kIOTeB0eNzaoGd7OtXBVccgFQsDABRex7guHh8tZzu26l3CcuGA5M5JxkycDk3mYRLhGbhwoeKhzu3TLnG/4QnFJHV72qLfkmwyyi9Rx;4:FQTge9jucLcADD9WhP8Kj/9UMMV4IGAaqAHaWmDVR0ODUqFU/31knh0y/j+pzhFPZe3rKBbyuiJw7ql7n08Xc1Tk6lPzgRRQRNnMooRCVQ5M7DPZWAuGwZLO8blMq1WgWMTivtx80i7cmrRyW2R5/r07OlDqBlIDHlYBQ7hKbfkck9+qGjimyNQ79PM4F+jzD/qQgxMWUbEKAGkCDu2Le4cvesHM+kWPWTm+eYlum64siauEjekJ+g0mV/2a4jSWbvMgif5Xj3yUrguliD75KPYAPi1k8YWUF9xT2vx7Q2c8ZK7UWqECERE07QmX4MmE
X-Microsoft-Antispam-PRVS: <SN1PR12MB0141466EF878A3B4E1372A19F38D0@SN1PR12MB0141.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231232)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123560045)(20161123558120)(6072148)(201708071742011);SRVR:SN1PR12MB0141;BCL:0;PCL:0;RULEID:;SRVR:SN1PR12MB0141;
X-Forefront-PRVS: 0655F9F006
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(376002)(396003)(39860400002)(346002)(39380400002)(189003)(199004)(478600001)(956004)(72206003)(446003)(44832011)(2616005)(486006)(11346002)(59450400001)(6666003)(76176011)(97736004)(2906002)(52116002)(50466002)(26005)(3846002)(6116002)(51416003)(7696005)(53936002)(476003)(48376002)(6486002)(186003)(50226002)(68736007)(81156014)(105586002)(86362001)(66066001)(305945005)(16526019)(316002)(81166006)(54906003)(7736002)(53416004)(386003)(5660300001)(8676002)(16586007)(4326008)(25786009)(106356001)(8936002)(36756003)(47776003);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR12MB0141;H:ssuthiku-ubuntu-b2.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN1PR12MB0141;23:TrnaNyUnpDOWIe7O5Xfh2Gz+XnIawzLZWITNsw8KW?=
 =?us-ascii?Q?I7/vfxujiR7WxyEAkHDZk6XfSJmgF0JhRoJUkMDZGbDCVNztwKm9qgA9fdSZ?=
 =?us-ascii?Q?1uGbI0BKtNG/ie+3GXh6nJQM6/yocqHJRqsWq+Hm8PWb+TbWDJuMm036yd9i?=
 =?us-ascii?Q?FTlQdpITM5fqTPqf384We8sP2KfLvf5MUUO8Y5LNJtSSG/uf8Ev5kjrwe4Yo?=
 =?us-ascii?Q?BBRSyBmUX1jgGaoIMFT9kBZy3WEawR9IAwCfwa56Dgc7CIhz2rehRy9WIpeK?=
 =?us-ascii?Q?B7bU/DIuEptIFudm2k0ip8B7Rl04lMtMBs2FCEkqP2fXYXOwVT8/qUEAfUsh?=
 =?us-ascii?Q?jgj17rK4TJM4eGPFzr6grqkq9LBRteHhM6lw0TW0KRkoRkx67V56Hr2XD6aI?=
 =?us-ascii?Q?iHmz3jog9qWqVP8Mr5M5JjlV9exrhV6j17h4ghI899OVwUnVvsOnd0/1B1Zr?=
 =?us-ascii?Q?4ylY+o+ldECZFz159wUw/BK2Kg04C/GI6jbVbPoAmL2eI8kobdNXssWqwSQ/?=
 =?us-ascii?Q?5n5kHlZGrbThbScIB+7v0vDlNtRwe/vyPhXKvvkk5bsga7tr6DcjrXPrrBhX?=
 =?us-ascii?Q?82A+c45xjX1gaY7tQdc+PsSw83kSRw4GWbf2K70h3xOTLkEfRUzQ/64Dq4BX?=
 =?us-ascii?Q?lRhTg9JNy7To1XvII1cqK0DqzwCzDQJyLwBKEod8JBEXf2r31/l1nHKAc7bT?=
 =?us-ascii?Q?0IAfZTSj0Wfe5WjvcVq8ldhQNY57kDEKfWBWVJakseIELl8PwKR9fcALuCZr?=
 =?us-ascii?Q?Se3vMw2gSjLSjG1lB6y9iiDMgRfahh0BdThDWu2RugnPRv5hODUCcwKixFX3?=
 =?us-ascii?Q?QJjSfwy2NcxAvP9GbnkoZPZ4cRt0Cn4uC9NXhFFylu1UC8dtY1C6hJR2j4gX?=
 =?us-ascii?Q?V/d+nUQ2LtrUarxjDlehkKxY9aVXvDpWaIIqwazQfcyWyM/L45fLb6qrHRk+?=
 =?us-ascii?Q?r0XXNaAISUDPt0m87sKwjPkCSpTxwMwLYbbHw++8n7PwdoS1Y2cV3UUKlHGd?=
 =?us-ascii?Q?G3lgP6teKDHHAEt1QdsqD81jkC5yHWYPVKze2/70ZxVQfNNrkllagTUMXG4v?=
 =?us-ascii?Q?gOpgRCnzrjl2n4UCypmDwemO1oFEyJCk7suFp1CiaSIDZ0MVGPtioAhFsJsM?=
 =?us-ascii?Q?W3b/AnkbhQo8t8LZZU8UQTBGXxSl7n/udiWegUqfrYCAWZW7vZXNwJy4/+6u?=
 =?us-ascii?Q?HNWW4xnEndkCIjlos+t4MrLw+Ok+Nb7bCW79hvkorjySzoNGIykGyG0hpY80?=
 =?us-ascii?Q?BUTr9xZ6Z8YOLXqwEs=3D?=
X-Microsoft-Antispam-Message-Info: od8En6ucyXUqJLdOhrKbC93azF9UGQeOVjp2tGpCzhJoc6qtEF4IhXQ7BmFaOkPadLZapPWkqr3eVWgkwRs71FYFi6L1J++N2QxA38mNUAGduuew405JyWjUPqOpeH6f307I/SX7OCaj0gC9J1GtNwQ3v8yDStU37EdKJzCFPVuudDTNwRdCR2E6H/UGeQxY
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB0141;6:B9G603dxvRhNm1trJOah3ONDJlA8P+d1jGBCCeo5BjXU+BhDCGyeJ+G4fCW3C0dGnS1+JeJycqmW2JcJJauPZdZie2k/YYjl20ezCHH6j9AQvFb+ja3ZIkymGYVWWtzhObbdMGKsW4MH6CASwFvhdXOeQTvFgby9RdjMqmlj7OTzsFEfJN56yw9g608tY8NnToQDA4fIXYReD45KSRSrBOnkULmBRbtT+tnbA8A2j/WaovqT6ygd0cU5DyLcGH2Rh+t8gG5nnilk4vF2feZ+PlC1BfNsGQIrHToAKSnNwo7E43y4cwTBovRD38FcwYg3y1rGWI5NvsBxlPu9DPB1B5MlJ6G4O0U6Jx527mGqsfHLJCyXZrDSU9nkxVPo8cfShhO7h5uamGZ3lGYI6VA5Yk9wLtBAYR0GCtN8INh5npPc2EPFrL/XTb6XUyhTYJ7d6xOavMedIDC48QOB9U1xEg==;5:I42rgM+BQODm7k1OINxKf4fQ4oIwRDu53EXmSM//X/o3TJ9+ULiidV4QsZ2mkdkhaMniVUqf+GpFfwi5Kyv0yCM8F8urFx5HaZmOrnLNtB5dZ2xiugZqnt3xHWDUELZpqrnZg7FDca/tCymPV0rTMrbMOpkm7CLzDB19L71ZvRY=;24:H7Z7A7K/rvjJfD4vE/1Y5XGyj9xR5vvCPNE8s0o8FY+nMS8/Lsdof1FqV66rMngUOiGa/bUxapY2fTLcOMFXnzw/EdapYn1B7SiX8oJmip8=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB0141;7:QmMD6HTLutM4T7duJWYebYcY4LHx5P9FkGsihnr0WoERmy7OlRi985CuS/Y/HS+Yv9CorWlbajnyxKJ1rzcpSfl0AGOXWyl9QG1DU0bSbqnZBzZai9AJOtiTyzJk41AHRfRdyaDjvex9WkeBPKuTKhi+xto3YNGL9INcQrSa+4Pa+C9w2TbawCgj7exNz6VpT1OIgUVEm+MzGMj45MyRpRSc3b+OnaueByFnppNMpZczMdHPszEUquhMWhVo9qSY;20:G3ShXGLdGTHDm8PjXg6nbBIQ5J+5SIMmuMd9Sc1xkfB6OdvWSjjo20Ssrbq5vUPPxHxhjqdKN/zftnnDNiOgdXAfvBrBXLOKBVcbPuONEywGlecmfpqH6OemtLsTJm6DZ3pOFa7gWe4aJQwKHYuKHjGBDXoGkATN5wjPOboJeqZjZNzLHqmwzHtF7g8H7DKPOcvkbZVjB5v5qt6Dq2SB5xUvmGA8hcVhAdOqmnY9NP3HakYktSiJyRMwVgSYmwsc
X-MS-Office365-Filtering-Correlation-Id: 98101443-c8b8-4fbd-85bd-08d5ac86bc24
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2018 21:35:01.2554 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 98101443-c8b8-4fbd-85bd-08d5ac86bc24
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB0141
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current logic iterates over CPUID Fn8000001d leafs (Cache Properties)
to detect the last level cache, and derive the last-level cache ID.
However, this information is already available in the cpu_llc_id.
Therefore, make use of it instead.

Reviewed-by: Borislav Petkov <bp@suse.de>
Cc: Janakarajan Natarajan <Janakarajan.Natarajan@amd.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 arch/x86/events/amd/uncore.c | 21 ++-------------------
 1 file changed, 2 insertions(+), 19 deletions(-)

diff --git a/arch/x86/events/amd/uncore.c b/arch/x86/events/amd/uncore.c
index f5cbbba..981ba5e 100644
--- a/arch/x86/events/amd/uncore.c
+++ b/arch/x86/events/amd/uncore.c
@@ -19,6 +19,7 @@
 #include <asm/cpufeature.h>
 #include <asm/perf_event.h>
 #include <asm/msr.h>
+#include <asm/smp.h>
 
 #define NUM_COUNTERS_NB		4
 #define NUM_COUNTERS_L2		4
@@ -399,26 +400,8 @@ static int amd_uncore_cpu_starting(unsigned int cpu)
 	}
 
 	if (amd_uncore_llc) {
-		unsigned int apicid = cpu_data(cpu).apicid;
-		unsigned int nshared, subleaf, prev_eax = 0;
-
 		uncore = *per_cpu_ptr(amd_uncore_llc, cpu);
-		/*
-		 * Iterate over Cache Topology Definition leaves until no
-		 * more cache descriptions are available.
-		 */
-		for (subleaf = 0; subleaf < 5; subleaf++) {
-			cpuid_count(0x8000001d, subleaf, &eax, &ebx, &ecx, &edx);
-
-			/* EAX[0:4] gives type of cache */
-			if (!(eax & 0x1f))
-				break;
-
-			prev_eax = eax;
-		}
-		nshared = ((prev_eax >> 14) & 0xfff) + 1;
-
-		uncore->id = apicid - (apicid % nshared);
+		uncore->id = per_cpu(cpu_llc_id, cpu);
 
 		uncore = amd_uncore_find_online_sibling(uncore, amd_uncore_llc);
 		*per_cpu_ptr(amd_uncore_llc, cpu) = uncore;
-- 
2.7.4
