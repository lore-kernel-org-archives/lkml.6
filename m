Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3764808-1521494441-2-6940210430166140581
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521494441; b=L8DM+2pgcI5If7cdtuXtHBbxcm/Z4HS4bu77fzkX1RmTllJ
    KDzajkaORWrOAPzrXhicsj3bGYiNCH52nzikG0OZQrpORBcoZqcAgPiSsc3+N5+W
    MOpXMIb+l+P7Cj7DoGuuKD9JXP3tDHgSDA/B0sRMiBg7KqbcOMPiLvIyzPX/HpAW
    4s6a8A0fI2khonuKlKnvt3uWJLCXFk/d6AqtoMRrIO+6ZgER/m+PSA+UBPgQZijV
    +/UcaykiFEUuIqncGZJYRwmgiQMNMX0la0Zf5Wj2Kb0ie8iyPq+aV61PmhPdbMOt
    +zaxhmCY8CW3x/CEBQSQt3vtsSm3HVDqFNzCjiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521494441; bh=C/YNfN
    4C+Uf/RzBwXinKX8Q8uOx+A0pD1Fh47GhK5DI=; b=crnmNvdoGkOfGdM0hmHQJd
    z14mWN7Z6dP2jmr+Nfdt4xGQOs6CQVpyEzAPkcc0l6G2gGP9y8wdgYCBwk7erCDQ
    KVehXB+q9eGPO+NKR9eBMVfulXZWbSnN5JZkvUyvo2KScmVCJBiiTjg5pRQpm8zV
    GTmG0GmK0DzPq+KMhUlqND55gUsTKJsBmDZ84DvrTCFE+rFtHMZNw1P3lEqukR4B
    7tixZpAN3Zhm863tTAcCCmWG6TlK2Ln8eriIb4tr8KanRSqCpD8Xc62WNiUNLGdG
    VJDwT4ZoVts1+0Ngg+iP/rRn4Ge9k9MmuJiBq79heYhIboXOCqB1QWV+tzXRnVNQ
    ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=k6cnuJWA x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddugeelucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejudehvdenucevlhhushhtvghrufhiiigvpeef;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=k6cnuJWA x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddugeelucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejudehvdenucevlhhushhtvghrufhiiigvpeef;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S969684AbeCSVUM (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 17:20:12 -0400
Received: from mail-by2nam03on0105.outbound.protection.outlook.com ([104.47.42.105]:9497
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934899AbeCSQAx (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:00:53 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Dan Carpenter <dan.carpenter@oracle.com>,
        Trond Myklebust <trond.myklebust@primarydata.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 104/281] pNFS/flexfiles: missing error code in
 ff_layout_alloc_lseg()
Thread-Topic: [PATCH AUTOSEL for 4.9 104/281] pNFS/flexfiles: missing error
 code in ff_layout_alloc_lseg()
Thread-Index: AQHTv5tT4YrxIchhWEKs0ScBtikGqw==
Date: Mon, 19 Mar 2018 15:59:56 +0000
Message-ID: <20180319155742.13731-104-alexander.levin@microsoft.com>
References: <20180319155742.13731-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155742.13731-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1031;7:8qZmKmPJFzdKqXJqSapQWmm/z82Xto538xFajSRQRloW36m6YNpqAzUIT5SbVk8u1F++37ZzOCjBVYUVumRAsk0lf/0Zkg3RGlfSGtrZL+3mg3BM7uf5hZCqkYwxbAhuxgGF5F/usMhkURJjtRezqnIkEKNUvkkxgvOP56+vlVKYw05nVJXMvtbSNMQgdF5QcsLXy21IrVb1nOLU8OdmiYDjqBFraDGnC9kwMuWVCfQx0+tFBZZ2yQ1l56fGLhGf;20:BhETGinV0p2ToTCNduEReZMWskbwOgf3cZ9NHOKU54vFrhallA7M7VgQtyJW0mJ5u5hUnDMxBwQwMb8FU/MuCQAeTkspEMraIlyygV4ZMW+4zBjYvR6Hwx0rQ8mE3YItf/7WigQ6hYzwtnT5b+eOJdVa4+Hu7paoVs0nre+dN7o=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f18a8b52-12e7-41c3-44e7-08d58db29414
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1031;
x-ms-traffictypediagnostic: DM5PR2101MB1031:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB10314AFAD47FEB1C4D6F3E25FBD40@DM5PR2101MB1031.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231221)(944501300)(52105095)(3002001)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB1031;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1031;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(366004)(346002)(396003)(39860400002)(39380400002)(199004)(189003)(25786009)(6506007)(66066001)(99286004)(76176011)(10290500003)(54906003)(68736007)(3660700001)(97736004)(22452003)(575784001)(107886003)(53936002)(86362001)(110136005)(2501003)(5250100002)(86612001)(14454004)(478600001)(72206003)(316002)(102836004)(26005)(186003)(6116002)(3846002)(7736002)(2950100002)(10090500001)(6436002)(3280700002)(6512007)(6666003)(2900100001)(8676002)(8936002)(36756003)(106356001)(105586002)(4326008)(5660300001)(305945005)(1076002)(81156014)(6486002)(81166006)(2906002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1031;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: HJizNRekVJzRLUrwmrCVHXEYZa+riWGDJAjvgQvXZzo+IjK/kCCe6mBx+tQlst55Lbr01BdlYuehPfNHxuRqK/GWsi0hCecBcXVqx+NUz/6yFZhC0/dM5ntLwj2cGxmP5m6Tlzeixl2wMIil9lFNU9sJTxlgnCBlqDE3g1gfF8jB4hjpv/wmSCUZPE+KeY8lHWl9Oqs3kuVhplZIiFGrFO7ZFqc4BdueLkXgSo/DhiocrQ1oT5V5UGVRXuDNUw4B9MKBwT8KX01HDCPss5UWjOBzZetR2dJlbjaeAycNq6/ooE0bmBFyYP5HS+EFlNNCXN6MDl9CI7DbiRmPLVZNpA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f18a8b52-12e7-41c3-44e7-08d58db29414
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:59:56.7902
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1031
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Dan Carpenter <dan.carpenter@oracle.com>

[ Upstream commit 662f9a105b4322b8559d448f86110e6ec24b8738 ]

If xdr_inline_decode() fails then we end up returning ERR_PTR(0).  The
caller treats NULL returns as -ENOMEM so it doesn't really hurt runtime,
but obviously we intended to set an error code here.

Fixes: d67ae825a59d ("pnfs/flexfiles: Add the FlexFile Layout Driver")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Trond Myklebust <trond.myklebust@primarydata.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 fs/nfs/flexfilelayout/flexfilelayout.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/nfs/flexfilelayout/flexfilelayout.c b/fs/nfs/flexfilelayout=
/flexfilelayout.c
index 13abd608af0f..4539008502ce 100644
--- a/fs/nfs/flexfilelayout/flexfilelayout.c
+++ b/fs/nfs/flexfilelayout/flexfilelayout.c
@@ -475,6 +475,7 @@ ff_layout_alloc_lseg(struct pnfs_layout_hdr *lh,
 			goto out_err_free;
=20
 		/* fh */
+		rc =3D -EIO;
 		p =3D xdr_inline_decode(&stream, 4);
 		if (!p)
 			goto out_err_free;
--=20
2.14.1
