Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1576849-1517682432-2-12897869290578986553
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
    t=1517682432; b=hs16LpQIxdDNJos733OyfepdwpMJPS45Tpjnw3TeDkZc5Pf
    JJ5Zd16plkHVOBfmhP0s7Hb6Md4liCShgV1dj/457kUHvfplloY1FpAMWzKaKXZI
    UsuIJrwyKMKIe9/FVqqQ7gVJCXwCaL6W0nfRmSQ7GtuelLcsWIfUxSCLN7FqEJ5Z
    W/HlIpnMLfmjvCdCrTXy4wYmkMcD3THlGPKDHxIdsXpsUC4tIGnsSgRoksTA2VRf
    ZvNyU4RecJUQWcd3Ae+PkRd0INh9PrvnYMy5gB3mNSwSV/9NPNQRROaUzxTVKoVW
    drfvjKwNjGf8JpmCaFCTEd4t+tMcaOClBfPEekg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1517682432; bh=hiUKGm
    VcwljlvyPOz8Qb+dGu4POTkzIrY5iBBThO4W0=; b=ATzX0LWnAB2vqRP3ZSb99O
    oEe6gmNzif8aqo1g2NIWvz09QoBJMz3jbB0VBx8XpKj+wCqdaRvZixX1aqhCqbSa
    sGktFYoCghW37N1C7D7eQ+nnyuQc4ZNozRjQjQ3jsB9dTKm8HdVVQV1yrenrYFZ5
    +MXojKFMwSaVdHIALm9S7F5tYX25jni1ykWnG8VGJ8LV+BH0+GyZhnoZhqGALT/z
    h6huEaKJpIHt91O18eZQQMvUuLmfaqWyXz5s9UtUJnko/Vy40n+ILC/wX9w2iai9
    1uMuRbnX/LTijABM4YCc82WQIOYGwSI4d+f6cSPUL5BZPS+zMIpMuh+40hv9Wz+Q
    ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Y3Cb0zmX x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Y3Cb0zmX x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754310AbeBCSXZ (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Feb 2018 13:23:25 -0500
Received: from mail-sn1nam02on0093.outbound.protection.outlook.com ([104.47.36.93]:35549
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753290AbeBCSG2 (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Feb 2018 13:06:28 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Aliaksei Karaliou <akaraliou.dev@gmail.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 20/32] xfs: quota: check result of
 register_shrinker()
Thread-Topic: [PATCH AUTOSEL for 4.4 20/32] xfs: quota: check result of
 register_shrinker()
Thread-Index: AQHTnRlyr/W3bakI9k2el12IQyQa9A==
Date: Sat, 3 Feb 2018 18:04:34 +0000
Message-ID: <20180203180413.7438-20-alexander.levin@microsoft.com>
References: <20180203180413.7438-1-alexander.levin@microsoft.com>
In-Reply-To: <20180203180413.7438-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB1009;7:dUQjWWzOEpc6aH1JM8n7lvo7clHQfQFd6M5g5wcwahUhOyKRkCEfkaGquinv6e5gEY7Pks4iFUPAJGwXe2n57KJJrJhPjrjN8LXTR6x0XAK3ZwDmGUCLYEXUp/jz8NHPqUsbVPFM2iAwXGptr/JDuCnPm7HSdxex+UdTll7KblmGOF6U1DOiKAQJv0FrJ0Dg2FUzued3M6gt1vFMRyS351Ac8lQxtho55M+xmzBX3Vxe915wgbpOGJM9vtejt3RP
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4408330a-5b49-4849-a856-08d56b30c40c
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:BL0PR2101MB1009;
x-ms-traffictypediagnostic: BL0PR2101MB1009:
x-microsoft-antispam-prvs: <BL0PR2101MB1009211B602EF42E37C9847DFBF80@BL0PR2101MB1009.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(61425038)(6040501)(2401047)(5005006)(8121501046)(10201501046)(3231101)(2400082)(944501161)(93006095)(93001095)(3002001)(6055026)(61426038)(61427038)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(6072148)(201708071742011);SRVR:BL0PR2101MB1009;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1009;
x-forefront-prvs: 05724A8921
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(366004)(39860400002)(346002)(396003)(376002)(189003)(199004)(6346003)(39060400002)(1076002)(26005)(107886003)(186003)(25786009)(6116002)(3846002)(3660700001)(105586002)(2501003)(10290500003)(99286004)(2906002)(3280700002)(5250100002)(4326008)(66066001)(36756003)(81166006)(81156014)(97736004)(8676002)(8936002)(54906003)(110136005)(72206003)(6666003)(86612001)(22452003)(53936002)(478600001)(59450400001)(68736007)(5660300001)(76176011)(6486002)(316002)(6506007)(102836004)(15650500001)(6436002)(2900100001)(14454004)(305945005)(575784001)(106356001)(10090500001)(86362001)(6512007)(2950100002)(7736002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1009;H:BL0PR2101MB1027.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: uiELkw/pGSXZzXuj1B0BEPvZ2wOzT3kR/rr3RfwD13FUs9DQ8U+cosKtR/3plwLF2F6UBLPqZWme2xLhGBMPgw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4408330a-5b49-4849-a856-08d56b30c40c
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2018 18:04:34.9246
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1009
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
index 352b9c66a255..b148aa0e10f7 100644
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
@@ -660,9 +660,17 @@ xfs_qm_init_quotainfo(
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
@@ -671,7 +679,6 @@ out_free_qinf:
 	return error;
 }
=20
-
 /*
  * Gets called when unmounting a filesystem or when all quotas get
  * turned off.
@@ -688,19 +695,7 @@ xfs_qm_destroy_quotainfo(
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
@@ -1563,6 +1558,24 @@ error_rele:
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
