Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8B11C4646D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 11:37:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72B2421737
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 11:37:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="nzbJXePS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72B2421737
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727028AbeHHN4j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 09:56:39 -0400
Received: from mail-eopbgr80041.outbound.protection.outlook.com ([40.107.8.41]:25351
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726733AbeHHN4j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 09:56:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O4a8BM8MGccC9ji2HrQcQR50o8yPzr2/QlSy/LqkKdc=;
 b=nzbJXePStM/AV4H9KAEffDlEhFn0p4Cvt9zsAG7dwiIpWCxeZdNeEKhBS2cM974/mVVckeHU9s5MZ4aI6ea8hzAsZqoWh+VzYen1pz7Adlr7sYKFv4W5Aj21anTKYwd/wYa8Yt9YHWfCpZkxicp31tYWQD5tZoAk5ybXMqIr67Y=
Received: from AM0PR04MB4290.eurprd04.prod.outlook.com (52.134.126.145) by
 AM0PR04MB4147.eurprd04.prod.outlook.com (52.134.125.157) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1038.22; Wed, 8 Aug 2018 11:37:14 +0000
Received: from AM0PR04MB4290.eurprd04.prod.outlook.com
 ([fe80::c96b:d6f5:db75:1273]) by AM0PR04MB4290.eurprd04.prod.outlook.com
 ([fe80::c96b:d6f5:db75:1273%5]) with mapi id 15.20.1038.019; Wed, 8 Aug 2018
 11:37:14 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>
CC:     dl-linux-imx <linux-imx@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "A.s. Dong" <aisheng.dong@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "Joao.Pinto@synopsys.com" <Joao.Pinto@synopsys.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "andrew.smirnov@gmail.com" <andrew.smirnov@gmail.com>,
        Anson Huang <anson.huang@nxp.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: Re: [PATCH v3 0/2] PCI: imx: Initial imx7d pm support
Thread-Topic: [PATCH v3 0/2] PCI: imx: Initial imx7d pm support
Thread-Index: AQHUI2mAdxFCdwbsIEW0mCMYIbqjI6S1xVuAgAAFxICAAAZagA==
Date:   Wed, 8 Aug 2018 11:37:14 +0000
Message-ID: <a5556be9a5f62ea0472a1a2336bce8d71df0dcaa.camel@nxp.com>
References: <cover.1532448745.git.leonard.crestez@nxp.com>
         <bac2cb70b16d81f589915fc0900126b516414243.camel@nxp.com>
         <20180808111429.GC25150@e107981-ln.cambridge.arm.com>
In-Reply-To: <20180808111429.GC25150@e107981-ln.cambridge.arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.1-2 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [95.76.156.53]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR04MB4147;6:pvD+Jsrb2TGg7G2RrJ+BR/cdvChAP3B9VI1BHGNANAed2MgEI34/iNY/JMFroyM+oYZpOXLUEijV/KkoFu/eoqIC/YHAGdnyiTDWOKF8y2Gh29/jneskfbyH5kRzeTo+FitZqI9aPKeWiJZbcDEgNndv+d3gw3YQqZC/EucsEZ8Lydsa1FqkVWiLYPaAgtq2dtJ1GUzyzBtQ0Itz+V1PKaebT3i/DoEucixUVMICJgFh0egUbufZXos5s/gHlXM7kUg6Kv3NWzx/iLZY4HOhjlMf4TihMsznIyWRulDKVq5vLIgjGHWC6xXFuUZXQQpNHrOdFixhw5UhcOMyjRd9wZ8+GGtQh8QqmMYc27SILCxJYKTmSSnN0bYfNuHwYIHGHTZhhYXsrydyxjTqWnVmYA4fhxg4PoOaHGeeiA17dPQvBLIux13qUp0WtmMOK2MwAh+y5Hv0ga2oCgLKY7IhGg==;5:w6Nda8VKb51X3XSQrzQwlfmYXmZKFW6vl479dggZPNm6Cq70UnQuN0Fv4TMxJuFskH25rzRfDpx9P+iq9z9JoPm1vz/c25vGwSdSlBO4733LJpELdgAwhOcGzpJWApZ2DMWYI60PskAlvnMnrnaQcRb46qF/4vWBnvr9VxILhAs=;7:bymWfVWCBEzzzLSF9a6rO899WGeotgJuCA+ZJ5kyT8IOcHAiIwL+cZmQHd7CS39Uepk0EfNd6IwW2zZuDLUVKu/Yf0tSGfFoKvg8fdmGbB6KHQvATsTTE/xXqRcdhSlIKJ2Bn/j04B+TZMkcB17R6tjAW401TNg9Xh8x+cliGx6TXq8Y9qahsngCSEgsNplZT8Z/ttJuh3X18YIvgXmrLSlj5QxQknq80T+6Pg2za9rqB41hqKlPS5TFUe1Lbn2E
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: a5cbac27-8223-46d4-d4b2-08d5fd2349b7
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB4147;
x-ms-traffictypediagnostic: AM0PR04MB4147:
x-microsoft-antispam-prvs: <AM0PR04MB4147747AAAEC8D48ADA225C6EE260@AM0PR04MB4147.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(189930954265078)(45079756050767);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231311)(944501410)(52105095)(10201501046)(3002001)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123560045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:AM0PR04MB4147;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB4147;
x-forefront-prvs: 07584EDBCD
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(376002)(39860400002)(346002)(366004)(136003)(199004)(189003)(5660300001)(26005)(2900100001)(6916009)(316002)(186003)(54906003)(2351001)(4326008)(106356001)(105586002)(6506007)(6512007)(97736004)(102836004)(2906002)(53936002)(8936002)(14454004)(11346002)(476003)(2616005)(446003)(5640700003)(25786009)(966005)(478600001)(7416002)(486006)(45080400002)(6116002)(39060400002)(36756003)(5250100002)(2501003)(44832011)(14444005)(256004)(6246003)(99286004)(305945005)(86362001)(66066001)(3846002)(8676002)(68736007)(6486002)(81166006)(76176011)(81156014)(118296001)(6436002)(7736002)(50226002)(229853002)(6306002)(99106002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4147;H:AM0PR04MB4290.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: SjAR0n2kcN5v9JkDDXPsXZ/Eh7bFca6O8K5U4oLoEmLs43GIRMiA/5IjQrAaXhBj9xCMUOQCZRl9p4OWg1twEz28QuRiKu9e+RB6/JKdv8sPNi7pt0HUif3EcqAa+Lb/UHH6EV957H6SiLJpMdoraK+Vu5GGwHcpj41Cls6CHOnckMfda21X3jnUpN2VbJU2DyIbjJT/cRENCbOIDkqHvZMlNzG3Ykm/FXq3QU/cGE1ZFMdR/uCm9xa1yGWOgdzHHxEW0ReMJJUg8fQ4g8vPt4AESxpMwNhaOrBx34P+z0sHeZG0zqvGeoxErbQVpDLhaxZskIFgBmFuHSPQMkruCOgB+iXf4/DYTIGWMpqCOU4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <D54A979F4DEDD84E930F1E94CADC6524@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5cbac27-8223-46d4-d4b2-08d5fd2349b7
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Aug 2018 11:37:14.4039
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4147
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDE4LTA4LTA4IGF0IDEyOjE0ICswMTAwLCBMb3JlbnpvIFBpZXJhbGlzaSB3cm90
ZToNCj4gT24gV2VkLCBBdWcgMDgsIDIwMTggYXQgMTA6NTM6NTJBTSArMDAwMCwgTGVvbmFyZCBD
cmVzdGV6IHdyb3RlOg0KPiA+IE9uIFR1ZSwgMjAxOC0wNy0yNCBhdCAxOToxNCArMDMwMCwgTGVv
bmFyZCBDcmVzdGV6IHdyb3RlOg0KPiA+ID4gQ2hhbmdlcyBzaW5jZSB2MjoNCj4gPiA+ICAqIFBy
aW50IHdpdGggZGV2X2luZm8gaWYgbGluayBmYWlscyBvbiByZXN1bWUgKEx1Y2FzKQ0KPiA+ID4g
ICogQWRkIGEgY29tbWVudCBvbiBpbXg3ZCBwY2kgaXJxIG1hcHBpbmdzIChBbmRyZXkpDQo+ID4g
PiAgKiBNYWtlIGlteDZfcGNpZV9sdHNzbV9kaXNhYmxlIHByaW50IGFuIGVycm9yIG9uIElNWDZR
IChMdWNhcykNCj4gPiA+IA0KPiA+ID4gVGhlIGx0c3NtX2Rpc2FibGUgZG9lcyBub3QgcmV0dXJu
IGFuIGVycm9yIGJlY2F1c2UgaXQgY2FuJ3QgYmUgdXNlZnVsbHkNCj4gPiA+IGhhbmRsZWQsIHJl
dmVyc2luZyBwYXJ0aWFsIHN1c3BlbmQgaXMgYSBuaWdodG1hcmUgYW5kIHVubGlrZWx5IHRvIHdv
cmsuDQo+ID4gPiANCj4gPiA+ICAqIERyb3AgInJlc2V0OiBpbXg3OiBGaXggYWx3YXlzIHdyaXRp
bmcgYml0cyBhcyAwIChhY2NlcHRlZCBieSBQaGlsaXBwKQ0KPiA+ID4gDQo+ID4gPiBTZXJpZXMg
aXMgYWdhaW5zdCBsaW51eC1uZXh0IHRhZyBuZXh0LTIwMTgwNzI0IHdoZXJlIHRoZSByZXNldCBw
YXRjaCB3YXMNCj4gPiA+IGFscmVhZHkgYWNjZXB0ZWQuIFRoZSBpbXg3ZC5kdHNpIHBhdGNoIGlz
IGFsc28gdXNlZnVsIHN0YW5kYWxvbmUuDQo+ID4gPiANCj4gPiA+IExpbmsgdG8gdjI6IGh0dHBz
Oi8vZW1lYTAxLnNhZmVsaW5rcy5wcm90ZWN0aW9uLm91dGxvb2suY29tLz91cmw9aHR0cHMlM0El
MkYlMkZsa21sLm9yZyUyRmxrbWwlMkYyMDE4JTJGNyUyRjIwJTJGNDcyJmFtcDtkYXRhPTAyJTdD
MDElN0NsZW9uYXJkLmNyZXN0ZXolNDBueHAuY29tJTdDYzFlOTg1MTJhNTAyNDZjNDU3YTIwOGQ1
ZmQyMDIxZGMlN0M2ODZlYTFkM2JjMmI0YzZmYTkyY2Q5OWM1YzMwMTYzNSU3QzAlN0MwJTdDNjM2
NjkzMjM2ODExMjQ4Nzc3JmFtcDtzZGF0YT1neHMxJTJCZmV2SWFCbVFDVmNKTFVLNDFtbDhDSzJ6
TGclMkZGS0dHViUyRiUyRkhTTFElM0QmYW1wO3Jlc2VydmVkPTANCj4gPiANCj4gPiBUaGlzIGlz
IGEgZ2VudGxlIHJlbWluZGVyIHRoYXQgdGhpcyBzZXJpZXMgd2FzIHJldmlld2VkIGJ5IEx1Y2Fz
IHR3bw0KPiA+IHdlZWtzIGFnbyBidXQgbm90IHlldCBpbmNsdWRlZC4NCj4gDQo+IERvZXMgdGhp
cyBzZXJpZXMgaGF2ZSBhIGZ1bmN0aW9uYWwgZGVwZW5kZW5jeSBvbiB0aGUgcmVzZXQgZml4ID8g
SWYgeWVzDQo+IHdlIGNhbiBoYXZlIGEgYmlzZWN0aW9uIHByb3BsZW0gZGVwZW5kaW5nIG9uIHdo
aWNoIHRyZWUgZ2V0cyBtZXJnZWQNCj4gZmlyc3QuDQoNClllcywgd2l0aG91dCB0aGUgcmVzZXQg
Zml4IEkgZXhwZWN0IGhhbmdzLg0KDQpNYXliZSB0aGUgcmVzZXQgZml4IHNob3VsZCBiZSBwdWxs
ZWQgaW4gdGhlIHBjaSB0cmVlPyBJIGRvbid0IGtub3cgaG93DQp0aGVzZSBpc3N1ZXMgYXJlIHNv
cnRlZCBvdXQu
