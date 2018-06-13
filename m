Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 905B9C004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 06:38:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A618208AF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 06:38:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=renesasgroup.onmicrosoft.com header.i=@renesasgroup.onmicrosoft.com header.b="OfvILWxr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A618208AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934441AbeFMGie (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 02:38:34 -0400
Received: from relmlor3.renesas.com ([210.160.252.173]:21738 "EHLO
        relmlie2.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S933318AbeFMGib (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 02:38:31 -0400
Received: from unknown (HELO relmlir1.idc.renesas.com) ([10.200.68.151])
  by relmlie2.idc.renesas.com with ESMTP; 13 Jun 2018 15:38:29 +0900
Received: from relmlii2.idc.renesas.com (relmlii2.idc.renesas.com [10.200.68.66])
        by relmlir1.idc.renesas.com (Postfix) with ESMTP id 33AA1716FB;
        Wed, 13 Jun 2018 15:38:29 +0900 (JST)
X-IronPort-AV: E=Sophos;i="5.51,217,1526310000"; 
   d="scan'208";a="283867880"
Received: from mail-os2jpn01lp0147.outbound.protection.outlook.com (HELO JPN01-OS2-obe.outbound.protection.outlook.com) ([23.103.139.147])
  by relmlii2.idc.renesas.com with ESMTP/TLS/AES256-SHA256; 13 Jun 2018 15:38:28 +0900
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector1-bp-renesas-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X/jSUj3rHfkzFkidFe5T0hSVowDxc8BF1sLvmREs3Ro=;
 b=OfvILWxrOd3JcJYBXFZzmfVtqh+v6sZMsXhSXMhPj7avBnZjRDVkXobmdIIKm8AO2v9rPFdh4WzKyZza3JabjB5NXNvYO6UIAILC1qsUrXaqNO/kNyYkS9Yln+wWMDSiWEEG6v5+/dLypC76lgQFuQ0cByhxXRFl/ElpxEWetxw=
Received: from OSBPR01MB2054.jpnprd01.prod.outlook.com (52.134.240.151) by
 OSBPR01MB2471.jpnprd01.prod.outlook.com (52.134.251.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.863.6; Wed, 13 Jun 2018 06:38:26 +0000
Received: from OSBPR01MB2054.jpnprd01.prod.outlook.com
 ([fe80::dc58:aaf0:db8b:a5f9]) by OSBPR01MB2054.jpnprd01.prod.outlook.com
 ([fe80::dc58:aaf0:db8b:a5f9%2]) with mapi id 15.20.0820.018; Wed, 13 Jun 2018
 06:38:26 +0000
From:   Michel Pollet <michel.pollet@bp.renesas.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
CC:     Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Simon Horman <horms@verge.net.au>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Michel Pollet <buserror+upstream@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-clk <linux-clk@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v8 2/5] dt-bindings: clock: renesas,r9a06g032-sysctrl:
 documentation
Thread-Topic: [PATCH v8 2/5] dt-bindings: clock: renesas,r9a06g032-sysctrl:
 documentation
Thread-Index: AQHT/KhFbCVqt83aKUmpRh8LmEfn9KRa3MmAgALrJlA=
Date:   Wed, 13 Jun 2018 06:38:25 +0000
Message-ID: <OSBPR01MB2054D7F35A31A8331B906E05D27E0@OSBPR01MB2054.jpnprd01.prod.outlook.com>
References: <1528187462-47093-1-git-send-email-michel.pollet@bp.renesas.com>
 <1528187462-47093-3-git-send-email-michel.pollet@bp.renesas.com>
 <CAMuHMdWoE=+sEUtFdPKk4eBGtOn8f7bUPV-HLAvEETuqgVMeVw@mail.gmail.com>
In-Reply-To: <CAMuHMdWoE=+sEUtFdPKk4eBGtOn8f7bUPV-HLAvEETuqgVMeVw@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=michel.pollet@bp.renesas.com; 
x-originating-ip: [193.141.220.21]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;OSBPR01MB2471;7:bIePZzfjvjKjFLkV/dJDpCS/KwFYXurpyfMNjU4QYA2+PTsM9EPcfMUwGbYbBfVQgO/1PVO6b1FYdLRxGKi2RKKuqHH5y66VUz/4LJDEwrksmYtgdbQrFJkdImf+eMwYaesw8mfEoc13LAuyr9orwgwG3B0S5y25J0xUjsIEK2SSKUetCNB2+0wD63K1x0R1c/UwfaDicXQ1/cK5guGFBuc7q5+wSJBqdLtlrjdib9OTKOLx9orlX3hTgha6s875;20:vr91UD1gEeviWAH6Y0U9d6hvKkY519BArO0Jz5TEVh50XRN4mG0eJUZy6QosLyfab+86J0rGBXBXB4BSFSHlzR+wZZfKRIebGJZP82AG8GZTXm6R0xBmZXueE+Ai3A941SpAzryI0YUxPwL4Mj3enQZ+t+h/2gsbfg8TdnElZWc=
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: ff0d54ad-d5fa-447b-3e12-08d5d0f8446b
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:OSBPR01MB2471;
x-ms-traffictypediagnostic: OSBPR01MB2471:
x-microsoft-antispam-prvs: <OSBPR01MB24712AADC27D4FF1E5FE672ED27E0@OSBPR01MB2471.jpnprd01.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(10201501046)(93006095)(93001095)(3002001)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:OSBPR01MB2471;BCL:0;PCL:0;RULEID:;SRVR:OSBPR01MB2471;
x-forefront-prvs: 07025866F6
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(39380400002)(366004)(346002)(396003)(39860400002)(189003)(199004)(81166006)(7736002)(81156014)(4326008)(2906002)(3660700001)(476003)(68736007)(186003)(229853002)(6916009)(7416002)(3846002)(6116002)(11346002)(3280700002)(446003)(97736004)(74316002)(305945005)(44832011)(5250100002)(66066001)(39060400002)(486006)(8936002)(25786009)(8676002)(6506007)(33656002)(99286004)(9686003)(76176011)(86362001)(55016002)(2900100001)(316002)(105586002)(6436002)(26005)(7696005)(6246003)(14454004)(54906003)(106356001)(53546011)(53936002)(5660300001)(102836004)(478600001)(142933001);DIR:OUT;SFP:1102;SCL:1;SRVR:OSBPR01MB2471;H:OSBPR01MB2054.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:0;
received-spf: None (protection.outlook.com: bp.renesas.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: fLs2dh7+OU/H3mXNulsJ3621JQZIA65kFRPPu8ErVFEDVWnx4bpDAG+kDObyXPs+M0FbsO8X+qZHWqshB0ix9OsJaqLjvBRzxNO3PmRjQtD3srcjFEbC6NMz2hkxRAs9lBoZsYmKT9Kp7ZeoH4+nazknmwSBAMJRXiU4JnjiNt9iVhbrj9ZBQZa1IG3zTGNA
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff0d54ad-d5fa-447b-3e12-08d5d0f8446b
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2018 06:38:25.9263
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB2471
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgR2VlcnQsDQoNCk9uIDExIEp1bmUgMjAxOCAxMTowMSwgR2VlcnQgd3JvdGU6DQo+IEhpIE1p
Y2hlbCwNCj4NCj4gT24gVHVlLCBKdW4gNSwgMjAxOCBhdCAxMDozNiBBTSBNaWNoZWwgUG9sbGV0
DQo+IDxtaWNoZWwucG9sbGV0QGJwLnJlbmVzYXMuY29tPiB3cm90ZToNCj4gPiBUaGUgUmVuZXNh
cyBSOUEwNkcwMzIgU1lTQ1RSTCBub2RlIGRlc2NyaXB0aW9uLg0KPiA+DQo+ID4gU2lnbmVkLW9m
Zi1ieTogTWljaGVsIFBvbGxldCA8bWljaGVsLnBvbGxldEBicC5yZW5lc2FzLmNvbT4NCj4NCj4g
PiAtLS0gL2Rldi9udWxsDQo+ID4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRp
bmdzL2Nsb2NrL3JlbmVzYXMscjlhMDZnMDMyLQ0KPiBzeXNjdHINCj4gPiArKysgbC50eHQNCj4g
PiBAQCAtMCwwICsxLDMyIEBADQo+ID4gKyogUmVuZXNhcyBSOUEwNkcwMzIgU1lTQ1RSTA0KPiA+
ICsNCj4gPiArUmVxdWlyZWQgUHJvcGVydGllczoNCj4gPiArDQo+ID4gKyAgLSBjb21wYXRpYmxl
OiBNdXN0IGJlOg0KPiA+ICsgICAgLSAicmVuZXNhcyxyOWEwNmcwMzItc3lzY3RybCINCj4gPiAr
ICAtIHJlZzogQmFzZSBhZGRyZXNzIGFuZCBsZW5ndGggb2YgdGhlIFNZU0NUUkwgSU8gYmxvY2su
DQo+ID4gKyAgLSAjY2xvY2stY2VsbHM6IE11c3QgYmUgMQ0KPg0KPiAocmVwZWF0aW5nIG15c2Vs
ZikgTm8gY2xvY2tzL2Nsb2NrLW5hbWVzIGZvciB0aGUgZXh0ZXJuYWwgY2xvY2sgaW5wdXRzPw0K
Pg0KPiAiUlovTjEgaGFzIDMgY2xvY2sgc291cmNlcywgMSByZWZlcmVuY2UgY2xvY2sgaW5wdXRz
IGZvciBSR01JSSwgYW5kIDINCj4gcmVmZXJlbmNlIGNsb2NrIG91dHB1dHMgZm9yIFJNSUkvTUlJ
LiINCg0KV2VsbCwgSSdtIHRyeWluZyB0byBrZWVwIHRoZSBiaW5kaW5nIGFzIHNpbXBsZSBhcyBw
b3NzaWJsZSwgdG8gZG9kZ2UgYW55DQpmdXJ0aGVyIGRpc2N1c3Npb24uIEFkZGluZyB0aGVzZSB3
aWxsIGJlIHBvc3NpYmxlIGxhdGVyLCBJIGRvbid0IG5lZWQgdGhlbQ0KZm9yIHRoZSBtb21lbnQg
YW55d2F5Lg0KDQo+DQo+IFRoZSByZXN0IGxvb2tzIGZpbmUgdG8gbWUuDQo+IFRoYW5rcyENCg0K
RGlkIHlvdSBoYXZlIGEgY2hhbmNlIHRvIHJldmlldyB0aGUgY2xvY2sgZHJpdmVyIHByb3Blcj8g
SSdtIHBvbmRlcmluZw0Kc2VuZGluZyBhIHY5IHNpbmNlIGl0J3MgYmVlbiBhIHdlZWsgKHdpdGgg
dmVyeSBtaW5vciBjaGFuZ2VzKSAtLSBidXQgSQ0KZG9uJ3Qgd2FudCB0byBpbnRlcnJ1cHQgaWYg
eW91IHdlcmUgaW4gdGhlIHByb2Nlc3Mgb2YgcmV2aWV3aW5nLi4uDQoNCkNoZWVycywNCk1pY2hl
bA0KDQo+DQo+IEdye29ldGplLGVldGluZ31zLA0KPg0KPiAgICAgICAgICAgICAgICAgICAgICAg
ICBHZWVydA0KPg0KPiAtLQ0KPiBHZWVydCBVeXR0ZXJob2V2ZW4gLS0gVGhlcmUncyBsb3RzIG9m
IExpbnV4IGJleW9uZCBpYTMyIC0tIGdlZXJ0QGxpbnV4LQ0KPiBtNjhrLm9yZw0KPg0KPiBJbiBw
ZXJzb25hbCBjb252ZXJzYXRpb25zIHdpdGggdGVjaG5pY2FsIHBlb3BsZSwgSSBjYWxsIG15c2Vs
ZiBhIGhhY2tlci4gQnV0DQo+IHdoZW4gSSdtIHRhbGtpbmcgdG8gam91cm5hbGlzdHMgSSBqdXN0
IHNheSAicHJvZ3JhbW1lciIgb3Igc29tZXRoaW5nIGxpa2UgdGhhdC4NCj4gICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAtLSBMaW51cyBUb3J2YWxkcw0KDQoNCg0KUmVuZXNhcyBFbGVj
dHJvbmljcyBFdXJvcGUgTHRkLCBEdWtlcyBNZWFkb3csIE1pbGxib2FyZCBSb2FkLCBCb3VybmUg
RW5kLCBCdWNraW5naGFtc2hpcmUsIFNMOCA1RkgsIFVLLiBSZWdpc3RlcmVkIGluIEVuZ2xhbmQg
JiBXYWxlcyB1bmRlciBSZWdpc3RlcmVkIE5vLiAwNDU4NjcwOS4NCg==
