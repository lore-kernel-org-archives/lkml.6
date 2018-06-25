Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0998C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 10:05:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65E0524651
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 10:05:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=renesasgroup.onmicrosoft.com header.i=@renesasgroup.onmicrosoft.com header.b="AY8/iD+z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65E0524651
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755126AbeFYKFT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 06:05:19 -0400
Received: from relmlor4.renesas.com ([210.160.252.174]:58808 "EHLO
        relmlie3.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1755050AbeFYKFQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 06:05:16 -0400
Received: from unknown (HELO relmlir2.idc.renesas.com) ([10.200.68.152])
  by relmlie3.idc.renesas.com with ESMTP; 25 Jun 2018 19:05:15 +0900
Received: from relmlii1.idc.renesas.com (relmlii1.idc.renesas.com [10.200.68.65])
        by relmlir2.idc.renesas.com (Postfix) with ESMTP id E5AD07118E;
        Mon, 25 Jun 2018 19:05:14 +0900 (JST)
X-IronPort-AV: E=Sophos;i="5.51,269,1526310000"; 
   d="scan'208";a="283515359"
Received: from mail-ty1jpn01lp0177.outbound.protection.outlook.com (HELO JPN01-TY1-obe.outbound.protection.outlook.com) ([23.103.139.177])
  by relmlii1.idc.renesas.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Jun 2018 19:05:14 +0900
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector1-bp-renesas-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gF3efGHqDuLCHLaB9S2PSk8hZs61raBNpEWnwMtLlOo=;
 b=AY8/iD+zfcwdmZVulwyFS2IiICTK6OCIoGulUDbwttaKpptX2NTNcLP/leswBNbaOpnfGGex+NLJ4Qp2bpaPJlbZI38rNBOk9QH55ecdscaqMZSUAip8NKA8/ZXrCKsi13og5aX9bVzlq7MNRCVDGf6xhcXxblBOYEVpKEAUz4Q=
Received: from TY1PR01MB1770.jpnprd01.prod.outlook.com (52.133.163.147) by
 TY1PR01MB0924.jpnprd01.prod.outlook.com (10.167.157.135) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.884.23; Mon, 25 Jun 2018 10:05:12 +0000
Received: from TY1PR01MB1770.jpnprd01.prod.outlook.com
 ([fe80::2482:7a25:dbf1:cc43]) by TY1PR01MB1770.jpnprd01.prod.outlook.com
 ([fe80::2482:7a25:dbf1:cc43%2]) with mapi id 15.20.0884.023; Mon, 25 Jun 2018
 10:05:12 +0000
From:   Fabrizio Castro <fabrizio.castro@bp.renesas.com>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Wolfram Sang <wsa@the-dreams.de>
CC:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 4.4 16/37] i2c: rcar: rework hw init
Thread-Topic: [PATCH 4.4 16/37] i2c: rcar: rework hw init
Thread-Index: AQHT/O8aj6asVW75SkCSfzTpv2RxIqRmb3kAgApuRJA=
Date:   Mon, 25 Jun 2018 10:05:11 +0000
Message-ID: <TY1PR01MB17705473221A2566FE4B99E7C04A0@TY1PR01MB1770.jpnprd01.prod.outlook.com>
References: <20180605170108.884872354@linuxfoundation.org>
         <20180605170109.859976584@linuxfoundation.org>
 <1529347590.2289.271.camel@codethink.co.uk>
In-Reply-To: <1529347590.2289.271.camel@codethink.co.uk>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=fabrizio.castro@bp.renesas.com; 
x-originating-ip: [193.141.220.21]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;TY1PR01MB0924;7:swDLoSI9r8YLQnIfQBYIWJz5FSs3XvcGFnO49grPpflaYOfXBy/6iMXygG65fTMode7WJZMuvpmvBd5E6mzN/TQbE7QouFFNcm1UgLhJyMHtKiT1TB6jcFYAVEYGmCwMfVTTukdGQoE1Cweqn56KWg+K329ns8Q/1ziG9uGoQMqJ0TPDnaiuVUl5gqFV3Z/Rxh1uBnhyvBqVfiLl81JW8f1uBNQ6OQwnu7ePekWi6Ug4PUBn/V0V7bMS4SNIJ/cP;20:kIt17S9Z4xsHvRePZTrrlclDt84VzR9FadiFf4vRY0Dgjr3C8TekjkpCgI/I3qmRZ3iDPPYJV88lKgeJ5ZoQc//UwrMTzFDIV+XYi81hPWnUjslxmhJPH+ODO7pVnCOEnGJUQuhmMtcmS1Wh7WiNzd/ha359AC/+fLVD+JMo/08=
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-ms-office365-filtering-correlation-id: 8a0766b1-9479-4c06-7119-08d5da8323e5
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600026)(711020)(48565401081)(2017052603328)(7153060)(7193020);SRVR:TY1PR01MB0924;
x-ms-traffictypediagnostic: TY1PR01MB0924:
x-microsoft-antispam-prvs: <TY1PR01MB09241FB02A9945F9A5A963DEC04A0@TY1PR01MB0924.jpnprd01.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123562045)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:TY1PR01MB0924;BCL:0;PCL:0;RULEID:;SRVR:TY1PR01MB0924;
x-forefront-prvs: 0714841678
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(346002)(376002)(39380400002)(366004)(39860400002)(13464003)(199004)(189003)(486006)(446003)(476003)(7736002)(44832011)(11346002)(97736004)(6116002)(6506007)(14454004)(229853002)(74316002)(305945005)(3846002)(3660700001)(99286004)(6436002)(53936002)(316002)(5250100002)(2900100001)(966005)(68736007)(9686003)(6306002)(6246003)(110136005)(54906003)(7696005)(105586002)(66066001)(8936002)(33656002)(478600001)(76176011)(53546011)(5660300001)(8676002)(106356001)(4326008)(3280700002)(102836004)(575784001)(186003)(26005)(81166006)(86362001)(55016002)(25786009)(81156014)(2906002);DIR:OUT;SFP:1102;SCL:1;SRVR:TY1PR01MB0924;H:TY1PR01MB1770.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:0;MX:1;
received-spf: None (protection.outlook.com: bp.renesas.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: RAkmWAR715DkizGDRx/bRE+KdkBIDBGPGSzJD4Z6pRu4hHS0LyKiGSIPaL/yiA/YYJbPTfaHrGrFdCvWlU3PmSBSV6m9XiIexUFpLouWOw/cN3ai/C/X9U7IPr9ui3eAdOIf1KssonFp3NHRe4a3wIr6k/3Gdnbk/aL7cUpEn36gRwJy/sRCoQfhgTUHHpHywixu1i1N+dsNS33tulrxTPodh2Oiynevy/Vtg3Jk6FZYCsLgjC9Mn66AvmBCJcSac+GxpuzLTtMovYUgmkuVuRFrTQNvH/jykK/BJ0bSAxZwBR2l692q88lLrykalzjP53+5xGsz0BpMZPYH4QLJLSxlmy/WsT3MeXOQ86OmuQM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a0766b1-9479-4c06-7119-08d5da8323e5
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2018 10:05:11.8571
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PR01MB0924
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGVsbG8gV29sZnJhbSwNCg0KV2hhdCBkbyB5b3UgdGhpbmsgYWJvdXQgdGhpcz8NCg0KVGhhbmtz
LA0KRmFiDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogc3RhYmxlLW93
bmVyQHZnZXIua2VybmVsLm9yZyBbbWFpbHRvOnN0YWJsZS1vd25lckB2Z2VyLmtlcm5lbC5vcmdd
IE9uIEJlaGFsZiBPZiBCZW4gSHV0Y2hpbmdzDQo+IFNlbnQ6IDE4IEp1bmUgMjAxOCAxOTo0Nw0K
PiBUbzogR3JlZyBLcm9haC1IYXJ0bWFuIDxncmVna2hAbGludXhmb3VuZGF0aW9uLm9yZz47IGxp
bnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gQ2M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc7
IFdvbGZyYW0gU2FuZyA8d3NhK3JlbmVzYXNAc2FuZy1lbmdpbmVlcmluZy5jb20+OyBXb2xmcmFt
IFNhbmcgPHdzYUB0aGUtZHJlYW1zLmRlPjsgRmFicml6aW8NCj4gQ2FzdHJvIDxmYWJyaXppby5j
YXN0cm9AYnAucmVuZXNhcy5jb20+OyBDaHJpcyBQYXRlcnNvbiA8Q2hyaXMuUGF0ZXJzb24yQHJl
bmVzYXMuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIDQuNCAxNi8zN10gaTJjOiByY2FyOiBy
ZXdvcmsgaHcgaW5pdA0KPg0KPiBPbiBUdWUsIDIwMTgtMDYtMDUgYXQgMTk6MDEgKzAyMDAsIEdy
ZWcgS3JvYWgtSGFydG1hbiB3cm90ZToNCj4gPiA0LjQtc3RhYmxlIHJldmlldyBwYXRjaC4gIElm
IGFueW9uZSBoYXMgYW55IG9iamVjdGlvbnMsIHBsZWFzZSBsZXQgbWUga25vdy4NCj4gPg0KPiA+
IC0tLS0tLS0tLS0tLS0tLS0tLQ0KPiA+DQo+ID4gRnJvbTogV29sZnJhbSBTYW5nIDx3c2ErcmVu
ZXNhc0BzYW5nLWVuZ2luZWVyaW5nLmNvbT4NCj4gPg0KPiA+IGNvbW1pdCAyYzc4Y2RjMWMwNjMw
OGE1OWQ2ZWQ0MTQ1Y2RiYTczZmRlZmY4YzBkIHVwc3RyZWFtLg0KPiA+DQo+ID4gV2UgZG9uJ3Qg
bmVlZCB0byBpbml0IEhXIGJlZm9yZSBldmVyeSB0cmFuc2ZlciBzaW5jZSB3ZSBrbm93IHRoZSBI
Vw0KPiA+IHN0YXRlIHRoZW4uIEhXIGluaXQgYXQgcHJvYmUgdGltZSBpcyBlbm91Z2guDQo+DQo+
IFRoaXMgcGFydCBnb3QgcmV2ZXJ0ZWQgdXBzdHJlYW0gYnk6DQo+DQo+IGNvbW1pdCBhZTQ4MWNj
MTM5NjU4ZTg5ZWIzZWE2NzFkZDAwYjY3YmQ4N2YwMWEzDQo+IEF1dGhvcjogV29sZnJhbSBTYW5n
IDx3c2ErcmVuZXNhc0BzYW5nLWVuZ2luZWVyaW5nLmNvbT4NCj4gRGF0ZTogICBUdWUgQXByIDE4
IDIwOjM4OjM1IDIwMTcgKzAyMDANCj4NCj4gICAgIGkyYzogcmNhcjogZml4IHJlc3VtZSBieSBh
bHdheXMgaW5pdGlhbGl6aW5nIHJlZ2lzdGVycyBiZWZvcmUgdHJhbnNmZXINCj4NCj4gc28gbWF5
YmUgdGhhdCBzaG91bGQgZ28gaW50byBzdGFibGUgKDQuNCBhbmQgNC45IGJyYW5jaGVzKSB0b28/
DQo+DQo+IEJlbi4NCj4NCj4gPiBXaGlsZSBoZXJlLCBhZGQgc2V0dGluZyB0aGUNCj4gPiBjbG9j
ayByZWdpc3RlciB3aGljaCBiZWxvbmdzIHRvIGluaXQgSFcuIEFsc28sIHNldCBNREJTIGJpdCBz
aW5jZSBub3QNCj4gPiBzZXR0aW5nIGl0IGlzIHByb2hpYml0ZWQgYWNjb3JkaW5nIHRvIHRoZSBt
YW51YWwuDQo+IFsuLi5dDQo+DQo+IC0tDQo+IEJlbiBIdXRjaGluZ3MsIFNvZnR3YXJlIERldmVs
b3BlciAgICAgICAgICAgICAgICAgICAgICAgICBDb2RldGhpbmsgTHRkDQo+IGh0dHBzOi8vd3d3
LmNvZGV0aGluay5jby51ay8gICAgICAgICAgICAgICAgIERhbGUgSG91c2UsIDM1IERhbGUgU3Ry
ZWV0DQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBNYW5jaGVzdGVyLCBN
MSAySEYsIFVuaXRlZCBLaW5nZG9tDQoNCg0KDQpSZW5lc2FzIEVsZWN0cm9uaWNzIEV1cm9wZSBM
dGQsIER1a2VzIE1lYWRvdywgTWlsbGJvYXJkIFJvYWQsIEJvdXJuZSBFbmQsIEJ1Y2tpbmdoYW1z
aGlyZSwgU0w4IDVGSCwgVUsuIFJlZ2lzdGVyZWQgaW4gRW5nbGFuZCAmIFdhbGVzIHVuZGVyIFJl
Z2lzdGVyZWQgTm8uIDA0NTg2NzA5Lg0K
