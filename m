Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A139BC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 11:52:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C7962077C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 11:52:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="DJ9NQIYB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C7962077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=toradex.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728405AbeJLTYG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 15:24:06 -0400
Received: from mail-he1eur01on0096.outbound.protection.outlook.com ([104.47.0.96]:54656
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727816AbeJLTYF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 15:24:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ev6fVDQdVo2ycZb2pvr8yD07BN2H+Qyaa3n11EJRIso=;
 b=DJ9NQIYBXouVWC6geiDzHp4yoQqEfd8F0kAVpkUjyE90Wt+1gLC9mkTY95tFHHr4GwFCfHFC4dEVzktJiobTDl8SixnNBcRUCGf7r+LGvgzuAUKmFxH8NX3POC9Qbonen7zT6NrkYbk09TEjaH/+mKgvm7m10DJnrnxzG9txHpI=
Received: from VI1PR0501MB2590.eurprd05.prod.outlook.com (10.168.137.14) by
 VI1PR0501MB2304.eurprd05.prod.outlook.com (10.169.135.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.23; Fri, 12 Oct 2018 11:51:54 +0000
Received: from VI1PR0501MB2590.eurprd05.prod.outlook.com
 ([fe80::99b0:2276:18cf:18aa]) by VI1PR0501MB2590.eurprd05.prod.outlook.com
 ([fe80::99b0:2276:18cf:18aa%3]) with mapi id 15.20.1207.029; Fri, 12 Oct 2018
 11:51:54 +0000
From:   Marcel Ziswiler <marcel.ziswiler@toradex.com>
To:     "jonathanh@nvidia.com" <jonathanh@nvidia.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
CC:     "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
Subject: Re: [PATCH v1 3/8] ARM: tegra: apalis/colibri_t30: fix hdmi regulator
Thread-Topic: [PATCH v1 3/8] ARM: tegra: apalis/colibri_t30: fix hdmi
 regulator
Thread-Index: AQHUX+RYijA+bfRpTEq+i5qM8FkYjKUbcTKAgAAS8wA=
Date:   Fri, 12 Oct 2018 11:51:54 +0000
Message-ID: <1539345112.30485.34.camel@toradex.com>
References: <20181009152523.3771-1-marcel@ziswiler.com>
         <20181009152523.3771-4-marcel@ziswiler.com>
         <521e8eb0-ce63-851a-0637-a0207bec6a32@nvidia.com>
In-Reply-To: <521e8eb0-ce63-851a-0637-a0207bec6a32@nvidia.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=marcel.ziswiler@toradex.com; 
x-originating-ip: [188.155.129.42]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR0501MB2304;6:OYhpn0KKV7KM5qbKN8zJVhVnoHcR7yeEVf/AhG2hoefTYBxtIyevFG0ePI58GFGSrBrdfYYLo61MTWo6oQe88j/Rygy0OgPZtu8SWBE3OQASAmJdtnXvyT1gSbcIInSfDh3KkuWGMRosgObPfPPBoiO+ERQfEUej3Qz2xOHX2XcCDD2LjaBJfxT1Bp/eSzal5GSHtGuJQEu+xZUbNa5IgqX5jmNWaG1MOO2uVKJP6obx4AmPuT7zK3ZxkGEcyKvoJp2szm2T+P4UL7KSxxchGJ3hN2YkMZZK0K3TskVcI5h1eLMEqxAhg9A8o7YcH7UUTEi1ZiowpyjVc3A07X82uOw8iIsNQaO6Cui81H4on1TPy/DJrHgPaHHocEgNphF5F4a+25L8JQS3fU1ciE3qNlpspkSU15RbUXhBNczg/EMo9D3HueXixV2Jd56yZACPUOSKGcpZVbYzHE1KC4ndiA==;5:6D8kguXG/iGp83MszDSYvP7VZYqu8tmnaR5HpsC/wpr4jbffSMOaH4xnT93aC/iKuwsePx8pFDV3/xuaMtd5vrHkiRS44j+z+bsoh0maBroqv2bXcgPSUXEJgLlyK4+0qLPrrpbFxQb1WQf8sHYH4SmThjq/+bYqwOJnWouViT8=;7:xfHbdOuSeBEi5P1+Hh2aF7mXRV8Z1ZwcOMFI/Z1CSnV5L9FixHE7QZRftecFGRpYW2Bcmjv9cmzCk3H+IjQEgatcR1WOes+qv+0hzGfeD4W+mClDJyyFgH7UgFwuhSyaX/C/sAY+atF8myfuTShMW1Y5DzH8Yspz5dc7tuPYrnKT+HH1ULe5+u+55ZmiPNEtUbE9dfx/T1X4R5IHEtJqDVbngb11UZu2JC1jtm44TL7p5IE4V1k81lKfjyfwUlJ0
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 5a37e236-cc88-4d46-06df-08d630391b4d
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:VI1PR0501MB2304;
x-ms-traffictypediagnostic: VI1PR0501MB2304:
x-microsoft-antispam-prvs: <VI1PR0501MB2304F7DF769E608B487CABFAFBE20@VI1PR0501MB2304.eurprd05.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231355)(944501410)(52105095)(10201501046)(93006095)(93001095)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123558120)(20161123562045)(201708071742011)(7699051)(76991067);SRVR:VI1PR0501MB2304;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0501MB2304;
x-forefront-prvs: 0823A5777B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(396003)(136003)(39840400004)(366004)(189003)(199004)(229853002)(53936002)(6306002)(5660300001)(6512007)(6486002)(6436002)(66066001)(36756003)(4326008)(316002)(2501003)(5250100002)(4001150100001)(103116003)(6116002)(3846002)(25786009)(39060400002)(68736007)(256004)(97736004)(110136005)(54906003)(6246003)(2906002)(26005)(106356001)(186003)(105586002)(14454004)(99286004)(305945005)(8676002)(8936002)(6506007)(81166006)(81156014)(53546011)(7736002)(76176011)(102836004)(446003)(2201001)(2900100001)(71190400001)(44832011)(71200400001)(11346002)(86362001)(2616005)(486006)(476003)(478600001)(966005);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0501MB2304;H:VI1PR0501MB2590.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 7KBEIFxxHk5j/hduhHc2BtBZITXe8dTuep5/q46t16rvTArm9oBEgzFPKvsrbRbKAWnKPl3DjjAvC66UhMr+gRjU6P+PtWMPdNYoruEH+JJTLVeRXGoHuR7bIPDojqXYOCjA9FqYJmlYKA6mbjbyhYaJJ14W5JcmWt2dF74qF6dcfJJEXnyf9Y47s+cA5eFbT4ZVNODCHnW5EJn1xVVRp+B+6wyDvae7VYM7ghEhZhr4gHCPRew/LFSBc/2y3H4sPbAYJhvkSih2oElSpk7cnRtAwrEbKtX2lpWaEv5RbiLOTiV66Jy4p0er/j3fGRcuZRHBFGG5L4FceCnJqzc4TLUlp6aRtJjOk/dXdeBDxsg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <61A53C3CEB157A419B3E39A47935414D@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a37e236-cc88-4d46-06df-08d630391b4d
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2018 11:51:54.7764
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0501MB2304
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDE4LTEwLTEyIGF0IDExOjQ0ICswMTAwLCBKb24gSHVudGVyIHdyb3RlOg0KPiBP
biAwOS8xMC8xOCAxNjoyNSwgTWFyY2VsIFppc3dpbGVyIHdyb3RlOg0KPiA+IEZyb206IE1hcmNl
bCBaaXN3aWxlciA8bWFyY2VsLnppc3dpbGVyQHRvcmFkZXguY29tPg0KPiA+IC4uLg0KPiA+IA0K
PiBHaXZlbiBMaW51cyBXJ3MgZml4IGZvciB0aGUgZ3Bpb2xpYiBbMF0sIEkgYW0gbm90IGNvbnZp
bmNlZCB0aGF0IHRoaXMNCj4gaXMNCj4gcmVhbGx5IGJldHRlci9uZWVkZWQuDQoNCkJlaW5nIHBy
YWdtYXRpYyBhdCB0aGUgZW5kIG9mIHRoZSBkYXkgSSdtIGp1c3QgaGFwcHkgaWYgaXQgd29ya3Mg
YW5kIEkNCm1heSBqdXN0IGRyb3AgdGhpcyBvbmUgdGhlbiBpZiBub2JvZHkgZWxzZSBzZWVzIGFu
eSBhZHZhbnRhZ2UuDQoNCkFmdGVyIGFsbCB0aGVyZSBhcmUgc3RpbGwgZW5vdWdoIHJlYWxseSBi
cm9rZW4gdGhpbmdzIGxpa2UgYXVkaW8gb24NCkFwYWxpcyBUSzEuIE9mZiB0byBkZWJ1ZyB0aGF0
IG9uZSBmdXJ0aGVyLi4uIEFyZ2gsIC1FUFJPQkVfREVGRVIhDQoNCj4gQ2hlZXJzDQo+IEpvbg0K
PiANCj4gWzBdIGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3BhdGNod29yay9wYXRjaC85OTgzNTQv
