Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3384037-1521481402-2-11364880732879374180
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
    t=1521481401; b=EON0im0i1Bv0WI5lTsOBAfoytuaY5deeSJqDO025WF5wYoY
    ZqAHhD9sA+JgvthRH/bI+The+XmTITLTOXplOO4eHjwBzAmtQ8wea1KP2c06zA31
    TINX12+LVLh1IhFs4atPYeRjHNgmY+Q6KApbf0Wtq/jwN6Eb9jppOMnbZbotGizP
    0ALIHOfD48m6maxzBk4nLZpUN20Ca3B0JQltDa7FVzocuXniELgcksoZ1cY8bX4V
    cFU2BKAq4yZ0LttwaRKm7Y2OEywwcuTKTwfm9FFNJtCyGGy8nmZ+O2nHL+I+ItAH
    HukgXcwW04FJfbaF//r/cUSFOgcG+FW5m2+j5OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521481401; bh=rKcH5l
    pbeOrPs9Uc5bb/G4/pdNW9txGwjDHbhbgubsI=; b=taVnBTZ8dz8vaN41Mw/wWp
    DewhzRaSAwEX45JXc4Q0dAUh08PjGvCSdfFPgac/jWrH+h4vLXHkcksULCyYWZvM
    i3U5uAnwHcLG6tgwEHkSjCxXPqhhx38faSdjXdULOAHw1yPiS9BZt1P0ZfN1XKIJ
    B4l6k1qdqfHTkuCvMKJI00uiIFC5qX6OBJfNB5ysGuK3hefigbLBQljYQjFVrKfW
    95rp5p3lUIGptbBQOxv5zF3bs8dlA7P5WES+uYpfBQhSX6N1GJA3U/Qe8uWkxZEt
    zddwP9dzok8Yt73gchy9dfC0oW5R4oPCqxrPh6CwBpcx8WFLhfDgaG9fGNuQxQ9w
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=CjRgjgZO x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutdegucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecuffhomhgrihhnpehfrhgvvgguvghskhhtohhprdhorhhgnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeekuddvleenucevlhhushhtvghrufhiiigvpeeh;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=CjRgjgZO x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutdegucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecuffhomhgrihhnpehfrhgvvgguvghskhhtohhprdhorhhgnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeekuddvleenucevlhhushhtvghrufhiiigvpeeh;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965908AbeCSRmW (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 13:42:22 -0400
Received: from mail-dm3nam03on0092.outbound.protection.outlook.com ([104.47.41.92]:19136
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965847AbeCSQFv (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:05:51 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 261/281] drm/vc4: Fix resource leak in
 'vc4_get_hang_state_ioctl()' in error handling path
Thread-Topic: [PATCH AUTOSEL for 4.9 261/281] drm/vc4: Fix resource leak in
 'vc4_get_hang_state_ioctl()' in error handling path
Thread-Index: AQHTv5vCDjTKwkYcoE2txwST8/zbsQ==
Date: Mon, 19 Mar 2018 16:03:03 +0000
Message-ID: <20180319155742.13731-261-alexander.levin@microsoft.com>
References: <20180319155742.13731-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155742.13731-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1015;7:AOtBo0q+Pj/OA4zgws+L1yQUbZxV9Rd07Vii1nHNpA5gZHFpIXkgUS4F0oGNhrjfIFk9Bbwx2vfHBVvky4A3wuD58MuTsGHa3AfDKp6LkdseAFEiVLqxiGVjV9WQaDR7RhOWmaRjhJGWuBtLnd55yWOaYKRzGT1Ei15Lt/1c7uqTbGcsNAAfFvbjc9pOLfoDLwH3pMhXEPOnSGEIWoXRYsMzxbVajKBMCL1Ko5hoE6LO2rfEfwyskpTz5+Gbff4R;20:YYzR8ZbF4RusxwGaWlNrz9qYMY+zcSp1h5TW5a1fepcXTfNY1XnDyvVbdL4G0iL//ctaxC1zpmbJOQA/G9BaKkWoXV/wpgPUemFZ7myA2UpEV+ds8NkKmazJXIpp8Qf9R4oK/BxHhJmd74aSJWTKdskTQ+LO8fqrvWoP4qYoYJ0=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: fef62458-722d-4fc8-de58-08d58db341d3
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1015;
x-ms-traffictypediagnostic: DM5PR2101MB1015:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB10157C2979E584B2D9BDB2F8FBD40@DM5PR2101MB1015.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(155761271638844);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231221)(944501300)(52105095)(3002001)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB1015;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1015;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39380400002)(376002)(39860400002)(396003)(346002)(199004)(189003)(6506007)(106356001)(107886003)(2950100002)(6666003)(22452003)(316002)(10090500001)(59450400001)(76176011)(8676002)(81156014)(105586002)(81166006)(3280700002)(3660700001)(305945005)(7736002)(2501003)(6436002)(68736007)(6486002)(5250100002)(8936002)(6116002)(3846002)(2906002)(1076002)(186003)(36756003)(25786009)(10290500003)(4326008)(97736004)(6306002)(72206003)(2900100001)(99286004)(15760500003)(53936002)(5660300001)(6512007)(14454004)(966005)(478600001)(102836004)(66066001)(86612001)(86362001)(26005)(54906003)(110136005)(575784001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1015;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: 2P6nmLuf1+36x4bis1JSZcSR957QcKcMsasBoavChNEOY74Isd7GSRgpWTpM/F2s5CoSZ8gPlEtTE8rclX00BzqiKoQvaXchca0Oc07FKo9piBppNwT2Ln9KxGFzZDsNCQz1dCOKoxY0lorc/vKn1hTYqX9Pv8rCSBDl/DyuTrkLIDnJAJKVitjQoU+A6UmDLFlK7PCEdMMfqaWf3w3NEBSMEwiYKN1kqMl6EOd/HUHy/KM7BoVmv48IrBOUERlNxdktyRDxxsEIxjNg35r+ZYeNEwMhYAbQ/0KTOuyFkCheHapEoxAYgwQPO3YVe59Nj6qWXMZktXn2233ahzGRJA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fef62458-722d-4fc8-de58-08d58db341d3
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:03:03.5484
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1015
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

[ Upstream commit d0b1d259a4b58b21a21ea82d7174bf7ea825e9cc ]

If one 'drm_gem_handle_create()' fails, we leak somes handles and some
memory.

In order to fix it:
  - move the 'free(bo_state)' at the end of the function so that it is also
    called in the eror handling path. This has the side effect to also try
    to free it if the first 'kcalloc' fails. This is harmless.
  - add a new label, err_delete_handle, in order to delete already
    allocated handles in error handling path
  - remove the now useless 'err' label

The way the code is now written will also delete the handles if the
'copy_to_user()' call fails.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Reviewed-by: Eric Anholt <eric@anholt.net>
Link: http://patchwork.freedesktop.org/patch/msgid/20170512123803.1886-1-ch=
ristophe.jaillet@wanadoo.fr
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/gpu/drm/vc4/vc4_gem.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_gem.c b/drivers/gpu/drm/vc4/vc4_gem.c
index ab3016982466..b608cd463d4e 100644
--- a/drivers/gpu/drm/vc4/vc4_gem.c
+++ b/drivers/gpu/drm/vc4/vc4_gem.c
@@ -110,8 +110,8 @@ vc4_get_hang_state_ioctl(struct drm_device *dev, void *=
data,
 					    &handle);
=20
 		if (ret) {
-			state->bo_count =3D i - 1;
-			goto err;
+			state->bo_count =3D i;
+			goto err_delete_handle;
 		}
 		bo_state[i].handle =3D handle;
 		bo_state[i].paddr =3D vc4_bo->base.paddr;
@@ -123,13 +123,16 @@ vc4_get_hang_state_ioctl(struct drm_device *dev, void=
 *data,
 			 state->bo_count * sizeof(*bo_state)))
 		ret =3D -EFAULT;
=20
-	kfree(bo_state);
+err_delete_handle:
+	if (ret) {
+		for (i =3D 0; i < state->bo_count; i++)
+			drm_gem_handle_delete(file_priv, bo_state[i].handle);
+	}
=20
 err_free:
-
 	vc4_free_hang_state(dev, kernel_state);
+	kfree(bo_state);
=20
-err:
 	return ret;
 }
=20
--=20
2.14.1
