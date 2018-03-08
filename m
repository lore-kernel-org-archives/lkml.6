Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1171329-1520492079-2-2306236079373958715
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
    t=1520492078; b=nu42qP0ZXtEjnO2dUCjPnHbac7sI0h9vgbFjITLTFAlzaL8
    Heic8UsiypgZIl5XdeucvDJvp3zi71mrwafp1sQmsX4sG4huovNkArE+hechQGJ6
    tD0eTvdBEPIpP1WqZd9oIDGZJXL8u7Mlk6JGLyDrCW8AsE009gPVKecbUTeQqiMV
    9RUqIlBsWCgZRbVojF/JfwIK44qJpWpK4ZR9oTPhwbiQCCfnpkYbg1jHOmIzQPvE
    eMcjYU19phmKsXPIV4u5ZJzOFoe3ROUPPrc8vw+XS/C1xxBVRmqrKyw1pbItk3x+
    48NAKDg4U1SZQ1RVY4bDrBhju+biTfG49qW4hnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520492078; bh=rN38Ar
    2mcl1wdwDTYXRXSbiZuRnkVbQ/8Xu26Jxxwrg=; b=czvtXDweWHgHejYYt5T7KH
    t9fUJKjPDFNk5Es4ypKjmkFQiJK+UD8SHD+j+qeV1Ah9y8yDNRNBjVlDKUgaRSnE
    dx7TB6cMO3Q0DTkzocHC/xOHrUf4VLe433r3KRCqXL47UnSDoZZzkmBP3T40yjXM
    fTC15A7igz1tDHupnm5/G/KW9zl9f3sx43WT7HdLmk4vrZO56vjUn1kaRNk4v45l
    FBVSQuWQgBWqZ/+/jRBmpenW8YqeVhzTYw83gWaKevi7G3ZqmuLz2FKG/VuvvOL7
    er4x9XOHCnsCIVZDFuqdWTabFWjtb7AUSydRhqMHbCuVA0gFGIw83OZowZHTWQrQ
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=PotFy1Gh x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=PotFy1Gh x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964985AbeCHGxc (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 01:53:32 -0500
Received: from mail-sn1nam01on0120.outbound.protection.outlook.com ([104.47.32.120]:33969
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S964963AbeCHE6F (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 7 Mar 2018 23:58:05 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Benjamin Coddington <bcodding@redhat.com>,
        "J . Bruce Fields" <bfields@redhat.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 71/78] nfsd4: permit layoutget of
 executable-only files
Thread-Topic: [PATCH AUTOSEL for 4.15 71/78] nfsd4: permit layoutget of
 executable-only files
Thread-Index: AQHTtpnUCjyC9gO3LESF5OqIoZ8YkQ==
Date: Thu, 8 Mar 2018 04:56:32 +0000
Message-ID: <20180308045525.7662-71-alexander.levin@microsoft.com>
References: <20180308045525.7662-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045525.7662-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0888;20:r/UItx7SKT31s8TJvoP8K7FiyunLXchOkek+alqiYGMuhM2kBSrF+g2oczdBwEphZF3ZYJx/LI2kIlpdyHDthu3ffwCJkLSf3stEfDB3Arvgz9hZR0kGJPgx9Ra/ViY2hDBNzfQXL1g9RXVq79oCFNPla0s+n4h59MfPsUV6hBw=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1d475c93-7e44-4cae-cef0-08d584b1297a
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0888;
x-ms-traffictypediagnostic: DM5PR2101MB0888:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB088833E59B41F2E02ED316D4FBDF0@DM5PR2101MB0888.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231220)(944501244)(52105095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0888;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0888;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(346002)(376002)(39380400002)(396003)(189003)(199004)(6116002)(99286004)(2950100002)(6512007)(6666003)(10290500003)(36756003)(5660300001)(106356001)(1076002)(22452003)(3846002)(97736004)(316002)(53936002)(68736007)(105586002)(4326008)(25786009)(54906003)(478600001)(2501003)(186003)(66066001)(76176011)(3280700002)(86362001)(575784001)(14454004)(2900100001)(5250100002)(110136005)(305945005)(7736002)(72206003)(3660700001)(6436002)(2906002)(26005)(6486002)(10090500001)(8676002)(81156014)(107886003)(81166006)(86612001)(6506007)(59450400001)(8936002)(102836004)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0888;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: w0IseB1K5RLsqOqnTm9XrxNcL5TZYv+RKbIWRdZSxIoW1GcKknOudshgO9HP36y+VHYyMrfvHWHbkWXpbQg8HiNKc5kO/+yBQZpEwocDpowIW2JPVsWidywuCoIJ0SXWpZ/y/9FUY0uzS94qxPVNJvdNZ402r0qFIg8m2eR3BwiilW9lyT+Uq8Vkc+S9HN91LfrMrUSGsMhOGH34AFXy094QzFNaLkNXa3wLRDTK6uWbPHdQYQ6wEj744d7i0qQ4TtFc2w7HRuPxlepOj0qCLJtu1KqTRA5ekYWQjlzrlfA2nlIevyJo7z1ePZtasfH/8ZOAPEIKPNZwUsMQK/qdpw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d475c93-7e44-4cae-cef0-08d584b1297a
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:56:32.9729
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0888
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
index 008ea0b627d0..effeeb4f556f 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -1363,14 +1363,14 @@ nfsd4_layoutget(struct svc_rqst *rqstp,
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
