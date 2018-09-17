Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01781ECE562
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:12:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F54B20693
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:12:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="E4HgLuNB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F54B20693
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731247AbeIQIce (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:32:34 -0400
Received: from mail-by2nam01on0104.outbound.protection.outlook.com ([104.47.34.104]:36220
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731213AbeIQIce (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:32:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vGyrQj5rCNAmgjTFal3+EGc3IJleKz6nbI2HuR4U7LQ=;
 b=E4HgLuNBsZNSzkOpUy7QBjyFYofFQ6g2ABk1KmYDnQuOX7QWF+0tC/CRKz3FGQlHHeggoeQHuNH1xPrbAx6wwfGzpG+q7yWNj++Ynj1oMQWqRdICfN+DvyldCSqC9cxb4Mh0MjhJjCML1aOceLKFw/09CRbqjXZYtdPArisaUGc=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0759.namprd21.prod.outlook.com (10.173.192.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.1164.5; Mon, 17 Sep 2018 03:07:11 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:07:11 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Javier Martinez Canillas <javierm@redhat.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.4 27/43] media: omap3isp: zero-initialize the isp
 cam_xclk{a,b} initial data
Thread-Topic: [PATCH AUTOSEL 4.4 27/43] media: omap3isp: zero-initialize the
 isp cam_xclk{a,b} initial data
Thread-Index: AQHUTjM8Mr+PtyZgOU+ZQxMVEt4Fiw==
Date:   Mon, 17 Sep 2018 03:05:06 +0000
Message-ID: <20180917030445.484-27-alexander.levin@microsoft.com>
References: <20180917030445.484-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030445.484-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0759;6:147NXhBiO0/a+H1vOaJFs1BENus46xpEDsV95fqerHvghGKRjsE87ndAdBMEiR7+GAbvA5pAMnJdExbpAAeC18prLPnprxaoniUs1kDECfHObi/2t5zjhU0+ojuT/cwcvxgDyY4P3VArGTYmvKj7FTlsNO0Z4rvF4/V9aAKTzMAMnXunl8E4y4kE/QFHtiZEa6fKSTBAKQvjZOZEEfH5LCnC1MAjppNjWWTes4PKvnZlQAPWx1rqX3dU/C4yMbLPOen3pnFueoJkHzPz2AYJn5tNJ8RVmGDSkNZov1wqdzJXNB1jXrXD59Rls3bZL/5kcdyNfqX0EvA8XrDw6FeG3KCoU37+oepW/qTAMfDler6Vpz8EAS3AawX8n5zo2DODHz8lLy6Y6UfrLOzwQVmJ7o3e3sTkJsXSKAq7i7TEKXGcUxWSxip/sLDevItyB5RASj//dHNHnCTq0+9rd5DleQ==;5:5LjWJy7ev8ABf/P2gbAhrhkfnncIBkU5IFv9WZB15OHjzbXjN//JIpieZITlUzpmTI1TpzPBV8Z891U3elZRjr3OMKiCksD4EHwFbX9LP5l+kZ0LSFGYnMVNvmujALk7WbIWpBmyZF8S9dlUeigMYb2+mDk+A52wvhKGxBdirUU=;7:oAdNKxO3fAGrfgSqWX0WTCgRNLJ4wURKvz7apHaDK84MQcglhYzBSeTKA4a3gkMSlwofM/mG52qhtysnyrhFKac58xXcrgMEYijvkZxnG/x+liWS+2nQAiouTL6JmJUBqO23MMw8OocARwOntByAb1C6aM2NVRiMQjyRiwQoLXdU7v3X2tCZRyKOMcu/2f0boCgDwfzupG808TVK1jX5yAMaixJZvMbKIUtwUYfXmnSfRkq8Gk+3MpvCQKTeQsFC
x-ms-office365-filtering-correlation-id: 154185f2-89c2-478d-b9f4-08d61c4aa97f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0759;
x-ms-traffictypediagnostic: CY4PR21MB0759:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0759BE96F95CFF180544E358FB1E0@CY4PR21MB0759.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(228905959029699)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231355)(944501410)(52105095)(2018427008)(93006095)(93001095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0759;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0759;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(396003)(136003)(39860400002)(366004)(189003)(199004)(2501003)(2900100001)(305945005)(7736002)(5250100002)(6436002)(5660300001)(53936002)(1076002)(86612001)(6512007)(2906002)(6116002)(3846002)(6666003)(6486002)(86362001)(97736004)(10090500001)(26005)(54906003)(256004)(14444005)(106356001)(102836004)(25786009)(99286004)(105586002)(6506007)(446003)(478600001)(10290500003)(72206003)(11346002)(217873002)(66066001)(68736007)(107886003)(4326008)(76176011)(36756003)(486006)(2616005)(476003)(316002)(14454004)(186003)(110136005)(22452003)(8936002)(8676002)(81166006)(81156014)(142933001)(32563001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0759;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: Oz8U9cQSmL3xZJHQsXk5nRhRWMi2JRaZN/YhZI8wdkRQAGHGU0n/44suhoGLs73O+xVtmu65l3NlnMN1vZT8FfPpFcjjZ3jmlUX/PMGZ1MsogxzfkP7+a/Ck3JdA460g8CPbVXQq094K5yXYsqSkS+ENRroHqS4xeR1pBuLtZEjkiA6oODK0vF5OIdJIiNJdXDl5S9qIRdMvMqeBfvIweoNtVpORSBQCDjN+neu1MEdQEjq4HTxYmwQ5Agp9IdLGHjBYUfBO42iSuaDf17djSRHUyeW4SrLcCxf4Fe071JJ5gAUrU2zN0sUoG8nuWpcQCyL7E9IH5wI8+Az4WVT0SK9wc1b2Ova19zkq9iM2a1Y=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 154185f2-89c2-478d-b9f4-08d61c4aa97f
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:05:06.1797
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0759
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
index 91e02c1ff392..136ea1848701 100644
--- a/drivers/media/platform/omap3isp/isp.c
+++ b/drivers/media/platform/omap3isp/isp.c
@@ -303,7 +303,7 @@ static struct clk *isp_xclk_src_get(struct of_phandle_a=
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
