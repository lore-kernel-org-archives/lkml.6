Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-981117-1520487258-2-2143014581212488235
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
    t=1520487258; b=jzAM4scRD+Aze9G8U4zv7wCmJCqiFfuAZpCu3NF4Iti4PAi
    UdaKsE6sqRqC1tvBolnt/hIShQX9Cfk4TaNVubeSvyqx2wsJx4cg5JPA2VMa3CKe
    ZOyZLwedu9pf0IxQDnqDB3Jy3GmIh78LIUl46kd+BPiAI4ta6vNM+gOyEPom/Ziy
    UNIhwVRRifBDsxaMCCby0r6FYDtm31PmA6R3eS2aI4i0BiH1kQ5v8UDjKm3cX7aa
    Tw9Yxh5+aXcnor4iu+iYkur7xepeHh1sxhloYItWl/zjhtknaljmWl1w+vd1E/II
    IlOSBQt4mxGa4uzYhhP3wZqWmCpRq3J6FnznO2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520487258; bh=o7kN25
    9q8El2X0wI/O5MIFslVNUJSY8Gxk44WgHGaWE=; b=GbNIeyvQ0Y2SdiIXxHXG5T
    TZzZ0l7U8kpyGyaUZuVs2um3x+u9Qfe55QuYy5hAyDpaGz/iloxNwz6hgafqAMBf
    VFI4eSPFUlTFkDX42SUBPBYnBj24Y7r6Cp1YkOChTWK3knH1PBR6wP8coND7y/Gp
    lx19nZjQDxJXlkx52JnLnXY80zMdbZ07uTWfSh7jdzUtacADlwmZRtQjFsGc3wvF
    e0NgJev47cVBsi+CzS9eyI79FntJ7Ru1jCIcOQt2aTYsI96qj5ij3Cogw2kposRh
    /ZfWN1ruFbD9exBd9QcbEq0b/hGbLFaeyIZblk5alD3BQIFeSKFtg4nULeeWZ59g
    ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=A1FSdrxb x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=A1FSdrxb x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966472AbeCHFeG (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 00:34:06 -0500
Received: from mail-by2nam01on0131.outbound.protection.outlook.com ([104.47.34.131]:12788
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966347AbeCHFGO (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:06:14 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: NeilBrown <neilb@suse.com>,
        "J . Bruce Fields" <bfields@redhat.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 050/101] NFS: don't try to cross a mountpount
 when there isn't one there.
Thread-Topic: [PATCH AUTOSEL for 4.4 050/101] NFS: don't try to cross a
 mountpount when there isn't one there.
Thread-Index: AQHTtpqS1nNIFVXeyk64RBpeTa2Rjw==
Date: Thu, 8 Mar 2018 05:01:52 +0000
Message-ID: <20180308050023.8548-50-alexander.levin@microsoft.com>
References: <20180308050023.8548-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308050023.8548-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0917;20:ZqYAbfLQjkXFw0egr6zHsHRPIrlX3B/cwf0HtlWrzsUTtp7BuY/sPGSUsc1E8KjahabCmb0d2d8BX9yy5XicBCO6nWFu17ugcr8n6lXYN2WeOYWOdJUi2oLBc+8lNo7N4UVVLEZ2eaxJjH89oMfe3ufFcPycwwBWx8/LaK7/6HY=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 38406545-1a5e-4307-7d71-08d584b24f7c
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0917;
x-ms-traffictypediagnostic: DM5PR2101MB0917:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB09179B24BCDC8BC4561D6D53FBDF0@DM5PR2101MB0917.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(265634631926514);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231220)(944501244)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041288)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0917;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0917;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(376002)(346002)(39860400002)(39380400002)(189003)(199004)(478600001)(2906002)(6512007)(6116002)(1076002)(7736002)(3280700002)(5250100002)(2501003)(6436002)(3846002)(186003)(99286004)(86612001)(53936002)(26005)(36756003)(305945005)(22452003)(6486002)(102836004)(10290500003)(72206003)(76176011)(110136005)(4326008)(10090500001)(105586002)(316002)(25786009)(97736004)(107886003)(6506007)(81156014)(14454004)(81166006)(575784001)(54906003)(8936002)(68736007)(8676002)(106356001)(6666003)(3660700001)(5660300001)(66066001)(2900100001)(2950100002)(86362001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0917;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: aJ8gVN43XDfgii3VuL2k0ML2M3VQv/6PPJLrJ4aIFmsTOYVszcn+iIlX6feBc+EfLFauMKejsMBa6mVGENYyiisrYEncJ52r42NHh5biC7MmDoOWpduH46IvK/Khfpizn1o0VWkvbaaYwVClZFTHvMM6M6fTDD/i2A3JawZo4+dEqtAwto5ro1bT1Tdafo0hjiQxqyJA1Uphy6AGQVo+0u01Pme+jIz6qR9EzxHnLA6weSZp2K0BDsg+82KYj/j5MNDe36AAR0eGRG1J2ed9PAeX43u5TiRJB/1pu+3HsYjLVtIpjhfw41YZXcmNTsHA8h87QXIHxmnwUBLpFLnOww==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38406545-1a5e-4307-7d71-08d584b24f7c
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 05:01:52.3569
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0917
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
index 91e0c5429b4d..17138a97f306 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -92,6 +92,12 @@ nfsd_cross_mnt(struct svc_rqst *rqstp, struct dentry **d=
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
@@ -165,16 +171,26 @@ static int nfsd_lookup_parent(struct svc_rqst *rqstp,=
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
