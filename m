Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1086562-1520491000-2-4007486370690526049
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
    t=1520490999; b=XLMyEGoZXE4SLEk9Gnw3svppaOU2ZneW4Fet9C0iufHsqEf
    87zRAQ+IKkEykdcqTW7bieYAOh+DE5WZV4Az4S7pHMSwpfUgkF6XqTCRz+NpJ5HB
    2p8qbMPRI1rKWoWI00O5E0uZux98QRXwEawkegGUUO0g1ayQiRG8kxwLDJWX08RH
    7fKD7pP5T7BPyVFDloth7ImFDdQVQMOo3FFVOImKMEof/yYsIGCvZSJPAXuIWVAL
    LY1RU76ar03253Y7RDu6XayJ1nzpWdzeOFfDPf0tOBc/mQrbHv0rtcYoczjvpEhT
    HcDmgJr2MJjdWdPpYBBHbBoPlyNh0DpRWEPf8Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520490999; bh=eza5lp
    +lF4ueoJ6cx9do3TuIV12alAUDFRe+e7TQJxY=; b=m/gywSLqhWD54agRJvd2+I
    BA0C9FZtJ06Wf8Zwly/R6XHKmRmFqpl3dgo9+EWlYB2Tw4O+wlojmqc8XJlweSmt
    rNsQomE6e/z5Di81b4v8p+vOC9iLIeZQpwnZyBgVTPLSinqjDXEf+7In2TLZrKNR
    BIoTvjEqT+AXcYqvupMiGJwZjiYIu1+IgTZSQgu6tRM9AMFKnYI+Yw5m07bZfjjX
    twBZiTtmHYEdV5pF+4mSFlUmfT+NrxpOVyjwtpEG+aV8j3F1iFGhlH5BvlMzsTWt
    76gjDZeYhc+59rWoLwqReW3w3bGBEJHXR/m1iqUWNLeouQkd1q0e6NTrv6mutGow
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=ijJ4vKoM x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=ijJ4vKoM x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964919AbeCHE7s (ORCPT <rfc822;greg@kroah.com>);
        Wed, 7 Mar 2018 23:59:48 -0500
Received: from mail-bl2nam02on0136.outbound.protection.outlook.com ([104.47.38.136]:38384
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S964809AbeCHE7p (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 7 Mar 2018 23:59:45 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Benjamin Coddington <bcodding@redhat.com>,
        "J . Bruce Fields" <bfields@redhat.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 61/67] nfsd4: permit layoutget of
 executable-only files
Thread-Topic: [PATCH AUTOSEL for 4.14 61/67] nfsd4: permit layoutget of
 executable-only files
Thread-Index: AQHTtpoHM4/ETNwZjUq382ZPfz/pkw==
Date: Thu, 8 Mar 2018 04:57:59 +0000
Message-ID: <20180308045641.7814-61-alexander.levin@microsoft.com>
References: <20180308045641.7814-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045641.7814-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0920;20:WH31rin3PIFXY4MunAUQe6oVuHBGBX9aDjmFBN9+4rnHXk1YcFqEwhn9AGtYHFb87MvdkwfxZYQaLUTAsvdJ6KJCr18hRyXP4Oy+5e+tIFHCThyRRAKFByFD/+dJx5J7LAi0JqCmPNJHPumGd34vHcWcHv7ZZ5lBF7rDGJqPNDo=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4e0a4725-26eb-44dd-6d78-08d584b16834
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0920;
x-ms-traffictypediagnostic: DM5PR2101MB0920:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB09205065C2DFD4D7C0F2D70CFBDF0@DM5PR2101MB0920.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231220)(944501244)(52105095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0920;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0920;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(396003)(39380400002)(346002)(366004)(376002)(189003)(199004)(81156014)(81166006)(5250100002)(8936002)(54906003)(2501003)(305945005)(8676002)(107886003)(110136005)(97736004)(99286004)(6436002)(36756003)(316002)(72206003)(76176011)(14454004)(6486002)(7736002)(478600001)(10290500003)(186003)(22452003)(59450400001)(68736007)(105586002)(2950100002)(106356001)(102836004)(26005)(6506007)(86362001)(3660700001)(5660300001)(2906002)(10090500001)(1076002)(25786009)(2900100001)(53936002)(4326008)(66066001)(6512007)(6666003)(6116002)(3280700002)(3846002)(86612001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0920;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: f8T15hXfAYTlgldrctD2V+/B+9cBelcMrw3sbQZKCAvH8ViiE6+CdbIXp3fTryGPqTa5h0aGaxi6fp8u5oz213zdSfvFGxC7/R7RdW/dqpUXDnkJKvSgnn/4iHPuhdLBssakMdOh65U4dH4bfQHmytNaPe+F4zrj2o3WjTyH7DIkHl7FjYnUoZGx8Eshddt5AquX+ppBSNNhJgj5iLMOfpvM2lidTcQWW1nqNniljqfGc5WMj5U0mLSkWnlTKqc7KtlhnMwT7z2RB3HPavLDHR7LbxQnqbqQA/OVObEMqWG2Z1nMbGb8SrHf2zyDr23B7G149yBToYXF3yYBDKr4qw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e0a4725-26eb-44dd-6d78-08d584b16834
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:57:59.0980
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0920
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
index 8487486ec496..8ce60986fb75 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -1372,14 +1372,14 @@ nfsd4_layoutget(struct svc_rqst *rqstp,
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
