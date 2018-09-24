Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7DF2ECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:33:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C7E421486
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:33:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=renesasgroup.onmicrosoft.com header.i=@renesasgroup.onmicrosoft.com header.b="RmNsP0e3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C7E421486
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=renesas.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388264AbeIXSe7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 14:34:59 -0400
Received: from relmlor4.renesas.com ([210.160.252.174]:16391 "EHLO
        relmlie3.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1733238AbeIXSe6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 14:34:58 -0400
Received: from unknown (HELO relmlir2.idc.renesas.com) ([10.200.68.152])
  by relmlie3.idc.renesas.com with ESMTP; 24 Sep 2018 21:33:00 +0900
Received: from relmlii2.idc.renesas.com (relmlii2.idc.renesas.com [10.200.68.66])
        by relmlir2.idc.renesas.com (Postfix) with ESMTP id 5CD5677D85;
        Mon, 24 Sep 2018 21:33:00 +0900 (JST)
X-IronPort-AV: E=Sophos;i="5.54,297,1534777200"; 
   d="scan'208";a="293326783"
Received: from mail-ty1jpn01lp0177.outbound.protection.outlook.com (HELO JPN01-TY1-obe.outbound.protection.outlook.com) ([23.103.139.177])
  by relmlii2.idc.renesas.com with ESMTP/TLS/AES256-SHA256; 24 Sep 2018 21:33:00 +0900
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector1-renesas-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NRya0dTkEKtyfRR3scnPeJhv/FqzfQ5e1UsbF4UmkPQ=;
 b=RmNsP0e3bpsUSAGwzSkNK6I8f42GvRh9IqAuEflCjpDp9z2h4SorgcYqhBYM2Y0HnMO62b/3FJYTogucH5GWb4Dj50IBIZPWi9YggV6XQOdIdZ18Egy0fT2D93aX60D2JFFPgq//O84Q5k4fbV03FsAiTRktB9r7YTJpwVNMqM0=
Received: from TY1PR01MB1769.jpnprd01.prod.outlook.com (52.133.163.146) by
 TY1PR01MB1802.jpnprd01.prod.outlook.com (52.133.164.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.18; Mon, 24 Sep 2018 12:32:57 +0000
Received: from TY1PR01MB1769.jpnprd01.prod.outlook.com
 ([fe80::90da:703e:a3a9:cd97]) by TY1PR01MB1769.jpnprd01.prod.outlook.com
 ([fe80::90da:703e:a3a9:cd97%6]) with mapi id 15.20.1164.017; Mon, 24 Sep 2018
 12:32:57 +0000
From:   Phil Edworthy <phil.edworthy@renesas.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
CC:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Simon Horman <horms@verge.net.au>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v4 2/3] pinctrl: renesas: Renesas RZ/N1 pinctrl driver
Thread-Topic: [PATCH v4 2/3] pinctrl: renesas: Renesas RZ/N1 pinctrl driver
Thread-Index: AQHUUCRzDn/9H1JDBkmNZHEnGB1u0aT/W6MAgAAHQ9A=
Date:   Mon, 24 Sep 2018 12:32:57 +0000
Message-ID: <TY1PR01MB17692EEC3A7354D82DC2646CF5170@TY1PR01MB1769.jpnprd01.prod.outlook.com>
References: <20180919142346.25468-1-phil.edworthy@renesas.com>
 <20180919142346.25468-3-phil.edworthy@renesas.com>
 <CAMuHMdWcHY6LSDK+nrhk8o3uicru1NsXYumAL5KmPc8bVAaoTA@mail.gmail.com>
In-Reply-To: <CAMuHMdWcHY6LSDK+nrhk8o3uicru1NsXYumAL5KmPc8bVAaoTA@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=phil.edworthy@renesas.com; 
x-originating-ip: [193.141.220.21]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;TY1PR01MB1802;20:UsWrIdfzoAwDkqECQiVetyRwp7zHlpCqzRS/BEWjv7hFrHhCBRZ4yyW3SaZotNTi809JwXdlSH/8fSKIybkdHBGNaDVmCJKRgAO+GejThtXWJH+4xT2dsRwMUhYCUySzSFYqkytRRVq2Nffyh7cQfX75lPPbsWNPBFXtyfyIUI8=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 8457493d-fb79-411a-38da-08d62219dbe0
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:TY1PR01MB1802;
x-ms-traffictypediagnostic: TY1PR01MB1802:
x-microsoft-antispam-prvs: <TY1PR01MB1802E1099F3C0351D2838618F5170@TY1PR01MB1802.jpnprd01.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231355)(944501410)(52105095)(6055026)(149066)(150027)(6041310)(20161123558120)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(201708071742011)(7699051);SRVR:TY1PR01MB1802;BCL:0;PCL:0;RULEID:;SRVR:TY1PR01MB1802;
x-forefront-prvs: 0805EC9467
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(376002)(396003)(136003)(346002)(39860400002)(189003)(199004)(229853002)(186003)(106356001)(54906003)(6506007)(33656002)(8936002)(5250100002)(55016002)(26005)(53546011)(3846002)(6116002)(105586002)(25786009)(81166006)(102836004)(476003)(81156014)(53936002)(76176011)(446003)(11346002)(8676002)(74316002)(305945005)(9686003)(4326008)(486006)(7736002)(2900100001)(6246003)(6436002)(99286004)(97736004)(7696005)(44832011)(71190400001)(256004)(71200400001)(14454004)(68736007)(478600001)(2906002)(6916009)(5660300001)(86362001)(66066001)(316002);DIR:OUT;SFP:1102;SCL:1;SRVR:TY1PR01MB1802;H:TY1PR01MB1769.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: renesas.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: JhxBEgAeZ7t/1oDn6hwQMP0UX14H9qkkd5imhrfyxaBQOChdqOoc754JjmIvDcFmkace1BYdcOuXAY/lN4ZQLICqX4EnaqJ8UeBRreGHqQBYgpJgU0dHP/m4GrIbPvC93cVEJXzNiPnIttMOHVfO6wkcBAj7ibH6LUstcJdGC6UQAihM0bCyT+yuHipmtTWwLojm4ItNNzlaW24Vl9dUsyjK9nQ35i2FcCnl5eaiN4G+T+Oj+xhAfe8tHb8qoqcc+qQ7NUg45zwwqqCnroumDAxKQzbbPxWvRGiM0ccg7FrZSrPZGeH9VH46vZNvMqzCOva6Xin4u+T2xOWw/Krgr6wlgYTuzrGHmMiqOx5p8vw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8457493d-fb79-411a-38da-08d62219dbe0
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2018 12:32:57.6094
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PR01MB1802
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgR2VlcnQsDQoNCk9uIDI0IFNlcHRlbWJlciAyMDE4IDEyOjU5IEdlZXJ0IFV5dHRlcmhvZXZl
biB3cm90ZToNCj4gT24gV2VkLCBTZXAgMTksIDIwMTggYXQgNDoyNCBQTSBQaGlsIEVkd29ydGh5
IHdyb3RlOg0KPiA+IFRoaXMgcHJvdmlkZXMgYSBwaW5jdHJsIGRyaXZlciBmb3IgdGhlIFJlbmVz
YXMgUlovTjEgZGV2aWNlIGZhbWlseS4NCj4gPg0KPiA+IEJhc2VkIG9uIGEgcGF0Y2ggb3JpZ2lu
YWxseSB3cml0dGVuIGJ5IE1pY2hlbCBQb2xsZXQgYXQgUmVuZXNhcy4NCj4gPg0KPiA+IFNpZ25l
ZC1vZmYtYnk6IFBoaWwgRWR3b3J0aHkgPHBoaWwuZWR3b3J0aHlAcmVuZXNhcy5jb20+DQo+IA0K
PiBUaGFua3MgZm9yIHlvdXIgcGF0Y2ghDQo+IA0KPiA+IC0tLSAvZGV2L251bGwNCj4gPiArKysg
Yi9kcml2ZXJzL3BpbmN0cmwvcGluY3RybC1yem4xLmMNCj4gDQo+ID4gKy8qDQo+ID4gKyAqIFN0
cnVjdHVyZSBkZXRhaWxpbmcgdGhlIEhXIHJlZ2lzdGVycyBvbiB0aGUgUlovTjEgZGV2aWNlcy4N
Cj4gPiArICogQm90aCB0aGUgTGV2ZWwgMSBtdXggcmVnaXN0ZXJzIGFuZCBMZXZlbCAyIG11eCBy
ZWdpc3RlcnMgaGF2ZSB0aGUNCj4gPiArc2FtZQ0KPiA+ICsgKiBzdHJ1Y3R1cmUuIFRoZSBvbmx5
IGRpZmZlcmVuY2UgaXMgdGhhdCBMZXZlbCAyIGhhcyBhZGRpdGlvbmFsIE1ESU8NCj4gPiArcmVn
aXN0ZXJzDQo+ID4gKyAqIGF0IHRoZSBlbmQuDQo+ID4gKyAqLw0KPiA+ICtzdHJ1Y3QgcnpuMV9w
aW5jdHJsX3JlZ3Mgew0KPiA+ICsgICAgICAgdW5pb24gew0KPiA+ICsgICAgICAgICAgICAgICB1
MzIgICAgIGNvbmZbMTcwXTsNCj4gPiArICAgICAgICAgICAgICAgdTggICAgICBwYWQwWzB4NDAw
XTsNCj4gDQo+IFRoaXMgbG9va3MgYSBiaXQgY29uZnVzaW5nLCBhbmQgaXNuJ3QgcmVhbGx5IHBh
ZGRpbmcsIGFzIHlvdSB1c2UgYSB1bmlvbi4NCj4gV2hhdCBhYm91dCBnZXR0aW5nIHJpZCBvZiB0
aGUgdW5pb24sIGFuZCBtYWtpbmcgaXQgcmVhbCBwYWRkaW5nPw0KPiANCj4gICAgICAgICB1MzIg
Y29uZlsxNzBdOw0KPiAgICAgICAgIHUzMiBwYWQwWzg2XTsNCj4gDQo+ID4gKyAgICAgICB9Ow0K
PiA+ICsgICAgICAgdTMyICAgICBzdGF0dXNfcHJvdGVjdDsgLyogMHg0MDAgKi8NCj4gPiArICAg
ICAgIC8qIE1ESU8gbXV4IHJlZ2lzdGVycywgbGV2ZWwyIG9ubHkgKi8NCj4gPiArICAgICAgIHUz
MiAgICAgbDJfbWRpb1syXTsNCj4gPiArfTsNCj4gDQo+IEJUVywgd2hpbGUgdXNpbmcgYSBzdHJ1
Y3QgaW5zdGVhZCBvZiByZWdpc3RlciBvZmZzZXQgZGVmaW5pdGlvbnMgaGFzIGl0cyBtZXJpdHMs
DQo+IGl0IGFsc28gaGFzIGl0cyBkcmF3YmFja3MsIGxpa2UgdGhlIG5lZWQgZm9yIHRoZSAiMHg0
MDAiIGNvbW1lbnQuDQo+IFlvdSBkb24ndCBoYXZlIHRvIGNoYW5nZSBpdCwgdGhvdWdoLg0KPiAN
Cj4gPiArc3RhdGljIGNvbnN0IHN0cnVjdCByem4xX3Bpbl9ncm91cCAqcnpuMV9waW5jdHJsX2Zp
bmRfZ3JvdXBfYnlfbmFtZSgNCj4gPiArICAgICAgIGNvbnN0IHN0cnVjdCByem4xX3BpbmN0cmwg
KmlwY3RsLCBjb25zdCBjaGFyICpuYW1lKSB7DQo+ID4gKyAgICAgICBjb25zdCBzdHJ1Y3Qgcnpu
MV9waW5fZ3JvdXAgKmdycCA9IE5VTEw7DQo+ID4gKyAgICAgICBpbnQgaTsNCj4gDQo+IHVuc2ln
bmVkIGludCBpOw0KPiAocnpuMV9waW5jdHJsLm5ncm91cHMgaXMgdW5zaWduZWQgaW50KQ0KPiAN
Cj4gPiArDQo+ID4gKyAgICAgICBmb3IgKGkgPSAwOyBpIDwgaXBjdGwtPm5ncm91cHM7IGkrKykg
ew0KPiA+ICsgICAgICAgICAgICAgICBpZiAoIXN0cmNtcChpcGN0bC0+Z3JvdXBzW2ldLm5hbWUs
IG5hbWUpKSB7DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgZ3JwID0gJmlwY3RsLT5ncm91
cHNbaV07DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgYnJlYWs7DQo+ID4gKyAgICAgICAg
ICAgICAgIH0NCj4gPiArICAgICAgIH0NCj4gPiArDQo+ID4gKyAgICAgICByZXR1cm4gZ3JwOw0K
PiA+ICt9DQo+IA0KPiA+ICtzdGF0aWMgaW50IHJ6bjFfcGluY29uZl9zZXQoc3RydWN0IHBpbmN0
cmxfZGV2ICpwY3RsZGV2LCB1bnNpZ25lZCBpbnQgcGluLA0KPiA+ICsgICAgICAgICAgICAgICAg
ICAgICAgICAgICB1bnNpZ25lZCBsb25nICpjb25maWdzLCB1bnNpZ25lZCBpbnQNCj4gPiArbnVt
X2NvbmZpZ3MpIHsNCj4gPiArICAgICAgIHN0cnVjdCByem4xX3BpbmN0cmwgKmlwY3RsID0gcGlu
Y3RybF9kZXZfZ2V0X2RydmRhdGEocGN0bGRldik7DQo+ID4gKyAgICAgICBlbnVtIHBpbl9jb25m
aWdfcGFyYW0gcGFyYW07DQo+ID4gKyAgICAgICBpbnQgaTsNCj4gDQo+IHVuc2lnbmVkIGludCBp
Ow0KPiANCj4gPiArICAgICAgIHUzMiBhcmc7DQo+ID4gKyAgICAgICB1MzIgbDEsIGwxX2NhY2hl
Ow0KPiA+ICsgICAgICAgdTMyIGRydjsNCj4gPiArDQo+ID4gKyAgICAgICBpZiAocGluID49IEFS
UkFZX1NJWkUoaXBjdGwtPmxldjEtPmNvbmYpKQ0KPiA+ICsgICAgICAgICAgICAgICByZXR1cm4g
LUVJTlZBTDsNCj4gPiArDQo+ID4gKyAgICAgICBsMSA9IHJlYWRsKCZpcGN0bC0+bGV2MS0+Y29u
ZltwaW5dKTsNCj4gPiArICAgICAgIGwxX2NhY2hlID0gbDE7DQo+ID4gKw0KPiA+ICsgICAgICAg
Zm9yIChpID0gMDsgaSA8IG51bV9jb25maWdzOyBpKyspIHsNCj4gDQo+ID4gK3N0YXRpYyBpbnQg
cnpuMV9waW5jb25mX2dyb3VwX2dldChzdHJ1Y3QgcGluY3RybF9kZXYgKnBjdGxkZXYsDQo+ID4g
KyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHVuc2lnbmVkIGludCBzZWxlY3RvciwN
Cj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdW5zaWduZWQgbG9uZyAqY29u
ZmlnKSB7DQo+ID4gKyAgICAgICBzdHJ1Y3QgcnpuMV9waW5jdHJsICppcGN0bCA9IHBpbmN0cmxf
ZGV2X2dldF9kcnZkYXRhKHBjdGxkZXYpOw0KPiA+ICsgICAgICAgc3RydWN0IHJ6bjFfcGluX2dy
b3VwICpncnAgPSAmaXBjdGwtPmdyb3Vwc1tzZWxlY3Rvcl07DQo+ID4gKyAgICAgICB1bnNpZ25l
ZCBsb25nIG9sZCA9IDA7DQo+ID4gKyAgICAgICBpbnQgaTsNCj4gDQo+IHVuc2lnbmVkIGludCBp
Ow0KPiANCj4gPiArDQo+ID4gKyAgICAgICBkZXZfZGJnKGlwY3RsLT5kZXYsICJncm91cCBnZXQg
JXMgc2VsZWN0b3I6JWRcbiIsIGdycC0+bmFtZSwNCj4gPiArIHNlbGVjdG9yKTsNCj4gDQo+ICV1
IHRvIGZvcm1hdCB1bnNpZ25lZCBpbnQuDQo+IA0KPiA+ICsNCj4gPiArICAgICAgIGZvciAoaSA9
IDA7IGkgPCBncnAtPm5waW5zOyBpKyspIHsNCj4gDQo+ID4gK3N0YXRpYyBpbnQgcnpuMV9waW5j
b25mX2dyb3VwX3NldChzdHJ1Y3QgcGluY3RybF9kZXYgKnBjdGxkZXYsDQo+ID4gKyAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIHVuc2lnbmVkIGludCBzZWxlY3RvciwNCj4gPiArICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdW5zaWduZWQgbG9uZyAqY29uZmlncywNCj4g
PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdW5zaWduZWQgaW50IG51bV9jb25m
aWdzKSB7DQo+ID4gKyAgICAgICBzdHJ1Y3QgcnpuMV9waW5jdHJsICppcGN0bCA9IHBpbmN0cmxf
ZGV2X2dldF9kcnZkYXRhKHBjdGxkZXYpOw0KPiA+ICsgICAgICAgc3RydWN0IHJ6bjFfcGluX2dy
b3VwICpncnAgPSAmaXBjdGwtPmdyb3Vwc1tzZWxlY3Rvcl07DQo+ID4gKyAgICAgICBpbnQgcmV0
LCBpOw0KPiANCj4gdW5zaWduZWQgaW50IGk7DQo+IA0KPiA+ICsNCj4gPiArICAgICAgIGRldl9k
YmcoaXBjdGwtPmRldiwgImdyb3VwIHNldCAlcyBzZWxlY3RvcjolZA0KPiA+ICsgY29uZmlnczol
cC8lZFxuIiwNCj4gDQo+ICV1DQo+IA0KPiA+ICsgICAgICAgICAgICAgICBncnAtPm5hbWUsIHNl
bGVjdG9yLCBjb25maWdzLCBudW1fY29uZmlncyk7DQo+ID4gKw0KPiA+ICsgICAgICAgZm9yIChp
ID0gMDsgaSA8IGdycC0+bnBpbnM7IGkrKykgew0KPiA+ICsgICAgICAgICAgICAgICB1bnNpZ25l
ZCBpbnQgcGluID0gZ3JwLT5waW5zW2ldOw0KPiA+ICsNCj4gPiArICAgICAgICAgICAgICAgcmV0
ID0gcnpuMV9waW5jb25mX3NldChwY3RsZGV2LCBwaW4sIGNvbmZpZ3MsIG51bV9jb25maWdzKTsN
Cj4gPiArICAgICAgICAgICAgICAgaWYgKHJldCkNCj4gPiArICAgICAgICAgICAgICAgICAgICAg
ICByZXR1cm4gcmV0Ow0KPiA+ICsgICAgICAgfQ0KPiA+ICsNCj4gPiArICAgICAgIHJldHVybiAw
Ow0KPiA+ICt9DQo+IA0KPiANCj4gPiArc3RhdGljIGludCByem4xX3BpbmN0cmxfcGFyc2VfZnVu
Y3Rpb25zKHN0cnVjdCBkZXZpY2Vfbm9kZSAqbnAsDQo+ID4gKyAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIHN0cnVjdCByem4xX3BpbmN0cmwgKmlwY3RsLA0KPiA+ICt1MzIg
aW5kZXgpDQo+IA0KPiBXaHkgdTMyIGluc3RlYWQgb2YgcGxhaW4gdW5zaWduZWQgaW50Pw0KPiAN
Cj4gPiArew0KPiA+ICsgICAgICAgc3RydWN0IGRldmljZV9ub2RlICpjaGlsZDsNCj4gPiArICAg
ICAgIHN0cnVjdCByem4xX3BteF9mdW5jICpmdW5jOw0KPiA+ICsgICAgICAgc3RydWN0IHJ6bjFf
cGluX2dyb3VwICpncnA7DQo+ID4gKyAgICAgICB1MzIgaSA9IDA7DQo+IA0KPiBXaHkgbm90IHBs
YWluIHVuc2lnbmVkIGludD8NCj4gDQo+ID4gKyAgICAgICBpbnQgcmV0Ow0KPiA+ICsNCj4gPiAr
ICAgICAgIGZ1bmMgPSAmaXBjdGwtPmZ1bmN0aW9uc1tpbmRleF07DQo+ID4gKw0KPiA+ICsgICAg
ICAgLyogSW5pdGlhbGlzZSBmdW5jdGlvbiAqLw0KPiA+ICsgICAgICAgZnVuYy0+bmFtZSA9IG5w
LT5uYW1lOw0KPiA+ICsgICAgICAgZnVuYy0+bnVtX2dyb3VwcyA9IHJ6bjFfcGluY3RybF9jb3Vu
dF9mdW5jdGlvbl9ncm91cHMobnApOw0KPiA+ICsgICAgICAgaWYgKGZ1bmMtPm51bV9ncm91cHMg
PT0gMCkgew0KPiA+ICsgICAgICAgICAgICAgICBkZXZfZXJyKGlwY3RsLT5kZXYsICJubyBncm91
cHMgZGVmaW5lZCBpbiAlcE9GXG4iLCBucCk7DQo+ID4gKyAgICAgICAgICAgICAgIHJldHVybiAt
RUlOVkFMOw0KPiA+ICsgICAgICAgfQ0KPiA+ICsgICAgICAgZGV2X2RiZyhpcGN0bC0+ZGV2LCAi
ZnVuY3Rpb24gJXMgaGFzICVkIGdyb3Vwc1xuIiwNCj4gPiArICAgICAgICAgICAgICAgbnAtPm5h
bWUsIGZ1bmMtPm51bV9ncm91cHMpOw0KPiA+ICsNCj4gPiArICAgICAgIGZ1bmMtPmdyb3VwcyA9
IGRldm1fa21hbGxvY19hcnJheShpcGN0bC0+ZGV2LA0KPiA+ICsgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIGZ1bmMtPm51bV9ncm91cHMsIHNpemVvZihjaGFyICopLA0K
PiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIEdGUF9LRVJORUwp
Ow0KPiA+ICsgICAgICAgaWYgKCFmdW5jLT5ncm91cHMpDQo+ID4gKyAgICAgICAgICAgICAgIHJl
dHVybiAtRU5PTUVNOw0KPiA+ICsNCj4gPiArICAgICAgIGlmIChvZl9wcm9wZXJ0eV9jb3VudF91
MzJfZWxlbXMobnAsIFJaTjFfUElOU19QUk9QKSA+IDApIHsNCj4gPiArICAgICAgICAgICAgICAg
ZnVuYy0+Z3JvdXBzW2ldID0gbnAtPm5hbWU7DQo+ID4gKyAgICAgICAgICAgICAgIGdycCA9ICZp
cGN0bC0+Z3JvdXBzW2lwY3RsLT5uZ3JvdXBzXTsNCj4gPiArICAgICAgICAgICAgICAgZ3JwLT5m
dW5jID0gZnVuYy0+bmFtZTsNCj4gPiArICAgICAgICAgICAgICAgcmV0ID0gcnpuMV9waW5jdHJs
X3BhcnNlX2dyb3VwcyhucCwgZ3JwLCBpcGN0bCk7DQo+ID4gKyAgICAgICAgICAgICAgIGlmIChy
ZXQgPCAwKQ0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIHJldHVybiByZXQ7DQo+ID4gKyAg
ICAgICAgICAgICAgIGkrKzsNCj4gPiArICAgICAgICAgICAgICAgaXBjdGwtPm5ncm91cHMrKzsN
Cj4gPiArICAgICAgIH0NCj4gPiArDQo+ID4gKyAgICAgICBmb3JfZWFjaF9jaGlsZF9vZl9ub2Rl
KG5wLCBjaGlsZCkgew0KPiA+ICsgICAgICAgICAgICAgICBmdW5jLT5ncm91cHNbaV0gPSBjaGls
ZC0+bmFtZTsNCj4gPiArICAgICAgICAgICAgICAgZ3JwID0gJmlwY3RsLT5ncm91cHNbaXBjdGwt
Pm5ncm91cHNdOw0KPiA+ICsgICAgICAgICAgICAgICBncnAtPmZ1bmMgPSBmdW5jLT5uYW1lOw0K
PiA+ICsgICAgICAgICAgICAgICByZXQgPSByem4xX3BpbmN0cmxfcGFyc2VfZ3JvdXBzKGNoaWxk
LCBncnAsIGlwY3RsKTsNCj4gPiArICAgICAgICAgICAgICAgaWYgKHJldCA8IDApDQo+ID4gKyAg
ICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIHJldDsNCj4gPiArICAgICAgICAgICAgICAgaSsr
Ow0KPiA+ICsgICAgICAgICAgICAgICBpcGN0bC0+bmdyb3VwcysrOw0KPiA+ICsgICAgICAgfQ0K
PiA+ICsNCj4gPiArICAgICAgIGRldl9kYmcoaXBjdGwtPmRldiwgImZ1bmN0aW9uICVzIHBhcnNl
ZCAlZC8lZCBncm91cHNcbiIsDQo+IA0KPiAldS8ldQ0KPiANCj4gPiArICAgICAgICAgICAgICAg
bnAtPm5hbWUsIGksIGZ1bmMtPm51bV9ncm91cHMpOw0KPiA+ICsNCj4gPiArICAgICAgIHJldHVy
biAwOw0KPiA+ICt9DQo+ID4gKw0KPiA+ICtzdGF0aWMgaW50IHJ6bjFfcGluY3RybF9wcm9iZV9k
dChzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2LA0KPiA+ICsgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIHN0cnVjdCByem4xX3BpbmN0cmwgKmlwY3RsKSB7DQo+ID4gKyAgICAgICBz
dHJ1Y3QgZGV2aWNlX25vZGUgKm5wID0gcGRldi0+ZGV2Lm9mX25vZGU7DQo+ID4gKyAgICAgICBz
dHJ1Y3QgZGV2aWNlX25vZGUgKmNoaWxkOw0KPiA+ICsgICAgICAgdW5zaWduZWQgaW50IG1heGdy
b3VwcyA9IDA7DQo+ID4gKyAgICAgICB1MzIgbmZ1bmNzID0gMDsNCj4gPiArICAgICAgIHUzMiBp
ID0gMDsNCj4gDQo+IFdoeSBub3QgcGxhaW4gdW5zaWduZWQgaW50LCBmb3IgYm90aD8NCg0KVGhh
bmtzIGZvciB5b3VyIHJldmlldyBhbmQgY29tbWVudHMsIHlvdSBhcmUgcmlnaHQgaW4gYWxsIG9m
IHRoZW0uDQpJJ2xsIGZpeCB0aGVtIGFuZCByZS1wb3N0Lg0KDQpUaGFua3MNClBoaWwNCg0KPiBH
cntvZXRqZSxlZXRpbmd9cywNCj4gDQo+ICAgICAgICAgICAgICAgICAgICAgICAgIEdlZXJ0DQo+
IA0KPiAtLQ0KPiBHZWVydCBVeXR0ZXJob2V2ZW4gLS0gVGhlcmUncyBsb3RzIG9mIExpbnV4IGJl
eW9uZCBpYTMyIC0tIGdlZXJ0QGxpbnV4LQ0KPiBtNjhrLm9yZw0KPiANCj4gSW4gcGVyc29uYWwg
Y29udmVyc2F0aW9ucyB3aXRoIHRlY2huaWNhbCBwZW9wbGUsIEkgY2FsbCBteXNlbGYgYSBoYWNr
ZXIuIEJ1dA0KPiB3aGVuIEknbSB0YWxraW5nIHRvIGpvdXJuYWxpc3RzIEkganVzdCBzYXkgInBy
b2dyYW1tZXIiIG9yIHNvbWV0aGluZyBsaWtlIHRoYXQuDQo+ICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgLS0gTGludXMgVG9ydmFsZHMNCg==
