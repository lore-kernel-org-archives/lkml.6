Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00F6AECE565
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 08:28:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9884A2146D
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 08:28:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="mDP40efc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9884A2146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729366AbeIROAO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 10:00:14 -0400
Received: from mail-eopbgr10061.outbound.protection.outlook.com ([40.107.1.61]:34933
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726759AbeIROAN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 10:00:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kw1/PUZzXJs8xDaUcRCILQudSZ2Tyxjn0p8HCLIURD8=;
 b=mDP40efcY3g/qwc64zVjpqBeXlOfCTv/Gsi/nm82mtNT++9aoq6xm9sy1mygMRDzJbe0pV/BI/gHwVcaLNwKomnasAYNCi9VCRqq/vNfHxshRcSi40yncrDdvhqTXFeqguiWLwWP4rSclA3iGQHkNWFZlXdKm6L/COmI4Rc3Yko=
Received: from VI1PR04MB1038.eurprd04.prod.outlook.com (10.161.109.144) by
 VI1PR04MB1357.eurprd04.prod.outlook.com (10.163.166.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.18; Tue, 18 Sep 2018 08:28:23 +0000
Received: from VI1PR04MB1038.eurprd04.prod.outlook.com
 ([fe80::2098:afc:1023:6534]) by VI1PR04MB1038.eurprd04.prod.outlook.com
 ([fe80::2098:afc:1023:6534%5]) with mapi id 15.20.1143.017; Tue, 18 Sep 2018
 08:28:23 +0000
From:   Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
To:     Frieder Schrempf <frieder.schrempf@exceet.de>,
        Boris Brezillon <boris.brezillon@bootlin.com>
CC:     "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "robh@kernel.org" <robh@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 1/5] spi: spi-mem: Add driver for NXP FlexSPI
 controller
Thread-Topic: [PATCH v2 1/5] spi: spi-mem: Add driver for NXP FlexSPI
 controller
Thread-Index: AQHUTmvfC0oHQrtTJUq+OAlmHVuv6qT0WOOAgAFbqYCAAAA64A==
Date:   Tue, 18 Sep 2018 08:28:23 +0000
Message-ID: <VI1PR04MB1038A85DC36665244DF2104A991D0@VI1PR04MB1038.eurprd04.prod.outlook.com>
References: <1537177710-9379-1-git-send-email-yogeshnarayan.gaur@nxp.com>
 <1537177710-9379-2-git-send-email-yogeshnarayan.gaur@nxp.com>
 <20180917133751.453ea6ed@bbrezillon>
 <9529c765-cb3b-02f9-df15-4f79cfa48e47@exceet.de>
In-Reply-To: <9529c765-cb3b-02f9-df15-4f79cfa48e47@exceet.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yogeshnarayan.gaur@nxp.com; 
x-originating-ip: [14.142.187.166]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR04MB1357;6:6/g3T00Zv9M1CRB57NHHhxcNx/sM2qQ6Gusm9C4Wo2kt9r68IxgVdzWBt0c/jyeFH4/Sib6hUSNtZ6YCTGVXnB6gofLHi8tgzm8ZUkb4pqUMK44qgr0uI9LZxy31iHAHmY+rTOwZSdF2JlcDA2uQnnSR8zSZ549Fk1Tiod5RBsWisMjZHr903ivP8zBLH4l2Ha+Z6Kg4tLS8Cb7GJzGAmplCleTyWUWxp/Og/hqs0Jn4YY7guS7blKSVZ8h4ra4Tc1DnjpwHkeJ+5tFhUnY7kfKuCD0k0vOSks7ku3WQinEBXzuuhyBymolYD/d1Qm8kfMX3ogVMwTwr5W6CoUUbsoWCw7NHzqKN2qPB9t/fnVQhohhaWFTnhNAg7Ax1rFZtQJoCjoKPSH/xeFhgqqV3E/GQV2aJP8d+m8Q44ruuv6hEKmfoLGTWmgZlJsz+TKE+WYaXq0iVmOqmYZQy+JhTRA==;5:79/TQPMKBGbnXFu58lRo80ZcOqHa9uYHqhdYA9ZYHrPq28QbHimXIwIbTjwwdXUzNeXSpItlmaf0jYmoqU3RdvuRyvEF4UMngevHPzZJ+hVMhPjagybyC8DDoZojDbPqia4GIaFsFbhsGGHrUeqsrJrKpLfY2aluIiycPyQWd60=;7:Mdzal7/IeDMUYbys6aEFA7YWfMFht9Vo/r04xz5EKzglGx67vn8/+doKRvLyvB7xSprhu7Xc087IWRZYv5UmqaMy5S4DZ2TzbG3YNhb7jO7DqVj6xKjwir0BrBNTEdGloHm8XDIUKXT9PfLoKTIm6AsxWDOgfkEbiVh19VBa9qreoCT0ZzBSJImC8c0dkixMM967dh4fmdzADfjBeO/QwCYXbYQQDyj8TH4llea0cIEUyBhupMg/zLbEN9vsGzmg
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 3bacb0ad-f05c-461a-7c15-08d61d40b2e8
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB1357;
x-ms-traffictypediagnostic: VI1PR04MB1357:
x-microsoft-antispam-prvs: <VI1PR04MB1357C8656A941C150DF4D6D5991D0@VI1PR04MB1357.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(180628864354917)(9452136761055)(185117386973197)(85827821059158)(258649278758335);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231355)(944501410)(52105095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(201708071742011)(7699050);SRVR:VI1PR04MB1357;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB1357;
x-forefront-prvs: 0799B1B2D7
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(366004)(396003)(39860400002)(136003)(13464003)(189003)(199004)(6116002)(55236004)(76176011)(99286004)(7696005)(26005)(478600001)(11346002)(316002)(53936002)(54906003)(6506007)(486006)(476003)(86362001)(68736007)(446003)(110136005)(102836004)(93886005)(97736004)(186003)(256004)(9686003)(53546011)(7416002)(5660300001)(6436002)(105586002)(7736002)(305945005)(4326008)(5250100002)(2900100001)(81166006)(8936002)(106356001)(33656002)(6246003)(2906002)(229853002)(39060400002)(66066001)(74316002)(81156014)(25786009)(14454004)(3846002)(8676002)(55016002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB1357;H:VI1PR04MB1038.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: n3wROqtdDUy3N6TedwDqbfp+pFxgABJxhqbEQd3teTfyb0qZRxg/vdx290C+YETsuAtykd+fjAqNbTeuuayBiVkmzvzYudbe0RuTwc62YRL38F1Udn3cFqpibWjEbB1mIU6CDTUm9M+gZkXuVdGhVfoCfurix6YpMcRvVUiUXW+qqn68qHKhRa69yVhnyk0Y96WIMDjjylKORomm256thwFCrYY1XHH3zeDVQiTG4MteivSW/T4nCY/ia+C1yAqv36GX/k4itLK310B8/cVUTnB9g1DC1nxN3VJyFB34rLWqNh64gayuzogTK7Dcriu5PPnksIrnbvENhLu0km+OXZMyMekDNArfwpJR/JW2JZE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bacb0ad-f05c-461a-7c15-08d61d40b2e8
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2018 08:28:23.4321
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB1357
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgRnJpZWRlciwNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBGcmll
ZGVyIFNjaHJlbXBmIFttYWlsdG86ZnJpZWRlci5zY2hyZW1wZkBleGNlZXQuZGVdDQo+IFNlbnQ6
IFR1ZXNkYXksIFNlcHRlbWJlciAxOCwgMjAxOCAxOjUyIFBNDQo+IFRvOiBCb3JpcyBCcmV6aWxs
b24gPGJvcmlzLmJyZXppbGxvbkBib290bGluLmNvbT47IFlvZ2VzaCBOYXJheWFuIEdhdXINCj4g
PHlvZ2VzaG5hcmF5YW4uZ2F1ckBueHAuY29tPg0KPiBDYzogbGludXgtbXRkQGxpc3RzLmluZnJh
ZGVhZC5vcmc7IG1hcmVrLnZhc3V0QGdtYWlsLmNvbTsgbGludXgtDQo+IHNwaUB2Z2VyLmtlcm5l
bC5vcmc7IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOyByb2JoQGtlcm5lbC5vcmc7DQo+IG1h
cmsucnV0bGFuZEBhcm0uY29tOyBzaGF3bmd1b0BrZXJuZWwub3JnOyBsaW51eC1hcm0tDQo+IGtl
cm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOyBjb21wdXRlcnNmb3JwZWFjZUBnbWFpbC5jb207IGxp
bnV4LQ0KPiBrZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjIg
MS81XSBzcGk6IHNwaS1tZW06IEFkZCBkcml2ZXIgZm9yIE5YUCBGbGV4U1BJIGNvbnRyb2xsZXIN
Cj4gDQo+IEhpIEJvcmlzLCBZb2dlc2gsDQo+IA0KPiBPbiAxNy4wOS4yMDE4IDEzOjM3LCBCb3Jp
cyBCcmV6aWxsb24gd3JvdGU6DQo+ID4gSGkgWW9nZXNoLA0KPiA+DQo+ID4gT24gTW9uLCAxNyBT
ZXAgMjAxOCAxNToxODoyNiArMDUzMA0KPiA+IFlvZ2VzaCBHYXVyIDx5b2dlc2huYXJheWFuLmdh
dXJAbnhwLmNvbT4gd3JvdGU6DQo+ID4NCj4gPj4gKw0KPiA+PiArCS8qDQo+ID4+ICsJICogUi9X
IGZ1bmN0aW9ucyBmb3IgYmlnLSBvciBsaXR0bGUtZW5kaWFuIHJlZ2lzdGVyczoNCj4gPj4gKwkg
KiBUaGUgRlNQSSBjb250cm9sbGVyJ3MgZW5kaWFubmVzcyBpcyBpbmRlcGVuZGVudCBvZg0KPiA+
PiArCSAqIHRoZSBDUFUgY29yZSdzIGVuZGlhbm5lc3MuIFNvIGZhciwgYWx0aG91Z2ggdGhlIENQ
VQ0KPiA+PiArCSAqIGNvcmUgaXMgbGl0dGxlLWVuZGlhbiB0aGUgRlNQSSBjb250cm9sbGVyIGNh
biB1c2UNCj4gPj4gKwkgKiBiaWctZW5kaWFuIG9yIGxpdHRsZS1lbmRpYW4uDQo+ID4+ICsJICov
DQo+ID4+ICsJaWYgKG9mX3Byb3BlcnR5X3JlYWRfYm9vbChucCwgImJpZy1lbmRpYW4iKSkgew0K
PiA+PiArCQlmLT53cml0ZSA9IGZzcGlfd3JpdGVsX2JlOw0KPiA+PiArCQlmLT5yZWFkID0gZnNw
aV9yZWFkbF9iZTsNCj4gPj4gKwl9IGVsc2Ugew0KPiA+PiArCQlmLT53cml0ZSA9IGZzcGlfd3Jp
dGVsOw0KPiA+PiArCQlmLT5yZWFkID0gZnNwaV9yZWFkbDsNCj4gPj4gKwl9DQo+ID4NCj4gPiBI
bSwgaXNuJ3QgaXQgc29tZXRoaW5nIHlvdSBjYW4gZXh0cmFjdCBmcm9tIHRoZSBjb21wYXRpYmxl
IHN0cmluZz8gSSdkDQo+ID4gcmF0aGVyIG5vdCBhbGxvdyB1c2VycyB0byBzZXQgdGhhdCBpbiB0
aGVpciBEVCBpZiBpdCdzIG5vdCBzb21ldGhpbmcNCj4gPiB5b3UgY2FuIGNoYW5nZS4NCj4gDQo+
IFRoaXMgd2FzIGNvcGllZCBmcm9tIHRoZSBRU1BJIGRyaXZlciwgYnV0IEkgdGhpbmsgQm9yaXMg
aXMgcmlnaHQuIFRoaXMgc2VlbXMgdG8gYmUgYQ0KPiBmaXhlZCBTT0Mtc3BlY2lmaWMgc2V0dGlu
ZyBhbmQgd2Ugc2hvdWxkbid0IHNldCBpdCBpbiB0aGUgRFQuIFRoaXMgYXBwbGllcyB0byBRU1BJ
DQo+IGFuZCBGU1BJIGFsaWtlLg0KPiANCg0KWWVzLCBpdCBjYW4gYmUgbW9kaWZpZWQuIEluc3Rl
YWQgb2YgcmVhZGluZyBlbmRpYW5uZXNzIHByb3BlcnR5IGZyb20gZGV2aWNlIHRyZWUgY2FuIGJl
IG1vdmVkIHRvIHRoZSBwbGF0Zm9ybSBzdHJ1Y3R1cmUgbnhwX2ZzcGlfZGV2dHlwZV9kYXRhIHdo
aWNoIGlzIGxpbmtlZCB3aXRoIHRoZSBjb21wYXRpYmxlIHN0cmluZw0KeyAuY29tcGF0aWJsZSA9
ICJueHAsbHgyMTYwYS1mc3BpIiwgLmRhdGEgPSAodm9pZCAqKSZseDIxNjBhX2RhdGEsIH0NCg0K
VGhhbmtzLg0KDQpXb3VsZCBzZW5kIHRoZSBjaGFuZ2VzIGluIG5leHQgdmVyc2lvbi4NCg0KLS0N
ClJlZ2FyZHMsDQpZb2dlc2ggR2F1ci4NCg0KPiBSZWdhcmRzLA0KPiBGcmllZGVyDQo+IA0KPiA+
DQo+ID4gUmVnYXJkcywNCj4gPg0KPiA+IEJvcmlzDQo+ID4NCg==
