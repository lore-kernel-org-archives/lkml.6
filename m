Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-912290-1520485510-2-12098386795203900491
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520485509; b=lAYfmzXihvfA/zMge0tgSq4doJVabqqiqf8Q6AAaoR2k+gl
    aSYfFNC1vh0Z0mbPDkE6g05EBC7JTFWkqscnVca2BfK4yZ1AAIHAdjJ57+BOh6wG
    u6cETjpOjYy8KpqJ8hm2KaUy6lGlyt6W9FVwX3HfVZwTk3wEskdrr61429L7q8fB
    AHRh9nnHtH7g6gfbU94GA4rNHTd5r9aXuuiuPYyvxLi14NrcR7RpYoiBfNiIxx+V
    DAGoAAEaq3CRlMAC2Vv4fzwPxitMt8ChryxLcWaV5gJQtNUCajKIH3yy0oLZyqfd
    c/iZMqtKtJM3KyBdtWcKEUPYYVaRNZzZ1/ZMZeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520485509; bh=lvoWpb
    ROXD4gSLad/cN/lj5ZTgKJiGUgg9Zjugkjejk=; b=FKwybfyiZHr2JkPTIvO+sn
    KvEE2tivBFm8pe/7XRXqsRGI+yF2HkgPxBBp5jvgrZxWcKw1oiyt6RoT9XyUPRCw
    sfWSEA/DjfZ7kGCg1sJxJGMeErYzycBNQVDG1qbT3JDHUSpoE2kN+h0xQ6TgqWUr
    UwyKVkCuzN3q02NOQSw6tzMKqTPmaP7JI9IQE/Dlo9183TzQGG96upP+esIaTbOb
    MkJLFdI5o+OT5XSgjLObqQZA2CSq1IhTZedCgHJDagv7vsU5haHjwQd1dwHdMYKd
    BUC+LbXGdjH0+TQeRNnrxxgp88dwkFPp0p8hVAA9Pf8DKY32HLiqL6GhvdrOzYPA
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=NAZz1uBa x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=NAZz1uBa x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935594AbeCHFFF (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 00:05:05 -0500
Received: from mail-by2nam03on0127.outbound.protection.outlook.com ([104.47.42.127]:45712
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935583AbeCHFFE (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:05:04 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Benjamin Coddington <bcodding@redhat.com>,
        "J . Bruce Fields" <bfields@redhat.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 186/190] nfsd4: permit layoutget of
 executable-only files
Thread-Topic: [PATCH AUTOSEL for 4.9 186/190] nfsd4: permit layoutget of
 executable-only files
Thread-Index: AQHTtppYFm4DnlQdZEq5LKDW0nQY+w==
Date: Thu, 8 Mar 2018 05:00:14 +0000
Message-ID: <20180308045810.8041-186-alexander.levin@microsoft.com>
References: <20180308045810.8041-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045810.8041-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0981;20:XhSNtmIR4yXtXlRvb0viay/F6YBVGJTJUjYt0VyOx9RMYGK1q177a5U3h92IoJIvb/sbTG3BYWxWilbR7qNIZn1fr4EK0baav6Ux3cniuKsBFoc5NfarEPeOqZ+DsOCe/POJWsH88CfVDMiPd9tvJLTviARLgyQcmoGlY+1UD98=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4d1924aa-f419-4cd0-aa77-08d584b22511
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0981;
x-ms-traffictypediagnostic: DM5PR2101MB0981:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB09810778AE714659690648F0FBDF0@DM5PR2101MB0981.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231220)(944501244)(52105095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0981;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0981;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(39380400002)(396003)(366004)(346002)(376002)(199004)(189003)(305945005)(86612001)(2906002)(7736002)(6486002)(36756003)(54906003)(110136005)(6436002)(6666003)(2950100002)(10290500003)(316002)(186003)(22452003)(10090500001)(478600001)(105586002)(6512007)(53936002)(66066001)(68736007)(76176011)(102836004)(3280700002)(107886003)(25786009)(8936002)(59450400001)(106356001)(6506007)(5660300001)(3846002)(97736004)(14454004)(2501003)(26005)(5250100002)(4326008)(3660700001)(86362001)(575784001)(6116002)(81166006)(99286004)(72206003)(2900100001)(1076002)(8676002)(81156014)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0981;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: hZ5/7ZcRaDwKRYwkYLONgqx89YNrvGqvbrA2VQrHKI1cxxMP7i44QkEaHTYTdv/4KUJYbWYL5pAEWHiSvDzEMfUvnCZp4JN/GLZ3mStkELvi6Vlmf7Vul4kskZ8rijgRlI4PmLjohouPc/tpGRib4YPMi5+kPLCyRlXRE1o3Xdd8VSe0iJAuSsf74gGqDQduHQeXq13hz9RzAUp1lBt65I4XIefNjfKFd39BtdhIhvMG8H08HMICnJOjKkJOVzhF/Z/EshjOOHFjwnVim2TDkN9pMsfSyZwrpYGwL4YYfycPBQtP2uCUTBPKPZ/CEWI3qlfnGz+yhv8bdrLnIJi8Gg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d1924aa-f419-4cd0-aa77-08d584b22511
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 05:00:14.8018
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0981
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Benjamin Coddington <bcodding@redhat.com>

[ Upstream commit 66282ec1cf004c09083c29cb5e49019037937bbd ]

Clients must be able to read a file in order to execute it, and for pNFS
that means the client needs to be able to perform a LAYOUTGET on the file.

This behavior for executable-only files was added for OPEN in commit
a043226bc140 "nfsd4: permit read opens of executable-only files".

This fixes up xfstests generic/126 on block/scsi layouts.

Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
Signed-off-by: J. Bruce Fields <bfields@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 fs/nfsd/nfs4proc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 022d95886d66..eef0caf6e67d 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -1338,14 +1338,14 @@ nfsd4_layoutget(struct svc_rqst *rqstp,
 	const struct nfsd4_layout_ops *ops;
 	struct nfs4_layout_stateid *ls;
 	__be32 nfserr;
-	int accmode;
+	int accmode =3D NFSD_MAY_READ_IF_EXEC;
=20
 	switch (lgp->lg_seg.iomode) {
 	case IOMODE_READ:
-		accmode =3D NFSD_MAY_READ;
+		accmode |=3D NFSD_MAY_READ;
 		break;
 	case IOMODE_RW:
-		accmode =3D NFSD_MAY_READ | NFSD_MAY_WRITE;
+		accmode |=3D NFSD_MAY_READ | NFSD_MAY_WRITE;
 		break;
 	default:
 		dprintk("%s: invalid iomode %d\n",
--=20
2.14.1
