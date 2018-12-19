Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F2A5C43612
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 02:41:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 444502080D
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 02:41:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="GH8Bl5+x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727176AbeLSClx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 21:41:53 -0500
Received: from mail-eopbgr140052.outbound.protection.outlook.com ([40.107.14.52]:62113
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726631AbeLSClw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 21:41:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HNUnhXwPPZcRx8BoLIHeSmpqGVdfma0uJ+gbc+ZmYCk=;
 b=GH8Bl5+xX7zPkBb2A3G6DpxRdq3d68QFlG0uzNYQfdbmOLIFUJxxVtKjyQM6ImM4Ta42k76/B5QBbZ9oRgMBEiSz/7sC8FO2I95a9raSOZOorXHGQvowVh1ZhYfP3ij58PejSwZoZojNVY7AStMLkLiHYnIqaqWPYhh1tlk7crI=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3755.eurprd04.prod.outlook.com (52.134.71.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.20; Wed, 19 Dec 2018 02:41:46 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::adf8:f49d:deb4:58fd]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::adf8:f49d:deb4:58fd%3]) with mapi id 15.20.1425.023; Wed, 19 Dec 2018
 02:41:46 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Stephen Boyd <sboyd@kernel.org>,
        Lucas Stach <l.stach@pengutronix.de>
CC:     Fabio Estevam <festevam@gmail.com>,
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
Subject: RE: [PATCH] clk: imx: add CLK_GET_RATE_NOCACHE flag for i.MX8M
 composite clock
Thread-Topic: [PATCH] clk: imx: add CLK_GET_RATE_NOCACHE flag for i.MX8M
 composite clock
Thread-Index: AQHUln02eAG5Z54Wc0mB2eSSS/znh6WESrGAgAAEigCAADDtEYAAAbEAgAADYNWAAAJrAIAAXCcAgABxvrA=
Date:   Wed, 19 Dec 2018 02:41:45 +0000
Message-ID: <DB3PR0402MB3916574F12AFD4931CD48E8DF5BE0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1545101396-16335-1-git-send-email-Anson.Huang@nxp.com>
 <CAOMZO5BX6PWBp_FmTsMkZJEsKpf+=N6Zyn8P_+ziis-fKR37Ng@mail.gmail.com>
 ,<1545129634.5874.20.camel@pengutronix.de>
 <7E78DD25-BA90-4EBA-81B9-755CD89BD0BF@nxp.com>
 ,<1545140504.5874.25.camel@pengutronix.de>
 <25BEFDBA-5A09-42E9-A4E3-AC15EF4B1886@nxp.com>
 <1545141748.5874.27.camel@pengutronix.de>
 <154516153880.238328.15274393304999995060@swboyd.mtv.corp.google.com>
In-Reply-To: <154516153880.238328.15274393304999995060@swboyd.mtv.corp.google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB3PR0402MB3755;6:gDVqQ8uwEi5PlaNGZCD/K8bWgZ0HncYg8Byp5bDLmfpRH0AlgR9ZRMh4lCLxvAsZYGdyeAEHLKkcVRVsmY+cuucflWl5XRfyUnIgWpawNNFv8rUZRXnkHibWpfMid48L/dfi8uJRMSXd4JKUoFrCYMQCyK5h2zjTaz4udBE+smzs4dYvDqNqydZ9p+Nz9Yqqa00NEGE+R0ycNqROASTkOjvggMhKcl5pWUGyvW8WZjObxEkTNQbWgHyIq9xI/gTn/TPqi2nQOnWn2LJqGEbac4FYezSXlRpBOLhXzGVRCfj/0AUgURmJcZgaUeZn9oFNJco3y8xnx8KL+2SLy5enb8MWKKBDBw/h+AjX47UxnFcAIgMz+OlsRfKaBNHr8ulivM7649WL0fZhcacYFyF8ZGfTHtp1GqRU/FjAQE/9dZ8wvxyymOkCzFyL8KYlP2F8FkVUhsDP7aMkxdAV2oaZng==;5:m3fKdFVmb3ViQjMvReH4dsoprzDiTSlIvYxMRvLrNCibU66Qw66DMU9ryARDsx6A8xG2px4aw4i/5o6gb0iNiih1q4OnGATxHKtmrCOtlnfqTEYyiTdWnT9lv13WkICFRxJNms25MAJ/74NkotuI0mN5tMbHj2hozLh/CPEut2A=;7:Utt1ZaVmi/O4+jW2U5eHBy4J19ndECIjwGEcjdV/JogAYPctszK0qfH9j3cyRznC/WUX78h5do57V2xJjRoRZJbun7Uz/zlonhh3k9hL+tSwEjqfoY2s3f51kQyY/C9YImQBusDHaQqB36fFR+t7LQ==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: ffc810d8-84af-495b-dc35-08d6655b849a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3755;
x-ms-traffictypediagnostic: DB3PR0402MB3755:
x-microsoft-antispam-prvs: <DB3PR0402MB375559FEC7AA5BE30064152BF5BE0@DB3PR0402MB3755.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(999002)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231475)(944501520)(52105112)(10201501046)(3002001)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:DB3PR0402MB3755;BCL:0;PCL:0;RULEID:;SRVR:DB3PR0402MB3755;
x-forefront-prvs: 0891BC3F3D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(346002)(376002)(39860400002)(366004)(136003)(189003)(199004)(51444003)(13464003)(53546011)(6506007)(5660300001)(105586002)(106356001)(97736004)(4001150100001)(3846002)(6436002)(44832011)(6116002)(8936002)(486006)(71190400001)(93886005)(74316002)(71200400001)(68736007)(66066001)(305945005)(478600001)(14454004)(110136005)(26005)(86362001)(229853002)(476003)(4326008)(11346002)(25786009)(7696005)(76176011)(186003)(446003)(54906003)(7736002)(316002)(8676002)(55016002)(99286004)(39060400002)(7416002)(9686003)(81166006)(81156014)(102836004)(33656002)(6246003)(2906002)(14444005)(256004)(53936002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3755;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 6UHX6EWHhhviAVtVmJ5jK7UtbkkJBYP++7GVR/u9CyH0J0a52H6R4YQDk7wqoWpPS6Tm6EloDEhOKMdjRB0DFsQwI45+MYblcRlmbaz+xjn4JcPocVpUOxhaCcwpL7p5MHK3TEHnQHs/fz9QLmCNvAi5f/q+TcprQUrxyicMWiTQNu6OHuRN+C5bjtFbs62ozRQGIt3K2nhSP+oLqEbqNU0qR/Bn0MKbCEZ2w7uLZNYFXl0b+cilzgBXkabDJ4hFKTt2XBVJyZvSPBf1kLXFbZueOleRrhEAuB+fUMlgA6mkxSSn0lvApgy8MQY4uLgO
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffc810d8-84af-495b-dc35-08d6655b849a
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Dec 2018 02:41:46.0174
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3755
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIFN0ZXBoZW4NCg0KQmVzdCBSZWdhcmRzIQ0KQW5zb24gSHVhbmcNCg0KPiAtLS0tLU9yaWdp
bmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBTdGVwaGVuIEJveWQgW21haWx0bzpzYm95ZEBrZXJu
ZWwub3JnXQ0KPiBTZW50OiAyMDE45bm0MTLmnIgxOeaXpSAzOjMyDQo+IFRvOiBBbnNvbiBIdWFu
ZyA8YW5zb24uaHVhbmdAbnhwLmNvbT47IEx1Y2FzIFN0YWNoDQo+IDxsLnN0YWNoQHBlbmd1dHJv
bml4LmRlPg0KPiBDYzogRmFiaW8gRXN0ZXZhbSA8ZmVzdGV2YW1AZ21haWwuY29tPjsgcy5oYXVl
ckBwZW5ndXRyb25peC5kZTsNCj4gbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgbGludXgt
Y2xrQHZnZXIua2VybmVsLm9yZzsgZGwtbGludXgtaW14DQo+IDxsaW51eC1pbXhAbnhwLmNvbT47
IGtlcm5lbEBwZW5ndXRyb25peC5kZTsgRmFiaW8gRXN0ZXZhbQ0KPiA8ZmFiaW8uZXN0ZXZhbUBu
eHAuY29tPjsgc2hhd25ndW9Aa2VybmVsLm9yZzsNCj4gbXR1cnF1ZXR0ZUBiYXlsaWJyZS5jb207
IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BB
VENIXSBjbGs6IGlteDogYWRkIENMS19HRVRfUkFURV9OT0NBQ0hFIGZsYWcgZm9yIGkuTVg4TQ0K
PiBjb21wb3NpdGUgY2xvY2sNCj4gDQo+IFF1b3RpbmcgTHVjYXMgU3RhY2ggKDIwMTgtMTItMTgg
MDY6MDI6MjgpDQo+ID4gQW0gRGllbnN0YWcsIGRlbiAxOC4xMi4yMDE4LCAxMzo1MyArMDAwMCBz
Y2hyaWViIEFuc29uIEh1YW5nOg0KPiA+IFsuLi5dDQo+ID4gPiA+DQo+ID4gPiA+ID4gUmVnYXJk
aW5nIGFib3V0IHRoZSBvdmVyIGhlYWQsIHllcywgdGhlIGNoYW5nZSBpbiBjb21tb24NCj4gPiA+
ID4gPiBjb21wb3NpdGUgY2xvY2sgcmVnaXN0ZXIgaGFzIHRvbyBtYW55IG92ZXIgaGVhZCBmb3Ig
b3RoZXINCj4gPiA+ID4gPiBjbG9ja3MsIHdoYXQgaWYgSSBPTkxZIGhhdmUgZHJhbSBjb3JlIGNs
b2NrIHRvIHBhc3MgdGhlDQo+ID4gPiA+ID4gQ0xLX0dFVF9SQVRFX05PQ0FDSEUgZmxhZyB0byBy
ZWdpc3RlciB0aGUgY29tcG9zaXRlIGNsb2NrPw0KPiA+ID4gPg0KPiA+ID4gPiBJTUhPIG1hcmtp
bmcgY2xvY2tzIHVuZGVyIFRGLUEgY29udHJvbCBleHBsaWNpdGx5IGFzIG5vY2FjaGUgd291bGQN
Cj4gPiA+ID4gYmUgbXVjaCBtb3JlIGFjY2VwdGFibGUgdGhhbiBkb2luZyBpdCBmb3IgZXZlcnkg
Y29tcG9zaXRlIGNsb2NrLg0KPiA+ID4gPiBUaGlzIHNlZW1zIG9rYXkgZm9yIGEgc2hvcnQgdGVy
bSBzb2x1dGlvbi4NCj4gPiA+ID4NCj4gPiA+ID4gU3RpbGwgSSB0aGluayB0aGF0IHdoYXRldmVy
IGlzIGNhdXNpbmcgdGhlIGJ1cyBmcmVxdWVuY3kgc2NhbGUgdG8NCj4gPiA+ID4gY2hhbmdlIHNo
b3VsZCBoYXZlIGEgd2F5IHRvIGV4cGxpY2l0bHkgaW52YWxpZGF0ZSB0aGUgY2xvY2sgY2FjaGUN
Cj4gPiA+ID4gZm9yIHRoZSBhZmZlY3RlZCBjbG9ja3MgZXZlbnR1YWxseS4NCj4gPiA+DQo+ID4g
PiBJdCBpcyBiZWNhdXNlIHRoZSBERFIgUExML2Nsb2NrcyBjYW4gb25seSBiZSBjaGFuZ2VkIHdp
dGggc3RyaWN0IEREUg0KPiA+ID4gZnJlcSBjaGFuZ2UgZmxvdywgYW5kIGl0IGlzIGRvbmUgaW4g
VEYtQSwgTGludXgga2VybmVsIGNhbiBOT1QgdG91Y2gNCj4gPiA+IGl0IGluIHJ1bnRpbWUsIHNv
IHdlIGhhdmUgdG8gbWFyayB0aGUgY2hpbGQgY2xvY2sgb2YgRERSIFBMTCB0byBiZQ0KPiA+ID4g
dW5jYWNoZWQsIGluIFYyIHBhdGNoLCBJIHdpbGwganVzdCBhZGQgdGhlIGZsYWcgZm9yIHRoZSBE
RFIgUExMDQo+ID4gPiBjaGlsZCBjbG9ja3MgdG8gYmUgYSBzaG9ydGVuIHNvbHV0aW9uLCBzaG91
bGQgYmUgb25seSB2ZXJ5IGZldyBvbmVzLA0KPiA+ID4gaG9wZSBpdCBpcyBhY2NlcHRhYmxlLCB0
aGFua3MuDQo+ID4NCj4gPiBJIGZ1bGx5IHVuZGVyc3RhbmQgd2h5IHlvdSBhcmUgZG9pbmcgdGhl
IGZyZXF1ZW5jeSBjaGFuZ2UgaW4gVEYtQSBhbmQNCj4gPiBJIGFncmVlIHdpdGggdGhlIHJlYXNv
bmluZyB0byBkbyBzby4gSSBhbHNvIHRoaW5rIHRoYXQgdXNpbmcgdW5jYWNoZWQNCj4gPiBmb3Ig
dGhlIGZldyBjbG9ja3MgdW5kZXIgVEYtQSBjb250cm9sIGlzIGZpbmUgZm9yIG5vdy4NCj4gPg0K
PiA+IEJ1dCBpZi93aGVuIHRoZSBidXMgZnJlcXVlbmN5IHNjYWxpbmcgaXMgYWN0dWFsbHkgaW1w
bGVtZW50ZWQgZm9yDQo+ID4gdXBzdHJlYW0gSSB0aGluayB0aGUgZmxvdyBzaG91bGQgbG9vayBz
b21ldGhpbmcgbGlrZSB0aGF0Og0KPiA+DQo+ID4gMS4gQnVzIGZyZXEgc2NhbGluZyBkcml2ZXIg
ZGV0ZXJtaW5lcyB0aGF0IGEgY2hhbmdlIGlzIG5lY2Vzc2FyeSAyLg0KPiA+IFNjYWxpbmcgZHJp
dmVyIGNhbGxzIGludG8gVEYtQSB0byBkbyB0aGUgY2hhbmdlIDMuIFRGLUEgcmVjb25maWd1cmVz
DQo+ID4gY2xvY2sgcmF0ZXMgNC4gU2NhbGluZyBkcml2ZXIgY2FsbHMgaW50byBjbG9jayBkcml2
ZXIgdG8gc2lnbmFsIHRoYXQgYQ0KPiA+IGNsb2NrIGNoYW5nZSBtaWdodCBoYXZlIGhhcHBlbmVk
IDUuIENsb2NrIGRyaXZlciBpbnZhbGlkYXRlcyBhbmQNCj4gPiByZWNhbGN1bGF0ZXMgY2FjaGVk
IHZhbHVlcyBmb3IgdGhlIGFmZmVjdGVkIGNsb2Nrcw0KPiA+DQo+IA0KPiBEb2VzIGFueSBjbGsg
Y29uc3VtaW5nIGRyaXZlciBvZiB0aGUgZG93bnN0cmVhbSBjbGtzIHRoYXQgYXJlIGJyYW5jaGVk
IG9mZiBvZg0KPiB0aGUgYnVzIGNsayBtYW5hZ2VkIGJ5IGZpcm13YXJlIGNhcmUgYWJvdXQgdGhl
IGZyZXF1ZW5jeT8gT3IgZG8gdGhleSBqdXN0DQo+IHdhbnQgdGhlIGNsayB0byBiZSBvbi4gSWYg
dGhleSBkb24ndCBjYXJlIHRoZW4gaXQncyBwb3NzaWJsZSB0byBicmVhayB0aGUgcGFyZW50DQo+
IGRlcGVuZGVuY3kgYW5kIGp1c3Qgbm90IGNhcmUgdG8gdGVsbCB0aGVtIHdoYXQgdGhlIGJ1cyBm
cmVxdWVuY3kgaXMgYW55bW9yZS4NCj4gDQo+IEkgZG9uJ3Qga25vdyBob3cgeW91IHdvdWxkIGlt
cGxlbWVudCAjNCBhYm92ZSwgYmVzaWRlcyBieSBoYXZpbmcgdGhlIGJ1cw0KPiBmcmVxIHNjYWxp
bmcgZHJpdmVyIHVzZSBjbGtfc2V0X3JhdGUoKSB0byB0ZWxsIHRoZSBidXMgY2xrIHRoYXQgaXQg
d2FudHMgYSBuZXcgcmF0ZQ0KPiBhbmQgdGhlbiBoYXZpbmcgdGhhdCBjbGsgaW1wbGVtZW50YXRp
b24gZG8gIzIuIFRoYXQgd2F5IHRoZSByYXRlIHByb3BhZ2F0aW9uDQo+IHdvcmtzIHdpdGhvdXQg
aGF2aW5nIHRvIG5vdGlmeSBjbGsgY29kZSBzb21laG93Lg0KDQpJbiBvdXIgY2FzZSwgdGhlIG9y
aWdpbmFsIGNsb2NrIHJlbGF0aW9uc2hpcCBpcyBhcyBiZWxvdywgd2hlbiBERFIgZnJlcSBuZWVk
cyB0byBiZSBzY2FsZWQsIGJlbG93IHRoaW5ncyBhcmUgcHJvY2VlZGVkOg0KDQpDbG9jayB0cmVl
Og0KSU1YOE1RX0RSQU1fUExMMg0KCUlNWDhNUV9EUkFNX1BMTDJfRElWDQoJCUlNWDhNUV9EUkFN
X1BMTDJfT1VUDQoJCQlJTVg4TVFfRFJBTV9QTExfT1VUDQoJCQkJSU1YOE1RX0NMS19EUkFNX0NP
UkUNCg0KMS4gTGludXgga2VybmVsIGRvIFNNQyBjYWxsIGludG8gVEYtQTsNCjIuIGluIFRGLUEs
IHdlIGhhdmUgdG8gc2NhbGUgdGhlIElNWDhNUV9EUkFNX1BMTDIgdG8gZGVkaWNhdGVkIGZyZXF1
ZW5jeSBhbG9uZyB3aXRoIEREUiBmcmVxIHNjYWxlIGZsb3c7DQozLiBBZnRlciBURi1BIGRvbmUg
dGhlIEREUiBmcmVxIHNjYWxlIGFuZCByZXR1cm4gYmFjayB0byBMaW51eCwgYWxsIHRoZSBkb3du
c3RyZWFtIG9mIElNWDhNUV9EUkFNX1BMTDIgY2xvY2sgd2lsbA0KICBoYXZlIG1pc21hdGNoIGNs
b2NrIHJhdGUgYmV0d2VlbiBjbG9jayB0cmVlIGFuZCBIVyBzZXR0aW5ncyBzaW5jZSB0aGV5IGFy
ZSBjYWNoZWQ7DQo0LiBNYXliZSB3ZSBjYW4gY2FsbCBjbGtfc2V0X3JhdGUgaW4gTGludXggZm9y
IElNWDhNUV9EUkFNX1BMTDIgYWdhaW4gKGFsdGhvdWdoIHRoZSBIVyBzZXR0aW5ncyBhcmUgYWxy
ZWFkeSBleHBlY3RlZCkNCiAgdG8gdXBkYXRlIHRoZSBkb3duc3RyZWFtIGNsb2NrcywgbG9va3Mg
bGlrZSBjYW4gZml4IGl0LCBidXQgd2lsbCB0aGUgY2FsbCBiZSBza2lwcGVkIGJ5IGNsb2NrIGZy
YW1ld29yayB3aGVuIGNsb2NrIGRyaXZlcg0KICByZS1jYWxjdWxhdGUgdGhlIFBMTCByYXRlIGJh
c2VkIG9uIEhXIHNldHRpbmcsIGFzIEhXIHNldHRpbmcgYWxyZWFkeSBlcXVhbCB0aGUgcmF0ZSB3
YW50cyB0byBiZSBzZXQsIGFuZCBjbGtfcHJvcGFnYXRlX3JhdGVfY2hhbmdlDQogIHdpbGwgYmUg
c2tpcHBlZCB0b28gb3IgaXQgd2lsbCBhdXRvbWF0aWNhbGx5IHVwZGF0ZSBhbGwgY2hpbGQgY2xv
Y2tzJyByYXRlPw0KDQpJcyBpdCBjb3JyZWN0PyBpZiBhbGwgY2hpbGQgY2xvY2tzJyByYXRlIGNh
biBiZSB1cGRhdGVkIGJ5IGNsa19wcm9wYWdhdGVfcmF0ZV9jaGFuZ2UoKSwgdGhlbiB3ZSBubyBu
ZWVkIHRvIGFkZCBhbnkgY2xvY2sgZmxhZywNCmp1c3QgbWFrZSBzdXJlIGFmdGVyIFRGLUEgZmlu
aXNoIHRoZSBERFIgZnJlcSBzY2FsZSwgbWFrZSBzdXJlIGNhbGxpbmcgdGhlIGNsa19zZXRfcmF0
ZSgpIGZvciB0aGUgSU1YOE1RX0RSQU1fUExMMiwgdGhlbiBldmVyeXRoaW5nIHNob3VsZCBiZSBj
b3JyZWN0Pw0KDQpBbnNvbi4NCg0K
