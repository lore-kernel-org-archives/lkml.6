Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27863C433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 01:18:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C29E820841
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 01:18:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="O9KPZbgl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C29E820841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726160AbeICFfr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 01:35:47 -0400
Received: from mail-eopbgr60047.outbound.protection.outlook.com ([40.107.6.47]:59788
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725762AbeICFfq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 01:35:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XijfjtGxA/2RwUUsedkd8Q2r5d5ysiFJTYYiOD2hBDw=;
 b=O9KPZbgltz+RhaaQDB6I20CXW6RdwPX/v73qAqtO0XGm5pOrqiEfqG8m/I7G7HWGz6ZUcToE2KXLXQ4idxmwLTMkD3hkvfg+K3uPeVHe7zsajhs1JzIfoO0lYUd4LGcVXipk3sUllGVgmjt9Nkte7bXmcVfBaqMZlqFKgtpjez8=
Received: from DB5PR0401MB2213.eurprd04.prod.outlook.com (10.166.173.8) by
 DB5PR0401MB1927.eurprd04.prod.outlook.com (10.166.10.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1101.17; Mon, 3 Sep 2018 01:17:55 +0000
Received: from DB5PR0401MB2213.eurprd04.prod.outlook.com
 ([fe80::f9e1:eda0:e2ec:6b1]) by DB5PR0401MB2213.eurprd04.prod.outlook.com
 ([fe80::f9e1:eda0:e2ec:6b1%7]) with mapi id 15.20.1101.016; Mon, 3 Sep 2018
 01:17:55 +0000
From:   Andy Tang <andy.tang@nxp.com>
To:     Scott Wood <oss@buserror.net>,
        Vabhav Sharma <vabhav.sharma@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel-owner@vger.kernel.org" 
        <linux-kernel-owner@vger.kernel.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "kstewart@linuxfoundation.org" <kstewart@linuxfoundation.org>,
        "yamada.masahiro@socionext.com" <yamada.masahiro@socionext.com>
CC:     Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        Udit Kumar <udit.kumar@nxp.com>, Varun Sethi <V.Sethi@nxp.com>
Subject: RE: [PATCH 3/5] drivers: clk-qoriq: Add clockgen support for lx2160a
Thread-Topic: [PATCH 3/5] drivers: clk-qoriq: Add clockgen support for lx2160a
Thread-Index: AQHUOLbm4rl14SxWF0C6ww3h4NBV1KTV6koAgAIMswCAAKh1AIAAANOAgADNfJCAAPM9AIADb+mA
Date:   Mon, 3 Sep 2018 01:17:55 +0000
Message-ID: <DB5PR0401MB221332A5ED14C8E14C8D18A1F30C0@DB5PR0401MB2213.eurprd04.prod.outlook.com>
References: <1534747636-20064-1-git-send-email-vabhav.sharma@nxp.com>
 <1534747636-20064-4-git-send-email-vabhav.sharma@nxp.com>
 <4a9ea6b451683ec98c92e86a5ae6b91213a6afcf.camel@buserror.net>
 <VI1PR04MB4800E8B1E8541FCA9221A1CFF3080@VI1PR04MB4800.eurprd04.prod.outlook.com>
 <d2cfd49eb33a3ce74f0e78f2b53d3954d2cb3e76.camel@buserror.net>
 <b31ae8e788fb93971167faa9b55b497e838532c4.camel@buserror.net>
 <DB5PR0401MB22130C025AA4CCAD0221781DF30F0@DB5PR0401MB2213.eurprd04.prod.outlook.com>
 <f6707cb54c3e6da1b50f45f915c996dfccfeacda.camel@buserror.net>
In-Reply-To: <f6707cb54c3e6da1b50f45f915c996dfccfeacda.camel@buserror.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB5PR0401MB1927;6:LZ403l1E1ayka5BlUd0mSs6s8pd6AAhIWWKIkQffYL3C4AxUjBYlf08MwUEGNJZl/ZXdW5w2/xFYnx8NKR6lwUhwd2pmp2euMJNFCBEtlt770KphOO20wy3mVOOeZCyeY7I1IbwwSHTyuqlhp1gtPcrY/qMnPwfEt9FsKFIpmZK/okEm22+WOgo3zXwjLHfWaGNE3zVqQlgKHZtPVqe2f98o1o35S+PQyYpSuZZNJoZOvIbtHf+MGuyPvdjjrcSe/LkDvhtpnZvA6jDD5KR8xFZWWpmIyzx49fyt2UQ7yJo84e6IeV3gCu/gS2pqxjxe6S2+OSJV8TyzvM7yY2nMcCq8eWS4gcirmGuRGuJWgiAHOdLNJ05I1dp2J7RYL4KKZMW1Q9Tq+24mTxGXmFig2hr1Xm1CizPQa1HSU6z7NeO6oAR84unGCxJ9KyMLSZaFSpiCmEbHyfEuhN+ExvTfEw==;5:VGnJ6bIHrgomhB+md9yUN//R8Bwk6m5YX16BjnoJyUQJs/3V2zgSXaTA9jYAaFXWk9G0Cp3lMbEpfsopnzKCD8j60Q4GMDJJkVWhvGVnFlzDXkK/b4/AN0BZD0oHSzgvUhJfSpAf6gGRUys9vygxKihx6jtthB+woQilY9D1J/0=;7:4o2RSV6r0ahfmW0UaG7LyDFdP+SNJ7i+lqjvroi/bRwOKBPij2cgZusH2lh4OA0s7pTCM0P1HDwcynDhDRKigRXbOkwPlXVvc0DqGVj5oz4LG4PCyk7PbTHAVnSM8G26/tt66/dKWHORPgT1p1zo/jstfUH4y2WBRRgV6C5uFFGfYLIDKIvNfCqIqxKKvadF4c5w9CYnvDQAF/GePTgYfEYLVLbnIPsNIUAlnE8/5vqCzwkl99WTNQOxlETcyWJJ
x-ms-office365-filtering-correlation-id: b6631158-5d3a-451e-5aed-08d6113b13f6
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB5PR0401MB1927;
x-ms-traffictypediagnostic: DB5PR0401MB1927:
x-microsoft-antispam-prvs: <DB5PR0401MB19275FDA45BE89AA6485F20CF30C0@DB5PR0401MB1927.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(180628864354917)(9452136761055)(65623756079841)(185117386973197)(258649278758335);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823301075)(10201501046)(3231311)(944501410)(52105095)(93006095)(93001095)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699016);SRVR:DB5PR0401MB1927;BCL:0;PCL:0;RULEID:;SRVR:DB5PR0401MB1927;
x-forefront-prvs: 0784C803FD
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(396003)(346002)(39860400002)(136003)(366004)(13464003)(189003)(199004)(76176011)(6506007)(81166006)(53546011)(81156014)(8676002)(186003)(8936002)(26005)(102836004)(6346003)(6246003)(44832011)(5660300001)(256004)(93886005)(229853002)(25786009)(7416002)(33656002)(4326008)(68736007)(99286004)(305945005)(7696005)(74316002)(14444005)(316002)(110136005)(486006)(2501003)(54906003)(7736002)(5250100002)(2906002)(97736004)(2900100001)(14454004)(2201001)(478600001)(55016002)(6116002)(3846002)(9686003)(105586002)(86362001)(6436002)(11346002)(446003)(53936002)(66066001)(476003)(106356001)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB5PR0401MB1927;H:DB5PR0401MB2213.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=andy.tang@nxp.com; 
x-microsoft-antispam-message-info: /4o7jeWMo7VPhv4mGUHBD3yrL3iVn1rw6O0ghWjNxMDTwRZyrDHtJYwoXv/0xFyWw9LorEN7uwLNwLbESgzLzNP4vsGA6ZmOaCP+Lj4AnuuW06WBTjlzp5b9eAuIyzfHycR81+REJJyOqeM0yV8ROm4B7XwAQCmoQmVaVpYHpJC3pI6vkqAH4IJ9MXFCkBwF4RifyA5yaQeeD8QeSjvgogcWPD4BgMwkW5X/iFhn+h4oLoGW98kfXLIhAPXuLZL9eB8+VkX/xzmmaPQfOZ2gcsIW2zdB5UAFwI24+7D9hao/dgXE+OAa/cOB60vZjqlDnsETz+yPhUmqhFmRvtJsbghd9CC9RkXrE8GBpIHMXV4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6631158-5d3a-451e-5aed-08d6113b13f6
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2018 01:17:55.4177
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR0401MB1927
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgU2NvdHQsDQoNClBsZWFzZSBzZWUgbXkgcmVwbGF5IGluIGxpbmUuDQoNCj4gLS0tLS1Pcmln
aW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTGludXhwcGMtZGV2DQo+IDxsaW51eHBwYy1kZXYt
Ym91bmNlcytiMjk5ODM9ZnJlZXNjYWxlLmNvbUBsaXN0cy5vemxhYnMub3JnPiBPbg0KPiBCZWhh
bGYgT2YgU2NvdHQgV29vZA0KPiBTZW50OiAyMDE45bm0OeaciDHml6UgNDoyOQ0KPiBUbzogQW5k
eSBUYW5nIDxhbmR5LnRhbmdAbnhwLmNvbT47IFZhYmhhdiBTaGFybWENCj4gPHZhYmhhdi5zaGFy
bWFAbnhwLmNvbT47IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7DQo+IGRldmljZXRyZWVA
dmdlci5rZXJuZWwub3JnOyByb2JoK2R0QGtlcm5lbC5vcmc7DQo+IG1hcmsucnV0bGFuZEBhcm0u
Y29tOyBsaW51eHBwYy1kZXZAbGlzdHMub3psYWJzLm9yZzsNCj4gbGludXgtYXJtLWtlcm5lbEBs
aXN0cy5pbmZyYWRlYWQub3JnOyBtdHVycXVldHRlQGJheWxpYnJlLmNvbTsNCj4gc2JveWRAa2Vy
bmVsLm9yZzsgcmp3QHJqd3lzb2NraS5uZXQ7IHZpcmVzaC5rdW1hckBsaW5hcm8ub3JnOw0KPiBs
aW51eC1jbGtAdmdlci5rZXJuZWwub3JnOyBsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmc7DQo+IGxp
bnV4LWtlcm5lbC1vd25lckB2Z2VyLmtlcm5lbC5vcmc7IGNhdGFsaW4ubWFyaW5hc0Bhcm0uY29t
Ow0KPiB3aWxsLmRlYWNvbkBhcm0uY29tOyBncmVna2hAbGludXhmb3VuZGF0aW9uLm9yZzsgYXJu
ZEBhcm5kYi5kZTsNCj4ga3N0ZXdhcnRAbGludXhmb3VuZGF0aW9uLm9yZzsgeWFtYWRhLm1hc2Fo
aXJvQHNvY2lvbmV4dC5jb20NCj4gQ2M6IFlvZ2VzaCBOYXJheWFuIEdhdXIgPHlvZ2VzaG5hcmF5
YW4uZ2F1ckBueHAuY29tPjsNCj4gbGludXhAYXJtbGludXgub3JnLnVrOyBVZGl0IEt1bWFyIDx1
ZGl0Lmt1bWFyQG54cC5jb20+OyBWYXJ1biBTZXRoaQ0KPiA8Vi5TZXRoaUBueHAuY29tPg0KPiBT
dWJqZWN0OiBSZTogW1BBVENIIDMvNV0gZHJpdmVyczogY2xrLXFvcmlxOiBBZGQgY2xvY2tnZW4g
c3VwcG9ydCBmb3INCj4gbHgyMTYwYQ0KPiANCj4gT24gRnJpLCAyMDE4LTA4LTMxIGF0IDA2OjEy
ICswMDAwLCBBbmR5IFRhbmcgd3JvdGU6DQo+ID4gSGkgU2NvdHQsDQo+ID4NCj4gPiBQbGVhc2Ug
c2VlIG15IHJlcGxheSBpbmxpbmUuDQo+ID4NCj4gPiA+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0t
LS0tDQo+ID4gPiBGcm9tOiBsaW51eC1hcm0ta2VybmVsDQo+ID4gPiA8bGludXgtYXJtLWtlcm5l
bC1ib3VuY2VzQGxpc3RzLmluZnJhZGVhZC5vcmc+DQo+ID4gPiBPbiBCZWhhbGYgT2YgU2NvdHQg
V29vZA0KPiA+ID4gU2VudDogMjAxOOW5tDjmnIgzMeaXpSAxOjQzDQo+ID4gPiBUbzogVmFiaGF2
IFNoYXJtYSA8dmFiaGF2LnNoYXJtYUBueHAuY29tPjsNCj4gPiA+IGxpbnV4LWtlcm5lbEB2Z2Vy
Lmtlcm5lbC5vcmc7IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOw0KPiA+ID4gcm9iaCtkdEBr
ZXJuZWwub3JnOyBtYXJrLnJ1dGxhbmRAYXJtLmNvbTsNCj4gPiA+IGxpbnV4cHBjLWRldkBsaXN0
cy5vemxhYnMub3JnOyBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7DQo+ID4g
PiBtdHVycXVldHRlQGJheWxpYnJlLmNvbTsgc2JveWRAa2VybmVsLm9yZzsgcmp3QHJqd3lzb2Nr
aS5uZXQ7DQo+ID4gPiB2aXJlc2gua3VtYXJAbGluYXJvLm9yZzsgbGludXgtY2xrQHZnZXIua2Vy
bmVsLm9yZzsNCj4gPiA+IGxpbnV4LXBtQHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsLW93
bmVyQHZnZXIua2VybmVsLm9yZzsNCj4gPiA+IGNhdGFsaW4ubWFyaW5hc0Bhcm0uY29tOyB3aWxs
LmRlYWNvbkBhcm0uY29tOw0KPiA+ID4gZ3JlZ2toQGxpbnV4Zm91bmRhdGlvbi5vcmc7IGFybmRA
YXJuZGIuZGU7DQo+ID4gPiBrc3Rld2FydEBsaW51eGZvdW5kYXRpb24ub3JnOyB5YW1hZGEubWFz
YWhpcm9Ac29jaW9uZXh0LmNvbQ0KPiA+ID4gQ2M6IFlvZ2VzaCBOYXJheWFuIEdhdXIgPHlvZ2Vz
aG5hcmF5YW4uZ2F1ckBueHAuY29tPjsgQW5keSBUYW5nDQo+ID4gPiA8YW5keS50YW5nQG54cC5j
b20+OyBsaW51eEBhcm1saW51eC5vcmcudWs7IFZhcnVuIFNldGhpDQo+ID4gPiA8Vi5TZXRoaUBu
eHAuY29tPjsgVWRpdCBLdW1hciA8dWRpdC5rdW1hckBueHAuY29tPg0KPiA+ID4gU3ViamVjdDog
UmU6IFtQQVRDSCAzLzVdIGRyaXZlcnM6IGNsay1xb3JpcTogQWRkIGNsb2NrZ2VuIHN1cHBvcnQN
Cj4gPiA+IGZvciBseDIxNjBhDQo+ID4gPg0KPiA+ID4gT24gVGh1LCAyMDE4LTA4LTMwIGF0IDEy
OjM5IC0wNTAwLCBTY290dCBXb29kIHdyb3RlOg0KPiA+ID4gPiBPbiBUaHUsIDIwMTgtMDgtMzAg
YXQgMDc6MzYgKzAwMDAsIFZhYmhhdiBTaGFybWEgd3JvdGU6DQo+ID4gPiA+ID4gPg0KPiA+ID4g
PiA+ID4gV2h5IGFyZSB5b3UgaW5jcmVhc2luZyBOVU1fQ01VWCBiZXlvbmQgOCBmb3IgYSBjaGlw
IHRoYXQNCj4gb25seQ0KPiA+ID4NCj4gPiA+IGhhcw0KPiA+ID4gPiA+ID4gOCBlbnRyaWVzIGlu
IGNtdXhfdG9fZ3JvdXA/DQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBDb25maWd1cmF0aW9uIGlzIDE2
IGNvcmVzLDggY2x1c3RlciB3aXRoIDIgY29yZXMgaW4gZWFjaCBjbHVzdGVyDQo+ID4gPiA+DQo+
ID4gPiA+IFNvPyAgVGhpcyBpcyBhYm91dCBjbXV4ZXMsIG5vdCBjb3Jlcy4gIFlvdSdyZSBpbmNy
ZWFzaW5nIHRoZSBhcnJheQ0KPiA+ID4gPiB3aXRob3V0IGV2ZXIgdXNpbmcgdGhlIG5ldyBzaXpl
Lg0KPiA+ID4NCj4gPiA+IE9oLCBhbmQgeW91IGFsc28gYnJva2UgcDQwODAgd2hpY2ggaGFzIDgg
Y211eGVzIGJ1dCBubyAtMQ0KPiA+ID4gdGVybWluYXRvciwgYmVjYXVzZSB0aGUgYXJyYXkgd2Fz
IG9mIGxlbmd0aCA4LiAgUHJvYmFibHkgdGhlIGFycmF5DQo+ID4gPiBzaG91bGQgYmUgY2hhbmdl
ZCB0byBOVU1fQ01VWCsxIHNvIGV2ZXJ5IGFycmF5IGNhbiBiZSAtMQ0KPiB0ZXJtaW5hdGVkLg0K
PiA+ID4NCj4gPg0KPiA+IFtBbmR5XSBIb3cgYWJvdXQgd2UgYWRkIC0xIHRlcm1pbmF0b3IgdG8g
cDQwODAgYW5kIGluY3JlYXNlDQo+IE5VTV9DTVVYIHRvIDE2Pw0KPiANCj4gV2h5IDE2PyAgV2hh
dCBkb2VzIHN1Y2ggYSBjaGFuZ2UgaGF2ZSB0byBkbyB3aXRoIHRoaXMgY2hpcCwgd2hpY2gNCj4g
YWNjb3JkaW5nIHRvIHRoZSByZXN0IG9mIHRoZSBwYXRjaCBoYXMgOCBjbXV4ZXM/DQpbQW5keV0g
TlVNX0NNVVggaXMgYSBsaW1pdGF0aW9uIG51bWJlci4gV2UgYmV0dGVyIGdpdmUgaXQgYW4gZXh0
cmEgYnVmZmVyLCBub3QgZXhhY3RseSBlcXVhbCB0byB0aGUgbGltaXRhdGlvbi4NCjE2IGlzIHRo
ZSBsaW1pdGF0aW9uIG51bWJlciB3aXRoIGV4dHJhIGJ1ZmZlci4NCg0KPiANCj4gPiBXZSBkb24n
dCB3YW50IHRvIGluY3JlYXNlIE5VTV9DTVVYIGVhY2ggdGltZSBuZXcgc29jIHdpdGggbW9yZQ0K
PiBjbXV4ZXMgYWRkZWQuDQo+IA0KPiBZb3UgZG9uJ3Qgd2FudCB0byBoYXZlIHRvIG1ha2UgYSB0
cml2aWFsIGNoYW5nZSBlYWNoIHRpbWUgeW91IGV4Y2VlZCBhDQo+IGxpbWl0IHRoYXQgaGFzIHll
dCB0byBiZSBleGNlZWRlZCBvbmNlIHNpbmNlIE5VTV9DTVVYIHdhcyBhZGRlZD8NCj4gVGhpcyBp
c24ndCBBQkkgb3IgaW4gYW55IG90aGVyIHdheSBoYXJkIHRvIGNoYW5nZS4gIEl0J3MgcmlnaHQg
aW4gdGhlIHNhbWUgZmlsZQ0KPiBhcyB0aGUgY2hpcCBkZXNjcmlwdGlvbiB5b3UnZCBiZSBhZGRp
bmcuDQo+IA0KPiBBbmQgZXZlbiBpZiBhIGNoaXAgZGlkIGNvbWUgYWxvbmcgd2l0aCAxNiBjbXV4
ZXMsIHlvdSdkIHRoZW4gbmVlZCB0bw0KPiBpbmNyZWFzZSB0aGUgYXJyYXkgdG8gMTcgdG8gaG9s
ZCB0aGUgLTEgaWYgeW91IGRvbid0IHdhbnQgdG8gbGVhdmUgYSBzaXR1YXRpb24NCj4gbGlrZSB0
aGUNCj4gcDQwODAgaXMgaW4gbm93LCB3aGVyZSBhIGNoaXAncyBjbXV4IGFycmF5IGNvdWxkIGJl
IGJyb2tlbiBieSBpbmNyZWFzaW5nDQo+IE5VTV9DTVVYIGZ1cnRoZXIuDQo+IA0KW0FuZHldIEFk
ZGluZyBidWZmZXIgdG8gYSBsaW1pdGF0aW9uIG51bWJlciBpcyBhbHdheXMgYSBnb29kIGhhYml0
IHdoZW4gY29kaW5nLiBXZSBvZnRlbiBmb3JnZXQgdG8gaW5jcmVhc2UgdGhpcyB2YWx1ZSB3aGVu
DQphIG5ldyBjaGlwIHdpdGggbW9yZSBjbXV4ZXMgYWRkZWQuIExpa2UgdGhpcyBwYXRjaCwgd2Ug
ZGlkbid0IGluY3JlYXNlIHRoaXMgdmFsdWUgYXQgZmlyc3QuIFdlIHNwZW50IGEgbG90IG9mIHRp
bWUgZmluZGluZyBvdXQgdGhhdCBOVU1fQ01VWCBuZWVkcyB0byBiZSBpbmNyZWFzZWQgdG9vLg0K
SXQgaXMgYSBwZXJzb25hbCBwcmVmZXJlbmNlIGhvdyB0byBzZXQgdGhpcyB2YWx1ZS4gSSB0aGlu
ayBpdCBpcyBiZXR0ZXIgdG8gaW5jcmVhc2UgaXQgdG8gMTYsIG5vdCBOVU1fQ01VWCsxIGFzIGxv
bmcgYXMgd2UgZml4IHRoZSBQNDA4MCBpc3N1ZQ0KZXZlbiB0aG91Z2ggaXQgaXMgYSB0cml2aWFs
IGNoYW5nZS4gQW5kIEkgYWdyZWUgdGhlIGRlc2NyaXB0aW9uIG5lZWRzIHRvIGJlIHVwZGF0ZWQu
DQoNCkJSLA0KQW5keQ0KDQo+IC1TY290dA0KDQo=
