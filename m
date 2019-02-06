Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CAFBC169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 11:44:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C3DC20B1F
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 11:44:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nokia.onmicrosoft.com header.i=@nokia.onmicrosoft.com header.b="Pb4SKpEI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730067AbfBFLok (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 06:44:40 -0500
Received: from mail-eopbgr10091.outbound.protection.outlook.com ([40.107.1.91]:27904
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729756AbfBFLoj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 06:44:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w97+D4VTs33a7z2KPnKnkHmfW17vqqfJqXY9H5JeB/o=;
 b=Pb4SKpEITUZFXzS1Cp1Mu076PchXqDisxpr4GsE6Beo+fzyJ1aXs4StGaqQiZC8aL6P2DbDZSSad8Suhpx/m8s2iiy4Pk1SIy3O9SDheVNzkdSekXGi03xdxwXLsGebflrBhcH7FSENBmS7e+kTlFkDA1nBZNDuGCTFEM8yH5XY=
Received: from HE1PR0702MB3675.eurprd07.prod.outlook.com (52.133.6.141) by
 HE1PR0702MB3660.eurprd07.prod.outlook.com (52.133.6.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.14; Wed, 6 Feb 2019 11:44:36 +0000
Received: from HE1PR0702MB3675.eurprd07.prod.outlook.com
 ([fe80::b49f:d20e:88d4:128]) by HE1PR0702MB3675.eurprd07.prod.outlook.com
 ([fe80::b49f:d20e:88d4:128%6]) with mapi id 15.20.1622.006; Wed, 6 Feb 2019
 11:44:36 +0000
From:   "Rantala, Tommi T. (Nokia - FI/Espoo)" <tommi.t.rantala@nokia.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>
CC:     "keescook@chromium.org" <keescook@chromium.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tytso@mit.edu" <tytso@mit.edu>
Subject: 4.14 "random: add a config option to trust the CPU's hwrng"
Thread-Topic: 4.14 "random: add a config option to trust the CPU's hwrng"
Thread-Index: AQHUvhFVeIOPgaip6k6iInncDQCRbQ==
Date:   Wed, 6 Feb 2019 11:44:36 +0000
Message-ID: <b6532199f855e48fa53b8c3725a2eb93f949b32a.camel@nokia.com>
Accept-Language: fi-FI, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=tommi.t.rantala@nokia.com; 
x-originating-ip: [131.228.2.20]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;HE1PR0702MB3660;6:M2+L5jp4CxoBXADWayxptYgquvqNBXAJJGvSK7qU6tWdZf2lxGqYz4pTaH1gm/nfoMrRFNFQWnhvcGxv2G7XiVArFu8GK+7+wuONXnpoh/NlfRoH6UKtC4TckG7xe/ec+2uXtyCEqVd0tvFAIPFxxa6FQqTiu1AU0yiJud/cyRXwDB3mPs3vul/8WLN+ncfNjfvETMKESyWE2kxjqQI1EOU9Y0CaTHxaoA5UaRQKSG08dVWpqK7gwcDe+1kGjwDYWj8uc3swVUIChctmRwUGIrgPXicPp1o+wWmJ+Wa6/ycSNcEOYO7TVreuB1rXza+nMLz/rNGrfJIaiaQN36RDRPBsNnXdlU/qwTade1RqiQH+WPwsH4Gn8BgtcrprUHXpAs6XkJDysv7nU2QJVzArdrwlTmGx53V85KChCL1h7/Gzgfx5vL4AF9Zva+XHd6Cl27c8MYWIP8GLTtsyMxjiwA==;5:bavSDx5NzY2gvRLhgsYsYTQiQKQwouxbhdeIF0s2lQOkTy/XfYoxq7+/3sw1IjV0GkChdwYJPapezuJb0PasJnZxsMfO0XYJQeWZIWbZ4lDle0jcSsIO7jK8AaAq7RSmRIL3eCFzOj8taKEJ2F3QEKkqgB/HRJDy5Mq1tSkMJs2VoVFIx4vzeGekyWEWmYoNA7pUiUkvB/TRwhbTG5VovA==;7:jRKsDwQejQlBZq9MiKOIvlkrvDu07vqPYqH0uO0PYXqVsj2m9u0M/ZlJCKw5du6jotcRQB0uPomY8P8SHz+J1OAwedzjkTwpJ04EhL/goEGiE8fPuuh5I6kmtOofaXA8OK4g+CFoirUmG/hvrvF3Ig==
x-ms-office365-filtering-correlation-id: ba7e7da7-1fbe-4fbe-485d-08d68c28783b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7193020);SRVR:HE1PR0702MB3660;
x-ms-traffictypediagnostic: HE1PR0702MB3660:
x-microsoft-antispam-prvs: <HE1PR0702MB36608BE0D2385F29A461FA90B46F0@HE1PR0702MB3660.eurprd07.prod.outlook.com>
x-forefront-prvs: 0940A19703
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(136003)(346002)(366004)(396003)(39860400002)(199004)(189003)(25786009)(6916009)(71200400001)(71190400001)(68736007)(36756003)(26005)(97736004)(53936002)(478600001)(2906002)(118296001)(86362001)(4744005)(66066001)(256004)(486006)(476003)(102836004)(6506007)(5640700003)(316002)(99286004)(8936002)(6486002)(3846002)(6116002)(81156014)(2351001)(2501003)(2616005)(6436002)(1730700003)(106356001)(105586002)(8676002)(81166006)(6512007)(186003)(14454004)(7736002)(305945005)(4326008)(54906003);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0702MB3660;H:HE1PR0702MB3675.eurprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nokia.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: IsWdMKpFIlIiEeq0CgK4+LihdVvY9qv220XD/5rMYq/6TSfXLjPS9nYyQbj7aE/Fb9q2YuIhGq5oByi+HZuVBMEEuHp7e+r/F7TbMKeh+R40HpnMtWeKtEfEl4qsFvkHE7uN8vFFmi/FYiMhJu3eB6+4jqtplgEiiLd3aWSOjUQjysC/zfS7F6qbvklqX0bItdvMQwK06jv9fiBb9p0LdMevyY+5lFbv75kY6J5rkSqDNEXecNnXV6iNOvdKaXDx3vTwVHPseRpGQCV4lmxp3YkIhIK59F1psIIX13K9Lfc65wgI0sZx5s/GdwFew7Z1OW7atlbWquLgoZEwiyVc7Ao+ddlGbOgHhvcRvkiKxAVA0c+8WS1IKF8YumTsgK70I0ynRA/vTdfEegTKYOqIIJ5ZCsuwCrqF5yVdmwBG4gA=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CDD07593693242459691C535320A0256@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba7e7da7-1fbe-4fbe-485d-08d68c28783b
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2019 11:44:36.1103
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0702MB3660
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgc3RhYmxlIG1haW50YWluZXJzLA0KDQpDYW4geW91IGNvbnNpZGVyIGluY2x1ZGluZyB0aGVz
ZSAicmFuZG9tIiBwYXRjaGVzIGluIDQuMTQueT8NCg0KVGhlc2UgYXJlIHZlcnkgdXNlZnVsIGlu
IGZpeGluZyBlc3AuIGZpcnN0LWJvb3R1cCBkZWxheXMgb2YgVk1zIGR1ZSB0bw0KZW50cm9weSBz
dGFydmF0aW9uLg0KDQoNCmNvbW1pdCAzOWE4ODgzYTJiOTg5ZDFkMjFiZDhkZDk5ZjU1NTdmMGM1
ZTg5Njk0DQpBdXRob3I6IFRoZW9kb3JlIFRzJ28gPHR5dHNvQG1pdC5lZHU+DQpEYXRlOiAgIFR1
ZSBKdWwgMTcgMTg6MjQ6MjcgMjAxOCAtMDQwMA0KDQogICAgcmFuZG9tOiBhZGQgYSBjb25maWcg
b3B0aW9uIHRvIHRydXN0IHRoZSBDUFUncyBod3JuZw0KDQpjb21taXQgOWIyNTQzNjY2MmQ1ZmI0
YzY2ZWI1MjdlYWQ1M2NhYjE1ZjU5NmVlMA0KQXV0aG9yOiBLZWVzIENvb2sgPGtlZXNjb29rQGNo
cm9taXVtLm9yZz4NCkRhdGU6ICAgTW9uIEF1ZyAyNyAxNDo1MTo1NCAyMDE4IC0wNzAwDQoNCiAg
ICByYW5kb206IG1ha2UgQ1BVIHRydXN0IGEgYm9vdCBwYXJhbWV0ZXINCg0KDQotVG9tbWkNCg0K
