Return-Path: <JOLLYS@xilinx.com>
X-Google-Smtp-Source: AB8JxZoWfqjj/AV/IIT/uoTqar3zTmiIKo1WTncQzqKONPCMbgesjsDZk0GOTKxuU3aiALIXrwdQ
ARC-Seal: i=1; a=rsa-sha256; t=1526325375; cv=none;
        d=google.com; s=arc-20160816;
        b=xSxexmZ3po9A44ZFaXynlXQOZ4O0Xi3tI6k2PdXIF6IsB7mgiAEiY8yrKjDAtlEbc8
         xLvekxNtxt82XwZTvq1bY+THBipav5+SuJA/CHpyH8droehnimHOFcKnvJYHM0ljYlOw
         kpBfl5COxMYKnWMqLxZYIqV6UumDrE/ge51IlVQ4TONHWouz9cqAETW6c1311Bmmn5+T
         kYuVfkZcurKSu6Y3OTQ2ygFuKgR9xKh+c2PjOEFSZ1w8PR4hwq/DehN9v/w324smzRmF
         bdU6vNyvprIVCfqnhXag4ZswldRq3mAPf3vKm6JES4oG33vMBhUOaAPhPbfdu/2K7xhH
         1FPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:spamdiagnosticmetadata
         :spamdiagnosticoutput:content-language:accept-language:in-reply-to
         :references:message-id:date:thread-index:thread-topic:subject:cc:to
         :from:dkim-signature:arc-authentication-results;
        bh=jWLm2mPVqwrbvv5MM9wXEbnz8/BTEFs+FvTrLWis9kY=;
        b=L7UTPrDrEDmxK+/MYPcY4LSHgsCb5KAeX05E4uEBM3W6DxuWgx1DNdxVYJXkm7u/U2
         gduE2YghAYh94kl8Cfpd2qEHMFqTAhOeCj6XazPiUWUozUT57m4S7Wgwv+5s5FwN8L+y
         wXQRKn857eRXi9XAdgb/peAOyml0Uc+M9YGWufy7wYwgu+AjLF63JtRRnsfyoxuDf9nn
         ZjcrUzWvv33OYCqSnKNOGifaEQZjqEVs/FJjj654wH9P7Q1XCsKHy7Jyzr6SmUwh891n
         T0wAW+VZErk0oe0sIwDl5RzYrxewaE7pW3mqqMWJC0jqXapxtVrxty3U82eRHS6HyzPM
         nHWQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@xilinx.onmicrosoft.com header.s=selector1-xilinx-com header.b=HLm2YH/M;
       spf=pass (google.com: domain of jollys@xilinx.com designates 104.47.37.88 as permitted sender) smtp.mailfrom=JOLLYS@xilinx.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@xilinx.onmicrosoft.com header.s=selector1-xilinx-com header.b=HLm2YH/M;
       spf=pass (google.com: domain of jollys@xilinx.com designates 104.47.37.88 as permitted sender) smtp.mailfrom=JOLLYS@xilinx.com
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
Subject: RE: [PATCH v6 04/11] firmware: xilinx: Add query data API
Thread-Topic: [PATCH v6 04/11] firmware: xilinx: Add query data API
Thread-Index: AQHT0QO143ffVVfo7UWNtLCAgNhWHaQpL8cAgAadEVA=
Date: Mon, 14 May 2018 19:16:10 +0000
Message-ID: <SN1PR02MB37587E3AB2718E1DB510E35AB89C0@SN1PR02MB3758.namprd02.prod.outlook.com>
References: <1523389127-14243-1-git-send-email-jollys@xilinx.com>
 <1523389127-14243-5-git-send-email-jollys@xilinx.com>
 <85f8f8c5-a177-dad8-e095-a9dd1c513e8d@arm.com>
In-Reply-To: <85f8f8c5-a177-dad8-e095-a9dd1c513e8d@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=JOLLYS@xilinx.com;
x-originating-ip: [149.199.62.254]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SN1PR02MB3886;7:A38MB3UcthkwIL/PqIAxda5aBxp8XYg7mjjn0cR5wflSvRRDBWXr9A0PrZSa65ghpIMhDO9ywwR9TfBs3IhF062PoT/OZ7ls8lW3nQqrVpYQtPOv4UZFHohUA6v9pN4d21e8+ENPZjxmlHDtkkRpLqiwmeDukVrn4mzNsaj0dX+PZM1rql+0czRboQYxs9lxbUg4cSS9jci4ef28nboQtSmsUP9jz69r/o3P/Q4fPH0e3R/R4h7jO2+Ewhguakik
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(346002)(366004)(39860400002)(39380400002)(376002)(396003)(189003)(199004)(13464003)(110136005)(4326008)(25786009)(3280700002)(66066001)(11346002)(54906003)(446003)(7416002)(305945005)(99286004)(7736002)(316002)(5660300001)(6246003)(33656002)(81156014)(105586002)(106356001)(74316002)(81166006)(39060400002)(3846002)(6116002)(3660700001)(8936002)(8676002)(476003)(14454004)(478600001)(486006)(6436002)(186003)(72206003)(86362001)(2900100001)(229853002)(5250100002)(97736004)(102836004)(2906002)(6506007)(68736007)(53546011)(55016002)(9686003)(53936002)(2201001)(2501003)(26005)(76176011)(7696005)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR02MB3886;H:SN1PR02MB3758.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(48565401081)(2017052603328)(7153060)(7193020);SRVR:SN1PR02MB3886;
x-ms-traffictypediagnostic: SN1PR02MB3886:
x-microsoft-antispam-prvs: <SN1PR02MB388652F719973B491BA554E5B89C0@SN1PR02MB3886.namprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(180628864354917)(9452136761055)(85827821059158)(258649278758335)(192813158149592)(155532106045638);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(3231254)(944501410)(52105095)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:SN1PR02MB3886;BCL:0;PCL:0;RULEID:;SRVR:SN1PR02MB3886;
x-forefront-prvs: 067270ECAF
x-microsoft-antispam-message-info: p1y/ZWR7jdxJdHxW/bKIKdu8/2lsie5My7R16Bht1b9f/v2M8Kgchirc5ZFDVEdf1F7ZjqzxlRSTuA2LUAzTuXyIA/IV+18y+dJp8MpLyssgISnf/NMJExM1Ds//XsEr/4C2zxwV/I1z2+FRhlgO/SUcW5HRK1HflBRxzQXbm/aZoJhVDCt/9hItMlmlNjQU
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 0ac42c4d-109d-4912-616f-08d5b9cf26c7
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ac42c4d-109d-4912-616f-08d5b9cf26c7
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2018 19:16:10.1669
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR02MB3886
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597389328792813890?=
X-GMAIL-MSGID: =?utf-8?q?1600468156410260753?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

SEkgU3VkZWVwLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFN1ZGVl
cCBIb2xsYSBbbWFpbHRvOnN1ZGVlcC5ob2xsYUBhcm0uY29tXQ0KPiBTZW50OiBUaHVyc2RheSwg
TWF5IDEwLCAyMDE4IDc6MTIgQU0NCj4gVG86IEpvbGx5IFNoYWggPEpPTExZU0B4aWxpbnguY29t
PjsgYXJkLmJpZXNoZXV2ZWxAbGluYXJvLm9yZzsNCj4gbWluZ29Aa2VybmVsLm9yZzsgZ3JlZ2to
QGxpbnV4Zm91bmRhdGlvbi5vcmc7IG1hdHRAY29kZWJsdWVwcmludC5jby51azsNCj4gaGthbGx3
ZWl0MUBnbWFpbC5jb207IGtlZXNjb29rQGNocm9taXVtLm9yZzsNCj4gZG1pdHJ5LnRvcm9raG92
QGdtYWlsLmNvbTsgbXR1cnF1ZXR0ZUBiYXlsaWJyZS5jb207DQo+IHNib3lkQGNvZGVhdXJvcmEu
b3JnOyBtaWNoYWwuc2ltZWtAeGlsaW54LmNvbTsgcm9iaCtkdEBrZXJuZWwub3JnOw0KPiBtYXJr
LnJ1dGxhbmRAYXJtLmNvbTsgbGludXgtY2xrQHZnZXIua2VybmVsLm9yZw0KPiBDYzogU3VkZWVw
IEhvbGxhIDxzdWRlZXAuaG9sbGFAYXJtLmNvbT47IFJhamFuIFZhamEgPFJBSkFOVkB4aWxpbngu
Y29tPjsNCj4gbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOyBsaW51eC1rZXJu
ZWxAdmdlci5rZXJuZWwub3JnOw0KPiBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsgSm9sbHkg
U2hhaCA8Sk9MTFlTQHhpbGlueC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjYgMDQvMTFd
IGZpcm13YXJlOiB4aWxpbng6IEFkZCBxdWVyeSBkYXRhIEFQSQ0KPiANCj4gDQo+IA0KPiBPbiAx
MC8wNC8xOCAyMDozOCwgSm9sbHkgU2hhaCB3cm90ZToNCj4gPiBGcm9tOiBSYWphbiBWYWphIDxy
YWphbnZAeGlsaW54LmNvbT4NCj4gPg0KPiA+IEFkZCBaeW5xTVAgZmlybXdhcmUgcXVlcnkgZGF0
YSBBUEkgdG8gcXVlcnkgcGxhdGZvcm0gc3BlY2lmaWMNCj4gPiBpbmZvcm1hdGlvbihjbG9ja3Ms
IHBpbnMpIGZyb20gZmlybXdhcmUuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBSYWphbiBWYWph
IDxyYWphbnZAeGlsaW54LmNvbT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBKb2xseSBTaGFoIDxqb2xs
eXNAeGlsaW54LmNvbT4NCj4gPiAtLS0NCj4gPiAgZHJpdmVycy9maXJtd2FyZS94aWxpbngvenlu
cW1wLmMgICAgIHwgMTQgKysrKysrKysrKysrKysNCj4gPiAgaW5jbHVkZS9saW51eC9maXJtd2Fy
ZS94bG54LXp5bnFtcC5oIHwgMjAgKysrKysrKysrKysrKysrKysrKysNCj4gPiAgMiBmaWxlcyBj
aGFuZ2VkLCAzNCBpbnNlcnRpb25zKCspDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9m
aXJtd2FyZS94aWxpbngvenlucW1wLmMNCj4gPiBiL2RyaXZlcnMvZmlybXdhcmUveGlsaW54L3p5
bnFtcC5jDQo+ID4gaW5kZXggNDRiNDNmYS4uZWYwOWM0NCAxMDA2NDQNCj4gPiAtLS0gYS9kcml2
ZXJzL2Zpcm13YXJlL3hpbGlueC96eW5xbXAuYw0KPiA+ICsrKyBiL2RyaXZlcnMvZmlybXdhcmUv
eGlsaW54L3p5bnFtcC5jDQo+ID4gQEAgLTI1OCw5ICsyNTgsMjMgQEAgc3RhdGljIGludCB6eW5x
bXBfcG1faW9jdGwodTMyIG5vZGVfaWQsIHUzMg0KPiBpb2N0bF9pZCwgdTMyIGFyZzEsIHUzMiBh
cmcyLA0KPiA+ICAJCQkJICAgYXJnMSwgYXJnMiwgb3V0KTsNCj4gPiAgfQ0KPiA+DQo+ID4gKy8q
Kg0KPiA+ICsgKiB6eW5xbXBfcG1fcXVlcnlfZGF0YSgpIC0gR2V0IHF1ZXJ5IGRhdGEgZnJvbSBm
aXJtd2FyZQ0KPiA+ICsgKiBAcWRhdGE6CVZhcmlhYmxlIHRvIHRoZSB6eW5xbXBfcG1fcXVlcnlf
ZGF0YSBzdHJ1Y3R1cmUNCj4gPiArICogQG91dDoJUmV0dXJuZWQgb3V0cHV0IHZhbHVlDQo+ID4g
KyAqDQo+ID4gKyAqIFJldHVybjogUmV0dXJucyBzdGF0dXMsIGVpdGhlciBzdWNjZXNzIG9yIGVy
cm9yK3JlYXNvbiAgKi8gc3RhdGljDQo+ID4gK2ludCB6eW5xbXBfcG1fcXVlcnlfZGF0YShzdHJ1
Y3QgenlucW1wX3BtX3F1ZXJ5X2RhdGEgcWRhdGEsIHUzMiAqb3V0KQ0KPiA+ICt7DQo+ID4gKwly
ZXR1cm4genlucW1wX3BtX2ludm9rZV9mbihQTV9RVUVSWV9EQVRBLCBxZGF0YS5xaWQsDQo+IHFk
YXRhLmFyZzEsDQo+ID4gKwkJCQkgICBxZGF0YS5hcmcyLCBxZGF0YS5hcmczLCBvdXQpOw0KPiA+
ICt9DQo+ID4gKw0KPiA+ICBzdGF0aWMgY29uc3Qgc3RydWN0IHp5bnFtcF9lZW1pX29wcyBlZW1p
X29wcyA9IHsNCj4gPiAgCS5nZXRfYXBpX3ZlcnNpb24gPSB6eW5xbXBfcG1fZ2V0X2FwaV92ZXJz
aW9uLA0KPiA+ICAJLmlvY3RsID0genlucW1wX3BtX2lvY3RsLA0KPiA+ICsJLnF1ZXJ5X2RhdGEg
PSB6eW5xbXBfcG1fcXVlcnlfZGF0YSwNCj4gDQo+IENhbiB5b3UgZ2l2ZSBtb3JlIGluc2lnaHQg
aW50byB0aGlzID8gSG93IHdpbGwgYmUgdGhpcyB1c2VkID8NCj4gSG93IHRoaXMgYWxpZ25zIHdp
dGggZGF0YSB3ZSBnZXQgZnJvbSBEVCA/IEkgYW0ganVzdCB0cnlpbmcgdG8gdW5kZXJzdGFuZCBo
b3cgaXMNCj4gdGhpcyBpbmZvcm1hdGlvbiBzcGxpdCBiZXR3ZWVuIHRoaXMgQVBJIGFuZCBEVCBm
b3IgZXhhbXBsZS4NCj4gDQo+IC0tDQo+IFJlZ2FyZHMsDQo+IFN1ZGVlcA0KDQpUaGlzIEFQSSBp
cyB1c2VkIHRvIGdldCBjbG9jayBpbmZvcm1hdGlvbiBmcm9tIGZpcm13YXJlIGFuZCByZWdpc3Rl
ciBjbG9ja3MgYWNjb3JkaW5nbHkgaW4gZHJpdmVyLiBJbiBvdXIgY2FzZSwgZmlybXdhcmUgbWFp
bnRhaW5zIGRhdGFiYXNlIG9mIGFsbCBjbG9ja3MgYXZhaWxhYmxlIG9uIGNoaXAuIERUIHdpbGwg
cHJvdmlkZSBpbmZvcm1hdGlvbiBmb3Igb2ZmIGNoaXAgcmVmZXJlbmNlIGNsb2NrcyBvbmx5Lg0K
VGhpcyBpcyB0byBhdm9pZCBkdXBsaWNhdGlvbiBvZiBjbG9ja3MgZGF0YSBpbiBEVCBhbmQgZmly
bXdhcmUgYm90aCBhcyBmaXJtd2FyZSBhbnl3YXlzIG5lZWQgY2xvY2sgZGF0YSB0byBtYW5hZ2Ug
dGhlbS4NCg0KVGhhbmtzLA0KSm9sbHkgU2hhaA0KDQo=
