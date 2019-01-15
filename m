Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D624DC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 12:37:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92E2420657
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 12:37:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="M3rbcbQj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728822AbfAOMhC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 07:37:02 -0500
Received: from mail-eopbgr700041.outbound.protection.outlook.com ([40.107.70.41]:14848
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727703AbfAOMhB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 07:37:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HaLW6Imh2GfryteF+Rh6351HpC42pu6ILM4iX6lbn8I=;
 b=M3rbcbQjKHmHAZJGpQi4EXtSoKE0hIWr/b62HWKfC9QnMFFJW/YzrhYbSnXVSSkI8H2Zjw/B+j/YkNpq0UHGTUQirUzGr8Zm3kVX3z5b4YV0F+KnnKromMi1Df55oKWHJHWSJxfC2nPEI6CvhmKekHNKEb+V14L2tIpNXwmv8Us=
Received: from DM5PR03CA0030.namprd03.prod.outlook.com (2603:10b6:4:3b::19) by
 BYAPR03MB3493.namprd03.prod.outlook.com (2603:10b6:a02:a9::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.14; Tue, 15 Jan 2019 12:34:17 +0000
Received: from SN1NAM02FT062.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::203) by DM5PR03CA0030.outlook.office365.com
 (2603:10b6:4:3b::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1516.14 via Frontend
 Transport; Tue, 15 Jan 2019 12:34:16 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.55)
 smtp.mailfrom=analog.com; gmx.de; dkim=none (message not signed)
 header.d=none;gmx.de; dmarc=bestguesspass action=none header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 SN1NAM02FT062.mail.protection.outlook.com (10.152.72.208) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1471.13
 via Frontend Transport; Tue, 15 Jan 2019 12:34:16 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id x0FCYFYh007929
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Tue, 15 Jan 2019 04:34:15 -0800
Received: from linux.ad.analog.com (10.32.224.122) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Tue, 15 Jan 2019 07:34:15 -0500
From:   Stefan Popa <stefan.popa@analog.com>
To:     <jic23@kernel.org>, <robh+dt@kernel.org>
CC:     <mark.rutland@arm.com>, <knaack.h@gmx.de>, <lars@metafoo.de>,
        <pmeerw@pmeerw.net>, <Michael.Hennerich@analog.com>,
        <gregkh@linuxfoundation.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <stefan.popa@analog.com>
Subject: [PATCH v2 2/2] dt-bindings: iio: adc: Add docs for AD7768-1
Date:   Tue, 15 Jan 2019 14:34:03 +0200
Message-ID: <1547555643-2248-1-git-send-email-stefan.popa@analog.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(136003)(346002)(39860400002)(396003)(2980300002)(199004)(189003)(77096007)(26005)(110136005)(186003)(486006)(44832011)(6306002)(305945005)(7636002)(7696005)(47776003)(54906003)(51416003)(7416002)(36756003)(316002)(16586007)(106002)(5660300001)(106466001)(2906002)(966005)(356004)(6666004)(72206003)(2616005)(476003)(126002)(426003)(48376002)(336012)(50466002)(8936002)(50226002)(8676002)(246002)(478600001)(4326008)(107886003);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR03MB3493;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;SN1NAM02FT062;1:HIVJsYwsK5TomRv6MCjtZHWyQHp3Uaw0WZ0grbpUk4GMdbhidYYA+dltAa0TqCgLzPLaPWZr5fc5Xqlj2hSYmXHuRtUDmLxjezGrglgf8rZV7rdu92aNwgDzVfRrawBn
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4f882752-d8ee-4f2a-5c1c-08d67ae5c3aa
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4608076)(4709027)(2017052603328)(7153060);SRVR:BYAPR03MB3493;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR03MB3493;3:iw9juaUWAwmGviSGu9iYJ7jBRQZpo91We3x8ua/WhqqBZu2IUm0zZ09n+cxZfeu8nX4nF+gCaGxuJSslV82ZFtVr9NNbJfXPzle9tSughKsE8Ih432dQ0gWqhyssM+IBk7w7t/8ZjpVZ5ATLki2n/lzyEum9xgny9JQBQmV1R/PAFhJd3ZcrwrcRjLU5JG90/DGf577h4v9uF8oY3kJ9vizR+qx2TCOVxT3BitRSH/RRjmrTe0pluiOO1qtxCxoyB2VLCDfXCnU2FdDgUkz7kHeReE2Xsj7jcGTQOvPo68SI0iP/1JwpxXNb4/Dw3u+rMlKbIfmKhEmlx3CxuYhKARwKArYxn0W+Emx1DN/MiB/fQYcbENqHr8FrHeAMAEvy;25:OPyr8M1ZsUN3H3FsR/hKZ4Z3/eCw0Oa4HUJkxQf7Ek3xg1bkM+JOdndN9SxhF7g4gCwErXoAknhI5F6F0YYS64umn90k47Cj33ixeu+ODilo/tKTEGDhCKz/i95fPW7VpovRJfRJwoAKzqBNu2wXW9Ewl4fO/riMzXDHSV9C3UnYNKfLDxX+JlGqn/YN4e1TLqnsRDwSk6h2ve8lJwdsflUVCX1C/VYP/jTFmehS1ajc1g2JfYI9S+xC20OyEL3s16vhwVHTWmEaiMOur3TWFZBfMbFvZnzDukwBVsf41u0kN5TnU+2LrziCgd7HPw7m1qAQ/mxd8Jy+3i9YS+skWQ==
X-MS-TrafficTypeDiagnostic: BYAPR03MB3493:
X-Microsoft-Exchange-Diagnostics: 1;BYAPR03MB3493;31:2sEvI20GIzvzCuLe2DpbZkP7Qv5SnIZyjPxMrC6wPEWlDFJe/SuC/YCnm0y2iS6TR1YVxwJPe5a6NB08raWcwYtG7H9bcJsvSQPVOtlsJqeqpj/lUrfmndGUzdpfjD7s3OE1iG7TL0Bm64Xraeo4Ji8XFSZ9ZPKKPAtusYEmXACNebkHj5X+oqnKW8FO4nNWo0tmz4arBwjkI9gTzRn52M1M+ZaDPDXZWuLefdYc/Pg=;20:yVSefg+XmTraeZWlPG5S0jl4pdpbjMHw7nBhEqe7RBbm2wOzvG1nnIcsHXJMODh5EvMxedeyV7JX5+YIZll/Y8mGRoSVXEzTMAXB5R9pepzZcZsZWVQbKlNgs7XbyQ56wmz1Dn88se1+ePiQMwblHDCaYLMGWQMB4NajrU61mKlt71H3LyooiM6wpacteE6tav6ThiT+GMGuYrriSy4omoTqhHWvhMeox1VXlUxerOh6Ia1C4ChUq85RZOgYp4HJ2Vl7nWe1tOn9hUGyEUX0PX7H9Y2CwjQqOq1QshOHfG2Lyv0wVaCR1GZ65GskRiPO4V3QgkDBJGdUCOjj03Xu5ByoVCwvuaH3Ep+XVIAMFEIoPFUFZqrv7OIpjgvwIMiL2oI74Kj2fQ4PY2+m8BAjXL4/n2t0WLaE/1PnYuXdlNFa/4CMtvmPeUpJ04o1aJGnNhYDkDC4/IdtuIc11np7owCl1nYxxV4BiD055yMqDki/+U//+P7rhkkGRqNv0Dnj
X-Microsoft-Antispam-PRVS: <BYAPR03MB3493D036959E62CEFAF39CE49D810@BYAPR03MB3493.namprd03.prod.outlook.com>
X-Microsoft-Exchange-Diagnostics: 1;BYAPR03MB3493;4:r9EVOO4HdD3BR2G15ilc1r5QB9YkStUEg12pE1piMeTCRogkJFPgzcoUxqIOy1cVmS56SnWWA1Tb2FK69jzZ1gzPEKLwM2Zmeg3hngAZVatljxIkkCqx1yv4Xd5ISm3FAn+z7VcOfcajblXjIFVqs7rhbzCcoZjkGFcVaq6RurZPY67CCB6ZLTP7CKyVNMB34WmD98iCFz/BNPkn8rtvanaqeWfLja+PW+XmvdkizvnjA6MerAkV6xsCBAHw0KrPUG2794xYo7Bh5vDyBo09XtGWm0PYZCcxXuCmFf/T1ysi6+Z9CfKTl7vkQWW8A0Qn
X-Forefront-PRVS: 0918748D70
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BYAPR03MB3493;23:UoAn8ldFXu7v1lsz7OjZcl25YJG9KBE4FcQEW6dM1?=
 =?us-ascii?Q?FJFmREPsNe9TwbS07eQM7jcOyazSLQnUQoetMc6hu0/mYPKnvKOVu8BzpJKt?=
 =?us-ascii?Q?5tGBLy7T8V9J2LzwkH1NOERX7ZeJflG9J+GfW2v4Quzg5nVZToTgnNY2+4D9?=
 =?us-ascii?Q?XgeURsTjHjweh/fwGP010oaUxsTp5RQiLRZWMr+i4CNj2y7UsyVM7mrgbqBj?=
 =?us-ascii?Q?7rI0JL2pibk+9rSoJNxpihqnTzBSw5/Wuj5ai6zXKrKbcjetmroyijUNuxon?=
 =?us-ascii?Q?XZ/+opDLNxdbNjehMJbDE9KkLF5Y28gZewzzkMv0llA62IIIuM0OsfHVd6UI?=
 =?us-ascii?Q?taEf/l1/tcc0ZV9L18ulBPYB9nqdpVM/25tFs4rVZdxTSyaX1pzDR/PiXlGW?=
 =?us-ascii?Q?5HH4CEWNCVxBzu7wa14eTs/0Vz0jgmNvaOSiNLFAH1kgj/XD/lrM6dMFVB75?=
 =?us-ascii?Q?fp+CeIJkOoI44gHzMZJOwaxVJLjqNX5wzjPxeuyfkx2T+XqkH31kRjp24sTM?=
 =?us-ascii?Q?wvi6dqFQGdJHiAq/1yFnINkP7zX+L7bxb1UEoNMYR+h7HRk4jJWnmMio0IUj?=
 =?us-ascii?Q?X88OBZZ/Dq5zrONw/INx3Jhz4Uh0TxatYzvuKI2s2+jnHzP0qYYTztJMxpXw?=
 =?us-ascii?Q?50WbxCskbYz0PzzRs4Kr9HsQWwbMxHPVkFa5Oy3y2iZALYCE/vThPEDL6phe?=
 =?us-ascii?Q?a9U9gII8slrZIRCeKqV1PKSn5fl923yk8TuF7dJwIfA27sM5byT2re/Srkpl?=
 =?us-ascii?Q?igqwyTNO3qS6mPQNSkmT1NsnWOqpMI/cKCbPnmdtspwBviRMESn97NvtcTPe?=
 =?us-ascii?Q?kqVGvvWX+3Y59S3vSS0OgcoueCCUl9JXp9iAv6I3bDr+BndvC4XNSTjvmTjX?=
 =?us-ascii?Q?rmN/X6hBEIqEpkqBmi0dYxKKbXN7a0KjyPPclN/TfB8UH4czlpyrSiQBnm39?=
 =?us-ascii?Q?fgheXuzRciGDnMrRMKwKCaLPR7y1MmdscyEqmqoUV5aTPMR4Pu4f4cJrejhy?=
 =?us-ascii?Q?S2WjIc7B/abCoJtihjXvfv3wbzz9X0ZN9Nd0q3MqB3p2Q=3D=3D?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: bmKnb8WNOuprIjwhIItJeOeGmVOTMUKYYl/fCJDY8u7UfIZvYabVFi9xtK8Ln+bvaftRu7VjU+pMFuGrHvHo6TNz7E4wwxWw1WadkTmoqJ4/u027TeMuB8Cocywrbw1qlZxtnXIymV2nWzSCKnO8HgJ8rmYPB8ePmt9fOkMdv1vj8wDvFlvHac1+g9yRVKzOt4ALQXMpf+D8ljn1kvKpRFJcezGFiNi5gHVdAI1bsSYM9tvV4DszsCM1TEU9OsxwjaY7Bo3pI0Z/+Nc6w+s0d4gqQ5wZxpC3iM4TItPw4ynRXSN9UVlYZ50aVMGM3ONrPMeMFxkzEK9uNokFATOoRGV8yqooiAL+hUahpp9NQCBHgfhVyR0re9rn73oj9zRp/bTosqsE/nxi4O9u5E7YpKKyepJ8PQIVWhLuTs9LTfI=
X-Microsoft-Exchange-Diagnostics: 1;BYAPR03MB3493;6:u2usjnA1R9kRJthObBc3gBqsRNfekQae66jGiRBx5US/L+7AelAwO8Iur44ZhD/sow4dAJna9DM19nCAIQOwDoYYXgYDDTeOuEluGefSf4yT05usyXnB2IojpWJt2YtK5MTGluoJmkm0SfgBvV+4hCpgIQahad4eWqmRcGhbx4F/VfLjSfMttgKzgFaxHUf864xEIPx3Kv67EshJgrTUOFm7DeZCj3+J0iuXSpFTZlXM2/Y+LjWvyUrF3umSVFhu19BTJPXCcVekpTzkv+PP7ehpEdXtunZ1iFbPUIf2P7rAQIQT60Z5jq2aDSF1d8f7hH2hrZzjsRkkdy6JdaNTZ1HgiMLkRjbsVZ5PNMDFwBhgDP1N0x6ufAXPA/f61sYJsglWxLw4FuWY7h/ijxD5zsYOlMgW1/Ah+ixMvglPl7racx+aT5G4e6g0dfJwq0K7v98OzALhbP04+YIbKjkkDw==;5:mN+6bZcTb9veOzCp1M6xjkBUp+8ZSJgfzPHcgDKiRoUTBUeknmcQohroFZH14AqoM5LB+gcc1Vn7k2+xX5CvDGeDCFtrV6Pi/7qRVAyLEnwPLsuIflpEw2vnN3Nd/t2rBsQ6QX4QRJAxxrRPzMYECJQ5mDaSbnfxIOxUxvK2SnWKbidBBUNEBivSexaUNAaisDJx+EFC6j5kZmHUHFv7Dg==;7:9wOAFMitS7gJ3eDqgbw27ZlZ+cDuc/QJouL8FyMcrM/+MZ89y40CQ3tOtfN4rR5IqXkuu+tfW40arHCN6fm8McRYYmNlnYB+X0dcj06c1JDhTFtddwV3x48PnlGrPYRfBt96xxfqg/DvopwFOqVPbw==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2019 12:34:16.3324
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f882752-d8ee-4f2a-5c1c-08d67ae5c3aa
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR03MB3493
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document support for AD7768-1 Analog to Digital Converter.

Signed-off-by: Stefan Popa <stefan.popa@analog.com>
---
Changes in v2:
	- Added information regarding the simultaneous sampling of the SYNC-IN pin
	- Added the reset-gpios in the binding.

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

