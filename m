Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3550853-1523233598-2-7883586574532495691
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
    1523233597; b=EXmoyM/CXoCuOtz40w9U/4B9MgnY84lLc3a9LV3Rpjj+PPsGiq
    ziR7jHUDjTUbB4XvPsBP/VOggQJ6BGc8N9hz9G67RNwh5EA9CcK0+94g3BPQxch1
    nbH6iTUCVmkXVFvpw7XFlCA4uJ94bAs/e6C3ikNRRJcOkKVPfSGKd5/ae/Cu4Rwu
    a6qjIgh95cRRvE8KYJfqbV8c2aH1xdNhVyqN4V5lULM28D6X+cdEC8WB83wQXbwC
    3UFSJbtmgJ5qqeHwH4PcpL49IJvYD29FGKn/BbpmxgCfZH+sVFnNLDTmkosA3WXU
    tkQBpDRmkOvekCRgyjC7/W1yhGUoBtswuQCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523233597; bh=wRODkf6K0U
    //ChU/JUgkZBa/CwCLy9hGHYvSWS4MhDQ=; b=PG8RtBGYiYcTLjX2pCZXJdbqcT
    hjYZq+XNQwxrPwbhTkYPW+Z1JPxbJYyCkDdwuo9XpHcbcvWgg5Dl1L/ncfFP5wQ0
    P2Valz0ULOzscFaUuWpAsfAWoHOMPH3DZURGWQWY+3LE4wolZsPVvWCUAx85QcrJ
    aC2ogsFaVuk4UjjGzBKhsLmg66RIAiHaJZgI5lzt93lVoBnuk4xQF9lM4wG7jUiU
    9VKbmzq/00pZQ9oOGuKBo5S1ygqGq7UeMXcFkd8Z4TdHJO9wCOXMjWSOyJ8z01Jr
    N7q7K1/3Zwknj86hwlCVWIUoQ7c5DEf6FNCgH1PdowajimmTSp5pPvFWjwiw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=jTldM3+p x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=jTldM3+p x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfFdC7SNGABv7uoeDidJi21jqPLDloA6vqxbOPJa9KRZBUaXrgknnOe4bpu9vI4YqGc0o6pgtADjT55oE3oFiP3WkI9lsvZYDENAvfwFymSCWD050DMG5
    03ALS9OZHkZ3i7DVA++8GtvQSHLvpF1heEdL/xa3FG0tD/nRNOnz+cZhLy+s+Kr6k2vLfslFIEvOPeSbkxRMaMNWkBdZh23YZhJAdMQFO61wMJpHYmWxRPpt
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=yPCof4ZbAAAA:8 a=JDjsHSkAAAAA:8 a=20KFwNOVAAAA:8
    a=yMhMjlubAAAA:8 a=l2jCzf7jOVhU8yY9kJsA:9 a=68qRyKIKyM3WOb4n:21
    a=Dwz14HG9gQHMyJBE:21 a=wPNLvfGTeEIA:10 a=dseMxAR1CDlncBZeV_se:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755336AbeDIA0a (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:26:30 -0400
Received: from mail-by2nam03on0131.outbound.protection.outlook.com ([104.47.42.131]:4960
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755311AbeDIA02 (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:26:28 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Chuck Lever <chuck.lever@oracle.com>,
        "J . Bruce Fields" <bfields@redhat.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 144/161] svcrdma: Fix Read chunk round-up
Thread-Topic: [PATCH AUTOSEL for 4.14 144/161] svcrdma: Fix Read chunk
 round-up
Thread-Index: AQHTz5jBUeRQL34Qi0y7faCAz3bTfA==
Date: Mon, 9 Apr 2018 00:21:51 +0000
Message-ID: <20180409001936.162706-144-alexander.levin@microsoft.com>
References: <20180409001936.162706-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001936.162706-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0725;7:+7EecW2wwXsi4xE2wghkcUkxjEMKSCju/BI4F1DNEaP3CpuUjWMrZT5aT/RMJBKRbQSSQKAxns/0VC0TC766fvhtr/w6MfpDW5NLBBzs4l2O0gTWyOi6L95noago++8HDyLYkgxHMt6u2SjSTqQoozwmGgDkjvAkXNJ45rruAn5sQk9nbI5cMKslAC3sGAx8UwF4watDRWxVLHzM3+kaXAExX3xHbp3Snlc0E9CdcTkIMduPmvQsD3zfgnVca63u;20:WfawtLRw/FBChPPBBSsDALTYLEnADzN3P0P5gi8nS1Muqgg8/LUNIbQ/pulpUv1Ezw7TkrHWKLx9TVjqw+3lZI9F8uMwiHSBvZQoyr+CYPohJgl0Uc6U4VfDPREPHfJhOnkawgjr0+e/KdsSih8wZHcnesP89O8gVMOvdnM8Pwo=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: f81b3665-1b8e-4bab-feec-08d59db0826f
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0725;
x-ms-traffictypediagnostic: DM5PR2101MB0725:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB07254BF3E8993744BF29F193FBBF0@DM5PR2101MB0725.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(158342451672863)(89211679590171)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231221)(944501327)(52105095)(93006095)(93001095)(3002001)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0725;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0725;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(346002)(366004)(376002)(396003)(39860400002)(199004)(189003)(6486002)(81166006)(26005)(6512007)(4326008)(6666003)(6436002)(81156014)(8676002)(97736004)(186003)(36756003)(72206003)(53936002)(107886003)(2906002)(86362001)(76176011)(110136005)(305945005)(10090500001)(486006)(3660700001)(102836004)(5660300001)(14454004)(476003)(575784001)(86612001)(446003)(99286004)(68736007)(66066001)(11346002)(54906003)(2616005)(1076002)(7736002)(5250100002)(25786009)(8936002)(478600001)(2900100001)(2501003)(3280700002)(105586002)(59450400001)(316002)(106356001)(22452003)(6506007)(3846002)(10290500003)(6116002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0725;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: eFmK1UfEv1N+hbZDLtaoykJtLQ9XLy4tjYooUCaZcMCZ1+tZPAHbjqpNzWIMQ4uQiO66rd1ZBZiEsXQoIX7YGd+YQHWNK0XIqWGioFCmUZCBZR+OjJewy3yHvgbApPnIf3XOFe8TWhNeMkiTECxCjNB2GvO0nBLco7TypVk2PpWL5Z/S6LMpKhGZXDEGCuuR1ypfjmBUpMmTN4kee8eYpJjlA4T0YIEBNi2RHyqIm/ltfz6z+vQJy5vc9CXdGP9N/vRNC+py0eM4nN/8/ZJMqlh9fXqAFFeku2xsHyl1Q1Y34UWzaX5909hLz4fWZbrKS5spUGoAOlgSU/Jt3l+IIimE/BLEzwVbMRGM2RE1PN4vFXuh3u8OMWdHfXR4j2XNsZnvnmcCjANmjaPJgLVoak43QtXLyPiYl+zKPHsDIMA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f81b3665-1b8e-4bab-feec-08d59db0826f
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:21:51.0811
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0725
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
