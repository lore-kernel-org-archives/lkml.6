Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06494ECE567
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 16:58:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B22F2150E
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 16:58:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="SophqA2U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B22F2150E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=toradex.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390766AbeIUWsV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 18:48:21 -0400
Received: from mail-eopbgr50095.outbound.protection.outlook.com ([40.107.5.95]:21568
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728149AbeIUWsV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 18:48:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Q2QZoIooO/X0fB5vw0yEyupKW0678Nc8K1skm0rGik=;
 b=SophqA2Ul6GRgSY25/Xc15YHv5temdcrdfasYWFxEJCM0/WyLNsx6kpbGY3+yOY0FqQ3fw4qdqxfmaduf/L5evJLM67eG3wjRsclK6NeiKGRPrYWJjbBMAYcT39MN96kM/n4rRs3UpTJphLJDsilopQiT+Xi72b46harisl9XRY=
Received: from VI1PR0501MB2590.eurprd05.prod.outlook.com (10.168.137.14) by
 VI1PR0501MB2173.eurprd05.prod.outlook.com (10.169.134.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.18; Fri, 21 Sep 2018 16:58:30 +0000
Received: from VI1PR0501MB2590.eurprd05.prod.outlook.com
 ([fe80::2952:58bf:2bbb:eb4a]) by VI1PR0501MB2590.eurprd05.prod.outlook.com
 ([fe80::2952:58bf:2bbb:eb4a%4]) with mapi id 15.20.1143.017; Fri, 21 Sep 2018
 16:58:29 +0000
From:   Marcel Ziswiler <marcel.ziswiler@toradex.com>
To:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "golf@perches.com" <golf@perches.com>,
        "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
CC:     "boris.brezillon@bootlin.com" <boris.brezillon@bootlin.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "andrew@aj.id.au" <andrew@aj.id.au>,
        "joel@jms.id.au" <joel@jms.id.au>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>
Subject: Re: [RESEND PATCH 1/6] ARM: config: multi_v5: enable dynamic debug
Thread-Topic: [RESEND PATCH 1/6] ARM: config: multi_v5: enable dynamic debug
Thread-Index: AQHUM9gKrdXB2936Tk+Tpb9dtde8maS/SxmAgAJOcgCAOZdlAA==
Date:   Fri, 21 Sep 2018 16:58:29 +0000
Message-ID: <1537549106.6513.1.camel@toradex.com>
References: <20180814140612.12554-1-marcel@ziswiler.com>
         <9461e62248cc7c1b5585004ff8cf7268b823e29c.camel@perches.com>
         <f20387e3-4cce-78eb-886c-03ab8c39ae42@gmail.com>
In-Reply-To: <f20387e3-4cce-78eb-886c-03ab8c39ae42@gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [89.217.215.226]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR0501MB2173;6:YvURHk4tx5Cil2V00T5wpz+Fn6d0q0dA6ekCpsksgF3ETfvEJrlINUQxloPNkWTiCdhjw0yW5IFQQsaSPi+bCa1AEwtdJ+Eqwit19V09TaAuL82Tags12FVLZpFZbHz8n9JCPHrBu5Ekuxa9+MBGbpLnlj4x3Tc2vjwqpKFQg7heIc2IiS8LGBf5jnQF4wFB2gXuMVAnXA4mbtTxrE1KqIw47mgA4T0JtCruW4hrqORHV5oJbu0tn0ErrfPZK/LZGZIWy6k9zvxLx3nUoxR5M7vjek1W41DqRlDCb8hB6vWYLGXL7taifcp1tEmRIAWD9td0ylNLKZS+95/ghFuVJU5CJUwWTmMnOZnAoWG4CF2Vk/+iphWNINoyBtFaFZX5IdSD71cKE31ry+DX9TOhhOGrAe4Qfc7Cj0emMnfP/HcLt0LLfs5f7D7JA6PHsatVYJw5dirkT0pLmZqcPRYWfA==;5:f4WZbscGPBVhUK0yCbVklxv6cdWrbQASzEz/+Mcj+rfcpp7D5FfX1D22tBCTVUUXJiGG53eeKClsE+xQm5jue4QpBLOBpBEamsxidWOKPYsHusfX9/oP+9L1XRp5LnmcqPkcawCnZrWlcvj7grpc/GSiIzZdJaf/7JsAmlhafWM=;7:vsJ/9Ubw4MzIy5w68lUMRmL9NSKi5bQKU2HekwAMWPJX5e5VQC5AyFLwpcXp/1rO/M1taVAZ7Wrh0BBarGB7jPSAllMlSSu3tPRUYIJH8OIQ46sGbX1LMlK2WYB8rzL3QL3NZZhCl78mRydPUJRFdhkAjAajgyJgmJgID6J6I5uh0roCixzcXTSVZnOzI7TNWLvfCGN4OdywoNbl8OeRVol1ebw4hHI5nBksHpPo7zShb8OtwHWsusT+DG2dpOL9
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 68dd27e3-83d8-4275-2a46-08d61fe374f6
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:VI1PR0501MB2173;
x-ms-traffictypediagnostic: VI1PR0501MB2173:
x-microsoft-antispam-prvs: <VI1PR0501MB217336C08B255655986A52ECFB120@VI1PR0501MB2173.eurprd05.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(258649278758335);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(10201501046)(93006095)(93001095)(3002001)(149027)(150027)(6041310)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991041);SRVR:VI1PR0501MB2173;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0501MB2173;
x-forefront-prvs: 0802ADD973
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39850400004)(376002)(346002)(396003)(136003)(366004)(189003)(199004)(105586002)(6512007)(229853002)(53936002)(3846002)(6116002)(103116003)(6436002)(6486002)(5660300001)(966005)(6306002)(36756003)(2906002)(4326008)(14454004)(5250100002)(81166006)(1720100001)(2900100001)(6346003)(68736007)(66066001)(102836004)(6246003)(25786009)(39060400002)(54906003)(106356001)(2501003)(76176011)(8676002)(478600001)(99286004)(316002)(2201001)(446003)(186003)(486006)(11346002)(256004)(44832011)(7416002)(97736004)(2616005)(86362001)(81156014)(110136005)(53546011)(6506007)(476003)(26005)(7736002)(8936002)(217873002)(71190400001)(305945005)(71200400001);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0501MB2173;H:VI1PR0501MB2590.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=marcel.ziswiler@toradex.com; 
x-microsoft-antispam-message-info: 1xYJNz3MGJQOovK4g71R9tskAzZuHfZoMg0YCpH0ufcSMaWpf68M7sYyGVoQyDAx/bI/OxENZXomeWivn/Zo8e36/XGyAsRNSJEdlB9KhfuISMlXe68zL/v92OM+dQ1GfdtlKuQu4rGobsOg9229C8m8r6SbRf3zwE6UKompWV+APootpd7s4MRmhW4VF/acuIBlyXflnLzgibs88BZV31jXlalse0u3kJn/An0HeSc3u8FximC1mwO9CupDfc+d3jaLr9zQrXgwyhQV0yHy5hTd8nlRi0V6B/m1eDDM0VZV9S0QT0aemclwDgJ4lT/4/bJmskLLIVrS0yDpGOuvTCmD5qU+hv8hK1Nuz/RpVW8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <FBACB5C17289DF4E9483FAAC4ACA2F1E@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68dd27e3-83d8-4275-2a46-08d61fe374f6
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2018 16:58:29.7508
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0501MB2173
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDE4LTA4LTE1IGF0IDE4OjI5IC0wNzAwLCBGbG9yaWFuIEZhaW5lbGxpIHdyb3Rl
Og0KPiANCj4gT24gMDgvMTQvMjAxOCAwNzoxNiBBTSwgSm9lIFBlcmNoZXMgd3JvdGU6DQo+ID4g
T24gVHVlLCAyMDE4LTA4LTE0IGF0IDE2OjA2ICswMjAwLCBNYXJjZWwgWmlzd2lsZXIgd3JvdGU6
DQo+ID4gPiBGcm9tOiBNYXJjZWwgWmlzd2lsZXIgPG1hcmNlbC56aXN3aWxlckB0b3JhZGV4LmNv
bT4NCj4gPiA+IA0KPiA+ID4gRHluYW1pYyBkZWJ1ZyBpcyByZWFsbHkgaGVscGZ1bC4NCj4gPiAN
Cj4gPiBJdCdzIHVzZWZ1bCwgYnV0IHBlcmhhcHMgbm90IGFwcHJvcHJpYXRlLg0KPiA+IA0KPiA+
IE1vc3QgYXJtIGNvbmZpZ3MgYXJlIGZvciBzbWFsbCByZXNvdXJjZSBjb25zdHJhaW5lZCBzeXN0
ZW1zLg0KPiANCj4gWWVzLCBidXQgbXVsdGlfdipfZGVmY29uZmlnLCBieSBkZWZpbml0aW9uIGFy
ZSBub3QsIHNvIHRoaXMgcmVhbGx5DQo+IHNlZW1zDQo+IGFjY2VwdGFibGUgdG8gbWUgaGVyZS4N
Cg0KV2hhdCBpcyB0aGUgY29uY2x1c2lvbiBub3c/IElzIGFueWJvZHkgZ29uYSBwdWxsIHRoaXMg
cGF0Y2hzZXQgaW4/IE9yDQphcmUgYW55IGNoYW5nZXMgbmVlZGVkPw0KDQo+ID4gZHluYW1pY19k
ZWJ1ZyBhZGRzIGEgbG90IG9mIGFkZGl0aW9uYWwgdGV4dCBhbmQgYSBmYWlyIGFtb3VudCBvZg0K
PiA+IGRhdGEuDQo+ID4gDQo+ID4gDQo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBNYXJjZWwgWmlzd2ls
ZXIgPG1hcmNlbC56aXN3aWxlckB0b3JhZGV4LmNvbT4NCj4gPiA+IA0KPiA+ID4gLS0tDQo+ID4g
PiANCj4gPiA+ICBhcmNoL2FybS9jb25maWdzL211bHRpX3Y1X2RlZmNvbmZpZyB8IDEgKw0KPiA+
ID4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQ0KPiA+ID4gDQo+ID4gPiBkaWZmIC0t
Z2l0IGEvYXJjaC9hcm0vY29uZmlncy9tdWx0aV92NV9kZWZjb25maWcNCj4gPiA+IGIvYXJjaC9h
cm0vY29uZmlncy9tdWx0aV92NV9kZWZjb25maWcNCj4gPiA+IGluZGV4IDMxOGI3NmZhMjZkMS4u
YjMwMmFjNjhkNTg3IDEwMDY0NA0KPiA+ID4gLS0tIGEvYXJjaC9hcm0vY29uZmlncy9tdWx0aV92
NV9kZWZjb25maWcNCj4gPiA+ICsrKyBiL2FyY2gvYXJtL2NvbmZpZ3MvbXVsdGlfdjVfZGVmY29u
ZmlnDQo+ID4gPiBAQCAtMjc1LDYgKzI3NSw3IEBAIENPTkZJR19OTFNfQ09ERVBBR0VfODUwPXkN
Cj4gPiA+ICBDT05GSUdfTkxTX0lTTzg4NTlfMT15DQo+ID4gPiAgQ09ORklHX05MU19JU084ODU5
XzI9eQ0KPiA+ID4gIENPTkZJR19OTFNfVVRGOD15DQo+ID4gPiArQ09ORklHX0RZTkFNSUNfREVC
VUc9eQ0KPiA+ID4gIENPTkZJR19ERUJVR19JTkZPPXkNCj4gPiA+ICBDT05GSUdfREVCVUdfRlM9
eQ0KPiA+ID4gIENPTkZJR19NQUdJQ19TWVNSUT15DQo+ID4gDQo+ID4gX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18NCj4gPiBsaW51eC1hcm0ta2VybmVsIG1h
aWxpbmcgbGlzdA0KPiA+IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZw0KPiA+
IGh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtl
cm5lbA==
