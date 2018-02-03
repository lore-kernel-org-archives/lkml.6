Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1486374-1517681232-2-3283743865422144542
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
    t=1517681231; b=XoPuR6uSPYlLL/gTUe1pgSviH0tYdhr5/NmP+Uok39FX5q1
    AHmulxMb9EApOBjc11jYpiUXRlrUM9pafa1DVJev1OVmFldT6I9fN8LyVKRX/rHO
    scoSMIma9MZNkkmIEqYOPCg37jdW312dUDScrIfIUYIVHb623ILGnQZ0SwLlnw83
    HZJBq2bkqlXxayweU745F1JB5Ushw4vIcF1OfkSaemg8myAN7DE0R9pSq9K+bJQB
    ZGGD6a6pPOSuJ+Uy0ARANeBi1VFnZCHI/WDoEfuaWcYWLFmM2gNYZLUaqRs9LP0d
    pA80sx3+10g90pnsbqekzOpXfM+6nrjvRgMNp1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1517681231; bh=aFiAq5
    lI+HuHvRKJiVpLOAyvj22WDMckpA+0LC9lItk=; b=s/JYGeFSWdcSeGEXSNAWBy
    nskMkNQf3ZErCd4P5FB7/oSJiDS+94CwvAbXS7r1eNihU/Z2TWDM9ZmxMewAIdz3
    i3HXpqwB1a0ZTvVGGAz191GFMg41L1TSA/dh05kHha4aomzTsRtIzTJVzdYbmNJT
    Nwv+a0Yr4udBlG/tq7Lc7RpeaJ4OQCx6buQcL2hIYGvrzayRBJ6MCp/h+O91WK1I
    O8+Q+j49hMif2K8RSW83i4UCq1Gwd/d3pEy5iDHPPcoQQHbI6RPFdHFHpN7KZIRS
    vefxqFqowCwv60rb5jMF3qV3ndZBwXiyYbXUvwjjimCgog6YOm21FSzD2wkGOIQQ
    ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=LXve2pz2 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=LXve2pz2 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753535AbeBCSHH (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Feb 2018 13:07:07 -0500
Received: from mail-bl2nam02on0139.outbound.protection.outlook.com ([104.47.38.139]:53600
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753393AbeBCSFc (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Feb 2018 13:05:32 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Aliaksei Karaliou <akaraliou.dev@gmail.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 34/52] xfs: quota: fix missed destroy of
 qi_tree_lock
Thread-Topic: [PATCH AUTOSEL for 4.9 34/52] xfs: quota: fix missed destroy of
 qi_tree_lock
Thread-Index: AQHTnRlZ+dYMAiiaNUOnceu5IQQMAw==
Date: Sat, 3 Feb 2018 18:03:52 +0000
Message-ID: <20180203180303.8490-34-alexander.levin@microsoft.com>
References: <20180203180303.8490-1-alexander.levin@microsoft.com>
In-Reply-To: <20180203180303.8490-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB1012;7:ha1Jvcc1b7esUBeiVDaVdbWRcftqFhxUWNyWfDMWvrXq2TTBFpztrOnF0TSHBnitfuoJWnHZPHBLY4JwgWGwxVD9gQ173Yf5cZPABXmFGGJh8RyehqndpNvXcVW1w4Dy4kKgKx2vO3bhNVRgeJi4UYZerCqOuOvsTuVNnebqtzTOH63whnNVr+aUSlTsvRCl4vNiCoqYBXI8jCEoBs9IMsuMRUFKFwcUFvbwGOeHwVCLNVyWB96L7L1DHEnnT7cA
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 26286f90-7252-461e-3b0c-08d56b309b12
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:BL0PR2101MB1012;
x-ms-traffictypediagnostic: BL0PR2101MB1012:
x-microsoft-antispam-prvs: <BL0PR2101MB1012CDF0489763FE05C3F3B6FBF80@BL0PR2101MB1012.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(61425038)(6040501)(2401047)(8121501046)(5005006)(3231101)(2400082)(944501161)(93006095)(93001095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041288)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:BL0PR2101MB1012;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1012;
x-forefront-prvs: 05724A8921
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(366004)(396003)(346002)(39860400002)(39380400002)(199004)(189003)(316002)(26005)(54906003)(10290500003)(6512007)(6666003)(2900100001)(106356001)(2950100002)(76176011)(86612001)(86362001)(575784001)(39060400002)(81166006)(8936002)(6346003)(81156014)(107886003)(102836004)(4326008)(25786009)(110136005)(97736004)(22452003)(59450400001)(6506007)(53936002)(8676002)(5250100002)(6436002)(1076002)(186003)(2501003)(66066001)(6486002)(6116002)(7736002)(36756003)(2906002)(10090500001)(99286004)(72206003)(305945005)(105586002)(3846002)(3660700001)(15650500001)(478600001)(68736007)(14454004)(5660300001)(3280700002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1012;H:BL0PR2101MB1027.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: +iFhi1VNiTu+0SVx42T3hGE/rI28d7dP4ee8BHnJaf8xDQMMXphHIqH8DdGp7xg7JUkH9ZX2r6cIoxNAHCMukQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26286f90-7252-461e-3b0c-08d56b309b12
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2018 18:03:52.6276
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

[ Upstream commit 2196881566225f3c3428d1a5f847a992944daa5b ]

xfs_qm_destroy_quotainfo() does not destroy quotainfo->qi_tree_lock
while destroys quotainfo->qi_quotaofflock.

Signed-off-by: Aliaksei Karaliou <akaraliou.dev@gmail.com>
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>
Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 fs/xfs/xfs_qm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/xfs/xfs_qm.c b/fs/xfs/xfs_qm.c
index 1fdd3face2d9..d0a86b72d921 100644
--- a/fs/xfs/xfs_qm.c
+++ b/fs/xfs/xfs_qm.c
@@ -735,6 +735,7 @@ xfs_qm_destroy_quotainfo(
 		IRELE(qi->qi_pquotaip);
 		qi->qi_pquotaip =3D NULL;
 	}
+	mutex_destroy(&qi->qi_tree_lock);
 	mutex_destroy(&qi->qi_quotaofflock);
 	kmem_free(qi);
 	mp->m_quotainfo =3D NULL;
--=20
2.11.0
