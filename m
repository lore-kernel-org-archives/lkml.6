Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3836577-1523239296-2-9464549962064210213
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
    1523239295; b=BHmhmBsxSDf6Qrn6jOhgKvwUefmtdXx0IJEsqdz7WcZkM/6gt4
    0/O6wx/peCgbn+BUKaMeb/I5by3Gzshgy+Zbei8a5D2f1u+gG9lhbcm3QSQ64TBM
    kVXsmS5CyHau7xmvnOTsU0bjOPX4b+wii1peV1ctRhQcfDHR/iiQqaPnh2AlIt2p
    Ow63Bwdd94oTwDJfySdtL4ON3gNttWm2DoKi2vCWSu3Y7I7h2fCRZ/MXEOSEnAbj
    irbjk9HRLHSCNFvJOqKqBq1SHRzwuh1iKPSNwZr+hlhJ+hwvtU8DqvZnOVQgicaj
    VfxY/lx2adz5lUFAxrnlNKkBfkhqe85ws8uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523239295; bh=v6A1wYuPa1
    TKnzafA8nwlXm6Yg9rVq3ahLcYaIDTUSU=; b=nnXQ32FXKzOl/QVeuzFfmGk1rm
    jtjwOaM58LLKHPaWMT9nRiJIJEnW6BeG8xowG7K9h/f66gqsHUfJ4lOdrKKnMaWn
    r4oTP7VhNWBDXcL00KQWzA20UOBkOC2/9qkIjVaH5tgaHfJvm5oXsoGE/1pUc2UF
    Tv1jHxgPO29Kj5PqUecA3ooScvhMPbmb4Y06kyoPNEd08kLbuBOT5T/sFm2WbxHd
    FE6U+RgL4Cez1GzdiJj+WWIyr12TJfFXbUO7DLeET1kvMdbTKBqRJEPc+5AZTLvT
    /2XKjTPtudqMq5nciFglTKXlL9LIebIR6fhfCTIPmOXxM1tQe5yQ4Nuhfcsg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=bP+FnN7x x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=bP+FnN7x x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfL4Er3Hf5O0K0uP4CO+LAl3g5OgMEMueV8t37J4+U8gWz7iFf2kophxv+IZIPaVkDzaWb39FnW2avAqLmnLulBo1BOwtwr4//JpTE/mkxez+fbXpjKfA
    v3h9EJsq87udyC7tsZ1IV/JLcHutu2p2V//8G4Nhx8imva/pMzS71MfxCAEbTCNvY0R9qrvcpZv9J3CpfPYa0AucDko0Qy2K8BAxdGNu8l0EjN7mLfLZOw8N
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=1XWaLZrsAAAA:8 a=RPJ6JBhKAAAA:8 a=yMhMjlubAAAA:8
    a=Fmfs_lXRlCNEQNX1f9oA:9 a=V0ImqIf7RNU8Dc9g:21 a=AKvhE3tlVnw-sZAo:21
    a=wPNLvfGTeEIA:10 a=fa_un-3J20JGBB2Tu-mn:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756469AbeDIAcO (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:32:14 -0400
Received: from mail-sn1nam01on0103.outbound.protection.outlook.com ([104.47.32.103]:45281
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1756440AbeDIAcM (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:32:12 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Tahsin Erdogan <tahsin@google.com>, Theodore Ts'o <tytso@mit.edu>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 200/293] ext4: change fast symlink test to not
 rely on i_blocks
Thread-Topic: [PATCH AUTOSEL for 4.9 200/293] ext4: change fast symlink test
 to not rely on i_blocks
Thread-Index: AQHTz5lDMhH58tsi/kqrW2TA+mvsxg==
Date: Mon, 9 Apr 2018 00:25:30 +0000
Message-ID: <20180409002239.163177-200-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0870;7:vgm77yOLA1NSSBDYS7/pdb23D3OxFzqUl+zS2xHxIX0Egy/MA69B+G7RClkr6VsBCuChkm/3g3Dlp+mArHFiMYQmsp9TEWIMl1VEkHOWTn7A5aI1KpET/CR43w/W1iol1hibDrXuxw0udHoGehf0hjRo28ge31dCxI8jsi+HOU8Mh+VhoMvsHY0sFeHNjuJm1AwX40uadM5im7wFP1A66YJh0VjJ1Qi0zlNJsbtZTobctUI/uyIkp/GPyHHYe620;20:JMCeYKWyNmu9laSShd27B/4anqNBwt7uzNgnxk/JdBD73xjavjFaYtBP+mkUkndvghXm+HOfEJVRkYhIdulYLmNt1HozNw5cOEyJ/lhYwcqkJ+XnYDqKlhodnkwnmKTHot/Mk9xcpXrB5KPL6C2vjtyq6p7r3PnfsHRU+sczbbM=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 1e360685-a4e2-46d7-06fa-08d59db15351
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0870;
x-ms-traffictypediagnostic: DM5PR2101MB0870:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0870A3EC068E94F9766EF963FBBF0@DM5PR2101MB0870.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(211936372134217)(153496737603132)(240460790083961);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231221)(944501327)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041310)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB0870;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0870;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(366004)(396003)(39380400002)(376002)(199004)(189003)(53936002)(2906002)(6512007)(102836004)(2616005)(76176011)(14454004)(446003)(10090500001)(11346002)(476003)(486006)(107886003)(59450400001)(2900100001)(97736004)(66066001)(6506007)(6436002)(106356001)(99286004)(105586002)(3660700001)(6116002)(86612001)(3280700002)(6666003)(2501003)(10290500003)(26005)(8676002)(8936002)(478600001)(68736007)(5250100002)(5660300001)(316002)(4326008)(72206003)(186003)(110136005)(6486002)(7736002)(25786009)(3846002)(86362001)(36756003)(22452003)(81156014)(81166006)(575784001)(305945005)(54906003)(1076002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0870;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: nN3e8HWKDOEa5eGWV8fUfgdms8ywKIfy5N4QC/uAfxGGydqyS6EI8iqheE7fN5V5wPOOcM2DkpNeLecbMvvcUZdnaMdg5BU/lTs0RKIEvu1KqCEmWQnk0X+CglOckxwx7NhsnEdHcMVVSMHH/g5Q5ESAGglI2h00KE672K780CPICKtGxgN6gMo0/53QWrONNPSLa8+uod2lH5jUS2EPQLokZk36SuGgzyrSGQ6fapndyV1LnTBOQWoqSxphKp55mFic7Cnq7NOSDBgidNT5LnC4SemgokTkZvmY6As2apAdNYxT3OYZZznRN0iKHVec0aN4st7Vu/gWF3kFSo4buSKrl+41xHyZxheiV7zontmjQX9eQW2RBP2toSKnyOUswZiGaO92xMqw+sHYei302vSYL3Hc8ksM06R0OAbvG7Y=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e360685-a4e2-46d7-06fa-08d59db15351
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:25:30.3315
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0870
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
index 58d57c56ec62..1c6c75ad1c60 100644
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
@@ -253,6 +249,16 @@ void ext4_evict_inode(struct inode *inode)
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
