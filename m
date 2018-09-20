Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A533BC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 10:39:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AEDB21529
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 10:39:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="blMHSQtg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AEDB21529
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731100AbeITQVt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 12:21:49 -0400
Received: from mail-eopbgr00055.outbound.protection.outlook.com ([40.107.0.55]:41188
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728444AbeITQVs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 12:21:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=afwBnaCWElruujDYMsWnGHx5Tpe9R2kb88gcsU8EAiQ=;
 b=blMHSQtg/N8UjOE2nzjLMM1VHTplkHmLrITRtCT/bK61pRLPILeUWvXHkZjgBdciGY9Ud4Gkj/tZvEDZVlR6m2LpBZJZwTGpp0mZxvjEyDFJXKE4brFPA2xML87llgoQemejjmicZXNF5vGCN+0O/YsF4CCrcbHGaecZoIZCtJA=
Received: from AM6PR0402MB3864.eurprd04.prod.outlook.com (52.133.29.151) by
 AM6PR0402MB3864.eurprd04.prod.outlook.com (52.133.29.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.18; Thu, 20 Sep 2018 10:38:54 +0000
Received: from AM6PR0402MB3864.eurprd04.prod.outlook.com
 ([fe80::918c:7f25:5892:764]) by AM6PR0402MB3864.eurprd04.prod.outlook.com
 ([fe80::918c:7f25:5892:764%2]) with mapi id 15.20.1143.017; Thu, 20 Sep 2018
 10:38:53 +0000
From:   Laurentiu Tudor <laurentiu.tudor@nxp.com>
To:     Robin Murphy <robin.murphy@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
CC:     Madalin-cristian Bucur <madalin.bucur@nxp.com>,
        Roy Pledge <roy.pledge@nxp.com>, Leo Li <leoyang.li@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>
Subject: Re: [PATCH 00/21] SMMU enablement for NXP LS1043A and LS1046A
Thread-Topic: [PATCH 00/21] SMMU enablement for NXP LS1043A and LS1046A
Thread-Index: AQHUUBVdnVuE9WUMJk6OHUCevWlNC6T3mFcAgAAO0oCAAAUrgIABT78A
Date:   Thu, 20 Sep 2018 10:38:53 +0000
Message-ID: <33eac426-cbb7-f899-5a35-aea28f8e5dc4@nxp.com>
References: <20180919123613.15092-1-laurentiu.tudor@nxp.com>
 <7d7646dc-9d0b-013d-75d7-a6cb4453f41f@arm.com>
 <fd8ab351-46aa-f73e-593b-502a57de1975@nxp.com>
 <39211e7a-034b-cdca-f182-1b6f6e5fbc53@arm.com>
In-Reply-To: <39211e7a-034b-cdca-f182-1b6f6e5fbc53@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [86.34.165.90]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM6PR0402MB3864;6:wn0lFYxkRy2M/nmnsArFP8Pjmta8D34O5yNJ36Lv6TEuUWRBWdd7oo0MpTF7HOADHLir1/Au6J3OqXDzGq4sF43TlvqUxPurQ60Dg9KpB+6idXEjnl3SDC03GpDbjeLGfM/zMH65sI1aSB+ZAVWsFyV6S0rY+USderA/6gGLm9P7YMrYkzcItPy6H/SP3HDSkK/h3hy2Purd+BO4jkab70B1HVmz54XUQlEOCcOkpubRU2aLylEQn9d0/wGeNBJ+nRrQCavTVIXcK10w55QZQkaIpgMXonOeMTmDydE1X6Cb2mkTHwHdpx9U0fZgg7213PHZ+Lvfw5xxyPtoO/DwqIpuhDo0yB6u/r0gDcHTqMOO7++M028jCpqCTSnqXHkqUWbdm0mjA7suq6bVuXHsvt9Uh0gqavvAiasToNfiE5k4OSdfWoYE6Z4Mj9V9sRQgKF8LfplqmqEQ+lWOKfHlAA==;5:GBHO/KbAbakmuGU91NVT8eYDm8r/f2BCYg0DvmkrQHGdhZnAg1+oIPMshXXQfzLeu2exAmLgDnM4vNlofrucBiySd7G/rBB2YiyZvppBnU7FkP63724wCC1aCz4/otV7GAPUO9R+F7LTAns7Pli7/CBCvAZq+EGmyRWOBXCvZQ4=;7:oRzQsh0mIjKSsjaOhNmA+as1QVjq/lX1EYPm0Aup8a1HCG2GFGdtuKOwr9zCLQQ8p3rNLEMe08UmpZzHC9Bvx58Zjsb05AZaELp+gdSdYt7yMY+xgL4w56bFQ4EZSn/sKQuSoCKpHKpT4c+PPZiU9ZVwP1dMRvfq5U+vDFE9aLA/Fl/oB/dg3qxupTGW0dOJEZ0mtS1li1i7KX7xU2RL3x0gunbSfk8Y0nA8OCDzTLULlR2Zc7W8ftf1VKrxnNwU
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: f5264b38-fb33-40db-99d4-08d61ee542ee
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR0402MB3864;
x-ms-traffictypediagnostic: AM6PR0402MB3864:
x-microsoft-antispam-prvs: <AM6PR0402MB3864C9643E4CC433C260FE08EC130@AM6PR0402MB3864.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231355)(944501410)(52105095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123564045)(201708071742011)(7699051)(76991041);SRVR:AM6PR0402MB3864;BCL:0;PCL:0;RULEID:;SRVR:AM6PR0402MB3864;
x-forefront-prvs: 0801F2E62B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(366004)(396003)(39860400002)(136003)(189003)(199004)(31696002)(229853002)(2900100001)(97736004)(26005)(316002)(256004)(11346002)(6512007)(2616005)(53936002)(446003)(2906002)(486006)(476003)(54906003)(31686004)(14444005)(8676002)(305945005)(7736002)(6346003)(44832011)(99286004)(4326008)(6436002)(105586002)(110136005)(5660300001)(6116002)(3846002)(6486002)(25786009)(81156014)(14454004)(106356001)(478600001)(36756003)(8936002)(81166006)(76176011)(5250100002)(102836004)(53546011)(6506007)(68736007)(66066001)(86362001)(2201001)(2501003)(6246003)(186003)(93886005)(71190400001)(71200400001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR0402MB3864;H:AM6PR0402MB3864.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=laurentiu.tudor@nxp.com; 
x-microsoft-antispam-message-info: hulbF8tgOpPAWw8LXwUwgnhmHM6s1w+OZeL5tTW9Yt3yZD23JV9pSUpc4GKQFXeAw3mDza2pO02JPtBBeP48VI3RV6EAcT/udUMJO60asBU5pm6F4VNzaC4u3g38gnPdWOfqbS1CYOLVBJXbIbiHZRxTIf/uXfbHqQjDYHnrlLq04DIkk+n0g1+KqQof7KuBc8AJYbAen2MpcWqxli17tsAl0UrZDFfbzSEJGKBzUZ72sK7RguEJOMfoVpfHWfxCFMEZfiRZP8MXXdMFvKyvqSt+Pd39QLz3Hpo7n6tMZjecyzUyNOmkkWSJBY73n1aMtE/uWzdgmnee+WRM+Xo3smfDNtqUMjEWAUp/zZ9ExaE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <62B758932A5F144AB2B7FD7494933B5D@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5264b38-fb33-40db-99d4-08d61ee542ee
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2018 10:38:53.7710
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3864
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDE5LjA5LjIwMTggMTc6MzcsIFJvYmluIE11cnBoeSB3cm90ZToNCj4gT24gMTkvMDkv
MTggMTU6MTgsIExhdXJlbnRpdSBUdWRvciB3cm90ZToNCj4+IEhpIFJvYmluLA0KPj4NCj4+IE9u
IDE5LjA5LjIwMTggMTY6MjUsIFJvYmluIE11cnBoeSB3cm90ZToNCj4+PiBIaSBMYXVyZW50aXUs
DQo+Pj4NCj4+PiBPbiAxOS8wOS8xOCAxMzozNSwgbGF1cmVudGl1LnR1ZG9yQG54cC5jb20gd3Jv
dGU6DQo+Pj4+IEZyb206IExhdXJlbnRpdSBUdWRvciA8bGF1cmVudGl1LnR1ZG9yQG54cC5jb20+
DQo+Pj4+DQo+Pj4+IFRoaXMgcGF0Y2ggc2VyaWVzIGFkZHMgU01NVSBzdXBwb3J0IGZvciBOWFAg
TFMxMDQzQSBhbmQgTFMxMDQ2QSBjaGlwcw0KPj4+PiBhbmQgY29uc2lzdHMgbW9zdGx5IGluIGlt
cG9ydGFudCBkcml2ZXIgZml4ZXMgYW5kIHRoZSByZXF1aXJlZCBkZXZpY2UNCj4+Pj4gdHJlZSB1
cGRhdGVzLiBJdCB0b3VjaGVzIHNldmVyYWwgc3Vic3lzdGVtcyBhbmQgY29uc2lzdHMgb2YgdGhy
ZWUgbWFpbg0KPj4+PiBwYXJ0czoNCj4+Pj4gwqDCoCAtIGNoYW5nZXMgaW4gc29jL2RyaXZlcnMv
ZnNsL3FibWFuIGRyaXZlcnMgYWRkaW5nIGlvbW11IG1hcHBpbmcgb2YNCj4+Pj4gwqDCoMKgwqAg
cmVzZXJ2ZWQgbWVtb3J5IGFyZWFzLCBmaXhlcyBhbmQgZGVmZXJlZCBwcm9iZSBzdXBwb3J0DQo+
Pj4+IMKgwqAgLSBjaGFuZ2VzIGluIGRyaXZlcnMvbmV0L2V0aGVybmV0L2ZyZWVzY2FsZS9kcGFh
X2V0aCBkcml2ZXJzDQo+Pj4+IMKgwqDCoMKgIGNvbnNpc3RpbmcgaW4gbWlzYyBkbWEgbWFwcGlu
ZyByZWxhdGVkIGZpeGVzIGFuZCBwcm9iZSBvcmRlcmluZw0KPj4+PiDCoMKgIC0gYWRkaXRpb24g
b2YgdGhlIGFjdHVhbCBhcm0gc21tdSBkZXZpY2UgdHJlZSBub2RlIHRvZ2V0aGVyIHdpdGgNCj4+
Pj4gwqDCoMKgwqAgdmFyaW91cyBhZGp1c3RtZW50cyB0byB0aGUgZGV2aWNlIHRyZWVzDQo+Pj4+
DQo+Pj4+IFBlcmZvcm1hbmNlIGltcGFjdA0KPj4+Pg0KPj4+PiDCoMKgwqDCoMKgIFJ1bm5pbmcg
aXBlcmYgYmVuY2htYXJrcyBpbiBhIGJhY2stdG8tYmFjayBzZXR1cCAoYm90aCBzaWRlcw0KPj4+
PiDCoMKgwqDCoMKgIGhhdmluZyBzbW11IGVuYWJsZWQpIG9uIGEgMTBHQnBzIHBvcnQgc2hvdyBh
biBpbXBvcnRhbnQNCj4+Pj4gwqDCoMKgwqDCoCBuZXR3b3JraW5nIHBlcmZvcm1hbmNlIGRlZ3Jh
ZGF0aW9uIG9mIGFyb3VuZCAlNDAgKDkuNDhHYnBzDQo+Pj4+IMKgwqDCoMKgwqAgbGluZXJhdGUg
dnMgNS40NUdicHMpLiBJZiB5b3UgbmVlZCBwZXJmb3JtYW5jZSBidXQgd2l0aG91dA0KPj4+PiDC
oMKgwqDCoMKgIFNNTVUgc3VwcG9ydCB5b3UgY2FuIHVzZSAiaW9tbXUucGFzc3Rocm91Z2g9MSIg
dG8gZGlzYWJsZQ0KPj4+PiDCoMKgwqDCoMKgIFNNTVUuDQo+Pj4+DQo+Pj4+IFVTQiBpc3N1ZSBh
bmQgd29ya2Fyb3VuZA0KPj4+Pg0KPj4+PiDCoMKgwqDCoMKgIFRoZXJlJ3MgYSBwcm9ibGVtIHdp
dGggdGhlIHVzYiBjb250cm9sbGVycyBpbiB0aGVzZSBjaGlwcw0KPj4+PiDCoMKgwqDCoMKgIGdl
bmVyYXRpbmcgc21hbGxlciwgNDAtYml0IHdpZGUgZG1hIGFkZHJlc3NlcyBpbnN0ZWFkIG9mIHRo
ZSANCj4+Pj4gNDgtYml0DQo+Pj4+IMKgwqDCoMKgwqAgc3VwcG9ydGVkIGF0IHRoZSBzbW11IGlu
cHV0LiBTbyB5b3UgZW5kIHVwIGluIGEgc2l0dWF0aW9uIA0KPj4+PiB3aGVyZSB0aGUNCj4+Pj4g
wqDCoMKgwqDCoCBzbW11IGlzIG1hcHBlZCB3aXRoIDQ4LWJpdCBhZGRyZXNzIHRyYW5zbGF0aW9u
cywgYnV0IHRoZSBkZXZpY2UNCj4+Pj4gwqDCoMKgwqDCoCBnZW5lcmF0ZXMgdHJhbnNhY3Rpb25z
IHdpdGggY2xpcHBlZCA0MC1iaXQgYWRkcmVzc2VzLCB0aHVzIHNtbXUNCj4+Pj4gwqDCoMKgwqDC
oCBjb250ZXh0IGZhdWx0cyBhcmUgdHJpZ2dlcmVkLiBJIGVuY291bnRlcmVkIGEgc2ltaWxhciAN
Cj4+Pj4gc2l0dWF0aW9uIGZvcg0KPj4+PiDCoMKgwqDCoMKgIG1tYyB0aGF0IEnCoCBtYW5hZ2Vk
IHRvIGZpeCBpbiBzb2Z0d2FyZSBbMV0gaG93ZXZlciBmb3IgVVNCIEkgDQo+Pj4+IGRpZCBub3QN
Cj4+Pj4gwqDCoMKgwqDCoCBmaW5kIGEgcHJvcGVyIHBsYWNlIGluIHRoZSBjb2RlIHRvIGFkZCBh
IHNpbWlsYXIgZml4LiBUaGUgb25seQ0KPj4+PiDCoMKgwqDCoMKgIHdvcmthcm91bmQgSSBmb3Vu
ZCB3YXMgdG8gYWRkIHRoaXMga2VybmVsIHBhcmFtZXRlciB3aGljaCANCj4+Pj4gbGltaXRzIHRo
ZQ0KPj4+PiDCoMKgwqDCoMKgIHVzYiBkbWEgdG8gMzItYml0IHNpemU6ICJ4aGNpLWhjZC5xdWly
a3M9MHg4MDAwMDAiLg0KPj4+PiDCoMKgwqDCoMKgIFRoaXMgd29ya2Fyb3VuZCBpZiBmYXIgZnJv
bSBpZGVhbCwgc28gYW55IHN1Z2dlc3Rpb25zIGZvciBhIGNvZGUNCj4+Pj4gwqDCoMKgwqDCoCBi
YXNlZCB3b3JrYXJvdW5kIGluIHRoaXMgYXJlYSB3b3VsZCBiZSBncmVhdGx5IGFwcHJlY2lhdGVk
Lg0KPj4+DQo+Pj4gSWYgeW91IGhhdmUgYSBub21pbmFsbHktNjQtYml0IGRldmljZSB3aXRoIGEN
Cj4+PiBuYXJyb3dlci10aGFuLXRoZS1tYWluLWludGVyY29ubmVjdCBsaW5rIGluIGZyb250IG9m
IGl0LCB0aGF0IHNob3VsZA0KPj4+IGFscmVhZHkgYmUgZml4ZWQgaW4gNC4xOS1yYyBieSBidXNf
ZG1hX21hc2sgcGlja2luZyB1cCBEVCBkbWEtcmFuZ2VzLA0KPj4+IHByb3ZpZGVkIHRoZSBpbnRl
cmNvbm5lY3QgaGllcmFyY2h5IGNhbiBiZSBkZXNjcmliZWQgYXBwcm9wcmlhdGVseSAob3INCj4+
PiBhdCBsZWFzdCBtYXNzYWdlZCBzdWZmaWNpZW50bHkgdG8gc2F0aXNmeSB0aGUgYmluZGluZyks
IGUuZy46DQo+Pj4NCj4+PiAvIHsNCj4+PiDCoCDCoMKgwqDCoC4uLg0KPj4+DQo+Pj4gwqAgwqDC
oMKgwqBzb2Mgew0KPj4+IMKgIMKgwqDCoMKgwqDCoMKgIHJhbmdlczsNCj4+PiDCoCDCoMKgwqDC
oMKgwqDCoCBkbWEtcmFuZ2VzID0gPDAgMCAxMDAwMCAwPjsNCj4+Pg0KPj4+IMKgIMKgwqDCoMKg
wqDCoMKgIGRldl80OGJpdCB7IC4uLiB9Ow0KPj4+DQo+Pj4gwqAgwqDCoMKgwqDCoMKgwqAgcGVy
aXBoX2J1cyB7DQo+Pj4gwqAgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByYW5nZXM7DQo+Pj4gwqAg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBkbWEtcmFuZ2VzID0gPDAgMCAxMDAgMD47DQo+Pj4NCj4+
PiDCoCDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGRldl80MGJpdCB7IC4uLiB9Ow0KPj4+IMKgIMKg
wqDCoMKgwqDCoMKgIH07DQo+Pj4gwqAgwqDCoMKgwqB9Ow0KPj4+IH07DQo+Pj4NCj4+PiBhbmQg
aWYgdGhhdCBmYWlscyB0byB3b3JrIGFzIGV4cGVjdGVkIChleGNlcHQgZm9yIFBDSSBob3N0cyB3
aGVyZQ0KPj4+IGhhbmRsaW5nIGRtYS1yYW5nZXMgcHJvcGVybHkgc3RpbGwgbmVlZHMgc29ydGlu
ZyBvdXQpLCBwbGVhc2UgZG8gbGV0IHVzDQo+Pj4ga25vdyA7KQ0KPj4+DQo+Pg0KPj4gSnVzdCB0
byBjb25maXJtLCBJcyB0aGlzIFsxXSB0aGUgY2hhbmdlIEkgd2FzIHN1cHBvc2VkIHRvIHRlc3Q/
DQo+IA0KPiBOb3QgcXVpdGUgLSBkbWEtcmFuZ2VzIGlzIG9ubHkgdmFsaWQgZm9yIG5vZGVzIHJl
cHJlc2VudGluZyBhIGJ1cywgc28gDQo+IHB1dHRpbmcgaXQgZGlyZWN0bHkgaW4gdGhlIFVTQiBk
ZXZpY2Ugbm9kZXMgZG9lc24ndCB3b3JrIChGV0lXIHRoYXQncyANCj4gd2h5IFBDSSBpcyBicm9r
ZW4sIGJlY2F1c2UgdGhlIHBhcnNlciBkb2Vzbid0IGV4cGVjdCB0aGUgDQo+IGJ1cy1hcy1sZWFm
LW5vZGUgY2FzZSkuIFRoYXQncyB0ZWggcG9pbnQgb2YgdGhhdCBpbnRlcm1lZGlhdGUgc2ltcGxl
LWJ1cyANCj4gbm9kZSByZXByZXNlbnRlZCBieSAicGVyaXBoX2J1cyIgaW4gbXkgZXhhbXBsZSAo
c29ycnksIEkgc2hvdWxkIGhhdmUgcHV0IA0KPiBjb21wYXRpYmxlcyBpbiB0byBtYWtlIGl0IGNs
ZWFyZXIpIC0gb2Z0ZW4gdGhhdCdzIGFjdHVhbGx5IHRydWUgdG8gbGlmZSANCj4gKGkuZS4gInNv
YyIgaXMgc29tZXRoaW5nIGxpa2UgYSBDQ0kgYW5kICJwZXJpcGhfYnVzIiBpcyBzb21ldGhpbmcg
bGlrZSANCj4gYW4gQVhJIE5JQyBnbHVpbmcgYSBidW5jaCBvZiBsb3dlci1iYW5kd2lkdGggRE1B
IG1hc3RlcnMgdG8gb25lIG9mIHRoZSANCj4gQ0NJIHBvcnRzKSBidXQgYXQgd29yc3QgaXQncyBq
dXN0IGEgbmVjZXNzYXJ5IGV2aWwgdG8gbWFrZSB0aGUgYmluZGluZyANCj4gaGFwcHkgKGlmIGl0
IGxpdGVyYWxseSBvbmx5IHJlcHJlc2VudHMgdGhlIHBvaW50LXRvLXBvaW50IGxpbmsgYmV0d2Vl
biANCj4gdGhlIGRldmljZSBtYXN0ZXIgcG9ydCBhbmQgaW50ZXJjb25uZWN0IHNsYXZlIHBvcnQp
Lg0KPiANCg0KUXVpY2sgdXBkYXRlOiBzbyBJIGFkanVzdGVkIHRvIGRldmljZSB0cmVlIGFjY29y
ZGluZyB0byB5b3VyIGV4YW1wbGUgYW5kIA0KaXQgd29ya3Mgc28gbm93IEkgY2FuIGdldCByaWQg
b2YgdGhhdCBuYXN0eSBrZXJuZWwgYXJnIGJhc2VkIHdvcmthcm91bmQsIA0KeWV5ISA6LSkNClRo
YW5rcyBhIGxvdCwgdGhhdCB3YXMgcmVhbGx5IGhlbHBmdWwuDQoNCi0tLQ0KQmVzdCBSZWdhcmRz
LCBMYXVyZW50aXU=
