Return-Path: <decui@microsoft.com>
X-Google-Smtp-Source: AB8JxZqnujpYRZTo96Eoua7pjXVmSJrg4peiGWcdtL87hWHBT8tXKIhtixJSgy3WM+yS+REYrTNw
ARC-Seal: i=1; a=rsa-sha256; t=1526415029; cv=none;
        d=google.com; s=arc-20160816;
        b=sNdSQXS7Cp5CThhsf3ZVLqXdL3dJiZ8rB2kESdhM0VrFmSxhmaq4cd3BJi/vNLrRYn
         ccyKWR2i/afDHwUGTyBjAGDoG+C7NzGKCy3YioXw4ZSHrkX0faLDzchQMGgYtbjJ8v4w
         KZfvIKcDAywfrhJ6Nt/DfCQw0JWuheo8FvTmGWD+kBoJtbHhlfKUwAY3lqpURN5kl0pl
         HG3PAKAPM3uXiXjvmMn3gwP8ioL5p5CKKWKwdf1wARG9OClH9VRDatk+1j2h9mSX9VMa
         Pp6ZOFQMSTO8Ma0Pr7V7sCWI2B3TVkMW44jqhV0PXsZKi7Guwt1J2zjiZgPxiRuD8+p1
         RJWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:spamdiagnosticmetadata
         :spamdiagnosticoutput:msip_labels:content-language:accept-language
         :in-reply-to:references:message-id:date:thread-index:thread-topic
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=rKMUooUSYzOL4W1qJp6qS8PJUx+8UO1Rq24Az2BuzEc=;
        b=Cbl845T74P2CDHnKxDnvr6GfLGxx/AEmmTNoykHQ7JwAIkGiWoOSRYgjw6hbkWA6Ea
         dGv99QNkSXHJN4NLFSRBNlyWtjIXdR63MbpeeAL6VgdCQfHEPl7H1kaWL+bmC8yd3Vre
         UYWsGORiybVbGNT6DpG41pZQMJ2NKwwqL4Fj4uN5rlMaSAic8oS7PlQDc1zfRoeCzAll
         LMV0mqwQwVQSYHGgWUlCAYbgaYYRs0+3xKyIz1teJDwmsd4Cgd1Vt1DDWwkSClsQTY90
         oHWk/G145vTJA+Gb7zJp+qBcDNo6hgovOOuotHIIwV1obJiPrGoS7pG8wtVXns4eE9dB
         qffQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@microsoft.com header.s=selector1 header.b=BGDpX5f7;
       spf=pass (google.com: domain of decui@microsoft.com designates 104.47.126.71 as permitted sender) smtp.mailfrom=decui@microsoft.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=microsoft.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@microsoft.com header.s=selector1 header.b=BGDpX5f7;
       spf=pass (google.com: domain of decui@microsoft.com designates 104.47.126.71 as permitted sender) smtp.mailfrom=decui@microsoft.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=microsoft.com
From: Dexuan Cui <decui@microsoft.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
CC: Ingo Molnar <mingo@kernel.org>, Alexey Dobriyan <adobriyan@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>, Peter Zijlstra
	<peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Rakib Mullick
	<rakib.mullick@gmail.com>, Linux Kernel Mailing List
	<linux-kernel@vger.kernel.org>
Subject: RE: for_each_cpu() is buggy for UP kernel?
Thread-Topic: for_each_cpu() is buggy for UP kernel?
Thread-Index: AQHT6/knJa5WstrYJkq8AbGhuJkM9KQxCm6AgAAuagA=
Date: Tue, 15 May 2018 20:10:22 +0000
Message-ID: <KL1P15301MB0006432F17DE0DB6ABA80EDEBF930@KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM>
References: <KL1P15301MB000678289FE55BA365B3279ABF990@KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM>
 <CA+55aFx5_qcUHBQ50RfOnH+pS=jqA_Wg2YYCcm=fTXRFJjs3rg@mail.gmail.com>
 <SG2P15301MB0015F23FF0E44BE991E8C38EBF930@SG2P15301MB0015.APCP153.PROD.OUTLOOK.COM>
 <CA+55aFziNcDmN=DT7efKYGU-AZC535GDVKh57bC7UHaFff3vRw@mail.gmail.com>
In-Reply-To: <CA+55aFziNcDmN=DT7efKYGU-AZC535GDVKh57bC7UHaFff3vRw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=decui@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2018-05-15T20:10:19.9553643Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic;
 Sensitivity=General
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com;
x-originating-ip: [131.107.147.147]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;KL1P15301MB0022;7:i2v8l3diggeKuNV1bdqq1FxBi20PNRVjNP9BHiCEKmtI2W6L1SW2nivaNGwLTxpg6d+c78U/rMM3n/gZ1dIL8tIDjz7/xJsl1EtZlA5IURBsOSfjFR2FgzzeV2COGsMseT4w1AmjxZ4wKM+GkxdTnZRbI2KM7CFxvoXyYjyQuBCWmK9O1UKpCnqC9nXc/0wEWwHIfq3mPgVsBvDsTXBdV/NWQORuYRv4JV6JN8j0EF6ddDpPEY2paV8Z1vW2jIts;20:Lcw3ptvfK6t9sSsGJpGIhgmAMiTux4qj0zX3RniA+MdWNSlo3B9+AdG3D/Nsg2H6z0Cd53e9vZyW4IVpBd7bKbE54TceOzik2ScOKLrjiuEtfoJ01vutiknJALY3MfodLgO5kPTnOpngLxROvRDV3EjYgC1w0N4ZWgXDvYgSxk8=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(2017052603328)(7193020);SRVR:KL1P15301MB0022;
x-ms-traffictypediagnostic: KL1P15301MB0022:
x-o365eop-header: O365_EOP: Allow for Unauthenticated Relay
x-o365ent-eop-header: Message processed by -  O365_ENT: Allow from ranges
 (Engineering ONLY)
x-microsoft-antispam-prvs: <KL1P15301MB0022E2EF758D86DC0FA06F19BF930@KL1P15301MB0022.APCP153.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231254)(944501410)(52105095)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:KL1P15301MB0022;BCL:0;PCL:0;RULEID:;SRVR:KL1P15301MB0022;
x-forefront-prvs: 0673F5BE31
x-forefront-antispam-report: SFV:NSPM;SFS:(10009001)(6009001)(428001)(377454003)(164054003)(51704005)(24454002)(41574002)(199002)(189002)(20776003)(69226001)(63696002)(74876001)(74706001)(33656001)(76786001)(76796001)(81542001)(54356001)(93136001)(92566001)(46102001)(64706001)(81342001)(92726001)(15975445006)(77982001)(59766001)(56816005)(80022001)(66066001)(76482001)(90146001)(65816001)(87936001)(56776001)(54316002)(74366001)(44376005)(87266001)(2656002)(4396001)(47976001)(50986001)(95666003)(49866001)(47736001)(51856001)(85306002)(79102001)(85852003)(83072002)(21056001)(97336001)(94946001)(93516002)(95416001)(94316002)(86362001)(97186001)(80976001)(81686001)(83322001)(19580405001)(81816001)(86612001)(31966008)(74662001)(19580395003)(53806001)(74502001)(47446002);DIR:OUT;SFP:1101;SCL:1;SRVR:KL1P15301MB0022;H:KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: eycEeFUkkF/up26eo1qy/BD8vnTyKujXRltgHGE320Lzl3TZ04PUk618qDPjdSc4hNLzH67iSynI6SLgoLS72B2rt5u/5ygW00DpQgSKCefRgrXWym8eWzRWCRCkX5Jz70Tav+gCSwulR258v4g7nEN90TRk9d+oB5AnpA5Yk7gJRwgyssjpBQLl5X5zm1dU
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: aef3692b-2135-4c3d-b47b-08d5ba9fe414
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aef3692b-2135-4c3d-b47b-08d5ba9fe414
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2018 20:10:22.7688
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1P15301MB0022
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599966610262155638?=
X-GMAIL-MSGID: =?utf-8?q?1600562166473295232?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

PiBGcm9tOiBMaW51cyBUb3J2YWxkcyA8dG9ydmFsZHNAbGludXgtZm91bmRhdGlvbi5vcmc+DQo+
IFNlbnQ6IFR1ZXNkYXksIE1heSAxNSwgMjAxOCAxMDoyMg0KPiBUbzogRGV4dWFuIEN1aSA8ZGVj
dWlAbWljcm9zb2Z0LmNvbT4NCj4gDQo+IE9uIE1vbiwgTWF5IDE0LCAyMDE4IGF0IDg6MDIgUE0g
RGV4dWFuIEN1aSA8ZGVjdWlAbWljcm9zb2Z0LmNvbT4gd3JvdGU6DQo+IA0KPiA+IElmIHlvdSdy
ZSBPSyB3aXRoIHRoZSBiZWxvdyBmaXggKG5vdCB0ZXN0ZWQgeWV0KSwgSSdsbCBzdWJtaXQgYSBw
YXRjaCBmb3IgaXQ6DQo+IA0KPiA+IC0tLSBhL2tlcm5lbC90aW1lL3RpY2stYnJvYWRjYXN0LmMN
Cj4gPiArKysgYi9rZXJuZWwvdGltZS90aWNrLWJyb2FkY2FzdC5jDQo+ID4gQEAgLTYxNiw2ICs2
MTYsMTAgQEAgc3RhdGljIHZvaWQgdGlja19oYW5kbGVfb25lc2hvdF9icm9hZGNhc3Qoc3RydWN0
DQo+IGNsb2NrX2V2ZW50X2RldmljZSAqZGV2KQ0KPiA+ICAgICAgICAgIG5vdyA9IGt0aW1lX2dl
dCgpOw0KPiA+ICAgICAgICAgIC8qIEZpbmQgYWxsIGV4cGlyZWQgZXZlbnRzICovDQo+ID4gICAg
ICAgICAgZm9yX2VhY2hfY3B1KGNwdSwgdGlja19icm9hZGNhc3Rfb25lc2hvdF9tYXNrKSB7DQo+
ID4gKyNpZm5kZWYgQ09ORklHX1NNUA0KPiA+ICsgICAgICAgICAgICAgICBpZiAoY3B1bWFza19l
bXB0eSh0aWNrX2Jyb2FkY2FzdF9vbmVzaG90X21hc2spKQ0KPiA+ICsgICAgICAgICAgICAgICAg
ICAgICAgIGJyZWFrOw0KPiA+ICsjZW5kaWYNCj4gDQo+IEknbSBjZXJ0YWlubHkgb2sgd2l0aCB0
aGlzLiBJdCdzIGhhY2t5LCBidXQgbWF5YmUgYmVpbmcgZXhwbGljaXRseSBoYWNreSBpcw0KPiBn
b29kIHRvICJkb2N1bWVudCIgdGhpcyBnb3RjaGEuDQo+IA0KPiBBbmQgSSByZWFsbHkgZG8gYWdy
ZWUgdGhhdCB0aGlzIHNwZWNpYWwgVVAgY2FzZSBpcyBuYXN0eSBuYXN0eSBhbmQgbXVjaCB0b28N
Cj4gc3VidGxlLCBhbmQgSSBob3BlIHRoYXQgc29tZSBkYXkgd2Ugd29uJ3QgY2FyZSBhYm91dCBV
UCBhdCBhbGwsIGFuZCBtYXliZQ0KPiBraWxsIGl0LCBvciBtYXliZSBqdXN0IG1ha2UgZm9yX2Vh
Y2hfY3B1KCkgZ2VuZXJhdGUgdGhlIGV4dHJhIGNvZGUgdG8gaGF2ZQ0KPiB0aGUgYWN0dWFsIHNh
bWUgc2VtYW50aWNzIGFzIHRoZSBTTVAgY2FzZS4NCj4gDQo+ICAgICAgICAgICAgICAgICAgIExp
bnVzDQoNClRoYW5rcyEgSSBzdWJtaXR0ZWQgdGhlIHBhdGNoIGp1c3Qgbm93OiBodHRwczovL2xr
bWwub3JnL2xrbWwvMjAxOC81LzE1Lzg2NiANCg0KVGhhbmtzLA0KLS0gRGV4dWFuDQo=
