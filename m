Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C34F1C6783C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 13:17:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6900E2086A
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 13:17:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="OfCovVOW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6900E2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=toradex.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728683AbeJLUtZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 16:49:25 -0400
Received: from mail-ve1eur01on0100.outbound.protection.outlook.com ([104.47.1.100]:41927
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727838AbeJLUtZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 16:49:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i2w01vNoVs19n46WnfAfHxqz8UwEnFVghSyA4F+nfNk=;
 b=OfCovVOWsTRnxf9M3xqfLCVyKssjnLJ0YxLoVL3UQIzgUWegeMqAcpwkCyGGt1dU1iinVi7UY488HfMZRzY3UfLvWLoIPWIxBaAU6hwYeFy5j7FPNJ+uhYotgnQ7t2CT7Ef9j1Wy01WNMaJb83BJMSFUY3QZizNWXBuy3mrmLqw=
Received: from VI1PR0501MB2590.eurprd05.prod.outlook.com (10.168.137.14) by
 VI1PR0501MB2816.eurprd05.prod.outlook.com (10.172.11.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.23; Fri, 12 Oct 2018 13:16:54 +0000
Received: from VI1PR0501MB2590.eurprd05.prod.outlook.com
 ([fe80::99b0:2276:18cf:18aa]) by VI1PR0501MB2590.eurprd05.prod.outlook.com
 ([fe80::99b0:2276:18cf:18aa%3]) with mapi id 15.20.1207.029; Fri, 12 Oct 2018
 13:16:54 +0000
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
Thread-Index: AQHUX+RYijA+bfRpTEq+i5qM8FkYjKUbcTKAgAAqswA=
Date:   Fri, 12 Oct 2018 13:16:54 +0000
Message-ID: <1539350212.30485.48.camel@toradex.com>
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
x-microsoft-exchange-diagnostics: 1;VI1PR0501MB2816;6:3KMtS0bt14oCFDuqIuqhFCYKmegzV3CLgZ0f4et1jyU85EJ7lZJDbvPKhGIAVU/H0pH5I6xYZmrGoSGKjsQB+u+plVitgcFk+uZlCv2q7D1O28CQwe1kjBEinS83SnXaEW5r9bEtQl6QjAuwJTyUyVS1dDsd4xp24kf4C3UTltmoJsVtQGBKWkkjk+kKga+8heqdFC+U1k+FdJeY6owQGizjb/RpYQcfA9qiPOatGfWF4K2/nRKyM6WVFXw4pNkbVAR4XtmcqL3+jLrG3j4RWVW/yamDbmlL/2ksN9xbFa4FVT34HS/2DvaxUhiOUoI2RIqpCFO9bb5vYAf+pth9ji5Bc7xUwLGQMUHHVSptghQ1M92pnfvAJ2vqCm5xu4KjRMZq8rf/r0WsyDl/G/z0MhXgdLfBve6B1GSihlW+Csuay3vbTtfpkflDxhEtsX4gPyVi2ZiJov1wcPUOd37W1A==;5:rVfJYet5wfN6+rH7qGu7jlGeV7zjubQzKiXdsf3zB09ySFaOdtM32Ci7lnfR3zTqSWs7BTdLmzxLm2L9dJLzfXbdPUBfZMT0pAfWKenZjH2NpHH2gM2B1+X68uioMvviqL9F9hC/bztR1erY5nOeqQCxpR4LIeKxjm0RulRQ58o=;7:yWIpLEvqJxtRc1mScQfezaEsd8RmCzealzAkOKL0tGgIJKlphDuvmPsTBCGNVRFeWQpinJr/pnslUic3y6Nbl1iAJkF+U9Hhh1pS7yLpSDTWwpJY4Di3Z7CAeBz5Ef3bgtStXNtUOixgdc7Y5VYsVTdymnX27f/fBbp5TVdb1Y1njBgo8lpSWfE3ZEPVDQ0r20d9jrbY0AZn70O7jPLoqLOn9kcpslOSgM4mkY/r9FMPeuXxzkqba3FXzCaGX29U
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 673b9c24-06f7-49fe-e296-08d63044fb0a
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:VI1PR0501MB2816;
x-ms-traffictypediagnostic: VI1PR0501MB2816:
x-microsoft-antispam-prvs: <VI1PR0501MB28165E771F5F7B800E88DEE6FBE20@VI1PR0501MB2816.eurprd05.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231355)(944501410)(52105095)(3002001)(93006095)(93001095)(149066)(150057)(6041310)(20161123560045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(201708071742011)(7699051);SRVR:VI1PR0501MB2816;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0501MB2816;
x-forefront-prvs: 0823A5777B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(136003)(396003)(376002)(366004)(39840400004)(199004)(189003)(86362001)(6486002)(53936002)(44832011)(186003)(102836004)(36756003)(68736007)(26005)(39060400002)(2906002)(316002)(2201001)(66066001)(2501003)(5250100002)(81156014)(6436002)(81166006)(6512007)(6306002)(256004)(305945005)(229853002)(103116003)(14454004)(7736002)(478600001)(71190400001)(71200400001)(446003)(8936002)(11346002)(110136005)(966005)(54906003)(476003)(2616005)(8676002)(4001150100001)(6246003)(6116002)(105586002)(106356001)(99286004)(3846002)(4326008)(486006)(97736004)(2900100001)(53546011)(6506007)(76176011)(5660300001)(25786009);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0501MB2816;H:VI1PR0501MB2590.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: YI65ATKKJsgETc2Q9hAmDMt93YWUs48K4m+49pqX/ShG+3xirHRHrCvEtjxt9xRX26xiIzbT3H8/R75gHZ1WDllRVahUHO+gu/xhDGAMDMFcYs1yUwY+d1gwZt/AkAP6VHQWWsK8lNOZR1hXj+n/vQ67N3664vMlhmrduMxox+NeXZJa0LRwDGjgNKSnAShxpAKVhAHr+AhS0s6VH5NSoFuTKBnzmw6460LG3Dchuy3QLYg6JdYNdbGp+vfeDnlK99b8VFilf6SROaHicD8FNvC/ueqSnIZODUykDPNQPKnIDJbgnuE+P10nurYnFDBHs92VK7WtiJuC/qFauIaokJlBxW0Kzx+mY4k9LuACwbo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <6D5AD75123D9E340927C7A55A49DA621@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 673b9c24-06f7-49fe-e296-08d63044fb0a
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2018 13:16:54.6216
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0501MB2816
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDE4LTEwLTEyIGF0IDExOjQ0ICswMTAwLCBKb24gSHVudGVyIHdyb3RlOg0KPiBP
biAwOS8xMC8xOCAxNjoyNSwgTWFyY2VsIFppc3dpbGVyIHdyb3RlOg0KPiA+IEZyb206IE1hcmNl
bCBaaXN3aWxlciA8bWFyY2VsLnppc3dpbGVyQHRvcmFkZXguY29tPg0KPiA+IC4uLg0KPiA+IA0K
PiBHaXZlbiBMaW51cyBXJ3MgZml4IGZvciB0aGUgZ3Bpb2xpYiBbMF0sIEkgYW0gbm90IGNvbnZp
bmNlZCB0aGF0IHRoaXMNCj4gaXMNCj4gcmVhbGx5IGJldHRlci9uZWVkZWQuDQoNCkxvb2tzIGxp
a2Ugbm9ib2R5IGVsc2UgZmF2b3VycyB0aGlzIChyYXRoZXIgdGhlIG9wcG9zaXRlIGlzIHRoZSBj
YXNlIGl0DQpzZWVtcyBbMV0pIHNvIEkgd2lsbCBkcm9wIGl0IGluIGEgdjIuIFRoYW5rcyENCg0K
QW55IGZlZWRiYWNrIGFib3V0IGFueSBvZiB0aGUgb3RoZXIgcGF0Y2hlcz8NCg0KPiBDaGVlcnMN
Cj4gSm9uDQo+IA0KPiBbMF0gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvcGF0Y2h3b3JrL3BhdGNo
Lzk5ODM1NC8NCg0KWzFdIA0KaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGttbC8yMDE4MTAxMjEy
NTkxMS5HVDMwNjU4QG4yMTAwLmFybWxpbnV4Lm9yZy4NCnVrLw==
