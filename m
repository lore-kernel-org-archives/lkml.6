Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79223C43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 11:03:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1670420867
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 11:03:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=renesasgroup.onmicrosoft.com header.i=@renesasgroup.onmicrosoft.com header.b="E8BPoa5Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1670420867
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=renesas.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727467AbeICPXH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 11:23:07 -0400
Received: from relmlor4.renesas.com ([210.160.252.174]:32791 "EHLO
        relmlie3.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726034AbeICPXH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 11:23:07 -0400
Received: from unknown (HELO relmlir2.idc.renesas.com) ([10.200.68.152])
  by relmlie3.idc.renesas.com with ESMTP; 03 Sep 2018 20:03:23 +0900
Received: from relmlii1.idc.renesas.com (relmlii1.idc.renesas.com [10.200.68.65])
        by relmlir2.idc.renesas.com (Postfix) with ESMTP id CD7FF7AD6D;
        Mon,  3 Sep 2018 20:03:23 +0900 (JST)
X-IronPort-AV: E=Sophos;i="5.53,324,1531753200"; 
   d="scan'208";a="289855228"
Received: from mail-os2jpn01lp0145.outbound.protection.outlook.com (HELO JPN01-OS2-obe.outbound.protection.outlook.com) ([23.103.139.145])
  by relmlii1.idc.renesas.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Sep 2018 20:03:23 +0900
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector1-renesas-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Oi89GQIH9ziSkw+isOSeg+Iu0U5HsbRzhJwG/7s/CGo=;
 b=E8BPoa5ZH7BnDJ/G7mT5c4fHsPzyAlZ5M4ExVFr7dkUmBbFopFifk7yoI4B1DZkdzX1erzuCnednh1tGXfsZOPTlIglE9E6T0Co1GOgVazLBHmHvIh3W5HW156LGqzak4jZ7Aq8/0wr+JXu8hjmuMtZKQs8RD+dBWUgq5/ZPRAc=
Received: from TY1PR01MB1769.jpnprd01.prod.outlook.com (52.133.163.146) by
 TY1PR01MB0285.jpnprd01.prod.outlook.com (10.161.136.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1101.17; Mon, 3 Sep 2018 11:03:19 +0000
Received: from TY1PR01MB1769.jpnprd01.prod.outlook.com
 ([fe80::7c89:e594:b792:97eb]) by TY1PR01MB1769.jpnprd01.prod.outlook.com
 ([fe80::7c89:e594:b792:97eb%4]) with mapi id 15.20.1080.020; Mon, 3 Sep 2018
 11:03:19 +0000
From:   Phil Edworthy <phil.edworthy@renesas.com>
To:     jacopo mondi <jacopo@jmondi.org>
CC:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Simon Horman <horms@verge.net.au>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 0/3] Renesas R9A06G032 PINCTRL Driver
Thread-Topic: [PATCH v2 0/3] Renesas R9A06G032 PINCTRL Driver
Thread-Index: AQHUQGMu6ROdNPJdbkaf+nPyB2h7vKTeYncAgAADtzA=
Date:   Mon, 3 Sep 2018 11:03:18 +0000
Message-ID: <TY1PR01MB17697F04004A7C8CF1D21CC1F50C0@TY1PR01MB1769.jpnprd01.prod.outlook.com>
References: <1535634775-19365-1-git-send-email-phil.edworthy@renesas.com>
 <20180903103358.GC20333@w540>
In-Reply-To: <20180903103358.GC20333@w540>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=phil.edworthy@renesas.com; 
x-originating-ip: [193.141.220.21]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;TY1PR01MB0285;20:0/+RMBP42UUiUi5J+sc+eT6BOZemEhdKwjAaADtu82jv4yWKHqhlym9o+yNvniX0FFsHE8h6eli5NHcj7a96G9Jy3rAtWYOzZdUy/UbVyuBkwTy9zTducCl4CFvSAA1fROXHQ0OEZXYGdBunmkwP7R8c0EizgTy8FtoiB97kr/0=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 37619564-09e4-4d2a-390f-08d6118cdb64
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:TY1PR01MB0285;
x-ms-traffictypediagnostic: TY1PR01MB0285:
x-microsoft-antispam-prvs: <TY1PR01MB0285925F210927B5C8647A9FF50C0@TY1PR01MB0285.jpnprd01.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(20558992708506);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231311)(944501410)(52105095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(201708071742011)(7699016);SRVR:TY1PR01MB0285;BCL:0;PCL:0;RULEID:;SRVR:TY1PR01MB0285;
x-forefront-prvs: 0784C803FD
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(39860400002)(346002)(136003)(366004)(199004)(189003)(6116002)(2900100001)(55016002)(9686003)(97736004)(26005)(66066001)(6306002)(476003)(7416002)(74316002)(305945005)(86362001)(7736002)(5250100002)(486006)(44832011)(3846002)(11346002)(446003)(14454004)(8676002)(53936002)(316002)(8936002)(25786009)(2906002)(6916009)(6246003)(68736007)(6436002)(54906003)(81156014)(81166006)(33656002)(229853002)(4326008)(76176011)(102836004)(105586002)(256004)(99286004)(478600001)(186003)(5660300001)(6506007)(106356001)(7696005)(53546011)(966005);DIR:OUT;SFP:1102;SCL:1;SRVR:TY1PR01MB0285;H:TY1PR01MB1769.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: renesas.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: mn9+dQ3J7gIyom5vbmKR8Ueap7SMP698J69kROBZf8LAgaL3xtLFBfgiWR/knPbkeiEbpDRclfRwIWg90+bZceXHNV+U6FDDZTI28Yir8zC4p2yovRdQs34dYZNN5vZqummTHC5dvTZoQ8/nvdY/W//T347ZB4J1Y5v9tqFZt1WlpbrFf1Wsq6OXkb6u8kyQBDaVRkqCAvJ89p4p+zWCSgCjviCpAnsEu1Xb3G2PeSN68jn332DZyonOH0xQxDUkYkv7EiuEWcD5gHlznGv2L71DhtqJas1hPI8qk+nJjtxxDKTNKxYHlc6uiRCzuIyDC8k0mS66tSWs1O0QRAyUmDpu49k6VoP+TOKuivL+AAI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37619564-09e4-4d2a-390f-08d6118cdb64
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2018 11:03:18.7662
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PR01MB0285
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgSmFjb3BvLA0KDQpPbiAwMyBTZXB0ZW1iZXIgMjAxOCAxMTozNCwgamFjb3BvIG1vbmRpIHdy
b3RlOg0KPiBPbiBUaHUsIEF1ZyAzMCwgMjAxOCBhdCAwMjoxMjo1MlBNICswMTAwLCBQaGlsIEVk
d29ydGh5IHdyb3RlOg0KPiA+IFRoaXMgaW1wbGVtZW50cyB0aGUgcGluY3RybCBkcml2ZXIgZm9y
IHRoZSBSWi9OMSBmYW1pbHkgb2YgZGV2aWNlcywgaW5jbHVkaW5nDQo+ID4gdGhlIFI5QTA2RzAz
MiAoUlovTjFEKSBkZXZpY2UuDQo+ID4NCj4gPiBPbmUgYXJlYSB0aGF0IGlzIGxpa2VseSB0byBi
ZSBjb250ZW50aW91cyBpcyB0aGUgdXNlIG9mICd2aXJ0dWFsIHBpbnMnIGZvciB0aGUNCj4gPiBN
RElPIHBpbm11eGluZy4gVGhlIGRyaXZlciB1c2VzIHR3byBwaW5zICgxNzAgYW5kIDE3MSkgdGhh
dCBkb24ndCBleGlzdCBvbg0KPiB0aGUNCj4gPiBkZXZpY2UgdG8gY29uZmlndXJlIHRoZSBNRElP
IHNvdXJjZSB3aXRoaW4gdGhlIFJaL04xIGRldmljZXMuIE9uIHRoZXNlDQo+IGRldmljZXMsDQo+
ID4gdGhlcmUgYXJlIHR3byBFdGhlcm5ldCBNQUNzLCBhIDUtUG9ydCBTd2l0Y2gsIG51bWVyb3Vz
IGluZHVzdHJpYWwNCj4gRXRoZXJuZXQNCj4gPiBwZXJpcGhlcmFscywgYW55IG9mIHdoaWNoIGNh
biBiZSB0aGUgTURJTyBzb3VyY2UuIENvbmZpZ3VyaW5nIHRoZSBNRElPDQo+IHNvdXJjZQ0KPiA+
IGNvdWxkIGJlIGRvbmUgd2l0aG91dCB0aGUgdmlydHVhbCBwaW5zLCBlLmcuIGJ5IGV4dGVuZGlu
ZyB0aGUgZnVuY3Rpb25zIHRvDQo+ID4gY292ZXIgYWxsIE1ESU8gdmFyaWFudHMgKGEgdG90YWwg
b2YgMzIgYWRkaXRpb25hbCBmdW5jdGlvbnMpLCBidXQgdGhpcyB3b3VsZA0KPiA+IGFsbG93IHVz
ZXJzIHRvIG1pc2NvbmZpZ3VyZSBpbmRpdmlkdWFsIE1ESU8gcGlucywgcmF0aGVyIHRoYW4gYXNz
aWduIGFsbA0KPiBNRElPDQo+ID4gcGlucyB0byBhIE1ESU8gc291cmNlLiBUaGUgY2hvaWNlIG9m
IGhvdyB0byBpbXBsZW1lbnQgdGhpcyB3aWxsIGFmZmVjdCB0aGUNCj4gPiBEVCBiaW5kaW5ncy4N
Cj4gPg0KPiA+IFRoaXMgc2VyaWVzIHdhcyBvcmlnaW5hbGx5IHdyaXR0ZW4gYnkgTWljaGVsIFBv
bGxldCB3aGlsc3QgYXQgUmVuZXNhcywgYW5kIEkNCj4gPiBoYXZlIHRha2VuIG92ZXIgdGhpcyB3
b3JrLg0KPiA+DQo+ID4gT25lIHBvaW50IGZyb20gTWljaGVsJ3MgdjEgc2VyaWVzOg0KPiA+ICJO
b3RlLCBJIHVzZWQgcmVuZXNhcyxyem4xLXBpbm11eCBub2RlIHRvIHNwZWNpZnkgdGhlIHBpbm11
eCBjb25zdGFudHMsDQo+ID4gYW5kIEkgYWxzbyBkb24ndCB1c2Ugc29tZSBvZiB0aGUgcHJvcGVy
dGllcyBkb2N1bWVudGVkIGluDQo+ID4gcGluY3RybC1iaW5kaW5ncy50eHQgb24gcHVycG9zZSwg
YXMgdGhleSBhcmUgdG9vIGxpbWl0ZWQgZm9yIG15IHVzZQ0KPiA+IChJIG5lZWQgdG8gYmUgYWJs
ZSB0byBzZXQsIGNsZWFyLCBpZ25vcmUgb3IgcmVzZXQgbGV2ZWwsIHB1bGwgdXAvZG93bg0KPiA+
IGFuZCBmdW5jdGlvbiBhcyB0aGUgcGlubXV4IG1pZ2h0IGJlIHNldCBieSBhbm90aGVyIE9TL2Nv
cmUgcnVubmluZw0KPiA+IGNvbmN1cmVudGx5KS4iDQo+ID4NCj4gDQo+IEkgc3RhcnQgYnkgc2F5
aW5nIHRoYXQgSSBkb24ndCBrbm93IHRoaXMgSFcgcGluIGNvbnRyb2xsZXIgd2VsbCwgc28NCj4g
SSBtaWdodCBiZSBtaXNzaW5nIHNvbWV0aGluZywgYnV0IGFzIGNvbW1lbnRlZCBvbiB0aGUgb3Jp
Z2luYWwgc2VyaWVzIGZyb20NCj4gTWljaGVhbCwgSSBzdGlsbCBkb24ndCBzZWUgd2h5IHlvdSBu
ZWVkIGEgY3VzdG9tIHByb3BlcnR5IGhlcmUuLi4NCj4gDQo+IE15IHVuZGVyc3RhbmRpbmcsIGxv
b2tpbmcgYXQgdGhpcyBjb21tZW50IGFuZCB0aGUgaGVhZGVyIHByb3ZpZGVkIGJ5DQo+IHBhdGNo
IFsxLzNdIChpbmNsdWRlL2R0LWJpbmRpbmdzL3BpbmN0cmwvcnpuMS1waW5jdHJsLmgpIGlzIHRo
YXQNCj4gYmFzaWNhbGx5IG5lZWQgdG8gY29udHJvbCBwdWxsLXVwL2Rvd24gYW5kIHRoZSBvdXRw
dXQgZHJpdmVyIHN0cmVuZ3RoLg0KPiANCj4gRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRp
bmdzL3BpbmN0cmwvcGluY3RybC1iaW5kaW5ncy50eHQgcmVwb3J0cw0KPiBhIHNldCBvZiBnZW5l
cmljIHBpbiBjb25maWd1cmF0aW9uIHByb3BlcnRpZXMgdG8gYmUgYXBwbGllZCB0byBhIHBpbg0K
PiBjb25maWd1cmF0aW9uIChhbmQgbXVsdGlwbGV4aW5nKSBwaW4gY29udHJvbGxlciBjaGlsZCBu
b2RlIHRoYXQgZnVsbHkNCj4gZXhwcmVzcyBhbGwgKG1vc3Q/KSBvZiB5b3VyIG5lZWRzLg0KPiAN
Cj4gRWcuIGEgcGluIGNvbmZpZ3VyYXRpb24gd2l0aCBwdWxsIHVwIGFwcGxpZWQsIHVzaW5nIGV4
YW1wbGVzIGZyb20geW91cg0KPiBjb3ZlciBsZXR0ZXIgc2hvdWxkIGJlIGV4cHJlc3NlZCBhcw0K
PiANCj4gWW91ciBleGFtcGxlOg0KPiAgICAgICAgICAmcGluY3RybCB7DQo+ICAgICAgICAgICAg
ICAgICAgcGluc3VhcnQwOiBwaW5zdWFydDAgew0KPiAgICAgICAgICAgICAgICAgICAgICAgICAg
cmVuZXNhcyxyem4xLXBpbm11eC1pZHMgPSA8DQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIFJaTjFfTVVYKDEwMywgVUFSVDBfSSkgIC8qIFVBUlQwX1RYRCAqLw0KPiAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBSWk4xX01VWF9QVVAoMTA0LCBVQVJUMF9JKSAgICAg
IC8qIFVBUlQwX1JYRCAqLw0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgPjsNCj4gICAgICAg
ICAgICAgICAgICB9Ow0KPiAgICAgICAgICB9Ow0KPiANCj4gVXNpbmcgc3RhbmRhcmQgcGluY3Ry
b2xsZXIgYmluZGluZ3MgcGluIGNvbmZpZ3VyYXRpb24gcHJvcGVydGllczoNCj4gDQo+ICAgICAg
ICAgICZwaW5jdHJsIHsNCj4gICAgICAgICAgICAgICAgICBwaW5zdWFydDA6IHVhcnQwICB7DQo+
ICAgICAgICAgICAgICAgICAgICAgICAgIHBpbnN1YXJ0X3R4MCB7DQo+ICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgcGlubXV4ID0gPDEwMywgVUFSVDBfST47ICAvKiBVQVJUMF9UWEQg
Ki8NCj4gICAgICAgICAgICAgICAgICAgICAgICAgfTsNCj4gDQo+ICAgICAgICAgICAgICAgICAg
ICAgICAgIHBpbnN1YXJ0X3J4MCB7DQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IHBpbm11eCA9IDwxMDQsIFVBUlQwX0k+OyAvKiBVQVJUMF9SWEQgKi8NCj4gICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgYmlhcy1wdWxsLXVwOw0KPiAgICAgICAgICAgICAgICAgICAg
ICAgICB9Ow0KPiAgICAgICAgICAgICAgICAgIH07DQo+ICAgICAgICAgIH07DQo+IA0KPiBJcyB0
aGVyZSBhbnl0aGluZyBJIGFtIG1pc3Npbmc/IE1heWJlIGZyb20gdGhlIGludGVyYWN0aW9uIHdp
dGgNCj4gImFub3RoZXIgT1MvY29yZSBydW5uaW5nIGNvbmN1cnJlbnRseSIgeW91IG1lbnRpb25l
ZD8gSW4gdGhpcyBjYXNlIGlmDQo+IHlvdSBvbmx5IGhhdmUgdG8gcGVyZm9ybSBwaW4gY29uZmln
dXJhdGlvbiAoYmVjYXVzZSBtdXhpbmcgaXMgaGFuZGxlZA0KPiBhbHJlYWR5KSB0aGluZ3MgYXJl
IGV2ZW4gc2ltcGxlciwganVzdCB1c2UgdGhlIHBpbiBjb25maWd1cmF0aW9uDQo+IGJpbmRpbmdz
LCB3aXRob3V0IGludm9sdmluZyBtdXhpbmcgYXQgYWxsOg0KPiANCj4gICAgICAgICAmcGluY3Ry
bCB7DQo+ICAgICAgICAgICAgICAgICBwaW5zdWFydF9jb25mOiB1YXJ0MCB7DQo+ICAgICAgICAg
ICAgICAgICAgICAgICAgIHBpbnMgPSA8MTAzLCAxMDQ+Ow0KPiAgICAgICAgICAgICAgICAgICAg
ICAgICBiaWFzLXB1bGwtdXA7DQo+ICAgICAgICAgICAgICAgICAgfTsNCj4gICAgICAgICAgfTsN
Cg0KU29ycnkgSSBkaWRu4oCZdCBhZGRyZXNzIHlvdXIgcG9pbnQuDQpUaGUgb25seSByZWFzb24g
d2Ugd2FudCB0byB1c2UgbmV3IHByb3BlcnRpZXMgaXMgc28gdGhlIGRyaXZlciBjYW4gcHJvY2Vz
cw0KZHRzIGZpbGVzIHRoYXQgaGF2ZSBiZWVuIGdlbmVyYXRlZCBmcm9tIGFuIGV4aXN0aW5nIFBp
bk11eCBBcHAuIFRoYXQgb3V0cHV0DQppcyB1c2VkIGJ5IFZ4V29ya3MgYXMgd2VsbCBhcyBvdXIg
b3V0LW9mLXRyZWUgTGludXggcG9ydC4gSWYgdGhhdCBpcyBub3QgYQ0KZ29vZCBlbm91Z2ggcmVh
c29uIHRvIGFkZCBuZXcgcHJvcGVydGllcywgdGhlbiBJIGNhbid0IHNlZSBhbnkgdGVjaG5pY2Fs
DQpyZWFzb24gbm90IHRvIHVzZSB0aGUgZXhpc3RpbmcgYmluZGluZ3MuDQpUaGUgdXNlIHdpdGgg
YW5vdGhlciBPUyBydW5uaW5nIG9uIGEgZGlmZmVyZW50IGNvcmUgc2hvdWxkIG5vdCBiZSBhIGJh
cnJpZXINCmFzIGl0IG11c3Qgbm90IHVzZSB0aGUgc2FtZSBwaW5zIGFzIExpbnV4Lg0KDQpUaGFu
a3MNClBoaWwNCg0KPiBUaGFua3MNCj4gICBqDQo+IA0KPiA+IFBhdGNoIDAwMDMgc2hvdWxkIHJl
YWxseSBiZSBhcHBsaWVkIGFmdGVyIHBhdGNoOg0KPiA+ICAiQVJNOiBkdHM6IHI5YTA2ZzAzMjog
Q29ycmVjdCBVQVJUIGFuZCBhZGQgYWxsIG90aGVyIFVBUlRzIiwgc2VlDQo+ID4gIGh0dHBzOi8v
d3d3LnNwaW5pY3MubmV0L2xpc3RzL2FybS1rZXJuZWwvbXNnNjczNTI1Lmh0bWwNCj4gPg0KPiA+
IE1haW4gY2hhbmdlczoNCj4gPiB2MjoNCj4gPiAgLSBDaGFuZ2UgdG8gZ2VuZXJpYyByem4xIGZh
bWlseSBkcml2ZXIsIGluc3RlYWQgb2YgZGV2aWNlIHNwZWNpZmljLg0KPiA+ICAtIFJldmlldyBj
b21tZW50cyBmaXhlZC4NCj4gPiAgLSBGaXggZXJyb3IgaGFuZGxpbmcgZHVyaW5nIHByb2JlDQo+
ID4NCj4gPiBQaGlsIEVkd29ydGh5ICgzKToNCj4gPiAgIGR0LWJpbmRpbmdzOiBwaW5jdHJsOiBy
ZW5lc2FzLHJ6bjEtcGluY3RybDogZG9jdW1lbnRhdGlvbg0KPiA+ICAgcGluY3RybDogcmVuZXNh
czogUmVuZXNhcyBSWi9OMSBwaW5jdHJsIGRyaXZlcg0KPiA+ICAgQVJNOiBkdHM6IHI5YTA2ZzAz
MjogQWRkIHBpbmN0cmwgbm9kZQ0KPiA+DQo+ID4gIC4uLi9iaW5kaW5ncy9waW5jdHJsL3JlbmVz
YXMscnpuMS1waW5jdHJsLnR4dCAgICAgIHwgIDk3ICsrKw0KPiA+ICBhcmNoL2FybS9ib290L2R0
cy9yOWEwNmcwMzIuZHRzaSAgICAgICAgICAgICAgICAgICB8ICAgOCArDQo+ID4gIGRyaXZlcnMv
cGluY3RybC9LY29uZmlnICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgIDEwICsNCj4gPiAg
ZHJpdmVycy9waW5jdHJsL01ha2VmaWxlICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgIDEg
Kw0KPiA+ICBkcml2ZXJzL3BpbmN0cmwvcGluY3RybC1yem4xLmMgICAgICAgICAgICAgICAgICAg
ICB8IDg0NCArKysrKysrKysrKysrKysrKysrKysNCj4gPiAgaW5jbHVkZS9kdC1iaW5kaW5ncy9w
aW5jdHJsL3J6bjEtcGluY3RybC5oICAgICAgICAgfCAxOTEgKysrKysNCj4gPiAgNiBmaWxlcyBj
aGFuZ2VkLCAxMTUxIGluc2VydGlvbnMoKykNCj4gPiAgY3JlYXRlIG1vZGUgMTAwNjQ0DQo+IERv
Y3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9waW5jdHJsL3JlbmVzYXMscnpuMS1waW5j
dHJsLnR4dA0KPiA+ICBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9waW5jdHJsL3BpbmN0cmwt
cnpuMS5jDQo+ID4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBpbmNsdWRlL2R0LWJpbmRpbmdzL3BpbmN0
cmwvcnpuMS1waW5jdHJsLmgNCj4gPg0KPiA+IC0tDQo+ID4gMi43LjQNCj4gPg0K
