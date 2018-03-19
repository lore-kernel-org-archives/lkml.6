Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3827995-1521494605-2-297281406132930449
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
    t=1521494604; b=VVVzLDBzNpi8VCerDpqS8+N/VXIBHzCfLgSz7WHN5fxnyxn
    6xlqMLCd9jpEGSpvF3yYUhz2KDGGk2NK7u5PPi4EIGAsYQMfLxh7aA0VAx295sQR
    9SsXa6M0lsoOzolEc/BKuac06mcetPenNrfHKmQgGqLBHJsb3ObOaqVDkhCykorb
    VnoViL5gXtmaa7yFAXLHSjIClg5Zs4cqaZNwbFyq80dgHIGRq5t4z4BGdY5BzRx2
    34KItiEcq7OuJDuNhvEqPQTDIUlUvWDRAwV09pNTnIODW9dSrdaBIYGBANvRgbsG
    LqHt0tZ+AUMhryVqTLPbNhEB7Z46oDlsrALzHWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521494604; bh=V+VEvQ
    vJqsFmmUfkM2gPipEaxo0goov+4wrLc9ijHmo=; b=mVKB3969AyxR/L8O1x/pGZ
    gUBT0Cq1uSjVCXSUu5xWUQnrZOS3Q+xUmG0QEXKRQ/Fy52znVcN01jcrYaDHXmHj
    O0yrb07BJzXlmynKRA2ZNMX9oGVRxgX5EHDPtJrPFlPKQM4HTtbu2Dj6pf37nbhr
    XUH/JGo6y0APaqPEGWvgn71JPPBj//qgAYngGrz1fZs/3pn3V4noRuVbbwDxBI3B
    bGhvb5DA7JcwdJyB5moNrXX4dsbqMpCQ6rr+xqhdxf8hYy0erGuwxrbzXkVe+cSV
    nYicmaCkElaL0QHVRm08jWTLewDJXnnc68Wo+5wsD7LQtL9mbqJU7lFY8yiWCQvw
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=adY311mQ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddugeelucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeelfedtjeenucevlhhushhtvghrufhiiigvpeeije;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=adY311mQ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddugeelucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeelfedtjeenucevlhhushhtvghrufhiiigvpeeije;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934927AbeCSVXF (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 17:23:05 -0400
Received: from mail-co1nam03on0122.outbound.protection.outlook.com ([104.47.40.122]:54448
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934868AbeCSQAd (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:00:33 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Theodore Ts'o <tytso@mit.edu>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 087/281] ext4: handle the rest of
 ext4_mb_load_buddy() ENOMEM errors
Thread-Topic: [PATCH AUTOSEL for 4.9 087/281] ext4: handle the rest of
 ext4_mb_load_buddy() ENOMEM errors
Thread-Index: AQHTv5tGLg5CdMdM90ejz/q/WxsKJA==
Date: Mon, 19 Mar 2018 15:59:34 +0000
Message-ID: <20180319155742.13731-87-alexander.levin@microsoft.com>
References: <20180319155742.13731-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155742.13731-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0869;7:Zs5AR2Q0Hz1scgBTByywZokdHseENLWkP0D/Fy2ZobYolaLnO36bm6ezW5b34XneboKgSNYGPFgP9Iu4ve9pCeL9tEvFNPUA90ZFWaAfjGW68zBQeBxJ5a/x+y6GnM9E7KQvG6vTQXK1hMaW1M2vy2hh8j7ODkScIBAPXK2ugBlawbT51Hmt17MLip5JiLIcFYmr2apEePxZeXjDr7EX6/uIauyidPnZ3w0GpsWP4nbq4FAji26/VqFiSzi+NfcI;20:sQ0dp2EeRNZM05TttJxO6sNJwlrLnRTwkUoTkkCUsodZSVmJV61DH/E4OIBXpK/5OXZsP3uKltsC/a+ZekNYK89k470pLC4r6Dondw7x5YbFJW8BFMbhUog5ou3hqbQPFkrOi9WUBwHa+4f0amk42cwkUQqJoxBNWqPBiyLrYoQ=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5e793df2-7756-439b-a244-08d58db27c99
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0869;
x-ms-traffictypediagnostic: DM5PR2101MB0869:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB086951B752D42293489E3F3BFBD40@DM5PR2101MB0869.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(240460790083961)(17755550239193);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0869;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0869;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(39380400002)(366004)(346002)(39860400002)(199004)(189003)(15760500003)(76176011)(6486002)(2950100002)(6666003)(2906002)(5660300001)(54906003)(14454004)(110136005)(7736002)(2501003)(10290500003)(106356001)(22452003)(59450400001)(3280700002)(5250100002)(305945005)(25786009)(99286004)(107886003)(10090500001)(6436002)(26005)(97736004)(53936002)(86612001)(3846002)(6116002)(186003)(1076002)(8676002)(81156014)(81166006)(68736007)(102836004)(72206003)(3660700001)(8936002)(316002)(478600001)(4326008)(36756003)(6506007)(4477795004)(105586002)(66066001)(6512007)(2900100001)(86362001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0869;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: emTxjmo25v5WtwCz3OKGVqBpA0Ym3CHs9FdW6cZtwhx+Lhi9wU8cW63Mf0mj4JKaRz8O22JJtCkuTDR0oj1UObAiQnq99mQhJ0Vd+lWJHB1FOpKs60fre+GW+atZMdw1XFr5x+BT9ohqXKW8oEDewxPuI8NIOn9SRGXnmBJs0d9P1u23Ezje9pRljABsY4f6rAJhs/4JCcrXSAwPRjPwZ93T+JDAhWg/2I+KcngmQ/XP+Z4IivFxo2ijX/oIWXJyaeSx0rMlko53avvUov0nJYZEqUuEGyX6mzV/lod66+ahOsfpai6Hejpe/EHb0CkF+yGvVIqywHg6XaTlR7Yq8g==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e793df2-7756-439b-a244-08d58db27c99
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:59:34.8713
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0869
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>

[ Upstream commit 9651e6b2e20648d04d5e1fe6479a3056047e8781 ]

I've got another report about breaking ext4 by ENOMEM error returned from
ext4_mb_load_buddy() caused by memory shortage in memory cgroup.
This time inside ext4_discard_preallocations().

This patch replaces ext4_error() with ext4_warning() where errors returned
from ext4_mb_load_buddy() are not fatal and handled by caller:
* ext4_mb_discard_group_preallocations() - called before generating ENOSPC,
  we'll try to discard other group or return ENOSPC into user-space.
* ext4_trim_all_free() - just stop trimming and return ENOMEM from ioctl.

Some callers cannot handle errors, thus __GFP_NOFAIL is used for them:
* ext4_discard_preallocations()
* ext4_mb_discard_lg_preallocations()

Fixes: adb7ef600cc9 ("ext4: use __GFP_NOFAIL in ext4_free_blocks()")
Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 fs/ext4/mballoc.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 64056c6eb857..14bd37041e1a 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -3877,7 +3877,8 @@ ext4_mb_discard_group_preallocations(struct super_blo=
ck *sb,
=20
 	err =3D ext4_mb_load_buddy(sb, group, &e4b);
 	if (err) {
-		ext4_error(sb, "Error loading buddy information for %u", group);
+		ext4_warning(sb, "Error %d loading buddy information for %u",
+			     err, group);
 		put_bh(bitmap_bh);
 		return 0;
 	}
@@ -4034,10 +4035,11 @@ void ext4_discard_preallocations(struct inode *inod=
e)
 		BUG_ON(pa->pa_type !=3D MB_INODE_PA);
 		group =3D ext4_get_group_number(sb, pa->pa_pstart);
=20
-		err =3D ext4_mb_load_buddy(sb, group, &e4b);
+		err =3D ext4_mb_load_buddy_gfp(sb, group, &e4b,
+					     GFP_NOFS|__GFP_NOFAIL);
 		if (err) {
-			ext4_error(sb, "Error loading buddy information for %u",
-					group);
+			ext4_error(sb, "Error %d loading buddy information for %u",
+				   err, group);
 			continue;
 		}
=20
@@ -4293,11 +4295,14 @@ ext4_mb_discard_lg_preallocations(struct super_bloc=
k *sb,
 	spin_unlock(&lg->lg_prealloc_lock);
=20
 	list_for_each_entry_safe(pa, tmp, &discard_list, u.pa_tmp_list) {
+		int err;
=20
 		group =3D ext4_get_group_number(sb, pa->pa_pstart);
-		if (ext4_mb_load_buddy(sb, group, &e4b)) {
-			ext4_error(sb, "Error loading buddy information for %u",
-					group);
+		err =3D ext4_mb_load_buddy_gfp(sb, group, &e4b,
+					     GFP_NOFS|__GFP_NOFAIL);
+		if (err) {
+			ext4_error(sb, "Error %d loading buddy information for %u",
+				   err, group);
 			continue;
 		}
 		ext4_lock_group(sb, group);
@@ -5117,8 +5122,8 @@ ext4_trim_all_free(struct super_block *sb, ext4_group=
_t group,
=20
 	ret =3D ext4_mb_load_buddy(sb, group, &e4b);
 	if (ret) {
-		ext4_error(sb, "Error in loading buddy "
-				"information for %u", group);
+		ext4_warning(sb, "Error %d loading buddy information for %u",
+			     ret, group);
 		return ret;
 	}
 	bitmap =3D e4b.bd_bitmap;
--=20
2.14.1
