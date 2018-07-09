Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47C03C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 11:19:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E409520881
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 11:19:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="TM6Pd28G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E409520881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933060AbeGILTP (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 07:19:15 -0400
Received: from mail-eopbgr10060.outbound.protection.outlook.com ([40.107.1.60]:52736
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932770AbeGILTK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 07:19:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BYQspJMUTiCUuLRtncdyrdec+hBVsV2eAvrASGYGbCU=;
 b=TM6Pd28Gl/y21s0XgU91pLi7HgiK3AZMli8zYhJYWuYjmE6lfsgJcTeJKaT+Tqz0ALcvRoEWcYq31NccSNFymb5vCZz4Ca2oI4BMDi4pJFe9xTXQp5Wdo1ThzSzs2pzCI/VPuETWrLY5btrEIXWePx+jPcnsEqvGBWqtJB/Nb1Q=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=nipun.gupta@nxp.com; 
Received: from b27504-OptiPlex-790.ap.freescale.net (14.142.187.166) by
 HE1PR0401MB2427.eurprd04.prod.outlook.com (2603:10a6:3:25::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.930.21; Mon, 9 Jul 2018 11:19:02 +0000
From:   Nipun Gupta <nipun.gupta@nxp.com>
To:     robin.murphy@arm.com, will.deacon@arm.com, robh+dt@kernel.org,
        robh@kernel.org, mark.rutland@arm.com, catalin.marinas@arm.com,
        gregkh@linuxfoundation.org, laurentiu.tudor@nxp.com,
        bhelgaas@google.com, hch@lst.de
Cc:     joro@8bytes.org, m.szyprowski@samsung.com, shawnguo@kernel.org,
        frowand.list@gmail.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
        bharat.bhushan@nxp.com, stuyoder@gmail.com, leoyang.li@nxp.com,
        Nipun Gupta <nipun.gupta@nxp.com>
Subject: [PATCH 1/7 v6] Documentation: fsl-mc: add iommu-map device-tree binding for fsl-mc bus
Date:   Mon,  9 Jul 2018 16:48:17 +0530
Message-Id: <1531135103-10699-2-git-send-email-nipun.gupta@nxp.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1531135103-10699-1-git-send-email-nipun.gupta@nxp.com>
References: <1531135103-10699-1-git-send-email-nipun.gupta@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [14.142.187.166]
X-ClientProxiedBy: BM1PR0101CA0068.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:19::30) To HE1PR0401MB2427.eurprd04.prod.outlook.com
 (2603:10a6:3:25::24)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1d667d00-131c-47fe-61c7-08d5e58dc8ae
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(48565401081)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:HE1PR0401MB2427;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0401MB2427;3:R4P2Th7usN+GaKC+oDqQMrvEwjSCnuvcyoR3AdOqpZ5AJj7X9sHSZxs5WAPSK7QV8RkXrdyZ/EVj3KB5zppY3gJwgBt0hluMjKH1c+0CYlWtVTWCul6dVNu2itEySAqxbitvxQnKHjpJRJpgEvqel50N6qoagvF5u8b3uySGKrpI0fb9uzEManUGI1yacsGW0cHOduEEhTnIJIPMHXE4YAa1RC/0ccVcXLgvxpW+MsrPF34MiBow268cs+N7LERa;25:3D17kELRCeOQF77FPkMZs7QOd6TgNQUOo/P3KxUexowiP7LKKR2U62WvCOx4dY4Oomkz8wgNYIM84UL42shKDlJC4arWdwL0keunYjM3iW5tnm5U0UwlCqD6RSGq903MfqxjBCUMe38Sm/mhVWtbhUKAHMboNhOnD81p8sXhQU0jwg4jaUDP9pz6vwjRPETvU1eAoBJ8UH4tVlwxVekD+4SvzB/1BgvQSg/ZRxYiLJX3TE5UGUlJ7nnfHl2RSSaKL6IO7ozWWobSrbNzgraTPxUHvWmJldQWT2Ld1SFRxjGhvfam3/JhPQQ1tkcHRPaVweAi6WlHZpPMcxGwQekGSQ==;31:5PK8XTTmqL48FByliW27PKZLcjPdFTbi7Fpzwz67AdVmFoWgz6WYXf3E1gIw1aMzdFL0BaZBA7no51NUlA5irZj0A6mfrJsZjBxn5WXbQxkOO0qkeNIR0rV3cBSVFtjNYzjtABB3Uz6TOTpsqdH/kvNikblRB98dggcMAatLqE2/fgYYTQavGq4e8u73i8FMpkctu+YVt6CiehK+azQk4qEK4UEpFU/wOZeSwxZlpVE=
X-MS-TrafficTypeDiagnostic: HE1PR0401MB2427:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0401MB2427;20:XgJxO3F673+3L+CSPJDqX+1qzmyWdKSODLq2OfS63DXU2eShZ08jx8yVmNSdu8RjP0/42/GrBOxT7lxFwVJMDblFK4esVTMeKh7b16Q7v6yo8uX5hy7eU9r2zkupV+OSmpcrJWa7zb4/hbtogRi/z+Ep4eS0ooAIt4EIwy4xUMkcV8STVt02cVX2OO0Y3CEXdxaUWfg3E6YSMzJehrY9ZbDSwRhRxFIvspuwK9hLWwIGD/twf3F/0V5Bv997AeyvZooZPZOB/bZw4t7SPFDp2Abr9lkHY0CUaY/3+I8Zupg8BYnm1GD+zaxebtI21O8U/vFYPAtVpTuHhF+vfm+4h+p8VoNAnAoXs0IwwLyFwTK43c0fGaY54isZvHI3TPC7XsXjdVBO6S87Q2SW78KBLDG1sT2IhdgfbsV10V2MqJ3+Uluh+CMppK0LLvCnP7wdQ3IHKszazTtYxWN5kvuaA3XV7MxgP+oM6VUqhYSyh0A+MeekBF7Qid4Nc+mN1XUz;4:QwkEqT8lDquxCeJVuw8Cgq0Myn8nB9pA3G8e/B26kfKhRNOJjbgBY6wbm1zaw65NVcGa5YBJUm+72BfkREcoe8afmoSPHfCndsQSv9H19RaCFxvVIdCLrTvVxhiMBA5VpAHtp856XqdEhfwb7iaVIRFW2p7OT/8DdqxhDpE4Xk3xfj9ui3DJMtsYXrYLUNlu0iAV4ekedpvNkbqzAazuJcH4GA30LjGXNrXGBoM89Dr3LA2G4KoLyXc9Do5BEHTVURAzw8byyxkUYpd6xBtnumIJB1MkQHwVTkFriYGIjV+B4CQ4fpp5X5n8eg927HIeJbZp15i+2p0odAnf4kMqRuPGKMdqtKIlpMTsFASBu8w=
X-Microsoft-Antispam-PRVS: <HE1PR0401MB2427394A51167536360F54D5E6440@HE1PR0401MB2427.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197)(275809806118684);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231311)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:HE1PR0401MB2427;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0401MB2427;
X-Forefront-PRVS: 07283408BE
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(376002)(396003)(136003)(346002)(39860400002)(366004)(189003)(199004)(44832011)(446003)(25786009)(51416003)(486006)(81156014)(81166006)(2906002)(39060400002)(6506007)(386003)(50226002)(7416002)(316002)(476003)(4326008)(2616005)(50466002)(11346002)(47776003)(8676002)(66066001)(68736007)(956004)(48376002)(5009440100003)(6486002)(7736002)(76176011)(16586007)(53936002)(26005)(478600001)(55236004)(106356001)(105586002)(5660300001)(186003)(52116002)(305945005)(97736004)(8936002)(16526019)(36756003)(575784001)(3846002)(6666003)(6512007)(86362001)(6116002)(110426005)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR0401MB2427;H:b27504-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;HE1PR0401MB2427;23:uGnhe90CoZNyXl3jG9AkeJtTdzqZeC/5kzE8X4D?=
 =?us-ascii?Q?b4JXCLuuFFFkPraEbZnX5XYuN9e5X80mgInlOAYv3MR/REdjzIhK8XPGQoU/?=
 =?us-ascii?Q?LsWhv32AqyGavF5SMoozAt/qefos6Ixyk2S/2qICHsUyEQIrudDcP/prkAz/?=
 =?us-ascii?Q?oyTYQGdnAwQCAfTDEdaeeBdUUr1movGV1V9KV0doW0gJfcms6NolybJnq8zW?=
 =?us-ascii?Q?mb5LDzvGZod5Zc4vU5GkAXeHBX1VOU26Ou4u/BDOtN1OBCK13j1Ar0/kbRPc?=
 =?us-ascii?Q?vNE3CgqMcJUCKvDOBPoEmXvqAsBpeqwdC2jBiS1MiKf8torvimNks2jccH7j?=
 =?us-ascii?Q?EczFsEebzltvp3H9ALht6pDCe2CRdqQR6mTbOzsGcgnhqHy+jYZOYa/wTf/E?=
 =?us-ascii?Q?1m6IhPzeDSSt2R+Yg/jypEDF39p8QvLzhe0P0ItJLa2lO/E1rYWf/oNkYaaO?=
 =?us-ascii?Q?xJO0nEiIIH1RfbmkzcEHXBC+CwiBeg7gEvmdtTpKKcZt0Fq4ZDv6zDuy3NMr?=
 =?us-ascii?Q?6mKKSXuGPi7yRwu3At77AuMrUfamt+SceJObD7z3j4V5loCFd3gZ3mjKY92V?=
 =?us-ascii?Q?j7/wa5xnvNvHJQEohEFtNN8H3CHTya9nQZ64fkVHBD4NlZP2ykJTskjR7zf0?=
 =?us-ascii?Q?2EAjmicHo9nydvIsPsn4XLnbIw8HcoIsS6CtED/FqPqnfUu45MOfXMYnrZSZ?=
 =?us-ascii?Q?TVDmRVQ1w33duM2Xknc9FvHLI0e8VA0LcvUbNrN8MKaVDU9JQUTIRhc4D9hK?=
 =?us-ascii?Q?bGq5eIgXkyZ4cTHC8g72y1PmdxB4QGSm5XJHdNYhfllbbguhbNb8YM2eyFP2?=
 =?us-ascii?Q?VGEJ927ye0UE5rw+jlQmXUo6eqGTJ0PJvnDcolM0iSQSduUlfPdCLacExDEd?=
 =?us-ascii?Q?PH3iS3TJcLmS/Y2r7pUrwiyLKRyIsoBnHuJ40CuU90rwNn+DoFVaPtDHHiFN?=
 =?us-ascii?Q?FSJ+8RNhbSznlwCbmD2Bl4ENmTQMMghQdWHLAvsIVibnPipq/q9fp2BS1rgu?=
 =?us-ascii?Q?BYw+8U88XJ62pW1biF6EyXNsqTvI0FhapAcSshNEVKmMOTY32qQTmTtKBUyr?=
 =?us-ascii?Q?ZvRF3+ivmvygEwAqU0ZG9aQhR3OZDW2QWRNHvgF2nfDdGFNKoWebcLCjbMLc?=
 =?us-ascii?Q?rUrKhQi6SbdsUUa7/b2gV8GDiTU48RBGRGidnINjliSoGj56UeVkGiS3GCw0?=
 =?us-ascii?Q?Kxs6ZTx9wPRyEBACSQyaMcwf81rYVOMjbDyXVDqxfhHp3ARRaqqaH1S9Eix8?=
 =?us-ascii?Q?OwAL1g1PToD2etXnb0fhCL1+PASC/DKsqGE9g2BQjqQApmL4E7OmDjajfIZF?=
 =?us-ascii?Q?dHd2kyTwIpjIjEGJscPQsqDmQrz4v36I53lD+vu6oatMZKOsOIWbNoRnbtGL?=
 =?us-ascii?Q?iMzN7gw=3D=3D?=
X-Microsoft-Antispam-Message-Info: stkkwH+r0Ry0YhvV1wodE6CZn+wLZHqeJeE619N6uT0k7wyFexM6m081z2jtwWvxYWP6II7eJKZZUbzQZ6pge4fzkLSrZ23ol/9AsgjrXeHgBeewrZ9kGwJrEbEr8AmOsUlfpqcmgQP74cwRsQYpvZIOgqWTozLwEiV5Vgjxjb3Ls7hTnQwmUhEzjlFGVH+XQsqSnyYh15CZ5LSQqCOoYwtD81aOKC2TWsKYGfwgo/MrdpzXAeDsY+FCFZrFiOQoBQWmaCvqUwLKmaar4UJZQWL6nxX9pX5uKSBIClHGjV2lxZmOpiOzSvnnmMuStjDOXiZIoyIsPZNOEzAraWV95XlAu0UpNu0kvoZpHhunSdM=
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0401MB2427;6:PSbSNq4UAoDevEUKKQymxowMl/TKKXU0m2+GEKehsB8VXyQ1fs8AXzSPy1rk2k2zdfD2iqByyARipgx826ogGcLR4JOLZMqCyuxJyLwzePK+HRW2dPokmEXj4OZ/yWdWZgLD5ror24SRReKGx7gvh03glbGmXDAvsshcb0cNarXOPQGzirzumAIjAeerk8zdGMQYAdlryDcZcflbujj2+UKQgogh2hM+gWYmPx9yYcnrodZxun9q5I/GXv6lfyjmsD7w/aw7+OyiOClvub0mkxfCCmyqaclYIuoUoWc41hDQl7CUtGc2xJOi8JMtGEPXqhkmqMyCJsB4HR6q/spdYRyd+55YQqN46pblOtmX4xTqPWrGBINuP8W8QM+RlQBteT/1EnEe98dLRAbASS9XYHeY9YNKyxwE3O1cyHyo0UrUZ8IuVwoYlMbRm5yc8xYQg45MPNKzh1n5aZ1EuAuHkw==;5:Ir+MOof3ZD9FplZBciyGAe1SN6kM8+p6hm91QY5qDYQnvooecx2VL5812bNzqiMj0e76LamlG7RTFTTvwJn+yUFFWDtj5jdnl0agIJtzl+znOHvg/dfa6osXbIp45rNgss1OJbGjrxx0EDtWg0wF1X0sR/QVoDSGcnEpVRwRFxA=;24:EsKgWcAaydei2bwCihmubukWY1CKecRyoa4t/9AdK+wltLvNx1EJrrmI8jY4txkPviSqv4JRLmNL6pm20i5FEm6MGJSE1fJ4xsNdn7msqiE=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0401MB2427;7:b59EbJvFW3Dsc8Kr9Hp1QaKuZXVH+SZDBtNz55x6OJvBhfDbej+FZfkmgzyTaHx8x3tx8U4Ik5LfiWBmfP8BiExT81aO2P12DlyfbN1nTZ8N4A5kE6dRkJcmgtdZKxRJBkdvEVo6xKMLRYMFjoOTqU+JH584G30vH7wiFLI27HODxtJNISivq5Mt9azRb9UUxTbvpqf0iITS+W5BduT1q2oY01TtSh4lI3u9OGHuB+K5FoB19bxfrNOrdMBZl5lJ
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2018 11:19:02.0580
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d667d00-131c-47fe-61c7-08d5e58dc8ae
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0401MB2427
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The existing IOMMU bindings cannot be used to specify the relationship
between fsl-mc devices and IOMMUs. This patch adds a generic binding for
mapping fsl-mc devices to IOMMUs, using iommu-map property.

Signed-off-by: Nipun Gupta <nipun.gupta@nxp.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/misc/fsl,qoriq-mc.txt      | 39 ++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/Documentation/devicetree/bindings/misc/fsl,qoriq-mc.txt b/Documentation/devicetree/bindings/misc/fsl,qoriq-mc.txt
index 6611a7c..01fdc33 100644
--- a/Documentation/devicetree/bindings/misc/fsl,qoriq-mc.txt
+++ b/Documentation/devicetree/bindings/misc/fsl,qoriq-mc.txt
@@ -9,6 +9,25 @@ blocks that can be used to create functional hardware objects/devices
 such as network interfaces, crypto accelerator instances, L2 switches,
 etc.
 
+For an overview of the DPAA2 architecture and fsl-mc bus see:
+Documentation/networking/dpaa2/overview.rst
+
+As described in the above overview, all DPAA2 objects in a DPRC share the
+same hardware "isolation context" and a 10-bit value called an ICID
+(isolation context id) is expressed by the hardware to identify
+the requester.
+
+The generic 'iommus' property is insufficient to describe the relationship
+between ICIDs and IOMMUs, so an iommu-map property is used to define
+the set of possible ICIDs under a root DPRC and how they map to
+an IOMMU.
+
+For generic IOMMU bindings, see
+Documentation/devicetree/bindings/iommu/iommu.txt.
+
+For arm-smmu binding, see:
+Documentation/devicetree/bindings/iommu/arm,smmu.txt.
+
 Required properties:
 
     - compatible
@@ -88,14 +107,34 @@ Sub-nodes:
               Value type: <phandle>
               Definition: Specifies the phandle to the PHY device node associated
                           with the this dpmac.
+Optional properties:
+
+- iommu-map: Maps an ICID to an IOMMU and associated iommu-specifier
+  data.
+
+  The property is an arbitrary number of tuples of
+  (icid-base,iommu,iommu-base,length).
+
+  Any ICID i in the interval [icid-base, icid-base + length) is
+  associated with the listed IOMMU, with the iommu-specifier
+  (i - icid-base + iommu-base).
 
 Example:
 
+        smmu: iommu@5000000 {
+               compatible = "arm,mmu-500";
+               #iommu-cells = <1>;
+               stream-match-mask = <0x7C00>;
+               ...
+        };
+
         fsl_mc: fsl-mc@80c000000 {
                 compatible = "fsl,qoriq-mc";
                 reg = <0x00000008 0x0c000000 0 0x40>,    /* MC portal base */
                       <0x00000000 0x08340000 0 0x40000>; /* MC control reg */
                 msi-parent = <&its>;
+                /* define map for ICIDs 23-64 */
+                iommu-map = <23 &smmu 23 41>;
                 #address-cells = <3>;
                 #size-cells = <1>;
 
-- 
1.9.1

