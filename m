Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22E7EC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 09:54:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B567C2086E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 09:54:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=renesasgroup.onmicrosoft.com header.i=@renesasgroup.onmicrosoft.com header.b="g9PwdOEP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B567C2086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728193AbeIJOrs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 10:47:48 -0400
Received: from relmlor4.renesas.com ([210.160.252.174]:55937 "EHLO
        relmlie3.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727353AbeIJOrs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 10:47:48 -0400
Received: from unknown (HELO relmlir4.idc.renesas.com) ([10.200.68.154])
  by relmlie3.idc.renesas.com with ESMTP; 10 Sep 2018 18:54:32 +0900
Received: from relmlii2.idc.renesas.com (relmlii2.idc.renesas.com [10.200.68.66])
        by relmlir4.idc.renesas.com (Postfix) with ESMTP id 0CE207FE2A;
        Mon, 10 Sep 2018 18:54:32 +0900 (JST)
X-IronPort-AV: E=Sophos;i="5.53,355,1531753200"; 
   d="scan'208";a="292071079"
Received: from mail-os2jpn01lp0152.outbound.protection.outlook.com (HELO JPN01-OS2-obe.outbound.protection.outlook.com) ([23.103.139.152])
  by relmlii2.idc.renesas.com with ESMTP/TLS/AES256-SHA256; 10 Sep 2018 18:54:31 +0900
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector1-bp-renesas-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5ibf1JwIg6GLT8/cGcpDIc0FaYVkfVH4cqaIRLS5s+Q=;
 b=g9PwdOEPIX5l/5kOL3qTwkP938ZhgI0ob8b2LuDuKmIS9SDRo80mo6ydYfYYUdNOF46hjVq1RBwmxi3nENxO2lF8ppqdK+wNd54B5J/IUT41//2HIq7Xx32RbsxfffdcnLC+I5DyV9ZPzfJzKgQ6/hLSMFumJcgKbLFtklgjNOc=
Received: from TY1PR01MB1770.jpnprd01.prod.outlook.com (52.133.163.147) by
 TY1PR01MB1200.jpnprd01.prod.outlook.com (10.174.226.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.17; Mon, 10 Sep 2018 09:54:27 +0000
Received: from TY1PR01MB1770.jpnprd01.prod.outlook.com
 ([fe80::e95a:26ea:3713:333a]) by TY1PR01MB1770.jpnprd01.prod.outlook.com
 ([fe80::e95a:26ea:3713:333a%4]) with mapi id 15.20.1122.018; Mon, 10 Sep 2018
 09:54:27 +0000
From:   Fabrizio Castro <fabrizio.castro@bp.renesas.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
CC:     Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        "David S. Miller" <davem@davemloft.net>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Simon Horman <horms@verge.net.au>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 3/3] dt-bindings: can: rcar_can: Add r8a774a1 support
Thread-Topic: [PATCH 3/3] dt-bindings: can: rcar_can: Add r8a774a1 support
Thread-Index: AQHUOuJYhP3ID7Y7XEqKHJjJBXyAzqTTkIqAgBXP7hA=
Date:   Mon, 10 Sep 2018 09:54:27 +0000
Message-ID: <TY1PR01MB1770FB578F15731898CD6770C0050@TY1PR01MB1770.jpnprd01.prod.outlook.com>
References: <1535029653-7418-1-git-send-email-fabrizio.castro@bp.renesas.com>
 <1535029653-7418-4-git-send-email-fabrizio.castro@bp.renesas.com>
 <CAMuHMdWPuqfXOgh_-qp8q6wATU3Lj_WpX0bAOxPBX76SKvyXCQ@mail.gmail.com>
In-Reply-To: <CAMuHMdWPuqfXOgh_-qp8q6wATU3Lj_WpX0bAOxPBX76SKvyXCQ@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=fabrizio.castro@bp.renesas.com; 
x-originating-ip: [193.141.220.21]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;TY1PR01MB1200;20:4gNYmIH64bwwkeH2mLp1vbm2pxDdQPUi6DpsthtsM+rZy9GRyWyUGEa4xZl70QTlSsiuCl+gFMbspVn8cFxSHULwYmAUD1hSonBjsHgu/Qh0Ix7F8lWtDAME1kvVx8T7zcrZ9frxioDLLR+a9+w7dIj6pqiVT5pd6ZvFMWPV6zw=
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-ms-office365-filtering-correlation-id: 4bb0875e-c57d-4fbf-7194-08d61703659f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:TY1PR01MB1200;
x-ms-traffictypediagnostic: TY1PR01MB1200:
x-microsoft-antispam-prvs: <TY1PR01MB120030395DCC2FFDCA95F959C0050@TY1PR01MB1200.jpnprd01.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(823301075)(93006095)(93001095)(3231311)(944501410)(52105095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699050);SRVR:TY1PR01MB1200;BCL:0;PCL:0;RULEID:;SRVR:TY1PR01MB1200;
x-forefront-prvs: 07915F544A
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(136003)(346002)(366004)(39860400002)(396003)(199004)(189003)(345774005)(476003)(74316002)(6436002)(446003)(55016002)(186003)(486006)(66066001)(7736002)(99286004)(14454004)(256004)(54906003)(7416002)(6246003)(2906002)(11346002)(316002)(76176011)(44832011)(86362001)(3846002)(6116002)(7696005)(68736007)(5250100002)(5660300001)(26005)(97736004)(8676002)(81166006)(478600001)(25786009)(6916009)(8936002)(33656002)(305945005)(81156014)(4326008)(229853002)(105586002)(9686003)(106356001)(53936002)(2900100001)(102836004)(6506007);DIR:OUT;SFP:1102;SCL:1;SRVR:TY1PR01MB1200;H:TY1PR01MB1770.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:0;MX:1;
received-spf: None (protection.outlook.com: bp.renesas.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: TsmYsZR11oNEAeNPZ4poAvg3C3ab/5+7M2XSH4OX0g52XYEjdQCNRfOzeTfIGCfgueux4CUPpV14vPrsbPzAfRwuPrmz0MjtKYEtsPJQljJHBin3qdNkNgXM/dV8Ml6F+RYoV7JZTf30LfR5MsjS8Gc1F+oL4/kZRuccnxCXPO0Z+wOjBlXWAQ9Hr9Lk3drNpJYQ27VnnXghyodZbm2ea7/0nKVxSjQDppjiwo/zfAsR0LlFvaWMdAk3Fedlq/B/hGA6d5cLZfrRRbrR6hKGqa/iOhpC/Jebbi0pkV/LXsgBmeIbod5hNNr6JTkzr7dO5Ds51ckb0rLHxJ/Tn+zqcbjy5koK9H9BVOEqdZZpW9E=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bb0875e-c57d-4fbf-7194-08d61703659f
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Sep 2018 09:54:27.4160
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PR01MB1200
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGVsbG8gR2VlcnQsDQoNClRoYW5rIHlvdSBmb3IgeW91ciBmZWVkYmFjay4NCg0KPiBTdWJqZWN0
OiBSZTogW1BBVENIIDMvM10gZHQtYmluZGluZ3M6IGNhbjogcmNhcl9jYW46IEFkZCByOGE3NzRh
MSBzdXBwb3J0DQo+DQo+IEhpIEZhYnJpemlvLA0KPg0KPiBPbiBUaHUsIEF1ZyAyMywgMjAxOCBh
dCAzOjA4IFBNIEZhYnJpemlvIENhc3Rybw0KPiA8ZmFicml6aW8uY2FzdHJvQGJwLnJlbmVzYXMu
Y29tPiB3cm90ZTo+DQo+ID4gRG9jdW1lbnQgUlovRzJNIChyOGE3NzRhMSkgU29DIHNwZWNpZmlj
IGJpbmRpbmdzIGFuZCBSWi9HMg0KPiA+IGdlbmVyaWMgYmluZGluZ3MuDQo+ID4NCj4gPiBTaWdu
ZWQtb2ZmLWJ5OiBGYWJyaXppbyBDYXN0cm8gPGZhYnJpemlvLmNhc3Ryb0BicC5yZW5lc2FzLmNv
bT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBDaHJpcyBQYXRlcnNvbiA8Q2hyaXMuUGF0ZXJzb24yQHJl
bmVzYXMuY29tPg0KPiA+IFJldmlld2VkLWJ5OiBCaWp1IERhcyA8YmlqdS5kYXNAYnAucmVuZXNh
cy5jb20+DQo+DQo+IFRoYW5rcyBmb3IgeW91ciBwYXRjaCENCj4NCj4gPiAtLS0gYS9Eb2N1bWVu
dGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbmV0L2Nhbi9yY2FyX2Nhbi50eHQNCj4gPiArKysg
Yi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbmV0L2Nhbi9yY2FyX2Nhbi50eHQN
Cj4gPiBAQCAtNCw2ICs0LDcgQEAgUmVuZXNhcyBSLUNhciBDQU4gY29udHJvbGxlciBEZXZpY2Ug
VHJlZSBCaW5kaW5ncw0KPiA+ICBSZXF1aXJlZCBwcm9wZXJ0aWVzOg0KPiA+ICAtIGNvbXBhdGli
bGU6ICJyZW5lc2FzLGNhbi1yOGE3NzQzIiBpZiBDQU4gY29udHJvbGxlciBpcyBhIHBhcnQgb2Yg
UjhBNzc0MyBTb0MuDQo+ID4gICAgICAgICAgICAgICAicmVuZXNhcyxjYW4tcjhhNzc0NSIgaWYg
Q0FOIGNvbnRyb2xsZXIgaXMgYSBwYXJ0IG9mIFI4QTc3NDUgU29DLg0KPiA+ICsgICAgICAgICAg
ICAgInJlbmVzYXMsY2FuLXI4YTc3NGExIiBpZiBDQU4gY29udHJvbGxlciBpcyBhIHBhcnQgb2Yg
UjhBNzc0QTEgU29DLg0KPg0KPiBMb29rcyBnb29kIHRvIG1lLg0KPg0KPiA+ICAgICAgICAgICAg
ICAgInJlbmVzYXMsY2FuLXI4YTc3NzgiIGlmIENBTiBjb250cm9sbGVyIGlzIGEgcGFydCBvZiBS
OEE3Nzc4IFNvQy4NCj4gPiAgICAgICAgICAgICAgICJyZW5lc2FzLGNhbi1yOGE3Nzc5IiBpZiBD
QU4gY29udHJvbGxlciBpcyBhIHBhcnQgb2YgUjhBNzc3OSBTb0MuDQo+ID4gICAgICAgICAgICAg
ICAicmVuZXNhcyxjYW4tcjhhNzc5MCIgaWYgQ0FOIGNvbnRyb2xsZXIgaXMgYSBwYXJ0IG9mIFI4
QTc3OTAgU29DLg0KPiA+IEBAIC0xNyw2ICsxOCw3IEBAIFJlcXVpcmVkIHByb3BlcnRpZXM6DQo+
ID4gICAgICAgICAgICAgICAicmVuZXNhcyxyY2FyLWdlbjItY2FuIiBmb3IgYSBnZW5lcmljIFIt
Q2FyIEdlbjIgb3IgUlovRzENCj4gPiAgICAgICAgICAgICAgIGNvbXBhdGlibGUgZGV2aWNlLg0K
PiA+ICAgICAgICAgICAgICAgInJlbmVzYXMscmNhci1nZW4zLWNhbiIgZm9yIGEgZ2VuZXJpYyBS
LUNhciBHZW4zIGNvbXBhdGlibGUgZGV2aWNlLg0KPiA+ICsgICAgICAgICAgICAgInJlbmVzYXMs
cnpnLWdlbjItY2FuIiBmb3IgYSBnZW5lcmljIFJaL0cyIGNvbXBhdGlibGUgZGV2aWNlLg0KPg0K
PiBBRkFJSywgdGhlIGFjdHVhbCBDQU4gbW9kdWxlIGluIFJaL0cyTSBpcyBmdWxseSBjb21wYXRp
YmxlIHdpdGggdGhlIENBTg0KPiBtb2R1bGUgaW4gUi1DYXIgR2VuMyBTb0NzLiBUaGUgbGFjayBv
ZiBjbGtwMiBpcyBtZXJlbHkgYW4gaW50ZWdyYXRpb24NCj4gZGlmZmVyZW5jZTogYXMgUlovRzIg
U29DcyBkbyBub3QgaGF2ZSB0aGUgQ0FORkQgbW9kdWxlLCBhbmQgdGhlaXIgQ1BHIGJsb2NrDQo+
IGRvZXNuJ3QgcHJvdmlkZSB0aGUgQ0FORkQgY2xvY2sgKHNvIHRoZSBDQU4gZGV2aWNlIG5vZGUg
aW4gRFQgY2Fubm90IHJlZmVyDQo+IHRvIHRoYXQgY2xvY2sgYW55d2F5KS4NCj4NCj4gSGVuY2Ug
SSBkb24ndCB0aGluayB0aGVyZSdzIGEgbmVlZCB0byBpbnRyb2R1Y2UgYSAicmVuZXNhcyxyemct
Z2VuMi1jYW4iDQo+IGNvbXBhdGlibGUgdmFsdWUuDQoNCkFncmVlZCwgd2lsbCBkcm9wIFJaL0cy
IHNwZWNpZmljIGNvbXBhdGlibGUgc3RyaW5nLg0KDQo+DQo+ID4gICAgICAgICAgICAgICBXaGVu
IGNvbXBhdGlibGUgd2l0aCB0aGUgZ2VuZXJpYyB2ZXJzaW9uLCBub2RlcyBtdXN0IGxpc3QgdGhl
DQo+ID4gICAgICAgICAgICAgICBTb0Mtc3BlY2lmaWMgdmVyc2lvbiBjb3JyZXNwb25kaW5nIHRv
IHRoZSBwbGF0Zm9ybSBmaXJzdA0KPiA+ICAgICAgICAgICAgICAgZm9sbG93ZWQgYnkgdGhlIGdl
bmVyaWMgdmVyc2lvbi4NCj4gPiBAQCAtMjQsNyArMjYsOSBAQCBSZXF1aXJlZCBwcm9wZXJ0aWVz
Og0KPiA+ICAtIHJlZzogcGh5c2ljYWwgYmFzZSBhZGRyZXNzIGFuZCBzaXplIG9mIHRoZSBSLUNh
ciBDQU4gcmVnaXN0ZXIgbWFwLg0KPiA+ICAtIGludGVycnVwdHM6IGludGVycnVwdCBzcGVjaWZp
ZXIgZm9yIHRoZSBzb2xlIGludGVycnVwdC4NCj4gPiAgLSBjbG9ja3M6IHBoYW5kbGVzIGFuZCBj
bG9jayBzcGVjaWZpZXJzIGZvciAzIENBTiBjbG9jayBpbnB1dHMuDQo+DQo+IFlvdSBzdGlsbCBo
YXZlICIzIiBoZXJlLiBQZXJoYXBzDQo+ICJNdXN0IGNvbnRhaW4gYSBwaGFuZGxlIGFuZCBjbG9j
ay1zcGVjaWZpZXIgcGFpciBmb3IgZWFjaCBlbnRyeSBpbg0KPiBjbG9jay1uYW1lcy4iPw0KDQpH
b29kIHNwb3QsIHdlIG92ZXJsb29rZWQgaXQuDQoNCj4NCj4gPiAtLSBjbG9jay1uYW1lczogMyBj
bG9jayBpbnB1dCBuYW1lIHN0cmluZ3M6ICJjbGtwMSIsICJjbGtwMiIsICJjYW5fY2xrIi4NCj4g
PiArLSBjbG9jay1uYW1lczogMiBjbG9jayBpbnB1dCBuYW1lIHN0cmluZ3MgZm9yIFJaL0cyOiAi
Y2xrcDEiLCAiY2FuX2NsayIuDQo+ID4gKyAgICAgICAgICAgICAgMyBjbG9jayBpbnB1dCBuYW1l
IHN0cmluZ3MgZm9yIGV2ZXJ5IG90aGVyIFNvQzogImNsa3AxIiwgImNsa3AyIiwNCj4gPiArICAg
ICAgICAgICAgICAiY2FuX2NsayIuDQo+DQo+IE9LLg0KPg0KPiA+IEBAIC00MSw4ICs0NSw5IEBA
IHVzaW5nIHRoZSBiZWxvdyBwcm9wZXJ0aWVzOg0KPiA+ICBPcHRpb25hbCBwcm9wZXJ0aWVzOg0K
PiA+ICAtIHJlbmVzYXMsY2FuLWNsb2NrLXNlbGVjdDogUi1DYXIgQ0FOIENsb2NrIFNvdXJjZSBT
ZWxlY3QuIFZhbGlkIHZhbHVlcyBhcmU6DQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAg
IDwweDA+IChkZWZhdWx0KSA6IFBlcmlwaGVyYWwgY2xvY2sgKGNsa3AxKQ0KPiA+IC0gICAgICAg
ICAgICAgICAgICAgICAgICAgICA8MHgxPiA6IFBlcmlwaGVyYWwgY2xvY2sgKGNsa3AyKQ0KPiA+
IC0gICAgICAgICAgICAgICAgICAgICAgICAgICA8MHgzPiA6IEV4dGVybmFsbHkgaW5wdXQgY2xv
Y2sNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgPDB4MT4gOiBQZXJpcGhlcmFsIGNs
b2NrIChjbGtwMikgKG5vdCBzdXBwb3J0ZWQgYnkNCj4gPiArICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBSWi9HMiBkZXZpY2VzKQ0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAg
ICAgICA8MHgzPiA6IEV4dGVybmFsIGlucHV0IGNsb2NrDQo+DQo+IEkgYWxyZWFkeSBleHByZXNz
ZWQgbXkgZmVlbGluZ3MgYWJvdXQgdGhpcyBwcm9wZXJ0eSBpbiBteSByZXBseSB0byB0aGUgZmly
c3QNCj4gcGF0Y2ggOy0pDQoNCkkga25vdywgSSBhbSBub3Qgc3VwZXIgaGFwcHkgYWJvdXQgaXQg
ZWl0aGVyLCBtYXliZSB3ZSB3aWxsIGdldCBhIHByb3BlciBzb2x1dGlvbiBmb3IgdGhpcyBhdCBz
b21lIHBvaW50IGluIHRoZSBmdXR1cmUuDQoNClRoYW5rcywNCkZhYg0KDQo+DQo+IEdye29ldGpl
LGVldGluZ31zLA0KPg0KPiAgICAgICAgICAgICAgICAgICAgICAgICBHZWVydA0KPg0KPiAtLQ0K
PiBHZWVydCBVeXR0ZXJob2V2ZW4gLS0gVGhlcmUncyBsb3RzIG9mIExpbnV4IGJleW9uZCBpYTMy
IC0tIGdlZXJ0QGxpbnV4LW02OGsub3JnDQo+DQo+IEluIHBlcnNvbmFsIGNvbnZlcnNhdGlvbnMg
d2l0aCB0ZWNobmljYWwgcGVvcGxlLCBJIGNhbGwgbXlzZWxmIGEgaGFja2VyLiBCdXQNCj4gd2hl
biBJJ20gdGFsa2luZyB0byBqb3VybmFsaXN0cyBJIGp1c3Qgc2F5ICJwcm9ncmFtbWVyIiBvciBz
b21ldGhpbmcgbGlrZSB0aGF0Lg0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIC0t
IExpbnVzIFRvcnZhbGRzDQoNCg0KDQpSZW5lc2FzIEVsZWN0cm9uaWNzIEV1cm9wZSBMdGQsIER1
a2VzIE1lYWRvdywgTWlsbGJvYXJkIFJvYWQsIEJvdXJuZSBFbmQsIEJ1Y2tpbmdoYW1zaGlyZSwg
U0w4IDVGSCwgVUsuIFJlZ2lzdGVyZWQgaW4gRW5nbGFuZCAmIFdhbGVzIHVuZGVyIFJlZ2lzdGVy
ZWQgTm8uIDA0NTg2NzA5Lg0K
