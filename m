Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1576849-1517682529-2-13306026061422795935
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
    t=1517682529; b=q5RxrH/ieDY8IYOkixytsEFoSRRp3aq0i/cV3KmMtlu1gFY
    5ykFmi7FcfwT21XG1o694rwcPMotSkUecfGC1VL3OLO8wvIW3A1ZCqzAHfZSm4s9
    +6ThhfsCdVnSsJa/M5vi8GlJ+IIaie0AaYl8XSUk86ZIpAVKAk+Jb/UfsPyBn7gj
    AZWYWuOnCb8mFeujOHzlIlKcHtc+Q2MNSWmKaOoLVuKMj+iAIRgX9BvOxU7w7NHD
    jGIc9HhsXpqommJ/KdrnGiguVptKaiKCPjv8i0bPG/tViXUyRMRxNrywnP8GaBJR
    3sA6jERw4bIeAzLAXFcvazbI5UqYEm9b2v3zlog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1517682529; bh=qvuCMN
    mlAEn5rY6Cv5BBsof0rbgOP85OS5U7KmQ9hqo=; b=ZOu+aXVqIuS6V7c6tewjBG
    Z63BT4Tg5pdiChW59x8dbfqwIaDgKONxA0B+E9Fb8rmzuX8p2jyMUBSzz5eS/K4+
    uMKMkiGmapvxWROwsXv9VlLx23kpDaiYaYMRGKew+zLQ5bkM9jf36hty8Pa6P3R3
    2GWFb29xnKt3mqmSoSm05Tq3EOdcy4GDon81UA2UCSCX2D3ICkt3CGbpL4ts1mY6
    Y+ZuwWAQtEFLV32xjZSeit4vw0JoSBuLis+n7MfA2gJgarAvbtNSR6M9AOSWJiXl
    70mzHtakh0kI1/zrL2lNdpv+N0Iv1VEc+0JWP4uUIIjp5KuO6I1uYFY+U42enTdA
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=hzK6wwi8 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=hzK6wwi8 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752542AbeBCS2p (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Feb 2018 13:28:45 -0500
Received: from mail-by2nam03on0136.outbound.protection.outlook.com ([104.47.42.136]:45129
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753041AbeBCSEr (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Feb 2018 13:04:47 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Aliaksei Karaliou <akaraliou.dev@gmail.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 075/110] xfs: quota: fix missed destroy of
 qi_tree_lock
Thread-Topic: [PATCH AUTOSEL for 4.14 075/110] xfs: quota: fix missed destroy
 of qi_tree_lock
Thread-Index: AQHTnRj9zOW/ncaLNUyvZ3knoNpkHw==
Date: Sat, 3 Feb 2018 18:01:17 +0000
Message-ID: <20180203180015.29073-75-alexander.levin@microsoft.com>
References: <20180203180015.29073-1-alexander.levin@microsoft.com>
In-Reply-To: <20180203180015.29073-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB1105;6:52O/cGL2+m+BEDgnLDpS4EKWbSDx2PyQAcU1vs3rWe00eXZPfgVVP2W0DXV141YWYVr8QgG4exBo68jnXHrNwMRyi5WyOwAHT9D8NjT6TJkDdIITysRy4gvdbKUPfGrgerWOlO+zG1lMt31hiQb1PxOSUL3v/rhilaVtBeNULmz6oLHpba+uQjUAavsmVJqciuxVuwAsbJS2ET8Z2nhh9PA52yNx47fLkcX+KPkwmDO3EPCCWgtWsvDRJ928Jj+68r+fCjGWHx544TGt7/uXYqQR5H9y2VmORuYkWhu6xXrYtW4y7Ad5eK7N8cEaxDfxRh/x4WAay182ngAnK2Gt8bL1IPkQfB0W5XycsH3cHxgbTO3SV8fB7x1iMTtWzxnJ;5:lcci7RiTlgGp+bUb2ARuDEdRzYegQGJxKeRDysOF0lUNZpxz1FMqG4LRDUwldyRAcVJq+pcvr4KxI2J05z3F1avqxcDHZcvst3jUAFELHSPoYLJ2eD4OOLfzUHzSapUPehIsN0+kfmySXpdFSxlzTodEwOIAAp8d3zGwM/5iy5w=;24:kAbDs5zqXWVYmcK2M2DiI+3OnhvPkqoN2V9yK3okXXeKCsQo+kPjOUnCcHvk1TcqCUWMECEf0Wb8W3db/wIA5e6i0+pizHQcO4ZxveNrl8c=;7:Ai9IrNW/7CfZHi4+/hdMhu5EzzlSDdgmr9de8EuAOrjwOYALoORuG5L2dADCpD3fSpJbw/gzsfgnK5iPFnXgDi5rBrt0Vj87+1mibhrYMUWNJfhyTFSfvQ5EPl5h2Gr1KjoQK6R3hJjBlP8G2UvRrip9dwGsTLbVRwG2ZXt2c7QsfnQRkP+eB3A6IC4BKCo5a2HE6bKppAivD3F48oM2UzxIyogTEyCCnomOm0F/lFe2VrSnD1jQgsShec9Bw6p3
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 998a1c74-0eb9-48b8-b8f4-08d56b303e7a
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:BL0PR2101MB1105;
x-ms-traffictypediagnostic: BL0PR2101MB1105:
x-microsoft-antispam-prvs: <BL0PR2101MB1105708DCDF76904EA3D69E8FBF80@BL0PR2101MB1105.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231101)(2400082)(944501161)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:BL0PR2101MB1105;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1105;
x-forefront-prvs: 05724A8921
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(39380400002)(39860400002)(346002)(376002)(199004)(189003)(6346003)(97736004)(6512007)(7736002)(26005)(305945005)(102836004)(105586002)(68736007)(5250100002)(8936002)(59450400001)(6486002)(6436002)(106356001)(6506007)(81166006)(81156014)(2501003)(2906002)(10090500001)(99286004)(66066001)(54906003)(6116002)(3846002)(36756003)(1076002)(8676002)(110136005)(39060400002)(107886003)(72206003)(2950100002)(478600001)(10290500003)(22452003)(6666003)(5660300001)(2900100001)(4326008)(25786009)(14454004)(316002)(86362001)(53936002)(3280700002)(15650500001)(186003)(3660700001)(76176011)(86612001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1105;H:BL0PR2101MB1027.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: yDMfi9SwCMCn2BZVNjY6HvSdCbzJ0YRdiAB0l8oYOYdlvqcnoyi+ByqvY2hWPSG9PXwzJuITMAYkqKqoZgxpsw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 998a1c74-0eb9-48b8-b8f4-08d56b303e7a
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2018 18:01:17.8003
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
index 010a13a201aa..2ec4269971df 100644
--- a/fs/xfs/xfs_qm.c
+++ b/fs/xfs/xfs_qm.c
@@ -736,6 +736,7 @@ xfs_qm_destroy_quotainfo(
 		IRELE(qi->qi_pquotaip);
 		qi->qi_pquotaip =3D NULL;
 	}
+	mutex_destroy(&qi->qi_tree_lock);
 	mutex_destroy(&qi->qi_quotaofflock);
 	kmem_free(qi);
 	mp->m_quotainfo =3D NULL;
--=20
2.11.0
