Return-Path: <jun.li@nxp.com>
X-Cyrus-Session-Id: sloti22d1t05-3703740-1520834344-2-424927901356111539
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, RCVD_IN_DNSWL_NONE -0.0001, RCVD_IN_MSPIKE_H4 -0.01,
  RCVD_IN_MSPIKE_WL -0.01, SPF_HELO_PASS -0.001, SPF_PASS -0.001,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='104.47.1.50',
  Host='mail-ve1eur01on0050.outbound.protection.outlook.com', Country='AT',
  FromHeader='com', MailFrom='com', XOriginatingCountry='SG'
X-Spam-charsets: to='utf-8', plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: jun.li@nxp.com
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520834343; b=rXmfx9xzwvriF8J7LZGRoGBA/MOWxAyxQPJpWIc1fMR8udT
    ya12NtBGLZOa+jYCcEp70RhRI/dW0ms6lt0bqxx78rPJScjp29UwSrfu4qaj4HlM
    gynC4qHg/AV46xdCp+Z7neiKW9GPeqDSt49yMnhgHXiz3NppNoFgxo9WqzCBEC/+
    BypkN4oMYPxcfelmmKy6axK6O7qymZdfoW7BLQvfFTF6Y1xdEvXgyOnVj6E6Kt6L
    qDjUYMHy6PlHpSsuhGjtgZV4ua5tirt01S7wT2P6SneSB66IisEBqLihhO7/+8mF
    yYmKQN5LhZPkodZXlGBKj40ZH+CRLZ2UnDX0MZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version; s=arctest; t=1520834343; bh=+hQgjHNF67uFT6tJryRh3
    mmWuC78Gri6D8osy4exOgg=; b=MT1yG8JAM4hnrMa2G+CjA3Y5PlATkTzn5Puie
    I5ZP4qp3cqWJcoUNSAOo0RmEwX1rZNuQDQXczwAAZ0sZBCmbKL0vMaWZuOnZDUMr
    +uaYt3UOXLCReBm0wBNt8zpr49EU+nH0hte1Irj4kr5eHP7i+n2UVyZhZ7kDk3/a
    sdb9xpyoGrtxwKJt/Cl1NFs10+RpGkEClOyjybyq3UFD089zvhK2mRHC3VbB0XLg
    BebE9+YJ2M8I2ZU3E2SQh6ZBRo3yNCkeDXQbKKaBYqzcsf1k2RKsDQGAgzfka8Ve
    /oRub6RMwaFBQy0zdukDdzWQzlMGD3oK9G0kEvpLIYHT0CUEw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=nxp.com header.i=@nxp.com header.b=pqeOPW9O x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=none,d=none) header.from=nxp.com;
    iprev=pass policy.iprev=104.47.1.50 (mail-ve1eur01on0050.outbound.protection.outlook.com);
    spf=pass smtp.mailfrom=jun.li@nxp.com smtp.helo=EUR01-VE1-obe.outbound.protection.outlook.com;
    x-aligned-from=pass;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=EUR01-VE1-obe.outbound.protection.outlook.com x-ptr-lookup=mail-ve1eur01on0050.outbound.protection.outlook.com;
    x-return-mx=pass smtp.domain=nxp.com smtp.result=pass smtp_is_org_domain=yes header.domain=nxp.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=nxp.com header.i=@nxp.com header.b=pqeOPW9O x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=none,d=none) header.from=nxp.com;
    iprev=pass policy.iprev=104.47.1.50 (mail-ve1eur01on0050.outbound.protection.outlook.com);
    spf=pass smtp.mailfrom=jun.li@nxp.com smtp.helo=EUR01-VE1-obe.outbound.protection.outlook.com;
    x-aligned-from=pass;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=EUR01-VE1-obe.outbound.protection.outlook.com x-ptr-lookup=mail-ve1eur01on0050.outbound.protection.outlook.com;
    x-return-mx=pass smtp.domain=nxp.com smtp.result=pass smtp_is_org_domain=yes header.domain=nxp.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128
From: Jun Li <jun.li@nxp.com>
To: =?utf-8?B?5p2O5pu45biG?= <leechu729@gmail.com>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"heikki.krogerus@linux.intel.com" <heikki.krogerus@linux.intel.com>,
	"linux@roeck-us.net" <linux@roeck-us.net>, "greg@kroah.com" <greg@kroah.com>,
	"shufan_lee@richtek.com" <shufan_lee@richtek.com>, "cy_huang@richtek.com"
	<cy_huang@richtek.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-usb@vger.kernel.org"
	<linux-usb@vger.kernel.org>
Subject: RE: [PATCH v7] staging: typec: handle vendor defined part and modify
 drp toggling flow
Thread-Topic: [PATCH v7] staging: typec: handle vendor defined part and modify
 drp toggling flow
Thread-Index: AQHTtO2TvuhbiKnCtkaCXDhq065ky6PL/wvQgAAbPQCAAAZVIA==
Date: Mon, 12 Mar 2018 05:58:56 +0000
Message-ID: <VI1PR0402MB391795EEE76FBDCFDBD541BB89D30@VI1PR0402MB3917.eurprd04.prod.outlook.com>
References: <1520301032-10109-1-git-send-email-leechu729@gmail.com>
 <VI1PR0402MB39170322F313A03DC0018A8089D30@VI1PR0402MB3917.eurprd04.prod.outlook.com>
 <CAFaeLdQDHSdeoG9fPVrBheohBGMkG-KirFtF-ra48AXfMWhVNw@mail.gmail.com>
In-Reply-To: <CAFaeLdQDHSdeoG9fPVrBheohBGMkG-KirFtF-ra48AXfMWhVNw@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is ) smtp.mailfrom=jun.li@nxp.com; 
x-originating-ip: [92.121.68.129]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR0402MB2896;7:PMx/nDTxmuhgaIL07XuqUAloK++f7wfBxTgxkWos5GdpRxPxVNeRleL1dhQsKePt+5E7SZjZDI2lCwnw74cE14tixxbZFeS5xo4N0F7bm4MZo2FkCVM3JA8cRzWQFNOGN7hP9ZbKa2QKsp9DhA51zdsfUPYuXlK0r3CPzO+k4gQu66YdIvZN5+SeXiTJXBhiI/e0a8WyNx3osiuM8QjkVV5J9XzM2QNM92QXUsimc1ib0cz/r1lE1hYFQ9447f41
x-ms-exchange-antispam-srfa-diagnostics: SSOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: bb040a1f-6641-4954-55ad-08d587de57af
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:VI1PR0402MB2896;
x-ms-traffictypediagnostic: VI1PR0402MB2896:
x-microsoft-antispam-prvs: <VI1PR0402MB2896AADEC49A844486156E0889D30@VI1PR0402MB2896.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(185117386973197)(85827821059158)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(3231220)(944501244)(52105095)(10201501046)(6055026)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123564045)(6072148)(201708071742011);SRVR:VI1PR0402MB2896;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0402MB2896;
x-forefront-prvs: 06098A2863
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(39860400002)(346002)(396003)(39380400002)(366004)(377424004)(199004)(189003)(13464003)(26005)(3280700002)(25786009)(5250100002)(186003)(3660700001)(102836004)(6506007)(6436002)(54906003)(4326008)(39060400002)(14454004)(478600001)(86362001)(2950100002)(6916009)(68736007)(8936002)(53546011)(1411001)(99286004)(97736004)(5660300001)(2900100001)(81166006)(81156014)(33656002)(76176011)(316002)(106356001)(105586002)(55016002)(74316002)(9686003)(7736002)(305945005)(59450400001)(2906002)(53936002)(8676002)(6116002)(229853002)(7696005)(66066001)(6246003)(3846002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB2896;H:VI1PR0402MB3917.eurprd04.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:3;LANG:en;
x-microsoft-antispam-message-info: ZVqccxtN4iobwwqA1tBYj0vVbWn/EnVZOs8QpogTbOnpNt60EHoLTrzCX3giInVaSS4quXWd4ZzxF6K4puTfkK8yh3jBI6K2gGE9I2sxpZRm5Jy6dlYI8VR2pfLIjqb2cy7k0YG0vopq6KSin1oA/D3oQLkOKE90LJxaNdGH6OBDVezmT8f77fpLHuM8Eub8x03xeFaRGthwAJt6oufiI9UgCUKvECG64bTRcRMFFuQcZN1j3AjKRhnkT0j1NMa/xRTo+7EUqLCIHHZPY9WR/BXd63yJvCylWSgBoFAWj55q3/6R04CAs/WdaWLzbI9ivSMyx8lzllidve1F+0xmJQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb040a1f-6641-4954-55ad-08d587de57af
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2018 05:58:56.5141
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB2896
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

SGkNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTog5p2O5pu45biGIFttYWls
dG86bGVlY2h1NzI5QGdtYWlsLmNvbV0NCj4gU2VudDogMjAxOOW5tDPmnIgxMuaXpSAxMzoyMg0K
PiBUbzogSnVuIExpIDxqdW4ubGlAbnhwLmNvbT4NCj4gQ2M6IEdyZWcgS3JvYWgtSGFydG1hbiA8
Z3JlZ2toQGxpbnV4Zm91bmRhdGlvbi5vcmc+Ow0KPiBoZWlra2kua3JvZ2VydXNAbGludXguaW50
ZWwuY29tOyBsaW51eEByb2Vjay11cy5uZXQ7IGdyZWdAa3JvYWguY29tOw0KPiBzaHVmYW5fbGVl
QHJpY2h0ZWsuY29tOyBjeV9odWFuZ0ByaWNodGVrLmNvbTsNCj4gbGludXgta2VybmVsQHZnZXIu
a2VybmVsLm9yZzsgbGludXgtdXNiQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BB
VENIIHY3XSBzdGFnaW5nOiB0eXBlYzogaGFuZGxlIHZlbmRvciBkZWZpbmVkIHBhcnQgYW5kIG1v
ZGlmeQ0KPiBkcnAgdG9nZ2xpbmcgZmxvdw0KPiANCj4gSGkgSnVuLA0KPiANCj4gICBUaGFuayB5
b3UuDQo+IA0KPiAyMDE4LTAzLTEyIDEyOjMzIEdNVCswODowMCBKdW4gTGkgPGp1bi5saUBueHAu
Y29tPjoNCj4gPiBIaSwNCj4gPg0KPiA+PiArc3RhdGljIGlycXJldHVybl90IF90Y3BjaV9pcnEo
aW50IGlycSwgdm9pZCAqZGV2X2lkKSB7DQo+ID4+ICsgICAgIHN0cnVjdCB0Y3BjaSAqdGNwY2kg
PSBkZXZfaWQ7DQo+ID4+ICsNCj4gPj4gKyAgICAgcmV0dXJuIHRjcGNpX2lycSh0Y3BjaSk7DQo+
ID4+ICt9DQo+ID4+DQo+ID4gLi4uDQo+ID4NCj4gPj4gKyAgICAgZXJyID0gZGV2bV9yZXF1ZXN0
X3RocmVhZGVkX2lycSgmY2xpZW50LT5kZXYsIGNsaWVudC0+aXJxLCBOVUxMLA0KPiA+PiArICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIF90Y3BjaV9pcnEsDQo+ID4+ICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgSVJRRl9PTkVTSE9UIHwNCj4gSVJRRl9U
UklHR0VSX0xPVywNCj4gPj4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBk
ZXZfbmFtZSh0Y3BjaS0+ZGV2KSwgdGNwY2kpOw0KPiA+PiArICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIGRldl9uYW1lKCZjbGllbnQtPmRldiksIGNoaXApOw0KPiA+DQo+ID4g
LSBkZXZfbmFtZSgmY2xpZW50LT5kZXYpLCBjaGlwKTsNCj4gPiArIGRldl9uYW1lKCZjbGllbnQt
PmRldiksIGNoaXAtPnRjcGNpKTsNCj4gPg0KPiA+IERpZCB5b3UgZXZlciB0ZXN0IHRoaXMgcGF0
Y2g/DQo+IEkndmUgdGVzdGVkIHRoaXMgcGF0Y2ggd2l0aCB0Y3BjaV9ydDE3MTFoLmMgdGhhdCB3
aWxsIGJlIHNlbnQgb3V0IGZvciByZXZpZXdpbmcgaW4NCj4gdGhlIG5leHQgcGF0Y2ggYWZ0ZXIg
dGNwY2kncyBtb2RpZmljYXRpb24gaXMgcGFzc2VkLg0KPiBCZWNhdXNlIGludGVycnVwdCBoYW5k
bGVyIGlzIHJlZ2lzdGVyZWQgaW4gdGNwY2lfcnQxNzExaC5jLCBoZXJlIGlzIHRoZSBwbGFjZSBJ
DQo+IGRpZG4ndCBub3RpY2UuDQoNClVuZGVyc3Rvb2QuDQoNCj4gVGhlIGludGVycnVwdCBoYW5k
bGVyIGZvciB0Y3BjaS5jIHNob3VsZCBiZSBtb2RpZmllZCBhcyBmb2xsb3dpbmc6DQo+ICBzdGF0
aWMgaXJxcmV0dXJuX3QgX3RjcGNpX2lycShpbnQgaXJxLCB2b2lkICpkZXZfaWQpICB7DQo+IC0g
ICAgICAgc3RydWN0IHRjcGNpICp0Y3BjaSA9IGRldl9pZDsNCj4gKyAgICAgICBzdHJ1Y3QgdGNw
Y2lfY2hpcCAqY2hpcCA9IGRldl9pZDsNCj4gDQo+IC0gICAgICAgcmV0dXJuIHRjcGNpX2lycSh0
Y3BjaSk7DQo+ICsgICAgICAgcmV0dXJuIHRjcGNpX2lycShjaGlwLT50Y3BjaSk7DQo+ICB9DQo+
IA0KDQpFaXRoZXIgd2F5IGlzIE9LIHRvIGZpeCBpdC4NCllvdSBtYXkgc2VuZCBvdXQgeW91ciB2
OCBhbmQgbm90aWZ5IEdyZWcgdG8gZHJvcCB5b3VyIHY3IHZlcnNpb24uDQoNCkp1biBMaQ0K
