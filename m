Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751835AbeCWOwv (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 10:52:51 -0400
Received: from mail-he1eur01on0075.outbound.protection.outlook.com ([104.47.0.75]:39360
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751400AbeCWOwt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 10:52:49 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=madalin.bucur@nxp.com;
From: Madalin Bucur <madalin.bucur@nxp.com>
To: davem@davemloft.net, geert.uytterhoeven@gmail.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Madalin Bucur <madalin.bucur@nxp.com>
Subject: [PATCH v2] fsl/fman: remove unnecessary set_dma_ops() call and HAS_DMA dependency
Date: Fri, 23 Mar 2018 09:52:25 -0500
Message-Id: <20180323145225.9130-1-madalin.bucur@nxp.com>
X-Mailer: git-send-email 2.8.3
Reply-to: madalin.bucur@nxp.com
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.88.168.1]
X-ClientProxiedBy: CO1PR15CA0056.namprd15.prod.outlook.com
 (2603:10b6:101:1f::24) To HE1PR04MB3273.eurprd04.prod.outlook.com
 (2603:10a6:7:1d::32)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 5c4c6a51-029e-4162-1db1-08d590cdbd9a
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:HE1PR04MB3273;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB3273;3:Z4Ylz1FCAoH2j8CQ883hxkXPg80Lu+MdwqJrzWeLm7HWvPrioKzgrguR+2KN0tOic6+DMmLeAjYOHeiZuvF7t5xjlGoc//YFE/l07Y0kzrJB+iS9PhZGgaoEPe7qzrHQa0TuTGMKJ6WTDyYhcppD2FIeBZ+RHVSMKxxtX49GSZBOmODzWoGFi+waai4r0eNZph4OQZPe4tzcgOvQ3GvcmLaNCsidhI3yuUHBSpWptl9f1F80skk8IxqVseqUXakr;25:B+hdSNWN6ybADvHuz94bdAGSJxBH161xgXWgOT2VSoqtAFjunJ8z2rGPSQzcZnbT3owqIUa/MUCr/3xKizu/JkIqV3yKIynOWlEsEn4U1IyAgaOhnLo4v/r+QN1998eP7KXiHkN3EubFI5eE/ZkJGeXcJiUn5Yxcw+Ii4wpwDHbBU9PN1N91be4YyDV1m2Rdp/ZmIwZdhZQaIqNx3IFSLmvr2ciap79pnf+254u+OxkyBMGthLCzp4Y9zBcKBSqyV+p/EDjJVd/+TffRy3YfaekoNDP66VvU7mxL53i8K/JWfBVkuZzyOIaFRirPxb6D99YkC1BwPkL6c0bMh+itLA==;31:2aP736Bd7eQURjcte0WQxVvh1sB/TsZfGRJOO4wBeVY8W3Vc/whKlMGKv1T4IyDB7aCH8fWHqhQjtJyTnDkhdhUa7t6vMs0FJ0HKJJmojHtNkRRuYbBXXQS+STZ1Wx1iV/XHWQWQV1EHqWzR4pvwxp5iCbsuJPYpk/Om77lIS2PTJQw+qk7efneNG6dIBtncwQ0l3UgrTi7EMMTLby0DNEztAYGPJcgRjvvy9+ixLxw=
X-MS-TrafficTypeDiagnostic: HE1PR04MB3273:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB3273;20:dDN3jOdYkDG5j3ict1Uw1SbgbX9isCDeqo7ttfpFRc/1oYtgXi+VF4aT8Uiof/RxA3HrKn2rgN46C5VmMI4F39K6ZlkHaAwseuMR+YP1eXjZZ0iQWHad/tUoMaLNgXn235/WiCeJyztP73HVg1QB5ztw2X8VShq7XDPXeC6qb3A9FYNgEcXgksbSiQ+0AgIohFaiKDPBQVeGWaNyx7lPe9jtcOS2pd1efUzQZoFMQu+ca5MLyiNPTUuSsSIzmy5WPd5Z7y8zPVMdJ31QPaOjcDxRXGZy07kEUeI4AvYJHBw3P7V8v9Gow5XpfZnDWj1J1jUWRLf1QgeajYTLOBe28wa2LSw4TFDiFz+yanBqiLKNt++TAPH2gu5eSXw43+MCF5O9bp4+yReaS6nZypjcuSkYIkvcpYqQ9w7cMzdqh0EiA1yUEHUAmC0xI0W8iM1qam+hRgzrjzNUzDF+iSTRMbXJKfzY8+UHvI6EhJpvBwWtDqcn+r9nTW4FIkgGaQel;4:3ybk9DhqCWhVybEw1lIr+YVlmzL6So5gddanjGKtba5qfgEC2l6vNNHn/nujUDoWQV5XYMCaW8csTp/jqoyP3yAeyTDyCa1gVNKM7QKJ9TObDKeDkuGdzO4dN098SlpowHQBBXTpo+2bM/uQ9jF3wyocGn6bv2w6XZeY+Qbh0RISp3PTiShMgzgA3XmjIMb+BYbw5yGUQ0FvVe8NOAsGQSSVEyvqDCiycs9PEWGhd+zQMX2O0dIjwoU4dCKPqbw540BAsEH/2/Nujsq+Rw+z4v0niP8jURcLtS3aSJRUU1fU6VoUehJjK85UVbnJN3M7
X-Microsoft-Antispam-PRVS: <HE1PR04MB327354F470F2C99778B662A3ECA80@HE1PR04MB3273.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231221)(944501327)(52105095)(93006095)(93001095)(3002001)(6055026)(6041310)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:HE1PR04MB3273;BCL:0;PCL:0;RULEID:;SRVR:HE1PR04MB3273;
X-Forefront-PRVS: 0620CADDF3
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39860400002)(346002)(396003)(366004)(376002)(39380400002)(199004)(189003)(43066004)(8676002)(8936002)(50226002)(81156014)(105586002)(25786009)(39060400002)(48376002)(68736007)(36756003)(3450700001)(2906002)(81166006)(6666003)(6512007)(51416003)(4326008)(53936002)(50466002)(52116002)(316002)(47776003)(1076002)(6506007)(386003)(6116002)(26005)(305945005)(3846002)(66066001)(7736002)(6486002)(186003)(106356001)(16526019)(97736004)(5660300001)(16586007)(478600001)(86362001);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR04MB3273;H:rhuath.am.freescale.net;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;HE1PR04MB3273;23:8BxInlHtwE+YNZQU8tqppenv7UdkktDZFmxb7/Ijr?=
 =?us-ascii?Q?+zUZO+cX5nBL2dnfG+3cnrDrmXlcHyGl0LIGuqXTeIhbuyVrZ/A2S6ddwPmr?=
 =?us-ascii?Q?uIfuyr0hV5yNOkyoAvd+a60ZXoTV9VrV6SCY5uFsk/Qz9BQ7THQGaaqKd/jg?=
 =?us-ascii?Q?QC/OVo8HDgrzJvMbFHFpXl8KG3sULdg0eOGxmggRdw3lhCb0vt3DLr5SOvbw?=
 =?us-ascii?Q?C5++kdodL7p5x6NKFPFzRsCsnbUyGRflfw/XoQ7qTctsc6sDsOK3Z6K+btXW?=
 =?us-ascii?Q?sq7O2JvQK81crI/cV2FajbszPmQE6RxWuXLlnFtXs0H8Az81U3Z4tdUofsen?=
 =?us-ascii?Q?NDE3LOQhcNg7lGyDMuUIp8tM+Nc6NRlZTTDzIj/PriomSSZb0SGq6f3dpC8N?=
 =?us-ascii?Q?6AfvCyhzvEMlhCPg6b4y3q7kiFLSm/Iq1lEwmwk1SGz/AmTiEv8//FMw5SZT?=
 =?us-ascii?Q?ePMXPIG/rYJOAoJYAZRHJFfNX8m8m0hV/eL3BzhY1V38PcR2sR8JaO9hUStN?=
 =?us-ascii?Q?Y/6OiQzfxBKPxKqAfrNaVQC3YUiHm5gu7bYRTqQmbc7dCm4JuML+oxthngIJ?=
 =?us-ascii?Q?HsrVorPpQ12crBkzCZjIAkrER/tNSCvax9R44uM/lWQ/m/6rtSNzVgTjAVAv?=
 =?us-ascii?Q?MkzksohEc8hsyFY2q4HciuuFZl3XzM8NR3F9O+WFM7ISReX1EonTC/q01Czn?=
 =?us-ascii?Q?bcZudKF63UhpmRha/ZSiJo1UMl4e2xLYpHiMvNq6dAwHrfVgpSzCLRg2Z1Zu?=
 =?us-ascii?Q?qHaEt69QRu4T4VihXIolTaeze5tGiEb1KtARWBalEsbOkte0bZAi+zufS8Qy?=
 =?us-ascii?Q?j2O61bAJMP9laAZMZzk/UXB+mCL4XzavH9j/1DJZX9DCQDMZQ+ak8QDJZ5kQ?=
 =?us-ascii?Q?ciBSFut5dAeuDxWyAwul1s2desE9OaGbKSPSSl8JdLp2Xhx5L+9I/ro2r1no?=
 =?us-ascii?Q?vhQmspBEpM+q9yY+ijbpOFP/MO+yEDXYuXDFbINM/cNBkyT48k+ijUOtg7Ch?=
 =?us-ascii?Q?zLm7T63OcvYpngPkGU1xz3bU2j1poxPXUNpj0ctuE5Dg6drPOA0RC1ee3fbb?=
 =?us-ascii?Q?3GskSquccB05SxlQc/c4/0WV7bV/bWBdYdQF2IlizlA4v1zVdIfcwFzk1fg7?=
 =?us-ascii?Q?Jo3HQlx+Lk=3D?=
X-Microsoft-Antispam-Message-Info: /NbeAbyzGcWkW7YOIsDPN+hpGH899ekhw4j9OmPsmlTN+7uJBF3FHIDSzkkceaX8ymdRW3ez2iR4IB3crypb5PSBdyak0FCuKgEJlK1JTluCqY5akM2ZyzxOEgeCwH1vH1ev18WBuUpbilVt7+aBRJ3v1xPxbg41TsI6+1Ru8EIUD8+gLEQp0TIWy9vy/diz
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB3273;6:UBHTZyhX/zlogAwVKiKOfWSB/cmRBfOuFTfuM8DkXVCTstBN+JyW+DFusgG2ougcePrGSBmIxG+IdzDqhvqv+SK17AlijzqR6KFLuCLp+u36lib7mhilu4giODxdYDkRXzAULqDpW9JSUEwBkrIxYGvXLEGarw2VgTKXQBLxusCUUq4HaIdVjYzl5oCWXBi4xj4JYL4BFhilkicQ4mQ7OT2DD8Ix7G5dBBjwCxJUKR1KSw/77xUKmQXIieBHPlRKl93jdSxKHN+IpOTfKu9XfRmcR1IjhL9eiqAEfhWZZ88HCjQ0gNShJI0ej31hiXmYsgpWeoqLAqqwn1yZfPTzsuxbhBR6LMdwGjxqQL6R1sY=;5:9eAz3allqDCXmocES3FQgPiO5JQIaYES63I386LMxvmiiDRbHAtZDwn++Rm+KOrWr+z513YTa7U98kXRSrvueaxqhAKUg/0OumQJoYBUUjkOa0n9gL7qSU4s8Sf0lWzqbofFl00+R0Jsn3f3xpaEOYgw3liLLfB7xw2lVjHYKBE=;24:8h9fnpZK7m12sd0uAQG4j/TzCAWt9gRepbLl/AHNJltInsXzLgQyZOHpbLYpGxqma/niw0ZqUGSbO0bPLCS6NDIN+zHHBLXZEQDAGUnpW4U=;7:IxYfhStbPlQMS/VxNU9tyq9TFo4hpDGi8PompWTx507ThNAyQ2kdGKv1xmsN9U5lTMvdS0IjQfKuyER5FGP2raycmkjMAsaeEVah6fpHwlEc21cYLCp5UM094Ck/NjvuUrRziYoLZKxfAC0vkDwj1DtvAJ6zrqviR2dzZZ32qtqEarn8ivDf6y2c+TDdQ5TUoWtrZtE9+H0Q4AugBPVzjBVLRCBZ27JTMzNrKwWMqnwuTysjyxvH374Jk4Kd2Xl5
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2018 14:52:44.7888
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c4c6a51-029e-4162-1db1-08d590cdbd9a
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR04MB3273
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
index 8870a9a..dc0850b 100644
--- a/drivers/net/ethernet/freescale/fman/Kconfig
+++ b/drivers/net/ethernet/freescale/fman/Kconfig
@@ -2,7 +2,6 @@ config FSL_FMAN
 	tristate "FMan support"
 	depends on FSL_SOC || ARCH_LAYERSCAPE || COMPILE_TEST
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
