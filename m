Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-912290-1520485900-2-16724957727284028806
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
    t=1520485899; b=Q4r/qLsBaHqDPk8z1yI5YCP/UE8cphXYsQBl/d7iHSrxJvl
    TGQTpdH7yKfwEhxCsR3dCECv3MxdmlV7mQ3/1z0I1v4043162hb+5/3oRs8pUEFy
    j11nhEhacxoOLUhJ/V8tr9hmXksHYw8AEMc5OLKTL4wNzheCKV9MEZXPcEHv67LW
    OjW9CBMkmgGfCRhE4Ty1WnUFVLkXjHOy+b1hbI29JVKFJd6n+JlZrxcvs+0SYpm1
    1y9mh76kB8mhTdklHx5/32YhAxd7Ss9pkrcbKyZNAK5F0d7UmOtZe9X26TPKxxxr
    ay1FyFRGPqnqgi7fzMJ8C05NS/VW5/DHXGfNhAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520485899; bh=2AU6VY
    rQ61dQrB+ldHs0chuvj4FB2jrQzslrIyzB5f0=; b=m9dCM4wrlKGARMMSdOKjUd
    +5MHCr9uFtYbpCJgo3iXaDMSG/8Aqu60uQlXtbVjiaPg6d6+5kXPtN9rvOLbT5Gl
    QjZOWAep73KilQj+aX7CndFJ37vofvga4qEN4dd/r8ZJ0piZMxQDC2ZtqVG3kIYV
    2JWYgqy6b+Jct7llgCc0EUoTu58TX7yZfixPQnCa/DNZhEcdcb7cZPe8GoHUF2/i
    H/kydYOQGratKlOiS3d7KbgkwsUSJrOpaTIGsM9qkIJlaFJD6R9X5uBYOvdvQzqw
    y3Iq2D+iCZTaWel3GkRHxnSdqmxbGYP1Ig1ukHIAVdrfGcZCiRCiGNGsPLnWsKQw
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=WXbthneH x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=WXbthneH x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966778AbeCHFLg (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 00:11:36 -0500
Received: from mail-cys01nam02on0090.outbound.protection.outlook.com ([104.47.37.90]:35342
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966575AbeCHFLd (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:11:33 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Filipe Manana <fdmanana@suse.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 32/53] Btrfs: send, fix file hole not being
 preserved due to inline extent
Thread-Topic: [PATCH AUTOSEL for 3.18 32/53] Btrfs: send, fix file hole not
 being preserved due to inline extent
Thread-Index: AQHTtprHOTqNZ4BpTEODCZF8COg8Wg==
Date: Thu, 8 Mar 2018 05:03:20 +0000
Message-ID: <20180308050230.8876-32-alexander.levin@microsoft.com>
References: <20180308050230.8876-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308050230.8876-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1030;20:fmAxzs0fbAUQW+PlE709mfICc+haStQz2yanc4XBUuWIps3tI6Ifml77grjtW2Dy52oc5LZ09jbNvrEr0tsI50FPx8aGx+b5JmUHcAy4mtvDSbWgnVCLM30ecFBaSZ7xAlFDkhp017FQxa1zgAfvTxs+Zl4yi4xFvJtvRr3GmME=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 359c601f-1693-4f36-b8aa-08d584b2fa86
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1030;
x-ms-traffictypediagnostic: DM5PR2101MB1030:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB10307A97FBA730FA09B95D4AFBDF0@DM5PR2101MB1030.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231220)(944501244)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB1030;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1030;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(366004)(396003)(39860400002)(346002)(376002)(199004)(189003)(5250100002)(316002)(6666003)(6506007)(2950100002)(26005)(76176011)(68736007)(53936002)(6512007)(2900100001)(86612001)(3660700001)(106356001)(10090500001)(99286004)(2501003)(4326008)(14454004)(102836004)(25786009)(97736004)(6486002)(86362001)(36756003)(7736002)(6116002)(2906002)(478600001)(6436002)(107886003)(72206003)(186003)(3846002)(66066001)(81156014)(10290500003)(1076002)(22452003)(305945005)(110136005)(81166006)(105586002)(3280700002)(54906003)(8936002)(5660300001)(8676002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1030;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: GYzTmzWeqAHKyGLKuV3Dao8u0OC8sY1AlDvN9ttcirksVqQ+mS06JLpLGXHBuiWLTb7oVPMS/Hm5UzDWnc+wQdVF8SXX0Z7GtwtyvOf9Rx1Hfu94ZPzblsXhteA8qKs8WUllgTy5u9YsxDRz7KQ1pCOIDkAioRGS9fMpLASOHu5jtHyX5AKDPhQrEhSgaw32j8PSAvIoHWlIkxMbG1Jf5sAxqp5Ds5aircJsSs2LxX3CHtiCj1wFd3UKzF7glr+T6xuAKav6RPojZVKar6kedqzJAK6UX4UMJ9tehR7F4xP2u3PWspKX508y65nnBVDG+etjiiTLLxNBXaW1rBHB/A==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 359c601f-1693-4f36-b8aa-08d584b2fa86
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 05:03:20.9770
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1030
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
index fc2472ef5011..a7c4e2f205dd 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -4663,13 +4663,19 @@ static int is_extent_unchanged(struct send_ctx *sct=
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
@@ -4683,6 +4689,19 @@ static int is_extent_unchanged(struct send_ctx *sctx=
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
