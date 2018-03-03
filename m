Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1145125-1520116746-2-10662620791688576914
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520116746; b=e15wBELgw5hQbT1bOscFlo9vRcvjxVbsh4x2CAC+p4IWa5Y
    6nHA1IGuBdo3GhDULlXGojuXsCXeXTiWYJ7/sYtflJ4bDdJRrimeQYw2QlJX7tCC
    PN/1Bzp6J6dE/cN0FKluhkHlgA7nrupBb8qW5nPVyVub8FpyvtGXoIk4elWraMcp
    /7jJ32TjfRuIkv+mReUYeqVlICbkz8oIJjDD1S1gEp+JGAguxwsIPzq1QFmYkjXf
    OzA30ZArwBFaaT61lZ3IJPLXyUQrWimTVUzamwaDkOsDlocPDI+QJ9puGyn0RodL
    4Rkra5OrPY8euV3K8W3IdSuPEjnebPaU4/j9YAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520116746; bh=hUGu5c
    LTk2n9Md2d/F8DBM0bTSfdmF+pWeXIE2vU97o=; b=eYOm2mRl72SwmIPwxrR+wy
    LIocaWOvN2Wb+5SAw9SK0u742AUqEeirQHZUu7O/HGRw95ZIlUyGVc7mw0t4nveT
    CCSj3R3uN1CXmE5Rh2812EhPOS0AJSLyBl91wzhJSWmfyxwCIKdiWYm2baNWAM3N
    4S28R2HK1iZ1TS1D6QwgmwcYDmM/Z8oBPDMuE43W9f3flSpMXc88LBtUvFboMmYA
    pfBWTh6mqO/zqBA4wqNypdaKM7srMhmivz9lWx2gXFBH81MioovhvfB3gsv+oihf
    gOr9W/QNYoC1YhhvCGcdJbdvsDK0C9l/VT8MGW+KUKhwMhcc4lT95zut7ZNsZoXA
    ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Kcsqrm6B x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Kcsqrm6B x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934398AbeCCWip (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 17:38:45 -0500
Received: from mail-cys01nam02on0109.outbound.protection.outlook.com ([104.47.37.109]:20871
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933968AbeCCWin (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:38:43 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 031/115] ASoC: rcar: ssi: don't set SSICR.CKDV
 = 000 with SSIWSR.CONT
Thread-Topic: [PATCH AUTOSEL for 4.4 031/115] ASoC: rcar: ssi: don't set
 SSICR.CKDV = 000 with SSIWSR.CONT
Thread-Index: AQHTsz9ShCeVo0rW/0ax776wjTje/Q==
Date: Sat, 3 Mar 2018 22:31:06 +0000
Message-ID: <20180303223010.27106-31-alexander.levin@microsoft.com>
References: <20180303223010.27106-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303223010.27106-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1067;7:Ps6zU9XnHi845gxWHaVgB1sKf4A9o1r2PebVlTh+Mzc5aurNZFrPD0pd7olhqhccIZXjWGmj4MBlnLje2NaOsIfw7nO+3c4mEPoZq69MsFqDrsycyQ9Tp9DGvRvh3tyO4wyj3FrOW8UPWVWJjwt2GPiFwcLL4zMiRyWC2BTWu6ThREUCtWpHCXvbIeYueqIQlRt27y5TNjDPSNfv1PTHuDVu2ZN+nWXDFc0AcawdV1EHCQskutUMi3AjxB/XtlWP
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: deb20c75-a692-4c44-b729-08d5815783ce
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2PR2101MB1067;
x-ms-traffictypediagnostic: MW2PR2101MB1067:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB106734B6BAE34A6CE534B12EFBC40@MW2PR2101MB1067.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3231220)(944501244)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(6072148)(201708071742011);SRVR:MW2PR2101MB1067;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1067;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(366004)(376002)(39860400002)(39380400002)(346002)(199004)(189003)(4326008)(5250100002)(86362001)(1076002)(2501003)(110136005)(6666003)(81156014)(2906002)(8936002)(305945005)(81166006)(2950100002)(7736002)(10290500003)(26005)(186003)(3660700001)(478600001)(72206003)(107886003)(8676002)(3280700002)(2900100001)(76176011)(6116002)(25786009)(3846002)(102836004)(6506007)(5660300001)(97736004)(10090500001)(86612001)(106356001)(99286004)(6512007)(66066001)(316002)(53936002)(14454004)(105586002)(36756003)(6486002)(54906003)(6436002)(68736007)(22452003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1067;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: wgvqT/GMRu0PQaOwsp19K6nDyuJKQA9Sx7ozTAI6Fk5uQcNEx4i9LBuZ15XKY97EUKGJXh2NRRv3Hp3FE4zUBQTr3n9Tg0KLlPKjbghysC6oyA2/f9dQ15fSiAugpKHwINfRjqwGPoTzjt4rnCGS9hAVPMS7v6j49yxbpTVqzOg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: deb20c75-a692-4c44-b729-08d5815783ce
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:31:06.8853
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1067
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

[ Upstream commit 6b8530cc056efd4a11b034ca5b1e9f7e9563f553 ]

R-Car Datasheet is indicating "SSICR.CKDV =3D 000 is invalid when
SSIWSR.WS_MODE =3D 1 or SSIWSR.CONT =3D 1".
Current driver will set CONT, thus, we shouldn't use CKDV =3D 000.
This patch fixup it.

Reported-by: Hiroyuki Yokoyama <hiroyuki.yokoyama.vx@renesas.com>
Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Tested-by: Hiroyuki Yokoyama <hiroyuki.yokoyama.vx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 sound/soc/sh/rcar/ssi.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/sound/soc/sh/rcar/ssi.c b/sound/soc/sh/rcar/ssi.c
index 38aae96267c9..a001331a53c1 100644
--- a/sound/soc/sh/rcar/ssi.c
+++ b/sound/soc/sh/rcar/ssi.c
@@ -142,6 +142,15 @@ static int rsnd_ssi_master_clk_start(struct rsnd_ssi *=
ssi,
 	 */
 	for (j =3D 0; j < ARRAY_SIZE(ssi_clk_mul_table); j++) {
=20
+		/*
+		 * It will set SSIWSR.CONT here, but SSICR.CKDV =3D 000
+		 * with it is not allowed. (SSIWSR.WS_MODE with
+		 * SSICR.CKDV =3D 000 is not allowed either).
+		 * Skip it. See SSICR.CKDV
+		 */
+		if (j =3D=3D 0)
+			continue;
+
 		/*
 		 * this driver is assuming that
 		 * system word is 64fs (=3D 2 x 32bit)
--=20
2.14.1
