Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752809AbeEOKUU (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 06:20:20 -0400
Received: from mail-bl2nam02on0057.outbound.protection.outlook.com ([104.47.38.57]:53984
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752580AbeEOKUR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 06:20:17 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com;
Date: Tue, 15 May 2018 18:19:24 +0800
From: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: dts: berlin2q: move PMU node from soc to root
Message-ID: <20180515181924.5e318077@xhacker.debian>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [124.74.246.114]
X-ClientProxiedBy: TYAPR01CA0023.jpnprd01.prod.outlook.com (2603:1096:404::35)
 To MWHPR03MB2638.namprd03.prod.outlook.com (2603:10b6:300:46::8)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:MWHPR03MB2638;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR03MB2638;3:73Zw1XMjfPNbKo/cdfAKBgm5oH2a8uGluijUcPUdg/nA2/+wdJX96q59C38Lj6qyzU9t5BSmjkVC9bxhI1BNRaJp8Ds2ehlY+fpBQl1uyp3ro+4FSYsrF4SzjuNZ1vWVb5NQlYAlZosxshXVgUmU4qcxHjaN34XIzTLDSsP1yNK2AQD14yhnw3K9J/N4vCDQNFjhqipjQdmdBPQgiEdgQh4qvleLqZyy+TRQ9iXYWTByJ+ZHT8Me/CWwfkUouAq0;25:a1+8HWoCbsKgmxMVbGrUyX+pmjFZcEjgJm6vVTKB0wYJPGgEcH4te/JrZ8I+1u2nMO1VynjKAkKlCwMILePXANqacws6iNc/p/WJv6Rop+4XxZSSXmZgt82bzKL68j53/VIZpJx4i+D82ytqALXnc41lt1nndpoJm6Eohh33IjokMVQumSWUF+0UKqyATjdC/eV998bxJLTPMvg9cPOJtl5VNb1LE/uS+2dCIpqooAVZYqbzzmaYZduoX7RAoMj1MFEDGSf3uJ6C3OJRJApDy6LDs5bHwWT/2tW/ZW2sdsp9tZ3KSLp4KUeR7pcuvY3Ly9nQa1yqk0pNxPFkh3Z8nQ==;31:CP/QSA4RRRx1CyjPUgPtiI6mhWP8GJALPVDu48DT5gN28EpB8jTMie21IEmHOqqu5chYz3PzokMyXnyVLVckx+OqPQSkNal78gDzeavmjCRDo5TLM9zGhtcTTWbHz1unAeYhGqKwxjdXXHUSKHEUl6ISvnqJiFOWlLW++TqwvfyT/eFCs+qJPXbYB7WI3mf8zr9xGuL0V7an9xmAz3SK5VCitNph9q56I2kMDc6UCAE=
X-MS-TrafficTypeDiagnostic: MWHPR03MB2638:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR03MB2638;20:Tsa8W9MwwnJit691pD+Zv9mZffKuTNgR7D6UzDC9BZM+4S5EmAJD5u14AmWJ1NiAK7aOQny8EalwU3B9V4KzV8aAydCGjCvU2wS0UOKheSr4D1Rp/p6Oh6hMLWddxg4+LBWldF1diTMQd5ptD4iKqH1LxZH2ikecitpZsFa0tRJV/XT+A7aHDUnmt5Y5OWspK2lwBManRbRichgjUWYZECPGUufTVuODTsfLXvo+bG0RU+VhIVrCvqaFh2tVIGGNjqwGmsMmx9P7e+QaPUyOYgIQvC/GBrEsXjCf6MIPAGqnSXb1EdYtufJpCl5qLEywbv6fXbQxUaG1/DJzSrXQsZItjfpU9P0e8VduaI1E00XnzOUYH45t1lXDobTPvKMcb6GXVsGhV+DsMWWA3wPsqsCFRU0YJSJX+ghsNtK0qDevw7tZ051GOE5rS1bM5J66sCUa+cEyketJXwx9umkOH88zkAxlHWS7edBOioTPq2ETEMYSdpcyktMn+3RUxR9m;4:pDj8tM8RH5ndAM2R83o0STiG/LdnAK28xUQB7FzHHMdH8OHtMgN9RkdMdwrFoijb5JEC3cr0HJvEhUNMuHvulMRwK+oPaw5DOTY6RWbwjf9Y72dO1K/CFyuS/21YMgYj7U4QjKSant/9t9Ar4NLQYI7fSweOJe7Rts0E5dHlBpbbgaOdE9CZEr4JfQiZneRfWLOi105ZVgLvZk9ZwwXBg1rbuvv1MOiGPOlyC8puDxaF8pD0ogglz+m1oxD8mJP70pWfz7d6fPUGW0vyukDIsg==
X-Microsoft-Antispam-PRVS: <MWHPR03MB263880760291C1FBBE71A3CCED930@MWHPR03MB2638.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231254)(944501410)(52105095)(93006095)(93001095)(149027)(150027)(6041310)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MWHPR03MB2638;BCL:0;PCL:0;RULEID:;SRVR:MWHPR03MB2638;
X-Forefront-PRVS: 0673F5BE31
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(376002)(346002)(366004)(396003)(39860400002)(39380400002)(199004)(189003)(86362001)(9686003)(6666003)(25786009)(956004)(33896004)(8676002)(55016002)(39060400002)(81156014)(4326008)(486006)(476003)(81166006)(68736007)(316002)(305945005)(478600001)(7736002)(5660300001)(53936002)(110136005)(105586002)(72206003)(106356001)(50226002)(386003)(50466002)(186003)(2906002)(16526019)(52116002)(66066001)(1076002)(8936002)(7696005)(230700001)(6116002)(47776003)(1857600001)(23726003)(3846002)(6506007)(97736004)(26005)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR03MB2638;H:xhacker.debian;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHPR03MB2638;23:fzIaAPElDDKCHGONDn3QJ8W/rJi7vuHq86z1HoVMe?=
 =?us-ascii?Q?oaHIJomet20wB1E1fPqqBS5PjC2hEBXR1Ba2Y73zavzD4OkVg5WhkyKKy5jr?=
 =?us-ascii?Q?E77V+RQzaVXQNxDZfQYu0mMlgJFmk2iMHVTx7ZZZBRV91UH1Uy4Lwm3ByRF6?=
 =?us-ascii?Q?UB7QsqjAK9S4esQyWP0/oGEgXp0yS1Q288OPo21Zq+dqlrepB2bwRTwmP4jV?=
 =?us-ascii?Q?I5Bb0AzHP3e7kMBpisFz+lX7bV4MIFeqf35tVW9Cfl3ructBWtMDwp9uP5zH?=
 =?us-ascii?Q?IlkBJIz/lxd3kA6owabH+R81qkgw7UqntrCQkIAoR39mu9aqpuvpbgW5aZ8X?=
 =?us-ascii?Q?thOCyoO94FNSm0U+K8JVczbuh6/JkINklM0NyltVk0qidw97Gbd1RuGWHGr2?=
 =?us-ascii?Q?2NZhd71KVD5xPDPbWoV5Ijcq5FbcljqCyv5ofI4U4osDBNfAEV6o3TnFzBOd?=
 =?us-ascii?Q?g1NJ8pz+g3I4F6ol4I8Pi9bJwynWLVjHcX4e1oC+YlnYpVWB8lOX9CzGEyyK?=
 =?us-ascii?Q?Rgke3+jR5KV6O7g6Qeny1q3BXvs4+FhGkdySr0vMsV5JDV80XV6tr/a2AYu6?=
 =?us-ascii?Q?b8mrDN/Ko6BWoR/Gn7uXMUmZGDqNNYDyLr5y2R3vV5qRFv9+7Wv5u2/uo2KZ?=
 =?us-ascii?Q?hfqIluEHDUYTOKzDNSWNFlTihh6LL3oK8njYiqb8TE/eOxWqg9TSLt3RHWJh?=
 =?us-ascii?Q?J/DZSDyxN0WJbkESeR7u4HLYr+U782KPxo+KnPBnjkuXKbB0Ojm9LsW2TJDB?=
 =?us-ascii?Q?k1x+w7S1tM3jj+ewbuKPkZNhyq3LyMfNpeREA+9QwLBNjswpyJ01dojmzOiF?=
 =?us-ascii?Q?9AoYUCkuw7ZgXc7VPzhElqDYYre0Wuf2URm0jU9uOwydrB4NoHdU8sxvd4QJ?=
 =?us-ascii?Q?rCrs5F6F2La5HLdrtYaCAoj7UC7DzAE2JXUT+4DsB1h0nMTsi6S6JLIEIjC3?=
 =?us-ascii?Q?B1e7gXliKw2uV3tNG+eNm2SyNq8WEQATICtFa3yS7uTjm1u1YKZRNvLpLHZF?=
 =?us-ascii?Q?W3eGAGjjNUpFera+qXBMBGAodQlycGP8R5Y8E6pqHFNeuY9SU6IKj96ApeuC?=
 =?us-ascii?Q?bBnuz8/u1nN38uovdddG0Va9XNT8I76cEUMLZil44PX17q/D/vVuJd3i635N?=
 =?us-ascii?Q?Qv+YMI9zflqnnnmY+fZ5rG0jxVn4LYu7ikEiB793YAsLUMY5k/vqbr3F+OMk?=
 =?us-ascii?Q?VyxVlZIhxu/L2K0+jeTpcf8MmFhWvjzlcdgKVbAkMb0UowBHljILMwaTw=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Antispam-Message-Info: vU/5+iTFcmcrSjVIF9AS5Cjl3BWHwkN0sOm2T+JiW8a0PFWVLhGrbeSTniKWcf/ydT0XH/08zidM8tR7SNSXUZ83EKSWBLOb6ogvrrQpOtzjE1qaHts99Ni6NX6l0oYUWmzXCV7/s5xNRWJ0sG0C+Z9MrXHzXlLqcrSR61Ii2PvjaBfzDpsrDhCd5j5sV4MX
X-Microsoft-Exchange-Diagnostics: 1;MWHPR03MB2638;6:3axUlE5gZYETbkh2Q/Bht+/S1YuEKBOCbxOHwRFIGjNVsYo3rBeowmcFdlVVpgz9soEYjpLVXdxGX3mpYOD+BSAn7H9EUTgibrjGKsDseybwjde7k2SGzYv5UiQdPyKoBgPRunjHxE1crZHhqk3KZ6FpMZ/QDZ/P64HI5ZRMKlSkzV3TAEagRXjA1pfFo+rsBZiIr126GxkaKMUJMNRUhYyY0oEEByxfrbA4KUEA/JynYJTeAPjwUOn8Jyi1/CyDdI93OsSPptkashGTmb6fG5ZnhXyZTcJ4AsBY5SH4q9xcvc365RSAvWXhlam6WmT5Vxy7kSCIJt09hxtiBUsUl9JpEFbwMPMMrWdBhB0uOPzQxZQbpXAHLu/qTUzG0wWk0xCKrAj0FdNF3LXPfbliwQq7Zpjj7t7kq3gjv9ZY1t8NrieQLJYxIQH+6x6mKklBvKgsrk2l4tg/AbSN2GJlTg==;5:bXxhG6JAzgB2uXXpRhFOGUKVYhWahyiDw3Nj7A3EWQq4gS+okOS8HCqfELFMVEiFA2tFXNKu+rlZrRnEPnn+Yqgs2kqH+LVY5BUVOTwlLxooh7pii7rhQwb+dHzHrO2TottJbYpjzW1tiulb4kfGDaEgR0XdoYwZzvcCnE7fqfI=;24:rBf8l0vAt7OkhoRaV2MXLIXLr+t7SkYjm05Wo8JqNjV9a99pvDwVS0V4sakCsBx0zT4fpR5doV381BE7oSMRBeth8yb5RtADArxvTuzd9mg=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;MWHPR03MB2638;7:DMHOIYtQ4nhG3ZuTbBBNKqbRy4r3smE731HOH6UQ19Zl5e5LpFtjgjyyHVUxDMXqsJ+leV2TP3SZcMJBBHeJ5MfFR4i1sRYRM7d1pT5oaNOG6tfq89agf8eqhYGBshUZIe0jIateG5iip3inaTaiW6/LAWMwdrfmku7oXTjTi8I85M/MznzOG7RBPwc0CQP8eJN2+iV7y7OS2dZsB3X5JnKjqOako3N8QuhPOA9xBp2IcJEkszvYDEg67sv0t7Ch
X-MS-Office365-Filtering-Correlation-Id: 16c28247-57a7-4477-5dff-08d5ba4d72d3
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2018 10:20:12.9652 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 16c28247-57a7-4477-5dff-08d5ba4d72d3
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR03MB2638
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix "make dtbs W=1" warns about missing reg or ranges property.

Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
---
 arch/arm/boot/dts/berlin2q.dtsi | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/arm/boot/dts/berlin2q.dtsi b/arch/arm/boot/dts/berlin2q.dtsi
index 82e176011d36..c1bf23a4412b 100644
--- a/arch/arm/boot/dts/berlin2q.dtsi
+++ b/arch/arm/boot/dts/berlin2q.dtsi
@@ -62,6 +62,18 @@
 		};
 	};
 
+	pmu {
+		compatible = "arm,cortex-a9-pmu";
+		interrupts = <GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-affinity = <&cpu0>,
+				     <&cpu1>,
+				     <&cpu2>,
+				     <&cpu3>;
+	};
+
 	refclk: oscillator {
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
@@ -76,18 +88,6 @@
 		ranges = <0 0xf7000000 0x1000000>;
 		interrupt-parent = <&gic>;
 
-		pmu {
-			compatible = "arm,cortex-a9-pmu";
-			interrupts = <GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH>;
-			interrupt-affinity = <&cpu0>,
-					     <&cpu1>,
-					     <&cpu2>,
-					     <&cpu3>;
-		};
-
 		sdhci0: sdhci@ab0000 {
 			compatible = "mrvl,pxav3-mmc";
 			reg = <0xab0000 0x200>;
-- 
2.17.0
