Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3230508-1521476025-2-14599106851666665523
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
    t=1521476024; b=L+Pv5V25SuG9hdzOm2EbsZlKIB2jQScFrpkQNOE5UMKS9zM
    6m3KsP0fdmcITqavKutK/YhtbG13IjDtUmzB7H47jYmMCEbfB2ZKTr1LeGJIHTLC
    NSMaBgC2NC4CzB9QOoLBgMwf5GtHgt7hJg8JsHwTbYZU5BcT1H1Q343CvZuy94e9
    a/o2xtpxIHdtbsHwruy2vero38aC9mcp5l1fMKvEQnOGGc94n8rCc3EbPcO+RPXH
    zUdUGzjQj4Aceo8b5KyxSizp1OxPjRZtnfcrFdmakj7znGKQy4z7BWhKvYmunUX5
    U9qv1NFBccbty3V9yTSTGoruuMwfYgBmQ8PfC1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521476024; bh=ASYjTs
    tmuLIq0rgKF1UM99cmIE+BmE43jzrCpMharcA=; b=evIlXaF54iQ5C74DinRo9n
    0HWkpkEPLZI1A32LdPV2PEI9YjKO0wKJFnlrGE0IPdg82ot69Mus7Jq/GQv5GSd8
    HYEiMlitwoH2qygB7iNk8mXmvW9ButzOIITsdP3VU/4W2aJqqnpRO9SmkZHMNp4o
    NQgouPpefzKEczj56RiHRuUc/34pEZAkW1BUy2+zwFPFC8AwV2YsuNMl1Ji3TVCc
    2s7V2G9mHmx3KCnZ2iSISx6P/Jdk9x7Ck2M/JKY2XP/oflD2egS+hkvSooRah5qR
    Z5jUMJUjWBGus3FrOP9S7rnGkq9LjA7gMg0awf/dqQ6SDetWuJieKSTkFsk9HqSA
    ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Kwu15wAj x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdekheculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepjeeifedunecuvehluhhsthgvrhfuihiivgepuddtud;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Kwu15wAj x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdekheculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepjeeifedunecuvehluhhsthgvrhfuihiivgepuddtud;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935312AbeCSQNj (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 12:13:39 -0400
Received: from mail-cys01nam02on0094.outbound.protection.outlook.com ([104.47.37.94]:64207
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935246AbeCSQNe (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:13:34 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 066/102] drm/omap: fix tiled buffer stride
 calculations
Thread-Topic: [PATCH AUTOSEL for 3.18 066/102] drm/omap: fix tiled buffer
 stride calculations
Thread-Index: AQHTv50hZoTbnkI1eEKp2EqQbCoWPQ==
Date: Mon, 19 Mar 2018 16:12:51 +0000
Message-ID: <20180319161117.17833-66-alexander.levin@microsoft.com>
References: <20180319161117.17833-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319161117.17833-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1048;7:7Y9j5B90+oOE+aLsJ3ImYI5SCs4YdQfQHcrfVsPA9IZHvxnUuwiCQRiiMLkzEW1CVvhyq9Jrp14pN7mCR/0zQKvbwQTHb5uy0TudFT5Exst8eIsxn3+EkYFPIFx4HioaYapixHdhUrCEVya3RVGB3JVsWfAqZJL51xr75m42nJI61U1X19VwvuKyThHPwHkJvjGmSZ7ZS9+bl/QKwIC4Yg2UEdyc0UqKnUhnWDOod19lvBFHRxfb5htcGfY8kxM4;20:y3GKgeL1JdxzDQ8br57/UvBlyWBVTta/8akgFxwoRhJT5Jf9IWue+pk5xHvCGOo1UKOpq90o6F8eWW81wDkMSb6et42FNuqqSXX0d3VzUR4xPt6oajsgfmcjriRzZHwqfsgZhylF6A28D5iIWq9m2dN9FfEl4BfUBeK/5fso6z8=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2adc8d89-c7be-474a-fdf7-08d58db454c5
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1048;
x-ms-traffictypediagnostic: DM5PR2101MB1048:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1048AC012778CB6D5001E9F5FBD40@DM5PR2101MB1048.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(31051911155226)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB1048;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1048;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(396003)(346002)(39860400002)(366004)(376002)(189003)(199004)(10090500001)(107886003)(25786009)(106356001)(102836004)(26005)(6506007)(8936002)(2906002)(6666003)(186003)(86362001)(2950100002)(5250100002)(66066001)(3280700002)(5660300001)(4326008)(72206003)(68736007)(10290500003)(86612001)(2501003)(478600001)(81156014)(81166006)(8676002)(2900100001)(1076002)(105586002)(6436002)(54906003)(110136005)(53936002)(36756003)(6116002)(59450400001)(3846002)(305945005)(316002)(6512007)(6486002)(14454004)(97736004)(3660700001)(7736002)(76176011)(22452003)(99286004)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1048;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: IFwvanqKttitSXvqxjVPYnBGmWjMtUuGzT7n/U98Bq3yGdHj0PkMCf5CUWhn9OpOL52DNVKCsl3SLWHrA4cfLASfKRnTiTOVtgDLXyrNJbLeMLaLF2iyu8yRrvfJqdOWibUdy2s0Y0Tl0baYGUbGPfibGtOyn2Ss3xcPzNUtXV8OGGuIoPAZ3iusbUExa+Jx2OUH7beh26KbYxapai5yvgGwstKpWRgdgEUHYzuLijRzwn0e0OetdoiuyXrWCs/+5FTlot9fAB54bfzHT2EVI83hONp/7PFFz+gVN71qaTWrWo9X7qCNfW2vwYCgMu0cfsewFMSmUwtWLczcxCe1OQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2adc8d89-c7be-474a-fdf7-08d58db454c5
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:12:51.4564
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1048
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Tomi Valkeinen <tomi.valkeinen@ti.com>

[ Upstream commit cc8dd7661ccc2d8dc88921da8e6cc7c2fcdb0341 ]

omap_gem uses page alignment for buffer stride. The related calculations
are a bit off, though, as byte stride of 4096 gets aligned to 8192,
instead of 4096.

This patch changes the code to use DIV_ROUND_UP(), which fixes those
calculations and makes them more readable.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/gpu/drm/omapdrm/omap_gem.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/omapdrm/omap_gem.c b/drivers/gpu/drm/omapdrm/o=
map_gem.c
index e4849413ee80..4f745c11d955 100644
--- a/drivers/gpu/drm/omapdrm/omap_gem.c
+++ b/drivers/gpu/drm/omapdrm/omap_gem.c
@@ -158,7 +158,7 @@ static void evict_entry(struct drm_gem_object *obj,
 	size_t size =3D PAGE_SIZE * n;
 	loff_t off =3D mmap_offset(obj) +
 			(entry->obj_pgoff << PAGE_SHIFT);
-	const int m =3D 1 + ((omap_obj->width << fmt) / PAGE_SIZE);
+	const int m =3D DIV_ROUND_UP(omap_obj->width << fmt, PAGE_SIZE);
=20
 	if (m > 1) {
 		int i;
@@ -415,7 +415,7 @@ static int fault_2d(struct drm_gem_object *obj,
 	 * into account in some of the math, so figure out virtual stride
 	 * in pages
 	 */
-	const int m =3D 1 + ((omap_obj->width << fmt) / PAGE_SIZE);
+	const int m =3D DIV_ROUND_UP(omap_obj->width << fmt, PAGE_SIZE);
=20
 	/* We don't use vmf->pgoff since that has the fake offset: */
 	pgoff =3D ((unsigned long)vmf->virtual_address -
--=20
2.14.1
