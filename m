Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE233C10F00
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 17:15:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7E4621773
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 17:15:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="sRumtV9a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729320AbfBSRPd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 12:15:33 -0500
Received: from mail-eopbgr710084.outbound.protection.outlook.com ([40.107.71.84]:26496
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726147AbfBSRPd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 12:15:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k9SJCRuQu3TsyRwrOYFjybLKcPFp96Lmr3ufQau0Tso=;
 b=sRumtV9ayBRDoipDqg4xwHwryejUSfjkBQcK4ZzcSuo9Xj2JuEQ+d6a4v820T9S2DC3RtVdSYQ/hDgypG7l3ew+Bk2U/qIW+bGm6VosQ9ExETv71kRJlhO8ek9KZqwKwPjIP4G9a6uYULqOkaVGI8sAlBRps+ytmQYayO1lAd4M=
Received: from BN6PR03CA0008.namprd03.prod.outlook.com (2603:10b6:404:23::18)
 by DM5PR03MB3067.namprd03.prod.outlook.com (2603:10b6:4:3c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1622.16; Tue, 19 Feb
 2019 17:15:28 +0000
Received: from CY1NAM02FT048.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::204) by BN6PR03CA0008.outlook.office365.com
 (2603:10b6:404:23::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1622.16 via Frontend
 Transport; Tue, 19 Feb 2019 17:15:28 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 CY1NAM02FT048.mail.protection.outlook.com (10.152.74.227) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1643.11
 via Frontend Transport; Tue, 19 Feb 2019 17:15:27 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id x1JHFPfg010017
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Tue, 19 Feb 2019 09:15:25 -0800
Received: from linux.ad.analog.com (10.50.1.179) by NWD2HUBCAS7.ad.analog.com
 (10.64.69.107) with Microsoft SMTP Server id 14.3.408.0; Tue, 19 Feb 2019
 12:15:25 -0500
From:   Stefan Popa <stefan.popa@analog.com>
To:     <jic23@kernel.org>, <robh+dt@kernel.org>
CC:     Stefan Popa <stefan.popa@analog.com>,
        <Michael.Hennerich@analog.com>, <knaack.h@gmx.de>,
        <lars@metafoo.de>, <pmeerw@pmeerw.net>,
        <gregkh@linuxfoundation.org>, <linux-kernel@vger.kernel.org>,
        <linux-iio@vger.kernel.org>
Subject: [PATCH 6/6] iio: imu: adis16480: Add docs for ADIS16480 IMU
Date:   Tue, 19 Feb 2019 19:12:18 +0200
Message-ID: <1550596338-24220-7-git-send-email-stefan.popa@analog.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1550596338-24220-1-git-send-email-stefan.popa@analog.com>
References: <1550596338-24220-1-git-send-email-stefan.popa@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(136003)(376002)(346002)(39860400002)(2980300002)(3190300001)(189003)(199004)(4326008)(305945005)(51416003)(50226002)(7696005)(106466001)(8676002)(76176011)(72206003)(50466002)(7636002)(966005)(106002)(246002)(316002)(54906003)(36756003)(478600001)(110136005)(16586007)(8936002)(48376002)(336012)(6306002)(446003)(426003)(6346003)(2906002)(26005)(77096007)(11346002)(44832011)(186003)(356004)(116002)(126002)(5660300002)(476003)(486006)(2616005)(6666004)(47776003)(357404004);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR03MB3067;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ea7bc694-2a18-40dd-c1e8-08d6968dd825
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(4608103)(4709054)(2017052603328)(7153060);SRVR:DM5PR03MB3067;
X-MS-TrafficTypeDiagnostic: DM5PR03MB3067:
X-MS-Exchange-PUrlCount: 2
X-Microsoft-Exchange-Diagnostics: 1;DM5PR03MB3067;20:OYWhnO8n1XaKI84o+2DSmipUWVHaoxZ+/G+6bb/FblWnroPyCS+4jwYKXBhTMU33QFPZStobWWxF1PLDJo/jz44vypJmFYvT32jF68Ezm7M9DrsaB7kVI0jL198zajJRAXUvLIvB/updSTfI/EMycf9Sd7G+z5E/jlqEOZvxqXynW3qOsdouwcvxeauhW/FWikKGcfep3SMJ8zutDScLxBLuue6m5ulGXU7dKFjieZl//3ilxn82sD8kslAjx55xgptdJQuOpvGuk2HlJIxguktKVzYd4mH/FwaFQV3kzYg496fyCsygNAmf8YNnadBGNFnJWa0AfJY5uNIEycWisq59WJIHILnqnOU/jNETAYs/yJwUsXEmH6ldDyhw371m8A5dX8NNSqF9AU2WVlG1r6Tb1QO0YCyDQNcUn6IBxUtf1zz93qj7xp4OwEdaFfVh5JLdymOUmShSQxkhbWXKway48+qzzofQL4HGjyMyhjtTHqRJfmC/Dtc6zbdPxgz3
X-Microsoft-Antispam-PRVS: <DM5PR03MB306733400E79D6FBAD9FF4719D7C0@DM5PR03MB3067.namprd03.prod.outlook.com>
X-Forefront-PRVS: 09538D3531
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5PR03MB3067;23:pFu7ekVO+6X6GWLaQwRYJ5Vjtz8Xvf85w7GR0lZ3A?=
 =?us-ascii?Q?eXp7Y5h2Kdu6gfGtbnkPJ7RU7lUzjPEwj7bpOpSFItmC0DYd/zDnyW0Zg4zX?=
 =?us-ascii?Q?CZDfZacq2LyzXoQHWWfI6+kivjUUtRn6riHwAebs9RqN6RJESdGeR2XQwEX6?=
 =?us-ascii?Q?wYKsZ1teNtu9iTd63wHu1kksJuWoolcgIXne9E3BZdHQBECqZ0ltLenEkg79?=
 =?us-ascii?Q?vkBv5UlaDMoksr1l/HZj3oSOUE8dyXGAHywQJ+lqqWHeIvWH3NJS47+2yFYe?=
 =?us-ascii?Q?sqF9zfGu0dFs8K/iGn5hZ3877uJYesN1tOWJBDKAMZ/z5Hyu2+7Wo217paIq?=
 =?us-ascii?Q?pv4avZiNtSi+anaY/wtBc8Ec8u4ObJm96MW/x3b5GaL+S/EF7tKiBbiHfoJd?=
 =?us-ascii?Q?eRNFGbk8KlImR2GgXtnyY62R2ulNrlqtFVOWYORXjAneDeS9I9mBhwgdkUhx?=
 =?us-ascii?Q?DmG6tMsHTrZQC67xRXxSdMylJ/kzlFhQjZKFTpjZIA1T+DbRM7rhu+0IOVBb?=
 =?us-ascii?Q?moZQs87G2A5ZX9NPotefIYwmbpjukpwkQmhcAaOJMcKyWXSGKbrXt7wO04lf?=
 =?us-ascii?Q?6vNl3XzVcN7sXR+7j3/v1UxWewWn/++rFYHd4hutKYhR80s/9xQ5TYH8Eybu?=
 =?us-ascii?Q?Zna6gNPiqmZfoT4d83I/IOMixvTjyI/i9JzI01XUBK7yRr+coEnFOmjJb2BD?=
 =?us-ascii?Q?oyFjKMciZti/XU1UspeIhIuY8eUUCFBg7lPnPr1arQf0neScqUvnq9+kbqNA?=
 =?us-ascii?Q?hvKLrmBsqzh8GJHAlHlzsBrtLZI5P08x3+ODlcJpRzqUXxon8dLe8StZ8TGl?=
 =?us-ascii?Q?zxqpejg3k+At+wj5iDl9JUSSG8fKuw6QWm7lsqwFB1h65IlSq/DYW+kXa4IE?=
 =?us-ascii?Q?J4QFrREtps9qUvUevdVuf71YdxjpEIt4Z7Gsm6tZjrBJLHpy5gwKcvtdcH9A?=
 =?us-ascii?Q?YzhzUfA0gMkQZh41KabX338BpbO35btaiIuKkv9irS01sMlSNFyvLGU7I/zs?=
 =?us-ascii?Q?04evCtmPR3g4Hw1F2aHOhHhhzObwyf5jnmGDyp7ECGdMq4skq4QGS2l2QTwx?=
 =?us-ascii?Q?pbwKB3yanzLmOugdpftL6DwFFHzysWeEWaF/AWD+dIyXsGutSlecSDrhH3B0?=
 =?us-ascii?Q?SPzeFE38aU9ADpt+0i38j7E+JLdu7s2?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: YMidW2E4xNfoLLLnSCDVNMhi6EFgnWUUgr2FUM5GUa0IIRzcWO59gq6MEwrpwh3dSa87uTkN3brsx9eVKABsZkFz8eR+mq3QX7s+fp828MovtN8efY7XEJxYD9vficgeoLxmogRkFLv1KyZWcFHXab91lndNmzGscqDKedJW7oR/mGyF/2Jnm3h81FnTYDcw3rapeoShb1m//0ejdSbfk3D2gIkxg4qIegnPa0/7Wm02iK1ch6LCKC+YM6c4Nzgx040ZSX0lkINg7lAphdFmBPJ5HHz1pX6mxdLcEmGCXwbSyNpD6md/GSKuScI9zuHh4Ln56evRtCeWqGkxa+o3xunfNREtqWOPuk9svP0tcc+hsDLN6s3+uGKsPjwV2P4hMDCVoxSUJhmznTiQ0Urtkyi6g4Jheke2zkQNTgcz5tc=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2019 17:15:27.2315
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ea7bc694-2a18-40dd-c1e8-08d6968dd825
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR03MB3067
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
index 0000000..dacf5f7
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
+	If this field is left empty, the factory default assigns DIO2 as data
+	ready signal.
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

