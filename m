Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3643807-1523235045-2-8366924033838510302
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523235045; b=u+/51dDb712LMyqo5OuD+okWiy246ijno3a85+ShWounGcLiq/
    yvLpU8h5JXQw80hIIMm5+XkoYGM0TD/6duE0xHIutEuksrswjVfASV9XKWZSyiBG
    BtwWGz3SHfDMFFzm17T5fE7j4qyJQ6h7oj8ll6TWZ2XNpvaGGewWGrZNr3GaL3DD
    MJEG2/PQEO/se++tYjo6bfQUi7seInQ4Nr02Z3/lmoLWe+evbG2xXTliiIN9gxoY
    /4lmeWawOW1LY02M9RPntWMKb8eD9XccXSwZlC2yGrN4RpY2gNZdgsA0zX/ulMdd
    Iaua2uAcvoJ+nCuGr54EcwZ11y3UWUSLBikA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523235045; bh=DP3+av4X1y
    wZx5neAIjCnURWUootT7kJL1AFza8bbmQ=; b=GI3g2DzaprETDKa6FE8XHnMjW0
    jKc+GtYD4aJ6tLG7K4qx31jxuwrCWddU3rWfh2pTYuySVxPo0aSmVc9Fb0W+5ZzO
    KA23KewrxHEmkYokxI4zdMXn9h6uPvto3BxZLbquOq3NOvMd7RfRCC/pbTMv34gm
    hFhwHPVmDoS0/X1xgLK3ldPgFBY80hDxtmuqvoTZkYoVJ6I23FN5xpw0R1m9sjMs
    r1jgpkcWXzc9o/RfBpK3qTxiEs6CMlVBzKYiwdTvS7lrF2wIi+q8ch67ncnR+L5G
    emxaLqS3Ju4c1+fOxBUpgWWM82/NJ0qYpj4gcySh5KezHswU31iDLTe4Ei4Q==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=TWNENd9b x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=TWNENd9b x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfGnyKhsuE1PHvJD2+FyL7nvtzctkdjrcvgqCfQmAJfHAMFOs9MgyiyF9HDQkOOGtB21qo7y9eb/qIQ9dY0D1JP3ORGrDFIDHUNO1u6I6GJMTlTVRyAZS
    FxXDmJtH5OGp/nf0COIOm5SedIZa1u0jVvWFQckGc38gk5AF2Z/4KE3Gp7gulyW8wQCNMdlRwMRKbY2cvMOFfmOeT2o2cxWYq+aibbiDczgugfMLNyumreA2
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=1XWaLZrsAAAA:8 a=RPJ6JBhKAAAA:8 a=yMhMjlubAAAA:8
    a=Fmfs_lXRlCNEQNX1f9oA:9 a=V0ImqIf7RNU8Dc9g:21 a=AKvhE3tlVnw-sZAo:21
    a=wPNLvfGTeEIA:10 a=fa_un-3J20JGBB2Tu-mn:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933471AbeDIAld (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:41:33 -0400
Received: from mail-by2nam03on0126.outbound.protection.outlook.com ([104.47.42.126]:24363
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933437AbeDIAl1 (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:41:27 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Tahsin Erdogan <tahsin@google.com>, Theodore Ts'o <tytso@mit.edu>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 061/101] ext4: change fast symlink test to
 not rely on i_blocks
Thread-Topic: [PATCH AUTOSEL for 3.18 061/101] ext4: change fast symlink test
 to not rely on i_blocks
Thread-Index: AQHTz5t86aOEKMT1jkKbwpCeFOczzA==
Date: Mon, 9 Apr 2018 00:41:24 +0000
Message-ID: <20180409004042.164920-11-alexander.levin@microsoft.com>
References: <20180409004042.164920-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409004042.164920-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0901;7:Q+fh80E1/ZwP6D3oBJSWSVtLws7uLoqg/BgeA2lDhNSHpcxg6tX5STF4FcNbfi4nzOP9ot6RN93YyS1iNxWNQfDz0Rir/niXqSSHKXOulHB+xwrGbzuVKvBKIw9iQIT/fTw43j7Ni4pkQpMHoTM+Qe81lKm9fMJOVZcDl5EYLO213+cHoq4lfYI0vTrQBvULw2nFWseAJvZ5RbRKHaLQXNz/R0mCcOYzdBVsu2WAvEvUg5rN7/DaA6tTCkMKADM0;20:N1fc55f+HRK02bJfC1l9+wvjZgGPmzd9tdehZumGH5teOKLVxUNNBygVtcd9UHTs30vkahn9JfQHOXOyAnqMLRTb0/09PhNBJFo/ZFX7kPDCRpwWA0o11gFQqbr+XT02hBGKe3+0lbYgwmBX+VzoSd9nBttk0HXyOwsSj9h1tv8=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: c83fcb39-a155-43e1-009a-08d59db29fbb
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0901;
x-ms-traffictypediagnostic: DM5PR2101MB0901:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0901819C07F69BA68A4B9BF8FBBF0@DM5PR2101MB0901.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(211936372134217)(153496737603132)(240460790083961);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0901;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0901;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(39380400002)(376002)(346002)(396003)(366004)(189003)(199004)(59450400001)(99286004)(68736007)(10290500003)(25786009)(86612001)(6116002)(66066001)(97736004)(3846002)(76176011)(6512007)(54906003)(6436002)(4326008)(53936002)(105586002)(110136005)(6486002)(3280700002)(1076002)(107886003)(8676002)(10090500001)(2501003)(81156014)(81166006)(5660300001)(14454004)(186003)(3660700001)(102836004)(7736002)(2906002)(26005)(5250100002)(36756003)(478600001)(446003)(316002)(6506007)(2616005)(106356001)(8936002)(11346002)(575784001)(22452003)(2900100001)(86362001)(486006)(476003)(305945005)(72206003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0901;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: psVWVgju4Dxm5PR32l3ZnZiTldKogf1J44id5pv2EyU67DIeygUpXqssEBE3pGyWOa2NtXpnXG4Fn4cT9JSWeQRYDpUAmM49la4/7vHS3AttCQcs+nVrOXQ2PS1SFhemtAYgw79cethuENV59rBaNQsYy5G95NVpbS8P57Fbj7pcurEPFnGo12apiV2g7BbuKtAvCg6Oi4soxPln9J1KqRQJsV5qP4pC+C93M8QNmBSdqewhG/pjvpZLria5aBQXEw9G7bu1dHBNFAduCA1qRqy00Rcksjcg3B/YRiysnF0e/OgnlFB2w1FEKroJwlfD1G307bXO3IuavmVIjijsOV3nWh4rBbJPsOrAFKlSt5H4VJTA4lNq6Eljdj9h5reOrZy59Zicax3N8uZ2RCV4NNJfS+BPMLJaBRtEEkptKbY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c83fcb39-a155-43e1-009a-08d59db29fbb
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:41:24.4240
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0901
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
index c2434d72681e..c70d7d3832c4 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -140,16 +140,12 @@ static int ext4_meta_trans_blocks(struct inode *inode=
, int lblocks,
=20
 /*
  * Test whether an inode is a fast symlink.
+ * A fast symlink has its symlink data stored in ext4_inode_info->i_data.
  */
 static int ext4_inode_is_fast_symlink(struct inode *inode)
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
