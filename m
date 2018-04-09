Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3836577-1523240562-2-15936145211678787303
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
    1523240561; b=fMlwpPXxxb/0fVeeXKm0L5xR8K+Fnfwsh2p7KeVfM8M4iFCQ18
    MHQUxRfVFBX3kvVAh/OZh+GBat00nBVNRVNc1wayl8c58EEw3WpOSdg6UXvutLeA
    NMNqoRtduYAlKbk49K6UjA+QQHJzSPMV3sxJ+52vOPRv/dVwl8r+9hBID6kHBiF2
    r+I5x7IBDIMtjzILNpcDUCqNsWE+3KlsmJ1EIv6Z9XFdTlRAzaU0ia0KttnpO2BY
    OpgmBe2+lG9p5srTnN/66FVKZO8vjisvcqksgTZIIIeIk8vZT+xc3K/fahMw2BJ3
    e/VI0YcpJa1eZeHDNvr3gjwQZicts0OmDHow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523240561; bh=/Wqe582Qrp
    s8wd4sOu9/yBZEnqP/TxQ8yj2Yo61ri+g=; b=h6nK0Q9/vZd3hXyGrirJ+HQ8kF
    G6yY0zPUMh8g2NbGeosYPZaxNS17aYFy4x/Y6u9gpTgDmu4Xulm0nUjTkrUKioum
    d9TUM9SCf2YEIMQpDUSppqUDtuE8TBp13WEJnyPBxPv6adHnDQ2niTN7SCKmRDot
    4xWcHhkDToCMS53SmsrXjeMg/9gxeGkaitZwCBnB3XBQGw87+T/IKJYZg3KrPljh
    dPIdklQ+Wzklhn9zhMvxTXvnC/411E1XF35qYi6YvbXzuoMSfBp+KTwJPDAQhhiq
    aMqn8IsBN82ZgGqu9Q5N1Y3gKYdj10NlFk4Xtf3tonUzTVpYmXh5qC5ZFwXQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=JQwSKlEI x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=JQwSKlEI x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfO4el8XheBUsKmQGqS5VP5ZnpsrnxwkWtN4pHfLBusdayBjvyi7q4aH0luOXr/S9F/d7JYHf4q1r3ApZjGtEe4gIt5xLHpX4Iw3KiiJFui/aNxhjplB/
    Ff84JIDycwA7vpK8boe3TE0XF6ITG+iCVjxNEB0QJHKAHcJ4TSriyYRQvElCUg+vMrIzaBxz0Vb0f0ohPTGBRS5Ul1fDMVB/cYyhXWBdKK++tJLNmRgdKDDa
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=iox4zFpeAAAA:8 a=yMhMjlubAAAA:8 a=tlxZNUUtLAkpftw_GhIA:9
    a=-hJDkygSm-Lx3iek:21 a=VW0SpRvjVJlYc6IK:21 a=wPNLvfGTeEIA:10
    a=WzC6qhA0u3u7Ye7llzcV:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932979AbeDICVw (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 22:21:52 -0400
Received: from mail-sn1nam02on0106.outbound.protection.outlook.com ([104.47.36.106]:7529
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755032AbeDIA3l (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:29:41 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Filipe Manana <fdmanana@suse.com>, David Sterba <dsterba@suse.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 113/293] Btrfs: send, fix invalid path after
 renaming and linking file
Thread-Topic: [PATCH AUTOSEL for 4.9 113/293] Btrfs: send, fix invalid path
 after renaming and linking file
Thread-Index: AQHTz5kb5Z1azJ67cUuCAB6hlIpbrA==
Date: Mon, 9 Apr 2018 00:24:21 +0000
Message-ID: <20180409002239.163177-113-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1032;7:GIRkht/Y9VAjWTHuKo4ukj5Lz0bBANmfJmhJJJPq3PkR3CE9ygDvlX1mwLhvMDBwulv8gIDUMdAqy/UMHeSD4E2waaNFVVAASqSUVEUprbvwlSY6KW8XWmUjUqH/zJ0udo+ry350/6DhEMGMgQPyegsWHP/QoeY+dGdcMtw6UFuZAb2LmsWUuUVo/8+noVP/cr62xxX+y8E2tRzlBemhVmIyCSR6VN0/DgwbYMmRNuE/3zut4TmVcGkE/2dROVr+;20:IEefjt52Qi1Iw8+bxwvSZPi2xJrssCJItOjZ0YSTG+2o5Qc0ee8bWtUbLE1jaQmRAFlir41t+o8MyoS5syo1bsEr8B/bBU/0kP2QCtz7CZEQLCRk9gfYIcTnHfmuhv1gEc0dlmzUn937g+vqAq0zvTdcm95dOmM+2nVlGaXxwWo=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 4ae69e66-efea-4cb5-708e-08d59db0fa9b
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1032;
x-ms-traffictypediagnostic: DM5PR2101MB1032:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1032EAE78A21DDADA6CA3971FBBF0@DM5PR2101MB1032.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231221)(944501327)(52105095)(10201501046)(93006095)(93001095)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB1032;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1032;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(346002)(396003)(39860400002)(376002)(366004)(189003)(199004)(5660300001)(76176011)(99286004)(10090500001)(2900100001)(105586002)(305945005)(7736002)(107886003)(2501003)(5250100002)(14454004)(53936002)(4326008)(8936002)(68736007)(25786009)(86612001)(3846002)(66066001)(1076002)(486006)(316002)(72206003)(22452003)(106356001)(186003)(97736004)(6436002)(6116002)(476003)(2616005)(478600001)(6486002)(10290500003)(2906002)(110136005)(54906003)(6512007)(81156014)(81166006)(8676002)(36756003)(11346002)(3660700001)(446003)(6666003)(86362001)(26005)(102836004)(3280700002)(6506007)(59450400001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1032;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: IBa56OKJAsk3hv7oQD+ePVRE1YZcaFycALX9/rRZyCHTTc1gR7vgXJJUBpD5LZHU6PKQCmlag8uY/6CYGanm1ghQxRfaQ1paofOoFxLiNxTpd9/MpdipOTG/HO/5xmBl9waPKRuogZINGNekyunNGcspnq65/1FNZca3JirbD1e5gZCPa3ezuMu22TwqUtRvmcQRz1r05S9J4C82XAjPtIWHwVhFzSI3v5mx88Be+Ena9zienUeFgYQhwNjztg9QYlYluznz3jRjNNIxX4bgv+BxhOCSZFmO+qyafLajLGUJ2oqkPIRRkjWO4VlzY1yS6rlnChNXIbt5pOSlHTiI/+IdB1ZZm2obP4zCTiapkAJupBXKb/yEVAPwxcICHyWX5zD3U1+sOO4exLcvhMH+YsWzA6QswnegdiyLOrpaC3A=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ae69e66-efea-4cb5-708e-08d59db0fa9b
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:24:21.7062
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1032
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Filipe Manana <fdmanana@suse.com>

[ Upstream commit 72c3668fed2b3eec7c6fc059e7b54855361e3011 ]

Currently an incremental snapshot can generate link operations which
contain an invalid target path. Such case happens when in the send
snapshot a file was renamed, a new hard link added for it and some
other inode (with a lower number) got renamed to the former name of
that file. Example:

Parent snapshot

 .                  (ino 256)
 |
 |--- f1            (ino 257)
 |--- f2            (ino 258)
 |--- f3            (ino 259)

Send snapshot

 .                  (ino 256)
 |
 |--- f2            (ino 257)
 |--- f3            (ino 258)
 |--- f4            (ino 259)
 |--- f5            (ino 258)

The following steps happen when computing the incremental send stream:

1) When processing inode 257, inode 258 is orphanized (renamed to
   "o258-7-0"), because its current reference has the same name as the
   new reference for inode 257;

2) When processing inode 258, we iterate over all its new references,
   which have the names "f3" and "f5". The first iteration sees name
   "f5" and renames the inode from its orphan name ("o258-7-0") to
   "f5", while the second iteration sees the name "f3" and, incorrectly,
   issues a link operation with a target name matching the orphan name,
   which no longer exists. The first iteration had reset the current
   valid path of the inode to "f5", but in the second iteration we lost
   it because we found another inode, with a higher number of 259, which
   has a reference named "f3" as well, so we orphanized inode 259 and
   recomputed the current valid path of inode 258 to its old orphan
   name because inode 259 could be an ancestor of inode 258 and therefore
   the current valid path could contain the pre-orphanization name of
   inode 259. However in this case inode 259 is not an ancestor of inode
   258 so the current valid path should not be recomputed.
   This makes the receiver fail with the following error:

   ERROR: link f3 -> o258-7-0 failed: No such file or directory

So fix this by not recomputing the current valid path for an inode
whenever we find a colliding reference from some not yet processed inode
(inode number higher then the one currently being processed), unless
that other inode is an ancestor of the one we are currently processing.

A test case for fstests will follow soon.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 fs/btrfs/send.c | 35 +++++++++++++++++++++++++++--------
 1 file changed, 27 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index d040afc966fe..c3836978967c 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -3531,9 +3531,17 @@ static int is_ancestor(struct btrfs_root *root,
 		       struct fs_path *fs_path)
 {
 	u64 ino =3D ino2;
+	bool free_path =3D false;
+	int ret =3D 0;
+
+	if (!fs_path) {
+		fs_path =3D fs_path_alloc();
+		if (!fs_path)
+			return -ENOMEM;
+		free_path =3D true;
+	}
=20
 	while (ino > BTRFS_FIRST_FREE_OBJECTID) {
-		int ret;
 		u64 parent;
 		u64 parent_gen;
=20
@@ -3542,13 +3550,18 @@ static int is_ancestor(struct btrfs_root *root,
 		if (ret < 0) {
 			if (ret =3D=3D -ENOENT && ino =3D=3D ino2)
 				ret =3D 0;
-			return ret;
+			goto out;
+		}
+		if (parent =3D=3D ino1) {
+			ret =3D parent_gen =3D=3D ino1_gen ? 1 : 0;
+			goto out;
 		}
-		if (parent =3D=3D ino1)
-			return parent_gen =3D=3D ino1_gen ? 1 : 0;
 		ino =3D parent;
 	}
-	return 0;
+ out:
+	if (free_path)
+		fs_path_free(fs_path);
+	return ret;
 }
=20
 static int wait_for_parent_move(struct send_ctx *sctx,
@@ -3809,9 +3822,15 @@ static int process_recorded_refs(struct send_ctx *sc=
tx, int *pending_move)
 				 * might contain the pre-orphanization name of
 				 * ow_inode, which is no longer valid.
 				 */
-				fs_path_reset(valid_path);
-				ret =3D get_cur_path(sctx, sctx->cur_ino,
-					   sctx->cur_inode_gen, valid_path);
+				ret =3D is_ancestor(sctx->parent_root,
+						  ow_inode, ow_gen,
+						  sctx->cur_ino, NULL);
+				if (ret > 0) {
+					fs_path_reset(valid_path);
+					ret =3D get_cur_path(sctx, sctx->cur_ino,
+							   sctx->cur_inode_gen,
+							   valid_path);
+				}
 				if (ret < 0)
 					goto out;
 			} else {
--=20
2.15.1
