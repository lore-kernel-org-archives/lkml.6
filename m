Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4102378-1523246462-2-17962566624545046014
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
    1523246461; b=r3mIDOxhEhuRpSPUWMmacQIt4sCWyHP7Jiu2j7r0bScY02rNLg
    GQxntH2otknTL5xppxQIyLC+W5kPi/eoaIPgBZs/9lmDW7sXlXD7oUN6jA2RvfhK
    VSMnQI7q3tB9mLduVJFTxQRy/x8V5eWiSTEMRJZ60sLLeKgIgmjzlwBe+jzLrPGl
    6HxW6rFZpIUSQwQnrgsfL+t5YGmf7pVniclKxC3LyAaemJK0tY6+8w8uXGeXefbv
    F0FrUs9IbFNGjFoEA2WFimgAzWe4plqD2YBmsWTl5PC50kn/R7OT/RgKKJZKe7az
    MKr5rJlH7wPbsZLZbZvgE5mjYJdLOlqSb+Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523246461; bh=NRhST1FCsl
    XFd5e+yxj1CJXuYng5tAHYFuZDumEUrZA=; b=gPCuRkFZBCrjtCc5+v/934Zn1K
    4y+yiHVxlOIni4RH33l2W35aHnbJBb5oeNg+bzfPf3jeQ7bNWFmJl/yhTBFPR0NH
    qy91XLlD256E+6IkQL5XlgkiYLAto6fEQvJ+prCfGzEQdOLt/SDJuo/MonUII4oF
    a8GijAEEzj/oa5uazwD09iMraQkh1ocP3ac+VZ+oSYQuKlTAwsZyIXjWBG+193Jk
    iA9sjw8zNz0cbhOiMX154lDzWtoRiJmR8+FicY5o+AoAtviV2bzvEwFrvokciA4S
    8UxYixe4QIA3LXMzt/zqrhq0kkCvSjtKz8nBQIAu9/RP19KIP0tPSHjVe+0g==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=NAi9bWec x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=NAi9bWec x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfDEK9EEMVMr1G4P+OqqZNp5hGsB7svfD3Hz0PScFQe+bwPNGMHf5EKQPR/oZhgXmN5of5WK1H0TPoIwR62TxjzpMsij/zQCcynn6Yq4emZ5XYdpCqYbX
    Vh+HTFKYlbPy7To7MX27vi5lyIGJnuzrBUB5Z/HRoAwOPEnKAcN0RYd5qaNS4J1aOJfQNr2PoMGyVwtB66A4g0nOFEkZS4bpFqLjjUhJU6VEAlkMFPJDr7f0
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=yPCof4ZbAAAA:8 a=VwQbUJbxAAAA:8 a=iox4zFpeAAAA:8
    a=yMhMjlubAAAA:8 a=sdoPFwP2wC3FMohMv5EA:9 a=bHE92GVGLNHByvyT:21
    a=SXdcV7TddoC2q5Dh:21 a=wPNLvfGTeEIA:10 a=AjGcO6oz07-iQ99wixmX:22
    a=WzC6qhA0u3u7Ye7llzcV:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751991AbeDIEAb (ORCPT <rfc822;greg@kroah.com>);
        Mon, 9 Apr 2018 00:00:31 -0400
Received: from mail-co1nam03on0131.outbound.protection.outlook.com ([104.47.40.131]:30557
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753602AbeDIASd (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:18:33 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Liu Bo <bo.li.liu@oracle.com>, David Sterba <dsterba@suse.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 063/189] Btrfs: fix scrub to repair raid6
 corruption
Thread-Topic: [PATCH AUTOSEL for 4.15 063/189] Btrfs: fix scrub to repair
 raid6 corruption
Thread-Index: AQHTz5goo+0HhHq+BUSgfQLhLdo01A==
Date: Mon, 9 Apr 2018 00:17:34 +0000
Message-ID: <20180409001637.162453-63-alexander.levin@microsoft.com>
References: <20180409001637.162453-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001637.162453-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1046;7:jHlQ/zh3hnLQo8k1tx+5lPcdRuAIILeFfBt/iiotkJwlHOdm0cgmQacK19Y3Vy9oxABzRVuzGeQrvltIpiqIPhBcb6uq2b+lswkJTaTrnxbnbbTeeCzUOixO2UrqOnVzCizkqo9uG/nXzif5yY08fHwEXWmKIEve52EiU1lmdfFSg3FQrquV4/anw4GkmR/Ux6uFS6nj5tCqmzjoXGFePzJSNOVDJwsGzTyagpZQzkjFcjshHltL6bb6Jlc1+lxE;20:jhuAHYpK5E6LZXK2CfQsDwWOFj8LAgWGvkBi5j//MJ4KylDaLP42sbIm9YUseQx95fWtWPvtvbR1ybCH/c+JQh4gcih5psUOeh8RpWOelJ/RiHwkPcbQtaflyogA6Rjuje6dIiWNeKuMCk+aYxAEA3oD3pa5yi3jD/TaSvNBo7I=
X-MS-Office365-Filtering-Correlation-Id: 37d78571-9834-4c94-3261-08d59daf6b4d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(48565401081)(2017052603328)(7193020);SRVR:DM5PR2101MB1046;
x-ms-traffictypediagnostic: DM5PR2101MB1046:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB10466D3F0BEE2733371E60CCFBBF0@DM5PR2101MB1046.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(10201501046)(3002001)(93006095)(93001095)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB1046;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1046;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(346002)(376002)(396003)(366004)(39860400002)(199004)(189003)(36756003)(186003)(11346002)(446003)(476003)(2616005)(7736002)(5660300001)(26005)(10290500003)(478600001)(106356001)(6666003)(68736007)(10090500001)(54906003)(3846002)(59450400001)(22452003)(6116002)(86612001)(110136005)(99286004)(86362001)(72206003)(305945005)(76176011)(102836004)(6506007)(486006)(316002)(3280700002)(966005)(3660700001)(81166006)(81156014)(8676002)(2906002)(14454004)(2900100001)(97736004)(6486002)(8936002)(1076002)(6512007)(6306002)(6436002)(105586002)(25786009)(4326008)(2501003)(5250100002)(53936002)(66066001)(107886003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1046;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: L99zCFKY/ofB939kbWDYUHOd/8d+JKsR4QveVtwsLPh/OTetK/ZWnibHSoJMjALMbAXVopHpFeUTZZrdUd3ntKNoqDU6xk6gBeEYPifjvEkk6vLNFIcJe6KcpVPeM3xgxX2d47BiXaoC0gtM6nFTlLIMuTywBoPFxKWvkxe9ZFP6Qvk8zWDGHIrvDWQn1M4KfkWG7xDMqSirEx7jlbcddEoNBZcWqkfgAMAoH7HFpFunGAgNjZKcGUpjiGNQjQ1Gmli5CKuHHb41qql/mT6KEyvrsR8UmYsGFw1nw55G80laBBovWeP5dxCkiqDBAx2FJqiHmfDJj1wP1qDxSlr2wOfEWg618eErN6xKmOwORmYqMADrnWFEQqF3QLsqz/JQt28iq6DU56sYH+jLSpzVcNscw44YEONuUmZM6g2VQMc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37d78571-9834-4c94-3261-08d59daf6b4d
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:17:34.9777
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1046
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
index 8a3e42412506..025e69c57cbd 100644
--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@ -2170,11 +2170,21 @@ int raid56_parity_recover(struct btrfs_fs_info *fs_=
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
index 6631f48c6a11..82cdd9d74f04 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -5105,7 +5105,14 @@ int btrfs_num_copies(struct btrfs_fs_info *fs_info, =
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
