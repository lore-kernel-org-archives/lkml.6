Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4029176-1523245190-2-8409123012725967579
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523245190; b=TDhaAYfdtrqVbO893L1D8h/y5g5c9ZZvRhUeTs1asjdJk0Cni8
    tVqFee1wuCokT6ES4bThO6nMn7ysC4s07P42Vot2tRTB5fe1niVEuwhS14OZFfAK
    cBqKQObNhjjoIQdb2iJdkNY3/0Dq+6jetgMvpR3qoyIXY4fe0pSxnNLL6/Ag+COY
    W6JCl41Q6Esb4xA2a/0b6cHTu/wYc+XvUnfLCslc9P1QOP/ZiK4yYdGYbNchYlSm
    i6TcTDFsQfMwSqZdcdfj6uL44rH++vKcGj1T/ohJ9Rr0Sbp1Y2vzj2qEfQGMekY5
    8Au1pg80sSFtB1oKtxVpLFfWRUt6R1Pj/uWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523245190; bh=0ZUUF3pAKf
    BvxDpvEaQIrJDJrz9WBpgUZc+MccRexNA=; b=s2D88PKNaUb5vn6kx9kDxdfr/q
    naQ52jHF4YxzW+Ft1fmQPi7u5NCY+7RpypM1DLlh4htcHzgOlFJ6fmaZYQI9zJeg
    1iaqur7xK/GgqS5NZDnEJxfc2iMjrDHChEAGl5VEaNvY6PXDwXTuodZEIDAIIjhc
    vAmGLThI2zeB72P95peaOHIFBL2jGFplyJLTYj4pErg7nlJLu/uDxEotXchFCNZS
    HfcNBu/2ZmAa65aIZkgCdy05Hw9QgMaJx6sCseU67WJsP+VY5ULWorygVeoKogg6
    NQUwnpeSiDx/rykb/WYrKN4gmSoEcIXisrvKdk3c9KXJsCT3Amu0hAqNKdEQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=UJC8jW4+ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=UJC8jW4+ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfIB1vR/p7ffu38HXa75pw6GHOP1gpa1DAQ7pCq/6cB0pJzHWapT6bXDuw0w+axSAK5rOUmPgwRSDPP5LvbKFEMS0yM7CYDuytsdKTwJRhMT7gzluD6r5
    25RA25o7IcguEZ2ZZcpqzglztgztg86M6JzHzNw2yJJgN9mORxSKZM4pLwwfXqpnfRna/b0BM1g/G+OR7OqeYzkJsWFM0aF36trb35W6eEYefvo3fN45jfYz
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=20KFwNOVAAAA:8 a=omOdbC7AAAAA:8 a=yMhMjlubAAAA:8
    a=gsqZSsGcU53TmyZKCsoA:9 a=wPNLvfGTeEIA:10 a=baC4JDFNLZpnPwus_NF9:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752604AbeDIDgi (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 23:36:38 -0400
Received: from mail-bn3nam01on0108.outbound.protection.outlook.com ([104.47.33.108]:54803
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754387AbeDIAVL (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:21:11 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: "J. Bruce Fields" <bfields@redhat.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 168/189] nfsd: return RESOURCE not
 GARBAGE_ARGS on too many ops
Thread-Topic: [PATCH AUTOSEL for 4.15 168/189] nfsd: return RESOURCE not
 GARBAGE_ARGS on too many ops
Thread-Index: AQHTz5hccPWfIEumc0Gehf5m4O69Gg==
Date: Mon, 9 Apr 2018 00:19:02 +0000
Message-ID: <20180409001637.162453-168-alexander.levin@microsoft.com>
References: <20180409001637.162453-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001637.162453-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1125;7:R0059Dmv+3uKcjzt2Iz5+KmcLmceVKhHCFkXrC7zpBcwVDAaugF5tK7ttaE8+7BWk5qosAwTlfbgObd74zeReS1fQoljGDRaGRLmP5Ye/jsjbjehVcTeLetjauTr91zKtQKWEOIlnSAZ2lygEFQOEJ3xps0Xvbh5N+NNb2boVHLkGmJMmEdQ1/CwmiVU5RRDGW3HGmmpIot1LEDFgPA3ET9RzQEi+Szr9InSk4jXFLKL7uXOLWyX/Ccx7RhCTwLB;20:7/kF4h9NzvFWxpvZZa8xt7zyRy/cvRE1e2wyoLdFfTdjcwWFDEl4210/c3Jy/tcl9z/wNIbDXJHg1pHhkAUnAZIqglOnqXDq542tIlbMHbGloktEHizjh80LJZ7ckf8l56ALmWJBEdqhrvpIVZ/EU2/OwdA+X754Xl9gJ5+XE7w=
X-MS-Office365-Filtering-Correlation-Id: edd7a9fc-0457-4660-e6b4-08d59dafcb0c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(48565401081)(2017052603328)(7193020);SRVR:DM5PR2101MB1125;
x-ms-traffictypediagnostic: DM5PR2101MB1125:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB11255F20A235E7CE8E793E38FBBF0@DM5PR2101MB1125.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(170618885588394);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB1125;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1125;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(376002)(396003)(39380400002)(39860400002)(346002)(199004)(189003)(105586002)(7736002)(8676002)(97736004)(81166006)(59450400001)(106356001)(81156014)(305945005)(14454004)(66066001)(1076002)(102836004)(5250100002)(478600001)(2501003)(2900100001)(22452003)(72206003)(68736007)(26005)(86362001)(575784001)(8936002)(76176011)(6506007)(6116002)(6486002)(186003)(5660300001)(3660700001)(316002)(54906003)(110136005)(25786009)(2906002)(10090500001)(6512007)(3280700002)(6666003)(10290500003)(53936002)(99286004)(86612001)(3846002)(6436002)(486006)(4326008)(2616005)(11346002)(107886003)(36756003)(476003)(446003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1125;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: D6SlqOx6yv8pJZHD/BOelUr0hGiGuw7Txet+vD6KBg43t4Q7t6IMcYIgTRJEckAzvfz0l8RlraNOISV57Gm9ywWBaig50TC7aLYLvn/kt8cvm712nRZew0AeTS0oekbZWI7Iqld9aFe/8Qd6LVOocMakP4aF6zyeN01L0ZhY785FuXlmaz5rMcE4U5FM0tiVZ9CFa8QEAN4CgV8cci44cGJBDR9lrU9LMj11uX6eY0TOwlOAU4Z0MixwlqTkgb6D/1VperwsI2ATIpUzYRuxKbueZVBtRXrNXu5JDKFo3eAvR0OJtebc8eaJ7Z2n6IVL70p+ly3zPmR3LeMBFvlp3K+54EwrBlLLqsGBATx5aQ6CRWC1o4pjeX6hggVpo3w3eDv9edbX1iTeeUYAA26vjG9sOa5sq+Co9wbPmr0usKw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: edd7a9fc-0457-4660-e6b4-08d59dafcb0c
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:19:02.5804
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1125
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
index effeeb4f556f..a0bed2b2004d 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -1703,6 +1703,9 @@ nfsd4_proc_compound(struct svc_rqst *rqstp)
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
index 2c61c6b8ae09..5dcd7cb45b2d 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -1918,8 +1918,13 @@ nfsd4_decode_compound(struct nfsd4_compoundargs *arg=
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
