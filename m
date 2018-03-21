Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751640AbeCUJCQ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 05:02:16 -0400
Received: from mail-ve1eur01on0052.outbound.protection.outlook.com ([104.47.1.52]:43648
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751423AbeCUJCN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 05:02:13 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=madalin.bucur@nxp.com;
From: Madalin Bucur <madalin.bucur@nxp.com>
To: davem@davemloft.net, geert.uytterhoeven@gmail.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Madalin Bucur <madalin.bucur@nxp.com>
Subject: [PATCH] fsl/fman: remove unnecessary set_dma_ops() call and HAS_DMA dependency
Date: Wed, 21 Mar 2018 03:58:19 -0500
Message-Id: <20180321085819.23249-1-madalin.bucur@nxp.com>
X-Mailer: git-send-email 2.8.3
Reply-to: madalin.bucur@nxp.com
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.88.168.49]
X-ClientProxiedBy: CO1PR15CA0050.namprd15.prod.outlook.com
 (2603:10b6:101:1f::18) To AM5PR04MB3267.eurprd04.prod.outlook.com
 (2603:10a6:206:d::20)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 34f66d32-8dc6-4a4d-25a0-08d58f0a6e7e
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:AM5PR04MB3267;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR04MB3267;3:760lgWT5wmSWprtemA6BBE6owFrCwihogYyXiD/BWSUS54XBRAsmBs65eeGldz4gBBrdSQrZUwLxLRDa86aOfoTlk3KJ3udQYvxJ94/gQeJoehTEdh3q2ZjCjB9m0KrbOD1jAPPlBkTVA7068xT+eJ54nLDeuCdpuD5kn4KGriAZPNwffVUkYkvXacG5ABXl3/Ufk1KhRltbnr4tdpZrE8ZdRgQ8c+QqVePDjAgJNA2dMheEmVoLvJX/LzonEL1I;25:u6y7c/OZjauk8k7P6QHs2uDno37wahm5BgBKdfPv1O/viuYZHrjtJRsODgdIPLxuzmm6lz8CerMnPfxm4skchp1rgZGpA5siWQ3hc4fZzz6vzXtM+25CogsTpKhV3v13yK0Xb4cOxVFMewkk0f0A6JPvANsWOViZ8GL0M0ZtpJ6imf5g1mF7ocJRF5a4ggS3zmRI1KQ0oqr+JcgfgZUN/PEzS/2PjNjvtaTISFA8AesSOO3nvBkgSUDGNbaXT/JMONpRHKJAw1XAH/IwTy2LBIgmfKIurvxGDwQz9ROYO1bTgvRbWDhmfgfDD+pjPXU/Fx0KhXthrPYw7jZXK7lTAA==;31:yJzbPUNvRfoRfxl5On6g7WkspcqykMb5b/U4V5ce0QZVTIMbsdT9jefpO1MCvyqrXfdjfh5iKHL17z6uXCHehA1vbaZIyC5OjbOa75AP4zJ7FiHKs3fMI/E4fFdYt7yShVWnLFe3DFPxd585CV8D9VLEoedxkkAL9qw8EyUGhIpW+akYp+iWIJEual13WbcejTXSt+dTK1xA0Lwk0p8hRTd3l32CjlOxNkEwkla1Xds=
X-MS-TrafficTypeDiagnostic: AM5PR04MB3267:
X-Microsoft-Exchange-Diagnostics: 1;AM5PR04MB3267;20:8RlylvEPJlskaULVWTaNqrEu4vCrYH6qp3Y3wN3ZPPlh5BBnEDvWXO+SGJcff7ejVQ99LYpVNK8j65whGL3KOjwWMn7fCsL0jtRZEciTQG0ue+5SQAopCfmqbKTINT8kAZR1SRwYwNW/Aw2taKTSQ0HYwhbt7AsHvIQ5UQ8CG6/fegnwPOPMFfwFO79dIYfMwcgjkQA7xzRi3zslUnA7AfL2HbAToR2sz5LE5oKzZLFYR/ipBPx5+OgrzoyVDuQuHcDyK0iul2C2vFe+AtyO4JRdPFAM6Kw4B8rYplG7aGtJnFzjnQ0znDnVwjole1HhaHkHipzlhraB9gE13bd1BXbZ89yya9oO+cUngTdcQoOhNeFEn1fjYS5dz6TcbXoicfcjiHkWzrUqowOGDFlwda7H1zrCMMa9Mcv1zwEMqj80YTFHiei+ZjafQCxLi2Dvvh+Qns5XDROLpQdHkjoo80NETNjvlolZ9zmQlyafB3xec+mF/MA9Z5wX9fznxHog;4:zpKGsxUakgTUM2FnmgP+eCOyvRh8ZMu2wTDND36IzyFb8fIpK0ytvFvlnTPKXRHo6Uc7jXkskTVqPoyYSDXRSoWwxcbbW5KCwTHxjPU6G2cYJu+nMdfHovb2/yp+b4sP1gSDiBcrrXB2YgaiXfET7B/BnY3rXXw3hxIsPAa+dZKSUEqH3F8fcviGHqydz9MdQrGcu3zd9028E04kjzhZ1PuLJczQmmBIjcVfoQHrAwi91INR0YD5tIivH4zME0G/FzNw+FIyXH4XXVAaCVh01d5k122U5UFnOXZ4OMZlh4SElIEdi1QztdCvmox9zkcz
X-Microsoft-Antispam-PRVS: <AM5PR04MB326786377E5E4C504AD1299FECAA0@AM5PR04MB3267.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231221)(944501320)(52105095)(93006095)(93001095)(6055026)(6041310)(20161123562045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011);SRVR:AM5PR04MB3267;BCL:0;PCL:0;RULEID:;SRVR:AM5PR04MB3267;
X-Forefront-PRVS: 0618E4E7E1
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(376002)(39380400002)(346002)(366004)(199004)(189003)(47776003)(66066001)(81156014)(8676002)(6116002)(81166006)(3846002)(50466002)(48376002)(36756003)(8936002)(50226002)(6666003)(316002)(39060400002)(86362001)(68736007)(2906002)(478600001)(3450700001)(52116002)(305945005)(6506007)(386003)(105586002)(53936002)(1857600001)(6486002)(51416003)(7736002)(5660300001)(6512007)(106356001)(25786009)(97736004)(1076002)(26005)(16586007)(43066004)(186003)(16526019)(4326008);DIR:OUT;SFP:1101;SCL:1;SRVR:AM5PR04MB3267;H:rhuath.am.freescale.net;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM5PR04MB3267;23:0TuwPxPcrEyjJzzKMOgKtmCJOrAgngsQiQlan1x0P?=
 =?us-ascii?Q?YZWpNQj5i26H8yEaGMdx+eAchExasRU3KculKk7HJUs+Nybes3gxlbStqOng?=
 =?us-ascii?Q?RnWTzr07fqI81WColxf3E5r+ebjsCgsa9Fcitdhz8bvlD6Be77xrbDQjJacK?=
 =?us-ascii?Q?cHU84Hjll9It3A998NJWBIDK6Ubb3uxPpptZZ3OY1Rj69zreMOpf+/tq8y2O?=
 =?us-ascii?Q?zZzVqkp3oLDR3O9W8yi4nF7RSXZ7iKgzEDMzSoF+dqUH6zNWp8esecCM7GWc?=
 =?us-ascii?Q?Sxlz1itSqqLySTXVv4OL6kNmQYEEwUDsCiRSCGCqUSqcPbH++UFxVIH4sklE?=
 =?us-ascii?Q?JAZPab4bD++4oVOd44ZWGwTMlPRr8SB0v/dXJpdub31UxROOpl3BwqBTuIQ/?=
 =?us-ascii?Q?YYulMsA5/sLg0TBbE59mcjksOO+aTgLHixm10Iip4Rb/V9b60oExVWwZMxrD?=
 =?us-ascii?Q?fGT82rDCdekHAW9lMBV9vC3Hr6chXp95X1BmzT4uy7kPDksMQ7T9ElOZaCAQ?=
 =?us-ascii?Q?6EBXLaaGtcx4GOL8bq9T52oGx7j90teqhBH1LDt8uGUCzZVsvrQqdYOPO0zM?=
 =?us-ascii?Q?QyrqevBpXqw8ygo9UBRplIRctcxybH/uq/+t0GcUQhYS+0YJ0TjzVy+5+cjQ?=
 =?us-ascii?Q?B6d97XPtkswd9hkUF8eeMbxSCc4v8nq9GsVc1U0FXxEiU9QpVwiVz07axsBC?=
 =?us-ascii?Q?ECTPkmOQLnxFd2OZOyC9SuC2wj5VPU+4fboMTw/llz78SFh0lgacJQyjRJLi?=
 =?us-ascii?Q?f0D7wZXlI74VeKOCLkwbsA7mY/CPuUO/F+Y1ztTckarPLNkX8ynaWk8/VVtJ?=
 =?us-ascii?Q?1Anwl4QRPfZPmMMQi0yqaPR76JsJqK39NbZikovUaxKjri7Tp+3rdTjhCtrS?=
 =?us-ascii?Q?fffkIGunrOJBcH+ZR75Oj4CSgaWxZR/hR60CgCOyMpBwcPUSodcBeZHX64Cg?=
 =?us-ascii?Q?tURRRBelgIaavRMFfu84JxytE68IBbxCy8JNLEs15VB5P6krPnP3rX+nRA6p?=
 =?us-ascii?Q?yEtQNmkvecPM3U1bOGG0Tv99wSx6mCGPeWEqpSQraJmN+u1LIpcjejFPbiSv?=
 =?us-ascii?Q?W7owuQ5XeAb2sAGB2hI4x525LGj6qtPEaX2kBZ8xiQ1ZuXmg28Cfh4MNkXtv?=
 =?us-ascii?Q?+UnTEtaTSswcRB3FynBDwPCtKC9sNfw?=
X-Microsoft-Antispam-Message-Info: A1eUP4QuJDPzV95cLn8X0G1ZZKmk+LUrqJkb0ndoWYm8tIdXXCwE9QeoUxUFbMwhCI3BgMxadkgv0mFPRJEL0RFnNtOPjq93Jekq089/052mx3EoXE3JUtJ6OFbpP+pN7TMpyB9ZlMY/silhiMNRNDxQBuiDAS0gCNU7D7+O9wFPIoTMR0xR1fjWCdln/tEu
X-Microsoft-Exchange-Diagnostics: 1;AM5PR04MB3267;6:lI8oy8nynJnpzw9htr4LSG/COLU+1rBubyYtVnyx6JMpc+vO8nIub5XiKCfPzvR9L07LLHgREBFDarDkHOwJ6g3droukfRj52Hsj4adgpluCr5EWH5CgQtoR4br5LTAL0EcbSP4A5UYHG0jUkREbKesA/jT5PjomUF2nCck37UK3kh0m/kr182j5uKkVbzckKDXrTZ7JMbB+WvpHnKDJS5j0qacG7e2xuR3NDivbomXRM0zSA0xj5hyVUK1FdPU0JjNwZXtElQPm3kbahzQV6pWK9s7UpXB2GQFTYgRbfM5/WadVE/6VPJO91IpYIsROGDV4aIlVyHvGLZikslwJKzRaZ+UM83LBdNJlPLtbF/Cel+xxxcaXNPKTrpFRuPE5/zboCLPdARaV8Fcl8jnXpmwwK0PN4mOeTLcPA8AXgCmCgyPqvQzIljOquT5JJsVdaK+bDtVoBUwBv/ivJbLfxg==;5:eAr94G2QMrHUb+kjNNyrP2srzADA8+hPhkbPsg79VJFB5pb6XtGuhwWZrK+7G2MT+1/IH3gF8x5Ti27fJb0k7iT4Sy0LrgPYx/bhWM54GtJAd2XNIRUcZ+B7oBpWYbb29auyCl0B4MCfmj+DA0J4FH8DAQVZPYw5Kf4irseZzns=;24:+8j3N2hHrNR22MyEqgtnHdOCmT5r1Q1QCQUAxn92or+9GWlOfXJoDRz6ywMn5BQNvySq2Du/A54QMqV31NHw88RIxnNDAj2bD8aU9Bz1oEU=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM5PR04MB3267;7:Y7yOFp8eQPW3j7z4Mz/1WArG5yn8ZWjbSROqADO0e5Rkye+LNWYTC46hyKjTrOp8V+yYVC86DEBudeUgbvEBwIR4WaJWfq5KvYaP4EXgCrfPNGmt6SXq4r4BJNaLGzxkrui7IsIvwqHD9vi8zuukdL1I0/UF8fdyeMFwRcz5QVh93CbhKslvRtN5T9H6fi37xe48QXopOuvUdYTr4NxkNl5rxAchTLpneNUvBHkyH4z9ECOc/PHPGIe9EKTGJEXs
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2018 09:02:09.2592
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 34f66d32-8dc6-4a4d-25a0-08d58f0a6e7e
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR04MB3267
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The platform device is no longer used for DMA mapping so the
(questionable) setting of the DMA ops done here is no longer
needed. Removing it together with the HAS_DMA dependency that
it required.

Signed-off-by: Madalin Bucur <madalin.bucur@nxp.com>
---
 drivers/net/ethernet/freescale/fman/Kconfig | 1 -
 drivers/net/ethernet/freescale/fman/mac.c   | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fman/Kconfig b/drivers/net/ethernet/freescale/fman/Kconfig
index 7918cd6..c24deb4 100644
--- a/drivers/net/ethernet/freescale/fman/Kconfig
+++ b/drivers/net/ethernet/freescale/fman/Kconfig
@@ -2,7 +2,6 @@ config FSL_FMAN
 	tristate "FMan support"
 	depends on ARM || ARCH_LAYERSCAPE || FSL_SOC || COMPILE_TEST
 	select GENERIC_ALLOCATOR
-	depends on HAS_DMA
 	select PHYLIB
 	default n
 	help
diff --git a/drivers/net/ethernet/freescale/fman/mac.c b/drivers/net/ethernet/freescale/fman/mac.c
index 4829dcd..7b5b95f 100644
--- a/drivers/net/ethernet/freescale/fman/mac.c
+++ b/drivers/net/ethernet/freescale/fman/mac.c
@@ -567,7 +567,6 @@ static struct platform_device *dpaa_eth_add_device(int fman_id,
 	}
 
 	pdev->dev.parent = priv->dev;
-	set_dma_ops(&pdev->dev, get_dma_ops(priv->dev));
 
 	ret = platform_device_add_data(pdev, &data, sizeof(data));
 	if (ret)
-- 
2.1.0
