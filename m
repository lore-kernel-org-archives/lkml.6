Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E09A8C64EAD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 09:52:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79ED221479
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 09:52:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="mJMieVs4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79ED221479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726486AbeJIRIc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 13:08:32 -0400
Received: from mail-he1eur01on0082.outbound.protection.outlook.com ([104.47.0.82]:53072
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725823AbeJIRIc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 13:08:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3qBb3tFeJX1yWPT8GyFq5szdgypBHk4nYIbvhOAv3Ws=;
 b=mJMieVs4upM090GOcZVN1emoHI8Y0xNl937JR/zabCyBwK5TkEeaqYzj9oARt68qOuZDWk+JqMsFv0slRju+LU+b+GUBxJ+k70xZxJ5KM9lr/lxOZUgQNV24H3l20WCux/bSL587tcQBQckJIDZcy8uKzvnguownte7zeEsGN4g=
Received: from AM6PR04MB4357.eurprd04.prod.outlook.com (52.135.167.33) by
 AM6PR04MB3989.eurprd04.prod.outlook.com (52.135.160.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.26; Tue, 9 Oct 2018 09:52:23 +0000
Received: from AM6PR04MB4357.eurprd04.prod.outlook.com
 ([fe80::7dc8:c4f0:3cb6:d466]) by AM6PR04MB4357.eurprd04.prod.outlook.com
 ([fe80::7dc8:c4f0:3cb6:d466%3]) with mapi id 15.20.1207.024; Tue, 9 Oct 2018
 09:52:23 +0000
From:   Chuanhua Han <chuanhua.han@nxp.com>
To:     Boris Brezillon <boris.brezillon@bootlin.com>
CC:     "broonie@kernel.org" <broonie@kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "eha@deif.com" <eha@deif.com>
Subject: RE: [PATCH 1/2] spi: spi-mem: Add the spi_set_xfer_bpw function
Thread-Topic: [PATCH 1/2] spi: spi-mem: Add the spi_set_xfer_bpw function
Thread-Index: AQHUUXmVvI4Eamit80qkSTJAtq5nJ6UFSniAgAAAtKCAAAjOgIARcEYw
Date:   Tue, 9 Oct 2018 09:52:23 +0000
Message-ID: <AM6PR04MB4357280CD4F77FCB01AB5C7097E70@AM6PR04MB4357.eurprd04.prod.outlook.com>
References: <20180921070628.35153-1-chuanhua.han@nxp.com>
        <20180928084431.300b7bf9@bbrezillon>
        <AM6PR04MB43573478FFD0E512A117484097EC0@AM6PR04MB4357.eurprd04.prod.outlook.com>
 <20180928091833.15e95f7f@bbrezillon>
In-Reply-To: <20180928091833.15e95f7f@bbrezillon>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM6PR04MB3989;6:gJtpyS/DM7oeHa7mApg6gJfKpaBR+qrQj67u3m6N5uMRzYUY6i82XxU4SJqZia1dl0NBlQMuYIRMW98ESU6lduc38ssCEmbGa4A/9+npIF+y8x2K/rZeD2DVpkNgP2h/FnRbhuLaHNrfewqBlm4gqbgiOK7so8xCgdncvYrh5Sn3te87tye+dI79nQdFQskEjAo1u4Xd3AWCjY4XOPPCSAbOgFTOR7HSlkp1Ul2bycniMm6w3Ivfqrcmjg5FVOKVBtVvnP4L9x9Xb80NjYBpQS55lBV2cDMMQ2yMsTYNQf3JB4KkjmjD41e0mnX3haV2XSWr6fVHLzhkw/hJYOstL6xlXwTomDGYRpUt3/uWIkaWSrYSze20QHnFT6aP+pq7KGiOXfvt+Rq816EsB3JnDJ1KG7H2U+unJIjFQsw3H0AYSDBXGVC8Mc04zrhIkWWgenh8d+Zn0Nu4FiOodx4TrA==;5:U8SObT94Yujue6SR+FW6+h5KuH6p4RS+fzcQGw4JSnYHUJZQI6GlV3OrJBqrL8aGQqHxZqbkKUWtMsSHMVPz/VpENygB3/ApnZvdPO5dZ8ZtCpc+QcsKnBLPpwFuBnkG5/YL+CGjVt0mczASXCGPAbeLupdZD3jZcO4BIGIXAVU=;7:xEQae5D9g9VltUVy8ftBO5xnpIZJDKbGsXcZfl/T93jG1ql9wYVuItJKjM0IGVY5OAxBhjdweI3GH7vjd1GUDBylppW2gKsLq8YLKuigbZ1ORpBTbBAQFKd7Q6QsS9jppHb0GsV7pfuNsGkGtCetUsG+qi2rNDCXSca0gzehr78/yf0sk6XUGrxvLiAKnOHT3LBsCZMwjDAxTx1ywVoEqBKIu1TbRMr7Kyi+MJGLHgHUr3gkNmXmF79CJO74gLiF
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: adff421b-8cc6-4d1f-f111-08d62dcce9a1
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR04MB3989;
x-ms-traffictypediagnostic: AM6PR04MB3989:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=chuanhua.han@nxp.com; 
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-antispam-prvs: <AM6PR04MB398917AA82CF04543F759A2D97E70@AM6PR04MB3989.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(45079756050767)(189930954265078)(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(10201501046)(93006095)(93001095)(3002001)(6055026)(149066)(150057)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123558120)(201708071742011)(7699051)(76991055);SRVR:AM6PR04MB3989;BCL:0;PCL:0;RULEID:;SRVR:AM6PR04MB3989;
x-forefront-prvs: 08200063E9
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(346002)(136003)(376002)(366004)(396003)(189003)(199004)(13464003)(6246003)(44832011)(97736004)(476003)(478600001)(486006)(74316002)(186003)(446003)(7696005)(11346002)(2900100001)(4326008)(102836004)(6306002)(55016002)(9686003)(5250100002)(26005)(99286004)(14454004)(45080400002)(25786009)(66066001)(71200400001)(53936002)(8936002)(71190400001)(6116002)(316002)(229853002)(3846002)(305945005)(33656002)(86362001)(7736002)(14444005)(8676002)(6916009)(81156014)(53546011)(81166006)(68736007)(6506007)(106356001)(76176011)(5660300001)(6436002)(54906003)(93886005)(2906002)(105586002)(256004);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB3989;H:AM6PR04MB4357.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 7DQ7I7HAFC1pVDh9OqGWPP4sMENoDYt3X8KppoC+JSwXWNhHD1fiXWi170ZXyMDITE7rtlMRf4UNZ+aTGMwmv2A9ZdVSscplf1gV4g9lxGjpzFnfJaz2SXPx5IVYOS00y8jjMOZUwzbhsTclAl8yvx6fmMRR94lsVIHqcVoBkE+IPLG82Q0Vm/E8lRMRH1fsbZmu7TnMDOyz53Ggq4+VO6buohgTkd6y0rXa+65GfjO9JH7wXMNtrSFFEuAySKHLioKEZIUpRulRltaqQh+nQFNVgo7WNP57OZ26Wn2kXSBGRLG9Wd7X4AAzg2ZbDXI2qUFrzcqcXVF/OACqVzQ6yodz+wyshv6T2ftzsLeujqM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: adff421b-8cc6-4d1f-f111-08d62dcce9a1
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2018 09:52:23.4692
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB3989
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQm9yaXMgQnJlemlsbG9u
IDxib3Jpcy5icmV6aWxsb25AYm9vdGxpbi5jb20+DQo+IFNlbnQ6IDIwMTjE6jnUwjI4yNUgMTU6
MTkNCj4gVG86IENodWFuaHVhIEhhbiA8Y2h1YW5odWEuaGFuQG54cC5jb20+DQo+IENjOiBicm9v
bmllQGtlcm5lbC5vcmc7IGxpbnV4LXNwaUB2Z2VyLmtlcm5lbC5vcmc7DQo+IGxpbnV4LWtlcm5l
bEB2Z2VyLmtlcm5lbC5vcmc7IGVoYUBkZWlmLmNvbQ0KPiBTdWJqZWN0OiBSZTogW1BBVENIIDEv
Ml0gc3BpOiBzcGktbWVtOiBBZGQgdGhlIHNwaV9zZXRfeGZlcl9icHcgZnVuY3Rpb24NCj4gDQo+
IE9uIEZyaSwgMjggU2VwIDIwMTggMDY6NTk6NTggKzAwMDANCj4gQ2h1YW5odWEgSGFuIDxjaHVh
bmh1YS5oYW5AbnhwLmNvbT4gd3JvdGU6DQo+IA0KPiA+ID4NCj4gPiA+IEl0J3Mgc3RpbGwgdW5j
bGVhciB3aHkgeW91IG5lZWQgdG8gc3BlY2lmeSBhIGJpdHNfcGVyX3dvcmQgdmFsdWUsDQo+ID4g
PiBidXQgaWYgdGhpcyBpcyBuZWVkZWQsIGl0J3MgcHJvYmFibHkgc29tZXRoaW5nIHlvdSB3YW50
IHRvIGFkZCB0bw0KPiA+ID4gc3BpLmMsIHdoZW4gYSBtZXNzYWdlIGlzIHF1ZXVlZC4NCj4gPiBU
byBzcGVjaWZ5IGEgc3BlY2lmaWMgYml0c19wZXJfd29yZCB0byBiZSBhYmxlIHRvIHVzZSB0aGUg
eHNwaQ0KPiA+ICgzMmJpdCkgbW9kZSBvZiB0aGUgZnNsX2RzcGkgbW9kdWxlIHRvIHRyYW5zZmVy
IGRhdGEsIHlvdSBjYW4gbG9vayBhdA0KPiA+IG15IFBBVENIIDIvMi4gRG8gbm90IGFkZCBhIHZh
bHVlIGluIHNwaXMuYyB0aGF0IHRha2VzIGludG8gYWNjb3VudA0KPiA+IHRoYXQgdGhlIHZhbHVl
IGFzc2lnbmVkIHRvIGJpdHNfcGVyX3dvcmQgaXMgZGVjaWRlZCBiZWZvcmUgdGhlDQo+ID4gdHJh
bnNmZXIuIFRoYW5rcyBmb3IgeW91ciBjaGVjayBhbmQgcmVwbHkhDQo+IA0KPiBJIG1pZ2h0IGJl
IHdyb25nLCBidXQgdGhhdCdzIG5vdCBteSB1bmRlcnN0YW5kaW5nIG9mIC0+Yml0c19wZXJfd29y
ZC4NCj4gVG8gbWUsIGl0J3Mgc29tZXRoaW5nIHRoYXQgeW91IGNhbiB1c2Ugd2hlbiB5b3VyICpk
ZXZpY2UqIChub3QNCj4gY29udHJvbGxlcikgZXhwZWN0cyBub24tYnl0ZSBhbGlnbmVkIHdvcmRz
IFsxXS4gVGhlIHNwaS1tZW0gcHJvdG9jb2wgaXMNCj4gZGVmaW5pdGVseSBkZXNpZ25lZCB0byB3
b3JrIHdpdGggMWJ5dGUgbGFyZ2Ugd29yZHMsIHNvLCBhcyBJIHNhaWQsIEkgc3VzcGVjdA0KPiB5
b3UncmUgYWJ1c2luZyB4ZmVyLT5iaXRzX3Blcl93b3JkIHRvIGFkZHJlc3MgYSBjb250cm9sbGVy
IGRyaXZlciBpc3N1ZS4NCj4gDQo+IFsxXWh0dHBzOi8vZW1lYTAxLnNhZmVsaW5rcy5wcm90ZWN0
aW9uLm91dGxvb2suY29tLz91cmw9aHR0cHMlM0ElMkYlMkZlbGkNCj4geGlyLmJvb3RsaW4uY29t
JTJGbGludXglMkZsYXRlc3QlMkZzb3VyY2UlMkZpbmNsdWRlJTJGbGludXglMkZzcGklMkZzcGkN
Cj4gLmglMjNMMTE0JmFtcDtkYXRhPTAyJTdDMDElN0NjaHVhbmh1YS5oYW4lNDBueHAuY29tJTdD
N2VjNjFkNmQNCj4gN2VmNzQxYWJhODQ0MDhkNjI1MTJhOWUxJTdDNjg2ZWExZDNiYzJiNGM2ZmE5
MmNkOTljNWMzMDE2MzUlN0MwDQo+ICU3QzAlN0M2MzY3MzcxNTk0MjA4MjAwNTAmYW1wO3NkYXRh
PWl3RmdYRzN5RnZIN1J1YWM3TUdDb2FQOGgNCj4gbDJNOTE2bTklMkJaZVY3bmtzVGclM0QmYW1w
O3Jlc2VydmVkPTANCjEuIEluIHRoZSBkc3BpIGRyaXZlciAoc3BpIGNvbnRyb2xsZXIpLCBiaXRz
X3Blcl93b3JkIChkc3BpLT5iaXRzX3Blcl93b3JkID0gdHJhbnNmZXItPmJpdHNfcGVyX3dvcmQp
IHBhc3NlZCBmcm9tIHRoZSB1cHBlciBsYXllciAoc3BpLW1lbS5jKSBpcyB1c2VkLiANCkluIHRo
aXMgd2F5LCBJIGNhbiBvbmx5IGFzc2lnbiB0aGUgYXBwcm9wcmlhdGUgdmFsdWUgb2YgdHJhbnNm
ZXItPmJpdHNfcGVyX3dvcmQgYmVmb3JlIHBhc3NpbmcgdG8gdGhlIGNvbnRyb2xsZXIsIHRoYXQg
aXMsIHRoZSBjb250cm9sbGVyIGRyaXZlciBkb2VzIG5vdA0Ka25vdyB0aGUgdmFsdWUgb2YgYml0
c19wZXJfd29yZCwgYW5kIGl0IHdpbGwgdXNlIHRoaXMgdmFsdWUgd2hlbiB0aGUgdXBwZXIgbGV2
ZWwgc2V0cyB3aGF0IHZhbHVlIGlzIHBhc3NlZC4NCjIuIEFzIEkgdW5kZXJzdGFuZCwgYml0c19w
ZXJfd29yZCBkb2VzIG5vdCBleGlzdCBmb3Igbm9uLWJ5dGUgYWxpZ25tZW50LCBidXQgZm9yIHRo
ZSBuZWVkIHRvIHJlc2VydmUgbm9uLWJ5dGUgdHJhbnNtaXNzaW9uIG1vZGUgdGhhdCBtZWV0cyB0
aGUgY29udHJvbGxlci4NCjMuIEluIGFkZGl0aW9uLCBub3cgdGhlIFhTUEkgb2YgZHNwaSBjYW5u
b3QgdHJhbnNmZXIgZGF0YSBub3JtYWxseSwgc28gdGhpcyBwcm9ibGVtIG5lZWRzIHRvIGJlIHNv
bHZlZC4gQXMgZm9yIHRoZSBETUEgdHJhbnNmZXIgbW9kZSwgc29tZSBjb2xsZWFndWVzIHdpbGwg
c3R1ZHkgaXQuDQo=
