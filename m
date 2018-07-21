Return-Path: <SRS0=ZAeg=KF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDAD5ECDE5F
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 10:06:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55A4C20849
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 10:06:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="uLSXypTT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55A4C20849
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=toradex.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727630AbeGUK6j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Jul 2018 06:58:39 -0400
Received: from mail-ve1eur01on0109.outbound.protection.outlook.com ([104.47.1.109]:22801
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727412AbeGUK6j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jul 2018 06:58:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LyhxaT2T+jDVHEFcgUIlyn0yfXgb6Sep4sH5WpqlPVc=;
 b=uLSXypTTTXO2djZGEHgpqI8loEUN65e4ovImUIk/oJBecvU9W9UDPgrAyZ8e9LHSGSyT7rpav300SQsR7miIweqH/RlAhtbSfl74XtthWf99Pj/LbgH91MN5ZFZnfi0NqMstX1c8K9I7U3ubku9czxQ6cikhpF36TTTdVqFw4RI=
Received: from VI1PR0501MB2590.eurprd05.prod.outlook.com (10.168.137.14) by
 VI1PR0501MB2749.eurprd05.prod.outlook.com (10.172.11.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.973.16; Sat, 21 Jul 2018 10:06:24 +0000
Received: from VI1PR0501MB2590.eurprd05.prod.outlook.com
 ([fe80::dc61:4a61:b84:357e]) by VI1PR0501MB2590.eurprd05.prod.outlook.com
 ([fe80::dc61:4a61:b84:357e%8]) with mapi id 15.20.0973.018; Sat, 21 Jul 2018
 10:06:24 +0000
From:   Marcel Ziswiler <marcel.ziswiler@toradex.com>
To:     "broonie@kernel.org" <broonie@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jonathanh@nvidia.com" <jonathanh@nvidia.com>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "perex@perex.cz" <perex@perex.cz>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Subject: Re: [PATCH 2/2] ASoC: tegra: probe deferral error reporting
Thread-Topic: [PATCH 2/2] ASoC: tegra: probe deferral error reporting
Thread-Index: AQHUIABUe+tvL+Nfh0CxF11WAEwB4qSYBuQAgAAEKYCAAWcSgIAAAtKA
Date:   Sat, 21 Jul 2018 10:06:23 +0000
Message-ID: <1532167581.19673.21.camel@toradex.com>
References: <20180720080424.31505-1-marcel@ziswiler.com>
         <20180720080424.31505-2-marcel@ziswiler.com>
         <20180720121612.GC10784@sirena.org.uk>
         <1532089865.19673.13.camel@toradex.com>
         <20180721095615.GG16228@sirena.org.uk>
In-Reply-To: <20180721095615.GG16228@sirena.org.uk>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=marcel.ziswiler@toradex.com; 
x-originating-ip: [89.217.215.226]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR0501MB2749;6:7KJhOzmdRNoefUlaf6ffSqs41xMkz6qabe6p8uhXjJ5tORcgUzXQkG6MDBSTNC6EXODzV3Ubb1dqFuEQ+f9iebwrzmQZQEnULL+eOFo0OMtsvSKb8Nh3i20mcP6LfDQ41xGlXWVM6qFQPvQOWXWT7maDY1pMEmtARFxhc5cIYYoRGGm2PpIMpj2XNYzSO688MfZDu2blBHRJFMZEKNKpG91sYj0BHPxMY/Aa+VuKrsIoar59vd111sbSj/2vg4mOu8DJ0/K7unAyu3Qj9DS3FitMiIbR/7XNWGgfD7UPD9Eyxl313ob59UXUOCKD0Mb0Qc3KzvAC37UBpk8mQVu25jnYObEKbxtpZyB6tReRtzsJtX0kgKfxpyzSoIR0JOOgfv2x5aYaWC77G6j+3sClk8VHrlsWUtoJA88WiDvyLkQi2ZHRbTYs+QFiyqz4hJJmbqjD/R24mnj58TRqO+skwQ==;5:wikC9JPGStyyGyicztjZyq82Kn0sNMZYZ2df5UCPP3gnNC9K9O/YiEG0QZUoFw04+fz+lnxgtSu5f5fZK7KzG7lpnFOsqBLK70FWIoVxb2J59tLxFpf9952MaFP9SoC3KpgVe56JfTvYIVSoZ/tPgkYVe7lnD85P6Si8jT+LgPM=;7:9gnnwn5MOyLoh3cItCsaDgSz2Xg3EPsQKNfYTJE4Gg66992IWNQIxfNcg5+Pjy+mX6aKWbgaRfBoVOUrz5eCJyHxws0R6v+Izb87vbLAoGKa+bskdJv1OeNf2QZ6Xhw0pECUn0+PwSNWGd2yVxabM40r8XHBxVlZveYOcrwpuudiNOiAI/7mPksBshI4O1jcLBVBjZWZEaZVIxrAwJrqtzE8b1ahOKsdHvb/Dpecq7i3G2IG7P9m8CoYOzWEEyiL
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 2d8df025-23d1-46d0-ec1f-08d5eef19d84
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600073)(711020)(2017052603328)(7153060)(7193020);SRVR:VI1PR0501MB2749;
x-ms-traffictypediagnostic: VI1PR0501MB2749:
x-microsoft-antispam-prvs: <VI1PR0501MB2749C4140E500CDBFAF2DA2CFB500@VI1PR0501MB2749.eurprd05.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(211171220733660);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(10201501046)(3231311)(944501410)(52105095)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:VI1PR0501MB2749;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0501MB2749;
x-forefront-prvs: 074040B844
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39840400004)(376002)(346002)(136003)(366004)(189003)(199004)(81156014)(8676002)(102836004)(26005)(103116003)(8936002)(6506007)(186003)(68736007)(446003)(2501003)(81166006)(76176011)(5250100002)(478600001)(14454004)(305945005)(106356001)(54906003)(105586002)(7736002)(6436002)(3846002)(6116002)(5640700003)(316002)(6486002)(1730700003)(39060400002)(6512007)(486006)(11346002)(4326008)(2616005)(476003)(44832011)(97736004)(229853002)(256004)(53936002)(66066001)(25786009)(2906002)(86362001)(6246003)(5660300001)(2351001)(93886005)(6916009)(36756003)(2900100001)(99286004);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0501MB2749;H:VI1PR0501MB2590.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 0CSaHnaDSfqq+ScaadAs8c9Ssje2LRRHTrvNhaXH5kkoPOQVSFAKhV7hpezR1a4ZA7IJtde4A4NZrc1Bi6rahmqQdW0XPbQGE3Q6h+y0XLkwXGvhTXKjHZjpbkZ5K5oypGiB0kmw6L1hKtg6gdfS8+ICLtM3GGquQMUo24WhmIgfmyNaEvYB+05euJBs2OK9QmZSTI+jAFaVFBXkOmYIxErru2XlKrZDA94pXXvS6JDj37gCmp5V09D0YHiBTHae50SUvJ1qU7eLQ/qs0lAPG7pKYMZKoTX6DzDq3l0IbXfdKAYalSOHT28UjPHo86yoXHhgG1iI647PljCD5GQm/hdCOYG+yIxWhwltCZ5PaAw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <7AD8740C5954A74B90D843D13D70192E@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d8df025-23d1-46d0-ec1f-08d5eef19d84
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2018 10:06:23.8204
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0501MB2749
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gU2F0LCAyMDE4LTA3LTIxIGF0IDEwOjU2ICswMTAwLCBNYXJrIEJyb3duIHdyb3RlOg0KPiBP
biBGcmksIEp1bCAyMCwgMjAxOCBhdCAxMjozMTowN1BNICswMDAwLCBNYXJjZWwgWmlzd2lsZXIg
d3JvdGU6DQo+ID4gT24gRnJpLCAyMDE4LTA3LTIwIGF0IDEzOjE2ICswMTAwLCBNYXJrIEJyb3du
IHdyb3RlOg0KPiA+ID4gPiAgCWFjOTctPnN5bmNfZ3BpbyA9IG9mX2dldF9uYW1lZF9ncGlvKHBk
ZXYtPmRldi5vZl9ub2RlLA0KPiA+ID4gPiAgCQkJCQkgICAgIm52aWRpYSxjb2RlYy0NCj4gPiA+
ID4gc3luYy0NCj4gPiA+ID4gZ3BpbyIsIDApOw0KDQpBYm92ZSBhYzk3LT5zeW5jX2dwaW8gZ2V0
cyByZXR1cm4gdmFsdWUgZnJvbSBvZl9nZXRfbmFtZWRfZ3BpbygpLA0KcmlnaHQ/DQoNCj4gPiA+
ID4gIAlpZiAoIWdwaW9faXNfdmFsaWQoYWM5Ny0+c3luY19ncGlvKSkgew0KDQpIZXJlIGl0IGdv
ZXMgaWYgYWM5Ny0+c3luY19ncGlvIGlzIG5vdCBhIHZhbGlkIEdQSU8gZS5nLiBpbiBhbiBlcnJv
cg0KY2FzZSBhcyByZXBvcnRlZCBieSBhYm92ZSBvZl9nZXRfbmFtZWRfZ3BpbygpLCByaWdodD8N
Cg0KPiA+ID4gPiAtCQlkZXZfZXJyKCZwZGV2LT5kZXYsICJubyBjb2RlYy1zeW5jIEdQSU8NCj4g
PiA+ID4gc3VwcGxpZWRcbiIpOw0KPiA+ID4gPiArCQlyZXQgPSBhYzk3LT5zeW5jX2dwaW87DQoN
CkFuZCBoZXJlIEkgYXNzaWduIHJldCB3aXRoIHRoYXQgcmV0dXJuIHZhbHVlIGZyb20gb2ZfZ2V0
X25hbWVkX2dwaW8oKSwNCnJpZ2h0Pw0KDQo+ID4gPiA+ICsJCWRldl9lcnIoJnBkZXYtPmRldiwg
Im5vIGNvZGVjLXN5bmMgR1BJTw0KPiA+ID4gPiBzdXBwbGllZDoNCj4gPiA+ID4gJWRcbiIsIHJl
dCk7DQoNCkFuZCB0aGVuIEkgYWN0dWFsbHkgcmVwb3J0IHdoYXQgZXJyb3IgaXQgd2FzIChlLmcu
IHByb2JlIGRlZmVycmFsKS4NCg0KPiA+ID4gPiAgCQlnb3RvIGVycl9jbGtfcHV0Ow0KPiA+ID4g
PiAgCX0NCj4gPiA+IFRoaXMgaXNuJ3QgcmVwb3J0aW5nIGFuIGVycm9yIGNvZGUgYXNzb2NpYXRl
ZCB3aXRoIHRoZSBhdHRlbXB0IHRvDQo+ID4gPiBmaW5kIGENCj4gPiA+IGNvZGVjLXN5bmMgR1BJ
TywgaXQncyB0aGUgcmVzdWx0IG9mIHNvbWUgb3RoZXIgb3BlcmF0aW9uLg0KPiA+IFdoYXQgZXhh
Y3RseSBpcyB0aGVuIHRoZSBvZl9nZXRfbmFtZWRfZ3BpbygpIGFib3ZlIHBsZWFzZSBkb2luZyBp
Zg0KPiA+IG5vdCBnZXR0aW5nIHRoZSBjb2RlYyBzeW5jIEdQSU8/IEkgYW0gbm90IGZvbGxvd2lu
ZyB5b3UsIHNvcnJ5Lg0KPiANCj4gSXQncyBub3QgaW4gYW55IHdheSBpbnZvbHZlZCBpbiBzZXR0
aW5nIHRoZSB2YWx1ZSBvZiByZXQsIHdoYXRldmVyDQo+IHZhbHVlDQo+IHRoYXQgaGFzIGl0J3Mg
bm90aGluZyB0byBkbyB3aXRoIHRoYXQgb3BlcmF0aW9uLg0KDQpJIHJlYWxseSBkbyBub3QgdW5k
ZXJzdGFuZCB3aGF0IHlvdSBhcmUgdHJ5aW5nIHRvIGdldCBhdCwgc29ycnku
