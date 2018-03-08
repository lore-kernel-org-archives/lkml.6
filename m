Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1025811-1520488245-2-4205546239775865361
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES enda, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520488245; b=cqILGqDQ91zFDOhbnPB9SYy3T8H3LBifVtqGXeaEEfmaKte
    IHpNki8+DTppyV9e5aBo3ddKhwMnwAUICvrj2BS1h1Q2qXLCwiiWZNrSB6V/+wWc
    nSANarTen5El9yvOADL+VnDiRCZPcco6hgQtrGjGIBAwc55xgpj9Rpdw80KEIMGC
    CHJNQjyuvIHr0OIflD6v4HXM1rB3gZlsMV2KAp0vqV81gThtgf4KWmUZ+U3TIXEF
    cG1RLlg7+uz4drhe1+JBUv1u85u72CDdw13QTme56aturCZ3G6Lm+ST61LxhPOQh
    t7US28jDCBbjkQvbc3dgrwUs5qbHRSRK5UK8Yug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520488245; bh=EUK01T
    OJ0/XDaDhOKWVYBaj1bukE5VfQyZrvpaCzTL4=; b=ALKNQvYjBnHTaKOWmvs7hf
    018A1oXbophWUqMdC0ySxGipu4Ovvdgipr46IMuZ1HX4AGCrlKSEWEI6ur/Rl8J9
    qORiGqRhiPhkVzJ4rnF6UHBZH5Kdd7Jag9VIRlj3AGetfdycSsEX0oSurhDxSr5R
    sjjAf9hCMZgx2kmWLHYCDmmzMe8bES2uvZFVt83pmsljLosF8qc0h3kPmekKHAJ1
    zGu16WggdDX2+BW+Nv7GVe/SwFQ6Ai1tTF5VOEuSGhQUCyYdpG+mzUdElggqc77S
    YQDOVjJ/aDUZeeK7iKDFmXwcBkh+b4SLROgYaWMvxr4quYAqrYe0wlxsIftHSNpg
    ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=nPNB9mXG x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=nPNB9mXG x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935492AbeCHFEU (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 00:04:20 -0500
Received: from mail-co1nam03on0138.outbound.protection.outlook.com ([104.47.40.138]:9600
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935470AbeCHFES (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:04:18 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Artemy Kovalyov <artemyko@mellanox.com>,
        Leon Romanovsky <leon@kernel.org>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 173/190] IB/umem: Fix use of npages/nmap
 fields
Thread-Topic: [PATCH AUTOSEL for 4.9 173/190] IB/umem: Fix use of npages/nmap
 fields
Thread-Index: AQHTtppUKV5KTUsju0SLyyjH3Ro+IQ==
Date: Thu, 8 Mar 2018 05:00:09 +0000
Message-ID: <20180308045810.8041-173-alexander.levin@microsoft.com>
References: <20180308045810.8041-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045810.8041-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0919;7:oB7xMKlVwB9u1E2NgeAQGrP1xAjrNAdn2nZyiKBEKnXkVdChhQCdNlRhVnM9i/zzC0CaWkoWUHzvUIfT++U95m05k54zV9NnkUloZyy0E9ahqauZZBC6HyXP0GGe9T+ZQfKnLHq3aPkHQlu04cQQHQkafTCxctM6UsuygXPxmXNfkFCNsYvsyJsHLHQdzkxsXr2+GGmF+ilEiXyXgY5XOiZO7YCtyLjOLavDWjNur0ETJ5+rKXKr/NJY4XalJd2E;20:CtZgp311wANiAYZcjmAM6NfWkHdRDMTbtukqgrMkDzh5g+6nfuzkBEicgXfUY0JlAMWONihmEEmu88l7fmMDCSzDLAQzpFw7GXnBjTWGshmMB8xNtane+Ni9rMwoqrqzFm3TF7u2SnyIUzlUSKBhhuYxCKvWUk+VU5cjyZ597pw=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: fea948f8-01e4-4a0c-7168-08d584b20a0a
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0919;
x-ms-traffictypediagnostic: DM5PR2101MB0919:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0919E21E1702B528424EF6ADFBDF0@DM5PR2101MB0919.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231220)(944501244)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB0919;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0919;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(396003)(366004)(39380400002)(39860400002)(199004)(189003)(3846002)(305945005)(2501003)(26005)(6116002)(7736002)(186003)(2906002)(316002)(3660700001)(5250100002)(8936002)(4326008)(86362001)(76176011)(107886003)(25786009)(5660300001)(10090500001)(66066001)(10290500003)(22452003)(3280700002)(36756003)(86612001)(1076002)(478600001)(68736007)(110136005)(14454004)(54906003)(99286004)(6666003)(2950100002)(106356001)(6512007)(2900100001)(59450400001)(6436002)(6506007)(97736004)(102836004)(53936002)(72206003)(81156014)(6486002)(81166006)(8676002)(105586002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0919;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: nAfGaUeB0ved2Ezfv8SwhJodiuj17sw/C1F2vO8gAC4kVKb9JMP6kplI6XTnE96jZjUVU2G7QzXtCG4d9Y5ulQP9su/0BzwMH2G/QJ3PkbcVnYlZwJraWK/YUKDeBqAWdhu3xif+7gZyXCGPLBIJzVVLlHRsWTenGMFjC0qjIEAsXETYTCYTzCNZNzLYvDWUfanGJarycpu0I7pNiJPY3u+6VIMrGggWnD5Kbe0pP4P3OUSwEyvs8uFMtRdgiEvDLiMd+wc4BZXLU/SNuB7AJhzdhCJeHDEOO5kjibuTRTdPxCif+cVmsFUwAt6bMizuzYMW4B1+NIaZWcR26GD7xg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fea948f8-01e4-4a0c-7168-08d584b20a0a
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 05:00:09.1658
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0919
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Artemy Kovalyov <artemyko@mellanox.com>

[ Upstream commit edf1a84fe37c51290e2c88154ecaf48dadff3d27 ]

In ib_umem structure npages holds original number of sg entries, while
nmap is number of DMA blocks returned by dma_map_sg.

Fixes: c5d76f130b28 ('IB/core: Add umem function to read data from user-spa=
ce')
Signed-off-by: Artemy Kovalyov <artemyko@mellanox.com>
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/infiniband/core/umem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/umem.c b/drivers/infiniband/core/umem.=
c
index 8e973a2993a6..e74aa1d60fdb 100644
--- a/drivers/infiniband/core/umem.c
+++ b/drivers/infiniband/core/umem.c
@@ -357,7 +357,7 @@ int ib_umem_copy_from(void *dst, struct ib_umem *umem, =
size_t offset,
 		return -EINVAL;
 	}
=20
-	ret =3D sg_pcopy_to_buffer(umem->sg_head.sgl, umem->nmap, dst, length,
+	ret =3D sg_pcopy_to_buffer(umem->sg_head.sgl, umem->npages, dst, length,
 				 offset + ib_umem_offset(umem));
=20
 	if (ret < 0)
--=20
2.14.1
