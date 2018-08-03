Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A12DBC28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 17:59:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40F92217A2
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 17:59:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="QVOKHOL6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40F92217A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728833AbeHCT5B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 15:57:01 -0400
Received: from mail-eopbgr680080.outbound.protection.outlook.com ([40.107.68.80]:46528
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727356AbeHCT5B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 15:57:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pdaVklVFWcXRSN7eUJO2wxc6O67O+JdR7PlzeHUFxVk=;
 b=QVOKHOL6Gzre75LQ7gd/WJgRxScvDFVfNVHNkI40/LkGUUo5q0I4LU3hJ3kE+9scQ0l8QNe4iz31ZpzJr9Jx/5+ifEz3IOC4QmjM4ciRMXEKvxa9/j4M5kYFb+VajLIyjAbOqRcR7WwIMwZATbONQm2B+uc/WauR0CJO+rh3X64=
Received: from CY1PR02MB2138.namprd02.prod.outlook.com (10.166.190.144) by
 CY1PR02MB1721.namprd02.prod.outlook.com (10.162.165.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1017.15; Fri, 3 Aug 2018 17:59:37 +0000
Received: from CY1PR02MB2138.namprd02.prod.outlook.com
 ([fe80::9469:3f99:3931:2f92]) by CY1PR02MB2138.namprd02.prod.outlook.com
 ([fe80::9469:3f99:3931:2f92%3]) with mapi id 15.20.1017.010; Fri, 3 Aug 2018
 17:59:35 +0000
From:   Jolly Shah <JOLLYS@xilinx.com>
To:     Michal Simek <michals@xilinx.com>, Stephen Boyd <sboyd@kernel.org>,
        "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>,
        "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "hkallweit1@gmail.com" <hkallweit1@gmail.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "matt@codeblueprint.co.uk" <matt@codeblueprint.co.uk>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "sboyd@codeaurora.org" <sboyd@codeaurora.org>,
        "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
        Michal Simek <michals@xilinx.com>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Rajan Vaja <RAJANV@xilinx.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH v10 00/10] drivers: Introduce firmware dnd clock river for
 ZynqMP core
Thread-Topic: [PATCH v10 00/10] drivers: Introduce firmware dnd clock river
 for ZynqMP core
Thread-Index: AQHUHgiyrPpyPLTCbkmEsgOh0EA57qSWW8yAgAhcQECAAQXvAIACA62AgAYKHwCABT+ggIAAmv6AgADEjBA=
Date:   Fri, 3 Aug 2018 17:59:35 +0000
Message-ID: <CY1PR02MB2138A6BBE829400CEABA5AAFB8230@CY1PR02MB2138.namprd02.prod.outlook.com>
References: <1531857547-16652-1-git-send-email-jollys@xilinx.com>
 <2c3aad45-37ce-2446-4b90-bddb477286ed@xilinx.com>
 <CY1PR02MB2138E21A3FFBD5FEEAA7D6D4B8550@CY1PR02MB2138.namprd02.prod.outlook.com>
 <19376df2-fdd4-12e3-da4c-37106fffed19@xilinx.com>
 <153262301567.48062.15432354725863055071@swboyd.mtv.corp.google.com>
 <e5448935-770a-5c14-438c-23a652b17822@xilinx.com>
 <153324358299.10763.8724416723915219268@swboyd.mtv.corp.google.com>
 <d153598d-8d09-fb32-f68e-6fc4975eb9ce@xilinx.com>
In-Reply-To: <d153598d-8d09-fb32-f68e-6fc4975eb9ce@xilinx.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=JOLLYS@xilinx.com; 
x-originating-ip: [149.199.62.133]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY1PR02MB1721;6:AxVt2qTpYENePKx2GI8dzghu8/Xpz6fmVMrSGK1pZB19hVrFg/quB8YDZvzGsvA33o/p1hT78q4uMBvecW143AF91Rvtji8XiWH+jEvX7OxAnGDnWJVcM6seYuTlW/QyJwL8lOO5ww3OzDZXdhY/4soXkqUDG+IqPLsv6Q45hsNmi5rJ0q2S6c8h+6HyfuHc7fuzckVdLsVou9LE6WFgtlyD72b8ooGXBURdRCYwxGfeYLqXSPGyfRcqU9xH5XM6UMZChHQkaHnfedMAzVY44/DGLRZpNLXzZwxoARv+f/ITztYz2kx3cmMwt8fDgizOoIJzQp2DJGBoVYVTIhscLFdseZDgzi8hkq4NvXMfHo9XPfdq+lWRd7fghHMxT7qbOPOg8U1NOrZJCLZGxYTTz+id/aMJ+7Wt0XWlPpf9GyHn05nuSEYCJzvrvMNW38u/XGynlBBe98m+Jhg0oBW+6A==;5:W8F6/kgJESL9gInYHBjzlAiCe6xZNGkq/6Pn+QzqbijGBVI51Yn0MRJT7NoNogc/DSuXqZH1qhNA2zj+Bux1F5GSeKq70PVakX7taLF4KVZMJeF3mpHm2XfVwJXPjaVeHr6UazIbgV2rtGpj6UejCT1ktZOnFlU18uUgkD+5qV8=;7:58UWhE6A9P4/bZD2qSUTtHyornmq95eakI50RVVYf8yRN/+K7iaO3GXB7lnas8rzLHfAeGFqLPN3ha0zIxDw4HiU9K23/NjfPThZCg9Qld2Fiqxr/GD5u/YDdppM3hXpfyCLmc6YcyCVUPT7vfHuXQZypMnRwAqw3YwAONm+vF+lg2qZiMPW0+Qt4ioycQoQJpahaNMjM3O7uaduKP+wMzaq20H4Z1PMxMyjsGXLy2wCKI3oTy+hzHrk5feAi2EJ
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(39860400002)(396003)(346002)(136003)(376002)(366004)(189003)(199004)(13464003)(4326008)(76176011)(446003)(476003)(53936002)(99286004)(486006)(6436002)(8676002)(7696005)(966005)(66066001)(6506007)(105586002)(106356001)(5660300001)(8936002)(2501003)(6636002)(5250100002)(11346002)(7416002)(2900100001)(305945005)(229853002)(316002)(7736002)(74316002)(33656002)(25786009)(478600001)(39060400002)(55016002)(102836004)(86362001)(2906002)(2201001)(54906003)(256004)(3846002)(93886005)(53546011)(81156014)(14454004)(110136005)(9686003)(6306002)(6246003)(6116002)(72206003)(81166006)(68736007)(97736004)(26005)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR02MB1721;H:CY1PR02MB2138.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-office365-filtering-correlation-id: 8f7924da-8fb3-42a8-a7ba-08d5f96adfc3
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:CY1PR02MB1721;
x-ms-traffictypediagnostic: CY1PR02MB1721:
x-microsoft-antispam-prvs: <CY1PR02MB1721D7E8C95705D1472B7FBCB8230@CY1PR02MB1721.namprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(180628864354917)(166708455590820)(9452136761055)(85827821059158)(258649278758335)(192813158149592);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231311)(944501410)(52105095)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:CY1PR02MB1721;BCL:0;PCL:0;RULEID:;SRVR:CY1PR02MB1721;
x-forefront-prvs: 0753EA505A
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: Ox4UzezYs6+jGn1JWzv02Zdw0nNbDKeShgW9mmmT4VzMrNNc/4NSBNT83wEY5ptt58+Ykr+W7Dg2LwDNP+xE+iVqRLacWGM1lgrPjmrxjUWRn4CtjFLyutLkR5RLLAnacOFmngO/iiQ/BAFnEwDxbPmOqJAF12ffWPZu4KNzi520pYfrQfkIGGMAgunonUgAMyjaAe1IdIFUJnOS0SSxuxtdi0D9MrBti0H+jsGrWA6qDxXNY35QkZ0WpiJj07SiXTwlKYQ0mxUC78b4f6F2WpLcQUpxAJxvAbU5GqkWQhyu2il0kpAu3zd/GrsHW+tCTOlrX1YstPgd3nCLDu3vdZ/PBb97vk/MniuTEascy8E=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f7924da-8fb3-42a8-a7ba-08d5f96adfc3
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Aug 2018 17:59:35.7933
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR02MB1721
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTWljaGFsLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IGxpbnV4
LWtlcm5lbC1vd25lckB2Z2VyLmtlcm5lbC5vcmcgW21haWx0bzpsaW51eC1rZXJuZWwtDQo+IG93
bmVyQHZnZXIua2VybmVsLm9yZ10gT24gQmVoYWxmIE9mIE1pY2hhbCBTaW1law0KPiBTZW50OiBU
aHVyc2RheSwgQXVndXN0IDAyLCAyMDE4IDExOjE0IFBNDQo+IFRvOiBTdGVwaGVuIEJveWQgPHNi
b3lkQGtlcm5lbC5vcmc+OyBhcmQuYmllc2hldXZlbEBsaW5hcm8ub3JnOw0KPiBkbWl0cnkudG9y
b2tob3ZAZ21haWwuY29tOyBncmVna2hAbGludXhmb3VuZGF0aW9uLm9yZzsNCj4gaGthbGx3ZWl0
MUBnbWFpbC5jb207IGtlZXNjb29rQGNocm9taXVtLm9yZzsgbGludXgtY2xrQHZnZXIua2VybmVs
Lm9yZzsNCj4gbWFyay5ydXRsYW5kQGFybS5jb207IG1hdHRAY29kZWJsdWVwcmludC5jby51azsg
bWluZ29Aa2VybmVsLm9yZzsNCj4gbXR1cnF1ZXR0ZUBiYXlsaWJyZS5jb207IHJvYmgrZHRAa2Vy
bmVsLm9yZzsgc2JveWRAY29kZWF1cm9yYS5vcmc7DQo+IHN1ZGVlcC5ob2xsYUBhcm0uY29tOyBK
b2xseSBTaGFoIDxKT0xMWVNAeGlsaW54LmNvbT47IE1pY2hhbCBTaW1law0KPiA8bWljaGFsc0B4
aWxpbnguY29tPg0KPiBDYzogZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7IFJhamFuIFZhamEg
PFJBSkFOVkB4aWxpbnguY29tPjsgbGludXgtDQo+IGtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGxp
bnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENI
IHYxMCAwMC8xMF0gZHJpdmVyczogSW50cm9kdWNlIGZpcm13YXJlIGRuZCBjbG9jayByaXZlciBm
b3INCj4gWnlucU1QIGNvcmUNCj4gDQo+IE9uIDIuOC4yMDE4IDIyOjU5LCBTdGVwaGVuIEJveWQg
d3JvdGU6DQo+ID4gUXVvdGluZyBNaWNoYWwgU2ltZWsgKDIwMTgtMDctMzAgMDU6NTA6NDIpDQo+
ID4+IE9uIDI2LjcuMjAxOCAxODozNiwgU3RlcGhlbiBCb3lkIHdyb3RlOg0KPiA+Pj4gUXVvdGlu
ZyBNaWNoYWwgU2ltZWsgKDIwMTgtMDctMjUgMDI6NTE6MTQpDQo+ID4+Pj4gT24gMjQuNy4yMDE4
IDIwOjE0LCBKb2xseSBTaGFoIHdyb3RlOg0KPiA+Pj4+Pj4+ICBjcmVhdGUgbW9kZSAxMDA2NDQg
ZHJpdmVycy9maXJtd2FyZS94aWxpbngvenlucW1wLWRlYnVnLmgNCj4gPj4+Pj4+PiAgY3JlYXRl
IG1vZGUgMTAwNjQ0IGRyaXZlcnMvZmlybXdhcmUveGlsaW54L3p5bnFtcC5jICBjcmVhdGUNCj4g
Pj4+Pj4+PiBtb2RlDQo+ID4+Pj4+Pj4gMTAwNjQ0IGluY2x1ZGUvZHQtYmluZGluZ3MvY2xvY2sv
eGxueCx6eW5xbXAtY2xrLmgNCj4gPj4+Pj4+PiAgY3JlYXRlIG1vZGUgMTAwNjQ0IGluY2x1ZGUv
bGludXgvZmlybXdhcmUveGxueC16eW5xbXAuaA0KPiA+Pj4+Pj4+DQo+ID4+Pj4+Pg0KPiA+Pj4+
Pj4gSXQgbG9va3MgcHJldHR5IGNhbG0gb3ZlciB0aGUgbGFzdCBzZXZlcmFsIHNlcmllcyB0aGF0
J3Mgd2h5IHdoZW4NCj4gPj4+Pj4+IEkgZ2V0IGFuIGFuc3dlciBmcm9tIFN0ZXBoZW4gb3IgTWlr
ZSBJIHdpbGwgdGFrZSB0aGlzIHNlcmllcyB2aWEgbXkgdHJlZQ0KPiBhbmQgYXJtLXNvYyB0cmVl
Lg0KPiA+Pj4+Pj4NCj4gPj4+Pj4+IEkgaGF2ZSBhcHBsaWVkIDAxLTA4IGhlcmUNCj4gPj4+Pj4+
ICBodHRwczovL2dpdGh1Yi5jb20vWGlsaW54L2xpbnV4LXhsbngvY29tbWl0cy96eW5xbXAvc29j
DQo+ID4+Pj4+Pg0KPiA+Pj4+Pj4gVGhhbmtzLA0KPiA+Pj4+Pj4gTWljaGFsDQo+ID4+Pj4+DQo+
ID4+Pj4+DQo+ID4+Pj4+IFRoYW5rcyBmb3IgbWVyZ2luZyB0aGUgcGF0Y2hlcy4NCj4gPj4+Pj4g
QnkgbWlzdGFrZSBJIGFkZGVkIOKAnFJldmlld2VkLWJ5OiBTdGVwaGVuIEJveWQgc2JveWRAa2Vy
bmVsLm9yZ+KAnSBmb3INCj4gZmlybXdhcmUgYmluZGluZ3MgKFBhdGNoMDEpLiAgU3RlcGhlbiBo
YWQgcmV2aWV3ZWQgY2xvY2sgYmluZGluZ3Mgb25seS4gIFBsZWFzZQ0KPiBzdWdnZXN0IGlmIEkg
c2hvdWxkIHNlbmQgYSBuZXcgdmVyc2lvbiB3aXRoIHRoYXQgZml4Lg0KPiA+Pj4+DQo+ID4+Pj4g
SSBoYXZlIGZpeGVkIHRoYXQgaW4gbXkgYnJhbmNoIGFuZCBJIGhhdmUgYXNrZWQgU2hlcGhlbiB0
byBsb29rIGF0DQo+ID4+Pj4gY2xrIG92ZXIgY2hhdC4NCj4gPj4+Pg0KPiA+Pj4NCj4gPj4+IEkg
aGF2ZSBzb21lIHVucmVzb2x2ZWQgcmV2aWV3IGNvbW1lbnRzIG9uIHY5LiBJJ2xsIGdpdmUgcmV2
aWV3ZWQtYnkNCj4gPj4+IHdoZW4gdGhhdCBkaXNjdXNzaW9uIGlzIHJlc29sdmVkLg0KPiA+Pg0K
PiA+PiBvay4gRG8geW91IHdhbnQgdG8gdGFrZSB0aGVtIHZpYSBjbGsgdHJlZSBvciB2aWEgYXJt
LXNvYyB0cmVlPw0KPiA+Pg0KPiA+DQo+ID4gSSdtIGZpbmUgZm9yIHRoZSBjbGsgcGF0Y2ggdG8g
Z28gdmlhIGFybS1zb2MgaWYgdGhhdCBtYWtlcyBpdCBlYXNpZXIuDQo+ID4NCj4gDQo+IG9rLiBH
cmVhdC4NCj4gSm9sbHk6IFBsZWFzZSBhZGRyZXNzIGFsbCBTdGVwaGVuJ3MgY29tbWVudHMgdGhh
dCB3ZSBjYW4gbW92ZS4NCj4gDQo+IFRoYW5rcywNCj4gTWljaGFsDQoNClBvc3RlZCBWMTEgcGF0
Y2ggc2V0IHdpdGggYWxsIGhpcyBjb21tZW50cyBhZGRyZXNzZWQuIA0KDQpUaGFua3MsDQpKb2xs
eSBTaGFoDQo=
