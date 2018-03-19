Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3440611-1521482630-2-6588265009645751201
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
    t=1521482630; b=KkVW/giAYFMRhZPAclSgVC8MwLbAtiG3klvdgLxCOsCc5eh
    N3N+fzlLeg/KNrpnIoCAqpsxK76DdkdWt66/BGUUBJ2gWNVhatBFPuX7Vmb5eYhS
    dxMMdobEpbgO0CSu85DH8xqbsrAPqPr/RE3rKaOrqAMCyjRurHGkA476UZ1BeDxI
    +CH0HqGsHT/phg1lsVH1FduMVASEXMxfYu/GJ0REgLkkFW7uoO/Nrulpup/6BpeA
    atutAM34z23I1X5RGNgfCP/xzvoIYEs8lcEbokOMFKhJ1qIM5PxseYniFZ9EHSVq
    qF4g4+i7EM3vB/2myF3BECMHyxgLWI8XVXFBZGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521482630; bh=nb+iVC
    yDY5UG8klckSOK6TOuIxWuUYY7OL8ZkxKpA9s=; b=EeobKI7MwqcV03VLRtbP3j
    B2FznBFQmbgvl0JFcHVTIWHeWa90rXmkhx8F7mqeuKIwbjc2VCJ/WNoFEdMk37OO
    NWGGqBal0GWhA53VCaccFzkmrs3PUAGM87ac/El6G5vJmXIUApeVhwNSj3XeVftH
    6Q09TlL4PzEcM2KjE/9Fp02YBOcfMLPo99QQMyjBYhBoVEeFwRpoRWwHJAILKLc+
    Bv6eYwlt9AVgBrmPGM7gmSK58AviKE/+kvccHzzm9PJeGOlMdm50+7zhQCCIBPjC
    9UE0i6e4HO8bp4aXG/jGWrd/dwyrQmVvb7rs+bt5+gOX5uh5hLZ0pWug1cBGy4nA
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=mCOe1AgE x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutdekucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejieefleenucevlhhushhtvghrufhiiigvpeeiud;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=mCOe1AgE x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutdekucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejieefleenucevlhhushhtvghrufhiiigvpeeiud;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965637AbeCSSCd (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 14:02:33 -0400
Received: from mail-by2nam01on0098.outbound.protection.outlook.com ([104.47.34.98]:46928
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965621AbeCSQD7 (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:03:59 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 189/281] drm/omap: fix tiled buffer stride
 calculations
Thread-Topic: [PATCH AUTOSEL for 4.9 189/281] drm/omap: fix tiled buffer
 stride calculations
Thread-Index: AQHTv5uP1sk4NU8/t06zbKJwZr0tmA==
Date: Mon, 19 Mar 2018 16:01:36 +0000
Message-ID: <20180319155742.13731-189-alexander.levin@microsoft.com>
References: <20180319155742.13731-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155742.13731-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1077;7:CJsmzA5gBmdwMFAc0zd381BCQS7L1DQmoT6yR9bVgD71rzCutFYXi3FxNXJcpISBVaGHq6iaXThy0f3x0rFKF90+7b0hw+mpcRyszZ57bZzHA0s7yBmtxs34uXZFeNXH8HWYXE+kuRflWkzrPmi7VxvYFQL4l8tOluRGOCgDvSOKuBK7YdKCbXJn/eIv7P0G/1Wp+GR4U50RM31XAwSXYAv4aiiTGpA4i2z6dfNb6jdtTUg6ROUCQHU2ZUUpPB5M;20:6jX48nDp34tVwq3TnhUwU8k1a/NOFtDSK/oMPZLMW/rWZJwRv2Yx0zwD4ssz+TXMQ9kduZK+SXGmEcHTwv8JKZHge7YeXSic5Khr0BiEtwbAc6UHawEhuOZ45Ypu7VOjAddmiBBGOrnnt+XEiHjc8Fnh/AOazvudDyt1WxiSctc=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: abe234c8-5670-44d0-645d-08d58db30248
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1077;
x-ms-traffictypediagnostic: DM5PR2101MB1077:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB10774A5DB95C69DDD48BBA42FBD40@DM5PR2101MB1077.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(31051911155226)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231221)(944501300)(52105095)(3002001)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB1077;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1077;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(39860400002)(396003)(39380400002)(366004)(199004)(189003)(110136005)(36756003)(3280700002)(66066001)(3660700001)(4326008)(6666003)(2950100002)(25786009)(86612001)(105586002)(10090500001)(68736007)(22452003)(99286004)(106356001)(5660300001)(7736002)(305945005)(76176011)(54906003)(5250100002)(97736004)(316002)(2501003)(3846002)(6116002)(1076002)(2906002)(14454004)(2900100001)(6512007)(8936002)(186003)(478600001)(10290500003)(53936002)(575784001)(8676002)(107886003)(6436002)(81166006)(86362001)(6506007)(59450400001)(102836004)(26005)(72206003)(6486002)(81156014)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1077;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: T37hc7G9LgBoyM/KaWslyCzaU/iLQ37PXUmMdo8eoOiDXYIr0n+3AVbQWbi1vkH8ac2kL+HADL38Eg04vevETFe8HI9VUbNAj9x75YCnXIGensVnH1caAOEY4lRZXknXIHvr+RjOQ5OKD7uj5EtNUd98KliJ5mmfzKhXDEIjvo0vawEOUFMVcso/ZIGZI7fsoHGieMdvU93+5LqAUsW8NaVf+320RlcMg8lFBk40ES8faFmrhOP//QmjIJejga0FicvhJGow7+x/eXeVSH4t46GPPepL8QyhS34U9EHMI6+v8tj911LnPRJtDWVddn2S5vvNnb3Isdb2vdfMZErLCg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abe234c8-5670-44d0-645d-08d58db30248
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:01:36.9962
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1077
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
index 505dee0db973..ca91651be3d4 100644
--- a/drivers/gpu/drm/omapdrm/omap_gem.c
+++ b/drivers/gpu/drm/omapdrm/omap_gem.c
@@ -195,7 +195,7 @@ static void evict_entry(struct drm_gem_object *obj,
 	size_t size =3D PAGE_SIZE * n;
 	loff_t off =3D mmap_offset(obj) +
 			(entry->obj_pgoff << PAGE_SHIFT);
-	const int m =3D 1 + ((omap_obj->width << fmt) / PAGE_SIZE);
+	const int m =3D DIV_ROUND_UP(omap_obj->width << fmt, PAGE_SIZE);
=20
 	if (m > 1) {
 		int i;
@@ -442,7 +442,7 @@ static int fault_2d(struct drm_gem_object *obj,
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
