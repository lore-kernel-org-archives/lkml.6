Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-966195-1520485336-2-13103672502305416822
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
    t=1520485336; b=ecBlkKBYh1E5k/miPedPhdKS7ilUJR2qPYg1adVm5W57L6w
    Stgi4gcO5uAylHhJXrMcH506lmefyy/JsODvr3mVVt1F4IvBZWkf2SRpe2+gVoE2
    INKR3EhoLV/mLpyEDsUQqlSqRBU5AqqKMEwsNm0rOjRorUDBz3QgXrqAUA4LMMb7
    DtWrgOlb5uPx5+FxO5pnwmdVz4yJYlcOtjzL3FLqLKr1yOsENfLSXOPjg9r7oFa0
    6MNcBNFwBuFd4MVHscPtQXkJUeiVVf+HMbX4kXcpuvXaqY/KB6UEwwlpYoVJmEFX
    ggbbBacqivtJLIlJzXOtyZbgfBJ3V87y5aSauCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520485336; bh=7zlraP
    6wAehke4iS5EhzswD2Y5wRwUSvYMGP9ckkdgg=; b=mgMCS72tih2xQ2Ra6nx2uA
    ion3g+4y9TvLFbKYTNKxY786T8TB7Zfh3u5OJfOXXNlREL35bB5BzgeL9ucCNhNe
    vLcRwpfVYr/orzfl70ZNtVC1nCPo+Rh2pRhH8NciXUnHu5vwyohvp87AIMSHdh3I
    VFfvxF8le09BQfb+TmH6Xm4jEP+vKI13DbeywGrRGcLndz3Gh0GiOaGUXN0+60Tq
    Vy4/gfJ/I+rCZPThvvqhv7NciUH6SF/uWxSsyRFzreWIKsfCCtBNpJ0g+MSmmatW
    Drvps1TxnuOZEBefTM8f8nlUSSpd3GnphF7m/RGgsaEID+rM3w+KheLLMkTZ9tLA
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=ZIwlPVQ7 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=ZIwlPVQ7 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755367AbeCHFCN (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 00:02:13 -0500
Received: from mail-bl2nam02on0103.outbound.protection.outlook.com ([104.47.38.103]:23927
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932759AbeCHFCL (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:02:11 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Filipe Manana <fdmanana@suse.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 094/190] Btrfs: send, fix file hole not being
 preserved due to inline extent
Thread-Topic: [PATCH AUTOSEL for 4.9 094/190] Btrfs: send, fix file hole not
 being preserved due to inline extent
Thread-Index: AQHTtpo/+vxVnWfc7UG8Ju9ruDb8Lw==
Date: Thu, 8 Mar 2018 04:59:32 +0000
Message-ID: <20180308045810.8041-94-alexander.levin@microsoft.com>
References: <20180308045810.8041-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045810.8041-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1063;20:OdxYPX9HpvNOhWBeXGhiVisVYSsq2GdvW8JK/w9sFQrcIOdKqiN8MLulD13wam6QUL43mayacavJkDe18EKgM4g7MjLTS2rDq6sdZEhhN3bFX6T/2XSs1dxM21dNrBVwCTPd2Jh4n86rPr4IOR3KY90G63nhUysN6bACAl5oiTU=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6a205193-82a1-413c-49ca-08d584b1be0a
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1063;
x-ms-traffictypediagnostic: DM5PR2101MB1063:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB10634312366F2997BDEE9E7EFBDF0@DM5PR2101MB1063.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231220)(944501244)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041288)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB1063;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1063;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(396003)(39380400002)(346002)(376002)(199004)(189003)(36756003)(186003)(2900100001)(6512007)(3280700002)(6436002)(110136005)(102836004)(5250100002)(99286004)(54906003)(2501003)(25786009)(26005)(4326008)(2906002)(10290500003)(86362001)(76176011)(6116002)(3846002)(6486002)(68736007)(106356001)(1076002)(22452003)(2950100002)(72206003)(6666003)(14454004)(478600001)(3660700001)(107886003)(81166006)(105586002)(316002)(66066001)(10090500001)(305945005)(6506007)(8936002)(7736002)(53936002)(81156014)(8676002)(97736004)(86612001)(5660300001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1063;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: /mMO6vp6vRxR3BAw8NRQ1EVnSDBCqyscwXrn5dcMO85onMRNykhGe8ED5InJNfJI1tMkxiCxn2CrvmO1z2kYBiWmxuulL4Kw/hhGA5UQ4UgeG+lhPdJf8pi2VIpSKWE1MY0j0oiGv1XiAnbpTEhvAeUxNCCXhyjLS4cRp2JF2nkL4444WJajAmToU5C3CwFFrrX6+GY4CS0GjYMS8RZu7XNR8iNJCJ4uNiFsNoK1Yk38r7T1/I/X+qqU0nri39dO8cRJUArDbhGf6xKS6UZMfOyXwJ+45rxwMIgvu74+BaPZF2x2Gr3N5bzDDPvuwQU4nLKvGM2gMv4uecXmOCZXjA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a205193-82a1-413c-49ca-08d584b1be0a
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:59:32.9362
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1063
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Filipe Manana <fdmanana@suse.com>

[ Upstream commit e1cbfd7bf6dabdac561c75d08357571f44040a45 ]

Normally we don't have inline extents followed by regular extents, but
there's currently at least one harmless case where this happens. For
example, when the page size is 4Kb and compression is enabled:

  $ mkfs.btrfs -f /dev/sdb
  $ mount -o compress /dev/sdb /mnt
  $ xfs_io -f -c "pwrite -S 0xaa 0 4K" -c "fsync" /mnt/foobar
  $ xfs_io -c "pwrite -S 0xbb 8K 4K" -c "fsync" /mnt/foobar

In this case we get a compressed inline extent, representing 4Kb of
data, followed by a hole extent and then a regular data extent. The
inline extent was not expanded/converted to a regular extent exactly
because it represents 4Kb of data. This does not cause any apparent
problem (such as the issue solved by commit e1699d2d7bf6
("btrfs: add missing memset while reading compressed inline extents"))
except trigger an unexpected case in the incremental send code path
that makes us issue an operation to write a hole when it's not needed,
resulting in more writes at the receiver and wasting space at the
receiver.

So teach the incremental send code to deal with this particular case.

The issue can be currently triggered by running fstests btrfs/137 with
compression enabled (MOUNT_OPTIONS=3D"-o compress" ./check btrfs/137).

Signed-off-by: Filipe Manana <fdmanana@suse.com>
Reviewed-by: Liu Bo <bo.li.liu@oracle.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 fs/btrfs/send.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index 9a47b5598df7..d040afc966fe 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -5156,13 +5156,19 @@ static int is_extent_unchanged(struct send_ctx *sct=
x,
 	while (key.offset < ekey->offset + left_len) {
 		ei =3D btrfs_item_ptr(eb, slot, struct btrfs_file_extent_item);
 		right_type =3D btrfs_file_extent_type(eb, ei);
-		if (right_type !=3D BTRFS_FILE_EXTENT_REG) {
+		if (right_type !=3D BTRFS_FILE_EXTENT_REG &&
+		    right_type !=3D BTRFS_FILE_EXTENT_INLINE) {
 			ret =3D 0;
 			goto out;
 		}
=20
 		right_disknr =3D btrfs_file_extent_disk_bytenr(eb, ei);
-		right_len =3D btrfs_file_extent_num_bytes(eb, ei);
+		if (right_type =3D=3D BTRFS_FILE_EXTENT_INLINE) {
+			right_len =3D btrfs_file_extent_inline_len(eb, slot, ei);
+			right_len =3D PAGE_ALIGN(right_len);
+		} else {
+			right_len =3D btrfs_file_extent_num_bytes(eb, ei);
+		}
 		right_offset =3D btrfs_file_extent_offset(eb, ei);
 		right_gen =3D btrfs_file_extent_generation(eb, ei);
=20
@@ -5176,6 +5182,19 @@ static int is_extent_unchanged(struct send_ctx *sctx=
,
 			goto out;
 		}
=20
+		/*
+		 * We just wanted to see if when we have an inline extent, what
+		 * follows it is a regular extent (wanted to check the above
+		 * condition for inline extents too). This should normally not
+		 * happen but it's possible for example when we have an inline
+		 * compressed extent representing data with a size matching
+		 * the page size (currently the same as sector size).
+		 */
+		if (right_type =3D=3D BTRFS_FILE_EXTENT_INLINE) {
+			ret =3D 0;
+			goto out;
+		}
+
 		left_offset_fixed =3D left_offset;
 		if (key.offset < ekey->offset) {
 			/* Fix the right offset for 2a and 7. */
--=20
2.14.1
