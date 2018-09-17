Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68F8AECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:16:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09153214AB
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:16:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="ob4fc2XC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09153214AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730351AbeIQIbg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:31:36 -0400
Received: from mail-by2nam01on0133.outbound.protection.outlook.com ([104.47.34.133]:45216
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728488AbeIQIbg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:31:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tvIFs2spoWX7bXOjDO0WmK7nVgMxMC23erv7aR3y1Kc=;
 b=ob4fc2XCNK1Jbv6cwHi1BBPQuGGhy4zRaGuEjZchViC5HS45Vycgh727QVVJkaz1vW5vDbfEpzeDpgjwfodjBs/JAXPwrPESsEhS1y695XJGM1mCppq5fLEmIqLfOLbNohLABpzSbJmtm+1/vEW2q1DocHP7hgf15Ycl5a1ojmI=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0757.namprd21.prod.outlook.com (10.173.192.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.1164.6; Mon, 17 Sep 2018 03:06:18 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:06:18 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Javier Martinez Canillas <javierm@redhat.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.9 34/57] media: omap3isp: zero-initialize the isp
 cam_xclk{a,b} initial data
Thread-Topic: [PATCH AUTOSEL 4.9 34/57] media: omap3isp: zero-initialize the
 isp cam_xclk{a,b} initial data
Thread-Index: AQHUTjMXofkht4WAqECNE+FVhsvBFg==
Date:   Mon, 17 Sep 2018 03:04:04 +0000
Message-ID: <20180917030340.378-34-alexander.levin@microsoft.com>
References: <20180917030340.378-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030340.378-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0757;6:fMzF+RAWfTQs8gjABD+Vu8j+c+LyJWL5VlDQhZ52MXGb3HOjME1iHszddKbUya7xtZIZMdLTcrEMXHQDrnQQz9CkI+S94s1tBisbIn9C/lFlE63N4VGjagCuxnzKWcWH7jOTrQ7DII5CC7HFU6d8pg1FsZtcJTjyr7NDGXN4x6Ig0mnMInOeeHhU9KnxD/I923K1CVbVrcpNiTakOmmdeyruaGIGtmjQqE8O2ymE21tu2YEGOI5xEeDt67hMhaL99+sMEk41hxpGvOW2WN0+JXj0tGyBCzEI+lD76tECTHuobJHjEtotml8sXOoTWMMUknwVovYhFvTn6BKbH2yCFyyZfoTxvCjBZUDaRR/Q5v7o04bqN4lZYR3VUZQo6ZRxCqjEU7Q+eD5p3DqKC+ntU7UsQj+hC3yCND6NAIPm80pzIXWoXTcISfJlXTu5BlvjvMDEQRSVnIKtOI0de6DrCQ==;5:iKySDOQ7quE0Y47eyuCB5KbMVj1xYExaOlcRPUaLpR1MUYnM/ZoeHsvCsLpqZ7Y1CUi4GbIIDQ3Ozwbg3y/R6TWqwjxo19K82G3AsvLKCHqTiATEb+QjEJDNE/zFNGKzM/pSxLsmORr8A4tXaOPVufF+6njXYZPalQcHyofaqtg=;7:NyDkXzF6zbZpPxCSA00/FS4mUQYJwjPXMlDOvjE+PkPRN5Wdzq8mEIppCrw1R0sSzGZkR/IGfUjAzAPGuAU+ClP6xkdwm2Nnb+hJWr1Qd5B4wqNvs1mdPchrumF0j/1oa7EwO0wZ4vphF0rLFtF7EwpS1iiDTve6sSfFUcEtlxhkcuFUv0JWhPvjpGZtu2cXhzMrvKsIAefYPMVw+RQGUTI7So+i/50MW0fQLlT0LZiXiOo9nA7kEH8xHmTzZrel
x-ms-office365-filtering-correlation-id: c5c63747-24f6-4af3-8e1b-08d61c4a89f4
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0757;
x-ms-traffictypediagnostic: CY4PR21MB0757:
x-microsoft-antispam-prvs: <CY4PR21MB075746FBE2E172D96B6BBD72FB1E0@CY4PR21MB0757.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(228905959029699)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231355)(944501410)(52105095)(2018427008)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0757;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0757;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(136003)(366004)(346002)(376002)(396003)(189003)(199004)(8936002)(68736007)(476003)(10290500003)(446003)(53936002)(11346002)(6512007)(486006)(86612001)(6436002)(1076002)(256004)(6486002)(2616005)(14444005)(81156014)(81166006)(7736002)(8676002)(217873002)(478600001)(305945005)(3846002)(6116002)(86362001)(4326008)(106356001)(66066001)(186003)(36756003)(99286004)(76176011)(102836004)(107886003)(26005)(2906002)(5660300001)(110136005)(54906003)(10090500001)(22452003)(72206003)(2900100001)(316002)(14454004)(97736004)(105586002)(6506007)(25786009)(6346003)(6666003)(5250100002)(2501003)(32563001)(142933001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0757;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: xO0VWJHQ7lZ4nSk5E3avjDe2ooYaokUiGrcJ5WyMirosFu1I4mkQDa76CK05XrWQIrYiXnL++0CtpinC20beZkY4jYZg7MiGs8nM2pHxZducLh96TY1qqye7nLkbWZf2x64/qRNDIzTnxS827rVZwkoKEuWK3JOP1DhbLX1bAz/3ef8U6YQf3EjgU+Tl8rfsoufc9k+TlCwiE0AFgEbeDVSQAOp+h0fZ9zI1J8WBdDUcIpN87+MnMFPCJKhEjujg3qV1NPU/HF1cazrO2qfTGFrUlZ0hXRkJJ3l3gQoDWcxp1EFdloG+8CYu+Mdd24Gl3VEdUHMYIAIk6Sl9F+rer5oYP3xo9Irwi9gULV60IaU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5c63747-24f6-4af3-8e1b-08d61c4a89f4
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:04:04.1959
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0757
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
index 15a86bb4e61c..1e98b4845ea1 100644
--- a/drivers/media/platform/omap3isp/isp.c
+++ b/drivers/media/platform/omap3isp/isp.c
@@ -304,7 +304,7 @@ static struct clk *isp_xclk_src_get(struct of_phandle_a=
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
