Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1086562-1520489516-2-8422037647266529709
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
    t=1520489516; b=G69rg9ZICOY3pwLMmZgfHopryFt3275G96bePpwWSYX/Scq
    gDeBeYf9UQYQpH7U32vEUnNLwtBmms9+n8nkep/5XiQhQZUIxZK5ePguoDffF3GE
    SqnHbBxNSrRvI+6De387gI3AoUyg2/TFvMwvowFSF18a3evnyELsqGIbHDuoMZcC
    hV0DX57BlWaPEaVbSETqNO214Wz3wZST94e+56za1dObXddquGhh4jAh8V56Qvm5
    8x8QtNjrbgP1lwsikZnxa5YBQxNe/JAZx40AO3J7w9iZPPzoXxkT2JyjnThm6Fm6
    xbdBtvLGsRhwjy1FcyPu7gXenbHIeHg8wHNONJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520489516; bh=MR0ZSK
    ZojuOIOjC73SubFpzCyclv/8tvxoEqeZ472/A=; b=g8MzksxkgzpbHbdWX8zYJq
    UXIwyNZiFljZNK9xfcIRrnNsc/rkqX4dA5q0Lu0DOjMGUKKCLiyrNIJfje0cv7Pz
    /xEHd78/Y6aovsVLJzaBFe/JHON0OmKVEvHqaqRIYSaIA/6Kidn6flQrUBTfew+R
    hH18jCQR2rkxbE4Mg+cV3UZiZDSXVpcW+85vVG40clfekmzak78ZyD7S1fE4giMk
    XPNkcoUzeUB+ss9rafPK2tKlBz0diOD64/ChD6hJW1XnzMdsBcFtjYa6UFoL3gKv
    8MS2hM9X5QIdUh+onUDnCcagbLzsWx1CYjbx2IJpkCsA9nt5pjazKf30I5vobzSw
    ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=k9Cp8zms x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=k9Cp8zms x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965392AbeCHGLx (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 01:11:53 -0500
Received: from mail-bn3nam01on0131.outbound.protection.outlook.com ([104.47.33.131]:60864
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965391AbeCHFBg (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:01:36 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: NeilBrown <neilb@suse.com>,
        "J . Bruce Fields" <bfields@redhat.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 088/190] NFS: don't try to cross a mountpount
 when there isn't one there.
Thread-Topic: [PATCH AUTOSEL for 4.9 088/190] NFS: don't try to cross a
 mountpount when there isn't one there.
Thread-Index: AQHTtpo9E1xFXLh1a0Od34dAK4IeRQ==
Date: Thu, 8 Mar 2018 04:59:30 +0000
Message-ID: <20180308045810.8041-88-alexander.levin@microsoft.com>
References: <20180308045810.8041-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045810.8041-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0983;20:urj5fAr1trC8wd0DZOaNvLLG2NMhcpBdp3Sr4QjEBNXZ1i7TXyLyPZ0iCioBYcLLkmdEVZRBXLX7CEdomdNEfJGZFWoXukZHwezRwxSgwECVAlG58doFVKeDzcsnSS7ca2SieRcoYfT9mpkqlMxFqKVTNPG7V2IVR3rotG30Bkc=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6a8af9eb-b621-4e21-714a-08d584b1aa7e
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0983;
x-ms-traffictypediagnostic: DM5PR2101MB0983:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0983853153A374FF9CCC0317FBDF0@DM5PR2101MB0983.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(265634631926514);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231220)(944501244)(52105095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0983;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0983;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(346002)(39860400002)(39380400002)(376002)(366004)(189003)(199004)(6512007)(22452003)(54906003)(3280700002)(186003)(316002)(6436002)(110136005)(8936002)(2900100001)(10090500001)(5660300001)(99286004)(6486002)(106356001)(86362001)(575784001)(97736004)(7736002)(107886003)(25786009)(305945005)(76176011)(36756003)(8676002)(6506007)(5250100002)(105586002)(10290500003)(102836004)(26005)(1076002)(53936002)(81156014)(2950100002)(14454004)(81166006)(6666003)(2906002)(68736007)(478600001)(66066001)(3846002)(3660700001)(2501003)(4326008)(6116002)(86612001)(72206003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0983;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: OJQ2eIjCNUslScb/Egoc02A5CyHItfvlVqnhl6wCydDp90UGPI75jDgjYturORcKqa8iJ/NSuTAU6ecJsxxEfqCNZOCIga9Rk6hBUcCmNM4r/VmSTsbHwAMi2h65Ly6tRIXIU+CWZ7+9Kmr2s9D9HfEnP/mxqFF+L/Lz/0ioGU1KAPpFP6plkfqPaAeW27x+LJTjOhZLWEbYV9okKHj18GSxH9t7/u6N0lD+xKgArL8oMLF0mDVOB7EBcC4B1kGUvyTDxiaKlA+205IVjsqyPB/P+MGa1sgbqgjasTlqKkxV80Fa8KZ0CF9khzd8CFW3WWaBC3+r8CyFlawiGN+zGQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a8af9eb-b621-4e21-714a-08d584b1aa7e
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:59:30.4264
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0983
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: NeilBrown <neilb@suse.com>

[ Upstream commit 99bbf6ecc694dfe0b026e15359c5aa2a60b97a93 ]

consider the sequence of commands:
 mkdir -p /import/nfs /import/bind /import/etc
 mount --bind / /import/bind
 mount --make-private /import/bind
 mount --bind /import/etc /import/bind/etc

 exportfs -o rw,no_root_squash,crossmnt,async,no_subtree_check localhost:/
 mount -o vers=3D4 localhost:/ /import/nfs
 ls -l /import/nfs/etc

You would not expect this to report a stale file handle.
Yet it does.

The manipulations under /import/bind cause the dentry for
/etc to get the DCACHE_MOUNTED flag set, even though nothing
is mounted on /etc.  This causes nfsd to call
nfsd_cross_mnt() even though there is no mountpoint.  So an
upcall to mountd for "/etc" is performed.

The 'crossmnt' flag on the export of / causes mountd to
report that /etc is exported as it is a descendant of /.  It
assumes the kernel wouldn't ask about something that wasn't
a mountpoint.  The filehandle returned identifies the
filesystem and the inode number of /etc.

When this filehandle is presented to rpc.mountd, via
"nfsd.fh", the inode cannot be found associated with any
name in /etc/exports, or with any mountpoint listed by
getmntent().  So rpc.mountd says the filehandle doesn't
exist. Hence ESTALE.

This is fixed by teaching nfsd not to trust DCACHE_MOUNTED
too much.  It is just a hint, not a guarantee.
Change nfsd_mountpoint() to return '1' for a certain mountpoint,
'2' for a possible mountpoint, and 0 otherwise.

Then change nfsd_crossmnt() to check if follow_down()
actually found a mountpount and, if not, to avoid performing
a lookup if the location is not known to certainly require
an export-point.

Signed-off-by: NeilBrown <neilb@suse.com>
Signed-off-by: J. Bruce Fields <bfields@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 fs/nfsd/vfs.c | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index b829cc9a9b39..8f0b19a3ca81 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -94,6 +94,12 @@ nfsd_cross_mnt(struct svc_rqst *rqstp, struct dentry **d=
pp,
 	err =3D follow_down(&path);
 	if (err < 0)
 		goto out;
+	if (path.mnt =3D=3D exp->ex_path.mnt && path.dentry =3D=3D dentry &&
+	    nfsd_mountpoint(dentry, exp) =3D=3D 2) {
+		/* This is only a mountpoint in some other namespace */
+		path_put(&path);
+		goto out;
+	}
=20
 	exp2 =3D rqst_exp_get_by_name(rqstp, &path);
 	if (IS_ERR(exp2)) {
@@ -167,16 +173,26 @@ static int nfsd_lookup_parent(struct svc_rqst *rqstp,=
 struct dentry *dparent, st
 /*
  * For nfsd purposes, we treat V4ROOT exports as though there was an
  * export at *every* directory.
+ * We return:
+ * '1' if this dentry *must* be an export point,
+ * '2' if it might be, if there is really a mount here, and
+ * '0' if there is no chance of an export point here.
  */
 int nfsd_mountpoint(struct dentry *dentry, struct svc_export *exp)
 {
-	if (d_mountpoint(dentry))
+	if (!d_inode(dentry))
+		return 0;
+	if (exp->ex_flags & NFSEXP_V4ROOT)
 		return 1;
 	if (nfsd4_is_junction(dentry))
 		return 1;
-	if (!(exp->ex_flags & NFSEXP_V4ROOT))
-		return 0;
-	return d_inode(dentry) !=3D NULL;
+	if (d_mountpoint(dentry))
+		/*
+		 * Might only be a mountpoint in a different namespace,
+		 * but we need to check.
+		 */
+		return 2;
+	return 0;
 }
=20
 __be32
--=20
2.14.1
