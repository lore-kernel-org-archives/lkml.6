Return-Path: <JOLLYS@xilinx.com>
X-Google-Smtp-Source: AB8JxZrsxb66+S3JbTmXZY/a/Jf3zesFxhrI3BX3FNCfuAUnlNKg0sccw7vBio3pDDv5FF5n00uZ
ARC-Seal: i=1; a=rsa-sha256; t=1526325531; cv=none;
        d=google.com; s=arc-20160816;
        b=KUJQSByjguJVHtT9QbLEMYAEKq5CoXZTr0B4APFdvU6mxmA8Qm+zWGAnG6lW3bzLn8
         rvrvZ52sBKiNuilPUkn+G79xzhZ0LWgKtD6lPFs9HVO9M15vVBIEyTp7UGVTgThzmZPj
         BpcVq1FgB64xgr2KSemz1tL+Csh6+GjiTBU01Z2nTghBP2T8vt0+5HFktuQZ/jhqGyx6
         Hu/LFxVM8UovKK25hQte8LqXnoO7T3XzNRIa6F21pDYsz89/Dfr2F4ndBNrk3O1QH4kl
         V84KgoPY+cgoUWLMPMYfj6twd+ErwkMEgrYqIDb43dA8UgGImw83Hx8yPh/PcTKJT6cS
         7MOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:spamdiagnosticmetadata
         :spamdiagnosticoutput:content-language:accept-language:in-reply-to
         :references:message-id:date:thread-index:thread-topic:subject:cc:to
         :from:dkim-signature:arc-authentication-results;
        bh=Y0tihpFUqtJqLHMdjGbWguU0UZpXFJXQIRECwIGP1Us=;
        b=CrRgGA/YFMjFtnY4Zfcrd7aBo2bY+olWHv1MGJKl1qbIZhs0J5mlGQU7L5imL+02xl
         gTATeKU6th/3uBwruqpTVTXt1ivhHuzV0TXhbzqLJSq4N8c2jcBdfl10TDANAdtthcHV
         Acsvaw/H37zlW/1IrDH3DaVWwXafTc+kGWB/F0PD7yhXDoP23lUol+lombrZAbJkncJF
         wqugB5evC61iBwN9ljtqFjAIWT9prPT0rpQqr7ysFSBF0Ge+CY5QjIQR3KFxuNtuDyZB
         Y71fNQV3YnMXz4Hk0SMe4iOMAuyngHtR22WmgjoK8wD6pDkpzWfk7t4CB16fLMhDhSyp
         T8hg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@xilinx.onmicrosoft.com header.s=selector1-xilinx-com header.b=QKjlNwSW;
       spf=pass (google.com: domain of jollys@xilinx.com designates 104.47.38.89 as permitted sender) smtp.mailfrom=JOLLYS@xilinx.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@xilinx.onmicrosoft.com header.s=selector1-xilinx-com header.b=QKjlNwSW;
       spf=pass (google.com: domain of jollys@xilinx.com designates 104.47.38.89 as permitted sender) smtp.mailfrom=JOLLYS@xilinx.com
From: Jolly Shah <JOLLYS@xilinx.com>
To: Sudeep Holla <sudeep.holla@arm.com>, "ard.biesheuvel@linaro.org"
	<ard.biesheuvel@linaro.org>, "mingo@kernel.org" <mingo@kernel.org>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"matt@codeblueprint.co.uk" <matt@codeblueprint.co.uk>, "hkallweit1@gmail.com"
	<hkallweit1@gmail.com>, "keescook@chromium.org" <keescook@chromium.org>,
	"dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>,
	"mturquette@baylibre.com" <mturquette@baylibre.com>, "sboyd@codeaurora.org"
	<sboyd@codeaurora.org>, "michal.simek@xilinx.com" <michal.simek@xilinx.com>,
	"robh+dt@kernel.org" <robh+dt@kernel.org>, "mark.rutland@arm.com"
	<mark.rutland@arm.com>, "linux-clk@vger.kernel.org"
	<linux-clk@vger.kernel.org>
CC: Rajan Vaja <RAJANV@xilinx.com>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>
Subject: RE: [PATCH v6 09/11] firmware: xilinx: Add debugfs for clock control
 APIs
Thread-Topic: [PATCH v6 09/11] firmware: xilinx: Add debugfs for clock control
 APIs
Thread-Index: AQHT0QOvcs9sdlbCTkKDxq/bPR61b6QpNRYAgAaY/fA=
Date: Mon, 14 May 2018 19:18:44 +0000
Message-ID: <SN1PR02MB3758191654612CFC261A38BEB89C0@SN1PR02MB3758.namprd02.prod.outlook.com>
References: <1523389127-14243-1-git-send-email-jollys@xilinx.com>
 <1523389127-14243-10-git-send-email-jollys@xilinx.com>
 <5bcc47f7-3352-f0e6-29c5-78d5be96c1d1@arm.com>
In-Reply-To: <5bcc47f7-3352-f0e6-29c5-78d5be96c1d1@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=JOLLYS@xilinx.com;
x-originating-ip: [149.199.62.254]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SN1PR02MB3757;7:sm3l7sEYiXP5Au92Atxgb1lO/JcHTFZ1IClNVoqTBukCjFx8T5nDccvXRDftLna+RdYAYpd+W2fF2f/Vu9AKcaEQm+alOgwaUuhvPyE4iUqq+SBic2PbA09m/s3LCGK0sSxDJxsqwqsTa2DQWBzzgfVTVePPyv4z9x9xa13iDgb06mdXZ85Swn7rUVXGjV3WKAlHg6S6W6ufzp+QkAIvtub9fDUvzop0BRjxqR6Ul73aiu0HiFy+KqQh6gt0hzKn
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(39380400002)(39860400002)(396003)(376002)(366004)(346002)(13464003)(199004)(189003)(33656002)(2900100001)(6246003)(76176011)(68736007)(476003)(7416002)(446003)(5250100002)(97736004)(53936002)(486006)(9686003)(55016002)(2501003)(11346002)(59450400001)(305945005)(72206003)(7696005)(478600001)(25786009)(106356001)(105586002)(86362001)(39060400002)(4326008)(2201001)(2906002)(5660300001)(66066001)(6116002)(3846002)(229853002)(7736002)(6436002)(26005)(74316002)(110136005)(54906003)(81166006)(99286004)(14454004)(81156014)(6506007)(316002)(8676002)(3280700002)(102836004)(53546011)(3660700001)(186003)(8936002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR02MB3757;H:SN1PR02MB3758.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:SN1PR02MB3757;
x-ms-traffictypediagnostic: SN1PR02MB3757:
x-microsoft-antispam-prvs: <SN1PR02MB3757AB78E0BA09CAA88762A8B89C0@SN1PR02MB3757.namprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(180628864354917)(9452136761055)(85827821059158)(258649278758335)(192813158149592);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:SN1PR02MB3757;BCL:0;PCL:0;RULEID:;SRVR:SN1PR02MB3757;
x-forefront-prvs: 067270ECAF
x-microsoft-antispam-message-info: 0qsyGDDdPcnyTwRCEsuzSfPq8WGPIFhrRXflSx0Y8uXI3R39F3nfeqEI/y3af76UqvWbq4pidj3KDzK/K2BS8PwwAnv2Xg/VRZSLMJ3bGCyh28QlGgyuod3HjpM7luY1aGrIiQKwyNwlz6sup7AGUOkcs+YkbucdrrluYfKyEnwDmz/hYtAx5yURXSYoErne
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: b777ac78-0b23-440d-5aeb-08d5b9cf8300
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b777ac78-0b23-440d-5aeb-08d5b9cf8300
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2018 19:18:44.8438
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR02MB3757
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597389327627066068?=
X-GMAIL-MSGID: =?utf-8?q?1600468321090825777?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

SGkgU3VkZWVwLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFN1ZGVl
cCBIb2xsYSBbbWFpbHRvOnN1ZGVlcC5ob2xsYUBhcm0uY29tXQ0KPiBTZW50OiBUaHVyc2RheSwg
TWF5IDEwLCAyMDE4IDc6MzEgQU0NCj4gVG86IEpvbGx5IFNoYWggPEpPTExZU0B4aWxpbnguY29t
PjsgYXJkLmJpZXNoZXV2ZWxAbGluYXJvLm9yZzsNCj4gbWluZ29Aa2VybmVsLm9yZzsgZ3JlZ2to
QGxpbnV4Zm91bmRhdGlvbi5vcmc7IG1hdHRAY29kZWJsdWVwcmludC5jby51azsNCj4gaGthbGx3
ZWl0MUBnbWFpbC5jb207IGtlZXNjb29rQGNocm9taXVtLm9yZzsNCj4gZG1pdHJ5LnRvcm9raG92
QGdtYWlsLmNvbTsgbXR1cnF1ZXR0ZUBiYXlsaWJyZS5jb207DQo+IHNib3lkQGNvZGVhdXJvcmEu
b3JnOyBtaWNoYWwuc2ltZWtAeGlsaW54LmNvbTsgcm9iaCtkdEBrZXJuZWwub3JnOw0KPiBtYXJr
LnJ1dGxhbmRAYXJtLmNvbTsgbGludXgtY2xrQHZnZXIua2VybmVsLm9yZw0KPiBDYzogU3VkZWVw
IEhvbGxhIDxzdWRlZXAuaG9sbGFAYXJtLmNvbT47IFJhamFuIFZhamEgPFJBSkFOVkB4aWxpbngu
Y29tPjsNCj4gbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOyBsaW51eC1rZXJu
ZWxAdmdlci5rZXJuZWwub3JnOw0KPiBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsgSm9sbHkg
U2hhaCA8Sk9MTFlTQHhpbGlueC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjYgMDkvMTFd
IGZpcm13YXJlOiB4aWxpbng6IEFkZCBkZWJ1Z2ZzIGZvciBjbG9jayBjb250cm9sDQo+IEFQSXMN
Cj4gDQo+IA0KPiANCj4gT24gMTAvMDQvMTggMjA6MzgsIEpvbGx5IFNoYWggd3JvdGU6DQo+ID4g
RnJvbTogUmFqYW4gVmFqYSA8cmFqYW52QHhpbGlueC5jb20+DQo+ID4NCj4gPiBBZGQgZGVidWdm
cyBmaWxlIHRvIGNvbnRyb2wgY2xvY2tzIHVzaW5nIGZpcm13YXJlIEFQSXMgdGhyb3VnaCBkZWJ1
Z2ZzDQo+ID4gaW50ZXJmYWNlLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogUmFqYW4gVmFqYSA8
cmFqYW52QHhpbGlueC5jb20+DQo+ID4gU2lnbmVkLW9mZi1ieTogSm9sbHkgU2hhaCA8am9sbHlz
QHhpbGlueC5jb20+DQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvZmlybXdhcmUveGlsaW54L3p5bnFt
cC1kZWJ1Zy5jIHwgNDgNCj4gPiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+
ID4gIDEgZmlsZSBjaGFuZ2VkLCA0OCBpbnNlcnRpb25zKCspDQo+ID4NCj4gPiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy9maXJtd2FyZS94aWxpbngvenlucW1wLWRlYnVnLmMNCj4gPiBiL2RyaXZlcnMv
ZmlybXdhcmUveGlsaW54L3p5bnFtcC1kZWJ1Zy5jDQo+ID4gaW5kZXggMWNiNjlmNy4uODM3ZmNk
MSAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2Zpcm13YXJlL3hpbGlueC96eW5xbXAtZGVidWcu
Yw0KPiA+ICsrKyBiL2RyaXZlcnMvZmlybXdhcmUveGlsaW54L3p5bnFtcC1kZWJ1Zy5jDQo+ID4g
QEAgLTM0LDYgKzM0LDE1IEBAIHN0YXRpYyBzdHJ1Y3QgcG1fYXBpX2luZm8gcG1fYXBpX2xpc3Rb
XSA9IHsNCj4gPiAgCVBNX0FQSShQTV9HRVRfQVBJX1ZFUlNJT04pLA0KPiA+ICAJUE1fQVBJKFBN
X0lPQ1RMKSwNCj4gPiAgCVBNX0FQSShQTV9RVUVSWV9EQVRBKSwNCj4gPiArCVBNX0FQSShQTV9D
TE9DS19FTkFCTEUpLA0KPiA+ICsJUE1fQVBJKFBNX0NMT0NLX0RJU0FCTEUpLA0KPiA+ICsJUE1f
QVBJKFBNX0NMT0NLX0dFVFNUQVRFKSwNCj4gPiArCVBNX0FQSShQTV9DTE9DS19TRVRESVZJREVS
KSwNCj4gPiArCVBNX0FQSShQTV9DTE9DS19HRVRESVZJREVSKSwNCj4gPiArCVBNX0FQSShQTV9D
TE9DS19TRVRSQVRFKSwNCj4gPiArCVBNX0FQSShQTV9DTE9DS19HRVRSQVRFKSwNCj4gPiArCVBN
X0FQSShQTV9DTE9DS19TRVRQQVJFTlQpLA0KPiA+ICsJUE1fQVBJKFBNX0NMT0NLX0dFVFBBUkVO
VCksDQo+ID4gIH07DQo+ID4NCj4gPiAgLyoqDQo+ID4gQEAgLTg3LDYgKzk2LDcgQEAgc3RhdGlj
IGludCBwcm9jZXNzX2FwaV9yZXF1ZXN0KHUzMiBwbV9pZCwgdTY0DQo+ICpwbV9hcGlfYXJnLCB1
MzIgKnBtX2FwaV9yZXQpDQo+ID4gIAljb25zdCBzdHJ1Y3QgenlucW1wX2VlbWlfb3BzICplZW1p
X29wcyA9DQo+IHp5bnFtcF9wbV9nZXRfZWVtaV9vcHMoKTsNCj4gPiAgCXUzMiBwbV9hcGlfdmVy
c2lvbjsNCj4gPiAgCWludCByZXQ7DQo+ID4gKwl1NjQgcmF0ZTsNCj4gPg0KPiA+ICAJaWYgKCFl
ZW1pX29wcykNCj4gPiAgCQlyZXR1cm4gLUVOWElPOw0KPiA+IEBAIC0xMzIsNiArMTQyLDQ0IEBA
IHN0YXRpYyBpbnQgcHJvY2Vzc19hcGlfcmVxdWVzdCh1MzIgcG1faWQsIHU2NA0KPiAqcG1fYXBp
X2FyZywgdTMyICpwbV9hcGlfcmV0KQ0KPiA+ICAJCQkJcG1fYXBpX3JldFsyXSwgcG1fYXBpX3Jl
dFszXSk7DQo+ID4gIAkJYnJlYWs7DQo+ID4gIAl9DQo+ID4gKwljYXNlIFBNX0NMT0NLX0VOQUJM
RToNCj4gPiArCQlyZXQgPSBlZW1pX29wcy0+Y2xvY2tfZW5hYmxlKHBtX2FwaV9hcmdbMF0pOw0K
PiA+ICsJCWJyZWFrOw0KPiANCj4gQXMgSSBtZW50aW9uZWQgaW4gZWFybGllciBwYXRjaCwgSSBk
b24ndCBzZWUgdGhlIG5lZWQgZm9yIHRoaXMgZGVidWdmcyBpbnRlcmZhY2UuDQo+IENsb2NrIGxh
eSBoYXMgcmVhZC1vbmx5IGludGVyZmFjZSBpbiBkZWJ1Z2ZzIGFscmVhZHkuIEFsc28gaWYgeW91
IHdhbnQgdG8gZGVidWcNCj4gY2xvY2tzLCB5b3UgY2FuIGRvIHNvIHVzaW5nIHRoZSBkcml2ZXIg
d2hpY2ggdXNlcyB0aGVzZSBjbG9ja3MuIERvIHlvdSByZWFsbHkNCj4gd2FudCB0byBtYW5hZ2Ug
Y2xvY2tzIGluIHVzZXItc3BhY2UgPw0KPiBUaGUgd2hvbGUgaWRlYSBvZiBFRU1JIGtpbmQgb2Yg
aW50ZXJmYWNlIGlzIHRvIGFic3RyYWN0IGFuZCBoaWRlIHRoZSBmaW5lIGRldGFpbHMNCj4gZXZl
biBmcm9tIG5vbi10cnVzdGVkIHJpY2ggT1MgbGlrZSBMaW51eCBrZXJuZWwsIGJ1dCBieSBwcm92
aWRpbmcgdGhpcyB5b3UgYXJlDQo+IGRvaW5nIGV4YWN0bHkgb3Bwb3NpdGUuDQo+IA0KPiAtLQ0K
PiBSZWdhcmRzLA0KPiBTdWRlZXANCg0KTm8gd2UgZG9uJ3Qgd2FudCB0byBtYW5hZ2UgY2xvY2tz
IGluIHVzZXItc3BhY2UuIFRoaXMgZGVidWdmcyBpcyBtZWFudCBmb3IgZGV2ZWxvcGVyIHdobyB3
YW50cyB0byBkZWJ1ZyBBUElzIGJlaGF2aW9yIGluIGNhc2Ugc29tZXRoaW5nIGRvZXNuJ3Qgd29y
ayBhcyBleHBlY3RlZC4gRGVidWdmcyBzaG91bGQgYmUgb2ZmIGJ5IGRlZmF1bHQgaW4gcHJvZHVj
dGlvbiBpbWFnZXMuDQoNClRoYW5rcywNCkpvbGx5IFNoYWgNCg0K
