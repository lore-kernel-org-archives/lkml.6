Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A63A3C476E8
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 17:12:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3737C20842
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 17:12:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="SjRFgix+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3737C20842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732439AbeGLRXS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 13:23:18 -0400
Received: from mail-db5eur01on0049.outbound.protection.outlook.com ([104.47.2.49]:33696
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732418AbeGLRXS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 13:23:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7C6ZdDOTsokL8Tan56g1OTjzcgikxAE9g21EHplUgNU=;
 b=SjRFgix+X9/dOHE07stcHtI0xk91xvSycoxWWyEOu7XfAZFfsf5M09IGxhGLvblZYolD5jCVLqJM3TFMaxdB59FCNpjRqclG3Ord41Z3sKGlQeqVxtmYYAX6Zyit0/NX/ayRjs6dUIKvqOw/gIkPK4LlqBKKbHPhcfyqSCTel8A=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ruxandra.radulescu@nxp.com; 
Received: from rhuath.am.freescale.net (64.157.242.222) by
 AMSPR04MB342.eurprd04.prod.outlook.com (2a01:111:e400:8032::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.930.21; Thu, 12 Jul
 2018 17:12:44 +0000
From:   Ioana Radulescu <ruxandra.radulescu@nxp.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        ioana.ciornei@nxp.com, dan.carpenter@oracle.com
Subject: [PATCH] staging: fsl-dpaa2/eth: Remove unnecessary cast
Date:   Thu, 12 Jul 2018 12:12:29 -0500
Message-Id: <20180712171229.20745-1-ruxandra.radulescu@nxp.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [64.157.242.222]
X-ClientProxiedBy: SN4PR0501CA0138.namprd05.prod.outlook.com
 (2603:10b6:803:2c::16) To AMSPR04MB342.eurprd04.prod.outlook.com
 (2a01:111:e400:8032::17)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a1a18839-4ed1-464e-2bc5-08d5e81aafdc
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(48565401081)(2017052603328)(7153060)(7193020);SRVR:AMSPR04MB342;
X-Microsoft-Exchange-Diagnostics: 1;AMSPR04MB342;3:vHcLxS3hcjCyZ+zz7V08db0pFthFoHwGfB0Bn0++ylo97aMNGyN8w8WuNGQ9FRGPKyjRlN/BDjzdxjtA9b8omZRUvumHPRjuLFPUVEmkRa5BhkFQNZ2NDNEAvTxOMkU0tCjA2v7i7WRGblKKm1mJzj5kLCe2U2PzP50PrTzvwAImO+hZTtsoxLuy1s1/F13PbUpcuEKEIHLWBennRTaI2Rp9f0a+xetjrDyQPUrH/wWMMF4F9m/bkTO60g5+YFPR;25:gefjhxQAxGsGC1KcbkET4mhcACE6RUMEe4d8ygZLoXpaHTOnWe0MCFgUflPsk4StR07R3GiQv/elyF5AVQ6PpwiU+fl+8+JtM3+LlFiqCtLltOUreiL7FWKmy7gKG4ry+u4d4Td090gnsrDDOwCUHfJSGDPNelalWAaWOTG+up1CKUuC+95rMJ2KUpmLiZg0KYmkn4iJjEzU2vpWK3bjO10qyC8zmGluJZoIyuhWkLbpzVFo+BgTj0lmnWE0OTnPejGnGkj7gphmSkE0eJDaSvzWyNKBwWAe+7zX4poL2yQJItPqeeikdRBYU3lymdTw+qff2gmeAbu8qP0ZgecsHQ==;31:XkniNfno50JHUA18LcvZApvsGcOWweJh/DweIG1c08HLpduCslkJ7LQIfK3jENMQjPRNLXPChUl1F2NHN3+krXbz36xrmuHW4vqUwyso9+Jx1FeFOM9L4VwAwayyAdeT3j6P1UVLhc+uxDG4uUqP1vz9qJY9ET/J/o/9R0ovQFEBwjFSwy/4iC0Y6vNbmjJR7xmEi4vdzdL/iGvDbvxZYJPNflbeaRqwOmK9uLtolZk=
X-MS-TrafficTypeDiagnostic: AMSPR04MB342:
X-Microsoft-Exchange-Diagnostics: 1;AMSPR04MB342;20:4PJwbfk+m4LnoKGzDS8D2z8X3njV8tHfGnZ0e7ytp1LGQnmvBmAAWkHWIE9pnhHMmb0vVGzRnsiNOsBF2Qo0QBgcPtyNQif1zwNzj5Kd6qgLnwUp0WqtEmEcmkH/5OOO36WC7fCA+B0BAgRruhRWA6uw8uUN8HoPQRX2vsEZ1HSha1oZ1EQTN7rSAvZA/PfhNYDu/kId17Z3TBHFkLpdGaMYWFRf/cLIqARSOjnOO7+4ubEly+pFoIoE6D6rn3L4sZUj4vexLronAfR4lRl+2Y5vOaJDFyDfWJ9IO3SzTQl6dIDlleuWyqula5LdqeqaBuidezgAI+YfTCdWuyOMM5Uh8nGqtJoDMRyYBa/AzKgqd7h8x7RcBYFV7+7I7s2OJ77uqsn+wSjQDZ0Wf/AFdKVgUJXwQusO5vfLP+Z0BTspL6y4HqCGOaRuDO6F724A5rQHs5O3BAXwcRkHJGz+rdzMtRd+uugk9PnDwM40cs30HmQFuTqnFdFZFFT3kbh2;4:U/l2y1NkPcVtoyGpY1HMAh4nibhZ0Mfo3r15/pb5qUy0hKztUKgtFINfnqgkgj4wUcJRrRnvggwmWil+zzy7VtDl6tWmRgL0avfcuiPmFz47w2VwyMwCVpBShXt1ehy8F1r5rpXPCo0kKgcWBXR1dgEtt7SAM+fJspgBREeLqrTsMrvqO1/HtDTvffCQzFCQPtLxmHHhToyO0x/8QmR2srMEM688fFODco5Upsafai/lIx9H2mNaKaxxfseE1ZtzD3MXWnYhJGLX7Fery6ScGjVZcYgBcgphSymsGup8TE2q6/H2JcwTVPs+mNNSAWJZ0VFAR78ugjgyyWvXdmOoDbK4vifdZZWBdqQXfuU5wHU=
X-Microsoft-Antispam-PRVS: <AMSPR04MB3420918791CD3998333ED5394590@AMSPR04MB342.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197)(146099531331640);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231311)(944501410)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:AMSPR04MB342;BCL:0;PCL:0;RULEID:;SRVR:AMSPR04MB342;
X-Forefront-PRVS: 0731AA2DE6
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(376002)(396003)(136003)(346002)(366004)(39860400002)(199004)(189003)(386003)(316002)(1857600001)(486006)(2361001)(16526019)(478600001)(186003)(68736007)(26005)(52116002)(51416003)(2616005)(956004)(2351001)(14444005)(5660300001)(50226002)(476003)(2906002)(16586007)(4326008)(81166006)(81156014)(6116002)(1076002)(6506007)(50466002)(53936002)(7736002)(6916009)(25786009)(48376002)(106356001)(3846002)(86362001)(8936002)(105586002)(36756003)(97736004)(66066001)(8676002)(6486002)(305945005)(47776003)(6512007)(6666003);DIR:OUT;SFP:1101;SCL:1;SRVR:AMSPR04MB342;H:rhuath.am.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AMSPR04MB342;23:4Yo6L0iUq/V1mVl0nocp4zrOST6BA3RZHKyKYBuHHu?=
 =?us-ascii?Q?1nnDpT/1KGSTMeJ6xxyIVOlzjZ/DL6T8mKIW3t+2FXSPeN4eR11yzaYZi+Ir?=
 =?us-ascii?Q?6kAF/l9su+3kmPlDrTsKbczFZWjy1sm//BNespn21BlNzuuQtDOk6zivpL+3?=
 =?us-ascii?Q?htWso0hV7Np4SS2nTA3QBk/4dAG0kZ41qV9/GTZEBo5zFSIoc7VtGLo5Q34K?=
 =?us-ascii?Q?gHbFerZw3K6GqoXXQPZCqIsOAOL1jZSvFDNobjedlUbtRgCyteFOD99uQt9q?=
 =?us-ascii?Q?2C4yEYvGby2jBn6W00j9xcZP+o/MJOYvetUcXZTj59wNqRrY05NFMcxkerkm?=
 =?us-ascii?Q?benqhJQXwnTdmgcIuB7nqqPiyGpgn/pPNoi6hDWCJbSSqaNzKgXLyYMDTZZu?=
 =?us-ascii?Q?9tqt/fveeWK9ZcXSkctUZsVPqtec7YY41yQhcvNI6EO3x+/IKxnpSOphVrYx?=
 =?us-ascii?Q?ktHHvYwCY9ww/+YbhwgmU2+ejdx9hHPf6j+eoW3Y4/MCtC0M4aoIjQKzCZxj?=
 =?us-ascii?Q?XOVCmVRmBfjjn/B0OzJF+BYiX27sJ1XrbY7exV0059Qhixm1iESgDPUuXPxD?=
 =?us-ascii?Q?5D6mEsBTBbXRljboHqC3HmM8T0zKbbf0ogHI8xP8/LX61c0TEcv78fdKxSag?=
 =?us-ascii?Q?Y3hyiEz4zycXEQZDK9WtWcIZWlxPnKy0m3uHqM+M3aaIaZTI478lSBgn0xrP?=
 =?us-ascii?Q?kjHIrHTSmQYg0ZeGVV21fX7JJcGEgaTvRu1HVTCWx6hT31p5tqpgNJrX943a?=
 =?us-ascii?Q?hhfAqmqW3KI6g2s+HrcgtiagNdQRGcFBsaqfPmDIds6Nm36FxBBGj1hfpkDt?=
 =?us-ascii?Q?AtDTRlRyYfUQ2i8WmI+LM1REEXGJQV0huzEH12S6UP/szxJB2GnEAjheXTVv?=
 =?us-ascii?Q?vtMLewmpRZ0+7S3ZlyceiDQssjZcBBV7dIam25BeXR15Z+nNjHqkaXyBiZHU?=
 =?us-ascii?Q?GMq1YMvjuDeGEQBi0SP1E9j7ZmXJpwGmkjm8JehXeVcH8Deq0wLETrJLSoV9?=
 =?us-ascii?Q?d9PpUOl6zvSIxjwmoU3AVCKHVeUDipeqsMUKOh6ohSOH3SjjHbRdYwPhH2OE?=
 =?us-ascii?Q?LqcwGH9XfWtGppKSJEyMvkr8NgYlwygLkFm+E0JZ0Uex1Cy52NnQpQKmHLHL?=
 =?us-ascii?Q?p5Wj1DijeYqJ0Sqt2j9CxmwanYxo7mAg9MeZO89tfllesA2P+ceRMNGsqcNT?=
 =?us-ascii?Q?3a5k0P+RuZEzkYLgYvSwcARY7ZfLe2dvJF?=
X-Microsoft-Antispam-Message-Info: XhIIHowKcCLwaXyVxhpAXxkA4wPM2FBOPl7G97IXifqzRHcjuSZK7sEz2qWZeZvGIm3c4RuA3S7Kk084lg6NFs+/6mT9XPsfLDPU76BRCKw4fqBvchR/Lr95M65i9KVIWgGvJfyEdeZBk7zdgD/tsLAaB/A2Nz37bH6wOj0iJdKiefqlcFhmYB3XpA0z2aVnGPCNIA+0N8AUVHzPdi/xIRDrBY5GrRYpsiUSsa+fLqv9KXr6ECfYUyThs45GuLdOZtY3rfjF8JrFeZNBJ+U26kC/9C94c+ikSOXcL0/xjabsd2ynxBvkL3p3LyTOoQMo7GsqSiNgLoznloz+2ajSoL0n5HhC9EZYoTvk+eFi+wk=
X-Microsoft-Exchange-Diagnostics: 1;AMSPR04MB342;6:hGdZEhoy7N9Dof1LRtwLfIqgzd+iKdgPpKQwXu0zdhU1yWap4RvT7FPsGwBgNLZQLaI8Dcr+/IqluyIw/rKzbkovvDn2GvR7Moh+bHrD6t3U2uNVE1bFR8CCzu6YvjEfUvL0eOKdBHTJvxNdOzQCrF32GeWt/M1QIuo2sGIyxG6/KhQGrB+MKnjvW4XtwfOLrHzWIpFUZq5D7oPgPJtKfihFQOgPOt4OEemUycYiwtZbcdnVr8SVPaAmMKM7j1t1jTF1ixUB5QZMpJ4mtc5zAEyb5hLJ6GbF7gsGjPXqUZxVn0ENmwc+g0WxCju5lFqVZ9bYdXmp59HtFX6B9BMkFd8F+fDOW3YEMnFsKPSJmBkVCTpeS2lDZ3GfL4UQKi063LpcUyD5tuW5wNXS+FV+nDf6nyyKqtXb5Mgu8vKR8NdMjCQtXy9r6JOXzSOYznWGjx1mzKDfVBZ9ay90sk+3OA==;5:tfC7etAlwh3w6RZeMmmL1siznaYzmehPUdbdhqqJoo/dxaLoGOc4v94yMmmLyj3304+S11LXJywsV0Vr16qdldiL2AnLmVbvOjFYv2vwT7946PbLyhsmBFid767+N3x0Kn4fYGikxtRSZya1ZJo7ExzWwqt+KM5aNfDa+xY40kI=;24:Ftg896gioPjQKmN2oBKPVD+DWxpUDPG0PLqiBO/fKPH3FHoFohRJdTHQXXfrXUfsGSCsr53BXi0YbF9liLP2FoVmZSeH7S7v7VauPA561lc=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AMSPR04MB342;7:P9w0l19wBgsmH+sl6CIOKKYZ2fUQVsluV6sxCgI+LTCh4CNmqOZQ+/74sRZlnKkJ118/nnLvWc/AAA4uQ9hVSNzGtrtNS8EVGI+dG842wVl1dFta0/dEs2ull6jgsqYFXcqBr8Cy3hrCZinmgEKbvZxEivnyecGhNoFzRUDyUDTyMFTEaEkFnwc3XVNSQ0tjZArvODVwfozzowXtE5ZBTf5sDNyDAfC8HC/SURErPgHPN+InUrJ3GGNjBlxIs/KR
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2018 17:12:44.7841
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a1a18839-4ed1-464e-2bc5-08d5e81aafdc
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMSPR04MB342
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's no need to explicitly cast DPAA2_ETH_MFL to u16,
so remove it.

Signed-off-by: Ioana Radulescu <ruxandra.radulescu@nxp.com>
Suggested-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c b/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c
index 4ae2371..da993ed 100644
--- a/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c
+++ b/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c
@@ -2366,7 +2366,7 @@ static int netdev_init(struct net_device *net_dev)
 	/* Set MTU upper limit; lower limit is 68B (default value) */
 	net_dev->max_mtu = DPAA2_ETH_MAX_MTU;
 	err = dpni_set_max_frame_length(priv->mc_io, 0, priv->mc_token,
-					(u16)DPAA2_ETH_MFL);
+					DPAA2_ETH_MFL);
 	if (err) {
 		dev_err(dev, "dpni_set_max_frame_length() failed\n");
 		return err;
-- 
2.7.4

