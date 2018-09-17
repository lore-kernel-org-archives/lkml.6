Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29B44ECE562
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:32:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97B58208AE
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:32:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="GcGYX4k1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97B58208AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729364AbeIQI5l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:57:41 -0400
Received: from mail-by2nam03on0112.outbound.protection.outlook.com ([104.47.42.112]:14944
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728618AbeIQI1V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:27:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O6K8H0ldo71XTgR25aweySRqbqyL8vt5d3HVpHZy+Pw=;
 b=GcGYX4k14t5+y16k18DnCAbYYHoXSr9GorMU9XqzO05FgApwajNXwzKTq+lcW8dC6pndjoIsA6P8qGduL5Cb2mKoxlizbmQFZeiypHufhWAeAFrUZERRfkiijMlzjOU6FkxyJNhVgcKp0n1Afez+64gtucR9Udnya5dfaMqGH1U=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0502.namprd21.prod.outlook.com (10.172.122.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.7; Mon, 17 Sep 2018 03:01:57 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:01:57 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Javier Martinez Canillas <javierm@redhat.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 073/136] media: omap3isp: zero-initialize the isp
 cam_xclk{a,b} initial data
Thread-Topic: [PATCH AUTOSEL 4.18 073/136] media: omap3isp: zero-initialize
 the isp cam_xclk{a,b} initial data
Thread-Index: AQHUTjKobceNUcqU+0+tQbsJUX8zGw==
Date:   Mon, 17 Sep 2018 03:00:57 +0000
Message-ID: <20180917030006.245495-73-alexander.levin@microsoft.com>
References: <20180917030006.245495-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030006.245495-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0502;6:9LszbgavnExTnvh8gKKFmZb+y+FbbdZ8ApLxesgeSTYhsxwhGVV+WymPmYKEVEbKO4qYgXq0UhmBs5MGp2NaWRRWmsQSpLJsit+Uw4+0jlnzcCGEMmXmO0aKZ1o1VQa7pZ1visLIptqtBt3t+1ku6j9UmNJGubXIsMfOgI1bmUMrprMl87Z8cl9Yyweg1BlhqN9N/hburdoEFk1W8x10QZEvT0u2ERcC6Cpta2CWqY/Ki/lCNX0KQ8Hv28906/j40Pzh9LHQsu4k8oiGJVrKKjRZDIg+xqJ47dt/7YwwYXjSO/IwvHG4blxZxRgA7jKmkjtjNd4XgLX5WahvASkh64stFeakFJQWgkJD4bGpcpZrOQ24vAtqtmuYx+XFt9NXCl8M+0hLabXl43pR3u5rIzpyQj2lC2kQLH8yTJNwBzMfjDFYGOXM55/yGY9yLHkFAVv30i0FFEhKJwUG3Z/h+g==;5:ZIq6DMN3Ld2rtXDKlRRPHZCPGeMacasgHvhA5fMSxVWRyGLty8ewjHfjgQXfJYbfYdI5Jz0lPYACktNUPNxk/sUptkC2O24aRXcKeJO/cA6ZgeH7ie5qnRd/Bb+q1gY9ywl5wpdIoAxc7ntiaR7R7p38OOw1tl8nSPkBx2Q4Ky8=;7:l52azGR8F2I+2I2aNCbnkNr6/a/oY0YE6Wr1+eoG/89bDOMFIdZw8wXOLtJhUItPta2YOZM7I1uYdTPg+Iyl/Eo7PfatVPCJIZjAvrsGFafbV2WKR1Slf9e2Lc5GcSp/5HR3oN+xGOqUQS9AhksCmp4AKvF3GTp3RPWBZ0hGtpL4IruvcrDgkOX1GmMWWsqAQu2FYh8G23tN38/BSG87kQQB9G3j50MaBPNVXBv9InjMfVuTP4dFOLm9F7SLYAem
x-ms-office365-filtering-correlation-id: 218fa19c-0b9b-48f7-dcf1-08d61c49ee70
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0502;
x-ms-traffictypediagnostic: CY4PR21MB0502:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0502EBA1787B2056E8C2E674FB1E0@CY4PR21MB0502.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(228905959029699)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(2017102700009)(2017102701064)(6040522)(2401047)(5005006)(8121501046)(2017102702064)(20171027021009)(20171027022009)(20171027023009)(20171027024009)(20171027025009)(20171027026009)(2017102703076)(3002001)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(10201501046)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0502;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0502;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(346002)(136003)(366004)(376002)(189003)(199004)(86362001)(2616005)(99286004)(5660300001)(575784001)(1076002)(6116002)(3846002)(10290500003)(2900100001)(72206003)(68736007)(8676002)(22452003)(26005)(217873002)(86612001)(486006)(76176011)(66066001)(102836004)(2906002)(476003)(14444005)(186003)(256004)(6506007)(446003)(11346002)(36756003)(316002)(5250100002)(6512007)(97736004)(2501003)(107886003)(110136005)(54906003)(6486002)(8936002)(53936002)(81156014)(81166006)(10090500001)(25786009)(305945005)(7736002)(105586002)(106356001)(478600001)(4326008)(14454004)(6436002)(32563001)(142933001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0502;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: YGfA1HQ+b4WxvsQPOrLVqombmKcr03ceSgg8mijK/rjGwV8WiWCql7acJ5QXb64lobehD6a9EzuphIA1gsUdhYnMbrbG04QBEgXBU64KjHhIWJREAYoWbYN7KeBWrOxUfjsN0vdfrzcWo/NnlUnA8AoryF9qVcPuBuMd0hRIQ2bc7mP8TUOERcZOeCLQ/0+KHwc9Mra5qQ+p6TY3PTADT8Uk6xiWnaHf1KbdqLbzW9AQNtMjauskSjSWju2EZYeWrAZRY+INYXvVgqypQ3PYl4Y88Q9vfFVcq0Y/YJIBbJEVBswiAd9/lPQtC7caCLiw0PWmwxEhuf6Ur27aYw8J8yYFa6/74Li7Uu5zKoi9wQ8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 218fa19c-0b9b-48f7-dcf1-08d61c49ee70
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:00:57.7919
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0502
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Javier Martinez Canillas <javierm@redhat.com>

[ Upstream commit 2ec7debd44b49927a6e2861521994cc075a389ed ]

The struct clk_init_data init variable is declared in the isp_xclk_init()
function so is an automatic variable allocated in the stack. But it's not
explicitly zero-initialized, so some init fields are left uninitialized.

This causes the data structure to have undefined values that may confuse
the common clock framework when the clock is registered.

For example, the uninitialized .flags field could have the CLK_IS_CRITICAL
bit set, causing the framework to wrongly prepare the clk on registration.
This leads to the isp_xclk_prepare() callback being called, which in turn
calls to the omap3isp_get() function that increments the isp dev refcount.

Since this omap3isp_get() call is unexpected, this leads to an unbalanced
omap3isp_get() call that prevents the requested IRQ to be later enabled,
due the refcount not being 0 when the correct omap3isp_get() call happens.

Fixes: 9b28ee3c9122 ("[media] omap3isp: Use the common clock framework")

Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/media/platform/omap3isp/isp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/omap3isp/isp.c b/drivers/media/platform=
/omap3isp/isp.c
index f22cf351e3ee..ae0ef8b241a7 100644
--- a/drivers/media/platform/omap3isp/isp.c
+++ b/drivers/media/platform/omap3isp/isp.c
@@ -300,7 +300,7 @@ static struct clk *isp_xclk_src_get(struct of_phandle_a=
rgs *clkspec, void *data)
 static int isp_xclk_init(struct isp_device *isp)
 {
 	struct device_node *np =3D isp->dev->of_node;
-	struct clk_init_data init;
+	struct clk_init_data init =3D { 0 };
 	unsigned int i;
=20
 	for (i =3D 0; i < ARRAY_SIZE(isp->xclks); ++i)
--=20
2.17.1
