Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 650A6C43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 14:12:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 037402075E
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 14:12:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="l4ln9o3o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 037402075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=analog.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727480AbeIDSiN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 14:38:13 -0400
Received: from mail-bn3nam01on0080.outbound.protection.outlook.com ([104.47.33.80]:54058
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726956AbeIDSiM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 14:38:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gWh4mPdTswa3YZNcC0nJf95Sn4nLNGjW1HLlufoGlH8=;
 b=l4ln9o3oJHOLG1E40wYeMrsVu2hhTGLMo9hjQTKEZRrtFPn1efjXRJvEQnupCnGzU0EZ5iAn2HDaS2Iv/MQcVwu9PNS09zQewSVPqSlnuGhdDEtqQFAQi9Kfkj6EbEidJqEMa0gta4hf5ENavzPGkdBJYlg05x+aGFCarYhs0UA=
Received: from BN6PR03CA0089.namprd03.prod.outlook.com (2603:10b6:405:6f::27)
 by BLUPR03MB552.namprd03.prod.outlook.com (2a01:111:e400:883::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1101.14; Tue, 4 Sep
 2018 14:12:53 +0000
Received: from BN1BFFO11FD025.protection.gbl (2a01:111:f400:7c10::1:169) by
 BN6PR03CA0089.outlook.office365.com (2603:10b6:405:6f::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1101.14 via Frontend Transport; Tue, 4 Sep 2018 14:12:52 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.57)
 smtp.mailfrom=analog.com; pmeerw.net; dkim=none (message not signed)
 header.d=none;pmeerw.net; dmarc=bestguesspass action=none
 header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta4.analog.com;
Received: from nwd2mta4.analog.com (137.71.25.57) by
 BN1BFFO11FD025.mail.protection.outlook.com (10.58.144.88) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1122.11
 via Frontend Transport; Tue, 4 Sep 2018 14:12:52 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta4.analog.com (8.13.8/8.13.8) with ESMTP id w84ECqBJ028066
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=OK);
        Tue, 4 Sep 2018 07:12:52 -0700
Received: from linux.analog.com (10.50.1.110) by NWD2HUBCAS7.ad.analog.com
 (10.64.69.107) with Microsoft SMTP Server id 14.3.301.0; Tue, 4 Sep 2018
 10:12:52 -0400
From:   Stefan Popa <stefan.popa@analog.com>
To:     <jic23@kernel.org>
CC:     <knaack.h@gmx.de>, <lars@metafoo.de>,
        <Michael.Hennerich@analog.com>, <pmeerw@pmeerw.net>,
        <davem@davemloft.net>, <mchehab+samsung@kernel.org>,
        <gregkh@linuxfoundation.org>, <akpm@linux-foundation.org>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <stefan.popa@analog.com>
Subject: [PATCH 2/3] iio: adxl372: Add support for I2C communication
Date:   Tue, 4 Sep 2018 17:12:32 +0300
Message-ID: <1536070352-5571-1-git-send-email-stefan.popa@analog.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(346002)(376002)(136003)(39860400002)(2980300002)(438002)(199004)(189003)(51416003)(7696005)(50226002)(8936002)(48376002)(107886003)(575784001)(14444005)(50466002)(1720100001)(47776003)(106466001)(2616005)(356003)(316002)(16586007)(476003)(2351001)(6306002)(54906003)(6666003)(246002)(126002)(106002)(7416002)(2906002)(4326008)(5660300001)(305945005)(7636002)(6916009)(26005)(336012)(966005)(72206003)(478600001)(8676002)(186003)(486006)(53416004)(426003)(36756003)(77096007)(44832011);DIR:OUT;SFP:1101;SCL:1;SRVR:BLUPR03MB552;H:nwd2mta4.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;BN1BFFO11FD025;1:NpJjDrFjC4OS6w8d3EHZ/3QMei+Fc6awn4TKU/gX9xz2Wpk5wy3HXCgeDBSC1X8qk/zqpptGvuxUUxK5Lfqi7bLd73vKyY1xlqZgz3nCAsf8KA2Lk32qNj1ihp65bEQv
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8170f0eb-a2ef-4f9a-541e-08d612708107
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(5600074)(711020)(4608076)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060);SRVR:BLUPR03MB552;
X-Microsoft-Exchange-Diagnostics: 1;BLUPR03MB552;3:JmFXQEKZttMwbJGlNn4eMSOzKRjx/6GyfMAtCme9tKQOaXhVSdvpC5VfgQjowwwE8w1JU4h8UGEZCnzR4WLUStAUcI9jybrX/tkWmE+XRLpy0x9HFcAHV42DRLIhg1oU6Ne3cwN7E2v6SLCK7E/DAuQ4aT4kGNLhLFtxtOcGiLm2T5GA68HfLYFk3Oec5I2yEdIK1mHHoHeinyoO/GMvZ7edT10W8npPmKSIdNHdlLCehr5jLoSppg/krz9E2ggR2aH9qt6UDL+sN6LPI9ZCY9lRW8exrif7ozKcjy9mJcmnjXTBVn71b/pLvsxcWjkvK9gYwyr+n4SGKDskJHx0kuJSXzw85igjq4MQ/vWTSCQ=;25:rNx97lh+0X0VzFtCAFImTVJEFo268O4sVUxkyHN3YClVWhAS1t4gw5vRK1IlVRa9pl7vjgSh6ffjPgdMp2XHG6OBz30FMxHUQyb9LiheU9rXjy87olruz8dQAC9Ptk+VcGkfhotQDUbxLkv3QqohBA0DeR3eSrXsgcEAL9d0ECgNgEcZCEQ4HJ1x2JiVtI2SJrlIb+oMRv8dJyEZnwLi1mZEIe5yILToBgjzZpL1VTPvUzcW0JZuxa+MCLCaZbHXW5mh+4hE8mgQpw+jcOg01aTp3GbMYA7wdQalpKZdgH/bYio+EVLLIqhSath4dPCE2WnNSKZp2W1ygGVWJ9t1rw==
X-MS-TrafficTypeDiagnostic: BLUPR03MB552:
X-Microsoft-Exchange-Diagnostics: 1;BLUPR03MB552;31:n4J52cDq3JGYnnJEp2fpYirwwu5LIELtq53ImXl048JhsM5TQVuYYIreL0+rDByEMntyNzAL2Dx7quXVN6DwpHeTkaNmpr2oSHFbL6wo1n2YlhAFgM1Eb44xYtOSG1w8c+b97dKtpJWwNl3FyzNT0uSGtVuhS0aYoz9hRRQ6Ul6nfn7Q/+48L4bg+OFid0YqcbYpLF1xumpbFOitXyyZGllz5ZaOa77jytg0A2n3sII=;20:ZuYK8W/0K9uwlGY/eBNwChHD0s8sNfpXi8BG3fTjFCEr5FlQZVaKlatVPHE4ojyU/WA+9Eqn39ZlkVOjNFk+wZp4uzZzwUeyaplNS8HpJfPMaS6qUDjDJLorh5T8CrOWM9emzAiBLofRADRBANd7+ZrJyN9dSIxDfUQpwSPpd+fSkYZkV9LCuzA9Q4iB3O3GmecYXmEN2AquBvtAien/5q5xHb8EV6gyPnZECWevN8+ILH3zxSexDg48nMje8BSbkkAoH8ZdV4xeoReMQ0Ic9DviDVXUhnwxgrAn3B2+enXUbjlPwvqEe7fMDy50gUxVY0lps3Z/bFs/bP3d+WitKUOc1t8pzmydkvyeIOFAKzZAfc1XMKSigAht8nOb2eMt6YP7VfcAUe3erHftmiz9f4id3dYZ3Hm+tQSjWSx5EeCa8qAeDhijyGzdC5F+CHv2AX93JhYEfGCknOOamanvrT2KTHiHio0L/UBonltY3S8Q4reiCbWTcYX/9tHiH7+H
X-Microsoft-Antispam-PRVS: <BLUPR03MB552B868A164632A60CB19989D030@BLUPR03MB552.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(232431446821674)(170811661138872);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93004095)(3231311)(944501410)(52105095)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(201708071742011)(7699016);SRVR:BLUPR03MB552;BCL:0;PCL:0;RULEID:;SRVR:BLUPR03MB552;
X-Microsoft-Exchange-Diagnostics: 1;BLUPR03MB552;4:qNnwA6voFCYXlmHK2nbx6qumCxY53vUQ6zpnZNhC+SOCGgAHk407DJs4d8+B4A+Zog02bMsEO/VC153Pttal8w4Rw4nKukShGoLGHteryxlCuCt9iEyTHHevsFyrt8yMf5PZAPjQFroQGh52i0C59voQxcriM8uwG4RI5TiupclGQnwgG8c1djkPegqtn/Lthvo4LwUb4cIk+ZVRM6yTIeypxfQ1C0KG5oS9FM40P6/VOvTYObak1KJKYxtKL+NzNzh+SGM3Of7HhDOipXVrOloZ1xMkUhRCgMa/Bjs9seTDBEEbfV/5s48pndk/ZJ2zZGiUKQnWcGDBjwPIoR2AwCJ7DcvMbWqJ5QbCsDNAEk8=
X-Forefront-PRVS: 0785459C39
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BLUPR03MB552;23:FOrgrVYWwnU+LsHkFAEXe7VNTgpnvTBR8Zi2gKA430?=
 =?us-ascii?Q?ZwbZ8DQB3cUcsr8zfwqgvaskyuJQtogmL44k87Z/YW6cjo20IyEXDiR0c0Dy?=
 =?us-ascii?Q?Ek+O01QlSKddk5t/Fhu0GhTgtg43yAsHrNJt5S829zDT19scShAPAatjikA7?=
 =?us-ascii?Q?dJfxs+9TPcek0VJ44Aw+qrOsaYDCEzkm3y+CpV7oeN0FkIOTlh91P596g4BY?=
 =?us-ascii?Q?YoJoNOnP3ckG2PeTRtVj4q3Iy8SOiSdHDPHUrXNiFv21Pz/h/+DmnMXei73o?=
 =?us-ascii?Q?OAL9YQsIy16JNvIJkSPfng8AmsCbbNMxp7gVWcCnwcTLsd/HIsC6d6mbOsHl?=
 =?us-ascii?Q?wEEaAlpySdiDfy/4N5aNFBCdT9RzhOjmK5vyAdVW4EaXGe/4GS6uiLJfi4GI?=
 =?us-ascii?Q?iSBpIeTwyLqV/HLdRlt2Nu/sPevcFv1yWexw+wrNgwVJ5iGJKmOPYmtinl1m?=
 =?us-ascii?Q?ABZhdgkKTEHHbBP5LlwsMVgtINyzUJRR9QcWyNJ3A6gQ07c0MCRCI+N42KTP?=
 =?us-ascii?Q?20+SUOqXKMLBRE+MhVkxcBljdQhQLbiG3/GXXnDwQAFlQGm2GgWLIxd7i54j?=
 =?us-ascii?Q?VU/yvnsxRnEcMt7vCG/AwIkKM26cxi6YpJyOidgrC/hpxvAY6J6IE8jrmBVj?=
 =?us-ascii?Q?LBoGnx99m2QsHcqgx3vSu9+EDG3YMu5KHW7+frblIFJUUEIEUTk157bpRq07?=
 =?us-ascii?Q?eI5l6wHn8weAVRXrqzDcmHG73W3iYSr3LjnyiNfCNgvgIPF73OhuGXeQJl/n?=
 =?us-ascii?Q?n8BeqQJ+me5vsXbWTk+C54PQAUq2oWh0FWs2SHJUGGgxmURakAyzoUVssbZt?=
 =?us-ascii?Q?n5m4ivv5znnoumEnRzarRhpVPJON0DzsRWNKDiwBYsh02XDwIC411TVbTEvr?=
 =?us-ascii?Q?hpgPsY98I8T902OnECkyco2IYiOagT/VN2eLiBGY+uhJeWarYuEYH7iJ1Q39?=
 =?us-ascii?Q?/ESWj4nUSMIlFBWjAIUsKXSo+SqNX0n74qJbNloBoTwkm1pZcf2DJRktQE2t?=
 =?us-ascii?Q?SssIbyYMlEPoek/3WP706IppzIpoqN7boQljlT+No+qBLfNBXmNKLeWTmOai?=
 =?us-ascii?Q?sk5eOwCPX5qg3PtN07Nheg9bdJmX8qF2uEumHq9pDtAO+4FrrbK3Pguhd2kX?=
 =?us-ascii?Q?kboxhF2pK+ujC/UXcl5ElFkrHVxPbJ5ClWvV+prjMDvnXc3zekSw=3D=3D?=
X-Microsoft-Antispam-Message-Info: DdjMyiOLr1DTSwm5LsPza5jjCs1eMNYvlJ23s7nQBmJfrWCc62UVVVPOHaa6/toSZPP3k4fG0IwAjYup2XzuKXwM+BddIG/DdP5VfkhJmMG2xrTWGYM2uiLPqG6KqiascC0fwaZReUkBj3dkpsNXTB3XxW4PRAe/YQFtlkPcIshVOdSGG8urujnywzQ66zujWemCe1lkm0teebqOPSR6dJMtpltu1wvCog0yoFTD3q/RidqBx6RGgJRSICFdJXwEIzUT+ZqeZq08YpmoQRbbg0d1LIaUBADjrx0s6oVZQfx07q+jzOKt2Y17L8fQH+i+p6n3/+zlBm0A/9amycN0qemEVRjeca/JZhOMzsgrO7Q=
X-Microsoft-Exchange-Diagnostics: 1;BLUPR03MB552;6:B8Mx4YAT/2Ob3KFZRNTDj0jmL6sE5ENowDVfBb6VrAqB1Uy5R+shk8mw6VAjfYO7eSMnW9mPWzjtiPcHNFVQ7RyQyrAggwa6FoFWFg86865szb7LUdCGlRdNXm90IPieTvLJSgmGviYrfErTj2xIluA7wWKzhgSmfswn2t/sHkHXGLF7eEeDV12I31RQ/Jshi/HLpUdkH9AI0Bo+rS3VbSqe9/Xd0mqsz6prZBWFgxeIC6vbXeB8JsSUlJ2z90NTwRkn1s1XhfxGR5aOenlUvixcCY7dJXX1aWZpZX1fEaYnwgVr3GtbOwyzelgNSWKC5TjxZ3RatrXzKy/ablvmeYn6f98HrB76IXNt15afzaNrVSHkRs2hw9DUec0yetgiUuF+eFgtWkj45hZSQmEXBkGGT/iTJrFBgcYvRFa7dNG4cDmhj4+BVfy/hYMfVj3ygPbHo1sRcQQqdmRyHeswcg==;5:RKHz91owlpvnesOywwx2cdP9lkUZ/1NF07NQ4H4ScpjFahsm9kX/EqW+Zi3963KMZ+du/LyXmpvrNG1/t2pXtaV6xl8DwP6x6xEj5EjDV9tdzT979PUahfeUxg6pfAC5vdVlT+G3FO43xvVSbefrZczUWbAWW9a7CXRMp3XvpZc=;7:DEvOyAHXNYZTSrX5z/+notouDursfPTZQ37yckm8vNRd07k4irFGQB8nbnxWHmIJt4EDTcV9TMJG/dltarcr3My86Dt4NJfG/eMMgQLiALRmS0OQqESctufKhzmlQDCxqy4EhI2gcAywgKDSoqV8xIjXYr03VAUZwTtcAmilF81LjxcZ8mOCMnCmLDez2+a6Rz6zGqIelSo+V5UCqGmD6Ay3afDv7M2c8hCjuYTNWkyPHeWcCOxSVEkFst/RgHp9
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2018 14:12:52.8319
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8170f0eb-a2ef-4f9a-541e-08d612708107
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta4.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLUPR03MB552
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The adxl372 is designed to communicate in either SPI or I2C protocol. It
autodetects the format being used, requiring no configuration control to
select the format.

Signed-off-by: Stefan Popa <stefan.popa@analog.com>
---
 MAINTAINERS                     |  1 +
 drivers/iio/accel/Kconfig       | 11 ++++++++
 drivers/iio/accel/Makefile      |  1 +
 drivers/iio/accel/adxl372.c     |  1 -
 drivers/iio/accel/adxl372.h     |  2 ++
 drivers/iio/accel/adxl372_i2c.c | 61 +++++++++++++++++++++++++++++++++++++++++
 6 files changed, 76 insertions(+), 1 deletion(-)
 create mode 100644 drivers/iio/accel/adxl372_i2c.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 2938632..2b9a364 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -549,6 +549,7 @@ W:	http://ez.analog.com/community/linux-device-drivers
 S:	Supported
 F:	drivers/iio/accel/adxl372.c
 F:	drivers/iio/accel/adxl372_spi.c
+F:	drivers/iio/accel/adxl372_i2c.c
 F:	Documentation/devicetree/bindings/iio/accel/adxl372.txt
 
 AF9013 MEDIA DRIVER
diff --git a/drivers/iio/accel/Kconfig b/drivers/iio/accel/Kconfig
index bed5da8..7993a67 100644
--- a/drivers/iio/accel/Kconfig
+++ b/drivers/iio/accel/Kconfig
@@ -76,6 +76,17 @@ config ADXL372_SPI
 	  To compile this driver as a module, choose M here: the
 	  module will be called adxl372_spi.
 
+config ADXL372_I2C
+	tristate "Analog Devices ADXL372 3-Axis Accelerometer I2C Driver"
+	depends on I2C
+	select ADXL372
+	select REGMAP_I2C
+	help
+	  Say yes here to add support for the Analog Devices ADXL372 triaxial
+	  acceleration sensor.
+	  To compile this driver as a module, choose M here: the
+	  module will be called adxl372_i2c.
+
 config BMA180
 	tristate "Bosch BMA180/BMA250 3-Axis Accelerometer Driver"
 	depends on I2C
diff --git a/drivers/iio/accel/Makefile b/drivers/iio/accel/Makefile
index c9c5db9..56bd021 100644
--- a/drivers/iio/accel/Makefile
+++ b/drivers/iio/accel/Makefile
@@ -10,6 +10,7 @@ obj-$(CONFIG_ADXL345) += adxl345_core.o
 obj-$(CONFIG_ADXL345_I2C) += adxl345_i2c.o
 obj-$(CONFIG_ADXL345_SPI) += adxl345_spi.o
 obj-$(CONFIG_ADXL372) += adxl372.o
+obj-$(CONFIG_ADXL372_I2C) += adxl372_i2c.o
 obj-$(CONFIG_ADXL372_SPI) += adxl372_spi.o
 obj-$(CONFIG_BMA180) += bma180.o
 obj-$(CONFIG_BMA220) += bma220_spi.o
diff --git a/drivers/iio/accel/adxl372.c b/drivers/iio/accel/adxl372.c
index f1df89d..3b84cb2 100644
--- a/drivers/iio/accel/adxl372.c
+++ b/drivers/iio/accel/adxl372.c
@@ -26,7 +26,6 @@
 #define ADXL372_DEVID			0x00
 #define ADXL372_DEVID_MST		0x01
 #define ADXL372_PARTID			0x02
-#define ADXL372_REVID			0x03
 #define ADXL372_STATUS_1		0x04
 #define ADXL372_STATUS_2		0x05
 #define ADXL372_FIFO_ENTRIES_2		0x06
diff --git a/drivers/iio/accel/adxl372.h b/drivers/iio/accel/adxl372.h
index 5da89b1..80a0aa9 100644
--- a/drivers/iio/accel/adxl372.h
+++ b/drivers/iio/accel/adxl372.h
@@ -8,6 +8,8 @@
 #ifndef _ADXL372_H_
 #define _ADXL372_H_
 
+#define ADXL372_REVID	0x03
+
 int adxl372_probe(struct device *dev, struct regmap *regmap,
 		  int irq, const char *name);
 bool adxl372_readable_noinc_reg(struct device *dev, unsigned int reg);
diff --git a/drivers/iio/accel/adxl372_i2c.c b/drivers/iio/accel/adxl372_i2c.c
new file mode 100644
index 0000000..e1affe4
--- /dev/null
+++ b/drivers/iio/accel/adxl372_i2c.c
@@ -0,0 +1,61 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * ADXL372 3-Axis Digital Accelerometer I2C driver
+ *
+ * Copyright 2018 Analog Devices Inc.
+ */
+
+#include <linux/i2c.h>
+#include <linux/module.h>
+#include <linux/regmap.h>
+
+#include "adxl372.h"
+
+static const struct regmap_config adxl372_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.readable_noinc_reg = adxl372_readable_noinc_reg,
+};
+
+static int adxl372_i2c_probe(struct i2c_client *client,
+			     const struct i2c_device_id *id)
+{
+	struct regmap *regmap;
+	unsigned int regval;
+	int ret;
+
+	regmap = devm_regmap_init_i2c(client, &adxl372_regmap_config);
+	if (IS_ERR(regmap))
+		return PTR_ERR(regmap);
+
+	ret = regmap_read(regmap, ADXL372_REVID, &regval);
+	if (ret < 0)
+		return ret;
+
+	/* Starting with the 3rd revision an I2C chip bug was fixed */
+	if (regval < 3)
+		dev_warn(&client->dev,
+		"I2C might not work properly with other devices on the bus");
+
+	return adxl372_probe(&client->dev, regmap, client->irq, id->name);
+}
+
+static const struct i2c_device_id adxl372_i2c_id[] = {
+	{ "adxl372", 0 },
+	{}
+};
+MODULE_DEVICE_TABLE(i2c, adxl372_i2c_id);
+
+static struct i2c_driver adxl372_i2c_driver = {
+	.driver = {
+		.name = "adxl372_i2c",
+	},
+	.probe = adxl372_i2c_probe,
+	.id_table = adxl372_i2c_id,
+};
+
+module_i2c_driver(adxl372_i2c_driver);
+
+MODULE_AUTHOR("Stefan Popa <stefan.popa@analog.com>");
+MODULE_DESCRIPTION("Analog Devices ADXL372 3-axis accelerometer I2C driver");
+MODULE_LICENSE("GPL");
-- 
2.7.4

