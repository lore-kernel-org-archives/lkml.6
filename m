Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3099CC04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 05:38:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5D8D214DB
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 05:38:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=renesasgroup.onmicrosoft.com header.i=@renesasgroup.onmicrosoft.com header.b="kxM0ISDI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5D8D214DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=renesas.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728997AbeLFFiH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 00:38:07 -0500
Received: from mail-eopbgr1410091.outbound.protection.outlook.com ([40.107.141.91]:2112
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728758AbeLFFiG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 00:38:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector1-renesas-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6VwKcQ5I0JFFsOvBpOMqq8joIIaByxRfx/uJZgdkOfg=;
 b=kxM0ISDIZUGxx1bQI4S3rgpjEqLvazVSrFTEjExPqxT0KblP2bO2jHyGxhjWiY2R90J/WJOaiKc34D6SClB7M+rubGndep1pcB2gMHxjdhgQgUMoxmvSfa9uwwLMA04yEz0wlojdy0L05sC9mBkeRDiLpe07sFM+Wz1Qr135miw=
Received: from OSAPR01MB3652.jpnprd01.prod.outlook.com (20.178.102.21) by
 OSAPR01MB2146.jpnprd01.prod.outlook.com (52.134.236.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.17; Thu, 6 Dec 2018 05:38:02 +0000
Received: from OSAPR01MB3652.jpnprd01.prod.outlook.com
 ([fe80::1082:83c0:48f5:59a6]) by OSAPR01MB3652.jpnprd01.prod.outlook.com
 ([fe80::1082:83c0:48f5:59a6%4]) with mapi id 15.20.1404.020; Thu, 6 Dec 2018
 05:38:02 +0000
From:   Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
To:     Jiada Wang <jiada_wang@mentor.com>
CC:     "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "perex@perex.cz" <perex@perex.cz>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "vladimir_zapolskiy@mentor.com" <vladimir_zapolskiy@mentor.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH linux-next v3 6/7] ASoC: rsnd: add avb clocks
Thread-Topic: [PATCH linux-next v3 6/7] ASoC: rsnd: add avb clocks
Thread-Index: AQHUjHi5uIHaJM2ZQUK9E1ICoJh5yg==
Date:   Thu, 6 Dec 2018 05:38:02 +0000
Message-ID: <871s6vjkaz.wl-kuninori.morimoto.gx@renesas.com>
References: <20181205074932.28098-1-jiada_wang@mentor.com>
        <87va48bbpa.wl-kuninori.morimoto.gx@renesas.com>
        <612ee648-c217-e9b4-224c-87183e43d83d@mentor.com>
        <878t13jx6y.wl-kuninori.morimoto.gx@renesas.com>
        <011cfbf7-70d0-a649-52de-1689cdb5a10b@mentor.com>
In-Reply-To: <011cfbf7-70d0-a649-52de-1689cdb5a10b@mentor.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: TY1PR01CA0190.jpnprd01.prod.outlook.com (2603:1096:403::20)
 To OSAPR01MB3652.jpnprd01.prod.outlook.com (2603:1096:604:58::21)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=kuninori.morimoto.gx@renesas.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [211.11.155.130]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;OSAPR01MB2146;20:ORn8sSGNyI2cTR+BUr0OCNgin7H9M2cRohvRUe6FzbsGEBKYcKzBMesF1+K++qBeYllnKUNBfPFoy7NT56QVipsMq66zoAY2JlebmoRlnzbfRZMHOkfxX7LtaW3g3wk7BwhKKNBA2HGJXwRg/KFJktWDXseut8CeWj83Rj7HdWc=
x-ms-office365-filtering-correlation-id: f5be7f8c-9245-47f7-2f2c-08d65b3cfc94
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:OSAPR01MB2146;
x-ms-traffictypediagnostic: OSAPR01MB2146:
x-microsoft-antispam-prvs: <OSAPR01MB21468E1C8F763D89538A8211D4A90@OSAPR01MB2146.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231455)(999002)(944501520)(52105112)(93006095)(93001095)(3002001)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123564045)(20161123560045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:OSAPR01MB2146;BCL:0;PCL:0;RULEID:;SRVR:OSAPR01MB2146;
x-forefront-prvs: 087894CD3C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(366004)(346002)(376002)(39860400002)(136003)(199004)(189003)(476003)(4326008)(478600001)(26005)(6116002)(106356001)(386003)(6506007)(316002)(105586002)(6486002)(14444005)(256004)(6916009)(486006)(575784001)(97736004)(86362001)(102836004)(81156014)(6512007)(81166006)(186003)(3846002)(11346002)(2616005)(54906003)(36756003)(7736002)(53936002)(25786009)(6246003)(305945005)(14454004)(229853002)(76176011)(93886005)(99286004)(8936002)(446003)(71200400001)(71190400001)(66066001)(68736007)(39060400002)(2906002)(5660300001)(6436002)(52116002)(8676002);DIR:OUT;SFP:1102;SCL:1;SRVR:OSAPR01MB2146;H:OSAPR01MB3652.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: renesas.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: CSWVSTWGAxQKwoYuVxlR0rMznYAeJRor9y41b/f7DwtEV7+HQcq3ZkQuoFinNw6/gsT2HqufCJiD0r/JdbioEs69i+5tc7SxMwyH7ovMtJvyQrtH3K+UUcew3IBmS9Pt9q5OSo/hSBmIy5IgQDGtvmyz36vc7J+kWa+Vd0ziIaj1E7MLh1XIL9nSgrC+4HyOX9IlhJW/WXxfbFjFA65wO3Y29J+ywEzNlSF9hGhVXEvJ3s+npI9aKN5rZPI82g02M+PtzisNaQuvAvjwIgRhBu+7nAiZeaITEGvJ0rxUEIYhy2VhCrCMiyXntYpWOkJlRDUqdKG0H98oMlnJVI4rJOVaUcnd0oMWMn58pZtZeKc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <F70FC67AF3ABAC4C987DD34D87CD04BD@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5be7f8c-9245-47f7-2f2c-08d65b3cfc94
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2018 05:38:02.1554
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB2146
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpIaSBKaWFkYQ0KDQo+IFNNU1RQQ1I5MjIgY29udHJvbHMgaW5wdXQgb2YgdHdvIGNsb2NrcyAi
UzBEMc+VIiBhbmQgIlMwRDTPlSIsDQoNCkFoaCwgT0sgSSBjb3VsZCBjaGVjayBpdCB2aWEgQmxv
Y2sgZGlhZ3JhbS4NCkJ1dCBpdCBpcyAiTW9kdWxlIHN0b3AiIGZvciB0aGVzZSwgYW55d2F5Lg0K
Ik1vZHVsZSBzdG9wIiBhbmQgIlMwRDHPlS9TMEQ0z5UiIGFyZSBjb21wbGV0ZWx5IGRpZmZlcmVu
dCBjbG9ja3MuDQoNCj4gIlMwRDTPlSIgaXMgaW5wdXQgdG8gQlJHQSwNCj4gIlMwRDHPlSIgaXMg
aW5wdXQgdG8gYXZiX2NvdW50ZXI4DQoNCkl0IHNlZW1zIHdlIG5lZWQgdG8gdXBkYXRlICJjbGtf
aSIgcG9ydGlvbiBmaXJzdCBmb3IgdGhpcyBwdXJwb3NlLg0KVGhlbiwgd2UgbmVlZCB0byBjb25z
aWRlciBhYm91dCBHZW4yIHZzIEdlbjMsIGV0YywgZXRjLi4uDQpJdCBzZWVtcyB3ZSBjYW4ndCBr
ZWVwIHBhdGNoIHNpbXBsZS4uLg0KDQo+ID4gM3JkLCB3ZSBuZWVkIHRvIGNyZWF0ZSBuZXcgY2xv
Y2svaGFuZGxlciBmb3INCj4gPiBhdmJfY291bnRlcjggLyBhdWRpb19jbGtfZGl2MyAvIGF2Yl9k
aXY4IGZvciAiaW50ZXJuYWwiIHB1cnBvc2UsDQo+ID4gYW5kIG5lZWQgdG8gY3JlYXRlIGF2Yl9h
ZGdfc3luW10gY2xvY2sgZm9yICJleHRlcm5hbCIgcHVycG9zZSBmb3IgRUFWQi9JRi4NCj4gPiBZ
b3VyIGNvZGUgaXMgY3JlYXRpbmcgLyByZWdpc3RlcmluZyBhZGctPmNsa2F2YltdLA0KPiA+IGJ1
dCBpdCBpcyBmb3IgYXZiX2NvdW50ZXI4IGluIG15IHVuZGVyc3RhbmRpbmcuDQo+ID4gV2UgZG9u
J3QgbmVlZCB0byByZWdpc3RlciBpdCBhcyBmb3JtYWwgY2xvY2sgSU1PLg0KPiBJIGFncmVlLCBi
ZXNpZGVzIGF2Yl9jb3VudGVyOCB0aGVyZSBhcmUgb3RoZXIgY2xvY2tzIHdoaWNoIG5lZWQgdG8g
YmUNCj4gYWRkZWQgYXMgeW91IGhhdmUgbWVudGlvbmVkLA0KPiBpbiB0aGlzIHBhdGNoLXNldCwg
SSBvbmx5IGFkZGVkIGF2Yl9jb3VudGVyOCwgYmVjYXVzZSBJIHdhbnQgdG8ga2VlcA0KPiB0aGUg
cGF0Y2gtc2V0IHNpbXBsZSwNCj4gb3RoZXIgY2xvY2tzIGNhbiBiZSBhZGRlZCBsYXRlci4NCg0K
Tm8sIE5vLCBOby4NCmF2Yl9jb3VudGVyOCBpcyBqdXN0ICJpbnRlcm5hbCIgY2xvY2ssIGFuZCBv
bmUgb2YNCnBhcmVudCBjbG9jayBmb3IgYXZiX2Rpdjggd2hpY2ggaXMgbmVlZGVkIGZvciBhdmJf
YWRnX3N5bltdLg0KV2UgbmVlZCB0byBjb250cm9sL3JlZ2lzdGVyIGlzIGF2Yl9hZGdfc3luW10s
IG5vdCBhdmJfY291bnRlcjguDQoNCllvdXIgYXBwcm9hY2ggb24gdGhpcyBwYXRjaCBpcyB2ZXJ5
ICJRdWljay1IYWNrIi4NCkkgaGF2ZSBubyBvYmplY3Rpb24gZm9yIG91dC1vZi10cmVlIHBhdGNo
ZXMuDQpCdXQsICJRdWljay1IYWNrIGFwcHJvYWNoIHdpdGggY2hhbmdpbmcgZm9ybWFsIERUIG9u
IHVwc3RyZWFtIg0KaXMgbmlnaHRtYXJlLg0KDQo+IGF2Yl9jb3VudGVyOCBpcyByZWdpc3RlcmVk
IGFzIGZvcm1hbCBjbG9jayBpcyBiZWNhdXNlLA0KPiB0aGVyZSBpcyB1c2UgY2FzZSB0aGF0IEVB
VkItSUYgbWF5IHVzZSBhdmJfZGl2OCwgYW5kIGF2Yl9jb3VudGVyOCBpcw0KPiBpbnB1dCB0byBh
dmJfZGl2OC4NCj4gaWYga2VlcHMgYXZiX2NvdW50ZXI4ICdpbnRlcm5hbCcsIEkgYW0gbm90IHN1
cmUgaG93IEVBVkItSUYgY2FuIHNldA0KPiBjbG9jayByYXRlIGZvciBhdmJfY291bnRlcjgNCg0K
RUFWQi9JRiBkcml2ZXIgc2V0dXBzIGF2Yl9hZGdfc3luW10uDQpUaGVuLCBBREcgY29uc2lkZXJz
L3NlYXJjaHMgYXZiX2NvdW50ZXI4L2F2Yl9kaXY4L2F1ZGlvX2Nsa19kaXYzDQpzZXR0aW5ncyBp
bnRlcm5hbGx5Lg0KRG9uJ3QgY29udHJvbCBhdmJfY291bnRlcjggZGlyZWN0bHkgZnJvbSBFQVZC
Lg0KDQpCZXN0IHJlZ2FyZHMNCi0tLQ0KS3VuaW5vcmkgTW9yaW1vdG8NCg==
