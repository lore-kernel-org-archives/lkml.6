Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752549AbeETNui (ORCPT <rfc822;w@1wt.eu>);
        Sun, 20 May 2018 09:50:38 -0400
Received: from mail-eopbgr40075.outbound.protection.outlook.com ([40.107.4.75]:20992
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752509AbeETNua (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 May 2018 09:50:30 -0400
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
Subject: [PATCH 1/7 v5] Docs: dt: add fsl-mc iommu-map device-tree binding
Date: Sun, 20 May 2018 19:19:45 +0530
Message-Id: <1526824191-7000-2-git-send-email-nipun.gupta@nxp.com>
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
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0401MB2429;3:we2Q5nW4B1mvLfceGQH9xU+6HYy3A/8sh1aVn5VYtq7az+V23dhd2lW2cLh/+8j6YbOGTJ9esvrP2LbRPyizINL9NLYNwP7saQHiVlIe6aA1IJMr/Zz6oIaGqFmYAZYzvu0F22qFbEen6fBCkjQPR7J+Yuj9YPuh7IRaZq4wUSlvRne6++sPEDoLWr9Z9JL60/1NIWm4WS9UxAh62qtUN/bQFBj7NB79mm4RG9MbnzB/zCv/u98E6uJXBFmw0DAg;25:DY9VXazCfKTbRcfD6ENcRw3ZWPJoPH7jYusXu2nsbzjIeb2S9NgMclGIWOj29Q3x7T/P8oeyQwt/rUdmRIw/1gnTXOsi54/aT61sFLKYB1qLF/Bo6YugJmd9rllNjqvF7DJZF2ygciv3+w7eoRd6VDuZ812RfGhAFJOzuAYqVpL2IMUPF0XSLkr+uW1l09PyqxydENIAYxpMY93fzIuHA+VvkfauNqyyum/4FPazw/Bm9pov5CZ6WxvELXibIn2Kp+U4HO/ga7cQ+td0XaTnBxpTYp0xnYpDtqQAB5o3DETDyVXxhmkvf7X3cQirR/hdFgakvWDzVzP06l++CsfTzw==;31:coPLw2S4z7CM0sPNz/IP2yiYFdHFUJxo6/feMNmGM3vZvr7aJGAU+iqcm2j67zwgOKXWbKSNWj5cDvAkkAGAqbgEXXNGV7nS4kyeGjodr3yaY8bxEqe+1m0t0vlnm61Zi6KT6kcs0KzfcyB1/hepVCXYefLHD0AR/cFN4FNee/3G6G+vGjcdBk0a8rShYnx/MbrvdFx18TPAt73d3D6qLTVQJ5mPKSQvfrELjrOnSYI=
X-MS-TrafficTypeDiagnostic: VI1PR0401MB2429:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0401MB2429;20:LTDchMq2JKTizoAN5k8RDXWF4r99aBS3CsJbltkP3x8PhbhyLE+9uZFZBShbMj0Ttzs0rJSfOytC9DJzUliYsc1O2nemch6ct0bWW5+bRBI8yEVPyTmSffAN3s0S5Tob20n09gE36+tFmZHtnklnBRS4GaI5svyROmtOF+1RCk5xvuGh7X2z83xFy1brcEBusYz4yvrZ9qcfsZQsKKPVUfYNlGgiyPVizaxyGEcs9xefGbw/eNrCi++frGZ5tkI6ZjIY1NEJgGJBHIfzSQ2UgEb6YAc0Yy4/flmv3wXUQnR2VtKNbqpfaH87dEYegBc5hGUlkvd7tW5Jl87ibvgg++8rQQSwsJP3JH2N0K8CJd8MspQNIK30KviXgmOO1Kxbr09QCHcuxyR6WOe5kIw7qVc0Q5nb+s9+e33aNz8+2RPGw/LOlYeN/QiUO4mQhFn68PSM/FTUSkrW4NZ0z5BIzCYd5vwFkE2UWMeKqtK0E88JL5z9EWYDvdVoa0sjBtCi;4:kMlrE1hjemaH3M+QOHQFXtDZVhJ+3d60E3fFJTUtsiK1v2h9pB40wFcsU9SSO/jtdFQYuB/PRrOFbiRmj2jU3A3Ec8X8DsonKyATu/o+yT2f2fT6SnL9pTRiK9AARJVpN6rXSneICc4UdzI58kesA1A5MZKs5sBIz93lWOXe+ensR+XsynBYZ+tTggLmXZRvlFIxN2QdIGgyZbv6Y000yoEjQvb7ZkXYXdSMvzytDFlxDkChcwc0QPWiciIIZzhYs6+kYx1bEncJS4sdOCRGDudJ01j3M7Y5Bu7O/dzHWz1s9z67e1QO2lFIBvzMMUa8BzSMnYrGTlfDUphzNTrz5hkdhlRSQ9FaDRYxofF/6CA=
X-Microsoft-Antispam-PRVS: <VI1PR0401MB2429FC35047A7439244429CEE6960@VI1PR0401MB2429.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197)(275809806118684);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:VI1PR0401MB2429;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0401MB2429;
X-Forefront-PRVS: 06780E24F8
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(346002)(376002)(39860400002)(39380400002)(396003)(366004)(189003)(199004)(316002)(50466002)(50226002)(47776003)(3846002)(86362001)(39060400002)(66066001)(6116002)(8936002)(575784001)(16526019)(8676002)(7416002)(53936002)(6512007)(48376002)(486006)(186003)(26005)(44832011)(478600001)(81166006)(81156014)(76176011)(5660300001)(7736002)(52116002)(16586007)(51416003)(6486002)(97736004)(36756003)(68736007)(305945005)(4326008)(6666003)(106356001)(446003)(25786009)(5009440100003)(11346002)(55236004)(6506007)(386003)(105586002)(476003)(2616005)(2906002)(956004)(110426005);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0401MB2429;H:b27504-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR0401MB2429;23:IIi7cf+T9eafLAcvcHVCuzXKPjYyBPOL38lq/+u?=
 =?us-ascii?Q?JwoHu30NoM7NikpCvmIbzYfmCE2Lq1qOlW8tpGeybS7yixVIfqguuFMx5ddj?=
 =?us-ascii?Q?rh4VU3kjIM16yFZvqni4MSOs/amsAqIw7BfXn87hYiIeT2PAXXkWie7DzHx3?=
 =?us-ascii?Q?4x82DiHFbB922GSfW1FOPd0Yia4gpqBD3cdXcuHS6Iw0P+tqT6uel//yMCkR?=
 =?us-ascii?Q?5R8uRfQvjNpdiX2/khDMD1LEslUo5Gi0matYIoAIC91YmO+1NohVj/9/YxxH?=
 =?us-ascii?Q?u2YxbHfqh4XRmiN8P4etnUWfFhi9mvEggieVDgFV9BcStPdLh4+VR+Rw6LaU?=
 =?us-ascii?Q?25Ew9j2Lm0vh9KbBYS3deEqcoGkpELAan8pgSX7uRapbMa4D57fzxnuZrJ4o?=
 =?us-ascii?Q?Wf3ge3ai2bUowgss3k3TrkKMs7K1sQR0K7/R6nDmRcf+M9Ue0pTk//ZvN6NK?=
 =?us-ascii?Q?g/PPmU460sTZfX5e0G/W4CKl6WAGpdmoO1HSBrl7AuM5doLZA4DLnxD5BhKm?=
 =?us-ascii?Q?mgsTMC+oCRt7+ZgRad8utmQUoWNJXYd5xAEjL/wSnxFnE2yRTSbWgtTEB6j/?=
 =?us-ascii?Q?QhBEfrnx8+lcH7Uui2SZ5k+sGZ26GNJ+pyVaNS086Ix7C2eqQcsWAIOY3vbC?=
 =?us-ascii?Q?2xLkrQSdO8UeQ3ZtneEIVXq2aJaiPg5n9KDZ5mCo2WkRpsBHyDJ+/lWCrz6n?=
 =?us-ascii?Q?vDh2iZNErzWqFu5UJZ+wbG+lTXf8zJznUUot6mCoSKESFYo7BiL0qxqybrnJ?=
 =?us-ascii?Q?H5J+JIJqFvublfSKcRt/495kxZZyX/YpcqeJXsDTcrCT+PZIW+BX/eAq3V83?=
 =?us-ascii?Q?o4IKQcMjxpaVbNeFpfdk9xvSr+xpAMEI0xrlS0dADBCl1FEMb1SM7GpkZ03/?=
 =?us-ascii?Q?nYB7JZT92HNtiZtEE1jC+MxEWdq1dbnpHiSDow5yEVnP8lq5LJiIkf/Qw/H4?=
 =?us-ascii?Q?PZdQUaXi+OyPW9NNIDb2YS/YQtu7x1Hv92dfYqWKTr1X5HfXUBZtMd6aIQYQ?=
 =?us-ascii?Q?fGyZ6+UzAnxtosTuBHVCY99pEvhadqxwVqACuwoO50hqNzwgYHAtyzIsPd0b?=
 =?us-ascii?Q?+HrhHjD7VdiH6kdwu4CkEF8LVNu/tWwBVWNMGfDO961aPIp+zLG0HzS+4nmI?=
 =?us-ascii?Q?ow/EQnCT3UfnDuzgzKkYN4alaTPrKvsj9zzYTwctA8W5yBpkm2evTpiBWka4?=
 =?us-ascii?Q?k6PAxACfqoOMLu9znzMt/p3vjGvrEv2ttWzU1ffaFeheJ1izCu2AjaSxFLcD?=
 =?us-ascii?Q?z7B6sY/97DMuPnsVnSeQtWAiM9bnZ1uLS6IYYpsGAMfkfTXkIiSTzNcgQ+81?=
 =?us-ascii?Q?BSUbQtxC08fR1/28sQrppZZiBnUjnlgN0sfFLfN43U0Dc?=
X-Microsoft-Antispam-Message-Info: TB4xoZUN5ed9dlJIXe06+BujYYFtIjzcypuQ9C3d647k6XQF6m4pn9yIxNQUxstZRY8tAQ6Y0bVlwOYrKaJU6M+LsZBQa+GjcBHNAhYrSPBv+wj0ELyDKxRBjHzV+pVpFNGTvoYfuXbehFEPbJ4eLIkti4i8HGWG112wpUCgsqh1osXMtRxJ5RzryxvujN+C
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0401MB2429;6:5Zl7B7+dNRH5CYX+tXKhnEEHZYVHNzMZqzKWffoDMIMfUmqabqJBvRa8a4WizN0p4EXf+7HIyK8H0FlN5Oab7ssJrY1EcNNFlKNFHkBEK8tQqxfDVuvY47p+Oj0WK2ThqZkC62r1jUDN+uzVXGr+W/B7+PYmiFv85e6mUO8Fm5xdk4hiu6tZOdWLpDi8s2Oc897YqtQd0EBZMuAx7a7RRJQpPpxIwE2iTZn7udzpC2abxIp7u5Ys2no7qMSIWeVPfUEikaOjOqYTOyvaPdvBQsP52WeBFZuaYw+LB0Vt1GNirk3+Irflq1plAE4m5Hl73fCN6ZVOXDABXimxSSvT7rcnJsBASlZhZxrQNOlR9ivYoJvU/Bv5ZtF8I46norQ6EOplV+p+XYaWoUhlOWeykATBS1LbDvq58QzbSNIy1d2jfMat1vlNRVDYGO/HXnMLpPhyf2ZF03c7mbeZAJ2rwQ==;5:6No1LtH8Fk8JPvHZLoIsud3V3MN5mDZ2YSsIsOvuqLDqsaKnn3/LJ3lJJLLDY04dapq7UH+HKCAuLc02VdppxTqfNoq3ugJciaymdU206vCk/auHGxB2nTlafW2Ec6EcZa9/diWOgZwaI6FsaNY/9BHSC8lMfYMqpAkQel1N7o4=;24:oEatpSkJEyGVCCPk7gSWWswza+NTENZcSK/7iY39tNSurE3cTjru9k1cwKsP274Jf2EpFEFqBGyrq6xb23Dsp33iyyINEKj8FGMDSZSenVY=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0401MB2429;7:DR0rWUQKIO9tPbwoI7MBYhJ7a8Kb0kdfcty0HWxUqruGNxS9X4McNctkDTsZmIIwGdS+4SG4jc9cn1VwEQF/bHWz+n+2XVJxqxjEcEn8Bu+tX8mIfoco4QDl9f2W4vNVU9JeD4YE2upuQCK/2DauIDWcgQGckUz3BZ41UhfFpZoAijw2AbxpZXHKBlf4mMzwTSOf64M3QK0YlIhujCys1IAqT/Ex1Sh45LO3UrdBa4pO9oaVhvLlMycuN+Gxe4A4
X-MS-Office365-Filtering-Correlation-Id: c4045ca5-77ba-42b2-fe90-08d5be58a407
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2018 13:50:22.3992
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c4045ca5-77ba-42b2-fe90-08d5be58a407
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0401MB2429
Sender: linux-kernel-owner@vger.kernel.org
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
index 6611a7c..8cbed4f 100644
--- a/Documentation/devicetree/bindings/misc/fsl,qoriq-mc.txt
+++ b/Documentation/devicetree/bindings/misc/fsl,qoriq-mc.txt
@@ -9,6 +9,25 @@ blocks that can be used to create functional hardware objects/devices
 such as network interfaces, crypto accelerator instances, L2 switches,
 etc.
 
+For an overview of the DPAA2 architecture and fsl-mc bus see:
+drivers/staging/fsl-mc/README.txt
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
+               #iommu-cells = <2>;
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
