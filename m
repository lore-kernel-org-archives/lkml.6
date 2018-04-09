Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3695087-1523236380-2-9975784733389540544
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523236380; b=JunHGqiJVOBE632sIydqzuqephbJh5TuxBSPQ2LRCII2hwffgR
    8swnhwig4yamCOT7vN3jtuBHqKNk2vkkcGYIlIpbPgRG4k7ty1oZj8BR5MIAf5kV
    ij/38Jmff2NtgBaVIqTpuJIG1W7ehSJ2GHq1JBW3c2YSumQ1MFowMtqvkOuq5Rys
    z1RPSqi3O6kyFFUiDUIfKZnc0HnoOrQaaws31RNVExJjxeb95UW2100dDFGVw9ny
    Pym66QJbOexWvyLb9HPAEfJYpmUqPz9aXGUP/oj/CqD5TWH8UGrPjv0lpCG1jpkb
    yqZsEV5n6tC4HXAve0a18/ImDHdq1DcHRByg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523236380; bh=S6zyo+bs0J
    2UIH12BirffYtGAfp4TfJ/huYbTl3EGE8=; b=g1xuh5rHKHXayRTm8I/zF5pmFF
    a8ICLaGPt12fFs2W07+7w7zzhg++Vi23pSUlRt6YKc2iCzEHelwXjPBm0EuQmZpD
    JYZnPAJUG98ZhZLiBWLQtNLCynWaVGKuYPEqSA6PCh6SfktSEUTtUuAVjaNalQZF
    FZuikjiY8R6vHFVl59SER+BkQWBLwyJKKH+/2ta/ghcrycwMYsFIpf877bDzpG63
    xYdr3jFYl92/WVzcXFqiYB6CMaZozEPWB1k0qKemQBV7UoV6oeXJ6M2rAqff+SDV
    /BO8ocinQiDZmZ4wGnP7Y+lN1v+Vb2bLyE0O0l3ajSWaebrl38zGpo6xxMVw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=OZGPehkr x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=OZGPehkr x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfG+jWDfVt8CE7Q3EhwJWcaU6Aq65qbn3k56DURj5A7t4PT1dUuT9LQ/hvA+/DNYywKSPVcasOdlOoAZyRgVyDXLQuV9E5ZvAD6PrLB6SwQghYawKZ+Ax
    MVQkyi5y75K957mD7jS2r1v/Alkx2WpyeWb6Y6qw2W4G99gtFSX3CksO8x2ADiDeXdKALqE3g97whSnNGZxdAXrxEdHz1AXjUc+Zs06vmQ951zAmmKaw8iOk
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=yPCof4ZbAAAA:8 a=VwQbUJbxAAAA:8 a=iox4zFpeAAAA:8
    a=yMhMjlubAAAA:8 a=sdoPFwP2wC3FMohMv5EA:9 a=9sNPxEx9vO1_Ydjh:21
    a=ljEjL0k8rLSXbs74:21 a=wPNLvfGTeEIA:10 a=AjGcO6oz07-iQ99wixmX:22
    a=WzC6qhA0u3u7Ye7llzcV:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932982AbeDIAik (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:38:40 -0400
Received: from mail-co1nam03on0137.outbound.protection.outlook.com ([104.47.40.137]:26752
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932971AbeDIAij (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:38:39 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Liu Bo <bo.li.liu@oracle.com>, David Sterba <dsterba@suse.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 127/162] Btrfs: fix scrub to repair raid6
 corruption
Thread-Topic: [PATCH AUTOSEL for 4.4 127/162] Btrfs: fix scrub to repair raid6
 corruption
Thread-Index: AQHTz5nPTaM2UxaPiUC0jSgE1YbuiA==
Date: Mon, 9 Apr 2018 00:29:24 +0000
Message-ID: <20180409002738.163941-127-alexander.levin@microsoft.com>
References: <20180409002738.163941-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002738.163941-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1095;7:XG6seFRebQfC5+AUGRc9cigBVMtu5oFg1K9Tj/C1gyScczZATUSBs5lErsb7I9qFfCXrx9+cAFBJjHp3MsAre4ko/pGSB7CzG/9uW7/tQrmxzL0hkg9bzfv8sl57NIE/qWRoDJQp+vhq8NSBXLX/4eBnwG9pc3ANHVq8nSETl7DNUGxsE5qmpmH/BDyVT8mNSJ9OTLpf+U3zYUW5RlsmJXHi9ikKAZbPS9nBTfcKraQAIk+6g/FMUmhMg5Hw2YBN;20:Cpf4jWPnWVlS2yWW91sZ1Z9QgPFAXb7yztOfwAMJ4w4mCpYdvnKopH6n3YZ6/rbZaHpliayoBUdyCBvRS5mqVKPK4OlREsGjF5Rt5kojfK4tv32zq/7JLz+cSOog2TN+ej5XFq7Xq4eNdSBpXZz7fs5MI5v4XxgkvH//Az5uw7c=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2ee3373d-543c-4c2c-17b8-08d59db239df
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1095;
x-ms-traffictypediagnostic: DM5PR2101MB1095:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1095BD758296A6E142098E79FBBF0@DM5PR2101MB1095.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(10201501046)(3002001)(93006095)(93001095)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB1095;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1095;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(346002)(366004)(396003)(39860400002)(376002)(189003)(199004)(26005)(10090500001)(476003)(105586002)(86362001)(107886003)(11346002)(446003)(2616005)(102836004)(6306002)(76176011)(6512007)(97736004)(36756003)(6666003)(6506007)(8676002)(59450400001)(99286004)(4326008)(10290500003)(81156014)(86612001)(81166006)(186003)(486006)(2900100001)(106356001)(1076002)(72206003)(478600001)(305945005)(8936002)(25786009)(3660700001)(7736002)(966005)(68736007)(66066001)(110136005)(316002)(54906003)(3280700002)(2906002)(3846002)(6116002)(6436002)(53936002)(6486002)(22452003)(2501003)(5250100002)(14454004)(5660300001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1095;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: dFwo614SSg4qUxzQ7UCp0lqLG2vaeonWkV/1gD+ehwlM2bt3+7KdkVfwlR6HkknQ7G0N29lybiSdGNQZ2Lyuto2Lm9q43uhmG+X7o01rBBTX/JzKo0UCfwMUQ/Pcomsor8qvlw1q1CJRuxufncig+ueMui9psvbdv/ifSbpQk+n/9IyHuGGrehiGzTI0l5q0czMIpiSLzbjvD6VZt81p8F4Zm5K1tXNeEiOT6LGqBkSmlhCHCTy7zDrITfwzyqBp0qcWfgwrWQnFiWJg35jNdYm69ELGA/9G9LBSZqh0/TWasi6KOy1XoYu829XzyYJ+XQbEhsVfJnzFDg8m1ufqJB9tyKhi0Doof2d7c7RoSqzgfY/3rPfL2KMSAKRXuu0tD4XeT4gm8PzGY6VNgCKuSjn5523fnfKHOpJE3YuAlLY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ee3373d-543c-4c2c-17b8-08d59db239df
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:29:24.0993
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1095
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Liu Bo <bo.li.liu@oracle.com>

[ Upstream commit 762221f095e3932669093466aaf4b85ed9ad2ac1 ]

The raid6 corruption is that,
suppose that all disks can be read without problems and if the content
that was read out doesn't match its checksum, currently for raid6
btrfs at most retries twice,

- the 1st retry is to rebuild with all other stripes, it'll eventually
  be a raid5 xor rebuild,
- if the 1st fails, the 2nd retry will deliberately fail parity p so
  that it will do raid6 style rebuild,

however, the chances are that another non-parity stripe content also
has something corrupted, so that the above retries are not able to
return correct content.

We've fixed normal reads to rebuild raid6 correctly with more retries
in Patch "Btrfs: make raid6 rebuild retry more"[1], this is to fix
scrub to do the exactly same rebuild process.

[1]: https://patchwork.kernel.org/patch/10091755/

Signed-off-by: Liu Bo <bo.li.liu@oracle.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 fs/btrfs/raid56.c  | 18 ++++++++++++++----
 fs/btrfs/volumes.c |  9 ++++++++-
 2 files changed, 22 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
index 1a33d3eb36de..b9fa99577bf7 100644
--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@ -2160,11 +2160,21 @@ int raid56_parity_recover(struct btrfs_root *root, =
struct bio *bio,
 	}
=20
 	/*
-	 * reconstruct from the q stripe if they are
-	 * asking for mirror 3
+	 * Loop retry:
+	 * for 'mirror =3D=3D 2', reconstruct from all other stripes.
+	 * for 'mirror_num > 2', select a stripe to fail on every retry.
 	 */
-	if (mirror_num =3D=3D 3)
-		rbio->failb =3D rbio->real_stripes - 2;
+	if (mirror_num > 2) {
+		/*
+		 * 'mirror =3D=3D 3' is to fail the p stripe and
+		 * reconstruct from the q stripe.  'mirror > 3' is to
+		 * fail a data stripe and reconstruct from p+q stripe.
+		 */
+		rbio->failb =3D rbio->real_stripes - (mirror_num - 1);
+		ASSERT(rbio->failb > 0);
+		if (rbio->failb <=3D rbio->faila)
+			rbio->failb--;
+	}
=20
 	ret =3D lock_stripe_add(rbio);
=20
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 6d874b1cd53c..992ed3e7efb2 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -5047,7 +5047,14 @@ int btrfs_num_copies(struct btrfs_fs_info *fs_info, =
u64 logical, u64 len)
 	else if (map->type & BTRFS_BLOCK_GROUP_RAID5)
 		ret =3D 2;
 	else if (map->type & BTRFS_BLOCK_GROUP_RAID6)
-		ret =3D 3;
+		/*
+		 * There could be two corrupted data stripes, we need
+		 * to loop retry in order to rebuild the correct data.
+		 *=20
+		 * Fail a stripe at a time on every retry except the
+		 * stripe under reconstruction.
+		 */
+		ret =3D map->num_stripes;
 	else
 		ret =3D 1;
 	free_extent_map(em);
--=20
2.15.1
