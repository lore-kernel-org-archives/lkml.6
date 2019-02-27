Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BB26C4360F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 16:17:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 455AD20C01
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 16:17:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="m4aqMHRP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730177AbfB0QRc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 11:17:32 -0500
Received: from mail-eopbgr790048.outbound.protection.outlook.com ([40.107.79.48]:15331
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727400AbfB0QRb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 11:17:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sbNycr1ODAo4AYJ7qnkI3Sh0dwDMeOkrWah9MlkF1ss=;
 b=m4aqMHRPARqDjDGp83lDGiMwB0qpL4sZmp9LnXC7KqnBUiCRFdLLlrYiL0taR08lmmWpqitBpiiEFvxdOdRr8u+xqUTYt+FiDKQXclemh/bm6vPYst8wt+kgD6za9/h2ppfh1t5wXgrDhd1QkdtZMCp+EEmLerYt08UuvfjMl5o=
Received: from DM6PR03CA0049.namprd03.prod.outlook.com (2603:10b6:5:100::26)
 by DM5PR03MB3068.namprd03.prod.outlook.com (2603:10b6:4:3c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1643.15; Wed, 27 Feb
 2019 16:17:23 +0000
Received: from SN1NAM02FT005.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::205) by DM6PR03CA0049.outlook.office365.com
 (2603:10b6:5:100::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1643.18 via Frontend
 Transport; Wed, 27 Feb 2019 16:17:23 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 SN1NAM02FT005.mail.protection.outlook.com (10.152.72.117) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1643.11
 via Frontend Transport; Wed, 27 Feb 2019 16:17:23 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id x1RGHMn1022187
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Wed, 27 Feb 2019 08:17:22 -0800
Received: from linux.analog.com (10.50.1.179) by NWD2HUBCAS7.ad.analog.com
 (10.64.69.107) with Microsoft SMTP Server id 14.3.408.0; Wed, 27 Feb 2019
 11:17:21 -0500
From:   Stefan Popa <stefan.popa@analog.com>
To:     <jic23@kernel.org>, <robh+dt@kernel.org>
CC:     Stefan Popa <stefan.popa@analog.com>,
        <Michael.Hennerich@analog.com>, <knaack.h@gmx.de>,
        <lars@metafoo.de>, <pmeerw@pmeerw.net>,
        <gregkh@linuxfoundation.org>, <linux-kernel@vger.kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH v3 7/7] iio: imu: adis16480: Add docs for ADIS16480 IMU
Date:   Wed, 27 Feb 2019 18:14:28 +0200
Message-ID: <1551284068-4882-8-git-send-email-stefan.popa@analog.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1551284068-4882-1-git-send-email-stefan.popa@analog.com>
References: <1551284068-4882-1-git-send-email-stefan.popa@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(396003)(346002)(39860400002)(136003)(2980300002)(3190300001)(189003)(199004)(53416004)(7696005)(72206003)(51416003)(106466001)(76176011)(54906003)(966005)(6306002)(316002)(478600001)(106002)(2906002)(110136005)(36756003)(16586007)(50466002)(48376002)(186003)(4326008)(8676002)(7636002)(8936002)(246002)(305945005)(6346003)(116002)(446003)(77096007)(476003)(126002)(26005)(11346002)(486006)(44832011)(2616005)(336012)(426003)(5660300002)(50226002)(356004)(47776003)(357404004);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR03MB3068;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 613b1e0b-077f-4253-3767-08d69ccf0e85
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4608103)(4709054)(2017052603328)(7153060);SRVR:DM5PR03MB3068;
X-MS-TrafficTypeDiagnostic: DM5PR03MB3068:
X-MS-Exchange-PUrlCount: 2
X-Microsoft-Exchange-Diagnostics: 1;DM5PR03MB3068;20:bwp1UJZSa5gFDHkOdSX8D73+aQTxfHmItQDIWee+qtN825UN0jGWFSfKk1Vn9YuryxmsIhnYEDLXIA31njvhWdB+KsLDSm82mztbkIyRFDU/n9GtnBDHO1Slm+RLoJv/y54iLMCZrR4EROxVD/7d0Xu7sTRi77OAy3EvJVzc8z2y4uIMarUX+0X3SpUeX/zBV2VANe3XxI9RLTX1/BimZccrPwZmiOrOS1iO4ebcDKG6vEs1kNaJVagMFBYwmf2sU71R2SMGDbbEizW/MFqOskhp9hdO9u9srgK52ChR7wqvEkCzHId7r7YMVwwiOIjLkmTVGtwF5LMxr6ETcbL0rL/3adIdAmzAPAce73ey/RgurFt3T6ZGu5ZKt/Qwtpy9h598WFFkRV2P0ThYGy4woSl3NfZOfHFOPRBSMBlz0wlMPtQx1nmH0AUAXhQjLsSHpm0XtHfXEKyYqHcek/ldYzrKzrM7zX1OOZnHCPkF28Dh/GY1WwlupMNosgFY4JNW
X-Microsoft-Antispam-PRVS: <DM5PR03MB3068A7BF4657D1B9B738BA0B9D740@DM5PR03MB3068.namprd03.prod.outlook.com>
X-Forefront-PRVS: 0961DF5286
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5PR03MB3068;23:izWE4AVPc5Ad6H3XNgd6Wj+bbBgCMsHoZX089wFZe?=
 =?us-ascii?Q?WyT5RIymOXfFT3jI54QRUwaDFeZrTUIG0jj5AUHoZRhujagXbi62CuM+w2sQ?=
 =?us-ascii?Q?RBuUPezDRvtJ0m5iyNCsM+SewcChc6Ne9u+Mop5hUQLtsalPwSxT6KtoJxIX?=
 =?us-ascii?Q?h1Egtm4HGiIJvNMTqlmeWRyX4UCpITOB6lFb629jMjLhIbBER5wQMAILmBgm?=
 =?us-ascii?Q?Z3MCLqFfiJlqn5N0HPzd67HlPB1dEhtHo1/ZM40a+c+6ydvws16Rxp3m/6qD?=
 =?us-ascii?Q?8yg1sNmy6zoN29nQImeSRBy10gGj+NYv3pwQhxxqtcGzeVt1X3X0BCX1cc/8?=
 =?us-ascii?Q?iIrH2Qr21UAz4Ej8TKJPQGsdm8ZI0shu35PzObQ3wPR5CSh6lvgTbEb0NRme?=
 =?us-ascii?Q?yLWXn1Jr0pSFPJnrUeaxiok1Ll4Ir06Yo/wm6IasjluXEMMhlqfZLNR2WaSn?=
 =?us-ascii?Q?lUSQCWQmFwXCXk8PF49+O3rFETKivhymZQeLNUssJ8b+DU7eT3b4nFx3Kgpi?=
 =?us-ascii?Q?elCNM+VJ8Ft9zJtDyrQuwvLE4YbS+9Ub7UpoWflTkXRdxhEG6NXW8cE8xatx?=
 =?us-ascii?Q?0DNcc6Zxcbj9zcuYiDibGO+825QUXKN4mGXaHAyfdTlRY39JtSWUg7x/eSYA?=
 =?us-ascii?Q?wBW7F9HrKGEYWca+M4jt95F5yeR2fUZyvCuuin/mPH5SAzZnpiNKAdW7SNQ3?=
 =?us-ascii?Q?dow6wSfV5cKIY0aWdACWuohEzE9LIJD5w0SpHMpy1df9z1hzLypsvd4xWtWe?=
 =?us-ascii?Q?OOiHGmvu+TkAz0HlZraPU7rkTU2xd4yH5YeLEGZ0J5YCA6wnWlez7Agwr8fJ?=
 =?us-ascii?Q?+Xs1RWB+fZfGtPDECO01yzkprPXja9TyNFRcB484lQEaRm2wG5cNMPrIj6b0?=
 =?us-ascii?Q?OnP98XECIfU25F+RHpEJvZsZXEjM+8XmrYQt41EGdZ8Ng9RSISPAJsPHiGae?=
 =?us-ascii?Q?2y7jCvSj4PKJdbyJT51G8sn0aeQlOIji+WxZh0dwAKr4N8Nk5idZ2RTNs28z?=
 =?us-ascii?Q?2qI4hqFiCbOyXknu7DlaqW1s8PFVOrPvA7jNPJDWgl/LyTlFbZI46eJIgQnc?=
 =?us-ascii?Q?bG0NNzkVDvUT+f9x6ZViMJ2OJxtTZSxbBZrh8fVYM5Yw/J5D1B14QurnmIIX?=
 =?us-ascii?Q?JP0nIaYqXw0Gr4gY6cCQB96PJi5H2hc?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: WeI2mtUddfNz9umzQU8TskKHCTSj1+QcsjjR3M6xBoSxNJgttqKIIY6p7AZxc0rKgJ474AMRLqRrZZdYBldgPPmIHpgRnjYwomwnUux70kh0OBw17ua0mXI7hSqf/dmzOmha5yFoDb0fWpRFKS0PfJAm+tBGSDHSMOLVsSd+3a/RWGFU4ukiE2m/tGlcHXTSXZFjtCm/MT9AY8UlBMnQhZAx3kCWUlZJ8jFX07W4NlOqdZFowouR1rEtk2Co1UPly02WM1cHpOO+jjUz2zQoClq/PbJP/t6mf0CIr1ms6Qg1ESygtCIYaYqj5PoS4FoTGiqx7d4wyjc7rDUBiZ/SX7Vh9Lv94NPGzbix5ZZPhYIykTcLlg56zsHZIN0kSSumwq1rgzdvwgfSWvOVpjJugMOT5Dmxk0g4tIAcXu6K430=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2019 16:17:23.0634
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 613b1e0b-077f-4253-3767-08d69ccf0e85
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR03MB3068
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document support for ADIS16480 Inertial Measurement Unit.

Signed-off-by: Stefan Popa <stefan.popa@analog.com>
Reviewed-by: Rob Herring <robh@kernel.org>
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

