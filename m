Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 945EFC43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 13:27:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 539EC20651
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 13:27:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="vICCcLDn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728394AbfAGN1L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 08:27:11 -0500
Received: from mail-eopbgr820073.outbound.protection.outlook.com ([40.107.82.73]:14091
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727147AbfAGN1I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 08:27:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+fXXnQlYTTE+LBv45EZ3ykFQDtxPvJJ7XUebSfBA7fk=;
 b=vICCcLDnvAL2PenuvfuIJQBkgalM3JvKUwpn7IEX9XcuQ/SFpQX28V54hpcbw1YuNVsJh3cCmJiDjA2xC8wYjK3NcsSAFSQ7T0izQGA2DGqxqKQh/GMouxRh/kitQaZ5ayRoa29gklQb54oi8vekT2MK3desoBELXx59eNlLtdk=
Received: from BN8PR03CA0025.namprd03.prod.outlook.com (2603:10b6:408:94::38)
 by BL0PR03MB4257.namprd03.prod.outlook.com (2603:10b6:208:6b::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1495.6; Mon, 7 Jan
 2019 13:27:02 +0000
Received: from CY1NAM02FT024.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::207) by BN8PR03CA0025.outlook.office365.com
 (2603:10b6:408:94::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1495.6 via Frontend
 Transport; Mon, 7 Jan 2019 13:27:02 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.57)
 smtp.mailfrom=analog.com; gmx.de; dkim=none (message not signed)
 header.d=none;gmx.de; dmarc=bestguesspass action=none header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta2.analog.com;
Received: from nwd2mta2.analog.com (137.71.25.57) by
 CY1NAM02FT024.mail.protection.outlook.com (10.152.74.210) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1471.13
 via Frontend Transport; Mon, 7 Jan 2019 13:27:01 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id x07DR0sI026827
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Mon, 7 Jan 2019 05:27:00 -0800
Received: from linux.ad.analog.com (10.32.224.122) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Mon, 7 Jan 2019 08:26:59 -0500
From:   Stefan Popa <stefan.popa@analog.com>
To:     <jic23@kernel.org>, <robh+dt@kernel.org>
CC:     <mark.rutland@arm.com>, <knaack.h@gmx.de>, <lars@metafoo.de>,
        <pmeerw@pmeerw.net>, <Michael.Hennerich@analog.com>,
        <gregkh@linuxfoundation.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <stefan.popa@analog.com>
Subject: [PATCH 2/2] dt-bindings: iio: adc: Add docs for AD7768-1
Date:   Mon, 7 Jan 2019 15:26:49 +0200
Message-ID: <1546867609-4273-1-git-send-email-stefan.popa@analog.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(39860400002)(136003)(376002)(346002)(2980300002)(3190300001)(189003)(199004)(356004)(6666004)(478600001)(7696005)(336012)(316002)(110136005)(51416003)(4326008)(54906003)(6306002)(16586007)(47776003)(7636002)(305945005)(186003)(116002)(77096007)(106002)(5660300001)(7416002)(966005)(72206003)(26005)(36756003)(8936002)(50466002)(48376002)(246002)(126002)(8676002)(44832011)(486006)(50226002)(106466001)(2906002)(107886003)(476003)(426003)(2616005);DIR:OUT;SFP:1101;SCL:1;SRVR:BL0PR03MB4257;H:nwd2mta2.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT024;1:BDP0C/YXxrn1CkMgzSd/TjpqF6JIHLi4iG+ZJFSmXqQGus3ipSD9nxYiijqhZwxXn9bdXp37vAsF7mVmZK6p2SLmb90VVnPkAlHvzUhwUhOwZEm0pMjGYP/B/CDmrpCg
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2ddaa30d-1096-4b7a-4b0d-08d674a3cecf
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4608076)(4709027)(2017052603328)(7153060);SRVR:BL0PR03MB4257;
X-Microsoft-Exchange-Diagnostics: 1;BL0PR03MB4257;3:Ef+plt6eJEBx3pTvNM4nrCT4xqPLboKY4223ycYRhxqUuJzw1MjysWiQcRFec068aYPM4VNBAxdl7qb3VixDjR/u5IouVO4DwHw7oyRgVRmn/MJU98k0X1eVnKXjikPwZc4KBlCyIG/r//HZanii5Ioz30eVFSrV86JGUp8Du0tXb2b8eITuNQge7KPxz4C29aAhyDy/soqfXLW+CuBB3Gg8NvTm1Y+AYoApgW2vF7uuV3fKbAad9p6BQ9n/VYnUqwdeuSE+CURmPW48OmMVQKSAsgIvgc+xaxoEQVwY1Pehp9zCu7Ik0lMf6O/WLCYp4wzc5Fbb3oMArxjMn7FVA6ADdL8g1rj/LzNs/WCfPotGth+2H9mmyFsuHonMuuCw;25:Ey8+P6bXttBWr70gm3JYtQkHuGDkh/mUJkHl4ZkI+BENlnMtFxikSh5hne4VSqunwK67zh8XJ/1csKQjxCD3v9l4xmqHr0BlXFT6EEDs6XGr6JKSc2mwQgLNwAUAFjb1K6QYhWsxUyG+ge8M1XNUV8oKWq+yKw1lyJvKmhakiApd5fXtLusGWgZC1Ljj4oHrUVFcSMLgTFDRbhi+8LrY7m/X0rBigr5Cg3ixt40E68vWGALvnaF1dQuRJuE6wmSF9VBx6hC7+hx17iSusBzyMIbaqfGcomPNahUDlRUXqHfYuZaUm6hRWlGXISQMTV4L46HcxQsdFcNTwF76ld/20A==
X-MS-TrafficTypeDiagnostic: BL0PR03MB4257:
X-Microsoft-Exchange-Diagnostics: 1;BL0PR03MB4257;31:bHWh7rKz8Ct6rPl+3wWkRaiDKxSOIfUTeZxysXmVKWXomv1oY+fg0a4NdmGFvsH/6gVqVBTZ6VK8+oU8srO4gOBPvYOb7AXrnp8IBqnp2/c2TwkHdj0iWwgQvdJa/dnWg+xIARpG017r2WhNMsbn1Od5GnesMApQbWD+Kju0dd8jIC7C4pRSnZp505PZhvlUhVOgN+TlIsH23GqZljjeYzGGjU6AeXwqrkZcLnSzf3Q=;20:ZK3Yc2Ccz23qM52zwgGPixpTbu4xsZXJjHTKReHmrsf5ZJfhVPxMS+DgmfnRWvPXyzGKMw7l9hAIozWwRL72nLFf8NFOv2G2TYQ04g/pkbaLq9BXH9kbe1oeLX9nQlGJQGu+zDM1i4gLYjl13Eso0+oJLyUPoOWAisuoQyn/WSLPQ5dJbJcSNVRNfmrBquY8lcUeDTrJ3rjBiuH2A2BhmqNvZQkCv5xoE8hfw/qLGnkL1PvvU0Va5qOvjTRYVcO6Q6RfdfXTrwtVP8i205IDumq93DbKrc6b4VIrnbmfeI5lNujuOL7IgmBxdkWsmYlMdHL4DbBRayqcua7jhYcC18LHfvurEW5MAKGFQ+wZtf9UrPZAElDyUps2hQxP+KR/Qntv2H4Y/zUX6G5KP7AqLfQTM2hgH8WB0906acq+DGERIEZDGLjoL7gyUN7dJUFC3JFyM3M7C/bwteYEUlOm6diCCx4Td+Tbv63LTgFBxoLOpLB5+1yn2o3OHSGeYfmn
X-Microsoft-Antispam-PRVS: <BL0PR03MB4257F980262F7108DD2F9E4C9D890@BL0PR03MB4257.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(908002)(999002)(5005026)(6040522)(8220060)(2401047)(8121501046)(10201501046)(3002001)(93006095)(93004095)(3231475)(944501520)(4982022)(52105112)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:BL0PR03MB4257;BCL:0;PCL:0;RULEID:;SRVR:BL0PR03MB4257;
X-Microsoft-Exchange-Diagnostics: 1;BL0PR03MB4257;4:TEUMha9zrIsXL05SR6CNqpkCRH5/28NaiG8JhJelHbw2n68ZzC/jGQ4KKdcz2gp2a/GhEhl1+vO/rfbp4+TrZZZxXBGYdv5ST56md5PCXCZyXymOnfgfg7KQ1ErBOCypqBdJJRY2Qjyqy8UKEF3V1WeY9nYRjui7Ocy6gGnhEJRbkpCn0XbZ0fzQUntlIxmjfh53J8nxEYJWcZsSruXAv4SvFCnubWbqrP2nNlo/5MUvrD0+rd7yYdAgrT5+AqF++rkB5xDEi+XrL6FpPgFhO9Ks0W3e9ofkeS3WkQho45AgsgkZUabGgzeZf0SA1b0g
X-Forefront-PRVS: 0910AAF391
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BL0PR03MB4257;23:K2KwnT021l41RfBuk0UjeiWtusOZTyk8aRXHpQa5H?=
 =?us-ascii?Q?Mlpj6QQh2mx6oPRbDOZUSWkqufTCCKGMqnblFL8usYCekc59yeYhx4fl+EIQ?=
 =?us-ascii?Q?d5a/T5/ybG0QrFiiYsNt12XSr4YHgsUKfVCh6uLpxzPyx/dTDAfdBCebL8SK?=
 =?us-ascii?Q?Y9KQzu9ddq4UecS8urP5p93U+y8+nC+4pSpmObHmwMUc1vYKfGnPsX+YUrXC?=
 =?us-ascii?Q?s0mZAcz/ytVcVsJG3+lDryJTXOrzqwuiiVg9bG2DCG//SJS7pM+UoPz3MJLc?=
 =?us-ascii?Q?5MajSN1RfpkqujUB8SHXJ7VYwVlFqL7mIRK355NvpmPeAlsTXB4k5/taiQ+w?=
 =?us-ascii?Q?PSR8RGcJD8z2YEVoI2fqE1wpEEWXx3Shyi2088Fu5u8ByNTE8ZBfF/l2zHA1?=
 =?us-ascii?Q?K/zp459Gn/81fOGRRZp3/TYbb3eISFSNx/6GGH0YPQ0QJdtGImZn1LwZTGgd?=
 =?us-ascii?Q?oeOrNcrpEr5TkBa2RfsF12hnGk7Zl+74CaZ+Y66p4P5bjF8scbs4mqpQL/zW?=
 =?us-ascii?Q?N3km9tsz7HqW3mjiLm+eAC2kikgQ1+/pe/gtH4/kXibiBmGQ/HuCrR69+cds?=
 =?us-ascii?Q?6V7DbIWLLK6lfCZw0hudwUcjBMyf2qV6Rdc+IlWrP/UH/J+fHKcHGF3M+mU9?=
 =?us-ascii?Q?WJkoSBCOJIuanJEl0Rg6r0Z6othtwm9fC2lr49P9Vno+qVFFMNg3kzuTBNw2?=
 =?us-ascii?Q?R/KCt0CMedNUK340DcfVGYHopzC/wmL2bhFA5yeUpw43bb/85RxzuN3j5pH/?=
 =?us-ascii?Q?Hlyjnya2G2qRnevE/F3/fAxsVFa52k2aMTeo8a5QPvd8pBF7F+3+2Px2mKMC?=
 =?us-ascii?Q?HcmYObWXnhkBvDQ3vkoxynIwMCNTCDE8yW6ppo3XasyW1MpnenG722SFVcFm?=
 =?us-ascii?Q?ssvgGSj0F7A4T/26EQOXDOSJljYczmcBiXlsnoCKZ3z1i8J18o0QCpB5cJVO?=
 =?us-ascii?Q?Tx6UpFrEFIYep+kPhvFOP3tEzxotumQbgcmHrqI28tcsjG2JFWzO8lnNBDgg?=
 =?us-ascii?Q?LKJObGYcp3P69Of198a0x0JVM4UJCwnDUQRCerD799X5RSvhWvw3z5EwFkH8?=
 =?us-ascii?Q?niwjnD7DmuVkC1+/mXw+UnlyLhU?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: ReEypXppr/P3yDYqQ3iNiGTxWU53vku9AylK5WlA7e4tFX3jnjKBBwbSHSl8SHL8d2Yy/9PffQKZpoqMN4pM4fxIaTskkro2iLT4UENZ2ofRgOWWg2x/c5MYRK29evugAdxC9yRGOx0oB2l6KNTbvOpGBYQtVsyS5fhv+tWzy5XjmPSBg0o48x8MLgTQyrqUQ805aZDkqYfQ29wJn6rfQoGT37QXni7Qgh34E0+bnnkK34x6wSWF5BZY85VDSYh7KZStjO+8v7Lr6XjdMWOj2GQ6NN9eOHRc1iWMrVdG+Gndh9Cl/TcFXds0HI00hEPO
X-Microsoft-Exchange-Diagnostics: 1;BL0PR03MB4257;6:Vh3AZ234ez6MgdjQjBpG/0GOfSLhXhxDfs4YfbchIXdxSpIK/keiSoJJikJn7nJU1tgM7lVMqQ3WdA1FJ6ilwjbXevD8AIC0PgrvjdV3c9lnehXQXZ435NSLsgEFFzeTwivvH6W4TZjM4qQMy85ta/zylUA6gSC+IIrtLpQcJRp7obdQcox4SQR0BqZjIWRd+7UIkbA6v+FNli8/30SIZuDN2OU0tEevFj4tdzQfJTDu1WoKqpPGXGBK4iS1CTTOLRowqmypPFVNYsrVwFi8pRj+3NxFfvkwOH9sA7E9PGo/jTb0cZNk4rpwrS0U+Dav8D5fexf9YZXHgcHx4JRmCOYnfdsEKVwPZrIct7dwaN4aAL5ZcmwbV/t5qPxWmN4zYggAT7nJWVDgrPSK5Zp8lUaSgq5LwJlJA8Upnadqu5vVdSMyuXxwYD0URDhvgi0QsaMBhb6m4kMnd1ygon5Kug==;5:zT5Jz7+m7v2WlPEWD0yTXp8iy9Ixrqmaaiu/nRkMSwKQ/ouEiABzB5b2VB04fO5SSSaONI8fb1HuaJfkSdd+PeEnjSdiS7WEN9TD/Tb6tznA+b4TwmydrZ29DKRIqYCLYh7hVKmZsvbGf0DNm2GQ+Z1q110baO9ok61MtaKZ39BQ8+H905UFFQ9mE+GrhIsYVNBMGdRbJuV0DMBXFiwBEA==;7:mDlyYnGjexajkHBESdUa0p3I84EIqesBxF6itoVnzKljqRxlogDmgXgUrJ7Osf13CQKVfbsS40c1nj96WH02GkFZti60+FvDlK4WppcxZKZf8K/xa9xsCGIVvt/NYup1B/9GLxe+M6QpTXUrM918RQ==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2019 13:27:01.1592
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ddaa30d-1096-4b7a-4b0d-08d674a3cecf
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR03MB4257
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document support for AD7768-1 Analog to Digital Converter.

Signed-off-by: Stefan Popa <stefan.popa@analog.com>
---
 .../devicetree/bindings/iio/adc/adi,ad7768-1.txt   | 34 ++++++++++++++++++++++
 MAINTAINERS                                        |  1 +
 2 files changed, 35 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.txt

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.txt b/Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.txt
new file mode 100644
index 0000000..bf619fa8
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.txt
@@ -0,0 +1,34 @@
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
+- adi,sync-in-gpios: must be the device tree identifier of the SYNC-IN pin. A pulse
+	is always required if the configuration is changed in any way, for example
+	if the filter decimation rate changes. As the line is active low, it should
+	be marked GPIO_ACTIVE_LOW.
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

