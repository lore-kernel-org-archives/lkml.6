Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3357373-1521480254-2-2104193681787335569
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
    t=1521480253; b=IKS5QeQl+w1zEURAKalvl9fxkor2NZlmUBNAWLDUoduhZLX
    KlmAuL6Obr4O3avwzHaexue/yZRmuVuZeacomR4++M6eNQ4W3AcMS0HiS1c8sqPs
    imSUiGUOC1G6iw0ppk3zANkK1OelNy0oToYxUIhfZIeHk5c6eLe8V+VvB1yF5za6
    FoiKnJUrT8r7iQZ92VuO3MK7KSKD6j33kHqn9Cf6DVYgm0KODX5IzGbJiq3MhMkU
    CtK1TSffC3o1jZ6MCn1IVh9WgSlB14JfQrIA60S3NEZxPIjJ6WuJGHUZZA8236FA
    Vp1sD0FaZEh3nGFGyAt2E7DFS88XiaEKfpJBDTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521480253; bh=7Km1M4
    DIkHrqVk2zuCctKKtIrOd0RkCIFsD60muRBKI=; b=PT5Ae7IX0MRhLYhJHdNa84
    Mdo29dC13yfnsEI9h28CtyYw4iM0FoSBNwHHhLO0rYHSxRpokmL8oNn377SlRRqk
    xC+LhJOhhxmfxgbt/1rTMk04Vl100ZDQeiPnwi1CbYTjYMAP4TYtHGziB1li3srW
    0wieuiZbo8/tvg7s/zbJMNKop/CdlJLauGUW6l6wpqQG9PpAhLYgWZs29xLr5vyD
    rTWHIFSwzkptmOBsLwM8+DtcA+JpCjiqvN4DS2zO6RPMpuHpji+1HY8pSjXtBRjq
    JocNKMcZp5bAIvMxUG++8ggujEmKissMy9v4/BNZ4WOlvGcdJ6WMCDy33DmFTFoA
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=VVXnMyGW x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutdduucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeelfedtieenucevlhhushhtvghrufhiiigvpeeh;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=VVXnMyGW x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutdduucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeelfedtieenucevlhhushhtvghrufhiiigvpeeh;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966342AbeCSQIl (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 12:08:41 -0400
Received: from mail-dm3nam03on0096.outbound.protection.outlook.com ([104.47.41.96]:30671
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966304AbeCSQI3 (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:08:29 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Theodore Ts'o <tytso@mit.edu>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 058/167] ext4: handle the rest of
 ext4_mb_load_buddy() ENOMEM errors
Thread-Topic: [PATCH AUTOSEL for 4.4 058/167] ext4: handle the rest of
 ext4_mb_load_buddy() ENOMEM errors
Thread-Index: AQHTv5w/aYRBKDXwT0iXJLL99mSGCA==
Date: Mon, 19 Mar 2018 16:06:33 +0000
Message-ID: <20180319160513.16384-58-alexander.levin@microsoft.com>
References: <20180319160513.16384-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319160513.16384-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0805;7:MbQLBrf0z9jpX5tdE0eCq7jCfh59GMvXeBgS1hp/Bnks332GSCTx9cnG9JXv80lRm8HS3RU43xKYOGtSLooJh2p8YkmbCJ/VSTe0Wf4iN3uiOLEGbRHh4UTRnj0wv5FOCr+5e/Nekn0k5Lbs44mgwvj/6icJ4NAojVVwYwIceh6eNkFoIbO88sQ31EYWgctDAA2fZX/rYIcmy2yE6XYoJuN5cWrwa5azZhkODdoKvF/PFSsIFO5YFdVAhhP6naXE;20:iwO5V2GFNhzaN1lqQ+dGbmqGWB5tgwYSlTzLiaEG9Hs3YdoLIYW8csqrky98ZohC4BHqAU7/RPb9yHo0U0T6KdkgejwyKbEBoI2fzRlgH2wzyu7MEjzuWLlIzC/qKyxiiWWD1k5YpDXP113qwB0rwS4cclgC1jtgyN59K+MJ6ds=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e6d53526-74f8-4fe1-9fc6-08d58db3a3bc
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0805;
x-ms-traffictypediagnostic: DM5PR2101MB0805:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB080583394EF97B7CCB15C7B1FBD40@DM5PR2101MB0805.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(240460790083961)(17755550239193);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231221)(944501300)(52105095)(3002001)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0805;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0805;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(376002)(346002)(366004)(396003)(39860400002)(199004)(189003)(2950100002)(305945005)(186003)(86362001)(6506007)(3660700001)(6666003)(5660300001)(6116002)(8936002)(3846002)(1076002)(26005)(4477795004)(7736002)(6486002)(2900100001)(6436002)(2906002)(86612001)(68736007)(81166006)(81156014)(10090500001)(102836004)(59450400001)(8676002)(14454004)(105586002)(107886003)(25786009)(478600001)(2501003)(5250100002)(53936002)(3280700002)(316002)(54906003)(4326008)(6512007)(72206003)(66066001)(22452003)(10290500003)(99286004)(15760500003)(76176011)(36756003)(97736004)(106356001)(110136005)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0805;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: 6qN151YS+1UHPS0vc72AoBz7jLr05dYBUGfTUtYxBX50LCZKwIy155AFpOdke4HW6ZTWZyrVOuggtW7OAesq0AyUGkjZjqKune8efEG3t/BuPaFoK70kmV05K3rzm6/8mpEaVdDJg/4fQ0H3kMcMc7Dz7NXGez/j+1lA6kLt3mrn6Dv0zoMRJW46aIxEJnAkPJ56FWhZ6oob5ftqchrPx8M0ureQjeEHJYtPuGPFWheAXQs+/Ol2W+xxt3+9rU7kyb5P9kxAvmiW1bKXF5QUxl0pFjSPcxjd2g/E+S03wHQxl/OK/qe5+0JxHgkevJuBTFdyZHpw9IhNUxxb5DKVUA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6d53526-74f8-4fe1-9fc6-08d58db3a3bc
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:06:33.4088
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0805
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
index 1ba82dc5afa3..d98ff184d94a 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -3874,7 +3874,8 @@ ext4_mb_discard_group_preallocations(struct super_blo=
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
@@ -4031,10 +4032,11 @@ void ext4_discard_preallocations(struct inode *inod=
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
@@ -4290,11 +4292,14 @@ ext4_mb_discard_lg_preallocations(struct super_bloc=
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
@@ -5116,8 +5121,8 @@ ext4_trim_all_free(struct super_block *sb, ext4_group=
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
