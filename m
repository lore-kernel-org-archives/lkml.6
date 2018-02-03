Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1486374-1517681186-2-14291005833462619616
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517681185; b=Sx2JpUPALTdTghfSzQbSLownV+k05JWOc16EolgFp8rKX9+
    ywaDNkjE23tQoWIEa83XbtGFxHwMg8HxcxcuIcQjdr+QISKI3sQ8x1Bbw9jNEqcx
    rITkzyV85d9bnTv6o2kSJJ20mNMOR3JC51/+QoC8R86pI3kFq0Ir+YC+yQkHSZVy
    NQfpmOzjQpAT3TL4j7XWkgejd0fqxIrcMULkemGcCJsJ5O7jl1/qSMBk9rCPTm/V
    PH8DhYxZAelNysETf6+zYVBZz1CEbcTlmrjRbSiJ6gJQu39iyi+Buyu0IrlXLsM1
    ltga7g0c5ZTMg2524Lo9hc957aJAY2MLiGGMldw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1517681185; bh=Psaj6n
    ZXeNH889GSvsNhsmamhqTwiWx87tFn2oUfB7g=; b=oC/uNvra2Fn2Ociqwwfz+e
    F8lye3RHa28CZQooxxpHsOFKzmCYDFla2ZxnBoaFCLhswK4RsUzsp+gX/duYZ3nt
    71ojSlLY/CIXLVkIINAA86WQu+ApG4t4XGJDjHylftHAsFz8avYn+Ag6PZ1sgLYP
    zxrZd4MWA8x4GUK05YHVijooiZkEqa++cGqBcgxid/yeyyQoVho+PgL71LNJ5shx
    yZxUObdf4YIvxMJDneS5nGpnE+XRhGjf3d60mHlnvA8sfxzythilTB9+BwsVl2qP
    hVUz9EaFsLQp1WCXu8/2INpwVlpAg2pxCZbUV6Hq8BEoOm7/M22ahPupYVT6zhCQ
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=FcCxWLJs x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=FcCxWLJs x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753218AbeBCSGW (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Feb 2018 13:06:22 -0500
Received: from mail-by2nam03on0122.outbound.protection.outlook.com ([104.47.42.122]:54457
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753002AbeBCSFr (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Feb 2018 13:05:47 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Aliaksei Karaliou <akaraliou.dev@gmail.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 35/52] xfs: quota: check result of
 register_shrinker()
Thread-Topic: [PATCH AUTOSEL for 4.9 35/52] xfs: quota: check result of
 register_shrinker()
Thread-Index: AQHTnRlZlbtaMcM82Uuv0YPyMl7+Mg==
Date: Sat, 3 Feb 2018 18:03:53 +0000
Message-ID: <20180203180303.8490-35-alexander.levin@microsoft.com>
References: <20180203180303.8490-1-alexander.levin@microsoft.com>
In-Reply-To: <20180203180303.8490-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB1012;7:/wtYx2aO07Z/0ISbR//68PFJ8rwx4ETIAnvtKhK+hQNZzgFgEi3bOEc897VDeInEe+3sBClu/wUjJa0ZbLqwWPJprJwP6qCf2HPkUuMbEZbFWat352AQmisCg/P3zaGMLmQ7G2L5SUTw7xSZ+mIUzCl/xx+LMKFSY4ZGTuTRbmT4yAhozowXogdh41eap5Cc0B0eV1zwk+HD0kTIWHPI7w80yfXhCjFtSlM9ItnC1u/RCjO9FgTDmUHBgVbZA3lr
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4b619c4b-c786-4e3b-720e-08d56b309b6a
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:BL0PR2101MB1012;
x-ms-traffictypediagnostic: BL0PR2101MB1012:
x-microsoft-antispam-prvs: <BL0PR2101MB101229656296D7484FBC9EE6FBF80@BL0PR2101MB1012.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(61425038)(6040501)(2401047)(8121501046)(5005006)(3231101)(2400082)(944501161)(93006095)(93001095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041288)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:BL0PR2101MB1012;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1012;
x-forefront-prvs: 05724A8921
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(366004)(396003)(346002)(39860400002)(39380400002)(199004)(189003)(316002)(26005)(54906003)(10290500003)(6512007)(6666003)(2900100001)(106356001)(2950100002)(76176011)(86612001)(86362001)(575784001)(39060400002)(81166006)(8936002)(6346003)(81156014)(107886003)(102836004)(4326008)(25786009)(110136005)(97736004)(22452003)(59450400001)(6506007)(53936002)(8676002)(5250100002)(6436002)(1076002)(186003)(2501003)(66066001)(6486002)(6116002)(7736002)(36756003)(2906002)(10090500001)(99286004)(72206003)(305945005)(105586002)(3846002)(3660700001)(15650500001)(478600001)(68736007)(14454004)(5660300001)(3280700002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1012;H:BL0PR2101MB1027.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: pgvTNfzxnR6OHVyKBGRR2AqNFIzvAe8oGkJJPAep2/ycm4I+bLJf8e7feLl3TnpK1JC13hYgJ6pBFr9NMxHMBQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b619c4b-c786-4e3b-720e-08d56b309b6a
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2018 18:03:53.1120
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1012
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Aliaksei Karaliou <akaraliou.dev@gmail.com>

[ Upstream commit 3a3882ff26fbdbaf5f7e13f6a0bccfbf7121041d ]

xfs_qm_init_quotainfo() does not check result of register_shrinker()
which was tagged as __must_check recently, reported by sparse.

Signed-off-by: Aliaksei Karaliou <akaraliou.dev@gmail.com>
[darrick: move xfs_qm_destroy_quotainos nearer xfs_qm_init_quotainos]
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>
Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>

Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 fs/xfs/xfs_qm.c | 45 +++++++++++++++++++++++++++++----------------
 1 file changed, 29 insertions(+), 16 deletions(-)

diff --git a/fs/xfs/xfs_qm.c b/fs/xfs/xfs_qm.c
index d0a86b72d921..e3edaa547216 100644
--- a/fs/xfs/xfs_qm.c
+++ b/fs/xfs/xfs_qm.c
@@ -47,7 +47,7 @@
 STATIC int	xfs_qm_init_quotainos(xfs_mount_t *);
 STATIC int	xfs_qm_init_quotainfo(xfs_mount_t *);
=20
-
+STATIC void	xfs_qm_destroy_quotainos(xfs_quotainfo_t *qi);
 STATIC void	xfs_qm_dqfree_one(struct xfs_dquot *dqp);
 /*
  * We use the batch lookup interface to iterate over the dquots as it
@@ -694,9 +694,17 @@ xfs_qm_init_quotainfo(
 	qinf->qi_shrinker.scan_objects =3D xfs_qm_shrink_scan;
 	qinf->qi_shrinker.seeks =3D DEFAULT_SEEKS;
 	qinf->qi_shrinker.flags =3D SHRINKER_NUMA_AWARE;
-	register_shrinker(&qinf->qi_shrinker);
+
+	error =3D register_shrinker(&qinf->qi_shrinker);
+	if (error)
+		goto out_free_inos;
+
 	return 0;
=20
+out_free_inos:
+	mutex_destroy(&qinf->qi_quotaofflock);
+	mutex_destroy(&qinf->qi_tree_lock);
+	xfs_qm_destroy_quotainos(qinf);
 out_free_lru:
 	list_lru_destroy(&qinf->qi_lru);
 out_free_qinf:
@@ -705,7 +713,6 @@ out_free_qinf:
 	return error;
 }
=20
-
 /*
  * Gets called when unmounting a filesystem or when all quotas get
  * turned off.
@@ -722,19 +729,7 @@ xfs_qm_destroy_quotainfo(
=20
 	unregister_shrinker(&qi->qi_shrinker);
 	list_lru_destroy(&qi->qi_lru);
-
-	if (qi->qi_uquotaip) {
-		IRELE(qi->qi_uquotaip);
-		qi->qi_uquotaip =3D NULL; /* paranoia */
-	}
-	if (qi->qi_gquotaip) {
-		IRELE(qi->qi_gquotaip);
-		qi->qi_gquotaip =3D NULL;
-	}
-	if (qi->qi_pquotaip) {
-		IRELE(qi->qi_pquotaip);
-		qi->qi_pquotaip =3D NULL;
-	}
+	xfs_qm_destroy_quotainos(qi);
 	mutex_destroy(&qi->qi_tree_lock);
 	mutex_destroy(&qi->qi_quotaofflock);
 	kmem_free(qi);
@@ -1621,6 +1616,24 @@ error_rele:
 }
=20
 STATIC void
+xfs_qm_destroy_quotainos(
+	xfs_quotainfo_t	*qi)
+{
+	if (qi->qi_uquotaip) {
+		IRELE(qi->qi_uquotaip);
+		qi->qi_uquotaip =3D NULL; /* paranoia */
+	}
+	if (qi->qi_gquotaip) {
+		IRELE(qi->qi_gquotaip);
+		qi->qi_gquotaip =3D NULL;
+	}
+	if (qi->qi_pquotaip) {
+		IRELE(qi->qi_pquotaip);
+		qi->qi_pquotaip =3D NULL;
+	}
+}
+
+STATIC void
 xfs_qm_dqfree_one(
 	struct xfs_dquot	*dqp)
 {
--=20
2.11.0
