Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9185CC282D9
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 16:22:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D838218EA
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 16:22:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="BAuU+LLe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388383AbfAaQWH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 11:22:07 -0500
Received: from mail-eopbgr820057.outbound.protection.outlook.com ([40.107.82.57]:27824
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727189AbfAaQWG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 11:22:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H1tRT5cau8RRvbyad0FkkXSUJMbcNfBVxi6wZnSsw0A=;
 b=BAuU+LLeaStjjEzZ+uEtIo20Qcrozys8h14F6ksrLTeEBkPjTtmYMx/9Tg2RLTJBJCgzp08SMhvAhmD/A9lj4Qk1C+ZYpqYcccbLRj/W4E8JAdhhYeQ7gLKqmR3MovPaQNmtw/sG6wOV6CVy6fn8kfHHwoYx1WcwfgIpkJ2zRoc=
Received: from BN3PR03CA0091.namprd03.prod.outlook.com
 (2a01:111:e400:7a4d::51) by SN6PR03MB3759.namprd03.prod.outlook.com
 (2603:10b6:805:69::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1580.17; Thu, 31 Jan
 2019 16:21:51 +0000
Received: from BL2NAM02FT050.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::203) by BN3PR03CA0091.outlook.office365.com
 (2a01:111:e400:7a4d::51) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1580.16 via Frontend
 Transport; Thu, 31 Jan 2019 16:21:50 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.57)
 smtp.mailfrom=analog.com; gmx.de; dkim=none (message not signed)
 header.d=none;gmx.de; dmarc=bestguesspass action=none header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta2.analog.com;
Received: from nwd2mta2.analog.com (137.71.25.57) by
 BL2NAM02FT050.mail.protection.outlook.com (10.152.77.101) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1580.10
 via Frontend Transport; Thu, 31 Jan 2019 16:21:50 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id x0VGLoTm023704
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Thu, 31 Jan 2019 08:21:50 -0800
Received: from linux.analog.com (10.50.1.104) by NWD2HUBCAS7.ad.analog.com
 (10.64.69.107) with Microsoft SMTP Server id 14.3.408.0; Thu, 31 Jan 2019
 11:21:49 -0500
From:   Stefan Popa <stefan.popa@analog.com>
To:     <jic23@kernel.org>, <robh+dt@kernel.org>
CC:     <mark.rutland@arm.com>, <knaack.h@gmx.de>, <lars@metafoo.de>,
        <pmeerw@pmeerw.net>, <Michael.Hennerich@analog.com>,
        <gregkh@linuxfoundation.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <stefan.popa@analog.com>
Subject: [PATCH v3 2/2] dt-bindings: iio: adc: Add docs for AD7768-1
Date:   Thu, 31 Jan 2019 18:21:42 +0200
Message-ID: <1548951702-28525-1-git-send-email-stefan.popa@analog.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(136003)(396003)(346002)(39860400002)(2980300002)(189003)(199004)(426003)(336012)(4326008)(126002)(2906002)(7636002)(51416003)(305945005)(246002)(2616005)(476003)(7696005)(8676002)(486006)(107886003)(44832011)(50226002)(26005)(47776003)(6666004)(356004)(186003)(8936002)(77096007)(36756003)(48376002)(54906003)(478600001)(966005)(106002)(316002)(16586007)(50466002)(110136005)(7416002)(53416004)(6306002)(106466001)(72206003);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR03MB3759;H:nwd2mta2.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2NAM02FT050;1:Hf1zSKlj57pNPkFzVJ69MmG9Lsyp8wiAZLN0zxrJKR7+oCLx71a0pkZuSD6gz3OA6WzgkG8O4Vgxv5hy3AOwau/8YFEgpvbtt30ewq/fF2Dj1duVB7uqdljtow0Qj6I/0rD5eNTneJwbdpbRaq1tyg==
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 67bb8040-a83f-4ac4-e338-08d6879834a0
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4608076)(4709027)(2017052603328)(7153060);SRVR:SN6PR03MB3759;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR03MB3759;3:ZWCjD/M1gF5xwz5k5TqULdRAsbpvsEHsGH6lb0eb9fWylgB8Bpjw6vkpsMEEYM3WNBZs4FVecMsew/Zbl4nw6vqo2cxsuC3qk61ys0SBIg1qziKxUdx9fxZEN85yq4AnY+PZ9thZ4qSsZtpLJmuI28ja+zaAly/M9bSrZp5+EyttvlkvoQFMXQTbslTrfIdsZ8syNvmEtDvE0OyQFuz7pyiRNwkKLmdH6yUYES9+V7f7vGZZb0jJx/bcvLdSOUP0FTv7X63JL6ycaFgG0Yxgqbz3MvumGkkOsPPF1Dn6V3cOLYjsihb76ClxRIF83Z1cP3L/inNp6JuWmfphyOsQUqJb66lAMuUm11tEkTTaBDBUdEODaqTi9wTbTcPruNeR;25:OwSKOc0sx7GiQY1+PFtAlluem1Pp+t/jw9c4dJ2IAQrAL0GhIqPwBVPSfTpJk2SD1MZygptY4nfdDxZoHythfYq/wuAeG4OYjeFtO64GLkauW/iIST4l+WyV5eND3TYtkat5+5Yyz0jBJVkNwAq80B/oHNCwZinCtMBUf8YfOUaC4cy1o4gNfWEa+/x5O74vZCwpjg478dXBq1NnG9Sf2e05iWQkCSbwdtLgnM/a4YxM/jcr+mTYsvp5zRObyka3iiqaMhp28v2/Dw6nwT5Txl5f0ixU5jKo+L6eF86+uXw4aRwnv+W+n2wmZSi531SgAGWoAzSPwcZ7e1Fk9L+IaA==
X-MS-TrafficTypeDiagnostic: SN6PR03MB3759:
X-Microsoft-Exchange-Diagnostics: 1;SN6PR03MB3759;31:cboJ6NBOn2DFc2i8kFsm1KQhorkYXkuuft3PjMfqlVr/B2WtK7FIpVgUongo0OZA1KG3RuHAaELIHHkWpqDCjfmwRPo3q1NGVOaw+ih3ma8clmqvMPcLiv45T12urSpMne7ZC6xxy5A7CKVBgFqGVErQYNndtSDWLd82zTTQwOrPnXWNzup7tDAX3peaJWT2arbzbfSpj/hipfat3ICscQi/3mn9yvL48c37NWJfvPY=;20:nYLXLTYvdW7hfVDQs264lnM9we1BGEoEUGzdBRMiDZScBpoFvX88ZAPwhli+lLU2r+X4/1BJBASrS+zNOjpiKXAUB8ksS3nMi37838YIk4ICF5oBSLF2enduQVdNOvboUAjQp3FFrxol6fxmT2ZT+KKsDO7DsI9fpJLj0k4bZQhahX42QUEQN+8QAHUWCEYwCiVvl1aRGw3LLE+woevceAyIBtA+jopXkJLZcw9wNBLV0YTLBJugBfNIy0GiAVZrhEbWX9hL7yoILKSA1EQk7SzFS86eguZM/9iqoAcRyIaz8gcWnJ49fL9zwKZOyJnSWjUiHbuII0jRj9C0Ap0CtAY0lqATKWWlK4axaQ3GAkdJptm793jRvFkKdt9sk53zLJ0uNiKUoV2Oti0IZPAmLTCsWswppWsyCUGjclCkIN5pqUTqMcOJMXBWjHnVKcagU/hnjBQ9xeMcUYzHdXXQOqFwCeuo0h//DAIdIy/mUaAqOoe16aD4k2JDNkoAgO3J
X-Microsoft-Antispam-PRVS: <SN6PR03MB3759AB75B5B1974B19FF2B099D910@SN6PR03MB3759.namprd03.prod.outlook.com>
X-Microsoft-Exchange-Diagnostics: 1;SN6PR03MB3759;4:X9vyyucLIWd9yuDenbQYVV7vtdSwViRY40tCcqg7rYT4WIgO8dTQ5KHWCtZhmDzCNH0ijlWIplkGVA3IoKze612iT+ra3R0exUTlki+iv2G18GNRfrBvP5Ug3fA/Z3epdPlB+VurxP4HLXPhfaE6J4KVKyiXk8DzL+VnYalxrieZwgG33+gJWxjlz6PbG1Rz104daG/6RN1OJWfz2BDuL2e5b9xXAZTyUKwQCmRZ3gid87BrPmbuxmaoW37bQQAZIj9MfPc7vtzCLi/vmUoxsdNW+ZAMtpyfdEX08yDKTvzZ7EALx5iMyxEriMM50XAq
X-Forefront-PRVS: 09347618C4
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN6PR03MB3759;23:+MMt+iGjJVxFEmFi8M9EkMz0rhFS0Mv8bPNYDJJA/?=
 =?us-ascii?Q?aX2BjrtEyFDy3PfkpZSUkMkrxiiBSiloUDZJK5I7fqYWGPj30t0RuwngivUk?=
 =?us-ascii?Q?ztfOkhJXK0JeawvrPPAHIwDOUBrlrXFZPWWFNJS1lYFSqEFAyxbUuw7R+HA4?=
 =?us-ascii?Q?4uMkyWDrNyWieVXTwN6m7xOSbyf3K7MXPhDLq8Op+v664k+lV85cAGfeQHqB?=
 =?us-ascii?Q?/NV8LbF2HK/YCa46v+iIxExqxO66vhkzhovssjT7diJiXhprzP8w5Ut3nYVH?=
 =?us-ascii?Q?kaa0j94lR/w4/aLtObtQXunO08M/y2ljcuH/wZJPlOgvK8BuLBwQONeQtBUv?=
 =?us-ascii?Q?TqGNohThkctHQAz7FXXhCmtPV+oJDj0UvThXU7VMj4UtJnIQ9//nIUJc/JrT?=
 =?us-ascii?Q?Hz9AAW4/nA7X3P3QvAME50S8/uk7LpmIv7HOuJLykx4TEULvzBFAwQhzUrlK?=
 =?us-ascii?Q?b1T4gjUdCu4WqG5E1olIEuhiSwtQoJqfHkwdGEzDvRo8/rLr81VPEDWB8lWz?=
 =?us-ascii?Q?uZwyL+bfWX8IOoyURnotuFv6mdbIQYwj1Y3VKmwEcGalhBfm1jk7WADeaQpQ?=
 =?us-ascii?Q?E5Yj2ZlFoJAisZ6W9YTS+bEMP58AXGVabm9OTHNh1F8G0nzru6sxIa+Wypt+?=
 =?us-ascii?Q?Hw78xMaBU4dS3MPnOQjhYC4JNc1s66S3GG04TAKPwg3Wj5ZeP8pLrQa9D+0Y?=
 =?us-ascii?Q?RdB5ZOPPf03NA/umEj4UyYgIhPVjn+gtd1BoX+1Qvnly7oExNcsQH0DoyMKo?=
 =?us-ascii?Q?UuBmEEMuJJlzbW+/8Et91SqxDyT27ZhYWDxJhlvRzFN8NBcTK+rDHeGlicCu?=
 =?us-ascii?Q?sdiI0GReSjmiXROVatzYZpS2Vk/1diQxMYAZd1+lvZjDNK2T4M0A4cOI+Uo+?=
 =?us-ascii?Q?gPMq2R39wP4MLRDZ2m4NFiodZ+cmldQF+XQz3iZMghCrPg7W1Gl3aApZjqbA?=
 =?us-ascii?Q?sGF/H1rvVb7RZqSWsjK5iz4yb+/J7QFrYtKVBUjsieamA4ye/iiLBh5RiQbW?=
 =?us-ascii?Q?ZAeS9WH+2HQ5scfP4Ex9mqQrkjlAgZb1LPiXZsw6qTXuQ=3D=3D?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: ZAV5ocOOycZnKy1XyEp8oQuCXFr56Ef1p/5S6+A7Hc+wizhZRKChiqNhJN6Q1gj43MD3KrV6AeGso9qJjGDrei7SOsVA/2R5gEs4DGIGFHOypCz+Jo6xmT2VRODPjyo+r0yTP1LnAonCf3yHjHHgIdiP6/ce9IHYmabGevtyJSDPyMOFdv4hIt6qKYSdjU1D/+GZ5PMKmddw+8NDqQlwEvKUkpM7dLlvIBm3cUm6K7vdm/tbk7tNfdCGHjPPw6chxjUn2rz/+asRdjKeGnt3gbzX36F/h6wTEI7xkrH9FfT+i1zUdAnnbPUr9ODmwjNdb3zZjG+ht1NoIQJx53HXTTpVTPwMVJxx39CCgXm1hLesRCugy4qLoPPk0KoaanlwX8uluq6mhdWq6UPre8l234YCYTdY7zTb2UcjNmKajZ8=
X-Microsoft-Exchange-Diagnostics: 1;SN6PR03MB3759;6:CnMxs4YHAHm6uzAFjaQU6hMABD7iHA2zGMCtEEW0lvt8v77JU+p+ya6rtl+CPnfPxALJnIM/IWHWsDJsoxTPoxIzzimgxBPpk8vmNri1d+2oxUIF18S60kHq65ViHG1xrqB4F8wveB4oHY8tOPG30yRlowhqnN9GuL/o+Nq0smNrLw4aDfPAEvT/WLZStXf1GRV7eXwSiKehB3Ws0FC0XZmeUyPA749EZYIzH4N9lf8Tosk4CfMMKvhPGOXJV4woH8pNBFEwZBDez/a4NUeuEiNXcVj/+6/dPvvccXvk5qiOon2aPue/q3uDSEYuI1+OUavTTKSfvWNCXzouqeCAg2mQgSnxboSWy3HtJWUBz3akEUpVFl6PO8uGrhevc/SaHsNEvk5bhA/X2jV91cAzGOQbiwPmEidy6elDoWdtbOhWvJSe8k0hlpvy45+NlkkueC1edDPhbU8dpboRMGwroA==;5:Slz4PymEfs9gPFTU82SyTJJZWeGkPKpYpeEmjXBXTEhxAh0tkFnsbQCQaYafSNJrAVDhOO1tKtMdJdHsW61uAVT2M2nawMCbIBwG05kjvNc2SWACUwsXuhT/VOH38P+0IAlaUFY4RsjZwdYjBq9SAzcnRn2j57mYj/16s9IoOumo7h/IpG9ahuBWA92ElOJrjLdS0jBTGIiuLZS3qpTdPw==;7:n0/Nkdlvy41IMCaRJxbVBRR3BtVI957tzpp30fGJ8eyKHLzm/slycsTb5oDZA5UrUGrLWpUavpk4FkkOxTk4EU3tj0i634UevDeo0Z9V6UNN2rFuNesTXpbU13EBEcljMFHlwIuy8FFWZ57f74wTKQ==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2019 16:21:50.6090
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 67bb8040-a83f-4ac4-e338-08d6879834a0
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR03MB3759
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document support for AD7768-1 Analog to Digital Converter.

Signed-off-by: Stefan Popa <stefan.popa@analog.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
Changes in v2:
	- Added information regarding the simultaneous sampling of the SYNC-IN pin
	- Added the reset-gpios in the binding.
Changes in v3:
	- Nothing changed

 .../devicetree/bindings/iio/adc/adi,ad7768-1.txt   | 41 ++++++++++++++++++++++
 MAINTAINERS                                        |  1 +
 2 files changed, 42 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.txt

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.txt b/Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.txt
new file mode 100644
index 0000000..9f5b88c
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.txt
@@ -0,0 +1,41 @@
+Analog Devices AD7768-1 ADC device driver
+
+Required properties for the AD7768-1:
+
+- compatible: Must be "adi,ad7768-1"
+- reg: SPI chip select number for the device
+- spi-max-frequency: Max SPI frequency to use
+	see: Documentation/devicetree/bindings/spi/spi-bus.txt
+- clocks: phandle to the master clock (mclk)
+	see: Documentation/devicetree/bindings/clock/clock-bindings.txt
+- clock-names: Must be "mclk".
+- interrupts: IRQ line for the ADC
+	see: Documentation/devicetree/bindings/interrupt-controller/interrupts.txt
+- vref-supply: vref supply can be used as reference for conversion
+- adi,sync-in-gpios: must be the device tree identifier of the SYNC-IN pin. Enables
+	synchronization of multiple devices that require simultaneous sampling.
+	A pulse is always required if the configuration is changed in any way, for example
+	if the filter decimation rate changes. As the line is active low, it should
+	be marked GPIO_ACTIVE_LOW.
+
+Optional properties:
+
+ - reset-gpios : GPIO spec for the RESET pin. If specified, it will be asserted during
+	driver probe. As the line is active low, it should be marked GPIO_ACTIVE_LOW.
+
+Example:
+
+	adc@0 {
+		compatible = "adi,ad7768-1";
+		reg = <0>;
+		spi-max-frequency = <2000000>;
+		spi-cpol;
+		spi-cpha;
+		vref-supply = <&adc_vref>;
+		interrupts = <25 IRQ_TYPE_EDGE_RISING>;
+		interrupt-parent = <&gpio>;
+		adi,sync-in-gpios = <&gpio 22 GPIO_ACTIVE_LOW>;
+		reset-gpios = <&gpio 27 GPIO_ACTIVE_LOW>;
+		clocks = <&ad7768_mclk>;
+		clock-names = "mclk";
+	};
diff --git a/MAINTAINERS b/MAINTAINERS
index 3ba3811..e5613b6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -868,6 +868,7 @@ L:	linux-iio@vger.kernel.org
 W:	http://ez.analog.com/community/linux-device-drivers
 S:	Supported
 F:	drivers/iio/adc/ad7768-1.c
+F:	Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.txt
 
 ANALOG DEVICES INC AD9389B DRIVER
 M:	Hans Verkuil <hans.verkuil@cisco.com>
-- 
2.7.4

