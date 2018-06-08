Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id MDdEDRwnGluLCwAAmS7hNA
	; Fri, 08 Jun 2018 06:50:35 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id E6C2E607DC; Fri,  8 Jun 2018 06:50:34 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=renesasgroup.onmicrosoft.com header.i=@renesasgroup.onmicrosoft.com header.b="RzLxb713"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,T_DKIMWL_WL_MED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 3025C602FC;
	Fri,  8 Jun 2018 06:50:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3025C602FC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752676AbeFHGuc (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 02:50:32 -0400
Received: from relmlor3.renesas.com ([210.160.252.173]:45751 "EHLO
        relmlie2.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751079AbeFHGu3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 02:50:29 -0400
Received: from unknown (HELO relmlir4.idc.renesas.com) ([10.200.68.154])
  by relmlie2.idc.renesas.com with ESMTP; 08 Jun 2018 15:50:27 +0900
Received: from relmlii1.idc.renesas.com (relmlii1.idc.renesas.com [10.200.68.65])
        by relmlir4.idc.renesas.com (Postfix) with ESMTP id 08EBB5D4F5;
        Fri,  8 Jun 2018 15:50:27 +0900 (JST)
X-IronPort-AV: E=Sophos;i="5.49,489,1520866800";
   d="scan'208";a="281936271"
Received: from mail-os2jpn01lp0151.outbound.protection.outlook.com (HELO JPN01-OS2-obe.outbound.protection.outlook.com) ([23.103.139.151])
  by relmlii1.idc.renesas.com with ESMTP/TLS/AES256-SHA256; 08 Jun 2018 15:50:26 +0900
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector1-bp-renesas-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rGPVhsDQKjxM8zGSTitjVgXcP10yBIvuZtCvTKl9Pf0=;
 b=RzLxb713hHjuvN9vEVGifCfiIUXmDjkY5i2k/rDbDAi+9sLD4GlwJKfql40gIbkMOh/S+uX4KQtaybPfw1NrScJacxDlz+HBnA8wT7bmLMlu0iQIOybpGXim3ss8ZWiYJ8gpyVeSL3OqKTqVP7CSqEKHz21torDKCRa3VKm3wUg=
Received: from OSBPR01MB2054.jpnprd01.prod.outlook.com (52.134.240.151) by
 OSBPR01MB2213.jpnprd01.prod.outlook.com (52.134.242.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.841.17; Fri, 8 Jun 2018 06:50:23 +0000
Received: from OSBPR01MB2054.jpnprd01.prod.outlook.com
 ([fe80::dc58:aaf0:db8b:a5f9]) by OSBPR01MB2054.jpnprd01.prod.outlook.com
 ([fe80::dc58:aaf0:db8b:a5f9%2]) with mapi id 15.20.0820.015; Fri, 8 Jun 2018
 06:50:23 +0000
From: Michel Pollet <michel.pollet@bp.renesas.com>
To: Rob Herring <robh+dt@kernel.org>
CC: Frank Rowand <frowand.list@gmail.com>,
        "linux-renesas-soc@vger.kernel.org"
        <linux-renesas-soc@vger.kernel.org>,
        Simon Horman <horms@verge.net.au>,
        Michel Pollet <buserror+upstream@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        "Florian Fainelli" <f.fainelli@gmail.com>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Douglas Anderson <dianders@chromium.org>,
        "Chen-Yu Tsai" <wens@csie.org>, Carlo Caione <carlo@endlessm.com>,
        =?utf-8?B?QW5kcmVhcyBGw6RyYmVy?= <afaerber@suse.de>,
        Frank Rowand <frank.rowand@sony.com>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH v4 2/3] arm: shmobile: Add the R9A06G032 SMP enabler
 driver
Thread-Topic: [PATCH v4 2/3] arm: shmobile: Add the R9A06G032 SMP enabler
 driver
Thread-Index: AQHT/MEwPjoauwcadUW/vfsUGOHwuqRR7WMAgADZHRCAAQAaAIAAAUkAgACXoCCAAJa4AIAA+Cqg
Date: Fri, 8 Jun 2018 06:50:22 +0000
Message-ID: <OSBPR01MB2054A701CF65784FAB947692D27B0@OSBPR01MB2054.jpnprd01.prod.outlook.com>
References: <1528198148-23308-1-git-send-email-michel.pollet@bp.renesas.com>
 <1528198148-23308-3-git-send-email-michel.pollet@bp.renesas.com>
 <0481173f-6384-98d6-707c-89dc5ef103f0@gmail.com>
 <OSBPR01MB2054E3A1E383495F3534B551D2650@OSBPR01MB2054.jpnprd01.prod.outlook.com>
 <9cef7124-3020-5741-f3a2-6925a6c8f0f3@gmail.com>
 <79c0899e-7df1-1fe7-9681-ad3bd51feda7@gmail.com>
 <OSBPR01MB205442B483C792125E6A6AF7D2640@OSBPR01MB2054.jpnprd01.prod.outlook.com>
 <CAL_JsqLn+x0JCkjwABU7XkPsgvyVdiCRq=gZTfUBbbR4-c+1bQ@mail.gmail.com>
In-Reply-To: <CAL_JsqLn+x0JCkjwABU7XkPsgvyVdiCRq=gZTfUBbbR4-c+1bQ@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [193.141.220.21]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;OSBPR01MB2213;7:H/mqPVLujfPGx+t1Oy1JTYWmAZ8bbQyssMd1FM8H1r5UhfblRJ8bEETGIN4VGAs0bA0ydO68JkEUB7hzIm43sxl5UWjss419tnlfdVKHM9+gS55lCIz/hXKFL26DN59/cHaHRhvmuYYPoNqsBNF1+1V6gUH8tg6VCmsOhf+3Csg12+4bJoskBgdRo6iHTFFohGwOQhk4J0PqxatHmUrsA7IeagmN2cib+dN1zKm8FJbD6p7sPCkqrlDNj4MVlQFL;20:x+CqyNJB8MfhROm6NiGEbTeUnDKi5fDm8hS0U5uEgUzXxeBpk8Mi68HbgbloQsRzom94d+IF8bPCI9Hr+bWGAgTKIGzjEryIunf/wIJnGHv2Fdv25FQvep3wWnY9/croK/pufxPWo+DOMduyzF4WQjYeo/+1BrR8li3KvGLe6s4=
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(48565401081)(2017052603328)(7153060)(7193020);SRVR:OSBPR01MB2213;
x-ms-traffictypediagnostic: OSBPR01MB2213:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=michel.pollet@bp.renesas.com;
x-microsoft-antispam-prvs: <OSBPR01MB221377E59CBE370D92C082B4D27B0@OSBPR01MB2213.jpnprd01.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123562045)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:OSBPR01MB2213;BCL:0;PCL:0;RULEID:;SRVR:OSBPR01MB2213;
x-forefront-prvs: 06973FFAD3
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(396003)(39380400002)(39860400002)(366004)(199004)(189003)(53546011)(6506007)(26005)(97736004)(102836004)(74316002)(305945005)(7736002)(5660300001)(3846002)(6116002)(68736007)(54906003)(86362001)(186003)(93886005)(4326008)(6246003)(316002)(59450400001)(99286004)(2900100001)(39060400002)(8656006)(53936002)(14454004)(33656002)(476003)(486006)(446003)(2906002)(25786009)(11346002)(81166006)(76176011)(81156014)(478600001)(44832011)(9686003)(8936002)(7416002)(3280700002)(3660700001)(8676002)(7696005)(229853002)(55016002)(105586002)(106356001)(66066001)(6436002)(5250100002);DIR:OUT;SFP:1102;SCL:1;SRVR:OSBPR01MB2213;H:OSBPR01MB2054.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:0;MX:1;
received-spf: None (protection.outlook.com: bp.renesas.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: soG+2ANj/TUXb1urrFxe1BO2skx6ZX36phqZj4LVYj7sVYBJFP3vKrjAJiEsOShD4KkO5g34oVDWjv86x3uOKN0putOv4P91A7fMoWDj9IKkRRbL5zEqLLE7ZtXvejo5TVUD69m6u6QQ05H7VrT3FpV8AfUYJbNkcBLcB8YcxQUD5rOyz6z4LQIhS3l74oDp
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: eb9fa38a-27d0-45cc-281f-08d5cd0c1bb1
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb9fa38a-27d0-45cc-281f-08d5cd0c1bb1
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2018 06:50:22.8502
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB2213
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpPbiAwNyBKdW5lIDIwMTggMTY6NTUsIFJvYiB3cm90ZToNCj4NCj4gT24gVGh1LCBKdW4gNywg
MjAxOCBhdCAxOjU5IEFNLCBNaWNoZWwgUG9sbGV0DQo+IDxtaWNoZWwucG9sbGV0QGJwLnJlbmVz
YXMuY29tPiB3cm90ZToNCj4gPiBPbiAwNiBKdW5lIDIwMTggMjI6NTMsIEZyYW5rIHdyb3RlOg0K
PiA+PiBPbiAwNi8wNi8xOCAxNDo0OCwgRnJhbmsgUm93YW5kIHdyb3RlOg0KPiA+PiA+IE9uIDA2
LzA1LzE4IDIzOjM2LCBNaWNoZWwgUG9sbGV0IHdyb3RlOg0KPiA+PiA+PiBIaSBGcmFuaywNCj4g
Pj4gPj4NCj4gPj4gPj4gT24gMDUgSnVuZSAyMDE4IDE4OjM0LCBGcmFuayB3cm90ZToNCj4gPj4g
Pj4+IE9uIDA2LzA1LzE4IDA0OjI4LCBNaWNoZWwgUG9sbGV0IHdyb3RlOg0KPiA+PiA+Pj4+IFRo
ZSBSZW5lc2FzIFI5QTA2RzAzMiBzZWNvbmQgQ0E3IGlzIHBhcmtlZCBpbiBhIFJPTSBwZW4gYXQg
Ym9vdA0KPiA+PiA+Pj4+IHRpbWUsIGl0IHJlcXVpcmVzIGEgc3BlY2lhbCBlbmFibGUgbWV0aG9k
IHRvIGdldCBpdCBzdGFydGVkLg0KPg0KPiBbLi4uXQ0KPg0KPiA+PiA+Pj4+ICsgKiBUaGUgc2Vj
b25kIENQVSBpcyBwYXJrZWQgaW4gUk9NIGF0IGJvb3QgdGltZS4gSXQgcmVxdWlyZXMNCj4gPj4g
Pj4+PiArd2FraW5nIGl0IGFmdGVyDQo+ID4+ID4+Pj4gKyAqIHdyaXRpbmcgYW4gYWRkcmVzcyBp
bnRvIHRoZSBCT09UQUREUiByZWdpc3RlciBvZiBzeXNjdHJsLg0KPiA+PiA+Pj4+ICsgKg0KPiA+
PiA+Pj4+ICsgKiBTbyB0aGUgZGVmYXVsdCB2YWx1ZSBvZiB0aGUgImNwdS1yZWxlYXNlLWFkZHIi
IGNvcnJlc3BvbmRzDQo+ID4+ID4+Pj4gK3RvDQo+ID4+ID4+PiBCT09UQUREUi4uLg0KPiA+PiA+
Pj4+ICsgKg0KPiA+PiA+Pj4+ICsgKiAqSG93ZXZlciogdGhlIEJPT1RBRERSIHJlZ2lzdGVyIGlz
IG5vdCBhdmFpbGFibGUgd2hlbiB0aGUNCj4gPj4gPj4+PiAra2VybmVsDQo+ID4+ID4+Pj4gKyAq
IHN0YXJ0cyBpbiBOT05TRUMgbW9kZS4NCj4gPj4gPj4+PiArICoNCj4gPj4gPj4+PiArICogU28g
Zm9yIE5PTlNFQyBtb2RlLCB0aGUgYm9vdGxvYWRlciByZS1wYXJrcyB0aGUgc2Vjb25kIENQVQ0K
PiA+PiA+Pj4+ICtpbnRvIGEgcGVuDQo+ID4+ID4+Pj4gKyAqIGluIFNSQU0sIGFuZCBjaGFuZ2Vz
IHRoZSAiY3B1LXJlbGVhc2UtYWRkciIgb2YgbGludXgncyBEVCB0bw0KPiA+PiA+Pj4+ICthIFNS
QU0gYWRkcmVzcywNCj4gPj4gPj4+PiArICogd2hpY2ggaXMgbm90IHJlc3RyaWN0ZWQuDQo+ID4+
ID4+Pg0KPiA+PiA+Pj4gVGhlIGJpbmRpbmcgZG9jdW1lbnQgZm9yIGNwdS1yZWxlYXNlLWFkZHIg
ZG9lcyBub3QgaGF2ZSBhDQo+ID4+ID4+PiBkZWZpbml0aW9uIGZvciAzMiBiaXQgYXJtLiAgVGhl
IGV4aXN0aW5nIGRlZmluaXRpb24gaXMgb25seSA2NA0KPiA+PiA+Pj4gYml0IGFybS4gIFBsZWFz
ZSBhZGQgdGhlIGRlZmluaXRpb24gZm9yIDMyIGJpdCBhcm0gdG8gcGF0Y2ggMS4NCj4gPj4gPj4N
Cj4gPj4gPj4gSG1tbSBJIGRvIGZpbmQgYSBkZWZpbml0aW9uIGluDQo+ID4+ID4+IERvY3VtZW50
YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9hcm0vY3B1cy50eHQgLS0ganVzdCB1bmRlciB3aGVy
ZQ0KPiA+PiA+PiBJIGFkZGVkIG15ICdlbmFibGUtbWV0aG9kJyAtLSBBbmQgaXQgaXMgYWxyZWFk
eSB1c2VkIGFzIDMyIGJpdHMgaW4NCj4gPj4gPj4gYXQgbGVhc3QgYXJjaC9hcm0vYm9vdC9kdHMv
c3RpaDQwNy1mYW1pbHkuZHRzaS4NCj4gPj4gPg0KPiA+PiA+IElmIHRoZSBjb3JyZWN0IGFuc3dl
ciBpcyBmb3IgY3B1LXJlbGVhc2UtYWRkciB0byBiZSA2NCBiaXRzIGluDQo+ID4+ID4gY2VydGFp
biBjYXNlcyAodGhhdCBkaXNjdXNzaW9uIGlzIG9uZ29pbmcgZnVydGhlciBkb3dudGhyZWFkKSB0
aGVuDQo+ID4+ID4gb25lIGFwcHJvYWNoIHRvIG1haW50YWluIGNvbXBhdGliaWxpdHkgX2FuZF8g
dG8gZml4IHRoZSBkZXZpY2V0cmVlDQo+ID4+ID4gc291cmNlIGZpbGVzIGlzIHRvIGNoYW5nZSB0
aGUgc291cmNlIGNvZGUgdGhhdCBjdXJyZW50bHkgZ2V0cw0KPiA+PiA+IGNwdS1yZWxlYXNlLWFk
ZHIgYXMgYQ0KPiA+PiA+IDMyIGJpdCBvYmplY3QgdG8gY2hlY2sgdGhlIHNpemUgb2YgdGhlIHBy
b3BlcnR5IGFuZCBnZXQgaXQgYXMNCj4gPj4gPiBlaXRoZXIgYQ0KPiA+PiA+IDMyIGJpdCBvciA2
NCBiaXQgb2JqZWN0LCBiYXNlZCBvbiB0aGUgYWN0dWFsIHNpemUgb2YgdGhlIHByb3BlcnR5DQo+
ID4+ID4gaW4gdGhlIGRldmljZSB0cmVlIGFuZCB0aGVuIGNoYW5nZSB0aGUgdmFsdWUgaW4gdGhl
IGRldmljZXRyZWUNCj4gPj4gPiBzb3VyY2UgZmlsZXMgdG8gYmUgdHdvIGNlbGxzLiAgQlVUIHRo
aXMgZG9lcyBub3QgY29uc2lkZXIgdGhlDQo+ID4+ID4gYm9vdGxvYWRlciBjb21wbGljYXRpb24u
ICBhcmNoL2FybS9ib290L2R0cy9heG01NTE2LWNwdXMuZHRzaSBoYXMgYQ0KPiA+PiA+IG5vdGUg
Ii8vIEZpeGVkIGJ5IHRoZSBib290IGxvYWRlciIsIHNvIHRoZSBib290IGxvYWRlciBhbHNvIGhh
cyB0bw0KPiA+PiA+IGJlIG1vZGlmaWVkIHRvIGJlIGFibGUgdG8gaGFuZGxlIHRoZSBwb3NzaWJp
bGl0eSB0aGF0IHRoZSBwcm9wZXJ0eQ0KPiA+PiA+IGNvdWxkIGJlIGVpdGhlcg0KPiA+PiA+IDMy
IGJpdHMgb3IgNjQgYml0cy4gIEkgZG9uJ3Qga25vdyBob3cgdG8gbWFpbnRhaW4gY29tcGF0aWJp
bGl0eQ0KPiA+PiA+IHdpdGggdGhlIGJvb3QgbG9hZGVyIHNpbmNlIHdlIGNhbid0IGZvcmNlIGl0
IHRvIGNoYW5nZQ0KPiA+PiA+IHN5bmNocm9ub3VzbHkgd2l0aCBjaGFuZ2VzIGluIHRoZSBrZXJu
ZWwuDQo+ID4+ID4NCj4gPj4gPiBZb3UgY2FuIGNvbnNpZGVyIHRoaXMgY29tbWVudCB0byBiZSBh
IGRyaXZlLWJ5IG9ic2VydmF0aW9uLiAgSQ0KPiA+PiA+IHRoaW5rIFJvYiBhbmQgR2VlcnQgYW5k
IHBlb3BsZSBsaWtlIHRoYXQgYXJlIGxpa2VseSB0byBiZSBtb3JlDQo+ID4+ID4gaGVscGZ1bCB3
aXRoIHdoYXQgdG8gYWN0dWFsbHkgZG8sIGFuZCB5b3UgY2FuIHRyZWF0IG15IGNvbW1lbnQgbW9y
ZQ0KPiA+PiA+IGFzIHBvaW50aW5nIG91dCB0aGUgaXNzdWUgdGhhbiBhcyBwcm92aWRpbmcgdGhl
IHBlcmZlY3Qgc29sdXRpb24uDQo+ID4+DQo+ID4+IERhcm4gaXQsIGhpdCA8c2VuZD4gdG9vIHF1
aWNrbHkuDQo+ID4+DQo+ID4+IEkgbWVhbnQgdG8gbWVudGlvbiB0aGF0IHRoZXJlIGFyZSBzZXZl
cmFsIGRldmljZXRyZWUgc291cmNlIGZpbGVzDQo+ID4+IHRoYXQgaGF2ZSBhIHNpbmdsZSBjZWxs
IHZhbHVlIGZvciBjcHUtcmVsZWFzZS1hZGRyLCBhbmQgdGh1cw0KPiA+PiBwb3RlbnRpYWxseSBm
YWNlIHRoZSBzYW1lIHNpdHVhdGlvbiwgZGVwZW5kaW5nIG9uIHdoYXQgdGhlIGZpbmFsDQo+ID4+
IGRlY2lzaW9uIGlzIG9uIHRoZSBwcm9wZXIgc2l6ZSBmb3IgY3B1LSByZWxlYXNlLWFkZHIuIEFz
IG9mIHY0LjE3LCBhIGdpdCBncmVwDQo+IHNob3dzIG9uZSBjZWxsIHZhbHVlcyBpbjoNCj4gPj4N
Cj4gPj4gICBhcmNoL2FybS9ib290L2R0cy9heG01NTE2LWNwdXMuZHRzaQ0KPiA+PiAgIGFyY2gv
YXJtL2Jvb3QvZHRzL3N0aWg0MDctZmFtaWx5LmR0c2kNCj4gPj4gICBhcmNoL2FybS9ib290L2R0
cy9zdGloNDE4LmR0c2kNCj4gPg0KPiA+IFllcywgSSBoYWQgZ3JlcHBlZCBiZWZvcmUgSSB1c2Vk
IDMyIGJpdHMgb24gbWluZS4uLg0KPiA+DQo+ID4gTm93LCB3aGF0IGlzIHRoZSBkZWNpc2lvbiBo
ZXJlPyBPdXIgYm9vdGxvYWRlciBpcyBhbHJlYWR5IG1vZGlmaWVkIHRvDQo+ID4gc2V0IGl0IHRv
IDMyIGJpdHMsIHNvIEkgcHJvcG9zZSB0aGF0DQo+DQo+IEFuZCB0b28gbGF0ZSB0byBmaXggdGhl
IGJvb3Rsb2FkZXI/DQoNCg0KV2VsbCBub3QgdG9vIGxhdGUsIGJ1dCByZWFkIGZ1cnRoZXIgb24u
Li4NCg0KPg0KPiA+DQo+ID4gKyBJIGNoYW5nZSB0aGUgZHJpdmVyIHRvIGhhbmRsZSAzMiBhbmQg
NjQgYml0cyBwcm9wZXJ0aWVzDQo+DQo+IFRoYXQncyBmaW5lIGlmIHlvdSBjYW4ndCBmaXggdGhl
IGJvb3Rsb2FkZXIuDQo+DQo+ID4gKyBJIGFkZCB0aGlzIHRvIHRoZSBjcHUudHh0LCBhcyBhIHNl
cGFyYXRlIHBhdGNoOg0KPiA+ICMgT24gb3RoZXIgc3lzdGVtcywgdGhlIHByb3BlcnR5IGNhbiBi
ZSBlaXRoZXINCj4gPiAgIDMyIGJpdHMgb3IgNjQgYml0cywgaXQgaXMgdGhlIGRyaXZlcidzIHJl
c3BvbnNpYmlsaXR5DQo+ID4gICB0byBkZWFsIHdpdGggZWl0aGVyIHNpemVzLg0KPg0KPiBUaGF0
IGlzIGRlZmluaXRlbHkgbm90IHdoYXQgd2Ugd2FudCB0byBzYXkuIFVzZSBvZiAzMi1iaXQgc2hv
dWxkIGJlDQo+IGNvbnNpZGVyZWQgb3V0IG9mIHNwZWMuIFllcywgd2UgaGF2ZSBhIGZldyBwbGF0
Zm9ybXMgaW4gdGhhdCBjYXRlZ29yeSwgYnV0DQo+IHRoZXkgYWxyZWFkeSBoYW5kbGUgdGhhdCB0
aGVtc2VsdmVzLiBXb3VsZCBiZSBuaWNlIHRvIGZpeCB0aGVtLCBidXQgYXQgbGVhc3QNCj4gdGhl
IFNUaSBwbGF0Zm9ybXMgZG9uJ3Qgc2VlbSB0b28gYWN0aXZlLg0KPg0KPiBJTU8sIHdlIHNob3Vs
ZCBkZWxldGUgd2hhdGV2ZXIgdGV4dCB3ZSBjYW4gaGVyZSBhbmQgYXQgbW9zdCBqdXN0IHJlZmVy
IHRvDQo+IHRoZSBzcGVjLg0KDQpTbyBhY3R1YWxseSBJIGRpZG4ndCB1c2UgMzIgYml0cyBieSBw
bGFpbiBjaGFuY2UsIEkgcmVhZCB0aGUgY3B1LnR4dCBmaWxlIHdoaWNoIHNheXMNCnRoYXQgNjQg
Yml0cyBzeXN0ZW1zIHVzZSA2NCBiaXRzIHByb3BlcnR5LCBjb25jbHVkZWQgdGhhdCBpbiBteSBj
YXNlIEkgb3VnaHQgdG8NCnVzZSAzMiBiaXRzLCB0aGVuIGdyZXBwZWQgYXJvdW5kIGFuZCBmb3Vu
ZCBvdGhlciBzeXN0ZW1zIHVzaW5nIDMyIGJpdHMsIHRoZXJlZm9yZQ0KSSB3ZW50IGZvcndhcmQg
YW5kIHVzZWQgaXQuLg0KDQpOb3RoaW5nIHNhaWQgaGVyZSB0aGF0IGl0IHNob3VsZCBiZSA2NCBi
aXRzIGV2ZXJ5d2hlcmUgLS0gU28gdGhlIGRvY3VtZW50YXRpb24NCm5lZWRzIGZpeGluZyBzb21l
aG93LiBSaWdodCBub3cgaXQgY2VydGFpbmx5IGxlZCBtZSB3cm9uZy4NCg0KPg0KPiBSb2INCg0K
TWljaGVsDQoNCg0KDQoNClJlbmVzYXMgRWxlY3Ryb25pY3MgRXVyb3BlIEx0ZCwgRHVrZXMgTWVh
ZG93LCBNaWxsYm9hcmQgUm9hZCwgQm91cm5lIEVuZCwgQnVja2luZ2hhbXNoaXJlLCBTTDggNUZI
LCBVSy4gUmVnaXN0ZXJlZCBpbiBFbmdsYW5kICYgV2FsZXMgdW5kZXIgUmVnaXN0ZXJlZCBOby4g
MDQ1ODY3MDkuDQo=
