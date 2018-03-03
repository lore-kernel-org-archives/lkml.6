Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1352585-1520124011-2-11841475417197470936
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
    t=1520124010; b=EOF360KExvdBKM92ofHT7FOiz8dDp+21zRBXmUIAN8VVoWy
    S9j2LUaZxMKsLU0KH5J+t6Ps4UX8iEujNW8X2brwZHybflfunKaZk8KzyNzadeIt
    UeYVduAYmhXSHkPDJ07WJQFybei7h78Ul7nqiE+cFHHmajtkm4TafgDTFbusjhxa
    s0HDQqBX9oC4UDSXfsPnqIjJzlxvjrndlh6BGFeOLGI/FTgVPufoAosZGRJf2lz/
    JkxTlAj0KybulNnUudIMDqkE1MikSz9pfwIb0/gwxuGTshTUm4wZy2osBa4jg58s
    iL+GUNZ9ikYUABjKStKQlkXpYFTr9dRlzOMrOwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520124010; bh=j+ULWd
    GaJEqzYPoj0LYdLiNXXGYmQuJQ2kxgbZYLJS0=; b=pOZDI6GvwlU0btf6OnM6LG
    Mp+xTccrfQywYW3qWwtKNro/RSRQ0k313B9Ld4qJJgF8lyrm/U5Zc1AAXRS5WXUx
    QDgyGYzIB6hw4c74MNWjwkxY6NxVDjQibGzwtb/pSV55b2tvrpephUG454f5v1h1
    ixjaKGOxormIwvJCqq4M49ok7vXkgIKBqv8TIJMT4116jeapQ0JmNrBGQiDcthxb
    ADNrPxejiT3AwkxTeNseKONdPf/kTmJPQhDgcHJLgBR5y79MwKs33Qte9wa0IAqx
    J24Xa8DTmZGLkmMcxa689j1i7pgnzSehiGOyuYDx/AyE+XQgtJ7xRJVZJjNLlZtQ
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=UfdFxb/h x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=UfdFxb/h x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932679AbeCCW0Z (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 17:26:25 -0500
Received: from mail-bn3nam01on0098.outbound.protection.outlook.com ([104.47.33.98]:35904
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932577AbeCCW0U (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:26:20 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Vinod Koul <vinod.koul@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 053/102] dmaengine: amba-pl08x: Use
 vchan_terminate_vdesc() instead of desc_free
Thread-Topic: [PATCH AUTOSEL for 4.15 053/102] dmaengine: amba-pl08x: Use
 vchan_terminate_vdesc() instead of desc_free
Thread-Index: AQHTsz5rk8XH8+wc5EyQpgrxT2lgHA==
Date: Sat, 3 Mar 2018 22:24:39 +0000
Message-ID: <20180303222318.26006-53-alexander.levin@microsoft.com>
References: <20180303222318.26006-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222318.26006-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB0970;7:TMHXfHT8WwiFaX2EzL0znUqzwlXhUN2Svw/tlMZ6C0iWY/f3tiyLSk/0a13TowK8Y0PaYsMnMwkdLGv8NGfLmnhDwtKMI2i0znNFGCWVuiP+ULsFrK/f8YwMYxDM4ZTXHRgM3S9Bydnr8IvfY4d88srj78r3OXHaYWCcUL4BUkXgO9u5d0jfUDbDaWXqtVwVPrZGseCwDYmdk5aWP4AePO1EtqKFOR8FWk/Z1gEje1CVN2Vf+a/K8l5t4VN7DWXV
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 086508f3-6c0d-4654-c635-08d58155c50b
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2PR2101MB0970;
x-ms-traffictypediagnostic: MW2PR2101MB0970:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB0970F90763C51310DD64475FFBC40@MW2PR2101MB0970.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(31051911155226)(89211679590171)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231220)(944501244)(52105095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123558120)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR2101MB0970;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB0970;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(366004)(39380400002)(376002)(396003)(199004)(189003)(3660700001)(10290500003)(2950100002)(3846002)(2900100001)(22452003)(10090500001)(86612001)(6116002)(6666003)(68736007)(105586002)(5660300001)(5250100002)(106356001)(97736004)(2501003)(66066001)(8936002)(1076002)(99286004)(2906002)(36756003)(575784001)(86362001)(14454004)(6506007)(110136005)(4326008)(102836004)(6512007)(81156014)(305945005)(81166006)(7736002)(8676002)(53936002)(72206003)(59450400001)(6436002)(316002)(478600001)(76176011)(25786009)(6486002)(26005)(54906003)(3280700002)(186003)(107886003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB0970;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: ICL2+yh3Yd5BeHE3MN7vF6ewGkQvHr9wqGF/A+scT2JBpjS3JVgNoeVWQq78IJH5R/kRr+0APN+Nhp3/qZdeUPbQ6qAAJl0kiPbapgAM3+jB0Gq/FTu6BtLTEoxYfVsCXnaVEnpaodE/mXi8hl4UHiXsGRCZi+0y2hCRa2OxROs=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 086508f3-6c0d-4654-c635-08d58155c50b
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:24:39.7440
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
