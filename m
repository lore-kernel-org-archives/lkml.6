Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64D9CC43444
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 13:53:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16F2821871
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 13:53:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="nl4i8EVf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726769AbeLRNxz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 08:53:55 -0500
Received: from mail-eopbgr130089.outbound.protection.outlook.com ([40.107.13.89]:34014
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726419AbeLRNxy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 08:53:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yjd7yu1JSO9PUZRJGWn8OhpDN5jZ9bs3Ov+i+BJcapk=;
 b=nl4i8EVf6cPEemsdqlKphmt9AD8XXZ4fVMg1D5EO+N/Erf0TWuOkISNgzgAxxGmzP+HaeI7aYLwcn3eKwyzowO88B8W1SPUaCQiEi1cThiq5GK9WmaBA44zG/ZiefR5NXLKN7WAigln2w0gTH5qtPLdfMNPe3HnEigNFARUpbRw=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3675.eurprd04.prod.outlook.com (52.134.69.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.22; Tue, 18 Dec 2018 13:53:49 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::adf8:f49d:deb4:58fd]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::adf8:f49d:deb4:58fd%3]) with mapi id 15.20.1425.023; Tue, 18 Dec 2018
 13:53:49 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Lucas Stach <l.stach@pengutronix.de>
CC:     Fabio Estevam <festevam@gmail.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] clk: imx: add CLK_GET_RATE_NOCACHE flag for i.MX8M
 composite clock
Thread-Topic: [PATCH] clk: imx: add CLK_GET_RATE_NOCACHE flag for i.MX8M
 composite clock
Thread-Index: AQHUln02eAG5Z54Wc0mB2eSSS/znh6WESrGAgAAEigCAADDtEYAAAbEAgAADYNU=
Date:   Tue, 18 Dec 2018 13:53:49 +0000
Message-ID: <25BEFDBA-5A09-42E9-A4E3-AC15EF4B1886@nxp.com>
References: <1545101396-16335-1-git-send-email-Anson.Huang@nxp.com>
         <CAOMZO5BX6PWBp_FmTsMkZJEsKpf+=N6Zyn8P_+ziis-fKR37Ng@mail.gmail.com>
        ,<1545129634.5874.20.camel@pengutronix.de>
         <7E78DD25-BA90-4EBA-81B9-755CD89BD0BF@nxp.com>,<1545140504.5874.25.camel@pengutronix.de>
In-Reply-To: <1545140504.5874.25.camel@pengutronix.de>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [183.192.23.231]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB3PR0402MB3675;6:up344kNqTCkhmQPtb5+9G5fLCFOOsc8oybpBGbLZy3rnGetbCnMthZXNLL28+YfRDCcGKDf/QQmF6Uuixc3youxLjgmKyp4zEhRKemdhlcs80pvIvc78NyYJYgGWSIVlESYQJ8u5Jqo6s5+RYCjydyV+bqce5hTiTXaLkKrM/PyTQi5Ww2rj6OcMsqUpP770P0aRl0lSMuCTZgiKrhT+RrVUbT0x/7+oZQtfK3QNPV1i+d/Uyc5s9K35l8zlpXt50YPDkIuBoCmlTMPcEbaBN9qbzyYGQ3dbVLnxHr7gpiEf76zCyUSyoSPV98mbbNEhT3AJQN6+HKG18gbFDhyUkclw/3xMXqZMfI4ZwXJuUaLAtWz/Zk1tfiLBQUL0LiIi4b1nMLGPfzl85dVAPNbdcLbOfymYYY7yBdAIhCrP0sa5Ux1A2bgELu/wXRIk5RvObwTE5FkuXZlbIy5j4OtQCw==;5:X6hW0K3h/qs+zixiexf39VtSq3vVYOwVbPVhhHG/5kslyuFhCs4Qahqir6EM3Ybc0ELy0wn+Ehm0jcGLGmF81yCkyVZIO/dIMCBiIWpZ7vCTXfxqwNfdxGUZkFBaPx3BdUwH0max0JJg1ALJ8gWbcbhSQs67f3RztthwxPHCAqg=;7:j2G772JwFstdz2HjZjKeSxauXV6eCs12+n3e+ToqR4n8XgtZQAtV2K8ZVM2WDYtVCPR2uxon8+Dlz/3DH9D8IQPi6lYqvSkCsUdGn5yq/eSQcB/KGKKuP8bwY2kFz33CYov6uRe7V1Gt91+J1GtUjw==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 136c7657-738f-41ca-73e1-08d664f03cb7
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3675;
x-ms-traffictypediagnostic: DB3PR0402MB3675:
x-microsoft-antispam-prvs: <DB3PR0402MB3675AC9F73D8802CF8ADD3E9F5BD0@DB3PR0402MB3675.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(999002)(6040522)(2401047)(5005006)(8121501046)(3231475)(944501520)(52105112)(93006095)(93001095)(10201501046)(3002001)(6055026)(148016)(149066)(150057)(6041310)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:DB3PR0402MB3675;BCL:0;PCL:0;RULEID:;SRVR:DB3PR0402MB3675;
x-forefront-prvs: 08902E536D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(136003)(346002)(376002)(39860400002)(366004)(51444003)(199004)(189003)(54906003)(6506007)(39060400002)(5660300001)(33656002)(44832011)(93886005)(102836004)(486006)(53546011)(106356001)(105586002)(8936002)(6436002)(316002)(8676002)(25786009)(2906002)(6486002)(36756003)(3846002)(4326008)(186003)(97736004)(6116002)(82746002)(478600001)(229853002)(6916009)(256004)(81166006)(68736007)(476003)(71190400001)(6246003)(305945005)(53936002)(7736002)(99286004)(7416002)(81156014)(71200400001)(14444005)(11346002)(446003)(2616005)(83716004)(6512007)(26005)(76176011)(66066001)(86362001)(14454004);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3675;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: +AmAcbrD7RngO/vmYHl3nZEGpWE0EEodbKxoDUKpDgfhbNbF+tP+kP5X7xcC7CYciNh5PJxFTm9oL3PnQLX9+r7ZTdfFRYRZ2eannjzRC5nFTkiWxWxjOh3XKbwafyrpPpG3HibnIe8Hj7oDHf2DYsjF4uAZj7Vzy6fY82mKP+rQe1TGnV0xbSnBG0iIdxr+3cr122lpTynpIkWYx50yUTHcKQLGG2ZRaNy4nNOru3cgT9wmyIPSpsMTsLpkydG/v5SnOJQLhLhWftBa01+968dLw5/awhCoaYwBMDk94x0e1UxeObzWQDqtH74/ItvO
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 136c7657-738f-41ca-73e1-08d664f03cb7
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Dec 2018 13:53:49.1997
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3675
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEx1Y2FzDQoNCkZyb20gQW5zb24ncyBpUGhvbmUgNg0KDQoNCj4g5ZyoIDIwMTjlubQxMuac
iDE45pel77yMMjE6NDHvvIxMdWNhcyBTdGFjaCA8bC5zdGFjaEBwZW5ndXRyb25peC5kZT4g5YaZ
6YGT77yaDQo+IA0KPiBIaSBBbnNvbiwNCj4gDQo+IEFtIERpZW5zdGFnLCBkZW4gMTguMTIuMjAx
OCwgMTM6MzUgKzAwMDAgc2NocmllYiBBbnNvbiBIdWFuZzoNCj4+IEhpLCBMdWNhcw0KPj4gDQo+
PiBGcm9tIEFuc29uJ3MgaVBob25lIDYNCj4+IA0KPj4gDQo+Pj4g5ZyoIDIwMTjlubQxMuaciDE4
5pel77yMMTg6NDDvvIxMdWNhcyBTdGFjaCA8bC5zdGFjaEBwZW5ndXRyb25peC5kZT4g5YaZ6YGT
77yaDQo+Pj4gDQo+Pj4gQW0gRGllbnN0YWcsIGRlbiAxOC4xMi4yMDE4LCAwODoyNCAtMDIwMCBz
Y2hyaWViIEZhYmlvIEVzdGV2YW06DQo+Pj4+IEhpIEFuc29uLA0KPj4+PiANCj4+Pj4gT24gVHVl
LCBEZWMgMTgsIDIwMTggYXQgMTI6NTYgQU0gQW5zb24gSHVhbmcgPGFuc29uLmh1YW5nQG54cC5j
b20NCj4+Pj4+IA0KPj4+PiB3cm90ZToNCj4+Pj4+IA0KPj4+Pj4gT24gaS5NWDhNLCBzb21lIG9m
IHRoZSBidXMgY2xvY2tzJyByYXRlIGNvdWxkIGJlIGNoYW5nZWQgaW4gVEYtDQo+Pj4+PiBBLA0K
Pj4+PiANCj4+Pj4gRG8geW91IG1lYW4gQVRGIChBUk0gVHJ1c3RlZCBGaXJtd2FyZSkgaW5zdGVh
ZD8NCj4+PiANCj4+PiBURi1BIGlzIHRoZSBuYW1lIG9mIHRoZSBkYXkgZm9yIHdoYXQgd2FzIGZv
cm1lcmx5IGtub3duIGFzIEFURi4uLg0KPj4+IA0KPj4+IEhvd2V2ZXIgSSBkb24ndCB0aGluayB0
aGF0IGl0J3MgY29ycmVjdCB0byBqdXN0IGRvbid0IGNhY2hlIHRoZQ0KPj4+IGNsb2NrDQo+Pj4g
c2V0dGluZ3MuIE5vcm1hbGx5IHRoZSBzZWN1cmUgd29ybGQgZmlybXdhcmUgc2hvdWxkIG5vdCBj
aGFuZ2UgYW55DQo+Pj4gY2xvY2sgc2V0dGluZ3MgYXQgcnVudGltZSwgb3IgaXQgd291bGQgcnVu
IGludG8gYWxsIGtpbmRzIG9mDQo+Pj4gY29uZmxpY3RzDQo+Pj4gd2l0aCB0aGUgY2xvY2sgZHJp
dmVyLiBTbyB0aGVyZSBhcmUgcHJvYmFibHkgc29tZSB3ZWxsIGtub3duIHBvaW50cw0KPj4+IGlu
DQo+Pj4gdGltZSBsaWtlIGEgc3VzcGVuZCBvciByZXN1bWUgZXZlbnQgd2hlbiB0aGUgZmlybXdh
cmUgbWlnaHQgY2hhbmdlDQo+Pj4gY2xvY2sgc2V0dGluZ3MsIHNvIHdlIGNvdWxkIGluc3RlYWQg
dXNlIHRob3NlIHRvIHRyaWdnZXIgYW4NCj4+PiBleHBsaWNpdA0KPj4+IGludmFsaWRhdGUgb2Yg
dGhlIGNsb2NrIGNhY2hlcyB3aXRoIG11Y2ggbG93ZXIgb3ZlcmhlYWQuDQo+Pj4gDQo+Pj4gUmVn
YXJkcywNCj4+PiBMdWNhcw0KPj4gDQo+PiBUaGVyZSBpcyBidXMtZnJlcSBmZWF0dXJlIG9uIGlt
eDhtIHdoaWNoIGlzIHRvIHNjYWxlIGRkciBjbG9jaywgdGhpcw0KPj4gaXMgZG9uZSBpbiBBUk0g
VHJ1c3RlZCBGaXJtd2FyZSwgZm9yIHNvbWUgc2V0cG9pbnRzLCB0aGUgRERSIFBMTA0KPj4gY2xv
Y2sgcmF0ZSBtdXN0IGJlIGNoYW5nZWQgZGlyZWN0bHkgaW4gVEYtQSwgYnV0IGl0cyBjaGlsZCBj
bG9jayBsaWtlDQo+PiBkcmFtIGNvcmUgaXMgdW5hd2FyZSBpbiBMaW51eCBrZXJuZWwsIHNvIHRo
ZSBjbG9jayByYXRlIHdpbGwgbWlzbWF0Y2gNCj4+IHdpdGggaGFyZHdhcmUsIHNpbmNlIGRkciBy
ZWxhdGVkIGNsb2NrcyB3aWxsIE5PVCB1c2VkIGJ5IGFueSBtb2R1bGUNCj4+IGluIExpbnV4IGtl
cm5lbCwgc28gaXQgd2lsbCBOT1QgaW50cm9kdWNlIGFueSBjb25mbGljdC4NCj4gDQo+IEkgZG9u
J3QgdGhpbmsgdGhlcmUgaXMgYW55dGhpbmcgaW1wbGVtZW50aW5nIHRoZSBidXMgZnJlcXVlbmN5
IHNjYWxpbmcNCj4gaW4gbWFpbmxpbmUsIHJpZ2h0Pw0KDQpZZXMsIG1haW5saW5lIGhhcyBubyBi
dXMtZnJlcSBzY2FsaW5nIHNvIGZhciwgYnV0IGludGVybmFsbHkgd2UgdXNlIHNhbWUgY29tcG9z
aXRlIGNsb2NrIGRyaXZlciBhcyBtYWlubGluZSwgYW5kIGJ1cy1mcmVxIGNsb2NrIHJhdGUgaXNz
dWUvYnVnIHJlcG9ydGVkIGR1cmluZyBvdXIgaW50ZXJuYWwgdGVzdCwgdGhhdCBpcyB3aHkgSSBj
cmVhdGUgdGhpcyBwYXRjaCB0byBlYXN5IG91ciBuZXh0IGtlcm5lbCB1cGdyYWRlLg0KDQo+IA0K
Pj4gUmVnYXJkaW5nIGFib3V0IHRoZSBvdmVyIGhlYWQsIHllcywgdGhlIGNoYW5nZSBpbiBjb21t
b24gY29tcG9zaXRlDQo+PiBjbG9jayByZWdpc3RlciBoYXMgdG9vIG1hbnkgb3ZlciBoZWFkIGZv
ciBvdGhlciBjbG9ja3MsIHdoYXQgaWYgSQ0KPj4gT05MWSBoYXZlIGRyYW0gY29yZSBjbG9jayB0
byBwYXNzIHRoZSBDTEtfR0VUX1JBVEVfTk9DQUNIRSBmbGFnIHRvDQo+PiByZWdpc3RlciB0aGUg
Y29tcG9zaXRlIGNsb2NrPw0KPiANCj4gSU1ITyBtYXJraW5nIGNsb2NrcyB1bmRlciBURi1BIGNv
bnRyb2wgZXhwbGljaXRseSBhcyBub2NhY2hlIHdvdWxkIGJlDQo+IG11Y2ggbW9yZSBhY2NlcHRh
YmxlIHRoYW4gZG9pbmcgaXQgZm9yIGV2ZXJ5IGNvbXBvc2l0ZSBjbG9jay4gVGhpcw0KPiBzZWVt
cyBva2F5IGZvciBhIHNob3J0IHRlcm0gc29sdXRpb24uDQo+IA0KPiBTdGlsbCBJIHRoaW5rIHRo
YXQgd2hhdGV2ZXIgaXMgY2F1c2luZyB0aGUgYnVzIGZyZXF1ZW5jeSBzY2FsZSB0bw0KPiBjaGFu
Z2Ugc2hvdWxkIGhhdmUgYSB3YXkgdG8gZXhwbGljaXRseSBpbnZhbGlkYXRlIHRoZSBjbG9jayBj
YWNoZSBmb3INCj4gdGhlIGFmZmVjdGVkIGNsb2NrcyBldmVudHVhbGx5Lg0KDQpJdCBpcyBiZWNh
dXNlIHRoZSBERFIgUExML2Nsb2NrcyBjYW4gb25seSBiZSBjaGFuZ2VkIHdpdGggc3RyaWN0IERE
UiBmcmVxIGNoYW5nZSBmbG93LCBhbmQgaXQgaXMgZG9uZSBpbiBURi1BLCBMaW51eCBrZXJuZWwg
Y2FuIE5PVCB0b3VjaCBpdCBpbiBydW50aW1lLCBzbyB3ZSBoYXZlIHRvIG1hcmsgdGhlIGNoaWxk
IGNsb2NrIG9mIEREUiBQTEwgdG8gYmUgdW5jYWNoZWQsIGluIFYyIHBhdGNoLCBJIHdpbGwganVz
dCBhZGQgdGhlIGZsYWcgZm9yIHRoZSBERFIgUExMIGNoaWxkIGNsb2NrcyB0byBiZSBhIHNob3J0
ZW4gc29sdXRpb24sIHNob3VsZCBiZSBvbmx5IHZlcnkgZmV3IG9uZXMsIGhvcGUgaXQgaXMgYWNj
ZXB0YWJsZSwgdGhhbmtzLg0KDQpBbnNvbi4NCg0KDQo+IA0KPiBSZWdhcmRzLA0KPiBMdWNhcw0K
