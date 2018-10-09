Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B871C32788
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 22:56:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 148E32087D
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 22:56:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="hxvTjsdr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 148E32087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726731AbeJJGPc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 02:15:32 -0400
Received: from mail-ve1eur01on0087.outbound.protection.outlook.com ([104.47.1.87]:52027
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725748AbeJJGPc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 02:15:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mwiowa2eqkofnGaSPvJgZoKq18XdU0IYw4hW/JJcMuA=;
 b=hxvTjsdrFp0ttYSLih6saZUz2caMtAQqzCZ20Cd+wpfbFju7hu+CY6sHAIbL0haLKNkCj/p5YEZ0E+xdIXnXguXBSBd3bG7Fc8a4LZaRviQ2ujNoXsMhWi1ZH9pOsK8rf0Dht3fm6MwPE4SKLbW2RscZb9BPpy6CAb0wrfLyfB0=
Received: from AM0PR04MB4290.eurprd04.prod.outlook.com (52.134.126.145) by
 AM0PR04MB5314.eurprd04.prod.outlook.com (20.177.42.87) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.23; Tue, 9 Oct 2018 22:56:14 +0000
Received: from AM0PR04MB4290.eurprd04.prod.outlook.com
 ([fe80::3836:6416:4ebd:34ef]) by AM0PR04MB4290.eurprd04.prod.outlook.com
 ([fe80::3836:6416:4ebd:34ef%3]) with mapi id 15.20.1207.029; Tue, 9 Oct 2018
 22:56:14 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        Abel Vesa <abel.vesa@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "A.s. Dong" <aisheng.dong@nxp.com>
CC:     dl-linux-imx <linux-imx@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "abelvesa@linux.com" <abelvesa@linux.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>
Subject: Re: [PATCH v10 4/5] clk: imx: add imx composite clock
Thread-Topic: [PATCH v10 4/5] clk: imx: add imx composite clock
Thread-Index: AQHUX6tSKa6+rH5QiEuV7vcmHTUupKUXhzeA
Date:   Tue, 9 Oct 2018 22:56:14 +0000
Message-ID: <5c0cc4de8403fca17431a9382f7e34e8003f497b.camel@nxp.com>
References: <1539074230-27277-1-git-send-email-abel.vesa@nxp.com>
         <1539074230-27277-5-git-send-email-abel.vesa@nxp.com>
In-Reply-To: <1539074230-27277-5-git-send-email-abel.vesa@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [85.204.4.237]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR04MB5314;6:vz6eNnoRmTWewS3yf2idi5CGftRRPZWcyfWVIXSPFdP3FlSEkhwFgjKHgA35Ro+0H2PmvozfWQOW4V8Ts+c0fTP5XcodDThRR+LFxiHwBqIriNy313+lzicm33U/wYzdcz/8a/pVaV7fjad3WB/Q1TJeuzLvrjkUTeFNVrWVQ9/FWIjwC/nHS9P9nhdLWI/v6WtSf1u7gpT8An8XVRvJ4xujUp4YSHgIdZlRAfF7AkjibdgJ+EzNtS6COfqfRH0hWls/XHH7A+xlLIsnKeAotRwIAaByQng/9pXD/KQRvnfQG+AUGw61rQi57cAkIA1djtuyDRwg94r3aLdBiETo8DAOUm+1kB0+VtpxIZDOJuWMLdpUnxeWbM4LXAhxj/0lEG1Ob9uI6ZiZoxnDcSPPplLQ7czeBEXKNoUXPxxRKJGazCywOd0veTS8MxRtcE6J4ZuRzxzhGft7Z4d6ckRyGQ==;5:TeF+sGfF04shidN8JWjrbxW63iQJZlr0+Pjx5JkVIDcJy4/DxJdq/VxPM9UMjDvQlOD/frZeEizx4E1FH0FQzQzmP6wInuGxpywgq5mwBjY+oDWZz8ZrNBa1YYKsfQusBbSZhqjmxGrx15vwLUdDT/lQs22/l8nkOdOrM+fw4LI=;7:/i/gQKb+Dqxzaw5J1f3dWOZjRC+8/b86N11EZdeRepx9jlReMrUuhnTdHAPlWfde9cpDStIXPc/gJQbnHxpSQaMpht2484olFOG4a3oRBOuZV8jsTrNUL8j3qr+oEQowpWv53yxrccx0c9H5HUJ4BnXjOP8lK3+aLJDzysu3MkX2Xc033caS87O4iJ/t2ofzmx/IeP6JPi6mtP3BbkuwG+sAlgyNNucClUB1KaFoVrBzqvvu7XHV3hBJiqU3ttNX
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 486ef59d-6647-4873-5779-08d62e3a6a1c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534185)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB5314;
x-ms-traffictypediagnostic: AM0PR04MB5314:
x-microsoft-antispam-prvs: <AM0PR04MB53142A6AB1596F5BBBDF6EF3EEE70@AM0PR04MB5314.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231355)(944501410)(52105095)(6055026)(149066)(150057)(6041310)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051);SRVR:AM0PR04MB5314;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB5314;
x-forefront-prvs: 08200063E9
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(346002)(366004)(136003)(396003)(376002)(189003)(199004)(476003)(14454004)(8936002)(81166006)(7416002)(54906003)(8676002)(81156014)(2900100001)(6636002)(118296001)(5660300001)(71200400001)(71190400001)(7736002)(305945005)(99286004)(6506007)(97736004)(36756003)(110136005)(76176011)(68736007)(53936002)(11346002)(2616005)(229853002)(6512007)(6436002)(25786009)(6486002)(2906002)(446003)(478600001)(6246003)(105586002)(106356001)(66066001)(256004)(44832011)(86362001)(2501003)(2201001)(486006)(186003)(4326008)(102836004)(316002)(6116002)(3846002)(26005)(5250100002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5314;H:AM0PR04MB4290.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: NcfFRSsom8OcswN04NgA4BUypPy5Bsi7YLCnVoq0pHhLSEq3hePebG69hhZwAHlAKuOhq8uNt9+v3U/6NHytuKsov61qGOeMJGlXLn4cGlm8wwlZOUDdgzXXeoTpABNyxvU1g57Vh7PO8W+3G9/nvIlAc5g2iXE4NjqSoBhV1YuYb9BEfx7h7LwKoAK0OZuFBFN28shO0oBFdypw/Ieg1NL6e2wolrf4tophYIlQSuyTejkt2M3KVVEI2rajS6LWINYU3S5K2GenGVe2XApYwvtwnNAhpSMTceNHDhh7maJo3l5OG6Hft+BOklNz26zaICQnNwGAZmY8BsprYp664NnIuyECxCT7Wzdm1A7JZiM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <AEA48455CA4CA74B83BCBD9A667AE2B6@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 486ef59d-6647-4873-5779-08d62e3a6a1c
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2018 22:56:14.1796
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5314
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDE4LTEwLTA5IGF0IDA4OjM3ICswMDAwLCBBYmVsIFZlc2Egd3JvdGU6DQo+ICtz
dHJ1Y3QgY2xrICppbXhfY2xrX2NvbXBvc2l0ZV84bV9mbGFncyhjb25zdCBjaGFyICpuYW1lLA0K
PiArCQkJCQljb25zdCBjaGFyICoqcGFyZW50X25hbWVzLA0KPiArCQkJCQlpbnQgbnVtX3BhcmVu
dHMsIHZvaWQgX19pb21lbSAqcmVnLA0KPiArCQkJCQl1bnNpZ25lZCBsb25nIGZsYWdzKTsNCj4g
Kw0KPiArI2RlZmluZSBfX2lteF9jbGtfY29tcG9zaXRlXzhtKG5hbWUsIHBhcmVudF9uYW1lcywg
cmVnLCBmbGFncykgXA0KPiArCWlteF9jbGtfY29tcG9zaXRlXzhtX2ZsYWdzKG5hbWUsIHBhcmVu
dF9uYW1lcywgXA0KPiArCQlBUlJBWV9TSVpFKHBhcmVudF9uYW1lcyksIHJlZywgXA0KPiArCQlm
bGFncyB8IENMS19TRVRfUkFURV9OT19SRVBBUkVOVCB8IENMS19PUFNfUEFSRU5UX0VOQUJMRSkN
Cj4gKw0KPiArI2RlZmluZSBpbXhfY2xrX2NvbXBvc2l0ZV84bShuYW1lLCBwYXJlbnRfbmFtZXMs
IHJlZykgXA0KPiArCV9faW14X2Nsa19jb21wb3NpdGVfOG0obmFtZSwgcGFyZW50X25hbWVzLCBy
ZWcsIDApDQo+ICsNCj4gKyNkZWZpbmUgaW14X2Nsa19jb21wb3NpdGVfOG1fY3JpdGljYWwobmFt
ZSwgcGFyZW50X25hbWVzLCByZWcpIFwNCj4gKwlfX2lteF9jbGtfY29tcG9zaXRlXzhtKG5hbWUs
IHBhcmVudF9uYW1lcywgcmVnLCBDTEtfSVNfQ1JJVElDQUwpDQoNCkRvZXMgYW55b25lIGVsc2Ug
dGhpbmsgdGhhdCB0aGUgIjhtIiB3b3VsZCBiZSBwcmV0dGllciBuZXh0IHRvIGlteA0KcmF0aGVy
IHRoYW4gYXMgYSBzdWZmaXg/IFVzaW5nIGlteDhtX2Nsa19jb21wb3NpdGUqIGFuZA0KaW14N3Vs
cF9jbGtfY29tcG9zaXRlKiBtYWtlcyBtb3JlIHNlbnNlIHRvIG1lLg0KDQotLQ0KUmVnYXJkcywN
Ckxlb25hcmQNCg==
