Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15974C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 14:11:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B432208B4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 14:11:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="WysGvDsE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B432208B4
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=toradex.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727523AbeH0R5x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 13:57:53 -0400
Received: from mail-eopbgr40095.outbound.protection.outlook.com ([40.107.4.95]:45285
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726925AbeH0R5x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 13:57:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d/3hltCn88nvefvLC2oxxQi+GVbkh2X4SX+IKiNNcpc=;
 b=WysGvDsEmM7JNo3h/t+LF9ZJympcvGbZp4cf1XNuIliTwWBNeqqveebG8DcwS4TjWRZCBgz+mZOcWXguBTJbITzJ9QjtYMNPkFPnOtBSSZGm5gw7WgX+DP7E+48Ck2idWLtrlVT2F1FRGHoxL6dK6NrngiRxV3JjmCOOxL+YHyA=
Received: from VI1PR0501MB2590.eurprd05.prod.outlook.com (10.168.137.14) by
 VI1PR0501MB2414.eurprd05.prod.outlook.com (10.168.135.146) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1080.14; Mon, 27 Aug 2018 14:10:59 +0000
Received: from VI1PR0501MB2590.eurprd05.prod.outlook.com
 ([fe80::3518:3302:dd0c:373c]) by VI1PR0501MB2590.eurprd05.prod.outlook.com
 ([fe80::3518:3302:dd0c:373c%9]) with mapi id 15.20.1080.015; Mon, 27 Aug 2018
 14:10:59 +0000
From:   Marcel Ziswiler <marcel.ziswiler@toradex.com>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "jonathanh@nvidia.com" <jonathanh@nvidia.com>,
        "mperttunen@nvidia.com" <mperttunen@nvidia.com>,
        "stefan@agner.ch" <stefan@agner.ch>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "avienamo@nvidia.com" <avienamo@nvidia.com>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH v2 00/40] Tegra SDHCI add support for HS200 and UHS
 signaling
Thread-Topic: [PATCH v2 00/40] Tegra SDHCI add support for HS200 and UHS
 signaling
Thread-Index: AQHUPg/HGq++aK93jEaiZwlnYtxzmw==
Date:   Mon, 27 Aug 2018 14:10:58 +0000
Message-ID: <1535379056.14664.13.camel@toradex.com>
References: <1533924522-1037-1-git-send-email-avienamo@nvidia.com>
In-Reply-To: <1533924522-1037-1-git-send-email-avienamo@nvidia.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=marcel.ziswiler@toradex.com; 
x-originating-ip: [46.140.72.82]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR0501MB2414;6:lAc9qsAWrXZyx8yu59Qv4ejOd5arE6KV1Ss7ayfsZq5hVcbTmNEhS/ZZg7wM3mQk9MEpyZYdXNJEeOHWUOYO7kxpgfa1OiO6uPjSHT5klJ0p05btmP7lTmI5/TzlePwlurcjkY0/6uQr1dH9hBY0Cfkqv5feLbPhHk2hTM+UErWRUCwQfW/EVJg72+ItF53FNbWld592MRTY0BmmrOsRwV0Wl7A926rDgUXUhMOcpeQ5oKvMErS8kFauF6kflVeoC95FWT9uUEhM4nQ1cDBPflZvFoQ3K8BD9kWXaLKfU4RgwpCbVbj3UfTVs5797r4oAV82sma/8WsOAtW+dDXh7sZJDelGwJxMgRV6cnqzPQVlG8mbVZmwX+RuIyio8XE1nrJJWAXpdQcRwUM2GUBw2+qAvaVN6aa9b4WjSonfQTD3J+TeRdyRb8uknegcSibnG4F0kFgzwLm/wG/BYukp/w==;5:pXB0/T4Rooh5sjd4WcWU19BRY4eafIbJZILpeAnJ2n6j0EqueUPP2dl2vXVboIaG6cEYlhH5eIKqAqNsbcNwAg70VFATRYSOyfRm/k50C1E64IgsfOBH5aE+rgLFJFA6PCbqJCAkREPQHF8b+S2V405Y1bU5kUB9qLgt4msNzgQ=;7:lZVN9ctD5Ewx12OQECYTsZmuq/p9KzLOVdC/4XneEn0MzATHdBXoGnz1ItsFncU+ZUyYHDBele+2cde702Z7TjHO6fYSmseO51BXbuxwxnNN5qbAHTtKR2sNqtHqkmEbeuP97vW5n8K8eWv24Lw9bLqbN6lYRUKVuYHIbd7ermhVABW6lnhMKiIJ51R91XiK98ulwswPAwf5hPSlROoYIdW7DzGGbTYf05BwJyNH5Q8ZB6EMnnZ6E9Ot6viCmvev
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: b279ab3b-ba54-45e5-7deb-08d60c26e9c9
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:VI1PR0501MB2414;
x-ms-traffictypediagnostic: VI1PR0501MB2414:
x-microsoft-antispam-prvs: <VI1PR0501MB2414DDB6009CC82967215B3EFB0B0@VI1PR0501MB2414.eurprd05.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231311)(944501410)(52105095)(93006095)(93001095)(10201501046)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(201708071742011)(7699016);SRVR:VI1PR0501MB2414;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0501MB2414;
x-forefront-prvs: 07778E4001
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(366004)(346002)(136003)(396003)(39840400004)(189003)(199004)(53754006)(103116003)(14454004)(102836004)(14444005)(6506007)(256004)(486006)(7736002)(478600001)(53936002)(305945005)(5660300001)(106356001)(105586002)(186003)(76176011)(36756003)(2201001)(81156014)(110136005)(6436002)(446003)(229853002)(66066001)(6486002)(476003)(8676002)(99286004)(54906003)(8936002)(68736007)(7416002)(6116002)(3846002)(2616005)(6512007)(11346002)(86362001)(316002)(4326008)(5250100002)(81166006)(39060400002)(26005)(6246003)(2906002)(44832011)(25786009)(97736004)(2501003)(2900100001);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0501MB2414;H:VI1PR0501MB2590.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: wuBQu9gEgoCMJTcfR4RiHTOq4i5a3CzzEYKjwakNxMaxlwmlF5Dr+rGIX3RGESKjBR3B858MqArJx2hShIzNLGwXljATX+1rES32p4EVJDi6k8eL5MVN6bPNXkKrAOUJwAEIY73A02Kf2BY2uxL3JM3FurNyt2RWil5RmddWtkzEV47ijOOGYi1LJQB8fZAUVw/DgwupYrxSJNhC6qrqnvDJEfx3E7rU6jpWZbTh7mMTiCHIN08YP83iGBuEHMXYz/jVxm9mexriIQhn1WFjl/URvJhv6Cc4RfdewfN25gyAIHaL8FHfF1BFs4FgoGezNXQ/H0/9L/EjcRPRV86fGNnPI5DMwP8519hKP1LrQpk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <F318BFD43C1A544BBDF1FC66C4B87AA9@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b279ab3b-ba54-45e5-7deb-08d60c26e9c9
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Aug 2018 14:10:58.8215
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0501MB2414
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDE4LTA4LTEwIGF0IDIxOjA4ICswMzAwLCBBYXBvIFZpZW5hbW8gd3JvdGU6DQo+
IEhpIGFsbCwNCj4gDQo+IFRoaXMgc2VyaWVzIGltcGxlbWVudHMgc3VwcG9ydCBmb3IgZmFzdGVy
IHNpZ25hbGluZyBtb2RlcyBvbiBUZWdyYQ0KPiBTREhDSSBjb250cm9sbGVycy4gVGhpcyBzZXJp
ZXMgY29uc2lzdCBvZiBzZXZlcmFsIHBhcnRzOiBjaGFuZ2VzDQo+IHJlcXVyaWVkIGZvciAxLjgg
ViBzaWduYWxpbmcgYW5kIHBhZCBjb250cm9sLCBwYWQgY2FsaWJyYXRpb24sIGFuZA0KPiB0dW5p
bmcuIEZvbGxvd2luZyBlYXJsaWVzIHBhdGNoIHNldHMgaGF2ZSBiZWVuIG1lcmdlZCBpbnRvIHRo
aXMNCj4gbGFyZ2VyIHNldDogIlRlZ3JhIFBNQyBwaW5jdHJsIHBhZCBjb25maWd1cmF0aW9uIiwg
IlRlZ3JhIFNESENJDQo+IGVuYWJsZQ0KPiAxLjggViBzaWduYWxpbmcgb24gVGVnYXIyMTAgYW5k
IFRlZ3JhMTg2IiwgIlRlZ3JhIFNESENJIHVwZGF0ZSB0aGUNCj4gcGFkYXV0b2NhbCBwcm9jZWR1
cmUiLiBBbHNvIHRoZSBwYXRjaGVzIGZvciBlbmFibGluZyBTREhDSSB0dW5pbmcNCj4gYXJlIGFk
ZGVkLg0KDQpJIHRyaWVkIHlvdXIgdGtsbi9oczIwMCBicmFuY2ggb24gQ29saWJyaSBUMjAsIEFw
YWxpcy9Db2xpYnJpIFQzMCBhbmQNCkFwYWxpcyBUSzEuIEl0IGF0IGxlYXN0IGRvZXMgbm90IHNl
ZW0gdG8gbWFrZSB0aGluZ3MgYW55IHdvcnNlIGJ1dA0KSFMyMDAgb24gVEsxIHN0aWxsIHNlZW1z
IHRvIGJlaGF2ZSBzdHJhbmdlbHkuIER1cmluZyBib290IEkgZG8gZ2V0IHRoZQ0KZm9sbG93aW5n
IG1lc3NhZ2UgKG1tYzAgYmVpbmcgdGhlIFNESENJIGluc3RhbmNlIG9mIG9uZSBvZiB0aGVtIFNE
IGNhcmQNCnNsb3RzKToNCg0KWyAgICAzLjIzODM2MF0gbW1jMDogSW50ZXJuYWwgY2xvY2sgbmV2
ZXIgc3RhYmlsaXNlZC4NClsgICAgMy4yNDMxODNdIG1tYzA6IHNkaGNpOiA9PT09PT09PT09PT0g
U0RIQ0kgUkVHSVNURVIgRFVNUA0KPT09PT09PT09PT0NClsgICAgMy4yNDk2NDldIG1tYzA6IHNk
aGNpOiBTeXMgYWRkcjogIDB4MDAwMDAwMDAgfA0KVmVyc2lvbjogIDB4MDAwMDAzMDMNClsgICAg
My4yNTYxMzhdIG1tYzA6IHNkaGNpOiBCbGsgc2l6ZTogIDB4MDAwMDAwMDAgfCBCbGsNCmNudDog
IDB4MDAwMDAwMDANClsgICAgMy4yNjI2NTddIG1tYzA6IHNkaGNpOiBBcmd1bWVudDogIDB4MDAw
MDAwMDAgfCBUcm4gbW9kZToNCjB4MDAwMDAwMDANClsgICAgMy4yNjkxMTldIG1tYzA6IHNkaGNp
OiBQcmVzZW50OiAgIDB4MDFmYjAwZjAgfCBIb3N0IGN0bDoNCjB4MDAwMDAwMDANClsgICAgMy4y
NzU1ODBdIG1tYzA6IHNkaGNpOiBQb3dlcjogICAgIDB4MDAwMDAwMGYgfCBCbGsNCmdhcDogIDB4
MDAwMDAwMDANClsgICAgMy4yODIwNDFdIG1tYzA6IHNkaGNpOiBXYWtlLXVwOiAgIDB4MDAwMDAw
MDAgfA0KQ2xvY2s6ICAgIDB4MDAwMDA0MDENClsgICAgMy4yODg0ODVdIG1tYzA6IHNkaGNpOiBU
aW1lb3V0OiAgIDB4MDAwMDAwMDAgfCBJbnQgc3RhdDoNCjB4MDAwMDAwMDANClsgICAgMy4yOTUw
MzddIG1tYzA6IHNkaGNpOiBJbnQgZW5hYjogIDB4MDBmZjAwMDMgfCBTaWcgZW5hYjoNCjB4MDBm
YzAwMDMNClsgICAgMy4zMDE1NTldIG1tYzA6IHNkaGNpOiBBQzEyIGVycjogIDB4MDAwMDAwMDAg
fCBTbG90IGludDoNCjB4MDAwMDAwMDANClsgICAgMy4zMDgwMjJdIG1tYzA6IHNkaGNpOiBDYXBz
OiAgICAgIDB4Mzc2ZmQwODAgfA0KQ2Fwc18xOiAgIDB4MTAwMDBmNzANClsgICAgMy4zMTQ1Mjdd
IG1tYzA6IHNkaGNpOiBDbWQ6ICAgICAgIDB4MDAwMDAwMDAgfCBNYXggY3VycjoNCjB4MDAwMDAw
MDANClsgICAgMy4zMjExNTldIG1tYzA6IHNkaGNpOiBSZXNwWzBdOiAgIDB4MDAwMDAwMDAgfA0K
UmVzcFsxXTogIDB4MDAwMDAwMDANClsgICAgMy4zMjc2NDJdIG1tYzA6IHNkaGNpOiBSZXNwWzJd
OiAgIDB4MDAwMDAwMDAgfA0KUmVzcFszXTogIDB4MDAwMDAwMDANClsgICAgMy4zMzQxNDRdIG1t
YzA6IHNkaGNpOiBIb3N0IGN0bDI6IDB4MDAwMDAwMDANClsgICAgMy4zMzg2MTNdIG1tYzA6IHNk
aGNpOiBBRE1BIEVycjogIDB4MDAwMDAwMDAgfCBBRE1BIFB0cjoNCjB4MDAwMDAwMDANClsgICAg
My4zNDUxMTBdIG1tYzA6IHNkaGNpOg0KPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT0NCg0KQW5kIGl0IHN1YnNlcXVlbnRseSBzdGFsbHMgd2FpdGluZyBmb3IgaW50
ZXJydXB0IGZvciBtb3JlIHRoYW4gOA0Kc2Vjb25kcyBiZWZvcmUgY29udGludWluZyB0byBtb3Vu
dCB0aGUgcm9vdGZzIGFzIGZvbGxvd3MgKG1tYzIgYmVpbmcNCnRoZSBTREhDSSBpbnN0YW5jZSBv
ZiB0aGUgZU1NQyk6DQoNClsgICAgNC44NzQwMTddIHRlZ3JhLWhkbWkgNTQyODAwMDAuaGRtaTog
Y2Fubm90IHNldCBhdWRpbyB0byA0ODAwMCBIeg0KYXQgMjk3MDAwMDAwIEh6IHBpeGVsIGNsb2Nr
DQpbICAgMTMuOTMwMTM2XSBtbWMyOiBUaW1lb3V0IHdhaXRpbmcgZm9yIGhhcmR3YXJlIGludGVy
cnVwdC4NClsgICAxMy45MzU2MDNdIG1tYzI6IHNkaGNpOiA9PT09PT09PT09PT0gU0RIQ0kgUkVH
SVNURVIgRFVNUA0KPT09PT09PT09PT0NClsgICAxMy45NDIwNzFdIG1tYzI6IHNkaGNpOiBTeXMg
YWRkcjogIDB4MDAwMDAwMDAgfA0KVmVyc2lvbjogIDB4MDAwMDAzMDMNClsgICAxMy45NDg1MTFd
IG1tYzI6IHNkaGNpOiBCbGsgc2l6ZTogIDB4MDAwMDcwODAgfCBCbGsNCmNudDogIDB4MDAwMDAw
MDENClsgICAxMy45NTQ5NDhdIG1tYzI6IHNkaGNpOiBBcmd1bWVudDogIDB4MDAwMDAwMDAgfCBU
cm4gbW9kZToNCjB4MDAwMDAwMTMNClsgICAxMy45NjEzODVdIG1tYzI6IHNkaGNpOiBQcmVzZW50
OiAgIDB4MDFmYjAwZjAgfCBIb3N0IGN0bDoNCjB4MDAwMDAwMzENClsgICAxMy45Njc4MjFdIG1t
YzI6IHNkaGNpOiBQb3dlcjogICAgIDB4MDAwMDAwMDEgfCBCbGsNCmdhcDogIDB4MDAwMDAwMDAN
ClsgICAxMy45NzQyNjNdIG1tYzI6IHNkaGNpOiBXYWtlLXVwOiAgIDB4MDAwMDAwMDAgfA0KQ2xv
Y2s6ICAgIDB4MDAwMDAwMDcNClsgICAxMy45ODA2OTJdIG1tYzI6IHNkaGNpOiBUaW1lb3V0OiAg
IDB4MDAwMDAwMGUgfCBJbnQgc3RhdDoNCjB4MDAwMDAwMDANClsgICAxMy45ODcxMTldIG1tYzI6
IHNkaGNpOiBJbnQgZW5hYjogIDB4MDJmZjAwMGIgfCBTaWcgZW5hYjoNCjB4MDJmYzAwMGINClsg
ICAxMy45OTM1NDZdIG1tYzI6IHNkaGNpOiBBQzEyIGVycjogIDB4MDAwMDAwMDAgfCBTbG90IGlu
dDoNCjB4MDAwMDAwMDANClsgICAxMy45OTk5NzRdIG1tYzI6IHNkaGNpOiBDYXBzOiAgICAgIDB4
Mzc2ZmQwODAgfA0KQ2Fwc18xOiAgIDB4MTAwMDBmNzANClsgICAxNC4wMDY0MTVdIG1tYzI6IHNk
aGNpOiBDbWQ6ICAgICAgIDB4MDAwMDE1M2EgfCBNYXggY3VycjoNCjB4MDAwMDAwMDANClsgICAx
NC4wMTI4NDVdIG1tYzI6IHNkaGNpOiBSZXNwWzBdOiAgIDB4MDAwMDBiMDAgfA0KUmVzcFsxXTog
IDB4MDQ4MDYyYmYNClsgICAxNC4wMTkyNzJdIG1tYzI6IHNkaGNpOiBSZXNwWzJdOiAgIDB4MzE0
YTgwMDAgfA0KUmVzcFszXTogIDB4MDAwMDAyNDANClsgICAxNC4wMjU2OTddIG1tYzI6IHNkaGNp
OiBIb3N0IGN0bDI6IDB4MDAwMDAwMGINClsgICAxNC4wMzAxMzJdIG1tYzI6IHNkaGNpOiBBRE1B
IEVycjogIDB4MDAwMDAwMDAgfCBBRE1BIFB0cjoNCjB4ZmJjNmIyMDgNClsgICAxNC4wMzY1NjFd
IG1tYzI6IHNkaGNpOg0KPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT0NClsgICAxNC4wNDQzMzJdIG1tYzI6IG5ldyBIUzIwMCBNTUMgY2FyZCBhdCBhZGRyZXNzIDAw
MDENClsgICAxNC4wNTA2NTZdIG1tY2JsazI6IG1tYzI6MDAwMSAwMTZHMzAgMTQuNyBHaUINClsg
ICAxNC4wNTYzNzZdIG1tY2JsazJib290MDogbW1jMjowMDAxIDAxNkczMCBwYXJ0aXRpb24gMSA0
LjAwIE1pQg0KWyAgIDE0LjA2MzU2M10gbW1jYmxrMmJvb3QxOiBtbWMyOjAwMDEgMDE2RzMwIHBh
cnRpdGlvbiAyIDQuMDAgTWlCDQpbICAgMTQuMDY5NTg5XSBtbWNibGsycnBtYjogbW1jMjowMDAx
IDAxNkczMCBwYXJ0aXRpb24gMyA0LjAwIE1pQiwNCmNoYXJkZXYgKDI0NzowKQ0KWyAgIDE0LjA3
ODI2MF0gIG1tY2JsazI6IHAxIHAyDQoNCkFmdGVyIHRoYXQgaXQgYWN0dWFsbHkgc2VlbXMgdG8g
d29yayBxdWl0ZSBuaWNlbHk6DQoNCnJvb3RAYXBhbGlzLXRrMS1tYWlubGluZTp+IyBjYXQgL3N5
cy9rZXJuZWwvZGVidWcvbW1jMi9pb3MNCmNsb2NrOiAgICAgICAgICAyMDAwMDAwMDAgSHoNCmFj
dHVhbCBjbG9jazogICAxNjMyMDAwMDAgSHoNCnZkZDogICAgICAgICAgICAyMSAoMy4zIH4gMy40
IFYpDQpidXMgbW9kZTogICAgICAgMiAocHVzaC1wdWxsKQ0KY2hpcCBzZWxlY3Q6ICAgIDAgKGRv
bid0IGNhcmUpDQpwb3dlciBtb2RlOiAgICAgMiAob24pDQpidXMgd2lkdGg6ICAgICAgMyAoOCBi
aXRzKQ0KdGltaW5nIHNwZWM6ICAgIDkgKG1tYyBIUzIwMCkNCnNpZ25hbCB2b2x0YWdlOiAxICgx
LjgwIFYpDQpkcml2ZXIgdHlwZTogICAgMCAoZHJpdmVyIHR5cGUgQikNCnJvb3RAYXBhbGlzLXRr
MS1tYWlubGluZTp+IyBoZHBhcm0gLXQgL2Rldi9tbWNibGsyDQoNCi9kZXYvbW1jYmxrMjoNCiBU
aW1pbmcgYnVmZmVyZWQgZGlzayByZWFkczogNDA4IE1CIGluICAzLjAxIHNlY29uZHMgPSAxMzUu
MzkgTUIvc2VjDQoNCkhhdmUgeW91IGV2ZXIgb2JzZXJ2ZWQgc2ltaWxhciBiZWhhdmlvdXI/IFdo
YXQgY291bGQgY2F1c2UgdGhpcz8NCg0KQW55Ym9keSBlbHNlIHRyaWVkIGl0IG9uIFRLMT8=
