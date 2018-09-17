Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11BCAECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:04:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1AED2147A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:04:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Gn6IkQul"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1AED2147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730354AbeIQI3t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:29:49 -0400
Received: from mail-dm3nam03on0109.outbound.protection.outlook.com ([104.47.41.109]:36496
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729112AbeIQI3r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:29:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h1IofWxk75n/9iJLzwOYjPjNAz6hEjWB6GLfbRe0wgY=;
 b=Gn6IkQulKm9f3CAawbmk/MmodeUM9XAKsXGpU0v5W9mXSxltqTaQpGmwmqxj6LpmniO6crrrKPs2zgi6+wvPNDUgR13M7nU7VFX9OZCXt2W9M4l3yqjs+3FDZAnwUATg/giC0CcFvmlBJBWmwUZJn5NqrcnnPUe9VPSKWRUIhFE=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0774.namprd21.prod.outlook.com (10.173.192.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.5; Mon, 17 Sep 2018 03:04:22 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:04:21 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Javier Martinez Canillas <javierm@redhat.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 55/87] media: omap3isp: zero-initialize the isp
 cam_xclk{a,b} initial data
Thread-Topic: [PATCH AUTOSEL 4.14 55/87] media: omap3isp: zero-initialize the
 isp cam_xclk{a,b} initial data
Thread-Index: AQHUTjLwC/ecDOhSxkiF8hkl/snYvQ==
Date:   Mon, 17 Sep 2018 03:02:58 +0000
Message-ID: <20180917030220.245686-55-alexander.levin@microsoft.com>
References: <20180917030220.245686-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030220.245686-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0774;6:0UZ+Eogx3Hr1PgUSy/IOu0tB3hkVqzRlk3u5sCkLZ/zucD1G/d8Dipgugb8EsUSBFnLTm65gLr6OOYUKhQBZltsoRWtM5uE2/k07Qsw/7MOshUGHZ8VSZg5YNngXZC7KOopUfqtKuA6pqGFrujpjbCIVrHI0WhCmCjc14RitEdeQ10+gFNQIUUkyGUN1q+nTlItPAH8lc+05k0/ha4ddaPVXj7xRFzP1zjgCqgs+vhEhz2g7uzrVnHybT9vx7RRi2tKeqtfVBu4pp+oavYbK3G2rsqq25g8Pft9EcUd7xGsVoQA3u+T3bx7evknd/h9RVhfIPwJeFABbfexP4aDV52ic1YMaSQFXx3Zjf4lFkA7ziHPkMFYTNCLBuSr3vpTjj03fKIsTF67hOLQEq13l4SGPQjasEUqdBiz0skj7YsRq+rKRAIOPwTlor3EpMujVDawr8GNv9uP/yk3jeemOmw==;5:FL20z2smAY1TZEXSrjpo/QZg40s4KxGAToXMKlIWqfPZoI4wuSLckHMmRX5BYS6YOWxQLKorTjaji7Wg/jizyxSuxYaGWhyV8Q6Y+nzNw++OHjMCuAx56TNlbxuygzYoITYkXKS7vCCz5fPzoEoVtNIbXLEvAew7ak3JKJ4is3s=;7:DiCEm04Az60fDOshgqRws2IppA4n97h/kkqrdRSfOXUfRZJ/bnRtc2Tn1eTRc0+iSV/xriYtqdb3R07SIFRMgh8etKeHrnBkS+gGkfTw3+Oi+wVf/qUaIsdHGoV+ha8Qbp5kn52IfPiCwsw314zLVRx4nXee0B3pk59GNuq3V8UqCqchHBT0x9zlPNcZffwri0Rixr987ZE3ZZ3FY11YJq+lrYepvR1LVRyBSYW4uoZQ3bY86HAo4sHGPhLWF0On
x-ms-office365-filtering-correlation-id: a3078d5f-ce08-4bc1-e6b9-08d61c4a4461
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0774;
x-ms-traffictypediagnostic: CY4PR21MB0774:
x-microsoft-antispam-prvs: <CY4PR21MB0774EAE2208447BB1A708198FB1E0@CY4PR21MB0774.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(228905959029699)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0774;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0774;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(376002)(396003)(39860400002)(346002)(199004)(189003)(54906003)(105586002)(316002)(4326008)(6116002)(1076002)(14454004)(305945005)(7736002)(22452003)(81156014)(66066001)(81166006)(99286004)(8936002)(8676002)(3846002)(478600001)(72206003)(53936002)(10290500003)(68736007)(106356001)(6512007)(25786009)(76176011)(110136005)(11346002)(476003)(2616005)(446003)(6436002)(486006)(6506007)(86612001)(10090500001)(102836004)(86362001)(6346003)(186003)(26005)(36756003)(97736004)(2906002)(256004)(14444005)(2900100001)(6486002)(217873002)(107886003)(2501003)(6666003)(5250100002)(5660300001)(142933001)(32563001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0774;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: XMfy9VRfT/AC4yu5SBfMDH1eJ4I+48guN2h3UvXweZoDMofy5LqZYkhvBWEBqCWxNxo21YAz9NeWzGavfZOIceAG2xKSHbKakWAH+qpf8O0kMDBz5GCjRMwo1PwN1TLgWeOKYxyCMLQDPjDAQHcXaL9mVswo8iMHk+86JTMZy5WcpNBdUtcndmccxA2vuo2lBvynyQjFCjbK7ZLXfNgsbR25nyIHHs1wdYlTywzSedrq4hIixBvRW5loCWaiYWkfyOw9VEtKKlfjhkwp6AX5JkTWWXcFR++D3l1uXqiVkVS7SqiuYVeZi3LASceZFQ7LrwzZshNOF4zJmZsB+soAyoEMkyC88FyAin+Q/jCcWGs=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3078d5f-ce08-4bc1-e6b9-08d61c4a4461
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:02:58.7592
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0774
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
index 9f023bc6e1b7..6e6e978263b0 100644
--- a/drivers/media/platform/omap3isp/isp.c
+++ b/drivers/media/platform/omap3isp/isp.c
@@ -305,7 +305,7 @@ static struct clk *isp_xclk_src_get(struct of_phandle_a=
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
