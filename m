Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751977AbeBVXca (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 18:32:30 -0500
Received: from mail-sn1nam02on0060.outbound.protection.outlook.com ([104.47.36.60]:58076
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751317AbeBVXcZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 18:32:25 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=David.Daney@cavium.com;
From: David Daney <david.daney@cavium.com>
To: linux-mips@linux-mips.org, ralf@linux-mips.org,
        James Hogan <james.hogan@mips.com>, netdev@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: linux-kernel@vger.kernel.org,
        "Steven J. Hill" <steven.hill@cavium.com>, devicetree@vger.kernel.org,
        Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Carlos Munoz <cmunoz@cavium.com>,
        "Steven J . Hill" <Steven.Hill@cavium.com>,
        David Daney <david.daney@cavium.com>
Subject: [PATCH v8 1/3] dt-bindings: Add Cavium Octeon Common Ethernet Interface.
Date: Thu, 22 Feb 2018 15:32:03 -0800
Message-Id: <20180222233205.28857-2-david.daney@cavium.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180222233205.28857-1-david.daney@cavium.com>
References: <20180222233205.28857-1-david.daney@cavium.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [50.233.148.156]
X-ClientProxiedBy: DM5PR07CA0025.namprd07.prod.outlook.com
 (2603:10b6:3:16::11) To CY4PR07MB3176.namprd07.prod.outlook.com
 (2603:10b6:903:cf::14)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 49fa8b27-7e8d-4084-cbb5-08d57a4c8640
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:CY4PR07MB3176;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3176;3:l9tncxIQ5RjxPkpLO8VVNbU5QR8GLRSTkR5vU4tegmi8X1aYNtV9rHhXxPNirdP0+npVsT+H/taKhjJSA5HwaR2/mxd76fK+T2UIbWpJVFYnHPtqxzhwST1CIz+vDTEownPsUtyFwfcsR5uIQva4VO48FcmXkBojPTes1jC9RzOkkLKnC12sjQH5iH0fii0H4Ka1l1CKWDmDf26B6BRq+1NEh+qsHf+IMDzOTNl/ias624LOkwkUSwWU/iU2XswP;25:58U5d1nmVJY0WMFo54qdIfErObLKPtnJWhCWKe1XP+AdXalt0IIzukQHsH/NR+J55ndlVCiVl+KqACs8FfOka0LX2wm1Ctuf/j/3nrmvUpHaJBcSU2rjAOotuO1ekOWgEEpXEyhSH5hUiyJBb7RNpdQxH5NpAByx2eZmZMXM+BtHgHBtc5ZcMEpvE4PZebcRZluJ4gzLSun/XGW6rHFD4MIp8oWujEunzqhhd4JXlLvt7uO+vbFB6M8/5aEDtoWP8FelaV++UEJFps8sLnnB0WsQXoTiKAKXfv4g6Y600RT+Y9KK+mWo34eB5lni7m3qJUzWaFSOSJ4DoMdQMYqZYg==;31:gZa9IzQOvOgM6qnWxauu8FQtkcsjEAHKsHhd4v3mLlpG+a4Q3xxOJbNKqkOi/lnOAqHN2Id6KW/DIAM+IaJaPj4q31ZUhLS53nlhAdpPlq3UgkajJlon7bgQA1KdUNC7nRZr6SddZDzTgcLsV967zrZC5t3rXAxiBADjRmWafCMlUAADbzEoFYS4rfvP4ev4K2pWxGOjtX3AiQsXshcg+sw7H+h+4wCjCafLYyiM1IU=
X-MS-TrafficTypeDiagnostic: CY4PR07MB3176:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3176;20:c82GdArE4egqzwitu3MxWS1GmqV9luZILKYrHni6LWsWmQMGMOa3cokxMU0W9RSHTmvwi8OiGHvhZAgjx/vN3yAa4chvfZRrj05NUz3RFI2pgJY4X5/SDMUny2tNBxzTfKoJCrWSDTsKt7c4NrvYXdARtwrgeI3ia8uxbE+XzTV5P1Q+RFbdYxbOO0iS3tmzC6JB49tsg3s1qw/i9qraAjG1nNw8SfH4KZl24fqn4sGaPyjcVBCFnYinzpPipbQ/5+5Nu/JU7LoyLPg8NnToN/Uz30d42JQZo06yWpPK1UE28lheRFwh6YjKQMnIa51Eo2vICFp7GRKr5Yk4OVur99kIsWjnh0MMQims7QFmFQ162t+I0zoqfjeGUuNr4a93nIgZjrN7IeomLpWVSELkLFWrQ4fkBaBDzBtevxSVHn+B4TM5gptJ0VJSGV3lx15D9PK4iwc8ElZv2R5hEsQScm6w/Y4LdnbyCW2U4NriKF3aofpY3xeqcWM9leq/flnH;4:v5z9FJt9DDPE51YduQ1pmqieEc+m5yGe9JWUWV0xOsp+sWcclHANR6GmrQK7lncabeiFpxnRSUywDHI+gpBgyvoZMX2jJ2QHdeWSl0pPFENvj9ydM3WYp2PJC4VmmDfJb77SZI0O2Y1q3LxNX2r5WPpf9lhKLL98tJIWgclwJLk3rjBloNc9eI6z0wNkyfwQmfx7wHubHJbxJTOG6HExnk0R1LAcTACIbtAIzn7UvWNRApmCktRjCnD6ZIsA656UXWnnMjsjlTYV2Z/GJYSGKA==
X-Microsoft-Antispam-PRVS: <CY4PR07MB317606B7D2E8A3FDC386AE3797CD0@CY4PR07MB3176.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001082)(6040501)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231101)(944501161)(6041288)(20161123558120)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011);SRVR:CY4PR07MB3176;BCL:0;PCL:0;RULEID:;SRVR:CY4PR07MB3176;
X-Forefront-PRVS: 059185FE08
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39860400002)(39380400002)(346002)(376002)(396003)(366004)(199004)(189003)(316002)(1076002)(5660300001)(25786009)(478600001)(305945005)(7416002)(97736004)(68736007)(105586002)(66066001)(47776003)(6116002)(3846002)(86362001)(2906002)(53936002)(107886003)(76176011)(2950100002)(16586007)(54906003)(6666003)(50226002)(39060400002)(16526019)(52116002)(6512007)(110136005)(6486002)(4326008)(106356001)(51416003)(8676002)(7736002)(6506007)(386003)(8936002)(53416004)(72206003)(48376002)(50466002)(81166006)(69596002)(81156014)(186003)(36756003)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR07MB3176;H:ddl.caveonetworks.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY4PR07MB3176;23:ZI1Zbi6ycdU7slGT66bwMkuIhczK8r1qWK+tfkb5K?=
 =?us-ascii?Q?WgghK2/y1xEG22BRWGwkr79HjI1qBvUMr1dlkr6Y6LgdzvHdj9xjyGv5JWpL?=
 =?us-ascii?Q?uWKr+FWkYq2iI+xKp299SmS38OZn9Cp4IX+yoLLfdhkFeKF7RqJheqd7FI8H?=
 =?us-ascii?Q?inMdsFAFh3wXuEZiGChW2JuZ2mtasu4u6H/00dzBpy4v8as9atTRPPoKCcjp?=
 =?us-ascii?Q?W/2syBIY9C3mWPgeLK4Rvw/nnnzQFP1pXVpaJhgxk7/851e0++WDKAk7kpu5?=
 =?us-ascii?Q?eQDAQO8tWoYfFgd4PcsYjHqj9i/yAljAzwxqASjKZqv31HaUefXhf6vJFnXT?=
 =?us-ascii?Q?lhlV94SeIVMfFeyA2y8nzoyGTo1z3CzxHTFRd7VFr387YprCOSi2+hKwurQx?=
 =?us-ascii?Q?ohpcJ6G0/gopgZH+8aKLHkIzY6/E//FT4dotASOISz68+IT/Z7w3wBt1SqNi?=
 =?us-ascii?Q?UJB7UUtLQfj/QfX0Jwk+Hjr6BNqubIcGFug8Iw1OGazxYXY22IRAB8dU2yHX?=
 =?us-ascii?Q?HZEyqVhfhNHY+BnFo9cYSguAnpfIwzlDmkC7faQKuSt7MZUjvWN7k2VnzCSe?=
 =?us-ascii?Q?uzu2Xl/wcaCPfyhn+57TGVfafgwlQejGXeelOEM9DQLjtp71kTL1ZDf1AliY?=
 =?us-ascii?Q?N//1a3ikXKPGWWa6nSQngRAv98kCFTogpjmfmjY977eRDpRwAH3B19Et3QLQ?=
 =?us-ascii?Q?y5HRIva4aVX9CPN0QxFL5x84Hi2jp6I136kVnbVZVr87mvm+FWWFUlxJkz++?=
 =?us-ascii?Q?5ch39CBARQd+94cA2jxbSwItl9KE89qy4kKE/xVNWZUDj6pR1alUcSmMzfD+?=
 =?us-ascii?Q?HW6M1OikL9Uv9r11LYNXdK7veaVoNt+gscqDJixTOpH/sfCQSnIKU7C04pUy?=
 =?us-ascii?Q?rILyOaVGkzJx6CpxN9PqsrsW0q0ldTV1XmE8teM6yL8XbZxdL3w5v8DKF5Dw?=
 =?us-ascii?Q?Ej4HTwG3UtxULa2wjr/9bELpy2fpnDoMt+WPGJSdu73/KptsI4Pt6TrWHHtK?=
 =?us-ascii?Q?yR4jxfRU+znOqom2977ADxEImQeWCGRSfS7yrQiiWl5vWhXCth5HXRyu1TL1?=
 =?us-ascii?Q?wNdofpk+QnEDHCl9LIRgEz0nUVF5VvPicjXTKOeOzkzG6WXOQMlqLGfoDNlZ?=
 =?us-ascii?Q?ZxgP0x8T4mefahFoUPGU+Y/hRCC+L2kd6H946cW/jQ4wAVKZDev58XTXp8Ho?=
 =?us-ascii?Q?PTRe+c47Aci7kp1ToAkRy2/Q7azkwi3obDqL2SOcyFRF+ept3XP7ATi2ysVD?=
 =?us-ascii?Q?jr1iuOxicQxKffBem/ocIVhs0Dq0Kn5Zq5TnWIz?=
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3176;6:NWkZkG/JhMtSHJHlQseczQrutNX4eV2+xzZrk0lLCXwS2TbAMfDPxvoBgsH4fRNU1HcQAsLioHytFT6dwJwnK+O/IJ4J4CbucsZH5mx63t8Q4aR8kp7ezoSvIKZtpvBpLHOIn+MaT2mwPOt38poEskiOEvrQ8m9kCG1crOLKHkRqzqoosR3NGJwUCLSs8EABdyYhFbMQCvixHlJu0oOe6Mvd3eJwPr1vAudfHE4wVaxVAKf0Gsy0t7LkgERxh1i1N0DnwwniLi9fQnVHo0+h+OY/PiGZeHW7yBVNfViWxAC6KulUdVtltpzGW8sS3tASDJDn/trGGM+QYqz6YGcRGnup4X7qmqt20raGGCHUaWg=;5:aivX+szH6up1nW0ZdKZCukv4nzVWH5vU4Otx0O5VXaC6Fcmfqz3ESTpzlWtzAwV4bgbr6m2LrTwdnTJqW8uDVoIIdZeMMuURQSI4RGqhyhTfubngM2pWGxfoD97qK8nXw+TX3m5QIIz/p2cJOT2a8GdmBVh8ZShVqWZIc01TYdk=;24:2ESEQDI9bQUqLPEnW1lcRNVM++BfSowZUf+4Essh80SfLhRdUDZ82WZs5jB8isbnEybEXFgS6ZGPzhTrCttRdNjcdQg6J424bcUemvIV6MI=;7:D+XIJ8Pxsb/QMpwHe2D/koXbIRby0Pg7gwg2AE3B+Y6l1Szh8t5+MmWlbYFc0QtNgN0NYcK6OgnSJ7+Rv8q87dwOgUr1ZC+KDv58Gs329ZoNDvt6vDs8OkgULrfL4K8QFB/cCRPr6niCIq0upDvOOQWi644SN02C/c7vz4or+YS4PZXA6Pab/5ZlvSiMkMkiqmjaDQOSdW9Ou3Ux9Ks8wRspnnzevfa1oNGsRFMo/R18IrEEYJEVSKhBgZ9EQKBT
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2018 23:32:16.9883 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 49fa8b27-7e8d-4084-cbb5-08d57a4c8640
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR07MB3176
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Carlos Munoz <cmunoz@cavium.com>

Add bindings for Common Ethernet Interface (BGX) block.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Carlos Munoz <cmunoz@cavium.com>
Signed-off-by: Steven J. Hill <Steven.Hill@cavium.com>
Signed-off-by: David Daney <david.daney@cavium.com>
---
 .../devicetree/bindings/net/cavium-bgx.txt         | 61 ++++++++++++++++++++++
 1 file changed, 61 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/cavium-bgx.txt

diff --git a/Documentation/devicetree/bindings/net/cavium-bgx.txt b/Documentation/devicetree/bindings/net/cavium-bgx.txt
new file mode 100644
index 000000000000..830c5f08dddd
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/cavium-bgx.txt
@@ -0,0 +1,61 @@
+* Common Ethernet Interface (BGX) block
+
+Properties:
+
+- compatible: "cavium,octeon-7890-bgx": Compatibility with all cn7xxx SOCs.
+
+- reg: The base address of the BGX block.
+
+- #address-cells: Must be <1>.
+
+- #size-cells: Must be <0>.  BGX addresses have no size component.
+
+A BGX block has several children, each representing an Ethernet
+interface.
+
+
+* Ethernet Interface (BGX port) connects to PKI/PKO
+
+Properties:
+
+- compatible: "cavium,octeon-7890-bgx-port": Compatibility with all
+	      cn7xxx SOCs.
+
+	      "cavium,octeon-7360-xcv": Compatibility with cn73xx SOCs
+	      for RGMII.
+
+- reg: The index of the interface within the BGX block.
+
+Optional properties:
+
+- local-mac-address: Mac address for the interface.
+
+- phy-handle: phandle to the phy node connected to the interface.
+
+- phy-mode: described in ethernet.txt.
+
+- fixed-link: described in fixed-link.txt.
+
+Example:
+
+	ethernet-mac-nexus@11800e0000000 {
+		compatible = "cavium,octeon-7890-bgx";
+		reg = <0x00011800 0xe0000000 0x00000000 0x01000000>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		ethernet@0 {
+			compatible = "cavium,octeon-7360-xcv";
+			reg = <0>;
+			local-mac-address = [ 00 01 23 45 67 89 ];
+			phy-handle = <&phy3>;
+			phy-mode = "rgmii-rxid"
+		};
+		ethernet@1 {
+			compatible = "cavium,octeon-7890-bgx-port";
+			reg = <1>;
+			local-mac-address = [ 00 01 23 45 67 8a ];
+			phy-handle = <&phy4>;
+			phy-mode = "sgmii"
+		};
+	};
-- 
2.14.3
