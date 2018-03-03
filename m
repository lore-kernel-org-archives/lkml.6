Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1211789-1520119633-2-6049319166446893736
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES enro, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520119632; b=JbsvjJI7dWJeG5cafTTRw5b8BZ7GFS3jk7ZS3TVlCHQAXJO
    DyDTvZ7vrx562uMB4mHvaj/ntJrduk4aYawg4evLhaYb8GkWENi78TGBmqpOUnMt
    iG5OHoCjLxCPcOxzHbybpEo9EjhE9I4RBfDQWywL7PKqRrjR3C+iUHQe4WjiD34/
    YW3bRd3t+6KUgnS29GupTWySSuA3ZUB2hf2gmvMvB+9f6v5bn0LNBUj0PkGFRojB
    Krntnbz3DJEoaruH6r/wrU48y9GJv60Ts1aQmxl68kGD45FDfxN6KuyT6fxF78XA
    mHoLozuRUEjdqi3q1n/p0toLxyEYiCmMpFOgOtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520119632; bh=SV+Phq
    lwDf/HXxAXOcKxD5YZSnKurtTgcD32Z721Nkk=; b=TNOzYTbvv5n6Gtk0sSr29n
    mbK7RMQGKK0Z3NORBdxfBHbUEQg8MQJ7YbpLfTDSD3pXwuSVFujKCDZnqlozjfuW
    g4r63bZg/QKhLdg/Ho1hMtJujXMhtO+PThjiERAHfhJK6DODXtDlUyf3E1y676qZ
    cNg7KA272aIaTp5HiocMUUcOfv3OI9xay5frM8EDN//1Xn5ovloLwJ7ymiWfVVxi
    6+JhoTp6ZKfHESUplr1+wXhR5NgFyW2DDnfJWBpRFsrFd+nukw2wXYkQH8hBi+Fl
    o8I2WEF7q8/zQ22iE1gEHq5UtlQwhpX6/K9B/G9fsxSGroXEAQ/9Ymh+X/z4+bcw
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=MGRHfkH1 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=MGRHfkH1 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934558AbeCCX1F (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 18:27:05 -0500
Received: from mail-by2nam03on0136.outbound.protection.outlook.com ([104.47.42.136]:28821
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934659AbeCCWhF (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:37:05 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Vinod Koul <vinod.koul@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 195/219] dmaengine: bcm2835-dma: Use
 vchan_terminate_vdesc() instead of desc_free
Thread-Topic: [PATCH AUTOSEL for 4.9 195/219] dmaengine: bcm2835-dma: Use
 vchan_terminate_vdesc() instead of desc_free
Thread-Index: AQHTsz8kfOoU8U92mEK7fnECL2gPNQ==
Date: Sat, 3 Mar 2018 22:29:50 +0000
Message-ID: <20180303222716.26640-195-alexander.levin@microsoft.com>
References: <20180303222716.26640-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222716.26640-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB0969;7:1MhX5aNB5gUX/Ene3txEmnVod/RGu1AUTAVjAlzQ56A4Nt9KYedhJb9Rn+xR53n0tRezAJ0ajuwwa9z2o6uIeYxQHWk85cHBCID0gL0f6/ulVMCooI2MytYRHA6Uz5AUXwdaNqcYN+edbjbBtPY1EZ/rdgDkFY69SduWebGBZ99lkz9bH8/YfJpYbih55jzTO4DXe7WB1knOlY8L1TphsN+cV4gEgLk5PM+r89Ju8d0rDL3Qu3bnXg5MXqmglYxJ
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1fe256ea-4a78-41f1-f897-08d5815741a9
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7193020);SRVR:MW2PR2101MB0969;
x-ms-traffictypediagnostic: MW2PR2101MB0969:
x-microsoft-antispam-prvs: <MW2PR2101MB0969F2E7659C39C2EF8F2663FBC40@MW2PR2101MB0969.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(31051911155226)(89211679590171)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231220)(944501244)(52105095)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR2101MB0969;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB0969;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(39380400002)(366004)(396003)(39860400002)(189003)(199004)(105586002)(5250100002)(53936002)(107886003)(36756003)(6436002)(4326008)(2501003)(6486002)(1076002)(2906002)(6512007)(2900100001)(54906003)(110136005)(305945005)(106356001)(7736002)(316002)(3280700002)(478600001)(14454004)(59450400001)(10290500003)(68736007)(2950100002)(72206003)(3660700001)(66066001)(3846002)(6116002)(102836004)(6506007)(5660300001)(10090500001)(25786009)(186003)(26005)(99286004)(22452003)(81166006)(76176011)(86362001)(81156014)(97736004)(86612001)(8676002)(8936002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB0969;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: aIeMrBrViWRN34PDzUQp7nb0V4pJ6VUAW6MRmRtvYQsGxNrAUlX4EfcZKMRYDlziofvOqLCTQ6pus55sA6c03X2D8XMlsgm6OYHCnDApCuu/wDp2Vi/GIzaBRI+HT7Pl0gDK2WgeUx4yHE/EvKk193Y4AIPMmfJcgMJXglodeDI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fe256ea-4a78-41f1-f897-08d5815741a9
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:29:50.2289
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB0969
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Peter Ujfalusi <peter.ujfalusi@ti.com>

[ Upstream commit de92436ac40ffe9933230aa503e24dbb5ede9201 ]

To avoid race with vchan_complete, use the race free way to terminate
running transfer.

Implement the device_synchronize callback to make sure that the terminated
descriptor is freed.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Acked-by: Eric Anholt <eric@anholt.net>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/dma/bcm2835-dma.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/bcm2835-dma.c b/drivers/dma/bcm2835-dma.c
index 6204cc32d09c..847f84a41a69 100644
--- a/drivers/dma/bcm2835-dma.c
+++ b/drivers/dma/bcm2835-dma.c
@@ -812,7 +812,7 @@ static int bcm2835_dma_terminate_all(struct dma_chan *c=
han)
 	 * c->desc is NULL and exit.)
 	 */
 	if (c->desc) {
-		bcm2835_dma_desc_free(&c->desc->vd);
+		vchan_terminate_vdesc(&c->desc->vd);
 		c->desc =3D NULL;
 		bcm2835_dma_abort(c->chan_base);
=20
@@ -836,6 +836,13 @@ static int bcm2835_dma_terminate_all(struct dma_chan *=
chan)
 	return 0;
 }
=20
+static void bcm2835_dma_synchronize(struct dma_chan *chan)
+{
+	struct bcm2835_chan *c =3D to_bcm2835_dma_chan(chan);
+
+	vchan_synchronize(&c->vc);
+}
+
 static int bcm2835_dma_chan_init(struct bcm2835_dmadev *d, int chan_id,
 				 int irq, unsigned int irq_flags)
 {
@@ -942,6 +949,7 @@ static int bcm2835_dma_probe(struct platform_device *pd=
ev)
 	od->ddev.device_prep_dma_memcpy =3D bcm2835_dma_prep_dma_memcpy;
 	od->ddev.device_config =3D bcm2835_dma_slave_config;
 	od->ddev.device_terminate_all =3D bcm2835_dma_terminate_all;
+	od->ddev.device_synchronize =3D bcm2835_dma_synchronize;
 	od->ddev.src_addr_widths =3D BIT(DMA_SLAVE_BUSWIDTH_4_BYTES);
 	od->ddev.dst_addr_widths =3D BIT(DMA_SLAVE_BUSWIDTH_4_BYTES);
 	od->ddev.directions =3D BIT(DMA_DEV_TO_MEM) | BIT(DMA_MEM_TO_DEV) |
--=20
2.14.1
