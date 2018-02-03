Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1483324-1517681775-2-18117560950618293263
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
    t=1517681774; b=IexLxD2nYzvOsw5OfovKtSDycEMGWlSepQ+StMdTYT9V6P6
    QGLN8fQRD+8e4vmJPFN9ha7DvHcZF3DGGRFsp2agOL3UUWPKM2Xbw9QGEpAFNV7d
    oiPTZhLh4/f7AG9XiE8mKtVJOyA0cs0kPGLnhvSXN20zl9g+Mu1WeDnC30E/H9WV
    8tCYYOsWtbXKei1e5r45OoPS/lp9Oi3vePDb05y605t/0gzke7kE+Yow2l2fzUgv
    r0/lvL+b2FxQGxZGuwRO7AntX8U+k5CutUo8B9/N6ENJ5qAD61h6rAdUvy2okJGD
    g/QMS3R1dly0zCiBXLo1wFag/nKon/3MbRa+vJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1517681774; bh=qw8ZYD
    jXeGM7xL46OunwD/k88HKACY+WFCEQfdUP+u4=; b=LLQx0fC9dbr5zfkrFvAx/k
    QWwTyXyMJJcVnE8u/mwM8bEg9Ctu+GlsooTOGOb9PmggiHjNNJYmLIlumlEsnWg3
    wsp9RoD9aootHDmaSgSF/JhG58VMYB7iqIDNi6LjKeFhucEjsUUYyo340LshAMEl
    kLBOCp2NQW7DWAaSyRz+PaeA7Ip1qIVVidaiHgwxXjefVrsPjUpXld5OWmu3QEBL
    LL5WVyZwYRifgThhG/d/94owyVPd4AR+bU+2J244ir4ChSXCsKvxh0XLMtW9leze
    xNEkCvFwWdBbyK4gLfYW92stEh3VIBRX0Zxm4Eo5uq8sHg8k6VjIrhMlJttsi4Rw
    ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=bjHVdH5o x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=bjHVdH5o x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753798AbeBCSOg (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Feb 2018 13:14:36 -0500
Received: from mail-bl2nam02on0095.outbound.protection.outlook.com ([104.47.38.95]:12511
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753560AbeBCSHT (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Feb 2018 13:07:19 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Aliaksei Karaliou <akaraliou.dev@gmail.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 13/24] xfs: quota: fix missed destroy of
 qi_tree_lock
Thread-Topic: [PATCH AUTOSEL for 3.18 13/24] xfs: quota: fix missed destroy of
 qi_tree_lock
Thread-Index: AQHTnRmE86tQkqsueU+nnm3djhOA6A==
Date: Sat, 3 Feb 2018 18:05:05 +0000
Message-ID: <20180203180444.10801-13-alexander.levin@microsoft.com>
References: <20180203180444.10801-1-alexander.levin@microsoft.com>
In-Reply-To: <20180203180444.10801-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB0993;7:pQ63UGt4yPQhTxzqydf1K7dIBq3GECM9Nun5t2STuuCEbpRnBV8TdIQ5ZNhUEV4UEXTaDreQ08k4eyZdKfnwqNYeCIZP7MNrEIbNm7jgLZmzAnnW/GDcCaKqgTZHLGQed3lsX5qSc/NQ/yHAVA/QGVk4/1cInpH7dd9qOKAGT+stvJtUhsTD/GKJdBoo+GfrSnc+OUqVf40ASVLDMjcoXQMN3Tk8+xjz2PxWal7nM0GX/RpEJ2RQaXpEoMk/r7xj
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 499da0d7-79c9-47ee-45c2-08d56b30e08c
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:BL0PR2101MB0993;
x-ms-traffictypediagnostic: BL0PR2101MB0993:
x-microsoft-antispam-prvs: <BL0PR2101MB099392F81A6D3AB83BC4886DFBF80@BL0PR2101MB0993.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231101)(2400082)(944501161)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123558120)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011);SRVR:BL0PR2101MB0993;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB0993;
x-forefront-prvs: 05724A8921
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39380400002)(39860400002)(376002)(366004)(396003)(189003)(199004)(6436002)(186003)(3660700001)(8936002)(105586002)(2906002)(6346003)(6116002)(3280700002)(3846002)(97736004)(6486002)(1076002)(2950100002)(6666003)(81156014)(86362001)(76176011)(102836004)(2501003)(5250100002)(26005)(68736007)(10090500001)(81166006)(8676002)(15650500001)(59450400001)(53936002)(5660300001)(22452003)(305945005)(107886003)(7736002)(4326008)(86612001)(36756003)(99286004)(316002)(6512007)(10290500003)(72206003)(6506007)(14454004)(478600001)(25786009)(106356001)(2900100001)(39060400002)(54906003)(110136005)(66066001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB0993;H:BL0PR2101MB1027.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: 5ggvHr5H2CVd39VTjrlP/zlxMTvY0Az4WKzzXhfNhEAIKsAVWMhj1Cbn8GHsVEw2VquyHZcUseYexd1nrPUXcg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 499da0d7-79c9-47ee-45c2-08d56b30e08c
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2018 18:05:05.1121
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB0993
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
index 2eb71027d236..30eea71405ce 100644
--- a/fs/xfs/xfs_qm.c
+++ b/fs/xfs/xfs_qm.c
@@ -703,6 +703,7 @@ xfs_qm_destroy_quotainfo(
 		IRELE(qi->qi_pquotaip);
 		qi->qi_pquotaip =3D NULL;
 	}
+	mutex_destroy(&qi->qi_tree_lock);
 	mutex_destroy(&qi->qi_quotaofflock);
 	kmem_free(qi);
 	mp->m_quotainfo =3D NULL;
--=20
2.11.0
