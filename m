Return-Path: <nipun.gupta@nxp.com>
X-Google-Smtp-Source: AIpwx4/wpj+r8gy51V9L1fJ6dH3WOtwI8c+E7hW2giQnLlHVOSOQX5CpAWObeIJ6aAN7AFjcJk/E
ARC-Seal: i=1; a=rsa-sha256; t=1524032511; cv=none;
        d=google.com; s=arc-20160816;
        b=xTXkcp6A8TKO8d77KCDkIg8XzUEh5aJqHm8WERRS+yvV1Nz3qHVZlyRY4svTmWeOpw
         EhNvN7HXApbevGi/ZZiIH2sDrWQJDBhIrLETYsaCtGA+xhMB/sJWMY3XYTGsO9G9/5Aj
         RJY05faLIY/I5pqc8ixYcHwS/6vrtsX0Y77fchFs4CeGlzr9MfKQgD34LPxvORqbbH/A
         Lsu5okbF3xpXzD61nRSRJMbxr6wJjjho3IzKPmHcGBDOMTcqo9fbXvYYTSJHXRwG8By6
         JGejrDY6RVsKaYtIM9EgYmB7AbceHhI6EiFGPZAvWCqQ44B3beq+RKJ03IJlR2krstsX
         S+kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:spamdiagnosticmetadata
         :spamdiagnosticoutput:content-language:accept-language:in-reply-to
         :references:message-id:date:thread-index:thread-topic:subject:cc:to
         :from:dkim-signature:arc-authentication-results;
        bh=Ic+yKjVMz/I8OockIg/yh/6KNg9gtoyp6oKiuXOMAG8=;
        b=ThGseTukGf0sq/20OQFu170hy1dATNguU8LWqAmdRuSzrWjGPgKxxNLbaW/yKsIojt
         89XNdqjRH68IPOaLvbkletbSb7pTdaoq/XrSJcc2bBh6kzOwnpANoEkTGd3457m/ZmrY
         ShJQWRG/uVRd1slepYPArKaNRKYFr50sgCWIxasPEmq/hTK6FsSdRaxvrCsKbNkJefp+
         2q08ouzWX+YkJJdVCkboJAQ0WFH2t7JOf7MqjW6Rt0D4XqablNwqVrOTtNJ8nd7mxPPt
         ACmIzq9ZQ2kV3EUwjMEXJyIp+Y6QRpEcJYx9TrT+nHOZSffg7R2+kKKQa+945kcOqarx
         NJNg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@nxp.com header.s=selector1 header.b=fA5TVr4S;
       spf=pass (google.com: domain of nipun.gupta@nxp.com designates 104.47.2.76 as permitted sender) smtp.mailfrom=nipun.gupta@nxp.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nxp.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@nxp.com header.s=selector1 header.b=fA5TVr4S;
       spf=pass (google.com: domain of nipun.gupta@nxp.com designates 104.47.2.76 as permitted sender) smtp.mailfrom=nipun.gupta@nxp.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nxp.com
From: Nipun Gupta <nipun.gupta@nxp.com>
To: Robin Murphy <robin.murphy@arm.com>, "robh+dt@kernel.org"
	<robh+dt@kernel.org>, "frowand.list@gmail.com" <frowand.list@gmail.com>
CC: "will.deacon@arm.com" <will.deacon@arm.com>, "mark.rutland@arm.com"
	<mark.rutland@arm.com>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
	"hch@lst.de" <hch@lst.de>, "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>, "joro@8bytes.org" <joro@8bytes.org>,
	"m.szyprowski@samsung.com" <m.szyprowski@samsung.com>, "shawnguo@kernel.org"
	<shawnguo@kernel.org>, "bhelgaas@google.com" <bhelgaas@google.com>,
	"iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linuxppc-dev@lists.ozlabs.org"
	<linuxppc-dev@lists.ozlabs.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, Bharat Bhushan <bharat.bhushan@nxp.com>,
	"stuyoder@gmail.com" <stuyoder@gmail.com>, Laurentiu Tudor
	<laurentiu.tudor@nxp.com>, Leo Li <leoyang.li@nxp.com>
Subject: RE: [PATCH 2/6 v2] iommu: of: make of_pci_map_rid() available for
 other devices too
Thread-Topic: [PATCH 2/6 v2] iommu: of: make of_pci_map_rid() available for
 other devices too
Thread-Index: AQHT1jaZsPttBOauEUa6ehB5cbAsHKQFLIwAgADgpeA=
Date: Wed, 18 Apr 2018 06:21:46 +0000
Message-ID: <HE1PR0401MB2425A73A3BFF84B15B764FC6E6B60@HE1PR0401MB2425.eurprd04.prod.outlook.com>
References: <1520260166-29387-1-git-send-email-nipun.gupta@nxp.com>
 <1523960514-25457-1-git-send-email-nipun.gupta@nxp.com>
 <1523960514-25457-3-git-send-email-nipun.gupta@nxp.com>
 <41b32766-e21a-e946-6c8f-440e5c87d0ee@arm.com>
In-Reply-To: <41b32766-e21a-e946-6c8f-440e5c87d0ee@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [14.142.187.166]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;HE1PR0401MB2185;7:5N/X4JGQIb3UL57S0Af5lzTCQp2rN6Ba7I081Iobrydalrwgqa/PrIbriCHOvOYpN+fH0ZbJ7FaeGXLF9fEexzZvocK17PhbGRPPh2gLW8xS1TKmIMY/xwPeqtIpafdYcYAVqulDlWRNtuxLRM86S1eNoTqODmEpXaioCDu47QqzaqXafQr7IRyr1WsjjKP3Pa4Mfk4CV9OIIqKnfcEe+VQrhKtmjCgk4sFuDXrJxPlv5DPeHJziDlW1/+SsbORO
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(48565401081)(2017052603328)(7153060)(7193020);SRVR:HE1PR0401MB2185;
x-ms-traffictypediagnostic: HE1PR0401MB2185:
x-microsoft-antispam-prvs: <HE1PR0401MB2185E05EC7EC800640D69F60E6B60@HE1PR0401MB2185.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(180628864354917)(9452136761055)(65623756079841)(185117386973197)(85827821059158)(258649278758335)(211936372134217)(7411616537696);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231232)(944501327)(52105095)(6055026)(6041310)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(6072148)(201708071742011);SRVR:HE1PR0401MB2185;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0401MB2185;
x-forefront-prvs: 06469BCC91
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(396003)(39860400002)(366004)(39380400002)(43544003)(13464003)(76176011)(7696005)(446003)(97736004)(476003)(66066001)(44832011)(478600001)(6436002)(11346002)(25786009)(2501003)(55236004)(53546011)(316002)(6506007)(5250100002)(102836004)(2900100001)(2906002)(7736002)(33656002)(5660300001)(54906003)(186003)(229853002)(7416002)(305945005)(74316002)(99286004)(9686003)(4326008)(53936002)(3660700001)(110136005)(6246003)(26005)(39060400002)(86362001)(3280700002)(3846002)(8936002)(93886005)(81166006)(55016002)(8676002)(6116002)(14454004);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR0401MB2185;H:HE1PR0401MB2425.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;MLV:ovrnspm;PTR:InfoNoRecords;
x-microsoft-antispam-message-info: NKxIduitj9GoOzRnVFIPcWpUdZNmdwc72NlmXSOtgmCyNKTEn9Gpk2H8Hf0/6YgLxnghjXWWIEVRhTQmXpWEQQYMBLiV6BKSh9CAoDvRUhpSqkgyOgJU8l3XL09ZmkjzVI009QybZxavY3cR9lxQQKsMdKJ+I9aIKh3TB1KevWVgvpHGbx1IJayVU4EdOay1
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: e10de79f-569d-411f-6f56-08d5a4f4aa1e
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e10de79f-569d-411f-6f56-08d5a4f4aa1e
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Apr 2018 06:21:47.3546
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0401MB2185
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597988734561955050?=
X-GMAIL-MSGID: =?utf-8?q?1598063915099636389?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUm9iaW4gTXVycGh5IFtt
YWlsdG86cm9iaW4ubXVycGh5QGFybS5jb21dDQo+IFNlbnQ6IFR1ZXNkYXksIEFwcmlsIDE3LCAy
MDE4IDEwOjIzIFBNDQo+IFRvOiBOaXB1biBHdXB0YSA8bmlwdW4uZ3VwdGFAbnhwLmNvbT47IHJv
YmgrZHRAa2VybmVsLm9yZzsNCj4gZnJvd2FuZC5saXN0QGdtYWlsLmNvbQ0KPiBDYzogd2lsbC5k
ZWFjb25AYXJtLmNvbTsgbWFyay5ydXRsYW5kQGFybS5jb207IGNhdGFsaW4ubWFyaW5hc0Bhcm0u
Y29tOw0KPiBoY2hAbHN0LmRlOyBncmVna2hAbGludXhmb3VuZGF0aW9uLm9yZzsgam9yb0A4Ynl0
ZXMub3JnOw0KPiBtLnN6eXByb3dza2lAc2Ftc3VuZy5jb207IHNoYXduZ3VvQGtlcm5lbC5vcmc7
IGJoZWxnYWFzQGdvb2dsZS5jb207DQo+IGlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3Jn
OyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOw0KPiBkZXZpY2V0cmVlQHZnZXIua2VybmVs
Lm9yZzsgbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOyBsaW51eHBwYy0NCj4g
ZGV2QGxpc3RzLm96bGFicy5vcmc7IGxpbnV4LXBjaUB2Z2VyLmtlcm5lbC5vcmc7IEJoYXJhdCBC
aHVzaGFuDQo+IDxiaGFyYXQuYmh1c2hhbkBueHAuY29tPjsgc3R1eW9kZXJAZ21haWwuY29tOyBM
YXVyZW50aXUgVHVkb3INCj4gPGxhdXJlbnRpdS50dWRvckBueHAuY29tPjsgTGVvIExpIDxsZW95
YW5nLmxpQG54cC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMi82IHYyXSBpb21tdTogb2Y6
IG1ha2Ugb2ZfcGNpX21hcF9yaWQoKSBhdmFpbGFibGUgZm9yDQo+IG90aGVyIGRldmljZXMgdG9v
DQo+IA0KPiBPbiAxNy8wNC8xOCAxMToyMSwgTmlwdW4gR3VwdGEgd3JvdGU6DQo+ID4gaW9tbXUt
bWFwIHByb3BlcnR5IGlzIGFsc28gdXNlZCBieSBkZXZpY2VzIHdpdGggZnNsLW1jLiBUaGlzIHBh
dGNoDQo+ID4gbW92ZXMgdGhlIG9mX3BjaV9tYXBfcmlkIHRvIGdlbmVyaWMgbG9jYXRpb24sIHNv
IHRoYXQgaXQgY2FuIGJlIHVzZWQNCj4gPiBieSBvdGhlciBidXNzZXMgdG9vLg0KPiA+DQo+ID4g
U2lnbmVkLW9mZi1ieTogTmlwdW4gR3VwdGEgPG5pcHVuLmd1cHRhQG54cC5jb20+DQo+ID4gLS0t
DQo+ID4gICBkcml2ZXJzL2lvbW11L29mX2lvbW11LmMgfCAxMDYNCj4gPiArKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKystLQ0KPiANCj4gRG9lc24ndCB0aGlzIGJy
ZWFrICJtc2ktcGFyZW50IiBwYXJzaW5nIGZvciAhQ09ORklHX09GX0lPTU1VPyBJIGd1ZXNzIHlv
dQ0KPiBkb24ndCB3YW50IGZzbC1tYyB0byBoYXZlIHRvIGRlcGVuZCBvbiBQQ0ksIGJ1dCB0aGlz
IGxvb2tzIGxpa2UgYSBzdGVwIGluIHRoZQ0KPiB3cm9uZyBkaXJlY3Rpb24uDQoNClRoYW5rcyBm
b3IgcG9pbnRpbmcgb3V0Lg0KQWdyZWUsIHRoaXMgd2lsbCBicmVhayAibXNpLXBhcmVudCIgcGFy
c2luZyBmb3IgIUNPTkZJR19PRl9JT01NVSBjYXNlLg0KDQo+IA0KPiBJJ20gbm90IGVudGlyZWx5
IHN1cmUgd2hlcmUgb2ZfbWFwX3JpZCgpIGZpdHMgYmVzdCwgYnV0IGZyb20gYSBxdWljayBsb29r
IGFyb3VuZA0KPiB0aGUgbGVhc3Qtd29yc3Qgb3B0aW9uIG1pZ2h0IGJlIGRyaXZlcnMvb2Yvb2Zf
YWRkcmVzcy5jLCB1bmxlc3MgUm9iIGFuZCBGcmFuaw0KPiBoYXZlIGEgYmV0dGVyIGlkZWEgb2Yg
d2hlcmUgZ2VuZXJpYyBEVC1iYXNlZCBJRCB0cmFuc2xhdGlvbiByb3V0aW5lcyBjb3VsZCBsaXZl
Pw0KPiANCj4gPiAgIGRyaXZlcnMvb2YvaXJxLmMgICAgICAgICB8ICAgNiArLS0NCj4gPiAgIGRy
aXZlcnMvcGNpL29mLmMgICAgICAgICB8IDEwMSAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLQ0KPiA+ICAgaW5jbHVkZS9saW51eC9vZl9pb21tdS5oIHwgIDExICsr
KysrDQo+ID4gICBpbmNsdWRlL2xpbnV4L29mX3BjaS5oICAgfCAgMTAgLS0tLS0NCj4gPiAgIDUg
ZmlsZXMgY2hhbmdlZCwgMTE3IGluc2VydGlvbnMoKyksIDExNyBkZWxldGlvbnMoLSkNCj4gPg0K
DQpbLi4uXQ0KDQo+ID4gICBzdHJ1Y3Qgb2ZfcGNpX2lvbW11X2FsaWFzX2luZm8gew0KPiA+ICAg
CXN0cnVjdCBkZXZpY2UgKmRldjsNCj4gPiAgIAlzdHJ1Y3QgZGV2aWNlX25vZGUgKm5wOw0KPiA+
IEBAIC0xNDksOSArMjQ5LDkgQEAgc3RhdGljIGludCBvZl9wY2lfaW9tbXVfaW5pdChzdHJ1Y3Qg
cGNpX2RldiAqcGRldiwgdTE2DQo+IGFsaWFzLCB2b2lkICpkYXRhKQ0KPiA+ICAgCXN0cnVjdCBv
Zl9waGFuZGxlX2FyZ3MgaW9tbXVfc3BlYyA9IHsgLmFyZ3NfY291bnQgPSAxIH07DQo+ID4gICAJ
aW50IGVycjsNCj4gPg0KPiA+IC0JZXJyID0gb2ZfcGNpX21hcF9yaWQoaW5mby0+bnAsIGFsaWFz
LCAiaW9tbXUtbWFwIiwNCj4gPiAtCQkJICAgICAiaW9tbXUtbWFwLW1hc2siLCAmaW9tbXVfc3Bl
Yy5ucCwNCj4gPiAtCQkJICAgICBpb21tdV9zcGVjLmFyZ3MpOw0KPiA+ICsJZXJyID0gb2ZfbWFw
X3JpZChpbmZvLT5ucCwgYWxpYXMsICJpb21tdS1tYXAiLA0KPiA+ICsJCQkgImlvbW11LW1hcC1t
YXNrIiwgJmlvbW11X3NwZWMubnAsDQo+ID4gKwkJCSBpb21tdV9zcGVjLmFyZ3MpOw0KPiANCj4g
U3VwZXItbml0OiBBcHBhcmVudGx5IEkgbWlzc2VkIHJld3JhcHBpbmcgdGhpcyB0byAyIGxpbmVz
IGluIGQ4N2JlYjc0OTI4MSwgYnV0IGlmDQo+IGl0J3MgYmVpbmcgdG91Y2hlZCBhZ2FpbiwgdGhh
dCB3b3VsZCBiZSBuaWNlIDspDQoNClN1cmUuLiBJJ2xsIHRha2UgY2FyZSBvZiB0aGlzIGluIHRo
ZSBuZXh0IHZlcnNpb24gOikNCg0KUmVnYXJkcywNCk5pcHVuDQo=
