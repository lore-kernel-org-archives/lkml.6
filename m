Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BDFDC4646D
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 03:28:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20BD921C2B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 03:28:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="muCPrjr0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20BD921C2B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727685AbeHIFuy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 01:50:54 -0400
Received: from mail-eopbgr70040.outbound.protection.outlook.com ([40.107.7.40]:48544
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727138AbeHIFux (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 01:50:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nDeyqW7BaUD2nB8JYhdTkrmRVE8mO0ebouB2HQ8Ga1A=;
 b=muCPrjr0kzT9qu7KWfKdtXl62/+qjlQE7kTcV9T/ye7ZCg5kJfs/qHHiU4HYg4rO/BNeVsqD/z1kOe/wEVgzafUcVPtk7HOE+j4m/XyNTd3SCxjg4gHGSLfFsDnUDA5Ev0DfL4QAEh7fnGl4uLf+Ly3drgngr/r5CzBhW+ZvHLs=
Received: from AM5PR0401MB2545.eurprd04.prod.outlook.com (10.169.245.8) by
 AM5PR0401MB2562.eurprd04.prod.outlook.com (10.169.245.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1038.19; Thu, 9 Aug 2018 03:28:07 +0000
Received: from AM5PR0401MB2545.eurprd04.prod.outlook.com
 ([fe80::a2:591f:fe8f:7c93]) by AM5PR0401MB2545.eurprd04.prod.outlook.com
 ([fe80::a2:591f:fe8f:7c93%3]) with mapi id 15.20.1038.023; Thu, 9 Aug 2018
 03:28:07 +0000
From:   Bharat Bhushan <bharat.bhushan@nxp.com>
To:     Scott Wood <oss@buserror.net>,
        "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
        "paulus@samba.org" <paulus@samba.org>,
        "mpe@ellerman.id.au" <mpe@ellerman.id.au>,
        "galak@kernel.crashing.org" <galak@kernel.crashing.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "kstewart@linuxfoundation.org" <kstewart@linuxfoundation.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "robh@kernel.org" <robh@kernel.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "tyreld@linux.vnet.ibm.com" <tyreld@linux.vnet.ibm.com>,
        "joe@perches.com" <joe@perches.com>
Subject: RE: [RFC 5/5] powerpc/fsl: Add supported-irq-ranges for P2020
Thread-Topic: [RFC 5/5] powerpc/fsl: Add supported-irq-ranges for P2020
Thread-Index: AQHUJY+OEK4rmRCzmU6sElTr8iVLCqS02/0AgABrfQCAACZCgIAAAdDggADH3YCAAJ7PEA==
Date:   Thu, 9 Aug 2018 03:28:07 +0000
Message-ID: <AM5PR0401MB25458654D6CEFBF2F05FC7709A250@AM5PR0401MB2545.eurprd04.prod.outlook.com>
References: <1532684881-19310-1-git-send-email-Bharat.Bhushan@nxp.com>
         <1532684881-19310-6-git-send-email-Bharat.Bhushan@nxp.com>
         <ab2a113620123cb71364b6ae89328ae2fca49821.camel@buserror.net>
         <AM5PR0401MB254592DC0E917FD292B323BA9A260@AM5PR0401MB2545.eurprd04.prod.outlook.com>
         <aeff83355ee5235cfd6107dba06a5f7957b45c92.camel@buserror.net>
         <AM5PR0401MB2545041D99EEDC3136B201719A260@AM5PR0401MB2545.eurprd04.prod.outlook.com>
 <bef421feea16da2fdab333e63a6828741bd59055.camel@buserror.net>
In-Reply-To: <bef421feea16da2fdab333e63a6828741bd59055.camel@buserror.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=bharat.bhushan@nxp.com; 
x-originating-ip: [14.142.187.166]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM5PR0401MB2562;6:8olhI+p6/XYjVJRRZhRa/M8SShOYjKrsguqq5fjIsb8ivo74P1Jb3JxAmYouOat/zAFPONCaHs/AqW6YTEB8U3NFFLi5gv+S+GMQHs1kB6Aw+iAMr+YqnZf44CEeGIuErWNmbggdb7ye3OZKzdc43koOFrDW+BquEppF9PIeXUE0zqn4fwSbIMZybVL3T9cl7D4v4Se5V0Pf2ue2nA3qV+OtlRZtHjgazF8nZxPOIdpNt7f2z1LFy7E6OkEUdrIkJKvaaEmwP+oqIuQdCRRSMVctnAzt7kziNl7c2kRatJiCid30Ph/yaNRd9GsIDzaddazuk+8SkKRjHIbrZpd+zV0EN+DbcHzkZ/E+NsCFLt6gYJAoCcsSVng6y2HWf+CenNZia8JyPyS/Hn7fhWcjtFfKW6kNZeae2Xv2BmnxAv+jAKT6SkP2s6X9e3hhleC8CW7RkAIhXeyzoVjbz1dh2Q==;5:Ke9QMA4IUi7xoIIn4C82XvDmVuLQmkhxOMQSqtyzDoko6Cr24YEihQyoEMdZq9DbXz54CE38e6J0Qvrqq4DXI24y20e8+a5P43H26hxWWgMKrbwfXuoT4N9FzwYTWYyklU8usPkvJ9YYvrBdHMl/Mbvdyhl1ZyptZQ6D7wciH8E=;7:saG7ozvpI2f7xG8ZTQQCHc8I64b/qX8L4XvHWUiRs7uX5afS4z/Fp+5t6byaV0d4wTpS3pfLv9ycaSLXNAdUHasYdc7ssEW8GY9LMPbf2E2+q7Ic2gvY4V4+AIVDOr9SrsYvwJTqkOU2sNys0jxB2Y4fiJ0pX+uaThlcRkYBZTkzD3P2xdyJZbhiE03d1UIr6W/OoY2DCTJR96uKyF01nJkJE2GPEEqol+Vu5EeYL8c17cc0riyipfNGDnkpBlgR
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 03c329c2-2f5e-4aa3-febb-08d5fda8202b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM5PR0401MB2562;
x-ms-traffictypediagnostic: AM5PR0401MB2562:
x-microsoft-antispam-prvs: <AM5PR0401MB256220892063F92FF6C6036F9A250@AM5PR0401MB2562.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(180628864354917)(9452136761055)(65623756079841)(185117386973197)(104084551191319);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(3231311)(944501410)(52105095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:AM5PR0401MB2562;BCL:0;PCL:0;RULEID:;SRVR:AM5PR0401MB2562;
x-forefront-prvs: 0759F7A50A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(136003)(376002)(396003)(39860400002)(366004)(13464003)(54534003)(189003)(199004)(478600001)(76176011)(14444005)(256004)(305945005)(316002)(14454004)(93886005)(102836004)(186003)(66066001)(26005)(55236004)(53546011)(446003)(7416002)(6506007)(44832011)(86362001)(7696005)(2201001)(74316002)(5660300001)(476003)(5250100002)(11346002)(2501003)(486006)(6436002)(9686003)(229853002)(105586002)(55016002)(2906002)(99286004)(110136005)(81156014)(8676002)(54906003)(68736007)(7736002)(81166006)(97736004)(6246003)(53936002)(3846002)(8936002)(6116002)(106356001)(33656002)(2900100001)(25786009)(4326008)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM5PR0401MB2562;H:AM5PR0401MB2545.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: hBV57nqXaPdGD49VktyXxoqBpUBy6TeycnjZ746lUewq73L8zddOx2rTJsaIJkrAO9k3KR6P02oXWdaLmWbr+OGMR67pSqCdMd+uuGCK8BrdscCf4LqPZriWiBBW6m3gNiFyLOVuHufYHnuvZzCuB3aK7bK2/ObSmHBdfsSQHAjDKgOTNb3X2A2cYNXor6sRDK52MQQu5v/EpB5lWr6vQxosd8Fhw1ejMpL+oMkfaMb5JoaXvFwsvgEJTJlojdG/HcmgxY1EcBoF8ZCDT42WAyxF5mJB+cG8MyTaBVilgy0QVJy4QtC88L2tGnDEMakI4ipO7zCkH1ctagBgP8TWXaa5PFv52lkJ5VOkSdCPEpM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03c329c2-2f5e-4aa3-febb-08d5fda8202b
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2018 03:28:07.6038
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0401MB2562
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogU2NvdHQgV29vZCBbbWFp
bHRvOm9zc0BidXNlcnJvci5uZXRdDQo+IFNlbnQ6IFdlZG5lc2RheSwgQXVndXN0IDgsIDIwMTgg
MTE6MjcgUE0NCj4gVG86IEJoYXJhdCBCaHVzaGFuIDxiaGFyYXQuYmh1c2hhbkBueHAuY29tPjsN
Cj4gYmVuaEBrZXJuZWwuY3Jhc2hpbmcub3JnOyBwYXVsdXNAc2FtYmEub3JnOyBtcGVAZWxsZXJt
YW4uaWQuYXU7DQo+IGdhbGFrQGtlcm5lbC5jcmFzaGluZy5vcmc7IG1hcmsucnV0bGFuZEBhcm0u
Y29tOw0KPiBrc3Rld2FydEBsaW51eGZvdW5kYXRpb24ub3JnOyBncmVna2hAbGludXhmb3VuZGF0
aW9uLm9yZzsNCj4gZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4cHBjLWRldkBsaXN0
cy5vemxhYnMub3JnOyBsaW51eC0NCj4ga2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiBDYzogcm9i
aEBrZXJuZWwub3JnOyBrZWVzY29va0BjaHJvbWl1bS5vcmc7IHR5cmVsZEBsaW51eC52bmV0Lmli
bS5jb207DQo+IGpvZUBwZXJjaGVzLmNvbQ0KPiBTdWJqZWN0OiBSZTogW1JGQyA1LzVdIHBvd2Vy
cGMvZnNsOiBBZGQgc3VwcG9ydGVkLWlycS1yYW5nZXMgZm9yIFAyMDIwDQo+IA0KPiBPbiBXZWQs
IDIwMTgtMDgtMDggYXQgMDY6MjggKzAwMDAsIEJoYXJhdCBCaHVzaGFuIHdyb3RlOg0KPiA+ID4g
LS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPiA+IEZyb206IFNjb3R0IFdvb2QgW21haWx0
bzpvc3NAYnVzZXJyb3IubmV0XQ0KPiA+ID4gU2VudDogV2VkbmVzZGF5LCBBdWd1c3QgOCwgMjAx
OCAxMToyNiBBTQ0KPiA+ID4gVG86IEJoYXJhdCBCaHVzaGFuIDxiaGFyYXQuYmh1c2hhbkBueHAu
Y29tPjsNCj4gPiA+IGJlbmhAa2VybmVsLmNyYXNoaW5nLm9yZzsgcGF1bHVzQHNhbWJhLm9yZzsg
bXBlQGVsbGVybWFuLmlkLmF1Ow0KPiA+ID4gZ2FsYWtAa2VybmVsLmNyYXNoaW5nLm9yZzsgbWFy
ay5ydXRsYW5kQGFybS5jb207DQo+ID4gPiBrc3Rld2FydEBsaW51eGZvdW5kYXRpb24ub3JnOyBn
cmVna2hAbGludXhmb3VuZGF0aW9uLm9yZzsNCj4gPiA+IGRldmljZXRyZWVAdmdlci5rZXJuZWwu
b3JnOyBsaW51eHBwYy1kZXZAbGlzdHMub3psYWJzLm9yZzsgbGludXgtDQo+ID4gPiBrZXJuZWxA
dmdlci5rZXJuZWwub3JnDQo+ID4gPiBDYzogcm9iaEBrZXJuZWwub3JnOyBrZWVzY29va0BjaHJv
bWl1bS5vcmc7DQo+ID4gPiB0eXJlbGRAbGludXgudm5ldC5pYm0uY29tOyBqb2VAcGVyY2hlcy5j
b20NCj4gPiA+IFN1YmplY3Q6IFJlOiBbUkZDIDUvNV0gcG93ZXJwYy9mc2w6IEFkZCBzdXBwb3J0
ZWQtaXJxLXJhbmdlcyBmb3INCj4gPiA+IFAyMDIwDQo+ID4gPg0KPiA+ID4gT24gV2VkLCAyMDE4
LTA4LTA4IGF0IDAzOjQ0ICswMDAwLCBCaGFyYXQgQmh1c2hhbiB3cm90ZToNCj4gPiA+ID4gPiAt
LS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+ID4gPiA+IEZyb206IFNjb3R0IFdvb2QgW21h
aWx0bzpvc3NAYnVzZXJyb3IubmV0XQ0KPiA+ID4gPiA+IFNlbnQ6IFdlZG5lc2RheSwgQXVndXN0
IDgsIDIwMTggMjo0NCBBTQ0KPiA+ID4gPiA+IFRvOiBCaGFyYXQgQmh1c2hhbiA8YmhhcmF0LmJo
dXNoYW5AbnhwLmNvbT47DQo+ID4gPiA+ID4gYmVuaEBrZXJuZWwuY3Jhc2hpbmcub3JnOyBwYXVs
dXNAc2FtYmEub3JnOyBtcGVAZWxsZXJtYW4uaWQuYXU7DQo+ID4gPiA+ID4gZ2FsYWtAa2VybmVs
LmNyYXNoaW5nLm9yZzsgbWFyay5ydXRsYW5kQGFybS5jb207DQo+ID4gPiA+ID4ga3N0ZXdhcnRA
bGludXhmb3VuZGF0aW9uLm9yZzsgZ3JlZ2toQGxpbnV4Zm91bmRhdGlvbi5vcmc7DQo+ID4gPiA+
ID4gZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4cHBjLWRldkBsaXN0cy5vemxhYnMu
b3JnOw0KPiA+ID4gPiA+IGxpbnV4LSBrZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+ID4gPiA+ID4g
Q2M6IHJvYmhAa2VybmVsLm9yZzsga2Vlc2Nvb2tAY2hyb21pdW0ub3JnOw0KPiA+ID4gPiA+IHR5
cmVsZEBsaW51eC52bmV0LmlibS5jb207IGpvZUBwZXJjaGVzLmNvbQ0KPiA+ID4gPiA+IFN1Ympl
Y3Q6IFJlOiBbUkZDIDUvNV0gcG93ZXJwYy9mc2w6IEFkZCBzdXBwb3J0ZWQtaXJxLXJhbmdlcyBm
b3INCj4gPiA+ID4gPiBQMjAyMA0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gT24gRnJpLCAyMDE4LTA3
LTI3IGF0IDE1OjE4ICswNTMwLCBCaGFyYXQgQmh1c2hhbiB3cm90ZToNCj4gPiA+ID4gPiA+IE1Q
SUMgb24gTlhQIChGcmVlc2NhbGUpIFAyMDIwIHN1cHBvcnRzIGZvbGxvd2luZyBpcnENCj4gPiA+
ID4gPiA+IHJhbmdlczoNCj4gPiA+ID4gPiA+ICAgPiAwIC0gMTEgICAgICAoRXh0ZXJuYWwgaW50
ZXJydXB0KQ0KPiA+ID4gPiA+ID4gICA+IDE2IC0gNzkgICAgIChJbnRlcm5hbCBpbnRlcnJ1cHQp
DQo+ID4gPiA+ID4gPiAgID4gMTc2IC0gMTgzICAgKE1lc3NhZ2luZyBpbnRlcnJ1cHQpDQo+ID4g
PiA+ID4gPiAgID4gMjI0IC0gMjMxICAgKFNoYXJlZCBtZXNzYWdlIHNpZ25hbGVkIGludGVycnVw
dCkNCj4gPiA+ID4gPg0KPiA+ID4gPiA+IFdoeSBkb24ndCB5b3UgY29udmVydCB0byB0aGUgNC1j
ZWxsIGludGVycnVwdCBzcGVjaWZpZXJzIHRoYXQNCj4gPiA+ID4gPiBtYWtlIGRlYWxpbmcgd2l0
aCB0aGVzZSByYW5nZXMgbGVzcyBlcnJvci1wcm9uZT8NCj4gPiA+ID4NCj4gPiA+ID4gT2sgLCB3
aWxsIGRvIGlmIHdlIGFncmVlIHRvIGhhdmUgdGhpcyBzZXJpZXMgYXMgcGVyIGNvbW1lbnQgb24N
Cj4gPiA+ID4gb3RoZXIgcGF0Y2guDQo+ID4gPg0KPiA+ID4gSWYgeW91J3JlIGNvbmNlcm5lZCB3
aXRoIGVycm9ycywgdGhpcyB3b3VsZCBiZSBhIGdvb2QgdGhpbmdzIHRvIGRvDQo+ID4gPiByZWdh
cmRsZXNzLg0KPiA+ID4gIEFjdHVhbGx5LCBpdCBzZWVtcyB0aGF0IHAyMDIwc2ktcG9zdC5kdHNp
IGFscmVhZHkgdXNlcyA0LWNlbGwgaW50ZXJydXB0cy4NCj4gPiA+DQo+ID4gPiBXaGF0IGlzIG1v
dGl2YXRpbmcgdGhpcyBwYXRjaHNldD8gIElzIHRoZXJlIHNvbWV0aGluZyB3cm9uZyBpbiB0aGUN
Cj4gPiA+IGV4aXN0aW5nIGR0cyBmaWxlcz8NCj4gPg0KPiA+IFRoZXJlIGlzIG5vIGVycm9yIGlu
IGRldmljZSB0cmVlLiBNYWluIG1vdGl2YXRpb24gaXMgdG8gaW1wcm92ZSBjb2RlDQo+ID4gZm9y
IGZvbGxvd2luZyByZWFzb25zOg0KPiA+ICAgLSBXaGlsZSBjb2RlIHN0dWR5IGl0IHdhcyBmb3Vu
ZCB0aGF0IGlmIGEgcmVzZXJ2ZWQgaXJxLW51bWJlciB1c2VkDQo+ID4gdGhlbiB0aGVyZSBhcmUg
bm8gY2hlY2sgaW4gZHJpdmVyLiBpcnEgd2lsbCBiZSBjb25maWd1cmVkIGFzIGNvcnJlY3QNCj4g
PiBhbmQgaW50ZXJydXB0IHdpbGwgbmV2ZXIgZmlyZS4NCj4gDQo+IEFnYWluLCBhIHdyb25nIGlu
dGVycnVwdCBudW1iZXIgd29uJ3QgZmlyZSwgd2hldGhlciBhbiBpbnRlcnJ1cHQgYnkgdGhhdA0K
PiBudW1iZXIgZXhpc3RzIG9yIG5vdC4gIEkgd291bGRuJ3QgbWluZCBhIHNhbml0eSBjaGVjayBp
biB0aGUgZHJpdmVyIGlmIHRoZQ0KPiBwcm9ncmFtbWluZyBtb2RlbCBtYWRlIGl0IHByb3Blcmx5
IGRpc2NvdmVyYWJsZSwgYnV0IEkgZG9uJ3QgdGhpbmsgaXQncw0KPiB3b3J0aCBtZXNzaW5nIHdp
dGggZGV2aWNlIHRyZWVzIGp1c3QgZm9yIHRoaXMgKGFuZCBldmVuIGxlc3Mgc28gZ2l2ZW4gdGhh
dA0KPiB0aGVyZSBkb24ndCBzZWVtIHRvIGJlIG5ldyBjaGlwcyBjb21pbmcgb3V0IHRoYXQgdGhp
cyB3b3VsZCBiZSByZWxldmFudA0KPiBmb3IpLg0KDQpGYWlyIGVub3VnaCwgd2UgY2FuIHVzZSBN
UElDIHZlcnNpb24gdG8gZGVmaW5lIHN1cHBvcnRlZCBpbnRlcnJ1cHRzIHJhbmdlcy4gV2lsbCB0
aGF0IGJlIGFjY2VwdGFibGUuDQoNClRoYW5rcw0KLUJoYXJhdA0KDQo+IA0KPiA+ID4gPiBPbmUg
b3RoZXIgY29uZnVzaW5nIG9ic2VydmF0aW9uIEkgaGF2ZSBpcyB0aGF0ICJpcnFfY291bnQiIGZy
b20NCj4gPiA+ID4gcGxhdGZvcm0gY29kZSBpcyBnaXZlbiBwcmVjZWRlbmNlIG92ZXIgImxhc3Qt
aW50ZXJydXB0LXNvdXJjZSIgaW4NCj4gPiA+ID4gZGV2aWNlLQ0KPiA+ID4NCj4gPiA+IHRyZWUu
DQo+ID4gPiA+IFNob3VsZCBub3QgZGV2aWNlLXRyZWUgc2hvdWxkIGhhdmUgcHJlY2VkZW5jZSBv
dGhlcndpc2UgdGhlcmUgaXMNCj4gPiA+ID4gbm8gcG9pbnQgdXNpbmcgIiBsYXN0LWludGVycnVw
dC1zb3VyY2UiIGlmIHBsYXRmb3JtIGNvZGUgcGFzc2VzDQo+ID4gPiA+ICJpcnFfY291bnQiIGlu
IG1waWNfYWxsb2MoKS4NCj4gPiA+DQo+ID4gPiBNYXliZSwgdGhvdWdoIEkgZG9uJ3QgdGhpbmsg
aXQgbWF0dGVycyBtdWNoIGdpdmVuIHRoYXQNCj4gPiA+IGxhc3QtaW50ZXJydXB0LSBzb3VyY2Ug
d2FzIG9ubHkgYWRkZWQgdG8gYXZvaWQgaGF2aW5nIHRvIHBhc3MNCj4gPiA+IGlycV9jb3VudCBp
biBwbGF0Zm9ybSBjb2RlLg0KPiA+DQo+ID4gVGhhbmtzIGZvciBjbGFyaWZ5aW5nOw0KPiA+DQo+
ID4gTXkgdW5kZXJzdGFuZGluZyB3YXMgdGhhdCAibGFzdC1pbnRlcnJ1cHQtc291cmNlIiBhZGRl
ZCB0byBlbnN1cmUgdGhhdA0KPiA+IHdlIGNhbiBvdmVyLXJpZGUgdmFsdWUgcGFzc2VkIGZyb20g
cGxhdGZvcm0gY29kZS4gSW4gdGhhdCBjYXNlIHdlIGRvDQo+ID4gbm90IG5lZWQgdG8gY2hhbmdl
IGNvZGUgYW5kIGNhbiBjb250cm9sIGZyb20gZGV2aWNlIHRyZWUuDQo+IA0KPiBUaGUgY2hhbmdl
bG9nIHNheXMsICJUbyBhdm9pZCBuZWVkaW5nIHRvIHdyaXRlIGN1c3RvbSBib2FyZC1zcGVjaWZp
YyBjb2RlDQo+IHRvIGRldGVjdCB0aGF0IHNjZW5hcmlvLCBhbGxvdyBpdCB0byBiZSBlYXNpbHkg
b3ZlcnJpZGRlbiBpbiB0aGUgZGV2aWNlLXRyZWUsIg0KPiB3aGVyZSAiaXQiIG1lYW5zIHRoZSB2
YWx1ZSBwcm92aWRlZCBieSBoYXJkd2FyZS4gIFRoZSBnb2FsIHdhcyB0byBwYXNzIGluDQo+IDI1
NiB3aXRob3V0IGJvYXJkIGNvZGUgaW4gdGhlIGtlcm5lbCwgbm90IHRvIG92ZXJyaWRlIHRoZSAy
NTYuDQo+IA0KPiAtU2NvdHQNCg0K
