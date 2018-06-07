Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id xPLbAJ7XGFupSwAAmS7hNA
	; Thu, 07 Jun 2018 06:59:30 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id DD45F608B8; Thu,  7 Jun 2018 06:59:29 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=renesasgroup.onmicrosoft.com header.i=@renesasgroup.onmicrosoft.com header.b="R7xi+QuT"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,T_DKIMWL_WL_MED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 175FF607E7;
	Thu,  7 Jun 2018 06:59:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 175FF607E7
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753019AbeFGG71 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 02:59:27 -0400
Received: from relmlor4.renesas.com ([210.160.252.174]:17940 "EHLO
        relmlie3.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751974AbeFGG7Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 02:59:24 -0400
Received: from unknown (HELO relmlir1.idc.renesas.com) ([10.200.68.151])
  by relmlie3.idc.renesas.com with ESMTP; 07 Jun 2018 15:59:21 +0900
Received: from relmlii2.idc.renesas.com (relmlii2.idc.renesas.com [10.200.68.66])
        by relmlir1.idc.renesas.com (Postfix) with ESMTP id BC8D273E4A;
        Thu,  7 Jun 2018 15:59:21 +0900 (JST)
X-IronPort-AV: E=Sophos;i="5.49,486,1520866800";
   d="scan'208";a="283288082"
Received: from mail-ty1jpn01lp0178.outbound.protection.outlook.com (HELO JPN01-TY1-obe.outbound.protection.outlook.com) ([23.103.139.178])
  by relmlii2.idc.renesas.com with ESMTP/TLS/AES256-SHA256; 07 Jun 2018 15:59:14 +0900
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector1-bp-renesas-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uGYVgjvXmnC0TRCsoreTqAzS54F6IC5Oz3hgrSuqQVA=;
 b=R7xi+QuT0PfEzb6L3HrexVqpPC61hQOKNFQa7lLzgXcoZecpyvMP24vzRw2AW5bnarayaItSNP1TE8byCrgr41UR6/VXIU8yM4KNytgaGuwFmwPBF89fFM3ky9RCst7vFi0ie7NfDWvUDpK0+5s7l1Ept5hKeaUVo1M/C6ksUGM=
Received: from OSBPR01MB2054.jpnprd01.prod.outlook.com (52.134.240.151) by
 OSBPR01MB1557.jpnprd01.prod.outlook.com (52.134.225.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.841.14; Thu, 7 Jun 2018 06:59:10 +0000
Received: from OSBPR01MB2054.jpnprd01.prod.outlook.com
 ([fe80::dc58:aaf0:db8b:a5f9]) by OSBPR01MB2054.jpnprd01.prod.outlook.com
 ([fe80::dc58:aaf0:db8b:a5f9%2]) with mapi id 15.20.0820.015; Thu, 7 Jun 2018
 06:59:10 +0000
From: Michel Pollet <michel.pollet@bp.renesas.com>
To: Frank Rowand <frowand.list@gmail.com>,
        "linux-renesas-soc@vger.kernel.org"
        <linux-renesas-soc@vger.kernel.org>,
        Simon Horman <horms@verge.net.au>
CC: Michel Pollet <buserror+upstream@gmail.com>,
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
        "Chen-Yu Tsai" <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Carlo Caione <carlo@endlessm.com>,
        =?utf-8?B?QW5kcmVhcyBGw6RyYmVy?= <afaerber@suse.de>,
        Frank Rowand <frank.rowand@sony.com>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH v4 2/3] arm: shmobile: Add the R9A06G032 SMP enabler
 driver
Thread-Topic: [PATCH v4 2/3] arm: shmobile: Add the R9A06G032 SMP enabler
 driver
Thread-Index: AQHT/MEwPjoauwcadUW/vfsUGOHwuqRR7WMAgADZHRCAAQAaAIAAAUkAgACXoCA=
Date: Thu, 7 Jun 2018 06:59:10 +0000
Message-ID: <OSBPR01MB205442B483C792125E6A6AF7D2640@OSBPR01MB2054.jpnprd01.prod.outlook.com>
References: <1528198148-23308-1-git-send-email-michel.pollet@bp.renesas.com>
 <1528198148-23308-3-git-send-email-michel.pollet@bp.renesas.com>
 <0481173f-6384-98d6-707c-89dc5ef103f0@gmail.com>
 <OSBPR01MB2054E3A1E383495F3534B551D2650@OSBPR01MB2054.jpnprd01.prod.outlook.com>
 <9cef7124-3020-5741-f3a2-6925a6c8f0f3@gmail.com>
 <79c0899e-7df1-1fe7-9681-ad3bd51feda7@gmail.com>
In-Reply-To: <79c0899e-7df1-1fe7-9681-ad3bd51feda7@gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=michel.pollet@bp.renesas.com;
x-originating-ip: [193.141.220.21]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;OSBPR01MB1557;7:KByGYX3P/VVciXGsJS3MvfWgo/bEqypG6Gx5DAjHf/ByoqTVGmnQ47wR05lFVa5WuCS8iUtrhxkpJNL1rH7KKA3YgPyli0n3a4sTBQ7jxG9dvWwJr7fRx88ZXxoiQDmoXAUzhVL2qn5mIp2PJrbgNl3VmQMXV6TT53tPiyfVxDsC5P9O4XgkLkzxvia46L/m5sevOh/N0RMHXNH7vwUckDOjc1ICr2sfAWesp/k0wjBnhTAkpKkfKBvrnY1YBUTV;20:2n2LD4+O+xsMzD0pNEA6OEp0nJ1umWuud21ULVeA6IPbDKUtrMUIHxs5GP1g6fA35Q2DwXBLJifEa64DG/vjxFVIxBHnkAYKelY1Ldy5W6WgeJ24DN2H3Z3OdfGELlqzGJFWV3ppshNagOzM4R1iHC3CGVxUa1k8kHObNwTJJTg=
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(48565401081)(2017052603328)(7153060)(7193020);SRVR:OSBPR01MB1557;
x-ms-traffictypediagnostic: OSBPR01MB1557:
x-microsoft-antispam-prvs: <OSBPR01MB1557A3314BA4A0E2B711DF18D2640@OSBPR01MB1557.jpnprd01.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(85827821059158);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231254)(944501410)(52105095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:OSBPR01MB1557;BCL:0;PCL:0;RULEID:;SRVR:OSBPR01MB1557;
x-forefront-prvs: 06968FD8C4
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(366004)(39860400002)(39380400002)(346002)(199004)(189003)(25786009)(476003)(14454004)(66066001)(478600001)(9686003)(44832011)(2900100001)(5250100002)(97736004)(7416002)(8936002)(486006)(8656006)(81166006)(5660300001)(68736007)(81156014)(8676002)(316002)(54906003)(446003)(4326008)(3846002)(39060400002)(6116002)(33656002)(110136005)(11346002)(53936002)(74316002)(6506007)(186003)(53546011)(59450400001)(26005)(7736002)(305945005)(99286004)(76176011)(55016002)(3660700001)(86362001)(6246003)(6436002)(7696005)(102836004)(3280700002)(93886005)(229853002)(2501003)(105586002)(106356001)(2906002);DIR:OUT;SFP:1102;SCL:1;SRVR:OSBPR01MB1557;H:OSBPR01MB2054.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:0;MX:1;
received-spf: None (protection.outlook.com: bp.renesas.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: JKH5JLAiUSBj/WNgc12CI7irXTvV6oI4cezPlAa1t7xn78HGDfehGOPbTj6YsA922Tk5Q8+bWxGheLTjS96LlGyECIwurwdTHJhxjrXJmSvkPEUzWNdYKXVFeEzDop490fWVSEK2OY3aULZgvw+Lgs7qjIuzn+auOPHy5ykT81hCqozY1eT8C6F3GDsE6t5o
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 485c0d3f-21e0-4c32-513d-08d5cc442bb4
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 485c0d3f-21e0-4c32-513d-08d5cc442bb4
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2018 06:59:10.3216
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB1557
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDYgSnVuZSAyMDE4IDIyOjUzLCBGcmFuayB3cm90ZToNCj4gT24gMDYvMDYvMTggMTQ6NDgs
IEZyYW5rIFJvd2FuZCB3cm90ZToNCj4gPiBPbiAwNi8wNS8xOCAyMzozNiwgTWljaGVsIFBvbGxl
dCB3cm90ZToNCj4gPj4gSGkgRnJhbmssDQo+ID4+DQo+ID4+IE9uIDA1IEp1bmUgMjAxOCAxODoz
NCwgRnJhbmsgd3JvdGU6DQo+ID4+PiBPbiAwNi8wNS8xOCAwNDoyOCwgTWljaGVsIFBvbGxldCB3
cm90ZToNCj4gPj4+PiBUaGUgUmVuZXNhcyBSOUEwNkcwMzIgc2Vjb25kIENBNyBpcyBwYXJrZWQg
aW4gYSBST00gcGVuIGF0IGJvb3QNCj4gPj4+PiB0aW1lLCBpdCByZXF1aXJlcyBhIHNwZWNpYWwg
ZW5hYmxlIG1ldGhvZCB0byBnZXQgaXQgc3RhcnRlZC4NCj4gPj4+Pg0KPiA+Pj4+IFNpZ25lZC1v
ZmYtYnk6IE1pY2hlbCBQb2xsZXQgPG1pY2hlbC5wb2xsZXRAYnAucmVuZXNhcy5jb20+DQo+ID4+
Pj4gLS0tDQo+ID4+Pj4gIGFyY2gvYXJtL21hY2gtc2htb2JpbGUvTWFrZWZpbGUgICAgICAgIHwg
IDEgKw0KPiA+Pj4+ICBhcmNoL2FybS9tYWNoLXNobW9iaWxlL3NtcC1yOWEwNmcwMzIuYyB8IDc5
DQo+ID4+Pj4gKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPiA+Pj4+ICAyIGZp
bGVzIGNoYW5nZWQsIDgwIGluc2VydGlvbnMoKykNCj4gPj4+PiAgY3JlYXRlIG1vZGUgMTAwNjQ0
IGFyY2gvYXJtL21hY2gtc2htb2JpbGUvc21wLXI5YTA2ZzAzMi5jDQo+ID4+Pj4NCj4gPj4+PiBk
aWZmIC0tZ2l0IGEvYXJjaC9hcm0vbWFjaC1zaG1vYmlsZS9NYWtlZmlsZQ0KPiA+Pj4+IGIvYXJj
aC9hcm0vbWFjaC1zaG1vYmlsZS9NYWtlZmlsZSBpbmRleCAxOTM5ZjUyLi5kN2ZjOThmIDEwMDY0
NA0KPiA+Pj4+IC0tLSBhL2FyY2gvYXJtL21hY2gtc2htb2JpbGUvTWFrZWZpbGUNCj4gPj4+PiAr
KysgYi9hcmNoL2FybS9tYWNoLXNobW9iaWxlL01ha2VmaWxlDQo+ID4+Pj4gQEAgLTM0LDYgKzM0
LDcgQEAgc21wLSQoQ09ORklHX0FSQ0hfU0g3M0EwKSs9IHNtcC1zaDczYTAubw0KPiA+Pj4gaGVh
ZHNtcC1zY3UubyBwbGF0c21wLXNjdS5vDQo+ID4+Pj4gIHNtcC0kKENPTkZJR19BUkNIX1I4QTc3
NzkpKz0gc21wLXI4YTc3NzkubyBoZWFkc21wLXNjdS5vDQo+ID4+PiBwbGF0c21wLXNjdS5vDQo+
ID4+Pj4gIHNtcC0kKENPTkZJR19BUkNIX1I4QTc3OTApKz0gc21wLXI4YTc3OTAubw0KPiA+Pj4+
IHNtcC0kKENPTkZJR19BUkNIX1I4QTc3OTEpKz0gc21wLXI4YTc3OTEubw0KPiA+Pj4+ICtzbXAt
JChDT05GSUdfQVJDSF9SOUEwNkcwMzIpKz0gc21wLXI5YTA2ZzAzMi5vDQo+ID4+Pj4gIHNtcC0k
KENPTkZJR19BUkNIX0VNRVYyKSs9IHNtcC1lbWV2Mi5vIGhlYWRzbXAtc2N1Lm8NCj4gPj4+IHBs
YXRzbXAtc2N1Lm8NCj4gPj4+Pg0KPiA+Pj4+ICAjIFBNIG9iamVjdHMNCj4gPj4+PiBkaWZmIC0t
Z2l0IGEvYXJjaC9hcm0vbWFjaC1zaG1vYmlsZS9zbXAtcjlhMDZnMDMyLmMNCj4gPj4+PiBiL2Fy
Y2gvYXJtL21hY2gtc2htb2JpbGUvc21wLXI5YTA2ZzAzMi5jDQo+ID4+Pj4gbmV3IGZpbGUgbW9k
ZSAxMDA2NDQNCj4gPj4+PiBpbmRleCAwMDAwMDAwLi5jZDQwZTZlDQo+ID4+Pj4gLS0tIC9kZXYv
bnVsbA0KPiA+Pj4+ICsrKyBiL2FyY2gvYXJtL21hY2gtc2htb2JpbGUvc21wLXI5YTA2ZzAzMi5j
DQo+ID4+Pj4gQEAgLTAsMCArMSw3OSBAQA0KPiA+Pj4+ICsvLyBTUERYLUxpY2Vuc2UtSWRlbnRp
ZmllcjogR1BMLTIuMA0KPiA+Pj4+ICsvKg0KPiA+Pj4+ICsgKiBSOUEwNkcwMzIgU2Vjb25kIENB
NyBlbmFibGVyLg0KPiA+Pj4+ICsgKg0KPiA+Pj4+ICsgKiBDb3B5cmlnaHQgKEMpIDIwMTggUmVu
ZXNhcyBFbGVjdHJvbmljcyBFdXJvcGUgTGltaXRlZA0KPiA+Pj4+ICsgKg0KPiA+Pj4+ICsgKiBN
aWNoZWwgUG9sbGV0IDxtaWNoZWwucG9sbGV0QGJwLnJlbmVzYXMuY29tPiwNCj4gPj4+IDxidXNl
cnJvckBnbWFpbC5jb20+DQo+ID4+Pj4gKyAqIERlcml2ZWQgZnJvbSBhY3Rpb24sczUwMC1zbXAN
Cj4gPj4+PiArICovDQo+ID4+Pj4gKw0KPiA+Pj4+ICsjaW5jbHVkZSA8bGludXgvaW8uaD4NCj4g
Pj4+PiArI2luY2x1ZGUgPGxpbnV4L29mLmg+DQo+ID4+Pj4gKyNpbmNsdWRlIDxsaW51eC9vZl9h
ZGRyZXNzLmg+DQo+ID4+Pj4gKyNpbmNsdWRlIDxsaW51eC9zbXAuaD4NCj4gPj4+PiArDQo+ID4+
Pj4gKy8qDQo+ID4+Pj4gKyAqIFRoZSBzZWNvbmQgQ1BVIGlzIHBhcmtlZCBpbiBST00gYXQgYm9v
dCB0aW1lLiBJdCByZXF1aXJlcw0KPiA+Pj4+ICt3YWtpbmcgaXQgYWZ0ZXINCj4gPj4+PiArICog
d3JpdGluZyBhbiBhZGRyZXNzIGludG8gdGhlIEJPT1RBRERSIHJlZ2lzdGVyIG9mIHN5c2N0cmwu
DQo+ID4+Pj4gKyAqDQo+ID4+Pj4gKyAqIFNvIHRoZSBkZWZhdWx0IHZhbHVlIG9mIHRoZSAiY3B1
LXJlbGVhc2UtYWRkciIgY29ycmVzcG9uZHMgdG8NCj4gPj4+IEJPT1RBRERSLi4uDQo+ID4+Pj4g
KyAqDQo+ID4+Pj4gKyAqICpIb3dldmVyKiB0aGUgQk9PVEFERFIgcmVnaXN0ZXIgaXMgbm90IGF2
YWlsYWJsZSB3aGVuIHRoZQ0KPiA+Pj4+ICtrZXJuZWwNCj4gPj4+PiArICogc3RhcnRzIGluIE5P
TlNFQyBtb2RlLg0KPiA+Pj4+ICsgKg0KPiA+Pj4+ICsgKiBTbyBmb3IgTk9OU0VDIG1vZGUsIHRo
ZSBib290bG9hZGVyIHJlLXBhcmtzIHRoZSBzZWNvbmQgQ1BVIGludG8NCj4gPj4+PiArYSBwZW4N
Cj4gPj4+PiArICogaW4gU1JBTSwgYW5kIGNoYW5nZXMgdGhlICJjcHUtcmVsZWFzZS1hZGRyIiBv
ZiBsaW51eCdzIERUIHRvIGENCj4gPj4+PiArU1JBTSBhZGRyZXNzLA0KPiA+Pj4+ICsgKiB3aGlj
aCBpcyBub3QgcmVzdHJpY3RlZC4NCj4gPj4+DQo+ID4+PiBUaGUgYmluZGluZyBkb2N1bWVudCBm
b3IgY3B1LXJlbGVhc2UtYWRkciBkb2VzIG5vdCBoYXZlIGEgZGVmaW5pdGlvbg0KPiA+Pj4gZm9y
IDMyIGJpdCBhcm0uICBUaGUgZXhpc3RpbmcgZGVmaW5pdGlvbiBpcyBvbmx5IDY0IGJpdCBhcm0u
ICBQbGVhc2UNCj4gPj4+IGFkZCB0aGUgZGVmaW5pdGlvbiBmb3IgMzIgYml0IGFybSB0byBwYXRj
aCAxLg0KPiA+Pg0KPiA+PiBIbW1tIEkgZG8gZmluZCBhIGRlZmluaXRpb24gaW4NCj4gPj4gRG9j
dW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2FybS9jcHVzLnR4dCAtLSBqdXN0IHVuZGVy
IHdoZXJlIEkNCj4gPj4gYWRkZWQgbXkgJ2VuYWJsZS1tZXRob2QnIC0tIEFuZCBpdCBpcyBhbHJl
YWR5IHVzZWQgYXMgMzIgYml0cyBpbiBhdA0KPiA+PiBsZWFzdCBhcmNoL2FybS9ib290L2R0cy9z
dGloNDA3LWZhbWlseS5kdHNpLg0KPiA+DQo+ID4gSWYgdGhlIGNvcnJlY3QgYW5zd2VyIGlzIGZv
ciBjcHUtcmVsZWFzZS1hZGRyIHRvIGJlIDY0IGJpdHMgaW4gY2VydGFpbg0KPiA+IGNhc2VzICh0
aGF0IGRpc2N1c3Npb24gaXMgb25nb2luZyBmdXJ0aGVyIGRvd250aHJlYWQpIHRoZW4gb25lDQo+
ID4gYXBwcm9hY2ggdG8gbWFpbnRhaW4gY29tcGF0aWJpbGl0eSBfYW5kXyB0byBmaXggdGhlIGRl
dmljZXRyZWUgc291cmNlDQo+ID4gZmlsZXMgaXMgdG8gY2hhbmdlIHRoZSBzb3VyY2UgY29kZSB0
aGF0IGN1cnJlbnRseSBnZXRzDQo+ID4gY3B1LXJlbGVhc2UtYWRkciBhcyBhDQo+ID4gMzIgYml0
IG9iamVjdCB0byBjaGVjayB0aGUgc2l6ZSBvZiB0aGUgcHJvcGVydHkgYW5kIGdldCBpdCBhcyBl
aXRoZXIgYQ0KPiA+IDMyIGJpdCBvciA2NCBiaXQgb2JqZWN0LCBiYXNlZCBvbiB0aGUgYWN0dWFs
IHNpemUgb2YgdGhlIHByb3BlcnR5IGluDQo+ID4gdGhlIGRldmljZSB0cmVlIGFuZCB0aGVuIGNo
YW5nZSB0aGUgdmFsdWUgaW4gdGhlIGRldmljZXRyZWUgc291cmNlDQo+ID4gZmlsZXMgdG8gYmUg
dHdvIGNlbGxzLiAgQlVUIHRoaXMgZG9lcyBub3QgY29uc2lkZXIgdGhlIGJvb3Rsb2FkZXINCj4g
PiBjb21wbGljYXRpb24uICBhcmNoL2FybS9ib290L2R0cy9heG01NTE2LWNwdXMuZHRzaSBoYXMg
YSBub3RlICIvLw0KPiA+IEZpeGVkIGJ5IHRoZSBib290IGxvYWRlciIsIHNvIHRoZSBib290IGxv
YWRlciBhbHNvIGhhcyB0byBiZSBtb2RpZmllZA0KPiA+IHRvIGJlIGFibGUgdG8gaGFuZGxlIHRo
ZSBwb3NzaWJpbGl0eSB0aGF0IHRoZSBwcm9wZXJ0eSBjb3VsZCBiZSBlaXRoZXINCj4gPiAzMiBi
aXRzIG9yIDY0IGJpdHMuICBJIGRvbid0IGtub3cgaG93IHRvIG1haW50YWluIGNvbXBhdGliaWxp
dHkgd2l0aA0KPiA+IHRoZSBib290IGxvYWRlciBzaW5jZSB3ZSBjYW4ndCBmb3JjZSBpdCB0byBj
aGFuZ2Ugc3luY2hyb25vdXNseSB3aXRoDQo+ID4gY2hhbmdlcyBpbiB0aGUga2VybmVsLg0KPiA+
DQo+ID4gWW91IGNhbiBjb25zaWRlciB0aGlzIGNvbW1lbnQgdG8gYmUgYSBkcml2ZS1ieSBvYnNl
cnZhdGlvbi4gIEkgdGhpbmsNCj4gPiBSb2IgYW5kIEdlZXJ0IGFuZCBwZW9wbGUgbGlrZSB0aGF0
IGFyZSBsaWtlbHkgdG8gYmUgbW9yZSBoZWxwZnVsIHdpdGgNCj4gPiB3aGF0IHRvIGFjdHVhbGx5
IGRvLCBhbmQgeW91IGNhbiB0cmVhdCBteSBjb21tZW50IG1vcmUgYXMgcG9pbnRpbmcgb3V0DQo+
ID4gdGhlIGlzc3VlIHRoYW4gYXMgcHJvdmlkaW5nIHRoZSBwZXJmZWN0IHNvbHV0aW9uLg0KPg0K
PiBEYXJuIGl0LCBoaXQgPHNlbmQ+IHRvbyBxdWlja2x5Lg0KPg0KPiBJIG1lYW50IHRvIG1lbnRp
b24gdGhhdCB0aGVyZSBhcmUgc2V2ZXJhbCBkZXZpY2V0cmVlIHNvdXJjZSBmaWxlcyB0aGF0IGhh
dmUgYQ0KPiBzaW5nbGUgY2VsbCB2YWx1ZSBmb3IgY3B1LXJlbGVhc2UtYWRkciwgYW5kIHRodXMg
cG90ZW50aWFsbHkgZmFjZSB0aGUgc2FtZQ0KPiBzaXR1YXRpb24sIGRlcGVuZGluZyBvbiB3aGF0
IHRoZSBmaW5hbCBkZWNpc2lvbiBpcyBvbiB0aGUgcHJvcGVyIHNpemUgZm9yIGNwdS0NCj4gcmVs
ZWFzZS1hZGRyLiBBcyBvZiB2NC4xNywgYSBnaXQgZ3JlcCBzaG93cyBvbmUgY2VsbCB2YWx1ZXMg
aW46DQo+DQo+ICAgYXJjaC9hcm0vYm9vdC9kdHMvYXhtNTUxNi1jcHVzLmR0c2kNCj4gICBhcmNo
L2FybS9ib290L2R0cy9zdGloNDA3LWZhbWlseS5kdHNpDQo+ICAgYXJjaC9hcm0vYm9vdC9kdHMv
c3RpaDQxOC5kdHNpDQoNClllcywgSSBoYWQgZ3JlcHBlZCBiZWZvcmUgSSB1c2VkIDMyIGJpdHMg
b24gbWluZS4uLg0KDQpOb3csIHdoYXQgaXMgdGhlIGRlY2lzaW9uIGhlcmU/IE91ciBib290bG9h
ZGVyIGlzIGFscmVhZHkgbW9kaWZpZWQgdG8gc2V0IGl0IHRvIDMyIGJpdHMsIHNvIEkgcHJvcG9z
ZSB0aGF0DQoNCisgSSBjaGFuZ2UgdGhlIGRyaXZlciB0byBoYW5kbGUgMzIgYW5kIDY0IGJpdHMg
cHJvcGVydGllcw0KKyBJIGFkZCB0aGlzIHRvIHRoZSBjcHUudHh0LCBhcyBhIHNlcGFyYXRlIHBh
dGNoOg0KIyBPbiBvdGhlciBzeXN0ZW1zLCB0aGUgcHJvcGVydHkgY2FuIGJlIGVpdGhlcg0KICAz
MiBiaXRzIG9yIDY0IGJpdHMsIGl0IGlzIHRoZSBkcml2ZXIncyByZXNwb25zaWJpbGl0eQ0KICB0
byBkZWFsIHdpdGggZWl0aGVyIHNpemVzLg0KDQpNaWNoZWwNCg0KPg0KPiAtRnJhbmsNCj4NCj4g
PiAtRnJuYWsNCj4gPg0KPiA+DQo+ID4+DQo+ID4+IFdoYXQgZG8geW91IHdhbnQgbWUgdG8gYWRk
IHRvIHRoaXMgZXhhY3RseT8gRG8geW91IHdhbnQgbWUgdG8ganVzdA0KPiA+PiBjaGFuZ2UgInJl
cXVpcmVkIGZvciBzeXN0ZW1zIHRoYXQgaGF2ZSBhbiAiZW5hYmxlLW1ldGhvZCIgcHJvcGVydHkN
Cj4gPj4gdmFsdWUgb2YgInNwaW4tdGFibGUiIHRvIGFsc28gc3BlY2lmeSByZW5lc2FzLHI5YTA2
ZzAzMiA/DQo+ID4+DQo+ID4+IFRoYW5rcyENCj4gPj4gTWljaGVsDQo+ID4+DQo+ID4+Pg0KPiA+
Pj4gLUZyYW5rDQo+ID4+Pg0KPiA+Pj4NCj4gPj4+PiArICovDQo+ID4+Pj4gKw0KPiA+Pj4+ICtz
dGF0aWMgdm9pZCBfX2lvbWVtICpjcHVfYm9vdGFkZHI7DQo+ID4+Pj4gKw0KPiA+Pj4+ICtzdGF0
aWMgREVGSU5FX1NQSU5MT0NLKGNwdV9sb2NrKTsNCj4gPj4+PiArDQo+ID4+Pj4gK3N0YXRpYyBp
bnQgcjlhMDZnMDMyX3NtcF9ib290X3NlY29uZGFyeSh1bnNpZ25lZCBpbnQgY3B1LCBzdHJ1Y3QN
Cj4gPj4+PiArdGFza19zdHJ1Y3QgKmlkbGUpIHsgaWYgKCFjcHVfYm9vdGFkZHIpIHJldHVybiAt
RU5PREVWOw0KPiA+Pj4+ICsNCj4gPj4+PiArc3Bpbl9sb2NrKCZjcHVfbG9jayk7DQo+ID4+Pj4g
Kw0KPiA+Pj4+ICt3cml0ZWwoX19wYV9zeW1ib2woc2Vjb25kYXJ5X3N0YXJ0dXApLCBjcHVfYm9v
dGFkZHIpOw0KPiA+Pj4+ICthcmNoX3NlbmRfd2FrZXVwX2lwaV9tYXNrKGNwdW1hc2tfb2YoY3B1
KSk7DQo+ID4+Pj4gKw0KPiA+Pj4+ICtzcGluX3VubG9jaygmY3B1X2xvY2spOw0KPiA+Pj4+ICsN
Cj4gPj4+PiArcmV0dXJuIDA7DQo+ID4+Pj4gK30NCj4gPj4+PiArDQo+ID4+Pj4gK3N0YXRpYyB2
b2lkIF9faW5pdCByOWEwNmcwMzJfc21wX3ByZXBhcmVfY3B1cyh1bnNpZ25lZCBpbnQNCj4gPj4+
PiArbWF4X2NwdXMpIHsgc3RydWN0IGRldmljZV9ub2RlICpkbjsgaW50IHJldDsNCj4gPj4+PiAr
dTMyIGJvb3RhZGRyOw0KPiA+Pj4+ICsNCj4gPj4+PiArZG4gPSBvZl9nZXRfY3B1X25vZGUoMSwg
TlVMTCk7DQo+ID4+Pj4gK2lmICghZG4pIHsNCj4gPj4+PiArcHJfZXJyKCJDUFUjMTogbWlzc2lu
ZyBkZXZpY2UgdHJlZSBub2RlXG4iKTsgcmV0dXJuOyB9DQo+ID4+Pj4gKy8qDQo+ID4+Pj4gKyAq
IERldGVybWluZSB0aGUgYWRkcmVzcyBmcm9tIHdoaWNoIHRoZSBDUFUgaXMgcG9sbGluZy4NCj4g
Pj4+PiArICogVGhlIGJvb3Rsb2FkZXIgKmRvZXMqIGNoYW5nZSB0aGlzIHByb3BlcnR5ICAqLyBy
ZXQgPQ0KPiA+Pj4+ICtvZl9wcm9wZXJ0eV9yZWFkX3UzMihkbiwgImNwdS1yZWxlYXNlLWFkZHIi
LCAmYm9vdGFkZHIpOw0KPiA+Pj4+ICtvZl9ub2RlX3B1dChkbik7IGlmIChyZXQpIHsNCj4gPj4+
PiArcHJfZXJyKCJDUFUjMTogaW52YWxpZCBjcHUtcmVsZWFzZS1hZGRyIHByb3BlcnR5XG4iKTsg
cmV0dXJuOyB9DQo+ID4+Pj4gK3ByX2luZm8oIkNQVSMxOiBjcHUtcmVsZWFzZS1hZGRyICUwOHhc
biIsIGJvb3RhZGRyKTsNCj4gPj4+PiArDQo+ID4+Pj4gK2NwdV9ib290YWRkciA9IGlvcmVtYXAo
Ym9vdGFkZHIsIHNpemVvZihib290YWRkcikpOyB9DQo+ID4+Pj4gKw0KPiA+Pj4+ICtzdGF0aWMg
Y29uc3Qgc3RydWN0IHNtcF9vcGVyYXRpb25zIHI5YTA2ZzAzMl9zbXBfb3BzIF9faW5pdGNvbnN0
ID0NCj4gPj4+PiAreyAuc21wX3ByZXBhcmVfY3B1cyA9IHI5YTA2ZzAzMl9zbXBfcHJlcGFyZV9j
cHVzLA0KPiA+Pj4+ICsuc21wX2Jvb3Rfc2Vjb25kYXJ5ID0gcjlhMDZnMDMyX3NtcF9ib290X3Nl
Y29uZGFyeSwgfTsNCj4gPj4+PiArQ1BVX01FVEhPRF9PRl9ERUNMQVJFKHI5YTA2ZzAzMl9zbXAs
ICJyZW5lc2FzLHI5YTA2ZzAzMi0NCj4gc21wIiwNCj4gPj4+PiArJnI5YTA2ZzAzMl9zbXBfb3Bz
KTsNCj4gPj4+Pg0KPiA+Pg0KPiA+Pg0KPiA+Pg0KPiA+Pg0KPiA+PiBSZW5lc2FzIEVsZWN0cm9u
aWNzIEV1cm9wZSBMdGQsIER1a2VzIE1lYWRvdywgTWlsbGJvYXJkIFJvYWQsIEJvdXJuZQ0KPiBF
bmQsIEJ1Y2tpbmdoYW1zaGlyZSwgU0w4IDVGSCwgVUsuIFJlZ2lzdGVyZWQgaW4gRW5nbGFuZCAm
IFdhbGVzIHVuZGVyDQo+IFJlZ2lzdGVyZWQgTm8uIDA0NTg2NzA5Lg0KPiA+Pg0KPiA+DQo+ID4N
Cg0KDQoNCg0KUmVuZXNhcyBFbGVjdHJvbmljcyBFdXJvcGUgTHRkLCBEdWtlcyBNZWFkb3csIE1p
bGxib2FyZCBSb2FkLCBCb3VybmUgRW5kLCBCdWNraW5naGFtc2hpcmUsIFNMOCA1RkgsIFVLLiBS
ZWdpc3RlcmVkIGluIEVuZ2xhbmQgJiBXYWxlcyB1bmRlciBSZWdpc3RlcmVkIE5vLiAwNDU4Njcw
OS4NCg==
