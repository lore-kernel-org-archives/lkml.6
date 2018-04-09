Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3968184-1523243958-2-6526945141013273490
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
    1523243957; b=riiqHqxlIPUlfVbGUVLe1nISreH+mrkPZtBe+vO47u/mLBZ7FP
    Y02xLtJDMwHUHsXQ+v/NNDbc7Bb3Xqn2mcxkR2m4avB++t/NDPkIyHUdxNqwge7t
    MiZWUsstrCA0Wxk1FbeaLyc6ytfS7+e7/mNCE33d9KPOpiQPvx8MK7x/ya/ejj/w
    lQ/SvrzhlRsCNBKX9lIHV0qk75J5k6EKT5vs+g92F3ZJil2kjlPsHAnsdrvVi6Tx
    0juGKLsa6hlyAq3jii4qlzxWTEkKzHX4j8B2kg0nZPKviCfWimnEnNpzICYPZeRA
    mrTs+ES8RcKJVLP+p5d7/u4Gl2rh06sQ5ZXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523243957; bh=3fH1xlmjvb
    eYiIYT7nf3lvYzCjIISLwJP4FG5O2u68c=; b=M2bCn62hGxqOXPPwxlDO2Ere/s
    6Iwf5GmvvGb5EmijVGVHpM+3EKk+igqb79KqND/H+kHoqW1ue+dnHziwq84t03Db
    1LvHzUZlatORFxvfkKF9domG+/B/3qBac2HuGK4w3+DMd8qlWPXlVNUYpseDw/n9
    rp/PAdm0G01QnmENlRW/3EgcFPhyDY5NPk0xYY3sot8WWxA34kH2vC2LsiuFVgb+
    NB7qNUQohVsk38uqF7ODc8ketiMVRIzT2LdQGfdoelq3zRwcC6ZiZTiJuybGG5Mw
    WhUFAJUfQM0ZT3Ui43SCPuCyPLw5G86grD6tyFxuGmYBYe5EnC6IKnxaNoig==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=EC8Uhl6B x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=EC8Uhl6B x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfAR+By5QJk1krg/JQiG4De7i1UBwYf9YDp8yuXMs7wadvfpzH9xPdh0Ex7Azkg0diDJ/DzkLt8ovB+H7fJvIp9aP316UuSBp6YrDC5ZpcpRpK/5bnRDN
    twDFV4ekS47N4dXuZzd128ek8hSKIl+qT3rGk4FRuSo/QM6VzHStcjULtcwWzg9nnAudnDqfzcSHQZ1tReAYjJB9AGjwoHIi0sizgz3yw6Z9KieumHu7PKos
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=yPCof4ZbAAAA:8 a=VwQbUJbxAAAA:8 a=iox4zFpeAAAA:8
    a=yMhMjlubAAAA:8 a=sdoPFwP2wC3FMohMv5EA:9 a=bHE92GVGLNHByvyT:21
    a=SXdcV7TddoC2q5Dh:21 a=wPNLvfGTeEIA:10 a=AjGcO6oz07-iQ99wixmX:22
    a=WzC6qhA0u3u7Ye7llzcV:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752616AbeDIDTB (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 23:19:01 -0400
Received: from mail-bn3nam01on0095.outbound.protection.outlook.com ([104.47.33.95]:56127
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753917AbeDIAXb (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:23:31 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Liu Bo <bo.li.liu@oracle.com>, David Sterba <dsterba@suse.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 053/161] Btrfs: fix scrub to repair raid6
 corruption
Thread-Topic: [PATCH AUTOSEL for 4.14 053/161] Btrfs: fix scrub to repair
 raid6 corruption
Thread-Index: AQHTz5iQJZXOBPKxsU2+abgRTAprVg==
Date: Mon, 9 Apr 2018 00:20:29 +0000
Message-ID: <20180409001936.162706-53-alexander.levin@microsoft.com>
References: <20180409001936.162706-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001936.162706-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1014;7:LbmItQTg+XIskVbTCd2NMDKZJsyPnTrZHST+JM+XB45Yfor/VRDpJOKeZKaTzUmxr1knGOLobfAIKFis8wJ/5DhEOWINPaTqa/egvlxAnU9zXguA1iYPDAwlpA4Z1Ul9hdJUevvT1QIZURhN3UuDNZKfWHNGISD66iuaYmfblg99150y0CXYRfMVc1u2x2xw/g6NhXpcXNCdAaEjd28KIIHt+zS8hcAgZ/0QsMMLPUvii9BGXyqEVyImr1jDh9mP;20:1hDigbF1jVDcMELWcTYBPhCQl55nunXZrkFTIQhp2L8IHLumb4s+tzDniAzQXdk80nTOIAjyqEH0cOdjJvsy8YMVg7vAB0Qe+WeQrqVNtWcCfXdb8b5r1dtiFyYycewX0a87M4xK/6FAAsp8cgpD4cXa9i/CivAm13WuefYloMI=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 545c761c-18ba-402e-df84-08d59db01e51
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1014;
x-ms-traffictypediagnostic: DM5PR2101MB1014:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB10147FD57174FF99093B303AFBBF0@DM5PR2101MB1014.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB1014;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1014;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(39860400002)(39380400002)(396003)(376002)(189003)(199004)(81166006)(81156014)(478600001)(6436002)(72206003)(8936002)(10290500003)(106356001)(99286004)(86362001)(2616005)(7736002)(2501003)(446003)(476003)(8676002)(11346002)(105586002)(305945005)(5250100002)(6512007)(53936002)(68736007)(6306002)(107886003)(66066001)(86612001)(966005)(2906002)(14454004)(186003)(22452003)(25786009)(4326008)(2900100001)(486006)(36756003)(6486002)(3660700001)(59450400001)(54906003)(26005)(3280700002)(110136005)(1076002)(10090500001)(76176011)(6506007)(97736004)(316002)(3846002)(6116002)(102836004)(5660300001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1014;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: Mh6xbSwND/HDCet1AgnwZcfbDFPBW3Gz1Pacog9X9YR6FbFCiZ1yVpL9rtPd6nFA9D0CSYRVi9FU3q30RTadaawqgyvcjSrHV+zfJ5sTpfdaKVp4kg9MjSCSsCUHDdnrJ20ei0gMVb4jks6AC8uJ6s8kucthpES+56XjKAVFYJsk7qWsBcZgEAYHceOL7n38mbgFvIINeZ7HsnSGqIc6EkVqcrnblZ3XsaI4XWisMBJfDJRPyB1M/Aozdcpdu7DPiuFZlOxSnEe9bSmRS+mZWwzie+bgirD1dUBQVwW2D6ziP0wAWu0W0IPssBn6xkDIG5V8dnOrkSb72UHQ2Ftncgpb+xJlRh4tmR9ILteN5nY6kEHKdB4pUO0BhXURKomDuZykjtaTyy3KN6SP/lgIN239L16d2Ah4Le6Kd6sg2VM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 545c761c-18ba-402e-df84-08d59db01e51
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:20:29.3631
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1014
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
index 32b186c5694c..dcab41157899 100644
--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@ -2159,11 +2159,21 @@ int raid56_parity_recover(struct btrfs_fs_info *fs_=
info, struct bio *bio,
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
index 71b3cd634436..5c72b9d2a885 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -5101,7 +5101,14 @@ int btrfs_num_copies(struct btrfs_fs_info *fs_info, =
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
