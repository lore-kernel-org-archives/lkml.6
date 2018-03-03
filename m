Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1153505-1520116063-2-10817862312656390077
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES enrosk.us-ascii, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520116062; b=TIBRyUfjQm1RGB6Ul9axmP3YCUjqBR95Y/rvicTWrmWwyLD
    PgnFM58x6Iwwl5bSQzeDvET+atRlY9EkhVrE6XGv6cTddCJBFNqvjeLV1r39s2CM
    upbqft2QfiWk+nFfCohqi14SdAdY3nS4Rl4KnZ+r9ch7j5uexrHcec87zZWwJQ4m
    Ffdbj5im8N3twtRgw8xM/h+/C5luemfg59AYdd4irtsW9SmpRpBVc8zDMLkKJZaQ
    sNPCGbMCCKLIi9XIiIoCvt1ETJxpxGsJrFRbnaRpffBHOPPWhGJP3mLmNVDKdYkf
    4Tqjn0YuUfLHxD8c46x5eE6oScdDbOl0wNgUk5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520116062; bh=SV+Phq
    lwDf/HXxAXOcKxD5YZSnKurtTgcD32Z721Nkk=; b=ajO+Vz+uTxVxu6cuG/+4k9
    mhJnA4s6xO8vpRJbBcStURHUYZUZyXHaq0jF7Pj06vfc1El5MTqpshFIOxnELdat
    jFpXFuqzT0eQjGiOLzQLV+GHI/stTmONE1JegQr7QJZvKa0cvZ4vi19KnHLM/dON
    HgVAIFvsp13YpJ282oa4zX7S47BstpP5yhjwSnN7QkTQ3vTxBNtnxuhadOdYebda
    nWJnc06sMg04uwja+HOJrN5FEP/TNzdLCqLjiVCgDj/eQnRgMAQj4hEPIr1B8u59
    yb8yCGmgRZVl3NKziyzacORRopE1PTCHmskoRIXbdbX4mdDKvW9MnZHJ6OCAUosQ
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Jw671fXP x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Jw671fXP x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932639AbeCCW0Y (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 17:26:24 -0500
Received: from mail-sn1nam01on0131.outbound.protection.outlook.com ([104.47.32.131]:14704
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932649AbeCCW0T (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:26:19 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Vinod Koul <vinod.koul@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 052/102] dmaengine: bcm2835-dma: Use
 vchan_terminate_vdesc() instead of desc_free
Thread-Topic: [PATCH AUTOSEL for 4.15 052/102] dmaengine: bcm2835-dma: Use
 vchan_terminate_vdesc() instead of desc_free
Thread-Index: AQHTsz5rUoHLTxlPTE6HwSm5kORZYQ==
Date: Sat, 3 Mar 2018 22:24:39 +0000
Message-ID: <20180303222318.26006-52-alexander.levin@microsoft.com>
References: <20180303222318.26006-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222318.26006-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB0970;7:wLD2ycuaEmYB/sP9FfyUCl34AwdZPj8o1wApZcssVFxC4BsXoYgkNqrM2tQZleGbYtROSUjm7Gg2pI5O8sJimxM2wEK+F3OlL485HBkLAbxhxLD7qcePyJfmPfmi823hGbFZfmwKyPpvv57+5QCCIq0YLBl5ZRNVwrisP/yyG+4I0XWCji+sog5YaTFp981IHpCKkKhUGPshhNDRzUV15Mge0z+nozqvvKhRelwY6CrY4LYaLPqDI8JO/Zsfu/kz
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d0cfe6e2-f305-4225-2e3a-08d58155c492
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2PR2101MB0970;
x-ms-traffictypediagnostic: MW2PR2101MB0970:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB097036188B024B24426285BFFBC40@MW2PR2101MB0970.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(31051911155226)(89211679590171)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231220)(944501244)(52105095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123558120)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR2101MB0970;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB0970;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(366004)(39380400002)(376002)(396003)(199004)(189003)(3660700001)(10290500003)(2950100002)(3846002)(2900100001)(22452003)(10090500001)(86612001)(6116002)(6666003)(68736007)(105586002)(5660300001)(5250100002)(106356001)(97736004)(2501003)(66066001)(8936002)(1076002)(99286004)(2906002)(36756003)(86362001)(14454004)(6506007)(110136005)(4326008)(102836004)(6512007)(81156014)(305945005)(81166006)(7736002)(8676002)(53936002)(72206003)(59450400001)(6436002)(316002)(478600001)(76176011)(25786009)(6486002)(26005)(54906003)(3280700002)(186003)(107886003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB0970;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: DIUqhvI1YooE5izRtNBe13H2kJ4ILVe6Qs7IZ1IaTxtJspLGGItWFQAcsBQwLdniSGRMoeT30vE+RRll8lEIIMziwPvqHlp9tFB02Ceaa5CpgGN1JoywBfbQXdmty2zKymwLqHrtZ4jWqmN+AXxYUFUH+VikG8SwbxgiMGV5/Dc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0cfe6e2-f305-4225-2e3a-08d58155c492
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:24:39.1034
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB0970
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
