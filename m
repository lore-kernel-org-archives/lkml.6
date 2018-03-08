Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-981117-1520487210-2-6218860305551380808
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
    t=1520487210; b=XpKbI4ipppffN48mVwel+/ehBbjN7ideUSelukWHI9z0LsR
    pSmAM61rYEkM6koegdDsgSfhz8UPkSGBPHdgSZRHvUeuahHjasZf7ecftVnwTe7q
    l+pwwSKRRo/Yt+OL6chSrD6E/lPASe+dpcqs7x5peHh+Hr4Qxur5zZZLNvsEtajg
    Swy9azgaYflCNp7TAVUGdsr5mauuJ1/Myc0JslGj7lHa9H3os9zgQEx1RLUMR/vK
    wY/YaBoBNmDFeZRmqQSNJpZGoHZrCwbDqj5ZDsxBiF0fjnHeJgVNSAexcQl44a8z
    xU8fSblROmsVOQOOGwdzqUJBjHBJLOjHWDwZpvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520487210; bh=KwQ1PP
    W7TArrRu0wp1MgpK64Yg+I45IMIGmCtuM4MtI=; b=ulfwf7AKaByfPMzYIWWGHe
    5yxlv4c2owcoEyuH5AOEEML9/T3r+t+HQ987nj5C8SFSmMzyEx8xYTBTTtaPwYoo
    TZoa+T2gt2EowPXlvaURlIiFX06G7qBOb41u6VrXnlhhugmmkUQVtRz/Q659o2FB
    aDUeqjo2NkDGzmVROTuFUmqSpZc6B7AtMuFHvlVqI7STgGjfqYofmmWt3OcMA1fs
    IoqS3M1k3BAZ+gTiCwRAfJkoh0pjA9oWDjI8ejVHYRrm1h8fQcvbxqYnYcmAN+4z
    JWOjmZC5UKAJ7owpm4MyGpCNCAn3LAE+60kSmdARuk6aj10SVd+q2cW3ia+wUbSQ
    ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=bdza9Vzt x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=bdza9Vzt x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935034AbeCHFcl (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 00:32:41 -0500
Received: from mail-by2nam01on0131.outbound.protection.outlook.com ([104.47.34.131]:12788
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965958AbeCHFGR (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:06:17 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Filipe Manana <fdmanana@suse.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 054/101] Btrfs: send, fix file hole not being
 preserved due to inline extent
Thread-Topic: [PATCH AUTOSEL for 4.4 054/101] Btrfs: send, fix file hole not
 being preserved due to inline extent
Thread-Index: AQHTtpqT4XvDcA0OM0O3Uuqtc785RQ==
Date: Thu, 8 Mar 2018 05:01:54 +0000
Message-ID: <20180308050023.8548-54-alexander.levin@microsoft.com>
References: <20180308050023.8548-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308050023.8548-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0917;20:xr6/jAzfTiJ6FAtdUZclLA5P291LS5THFwP0d+3xreS4Xk+vF5C9amPymX5mT8TqW6y0+zYbrSKkeroC2xpXEUBMkpiyl07gmXna4XanD+c8vtXKCECB1sMUixCROTJhUcrHUQry2wATruIBvNX8P1dZ4Ua1QxtxgW1nVSp7Rvs=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ad74d749-7d61-407b-e289-08d584b250ad
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0917;
x-ms-traffictypediagnostic: DM5PR2101MB0917:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB09171FBB830BF13DD58083CEFBDF0@DM5PR2101MB0917.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231220)(944501244)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041288)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0917;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0917;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(376002)(346002)(39860400002)(39380400002)(189003)(199004)(478600001)(2906002)(6512007)(6116002)(1076002)(7736002)(3280700002)(5250100002)(2501003)(6436002)(3846002)(186003)(99286004)(86612001)(53936002)(26005)(36756003)(305945005)(22452003)(6486002)(102836004)(10290500003)(72206003)(76176011)(110136005)(4326008)(10090500001)(105586002)(316002)(25786009)(97736004)(107886003)(6506007)(81156014)(14454004)(81166006)(54906003)(8936002)(68736007)(8676002)(106356001)(6666003)(3660700001)(5660300001)(66066001)(2900100001)(2950100002)(86362001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0917;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: qYKSNApl09/D6mpytXVtQ58kEvo67in1cO7PfyhLXHYShv+jBppwxKEnjeuQQl7XxKIXQ0a/3njUVvY0Sd2MLbYESw5KC9hQfF/Mxir3MeNgpyBTxyvK9Lapk83DF1lcHADXrgzKkUnm0VY4fhUaljZWc7bNdvw3P/lh8CqM+8AlfW3JJTHoUxHwef/eB8+MNXk8r4+wfc4lbufXw2j+9T1k0qfc1vuCzjSBhgj0xFdJB8tS+e3R4XhG+6XF3EfDnFKtWuUsxGUK9szZ8ov4GIy9LxegHxnqzHlVThTnXHmP0TnuwNudQbROzlIz7ymVJB4fap211xwRUuULFHJ0Vg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad74d749-7d61-407b-e289-08d584b250ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 05:01:54.0260
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0917
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
index c5bbb5300658..19b56873b797 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -5008,13 +5008,19 @@ static int is_extent_unchanged(struct send_ctx *sct=
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
@@ -5028,6 +5034,19 @@ static int is_extent_unchanged(struct send_ctx *sctx=
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
