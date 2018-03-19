Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3980569-1521499403-2-2809080887008401690
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521499402; b=CEhTi+pJr1WnLLV/1J1UewtdRrC7QXfTIH7HAYvo9KBMPqT
    wtpgM66BNBqhsGU46iXcJem4kChtWrLv0RHlD3CarVEFQM54Tod7QjgVCIBYETwb
    +4TjcojpHr+vyBCf+5fLk4Xk0W+FfcIUY26rhTmcRRSlEz7BiFICjamg7P0bOrgy
    UJqmB5lUg5Q1UeMNywSgaFcNo0fZ4egXO2pCqu/PjcPj6roJfeMAPH1++IPLBkei
    sYNUArONK0XhGIvRPbpcLaFnyascKoswj7UycAgxr5rNY4iDbHQ8R7qxL8oeXZrc
    kHb0NizMkiE87hHKhk7kLcSiAn/vLnWiIYbwhiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521499402; bh=wz9vAf
    /XxlHXtcAsaBKyOM9kzp2vm/uTUsoq/uGlAXY=; b=Y2ji63wz9Ji9SqXVtVySjc
    IZp/PIinbQRU266oAaeqUxIv6jApy6rFhoMfdK47AOZoIYyjo+fjFRKk61zwxAZX
    O3REpsLytQHkb1T9ZnkV7Ln6sghlgSPGPYiXx1Gv4wxWcgdyYnjizmIik4t8vd8N
    bZ3eIj6Uld0DDjQXVqlIVpI1jtzO1aX3fhFq5FKmNHXThJBk831J7SrjXFhrdfbP
    X4CzA4UYzKSAAhizJJXnqvpdP1MA1mVqU7CbOTiuoiuzG7XMDFb7hf4+GuiODH2a
    N7Du3cuQDejSbFYaMpEeUUxJS0c9R2Je3Xv9O4SBH2At0d5BFGmHSLJDWs7Fn8PA
    ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=FyCicJY/ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudeggddtudculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepjeejieeinecuvehluhhsthgvrhfuihiivgepfeeh;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=FyCicJY/ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudeggddtudculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepjeejieeinecuvehluhhsthgvrhfuihiivgepfeeh;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933260AbeCSWnF (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 18:43:05 -0400
Received: from mail-by2nam01on0103.outbound.protection.outlook.com ([104.47.34.103]:19764
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755455AbeCSPrD (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 11:47:03 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 004/124] clk: meson: mpll: use 64-bit maths
 in params_from_rate
Thread-Topic: [PATCH AUTOSEL for 4.15 004/124] clk: meson: mpll: use 64-bit
 maths in params_from_rate
Thread-Index: AQHTv5mES+bEz0kV50iyUofT1iQM/g==
Date: Mon, 19 Mar 2018 15:47:00 +0000
Message-ID: <20180319154645.11350-4-alexander.levin@microsoft.com>
References: <20180319154645.11350-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319154645.11350-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1013;7:N+lOvTOf1CrTSPZUPffy03psise7J8n5F0bWNfzZmD4dtp8jbHrn2tgkO36cH2excZ2b2KSJtbCOszxL/Sh2T6CZADQ2/tTCTmOaRt3D2spHPz/LICi5RgHaDtTY6cp5NBNGapp64u3ywPHrBjYTLr79xwef7fZZRp969MYJfxarzePrXRq53iVPWr4fWl4R6dWXXvxl2QoSyty1ABE4Jnt5Ti8zvANSckoORQ6nlWpqThbucUoN4m0KO7oxPshg;20:B5FKkhEOkxaO3BJb6wngJ6E/EWHn05lOu8YtkcWjhlphki5pGjB5DveyQklo9IyKK93LyQIyb/X9+lnSJ/DOA/ufL5A6DkdrEDtnjpPbQBCnUOuTHCfPhAKwb/HUt39+n4ZyVe9BDKcJGX3NU+W3oz5fAy20VAyfm0XlMTPxqNg=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6ba1c023-bc4b-4780-fe1c-08d58db0a763
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1013;
x-ms-traffictypediagnostic: DM5PR2101MB1013:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB10139A768C6E90D54F8E8E28FBD40@DM5PR2101MB1013.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(8415204561270);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231221)(944501300)(52105095)(3002001)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB1013;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1013;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(39860400002)(346002)(376002)(39380400002)(189003)(199004)(86612001)(316002)(26005)(72206003)(4326008)(25786009)(110136005)(10290500003)(86362001)(59450400001)(54906003)(53936002)(36756003)(107886003)(3280700002)(14454004)(22452003)(6506007)(5660300001)(68736007)(99286004)(186003)(478600001)(76176011)(2950100002)(10090500001)(102836004)(6116002)(5250100002)(2501003)(97736004)(3660700001)(106356001)(81156014)(81166006)(8676002)(8936002)(7736002)(305945005)(2900100001)(105586002)(3846002)(1076002)(66066001)(6436002)(2906002)(6512007)(6486002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1013;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: aJ70w7PORklSwofEckkWfBi0IDmgODg1Q5zMUcKfq6Hvjz2k19nplpmqt1eyQHk8nLo5yQSPlclq5B78/fy3xiXuRw2tKO5Cp4inlL3a6rzUXxKVjESVYS9nkcBFCXBo7+dGh2t4yMi27jhlfdfx0FurMAD5FJSTLhxtCiwrA5rynz416hIKaGuww5fCd+Xx6Bd7FxgOMCz+rkwWbEN6Rbflybbim2X1vMaZKPOse5jXqEuPjleT2Gk5obwgsrekTmXbvOtHqzMWGndF7ciJ5WTChQrskf3st+jjoLqI/c3GGHAIpPxUE47YU+5vbK4P9ChXsIBbNE1kMG9AUZzhvg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ba1c023-bc4b-4780-fe1c-08d58db0a763
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:47:00.3420
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1013
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

[ Upstream commit 86aacdca66774051cbc0958110a48074b57a060b ]

"rem * SDM_DEN" can easily overflow on the 32-bit Meson8 and Meson8b
SoCs if the "remainder" (after the division operation) is greater than
262143Hz. This is likely to happen since the input clock for the MPLLs
on Meson8 and Meson8b is "fixed_pll", which is running at a rate of
2550MHz.

One example where this was observed to be problematic was the Ethernet
clock calculation (which takes MPLL2 as input). When requesting a rate
of 125MHz there is a remainder of 2500000Hz.
The resulting MPLL2 rate before this patch was 127488329Hz.
The resulting MPLL2 rate after this patch is 124999103Hz.

Commit b609338b26f5 ("clk: meson: mpll: use 64bit math in
rate_from_params") already fixed a similar issue in rate_from_params.

Fixes: 007e6e5c5f01d3 ("clk: meson: mpll: add rw operation")
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/clk/meson/clk-mpll.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/meson/clk-mpll.c b/drivers/clk/meson/clk-mpll.c
index 44a5a535ca63..5144360e2c80 100644
--- a/drivers/clk/meson/clk-mpll.c
+++ b/drivers/clk/meson/clk-mpll.c
@@ -98,7 +98,7 @@ static void params_from_rate(unsigned long requested_rate=
,
 		*sdm =3D SDM_DEN - 1;
 	} else {
 		*n2 =3D div;
-		*sdm =3D DIV_ROUND_UP(rem * SDM_DEN, requested_rate);
+		*sdm =3D DIV_ROUND_UP_ULL((u64)rem * SDM_DEN, requested_rate);
 	}
 }
=20
--=20
2.14.1
