Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BD0DC04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 08:28:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD5EC20839
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 08:28:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="BQOgHlML"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD5EC20839
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=toradex.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726693AbeIKN0O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 09:26:14 -0400
Received: from mail-eopbgr30104.outbound.protection.outlook.com ([40.107.3.104]:54444
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726476AbeIKN0O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 09:26:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lc4e6bTWslvrdlcJzQehh8UYvoV0ZYk2zlsLszdUW2k=;
 b=BQOgHlMLp3F0Asnnx9iEJUcu7pId6B7uley1YO3Le+JkJlxaPtDlSQBrHnXMD8MhVU9fs7UATreyOGNKuWmX6Pbmqy0pbqvX0cXC7HpgO03gAsxRJFMVfAnEdUHt7KbQ062OE0n8vvvF5AxwmxZf7IiADG3X6d2ulTormGdLWFk=
Received: from VI1PR0501MB2590.eurprd05.prod.outlook.com (10.168.137.14) by
 VI1PR0501MB2238.eurprd05.prod.outlook.com (10.169.134.149) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.17; Tue, 11 Sep 2018 08:27:52 +0000
Received: from VI1PR0501MB2590.eurprd05.prod.outlook.com
 ([fe80::2952:58bf:2bbb:eb4a]) by VI1PR0501MB2590.eurprd05.prod.outlook.com
 ([fe80::2952:58bf:2bbb:eb4a%3]) with mapi id 15.20.1122.019; Tue, 11 Sep 2018
 08:27:52 +0000
From:   Marcel Ziswiler <marcel.ziswiler@toradex.com>
To:     "jonathanh@nvidia.com" <jonathanh@nvidia.com>,
        "pdeschrijver@nvidia.com" <pdeschrijver@nvidia.com>,
        "digetx@gmail.com" <digetx@gmail.com>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH v1 0/5] CPUFREQ OPP's and Tegra30 support by
 tegra20-cpufreq driver
Thread-Topic: [PATCH v1 0/5] CPUFREQ OPP's and Tegra30 support by
 tegra20-cpufreq driver
Thread-Index: AQHURd4IqlT7eKk1o0uiAc+lOYc9HqTlDHOAgAW6dwA=
Date:   Tue, 11 Sep 2018 08:27:52 +0000
Message-ID: <1536654470.32292.31.camel@toradex.com>
References: <20180830194356.14059-1-digetx@gmail.com>
         <1536237301.25080.22.camel@toradex.com>
         <6c5b6eb4-f809-1a31-acbc-ea27e5cb891b@gmail.com>
In-Reply-To: <6c5b6eb4-f809-1a31-acbc-ea27e5cb891b@gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=marcel.ziswiler@toradex.com; 
x-originating-ip: [89.217.215.226]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR0501MB2238;6:ZXUVhqj/NabN2qk32df+zMYrl9Mj60ye/hOtT1hm0SwmUDHoP4tt6gG2+kznBLM1AfNOijkLarpBng6e9lGxhkq4jPFDMXa1sEuK5qVEp2LOBKbjpmVxZ8dV9Z3rBSED4kMZcr7LDPkGTYrGHj7SANOshaWC41JnvNzPCPMf8YYjnCLlXizNmMguTw2yaPTgxsz3ZsYy8dmpbhcaWGXpXPlHS/KZntBZ/qRvQ5J71DnmkFgwusiSBl4RepPBjTQTnAiYLPUdFiCpnSmHDOXNm8/SJ/0nf0SHHk4C36Lu7kp1+6CKT09SOsxvD6qcZ5qiJRMAI6iELI1LtlAcRQqD0D6v8O4gB5pgm7DBW5NnMXF3Y+/jr/e//DzlvyegqatHg0JoPddV4lyXYJFBIhf/w+yfMOT4OKzTcoPh4odgVYOMaDSVeakzQ7Zc0m8x1s6no3rI2raKi+kd4iLniaVIRw==;5:Eazo/dzUtbvlQfReul+eQ+C2L5kU+hWkR5awz/D0thI6joh9R8HScvo/axUA1qGYYc8re/5j03YGYiLowtir0JaBY8kfA7Sx99BaJ+8t2JI40Y6ojhME5Z/qYVfd6MjOovNjKzRrJldYt1VCLoNAgna96VlIcomjEs7A5Uti3fA=;7:UStnjFc2I+FtCMncXyWsyNcqBPtNNDn5SJnRdtKQgVc9Lo2x83DIyrnlPdOXDOyvaQt3pD1ehyvyyfcxjuFy2mA5dJTrbIKUH1ePEP7/RtPeUmLiY59VzMzc5OmHLQjLhP7WUkk5fiaPne1bx1dtG1QztTN1BFmNWXQryUDKnAWJ/61+HFovT3ZacSMMxiVH2kRYCAAbdsQ/QpBQ5jQRPPvaWQW+QrkG1b7P7STnmEQFH5IgkyR7OThDKjikQwET
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 6100ccf3-a1c6-4816-3848-08d617c07744
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:VI1PR0501MB2238;
x-ms-traffictypediagnostic: VI1PR0501MB2238:
x-microsoft-antispam-prvs: <VI1PR0501MB2238FBF7C792F4C883F80BDAFB040@VI1PR0501MB2238.eurprd05.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(190756311086443)(9452136761055);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231311)(944501410)(52105095)(93006095)(93001095)(149027)(150027)(6041310)(20161123562045)(20161123564045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699050);SRVR:VI1PR0501MB2238;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0501MB2238;
x-forefront-prvs: 0792DBEAD0
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(366004)(396003)(346002)(376002)(39840400004)(189003)(199004)(478600001)(256004)(68736007)(26005)(102836004)(186003)(5660300001)(8936002)(486006)(54906003)(316002)(81156014)(103116003)(81166006)(11346002)(8676002)(44832011)(446003)(110136005)(14454004)(76176011)(2616005)(476003)(105586002)(6506007)(2900100001)(106356001)(99286004)(5250100002)(6486002)(2906002)(229853002)(3846002)(6246003)(97736004)(6512007)(66066001)(6436002)(36756003)(7416002)(2201001)(86362001)(4326008)(7736002)(305945005)(25786009)(53936002)(39060400002)(6116002)(2501003);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0501MB2238;H:VI1PR0501MB2590.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: BZiApcmF66WVrvu91RHEda0zRNYRW2C6KsHhWQLeslYoxGxiKvUWAEXTARUne0v7AzpzA4EYhStXobcnIgYM7MqHsMgD9nUYUnimsXX/qIYMsEHUp17JhF8VCkNir5BHZd4VwAK/iuo+Y1X4GMBv/q7s/rUhz2Atol0Qylt7gCYtEfqPc4B7g8Ki+5upPxeJJ8Oy8Iae4HLrXAKhCyc35Oe2vvwRVvBmdRzIAlIFr8wkx1MlvPtpbDW8HEnASmEJzHKbVguy3IEleJYWJBFsqf3qG5CopzbSzGllY58D5yxP5eMHat78u8DltQ6mHzbC4Q4p+IXORlKpRctpx21nJW18HkSPoSRv8I7LyQmgI2c=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <8AB1C01505CF3F47BFCC056EF1230F0C@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6100ccf3-a1c6-4816-3848-08d617c07744
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2018 08:27:52.0216
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0501MB2238
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDE4LTA5LTA3IGF0IDE5OjU5ICswMzAwLCBEbWl0cnkgT3NpcGVua28gd3JvdGU6
DQoNCi0gc25pcCAtDQoNCj4gPiAtIFdpdGggImNwdWZyZXEtaW5mbyAtZiIgSSBjb3VsZCBvbmx5
IG9ic2VydmUgbGlrZSB0aGUgdG9wIDMtNCBPUFBzDQo+ID4gd2hpbGUgaXQgZG9lcyBub3QgdG8g
Z28gZnVydGhlciBkb3duIGV2ZW4gd2hlbiBpZGxpbmcuIFdoeSBjb3VsZA0KPiA+IHRoYXQNCj4g
PiBiZSByZXNwLiB3aGF0IGNvdWxkIGNhdXNlIHRoaXM/DQo+IA0KPiBXaGF0IGNwdWZyZXEgZ292
ZXJub3IgYXJlIHlvdSB1c2luZz8NCg0Kb25kZW1hbmQNCg0KPiBIZXJlIGlzIG15ICdjcHVmcmVx
LWluZm8gLS1zdGF0cycgb3V0cHV0IGZyb20gVGVncmEzMCBhZnRlciBhIHNldmVyYWwNCj4gbWlu
dXRlcyBvZiBpZGxpbmcgYWZ0ZXIgYm9vdDoNCj4gDQo+IDQwODAwMDoyNDU4ODQsIDQ1NjAwMDo0
NDUsIDYwODAwMDoyNTEsIDc2MDAwMDoxNTEsIDgxNjAwMDo4MiwNCj4gOTEyMDAwOjc1LCAxMDAw
MDAwOjE2MyAgKDU2MSkNCj4gDQo+IEFuZCBmdWxsIGNwdWZyZXEtaW5mbzoNCj4gDQo+IGNwdWZy
ZXF1dGlscyAwMDg6IGNwdWZyZXEtaW5mbyAoQykgRG9taW5payBCcm9kb3dza2kgMjAwNC0yMDA5
DQo+IFJlcG9ydCBlcnJvcnMgYW5kIGJ1Z3MgdG8gY3B1ZnJlcUB2Z2VyLmtlcm5lbC5vcmcsIHBs
ZWFzZS4NCj4gYW5hbHl6aW5nIENQVSAwOg0KPiAgICBkcml2ZXI6IHRlZ3JhDQo+ICAgIENQVXMg
d2hpY2ggcnVuIGF0IHRoZSBzYW1lIGhhcmR3YXJlIGZyZXF1ZW5jeTogMCAxIDIgMw0KPiAgICBD
UFVzIHdoaWNoIG5lZWQgdG8gaGF2ZSB0aGVpciBmcmVxdWVuY3kgY29vcmRpbmF0ZWQgYnkgc29m
dHdhcmU6IDANCj4gMSAyIDMNCj4gICAgbWF4aW11bSB0cmFuc2l0aW9uIGxhdGVuY3k6IDUwLjAg
dXMuDQo+ICAgIGhhcmR3YXJlIGxpbWl0czogNDA4IE1IeiAtIDEwMDAgTUh6DQo+ICAgIGF2YWls
YWJsZSBmcmVxdWVuY3kgc3RlcHM6IDQwOCBNSHosIDQ1NiBNSHosIDYwOCBNSHosIDc2MCBNSHos
IDgxNg0KPiBNSHosIDkxMiBNSHosIDEwMDAgTUh6DQo+ICAgIGF2YWlsYWJsZSBjcHVmcmVxIGdv
dmVybm9yczogY29uc2VydmF0aXZlLCB1c2Vyc3BhY2UsIHBvd2Vyc2F2ZSwNCj4gb25kZW1hbmQs
IHBlcmZvcm1hbmNlLCBzY2hlZHV0aWwNCj4gICAgY3VycmVudCBwb2xpY3k6IGZyZXF1ZW5jeSBz
aG91bGQgYmUgd2l0aGluIDQwOCBNSHogYW5kIDEwMDAgTUh6Lg0KPiAgICAgICAgICAgICAgICAg
ICAgVGhlIGdvdmVybm9yICJvbmRlbWFuZCIgbWF5IGRlY2lkZSB3aGljaCBzcGVlZCB0bw0KPiB1
c2UNCj4gICAgICAgICAgICAgICAgICAgIHdpdGhpbiB0aGlzIHJhbmdlLg0KPiAgICBjdXJyZW50
IENQVSBmcmVxdWVuY3kgaXMgNjA4IE1IeiAoYXNzZXJ0ZWQgYnkgY2FsbCB0byBoYXJkd2FyZSku
DQo+ICAgIGNwdWZyZXEgc3RhdHM6IDQwOCBNSHo6OTkuNTMlLCA0NTYgTUh6OjAuMTglLCA2MDgg
TUh6OjAuMTAlLCA3NjANCj4gTUh6OjAuMDYlLCA4MTYgTUh6OjAuMDMlLCA5MTIgTUh6OjAuMDMl
LCAxMDAwIE1IejowLjA3JSAgKDU2MykNCj4gYW5hbHl6aW5nIENQVSAxOg0KPiAgICBkcml2ZXI6
IHRlZ3JhDQo+ICAgIENQVXMgd2hpY2ggcnVuIGF0IHRoZSBzYW1lIGhhcmR3YXJlIGZyZXF1ZW5j
eTogMCAxIDIgMw0KPiAgICBDUFVzIHdoaWNoIG5lZWQgdG8gaGF2ZSB0aGVpciBmcmVxdWVuY3kg
Y29vcmRpbmF0ZWQgYnkgc29mdHdhcmU6IDANCj4gMSAyIDMNCj4gICAgbWF4aW11bSB0cmFuc2l0
aW9uIGxhdGVuY3k6IDUwLjAgdXMuDQo+ICAgIGhhcmR3YXJlIGxpbWl0czogNDA4IE1IeiAtIDEw
MDAgTUh6DQo+ICAgIGF2YWlsYWJsZSBmcmVxdWVuY3kgc3RlcHM6IDQwOCBNSHosIDQ1NiBNSHos
IDYwOCBNSHosIDc2MCBNSHosIDgxNg0KPiBNSHosIDkxMiBNSHosIDEwMDAgTUh6DQo+ICAgIGF2
YWlsYWJsZSBjcHVmcmVxIGdvdmVybm9yczogY29uc2VydmF0aXZlLCB1c2Vyc3BhY2UsIHBvd2Vy
c2F2ZSwNCj4gb25kZW1hbmQsIHBlcmZvcm1hbmNlLCBzY2hlZHV0aWwNCj4gICAgY3VycmVudCBw
b2xpY3k6IGZyZXF1ZW5jeSBzaG91bGQgYmUgd2l0aGluIDQwOCBNSHogYW5kIDEwMDAgTUh6Lg0K
PiAgICAgICAgICAgICAgICAgICAgVGhlIGdvdmVybm9yICJvbmRlbWFuZCIgbWF5IGRlY2lkZSB3
aGljaCBzcGVlZCB0bw0KPiB1c2UNCj4gICAgICAgICAgICAgICAgICAgIHdpdGhpbiB0aGlzIHJh
bmdlLg0KPiAgICBjdXJyZW50IENQVSBmcmVxdWVuY3kgaXMgNjA4IE1IeiAoYXNzZXJ0ZWQgYnkg
Y2FsbCB0byBoYXJkd2FyZSkuDQo+ICAgIGNwdWZyZXEgc3RhdHM6IDQwOCBNSHo6OTkuNTMlLCA0
NTYgTUh6OjAuMTglLCA2MDggTUh6OjAuMTAlLCA3NjANCj4gTUh6OjAuMDYlLCA4MTYgTUh6OjAu
MDMlLCA5MTIgTUh6OjAuMDMlLCAxMDAwIE1IejowLjA3JSAgKDU2MykNCj4gYW5hbHl6aW5nIENQ
VSAyOg0KPiAgICBkcml2ZXI6IHRlZ3JhDQo+ICAgIENQVXMgd2hpY2ggcnVuIGF0IHRoZSBzYW1l
IGhhcmR3YXJlIGZyZXF1ZW5jeTogMCAxIDIgMw0KPiAgICBDUFVzIHdoaWNoIG5lZWQgdG8gaGF2
ZSB0aGVpciBmcmVxdWVuY3kgY29vcmRpbmF0ZWQgYnkgc29mdHdhcmU6IDANCj4gMSAyIDMNCj4g
ICAgbWF4aW11bSB0cmFuc2l0aW9uIGxhdGVuY3k6IDUwLjAgdXMuDQo+ICAgIGhhcmR3YXJlIGxp
bWl0czogNDA4IE1IeiAtIDEwMDAgTUh6DQo+ICAgIGF2YWlsYWJsZSBmcmVxdWVuY3kgc3RlcHM6
IDQwOCBNSHosIDQ1NiBNSHosIDYwOCBNSHosIDc2MCBNSHosIDgxNg0KPiBNSHosIDkxMiBNSHos
IDEwMDAgTUh6DQo+ICAgIGF2YWlsYWJsZSBjcHVmcmVxIGdvdmVybm9yczogY29uc2VydmF0aXZl
LCB1c2Vyc3BhY2UsIHBvd2Vyc2F2ZSwNCj4gb25kZW1hbmQsIHBlcmZvcm1hbmNlLCBzY2hlZHV0
aWwNCj4gICAgY3VycmVudCBwb2xpY3k6IGZyZXF1ZW5jeSBzaG91bGQgYmUgd2l0aGluIDQwOCBN
SHogYW5kIDEwMDAgTUh6Lg0KPiAgICAgICAgICAgICAgICAgICAgVGhlIGdvdmVybm9yICJvbmRl
bWFuZCIgbWF5IGRlY2lkZSB3aGljaCBzcGVlZCB0bw0KPiB1c2UNCj4gICAgICAgICAgICAgICAg
ICAgIHdpdGhpbiB0aGlzIHJhbmdlLg0KPiAgICBjdXJyZW50IENQVSBmcmVxdWVuY3kgaXMgNjA4
IE1IeiAoYXNzZXJ0ZWQgYnkgY2FsbCB0byBoYXJkd2FyZSkuDQo+ICAgIGNwdWZyZXEgc3RhdHM6
IDQwOCBNSHo6OTkuNTMlLCA0NTYgTUh6OjAuMTglLCA2MDggTUh6OjAuMTAlLCA3NjANCj4gTUh6
OjAuMDYlLCA4MTYgTUh6OjAuMDMlLCA5MTIgTUh6OjAuMDMlLCAxMDAwIE1IejowLjA3JSAgKDU2
MykNCj4gYW5hbHl6aW5nIENQVSAzOg0KPiAgICBkcml2ZXI6IHRlZ3JhDQo+ICAgIENQVXMgd2hp
Y2ggcnVuIGF0IHRoZSBzYW1lIGhhcmR3YXJlIGZyZXF1ZW5jeTogMCAxIDIgMw0KPiAgICBDUFVz
IHdoaWNoIG5lZWQgdG8gaGF2ZSB0aGVpciBmcmVxdWVuY3kgY29vcmRpbmF0ZWQgYnkgc29mdHdh
cmU6IDANCj4gMSAyIDMNCj4gICAgbWF4aW11bSB0cmFuc2l0aW9uIGxhdGVuY3k6IDUwLjAgdXMu
DQo+ICAgIGhhcmR3YXJlIGxpbWl0czogNDA4IE1IeiAtIDEwMDAgTUh6DQo+ICAgIGF2YWlsYWJs
ZSBmcmVxdWVuY3kgc3RlcHM6IDQwOCBNSHosIDQ1NiBNSHosIDYwOCBNSHosIDc2MCBNSHosIDgx
Ng0KPiBNSHosIDkxMiBNSHosIDEwMDAgTUh6DQo+ICAgIGF2YWlsYWJsZSBjcHVmcmVxIGdvdmVy
bm9yczogY29uc2VydmF0aXZlLCB1c2Vyc3BhY2UsIHBvd2Vyc2F2ZSwNCj4gb25kZW1hbmQsIHBl
cmZvcm1hbmNlLCBzY2hlZHV0aWwNCj4gICAgY3VycmVudCBwb2xpY3k6IGZyZXF1ZW5jeSBzaG91
bGQgYmUgd2l0aGluIDQwOCBNSHogYW5kIDEwMDAgTUh6Lg0KPiAgICAgICAgICAgICAgICAgICAg
VGhlIGdvdmVybm9yICJvbmRlbWFuZCIgbWF5IGRlY2lkZSB3aGljaCBzcGVlZCB0bw0KPiB1c2UN
Cj4gICAgICAgICAgICAgICAgICAgIHdpdGhpbiB0aGlzIHJhbmdlLg0KPiAgICBjdXJyZW50IENQ
VSBmcmVxdWVuY3kgaXMgNjA4IE1IeiAoYXNzZXJ0ZWQgYnkgY2FsbCB0byBoYXJkd2FyZSkuDQo+
ICAgIGNwdWZyZXEgc3RhdHM6IDQwOCBNSHo6OTkuNTMlLCA0NTYgTUh6OjAuMTglLCA2MDggTUh6
OjAuMTAlLCA3NjANCj4gTUh6OjAuMDYlLCA4MTYgTUh6OjAuMDMlLCA5MTIgTUh6OjAuMDMlLCAx
MDAwIE1IejowLjA3JSAgKDU2MykNCj4gDQo+IA0KPiA+IC0gVW5mb3J0dW5hdGVseSAiY3B1ZnJl
cS1pbmZvIC0tc3RhdHMiIGN1cnJlbnRseSBkb2VzIG5vdCBzZWVtIHRvDQo+ID4gb3V0cHV0IGFu
eXRoaW5nLiBXb3VsZCB0aGF0IHJlcXVpcmUgc29tZXRoaW5nIHNwZWNpYWwgdG8gYmUNCj4gPiBp
bXBsZW1lbnRlZD8NCj4gDQo+IE1ha2Ugc3VyZSB0aGF0IENPTkZJR19DUFVfRlJFUV9TVEFUIGlz
IGVuYWJsZWQgaW4gdGhlIGtlcm5lbHMgY29uZmlnLg0KDQpZZXMsIHNvcnJ5LiBUaGF0IHdhcyBp
dCwgb2YgY291cnNlLiBKdXN0IHdvbmRlcmluZyB3aHkgdGhhdCBvbmUgaXNuJ3QNCmVuYWJsZWQg
aW4gdGVncmFfZGVmY29uZmlnLi4uDQoNCj4gPiBPdGhlciB0aGFuIHRoYXQgeW91IG1heSBhZGQg
dGhlIGZvbGxvd2luZyB0byB0aGUgd2hvbGUgc2VyaWVzOg0KPiA+IA0KPiA+IFRlc3RlZC1ieTog
TWFyY2VsIFppc3dpbGVyIDxtYXJjZWwuemlzd2lsZXJAdG9yYWRleC5jb20+DQo+IA0KPiBUaGFu
ayB5b3UgdmVyeSBtdWNoIQ0KDQpZb3UgYXJlIHZlcnkgd2VsY29tZS4gVGhhbmsgeW91IQ==
