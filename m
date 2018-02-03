Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1483324-1517681271-2-17107167312470502271
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
    t=1517681270; b=to4sq0M/RgofNpo1SG9/NawVesH9QLLX35Ji3rNJs7bSD5P
    80sPkmqkSt+LGKC9+SL20RcN5IFO2jltP1NBqrKBuhj9ucOr+kBQ0sLfH37a9kdh
    jbS6qgKbat/6yMX+5t2er5K6Kw8gu+18HzMYLJ+b6Vx6Xfqg9+LPJDZ2h+53c9za
    X6Mc3NBzxjI7oO5oH1SHQfTB0jsHgNL7bBzRlWlqAQHuILgZRF/o2K56s0g9QEUF
    qxnFhXPyvHccRBtZOfwizd0+B7dSeUi+WvDQlSe6pddYhBD8Qls8FFxc42jXJ2oL
    zXvXY3cg6YWyPjFvovDXbhzq1LxPa6TvjL+9GYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1517681270; bh=rntbmJ
    qNxmsvI7mI8XkaEQi00XKRiv6j2jt2yCIBaiM=; b=a7aOqeEBZwrU1nAZIj48QQ
    c5ams2z1uE6gYBnq2C2EG9SXNm2Q7P0Yu4hiOfkTaCRCbOb9ieZJ/xH8kcz2uKWO
    rUxYtFbAdFPqThLuezHNquGtAd9K4GCSRK8aMvfwFXOn9mjneZ8EsCUX7FEIjulv
    3EG37qrtyn/mKF3zBH5CBFsKniL+2psgTOVrsLrEeENkZPAQJRL3NL9OL5aGEKos
    j9onyPLGAmMPuwWGvlWoeui7NbTCFyymcR4qnWvZcO3/AQqOL2Bf5Z4CXYhaOJWl
    gK0PX4ZTM3GLhkB9zUh6R+EJ5k5wJb+ERFTHHzQLL1nmPOTkH1yjxdZtThFKgebg
    ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=VWuEu+De x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=VWuEu+De x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753558AbeBCSHr (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Feb 2018 13:07:47 -0500
Received: from mail-by2nam03on0097.outbound.protection.outlook.com ([104.47.42.97]:1354
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753038AbeBCSFI (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Feb 2018 13:05:08 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Aliaksei Karaliou <akaraliou.dev@gmail.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 076/110] xfs: quota: check result of
 register_shrinker()
Thread-Topic: [PATCH AUTOSEL for 4.14 076/110] xfs: quota: check result of
 register_shrinker()
Thread-Index: AQHTnRj9ag6cWl7mEUiP6YoPKrAvKQ==
Date: Sat, 3 Feb 2018 18:01:18 +0000
Message-ID: <20180203180015.29073-76-alexander.levin@microsoft.com>
References: <20180203180015.29073-1-alexander.levin@microsoft.com>
In-Reply-To: <20180203180015.29073-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB1105;7:YU2r0DzcF3Rf9fn8yinGP5xaGTUBcOsgNh06v1Hx8wHub9FJjOB3MsmIYu9psETGbO6uZkih/MlT9ZjImF4IaiP8s8SvGNVLICxZGXBBJDK9308DRLa2TtTAlYcTEiN95XWI6eeoWCxG716DtfjubIzS5KB9IjrnOn3e4AY1k9hSxXXeXVGHfYEuZoyR2x4yygy3fsIhs64Rvl7pBJK726LOFEp5O26WHhGqe43eCphuVoqVVkmBan4pdMvaSUpc
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f67b4ba8-37f4-4d52-3f6a-08d56b303ec2
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:BL0PR2101MB1105;
x-ms-traffictypediagnostic: BL0PR2101MB1105:
x-microsoft-antispam-prvs: <BL0PR2101MB110577360A17A31054FA0C42FBF80@BL0PR2101MB1105.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231101)(2400082)(944501161)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:BL0PR2101MB1105;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1105;
x-forefront-prvs: 05724A8921
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(39380400002)(39860400002)(346002)(376002)(199004)(189003)(6346003)(97736004)(6512007)(7736002)(26005)(305945005)(102836004)(105586002)(68736007)(5250100002)(8936002)(59450400001)(6486002)(6436002)(106356001)(6506007)(81166006)(81156014)(2501003)(2906002)(10090500001)(99286004)(66066001)(54906003)(6116002)(3846002)(36756003)(1076002)(8676002)(110136005)(575784001)(39060400002)(107886003)(72206003)(2950100002)(478600001)(10290500003)(22452003)(6666003)(5660300001)(2900100001)(4326008)(25786009)(14454004)(316002)(86362001)(53936002)(3280700002)(15650500001)(186003)(3660700001)(76176011)(86612001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1105;H:BL0PR2101MB1027.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: JZtJ9a+M969AoUNIknSYUbMxfoX+ECFfyxEgQNkXKes6+CYPQz2eKyFWCuC6D1V5b77Lto0iRnci+YgOZSHgcQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f67b4ba8-37f4-4d52-3f6a-08d56b303ec2
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2018 18:01:18.3784
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1105
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
index 2ec4269971df..659ed6f8c484 100644
--- a/fs/xfs/xfs_qm.c
+++ b/fs/xfs/xfs_qm.c
@@ -48,7 +48,7 @@
 STATIC int	xfs_qm_init_quotainos(xfs_mount_t *);
 STATIC int	xfs_qm_init_quotainfo(xfs_mount_t *);
=20
-
+STATIC void	xfs_qm_destroy_quotainos(xfs_quotainfo_t *qi);
 STATIC void	xfs_qm_dqfree_one(struct xfs_dquot *dqp);
 /*
  * We use the batch lookup interface to iterate over the dquots as it
@@ -695,9 +695,17 @@ xfs_qm_init_quotainfo(
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
@@ -706,7 +714,6 @@ out_free_qinf:
 	return error;
 }
=20
-
 /*
  * Gets called when unmounting a filesystem or when all quotas get
  * turned off.
@@ -723,19 +730,7 @@ xfs_qm_destroy_quotainfo(
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
@@ -1601,6 +1596,24 @@ error_rele:
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
