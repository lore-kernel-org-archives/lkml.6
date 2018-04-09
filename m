Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3643807-1523234730-2-15680339290795578835
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523234729; b=Sw5GWTgPakltLD0jwyvqBGG9yYr0sGtuBTjzsLBkHxJu2vKY0g
    8EGVsCG6yqOlPWB5XgscwItgd90D27Rxbpe+lTIw4QlOZ0mFPL8OMD/vGxDxvt87
    cfX1x7xu0GmncrEZCX9NfW4Uz5L7n3yjPAc2ZiG8PrCeOwK68Jt+D7Y1Yt0FQJCH
    x0nR3CgiU1FE6GWcAYqcrLzIJ4Ze4EwnjvsZQnusVUxll8KtyEC43O4AzisBseI2
    jBvsq7Md7TNpjBe4CXT+xEmAW84E8tQrZEadJBUkJKnGo5XIAPwwyKM2FuAAdE4p
    oQIJc2YGyHhK75KdX6EKuFdbsWAl+i4dkKWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523234729; bh=7bJs6TJAKF
    vPqRD+h5Ol181GFpgAd1tQpBdQNkHeJFA=; b=e6lY4qJToTNXdAjvEXMqpyRIv9
    v3k6cu9zGWQxKQ7blj8S6hut5XSSF06gf5nEN7NHgGZrchQwdOO+4VX4DUEbG47p
    MPVDqb8F1rhng8SoR7twoxGdRxe8elMTLxcafdGzo75T1yExeuvz2PFQe9tRvZs7
    tWfohFbNoS2BVyljkURK/UKjv91M8hQ1CJx3y8EvNGoenkJrIM93PErdpDG3SwiI
    z6VuYrf+ScjEyPH29enIgo3uYzXxLFDZzEEyps9zc/5tUJEYr02nszcQYsenWHZy
    qUdosWl660IbJ0hWZABlT7+GEXFXrp9eYYOiemueKwuPFEYxVcVLqS91JrbA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Kl4E4hEW x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Kl4E4hEW x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfDea8rbAHk+sPGjS7o1PBwx1qPys2QwQkC2he4kpN0aiqrPTHI3f5SnnLmQOye/81rGydMuJkiI5SNOBFcb6+yQKuadKujFJv9rDfhe4p5bpbx13gUNO
    2rYTn1LKmaGv1te5xlskOAltl5dGwVoMDHLNYMj5wZUxZNVyDbPkikXl05uD8u5c4fMLdHMmNFyr94FMasd+bUma4TcVMhUW4+9SqYe5QBpSKcYIcf8uopr3
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=20KFwNOVAAAA:8 a=omOdbC7AAAAA:8 a=yMhMjlubAAAA:8
    a=gsqZSsGcU53TmyZKCsoA:9 a=wPNLvfGTeEIA:10 a=baC4JDFNLZpnPwus_NF9:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756315AbeDIApA (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:45:00 -0400
Received: from mail-sn1nam02on0133.outbound.protection.outlook.com ([104.47.36.133]:59745
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1756779AbeDIAma (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:42:30 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: "J. Bruce Fields" <bfields@redhat.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 100/101] nfsd: return RESOURCE not
 GARBAGE_ARGS on too many ops
Thread-Topic: [PATCH AUTOSEL for 3.18 100/101] nfsd: return RESOURCE not
 GARBAGE_ARGS on too many ops
Thread-Index: AQHTz5uPXfRuc6PXQEOrxwL8aGZj3w==
Date: Mon, 9 Apr 2018 00:41:55 +0000
Message-ID: <20180409004042.164920-50-alexander.levin@microsoft.com>
References: <20180409004042.164920-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409004042.164920-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1029;7:MSFFnYhfMrDcJJ/oLR4YvmFcNWA7NddT4gcsdL/+L9rxkE6KqpNw6QevT9Ek6yEq8oFRwZzZcthXJjgyx0W5mxkaLq+1RBMdk5/e17m6NXg+0rp3/XbwAmM9CYpKWgIrFQILfg7aw1fClEQ39xV05IV8OU3dkFZgaZ9Fomvhl47wxkwvDA2IkGRjVbA9oBHQwAd4eTTUEEG/xt+CQVzTfu85T//+Gfku+vpz5iqLSIzpkeqMX5cvZDnyD3Ys9XAh;20:G4S9R5r9+mLs9T37m0eAeiLAc87K5OmvCs6PYSPvloDUilzPQiKKmDQbG9bf7pGDfgmjh+1PgHHZiRehwRnDS+guxAkCVegjgyiVqu0OTlMmG5T4tsn5+/zmS//TzpMosMf4oJDxIXINofeHr1H0zsur98wnNzKUBmex4O+5bw8=
X-MS-Office365-Filtering-Correlation-Id: f78df620-7ab6-453f-f6d0-08d59db2c5cf
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(48565401081)(2017052603328)(7193020);SRVR:DM5PR2101MB1029;
x-ms-traffictypediagnostic: DM5PR2101MB1029:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1029522CE837126FEF343B87FBBF0@DM5PR2101MB1029.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(170618885588394);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(6055026)(61426038)(61427038)(6041310)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB1029;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1029;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(396003)(376002)(346002)(39860400002)(366004)(189003)(199004)(7736002)(5250100002)(53936002)(66066001)(97736004)(22452003)(99286004)(68736007)(186003)(6506007)(26005)(2616005)(6486002)(575784001)(86362001)(11346002)(486006)(305945005)(59450400001)(316002)(3280700002)(110136005)(76176011)(476003)(102836004)(6666003)(446003)(3660700001)(5660300001)(8936002)(8676002)(6512007)(81166006)(81156014)(2906002)(6436002)(36756003)(14454004)(86612001)(10090500001)(54906003)(2501003)(105586002)(25786009)(4326008)(478600001)(10290500003)(1076002)(3846002)(72206003)(6116002)(106356001)(107886003)(2900100001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1029;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: XBQZ6Z8QSip4oUQQchHe1ZV7T89X076v1vf+LOZT+l6EF0ZNtXQ8pLNqVNVA8ToDjh79nuJ9+Xw8r/7ebKPgvJu9nM9o+l9LpDUje2AGkvNMwhdvnDSgTkaJgQTBDe1i6s4iruL+mvQoGw+1hGTttz8EymUDjn4MTEB02owRDLZnVkygkfsMv6ER+VPXmj31OnTflwBd5/9UR9+aY9xUeu//s1hQZ2s7Uozlz6638M9iSdzMWKTmnmVw1n3zS5fLdOXL8MeXLAxK2RHUCr+MtuHpuWJjg1jIyJRBJwwvgqAeznV3vG02czleiPBIR4xKwhyW5U1T2fMWlBQPU8lw2fvfNyrsoseD/iftur39alJrAJjjoq5CDe4blIF7Unvci4mVTlmtx8UxT9lZZFsSQxfFl6JJu4/xBtikMGQkDm4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f78df620-7ab6-453f-f6d0-08d59db2c5cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:41:55.0960
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1029
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: "J. Bruce Fields" <bfields@redhat.com>

[ Upstream commit 0078117c6d9160031b866cfa1853514d4f6865d2 ]

A client that sends more than a hundred ops in a single compound
currently gets an rpc-level GARBAGE_ARGS error.

It would be more helpful to return NFS4ERR_RESOURCE, since that gives
the client a better idea how to recover (for example by splitting up the
compound into smaller compounds).

This is all a bit academic since we've never actually seen a reason for
clients to send such long compounds, but we may as well fix it.

While we're there, just use NFSD4_MAX_OPS_PER_COMPOUND =3D=3D 16, the
constant we already use in the 4.1 case, instead of hard-coding 100.
Chances anyone actually uses even 16 ops per compound are small enough
that I think there's a neglible risk or any regression.

This fixes pynfs test COMP6.

Reported-by: "Lu, Xinyu" <luxy.fnst@cn.fujitsu.com>
Signed-off-by: J. Bruce Fields <bfields@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 fs/nfsd/nfs4proc.c | 3 +++
 fs/nfsd/nfs4xdr.c  | 9 +++++++--
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index f6429b3d89e2..a976c87eae49 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -1342,6 +1342,9 @@ nfsd4_proc_compound(struct svc_rqst *rqstp,
 	status =3D nfserr_minor_vers_mismatch;
 	if (nfsd_minorversion(args->minorversion, NFSD_TEST) <=3D 0)
 		goto out;
+	status =3D nfserr_resource;
+	if (args->opcnt > NFSD_MAX_OPS_PER_COMPOUND)
+		goto out;
=20
 	status =3D nfs41_check_op_ordering(args);
 	if (status) {
diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 660c813467e2..c8ebd89f0f2d 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -1655,8 +1655,13 @@ nfsd4_decode_compound(struct nfsd4_compoundargs *arg=
p)
=20
 	if (argp->taglen > NFSD4_MAX_TAGLEN)
 		goto xdr_error;
-	if (argp->opcnt > 100)
-		goto xdr_error;
+	/*
+	 * NFS4ERR_RESOURCE is a more helpful error than GARBAGE_ARGS
+	 * here, so we return success at the xdr level so that
+	 * nfsd4_proc can handle this is an NFS-level error.
+	 */
+	if (argp->opcnt > NFSD_MAX_OPS_PER_COMPOUND)
+		return 0;
=20
 	if (argp->opcnt > ARRAY_SIZE(argp->iops)) {
 		argp->ops =3D kzalloc(argp->opcnt * sizeof(*argp->ops), GFP_KERNEL);
--=20
2.15.1
