Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21EB5C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 02:47:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C602921522
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 02:47:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="WxVyYi4H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C602921522
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387429AbeITI2c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 04:28:32 -0400
Received: from mail-by2nam01on0122.outbound.protection.outlook.com ([104.47.34.122]:34106
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1733294AbeITI2b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 04:28:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=we57RpPKob8XNWkjAb5a35iiIfXMQ5d/lgSox62VeAQ=;
 b=WxVyYi4HKpPhGb163H04WaP9cUFUB0hVzq7ZjgfSRxZsgje6UdWxXhh12MgBcSnztS5xQ7dnqEx3VeD/RPJB3xyl6KmfH4PV3v+ngYzghzAg6zYMn7SQyB4Y37Xpn3xOPNtnGLexLwHIhtigZHQ/QnmaXsJQnzMPhWR18NQfc9k=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0149.namprd21.prod.outlook.com (10.173.189.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.4; Thu, 20 Sep 2018 02:47:27 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.010; Thu, 20 Sep 2018
 02:47:26 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Tony Lindgren <tony@atomide.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 02/56] ARM: OMAP2+: Fix module address for
 modules using mpu_rt_idx
Thread-Topic: [PATCH AUTOSEL 4.18 02/56] ARM: OMAP2+: Fix module address for
 modules using mpu_rt_idx
Thread-Index: AQHUUIxEQUWf67NYkk+3/1FDZsL+Kw==
Date:   Thu, 20 Sep 2018 02:47:26 +0000
Message-ID: <20180920024716.58490-2-alexander.levin@microsoft.com>
References: <20180920024716.58490-1-alexander.levin@microsoft.com>
In-Reply-To: <20180920024716.58490-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0149;6:bpo9nH2Kg34Di3w+ofifLCIdEeQZvC7YZ8Re2niqg/OYQ+5FQcepgMZmfq6ik+226HslsTwCTRwGvEwB/mXc0rugXaD1uCaZi66i48kVTY240j+yAuikpCbX8oBBv0OLqjHgwUhBbqPjnuD6uLXN52q2cygdBersl2cM8KMCWFh/Mu0W85kwXaymu8u6Av5cLylEJaH904iEGvH1SvfRQ0ZSHee1K4Cv7zQPgXzwIHzmR4dLIfpaBAvklpVJ2+nq7sbpHbABSrhLz0ykLqOEDGi4UxbD4gD54lYzJKSp+GB1MmT12jBLwrYKrRDmY3UjZX1yDRfCPb9/emU5KYTVZLROiyAh5hPFxARj2z3Ebwy/QnYjjCF9z4LkxadEOghgJ5ahiQrMm0J4w2BIfmw2dumbHYXzjU6W+n0sJW/LEoSOab+aCuko51/0G4RR98nXSdE60DQY9dGLXVVSLoEhJQ==;5:IS1zKW1rcivg1nqKuU9Mhp6QWnvfy4b/tkHg1khJZFE3jhSGBGqzWtJ07Q5eFAfUk2EMQs7Dc321civWipb44Se+8ZFYIQniRlUo6YmQzQYUg7Oej2SGszZHwn6nnSZBgUqHTzuGox6+994DxtkHxJ8WO7YhQHz3LDcRWfSSKvM=;7:TXXzVF7b4PVlK9G/Gxv5LT52276kNqZwFuYmzZ19hHsX0a6FObn7K9UGBqk9yrzk9EMZpBX47agV+wAqt6YiFl+H3lpz5eLLTSJGtyKuph7PB7UevznkVWQJP/IjqiZr9S48Y9yxiicfEZ9ZB4cQ3sAnefxzqPbQxSO9JSi9PsyORmBKn2uFp2/ErjhXS7UBZar/nHWvt8lHLjyTUsVYlnzTIGoXTbDwvL9jYZuLHJNhtiCjKEbQJ19k2YJCg8bc
x-ms-office365-filtering-correlation-id: 52bffd66-8872-4d2e-f579-08d61ea3669f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0149;
x-ms-traffictypediagnostic: CY4PR21MB0149:
x-microsoft-antispam-prvs: <CY4PR21MB014962746DB258E58152C0BBFB130@CY4PR21MB0149.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(2018427008)(3002001)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0149;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0149;
x-forefront-prvs: 0801F2E62B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(366004)(346002)(376002)(396003)(39860400002)(199004)(189003)(86612001)(7736002)(81156014)(305945005)(10090500001)(81166006)(8676002)(105586002)(106356001)(66066001)(2900100001)(6116002)(3846002)(1076002)(486006)(5660300001)(2616005)(476003)(14454004)(478600001)(72206003)(76176011)(22452003)(6346003)(316002)(99286004)(26005)(186003)(6506007)(102836004)(54906003)(110136005)(446003)(11346002)(4326008)(25786009)(107886003)(36756003)(6436002)(6486002)(86362001)(2501003)(5250100002)(71200400001)(2906002)(71190400001)(68736007)(8936002)(10290500003)(6512007)(217873002)(97736004)(53936002)(256004);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0149;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: v+DXlve/OgH0X5A76xNp0Q5znVyA74Pz4x21VWwCBURFSByu6H6E6PNdWTqSoAp7iY3qnuUfMkNC9rZq7i26jbZA8VJSLgkLl2ij6C6xkEsdBWIvD3y3mPSRI2xCDDWN5NQi3ER1sKZ11dEHoJXMlaGlW7UASeVGAZUTnYR62RDKWNBMI0cf//TDUGFcW2nbBAzLQrFFkdhpjny/8Gb2sYLIL9js+6II1GBtOuX5hYKll5wFroGdKHSmGHof1dYMlwSKvJiHncCWmTyklU9fmLT/WDqy2WTG5CY2yRBEKiIbnf8J9mWGbJ13aInOi3D81EKwuAAuunRfPOdWIXMo0vq6Z9A2t9hp21yFZ7x1o+s=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52bffd66-8872-4d2e-f579-08d61ea3669f
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2018 02:47:26.8359
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0149
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tony Lindgren <tony@atomide.com>

[ Upstream commit 1dbcb97c656eed1a244c960b8b3a469c3d20ce7b ]

If we use device tree data for a module interconnect target we want
to map the control registers from the module start. Legacy hwmod platform
data however is using child IP offsets for cpsw module with mpu_rt_idx.

In cases where we have the interconnect target module already using device
tree data with legacy hwmod platform data still around, the sysc register
area is not adjusted for mpu_rt_idx causing wrong registers being accessed.

Let's fix the issue for mixed dts and platform data mode by ioremapping
the module registers using child IP offset if mpu_rt_idx is set. For
device tree only data there's no reason to use mpu_rt_idx.

Fixes: 6c72b3550672 ("ARM: OMAP2+: Parse module IO range from dts for legac=
y
"ti,hwmods" support")
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/arm/mach-omap2/omap_hwmod.c | 37 ++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hw=
mod.c
index 7f759abcf49c..cd65ea4e9c54 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -2160,6 +2160,37 @@ static int of_dev_hwmod_lookup(struct device_node *n=
p,
 	return -ENODEV;
 }
=20
+/**
+ * omap_hwmod_fix_mpu_rt_idx - fix up mpu_rt_idx register offsets
+ *
+ * @oh: struct omap_hwmod *
+ * @np: struct device_node *
+ *
+ * Fix up module register offsets for modules with mpu_rt_idx.
+ * Only needed for cpsw with interconnect target module defined
+ * in device tree while still using legacy hwmod platform data
+ * for rev, sysc and syss registers.
+ *
+ * Can be removed when all cpsw hwmod platform data has been
+ * dropped.
+ */
+static void omap_hwmod_fix_mpu_rt_idx(struct omap_hwmod *oh,
+				      struct device_node *np,
+				      struct resource *res)
+{
+	struct device_node *child =3D NULL;
+	int error;
+
+	child =3D of_get_next_child(np, child);
+	if (!child)
+		return;
+
+	error =3D of_address_to_resource(child, oh->mpu_rt_idx, res);
+	if (error)
+		pr_err("%s: error mapping mpu_rt_idx: %i\n",
+		       __func__, error);
+}
+
 /**
  * omap_hwmod_parse_module_range - map module IO range from device tree
  * @oh: struct omap_hwmod *
@@ -2222,6 +2253,12 @@ int omap_hwmod_parse_module_range(struct omap_hwmod =
*oh,
 	pr_debug("omap_hwmod: %s %s at 0x%llx size 0x%llx\n",
 		 oh ? oh->name : "", np->name, base, size);
=20
+	if (oh && oh->mpu_rt_idx) {
+		omap_hwmod_fix_mpu_rt_idx(oh, np, res);
+
+		return 0;
+	}
+
 	res->start =3D base;
 	res->end =3D base + size - 1;
 	res->flags =3D IORESOURCE_MEM;
--=20
2.17.1
