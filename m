Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54015C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 11:16:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 013B720874
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 11:15:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="JtrmgexK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731223AbeL1LP7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 06:15:59 -0500
Received: from mail-eopbgr00086.outbound.protection.outlook.com ([40.107.0.86]:48928
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728367AbeL1LP6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 06:15:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pKnZl5qhjDQAgyC6NI/lg+RmJMCdH+UCMmWZUTuXN6Y=;
 b=JtrmgexKYL95YG7ErZGCQeP6PyHKhEsLnBe7Q88ybSLsxKzSLpqwLgVgpsRP/Rq0nVp0PD02VZtR1x2emMy5SKBvfwgs2nRchtxwoQqKlWV/EXZ1PpmroJ2MKtZ8qidxsVUzLzMPedSA9HxkiM8eVc4ZpiM/+H7hMlso95p9xAs=
Received: from AM3PR08MB0611.eurprd08.prod.outlook.com (10.163.188.149) by
 AM3PR08MB0184.eurprd08.prod.outlook.com (10.161.35.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1471.20; Fri, 28 Dec 2018 11:15:50 +0000
Received: from AM3PR08MB0611.eurprd08.prod.outlook.com
 ([fe80::3c73:534c:9c6e:352d]) by AM3PR08MB0611.eurprd08.prod.outlook.com
 ([fe80::3c73:534c:9c6e:352d%2]) with mapi id 15.20.1471.019; Fri, 28 Dec 2018
 11:15:50 +0000
From:   "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>
CC:     Liviu Dudau <Liviu.Dudau@arm.com>,
        "Jonathan Chai (Arm Technology China)" <Jonathan.Chai@arm.com>,
        Brian Starkey <Brian.Starkey@arm.com>,
        "Julien Yin (Arm Technology China)" <Julien.Yin@arm.com>,
        "thomas Sun (Arm Technology China)" <thomas.Sun@arm.com>,
        Alexandru-Cosmin Gheorghe <Alexandru-Cosmin.Gheorghe@arm.com>,
        "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>,
        Ayan Halder <Ayan.Halder@arm.com>,
        "Tiannan Zhu (Arm Technology China)" <Tiannan.Zhu@arm.com>,
        "Jin Gao (Arm Technology China)" <Jin.Gao@arm.com>,
        "Yiqi Kang (Arm Technology China)" <Yiqi.Kang@arm.com>,
        nd <nd@arm.com>, "malidp@foss.arm.com" <malidp@foss.arm.com>,
        "maarten.lankhorst@linux.intel.com" 
        <maarten.lankhorst@linux.intel.com>,
        "maxime.ripard@bootlin.com" <maxime.ripard@bootlin.com>,
        "sean@poorly.run" <sean@poorly.run>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "mchehab+samsung@kernel.org" <mchehab+samsung@kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "nicolas.ferre@microchip.com" <nicolas.ferre@microchip.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        Mark Rutland <Mark.Rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "yamada.masahiro@socionext.com" <yamada.masahiro@socionext.com>
Subject: Re: [PATCH v3 9/9] MAINTAINERS: Add maintainer for arm komeda driver
Thread-Topic: [PATCH v3 9/9] MAINTAINERS: Add maintainer for arm komeda driver
Thread-Index: AQHUmRQWeovHOOq9j0aufyIPqdEpbA==
Date:   Fri, 28 Dec 2018 11:15:50 +0000
Message-ID: <20181228111534.GA19025@james-ThinkStation-P300>
References: <20181221095757.15510-1-james.qian.wang@arm.com>
 <20181221095757.15510-10-james.qian.wang@arm.com>
 <20181224123314.GK22341@e110455-lin.cambridge.arm.com>
 <CAKMK7uGt63=_KuECQc2ivuSZb8gMD1=6n0=Q2bcvzCEPo84uFw@mail.gmail.com>
In-Reply-To: <CAKMK7uGt63=_KuECQc2ivuSZb8gMD1=6n0=Q2bcvzCEPo84uFw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mutt/1.9.4 (2018-02-28)
x-originating-ip: [113.29.88.7]
x-clientproxiedby: SYXPR01CA0125.ausprd01.prod.outlook.com
 (2603:10c6:0:2d::34) To AM3PR08MB0611.eurprd08.prod.outlook.com
 (2a01:111:e400:c408::21)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM3PR08MB0184;6:o5de2F2WPnmFM+ANs8mF8yq86CtlgrSk9tzTE5bgi2lUp5bbNekmAgzkllVREXKrk4gEIo4PEMwsNmxmLVip/jS71c8FLqLZL156/qLnqD8BS8xUrn/fd6q3EDPwOugSW7W/vI5OG5rHPMaO0khaYpRTiqbIDZnUVDzdkFvqUftKfOotOl8GtiVm5tViaJREBo3wLXJZrI2ht+zeP+yKm4JXTicvwoZZT3XGtzm6pmxUOIb11O8VNCcYME0ahhWt2A55qsRg663sFy8wGzeBUUXO8lvuNY83n8+onP9WN7GVj8O/VLb3jwCQQbIuRuq06rU5mpBrutkpu+Xzbl8CNbD/Psd/v0GyxmdkPmHzHtbrX3l5WJcdkPNomh89Mqof6VVILHYzEg6os0mWDOP1Tja4w3iJCIKHapcy8lUVAmmZXlSMrG42vVK2MslKe1eDHsNzO2oVMIU69c4MDXEgsfHbIyRxCyl7KcHMvEgNzoI=;5:/r4VGhEMdBCC1F5LaMIuny8fT8dZCOWJ4vutriZCEq21V9Oyh6X1et836wm7ks7dIz+MOBlokHy6qSYwbuv3YyKFX8es5THHGHfUybe8hjCa/DYcwuQ5xVXIw/w80t4gD7ZGWtmK7yCRJyh/oT/VAs8/sCItiVsUeY1dUxzZk34=;7:icjAx4OLbKKqtGZp969A72In6XbRUuE1R2J0svKTt2LP+Z7r06dAcxEq/DX94EPdgrXrgeIlzgOasBMnfSzBK9rl+ZW0opPxpE2i6OIZJA+AKbiaRv/dXCVPkkrNJpnq5MPettrXmKOWgULAHWgaXg==
x-ms-office365-filtering-correlation-id: 99982d56-d648-409b-37e2-08d66cb5d2a9
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600109)(711020)(4618075)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:AM3PR08MB0184;
x-ms-traffictypediagnostic: AM3PR08MB0184:
nodisclaimer: True
x-microsoft-antispam-prvs: <AM3PR08MB0184F3240F41540ED696FDFDB3B70@AM3PR08MB0184.eurprd08.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(908002)(999002)(5005026)(6040522)(2401047)(8121501046)(3002001)(3231475)(944501520)(4982022)(52105112)(10201501046)(93006095)(93001095)(6055026)(6041310)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:AM3PR08MB0184;BCL:0;PCL:0;RULEID:;SRVR:AM3PR08MB0184;
x-forefront-prvs: 09007040D4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(7916004)(366004)(396003)(346002)(376002)(136003)(39860400002)(199004)(189003)(11346002)(478600001)(446003)(14444005)(229853002)(6306002)(3846002)(53936002)(6486002)(966005)(6512007)(86362001)(6436002)(6246003)(6116002)(9686003)(4326008)(2906002)(256004)(476003)(1076003)(6916009)(486006)(305945005)(33716001)(55236004)(102836004)(33656002)(7736002)(386003)(68736007)(8676002)(81156014)(71190400001)(53546011)(99286004)(5660300001)(25786009)(93886005)(81166006)(58126008)(186003)(6506007)(33896004)(105586002)(97736004)(316002)(14454004)(106356001)(54906003)(26005)(52116002)(71200400001)(7416002)(66066001)(8936002)(76176011)(18370500001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM3PR08MB0184;H:AM3PR08MB0611.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: UWSJdauJhLyoVwP0YubrhryqXm8K/nydKdRvskarIuRpaaVjeKO0FDZ3OZ8SdnU9DKowIdmzDoGyJC68/8Eb6hgsKWcLVhtqfP8V1Z6G+GNL3RfgTEHugIy7CQwgKtjX+1TK3rCWdQsrAC6rQKysKDsIkUI9dUsMBei3UA1gObMY05DzU9ZSgDcyUlEZ7x6jqn/ZUBPbEzdlK96SbB67Zx1hvvLCURtMlnBaXDECBDC3xrUJeLSGttzfOrWIG/HHXC3XmDDCjEfWtqPmwIAugRjlckiKjRIpPaXE2n0dsFWPZCOX+gb9RGpykZM57Pmh
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <BAC77A78A210154DBBF52CA4E104FF1E@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99982d56-d648-409b-37e2-08d66cb5d2a9
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Dec 2018 11:15:50.2802
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM3PR08MB0184
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCBEZWMgMjQsIDIwMTggYXQgMDI6MDU6NDNQTSArMDEwMCwgRGFuaWVsIFZldHRlciB3
cm90ZToNCj4gT24gTW9uLCBEZWMgMjQsIDIwMTggYXQgMTozMyBQTSBMaXZpdSBEdWRhdSA8TGl2
aXUuRHVkYXVAYXJtLmNvbT4gd3JvdGU6DQo+ID4NCj4gPiBPbiBGcmksIERlYyAyMSwgMjAxOCBh
dCAxMDowMTowNkFNICswMDAwLCBqYW1lcyBxaWFuIHdhbmcgKEFybSBUZWNobm9sb2d5IENoaW5h
KSB3cm90ZToNCj4gPiA+IHYyOiBBZGp1c3RlZCB0aGUgcG9zaXRpb24gb2YgS09NRURBIGJ5IGFs
cGhhYmV0aWNhbCBvcmRlcg0KPiA+ID4NCj4gPiA+IFNpZ25lZC1vZmYtYnk6IEphbWVzIChRaWFu
KSBXYW5nIDxqYW1lcy5xaWFuLndhbmdAYXJtLmNvbT4NCj4gPg0KPiA+IEFja2VkLWJ5OiBMaXZp
dSBEdWRhdSA8bGl2aXUuZHVkYXVAYXJtLmNvbT4NCj4gPg0KPiA+IEJlc3QgcmVnYXJkcywNCj4g
PiBMaXZpdQ0KPiA+DQo+ID4gPiAtLS0NCj4gPiA+ICBNQUlOVEFJTkVSUyB8IDkgKysrKysrKysr
DQo+ID4gPiAgMSBmaWxlIGNoYW5nZWQsIDkgaW5zZXJ0aW9ucygrKQ0KPiA+ID4NCj4gPiA+IGRp
ZmYgLS1naXQgYS9NQUlOVEFJTkVSUyBiL01BSU5UQUlORVJTDQo+ID4gPiBpbmRleCAyNTRiN2Iy
Njc3MzEuLmU0OGMyZTVmZDI5ZiAxMDA2NDQNCj4gPiA+IC0tLSBhL01BSU5UQUlORVJTDQo+ID4g
PiArKysgYi9NQUlOVEFJTkVSUw0KPiA+ID4gQEAgLTExMjQsNiArMTEyNCwxNSBAQCBTOiAgICAg
U3VwcG9ydGVkDQo+ID4gPiAgRjogICBkcml2ZXJzL2dwdS9kcm0vYXJtL2hkbGNkXyoNCj4gPiA+
ICBGOiAgIERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9kaXNwbGF5L2FybSxoZGxj
ZC50eHQNCj4gPiA+DQo+ID4gPiArQVJNIEtPTUVEQSBEUk0tS01TIERSSVZFUg0KPiA+ID4gK006
ICAgSmFtZXMgKFFpYW4pIFdhbmcgPGphbWVzLnFpYW4ud2FuZ0Bhcm0uY29tPg0KPiA+ID4gK006
ICAgTWFsaSBEUCBNYWludGFpbmVycyA8bWFsaWRwQGZvc3MuYXJtLmNvbT4NCj4gPiA+ICtTOiAg
IFN1cHBvcnRlZA0KPiA+ID4gK0Y6ICAgZHJpdmVycy9ncHUvZHJtL2FybS9kaXNwbGF5L2luY2x1
ZGUvDQo+ID4gPiArRjogICBkcml2ZXJzL2dwdS9kcm0vYXJtL2Rpc3BsYXkva29tZWRhLw0KPiA+
ID4gK0Y6ICAgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2Rpc3BsYXkvYXJtL2Fy
bSxrb21lZGEudHh0DQo+ID4gPiArRjogICBEb2N1bWVudGF0aW9uL2dwdS9rb21lZGEta21zLnJz
dA0KPiANCj4gTWVudGlvbmluZyB0aGUgZ2l0IHRyZWUgd291bGQgYmUgZ29vZC4gQW5kIEkgZ3Vl
c3MgeW91J2xsIGRvIHNvbWUga2luZA0KPiBvZiBncm91cCBtYWludGFpbmVyc2hpcD8gUHJvYmFi
bHkgc3RpbGwgZ29vZCBpZiB5b3Ugc2VuZCBvdXQgYQ0KPiBkZWRpY2F0ZWQvdG9waWMgcHVsbCBy
ZXF1ZXN0IGZvciB0aGlzIG5ldyBkcml2ZXIsIGJ1dCBmcm9tIHRoZW4gb24NCj4gaXQncyBhbGwg
aW4gdGhlIHNhbWUgZ2l0IHJlcG8uDQo+IC1EYW5pZWwNCg0KSGkgRGFuaWVsOg0KDQpUaGUga29t
ZWRhIGRyaXZlciB3aWxsIHVzZSBhbiBBcm0taG9zdGVkIHRyZWU6DQoNCmdpdCBnaXQ6Ly9saW51
eC1hcm0ub3JnL2xpbnV4LWxkLmdpdCBmb3ItdXBzdHJlYW0vbWFsaS1kcA0KDQpTYW1lIGFzIG90
aGVyIGFybSBkaXNwbGF5IGRyaXZlcnMuIEFuZCBMaXZpdSBEdWRhdSB3aWxsIGhlbHAgdG8gc2Vu
ZCB0aGUgcHVsbA0KcmVxdWVzdCB0byBtZXJnZSB0aGlzIHRvcGljIGludG8gZHJtLW5leHQuDQoN
CkFuZCB3ZSBhcmUgcGxhbm5pbmcgdG8gYWRvcHQgYSBncm91cCBtYWludGFpbmVyc2hpcCBhbmQg
bWlncmF0ZSB0b3dhcmRzIGRybS1taXNjLW5leHQsDQpidXQgd2UganVzdCBuZWVkIHRvIGhhdmUg
ZW5vdWdoIHBlb3BsZSBhbmQgZW5vdWdoIGV4cGVyaWVuY2Ugd2l0aCB3b3JraW5nIHdpdGggdXBz
dHJlYW0NCmJlZm9yZSB3ZSBqdW1wIGFsbCBpbi4NCg0KTGFzdCBhIFQ6IGVudHJ5IHdpbGwgYmUg
YWRkZWQgaW4gdGhlIG5leHQgdmVyc2lvbi4NCg0KVDogICAgICBnaXQgZ2l0Oi8vbGludXgtYXJt
Lm9yZy9saW51eC1sZC5naXQgZm9yLXVwc3RyZWFtL21hbGktZHANCg0KSmFtZXMNCg0KPiA+ID4g
Kw0KPiA+ID4gIEFSTSBNQUxJLURQIERSTSBEUklWRVINCj4gPiA+ICBNOiAgIExpdml1IER1ZGF1
IDxsaXZpdS5kdWRhdUBhcm0uY29tPg0KPiA+ID4gIE06ICAgQnJpYW4gU3RhcmtleSA8YnJpYW4u
c3RhcmtleUBhcm0uY29tPg0KPiA+ID4gLS0NCj4gPiA+IDIuMTcuMQ0KPiA+ID4NCj4gPg0KPiA+
IC0tDQo+ID4gPT09PT09PT09PT09PT09PT09PT0NCj4gPiB8IEkgd291bGQgbGlrZSB0byB8DQo+
ID4gfCBmaXggdGhlIHdvcmxkLCAgfA0KPiA+IHwgYnV0IHRoZXkncmUgbm90IHwNCj4gPiB8IGdp
dmluZyBtZSB0aGUgICB8DQo+ID4gIFwgc291cmNlIGNvZGUhICAvDQo+ID4gICAtLS0tLS0tLS0t
LS0tLS0NCj4gPiAgICAgwq9cXyjjg4QpXy/Crw0KPiANCj4gDQo+IA0KPiAtLSANCj4gRGFuaWVs
IFZldHRlcg0KPiBTb2Z0d2FyZSBFbmdpbmVlciwgSW50ZWwgQ29ycG9yYXRpb24NCj4gKzQxICgw
KSA3OSAzNjUgNTcgNDggLSBodHRwOi8vYmxvZy5mZndsbC5jaA0K
