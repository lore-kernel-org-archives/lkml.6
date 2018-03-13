Return-Path: <nipun.gupta@nxp.com>
X-Google-Smtp-Source: AG47ELs4QvSYqCrbLbEeS+Bf5datPEzsVHOXHxnkM6K99vfvsNs0gnpQpY8DbUNjUAZeArj+H3Nt
ARC-Seal: i=1; a=rsa-sha256; t=1520914981; cv=none;
        d=google.com; s=arc-20160816;
        b=NTPZ/IVUMlsHTbKtSpfSpglW/H/x+cDE0qsxNkqGbFWYjn3dpxA0zWMSphkA1xACN4
         6H5YVT5ijiTjfXd1hJ//ztcmY/JxrzU3czzlYHzJyVz7U3etLXxX+6qEKXQY7W68YWez
         XCAGouK3JmaDJIJrRSR4KihCKyYzZkli4oQIKIezMuWr1X4pgqmDrNsMxxmwFnLJQZoI
         jYafL81XbVFTNNc5EXgkYsJ+auuTfF5a+PTZo9+E6Nt88nYd+C7SkDabKZTUYgHbhOgr
         iChuVpeRVBdSW2dYwpTvD4u2zQz1MdsiIvvCylz59hZqXld41nqaEKo8SRHKZsvqI4Rk
         G1Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:spamdiagnosticmetadata
         :spamdiagnosticoutput:content-language:accept-language:in-reply-to
         :references:message-id:date:thread-index:thread-topic:subject:cc:to
         :from:dkim-signature:arc-authentication-results;
        bh=+Z1g7DQpENI+EfTLb8cFeXRxAv1SA0X/fcQRj2gjsZI=;
        b=AbHbvoJISTVZJlB035yXgo6us9QHNh0V/rWky4lFs4zQy94okAEvaXcDjxoPmXKcHS
         wyjtSmpn4l4zdpqVvDGTLyGRfa+LHEF1b/L8tyfd4bnkMxwvdz7mnblMSZSWURkKBRy6
         Z5RlZx6ZxzdygPQCRz35e3AH4NmCtLbb84UquGyIAXitp15L8qVR1Vv5sejYIH6tZMrC
         te3qi45S8+p1GauG/FACiIF3TabLop9w/KXpInT6GUzVirsshXPJdP1c18hznEVPvZ44
         ewgPyX3JMsyzN4paiL1dvF1K1Fxc509YXBSeSNIoTuqXbp6yFB2YgxbAWbOD4ipThUaN
         8q5g==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@nxp.com header.s=selector1 header.b=iGZlOJH7;
       spf=pass (google.com: domain of nipun.gupta@nxp.com designates 104.47.2.78 as permitted sender) smtp.mailfrom=nipun.gupta@nxp.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nxp.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@nxp.com header.s=selector1 header.b=iGZlOJH7;
       spf=pass (google.com: domain of nipun.gupta@nxp.com designates 104.47.2.78 as permitted sender) smtp.mailfrom=nipun.gupta@nxp.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nxp.com
From: Nipun Gupta <nipun.gupta@nxp.com>
To: Sinan Kaya <okaya@codeaurora.org>, "hch@lst.de" <hch@lst.de>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>, "linux@armlinux.org.uk"
	<linux@armlinux.org.uk>, "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>, "m.szyprowski@samsung.com"
	<m.szyprowski@samsung.com>, "bhelgaas@google.com" <bhelgaas@google.com>
CC: "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>,
	"rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>,
	"jarkko.sakkinen@linux.intel.com" <jarkko.sakkinen@linux.intel.com>,
	"linus.walleij@linaro.org" <linus.walleij@linaro.org>, "johan@kernel.org"
	<johan@kernel.org>, "msuchanek@suse.de" <msuchanek@suse.de>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, Bharat Bhushan
	<bharat.bhushan@nxp.com>, Leo Li <leoyang.li@nxp.com>
Subject: RE: [PATCH] dma-mapping: move dma configuration to bus infrastructure
Thread-Topic: [PATCH] dma-mapping: move dma configuration to bus
 infrastructure
Thread-Index: AQHTuhZRcz681iNeqU+MbBDXy/Xb6aPMzpIAgADAXRA=
Date: Tue, 13 Mar 2018 04:22:53 +0000
Message-ID: <HE1PR0401MB24250A8631823FB3108EA62CE6D20@HE1PR0401MB2425.eurprd04.prod.outlook.com>
References: <1520868292-2479-1-git-send-email-nipun.gupta@nxp.com>
 <6a76df69-8c6c-52a6-0afd-fd0b8d2ff703@codeaurora.org>
In-Reply-To: <6a76df69-8c6c-52a6-0afd-fd0b8d2ff703@codeaurora.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=nipun.gupta@nxp.com;
x-originating-ip: [14.142.187.166]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;HE1PR0401MB2460;7:e5PIf3yEVTWjgnwXsNO2x+D1QCRlszuD1vWeO8puh9NOfc/SXoUQ7bHTJaW5qWSM9FiMdqYsY/PSzhqk/4Nz36fYSNldoVuIV+aRL1ZIqB9K11oZQAEr/v0xgpj8zTXoScVX+0Ynj1rPt/FeYusv+pyBGhkpqKVBuMoUW3nWSrBxdJB/DBgflJ+Q0pB5uRF7PBueUbES+2P2lmP1kmz4It/vaL+0jsIZEZR6WupAoxzWmH2i6Hi38z3NB/igCKW1
x-ms-exchange-antispam-srfa-diagnostics: SSOS;SSOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(366004)(39860400002)(39380400002)(376002)(346002)(396003)(189003)(199004)(13464003)(2501003)(6436002)(7696005)(39060400002)(54906003)(99286004)(106356001)(86362001)(7416002)(97736004)(229853002)(478600001)(5660300001)(2201001)(9686003)(55016002)(105586002)(3280700002)(2906002)(6246003)(110136005)(76176011)(4326008)(53936002)(25786009)(5250100002)(14454004)(2900100001)(305945005)(316002)(74316002)(186003)(66066001)(6116002)(59450400001)(7736002)(3846002)(33656002)(68736007)(8936002)(6506007)(102836004)(55236004)(53546011)(26005)(3660700001)(2950100002)(81166006)(8676002)(81156014);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR0401MB2460;H:HE1PR0401MB2425.eurprd04.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-ms-office365-filtering-correlation-id: 752e2dc4-be71-46c8-29f1-08d5889a1769
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(3008032)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(48565401081)(2017052603328)(7153060)(7193020);SRVR:HE1PR0401MB2460;
x-ms-traffictypediagnostic: HE1PR0401MB2460:
x-microsoft-antispam-prvs: <HE1PR0401MB2460A8D3F3BBF39D052A7C57E6D20@HE1PR0401MB2460.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(180628864354917)(9452136761055)(185117386973197)(85827821059158)(211936372134217)(7411616537696)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501244)(52105095)(10201501046)(93006095)(93001095)(3002001)(6055026)(6041310)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(6072148)(201708071742011);SRVR:HE1PR0401MB2460;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0401MB2460;
x-forefront-prvs: 0610D16BBE
x-microsoft-antispam-message-info: blANuMShFqf6QsHNYziDjVx0RZEwN9/kwM5b8x0APHVrh2OW0DoZS8vquMZmEEORTzCWj6LXc37VZB8weWNgcWOytZfiLXbYtBHjNaL9hLcdk50frL/tCKuubuhscj7KENJiPWNB5vpa9cEcp2LBgCgDgigk3LhxDV6kJdNZ0FF0zcL9mFkrUicRGYtqTs3yQr4GcnuMrotqsWJ8Eoy/T3VOImO5dhFrvay87Rpf4ARTu3E6Ij4IIW38ivlfeDAKQwUXhQfAagaKlrek2a7NHnwW6a4AHf0EOO1Y0j9YGRs12w1Qxjyi/YlVYGHJYvv8s0DRdNhZXY1uu/7p2gDGZQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 752e2dc4-be71-46c8-29f1-08d5889a1769
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2018 04:22:53.9871
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0401MB2460
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594746017210545974?=
X-GMAIL-MSGID: =?utf-8?q?1594794947176993881?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogU2luYW4gS2F5YSBbbWFp
bHRvOm9rYXlhQGNvZGVhdXJvcmEub3JnXQ0KPiBTZW50OiBNb25kYXksIE1hcmNoIDEyLCAyMDE4
IDIyOjE0DQo+IFRvOiBOaXB1biBHdXB0YSA8bmlwdW4uZ3VwdGFAbnhwLmNvbT47IGhjaEBsc3Qu
ZGU7DQo+IHJvYmluLm11cnBoeUBhcm0uY29tOyBsaW51eEBhcm1saW51eC5vcmcudWs7IGdyZWdr
aEBsaW51eGZvdW5kYXRpb24ub3JnOw0KPiBtLnN6eXByb3dza2lAc2Ftc3VuZy5jb207IGJoZWxn
YWFzQGdvb2dsZS5jb20NCj4gQ2M6IGRtaXRyeS50b3Jva2hvdkBnbWFpbC5jb207IHJhZmFlbC5q
Lnd5c29ja2lAaW50ZWwuY29tOw0KPiBqYXJra28uc2Fra2luZW5AbGludXguaW50ZWwuY29tOyBs
aW51cy53YWxsZWlqQGxpbmFyby5vcmc7IGpvaGFuQGtlcm5lbC5vcmc7DQo+IG1zdWNoYW5la0Bz
dXNlLmRlOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBpb21tdUBsaXN0cy5saW51eC0N
Cj4gZm91bmRhdGlvbi5vcmc7IGxpbnV4LXBjaUB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDog
UmU6IFtQQVRDSF0gZG1hLW1hcHBpbmc6IG1vdmUgZG1hIGNvbmZpZ3VyYXRpb24gdG8gYnVzDQo+
IGluZnJhc3RydWN0dXJlDQo+IA0KPiBPbiAzLzEyLzIwMTggMTE6MjQgQU0sIE5pcHVuIEd1cHRh
IHdyb3RlOg0KPiA+ICsJaWYgKGRtYV9kZXYtPm9mX25vZGUpIHsNCj4gPiArCQlyZXQgPSBvZl9k
bWFfY29uZmlndXJlKGRldiwgZG1hX2Rldi0+b2Zfbm9kZSk7DQo+ID4gKwl9IGVsc2UgaWYgKGhh
c19hY3BpX2NvbXBhbmlvbihkbWFfZGV2KSkgew0KPiA+ICsJCWF0dHIgPSBhY3BpX2dldF9kbWFf
YXR0cih0b19hY3BpX2RldmljZV9ub2RlKGRtYV9kZXYtDQo+ID5md25vZGUpKTsNCj4gPiArCQlp
ZiAoYXR0ciAhPSBERVZfRE1BX05PVF9TVVBQT1JURUQpDQo+ID4gKwkJCXJldCA9IGFjcGlfZG1h
X2NvbmZpZ3VyZShkZXYsIGF0dHIpOw0KPiA+ICsJfQ0KPiA+ICsNCj4gPiArCXBjaV9wdXRfaG9z
dF9icmlkZ2VfZGV2aWNlKGJyaWRnZSk7DQo+ID4gKw0KPiA+ICsJcmV0dXJuIHJldDsNCj4gPiAr
fQ0KPiA+ICsNCj4gPiArdm9pZCBwY2lfZG1hX2RlY29uZmlndXJlKHN0cnVjdCBkZXZpY2UgKmRl
dikNCj4gPiArew0KPiA+ICsJb2ZfZG1hX2RlY29uZmlndXJlKGRldik7DQo+ID4gKwlhY3BpX2Rt
YV9kZWNvbmZpZ3VyZShkZXYpOw0KPiA+ICt9DQo+IA0KPiBJc24ndCB0aGlzIG9uZSBvciB0aGUg
b3RoZXIgb25lIGJ1dCBub3QgYm90aD8NCj4gDQo+IFNvbWV0aGluZyBsaWtlOg0KPiANCj4gaWYg
KGRldi0+b2Zfbm9kZSkNCj4gCW9mX2RtYV9kZWNvbmZpZ3VyZShkZXYpOw0KPiBlbHNlDQo+IAlh
Y3BpX2RtYV9kZWNvbmZpZ3VyZShkZXYpOw0KPiANCj4gc2hvdWxkIHdvcmsuDQoNCkkgdW5kZXJz
dGFuZCB5b3VyIHBvaW50LiBTZWVtcyByZWFzb25hYmxlIGFzIHdlIHNob3VsZCBub3QgZXhwZWN0
DQp0aGUgJ29mL2FjcGkgRE1BIGRlY29uZmlndXJlJyBBUEkgdG8gbm90IGZhaWwgd2hlbiB0aGV5
IGFyZSBub3QgY29uZmlndXJlZC4NCg0KQnV0LCBoZXJlIHdlIHdvdWxkIGFsc28gbmVlZCB0byBn
ZXQgZG1hX2RldmljZSAoanVzdCBhcyB3ZSBnZXQgaW4NCidwY2lfZG1hX2NvbmZpZ3VyZScpIGFu
ZCBuZWVkIGEgY2hlY2sgb24gaXQgYXMgZm9yIFBDSSB0aGVyZSAnb2Zfbm9kZScNCmlzIHByZXNl
bnQgaW4gdGhlIGRtYV9kZXYuDQoNCklsbCB1cGRhdGUgdGhpcyBpbiB2MiwgYW5kIGFsc28gbWFr
ZSBzaW1pbGFyIGNoYW5nZXMgZm9yIHBsYXRmb3JtIGFuZCBBTUJBIGJ1cy4NCg0KVGhhbmtzLA0K
TmlwdW4NCg0KPiANCj4gLS0NCj4gU2luYW4gS2F5YQ0KPiBRdWFsY29tbSBEYXRhY2VudGVyIFRl
Y2hub2xvZ2llcywgSW5jLiBhcyBhbiBhZmZpbGlhdGUgb2YgUXVhbGNvbW0NCj4gVGVjaG5vbG9n
aWVzLCBJbmMuDQo+IFF1YWxjb21tIFRlY2hub2xvZ2llcywgSW5jLiBpcyBhIG1lbWJlciBvZiB0
aGUgQ29kZSBBdXJvcmEgRm9ydW0sIGEgTGludXgNCj4gRm91bmRhdGlvbiBDb2xsYWJvcmF0aXZl
IFByb2plY3QuDQo=
