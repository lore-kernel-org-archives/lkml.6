Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFF8EC43444
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 09:37:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B06F218AD
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 09:37:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="XDFJX1/q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728562AbeLSJhu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 04:37:50 -0500
Received: from mail-eopbgr150053.outbound.protection.outlook.com ([40.107.15.53]:28832
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726537AbeLSJhu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 04:37:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9IUSvE0qyS716YNKgHW+6PUPgrTX2R83XyLw/1JUn9w=;
 b=XDFJX1/qM2ogJCUDrhqTSGWEjkiZ7MRVwoTDOuEijaxqA0X/3cE0bUWooPl4y7YP8Ph5gBAj2FDVZRRmemNslcLb+IbN0AfB8OFZzg0lkB9QM8doeJtyQA6GQRtY6Fg9LPNVK80pUinKb4RpVOt1IHAS+yTGVJ5qq25fBCuw044=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3658.eurprd04.prod.outlook.com (52.134.65.28) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1446.19; Wed, 19 Dec 2018 09:37:44 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::adf8:f49d:deb4:58fd]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::adf8:f49d:deb4:58fd%3]) with mapi id 15.20.1425.023; Wed, 19 Dec 2018
 09:37:44 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
CC:     "a.zummo@towertech.it" <a.zummo@towertech.it>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Andy Gross <andy.gross@linaro.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "horms+renesas@verge.net.au" <horms+renesas@verge.net.au>,
        "heiko@sntech.de" <heiko@sntech.de>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
        "amit.kucheria@linaro.org" <amit.kucheria@linaro.org>,
        "ezequiel@collabora.com" <ezequiel@collabora.com>,
        "olof@lixom.net" <olof@lixom.net>,
        "LW@KARO-electronics.de" <LW@KARO-electronics.de>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH V4 2/4] rtc: add i.MX system controller RTC support
Thread-Topic: [PATCH V4 2/4] rtc: add i.MX system controller RTC support
Thread-Index: AQHUh4XdMkdvaBq+50CIziMq0Y1OP6WF4duAgAALzYA=
Date:   Wed, 19 Dec 2018 09:37:44 +0000
Message-ID: <DB3PR0402MB39167296BD1302130B537FD7F5BE0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1543455856-18021-1-git-send-email-Anson.Huang@nxp.com>
 <1543455856-18021-3-git-send-email-Anson.Huang@nxp.com>
 <20181219085429.GJ19816@piout.net>
In-Reply-To: <20181219085429.GJ19816@piout.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB3PR0402MB3658;6:cxDkzKznBIJdAL/sgbhdnBjjIWq1tHkWHCkn6BQ8/Bf2eKNIe6fiS+pmA2m0l5NTHDhT4MwG141eSIiogxvg4VxkYSfJyn+H5FGODX3zs9sJaQLUcbmL6IkUepCVEa85VIcNIHW2yoLi9Z0o/MggfcBJtINKMfbkb/a6/NCHTH6U2TwlPhPUwBTzrm9IyLFkFfH/oclaqlJoTPT72ez8URBfJhrG3QB1WpA3M2vxT27Jxr6iwsT2uUUsvYxzqhrAy/jClXBi44hLiEBJWvkcbipuGZRM2/0+4Gz1HqcPrS3a4yhq6JUwoFFUmcDXPuIT3y5SrjMmVzCSHv8QJBXoqoac3ai1svJCjFhrEi6g7fM5dhMT8MhxPe5bNsTpZfW14KE13E/xM03ofH63tBD1gcgFDBf6UFxkKXe3O8CGePak2xfVkZMM0cn6qaItoLqQxQMdH+b0VPzz7ztneOZL+w==;5:PErDjRVhqNvK6UdPrXFX2nyDa30j3adCGSzwL5Sc34F9p7dTYlCJOomtfWCHggjGkEA0oxHNfX3uMdmEK8jxUQcwprGo8wXqQRKayPmypEVEdhTVbHaaeYOSwJgwp462t28tvLUKtIG8WaHMGKgjNt3Pc/t3cXdV6I0RMhKys3Q=;7:Y4Khij5h7GatWd2X/tO3wNgBZ8I8LoTI5MRuoyvbS8G4hRr5d1nnBbLAiyVxKQJWYmM3DJxHJFiOoQLIWEStmHKR+xXuKdTgQdPHt/llc6ULDmPho9TidAOTxJ5EQRYKuIzZzECz6Vmf7Fn4ACHSxA==
x-ms-office365-filtering-correlation-id: a84b2ab8-e3e6-4f34-1710-08d66595a11d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3658;
x-ms-traffictypediagnostic: DB3PR0402MB3658:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-antispam-prvs: <DB3PR0402MB3658BF3A5C852F789921EFBAF5BE0@DB3PR0402MB3658.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(999002)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231475)(944501520)(52105112)(3002001)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123558120)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:DB3PR0402MB3658;BCL:0;PCL:0;RULEID:;SRVR:DB3PR0402MB3658;
x-forefront-prvs: 0891BC3F3D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(366004)(396003)(39860400002)(136003)(13464003)(54534003)(199004)(189003)(68736007)(11346002)(446003)(476003)(97736004)(54906003)(186003)(76176011)(7696005)(486006)(5660300001)(86362001)(55016002)(9686003)(71190400001)(7416002)(6116002)(53936002)(6306002)(74316002)(8936002)(26005)(3846002)(6246003)(2906002)(66066001)(4326008)(6436002)(106356001)(81156014)(8676002)(81166006)(305945005)(14454004)(7736002)(71200400001)(105586002)(966005)(6506007)(316002)(25786009)(45080400002)(44832011)(229853002)(53546011)(33656002)(14444005)(256004)(102836004)(6916009)(99286004)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3658;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: dBWdQ0AoRPBU8rJVgoppY6BYCBGHrl/02ZvV0Q1dsbgmLpQgUhmrnOhL3SGJwcYyyByZ5AcKvvmjfbBLqTApdpX+vX3TA/2zekZbFb2YEe/MO4/azcxe+nNH/TWcvmphjdeR0hJd/Hrw0OgT3BFQIjFxlYSvjbWQW9zL7U26QJxzZh6Iz8cH0iyfllDPn32Dh1KgKss7cn3Ujq9qkAOS8z7cwCpz3UOxxD2w+hAWFiqAxgmCySefaPVGzmRyO4W5o7ULAMgNMhS2wQp3Upz8RAoR1yximaWPKUVFfwjmgXUe8TwVfMpEKZsjRawNhOHm
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a84b2ab8-e3e6-4f34-1710-08d66595a11d
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Dec 2018 09:37:44.5833
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3658
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEFsZXhhbmRyZQ0KDQpCZXN0IFJlZ2FyZHMhDQpBbnNvbiBIdWFuZw0KDQo+IC0tLS0tT3Jp
Z2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEFsZXhhbmRyZSBCZWxsb25pIFttYWlsdG86YWxl
eGFuZHJlLmJlbGxvbmlAYm9vdGxpbi5jb21dDQo+IFNlbnQ6IDIwMTjE6jEy1MIxOcjVIDE2OjU0
DQo+IFRvOiBBbnNvbiBIdWFuZyA8YW5zb24uaHVhbmdAbnhwLmNvbT4NCj4gQ2M6IGEuenVtbW9A
dG93ZXJ0ZWNoLml0OyByb2JoK2R0QGtlcm5lbC5vcmc7IG1hcmsucnV0bGFuZEBhcm0uY29tOw0K
PiBjYXRhbGluLm1hcmluYXNAYXJtLmNvbTsgd2lsbC5kZWFjb25AYXJtLmNvbTsgQWlzaGVuZyBE
b25nDQo+IDxhaXNoZW5nLmRvbmdAbnhwLmNvbT47IEFuZHkgR3Jvc3MgPGFuZHkuZ3Jvc3NAbGlu
YXJvLm9yZz47DQo+IGFybmRAYXJuZGIuZGU7IGhvcm1zK3JlbmVzYXNAdmVyZ2UubmV0LmF1OyBo
ZWlrb0BzbnRlY2guZGU7DQo+IGJqb3JuLmFuZGVyc3NvbkBsaW5hcm8ub3JnOyBlbnJpYy5iYWxs
ZXRib0Bjb2xsYWJvcmEuY29tOw0KPiBhbWl0Lmt1Y2hlcmlhQGxpbmFyby5vcmc7IGV6ZXF1aWVs
QGNvbGxhYm9yYS5jb207IG9sb2ZAbGl4b20ubmV0Ow0KPiBMV0BLQVJPLWVsZWN0cm9uaWNzLmRl
OyBzaGF3bmd1b0BrZXJuZWwub3JnOyBsaW51eC1ydGNAdmdlci5rZXJuZWwub3JnOw0KPiBkZXZp
Y2V0cmVlQHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsNCj4g
bGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOyBkbC1saW51eC1pbXggPGxpbnV4
LWlteEBueHAuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIFY0IDIvNF0gcnRjOiBhZGQgaS5N
WCBzeXN0ZW0gY29udHJvbGxlciBSVEMgc3VwcG9ydA0KPiANCj4gSGVsbG8sDQo+IA0KPiBPbiAy
OS8xMS8yMDE4IDAxOjUwOjExKzAwMDAsIEFuc29uIEh1YW5nIHdyb3RlOg0KPiA+IGkuTVg4UVhQ
IGlzIGFuIEFSTXY4IFNvQyB3aGljaCBoYXMgYSBDb3J0ZXgtTTQgc3lzdGVtIGNvbnRyb2xsZXIN
Cj4gPiBpbnNpZGUsIHRoZSBzeXN0ZW0gY29udHJvbGxlciBpcyBpbiBjaGFyZ2Ugb2YgY29udHJv
bGxpbmcgcG93ZXIsIGNsb2NrDQo+ID4gYW5kIHNlY3VyZSBydGMgZXRjLi4NCj4gPg0KPiA+IFRo
aXMgcGF0Y2ggYWRkcyBpLk1YIHN5c3RlbSBjb250cm9sbGVyIFJUQyBkcml2ZXIgc3VwcG9ydCwg
TGludXgNCj4gPiBrZXJuZWwgaGFzIHRvIGNvbW11bmljYXRlIHdpdGggc3lzdGVtIGNvbnRyb2xs
ZXIgdmlhIE1VIChtZXNzYWdlIHVuaXQpDQo+ID4gSVBDIHRvIHNldC9nZXQgUlRDIHRpbWUgYW5k
IG90aGVyIGFsYXJtIGZ1bmN0aW9ucywgc2luY2UgdGhlIFJUQyBzZXQNCj4gPiB0aW1lIG5lZWRz
IHRvIGJlIGRvbmUgaW4gc2VjdXJlIEVMMyBtb2RlIChyZXF1aXJlZCBieSBzeXN0ZW0NCj4gPiBj
b250cm9sbGVyIGZpcm13YXJlKSBhbmQgYWxhcm0gZnVuY3Rpb25zIG5lZWRzIHRvIGJlIGRvbmUg
d2l0aCBnZW5lcmFsDQo+ID4gTVUgSVJRIGhhbmRsZSwgdGhlc2UgZGVwZW5kIG9uIG90aGVyIGNv
bXBvbmVudHMgd2hpY2ggYXJlIE5PVCByZWFkeSwNCj4gPiBzbyB0aGlzIHBhdGNoIE9OTFkgZW5h
YmxlcyB0aGUgUlRDIHRpbWUgcmVhZC4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEFuc29uIEh1
YW5nIDxBbnNvbi5IdWFuZ0BueHAuY29tPg0KPiA+IC0tLQ0KPiA+IENoYW5nZUxvZzoNCj4gPiBW
My0+VjQ6DQo+ID4gICAqcmVtb3ZlIHVubmVjZXNzYXJ5IGhlYWRmaWxlIGluY2x1ZGVkOw0KPiA+
ICAgKmZpeCBwb3RlbnRpYWwgbWVtb3J5IGN1cnJwdXRpb24gZm9yIHRoZSBtZXNzYWdlIHJlc3Bv
bmNlOw0KPiA+ICAgKnVwZGF0ZSB0aGUgY29tcGF0aWJsZSBzdHJpbmcgbmFtZSB0byBzdGFydCB3
aXRoICJmc2wiIGluc3RlYWQgb2YgIm54cCIuDQo+ID4gIGRyaXZlcnMvcnRjL0tjb25maWcgICAg
ICB8ICA2ICsrKw0KPiA+ICBkcml2ZXJzL3J0Yy9NYWtlZmlsZSAgICAgfCAgMSArDQo+ID4gIGRy
aXZlcnMvcnRjL3J0Yy1pbXgtc2MuYyB8IDk4DQo+ID4gKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrDQo+ID4gIDMgZmlsZXMgY2hhbmdlZCwgMTA1IGluc2Vy
dGlvbnMoKykNCj4gPiAgY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvcnRjL3J0Yy1pbXgtc2Mu
Yw0KPiA+DQo+IA0KPiBJIGFwcGxpZWQgaXQgb24gbXkgdGVzdCBicmFuY2ggYW5kIHRoaXMgbWFr
ZXMgc3BhcmM2NC1hbGx5ZXNjb25maWcgZmFpbA0KPiB3aXRoOg0KPiANCj4gICAgZHJpdmVycy9y
dGMvcnRjLWlteC1zYy5vOiBJbiBmdW5jdGlvbiBgaW14X3NjX3J0Y19yZWFkX3RpbWUnOg0KPiAg
ICBydGMtaW14LXNjLmM6KC50ZXh0KzB4MzQpOiB1bmRlZmluZWQgcmVmZXJlbmNlIHRvIGBpbXhf
c2N1X2NhbGxfcnBjJw0KPiAgICBkcml2ZXJzL3J0Yy9ydGMtaW14LXNjLm86IEluIGZ1bmN0aW9u
IGBpbXhfc2NfcnRjX3Byb2JlJzoNCj4gICAgcnRjLWlteC1zYy5jOigudGV4dCsweDkwKTogdW5k
ZWZpbmVkIHJlZmVyZW5jZSB0byBgaW14X3NjdV9nZXRfaGFuZGxlJw0KDQpNYXliZSB0aGVyZSBh
cmUgc29tZSBjaGFuZ2VzIG9uIGJhc2ljIHN1cHBvcnQgb2YgaW14IHNjdSBkcml2ZXIsIEkgd2ls
bCByZXNlbmQNCmEgcGF0Y2ggc2V0IGxhdGVyLCB0aGFua3MuDQoNCkFuc29uLg0KDQo+IA0KPiAN
Cj4gDQo+IC0tDQo+IEFsZXhhbmRyZSBCZWxsb25pLCBCb290bGluDQo+IEVtYmVkZGVkIExpbnV4
IGFuZCBLZXJuZWwgZW5naW5lZXJpbmcNCj4gaHR0cHM6Ly9lbWVhMDEuc2FmZWxpbmtzLnByb3Rl
Y3Rpb24ub3V0bG9vay5jb20vP3VybD1odHRwcyUzQSUyRiUyRmJvb3RsDQo+IGluLmNvbSZhbXA7
ZGF0YT0wMiU3QzAxJTdDYW5zb24uaHVhbmclNDBueHAuY29tJTdDNzJiMTQ3NjQzYTNmDQo+IDQ0
YzI1OGMyMDhkNjY1OGY5Y2NlJTdDNjg2ZWExZDNiYzJiNGM2ZmE5MmNkOTljNWMzMDE2MzUlN0Mw
JTdDMA0KPiAlN0M2MzY4MDgwNjQ4MTg3OTc3MTEmYW1wO3NkYXRhPSUyQmw1akdYWDZ3QlliT2c1
WmFsZzRDeXh5WktqVWUNCj4gdXpSU1FFS085VEpuUkklM0QmYW1wO3Jlc2VydmVkPTANCg==
