Return-Path: <ioana.ciornei@nxp.com>
X-Google-Smtp-Source: AIpwx4+wxE5dVKZRGsoZcSq9d+IEkWjEVO7foJ4ygO8h8NFw5ubEpOcjP0/tLk698GHQYgl7rLuW
ARC-Seal: i=1; a=rsa-sha256; t=1522247253; cv=none;
        d=google.com; s=arc-20160816;
        b=Gf92N8tsFT/nKLOrrkfYXo19/sDUg56F8xb8u7nQfFsIb7LGWt9HUJsx2uvbt6SJ4V
         eLaqykCYLVNy0Byu/hgRZhLdp2q1GGy1BsGei2NFePDAm5bH9ElsVnCdm6NBsb2I8c91
         s/BKlpmxtbSgqhW2AqDMZXXHXb4T9Vf76FawsMbYkUiO3d3onpYfVVvryAnJXl6Py5OK
         aSl4Emq0tDTWT5JDq8BD6iIDToi9IT8z4Ied1zFhvmr4FHXNDNehhsZ+DJ97LPwlaTX9
         +Lvvjxvu2wipW18RKQPNI97jMVFLaVjjwirEzz4HCpXord8iFy/VDUDEa/9fIE58RwDr
         nvwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:spamdiagnosticmetadata
         :spamdiagnosticoutput:content-language:accept-language:in-reply-to
         :references:message-id:date:thread-index:thread-topic:subject:cc:to
         :from:dkim-signature:arc-authentication-results;
        bh=CP/Mp11R8srhOHgIuvy7RghygqMPdCcQUy8sTdvy+Oo=;
        b=er/2XA91Gzi5GiHRX421rvL5xYPQek4hoL7D6CnhONe6XFUCx+EFOgnpmQgUQL8P+k
         atGzDqnVPF2mrp+NFlwARNmC8B7VB437W63PNySpfh5vrnJMTdrCJRXnj80FUBLAhwiL
         gystl84hMWqecjdAFTZYSZyH4khrT63nDsj/ntcO8l+ykMBXpZGtTht5g/a3omEsFsPF
         kwQ9KrAZRfFuGae52f6RpMYjSej3Ban9U8kBZtqx2zRtappSj7IjnF6KWmQNyDLzCGfX
         E51oQp4P6Xd6xztlRLs1KS0EHHkAXlRE0ScaAlRY3rrX9XKzgocgYnabigmqRzqZhYi4
         rbVQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@nxp.com header.s=selector1 header.b=trDwF2+b;
       spf=pass (google.com: domain of ioana.ciornei@nxp.com designates 104.47.0.59 as permitted sender) smtp.mailfrom=ioana.ciornei@nxp.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nxp.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@nxp.com header.s=selector1 header.b=trDwF2+b;
       spf=pass (google.com: domain of ioana.ciornei@nxp.com designates 104.47.0.59 as permitted sender) smtp.mailfrom=ioana.ciornei@nxp.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nxp.com
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: Arnd Bergmann <arnd@arndb.de>
CC: gregkh <gregkh@linuxfoundation.org>, Laurentiu Tudor
	<laurentiu.tudor@nxp.com>, Linux Kernel Mailing List
	<linux-kernel@vger.kernel.org>, Stuart Yoder <stuyoder@gmail.com>, Ruxandra
 Ioana Ciocoi Radulescu <ruxandra.radulescu@nxp.com>, Razvan Stefanescu
	<razvan.stefanescu@nxp.com>, Roy Pledge <roy.pledge@nxp.com>
Subject: RE: [PATCH v3 2/4] bus: fsl-mc: add restool userspace support
Thread-Topic: [PATCH v3 2/4] bus: fsl-mc: add restool userspace support
Thread-Index: AQHTwr0rRbeSymdCeEiXdPiYqeyzd6PfBFwAgAPKwGA=
Date: Wed, 28 Mar 2018 14:27:27 +0000
Message-ID: <HE1PR04MB32126A07A4B4CC7225E661E4E0A30@HE1PR04MB3212.eurprd04.prod.outlook.com>
References: <cover.1521818402.git.ioana.ciornei@nxp.com>
 <d8c243a9ead2fe1375dee242aec26d1276129409.1521818402.git.ioana.ciornei@nxp.com>
 <CAK8P3a089ZiPdp1CcVct8Kac+ejkNP8TrVpWYSr_nMGo4goO1Q@mail.gmail.com>
In-Reply-To: <CAK8P3a089ZiPdp1CcVct8Kac+ejkNP8TrVpWYSr_nMGo4goO1Q@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [86.34.165.90]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;HE1PR04MB0891;7:oGup3I8M41+OvjeBo4QKeEozUDluyhIthMbqDtcnXbtpF+6+1O5JVqLwXjLhf6V0wwI43qn0FHtp2kJQTTc+Fx/JTfe13QE53wzCnVTTVknGX0dFXHV1PzVSZ17R79mgehziPIzwb64bd++gc/2xsIfN36fyaZQJB8VzK0XYTJzWWg7pFdbLy4SRPNINOA1dp63i9OwP0KgTkW0X5QoqmJ2T2aUbPj8HYS0LMDUhpKWSARKF/s/xb2zXzi7KcIiP
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1a8b8ac6-e223-47f8-44fa-08d594b80849
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:HE1PR04MB0891;
x-ms-traffictypediagnostic: HE1PR04MB0891:
x-microsoft-antispam-prvs: <HE1PR04MB0891FD6766EAFE1A14439299E0A30@HE1PR04MB0891.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(166708455590820)(35073007944872);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:HE1PR04MB0891;BCL:0;PCL:0;RULEID:;SRVR:HE1PR04MB0891;
x-forefront-prvs: 06259BA5A2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39380400002)(376002)(396003)(366004)(39860400002)(346002)(189003)(199004)(54906003)(6246003)(14454004)(966005)(33656002)(106356001)(5660300001)(6306002)(39060400002)(9686003)(4326008)(6506007)(6436002)(68736007)(486005)(55016002)(305945005)(7736002)(97736004)(486005)(6116002)(3846002)(53936002)(74316002)(25786009)(478600001)(8676002)(6916009)(186003)(99286004)(6346003)(2900100001)(102836004)(26005)(59450400001)(316002)(86362001)(76176011)(446003)(105586002)(229853002)(8936002)(81166006)(2906002)(11346002)(7696005)(3280700002)(3660700001)(66066001)(476003)(81156014)(5250100002);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR04MB0891;H:HE1PR04MB3212.eurprd04.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ioana.ciornei@nxp.com;
x-microsoft-antispam-message-info: qBh6AXyj/zPL2dp8meQaIvheaHNOhc66xSJK/5Pj+Vs5pI1FBUjJtpTCrVcEEKGbPwu+Ne2VemOt3u1j+Gb4pjGrKf+r0kDf2/FofLJuePgeg1v98xcYDQ8ZYH2zDOmWmYuGzdmpFjqsepCt646ksiBYsbT8Lc7QxCeuIhGouXLtE7CpTb90YalNCiT6NdMngkV7lNq0iDctigxrDm/xqZgR+ZMYIYMOCLtYLeCvSBuF9T55XYnXD+R0Xj3pEabNYCd8PRfY18ZuM1tyvS6pvhmKkHBgUiRj1F/Q441vgVq+bHCpwYgbBSeUoMkYVKwmKyQG0E/w/o61tfNU4hIu5Q==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a8b8ac6-e223-47f8-44fa-08d594b80849
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2018 14:27:27.5143
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR04MB0891
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595743497041548891?=
X-GMAIL-MSGID: =?utf-8?q?1596191935558782991?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

SGksDQoNCj4gDQo+IEhpIElvYW5hLA0KPiANCj4gU28gdGhpcyBkcml2ZXIgaXMgYSBkaXJlY3Qg
cGFzc3Rocm91Z2ggdG8geW91ciBoYXJkd2FyZSBmb3IgcGFzc2luZyBmaXhlZC0NCj4gbGVuZ3Ro
IGNvbW1hbmQvcmVzcG9uc2UgcGFpcnMuIEhhdmUgeW91IGNvbnNpZGVyZWQgdXNpbmcgYSBoaWdo
ZXItbGV2ZWwNCj4gaW50ZXJmYWNlIGluc3RlYWQ/DQo+IA0KPiBDYW4geW91IGxpc3Qgc29tZSBv
ZiB0aGUgY29tbWFuZHMgdGhhdCBhcmUgcGFzc2VkIGhlcmUgYXMgY2xhcmlmaWNhdGlvbiwgYW5k
DQo+IGV4cGxhaW4gd2hhdCB0aGUgdHJhZGVvZmZzIGFyZSB0aGF0IGhhdmUgbGVkIHRvIGFkb3B0
aW5nIGEgbG93LWxldmVsIGludGVyZmFjZQ0KPiBpbnN0ZWFkIG9mIGEgaGlnaC1sZXZlbCBpbnRl
cmZhY2U/DQo+IA0KPiBUaGUgbWFpbiBkb3duc2lkZSBvZiB0aGUgZGlyZWN0IHBhc3N0aHJvdWdo
IG9idmlvdXNseSBpcyB0aGF0IHlvdSB0aWUgeW91cg0KPiB1c2VyIHNwYWNlIHRvIGEgcGFydGlj
dWxhciBoYXJkd2FyZSBpbXBsZW1lbnRhdGlvbiwgd2hpbGUgYSBoaWdoLWxldmVsDQo+IGFic3Ry
YWN0aW9uIGNvdWxkIGluIHByaW5jaXBsZSB3b3JrIGFjcm9zcyBhIHdpZGVyIHJhbmdlIG9mIGhh
cmR3YXJlIHJldmlzaW9ucw0KPiBvciBldmVuIGFjcm9zcyBtdWx0aXBsZSB2ZW5kb3JzIGltcGxl
bWVudGluZyB0aGUgc2FtZSBjb25jZXB0IGJ5IGRpZmZlcmVudA0KPiBtZWFucy4NCg0KSWYgYnkg
ImhpZ2hlci1sZXZlbCIgeW91IG1lYW4gYW4gaW1wbGVtZW50YXRpb24gd2hlcmUgY29tbWFuZHMg
YXJlIGNyZWF0ZWQgYnkgdGhlIGtlcm5lbCBhdCB1c2Vyc3BhY2UncyByZXF1ZXN0LCB0aGVuIEkg
YmVsaWV2ZSB0aGlzIGFwcHJvYWNoIGlzIG5vdCByZWFsbHkgdmlhYmxlIGJlY2F1c2Ugb2YgdGhl
IHNoZWVyIG51bWJlciBvZiBwb3NzaWJsZSBjb21tYW5kcyB0aGF0IHdvdWxkIGJsb2F0IHRoZSBk
cml2ZXIuDQoNCkZvciBleGFtcGxlLCBhIERQTkkgKERhdGEgUGF0aCBOZXR3b3JrIEludGVyZmFj
ZSkgY2FuIGJlIGNyZWF0ZWQgdXNpbmcgYSBjb21tYW5kIHRoYXQgaGFzIHRoZSBmb2xsb3dpbmcg
c3RydWN0dXJlOg0KDQpzdHJ1Y3QgZHBuaV9jbWRfY3JlYXRlIHsNCgl1aW50MzJfdCBvcHRpb25z
Ow0KCXVpbnQ4X3QgbnVtX3F1ZXVlczsNCgl1aW50OF90IG51bV90Y3M7DQoJdWludDhfdCBtYWNf
ZmlsdGVyX2VudHJpZXM7DQoJdWludDhfdCBwYWQxOw0KCXVpbnQ4X3Qgdmxhbl9maWx0ZXJfZW50
cmllczsNCgl1aW50OF90IHBhZDI7DQoJdWludDhfdCBxb3NfZW50cmllczsNCgl1aW50OF90IHBh
ZDM7DQoJdWludDE2X3QgZnNfZW50cmllczsNCn07DQoNCkluIHRoZSBhYm92ZSBzdHJ1Y3R1cmUs
IGVhY2ggZmllbGQgaGFzIGEgbWVhbmluZyB0aGF0IHRoZSBlbmQtdXNlciBtaWdodCB3YW50IHRv
IGJlIGFibGUgdG8gY2hhbmdlIGFjY29yZGluZyB0byB0aGVpciBwYXJ0aWN1bGFyIHVzZS1jYXNl
IChub3QgbXVjaCBpcyBsZWZ0IGF0IGl0cyBkZWZhdWx0IHZhbHVlKS4NClRoZSBzYW1lIGxldmVs
IG9mIGNvbXBsZXhpdHkgaXMgZW5jb3VudGVyZWQgZm9yIGFsbCB0aGUgY29tbWFuZHMgdGhhdCBp
bnRlcmFjdCB3aXRoIERhdGEgUGF0aCBvYmplY3RzIHN1Y2ggYXMgRFBCUChidWZmZXIgcG9vbHMp
LCBEUFJDKFJlc291cmNlIENvbnRhaW5lcikgZXRjLg0KWW91IGNhbiBmaW5kIG1vcmUgZXhhbXBs
ZXMgb2YgY29tbWFuZHMgaW4gcmVzdG9vbCdzIHJlcG86IGh0dHBzOi8vZ2l0aHViLmNvbS9xb3Jp
cS1vcGVuLXNvdXJjZS9yZXN0b29sL3RyZWUvaW50ZWdyYXRpb24vbWNfdjEwDQoNCkluIG15IG9w
aW5pb24sIGFuIGluLWtlcm5lbCBpbXBsZW1lbnRhdGlvbiB0aGF0IGlzIGVxdWl2YWxlbnQgaW4g
dGVybXMgb2YgZmxleGliaWxpdHkgd2lsbCB0dXJuIGludG8gYSBnaWFudCBpb2N0bCBwYXJzZXIs
IGFsbCB3aGlsZSBhbHNvIGV4cG9zaW5nIGFuIHVzZXJzcGFjZSBBUEkgdGhhdCBpcyBub3QgYXMg
c2ltcGxlL2Vhc3kgdG8gdXNlLg0KDQo+ID4gQEAgLTE0LDEwICsxNCwxOCBAQA0KPiA+ICAgKiBz
dHJ1Y3QgZnNsX21jX2NvbW1hbmQgLSBNYW5hZ2VtZW50IENvbXBsZXggKE1DKSBjb21tYW5kDQo+
IHN0cnVjdHVyZQ0KPiA+ICAgKiBAaGVhZGVyOiBNQyBjb21tYW5kIGhlYWRlcg0KPiA+ICAgKiBA
cGFyYW1zOiBNQyBjb21tYW5kIHBhcmFtZXRlcnMNCj4gPiArICoNCj4gPiArICogVXNlZCBieSBS
RVNUT09MX1NFTkRfTUNfQ09NTUFORA0KPiA+ICAgKi8NCj4gPiAgc3RydWN0IGZzbF9tY19jb21t
YW5kIHsNCj4gPiAgICAgICAgIF9fdTY0IGhlYWRlcjsNCj4gPiAgICAgICAgIF9fdTY0IHBhcmFt
c1tNQ19DTURfTlVNX09GX1BBUkFNU107ICB9Ow0KPiA+DQo+ID4gKyNkZWZpbmUgUkVTVE9PTF9J
T0NUTF9UWVBFICAgICAnUicNCj4gPiArI2RlZmluZSBSRVNUT09MX0lPQ1RMX1NFUSAgICAgIDB4
RTANCj4gDQo+IEkgdHJpZWQgdG8gZm9sbG93IHRoZSBjb2RlIHBhdGggaW50byB0aGUgaGFyZHdh
cmUgYW5kIGFtIGEgYml0IGNvbmZ1c2VkIGFib3V0DQo+IHRoZSBzZW1hbnRpY3Mgb2YgdGhlICdo
ZWFkZXInIGZpZWxkIGFuZCB0aGUgZGF0YS4gQm90aCBhcmUgYWNjZXNzZWQgcGFzc2VkIHRvDQo+
IHRoZSBoYXJkd2FyZSB1c2luZw0KPiANCj4gICAgICAgIHdyaXRlcShsZTY0X3RvX2NwdShjbWQt
PmhlYWRlcikpDQo+IA0KPiB3aGljaCB3b3VsZCBpbmRpY2F0ZSBhIGZpeGVkIGJ5dGUgbGF5b3V0
IG9uIHRoZSB1c2VyIHN0cnVjdHVyZSBhbmQgdGhhdCBpdA0KPiBzaG91bGQgcmVhbGx5IGJlIGEg
J19fbGU2NCcgaW5zdGVhZCBvZiAnX191NjQnLCBvciBwb3NzaWJseSBzaG91bGQgYmUNCj4gcmVw
cmVzZW50ZWQgYXMgJ19fdTggaGVhZGVyWzhdJyB0byBjbGFyaWZ5IHRoYXQgdGhlIGJ5dGUgb3Jk
ZXJpbmcgaXMgc3VwcG9zZWQNCj4gdG8gbWF0Y2ggdGhlIG9yZGVyIG9mIHRoZSBieXRlIGFkZHJl
c3NlcyBvZiB0aGUgcmVnaXN0ZXIuDQo+IA0KDQpJbmRlZWQsIHRoZSBzdHJ1Y3QgZnNsX21jX2Nv
bW1hbmQgc2hvdWxkIHVzZSAnX19sZTY0JyBpbnN0ZWFkIG9mICdfX3U2NCcsIHNvIHRoYXQgdGhl
IFVBUEkgaGVhZGVyIGZpbGUgY2xlYXJseSBzdGF0ZXMgd2hhdCBlbmRpYW5uZXNzIHNob3VsZCB0
aGUgdXNlcnNwYWNlIHByZXBhcmUuDQpUaGUgd3JpdGVxIGFwcGVhcmVkIGFzIGEgY29uc2VxdWVu
Y2Ugb2YgYSBwcmV2aW91cyBtYWlsIHRocmVhZCBodHRwczovL2xrbWwub3JnL2xrbWwvMjAxNy83
LzE3LzQxNSwgYmVjYXVzZSB0aGUgZW5kaWFubmVzcyBvZiB0aGUgY29tbWFuZCBpcyBoYW5kbGVk
IGJ5IHRoZSB1c2VyIGFuZCB0aGUgYnVzIHNob3VsZCBsZWF2ZSB0aGUgYmluYXJ5IGJsb2IgaW50
YWN0Lg0KDQo+IEhvd2V2ZXIsIHRoZSBpbi1rZXJuZWwgdXNhZ2Ugb2YgdGhhdCBmaWVsZCBzdWdn
ZXN0cyB0aGF0IHdlIHRyZWF0IGl0IGFzIGEgNjQtYml0DQo+IGNwdS1lbmRpYW4gbnVtYmVyLCBm
b3Igd2hpY2ggdGhlIGhhcmR3YXJlIG5lZWRzIHRvIGtub3cgdGhlIGVuZGlhbmVzcyBvZg0KPiB0
aGUgY3VycmVudGx5IHJ1bm5pbmcga2VybmVsIGFuZCB1c2VyIHNwYWNlLg0KPiANCg0KSSBtaWdo
dCBoYXZlIG5vdCB1bmRlcnN0b29kIHdoYXQgeW91IGFyZSB0cnlpbmcgdG8gc2F5LCBidXQgdGhl
IGluLWtlcm5lbCBjb2RlIHRyZWF0cyB0aGUgZnNsX21jX2NvbW1hbmQgYXMgbGl0dGxlIGVuZGlh
biBieSB1c2luZyBjcHVfdG9fbGVYWCBhbmQgbGVYWF90b19jcHUgaW4gb3JkZXIgdG8gc2V0dXAg
dGhlIGNvbW1hbmQgc3RydWN0dXJlLg0KDQpJb2FuYQ0KDQo+IENhbiB5b3UgaGF2ZSBhIGxvb2sg
YXQgd2hlcmUgdGhlIG1pc3Rha2UgaXMgYW5kIHdoYXQgdGhlIGJ5dGVvcmRlciBmb3IgdGhlDQo+
IGZzbF9tY19jb21tYW5kIHN0cnVjdHVyZSBpcyBzdXBwb3NlZCB0byBiZT8gT2J2aW91c2x5LCB0
aGlzIGlzIG9uZSB0aGluZw0KPiB0aGF0IHdvdWxkIGJlIHNpbXBsaWZpZWQgYnkgdXNpbmcgYSBo
aWdoLWxldmVsIGludGVyZmFjZSwgYnV0IGl0J3MgcG9zc2libGUgdG8gZG8NCj4gaXQgbGlrZSB0
aGlzIGFzIGxvbmcgYXMgaXQncyBjb21wbGV0ZWx5IGNsZWFyIGhvdyB0aGUgc3RydWN0dXJlIGxh
eW91dCBpcyBtZWFudCB0bw0KPiBiZSB1c2VkIGluIHRoZSB1YXBpIGhlYWRlci4NCj4gDQo+ICAg
ICAgICAgQXJuZA0K
