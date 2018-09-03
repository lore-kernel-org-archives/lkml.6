Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85A0EC43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 11:50:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18CE220843
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 11:50:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="aqSNa05Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18CE220843
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=toradex.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727635AbeICQKR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 12:10:17 -0400
Received: from mail-eopbgr50093.outbound.protection.outlook.com ([40.107.5.93]:27259
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727431AbeICQKQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 12:10:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kAzwfWpQ5ZWbNtBHWGJ56rVUhdhlnNcx2HKoJzWYaiM=;
 b=aqSNa05QLy7iLsO/9UvmAxDY1IMeSh8YqStVdvr3OY1oo/5k9Y/oXXKp1lRsfsVLWr8aVJQeOIJ8RdrAWqNnykmp/A+NY+EMF5cBt63ZTzaFZNHdj41k4TVSm7nETBAFFbl+Syyj3qDQMs78kSUL0IGmSpDDdASyBV2X0RZiBFU=
Received: from VI1PR0501MB2590.eurprd05.prod.outlook.com (10.168.137.14) by
 VI1PR0501MB2813.eurprd05.prod.outlook.com (10.172.11.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1080.17; Mon, 3 Sep 2018 11:50:23 +0000
Received: from VI1PR0501MB2590.eurprd05.prod.outlook.com
 ([fe80::79d0:3e0b:20af:4bb]) by VI1PR0501MB2590.eurprd05.prod.outlook.com
 ([fe80::79d0:3e0b:20af:4bb%8]) with mapi id 15.20.1101.016; Mon, 3 Sep 2018
 11:50:23 +0000
From:   Marcel Ziswiler <marcel.ziswiler@toradex.com>
To:     "daniel.thompson@linaro.org" <daniel.thompson@linaro.org>
CC:     "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "jonathanh@nvidia.com" <jonathanh@nvidia.com>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
Subject: Re: [PATCH v2 15/34] ARM: tegra: apalis_t30: reorder backlight
 properties
Thread-Topic: [PATCH v2 15/34] ARM: tegra: apalis_t30: reorder backlight
 properties
Thread-Index: AQHUQdz6KC63V7te6U2fuQ1UYm+FM6TeS4oAgAApUYA=
Date:   Mon, 3 Sep 2018 11:50:23 +0000
Message-ID: <1535975421.14464.2.camel@toradex.com>
References: <20180831163817.23970-1-marcel@ziswiler.com>
         <20180831163817.23970-16-marcel@ziswiler.com>
         <20180903092228.7k46uf6qehgou5wx@holly.lan>
In-Reply-To: <20180903092228.7k46uf6qehgou5wx@holly.lan>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=marcel.ziswiler@toradex.com; 
x-originating-ip: [46.140.72.82]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR0501MB2813;6:iRmOT8xJo8AH8vSW4CsTEFVVw+aQTwYHW04r8E4J4mb/i8Ut38cmOZVArOXQVvQsP8sq3M3t3IH+ENFXRmD8SVV4PifRqzow4rp4VH8oC6a5BwhRQK1Kfr+uyD9SRQMEWuPESgtJ5Kms0eR5Agm1IH9XB5zBSVqeX1rpM704+xeVSVF38/hSH5TUxtyYj530+DG6D9NiL5OHnDHZw2mZU9Lo6Ww4qu3FaB1+0PPoZ/75QLOAuY3yiKxFt3anSpT33UEp8wlnGfz4VCMZcLueHQL9iR0uJxe35Ny0Uk5fT7ev11WUecSPzKCQf1+Wy+EC/wMGnBHpCZBIkb3HvN2NE/QfAc/eOZkuc8eckpT/6qOIWNwCp6DUI1Ya6R501NN/SZj/WYqcOxX48xcpceyebl87Q1vPhqZEfRpJEBXRuFZkZebJhebbZiTkfAELYgC4n3CW3f4YUJt7exJUMiSFsA==;5:oGm6RJOARFXvPUtOw6aDCUADyLnW1eaGP/4KYv7c5rqJVO5Jl5iAana9JhCGKOSroUxHsN8XEoxAwHACnOIfEQ1Fpa7B/mqPbX62yw7JgT4p6m6FQiE9XJKR9xchysfhpvjGuv9UEvre3XRknC60U9f35gHr2lGs2WkQ66AyFw4=;7:pyFyMcqUvKMW2dJsv4lZ/+PLYX4xDWARToyGxHbjNGtug6UI+pvCgnN/o3+y0DdbzHYaKC6Z9++9ti9Nws2pIUbT5vBLlgJLeMhSaRAwRaVFjothZuqKGp2+/N7DyMMink5RTlxhl5DuYp+sF1Lu0u4rB125cnA/iKfv94qBA08o2T6WT8Hr4xIG98V7lK6sSOZt3zTnL5AVrRaz0U3SHktTtIAA8PkFBf4ycg25aicZJGClpP4EdndHbpjUnb/z
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: d3d1a2e7-e0ec-4fd0-e872-08d611936ecd
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:VI1PR0501MB2813;
x-ms-traffictypediagnostic: VI1PR0501MB2813:
x-microsoft-antispam-prvs: <VI1PR0501MB28135A201C014B310E844E8CFB0C0@VI1PR0501MB2813.eurprd05.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(3231311)(944501410)(52105095)(10201501046)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(201708071742011)(7699016);SRVR:VI1PR0501MB2813;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0501MB2813;
x-forefront-prvs: 0784C803FD
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(396003)(346002)(366004)(39840400004)(376002)(199004)(189003)(53234004)(76176011)(105586002)(6916009)(14454004)(39060400002)(99286004)(2906002)(8936002)(68736007)(8676002)(97736004)(6246003)(229853002)(2900100001)(2351001)(106356001)(7736002)(4326008)(256004)(316002)(36756003)(81156014)(476003)(486006)(446003)(305945005)(11346002)(2501003)(5250100002)(2616005)(81166006)(44832011)(6436002)(5640700003)(66066001)(186003)(26005)(103116003)(25786009)(6116002)(3846002)(6512007)(6486002)(478600001)(53936002)(6506007)(54906003)(5660300001)(102836004)(86362001);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0501MB2813;H:VI1PR0501MB2590.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: xWIYDYkwzSZBiG01COveuPZISIixJdBuWpnCiiJ6nbp+11SmlirWaCkBrsSiJoYCAZ/6IlpRPPS9TQ9fdt+XeK+MKEOmWllV6gl+HnLbPvZ6v1mhuJIBjogXvsHgPs5x+V9d65qk4HmUZE8OOlixgeuauw6pQLq0zDo+ifdCqJM8OMrFVcxt+qJg3i4t0qOro5ZZWUAxmY6cbTiXzXmsnNhpSXwAfTXljBNHaF5FrZY9uMj2/OgsarCVNzPevV7rkzItr11FAscsT0uJcvjOueHSTafJHE3VjCMxcEKEe2LZRwFzaBJg4TnTPO6bSjaFBpjhmUiqYN+pLpT9fBu3xK44/kJSR3X09B4/KpgdpEQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <D7D3751328FC16458C5888D171360193@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3d1a2e7-e0ec-4fd0-e872-08d611936ecd
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2018 11:50:23.4325
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0501MB2813
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDE4LTA5LTAzIGF0IDEwOjIyICswMTAwLCBEYW5pZWwgVGhvbXBzb24gd3JvdGU6
DQo+IE9uIEZyaSwgQXVnIDMxLCAyMDE4IGF0IDA2OjM3OjU3UE0gKzAyMDAsIE1hcmNlbCBaaXN3
aWxlciB3cm90ZToNCj4gPiBGcm9tOiBNYXJjZWwgWmlzd2lsZXIgPG1hcmNlbC56aXN3aWxlckB0
b3JhZGV4LmNvbT4NCj4gPiANCj4gPiBSZW9yZGVyIGJhY2tsaWdodCBwcm9wZXJ0aWVzLg0KPiAN
Cj4gVGhpcyBpcyBhIGJpdCB0ZXJzZS4gU2hvdWxkIHRoZSBoZWFkZXIgZXhwbGFpbiB3aHkgdG9v
Pw0KDQpJIGFncmVlLiBJIGd1ZXNzIEkgbWlzc2VkIG1lbnRpb25pbmcgaXQgaGVyZSBleHBsaWNp
dGx5LiBBdCBvdGhlcg0KcGxhY2VzIEkgZGlkIHVzdWFsbHkgbWVudGlvbmVkIHRoYXQgaXQgaW1w
cm92ZXMgdGhlIHNpdHVhdGlvbiBpbg0KcmVnYXJkcyB0byBhbGwgb3VyIG90aGVyIGRldmljZSB0
cmVlcy4gSXQncyBqdXN0IGEgcGFpbiB0byBsb29rIGF0DQp2YXJpb3VzIGRldmljZSB0cmVlcyBp
ZiBzdHVmZiBpcyByYW5kb21seSBvcmRlcmVkLg0KDQo+ID4gU2lnbmVkLW9mZi1ieTogTWFyY2Vs
IFppc3dpbGVyIDxtYXJjZWwuemlzd2lsZXJAdG9yYWRleC5jb20+DQo+ID4gDQo+ID4gLS0tDQo+
ID4gDQo+ID4gQ2hhbmdlcyBpbiB2MjogTm9uZQ0KPiA+IA0KPiA+ICBhcmNoL2FybS9ib290L2R0
cy90ZWdyYTMwLWFwYWxpcy1ldmFsLmR0cyB8IDMgKy0tDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAx
IGluc2VydGlvbigrKSwgMiBkZWxldGlvbnMoLSkNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvYXJj
aC9hcm0vYm9vdC9kdHMvdGVncmEzMC1hcGFsaXMtZXZhbC5kdHMNCj4gPiBiL2FyY2gvYXJtL2Jv
b3QvZHRzL3RlZ3JhMzAtYXBhbGlzLWV2YWwuZHRzDQo+ID4gaW5kZXggOWYyMzkyYTA1NTMyLi4z
MDBjZTcyNmZmNGQgMTAwNjQ0DQo+ID4gLS0tIGEvYXJjaC9hcm0vYm9vdC9kdHMvdGVncmEzMC1h
cGFsaXMtZXZhbC5kdHMNCj4gPiArKysgYi9hcmNoL2FybS9ib290L2R0cy90ZWdyYTMwLWFwYWxp
cy1ldmFsLmR0cw0KPiA+IEBAIC0xODUsMTMgKzE4NSwxMiBAQA0KPiA+ICANCj4gPiAgCWJhY2ts
aWdodDogYmFja2xpZ2h0IHsNCj4gPiAgCQljb21wYXRpYmxlID0gInB3bS1iYWNrbGlnaHQiOw0K
PiA+IC0JCS8qIFBXTV9CS0wxICovDQo+ID4gLQkJcHdtcyA9IDwmcHdtIDAgNTAwMDAwMD47DQo+
ID4gIAkJYnJpZ2h0bmVzcy1sZXZlbHMgPSA8MjU1IDIzMSAyMjMgMjA3IDE5MSAxNTkgMTI3DQo+
ID4gMD47DQo+ID4gIAkJZGVmYXVsdC1icmlnaHRuZXNzLWxldmVsID0gPDY+Ow0KPiA+ICAJCS8q
IEJLTDFfT04gKi8NCj4gPiAgCQllbmFibGUtZ3Bpb3MgPSA8JmdwaW8gVEVHUkFfR1BJTyhWLCAy
KQ0KPiA+IEdQSU9fQUNUSVZFX0hJR0g+Ow0KPiA+ICAJCXBvd2VyLXN1cHBseSA9IDwmcmVnXzN2
Mz47DQo+ID4gKwkJcHdtcyA9IDwmcHdtIDAgNTAwMDAwMD47IC8qIEJLTDFfUFdNICovDQo+ID4g
IAl9Ow0KPiA+ICANCj4gPiAgCWdwaW8ta2V5cyB7DQo+ID4gLS0gDQo+ID4gMi4xNC40
