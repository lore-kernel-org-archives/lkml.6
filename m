Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1310899-1520122829-2-12549570514426167967
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
    t=1520122829; b=acsT1uVai39yy+IB0mmsCiXhc+lpnmvkz/h8Q8VYXbpHGCA
    U/3RjrOyl67yJXyIeHTDw0wrA3jFvPk5c4UKoftnGSILJeOuFITD2g9hDjnnxeHh
    csOL94SeBiJ3DKsx+jt2TWt7//c3iCIe5vTzVBxdBLh9a4fSh/JVaTnKE0ZaIWsV
    g9JzSK1+UfNkwHurMkw8cKNGj87ezuPEuG/xLpLv1CICq4T0czJfL47xCMO53GQ3
    RT5wlm7OHhT2N7VNBpjZYZoCz0Sg3HQ3YHPHmlSU/PZxkrBDHVZ22j8hPv/BBEQc
    kEovKkJHtToNEikbwTNc5Rrq5fBW6SnwDyxF76Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520122829; bh=SV+Phq
    lwDf/HXxAXOcKxD5YZSnKurtTgcD32Z721Nkk=; b=FPwDII/+DY+7FxTte8MC3h
    PSSgYQRzZabchLkQjUj3kj2sqO0vi8HoGdjbND0K/eoy8NBISlM3Nq6vEgPYl4av
    7Q8cgn2wohSOWYvddSGQYLvuy99uZZR3zBlnhGidZYqRanX1Zai2RnnS/qs56XGL
    4CcgEs/kgAD03j9u5i9sfHp5l2kCroorSOzafwiY+OjcYhyAThf+wbtA4eyEZz/v
    cuKkE9QJZs3aFCOaXh6C1NRSe7HFehdZbDtkTqwCGWAzZBEMYVUCXmzZDC5/6yqN
    HxuQfXBLAJjsmadqOwc6mxSj17GfLmW4tbYzg9VWz8fzdwyVpeLZwhmodqeEf8lw
    ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=ZuxGh5ze x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=ZuxGh5ze x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933238AbeCDAUX (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 19:20:23 -0500
Received: from mail-sn1nam01on0126.outbound.protection.outlook.com ([104.47.32.126]:12224
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932887AbeCCW3H (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:29:07 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Vinod Koul <vinod.koul@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 40/84] dmaengine: bcm2835-dma: Use
 vchan_terminate_vdesc() instead of desc_free
Thread-Topic: [PATCH AUTOSEL for 4.14 40/84] dmaengine: bcm2835-dma: Use
 vchan_terminate_vdesc() instead of desc_free
Thread-Index: AQHTsz6p98qwk4rujUOkTm1nVlBy9A==
Date: Sat, 3 Mar 2018 22:26:22 +0000
Message-ID: <20180303222518.26271-40-alexander.levin@microsoft.com>
References: <20180303222518.26271-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222518.26271-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB0970;7:5T6poyL8UDbHpY75EhW/NB01TqeKCA4WEDsMyAmXNtmlIQxvbQp1Z2q9zpcSNljLChHT3D8LtF9R+FEL1gbJ8C/SpXz/PmuIdugKNpu7tk7A9AYxRvcy46pCZALTX1TeR2lwHNyIHFS3v8g7n/1dyk825MVrwTBCut61PRZ/u2vU542YxONm42g+dF7nUXvywMBD38UHlzpVWnlr+m+rhrA4PdjscYxiXvqPF+plB1nOtWsuNa8CTGWDPk/r62lk
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 565f208c-5548-4b37-822b-08d581562c67
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2PR2101MB0970;
x-ms-traffictypediagnostic: MW2PR2101MB0970:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB0970CC61296D8C5E1FA5733EFBC40@MW2PR2101MB0970.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(31051911155226)(89211679590171)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231220)(944501244)(52105095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123558120)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR2101MB0970;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB0970;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(39380400002)(366004)(396003)(39860400002)(346002)(199004)(189003)(86362001)(110136005)(4326008)(6506007)(14454004)(99286004)(8936002)(1076002)(36756003)(2906002)(102836004)(76176011)(25786009)(6486002)(316002)(478600001)(3280700002)(107886003)(186003)(54906003)(26005)(81166006)(7736002)(8676002)(6512007)(81156014)(305945005)(72206003)(59450400001)(6436002)(53936002)(6116002)(6666003)(86612001)(68736007)(3846002)(2950100002)(3660700001)(10290500003)(22452003)(10090500001)(2900100001)(106356001)(2501003)(66066001)(97736004)(5660300001)(5250100002)(105586002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB0970;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: CvADaCxf+aZ7/p0c73kXbDAT6VU3BcOptINTuCkv6pFdl7o5jLOEIvrNoILi1ldCNJbvxvUSfT6l6yEij9cbrBHUSHd7iwpQJrjomxXnF2f8dTuthxdSzHDwdnk8cFNdFJqj3qGPTnQqaxIDlvTOHQSQy5k+pfc/zIju7GgoZNE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 565f208c-5548-4b37-822b-08d581562c67
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:26:23.0098
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
