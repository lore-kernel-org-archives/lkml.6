Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751848AbeEGHm4 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 03:42:56 -0400
Received: from mail-co1nam03on0075.outbound.protection.outlook.com ([104.47.40.75]:58496
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750913AbeEGHmy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 03:42:54 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com;
Date: Mon, 7 May 2018 15:42:15 +0800
From: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To: Neil Armstrong <narmstrong@baylibre.com>
Cc: Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-oxnas@groups.io,
        linux-kernel@vger.kernel.org
Subject: [PATCH] arm: oxnas: remove non-necessary flush_cache_all()
Message-ID: <20180507154215.45a9348f@xhacker.debian>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [124.74.246.114]
X-ClientProxiedBy: TYAPR01CA0019.jpnprd01.prod.outlook.com (2603:1096:404::31)
 To BN6PR03MB2625.namprd03.prod.outlook.com (2603:10b6:404:59::8)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:BN6PR03MB2625;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR03MB2625;3:D9OtDw5iVhZ5WvVa5h29P9sxUtW6L5+NcRHscAqnwFLQ3XOORpGk0PV+MBZpHtDXWuZEpyJy7DKsKY0SKvZfJgty0RnwyuYNSZe1L+4RJpj9zPCFrMTFTnGkpT3lDR/iRm9835GFzljqP/RSF0lMUAeFLKGD6cHb87HYZrCPewKuw0hnvkQ50aGRK/JSHMDh0fiBZLioLpmvd2yOrmrtj4jJB60YNTzr/IzhxdNOz2Rm7IbbX3LEUwOfhQ1805Av;25:6S6OaxM7XVQmHXkWQiR8vHw0T+AumEz9tZW6wwSioKYg7Q2ixuruQdoRHSscQQS/qhNnBmJDKWuUyzddpk89OygyZyTlz1dgcCJYwIoAzywZrDQkuJZpX35pCJSLPCIFhrocTe/RGQYzwD/3MCZJRamNWlMvB+rxJoqoRehctOu/FbRgjP7sLnzgzUo6OPqpOERFfqF2fRO4rbhtJdRHec+RSpFX4fLCh8Uun8bS1YcjLzS334IgNB8JHuudIlg7ay+PZ1FWGFlMgM+cfR4kDJkKZwxGYgUa3yhjkckRWk8twFpOyAXgFOJ9yJSagH6vXGunH7kk+xEV1He7LIJQfw==;31:23dMnNfxO+4AgMu55z93Fmdiwsw8x8uqo1bJ+g3QL09ywomT65Asr7ktuNujAz+nHJLasNFVU2COc+NznCGN+PJPOI+ZIhn6IHJQuFiTW82/31wifxqzLtNFMwJ5e9gee+Dej8Zkw7BVUwZmAcAFGaOShzcDpct6rtFRzI0bER2DvKHd+YZ1nA1kd2Rq8ahjyDpJBF+jRJ203mMRWve6FTv4HH7D2/q9QedKzaoDA3o=
X-MS-TrafficTypeDiagnostic: BN6PR03MB2625:
X-Microsoft-Exchange-Diagnostics: 1;BN6PR03MB2625;20:GGqLmXFHXjfcZZ/aDbpZEsy71f/Z7Xo+1p8GRFcF1L4Ad+gRd/NhCE0VPAr5avR/2oG4H2UHiSbOj3Lpe1SkaeUdnI0r1GYXsQEO+n5h0zr2k1pfoNNBVp+kMrIdv1AvFiP2mEOY2d0mSuzi4+0EhEGexw7sFkvJz9ah6w3kHcQISs93apMQxM+A+afehx4tS735dwC07DZfqZOOAyAC1wq/bZCca7Yj4WnwotuD/IaLTjXgBcGern5djdhS6mPtgwFFglRMdc3akh4633+GaVYPetDQ8scp2Gv9n5ttRKVQkvXI24n9GvxrrutEtCDaPxXy7ApaBeQ5qFjQAnVA4pbL/id2wn8ZWUv6W/z52GZIpvMs8sWBMISjxVoMkBa7Nzy1D+KlkO3Rok059/09MSdChS/Vxx04GpKmUK7DjLRIgrJCuSZOcZQTng3db9s/46l1Kb7os25XuC7BTDIpfTUd5PjRy01O/iXg/syoiVFfLn/57Tt6udsa7EqKPOKE;4:gLqr2wozwFyPW84j4vMIJJjjk0d2WaNOrwIxHTnFnzxhFxa34aXq2VmWkhLgSNx9uN6cRp/LhbMLvcrbHK5IuJIFJIhyVf8vvACQWBoqMIEEJBpG3pu5uonmiiOYAgSoMxQAEUhPK/UXYQL2kwe2YQQ2W+aO+Tl8XyZtEOKx/meEq705Hoi3KCuQBQd1iYWFySEDRtiF+PHUBMm0/lX6cn9W9Vob0QBcx2fo5OBp/N9v9gUZuVI44Z6XxIKvw2ZE3gt0RsoGLpE/84qlPQMiZg==
X-Microsoft-Antispam-PRVS: <BN6PR03MB2625185BAC7192ABDD2A1F97ED9B0@BN6PR03MB2625.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231254)(944501410)(52105095)(93006095)(93001095)(149027)(150025)(6041310)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:BN6PR03MB2625;BCL:0;PCL:0;RULEID:;SRVR:BN6PR03MB2625;
X-Forefront-PRVS: 066517B35B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(39380400002)(39860400002)(366004)(376002)(346002)(199004)(189003)(97736004)(956004)(476003)(50466002)(1857600001)(6916009)(68736007)(6666003)(105586002)(106356001)(486006)(5660300001)(2906002)(4326008)(1076002)(6116002)(3846002)(81166006)(23726003)(81156014)(50226002)(8676002)(8936002)(53936002)(86362001)(55016002)(386003)(6506007)(47776003)(305945005)(33896004)(7696005)(59450400001)(52116002)(26005)(230700001)(16526019)(186003)(66066001)(25786009)(478600001)(316002)(9686003)(72206003)(7736002)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR03MB2625;H:xhacker.debian;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN6PR03MB2625;23:9erATuZso/Mhmv2suAEynbNUZm/lLvFiCsrRv+gTs?=
 =?us-ascii?Q?bp0Lyevoczoz7IxaQiGRd41C1yXMA+23ofA74NfFE9bw3YhUlActCJuKb9ev?=
 =?us-ascii?Q?LKhzqdEmUhYyN9duAiPwtVL2M3RiGEY+uxjDdKq1tP2equsIZu54Qfuw74Ux?=
 =?us-ascii?Q?CnGTBNiYiIwbYfECQKUI6NuHBzCY3Ypu83c6ePg+IHRDHRXv3LppJfdKRhBD?=
 =?us-ascii?Q?shT+gzQGBRnByEwic11edWvkMv6ohY8Y24/oc0i+Li+Kseg4sparO2KT/JUS?=
 =?us-ascii?Q?dqyY5nWuJMlkNyMGJp5z3sRsvqeHJHnPD576OK6c56V3Lr6tjm61F8xY2KUF?=
 =?us-ascii?Q?vAa9kd/l4dQ7IW44PJQ32RP3gb7zy0xMh83iOFK2Nshcx2qtwvjp7fTVVg20?=
 =?us-ascii?Q?eEV0aqrPA8fN1uerAaoKSPdrx0tTWxo6m55EY5PXlGgKmcWF4tniMJPbp7XA?=
 =?us-ascii?Q?YZkZuFcx3Vu/UiiWa5JFCGP1oF+zHVy2lXczkgESri5yVnQDAib8RmR6FwIx?=
 =?us-ascii?Q?4RlWybF9K4dubnGp8LBnk/EIBPqZROwMunBSu8fcjM/IgI4N+uwZjWU0/qeu?=
 =?us-ascii?Q?c8akSCB8F0Dz5PpnHCBPSU0yrly/RZHWDE8CfwsszcFgs8MUE2UcYCCKC5dK?=
 =?us-ascii?Q?183z7H2jGCKo5oN51E3/tJ4YcNPTa2YwGbrRpZPbTcpNX7kfHo6c4UVUBUzk?=
 =?us-ascii?Q?yx5inDir5aM+HL+cj4wPqTlz4nXcyv9eyXrE3jz2CKD72TDXndufEnQfLtBq?=
 =?us-ascii?Q?vaiVdIa4y+vrA8FpAOvGNhmXN/3aDctYQaDKyFLCSDGxW/kiddxw6g5lrdLb?=
 =?us-ascii?Q?70oHo5Fv6/h9rdvNUnJTymgMmEbZJUyatWHzvUUDayRybyTmvgrNbodsXdfH?=
 =?us-ascii?Q?KTBoi7pUMi7g+7jXIKM+dmq65XuqvHZS2Jatlpn9+dMkhOtJoE3VCEvFigLH?=
 =?us-ascii?Q?IJ0FZzyoMnBqb2MPxg97pMSSq4XLAPJ65V+BO0t6g4s2n0hdrZVVe2xs0z5y?=
 =?us-ascii?Q?DM9Dfolx2bhEyGJlFlGc9mfXBFMQWbIm+SUsXa2GlWhQviO20sTB9X3nkJ5q?=
 =?us-ascii?Q?3OAKvhvivHbXw8VRQweYtX3ewpvs1UBSEmxVQxPAsaz2K5XkGpD/mUzMOMKZ?=
 =?us-ascii?Q?iCysq5170UwojjdwrSx/rWsV/e5ZCXl6kK9LePdzioD2IXZT9D3C+4dEBz06?=
 =?us-ascii?Q?7wZApMJUX7WIMYUoviIpRevO4Po8cWBrDeY9TXLBrRIIXV6vAumDMs2vg=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Antispam-Message-Info: bsmIYs0HfiX/rlry33BHGknTw2qP1nmpi1Ccyn0tBfPWT+hUorSm9X/4vFnlOe3ZFpQ5jcDtLbm3bEE3eOd1UpK/rI4cMc5it65z5CDJoft3WcyAhCGMoWRsHYtuACQ+6wsIEdx9EhcU/qG1i+4WHJXcrDXdqP2ruznwdaxTbUrF6E+lhtllViakFBAoPQnP
X-Microsoft-Exchange-Diagnostics: 1;BN6PR03MB2625;6:9RgcQJnm18CcczJlBUMNZES68RoGPzKLrL76gwQPOBN3irFrAiWfHVRqIpEP9sDFTnLVDAAuJjYfWOzQsVvqbw/PXyHsBcdZgA3WQJvUsI3jUUR1TXTd/gXE7x+hb4XQa7iY+nE5GAO2mr2oZc/wXj66RrOM+EqEUnqRuDsddm75Z38OjRcGJKN0pUiyWCx8ck0CSvYE9kJoKq1Ag8oWRI1dSlam0Qdo/xCbGdsOsCHuOjYEqnf++cGU1QzJzPnesYHS6VoUMzNbTxytW63/t26PilwD0DzIxjMrLojsaTepG0h06ry7A0G6zeZsu0aNw5klgX2lL0j6i2ojGSI35CuH7g0rzC3kSPO66F6o2rKDCr3IBAsWhvgOM4f6Azb7vtKFGa658c9hx2Ng8YHVTwZ8M8XCA0Xwk2AhMYDo3v+ZmYQ9uRjVGIsW6qWJttI2L4a7GgVnYGx3Slx1q94jEQ==;5:KjpmnwGg2DU7RguVfHfBELaM9f52z+Ov/35iFSdTBHCzVnDJkjxhe4wsFg7ZXmYZGnPWKEP9UIUPZngkZ8bFlJjkyFMUzvJO8CjJPcqpIxmziBFQ3NHGltZHSToFb/Il3ZMvBfhy4gHsAeLuoyV/g5huJPTr1qZJZLPTpdVQMXI=;24:tHR7A16FmLSjNp+ZRheaKQHEnijSlMVx6HiIdz2iPaDp5jFb7YY3rbwnnZFCu/o8hPU4k6cGwTlHaMnf3ru4HDszRaY1IsQuPZ0N7Vv1jME=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN6PR03MB2625;7:9EIGB9SiO+gwwIAtbvIYgcjM/fpaXPFiDLtfgdZm05Cm90vw9BJZgTKr3HDkSE1rt5Iu/w0/cRcWcQKHJB7h+uXL1LyVrll7JSJeEWp2vy3Z0cmQ/Jhmvet2A6tJHxSlC47SVgpiUwu1cF0y02jbI8BUhPLy6o6QcXSSudYDTzdur+4GuioNWbCj9ROJzVLWDi/Eq/5dNjhp2CQKIyt25G668W3Lsa0jB+p+dgeRxo6XULJZH0ybp+evM75LPjA4
X-MS-Office365-Filtering-Correlation-Id: 0b3b9591-6ad9-47f4-414c-08d5b3ee2397
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2018 07:42:50.7442 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b3b9591-6ad9-47f4-414c-08d5b3ee2397
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR03MB2625
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I believe the flush_cache_all() after scu_enable() is to "Ensure that
the data accessed by CPU0 before the SCU was initialised is visible
to the other CPUs." as commented in scu_enable(). So flush_cache_all()
here is a duplication of the one in scu_enable(), remove it.

Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
---
 arch/arm/mach-oxnas/platsmp.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-oxnas/platsmp.c b/arch/arm/mach-oxnas/platsmp.c
index 442cc8a2f7dc..1a8e1e9fc222 100644
--- a/arch/arm/mach-oxnas/platsmp.c
+++ b/arch/arm/mach-oxnas/platsmp.c
@@ -85,7 +85,6 @@ static void __init ox820_smp_prepare_cpus(unsigned int max_cpus)
 		goto unmap_scu;
 
 	scu_enable(scu_base);
-	flush_cache_all();
 
 unmap_scu:
 	iounmap(scu_base);
-- 
2.17.0
