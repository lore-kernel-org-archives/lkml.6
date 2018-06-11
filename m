Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id b4tfAohlHlvsCwAAmS7hNA
	; Mon, 11 Jun 2018 12:09:30 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id BDB7F607A4; Mon, 11 Jun 2018 12:09:30 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="v1jPscX0"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 392906074D;
	Mon, 11 Jun 2018 12:09:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 392906074D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932902AbeFKMJ1 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 21 others); Mon, 11 Jun 2018 08:09:27 -0400
Received: from mail-eopbgr80055.outbound.protection.outlook.com ([40.107.8.55]:26432
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932776AbeFKMJZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 08:09:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/deL+9tLm9ZVkLBKJab6DddexeTNP1p6b1SJhocCyuI=;
 b=v1jPscX04W/i+GyuIPIkZz+ADoSiRkxuN6a1t6LdbQ3nrVNSQ6fzUzT3WZ+z2m+9pMziQEr2Dug/O6b81rsIP0L9A4lUGMnGxb37KeYzwn5ww1lAm8S/Bc1AsXkx6M/HCkY2f0qU+eLxRpS0Ey2PBmaHf180t/eNDEobTdwYFoI=
Received: from DB6PR04MB3223.eurprd04.prod.outlook.com (10.170.211.19) by
 DB6PR04MB3016.eurprd04.prod.outlook.com (10.170.213.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.841.14; Mon, 11 Jun 2018 12:09:22 +0000
Received: from DB6PR04MB3223.eurprd04.prod.outlook.com
 ([fe80::15a5:6ba0:ac66:7977]) by DB6PR04MB3223.eurprd04.prod.outlook.com
 ([fe80::15a5:6ba0:ac66:7977%2]) with mapi id 15.20.0841.011; Mon, 11 Jun 2018
 12:09:22 +0000
From: Robin Gong <yibin.gong@nxp.com>
To: Lucas Stach <l.stach@pengutronix.de>
CC: "vkoul@kernel.org" <vkoul@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH v3 0/6] add virt-dma support for imx-sdma
Thread-Topic: [PATCH v3 0/6] add virt-dma support for imx-sdma
Thread-Index: AQHUAVHamC9wTHQjkEKuAo/ffjDFC6Ra5GaAgAATBp8=
Date: Mon, 11 Jun 2018 12:09:22 +0000
Message-ID: <8C06065A-DC99-4DA8-BF97-0C3BFE95C080@nxp.com>
References: <1528729173-28684-1-git-send-email-yibin.gong@nxp.com>,<1528714877.2842.3.camel@pengutronix.de>
In-Reply-To: <1528714877.2842.3.camel@pengutronix.de>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yibin.gong@nxp.com;
x-originating-ip: [223.104.213.29]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB6PR04MB3016;7:6M4K4B46cJJAUhPJVZ/vNA1DH8EU7CGMT2z3tKwzUFcf2B7RKSDKkCrXKzxfjQSMK/w/fqBIFRxFqdbWojHAV87v+j6OFjWS7t0bxuiduTjy7kcxeKBWUXvjOp59JOqxMXHSw21RfqJ+qc+MAwTkoWMw6kkNV7gnT1V29fPyJe1csBreT4lpUIHA7sUAH96Ll/z40D7Z873VJ/Qn7+NXPLugjzv1/6VRg3hiyZuTs2P7vt9utKBMHoKCI9s+1e0R
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DB6PR04MB3016;
x-ms-traffictypediagnostic: DB6PR04MB3016:
x-microsoft-antispam-prvs: <DB6PR04MB3016795E3D093D6FB659A95F89780@DB6PR04MB3016.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(10201501046)(93006095)(93001095)(3002001)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:DB6PR04MB3016;BCL:0;PCL:0;RULEID:;SRVR:DB6PR04MB3016;
x-forefront-prvs: 070092A9D3
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(366004)(39380400002)(376002)(346002)(199004)(189003)(8936002)(6916009)(83716003)(5660300001)(59450400001)(54906003)(76176011)(478600001)(105586002)(106356001)(102836004)(97736004)(53936002)(316002)(99286004)(36756003)(6506007)(5250100002)(6486002)(229853002)(86362001)(66066001)(25786009)(11346002)(2900100001)(486006)(446003)(3280700002)(4326008)(6436002)(476003)(305945005)(2906002)(7736002)(2616005)(3660700001)(6246003)(33656002)(6116002)(3846002)(81156014)(8676002)(186003)(81166006)(14454004)(82746002)(68736007)(6512007)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR04MB3016;H:DB6PR04MB3223.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: y56scH1pl112HLlt5mAiKGKfAWtXB8yYol/DS5N6f/JSl0y23aWfc5YBUiur8TGxTa3yxFUPZ44eTb1kk2Tk6Y6gsePC0KHhohemT4DQ2Nz+4e6OUpjir/4U03g5v47jSLUcBjCB/xMRuz7A4FW2rPMARfro7HCn5RnrxjpMfBdRXZBlDXKqPwGShvY7/fHd
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 21ca88b5-9c4d-4c01-318a-08d5cf942ad4
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21ca88b5-9c4d-4c01-318a-08d5cf942ad4
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jun 2018 12:09:22.1733
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR04MB3016
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpIaSBMdWNhcywNCiAgICBUaGFuayBmb3IgeW91ciByZXBvcnQsIEkgdGVzdGVkIGl0IG9ubHkg
b24gU1BJLCB3aWxsIHVwZGF0ZSB0byB5b3UgYWZ0ZXIgdHJ5IG9uIHVhcnQgdG9tb3Jyb3cuDQoN
Cj4g5ZyoIDIwMTjlubQ25pyIMTHml6XvvIzkuIvljYg3OjAx77yMTHVjYXMgU3RhY2ggPGwuc3Rh
Y2hAcGVuZ3V0cm9uaXguZGU+IOWGmemBk++8mg0KPiANCj4gSGkgUm9iaW4sDQo+IA0KPiB0aGlz
IHNlcmllcyBicmVha3Mgc2VyaWFsIERNQSBmb3IgbWUuIEkgd2Fzbid0IGFibGUgdG8gZGlnIGlu
IGRlZXBlcg0KPiB5ZXQuIFBsZWFzZSBsZXQgbWUga25vdyBpZiB5b3UgY2FuIHRlc3QvcmVwcm9k
dWNlIGF0IHlvdXIgc2lkZSwgaWYgbm90DQo+IEknbGwgdHJ5IHRvIGZpbmQgc29tZSB0aW1lIHRv
IGNvbGxlY3Qgc29tZSBtb3JlIGRlYnVnIGluZm8uDQo+IA0KPiBSZWdhcmRzLA0KPiBMdWNhcw0K
PiANCj4gQW0gTW9udGFnLCBkZW4gMTEuMDYuMjAxOCwgMjI6NTkgKzA4MDAgc2NocmllYiBSb2Jp
biBHb25nOg0KPj4gVGhlIGxlZ2FjeSBzZG1hIGRyaXZlciBoYXMgYmVsb3cgbGltaXRhdGlvbnMg
b3IgZHJhd2JhY2tzOg0KPj4gICAxLiBIYXJkY29kZSB0aGUgbWF4IEJEcyBudW1iZXIgYXMgIlBB
R0VfU0laRSAvIHNpemVvZigqKSIsIGFuZCBhbGxvYw0KPj4gICAgICBvbmUgcGFnZSBzaXplIGZv
ciBvbmUgY2hhbm5lbCByZWdhcmRsZXNzIG9mIG9ubHkgZmV3IEJEcyBuZWVkZWQNCj4+ICAgICAg
bW9zdCB0aW1lLiBCdXQgaW4gZmV3IGNhc2VzLCB0aGUgbWF4IFBBR0VfU0laRSBtYXliZSBub3Qg
ZW5vdWdoLg0KPj4gICAyLiBPbmUgU0RNQSBjaGFubmVsIGNhbid0IHN0b3AgaW1tZWRpYXRsZXkg
b25jZSBjaGFubmVsIGRpc2FibGVkIHdoaWNoDQo+PiAgICAgIG1lYW5zIFNETUEgaW50ZXJydXB0
IG1heSBjb21lIGluIGFmdGVyIHRoaXMgY2hhbm5lbCB0ZXJtaW5hdGVkLlRoZXJlDQo+PiAgICAg
IGFyZSBzb21lIHBhdGNoZXMgZm9yIHRoaXMgY29ybmVyIGNhc2Ugc3VjaCBhcyBjb21taXQgIjI3
NDZlMmMzODlmOSIsDQo+PiAgICAgIGJ1dCBub3QgY292ZXIgbm9uLWN5Y2xpYy4NCj4+IA0KPj4g
VGhlIGNvbW1vbiB2aXJ0LWRtYSBvdmVyY29tZXMgdGhlIGFib3ZlIGxpbWl0YXRpb25zLiBJdCBj
YW4gYWxsb2MgYmQNCj4+IGR5bmFtaWNhbGx5IGFuZCBmcmVlIGJkIG9uY2UgdGhpcyB0eCB0cmFu
c2ZlciBkb25lLiBObyBtZW1vcnkgd2FzdGVkIG9yDQo+PiBtYXhpbXVtIGxpbWl0aXRhdGlvbiBo
ZXJlLCBvbmx5IGRlcGVuZHMgb24gaG93IG1hbnkgbWVtb3J5IGNhbiBiZSByZXF1ZXN0ZWQNCj4+
IGZyb20ga2VybmVsLiBGb3IgTm8uMiwgc3VjaCBpc3N1ZSBjYW4gYmUgd29ya2Fyb3VuZCBieSBj
aGVja2luZyBpZiB0aGVyZQ0KPj4gaXMgYXZhaWxhYmxlIGRlc2NyaXB0KCJzZG1hYy0+ZGVzYyIp
IG5vdyBvbmNlIHRoZSB1bndhbnRlZCBpbnRlcnJ1cHQNCj4+IGNvbWluZy4gQXQgbGFzdCB0aGUg
Y29tbW9uIHZpcnQtZG1hIGlzIGVhc2llciBmb3Igc2RtYSBkcml2ZXIgbWFpbnRhaW4uDQo+PiAN
Cj4+IENoYW5nZSBmcm9tIHYyOg0KPj4gICAxLiBpbmNsdWRlIFNhc2NoYSdzIHBhdGNoIHRvIG1h
a2UgdGhlIG1haW4gcGF0Y2ggZWFzaWVyIHRvIHJldmlldy4NCj4+ICAgICAgVGhhbmtzIFNhY2hh
Lg0KPj4gICAyLiByZW1vdmUgdXNlbGVzcyAnZGVzYycvJ2NoYW4nIGluIHN0cnVjdCBzZG1hX2No
YW5uZS4NCj4+IA0KPj4gQ2hhbmdlIGZyb20gdjE6DQo+PiAgIDEuIHNwbGl0IHYxIHBhdGNoIGlu
dG8gNSBwYXRjaGVzLg0KPj4gICAyLiByZW1vdmUgc29tZSB1bm5lY2Vzc2FyeSBjb25kaXRpb24g
Y2hlY2suDQo+PiAgIDMuIHJlbW92ZSB1bm5lY2Vzc2FyeSAncGVuZGluZycgbGlzdC4NCj4+IA0K
Pj4gUm9iaW4gR29uZyAoNSk6DQo+PiAgIGRtYWVuZ2luZTogaW14LXNkbWE6IGFkZCB2aXJ0LWRt
YSBzdXBwb3J0DQo+PiAgIFJldmVydCAiZG1hZW5naW5lOiBpbXgtc2RtYTogZml4IHBhZ2VmYXVs
dCB3aGVuIGNoYW5uZWwgaXMgZGlzYWJsZWQNCj4+ICAgICBkdXJpbmcgaW50ZXJydXB0Ig0KPj4g
ICBkbWFlbmdpbmU6IGlteC1zZG1hOiByZW1vdmUgdXNsZXNzIGxvY2sNCj4+ICAgZG1hZW5naW5l
OiBpbXgtc2RtYTogcmVtb3ZlIHRoZSBtYXhpbXVtIGxpbWF0aW9uIGZvciBiZCBudW1iZXJzDQo+
PiAgIGRtYWVuZ2luZTogaW14LXNkbWE6IGFkZCBzZG1hX3RyYW5zZmVyX2luaXQgdG8gZGVjcmVh
c2UgY29kZSBvdmVybGFwDQo+PiANCj4+ICBkcml2ZXJzL2RtYS9LY29uZmlnICAgIHwgICAxICsN
Cj4+ICBkcml2ZXJzL2RtYS9pbXgtc2RtYS5jIHwgMzkyICsrKysrKysrKysrKysrKysrKysrKysr
KysrKystLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4+ICAyIGZpbGVzIGNoYW5nZWQsIDIyNyBpbnNl
cnRpb25zKCspLCAxNjYgZGVsZXRpb25zKC0pDQo+PiANCj4+IC0tIA0KPj4gMi43LjQNCj4+IA0K
Pj4gUm9iaW4gR29uZyAoNSk6DQo+PiAgIGRtYWVuZ2luZTogaW14LXNkbWE6IGFkZCB2aXJ0LWRt
YSBzdXBwb3J0DQo+PiAgIFJldmVydCAiZG1hZW5naW5lOiBpbXgtc2RtYTogZml4IHBhZ2VmYXVs
dCB3aGVuIGNoYW5uZWwgaXMgZGlzYWJsZWQNCj4+ICAgICBkdXJpbmcgaW50ZXJydXB0Ig0KPj4g
ICBkbWFlbmdpbmU6IGlteC1zZG1hOiByZW1vdmUgdXNsZXNzIGxvY2sNCj4+ICAgZG1hZW5naW5l
OiBpbXgtc2RtYTogcmVtb3ZlIHRoZSBtYXhpbXVtIGxpbWF0aW9uIGZvciBiZCBudW1iZXJzDQo+
PiAgIGRtYWVuZ2luZTogaW14LXNkbWE6IGFkZCBzZG1hX3RyYW5zZmVyX2luaXQgdG8gZGVjcmVh
c2UgY29kZSBvdmVybGFwDQo+PiANCj4+IFNhc2NoYSBIYXVlciAoMSk6DQo+PiAgIGRtYWVuZ2lu
ZTogaW14LXNkbWE6IGZhY3RvciBvdXQgYSBzdHJ1Y3Qgc2RtYV9kZXNjIGZyb20gc3RydWN0DQo+
PiAgICAgc2RtYV9jaGFubmVsDQo+PiANCj4+ICBkcml2ZXJzL2RtYS9LY29uZmlnICAgIHwgICAx
ICsNCj4+ICBkcml2ZXJzL2RtYS9pbXgtc2RtYS5jIHwgMzkxICsrKysrKysrKysrKysrKysrKysr
KysrKysrKystLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4+ICAyIGZpbGVzIGNoYW5nZWQsIDIyNiBp
bnNlcnRpb25zKCspLCAxNjYgZGVsZXRpb25zKC0pDQo+PiANCg==
