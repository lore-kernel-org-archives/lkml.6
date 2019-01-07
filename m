Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58DFFC43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:51:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E3A120651
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:51:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ux31bil/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729304AbfAGMvP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 07:51:15 -0500
Received: from mail-eopbgr770083.outbound.protection.outlook.com ([40.107.77.83]:20828
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728605AbfAGMst (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 07:48:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4FeI5g1rNZ0vWmPplF85Y4lZWJpUVFXSM31Of1tl//I=;
 b=ux31bil/OOR7xmO9G2tOSTcpv8H1dbRtKM5YqKZ24fuI7Ieh9j1rOrbAuZh8p4Tgf5GqJ6swtAiJfjNU6l16cbSn8qUdqVe27zXYzj419JknVnQj/0EQ4I3vp71OKUBrUZr5+AIq2h14rkVJXPBHiPPIJR+FUVqE67k4k60A5cQ=
Received: from SN1PR12MB2575.namprd12.prod.outlook.com (52.132.197.151) by
 SN1PR12MB0798.namprd12.prod.outlook.com (10.164.26.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1495.6; Mon, 7 Jan 2019 12:48:41 +0000
Received: from SN1PR12MB2575.namprd12.prod.outlook.com
 ([fe80::1c91:d48a:16de:94ae]) by SN1PR12MB2575.namprd12.prod.outlook.com
 ([fe80::1c91:d48a:16de:94ae%4]) with mapi id 15.20.1495.011; Mon, 7 Jan 2019
 12:48:41 +0000
From:   "Shah, Nehal-bakulchandra" <Nehal-bakulchandra.Shah@amd.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Sinan Kaya <okaya@kernel.org>
CC:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Faiz Abbas <faiz_abbas@ti.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
        Ludovic Barre <ludovic.barre@st.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Alex Smith <alex.smith@imgtec.com>,
        Chris Brandt <chris.brandt@renesas.com>,
        "open list:MULTIMEDIA CARD (MMC), SECURE DIGITAL (SD) AND..." 
        <linux-mmc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Wang Dongsheng <dongsheng.wang@hxt-semitech.com>,
        Philip Elcan <pelcan@codeaurora.org>
Subject: Re: [PATCH v6 09/11] mmc: sdhci-acpi: Make PCI dependency explicit
Thread-Topic: [PATCH v6 09/11] mmc: sdhci-acpi: Make PCI dependency explicit
Thread-Index: AQHUpN5fB+S0V7sI+ku8JVIe6EbhvqWjq32AgAAXlICAAAG9AA==
Date:   Mon, 7 Jan 2019 12:48:41 +0000
Message-ID: <39e66940-87ea-f492-5e3b-3bdbe74edf78@amd.com>
References: <20190105100606.6673-1-okaya@kernel.org>
 <20190105100606.6673-10-okaya@kernel.org>
 <CAJZ5v0gXM3d0uuaQPyeafVS3S1tNbo0gY5TMskpQptNGvmVKzA@mail.gmail.com>
 <39fa9438-8928-5a1b-2a86-617df39e4c73@intel.com>
In-Reply-To: <39fa9438-8928-5a1b-2a86-617df39e4c73@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BMXPR01CA0010.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:d::20) To SN1PR12MB2575.namprd12.prod.outlook.com
 (2603:10b6:802:2b::23)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [202.56.249.162]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SN1PR12MB0798;20:5fdfeTBTtstol+cpo2TzFcPopeTK2jW3E6vLcyGrpfoLezk4CEpATb69IDu43tmOlKVwHSoV5qYtFHO3tUS9NNebvATUiRuo9KYDpPgOMjMubf+1v/ywE9IRbshmvUw8xoVxjXRpeJdYCqvpFED78US+SqMiYi6qXLU5JPaDzHPFSL7ToQcuEZ9pM/6M5PYwpCNDiKGVQzoLZusqbDiabi7IKm4aAlqfPFhBMsFwLwEo2nqNYTvkLRHzBnkLuxT5
x-ms-office365-filtering-correlation-id: 8227fb4a-03ab-4746-abfe-08d6749e734f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:SN1PR12MB0798;
x-ms-traffictypediagnostic: SN1PR12MB0798:
x-microsoft-antispam-prvs: <SN1PR12MB07986B31B4ED4683E235B4D8A0890@SN1PR12MB0798.namprd12.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(908002)(999002)(5005026)(6040522)(8220060)(2401047)(8121501046)(10201501046)(3002001)(3231475)(944501520)(52105112)(93006095)(93001095)(6055026)(6041310)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:SN1PR12MB0798;BCL:0;PCL:0;RULEID:;SRVR:SN1PR12MB0798;
x-forefront-prvs: 0910AAF391
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(39860400002)(136003)(346002)(376002)(189003)(199004)(68736007)(386003)(6506007)(52116002)(106356001)(105586002)(36756003)(186003)(25786009)(486006)(476003)(446003)(11346002)(2616005)(4326008)(31696002)(97736004)(72206003)(31686004)(71190400001)(71200400001)(14454004)(26005)(256004)(14444005)(3846002)(6116002)(76176011)(53546011)(6346003)(99286004)(93886005)(66066001)(305945005)(86362001)(7736002)(6436002)(102836004)(6486002)(316002)(2906002)(7416002)(8936002)(478600001)(6512007)(6246003)(229853002)(53936002)(81156014)(8676002)(5660300001)(81166006)(54906003)(110136005);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR12MB0798;H:SN1PR12MB2575.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Nehal-bakulchandra.Shah@amd.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: rnzn5cALqyEqF8x7BrHuPs8+7r/PBHBP+jMgzQg9KJ07HR0P1EUo7pGtgYpDoksvgVpYTrSe2VlXY9KZLPkLzscOmhy/lCYncDqcBWXX2kJgbIQokr8gXW8S2pOEKfTTRES3gX1qBA7Y11NFvczH5g0cFuGdBYyKcsQ5dQnycNE3nxlcQsASIxlR62SfON+xqOPaogqZV8rzQhM698KPHModSJXcyTIdfYzPWrUI2cOLznegY3AUBRgBkhDlJSlNrCmUollSOnYj1m2atJ5otGfOaa6bUdc7Qin6kG1622oviUXvx+9eNcipjTeotNtr
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <07B7F27FE1EB5F44B54E9D16F6E13622@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8227fb4a-03ab-4746-abfe-08d6749e734f
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jan 2019 12:48:41.2583
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB0798
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkNCg0KT24gMS83LzIwMTkgNjoxMiBQTSwgQWRyaWFuIEh1bnRlciB3cm90ZToNCj4gT24gNy8w
MS8xOSAxOjE3IFBNLCBSYWZhZWwgSi4gV3lzb2NraSB3cm90ZToNCj4+IE9uIFNhdCwgSmFuIDUs
IDIwMTkgYXQgMTE6MDYgQU0gU2luYW4gS2F5YSA8b2theWFAa2VybmVsLm9yZz4gd3JvdGU6DQo+
Pj4NCj4+PiBBZnRlciAnY29tbWl0IDVkMzJhNjY1NDFjNCAoIlBDSS9BQ1BJOiBBbGxvdyBBQ1BJ
IHRvIGJlIGJ1aWx0IHdpdGhvdXQNCj4+PiBDT05GSUdfUENJIHNldCIpJyBkZXBlbmRlbmNpZXMg
b24gQ09ORklHX1BDSSB0aGF0IHByZXZpb3VzbHkgd2VyZQ0KPj4+IHNhdGlzZmllZCBpbXBsaWNp
dGx5IHRocm91Z2ggZGVwZW5kZW5jaWVzIG9uIENPTkZJR19BQ1BJIGhhdmUgdG8gYmUNCj4+PiBz
cGVjaWZpZWQgZGlyZWN0bHkuIFRoaXMgZHJpdmVyIHJlbGllcyBvbiBJT1NGX01CSSBhbmQgSU9T
Rl9NQkkgZGVwZW5kcw0KPj4+IG9uIFBDSS4gRm9yIHRoaXMgcmVhc29uLCBhZGQgYSBkaXJlY3Qg
ZGVwZW5kZW5jeSB0byBDT05GSUdfUENJIGhlcmUuDQo+Pj4NCj4+PiBGaXhlczogNWQzMmE2NjU0
MWM0NiAoIlBDSS9BQ1BJOiBBbGxvdyBBQ1BJIHRvIGJlIGJ1aWx0IHdpdGhvdXQgQ09ORklHX1BD
SSBzZXQiKQ0KPj4+IFNpZ25lZC1vZmYtYnk6IFNpbmFuIEtheWEgPG9rYXlhQGtlcm5lbC5vcmc+
DQo+Pj4gLS0tDQo+Pj4gIGRyaXZlcnMvbW1jL2hvc3QvS2NvbmZpZyB8IDIgKy0NCj4+PiAgMSBm
aWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+Pj4NCj4+PiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy9tbWMvaG9zdC9LY29uZmlnIGIvZHJpdmVycy9tbWMvaG9zdC9LY29u
ZmlnDQo+Pj4gaW5kZXggZTI2YjgxNDVlZmIzLi4xYjk0MDFmZTk0YzAgMTAwNjQ0DQo+Pj4gLS0t
IGEvZHJpdmVycy9tbWMvaG9zdC9LY29uZmlnDQo+Pj4gKysrIGIvZHJpdmVycy9tbWMvaG9zdC9L
Y29uZmlnDQo+Pj4gQEAgLTExNiw3ICsxMTYsNyBAQCBjb25maWcgTU1DX1JJQ09IX01NQw0KPj4+
DQo+Pj4gIGNvbmZpZyBNTUNfU0RIQ0lfQUNQSQ0KPj4+ICAgICAgICAgdHJpc3RhdGUgIlNESENJ
IHN1cHBvcnQgZm9yIEFDUEkgZW51bWVyYXRlZCBTREhDSSBjb250cm9sbGVycyINCj4+PiAtICAg
ICAgIGRlcGVuZHMgb24gTU1DX1NESENJICYmIEFDUEkNCj4+PiArICAgICAgIGRlcGVuZHMgb24g
TU1DX1NESENJICYmIEFDUEkgJiYgUENJDQo+Pj4gICAgICAgICBzZWxlY3QgSU9TRl9NQkkgaWYg
WDg2DQo+Pj4gICAgICAgICBoZWxwDQo+Pj4gICAgICAgICAgIFRoaXMgc2VsZWN0cyBzdXBwb3J0
IGZvciBBQ1BJIGVudW1lcmF0ZWQgU0RIQ0kgY29udHJvbGxlcnMsDQo+Pj4gLS0NCj4+DQo+PiBB
bnkgb2JqZWN0aW9ucyBhZ2FpbnN0IHRoaXMgb25lIGZyb20gYW55b25lPw0KPiANCj4gKyBRQ09N
IGFuZCBBTUQgY29udHJpYnV0b3JzDQo+IA0KDQpObyBpc3N1ZXMgd2l0aCB1cyBhcyB3ZSBoYXZl
IHNlcGFyYXRlIFBDSSBiYXNlZCBkcml2ZXIgYW5kIEFDUEkgYmFzZWQgZHJpdmVyLg0KDQpSZWdh
cmRzDQpOZWhhbCBTaGFoDQo=
