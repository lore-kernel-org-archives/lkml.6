Return-Path: <jun.li@nxp.com>
X-Cyrus-Session-Id: sloti22d1t05-3903807-1520838798-2-1028959122400354588
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, RCVD_IN_DNSWL_NONE -0.0001, SPF_HELO_PASS -0.001,
  SPF_PASS -0.001, LANGUAGES enda, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='40.107.0.51', Host='mail-eopbgr00051.outbound.protection.outlook.com',
  Country='NL', FromHeader='com', MailFrom='com', XOriginatingCountry='SG'
X-Spam-charsets: to='utf-8', plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: jun.li@nxp.com
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520838797; b=KsRu9413McP6v3nwuyUB8CiZ1zMQUwysDhwck/CNfYJbWBp
    Iw5++/uoeFvht5XipLZB+I/3+UVuOunRLZkUH8f3b5Wav7u8zzDWYZY1lEFNwSe8
    0WS3Zhf22V5pmf67VlP6esdStQljobU87AxHD2YpuyRjIQvkkG1Q/wRrJdaFQ66T
    kJ0wqVBX6o3L9pTK/Im6iDCXWQW/OVbBuZnKoCsg/G4sZ108GWpWkw3ZtQzc+BlP
    1bmQ+jZW5Spfvc9PyITTL9EISFuKcauAMZHfNd8dVt7176AT8QEiXEeMrjrIAbOa
    fsQpBk4Ky2flTOh528no+DKFHKGnEJb0rp8H2FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version; s=arctest; t=1520838797; bh=J+VgfnAN9aSDftupcUvNA
    utFtQI/25byRO3BrMh6faQ=; b=IkP67z+wHjYE00NN4wjMkqSkE7Kd2tAHg5Hxj
    0arg4E4XcYwPKQdpSxxQ5Kzi1iwkBUEE6db3TAoqheN1nNxL72meWxfzKrKiR49J
    mrj4S9WX0uoBCwmIHMDHX1xLPmzJc9wg6PuhwjcAOv8lqAaFlIlPbxw+hvp6cJDM
    mXkXx0zG7iQrYus8LpQCy5lO/TG28djpS5beDBuwwCxP/PfoH8DxzNS3ExR2B9Rp
    PnIIpQ+zZhNgPmu0BPgUPrQXxanVVOoP1SEjVXAAiNN5v9e2143CpUWjUzs46/wr
    bcL0xehrzDkR8/6YrD5wn/DX1Fg08LlBWuhRQX6y2IJ1SD8GQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=nxp.com header.i=@nxp.com header.b=qjt+VbDK x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=none,d=none) header.from=nxp.com;
    iprev=pass policy.iprev=40.107.0.51 (mail-eopbgr00051.outbound.protection.outlook.com);
    spf=pass smtp.mailfrom=jun.li@nxp.com smtp.helo=EUR02-AM5-obe.outbound.protection.outlook.com;
    x-aligned-from=pass;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=EUR02-AM5-obe.outbound.protection.outlook.com x-ptr-lookup=mail-eopbgr00051.outbound.protection.outlook.com;
    x-return-mx=pass smtp.domain=nxp.com smtp.result=pass smtp_is_org_domain=yes header.domain=nxp.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=nxp.com header.i=@nxp.com header.b=qjt+VbDK x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=none,d=none) header.from=nxp.com;
    iprev=pass policy.iprev=40.107.0.51 (mail-eopbgr00051.outbound.protection.outlook.com);
    spf=pass smtp.mailfrom=jun.li@nxp.com smtp.helo=EUR02-AM5-obe.outbound.protection.outlook.com;
    x-aligned-from=pass;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=EUR02-AM5-obe.outbound.protection.outlook.com x-ptr-lookup=mail-eopbgr00051.outbound.protection.outlook.com;
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
Thread-Index: AQHTtO2TvuhbiKnCtkaCXDhq065ky6PL/wvQgAAbPQCAAAZVIIAAFDsAgAABZiA=
Date: Mon, 12 Mar 2018 07:13:12 +0000
Message-ID: <VI1PR0402MB3917B8C71E99BCBDB2719EEB89D30@VI1PR0402MB3917.eurprd04.prod.outlook.com>
References: <1520301032-10109-1-git-send-email-leechu729@gmail.com>
 <VI1PR0402MB39170322F313A03DC0018A8089D30@VI1PR0402MB3917.eurprd04.prod.outlook.com>
 <CAFaeLdQDHSdeoG9fPVrBheohBGMkG-KirFtF-ra48AXfMWhVNw@mail.gmail.com>
 <VI1PR0402MB391795EEE76FBDCFDBD541BB89D30@VI1PR0402MB3917.eurprd04.prod.outlook.com>
 <CAFaeLdSBJ_SD9gtGbQsCchxQ03PBi3=6D4bjCpYrnm-xoRdvCg@mail.gmail.com>
In-Reply-To: <CAFaeLdSBJ_SD9gtGbQsCchxQ03PBi3=6D4bjCpYrnm-xoRdvCg@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [92.121.68.129]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR0402MB2782;7:xChd4LDwFjLPSOEp0REG2Wz+uwXmfPulgih//dL/irS3h447eZL/a8n0AKZk1jK/q9YoEeRlZaPNEXwqS4ZMKKRHSZiLFrPDCnf8YizhKrH6C/BnxVX9mi0h0uQsL9jMmKCSwsOVq1u7QumguKxz+FXU7o9RgiyRdnjW407b8N/xwj3sqzqu9xasUzGzGjGlTT511qlvYtVNSdngMnZUf1UBdLbCe9DYbGq/tNi2f1cWMERHwjRzXWcKDQs5XBYB
x-ms-exchange-antispam-srfa-diagnostics: SSOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 00d28beb-5ae0-463c-1dc1-08d587e8b778
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:VI1PR0402MB2782;
x-ms-traffictypediagnostic: VI1PR0402MB2782:
x-microsoft-antispam-prvs: <VI1PR0402MB2782FE4C4D3C6B3BF064A8C489D30@VI1PR0402MB2782.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(185117386973197)(85827821059158)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(10201501046)(3231220)(944501244)(52105095)(6055026)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123558120)(6072148)(201708071742011);SRVR:VI1PR0402MB2782;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0402MB2782;
x-forefront-prvs: 06098A2863
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39380400002)(396003)(376002)(366004)(39860400002)(346002)(377424004)(13464003)(199004)(189003)(6116002)(7736002)(305945005)(74316002)(93886005)(9686003)(55016002)(6436002)(5660300001)(6346003)(229853002)(26005)(2950100002)(6916009)(186003)(68736007)(33656002)(5250100002)(316002)(53546011)(6506007)(66066001)(106356001)(105586002)(102836004)(59450400001)(3846002)(1411001)(3660700001)(97736004)(478600001)(99286004)(76176011)(7696005)(4326008)(25786009)(2900100001)(39060400002)(8936002)(54906003)(6246003)(86362001)(3280700002)(2906002)(81166006)(8676002)(81156014)(14454004)(53936002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB2782;H:VI1PR0402MB3917.eurprd04.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
authentication-results: spf=none (sender IP is ) smtp.mailfrom=jun.li@nxp.com; 
x-microsoft-antispam-message-info: RkGwzMWvFzeKrmllO0vwrWHK/F7OoUB9AP0b34cX5TfsZ4wLfX8VcooVlkyDgf/S16Oj3/TdcJ92FpDIcWatj5jiGHZxFPYhxyVwlHpzW7eRTQfP2xuRpk3nGDKY/R3FGupeK8PgyGHsaoL166CG5gwewsteZcMeyrt16+PDuL8FFtIezGftTtHzyfK1OFu5kD2frUbw5tPxSqrGdrFbFO/+lLa+J1V9Lnhm6b9qi7k9Ee3yJRSPfAZ6t1vUytkZjXbjMm2K+UONiUIdsjiEofUqDvN0hBuJUOThC+JAcXH2gmbzPgLCm4VTUawn3wHM1pvisZkISCwQjBzh2Uh3Xg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00d28beb-5ae0-463c-1dc1-08d587e8b778
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2018 07:13:12.1808
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB2782
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IOadjuabuOW4hiBbbWFpbHRv
OmxlZWNodTcyOUBnbWFpbC5jb21dDQo+IFNlbnQ6IDIwMTjlubQz5pyIMTLml6UgMTQ6NTcNCj4g
VG86IEp1biBMaSA8anVuLmxpQG54cC5jb20+DQo+IENjOiBHcmVnIEtyb2FoLUhhcnRtYW4gPGdy
ZWdraEBsaW51eGZvdW5kYXRpb24ub3JnPjsNCj4gaGVpa2tpLmtyb2dlcnVzQGxpbnV4LmludGVs
LmNvbTsgbGludXhAcm9lY2stdXMubmV0OyBncmVnQGtyb2FoLmNvbTsNCj4gc2h1ZmFuX2xlZUBy
aWNodGVrLmNvbTsgY3lfaHVhbmdAcmljaHRlay5jb207DQo+IGxpbnV4LWtlcm5lbEB2Z2VyLmtl
cm5lbC5vcmc7IGxpbnV4LXVzYkB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRD
SCB2N10gc3RhZ2luZzogdHlwZWM6IGhhbmRsZSB2ZW5kb3IgZGVmaW5lZCBwYXJ0IGFuZCBtb2Rp
ZnkNCj4gZHJwIHRvZ2dsaW5nIGZsb3cNCj4gDQo+IEhpIEp1biwNCj4gDQo+IDIwMTgtMDMtMTIg
MTM6NTggR01UKzA4OjAwIEp1biBMaSA8anVuLmxpQG54cC5jb20+Og0KPiA+IEhpDQo+ID4+IC0t
LS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4+IEZyb206IOadjuabuOW4hiBbbWFpbHRvOmxl
ZWNodTcyOUBnbWFpbC5jb21dDQo+ID4+IFNlbnQ6IDIwMTjlubQz5pyIMTLml6UgMTM6MjINCj4g
Pj4gVG86IEp1biBMaSA8anVuLmxpQG54cC5jb20+DQo+ID4+IENjOiBHcmVnIEtyb2FoLUhhcnRt
YW4gPGdyZWdraEBsaW51eGZvdW5kYXRpb24ub3JnPjsNCj4gPj4gaGVpa2tpLmtyb2dlcnVzQGxp
bnV4LmludGVsLmNvbTsgbGludXhAcm9lY2stdXMubmV0OyBncmVnQGtyb2FoLmNvbTsNCj4gPj4g
c2h1ZmFuX2xlZUByaWNodGVrLmNvbTsgY3lfaHVhbmdAcmljaHRlay5jb207DQo+ID4+IGxpbnV4
LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LXVzYkB2Z2VyLmtlcm5lbC5vcmcNCj4gPj4g
U3ViamVjdDogUmU6IFtQQVRDSCB2N10gc3RhZ2luZzogdHlwZWM6IGhhbmRsZSB2ZW5kb3IgZGVm
aW5lZCBwYXJ0DQo+ID4+IGFuZCBtb2RpZnkgZHJwIHRvZ2dsaW5nIGZsb3cNCj4gPj4NCj4gPj4g
SGkgSnVuLA0KPiA+Pg0KPiA+PiAgIFRoYW5rIHlvdS4NCj4gPj4NCj4gPj4gMjAxOC0wMy0xMiAx
MjozMyBHTVQrMDg6MDAgSnVuIExpIDxqdW4ubGlAbnhwLmNvbT46DQo+ID4+ID4gSGksDQo+ID4+
ID4NCj4gPj4gPj4gK3N0YXRpYyBpcnFyZXR1cm5fdCBfdGNwY2lfaXJxKGludCBpcnEsIHZvaWQg
KmRldl9pZCkgew0KPiA+PiA+PiArICAgICBzdHJ1Y3QgdGNwY2kgKnRjcGNpID0gZGV2X2lkOw0K
PiA+PiA+PiArDQo+ID4+ID4+ICsgICAgIHJldHVybiB0Y3BjaV9pcnEodGNwY2kpOw0KPiA+PiA+
PiArfQ0KPiA+PiA+Pg0KPiA+PiA+IC4uLg0KPiA+PiA+DQo+ID4+ID4+ICsgICAgIGVyciA9IGRl
dm1fcmVxdWVzdF90aHJlYWRlZF9pcnEoJmNsaWVudC0+ZGV2LCBjbGllbnQtPmlycSwgTlVMTCwN
Cj4gPj4gPj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBfdGNwY2lfaXJx
LA0KPiA+PiA+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIElSUUZfT05F
U0hPVCB8DQo+ID4+IElSUUZfVFJJR0dFUl9MT1csDQo+ID4+ID4+IC0gICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgZGV2X25hbWUodGNwY2ktPmRldiksDQo+IHRjcGNpKTsNCj4g
Pj4gPj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBkZXZfbmFtZSgmY2xp
ZW50LT5kZXYpLA0KPiA+PiA+PiArIGNoaXApOw0KPiA+PiA+DQo+ID4+ID4gLSBkZXZfbmFtZSgm
Y2xpZW50LT5kZXYpLCBjaGlwKTsNCj4gPj4gPiArIGRldl9uYW1lKCZjbGllbnQtPmRldiksIGNo
aXAtPnRjcGNpKTsNCj4gPj4gPg0KPiA+PiA+IERpZCB5b3UgZXZlciB0ZXN0IHRoaXMgcGF0Y2g/
DQo+ID4+IEkndmUgdGVzdGVkIHRoaXMgcGF0Y2ggd2l0aCB0Y3BjaV9ydDE3MTFoLmMgdGhhdCB3
aWxsIGJlIHNlbnQgb3V0IGZvcg0KPiA+PiByZXZpZXdpbmcgaW4gdGhlIG5leHQgcGF0Y2ggYWZ0
ZXIgdGNwY2kncyBtb2RpZmljYXRpb24gaXMgcGFzc2VkLg0KPiA+PiBCZWNhdXNlIGludGVycnVw
dCBoYW5kbGVyIGlzIHJlZ2lzdGVyZWQgaW4gdGNwY2lfcnQxNzExaC5jLCBoZXJlIGlzDQo+ID4+
IHRoZSBwbGFjZSBJIGRpZG4ndCBub3RpY2UuDQo+ID4NCj4gPiBVbmRlcnN0b29kLg0KPiA+DQo+
ID4+IFRoZSBpbnRlcnJ1cHQgaGFuZGxlciBmb3IgdGNwY2kuYyBzaG91bGQgYmUgbW9kaWZpZWQg
YXMgZm9sbG93aW5nOg0KPiA+PiAgc3RhdGljIGlycXJldHVybl90IF90Y3BjaV9pcnEoaW50IGly
cSwgdm9pZCAqZGV2X2lkKSAgew0KPiA+PiAtICAgICAgIHN0cnVjdCB0Y3BjaSAqdGNwY2kgPSBk
ZXZfaWQ7DQo+ID4+ICsgICAgICAgc3RydWN0IHRjcGNpX2NoaXAgKmNoaXAgPSBkZXZfaWQ7DQo+
ID4+DQo+ID4+IC0gICAgICAgcmV0dXJuIHRjcGNpX2lycSh0Y3BjaSk7DQo+ID4+ICsgICAgICAg
cmV0dXJuIHRjcGNpX2lycShjaGlwLT50Y3BjaSk7DQo+ID4+ICB9DQo+ID4+DQo+ID4NCj4gPiBF
aXRoZXIgd2F5IGlzIE9LIHRvIGZpeCBpdC4NCj4gPiBZb3UgbWF5IHNlbmQgb3V0IHlvdXIgdjgg
YW5kIG5vdGlmeSBHcmVnIHRvIGRyb3AgeW91ciB2NyB2ZXJzaW9uLg0KPiA+DQo+ID4gSnVuIExp
DQo+IA0KPiBNYXkgSSBhZGQgeW91IGluIHRoZSBSZXBvcnRlZC1ieSBsaXN0Pw0KDQpJIGp1c3Qg
Z2F2ZSBhIHJ1biB3aXRoIHlvdXIgcGF0Y2ggb24gbXkgSFcsIHNvIGZvciB5b3VyIG5ldyB2ZXJz
aW9uLA0KeW91IGNhbiBkaXJlY3RseSBhZGQ6DQoNClJldmlld2VkLWJ5OiBMaSBKdW4gPGp1bi5s
aUBueHAuY29tPg0KVGVzdGVkLWJ5OiBMaSBKdW4gPGp1bi5saUBueHAuY29tPg0KDQo+IA0KPiAt
LQ0KPiBCZXN0IFJlZ2FyZHMsDQo+IOabuOW4hg0K
