Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3689844-1523236760-2-986745558855274558
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
    1523236759; b=X6W2W0qtgf0OekEi6vOkOZqWGXACjZgTu+JKOYSk3LFmzoFMiR
    ImYZ0EzxuH3Im8/Ajf1LL5cFLYsjOloFf4Zvbuz5oYyEVlu29UJSy2uzZJb2eJx6
    VaiGA5WfkpJ4udAWVDN9lIEdNYQDa+aqKCtUSZQ25blBRyPqUYl9z2qPGk/Cf1Tc
    V4YjMQOJX6WbN9QzzsKOCkpPgC6vFFHasPPBRIV69X44d2hZQARtnEWgLyyp2PXb
    tFBnHlZ6Gm9IewUiZdR2d+RlQFWX5rPXvIlBT/+vzKKHvHyNhin8oZuL5LbOc5/w
    UCXW6eB2X65iFapk6T11PtRwtmzpDJ1Eo+rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523236759; bh=37khSAsiMv
    5fdXBnAWBc4DLFHSjjckv9Le4azQybBkU=; b=dz76odYoiupY83FwxYhdomUZbe
    gOckLv+gqajhHxbGzo67PaDzsF67ShiEU988hjPWRBYvkXCHmn7T6zkBBz6F0WBI
    tGDlUg/x5cK3e8L9PmN3o7SH9XMr7hH3jUJwYMVjhrAWe+Bv6xzObAzSEvVhuk2f
    Z5VbKk5ofi05fr0GhmZL6iA97d4ep3m8C2wcDee6YV/zhA8/Gtj4VuJeSlZsukf4
    em8BsH7AwDPXn9NEOIoddd5gNTSTVK/cDhug9hRIK2f7y8TuYwGZudbO5eqXHBFE
    fr6VRFTdc03zI9ZABry1fVFKxt80792LB/o7fhouo97pXN+jR40FoanCs/kw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=j0mwNm+k x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=j0mwNm+k x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfIwqT2munN+ospHrp6bJ+UKRlEXTgPm8Bz1ksYN3IM9SNhLSH3D0h1rhFtrnO8fM0HOkg2l02a43BH0kL6yJEhmKqpFecoelM5xGFNShIDWV85EELOnl
    qxmPrYMYcJT2dyMcTZXEh99rvLf/DyEbJs+FMXGTwg6pgY1FpNXXDvSdu2c5wGwtnX4Qb10T3nxryJqNQXTRIasFRZJOAn+DrXIYV8RkiMktc2X3RDb+urlW
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=1XWaLZrsAAAA:8 a=RPJ6JBhKAAAA:8 a=yMhMjlubAAAA:8
    a=Fmfs_lXRlCNEQNX1f9oA:9 a=V0ImqIf7RNU8Dc9g:21 a=AKvhE3tlVnw-sZAo:21
    a=wPNLvfGTeEIA:10 a=fa_un-3J20JGBB2Tu-mn:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754324AbeDIBSt (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 21:18:49 -0400
Received: from mail-sn1nam02on0135.outbound.protection.outlook.com ([104.47.36.135]:3040
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932828AbeDIAhr (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:37:47 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Tahsin Erdogan <tahsin@google.com>, Theodore Ts'o <tytso@mit.edu>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 099/162] ext4: change fast symlink test to not
 rely on i_blocks
Thread-Topic: [PATCH AUTOSEL for 4.4 099/162] ext4: change fast symlink test
 to not rely on i_blocks
Thread-Index: AQHTz5m/IYExRoG+qUehDlHNOqMMJg==
Date: Mon, 9 Apr 2018 00:28:57 +0000
Message-ID: <20180409002738.163941-99-alexander.levin@microsoft.com>
References: <20180409002738.163941-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002738.163941-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1031;7:Mwl3+Rhfl8GtSCWGUzNGSe5VpRgczodp5GbkURZ+A5TReXEcFXIwhbfiFB7OwoHm01DvmDxDPpZD6YPmihLafTFL4PjAHnkkmzNfWjwhsfLOInHPsn/E6jhYh2bsBuv+0OP4YVHMYOtNnY9CInfGERERDwase6nFKT7GWfBGybdi9d8+kr9IdesH3uD6P5pCD8mkQONXmL8bdt/FGfROtieDlPjbYNm31TeNbYAZRUNqEjTizUeBvbUJmb/tvg+e;20:kmJQVPyMSlT2tPwjBU70c/k91Yu27DPa6gqwkmlUPK8dFQINPuQxgEGjGfd5XXafqkIXv/3l6gKWQXz4N4FfHpHjigb6NdrLd2ZCsdQV2ShBvhfQjXmp/gRAlhfZnAwca91uvC5lTgNXYBXga9+LSOGt4+eOdlkrw2USJ4lRDI4=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 6de8d8c8-ade5-4868-ffd8-08d59db21bc2
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1031;
x-ms-traffictypediagnostic: DM5PR2101MB1031:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1031355B0299006B7BD64D77FBBF0@DM5PR2101MB1031.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(211936372134217)(153496737603132)(240460790083961);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB1031;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1031;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(366004)(39380400002)(346002)(39860400002)(189003)(199004)(2900100001)(10290500003)(99286004)(76176011)(14454004)(7736002)(11346002)(26005)(6666003)(86612001)(72206003)(478600001)(36756003)(106356001)(66066001)(2616005)(186003)(575784001)(22452003)(86362001)(68736007)(305945005)(54906003)(102836004)(486006)(59450400001)(110136005)(316002)(6506007)(446003)(107886003)(53936002)(4326008)(105586002)(6436002)(6486002)(476003)(6512007)(5660300001)(5250100002)(25786009)(3846002)(6116002)(1076002)(97736004)(3280700002)(2501003)(2906002)(81156014)(8676002)(10090500001)(81166006)(8936002)(3660700001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1031;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: mQAq5UCWN4UcM/eKmu2oEUDzDHcDCagq28tEoZwKchEs3ZxZWgvPu066BH0fGmP4EazB2cdh0mw6VC7jN6MiJCsN7Mo9GUu/ryA9+ZQSqK72ijJ71yzbkkdbXhCsc/lnbewc2cbu/f7hOd/sxDP2mvV5UBg/sXByI2zfxWPU9d22eeD5nl+t7rNS5Ic/EIzcglrxqHr18jriHhI3ybPPJguDEAvLss2Vfjjs0svsWeb440DREPLWgtGQUMtOfeiFMxqIJRXfidE8tKC+JV7AUdGXAMahotnF8VguMKiE9ZW2I7oBkgoDf7wnsXT8CuWxUMkWoYGA8ABuS69bu587unzAAe6blR4+/zGloenb3UU1wJO9aQtgLoKFJyQJ+8iM2v7ECYGc32rj8uXtKdIPBEgyqUDuh4n0gKCXcP074PY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6de8d8c8-ade5-4868-ffd8-08d59db21bc2
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:28:57.5053
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1031
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Tahsin Erdogan <tahsin@google.com>

[ Upstream commit 407cd7fb83c0ebabb490190e673d8c71ee7df97e ]

ext4_inode_info->i_data is the storage area for 4 types of data:

  a) Extents data
  b) Inline data
  c) Block map
  d) Fast symlink data (symlink length < 60)

Extents data case is positively identified by EXT4_INODE_EXTENTS flag.
Inline data case is also obvious because of EXT4_INODE_INLINE_DATA
flag.

Distinguishing c) and d) however requires additional logic. This
currently relies on i_blocks count. After subtracting external xattr
block from i_blocks, if it is greater than 0 then we know that some
data blocks exist, so there must be a block map.

This logic got broken after ea_inode feature was added. That feature
charges the data blocks of external xattr inodes to the referencing
inode and so adds them to the i_blocks. To fix this, we could subtract
ea_inode blocks by iterating through all xattr entries and then check
whether remaining i_blocks count is zero. Besides being complicated,
this won't change the fact that the current way of distinguishing
between c) and d) is fragile.

The alternative solution is to test whether i_size is less than 60 to
determine fast symlink case. ext4_symlink() uses the same test to decide
whether to store the symlink in i_data. There is one caveat to address
before this can work though.

If an inode's i_nlink is zero during eviction, its i_size is set to
zero and its data is truncated. If system crashes before inode is removed
from the orphan list, next boot orphan cleanup may find the inode with
zero i_size. So, a symlink that had its data stored in a block may now
appear to be a fast symlink. The solution used in this patch is to treat
i_size =3D 0 as a non-fast symlink case. A zero sized symlink is not legal
so the only time this can happen is the mentioned scenario. This is also
logically correct because a i_size =3D 0 symlink has no data stored in
i_data.

Suggested-by: Andreas Dilger <adilger@dilger.ca>
Signed-off-by: Tahsin Erdogan <tahsin@google.com>
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Reviewed-by: Andreas Dilger <adilger@dilger.ca>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 fs/ext4/inode.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index f0cabc8c96cb..e62afd15b35b 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -143,16 +143,12 @@ static int ext4_meta_trans_blocks(struct inode *inode=
, int lblocks,
=20
 /*
  * Test whether an inode is a fast symlink.
+ * A fast symlink has its symlink data stored in ext4_inode_info->i_data.
  */
 int ext4_inode_is_fast_symlink(struct inode *inode)
 {
-        int ea_blocks =3D EXT4_I(inode)->i_file_acl ?
-		EXT4_CLUSTER_SIZE(inode->i_sb) >> 9 : 0;
-
-	if (ext4_has_inline_data(inode))
-		return 0;
-
-	return (S_ISLNK(inode->i_mode) && inode->i_blocks - ea_blocks =3D=3D 0);
+	return S_ISLNK(inode->i_mode) && inode->i_size &&
+	       (inode->i_size < EXT4_N_BLOCKS * 4);
 }
=20
 /*
@@ -256,6 +252,16 @@ void ext4_evict_inode(struct inode *inode)
=20
 	if (IS_SYNC(inode))
 		ext4_handle_sync(handle);
+
+	/*
+	 * Set inode->i_size to 0 before calling ext4_truncate(). We need
+	 * special handling of symlinks here because i_size is used to
+	 * determine whether ext4_inode_info->i_data contains symlink data or
+	 * block mappings. Setting i_size to 0 will remove its fast symlink
+	 * status. Erase i_data so that it becomes a valid empty block map.
+	 */
+	if (ext4_inode_is_fast_symlink(inode))
+		memset(EXT4_I(inode)->i_data, 0, sizeof(EXT4_I(inode)->i_data));
 	inode->i_size =3D 0;
 	err =3D ext4_mark_inode_dirty(handle, inode);
 	if (err) {
--=20
2.15.1
