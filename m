Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB02FECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 06:23:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C44820673
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 06:23:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="DTsGPPxh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C44820673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727648AbeGTHKI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 03:10:08 -0400
Received: from mail-eopbgr690064.outbound.protection.outlook.com ([40.107.69.64]:23107
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727240AbeGTHKI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 03:10:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L2nVPeF/BIfzFYYFK56JfJuhhfmcprrPS/x8rcMo7pk=;
 b=DTsGPPxhGuUUe27EzqgfvfRyVWx3hhkWb/Z4Arc40V/XifAjg78ZuRxOsN1BJIQ1t6ASbmaO6PX4Y/u07+EB9YO5EyqaX1+Wzj55AH/FA1gTOrcvfuCua+A4u38LrThyvhD1rPrrXS75aFjXmXe+uN1BL8HncPj0+BAdaCksMOE=
Received: from SN6PR02MB4959.namprd02.prod.outlook.com (52.135.116.89) by
 SN6PR02MB4704.namprd02.prod.outlook.com (52.135.113.213) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.973.16; Fri, 20 Jul 2018 06:23:19 +0000
Received: from SN6PR02MB4959.namprd02.prod.outlook.com
 ([fe80::fda4:6729:248f:71c7]) by SN6PR02MB4959.namprd02.prod.outlook.com
 ([fe80::fda4:6729:248f:71c7%4]) with mapi id 15.20.0973.018; Fri, 20 Jul 2018
 06:23:17 +0000
From:   Manish Narani <MNARANI@xilinx.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Moritz Fischer <mdf@kernel.org>,
        "stefan.krsmanovic@aggios.com" <stefan.krsmanovic@aggios.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Michal Simek <michals@xilinx.com>
Subject: RE: [RFC PATCH 3/3] sdhci: arasan: Add support to read Tap Delay
 values from DT
Thread-Topic: [RFC PATCH 3/3] sdhci: arasan: Add support to read Tap Delay
 values from DT
Thread-Index: AQHT/ljITFQme7ObgE2kg4lbhDXBJ6SIVCaAgAytqyA=
Date:   Fri, 20 Jul 2018 06:23:16 +0000
Message-ID: <SN6PR02MB4959F4BE25593EC7589DC34AC1510@SN6PR02MB4959.namprd02.prod.outlook.com>
References: <1528373500-24663-1-git-send-email-manish.narani@xilinx.com>
 <1528373500-24663-3-git-send-email-manish.narani@xilinx.com>
 <CAPDyKFoGJOE-h4rLqzMO=wzNjkfcuU_oQ3NLK5=OQfSMj3dDHg@mail.gmail.com>
In-Reply-To: <CAPDyKFoGJOE-h4rLqzMO=wzNjkfcuU_oQ3NLK5=OQfSMj3dDHg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=MNARANI@xilinx.com; 
x-originating-ip: [182.72.145.30]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SN6PR02MB4704;6:QHR+gPpVb2vxpynKl5v1G+ieHuhZgPE+efYzg2CAnY+nD/bGIRVkRC+QhNEv0vxgd8S8AfMywaDU3d0bO2JFn6cfMUdsAPydlEJWocZXSSN7IAmC5YVRTvLbimTB+VfAae2DFhtzWq0J/LJqCOjTHqgJjtieSa1NZYDMgnykyJTIEcc1vxj6wv92Sy+2WLxOAfeYKbY+lpSaelhlPsjIvDRj2H1T2BbZY44ZBxgKJIeJ4nIb6aa3nrfK+kL2sSm0/1qk3Ov+uYOhp/Xj4phAZGcDrpXAsBapbFVb+0BCDV++MfgXSk4IhWeniw93GFWvURXDG4kkfomtAbIK+B0sXoXfc1jy7BPtCcPWz8fb+ogks84rxb8NQi1+zJ3334gb5CLzJKMY0Ttp+cRXYwTUmx0wGyucN21+K5k2U3DQoLVf/IdLqbkEEe73Zu4yWVyBOSYzT4vXOG0OEVkzv/ROUA==;5:yvvD7RF0bpRgHv5Ry+loaSQ+8aBlZbtqOVQhSEVE2Yx8r4kmiaMNMCq2I9/SEW8x5oSr3gqqa4kmf+5AB0oa4gtIVnyJggdZIMifNDv6pFZd8/DuMg7R9n91NzDqAmOk4Kafa2OK5TBmAkiN97Ge7UN0zVltc3F6W9QrOLPVEwc=;7:bxIk0osyH7hLNNnO4k/BIMZ6UhP7rWHK5NG7Hc1lp8aYN+ma2gkTOL8Um99Jt6mWbXoM4aNxJ27IBXdtTzIO3tXQiRKCeJB5b1aY0Hb07wGmx5qgQTw8Q782nRtt2u2NKsHnVqRDpelqFe0swFrL59IUeQD/VhcYIoUnwlcOoYukZdvFoMhbRiC4pXYhPixlFDF4jZuK/zD+2uNZfF0hRwkapI/aEBTCJqm4nf1/9uyCfdHpYTs66rBaP2VadHWN
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-ms-office365-filtering-correlation-id: 505293b4-8868-42d2-e0db-08d5ee0947e0
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(8990107)(48565401081)(2017052603328)(7153060)(7193020);SRVR:SN6PR02MB4704;
x-ms-traffictypediagnostic: SN6PR02MB4704:
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-microsoft-antispam-prvs: <SN6PR02MB4704CA561138D6F030564592C1510@SN6PR02MB4704.namprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(180628864354917)(9452136761055)(258649278758335)(192813158149592)(228905959029699);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3002001)(3231311)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:SN6PR02MB4704;BCL:0;PCL:0;RULEID:;SRVR:SN6PR02MB4704;
x-forefront-prvs: 073966E86B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(366004)(136003)(39860400002)(396003)(13464003)(199004)(189003)(6916009)(7696005)(76176011)(186003)(74316002)(6436002)(446003)(11346002)(25786009)(53936002)(107886003)(316002)(229853002)(7736002)(6246003)(54906003)(305945005)(33656002)(4326008)(2900100001)(8676002)(478600001)(99286004)(8936002)(55236004)(106356001)(6506007)(105586002)(53546011)(2906002)(81166006)(81156014)(9686003)(102836004)(6116002)(3846002)(55016002)(72206003)(14454004)(86362001)(5250100002)(26005)(575784001)(68736007)(476003)(5660300001)(7416002)(66066001)(486006)(217873002)(256004)(14444005)(97736004);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR02MB4704;H:SN6PR02MB4959.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: UHh270xmmSVA9XU80tD63rdZsJsnHPNMEqSYwNVnVTLmG0sDem5nPPtsEaQ546kwQqaUGdXerT+pp61IRQK2WyvhIyk5CruH/MSiDj+ta7TSKqVDnha6h9InDKshgo0O3d5nxHIo+uJzpOBg9rIfVi7Bo1j7mzzRF4ESjJTaPWIDvoFICCW6NjgV7LkofYEHu4fca6wzsnFN2ACohINOdzPe/gfdluKWlmFVvt7E8CRElNbcsMZ3U8X2LCBe5+LU53EqZqbOsGwkSazqXL/feASwXu5h+kO+n9o2iw6T0j+qmCLw88TvyF9b+Gz7RAucFC5ZAHS+nwqRj2xAI0HRqq+33JcTMRe4PltoJ1tOwCM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 505293b4-8868-42d2-e0db-08d5ee0947e0
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2018 06:23:16.9892
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB4704
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgVWZmZSwNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBVbGYgSGFu
c3NvbiBbbWFpbHRvOnVsZi5oYW5zc29uQGxpbmFyby5vcmddDQo+IFNlbnQ6IFR1ZXNkYXksIEp1
bHkgMTAsIDIwMTggMjowMiBQTQ0KPiBUbzogTWFuaXNoIE5hcmFuaSA8TU5BUkFOSUB4aWxpbngu
Y29tPg0KPiBDYzogUm9iIEhlcnJpbmcgPHJvYmgrZHRAa2VybmVsLm9yZz47IE1hcmsgUnV0bGFu
ZA0KPiA8bWFyay5ydXRsYW5kQGFybS5jb20+OyBDYXRhbGluIE1hcmluYXMgPGNhdGFsaW4ubWFy
aW5hc0Bhcm0uY29tPjsgV2lsbA0KPiBEZWFjb24gPHdpbGwuZGVhY29uQGFybS5jb20+OyBNb3Jp
dHogRmlzY2hlciA8bWRmQGtlcm5lbC5vcmc+Ow0KPiBzdGVmYW4ua3JzbWFub3ZpY0BhZ2dpb3Mu
Y29tOyBMaW51eCBBUk0gPGxpbnV4LWFybS0NCj4ga2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc+
OyBMaW51eCBLZXJuZWwgTWFpbGluZyBMaXN0IDxsaW51eC0NCj4ga2VybmVsQHZnZXIua2VybmVs
Lm9yZz47IGxpbnV4LW1tY0B2Z2VyLmtlcm5lbC5vcmc7DQo+IGRldmljZXRyZWVAdmdlci5rZXJu
ZWwub3JnOyBBZHJpYW4gSHVudGVyIDxhZHJpYW4uaHVudGVyQGludGVsLmNvbT47DQo+IE1pY2hh
bCBTaW1layA8bWljaGFsc0B4aWxpbnguY29tPg0KPiBTdWJqZWN0OiBSZTogW1JGQyBQQVRDSCAz
LzNdIHNkaGNpOiBhcmFzYW46IEFkZCBzdXBwb3J0IHRvIHJlYWQgVGFwIERlbGF5DQo+IHZhbHVl
cyBmcm9tIERUDQo+IA0KPiBPbiA3IEp1bmUgMjAxOCBhdCAxNDoxMSwgTWFuaXNoIE5hcmFuaSA8
bWFuaXNoLm5hcmFuaUB4aWxpbnguY29tPiB3cm90ZToNCj4gPiBUaGlzIHBhdGNoIGFkZHMgc3Vw
cG9ydCBmb3IgcmVhZGluZyBUYXAgRGVsYXkgdmFsdWVzIGZyb20gRGV2aWNlIFRyZWUNCj4gPiBh
bmQgd3JpdGUgdGhlbSB2aWEgZWVtaSBjYWxscy4gVGhlIG1hY3JvcyBjb250YWluaW5nIHRoZXNl
IHRhcCBkZWxheQ0KPiA+IHZhbHVlcyBhcmUgcmVtb3ZlZCBmcm9tIHRoZSBkcml2ZXIuDQo+ID4N
Cj4gPiBTaWduZWQtb2ZmLWJ5OiBNYW5pc2ggTmFyYW5pIDxtYW5pc2gubmFyYW5pQHhpbGlueC5j
b20+DQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvbW1jL2hvc3Qvc2RoY2ktb2YtYXJhc2FuLmMgfCAx
MzENCj4gPiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+ID4gIDEgZmls
ZSBjaGFuZ2VkLCAxMzEgaW5zZXJ0aW9ucygrKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvbW1jL2hvc3Qvc2RoY2ktb2YtYXJhc2FuLmMNCj4gPiBiL2RyaXZlcnMvbW1jL2hvc3Qvc2Ro
Y2ktb2YtYXJhc2FuLmMNCj4gPiBpbmRleCBlMzMzMmE1Li5mYzBmZDAxIDEwMDY0NA0KPiA+IC0t
LSBhL2RyaXZlcnMvbW1jL2hvc3Qvc2RoY2ktb2YtYXJhc2FuLmMNCj4gPiArKysgYi9kcml2ZXJz
L21tYy9ob3N0L3NkaGNpLW9mLWFyYXNhbi5jDQo+ID4gQEAgLTM2LDYgKzM2LDggQEANCj4gPg0K
PiA+ICAjZGVmaW5lIFBIWV9DTEtfVE9PX1NMT1dfSFogICAgICAgICAgICA0MDAwMDANCj4gPg0K
PiA+ICsjZGVmaW5lIE1NQ19CQU5LMiAgICAgICAgICAgICAgMHgyDQo+ID4gKw0KPiA+ICAvKg0K
PiA+ICAgKiBPbiBzb21lIFNvQ3MgdGhlIHN5c2NvbiBhcmVhIGhhcyBhIGZlYXR1cmUgd2hlcmUg
dGhlIHVwcGVyIDE2LWJpdHMgb2YNCj4gPiAgICogZWFjaCAzMi1iaXQgcmVnaXN0ZXIgYWN0IGFz
IGEgd3JpdGUgbWFzayBmb3IgdGhlIGxvd2VyIDE2LWJpdHMuDQo+ID4gVGhpcyBhbGxvd3MgQEAg
LTkwLDYgKzkyLDEwIEBAIHN0cnVjdCBzZGhjaV9hcmFzYW5fZGF0YSB7DQo+ID4gICAgICAgICBz
dHJ1Y3Qgc2RoY2lfaG9zdCAqaG9zdDsNCj4gPiAgICAgICAgIHN0cnVjdCBjbGsgICAgICAqY2xr
X2FoYjsNCj4gPiAgICAgICAgIHN0cnVjdCBwaHkgICAgICAqcGh5Ow0KPiA+ICsgICAgICAgdTMy
IG1pb19iYW5rOw0KPiA+ICsgICAgICAgdTMyIGRldmljZV9pZDsNCj4gPiArICAgICAgIHUzMiBp
dGFwZGx5W01NQ19USU1JTkdfTU1DX0hTNDAwICsgMV07DQo+ID4gKyAgICAgICB1MzIgb3RhcGRs
eVtNTUNfVElNSU5HX01NQ19IUzQwMCArIDFdOw0KPiA+ICAgICAgICAgYm9vbCAgICAgICAgICAg
IGlzX3BoeV9vbjsNCj4gPg0KPiA+ICAgICAgICAgYm9vbCAgICAgICAgICAgIGhhc19jcWU7DQo+
ID4gQEAgLTE2MCwxMSArMTY2LDM2IEBAIHN0YXRpYyBpbnQgc2RoY2lfYXJhc2FuX3N5c2Nvbl93
cml0ZShzdHJ1Y3QNCj4gc2RoY2lfaG9zdCAqaG9zdCwNCj4gPiAgICAgICAgIHJldHVybiByZXQ7
DQo+ID4gIH0NCj4gPg0KPiA+ICsvKioNCj4gPiArICogYXJhc2FuX3p5bnFtcF9zZXRfdGFwX2Rl
bGF5IC0gUHJvZ3JhbSB0aGUgdGFwIGRlbGF5cy4NCj4gPiArICogQGRldmljZWlkOiAgICAgICAg
ICBVbmlxdWUgSWQgb2YgZGV2aWNlDQo+ID4gKyAqIEBpdGFwX2RlbGF5OiAgICAgICAgICAgICAg
ICBJbnB1dCBUYXAgRGVsYXkNCj4gPiArICogQG9pdGFwX2RlbGF5OiAgICAgICBPdXRwdXQgVGFw
IERlbGF5DQo+ID4gKyAqLw0KPiA+ICtzdGF0aWMgdm9pZCBhcmFzYW5fenlucW1wX3NldF90YXBf
ZGVsYXkodTggZGV2aWNlaWQsIHU4IGl0YXBfZGVsYXksDQo+ID4gK3U4IG90YXBfZGVsYXkpIHsN
Cj4gPiArICAgICAgIGNvbnN0IHN0cnVjdCB6eW5xbXBfZWVtaV9vcHMgKmVlbWlfb3BzID0NCj4g
PiArenlucW1wX3BtX2dldF9lZW1pX29wcygpOw0KPiANCj4gTm8gdGhhbmtzIQ0KPiANCj4gSXNu
J3QgdGhlcmUgYSBtb3JlIGdlbmVyaWMgZnJhbWV3b3JrIHdlIGNhbiB1c2UgdG8gY2hhbmdlIHRo
ZSB0YXAgdmFsdWVzLA0KPiByYXRoZXIgdGhhbiBjYWxsaW5nIFNvQyBzcGVjaWZpYyBmdW5jdGlv
bnMgZnJvbSB0aGUgZHJpdmVyPw0KWWVzLCBUaGFua3MgZm9yIHlvdXIgc3VnZ2VzdGlvbi4gSSB3
aWxsIHdvcmsgb24gdGhlIGdlbmVyaWMgZnJhbWV3b3JrIHdoaWNoIHdpbGwgYmUgdXNlZCB0byBj
aGFuZ2UgdGFwIHZhbHVlcw0KVmlhIFNvQyBkcml2ZXJzLg0KPiANCj4gQlRXLCB3aGF0IGlzIGEg
dGFwIHZhbHVlLCBtb3JlIGV4YWN0bHk/DQo+IFdoYXQgZG9lcyBjaGFuZ2luZyBhIHRhcCB2YWx1
ZSBtZWFuIGFuZCB3aGVyZSBkb2VzIHRoZSBwcm9wZXJ0eSBiZWxvbmcsDQo+IHJlYWxseT8NClRh
cCBWYWx1ZSBpcyB0aGUgZGVsYXkgb2YgY2xvY2sgcGhhc2Ugd2hpY2ggaXMgdXNlZCB0byBhZGp1
c3QgcGhhc2UgdG8gdGhlIHdvcmtpbmcgdmFsdWUuIFRoZSBhdXRvIHR1bmluZw0KcHJvY2VzcyBn
ZW5lcmFsbHkgc2V0cyB0YXAgdmFsdWVzIGludGVybmFsbHkgaW4gY29udHJvbGxlciBpbiBTRCBV
SFMgbW9kZXMuIEJ1dCBmb3Igb3RoZXIgbW9kZXMgd2hlcmUNCmF1dG8gdHVuaW5nIGlzIGFwcGxp
Y2FibGUsIHdlIGFyZSBkZXRlcm1pbmluZyB0YXAgdmFsdWVzIHZpYSB0cmlhbCAmIGVycm9yIG1l
dGhvZCBmb3Igc3BlY2lmaWMgU29DLg0KPiA+IA0KPiBPZiBjb3Vyc2UgdGhpcyBkb2Vzbid0IGV2
ZW4gY29tcGlsZSwgYXMgeW91IGhhdmUgYSBkZXBlbmRlbmN5IHRvIGFub3RoZXINCj4gc2VyaWVz
LiBOZXh0IHRpbWUsIHBsZWFzZSBjbGFyaWZ5IHRoYXQgaW4gYSBjb3Zlci1sZXR0ZXIgKG1heWJl
IHlvdSBkaWQsIGJ1dCBJDQo+IGNhbid0IGZpbmQgaXQpLg0KPiANCj4gPiArICAgICAgIHUzMiBu
b2RlX2lkID0gKGRldmljZWlkID09IDApID8gTk9ERV9TRF8wIDogTk9ERV9TRF8xOw0KPiA+ICsN
Cj4gPiArICAgICAgIGlmICghZWVtaV9vcHMgfHwgIWVlbWlfb3BzLT5pb2N0bCkNCj4gPiArICAg
ICAgICAgICAgICAgcmV0dXJuOw0KPiA+ICsNCj4gPiArICAgICAgIGlmIChpdGFwX2RlbGF5KQ0K
PiA+ICsgICAgICAgICAgICAgICBlZW1pX29wcy0+aW9jdGwobm9kZV9pZCwgSU9DVExfU0VUX1NE
X1RBUERFTEFZLA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgUE1fVEFQREVM
QVlfSU5QVVQsIGl0YXBfZGVsYXksIE5VTEwpOw0KPiA+ICsNCj4gPiArICAgICAgIGlmIChvdGFw
X2RlbGF5KQ0KPiA+ICsgICAgICAgICAgICAgICBlZW1pX29wcy0+aW9jdGwobm9kZV9pZCwgSU9D
VExfU0VUX1NEX1RBUERFTEFZLA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
UE1fVEFQREVMQVlfT1VUUFVULCBvdGFwX2RlbGF5LCBOVUxMKTsNCj4gPiArfQ0KPiANCj4gQW5v
dGhlciBvdmVyYWxsIGNvbW1lbnQgZm9yIHRoZSBzZXJpZXMuDQo+IA0KPiBJIHdvdWxkIHJlY29t
bWVuZCB0byBjaGFuZ2UgdGhlIG9yZGVyIG9mIHRoZSBwYXRjaGVzIGluIHRoZSBzZXJpZXMuDQo+
IExldCB0aGUgRFQgZG9jIGNoYW5nZSBjb21lIGZpcnN0LCBuZXh0IHRoZSBkcml2ZXIgY2hhbmdl
IGFuZCBmaW5hbGx5IHRoZSBjaGFuZ2UNCj4gdG8gdGhlIERUUyBmaWxlKHMpLiBUaGlzIG1ha2Vz
IGl0IGVhc2llciB0byBmb2xsb3cgYW5kIHJldmlldy4NClN1cmUsIEkgd2lsbCBkbyB0aGF0Lg0K
DQpUaGFua3MgJiBSZWdhcmRzLA0KTWFuaXNoDQoNCj4gDQo+IFsuLi5dDQo+IA0KPiBLaW5kIHJl
Z2FyZHMNCj4gVWZmZQ0K
