Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBFA8C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 08:57:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E1322084D
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 08:57:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="XUux74dJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E1322084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727996AbeH2Mxi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 08:53:38 -0400
Received: from mail-eopbgr60085.outbound.protection.outlook.com ([40.107.6.85]:13390
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727204AbeH2Mxi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 08:53:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YZnKvMsnqnR2c2m1qLdYvAPsdrer562BgsVYvei2GH0=;
 b=XUux74dJoOEqfOzynDhwySV6J/eqibkVUlLsGWU9icTAT28h8I2Way0GCpOrforKfZ01V6bvpohBThrmcU4NgcoSuN4pwDtvZ1dQshoOHlODIwFtp+SUzWrM5CtS7DRHkDuepPc2wyI1c92lXKKH9V6C9eZKWX+4Jtx03Kd3VqQ=
Received: from VI1PR04MB3247.eurprd04.prod.outlook.com (10.170.232.160) by
 VI1PR04MB1567.eurprd04.prod.outlook.com (10.164.84.29) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1080.17; Wed, 29 Aug 2018 08:57:40 +0000
Received: from VI1PR04MB3247.eurprd04.prod.outlook.com
 ([fe80::c529:ccae:df5:7515]) by VI1PR04MB3247.eurprd04.prod.outlook.com
 ([fe80::c529:ccae:df5:7515%2]) with mapi id 15.20.1101.007; Wed, 29 Aug 2018
 08:57:40 +0000
From:   Qiang Zhao <qiang.zhao@nxp.com>
To:     Rob Herring <robh@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Leo Li <leoyang.li@nxp.com>, Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-soc@vger.kernel.org" <linux-soc@vger.kernel.org>
Subject: RE: [PATCH] soc: Convert to using %pOFn instead of device_node.name
Thread-Topic: [PATCH] soc: Convert to using %pOFn instead of device_node.name
Thread-Index: AQHUPnIqbJWxkCbSU0umg/lfaM6+KKTWbxBg
Date:   Wed, 29 Aug 2018 08:57:40 +0000
Message-ID: <VI1PR04MB3247DA20AA7C6242B90FA6DA91090@VI1PR04MB3247.eurprd04.prod.outlook.com>
References: <20180828015252.28511-1-robh@kernel.org>
 <20180828015252.28511-43-robh@kernel.org>
In-Reply-To: <20180828015252.28511-43-robh@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=qiang.zhao@nxp.com; 
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR04MB1567;6:w1F+4T+4hsbIJJWQ7rYtU9hFOu/hSj4TyO4nqDnwh9Qi/jYOpOYVjDsRfw3f2xLZMiPUPDolZuJNz/oj1LpwxyaNkLHMTEsBkd5lPiodBiPgvTUw+it2MTznEwqJY2woXPS8ADwqx7MxEPQKo5mv6P3TgI609RHqBtKT0VnwX0NmJW9T50dcA8SbaQ4vZn1lliezyD6cUiJutvKWx81ESLaShXWIF+jYGPtJLCiCrri7lWeM0drzk3nxDMnR3FtVgAU3SNp6fwcAthKLPXLN6iml4Uhfo3Fi/6M7ddePHdVlPUqS0mkhOJicNm0Fiu5DDj4n4FgQCUDTcoJuj+pdnwi17THiUpoDgR8p+udxo1sioEsqQyuHb1nCOjJs/wHQVPC9ShhJ0g6tDnb5xfcHE+pBe+DKxImjh4XlM0VjZsMIX/5ZILJjCXcjPR4b+/YEe8Rb0PdrJ4Hk8YZc78kE9w==;5:WSbFDl3RaMsjUennNRwf26RTSIouyfGdvXWV5PBi+E0JRxXYYJ/Ghkrmsx0sUukGX7Q0Vy0T8R29EhQqiyAnmc4rExPotpn+s7fLAFTyUkrBXaX4EHVVWJwTMbEEviKMdXJ+xsmonuSHLvGitvZlEGdDCly3omTUUPxNvtYKd3s=;7:l2JWbKDDgvukrCXxKXQqC33YToIxjtc1d+qr7RvNk0TazB4EGMtwfPNoNJ6B/FVLdWEDI6ARI/VhgiwdwMtG0bJkeKxA5ZJnVT3VPwZ5MvhoJn1w01s7AYjk9Vt8zstt8vT0K/F1RotfYqwtR42jgPdmGFrwKk8HGjn7TYk4CgYilRWwOix0zfx78iipSzXNC24FdxPRZho63PMM7fZ09gXHTMcsfrSVHD1/LybgbYU+ZtxReo+tANHX+i206N9p
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 1b92f68e-1df0-4cf0-0ded-08d60d8d799c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB1567;
x-ms-traffictypediagnostic: VI1PR04MB1567:
x-microsoft-antispam-prvs: <VI1PR04MB1567D743574623B851D0C16B91090@VI1PR04MB1567.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(65623756079841)(185117386973197)(85827821059158)(18589796830644)(258649278758335);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(823301075)(10201501046)(3002001)(93006095)(93001095)(3231311)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699016);SRVR:VI1PR04MB1567;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB1567;
x-forefront-prvs: 077929D941
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(136003)(376002)(346002)(396003)(199004)(189003)(2900100001)(8936002)(2906002)(66066001)(14454004)(110136005)(33656002)(54906003)(6246003)(229853002)(256004)(6436002)(81156014)(81166006)(316002)(97736004)(105586002)(106356001)(476003)(11346002)(4326008)(446003)(7416002)(44832011)(7736002)(305945005)(486006)(74316002)(25786009)(39060400002)(55016002)(68736007)(478600001)(5660300001)(3846002)(6116002)(8676002)(9686003)(99286004)(53936002)(76176011)(2501003)(102836004)(6506007)(186003)(5250100002)(86362001)(7696005)(26005)(53546011);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB1567;H:VI1PR04MB3247.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: N7J7A4Jb6oudIvNARMHxMmguIMQ9S2gIPkdhN8//Mspf2YdAm+y0OYm74kkuaSc7KoV/EXlgQ+2yBA1ptJ3OOOhzwzyIXIwoG1ZGlU3j1iEE4fAYvLgCg9ZLadjAM5TbaU5FmVJl8RF2CJVulVoT2e5NSUDly90ojgX5TNSOBYb0TJsQW3lh1Fs8www8JxwxqW6fSJDu4C1rMBpXFfKelPQVCcQlfXCaN4SXqRQAbxg76ujcbKtogjmO9N2+kaBlC4irmJrLGJGXboNCwJ7ayvGKEWJKaMpt+ppcAotIPvS+LYqf99wE0AUxCfa3f6z+DmNqc+IBT7ybuStRy2HnPlN6Bhiz7IwJeHrG5PcY3gw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b92f68e-1df0-4cf0-0ded-08d60d8d799c
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2018 08:57:40.0230
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB1567
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogUm9iIEhlcnJpbmcgPHJvYmhAa2VybmVsLm9yZz4NCkRhdGU6IDIwMTjE6jjUwjI4yNUg
OTo1Mw0KPiBUbzogbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiBDYzogUWlhbmcgWmhh
byA8cWlhbmcuemhhb0BueHAuY29tPjsgTGVvIExpIDxsZW95YW5nLmxpQG54cC5jb20+OyBBbmR5
DQo+IEdyb3NzIDxhbmR5Lmdyb3NzQGxpbmFyby5vcmc+OyBEYXZpZCBCcm93biA8ZGF2aWQuYnJv
d25AbGluYXJvLm9yZz47IEhlaWtvDQo+IFN0dWVibmVyIDxoZWlrb0BzbnRlY2guZGU+OyBUaGll
cnJ5IFJlZGluZyA8dGhpZXJyeS5yZWRpbmdAZ21haWwuY29tPjsNCj4gSm9uYXRoYW4gSHVudGVy
IDxqb25hdGhhbmhAbnZpZGlhLmNvbT47IFNhbnRvc2ggU2hpbGlta2FyDQo+IDxzc2FudG9zaEBr
ZXJuZWwub3JnPjsgbGludXhwcGMtZGV2QGxpc3RzLm96bGFicy5vcmc7DQo+IGxpbnV4LWFybS1r
ZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsgbGludXgtc29jQHZnZXIua2VybmVsLm9yZw0KPiBT
dWJqZWN0OiBbUEFUQ0hdIHNvYzogQ29udmVydCB0byB1c2luZyAlcE9GbiBpbnN0ZWFkIG9mIGRl
dmljZV9ub2RlLm5hbWUNCj4gDQo+IEluIHByZXBhcmF0aW9uIHRvIHJlbW92ZSB0aGUgbm9kZSBu
YW1lIHBvaW50ZXIgZnJvbSBzdHJ1Y3QgZGV2aWNlX25vZGUsDQo+IGNvbnZlcnQgcHJpbnRmIHVz
ZXJzIHRvIHVzZSB0aGUgJXBPRm4gZm9ybWF0IHNwZWNpZmllci4NCj4gDQo+IENjOiBRaWFuZyBa
aGFvIDxxaWFuZy56aGFvQG54cC5jb20+DQo+IENjOiBMaSBZYW5nIDxsZW95YW5nLmxpQG54cC5j
b20+DQo+IENjOiBBbmR5IEdyb3NzIDxhbmR5Lmdyb3NzQGxpbmFyby5vcmc+DQo+IENjOiBEYXZp
ZCBCcm93biA8ZGF2aWQuYnJvd25AbGluYXJvLm9yZz4NCj4gQ2M6IEhlaWtvIFN0dWVibmVyIDxo
ZWlrb0BzbnRlY2guZGU+DQo+IENjOiBUaGllcnJ5IFJlZGluZyA8dGhpZXJyeS5yZWRpbmdAZ21h
aWwuY29tPg0KPiBDYzogSm9uYXRoYW4gSHVudGVyIDxqb25hdGhhbmhAbnZpZGlhLmNvbT4NCj4g
Q2M6IFNhbnRvc2ggU2hpbGlta2FyIDxzc2FudG9zaEBrZXJuZWwub3JnPg0KPiBDYzogbGludXhw
cGMtZGV2QGxpc3RzLm96bGFicy5vcmcNCj4gQ2M6IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5m
cmFkZWFkLm9yZw0KPiBDYzogbGludXgtc29jQHZnZXIua2VybmVsLm9yZw0KPiBTaWduZWQtb2Zm
LWJ5OiBSb2IgSGVycmluZyA8cm9iaEBrZXJuZWwub3JnPg0KPiAtLS0NCj4gIGRyaXZlcnMvc29j
L2RvdmUvcG11LmMgICAgICAgICAgICB8ICA4ICsrKy0tLQ0KPiAgZHJpdmVycy9zb2MvZnNsL3Fl
L3FlX3RkbS5jICAgICAgIHwgIDQgKy0tDQo+ICBkcml2ZXJzL3NvYy9xY29tL2Fwci5jICAgICAg
ICAgICAgfCAgMiArLQ0KPiAgZHJpdmVycy9zb2Mvcm9ja2NoaXAvcG1fZG9tYWlucy5jIHwgNDQg
KysrKysrKysrKysrKysrLS0tLS0tLS0tLS0tLS0tLQ0KPiAgZHJpdmVycy9zb2MvdGVncmEvcG1j
LmMgICAgICAgICAgIHwgMTIgKysrKy0tLS0tDQo+ICBkcml2ZXJzL3NvYy90aS9rbmF2X2RtYS5j
ICAgICAgICAgfCAgOCArKystLS0NCj4gIGRyaXZlcnMvc29jL3RpL2tuYXZfcW1zc19xdWV1ZS5j
ICB8ICA4ICsrKy0tLQ0KPiAgNyBmaWxlcyBjaGFuZ2VkLCA0MyBpbnNlcnRpb25zKCspLCA0MyBk
ZWxldGlvbnMoLSkNCg0KRm9yIHFlX3RkbSBwYXJ0DQpBY2tlZC1ieTogUWlhbmcgWmhhbyA8cWlh
bmcuemhhb0BueHAuY29tPg0KDQo=
