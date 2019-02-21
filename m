Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C218BC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 13:18:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8730020665
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 13:18:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="oOUlhWge"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728090AbfBUNS4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 08:18:56 -0500
Received: from mail-eopbgr790042.outbound.protection.outlook.com ([40.107.79.42]:64640
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725831AbfBUNS4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 08:18:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6e2SNY6/tbjTsQdeZJcEhn5o/eo4bBcWr6zAGRybcHg=;
 b=oOUlhWgeadpBX++TEM5hIkbs2rFE9BOGhyJxewQO00qEbySO0PuYHRmPrNDSQsd/zegMbiErqWfconPY70l7vrsHeJwvdbOW4r4CK1jlW3YAkgzrIA1k3gB8j2/eOF8mXAiz1zRH2ssz2+I7ht1BY6TxYMDITNt9U9Mf2wGK9S4=
Received: from MWHPR03CA0052.namprd03.prod.outlook.com (2603:10b6:301:3b::41)
 by MWHPR03MB3070.namprd03.prod.outlook.com (2603:10b6:301:3c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1643.14; Thu, 21 Feb
 2019 13:18:52 +0000
Received: from BL2NAM02FT003.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::208) by MWHPR03CA0052.outlook.office365.com
 (2603:10b6:301:3b::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1622.16 via Frontend
 Transport; Thu, 21 Feb 2019 13:18:52 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.55)
 smtp.mailfrom=analog.com; gmx.de; dkim=none (message not signed)
 header.d=none;gmx.de; dmarc=bestguesspass action=none header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 BL2NAM02FT003.mail.protection.outlook.com (10.152.76.204) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1643.11
 via Frontend Transport; Thu, 21 Feb 2019 13:18:51 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id x1LDIpVQ003896
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Thu, 21 Feb 2019 05:18:51 -0800
Received: from linux.ad.analog.com (10.50.1.179) by NWD2HUBCAS7.ad.analog.com
 (10.64.69.107) with Microsoft SMTP Server id 14.3.408.0; Thu, 21 Feb 2019
 08:18:51 -0500
From:   Stefan Popa <stefan.popa@analog.com>
To:     <jic23@kernel.org>, <robh+dt@kernel.org>
CC:     Stefan Popa <stefan.popa@analog.com>,
        <Michael.Hennerich@analog.com>, <knaack.h@gmx.de>,
        <lars@metafoo.de>, <pmeerw@pmeerw.net>,
        <gregkh@linuxfoundation.org>, <linux-kernel@vger.kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH v2 5/5] iio: imu: adis16480: Add docs for ADIS16480 IMU
Date:   Thu, 21 Feb 2019 15:15:06 +0200
Message-ID: <1550754906-24640-6-git-send-email-stefan.popa@analog.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1550754906-24640-1-git-send-email-stefan.popa@analog.com>
References: <1550754906-24640-1-git-send-email-stefan.popa@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(346002)(39860400002)(136003)(396003)(2980300002)(3190300001)(199004)(189003)(11346002)(76176011)(966005)(478600001)(50226002)(2616005)(48376002)(106466001)(446003)(116002)(486006)(476003)(126002)(54906003)(356004)(316002)(72206003)(110136005)(6306002)(6666004)(50466002)(16586007)(47776003)(8676002)(4326008)(8936002)(26005)(426003)(36756003)(106002)(336012)(77096007)(186003)(51416003)(2906002)(5660300002)(7696005)(44832011)(305945005)(7636002)(246002)(357404004);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR03MB3070;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3e1bb60e-dbd4-4136-0eb5-08d697ff1f53
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(4608103)(4709054)(2017052603328)(7153060);SRVR:MWHPR03MB3070;
X-MS-TrafficTypeDiagnostic: MWHPR03MB3070:
X-MS-Exchange-PUrlCount: 2
X-Microsoft-Exchange-Diagnostics: 1;MWHPR03MB3070;20:Y4yAWgee4CLuHiJMTrrLj66GlfhzUM+sEaaN6e/Y0j1Rpmt8DtdfDrbwd46RW1yYi+OnMrbKsGAkwTDvW10Mij1thXcM/tIPLqbLq3CwCKw9oEmZbaDhP04s5NqvyiwMCO/4gw8UKtY+qy7SAA3Buluhw8jQBwxQBn6vWj5F3J73LjfumMs+rncRFRTlQqywQIvzpQC3O/WX5G2WQoOc4SKZvrYJLW3HUQX01eJlhmwMANYn2z1PkzA8/HqX/rUchNGN5RvO/7R4I9rLEdShTl+jac6WEpMykpV1GQVRjMlJcRPKtV1MAc0YjOIEZ7cFJCAiqpTJ6ZVnaZG3WMzHoUpmCBZoSXALUUaaYSBttnwSEnZnRZX7RL/dOK03Y80+6NjVDQLs1lSUrdiee6cQ9naMWWVQl2UcDQGw3y4AygqOqdgo18BSDtJ6zH2m/s2A6btJmGcdCCDAtsEZu9gL+5Ty8t9Mi+jI5lKhFQbXcEyR8OX4IV/dGVkykqEKr81f
X-Microsoft-Antispam-PRVS: <MWHPR03MB3070053EC5433D5B6A31BA359D7E0@MWHPR03MB3070.namprd03.prod.outlook.com>
X-Forefront-PRVS: 09555FB1AD
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHPR03MB3070;23:4NdzK1x+R3oTjrJat5HdI0YeWrxLHqAjgSb7FEYmc?=
 =?us-ascii?Q?VhTNXsGOoWAzetdOASuucnzAO88zH8ClQlYZaRcJqkWp+ph3Ir0SRbXss3vP?=
 =?us-ascii?Q?zKnNzj6XJmGhxgPHLy8k0EXkP7Ln4X2GW+slvtwoMvmNZoETQLPD0Phzbh4N?=
 =?us-ascii?Q?EZYn5D6PYCN84XdLl/RE6oixjk31BTiRgFZiULLy2z4XFDzHJv9oi3ye3KKS?=
 =?us-ascii?Q?/s1OtysLyYWHIKmf4EuIjlLqH+WO/E6Ede+M29RvUIgRfeyMuxpdpuDhNZiM?=
 =?us-ascii?Q?Bt0J3ZXhKZ1VuM2kC7jhdOg8fLDV8yUuv+RgDSCw/MpJZ92KQgvtUtlTC2hU?=
 =?us-ascii?Q?bxWKhtzOQ7puGVCyepzaq//ahU5j5nmpKy+Yd9AylpHo9x4g7nEsu1J1kn25?=
 =?us-ascii?Q?+urLeg+pxrxN6c3r/0wWejpE8UzqfJWCJRmT8oi7R5FWISpvl/fj1WkerRcg?=
 =?us-ascii?Q?r83HZzLYGqGu1LQkMi2YwY0fACOvgt6XcAF7VN6l9p0tUdNpaT9OYXK3UGnj?=
 =?us-ascii?Q?AoZoPKYTkL8la5nG5jd9HOWCO4TvYVqGTPQHdbbAugDK5jUU6kBetNVFb0/r?=
 =?us-ascii?Q?G3gDyvzHhEjZ1Dxr2zYUr53T+hIc1IujWoeB2lvdfXRxJgB1/2K4niX0ISCm?=
 =?us-ascii?Q?GoRH0BxF5tEnpB0Wp5dhy/IcNwAJowGbZ7ig/tu9IwWcVAtuPA8oVSHf4vYU?=
 =?us-ascii?Q?tr9THObyUXKOv4XuhPESJurulzgPAh1O7gAau84PBgo2z/j6DRjvdF0Oeme2?=
 =?us-ascii?Q?Lp6Khk6bV3DbMeo553TgsbXLAzy1fIVFAjqwtVDk9IdA66A0OeMpg6Om46zK?=
 =?us-ascii?Q?jCt1h2rip3OxGIaxy6WPGEEZ3e/h3u2EzRSSp2daWR8XeILoXHTpl6OPrMGv?=
 =?us-ascii?Q?YMmmP4nWupZhG1uNbntBXFVkvE27X7MkFzrwT+HNNiSXP3j5x6gywuzgxLyJ?=
 =?us-ascii?Q?nLW6GbB3kaBKL7GjjDqYN9H8c3r5VtZbcXj+hWsX9Igu1fQ9+l3HX9AZ2bjY?=
 =?us-ascii?Q?vNWXN1ruH6+R7nTsYpqSLP7CgiQfCDZB28GuGP5/0L0H9fihV3o6f8JNsTt6?=
 =?us-ascii?Q?vS2YxIEzJzKJhLApSeVXq0o1lVKcxRfWIOiCEiGEPZVvEFUtC+eaMDhMgxVE?=
 =?us-ascii?Q?rwifKU7Vyg=3D?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: kuZqmmVnJTAnxuoBuNintEv+zIX1jobOUon/N5oMFcUb7D39BLYHswESI15ZKSzfDiz7QtSwU46ZkhszVg12JnDnPX/RSIHNPoChLsi/O8gW+LNs+ylIQ6K/un8atOidXw7f53RGxNiiyoYy1M/YElMCqYft3s9DK3Y4SK9nUsz1HbWW99S35IoJ0oknMauJfuGRexBvoZ+mXh1vHW2SV0vjqW4jF3EVZ0v8lykVz/xmsGMFifs/ti2PBkzG15ilwmhNMCYsrNWtlMj8OgmjvcmNlUSOevgm/TEs5LXHOp45dsGIoxIKA08FmFn5O/jT4+7HjrszcuhTfgCzKtpa/IZl8kkgW8gbLsYu1PzJ46637rzFsQMH8HPrMOvQ8ftikuN+85NLJ12LG4D0nFuaF7rgnmtDbhi/qk+dAhPrx8w=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2019 13:18:51.6294
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e1bb60e-dbd4-4136-0eb5-08d697ff1f53
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR03MB3070
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document support for ADIS16480 Inertial Measurement Unit.

Signed-off-by: Stefan Popa <stefan.popa@analog.com>
---
 .../devicetree/bindings/iio/imu/adi,adis16480.txt  | 49 ++++++++++++++++++++++
 MAINTAINERS                                        |  1 +
 2 files changed, 50 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/imu/adi,adis16480.txt

diff --git a/Documentation/devicetree/bindings/iio/imu/adi,adis16480.txt b/Documentation/devicetree/bindings/iio/imu/adi,adis16480.txt
new file mode 100644
index 0000000..39ab016
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/imu/adi,adis16480.txt
@@ -0,0 +1,49 @@
+
+Analog Devices ADIS16480 and similar IMUs
+
+Required properties for the ADIS16480:
+
+- compatible: Must be one of
+	* "adi,adis16375"
+	* "adi,adis16480"
+	* "adi,adis16485"
+	* "adi,adis16488"
+	* "adi,adis16495-1"
+	* "adi,adis16495-2"
+	* "adi,adis16495-3"
+	* "adi,adis16497-1"
+	* "adi,adis16497-2"
+	* "adi,adis16497-3"
+- reg: SPI chip select number for the device
+- spi-max-frequency: Max SPI frequency to use
+	see: Documentation/devicetree/bindings/spi/spi-bus.txt
+- spi-cpha: See Documentation/devicetree/bindings/spi/spi-bus.txt
+- spi-cpol: See Documentation/devicetree/bindings/spi/spi-bus.txt
+- interrupts: interrupt mapping for IRQ, accepted values are:
+	* IRQF_TRIGGER_RISING
+	* IRQF_TRIGGER_FALLING
+
+Optional properties:
+
+- interrupt-names: Data ready line selection. Valid values are:
+	* DIO1
+	* DIO2
+	* DIO3
+	* DIO4
+	If this field is left empty, DIO1 is assigned as default data ready
+	signal.
+- reset-gpios: must be the device tree identifier of the RESET pin. As the line
+	is active low, it should be marked GPIO_ACTIVE_LOW.
+
+Example:
+
+	imu@0 {
+		compatible = "adi,adis16495-1";
+		reg = <0>;
+		spi-max-frequency = <3200000>;
+		spi-cpol;
+		spi-cpha;
+		interrupts = <25 IRQF_TRIGGER_FALLING>;
+		interrupt-parent = <&gpio>;
+		interrupt-names = "DIO2";
+	};
diff --git a/MAINTAINERS b/MAINTAINERS
index e4091ac..beecd1e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -942,6 +942,7 @@ F:	drivers/dma/dma-axi-dmac.c
 ANALOG DEVICES INC IIO DRIVERS
 M:	Lars-Peter Clausen <lars@metafoo.de>
 M:	Michael Hennerich <Michael.Hennerich@analog.com>
+M:	Stefan Popa <stefan.popa@analog.com>
 W:	http://wiki.analog.com/
 W:	http://ez.analog.com/community/linux-device-drivers
 S:	Supported
-- 
2.7.4

