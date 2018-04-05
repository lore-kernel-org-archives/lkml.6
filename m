Return-Path: <laurentiu.tudor@nxp.com>
X-Google-Smtp-Source: AIpwx49Jrn/mf25Cetz+tkcFY9VTXFFcbxInEmBX3h/hIDSWfu1uHXa/gSzhpVG8+NRJ8orwJJNl
ARC-Seal: i=1; a=rsa-sha256; t=1522937391; cv=none;
        d=google.com; s=arc-20160816;
        b=g/KLyV5YEyUfNo5Gn9kmayFtoTjFt+apybyf/z0S6Ad/iq31REqvGq2Srdgzi6JP17
         82em9+YZDL8d31ssXj19LQDOr6rZPAp0jE3Hq9VapDaAMPsOCwLzKbMttoHyGKIicN+p
         cASzC/+I3dRMXTKJhwfVIvg8S++hTwMQT2GXpTa7xDQkBnfl1V9aguvWvH9M1XFo0Cfu
         mICv+VayRB06T1lMehZOoxdYEuAj69Lg24b8ElqyffkpetvJcneS173agL1qUloxlHLx
         aimechR1HzFUBMiPHq0H4XWYU83aEaRPHJsF6RpDlpvNz8GHIF47fvO8vl4tT3LzUPcs
         aYWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:content-id
         :spamdiagnosticmetadata:spamdiagnosticoutput:content-language
         :accept-language:in-reply-to:references:message-id:date:thread-index
         :thread-topic:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=h8GnNGfHH3vJ15VGzzMzse3qadmAiYoClzYeWEHvbYU=;
        b=iXVZpuDTT2iInXFAZ0CwmkAuE4gY594vrf1OZYaal3QTIOnsUToTgnbQqPy8TrMipD
         LcF1gy/nHNgzXOdJHeCQnO1gPhqBpnv5RQbOniWd+7UiwP7e9vM0Kv1LPsLjA5/b7RN1
         QB1Ukok+mDye7buyR0oPEcLWV7ao8g7v/rsSLcavDF7uSgMkhUrQYAtQn+1xPIZLaCmR
         UaF/h71bRUAXPlVcHtzpzdwhxsOpMECQlzDTAEFBtRrbCvh6fLhE5wb1ySzL+/+ML6EM
         5DVhF4kB5XceqEUgldTVJQUQFLkm6CcChcHqyZFHz0z2MtG8BwiI+BeZzEe+2dGqLTzO
         VOww==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@nxp.com header.s=selector1 header.b=a/DdBsqB;
       spf=pass (google.com: domain of laurentiu.tudor@nxp.com designates 104.47.1.57 as permitted sender) smtp.mailfrom=laurentiu.tudor@nxp.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nxp.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@nxp.com header.s=selector1 header.b=a/DdBsqB;
       spf=pass (google.com: domain of laurentiu.tudor@nxp.com designates 104.47.1.57 as permitted sender) smtp.mailfrom=laurentiu.tudor@nxp.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nxp.com
From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
To: gregkh <gregkh@linuxfoundation.org>
CC: Andrew Lunn <andrew@lunn.ch>, Stuart Yoder <stuyoder@gmail.com>, Arnd
 Bergmann <arnd@arndb.de>, Ioana Ciornei <ioana.ciornei@nxp.com>, Linux Kernel
 Mailing List <linux-kernel@vger.kernel.org>, Ruxandra Ioana Ciocoi Radulescu
	<ruxandra.radulescu@nxp.com>, Razvan Stefanescu <razvan.stefanescu@nxp.com>,
	Roy Pledge <roy.pledge@nxp.com>, Networking <netdev@vger.kernel.org>
Subject: Re: [PATCH v3 2/4] bus: fsl-mc: add restool userspace support
Thread-Topic: [PATCH v3 2/4] bus: fsl-mc: add restool userspace support
Thread-Index: AQHTwr0s//RURDTyGEKsLhU+ZuPm16PfBFwAgAa39ICAABVLAIAJ+AgAgAATBYCAACYwgIAAnIoAgAFtPQCAACGcAIAAG8sA
Date: Thu, 5 Apr 2018 14:09:47 +0000
Message-ID: <5AC62E2A.90900@nxp.com>
References: <cover.1521818402.git.ioana.ciornei@nxp.com>
 <d8c243a9ead2fe1375dee242aec26d1276129409.1521818402.git.ioana.ciornei@nxp.com>
 <CAK8P3a089ZiPdp1CcVct8Kac+ejkNP8TrVpWYSr_nMGo4goO1Q@mail.gmail.com>
 <HE1PR04MB32126A07A4B4CC7225E661E4E0A30@HE1PR04MB3212.eurprd04.prod.outlook.com>
 <CAK8P3a1aQCm_r95Ka4x+j8SJLCLFvLuX3A4twK1WJcJs66YwKg@mail.gmail.com>
 <CAEac7tZ4we46EEa2DuAbmMr+hW6Q4BoBKJFFf1k_k57r2oJpng@mail.gmail.com>
 <20180404010549.GA12443@lunn.ch>
 <CAEac7tYSAmgt-kAcLNToKdrBOZhvq4Q+HxYEG+NkGZAk6kDADw@mail.gmail.com>
 <20180404124246.GA20869@lunn.ch> <5AC5FAA8.80409@nxp.com>
 <20180405123018.GA17751@kroah.com>
In-Reply-To: <20180405123018.GA17751@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=laurentiu.tudor@nxp.com;
x-originating-ip: [86.34.165.90]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR0401MB2190;7:D+Cax2y5aMKjwByYOFqJFkNcG7K1dqNGknj6g98r4vOQu6K/HW6/oVB6m8WYYqx9v4gNOWOY67CG/8IT78WgkJYLZGzJttWKoyUl7W2MPErA7w2Jg/P7REWKRSX+0vBuYC2fslWVT/pRWDYqdIFYe49R+D7gJeglHipxh+mSPCqlOhSSM24WqHFc75a0/aho0uq3GH5iwoJvtHlGofKPPI7EPh2EgPJ8UKL4AA1w9GQ9CcFfDTCY4tju6OF38uat
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 84bc3932-34c8-4937-3469-08d59afee3e0
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:VI1PR0401MB2190;
x-ms-traffictypediagnostic: VI1PR0401MB2190:
x-microsoft-antispam-prvs: <VI1PR0401MB21900E24F520A75B6BF681CAECBB0@VI1PR0401MB2190.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197)(264314650089876);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231221)(944501327)(52105095)(6055026)(6041310)(20161123558120)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011);SRVR:VI1PR0401MB2190;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0401MB2190;
x-forefront-prvs: 06339BAE63
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(39860400002)(346002)(396003)(39380400002)(376002)(51444003)(199004)(189003)(68736007)(316002)(6246003)(229853002)(446003)(6116002)(36756003)(3846002)(476003)(11346002)(105586002)(5660300001)(8936002)(2906002)(6436002)(8676002)(66066001)(7736002)(97736004)(86362001)(81166006)(305945005)(2616005)(486006)(4326008)(6486002)(25786009)(81156014)(5250100002)(14454004)(186003)(54906003)(93886005)(39060400002)(6512007)(966005)(478600001)(3660700001)(99286004)(6306002)(106356001)(6916009)(102836004)(6506007)(2900100001)(26005)(53936002)(65816011)(33656002)(53546011)(3280700002)(76176011);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0401MB2190;H:VI1PR0401MB1856.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: eVB4SFp1oJHE7QbHB/NZwscWvSivP1GNR9V0eCNWn59uwXREGlu6vuX6osSOxtUfwOWpdw6+SnWO0BN7rgKbEXufubSQf1eEGsGPgnyYaFPDuC6KKWQrIyFw7TyJNk3XNi6UpKJH2LvRINVs6N9mk239LIZyIdzarfELUrtapq9VMtBBEMxsz18KoKegzGckUlLkUIXN4fSDXOmHPq4Qw1tzvGa4utzZgenXcawPVfGdwbRgzdyqcH45sZ8bmL6tpZUUitG97fvKKiwKNvkhfLTnW8/DOx2/9BkL64tJTbpIxhCm96RcBjcj+0tE9m6H4PSzNbweCHXrzkC9w3fBRNcjdOQiFbv23kHe9uGHQ/QvaQhudJp7vfxJGvN2/7NP3DBmJ5TFSMRKoRHJgmbflVXiMPuantXYlIwnaOkPpH0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <685363DCA298C5448132CF2A2F6647A2@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84bc3932-34c8-4937-3469-08d59afee3e0
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Apr 2018 14:09:47.6879
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0401MB2190
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595743497041548891?=
X-GMAIL-MSGID: =?utf-8?q?1596915598473978736?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

SGkgR3JlZywNCg0KT24gMDQvMDUvMjAxOCAwMzozMCBQTSwgZ3JlZ2toIHdyb3RlOg0KPiBPbiBU
aHUsIEFwciAwNSwgMjAxOCBhdCAxMDozMDowMUFNICswMDAwLCBMYXVyZW50aXUgVHVkb3Igd3Jv
dGU6DQo+PiBIZWxsbywNCj4+DQo+PiBNeSAyYyBiZWxvdy4NCj4+DQo+PiBPbiAwNC8wNC8yMDE4
IDAzOjQyIFBNLCBBbmRyZXcgTHVubiB3cm90ZToNCj4+Pj4gSSBoZWFyIHlvdS4gIEl0IGlzIG1v
cmUgY29tcGxpY2F0ZWQgdGhpcyB3YXkuLi5oYXZpbmcgYWxsIHRoZXNlIGluZGl2aWR1YWwNCj4+
Pj4gb2JqZWN0cyB2cyBqdXN0IGEgc2luZ2xlICJidW5kbGUiIG9mIHRoZW0gdGhhdCByZXByZXNl
bnRzIGEgTklDLiAgQnV0LCB0aGF0J3MNCj4+Pj4gdGhlIHdheSB0aGUgRFBBQTIgaGFyZHdhcmUg
aXMsIGFuZCB3ZSdyZSBpbXBsZW1lbnRpbmcga2VybmVsIHN1cHBvcnQgZm9yDQo+Pj4+IHRoZSBo
YXJkd2FyZSBhcyBpdCBpcy4NCj4+Pg0KPj4+IEhpIFN0dWFydA0KPj4+DQo+Pj4gSSBzZWUgd2Ug
YXJlIG5vdCBtYWtpbmcgYW55IHByb2dyZXNzIGhlcmUuDQo+Pj4NCj4+PiBTbyB3aGF0IGkgc3Vn
Z2VzdCBpcyB5b3UgcG9zdCB0aGUga2VybmVsIGNvZGUgYW5kIGNvbmZpZ3VyYXRpb24gdG9vbA0K
Pj4+IGNvbmNlcHQgdG8gbmV0ZGV2IGZvciBhIGZ1bGwgcmV2aWV3LiBZb3Ugd2FudCByZXZpZXdz
IGZyb20gRGF2aWQNCj4+PiBNaWxsZXIsIEppcmkgUGlya28sIEpha3ViIEtpY2luc2tpLCBEYXZp
ZCBBaGVybiwgZXRjLg0KPj4+DQo+Pg0KPj4gSSB0aGluayB0aGF0IHRoZSBkaXNjdXNzaW9uIHN0
ZWVyZWQgdG9vIG11Y2ggdG93YXJkcyBuZXR3b3JraW5nIHJlbGF0ZWQNCj4+IHRvcGljcywgd2hp
bGUgdGhpcyBpb2N0bCBkb2Vzbid0IGhhdmUgbXVjaCB0byBkbyB3aXRoIG5ldHdvcmtpbmcuDQo+
PiBJdCdzIGp1c3QgYW4gaW9jdGwgZm9yIG91ciBtYy1idXMgYnVzIGRyaXZlciB0aGF0IGlzIHVz
ZWQgdG8gbWFuYWdlIHRoZQ0KPj4gZGV2aWNlcyBvbiB0aGlzIGJ1cyB0aHJvdWdoIHVzZXJzcGFj
ZSB0b29scy4NCj4+IEluIGFkZGl0aW9uLCBJJ2QgZHJvcCBhbnkgbWVudGlvbiBvZiBvdXIgcmVm
ZXJlbmNlIHVzZXIgc3BhY2UgYXBwDQo+PiAocmVzdG9vbCkgdG8gZW1waGFzaXplIHRoYXQgdGhp
cyBpb2N0bCBpcyBub3QgYWRkZWQganVzdCBmb3IgYQ0KPj4gcGFydGljdWxhciB1c2VyIHNwYWNl
IGFwcC4gSSB0aGluayBTdHVhcnQgYWxzbyBtZW50aW9uZWQgdGhpcy4NCj4NCj4gSSdtIG5vdCBn
b2luZyB0byB0YWtlIGEgImdlbmVyaWMgZGV2aWNlIGNvbmZpZ3VyYXRpb24gaW9jdGwiIHBhdGNo
DQo+IHVubGVzcyBpdCBpcyBkb2N1bWVudGVkIHRvIGFsbCBleGFjdGx5IHdoYXQgaXQgZG9lcywg
YW5kIHdoeSBpdCBpcw0KPiB0aGVyZS4NCg0KVGhlIGlvY3RsKCkgaXMganVzdCBhIHNpbXBsZSBw
YXNzLXRocm91Z2ggaW50ZXJmYWNlIHRvIHRoZSBmaXJtd2FyZS4NCkl0IHBhc3NlcyBjb21tYW5k
cyB0byB0aGUgZmlybXdhcmUgYW5kIHJldHVybnMgdGhlIHJlc3BvbnNlIGJhY2sgdG8gdGhlIA0K
dXNlcnNwYWNlLiBUaHVzIHRoZSBBQkkgdXNlZCBieSB0aGUgZmlybXdhcmUgYXBwbGllcyBmb3Ig
dGhpcyBpb2N0bCgpIA0KYW5kIGl0IGlzIGRvY3VtZW50ZWQgaW4gZGV0YWlsIGhlcmU6DQoNCmh0
dHBzOi8vd3d3Lm54cC5jb20vZG9jcy9lbi91c2VyLWd1aWRlL0RQQUEyX1VNLnBkZg0KDQotLS0N
CkJlc3QgUmVnYXJkcywgTGF1cmVudGl1
