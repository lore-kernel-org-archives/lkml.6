Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AAE0C004D3
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 06:32:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FFE120824
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 06:32:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="wyaWvRH0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FFE120824
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726949AbeJXO7K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 10:59:10 -0400
Received: from mail-eopbgr730082.outbound.protection.outlook.com ([40.107.73.82]:10784
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726426AbeJXO7K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 10:59:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8GUef2funW2ftKhX6z94FHuja7lnlkTSsgPy834aiS4=;
 b=wyaWvRH0dS+WNha3pgjt15KhJvbN8BwU/EGZAM0ZlGFOIuUMyKb51qV/CQVjV+wHd5d/bc+N3osUbxNGes98S19z9fko8T6BK1pXCP80MuDvpa+PSYqdSU9WytJHTJXs/shgjo7waRQ5330nfGWL00oC/QNBfa4c9rSG0dbA9wQ=
Received: from BYAPR02MB4710.namprd02.prod.outlook.com (52.135.232.23) by
 BYAPR02MB5575.namprd02.prod.outlook.com (20.177.230.85) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.32; Wed, 24 Oct 2018 06:32:21 +0000
Received: from BYAPR02MB4710.namprd02.prod.outlook.com
 ([fe80::8d0d:7d34:1d3:52d]) by BYAPR02MB4710.namprd02.prod.outlook.com
 ([fe80::8d0d:7d34:1d3:52d%4]) with mapi id 15.20.1250.028; Wed, 24 Oct 2018
 06:32:21 +0000
From:   Nava kishore Manne <navam@xilinx.com>
To:     Alan Tull <atull@kernel.org>
CC:     Moritz Fischer <mdf@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michal Simek <michals@xilinx.com>,
        Rajan Vaja <RAJANV@xilinx.com>, Jolly Shah <JOLLYS@xilinx.com>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        kishore m <chinnikishore369@gmail.com>
Subject: RE: [PATCH 0/3] Add Bitstream configuration support for ZynqMP
Thread-Topic: [PATCH 0/3] Add Bitstream configuration support for ZynqMP
Thread-Index: AQHUZ4ioni9EHqcfhkiiVnGyzfDZ0qUrcSQAgAJ8+0A=
Date:   Wed, 24 Oct 2018 06:32:21 +0000
Message-ID: <BYAPR02MB4710AD8C0FD51D14A7A40395C2F60@BYAPR02MB4710.namprd02.prod.outlook.com>
References: <20181020084805.29103-1-nava.manne@xilinx.com>
 <CANk1AXTUu=qiko9_sLrxrNxBmX7p0OXVxNN13p1uBirNh+Ymtw@mail.gmail.com>
In-Reply-To: <CANk1AXTUu=qiko9_sLrxrNxBmX7p0OXVxNN13p1uBirNh+Ymtw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=navam@xilinx.com; 
x-originating-ip: [149.199.50.133]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR02MB5575;6:gWvG8rMrdETGFet+RjsklBJqwJ0r75NA34uppnNAdHxejf9UWLgHbkrHx1GPbJ3PrsblNMzE9vGIDFXf8kzuFFLRiNl9hGM8kLZuvHXuktls0hJ+QOF6BH4komhslIUAkoe30j2PvWFmb8P54E5I6VzKdfv9jUfBknxGBHuxY36ik+Yfhzag0B+3KIFzxmi9FIW49mP4R+HKrN5F/qfUlOPQliJxh102oftJ9TALYbezu1QI1cMCbO3hDUjSC+8fMBKCqxAwnO1Qnh+uiOKiGjdDSX6iRFTyumlSNto68i4iys2v1SlxWHbY2fDc2UIuZpere9NyxsUO5NR4laRhXWilhuK8MtCd1yY48OPG+CxZkgElCRiuZfA8PqELvSUlhfDon9++ZHYkqrOY+w/Z5/Iobi6+f1sLR5YOmlOPmMHDCcIqO4gZN3zv/kSrfaxYlv8aWvXuUqr/IeHMHPyERQ==;5:w/LxBoyP23X1P9ElVH6ispzjXp5v9AjLdClRzTEevMm98BgE/Y012i9ADDQ62+kXEaidXrJrXCmQu+GNYa3u2dEznvwYVqeKb9vPR7yx7g1n1l8jhYVEsat4/oo866Bh5wnUKeXbLj8b9j3FmvRRezW8ozN1w6FGIwgXqpclCPE=;7:nY/DJu9G8S5vy1xX8MUEA0iGHcOqoPYfx4AsX2pO+TFDzbmbLX6f6DSuN1ZM5xv+1X4P8xWqgLGMBPdq1QM2ro4HEyMEAil6yhEdZfHfY7ZSB7BIi6epi8vv6j0dXFEy3Larriqp3I9HOoW+67h4LN2XY5kO8HDmMbtardFGXy2pmqj0qwo/3YSkq87ydznV2J9N7NjpJONhspPZMyK8GBGpt7gfM50wMsJAaOWXH/2txBjgrY6Dyoh0vAYtAieN
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-ms-office365-filtering-correlation-id: 1b06801e-8c47-48b5-25cf-08d6397a741c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:BYAPR02MB5575;
x-ms-traffictypediagnostic: BYAPR02MB5575:
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-microsoft-antispam-prvs: <BYAPR02MB55756AE6CD9916627CA64A32C2F60@BYAPR02MB5575.namprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(258649278758335)(84791874153150)(192813158149592)(180628864354917)(85827821059158);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231355)(944501410)(52105095)(10201501046)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:BYAPR02MB5575;BCL:0;PCL:0;RULEID:;SRVR:BYAPR02MB5575;
x-forefront-prvs: 083526BF8A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(366004)(39860400002)(346002)(136003)(396003)(199004)(189003)(13464003)(51914003)(6436002)(8676002)(186003)(2906002)(26005)(316002)(53936002)(256004)(71200400001)(39060400002)(6916009)(4326008)(14444005)(74316002)(2900100001)(476003)(486006)(11346002)(25786009)(446003)(3846002)(14454004)(6306002)(9686003)(6246003)(478600001)(966005)(81166006)(86362001)(305945005)(5660300001)(33656002)(6116002)(229853002)(7736002)(5250100002)(55016002)(54906003)(8936002)(99286004)(102836004)(71190400001)(106356001)(66066001)(97736004)(81156014)(6506007)(68736007)(105586002)(7696005)(76176011)(53546011);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR02MB5575;H:BYAPR02MB4710.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: c7kI/2YfYfVHXielaMdNhXGOaV3d5tUBkaZ5QRXSWumF8NIIr2RNpL5uE0dk69S1Bgj7B4b7cmBy/hzYPuN00uLhgdyVtP1J6ykRnvEfhBRY7iIgBTSNwhXU5pLOofzjk64+xA3lhecWFIOySwWNR+FFtldcqpBdcjmL7aVx3d5MeOsRTsiPKeSXwVDhzsZx4m2LC3DfBrkAfTuC0d/DvwxkRh+rtVVYUnpVt+MNassEz6TQR6d/MnGnuox9rdlm4aK40c0A/D+oLu4SFuvMgyUqdx7IfFqLG7z4QFtKJfEoFxsJXGKW7JFZU3DQDIwSgD5xAGmCGWRFnjYGvqHuFCAihoh2kWCWd6YEqImpWX0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b06801e-8c47-48b5-25cf-08d6397a741c
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2018 06:32:21.4736
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB5575
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQWxhbiwNCg0KVGhhbmtzIGZvciB0aGUgcmVwbHkuLi4NClBsZWFzZSBmaW5kIG15IHJlc3Bv
bnNlIGlubGluZS4NCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBBbGFu
IFR1bGwgW21haWx0bzphdHVsbEBrZXJuZWwub3JnXQ0KPiBTZW50OiBNb25kYXksIE9jdG9iZXIg
MjIsIDIwMTggOToyOSBQTQ0KPiBUbzogTmF2YSBraXNob3JlIE1hbm5lIDxuYXZhbUB4aWxpbngu
Y29tPg0KPiBDYzogTW9yaXR6IEZpc2NoZXIgPG1kZkBrZXJuZWwub3JnPjsgUm9iIEhlcnJpbmcg
PHJvYmgrZHRAa2VybmVsLm9yZz47DQo+IE1hcmsgUnV0bGFuZCA8bWFyay5ydXRsYW5kQGFybS5j
b20+OyBNaWNoYWwgU2ltZWsgPG1pY2hhbHNAeGlsaW54LmNvbT47DQo+IFJhamFuIFZhamEgPFJB
SkFOVkB4aWxpbnguY29tPjsgSm9sbHkgU2hhaCA8Sk9MTFlTQHhpbGlueC5jb20+OyBsaW51eC0N
Cj4gZnBnYUB2Z2VyLmtlcm5lbC5vcmc7IG9wZW4gbGlzdDpPUEVOIEZJUk1XQVJFIEFORCBGTEFU
VEVORUQgREVWSUNFDQo+IFRSRUUgQklORElOR1MgPGRldmljZXRyZWVAdmdlci5rZXJuZWwub3Jn
PjsgbW9kZXJhdGVkDQo+IGxpc3Q6QVJNL0ZSRUVTQ0FMRSBJTVggLyBNWEMgQVJNIEFSQ0hJVEVD
VFVSRSA8bGludXgtYXJtLQ0KPiBrZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZz47IGxpbnV4LWtl
cm5lbCA8bGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZz47DQo+IGtpc2hvcmUgbSA8Y2hpbm5p
a2lzaG9yZTM2OUBnbWFpbC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMC8zXSBBZGQgQml0
c3RyZWFtIGNvbmZpZ3VyYXRpb24gc3VwcG9ydCBmb3IgWnlucU1QDQo+IA0KPiBPbiBGcmksIE9j
dCAxOSwgMjAxOCBhdCAzOjQ5IEFNIE5hdmEga2lzaG9yZSBNYW5uZQ0KPiA8bmF2YS5tYW5uZUB4
aWxpbnguY29tPiB3cm90ZToNCj4gDQo+IEhpIE5hdmEsDQo+IA0KPiA+DQo+ID4gVGhpcyBzZXJp
ZXMgb2YgcGF0Y2hlcyBhcmUgY3JlYXRlZCBPbiB0b3Agb2YgdGhlIGJlbG93IHJlcG8uDQo+ID4g
Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvYXJtL2FybS1zb2MuZ2l0
DQo+ID4gQlJBTkNIOiBuZXh0L2RyaXZlcnMuDQo+IA0KPiBJSVVDIHRoaXMgaXMgZGVwZW5kZW50
IG9uIHNvbWUgcGF0Y2hlcyB0aGF0IGFyZW4ndCByZWxlYXNlZCB5ZXQuDQo+IFBsZWFzZSBtYWtl
IHRoaXMgZXhwbGljaXQgYnkgc3BlY2lmeWluZyB3aGljaCBwYXRjaGVzIHRoaXMgaXMgZGVwZW5k
ZW50IG9uIGluDQo+IGVhY2ggZnV0dXJlIHN1Ym1pc3Npb24gb2YgbmV3IHZlcnNpb25zLiAgSXQg
d2lsbCBoZWxwIHNvIHRoYXQgSSBkb24ndCBzZW5kIHRoZXNlDQo+IHVwc3RyZWFtIHByZW1hdHVy
ZWx5IGFuZCBpbnRyb2R1Y2UgYnVpbGQgYnJlYWtzLiAgT2YgY291cnNlLCB3ZSBjYW4ga2VlcA0K
PiByZXZpZXdpbmchDQo+IA0KDQpUaGlzIGRyaXZlciBkZXBlbmRzIG9uIHRoZSBiZWxvdyBzZXJp
ZXMgb2YgcGF0Y2hlcw0KaHR0cHM6Ly9sa21sLm9yZy9sa21sLzIwMTgvOS8xMi85ODMgDQpXaGlj
aCBpcyBnb3QgaW50ZWdyYXRlZCBpbnRvIHRoZSBiZWxvdyB1cHN0cmVhbSByZXBvLg0KaHR0cHM6
Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvYXJtL2FybS1zb2MuZ2l0
L3RyZWUvZHJpdmVycy9maXJtd2FyZS94aWxpbng/aD1mb3ItbmV4dCANCkkgaG9wZSBhcm0gbWFp
bnRhaW5lcnMgd2lsbCBzZW5kIHRoZSBwdWxsLXJlcXVlc3QgaW4gc29vbiB0byBpbnRlZ3JhdGUg
dGhlc2UgcGF0Y2hlcyB3aXRoIG1haW4gcmVwby4NCldpbGwgYWRkIHRoZSByZXF1aXJlZCBpbmZv
IGZvciB0aGUgZGVwZW5kZW50IHBhdGNoZXMgaW4gcy1vLWIgc2VjdGlvbiANCg0KUmVnYXJkcywN
Ck5hdmFraXNob3JlLg0K
