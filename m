Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1312649-1520122858-2-7426698311900366363
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520122857; b=fhRRDh2/jYSUYLp6g8V2zwWBxzy57kV2ZgQg+7YyRA2ZR78
    E9ZtFd8VK/FHxiF/07fLHa4vPcNVLey9jS1/rTcSi2aalTuF7V+DqZ3EvVT3ugTC
    7YXexk+aA0W6SJUFLgkoY8lM+/7437LbbsqTva1r6KgMGQJuEsegyrtTRORHMaVY
    RB6HpY29TbePxoHvBWyGFR/IJOXwmealHCV++IKBaBDOE975GCrPJWkhcl5WpX5D
    3x/1iEeBImizpMymX9TGTPeQXs8KDfzP9z7VLQaqtiAljEB88G4vPn+gai268aUg
    /3wqxaKRXDb3sa4gLMVThGueHFTWCcmQsxZDxIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520122857; bh=j+ULWd
    GaJEqzYPoj0LYdLiNXXGYmQuJQ2kxgbZYLJS0=; b=VFpVX6MiNYYkc04ZEmiotc
    5anxr1Nhndkf2bXkUB5DhxeznrGZWAISXvE8tE+MmSLb5Fs/K7u/Z5O8B3t39FrF
    3mQHZyLxDNM0iCz41Fk6RC+S+2sr5r2Zy8ErCepfArUjAIKuotUhCZ3QF6tQcoVH
    8+UakWrvUJOigLpijwg9L+0XWXUFrd15CHrX7SfzyvHO5jNglFV9fSoCrOT4MeuR
    urm/Yx/LDcEuHwaJ/zTourRoKNoHdFn5k2vhaMMMsCM4pQw63xYtqw5Q2cLPXqM8
    z5eOY7w+JCP09kfO3PbhbAAYqbOmIoPh+zWhs82nKRYL/Ye4X4ijjd3OFPw3lMKw
    ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=iIas9FMO x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=iIas9FMO x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932970AbeCDAUW (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 19:20:22 -0500
Received: from mail-sn1nam01on0126.outbound.protection.outlook.com ([104.47.32.126]:12224
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932830AbeCCW3I (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:29:08 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Vinod Koul <vinod.koul@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 41/84] dmaengine: amba-pl08x: Use
 vchan_terminate_vdesc() instead of desc_free
Thread-Topic: [PATCH AUTOSEL for 4.14 41/84] dmaengine: amba-pl08x: Use
 vchan_terminate_vdesc() instead of desc_free
Thread-Index: AQHTsz6pSbwU0JLV5E6NB1UC0GWY2A==
Date: Sat, 3 Mar 2018 22:26:23 +0000
Message-ID: <20180303222518.26271-41-alexander.levin@microsoft.com>
References: <20180303222518.26271-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222518.26271-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB0970;7:tyxUBzz0xWUNpcaZMRF/ojkvU8yWYAbFTvFSi2tExQg5m5YY00DwF08DSW6xqZSrkErTe5sCnaJ/r0+tMCqebcgNybpw2YHg72CB6khs1tGjRBnc2at3K9TFuyVLvaP1yLVRL0YN6o6JT9Y2/hS1/7PXkTkvkhp9gqjuaBsH7R1yknn0c3WeMPGct9km44YxTXkZduDUBeIc7BMxoEdfiUbSbE0LhKg12oMRWOt9M8u1ZFcLXm4big8dJ6+99a1q
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: cfef9354-4ca9-41b5-921f-08d581562cb8
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2PR2101MB0970;
x-ms-traffictypediagnostic: MW2PR2101MB0970:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB097090C700B151A07C6EC8E5FBC40@MW2PR2101MB0970.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(31051911155226)(89211679590171)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231220)(944501244)(52105095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123558120)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR2101MB0970;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB0970;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(39380400002)(366004)(396003)(39860400002)(346002)(199004)(189003)(575784001)(86362001)(110136005)(4326008)(6506007)(14454004)(99286004)(8936002)(1076002)(36756003)(2906002)(102836004)(76176011)(25786009)(6486002)(316002)(478600001)(3280700002)(107886003)(186003)(54906003)(26005)(81166006)(7736002)(8676002)(6512007)(81156014)(305945005)(72206003)(59450400001)(6436002)(53936002)(6116002)(6666003)(86612001)(68736007)(3846002)(2950100002)(3660700001)(10290500003)(22452003)(10090500001)(2900100001)(106356001)(2501003)(66066001)(97736004)(5660300001)(5250100002)(105586002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB0970;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: mBVylMdmHodCi5+8pIYwWplgTDlhXG8wc772Kb+fLPylD8zybYtR2tXF5w1Gc+sTbx+mSiskwVUGVdW8tvH2lJ8lp3wAgnml0QWzQAFvCRLgpYKR0p8ArYx8jZVI5x0+MaxEJP7oGoeO9Ooh49IuQnLFyqb0syzpg0McmFOcJIM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfef9354-4ca9-41b5-921f-08d581562cb8
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:26:23.6348
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

[ Upstream commit 47d71bc75d072ce25c1063aa629e55e1cfb961b2 ]

To avoid race with vchan_complete, use the race free way to terminate
running transfer.

Implement the device_synchronize callback to make sure that the terminated
descriptor is freed.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/dma/amba-pl08x.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/amba-pl08x.c b/drivers/dma/amba-pl08x.c
index b52b0d55247e..97483df1f82e 100644
--- a/drivers/dma/amba-pl08x.c
+++ b/drivers/dma/amba-pl08x.c
@@ -2182,7 +2182,7 @@ static int pl08x_terminate_all(struct dma_chan *chan)
 	}
 	/* Dequeue jobs and free LLIs */
 	if (plchan->at) {
-		pl08x_desc_free(&plchan->at->vd);
+		vchan_terminate_vdesc(&plchan->at->vd);
 		plchan->at =3D NULL;
 	}
 	/* Dequeue jobs not yet fired as well */
@@ -2193,6 +2193,13 @@ static int pl08x_terminate_all(struct dma_chan *chan=
)
 	return 0;
 }
=20
+static void pl08x_synchronize(struct dma_chan *chan)
+{
+	struct pl08x_dma_chan *plchan =3D to_pl08x_chan(chan);
+
+	vchan_synchronize(&plchan->vc);
+}
+
 static int pl08x_pause(struct dma_chan *chan)
 {
 	struct pl08x_dma_chan *plchan =3D to_pl08x_chan(chan);
@@ -2773,6 +2780,7 @@ static int pl08x_probe(struct amba_device *adev, cons=
t struct amba_id *id)
 	pl08x->memcpy.device_pause =3D pl08x_pause;
 	pl08x->memcpy.device_resume =3D pl08x_resume;
 	pl08x->memcpy.device_terminate_all =3D pl08x_terminate_all;
+	pl08x->memcpy.device_synchronize =3D pl08x_synchronize;
 	pl08x->memcpy.src_addr_widths =3D PL80X_DMA_BUSWIDTHS;
 	pl08x->memcpy.dst_addr_widths =3D PL80X_DMA_BUSWIDTHS;
 	pl08x->memcpy.directions =3D BIT(DMA_MEM_TO_MEM);
@@ -2802,6 +2810,7 @@ static int pl08x_probe(struct amba_device *adev, cons=
t struct amba_id *id)
 		pl08x->slave.device_pause =3D pl08x_pause;
 		pl08x->slave.device_resume =3D pl08x_resume;
 		pl08x->slave.device_terminate_all =3D pl08x_terminate_all;
+		pl08x->slave.device_synchronize =3D pl08x_synchronize;
 		pl08x->slave.src_addr_widths =3D PL80X_DMA_BUSWIDTHS;
 		pl08x->slave.dst_addr_widths =3D PL80X_DMA_BUSWIDTHS;
 		pl08x->slave.directions =3D
--=20
2.14.1
