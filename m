Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 8DBEEC07D5C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 12:10:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CF95208CB
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 12:10:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=renesasgroup.onmicrosoft.com header.i=@renesasgroup.onmicrosoft.com header.b="LYpCzyxg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CF95208CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936092AbeFNMKh (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 08:10:37 -0400
Received: from relmlor3.renesas.com ([210.160.252.173]:61317 "EHLO
        relmlie2.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1755069AbeFNMKe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 08:10:34 -0400
Received: from unknown (HELO relmlir1.idc.renesas.com) ([10.200.68.151])
  by relmlie2.idc.renesas.com with ESMTP; 14 Jun 2018 21:10:32 +0900
Received: from relmlii2.idc.renesas.com (relmlii2.idc.renesas.com [10.200.68.66])
        by relmlir1.idc.renesas.com (Postfix) with ESMTP id 7C080865EA;
        Thu, 14 Jun 2018 21:10:32 +0900 (JST)
X-IronPort-AV: E=Sophos;i="5.51,222,1526310000"; 
   d="scan'208";a="284010424"
Received: from mail-os2jpn01lp0146.outbound.protection.outlook.com (HELO JPN01-OS2-obe.outbound.protection.outlook.com) ([23.103.139.146])
  by relmlii2.idc.renesas.com with ESMTP/TLS/AES256-SHA256; 14 Jun 2018 21:10:32 +0900
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector1-bp-renesas-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RvBnyphAqx7lBjP5BFgIFKkLKa/pPBt6RgTkSvK9cSQ=;
 b=LYpCzyxgabu/AvlJPSnlMc7iMcw0o5KfS+LHI9nN9kVRfy6f82KfMiZ794jW76cHENd6aQfgihGtvXfoJh/RGY+/xaKwfnjUWmP0TTUa7CPvQ5ES1MF5/2/UKJWb++eMaamFlnU35JkEr0SJEMGaDsfYOOp55p1k/vGPST0tRI4=
Received: from OSBPR01MB2054.jpnprd01.prod.outlook.com (52.134.240.151) by
 OSBPR01MB2294.jpnprd01.prod.outlook.com (52.134.243.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.863.17; Thu, 14 Jun 2018 12:10:28 +0000
Received: from OSBPR01MB2054.jpnprd01.prod.outlook.com
 ([fe80::41ec:3e89:c18c:1b11]) by OSBPR01MB2054.jpnprd01.prod.outlook.com
 ([fe80::41ec:3e89:c18c:1b11%3]) with mapi id 15.20.0863.016; Thu, 14 Jun 2018
 12:10:28 +0000
From:   Michel Pollet <michel.pollet@bp.renesas.com>
To:     jacopo mondi <jacopo@jmondi.org>
CC:     "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        Simon Horman <horms@verge.net.au>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Michel Pollet <buserror+upstream@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v1 2/5] dt-bindings: clock: renesas,r9a06g032-pinctrl:
 documentation
Thread-Topic: [PATCH v1 2/5] dt-bindings: clock: renesas,r9a06g032-pinctrl:
 documentation
Thread-Index: AQHUA8+m177UAcNwi0yuFsjuR4E/uaRfqCYAgAAApJA=
Date:   Thu, 14 Jun 2018 12:10:28 +0000
Message-ID: <OSBPR01MB2054FBD2836B478B83D96C9CD27D0@OSBPR01MB2054.jpnprd01.prod.outlook.com>
References: <1528974029-29617-1-git-send-email-michel.pollet@bp.renesas.com>
 <1528974029-29617-3-git-send-email-michel.pollet@bp.renesas.com>
 <20180614120446.GA12638@w540>
In-Reply-To: <20180614120446.GA12638@w540>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=michel.pollet@bp.renesas.com; 
x-originating-ip: [193.141.220.21]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;OSBPR01MB2294;7:3AiptQNjCk8rmohUvW8bUKry82zdxYmrNWxv/nZLSwK4EI5QUOVRspTgemltLBgcl2g7rizA9Z9exulIXAe/KwSTzg4atJ9+t8jLjiDyaj4vEkez2E4EdqGJvSuCDznRF1eaUkBQiOBXmOe/GGapot/zExluzIG1VEU8ztxGnP9YISfedy1xkFUZkxQv+/DLhygQ/5UdyfRUzAdnuvLKh/FpnJkDcgUZPBRyeJ9vD8rdzNlz/2wzptu1kltQ79Bc;20:UdNt4pNbUXW9hkKUGeohWYIt/VfLvlQbAr5OofQuyFEIVEPCxDaYWG0J0ICHG067mU/EjgTgMtWftXi51C+UcDL7IPut5EfM8Bf39eT7XtBTEdTHejh/ycX3lZmWgqFjjMTUy8WuGasseiMruqIOiOk3VY98cPhVreKq71qOJNk=
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 85eaf335-d000-47ef-e9cd-08d5d1efd1b0
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(711020)(2017052603328)(7153060)(7193020);SRVR:OSBPR01MB2294;
x-ms-traffictypediagnostic: OSBPR01MB2294:
x-microsoft-antispam-prvs: <OSBPR01MB2294EDC5FD39803F005AF679D27D0@OSBPR01MB2294.jpnprd01.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231254)(944501410)(52105095)(3002001)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:OSBPR01MB2294;BCL:0;PCL:0;RULEID:;SRVR:OSBPR01MB2294;
x-forefront-prvs: 0703B549E4
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(396003)(39380400002)(346002)(376002)(199004)(189003)(37524003)(3846002)(99286004)(4326008)(5250100002)(7416002)(33656002)(74316002)(478600001)(7736002)(305945005)(86362001)(6116002)(68736007)(8676002)(25786009)(2906002)(11346002)(446003)(6436002)(55016002)(6246003)(476003)(39060400002)(53936002)(66066001)(486006)(3280700002)(44832011)(6506007)(53546011)(3660700001)(14454004)(76176011)(6916009)(54906003)(26005)(316002)(81156014)(81166006)(105586002)(2900100001)(5660300001)(102836004)(9686003)(97736004)(186003)(8936002)(7696005)(106356001)(229853002)(142933001);DIR:OUT;SFP:1102;SCL:1;SRVR:OSBPR01MB2294;H:OSBPR01MB2054.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:0;MX:1;
received-spf: None (protection.outlook.com: bp.renesas.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 9iNmO/+2cA+bNtIdVQfpEO2ZwoNPeDxvgVPcaNAegqAj1nNDJwFwBWoejaAnXljmy09g+ILPlt8sIE2YFwvnMqxXlS2LSFatJoIJ8c9tF2jghDmc5s3uIbgtx63Xu3EqsPR5DbdYsm7jVgHWiFVC2QuyqGQ0euHVOgKNm/Tuy9dhKCpqSyk4WJ9HLlnYOHAC
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85eaf335-d000-47ef-e9cd-08d5d1efd1b0
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2018 12:10:28.5714
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB2294
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgSmFjb3BvLA0KDQpPbiAxNCBKdW5lIDIwMTggMTM6MDUsIEphY29wbyB3cm90ZToNCj4gSGkg
TWljaGVsLA0KPg0KPiBPbiBUaHUsIEp1biAxNCwgMjAxOCBhdCAxMjowMDoxOFBNICswMTAwLCBN
aWNoZWwgUG9sbGV0IHdyb3RlOg0KPiA+IFRoZSBSZW5lc2FzIFI5QTA2RzAzMiBQSU5DVFJMIG5v
ZGUgZGVzY3JpcHRpb24uDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBNaWNoZWwgUG9sbGV0IDxt
aWNoZWwucG9sbGV0QGJwLnJlbmVzYXMuY29tPg0KPiA+IC0tLQ0KPiA+ICAuLi4vYmluZGluZ3Mv
cGluY3RybC9yZW5lc2FzLHI5YTA2ZzAzMi1waW5jdHJsLnR4dCB8IDEyNA0KPiA+ICsrKysrKysr
KysrKysrKysrKysrKw0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMTI0IGluc2VydGlvbnMoKykNCj4g
PiAgY3JlYXRlIG1vZGUgMTAwNjQ0DQo+ID4gRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRp
bmdzL3BpbmN0cmwvcmVuZXNhcyxyOWEwNmcwMzItcGluY3RybC50eA0KPiA+IHQNCj4gPg0KPiA+
IGRpZmYgLS1naXQNCj4gPiBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9waW5j
dHJsL3JlbmVzYXMscjlhMDZnMDMyLXBpbmN0cmwuDQo+ID4gdHh0DQo+ID4gYi9Eb2N1bWVudGF0
aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcGluY3RybC9yZW5lc2FzLHI5YTA2ZzAzMi1waW5jdHJs
Lg0KPiA+IHR4dA0KPiA+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQo+ID4gaW5kZXggMDAwMDAwMC4u
ZjYzNjk2Zg0KPiA+IC0tLSAvZGV2L251bGwNCj4gPiArKysgYi9Eb2N1bWVudGF0aW9uL2Rldmlj
ZXRyZWUvYmluZGluZ3MvcGluY3RybC9yZW5lc2FzLHI5YTA2ZzAzMi1waW5jDQo+ID4gKysrIHRy
bC50eHQNCj4gPiBAQCAtMCwwICsxLDEyNCBAQA0KPiA+ICtSZW5lc2FzIFJaL0ExIGNvbWJpbmVk
IFBpbiBhbmQgR1BJTyBjb250cm9sbGVyDQo+ID4gKw0KPiA+ICtUaGUgUmVuZXNhcyBTb0NzIG9m
IHRoZSBSWi9BMSBmYW1pbHkgZmVhdHVyZSBhIGNvbWJpbmVkIFBpbiBhbmQgR1BJTw0KPiA+ICtj
b250cm9sbGVyLCBuYW1lZCAiUG9ydHMiIGluIHRoZSBoYXJkd2FyZSByZWZlcmVuY2UgbWFudWFs
Lg0KPiA+ICtQaW4gbXVsdGlwbGV4aW5nIGFuZCBHUElPIGNvbmZpZ3VyYXRpb24gaXMgcGVyZm9y
bWVkIG9uIGEgcGVyLXBpbg0KPiA+ICtiYXNpcyB3cml0aW5nIGNvbmZpZ3VyYXRpb24gdmFsdWVz
IHRvIHBlci1wb3J0IHJlZ2lzdGVyIHNldHMuDQo+ID4gK0VhY2ggInBvcnQiIGZlYXR1cmVzIHVw
IHRvIDE2IHBpbnMsIGVhY2ggb2YgdGhlbSBjb25maWd1cmFibGUgZm9yDQo+ID4gK0dQSU8gZnVu
Y3Rpb24gKHBvcnQgbW9kZSkgb3IgaW4gYWx0ZXJuYXRlIGZ1bmN0aW9uIG1vZGUuDQo+ID4gK1Vw
IHRvIDggZGlmZmVyZW50IGFsdGVybmF0ZSBmdW5jdGlvbiBtb2RlcyBleGlzdCBmb3IgZWFjaCBz
aW5nbGUgcGluLg0KPg0KPiBUaGlzIGlzIGEgcGxhaW4gY29weSBvZiB0aGUgUlovQTEgcGluIGNv
bnRyb2xsZXIgZG9jdW1lbnRhdGlvbi4NCj4gSSBkb24ndCBrbm93IFJaL04gZGV2aWNlcyBhbmQg
Y2Fubm90IHRlbGwgaWYgaXQgYXBwbGllcyBoZXJlIHRvbywgYnV0IHRoaXMgbmVlZHMNCj4gYW4g
cy9BMS9OIGF0IHRoZSBsZWFzdC4NCj4NCj4gRnJvbSBhIHZlcnkgc3VwZXJmaWNpYWwgbG9vayBh
dCB0aGUgcHJvcG9zZWQgYmluZGluZ3MgYW5kIHBpbmN0cmwgZHJpdmVyLCBJDQo+IHdvbmRlciBp
ZiB0aGUgcnphMSBwaW5jdHJsIGRyaXZlciBjb3VsZCBiZSBleHBhbmRlZCBhbmQgcmUtdXNlZC4N
Cj4gSGF2ZSB5b3UgY29uc2lkZXJlZCB0aGF0IGJlZm9yZSBzdGFydGluZyBvbmUgZnJvbSBzY3Jh
dGNoPw0KDQpTb3JyeSBpdCdzIGp1c3QgdGhlIHN0YXJ0IG9mIHRoZSBkb2N1bWVudGF0aW9uIHdo
aWNoIEkgd3JvbmdseSBjdXQvcGFzdGVkIC0tIHRoZQ0KcmVzdCBpcyBjb21wbGV0ZWx5IGRpZmZl
cmVudDsgdGhlIG9ubHkgcmVhc29uIEExIGlzIG1lbnRpb25lZCBoZXJlIGlzIHRoYXQgSSB1c2Vk
DQp0aGF0IGZpbGUgYXMgYSB0ZW1wbGF0ZSBmb3IgdGhlIGhlYWRlci9zZWN0aW9ucyBldGMuLi4g
U29tZWhvdyB0aGUgdGl0bGUrYmx1cmINCndlbnQgdW5lZGl0ZWQhDQoNCkFuZCBubywgaW4gdGVy
bXMgb2YgZnVuY3Rpb25hbGl0aWVzLCB0aGV5IGFyZSBjb21wbGV0ZWx5IGRpZmZlcmVudCBJUHMu
DQoNCk1pY2hlbA0KDQo+DQo+IFRoYW5rcw0KPiAgICBqDQo+DQo+ID4gKw0KPiA+ICtQaW4gY29u
dHJvbGxlciBub2RlDQo+ID4gKy0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gPiArDQo+ID4gK1JlcXVp
cmVkIHByb3BlcnRpZXM6DQo+ID4gKyAgLSBjb21wYXRpYmxlOiBzaG91bGQgYmU6DQo+ID4gKyAg
ICAtICJyZW5lc2FzLHI5YTA1ZzAzMi1waW5jdHJsIg0KPiA+ICsgIC0gcmVnDQo+ID4gKyAgICBh
ZGRyZXNzIGJhc2UgYW5kIGxlbmd0aCBvZiB0aGUgbWVtb3J5IGFyZWEgd2hlcmUgdGhlIHBpbiBj
b250cm9sbGVyDQo+ID4gKyAgICBoYXJkd2FyZSBpcyBtYXBwZWQgdG8uDQo+ID4gKw0KPiA+ICtF
eGFtcGxlOg0KPiA+ICtwaW5jdHJsOiBwaW5jdHJsQDQwMDY3MDAwIHsNCj4gPiArY29tcGF0aWJs
ZSA9ICJyZW5lc2FzLHI5YTA2ZzAzMi1waW5jdHJsIjsNCj4gPiArcmVnID0gPDB4NDAwNjcwMDAg
MHgxMDAwPiwgPDB4NTEwMDAwMDAgMHg4MDA+Ow0KPiA+ICtjbG9ja3MgPSA8JnN5c2N0cmwgUjlB
MDZHMDMyX0hDTEtfUElOQ09ORklHPjsNCj4gPiArY2xvY2stbmFtZXMgPSAiYnVzIjsNCj4gPiAr
c3RhdHVzID0gIm9rYXkiOw0KPiA+ICt9Ow0KPiA+ICsNCj4gPiArDQo+ID4gK1N1Yi1ub2Rlcw0K
PiA+ICstLS0tLS0tLS0NCj4gPiArICBUaGUgY2hpbGQgbm9kZXMgb2YgdGhlIHBpbiBjb250cm9s
bGVyIG5vZGUgZGVzY3JpYmUgYSBwaW4NCj4gPiArbXVsdGlwbGV4aW5nDQo+ID4gKyAgZ3JvdXAg
dGhhdCBjYW4gYmUgdXNlZCBieSBkcml2ZXIgbm9kZXMuDQo+ID4gKw0KPiA+ICsgIEEgcGluIG11
bHRpcGxleGluZyBzdWItbm9kZSBkZXNjcmliZXMgaG93IHRvIGNvbmZpZ3VyZSBhIHNldCBvZg0K
PiA+ICsgKG9yIGEgc2luZ2xlKSBwaW4gaW4gc29tZSBkZXNpcmVkIGFsdGVybmF0ZSBmdW5jdGlv
biBtb2RlLg0KPiA+ICsgIEEgc2luZ2xlIHN1Yi1ub2RlIG1heSBkZWZpbmUgc2V2ZXJhbCBwaW4g
Y29uZmlndXJhdGlvbnMuDQo+ID4gKw0KPiA+ICsgIFRoZSBhbGxvd2VkIGdlbmVyaWMgZm9ybWF0
cyBmb3IgYSBwaW4gbXVsdGlwbGV4aW5nIHN1Yi1ub2RlIGFyZSB0aGUNCj4gPiArIGZvbGxvd2lu
ZyBvbmVzOg0KPiA+ICsNCj4gPiArICBDbGllbnQgc3ViLW5vZGVzIHNoYWxsIHJlZmVyIHRvIHBp
biBtdWx0aXBsZXhpbmcgc3ViLW5vZGVzIHVzaW5nDQo+ID4gKyB0aGUgcGhhbmRsZSAgb2YgdGhl
IG1vc3QgZXh0ZXJuYWwgb25lLg0KPiA+ICsNCj4gPiArICBFZy4NCj4gPiArDQo+ID4gKyAgY2xp
ZW50LTEgew0KPiA+ICsgICAgICAuLi4NCj4gPiArICAgICAgcGluY3RybC0wID0gPCZub2RlLTE+
Ow0KPiA+ICsgICAgICAuLi4NCj4gPiArICB9Ow0KPiA+ICsNCj4gPiArICBjbGllbnQtMiB7DQo+
ID4gKyAgICAgIC4uLg0KPiA+ICsgICAgICBwaW5jdHJsLTAgPSA8Jm5vZGUtMj47DQo+ID4gKyAg
ICAgIC4uLg0KPiA+ICsgIH07DQo+ID4gKw0KPiA+ICsgIFJlcXVpcmVkIHByb3BlcnRpZXM6DQo+
ID4gKyAgICAtIHJlbmVzYXMscnpuMS1waW5jdHJsOg0KPiA+ICsgICAgICBBcnJheSBvZiBpbnRl
Z2VycyByZXByZXNlbnRpbmcgZWFjaCAncGluJyBhbmQgaXQncyBjb25maWd1cmF0aW9uLg0KPiA+
ICsNCj4gPiArICAgICAgQSAncGluIG51bWJlcicgZG9lcyBub3QgY29ycmVzcG9uZCAxOjEgdG8g
dGhlIGhhcmR3YXJlIG1hbnVhbCBub3Rpb24NCj4gb2YNCj4gPiArICAgICAgUExfR1BJTyBkaXJl
Y3RseS4gTnVtYmVycyAwLi4uMTY5IGFyZSBQTF9HUElPcywgaG93ZXZlciB0aGVyZSBpcyBhbHNv
DQo+IHR3bw0KPiA+ICsgICAgICBleHRyYSAxNzAgYW5kIDE3MSB0aGF0IGNvcnJlc3BvbmRzIHRv
IHRoZSBNRElPMCBhbmQgTURJTzEgYnVzDQo+IGNvbmZpZy4NCj4gPiArDQo+ID4gKyAgICAgIEEg
J2Z1bmN0aW9uJyBhbHNvIGRvZXMgbm90IGNvcnJlc3BvbmQgMToxIHRvIHRoZSBoYXJkd2FyZSBt
YW51YWwuDQo+IFRoZXJlDQo+ID4gKyAgICAgIGFyZSAyIGxldmVscyBvZiBwaW4gbXV4aW5nLCBM
ZXZlbCAxLCBsZXZlbCAyIC0tIHRvIHRoaXMgYXJlIGFkZGVkIHRoZQ0KPiA+ICsgICAgICBNRElP
IGNvbmZpZ3VyYXRpb25zLg0KPiA+ICsNCj4gPiArICAgICAgSGVscGVyIG1hY3JvcyB0byBlYXNl
IGFzc2VtYmxpbmcgdGhlIHBpbiBpbmRleCBhbmQgZnVuY3Rpb24gaWRlbnRpZmllcg0KPiA+ICsg
ICAgICBhcmUgcHJvdmlkZWQgYnkgdGhlIHBpbiBjb250cm9sbGVyIGhlYWRlciBmaWxlIGF0Og0K
PiA+ICsgICAgICA8aW5jbHVkZS9kdC1iaW5kaW5ncy9waW5jdHJsL3I5YTA2ZzAzMi1waW5jdHJs
Lmg+DQo+ID4gKw0KPiA+ICtFeGFtcGxlICMxOg0KPiA+ICsgIEEgc2ltcGxlIGNhc2UgY29uZmln
dXJpbmcgb25seSB0aGUgZnVuY3Rpb24gZm9yIGEgZ2l2ZW4gJ3Bpbicgd29ya3MgYXMNCj4gZm9s
bG93Og0KPiA+ICsjaW5jbHVkZSA8aW5jbHVkZS9kdC1iaW5kaW5ncy9waW5jdHJsL3I5YTA2ZzAz
Mi1waW5jdHJsLmg+DQo+ID4gKyZwaW5jdHJsIHsNCj4gPiArcGluc3VhcnQwOiBwaW5zdWFydDAg
ew0KPiA+ICtyZW5lc2FzLHJ6bjEtcGlubXV4LWlkcyA9IDwNCj4gPiArUlpOMV9NVVgoMTAzLCBV
QVJUMF9JKS8qDQo+IFVBUlQwX1RYRCAqLw0KPiA+ICtSWk4xX01VWCgxMDQsIFVBUlQwX0kpLyoN
Cj4gVUFSVDBfUlhEICovDQo+ID4gKz47DQo+ID4gK307DQo+ID4gK307DQo+ID4gKw0KPiA+ICsm
dWFydDAgew0KPiA+ICtzdGF0dXMgPSAib2theSI7DQo+ID4gK3BpbmN0cmwtbmFtZXMgPSAiZGVm
YXVsdCI7DQo+ID4gK3BpbmN0cmwtMCA9IDwmcGluc3VhcnQwPjsNCj4gPiArfTsNCj4gPiArICBO
b3RlIHRoYXQgaW4gdGhpcyBjYXNlIHRoZSBvdGhlciBmdW5jdGlvbnMgb2YgdGhlIHBpbnMgYXJl
IG5vdCBjaGFuZ2VkLg0KPiA+ICsNCj4gPiArRXhhbXBsZSAjMjoNCj4gPiArICBIZXJlIHdlIGFs
c28gc2V0IHRoZSBwdWxsdXBzIG9uIHRoZSBSWEQgcGluOg0KPiA+ICsmcGluY3RybCB7DQo+ID4g
K3BpbnN1YXJ0MDogcGluc3VhcnQwIHsNCj4gPiArcmVuZXNhcyxyem4xLXBpbm11eC1pZHMgPSA8
DQo+ID4gK1JaTjFfTVVYKDEwMywgVUFSVDBfSSkvKg0KPiBVQVJUMF9UWEQgKi8NCj4gPiArUlpO
MV9NVVhfUFVQKDEwNCwgVUFSVDBfSSkvKg0KPiBVQVJUMF9SWEQgKi8NCj4gPiArPjsNCj4gPiAr
fTsNCj4gPiArfTsNCj4gPiArICBUaGVyZSBhcmUgbWFueSBhbHRlcm5hdGl2ZSBtYWNyb3MgdG8g
c2V0IHRoZSBwdWxsdXAvZG93bi9ub25lIGFuZA0KPiA+ICt0aGUgZHJpdmUNCj4gPiArICBzdHJl
bmdodCBpbiB0aGUgcjlhMDZnMDMyLXBpbmN0cmwuaCBoZWFkZXIgZmlsZS4NCj4gPiArDQo+ID4g
K0V4YW1wbGUgIzM6DQo+ID4gKyAgVGhlIFNvYyBoYXMgdHdvIGNvbmZpZ3VyYWJsZSBNRElPIG11
eGVzLCB0aGVzZSBjYW4gYWxzbyBiZQ0KPiA+ICtjb25maWd1cmVkDQo+ID4gKyAgd2l0aCB0aGlz
IGludGVyZmFjZSB1c2luZyB0aGUgJ3NwZWNpYWwnIE1ESU8gY29uc3RhbnRzOg0KPiA+ICsNCj4g
PiArJnBpbmN0cmwgew0KPiA+ICttZGlvX211eDogbWRpb211eCB7DQo+ID4gK3JlbmVzYXMscnpu
MS1waW5tdXgtaWRzID0gPA0KPiA+ICtSWk4xX01VWChSWk4xX01ESU9fQlVTMCwNCj4gUlpOMV9G
VU5DX01ESU9fTVVYX01BQzApDQo+ID4gK1JaTjFfTVVYKFJaTjFfTURJT19CVVMxLA0KPiBSWk4x
X0ZVTkNfTURJT19NVVhfU1dJVENIKQ0KPiA+ICs+Ow0KPiA+ICt9Ow0KPiA+ICt9Ow0KPiA+ICsg
IENsZWFybHkgdGhlIHB1bGwvdXAvbm9uZSBhbmQgZHJpdmUgY29uc3RhbnRzIHdpbGwgYmUgaWdu
b3JlZCwgZXZlbg0KPiA+ICtpZg0KPiA+ICsgIHNwZWNpZmllZC4NCj4gPiArDQo+ID4gK05vdGUg
dGhhdCBSZW5lc2FzIHByb3ZpZGVzIGFuIGV4dGVuc2l2ZSB3ZWJhcHAgdGhhdCBjYW4gZ2VuZXJh
dGVzIGENCj4gPiArZGV2aWNlIHRyZWUgZmlsZSBmb3IgeW91ciBib2FyZC4gU2VlIHRoZWlyIHdl
YnNpdGUgZm9yIHRoaXMgcGFydCBudW1iZXIgZm9yDQo+IGRldGFpbHMuDQo+ID4gLS0NCj4gPiAy
LjcuNA0KPiA+DQoNCg0KDQpSZW5lc2FzIEVsZWN0cm9uaWNzIEV1cm9wZSBMdGQsIER1a2VzIE1l
YWRvdywgTWlsbGJvYXJkIFJvYWQsIEJvdXJuZSBFbmQsIEJ1Y2tpbmdoYW1zaGlyZSwgU0w4IDVG
SCwgVUsuIFJlZ2lzdGVyZWQgaW4gRW5nbGFuZCAmIFdhbGVzIHVuZGVyIFJlZ2lzdGVyZWQgTm8u
IDA0NTg2NzA5Lg0K
