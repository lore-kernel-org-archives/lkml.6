Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A75ACC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 16:10:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F8B620841
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 16:10:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="htb9dSGO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F8B620841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390024AbeHAR4f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 13:56:35 -0400
Received: from mail-eopbgr10069.outbound.protection.outlook.com ([40.107.1.69]:32032
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732937AbeHAR4f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 13:56:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8teCWNjFwjufr27qr1+1IXbXwAVXPCq840QBJJjeSVA=;
 b=htb9dSGOmoSkR0WRTmDo6LnJF/Z9dWylt8cbR4jkTWH465XhOHmY9Ws2dWQ62c49N5RI4iOHCGzqgleZS96a+BtajT9Ad8M9L0tUgHsE/IpIvhYFaqYGv0YVOa50WboQVDP2dRBo+pDHD2psnfiKWMK9L9BWoqt/LojB+OyoTvw=
Received: from rhuath.am.freescale.net (64.157.242.222) by
 AM3PR04MB338.eurprd04.prod.outlook.com (2a01:111:e400:881e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.995.19; Wed, 1 Aug
 2018 16:10:06 +0000
From:   Ioana Radulescu <ruxandra.radulescu@nxp.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        ioana.ciornei@nxp.com
Subject: [PATCH 0/4] staging: fsl-dpaa2/eth: Private header cleanup
Date:   Wed,  1 Aug 2018 11:09:47 -0500
Message-Id: <20180801160951.3350-1-ruxandra.radulescu@nxp.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [64.157.242.222]
X-ClientProxiedBy: SN1PR12CA0093.namprd12.prod.outlook.com
 (2603:10b6:802:21::28) To AM3PR04MB338.eurprd04.prod.outlook.com
 (2a01:111:e400:881e::15)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3114f0c8-87a1-4c23-86ec-08d5f7c93fc9
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600074)(711020)(4618075)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:AM3PR04MB338;
X-Microsoft-Exchange-Diagnostics: 1;AM3PR04MB338;3:GSOltzYS4vRGXtf3koHmcWBmCMGjAqZ4sU8Mrj98o0cbVHnPf/O5MBqhI21Jnm6uRV/eE5Smw1H/ztCtX9x5yYcKx64HRu9ES9jBBdyHrIussvAPsbs2H5GVmTRGWSduuFrKfu8yIreW0FO4pmMD6hQ0L/ufqK2kGrgl4kzFWpTu6MB51Nv+JCFoJvessUhM4Sg9gqQoJphYpXfcYZ5aJYkaAU8mvnNoCuAhNF5vfNja9ns4wFNenJfAsFtzJLBl;25:o+2qREuH0yehXFilfqYymPzFrhXGalGgCIHZwcyvP9uUzJy5Rib2cZyhfFIcYJtPF2jmFG+nlHwWea2/2OwR3PApfOTdzvUOGL4Jzl9xMH6BxQZl/7NupJOgqewvG0GbMSNJxjCX1hRzYojWSrrHrGVf7CkFpFryAHt7VVZjX5KfExj233DaxQI3q0wJD+H+cTCXsFNKk0Umv36gUEW6D2aFQ2chzPmC5Fr9vBsba56+VT1i5Ni5/W5uM14BeDRm7QRfvMv/7I0U7yqRVs0fLuikHz+rhf7cSOHyYCxmWKsKLHuumOwwwUTmQVWOC6KsrSgDagc6VxjZ5ASMazctWg==;31:IxN4yVkvGVh0HpLO5xvF1JWXk1FlqIKXm9FOVBatib0qz+jI+18Q1DFiV3I2779mg+h5vH7HYUPsUYLUVjsLlx/jAnoiSvdJbf3kIsvLRHjNnYk48flLZa/sFovY1IoeU1AGeu/399yguNzuI5XBzAs3afEZN9FLwWA/kQvm9sn4WjEtoT9qFdTTE+bjub6OXNQ2bP7EAdLOIhbMYbfPf5h22QkzzUNGrNH24BAtAyE=
X-MS-TrafficTypeDiagnostic: AM3PR04MB338:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ruxandra.radulescu@nxp.com; 
X-Microsoft-Exchange-Diagnostics: 1;AM3PR04MB338;20:BefLJ2AGpMHJ+q0I4/on/zVPOOWzjXaI+Z7lv1MuK3551D1ljNYYggJ4dq3E2dxeyFg2Asl4GMUukBTR86bS4rmGFjBbGLzXLXBFOadG1Wu5b7Wv9yohhedbIklQx12+EHEQvA9TVwTVV2OYfWogPKRjRan57Y1hQxhaHwTl8zdSXg4XfrECFPSVuAO9P6FbKN1sJOX3pi8lhlhzXAyii7oPrws0PJsh4p+aF+UKFWk4nTuyvJivsD/1S+0yPK8aqco518sp/hESOMd83TOStnyLKajCMOl3dPFiUY/5CDDg8Kl90Tgdi8x5u70uYHQjdgqRG3SyuS0Xt3Imdca6hIk1BybRBtUokqJboFN5dYNFYz8a8TphdGSOkUap3gCapgl3nSjV2Uqx+5W4Ll5vJ+tZ11QcSs7u/w//Zt9Zq7YSVGHArbBCIj6qKFejJjxfir5GRZcqG2LazM4MBHQuNdWkwJeCAeiZKuakAG+wakkrYX+A5NfzAdNRa5gQHwi3;4:62p3IbfEYfWUzAap9TyVyHx3hNpeefc08ooHeA909R1OBVPUmuJlt0qyY6T4dz9hsBWAObxtQrL5XTIzgcwMcxkePVaBqUbd1OPV4LDor5yGR4DnBr3xW6JFRAPsryLE6WKXJMVkfLp3hK5GQ4fz3v17srww+5Q7VMrWqf3VTdhgU1y48mYUw6btrVj/U7zIGRplEzpelIHA4/SlgdnAQILubbqyl4+hzmS3gnwp75lkJnvtyJnER+GLrB3F9jbWRkngipGrWBp1gJ5C3AuQrg==
X-Microsoft-Antispam-PRVS: <AM3PR04MB338CE85A3DA0F90BF986048942D0@AM3PR04MB338.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3231311)(944501410)(52105095)(3002001)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:AM3PR04MB338;BCL:0;PCL:0;RULEID:;SRVR:AM3PR04MB338;
X-Forefront-PRVS: 0751474A44
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(346002)(39860400002)(366004)(376002)(136003)(396003)(189003)(199004)(5660300001)(186003)(2616005)(8936002)(53936002)(16526019)(2906002)(97736004)(51416003)(68736007)(486006)(6306002)(476003)(956004)(2351001)(50226002)(105586002)(81156014)(2361001)(52116002)(478600001)(26005)(14444005)(6512007)(7736002)(8676002)(50466002)(48376002)(6506007)(81166006)(1076002)(305945005)(6486002)(6116002)(36756003)(66066001)(6916009)(47776003)(106356001)(3846002)(6666003)(316002)(25786009)(16586007)(86362001)(4326008)(386003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM3PR04MB338;H:rhuath.am.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM3PR04MB338;23:/kWLZkQH0PnPQW18c5XeS339z3GqCwOJ0u3Xr+IdD0?=
 =?us-ascii?Q?2oH3SnMdNzz2PYazGI6Sn1fdm5a49xWeJljVVDZKJLYZHhIM22zr8e1r80jx?=
 =?us-ascii?Q?NgGZunClHbDkWpHI7XScdqbdxzkpZ2uW4xzAqtA/yeHCnIVNi68riglLeb58?=
 =?us-ascii?Q?NXEAt98fkvn3fnmhCL1thM6/B3kRrTWGS3UiMHDb6Tv0Cih52fyVM+NlhZCz?=
 =?us-ascii?Q?U/RLmfLExLbx7NjI96tOhMOZFP7zm4b00H+1DC13l8AK1ebPbm35YXbUgy8W?=
 =?us-ascii?Q?dRgXJelotidyuzMUUL02mTXq30U84c7ZQ92vMIiGSDgq2Wl96gflbFNuJXXG?=
 =?us-ascii?Q?8n7MIanKTtlZtv16dieA1egUSorNd8FPB5AYPwsrvp9fqjnQU5GTVhPEkg/Q?=
 =?us-ascii?Q?9pifmx6/FUptHdG4vG4pXS5oz8n6lcDu2VelkTvNWVJLzp+tB+aF5A/SLDHf?=
 =?us-ascii?Q?XV8flhEH7jZcHhSTCSyZG+3SEFuUeVoxa2bTUPAu/YwuTIviVqjS9enSPzhS?=
 =?us-ascii?Q?qJ+kYgcbpWxm5Ql/piHdG48Pbx0KXpb05m+gvCi6vA7xuHdaWMgfJAsGBvHh?=
 =?us-ascii?Q?2ZKl+dutnkgQ0ISkG5CW7KHw+y+AOenwp7TRvc0mKqhdkyQ+f5xtjeauUMgu?=
 =?us-ascii?Q?UHLYTX6RiwI8fPb/om9eq9C0NRibNJxjwslpneWv7f94xVpJO+wN1XqY2/QK?=
 =?us-ascii?Q?rLNODf5OpCTQaCsslCoThUiBaTRhoGLW+zZnIh5oTaTJK9MgZsGXYRNay1N7?=
 =?us-ascii?Q?X5OmFhaWVDkaN4xqisnxxDeBGmh8qU2eL+M3LevvIznZu/LjPAMMPtuQf7YN?=
 =?us-ascii?Q?TDyxCi9UapsZqs1n8XCWuI2YNelJC6by7jkNhOsulV1MAWiIXD4s8SROjvCy?=
 =?us-ascii?Q?Lrmy7Ve+hP+CpG+vvdbw9SYPwAvxCGEg7pMYneoST2eJPtl5Dss0axwDTrJV?=
 =?us-ascii?Q?pkn8BmMhq7L0dzj+ur9ADXaF62TchCZl41+ibA1WomUOEbq3E/ThbP8Cbxwu?=
 =?us-ascii?Q?Oc/Sqn7k7fHS48kWFPZXlNx2FXAv7aDY6ygoxZs2eg/9zLgDSszTfPkE0/4a?=
 =?us-ascii?Q?xoCIMEYdtb0XtiibBzB2UIeBHcF+7fghel6XcjvQiuQc7X9t8RO5V2vfyY4L?=
 =?us-ascii?Q?lepOHiWg5ccns9l5kcKn/rkrDAiJPMkcPJmI6pBI4cJDV1rP3FsjmNqaGw9O?=
 =?us-ascii?Q?MiNySlFB4Dtp4LQSn/OanMHZUr9SpxA1XV?=
X-Microsoft-Antispam-Message-Info: kyjZVPrF6JjBGqkO8m58Xm/YQU9ThBd9jZnUezKGGzohl9JCfOTCuDTHnysKeadxXLwVRKNnuBo+aQarxSDK0Crby2c5a/7AT0bGDG2OD/QZTRc/wxuyM1zXh9izsWOWOxg9zCSUDVWa2ZuKeVYJ4MxeLzIqxBq6JvOhONyp3jgrlIeIyEcQzEywxSA/ejeYGwMETr/uJqOyc1tUU6XUTSN5oCKiJmXLKtzAEkUGuGkXnwevoeBayNi88E9y4g6e8yiTg6z/5yYoSOIs3F+DzF34+HiXS/5Vcbv4c7j6VEbn+K3VhWvU7GLcYSD9YdWIBsOsWXXyukK3ePwEVaVVCwPunzknOoebbjCJ1uE6FDo=
X-Microsoft-Exchange-Diagnostics: 1;AM3PR04MB338;6:LActcVaVam6xzGHxy2QGWtYFk6I5AAv5wLu1EGZ7hDhvCn8LTUpsuxC2OlvnhpZ2YjJeWEwbKArDyyEvGVi3FYGswhVGOwNNmHQZo5alA0oSPK9EWtD2ef6EYNCaWsbQCR2ATwGGCNwGUiiR+rFdiVH8yhfiOj1gZrBEBdPCXYG3aCTqTK5qsbsTFMhp/6Nc5/PmNohe9JkUUvJKRYv4SNJOmFvdhBkZw0Ep5yMOudfHtwTQ/zWsEu/75Ro5gUlCg8kAaEDIjr5lowRKtpFLH/ZGfg4370y1r7XVOSY0EnYP7FJcjiJPsEDIAZokWb0GrT6Z5UjpMl9TzMW7FsPQRR4fKRXZZIkbm2yZeyXDDi46PnHv+mS362w6lOrWZOci4F662tCwv7YtaDPkejl9hOtRRGjegOseCjPWXWXGw3qwIm9shS9DiNWOd5flqe+WSJjn+bODKq9CqstQusMeEQ==;5:yDtm91PS8H4B4J6td+lK+kTJ/7pELzQaLW40Xev+2MT2Cr+fWrPbKqfrfzIV+l6Doon3NcHRrAmR0AdF6giz/KkjHDkBUa9v25b/Tp6Mchks3xwl7K01dKhkxJBjJmPQXvd83imzo/kafHT2ur3oNEe7drhLvhBPeVgyhaJrxR8=;7:l9OxN7kH1I9b9LdrKLjAW0vfD6NlX2lNlWKE8c+8sBXUZ/zzEXx6sWOs1AE3ZExMfwyiTEzv04J7nBoFT93blLGawGK6XTAYz6FuD1ATHtz1f9rPOx2e3cjU7GN5Edr5HkhZdJnMvCdzZJYQjHivH1oCMsxd2phuKukLv0qcYoz3LFUasb7ZCi+1wLddT8OPnV5PEb7IM4G8iVZ7sdE7sODiKdzu5uxo6kSX6DBjufZqI1gFquX+0CqnYyl2hGxH
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2018 16:10:06.2983 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3114f0c8-87a1-4c23-86ec-08d5f7c93fc9
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM3PR04MB338
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Private header file net.h receives a cleanup and the remaining code
is then merged into dpkg.h

This patchset depends on:
staging: fsl-dpaa2/eth: add SPDX license identifiers
(https://lore.kernel.org/patchwork/patch/969402/)

Ioana Radulescu (4):
  staging: fsl-dpaa2/eth: Cleanup comments
  staging: fsl-dpaa2/eth: Remove dead code
  staging: fsl-dpaa2/eth: Use BIT() macro
  staging: fsl-dpaa2/eth: Merge header files

 drivers/staging/fsl-dpaa2/ethernet/dpkg.h | 350 ++++++++++++++++++++++-
 drivers/staging/fsl-dpaa2/ethernet/net.h  | 452 ------------------------------
 2 files changed, 349 insertions(+), 453 deletions(-)
 delete mode 100644 drivers/staging/fsl-dpaa2/ethernet/net.h

-- 
2.7.4

