Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3992186-1523244994-2-11064855001005123489
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
    1523244993; b=MQPD+pnAe+OEajnIla6wI+6eQ0X418CmR/dgrB702jUogX3JN2
    yWXYOL+XK16wxVbVSmn8eCltsiONucdXANDGVG2UNG3NuPN6wSGtwm+CMFv/X46S
    e5pbNPBmCn33P+xh8JW1eXoufXn3UJs0uUDegkzVIOzW+0hmYUc7XelLSu9KEm5W
    MTABr+946wxeUi5Iw8ZJEQENiiv3xaZMHiUHeEm8Elc/wWsegv+eN2j5dnGE5dXR
    KhsjEfAJvr4D9YivaXelJ0dgGChtgZ5M4Ie75LH8aJxJuy1MH3eMROj7AMLc+zq0
    kCmGfs2euh3HfxgbEnyfZHPiw2mojo+JhDYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523244993; bh=wRODkf6K0U
    //ChU/JUgkZBa/CwCLy9hGHYvSWS4MhDQ=; b=koQYYSZr7vp5+qPkX4wNvTefbo
    alAjah0ljl0eeTfpxrkAMH41hH3FDQM+ZOyt0qYyps2gG/Z2gjlXPKUrzo0Ahe1y
    KN+IJSX2t89bRe07Ofj9w4ePhVn820ljmEgSTCHKGvdBDQqDftw6VH0u5ZpovpLH
    eqSxEBBQwg2ZJvwOpoQ7Uw0IgzlMKHg92paz/LiALSsy1jMfoD5ZlK2Y8/m562o9
    DNDsO2r9LgBpax/Vv9XYx674PN85pMVrhGROLV611vxGF5gfOhH2FRte45Eavd0B
    bdsavc15avIxz01s0K67WqgWHzPsaWHov8Qc5cC2HeLvQbqB7FnnvI4VSyzA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=cZ930hPJ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=cZ930hPJ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfDdYsppN21GMzRwEX4GXGvhYSPHYLuZSHDiElAht0Y67IE1IOx7mMQGKPE5NEigfGV819dCjRdTR9B870ZJlyfuSgzghClKku5NdwpiqJjbZXDsyILO0
    alR5jHJGtwLwRaK+XhFaFIhvhLW3GbBXaZUz6wkugoI5V60CTEYuIzQQelBn9/+WMqWSYFF99IklYyxRUs5Nu8IP2hPhngXOWJvDD4F1hGWYfPTdikWC8zWo
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=yPCof4ZbAAAA:8 a=JDjsHSkAAAAA:8 a=20KFwNOVAAAA:8
    a=yMhMjlubAAAA:8 a=l2jCzf7jOVhU8yY9kJsA:9 a=68qRyKIKyM3WOb4n:21
    a=Dwz14HG9gQHMyJBE:21 a=wPNLvfGTeEIA:10 a=dseMxAR1CDlncBZeV_se:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752369AbeDIDgP (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 23:36:15 -0400
Received: from mail-bn3nam01on0108.outbound.protection.outlook.com ([104.47.33.108]:54803
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754399AbeDIAVO (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:21:14 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Chuck Lever <chuck.lever@oracle.com>,
        "J . Bruce Fields" <bfields@redhat.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 170/189] svcrdma: Fix Read chunk round-up
Thread-Topic: [PATCH AUTOSEL for 4.15 170/189] svcrdma: Fix Read chunk
 round-up
Thread-Index: AQHTz5hd7FYH0eXtlEuxOjSxbzDZbA==
Date: Mon, 9 Apr 2018 00:19:04 +0000
Message-ID: <20180409001637.162453-170-alexander.levin@microsoft.com>
References: <20180409001637.162453-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001637.162453-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1125;7:JjjFqWBM9IRRmFd659CwvAIGDdSEE/gsW4RE9ueoMgFNNOaOsio6pMNl6+uxGprbvxR4STRepBl3+JAqA8DxNo4r9tXTrbdIjAfCxUxyeEIaLHXSInLFKQydA4xP4aPG4ST082/3KFaDqaYf4Np8/PlFaAD+7/vStpk/BqL/LeR/7ocom2/2sDoyqb+Nwak669w1ZVCUkngukxqYXWGM08SEiXMdsiSrqkRSEMDObeWx1KBuxLzg5RpnLeJX/47X;20:Yv3/UVaWgBw1+U/3j/pZdW/vAeZ0yUJcGb8RSo1S7l+RdAmiXFG4BRPJMdfWEVEryejNz0Zt3F5EKB5iehaMJF12Qb3soP4LQYktm/raROjfaZUHJY6AAWhqUmwlahPkweBsr1J6V2cM12fyTKXsx0Y/+7LZ+GdVscamGtIDu1I=
X-MS-Office365-Filtering-Correlation-Id: 4b5f20de-b4e7-4693-7cd1-08d59dafcba5
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(48565401081)(2017052603328)(7193020);SRVR:DM5PR2101MB1125;
x-ms-traffictypediagnostic: DM5PR2101MB1125:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB112586ACD39B66F25C839EFFFBBF0@DM5PR2101MB1125.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(158342451672863)(89211679590171)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB1125;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1125;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(376002)(396003)(39380400002)(39860400002)(346002)(199004)(189003)(105586002)(7736002)(8676002)(97736004)(81166006)(59450400001)(106356001)(81156014)(305945005)(14454004)(66066001)(1076002)(102836004)(5250100002)(478600001)(2501003)(2900100001)(22452003)(72206003)(68736007)(26005)(86362001)(575784001)(8936002)(76176011)(6506007)(6116002)(6486002)(186003)(5660300001)(3660700001)(316002)(54906003)(110136005)(25786009)(2906002)(10090500001)(6512007)(3280700002)(6666003)(10290500003)(53936002)(99286004)(86612001)(3846002)(6436002)(486006)(4326008)(2616005)(11346002)(107886003)(36756003)(476003)(446003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1125;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: ylFW/C1gY3tOhrdrOK4KTF31X56UqEq3wR3JNH383CYkkXuPc/BvtDgdELYJnpZBbvQOSxjTyczCeg3vG/V0lhef8ACQca6W2KELx64b2YygznzQkBbLc19dyd9BtC3nlbIBBev8n4B+WyXBZmPd1cp91/2fuyzgckb6n2WfXVbg0FScqsTuql+C21tUGmBftf0ugTc+flSfNgan2B+WidS1gh2uZz8P/SpwCyZ2ppZbGo3fYmPTrZENBBbi8Mg0eJW+C9JhsYBBfx2+pYXJafQ9NHqeklpktS5sgLjtbj0xEtLNZCL6oQ/C25yPmRIcMGdPd4BsgT2aWRMy9ZOZ3RR+VB0nEASDz4UX7mvn0sT7GQ73v7J7nNXxPJQTn+HEt3P2RDnVStT4VRsXA67OfgLwSShVWRg+OvuhjXAk9+o=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b5f20de-b4e7-4693-7cd1-08d59dafcba5
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:19:04.0022
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1125
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Chuck Lever <chuck.lever@oracle.com>

[ Upstream commit 175e03101d36c3034f3c80038d4c28838351a7f2 ]

A single NFSv4 WRITE compound can often have three operations:
PUTFH, WRITE, then GETATTR.

When the WRITE payload is sent in a Read chunk, the client places
the GETATTR in the inline part of the RPC/RDMA message, just after
the WRITE operation (sans payload). The position value in the Read
chunk enables the receiver to insert the Read chunk at the correct
place in the received XDR stream; that is between the WRITE and
GETATTR.

According to RFC 8166, an NFS/RDMA client does not have to add XDR
round-up to the Read chunk that carries the WRITE payload. The
receiver adds XDR round-up padding if it is absent and the
receiver's XDR decoder requires it to be present.

Commit 193bcb7b3719 ("svcrdma: Populate tail iovec when receiving")
attempted to add support for receiving such a compound so that just
the WRITE payload appears in rq_arg's page list, and the trailing
GETATTR is placed in rq_arg's tail iovec. (TCP just strings the
whole compound into the head iovec and page list, without regard
to the alignment of the WRITE payload).

The server transport logic also had to accommodate the optional XDR
round-up of the Read chunk, which it did simply by lengthening the
tail iovec when round-up was needed. This approach is adequate for
the NFSv2 and NFSv3 WRITE decoders.

Unfortunately it is not sufficient for nfsd4_decode_write. When the
Read chunk length is a couple of bytes less than PAGE_SIZE, the
computation at the end of nfsd4_decode_write allows argp->pagelen to
go negative, which breaks the logic in read_buf that looks for the
tail iovec.

The result is that a WRITE operation whose payload length is just
less than a multiple of a page succeeds, but the subsequent GETATTR
in the same compound fails with NFS4ERR_OP_ILLEGAL because the XDR
decoder can't find it. Clients ignore the error, but they must
update their attribute cache via a separate round trip.

As nfsd4_decode_write appears to expect the payload itself to always
have appropriate XDR round-up, have svc_rdma_build_normal_read_chunk
add the Read chunk XDR round-up to the page_len rather than
lengthening the tail iovec.

Reported-by: Olga Kornievskaia <kolga@netapp.com>
Fixes: 193bcb7b3719 ("svcrdma: Populate tail iovec when receiving")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Tested-by: Olga Kornievskaia <kolga@netapp.com>
Signed-off-by: J. Bruce Fields <bfields@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 net/sunrpc/xprtrdma/svc_rdma_rw.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/net/sunrpc/xprtrdma/svc_rdma_rw.c b/net/sunrpc/xprtrdma/svc_rd=
ma_rw.c
index 9bd04549a1ad..12b9a7e0b6d2 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_rw.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_rw.c
@@ -727,12 +727,16 @@ static int svc_rdma_build_normal_read_chunk(struct sv=
c_rqst *rqstp,
 		head->arg.head[0].iov_len - info->ri_position;
 	head->arg.head[0].iov_len =3D info->ri_position;
=20
-	/* Read chunk may need XDR roundup (see RFC 5666, s. 3.7).
+	/* Read chunk may need XDR roundup (see RFC 8166, s. 3.4.5.2).
 	 *
-	 * NFSv2/3 write decoders need the length of the tail to
-	 * contain the size of the roundup padding.
+	 * If the client already rounded up the chunk length, the
+	 * length does not change. Otherwise, the length of the page
+	 * list is increased to include XDR round-up.
+	 *
+	 * Currently these chunks always start at page offset 0,
+	 * thus the rounded-up length never crosses a page boundary.
 	 */
-	head->arg.tail[0].iov_len +=3D 4 - (info->ri_chunklen & 3);
+	info->ri_chunklen =3D XDR_QUADLEN(info->ri_chunklen) << 2;
=20
 	head->arg.page_len =3D info->ri_chunklen;
 	head->arg.len +=3D info->ri_chunklen;
--=20
2.15.1
