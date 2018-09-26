Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1C8FC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 18:25:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8764A21537
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 18:25:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="m4IqSoR6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8764A21537
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728009AbeI0Ajo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 20:39:44 -0400
Received: from mail-by2nam01on0089.outbound.protection.outlook.com ([104.47.34.89]:45883
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726410AbeI0Ajo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 20:39:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4SXmR7IDhexDq7gUdeGnQaYDGHK5i1Re1ZK9FhkMiVs=;
 b=m4IqSoR67GR8nlBH5Si+F0OTwXOvlzis9vTmaqE6lS0q4fRmT2Klpt47ODE1ytaqrX+xq6HP5p/WVdsRpy4of8/YvvTla0CiHcoorsXChD0ZEI5cKsocjgmWPD2jGab7u0QaeBraYNf45YDWiG/pJ4oYlSpV9/050LLPWEN2LBs=
Received: from CY1PR02MB2138.namprd02.prod.outlook.com (10.166.190.144) by
 CY1PR02MB2044.namprd02.prod.outlook.com (10.166.190.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.25; Wed, 26 Sep 2018 18:25:16 +0000
Received: from CY1PR02MB2138.namprd02.prod.outlook.com
 ([fe80::d401:dced:c223:a99a]) by CY1PR02MB2138.namprd02.prod.outlook.com
 ([fe80::d401:dced:c223:a99a%4]) with mapi id 15.20.1143.022; Wed, 26 Sep 2018
 18:25:14 +0000
From:   Jolly Shah <JOLLYS@xilinx.com>
To:     Olof Johansson <olof@lixom.net>
CC:     Michal Simek <michals@xilinx.com>,
        "arm@kernel.org" <arm@kernel.org>, Rajan Vaja <RAJANV@xilinx.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v12 0/6] drivers: Introduce firmware driver for ZynqMP
 core
Thread-Topic: [PATCH v12 0/6] drivers: Introduce firmware driver for ZynqMP
 core
Thread-Index: AQHUStBI6TetFFdXe0yJGHiWqofw86T5bOTggAR75ICABQ3lAA==
Date:   Wed, 26 Sep 2018 18:25:14 +0000
Message-ID: <CY1PR02MB21385086CCA9A22504657D38B8150@CY1PR02MB2138.namprd02.prod.outlook.com>
References: <1536781120-22794-1-git-send-email-jollys@xilinx.com>
 <CY1PR02MB21385F71D8BC4498654CD0BFB8130@CY1PR02MB2138.namprd02.prod.outlook.com>
 <CAOesGMgUaQMcTQsbLR_qN95QPfOE1gCJuM9=6AiFLg+_t98qaw@mail.gmail.com>
In-Reply-To: <CAOesGMgUaQMcTQsbLR_qN95QPfOE1gCJuM9=6AiFLg+_t98qaw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
x-originating-ip: [149.199.62.133]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY1PR02MB2044;6:MpB66AyAKu8ihlWioWB4tir4ZTImI1WGjmg4iOOAPNNgEkfImzCuIryfbz2Xav8ZFhu0Z6rhEXfTQhtwr31iO/wqPRGKeB1U7K984Vbsf2g4vRw5tUS7WZfimGTbHZ1/L37O298GPvwZz+eMVhfj0IVR5TKV+Rj8q5SER31djZAt3An7y7DPWEFhUQMbD54i4ogOfgSU/PUT5MT8Hol9IFxu0EYlQ0jHm5o/1bTwXmcIwlVg3iSUSY5Qj4LpXe43nq4wgJgJ3RLkRFmddvYSeBmtueCZpczKCY+3quicXeEc/qJ+lMaJ8vrRFEtuSgIHL9iX41mS4XKXX5B0w9DHd6NMWuKweHaUvPRVDOlTbPKv2zXCOBnlfyj9DkrsNN/iKSU1AfbxFyPczdcs8tpMB3PIhKLJw6zF1mq/Qh2jzHsEHMgOnPS7fpUfih9nV1BH4oU11nv6Etgj2f/8R9/54g==;5:krB6K5SLb4YRMDRvh1Ij4bfWjkUVtYMSiUnBrOAqhLBB3E23gDhkb8UXMPO5DabLMQ8GIfoozp7A2AGKUCdVocnBuKohC/G20k+gpYGGp26m2ss16An5rTqKCxjWS7P331Sx2J7T7tc5ozsqMwBHTF9RgMXyL9sDP2hdn/4UP5E=;7:d8EpiLdIqUC2eS4u11O1X7acwLtsLBPLZ8IYzowvJzhfiQmtRwEVdBcvrubGRK9BQ97yyKBs8I0uYyKbodGm1HuxxuwJNILXSMycSdXgOmCS1vNyJzUFlIuiUK0wtaTP+k6qiMFlIs75M1au2T3IbWHcy0WlzDwSpaxKkriNzdBIbakCoApFlhgiT6hLrY8JqD8eAOaF+MboqsRfTSGNcwnOgaQBluGfydNhnyDV1DeiUGSkNSYB9kuh6dv8XvI3
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(396003)(136003)(366004)(39860400002)(346002)(376002)(189003)(199004)(43544003)(51444003)(13464003)(14454004)(53546011)(6506007)(72206003)(486006)(68736007)(54906003)(55016002)(9686003)(3846002)(6116002)(53936002)(229853002)(305945005)(8676002)(7736002)(14444005)(256004)(446003)(102836004)(8936002)(11346002)(476003)(478600001)(7696005)(5250100002)(99286004)(76176011)(186003)(6436002)(6346003)(81166006)(81156014)(74316002)(26005)(5660300001)(106356001)(105586002)(2906002)(97736004)(6246003)(34290500001)(71190400001)(86362001)(71200400001)(6916009)(25786009)(316002)(66066001)(33656002)(4326008)(2900100001);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR02MB2044;H:CY1PR02MB2138.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-office365-filtering-correlation-id: 95bf2758-5ff5-43ee-7bb5-08d623dd6733
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:CY1PR02MB2044;
x-ms-traffictypediagnostic: CY1PR02MB2044:
x-microsoft-antispam-prvs: <CY1PR02MB2044FA2BEDA1D76451E7B613B8150@CY1PR02MB2044.namprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(258649278758335)(9452136761055)(192813158149592);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231355)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123562045)(20161123560045)(201708071742011)(7699051)(76991041);SRVR:CY1PR02MB2044;BCL:0;PCL:0;RULEID:;SRVR:CY1PR02MB2044;
x-forefront-prvs: 08076ABC99
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=JOLLYS@xilinx.com; 
x-microsoft-antispam-message-info: FiNYu8xGu1bz+l88YqmkHOTDhWD+eCPTkw2DruU+C2RV9bLOoyQG33ZOwNsngZWcTejlwfaoDSR8bCPU5aeNF1rQLw4ziU7m6ASp3SyuySzRj2EI86fOwMwPPEnhp5lngNWGdyzZwOPi8Q3MWk7C93OAOxaX8EfFh7MQMY6nAn71BWX2+6Egi8pxt/QdjH3wNtXiv/HPuBS61HerknWQkRE/oB1iGV68U2jM3P2H1b3lk3sd9871waST3bq1ppErylEGrlf7yVOBEsNEdrzLcVg9ZAeYRl5hxCwTivzLYzBtRjilzOvETJepnlOSw1YYMmnAg1rqwuIqloW6c75yrnXZSt4tzVkKqfi4PoO8lgs=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95bf2758-5ff5-43ee-7bb5-08d623dd6733
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2018 18:25:14.5085
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR02MB2044
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgT2xvZiwNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBPbG9mIEpv
aGFuc3NvbiBbbWFpbHRvOm9sb2ZAbGl4b20ubmV0XQ0KPiBTZW50OiBTdW5kYXksIFNlcHRlbWJl
ciAyMywgMjAxOCA2OjEzIEFNDQo+IFRvOiBKb2xseSBTaGFoIDxKT0xMWVNAeGlsaW54LmNvbT4N
Cj4gQ2M6IE1pY2hhbCBTaW1layA8bWljaGFsc0B4aWxpbnguY29tPjsgYXJtQGtlcm5lbC5vcmc7
IFJhamFuIFZhamENCj4gPFJBSkFOVkB4aWxpbnguY29tPjsgbGludXgtYXJtLWtlcm5lbEBsaXN0
cy5pbmZyYWRlYWQub3JnOyBsaW51eC0NCj4ga2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiBTdWJq
ZWN0OiBSZTogW1BBVENIIHYxMiAwLzZdIGRyaXZlcnM6IEludHJvZHVjZSBmaXJtd2FyZSBkcml2
ZXIgZm9yIFp5bnFNUCBjb3JlDQo+IA0KPiBPbiBUaHUsIFNlcCAyMCwgMjAxOCBhdCA1OjQ2IFBN
LCBKb2xseSBTaGFoIDxKT0xMWVNAeGlsaW54LmNvbT4gd3JvdGU6DQo+ID4gSGkgT2xvZiwNCj4g
Pg0KPiA+IEFzIHN1Z2dlc3RlZCwgdGhpcyBwYXRjaHNldCBpcyBnZW5lcmF0ZWQgd2l0aG91dCBp
b2N0bCBpbnRlcmZhY2UuIFBsZWFzZSByZXZpZXcuDQo+IElmIHlvdSBhcmUgb2ssIE1pY2hhbCBj
YW4gY3JlYXRlIGEgcHVsbCByZXF1ZXN0IGZvciBtZXJnZS4NCj4gDQo+IEhpLA0KPiANCj4gSSBy
ZXBsaWVkIG9uIHRoZSBvdGhlciB0aHJlYWQgYXMgd2VsbDsgaXQgc291bmRzIGxpa2UgeW91IHdp
bGwgbmVlZCBzb21ldGhpbmcNCj4gX2xpa2VfIHRoZSBpb2N0bCBpbnRlcmZhY2UgZm9yIHNvbWUg
b2YgdGhlIGRlcGVuZGVudCBkcml2ZXJzLiBGb3IgdGhvc2UsIHdvdWxkIGl0DQo+IGJlIHBvc3Np
YmxlIHRvIG9ubHkgZXhwb3NlIHNvbWUgb2YgdGhlIGlvY3RscyB0aHJvdWdoIHRoZSBpbnRlcmZh
Y2UsIGFuZCBub3QganVzdA0KPiBwYXNzIHRocm91Z2ggYW55IGNhbGw/IEkgdGhpbmsgdGhhdCdk
IHByb2JhYmx5IHRha2UgY2FyZSBvZiBteSBjb25jZXJuLg0KPiANCg0KSSBoYXZlIHB1c2hlZCBj
bG9jayBkcml2ZXIgcGF0Y2ggc2V0IGluY2x1ZGluZyBpb2N0bCBjaGFuZ2VzLiBQbGVhc2UgcmV2
aWV3IGFuZCBsZXQgbWUga25vdyBpZiBhbnkgY2hhbmdlcyBhcmUgcmVxdWlyZWQuDQoNClRoYW5r
cywNCkpvbGx5IFNoYWgNCg0KDQo+IEJ1dCB5ZWFoLCBnbyBhaGVhZCBhbmQgc3RhZ2UgdGhlc2Ug
aW4gYSBwdWxsIHJlcXVlc3QgZm9yIG5vdywgdGhhdCB3YXkgd2UgY2FuDQo+IHRha2UgY2FyZSBv
ZiB0aGVzZSBhbmQgbWVyZ2UgdGhlbSBhcyB0aGUgcmVzdCBhcmUgZ2V0dGluZyByZWFkeS4gSSBk
b24ndCB3YW50IHRvDQo+IGhvbGQgeW91IHVwIG1vcmUgdGhhbiBuZWVkZWQ7IHRoZSBwYXRjaCBz
ZXQgaXMgYWxyZWFkeSB1cCB0byBhIHZlcnkgaGlnaCB2ZXJzaW9uDQo+IG51bWJlciBhbmQgaXQn
cyBub3QgZmFpciB0byBtYWtlIHlvdSByZXdvcmsgaXQgY29tcGxldGVseSB5ZXQgYWdhaW4uDQo+
IA0KPiANCj4gDQo+IC1PbG9mDQo=
