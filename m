Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752601AbeETNvH (ORCPT <rfc822;w@1wt.eu>);
        Sun, 20 May 2018 09:51:07 -0400
Received: from mail-eopbgr40059.outbound.protection.outlook.com ([40.107.4.59]:52069
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752572AbeETNuz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 May 2018 09:50:55 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=nipun.gupta@nxp.com;
From: Nipun Gupta <nipun.gupta@nxp.com>
To: robin.murphy@arm.com, will.deacon@arm.com, robh+dt@kernel.org,
        robh@kernel.org, mark.rutland@arm.com, catalin.marinas@arm.com,
        gregkh@linuxfoundation.org, laurentiu.tudor@nxp.com,
        bhelgaas@google.com
Cc: hch@lst.de, joro@8bytes.org, m.szyprowski@samsung.com,
        shawnguo@kernel.org, frowand.list@gmail.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
        bharat.bhushan@nxp.com, stuyoder@gmail.com, leoyang.li@nxp.com,
        Nipun Gupta <nipun.gupta@nxp.com>
Subject: [PATCH 6/7 v5] bus: fsl-mc: set coherent dma mask for devices on fsl-mc bus
Date: Sun, 20 May 2018 19:19:50 +0530
Message-Id: <1526824191-7000-7-git-send-email-nipun.gupta@nxp.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1526824191-7000-1-git-send-email-nipun.gupta@nxp.com>
References: <1526824191-7000-1-git-send-email-nipun.gupta@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [14.142.187.166]
X-ClientProxiedBy: BM1PR01CA0075.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:1::15) To VI1PR0401MB2429.eurprd04.prod.outlook.com
 (2603:10a6:800:2a::22)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:VI1PR0401MB2429;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0401MB2429;3:my3anuCLv4l/9eZeQRB/Cdd8loHflxsboMhW2V5x4iK2IM/jH8OGorr/sV5Kk3inaYnpba9SdfLk9Rvd2rHl3DRHRcDlbyavCrRkG7Jsw6mY5oPNyAtp+i3iCDsmRPPJqlbXoCvIhHucSzXv0JPc1EToTyBpEH2IipnvXDFHSIN/j/vf0uKl4XeGNW7Mhh0NU/Gpis5o6wU1D2atSCAjJirTQFFmDhE6n7/nObTbF8T2ybYrqnibPFTC1RgSgrdd;25:APHKcZVcFrLZn3k8inhJ4OOWRFppoH5XkkpjaN3PB5AvokzFz5XnJXbZcsHBv88nile2LLXJqtVWOaravit7yY6dz6KRi7fpAiLn8q5nXt7+NwvZvfpSNXSBmA5GQwyZ0Fo+Kcy2LpClEusRS0XTzZRCPXicwOkeQ483kQA7YmLeRe9MafZ0nkXymSV8RLi4s0FY9113puOURbo+whu3i4awQhEOuvQmvpXgErfxCEitc+dnUl3KkpW1Lz/BTsuwjla82QPcSYdOhXztOwoEkupmYYNqU3zM3vgBlbaHmJwBxx9LbwQs5NUpSqyIp10ceJH+J5qi3sxarN105mr3rw==;31:YzhN7y1Iqr4H0govaW4U2OiBzYsMeK79AhIrZVHHtgV/+IW04LxmEIRgZRb2X8PQV97EOsAgNXzSdScqU3j3K9zlZnRkgQLfa3n6w0fGyhANZhpJIcFnUly3BcNsw/77aLpTrUG7zqtXm0tAGbO9cz2X9MCAIj0jdL8fwd/XZ99Gs8mzwJIbVaZCbybVvwLaxMJKpk21x2Gu6tCRVuUQtOZldxjiYJBG1hvrG14jEKk=
X-MS-TrafficTypeDiagnostic: VI1PR0401MB2429:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0401MB2429;20:NGAXSRDneiJmH61tnvmfYXwlIsbpBKnQv4sfv6AzOHAiBtw0Hzr8n++3PAg60+74PDhSloXRbQqmnE5QkSipOpYV2QPYhOJfcUQcVJ94P+M4+oikdfGFpBdMNkUf0KPOxL37f7bC9EZ9jQ1j0tVWYvTA/Oe2a1SnydDXXDMyMgLLE07MCGxM3tgZJpYHLTXjjzX2JhtEXEzdG2KouzicJXmr9v7N38IR4TNhYPQS3Q3R4uE+OtDe+cpdu2gbhqgUYOa4Z78r/xZY/NGlR8UFO7Ani/STTu7K2r2fQzmT+oWmrUuI0Bayk/CEYtJN+Xh4UwoxEzmuNJJfMIAINmM8zYWIlxOmDmjQ0EciiCpRE56a8ixpEKf6UX9Kd9ToJGVvFbRoZwZyUeB23q9i7LKlFd15NbDDwaarNryewemwYXYZjK06JSu9xQ9KpHgVqfWni9c9b7uDpjTDWznitbwNrqbXP8gxSMDGqBBez6Fb+SSUTrW3HPlv+zJeQ/cyL/pU;4:Ixx2B/ANygZXt+zKTwvqUmUGSo6bPuvEFYFzbWTtFb0nA5rQb3pxIVx7wlaQ7ahdPVll0Q2iZLS1eWvlw7mEbLlOlu9IApV7FXA8AgkiiaORT78X5ktfR4avtcOKxan2n78b2RGAwXD2WNIUAqV+IbpO1Hjz879xwxdOK/XOATryRxc6e8t1weYGiDNe/JyVIZHMCH18tiVw8IRHDw/OMH6FeGl1SAIH8UWJ+6b8b40OOlQ4JayE7Mnf98/idwl4+CatTQo6xnujUos/jl0U/aReTtgGWRliymgIA/qbBLiBxjZ8IXv6/sMF+ygBEkau
X-Microsoft-Antispam-PRVS: <VI1PR0401MB2429D9C556F75A73DA530DA8E6960@VI1PR0401MB2429.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:VI1PR0401MB2429;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0401MB2429;
X-Forefront-PRVS: 06780E24F8
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(346002)(376002)(39860400002)(39380400002)(396003)(366004)(189003)(199004)(316002)(50466002)(50226002)(47776003)(3846002)(86362001)(39060400002)(66066001)(6116002)(8936002)(16526019)(8676002)(7416002)(53936002)(6512007)(48376002)(486006)(186003)(26005)(44832011)(478600001)(81166006)(81156014)(76176011)(5660300001)(7736002)(52116002)(16586007)(51416003)(6486002)(97736004)(36756003)(68736007)(305945005)(4326008)(6666003)(106356001)(446003)(25786009)(5009440100003)(11346002)(55236004)(6506007)(386003)(105586002)(476003)(2616005)(2906002)(956004)(110426005);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0401MB2429;H:b27504-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR0401MB2429;23:CNayr+z3Vy2CI9VORyK8AD0jB+Y2YvjV1/foUiA?=
 =?us-ascii?Q?1KPPEqMH+tQCuXK1nkbmxYL2DpNjn5l0/nXhOix1UPYC6rIoJTdpsrWzqsuP?=
 =?us-ascii?Q?tuOTCwA0o8UgOSvDRV2xLzPnHtfv3c+hBPchCoBz2u3wOmbgxvlzZ1ZQhYzO?=
 =?us-ascii?Q?0OnYLe6EOIowOIiwK2/wTKztj2SFXMmh/So5j6uYnzNZ/tBaZC35Io014VIF?=
 =?us-ascii?Q?fsMyx8dMOEiCefvFIR+J/9qOwqjxRiBrfUzreZUMNz8CzXGsoMhqTj5wdjg+?=
 =?us-ascii?Q?3R+Q663LMQWa6IfjryKcIjRkwip2azJWjqmrTU4NVUXufoGQIWVfu0p+y59s?=
 =?us-ascii?Q?ca0K+WrdutDz/UE9EMKhtdwSZSwrIw0qbthLGjZROKa7uzrImbpdMpGlaHRO?=
 =?us-ascii?Q?rFC1g6d2iLz7lrlYkBULgIqPRvwgEgRO0QTGV/7mkJwLLSHe/rSkds8iJOVa?=
 =?us-ascii?Q?VqCz0Z5I3eBA2Re6/ptEa5I3dwAcSZC1CdIyTDIexZ2kguFP2PZUfh0Wysze?=
 =?us-ascii?Q?uOXxVyjsWb4U6STFQFqP3fdL/E9WqcwUjS4ypUUw7OlnOuCArRMrV6a3seG7?=
 =?us-ascii?Q?Ij+6ptmMBJKnvodb9bmz0fqBcPO8FU6c3+Kv3Rgju1pva7cH3ReMVgbBBr5K?=
 =?us-ascii?Q?eYPGI8RVxcwygb7NFIw78XZcpS8FjHSJvgq3Y3+ajehRbg4bxQoHxcEA80hK?=
 =?us-ascii?Q?A05ox77qUX3McRSR/VgKKnjQlJwBrN0syw/XVtz0wmZdcND3gpQGF29dEcX8?=
 =?us-ascii?Q?wj+EbM/uPMTxX2ee1I2AoPBdJQzi0IJoiPPVfE6uWlZjeeRNhYXpa/R9bXqf?=
 =?us-ascii?Q?72kJB0jYiRl1KX9mQ9iYMVG/t5OJf/9IukafEzNuaoKMFgFbIYBsTw/z4JB6?=
 =?us-ascii?Q?ztb/oT6NSKgotkP1I0Gvkybw/+D/5arLJ1/luBMf5b1es1yNh1GygdavoW5i?=
 =?us-ascii?Q?Yn5J6yH+hHnLYNParSHE2D6Xxivh0c1fMkCJBNl1MjxloqKvupBAWguLgoWa?=
 =?us-ascii?Q?9piJ//b13N67f1fFKzeFO0PAX3HoIHrlEKUshprd1xLUHYt+4HignFBny6mN?=
 =?us-ascii?Q?ddBhK1cjMd58mSswB7Py3EV3wgtcLJpVgnzAAnPgQfa2nJmtJRNLuUjyzVcv?=
 =?us-ascii?Q?WhcoG7ysYQvudCmC3cqS8Pd4zFAo46FIE47A9UV2aKdOdoSt1e1pwusx1u4R?=
 =?us-ascii?Q?jIhkeiFi/CPTOQvPN9heU+QqzxXbZWqfT/l5dcMr2h2kmv9BQoBJeqhozTJI?=
 =?us-ascii?Q?DtHiJ1e4uvGOsNFxk+1JZ4NUY3ubgWSV49Nq1m3DkwZOAaVgyn2yitwR08iU?=
 =?us-ascii?Q?VIGkb1Vh2x50KzkLrbb0glJQ=3D?=
X-Microsoft-Antispam-Message-Info: aSXHDBTdA4etERHV+b43p8zV5jkxLQGsPCTrjHIFh88834vIpFz1TWo5uVFDMWP5a13GKIa5sjhlLd7xlLC/pKGIbD4r9QZORRnYM098s6AZ4nSxvA0VkGDGgrZpVzai34lNhePhKUQrO9Q3yOJaetMI/c1p9anb3aPAR8DHIK1ayEpDjK1+gK0Xth00LfZs
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0401MB2429;6:mSr1y07QjEnoyvgxUjTzUeWPJnusrAcQacplOSWn1SHbyXltTICX/E7E6ukM4oq+fMb5bdATmNyoHDV+a9KDl24SYaBDx4QH9GIQfkee5T5P5uJQaV+JYFt307OvoSaX/L4+BTKifnFnTsaDB8ZDPC+Dfawd8J4nKUAejjhh2IRmeXptPB1mX53WnH9s/iPnmapQbpZLqXgpDc3xIkdZoRrnRN4yWoBjtJhqD8inNDKtEQfGblmSnemW2rOg9V5lFiYEwtG676Yd4ZFcDCpiiJzwIZDTl0PEobna7Z83es3hVPIMq9Qt7yA6Zc7eSKtkRGj8QeTvzXYt4goa3pPLzGQ+SieSQGKFj0NscUrYK85g6WVZ0XVBTS8rau/bZ7MTzTwTczmGFm74CKWOzUVrV3McXZitBjDxCndawYcvVNGdevps6lqlGObwWIzjChZlgQpGJ3RMcdE51Go0SxJ3Jg==;5:TLNuGWABi4ecQMQanSwYis/CIrPKrnuEj2m/WX1DnXuBHOhUZKNugjrAYn8mng4R7EgRsl/gZX+TOidFKLxfVdQeOIgFmojlZHrUoLMcbgje1/WHFb8sBn47TYxXNe8vK2cAGx66na5v5f1+/CLS7nwFFuNwm7pw3kHWVTBAYf0=;24:PkmMNCKbfsui5/X1ISR5ycpeEFVQspPtSAMs2hEAUJ6zrX4ldSb5x8x6+NuO/zzlw2rSgZgZ9xTomHjrIka/UpJHrZeu36gVmiBwIE4RKN4=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0401MB2429;7:L+H8v4rxZROTglmgSytovCcqZT24hgsmNXnHCmjKcVoBPAc2D6rS4qSJst68HyAqN08T7DzyBcdiaiwc6+2L3K6dcpuKkQc4t/sXL7c7SU/AV7UDVTLiXYl458/22PmGXfoiAdCi5DFp1brK6bQZH9NBmVh6Y8XVXcHIEX9mnfVzFMv/j1ZtUK08NNIB26YGdsMSAyRxwZwBVn2MLBOdmTRNqULoEBk8zsGU0Cw2D3NdRv8C9nKT2UkzNZ/ROcR/
X-MS-Office365-Filtering-Correlation-Id: 1c659ded-069f-4e5d-3f4f-08d5be58b336
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2018 13:50:47.8681
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c659ded-069f-4e5d-3f4f-08d5be58b336
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0401MB2429
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

of_dma_configure() API expects coherent_dma_mask to be correctly
set in the devices. This patch does the needful.

Signed-off-by: Nipun Gupta <nipun.gupta@nxp.com>
---
 drivers/bus/fsl-mc/fsl-mc-bus.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/bus/fsl-mc/fsl-mc-bus.c b/drivers/bus/fsl-mc/fsl-mc-bus.c
index fa43c7d..624828b 100644
--- a/drivers/bus/fsl-mc/fsl-mc-bus.c
+++ b/drivers/bus/fsl-mc/fsl-mc-bus.c
@@ -627,6 +627,7 @@ int fsl_mc_device_add(struct fsl_mc_obj_desc *obj_desc,
 		mc_dev->icid = parent_mc_dev->icid;
 		mc_dev->dma_mask = FSL_MC_DEFAULT_DMA_MASK;
 		mc_dev->dev.dma_mask = &mc_dev->dma_mask;
+		mc_dev->dev.coherent_dma_mask = mc_dev->dma_mask;
 		dev_set_msi_domain(&mc_dev->dev,
 				   dev_get_msi_domain(&parent_mc_dev->dev));
 	}
-- 
1.9.1
