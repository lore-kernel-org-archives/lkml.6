Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C570DC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 02:50:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 754C021521
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 02:50:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="cLP15aof"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 754C021521
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388682AbeITIbx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 04:31:53 -0400
Received: from mail-sn1nam01on0108.outbound.protection.outlook.com ([104.47.32.108]:32896
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388571AbeITIbO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 04:31:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CfTVsLS23jqnyvsz4IAJ9PgtZMs/nhKECPf1dyR2BRM=;
 b=cLP15aofzMcob6Fzio+TyOm7mLDBBTyAmZHINiv9Q6g7JfEfGR6dVEeCOpEfvjwr2dGmg0KdkzQZp07OlXJMVspCWplNmGMN+rcMn6Dfb4i7Hs2SY4kJ4MJrkFgeYZ9zSKEKrWfYu8W1qRqA90mW9rcsuQdbWZVG62bwt92ZmF0=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0855.namprd21.prod.outlook.com (10.173.192.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.4; Thu, 20 Sep 2018 02:50:07 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.010; Thu, 20 Sep 2018
 02:50:07 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Lothar Felten <lothar.felten@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.4 5/7] hwmon: (ina2xx) fix sysfs shunt resistor read
 access
Thread-Topic: [PATCH AUTOSEL 4.4 5/7] hwmon: (ina2xx) fix sysfs shunt resistor
 read access
Thread-Index: AQHUUIySA+fzRs3o4UGURCLQ7hIDaQ==
Date:   Thu, 20 Sep 2018 02:49:39 +0000
Message-ID: <20180920024932.58727-5-alexander.levin@microsoft.com>
References: <20180920024932.58727-1-alexander.levin@microsoft.com>
In-Reply-To: <20180920024932.58727-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0855;6:eQ9sGclG0ru60M4KHSjXM6uITwstjH4UvX7Gp2Es55w+/TYtyx2mm9lH91ACA21GxZDIO8+tJFDO7eburfhFR6cxFsFDiXi7L3y9m0PABcpyB2fKEwH4eeqmnKXCRMOkloBjS85N2JWXXCyAXLBbjlvULzaGS/qoX4Elc4RxqiY3Hb092vORH9OTgFkW8rhDV+rBTHmmJZRMF95jUGYg0jG8fljg3WyCa4XDXYqYCWqYwVFo1SPwOfpZxzywkiryF6NNc74qpb29gFS83IlDL4RxZ9XIOzxBR8mv6VolpFIgiZYq5CY6Mll0Sx9Emy6P7+AjDrtPHGsALClgnqUEd3ScJvXPuZv2/9YbOTHzqTQhYABIhCtn2QOll2kPNKJOJE2rrJ1bDXSUomKqZg+4FQ0C8npqqjf5pnYlUmKTKY5QS/WxhkvM5Xplz1kVy8zGbiX0RM4LziNMKTNFn7GocA==;5:sbdcFqCaMOKvwzAFUJ94O8k4PRf4NEbvRBucGbtW437LSL/ZKt9HxrbiAdrkj8eRGSAEftFuqzECbmtQq1c5j3QqsK4AWo1QP4LS3eFtokENCcWAeQOHeiC2A/cR3MifJ7t9IqnuIBmffRrL6pelHWGGN6L2CbkByGnPTtRj6zk=;7:A+LB+dukTHu73m5mm8HsVPGu10PPgToXJgES19Xe7O9rB43hC/pkKnRnl5yEXDdmVPwth4I7SVnpx54pZdx5+aKhCXAGjcI7DnGqsGBFBbytx16BnAAkSabgDCNaAa8eD5zV86AdSt7fAzi+FsfeZe1Vj1fgTHTurqv+OQoKCmjo1D7c4P04omEjXiGBnVNtdaxSzbHPrGIlCSsT1RzdeqY7kGNuiCIwcVk2VLzZTXnECtAox5BufPdxYV84Vbjw
x-ms-office365-filtering-correlation-id: 1eee4db4-4afc-42de-cbfc-08d61ea3c62f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0855;
x-ms-traffictypediagnostic: CY4PR21MB0855:
x-microsoft-antispam-prvs: <CY4PR21MB0855A471F40B6E5082F139B3FB130@CY4PR21MB0855.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(106291317490208)(31051911155226)(85827821059158)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231355)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0855;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0855;
x-forefront-prvs: 0801F2E62B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(346002)(136003)(396003)(376002)(189003)(199004)(2501003)(186003)(86612001)(10290500003)(478600001)(2906002)(86362001)(6666003)(106356001)(575784001)(3846002)(966005)(5660300001)(2900100001)(6116002)(8936002)(105586002)(1076002)(53936002)(14454004)(7736002)(305945005)(1720100001)(81156014)(81166006)(8676002)(6512007)(6306002)(68736007)(72206003)(6346003)(107886003)(102836004)(26005)(14444005)(256004)(6506007)(36756003)(39060400002)(446003)(476003)(2616005)(71200400001)(71190400001)(486006)(217873002)(66066001)(11346002)(97736004)(25786009)(22452003)(5250100002)(10090500001)(6436002)(316002)(6486002)(110136005)(54906003)(99286004)(4326008)(76176011)(2004002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0855;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: 8k6U/VBFUpdXYZFJV+o5pvfeyQumu4dnkx36eohaZFrD+BVxUewXdRm+7RIA7SWYXfz9Zgl4wq3oNLFZyIipBTXkreJPv6j5BmRXdQIU54Pmmtj7JDJKZT9uyzbVMFShXKujq2SQWGLqZSmxwbgDGdGEy/mh+B+dHv8Dx91NT4PPDakTewatZQzK4jjc91ecG1J4IhCjbuso2t/U5kpHtyVy70YCX6L0TSNUoJuh+bczNOl2/FaA6lK1rB07aAif3KfIPqfKLRz29JowfZWBx/GhCEWpH+zd+asa60psPAPrtoVj/UQwSt2HXH59v3esuVV8LDoad9Tdds0bdVgnsqOD2OSwC/G4O6gLAe6lLSo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1eee4db4-4afc-42de-cbfc-08d61ea3c62f
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2018 02:49:39.0218
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0855
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lothar Felten <lothar.felten@gmail.com>

[ Upstream commit 3ad867001c91657c46dcf6656d52eb6080286fd5 ]

fix the sysfs shunt resistor read access: return the shunt resistor
value, not the calibration register contents.

update email address

Signed-off-by: Lothar Felten <lothar.felten@gmail.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 Documentation/hwmon/ina2xx           |  2 +-
 drivers/hwmon/ina2xx.c               | 13 +++++++++++--
 include/linux/platform_data/ina2xx.h |  2 +-
 3 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/Documentation/hwmon/ina2xx b/Documentation/hwmon/ina2xx
index cfd31d94c872..f8bf14055c2f 100644
--- a/Documentation/hwmon/ina2xx
+++ b/Documentation/hwmon/ina2xx
@@ -32,7 +32,7 @@ Supported chips:
     Datasheet: Publicly available at the Texas Instruments website
                http://www.ti.com/
=20
-Author: Lothar Felten <l-felten@ti.com>
+Author: Lothar Felten <lothar.felten@gmail.com>
=20
 Description
 -----------
diff --git a/drivers/hwmon/ina2xx.c b/drivers/hwmon/ina2xx.c
index ac63e562071f..9ac6e1673375 100644
--- a/drivers/hwmon/ina2xx.c
+++ b/drivers/hwmon/ina2xx.c
@@ -17,7 +17,7 @@
  * Bi-directional Current/Power Monitor with I2C Interface
  * Datasheet: http://www.ti.com/product/ina230
  *
- * Copyright (C) 2012 Lothar Felten <l-felten@ti.com>
+ * Copyright (C) 2012 Lothar Felten <lothar.felten@gmail.com>
  * Thanks to Jan Volkering
  *
  * This program is free software; you can redistribute it and/or modify
@@ -328,6 +328,15 @@ static int ina2xx_set_shunt(struct ina2xx_data *data, =
long val)
 	return 0;
 }
=20
+static ssize_t ina2xx_show_shunt(struct device *dev,
+			      struct device_attribute *da,
+			      char *buf)
+{
+	struct ina2xx_data *data =3D dev_get_drvdata(dev);
+
+	return snprintf(buf, PAGE_SIZE, "%li\n", data->rshunt);
+}
+
 static ssize_t ina2xx_store_shunt(struct device *dev,
 				  struct device_attribute *da,
 				  const char *buf, size_t count)
@@ -402,7 +411,7 @@ static SENSOR_DEVICE_ATTR(power1_input, S_IRUGO, ina2xx=
_show_value, NULL,
=20
 /* shunt resistance */
 static SENSOR_DEVICE_ATTR(shunt_resistor, S_IRUGO | S_IWUSR,
-			  ina2xx_show_value, ina2xx_store_shunt,
+			  ina2xx_show_shunt, ina2xx_store_shunt,
 			  INA2XX_CALIBRATION);
=20
 /* update interval (ina226 only) */
diff --git a/include/linux/platform_data/ina2xx.h b/include/linux/platform_=
data/ina2xx.h
index 9abc0ca7259b..9f0aa1b48c78 100644
--- a/include/linux/platform_data/ina2xx.h
+++ b/include/linux/platform_data/ina2xx.h
@@ -1,7 +1,7 @@
 /*
  * Driver for Texas Instruments INA219, INA226 power monitor chips
  *
- * Copyright (C) 2012 Lothar Felten <l-felten@ti.com>
+ * Copyright (C) 2012 Lothar Felten <lothar.felten@gmail.com>
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
--=20
2.17.1
