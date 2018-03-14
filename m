Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752171AbeCNNic (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 09:38:32 -0400
Received: from mail-he1eur01on0042.outbound.protection.outlook.com ([104.47.0.42]:55200
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751408AbeCNNi3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 09:38:29 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=madalin.bucur@nxp.com;
From: Madalin Bucur <madalin.bucur@nxp.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        camelia.groza@nxp.com, leoyang.li@nxp.com,
        linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
        Madalin Bucur <madalin.bucur@nxp.com>, Roy Pledge <roy.pledge@nxp.com>
Subject: [PATCH 1/5] soc/fsl/qbman: fix issue in qman_delete_cgr_safe()
Date: Wed, 14 Mar 2018 08:37:28 -0500
Message-Id: <20180314133732.24068-2-madalin.bucur@nxp.com>
X-Mailer: git-send-email 2.8.3
In-Reply-To: <20180314133732.24068-1-madalin.bucur@nxp.com>
References: <20180314133732.24068-1-madalin.bucur@nxp.com>
Reply-to: madalin.bucur@nxp.com
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.88.168.49]
X-ClientProxiedBy: SN4PR0601CA0024.namprd06.prod.outlook.com
 (2603:10b6:803:2f::34) To AM5PR04MB3267.eurprd04.prod.outlook.com
 (2603:10a6:206:d::20)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f0f75ed4-01f4-4864-5ed6-08d589b0ddaf
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:AM5PR04MB3267;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR04MB3267;3:MgxEEousZxnatKHEwwfoshd0YeyFtFKoRIUFROaGLdHcWIxPCLP0HoPZ9jHyA9LITReBk/pQDEMcP/zJcwQk0x9Lqpma7pggsBSQyU03qe+FtvSjFcGOJhs05KS+d20yzocdbpfUKxxsnkyB77aEWBRQlzekAs+LQMH+yOx5SF2rW/vN4iLfXZuMTZ960jy7/dqmMLpjNcpGOD+HoDq3CmkwtUHmCZfSQr7w5TJBrtVNI6/yaXqoVj7JpGG+3vAw;25:crhQUbdRv4HvWgE09MgULEPp3VQtVhtxsj7vfhS2jY6RoEJqyZGhBFW/jDxwljs7rywjwpt0ekgcSUXU2d6QPUtCnrFMdOhg5TRcPOyFyMQBcAfEuzyTTFLpswKhI7+rSnm66BKlOmckbNAnGpBOh4NZzMXVuQD0As0ZEP9klPUG2stRR7y7qulGDWrFKxvwzJdfAMms2+KMjEaANB9sjaCd+3Zx3dz951ByTr/CMwfhTlqe4vntXyV1xBmYEqL629V/MYJ1mm4CA/xT80vPbixYRzLSnYxBoqMhxSRrchmPBj+xVx34wF3p0XChEXZ64uZ+CDBoiyH4GGznaMv2PQ==;31:yTGDSyHLikBnuFqSaId1DwYbiDWGw1Dvwym4GzbzOPsgiq5puLicPSVGfG/GnVvVXyHWUfyspIEWP6PbcOjEyzr0m4Zts6mdP3Cgb5CAWcb8r9GIepC3qi+IpMddcLFUdfoJsXmWLmLQwU/+frvXmZ0xJ/ZRGzrf+il0owiuQf8LeEmC5ZxP3IdPsWKNVFBXnVLdXxFM2tYcfGAbEBIwKYwXRJzW+cdSDtmXj08so9Y=
X-MS-TrafficTypeDiagnostic: AM5PR04MB3267:
X-Microsoft-Exchange-Diagnostics: 1;AM5PR04MB3267;20:Bvbkt4OX1bPftrP57yaZWYWXw2JfojV/1m7KztxKzzmCFhbODwvC13aBHSQmj8uHCAHbSw0P+gzVOY+f0w4qk2bMRkEaeH7S+U9LX6vDgKiBFA+Ebo6gu2v7PGmSuP0eQW1tuuBXOwWi3hdYd6sCMGPgGy+rQGRs/ZCGP1zFZ7E1JsYhE4ngyg2yknEVD8kYq8+N0+O3mLq1xneLbeMjMwjPMBp0LDh4cMWHfqb1m+m8uARZ2LiFvINpSySDu63NfnhNe0dsVrcA3CVVkbqLdD54cmF3r7W6S/dD8Fe8BkxktMRp1Mtio8azlz0vA3lFO8ieUXX8mFTHpQV96IXPvhdUf4CXA20QwDr6v4f54tQFx0AwluJE0ZaGaNRoC6bQubSyhkduXQdH3e57tCREqXqihRThfdg4cn3LpvCceueO13EEWccBU0mg17MCK+h4UhhZK/RpwLbxLqBhNXwOh8pXmRMmr2pxhcmQ3JE/srEr47R+VQtuVrV8ZgPLtoF1;4:Ppb56+TgqpVbuacPTIDgAXQLoXgG0XliOSjrx4B4Urr4Y2ytF7Y3xzl/XH7H5YuIA/pAGi9G1QyvZMJNikTXD8bzbrHA1OmpoSPlC0x+e/g+iyCPrcVHFWmgPI0H+UXB+VNEhCRYaRh664dkA3BkTjoR+IQ8hWi12BeX6YonwwfwObnHtG+yq32EXO1XljUv488Kq+o9txd214exJIuQp4cJunrycZWgz8jYwdCn4dsK5SboHsOj/Kq3/AfwYVgt6BZO/TJy16M/rnhtI0K3A+QRiS12gKNIvtxKBvbN7PDxd0/BNG9GH9lhbowN1Ht6
X-Microsoft-Antispam-PRVS: <AM5PR04MB3267C8B5DD20A90D3A6D8236ECD10@AM5PR04MB3267.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501244)(52105095)(10201501046)(3002001)(93006095)(93001095)(6055026)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:AM5PR04MB3267;BCL:0;PCL:0;RULEID:;SRVR:AM5PR04MB3267;
X-Forefront-PRVS: 0611A21987
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39860400002)(39380400002)(346002)(376002)(366004)(396003)(199004)(189003)(1076002)(68736007)(7736002)(6916009)(47776003)(4326008)(8676002)(2950100002)(316002)(50466002)(81156014)(25786009)(81166006)(66066001)(50226002)(305945005)(3846002)(8936002)(53936002)(6116002)(36756003)(48376002)(2906002)(16526019)(26005)(3450700001)(2361001)(86362001)(186003)(59450400001)(478600001)(51416003)(76176011)(106356001)(52116002)(16586007)(43066004)(6512007)(2351001)(6486002)(97736004)(5660300001)(54906003)(386003)(105586002)(6506007);DIR:OUT;SFP:1101;SCL:1;SRVR:AM5PR04MB3267;H:rhuath.am.freescale.net;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM5PR04MB3267;23:dtLw8xp4E18tN2ykfaR85BrCwSxWtWPgALl9RE1U1?=
 =?us-ascii?Q?zzS7V/XeOcQaKDufwdVMZD3M/40Xlz79FMSf2p9xDFIWBT/KMgiSCqzygHK9?=
 =?us-ascii?Q?WqLJx64zsC7FbuJYd1SfIg5xEm8gchqKAhhMUYLDnWC0jNsILmvUXABcXzSM?=
 =?us-ascii?Q?XV5TG/yxEwp3ITIN8Ha6mKCIusye7A2QCKeCkKrkaFHzhuhhWbvVsc+HoHF9?=
 =?us-ascii?Q?qV3TifH/OPF5cr8VNJVQ6CEWE0uGM1SLsh9mglMOlylUUQcnXnOtgn8MNrU7?=
 =?us-ascii?Q?WSrFXPfrgh/emhQEeKfxtDnZDj+C3djteJPlQGQcZ7Z0WLfa79ujZ3XLrr2E?=
 =?us-ascii?Q?DPZ6khuEV9DKuNyaT221AvNhCtzOm3Ct56nBnQRj+HmnSG+i0H0I5n31y3un?=
 =?us-ascii?Q?6WjIZbR1tBEb1ErvSAFqyM4kEhJnVP+OR90lKqgGCm/8PlTyJM5QfIdCXbXL?=
 =?us-ascii?Q?Ow6XIjIWbXbGV9Gc69F7TD07Hdv8BzxSn4UFlJ8RJJ7YGVsR7NwZLmC6wmOT?=
 =?us-ascii?Q?L+bU2kR9vAl9CSW9VSeb4MSLHYlTXp8nngP9sdDMzrhyLRs9187wDuRPpWjr?=
 =?us-ascii?Q?uIfONiVWuu/gsrr5b1xY4APvMYmds0OIL/U7SuCoEXEB4bYeRtP+lHOC5zFy?=
 =?us-ascii?Q?8azA+65jTWLf4OAki1+rts9hWw3E5Y7Ro6fRnHFF9fp7Rhzt2k9EdF3ocapl?=
 =?us-ascii?Q?932USjJsK3lXCiyILwwvlQ00yKBdxXv9ZA3jRNhHaR6ZLbB7vOHpmgmeJiOS?=
 =?us-ascii?Q?jbVM4DNERKSBMjCA3TqZGkoXeIFSJ67FfwikWM0tQznm2M1zIflEvULGkpsO?=
 =?us-ascii?Q?ya94iIAzWlSxgguew/SPNDBTjfwSJUskMp48NSXUOiUwFKuIGoPdkAbHMH1q?=
 =?us-ascii?Q?RP2UmLuhRFfYux7EaD/BytrME4ohIK7BevhXWBHFXDD13rPe1dqGG6ECYkSD?=
 =?us-ascii?Q?lAOfz5SqzJVhzJ0qywmVx3DY6GzvNDB45xNSeSofzrlBgmwqLHyhOYw8SWHj?=
 =?us-ascii?Q?3uqApowKAF53tLhj2Z4KTDsIjerOqelHr7A9wezSn8STfN47PVlxSJdx2Tnr?=
 =?us-ascii?Q?MC7px+Dy3e5fVnx6iD7+oujv1Tx3boHg+EMui85QcyU202s10GTwP0XWReIC?=
 =?us-ascii?Q?Ia5Ngw45UIPWLreRRQ30u3zHyQqoJ+LUvepSSC07S6OinQ4lCSwdO9Sn8TJy?=
 =?us-ascii?Q?oHLpCWwTmI0VRvmwVxWO3p3SQGLt2UFxsU3rAuZhPeFCidIMmQtfqBQ5g=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Antispam-Message-Info: P/0drxJDNaC9IXJVwqiOC6IRyGUfDs9cAT7vtAaQtfqXStwC7vMcWOjSmO+sbEH5rpCYffzisLIKQvaWj/Yib5kujfcnAyXLaOTboBjj5GkFT1T8aS2ADuRVLJwNoWt/6ods5aYNKW6tXy+YFMh1Y2feIUEL/FjwWnpveW4NPnTv4VC7Y/MqRkqKXkbikEez
X-Microsoft-Exchange-Diagnostics: 1;AM5PR04MB3267;6:zJLS7psq8S3xxJ35Sg5SuACwz8479z58M4g+UtJsKkFEQwBAHvm1wom7WFVBN577lvYhf9qcw8CoROrKv30qgvxytmMnJFxt+9s4qBAbkIB2Sn9pjf9sXZV0ODuyTGvHB7o6PHVcGuuHSC/WsVRiIvkoyq2Gq3LDzzrBkWLJ1WRwMAdMKa2PkwOLtBipj1OUsaDLkhlVpFbH6Q309RBV/+42ijg7eOZRJoMUUOnT0avKH7W+EVPywMsFILoheMQwSZ4uEsCdOa232HeN0ew4wD5r6ps76Md8HvqSWkDZDmy6nhW2WTpDxxujVmto13yb2EOk2jqfzBSnyK2jMaDtDWy/TF15LqPUUewvF7uW10g=;5:oH2yXUOWtzQaLTnG4yuUJILkFmVwcauC9frYLnLffg8LVQjjrfm3fCeJlKS2ix/foH5wJYKTyH3YqNmku+UjrB4HlWcCeXFzhRy+e9+Or6LRHOv5Rpd9lEpPmg9biGZk2vsSRMDleOIg4HL00DF7q+KbSHDM23lzptwJaYF2OFw=;24:9iSjYu88qjYuNAoLNXQLiSH60Yq5ToJMpXE/yuQfuUIQIPtoNd24UfWSBoU+bgOZwN/KTN7IJ+Z7CSBt5hC1Kby1aXpymyLLkC/zHGxPXV4=;7:kPyhip10yoGqflYNruTzxx7JptIBzFaGTJruFE6rtXCVlH8upkL/VMYutX6yljjtUoOlTdES/zQ6+BJDHF1Szj0iYBpLmusQBl7qguoYL/OfIp5VRObn3M5xnkm9kCfWG0BrHpbhHukEmJoQR9K5YN2yG5/RRkmK83HfEcfSzqsd2w067WOgoQ8o1wayOuKpsVwXeJcmDOKaNRu91bD3BsONxKizzNqOUdvwzeltbwh3tPde/hkRItcNMHI2/OY2
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2018 13:38:25.1800
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f0f75ed4-01f4-4864-5ed6-08d589b0ddaf
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR04MB3267
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The wait_for_completion() call in qman_delete_cgr_safe()
was triggering a scheduling while atomic bug, replacing the
kthread with a smp_call_function_single() call to fix it.

Signed-off-by: Madalin Bucur <madalin.bucur@nxp.com>
Signed-off-by: Roy Pledge <roy.pledge@nxp.com>
---
 drivers/soc/fsl/qbman/qman.c | 28 +++++-----------------------
 1 file changed, 5 insertions(+), 23 deletions(-)

diff --git a/drivers/soc/fsl/qbman/qman.c b/drivers/soc/fsl/qbman/qman.c
index e4f5bb0..ba3cfa8 100644
--- a/drivers/soc/fsl/qbman/qman.c
+++ b/drivers/soc/fsl/qbman/qman.c
@@ -2443,39 +2443,21 @@ struct cgr_comp {
 	struct completion completion;
 };
 
-static int qman_delete_cgr_thread(void *p)
+static void qman_delete_cgr_smp_call(void *p)
 {
-	struct cgr_comp *cgr_comp = (struct cgr_comp *)p;
-	int ret;
-
-	ret = qman_delete_cgr(cgr_comp->cgr);
-	complete(&cgr_comp->completion);
-
-	return ret;
+	qman_delete_cgr((struct qman_cgr *)p);
 }
 
 void qman_delete_cgr_safe(struct qman_cgr *cgr)
 {
-	struct task_struct *thread;
-	struct cgr_comp cgr_comp;
-
 	preempt_disable();
 	if (qman_cgr_cpus[cgr->cgrid] != smp_processor_id()) {
-		init_completion(&cgr_comp.completion);
-		cgr_comp.cgr = cgr;
-		thread = kthread_create(qman_delete_cgr_thread, &cgr_comp,
-					"cgr_del");
-
-		if (IS_ERR(thread))
-			goto out;
-
-		kthread_bind(thread, qman_cgr_cpus[cgr->cgrid]);
-		wake_up_process(thread);
-		wait_for_completion(&cgr_comp.completion);
+		smp_call_function_single(qman_cgr_cpus[cgr->cgrid],
+					 qman_delete_cgr_smp_call, cgr, true);
 		preempt_enable();
 		return;
 	}
-out:
+
 	qman_delete_cgr(cgr);
 	preempt_enable();
 }
-- 
2.1.0
