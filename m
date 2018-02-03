Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1576794-1517682418-2-8197292413405668866
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
    t=1517682417; b=Ow/opaLs5BfsDsxLYGLOrmYVhxPQXHqIUXXolq0R6dxLh+v
    p8yoQw7XgKIn3rKdxFljQMdMqMJyqVcN3n1lQyGa2VEj/N2/6DfAjjLY2ndHA0ys
    XxbAhMLGzyaJ0RXg7UoeZiD9ZgXn9QBBDYCt3/g3yshryntnpEQJvuN4Y/g5BtAn
    xgy9ucg/39wE8hgKldy6Leaj/lxDUQCVf618g/xNhEhkeWRwn90luz1xrma3bCys
    Ol+ygR5CLRKmEkRfCVF72z/oWcCUELDTVDXHdaQISZ4eZDwojX5UAcrFmUZNrc4X
    iMTO/36fbok8ZOO+/L84LQg/pNC8FSLKY5lGOGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1517682417; bh=fAdUPl
    nOriB/9UHbrhXuqPcBRO02380VeMf3XcjPYu0=; b=Gjzr+qY3lpZY5viozLZoy2
    gkLYtkTAlhIgw9ggWLOvvAXAI/7QsKiYYJ7LEM/lTvYj1Sls8W4cnk6GExNWFxWp
    KqGygqMFYLghqC5B/jg7tmtV18cVeqbzIvZ/h11wCQrysPK40Use169vr5Oc7Y5k
    FnBbQBA73ZEEu698beFDW7bZdM871PNZQIiw0dZjwmp3m614e6bPEp4FIbpHPiNC
    6sc0sh/SrwKt4ocWhCdUzYD+vjOTByvn/NE/pmtHjvL6NAgfw4RpL5/BcZDII9fU
    Y1z4qhI797RRUd0wne4mz09rH/F+O2uxY4tg2tvZEN+sSWmG431FAj/TMlKU9mpA
    ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=FmFFKhV4 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=FmFFKhV4 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753995AbeBCSYG (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Feb 2018 13:24:06 -0500
Received: from mail-co1nam03on0107.outbound.protection.outlook.com ([104.47.40.107]:45036
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753433AbeBCSGM (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Feb 2018 13:06:12 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Aliaksei Karaliou <akaraliou.dev@gmail.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 19/32] xfs: quota: fix missed destroy of
 qi_tree_lock
Thread-Topic: [PATCH AUTOSEL for 4.4 19/32] xfs: quota: fix missed destroy of
 qi_tree_lock
Thread-Index: AQHTnRlyqNFijidI8EuglD1Kr0tD4w==
Date: Sat, 3 Feb 2018 18:04:34 +0000
Message-ID: <20180203180413.7438-19-alexander.levin@microsoft.com>
References: <20180203180413.7438-1-alexander.levin@microsoft.com>
In-Reply-To: <20180203180413.7438-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB1009;7:54Ukp08Zmwvv1oRpMa/7I+Z7nZw8VxVvhkAeHyzrtKp2HvnTSLp0U9P6ukyNSP6GDpQVnel2U2oTpB0PEh+X1gXosKGFljTLUPXI4cXSlQCE+dczuch4BhXAEE9B9Kbu2lwV+O9mhQ5aIT3ZMDrNR9xdTmgq42jp/pWgNfuPJQPYFsNfOGcLPBaL8SwCSV8Yioxq3hivgcv6krI7+Kp0zwbdHEQA1ZQol/Qg2+nTj8Dj2e5dYXBuYJ0wYS41jUGt
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 45491608-12d8-4a9f-232d-08d56b30c3a6
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:BL0PR2101MB1009;
x-ms-traffictypediagnostic: BL0PR2101MB1009:
x-microsoft-antispam-prvs: <BL0PR2101MB10099B6B4A861EAC22CED154FBF80@BL0PR2101MB1009.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(61425038)(6040501)(2401047)(5005006)(8121501046)(10201501046)(3231101)(2400082)(944501161)(93006095)(93001095)(3002001)(6055026)(61426038)(61427038)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(6072148)(201708071742011);SRVR:BL0PR2101MB1009;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1009;
x-forefront-prvs: 05724A8921
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(366004)(39860400002)(346002)(396003)(376002)(189003)(199004)(6346003)(39060400002)(1076002)(26005)(107886003)(186003)(25786009)(6116002)(3846002)(3660700001)(105586002)(2501003)(10290500003)(99286004)(2906002)(3280700002)(5250100002)(4326008)(66066001)(36756003)(81166006)(81156014)(97736004)(8676002)(8936002)(54906003)(110136005)(72206003)(6666003)(86612001)(22452003)(53936002)(478600001)(59450400001)(68736007)(5660300001)(76176011)(6486002)(316002)(6506007)(102836004)(15650500001)(6436002)(2900100001)(14454004)(305945005)(106356001)(10090500001)(86362001)(6512007)(2950100002)(7736002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1009;H:BL0PR2101MB1027.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: Xuh70oacdlPOAXJwMgSUcA2lg7A2SXMxr7upJ/0Cmcmc5FGyMGTXICoCx9uXYAEgsgZ+lFkpVVvhEdPR8ik+KQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45491608-12d8-4a9f-232d-08d56b30c3a6
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2018 18:04:34.3933
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
index 572b64a135b3..352b9c66a255 100644
--- a/fs/xfs/xfs_qm.c
+++ b/fs/xfs/xfs_qm.c
@@ -701,6 +701,7 @@ xfs_qm_destroy_quotainfo(
 		IRELE(qi->qi_pquotaip);
 		qi->qi_pquotaip =3D NULL;
 	}
+	mutex_destroy(&qi->qi_tree_lock);
 	mutex_destroy(&qi->qi_quotaofflock);
 	kmem_free(qi);
 	mp->m_quotainfo =3D NULL;
--=20
2.11.0
