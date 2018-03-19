Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3827928-1521495136-2-12047692428819790654
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521495135; b=kK7j68b+m8IjAnw7NybWc1Wku6mTJa16nF63+j9MC+cb2W1
    G+XOk82hKiGjYox9G0s8sHfQ0Hthhp6G9QaMufRZQ1Vv/wj5Q+skzRxcWAqZKYZE
    5iUi8ciCdjUXVItwUZXavDHHV0v+3yH2av1NAQ6YnWmFO4WT6KD3cMSBAl5Ygxsg
    cER7sJMyWRlFsPYhYx5hJUQHX9zbrAJDU2tpSqVx6kYW7FisKDP6hw5e+CA+vzO9
    likmOwplA7jOAJ1mXWS3x6Vxdjo77Q9GVrJ4SpugboixA6Ay0v7QHlWBrcnsUXX0
    BDdNlbQpaqhaUCynrMcDQY4vz8KW0G+z/siEVdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521495135; bh=ZtaDCe
    DfwdZo87OJiQz5yiI9/Sr171s3yRJyGhMw4bs=; b=JPtwdub1EdjTtJa+/jQ5IJ
    ZAnWP+P4Xgc7qsyTveQng+Q1Wt4ey7ZaHoXr2FFaUq9oMMkEagh/cENELO3CXCIo
    DWjOSeUIqZOXXbuYmLQN2HBU57RPr13EBAEp+5vFTxna6QaXtydwO/K5GT6LIlOx
    ACGMFy0D2VwvWC7jQR3wOIhnSHDLlj+UnYzzFB3gqnQysTr9Ql7eFXLv/XnuM+ig
    1Oc7nKN+M+keCb7hZr+vTAo4PYeNHX+P0U48EWE/MdB0mwpRUWcWqreDNxdSAU4L
    fXRoRFgGWL+ISQajT1TSYebGTayDCYkOKUrUPv9GSiGoeDR2nSghTUpMxLfD9T7Q
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=GAnupO3K x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduheduucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeekkeegtdenucevlhhushhtvghrufhiiigvpeefge;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=GAnupO3K x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduheduucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeekkeegtdenucevlhhushhtvghrufhiiigvpeefge;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S971360AbeCSVcK (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 17:32:10 -0400
Received: from mail-sn1nam02on0102.outbound.protection.outlook.com ([104.47.36.102]:56553
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965201AbeCSP77 (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 11:59:59 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Petr Cvek <petr.cvek@tul.cz>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 067/281] [media] pxa_camera: fix module remove
 codepath for v4l2 clock
Thread-Topic: [PATCH AUTOSEL for 4.9 067/281] [media] pxa_camera: fix module
 remove codepath for v4l2 clock
Thread-Index: AQHTv5s2RdMN5Kn5fUiPXx99lnOlTA==
Date: Mon, 19 Mar 2018 15:59:08 +0000
Message-ID: <20180319155742.13731-67-alexander.levin@microsoft.com>
References: <20180319155742.13731-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155742.13731-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0984;7:S9dghThtogOmmEVL9vNf9tsH2j7hoO1VZgt1g3xKJwoLdQdkMQGEPUYKyuWT1EfE/m/gNmifMz05L1KQ7kzKBiBQqcUpE0ZX9T83WEJLzOJdLBZR/pVTqnQSjuxfiy9obY9PQQDNW5JxL0xMMToi3vKzDyNe2k1Tavs79JoQdb+3mGPR8xg9m2JV8GJDD9jI2IQrr8v1OKLKavDpKgwcG9EqSdzQ+Dhr/al31cFjdBRpZdYI+3cLVj+SOh+fbfeL;20:Oup87yuhYOcMkLJNM/T/Ex3lonmENjpkMCatnr3LZwv/CFA8h1gTeBc8EWMYUbPfL5wPWNghjnMb9IfCalLwCmQzlqmzErMGUCybPb4qwwnX11BKDTA0NolbxJkdUWGo1O/U8r0RE3dl6miWSW6Kf6h3Uw8yOso3my+ogpKoFpg=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1fdba27d-b95c-4cc8-8a81-08d58db2769c
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0984;
x-ms-traffictypediagnostic: DM5PR2101MB0984:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB09846F32E0708FBC1CA1F0E2FBD40@DM5PR2101MB0984.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(191636701735510)(89211679590171)(95692535739014)(17755550239193);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0984;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0984;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(366004)(39860400002)(39380400002)(396003)(189003)(199004)(6116002)(25786009)(6486002)(97736004)(1076002)(4326008)(2950100002)(6666003)(66066001)(3846002)(36756003)(81166006)(8676002)(6436002)(106356001)(8936002)(81156014)(2900100001)(105586002)(5250100002)(2501003)(305945005)(7736002)(10090500001)(5660300001)(14454004)(54906003)(68736007)(99286004)(26005)(186003)(6506007)(3280700002)(478600001)(3660700001)(86362001)(107886003)(10290500003)(6512007)(86612001)(72206003)(53936002)(76176011)(316002)(22452003)(102836004)(110136005)(2906002)(59450400001)(22906009)(217873001)(15866825006);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0984;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: dpa9Mzp/B747mGgTAMgB29/pLu3DyKHlvYmwBbwSJWVlgrWwA8GGbohkrvBdMvOwiSxF1uNnQE5AEAD3/U8nY9T7ct+s9fmg8FD9f/HSmsL4Di+cMk2uU+K/EhUZul2ksmZoy1cHQ6qlH+TSEy6zpGc2PRrT0cRc1hTxcoNEp0ecDP5L3WBLsQkLL7iM8Zde/1i268/Xn7FGDVVMkA/dVvX6tq00QdgT3wE77GVTMARKNAHdTkXw6Z9Y8EVRarHB1qDfuFpUSLAuCiH7Ycd2m7XILP8p/BBPoz6Cb6qMnJ6H36hRKRGhTl7td+p6Jhi5j1C1WAXr+HnMYYWBktkTLg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fdba27d-b95c-4cc8-8a81-08d58db2769c
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:59:08.2210
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0984
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Petr Cvek <petr.cvek@tul.cz>

[ Upstream commit e3b4d10cc057522353c4a02f2f90dca6a52e006f ]

The conversion from soc_camera omitted a correct handling of the clock
gating for a sensor. When the pxa_camera driver module was removed it
tried to unregister clk, but this caused a similar warning:

  WARNING: CPU: 0 PID: 6740 at drivers/media/v4l2-core/v4l2-clk.c:278
  v4l2_clk_unregister(): Refusing to unregister ref-counted 0-0030 clock!

The clock was at time still refcounted by the sensor driver. Before
the removing of the pxa_camera the clock must be dropped by the sensor
driver. This should be triggered by v4l2_async_notifier_unregister() call
which removes sensor driver module too, calls unbind() function and then
tries to probe sensor driver again. Inside unbind() we can safely
unregister the v4l2 clock as the sensor driver got removed. The original
v4l2_clk_unregister() should be put inside test as the clock can be
already unregistered from unbind(). If there was not any bound sensor
the clock is still present.

The codepath is practically a copy from the old soc_camera. The bug was
tested with a pxa_camera+ov9640 combination during the conversion
of the ov9640 from the soc_camera.

Signed-off-by: Petr Cvek <petr.cvek@tul.cz>
Tested-by: Robert Jarzmik <robert.jarzmik@free.fr>
Signed-off-by: Hans Verkuil <hans.verkuil@cisco.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/media/platform/pxa_camera.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/pxa_camera.c b/drivers/media/platform/p=
xa_camera.c
index c12209c701d3..390d708c807a 100644
--- a/drivers/media/platform/pxa_camera.c
+++ b/drivers/media/platform/pxa_camera.c
@@ -2169,6 +2169,12 @@ static void pxa_camera_sensor_unbind(struct v4l2_asy=
nc_notifier *notifier,
 	pxa_dma_stop_channels(pcdev);
=20
 	pxa_camera_destroy_formats(pcdev);
+
+	if (pcdev->mclk_clk) {
+		v4l2_clk_unregister(pcdev->mclk_clk);
+		pcdev->mclk_clk =3D NULL;
+	}
+
 	video_unregister_device(&pcdev->vdev);
 	pcdev->sensor =3D NULL;
=20
@@ -2495,7 +2501,13 @@ static int pxa_camera_remove(struct platform_device =
*pdev)
 	dma_release_channel(pcdev->dma_chans[1]);
 	dma_release_channel(pcdev->dma_chans[2]);
=20
-	v4l2_clk_unregister(pcdev->mclk_clk);
+	v4l2_async_notifier_unregister(&pcdev->notifier);
+
+	if (pcdev->mclk_clk) {
+		v4l2_clk_unregister(pcdev->mclk_clk);
+		pcdev->mclk_clk =3D NULL;
+	}
+
 	v4l2_device_unregister(&pcdev->v4l2_dev);
=20
 	dev_info(&pdev->dev, "PXA Camera driver unloaded\n");
--=20
2.14.1
