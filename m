Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-966195-1520486574-2-11370077152190255186
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
    t=1520486574; b=t9wKqKb9JizrunlpOO+THeLyCXx23AAvYDqtaUlqXzuDnOo
    J+lCIfidPk53bqbgLqKFOdb/YejmaMw1MmqwJLZMcDjd/8wA0/he14eohyJwO61B
    l8dW6GcYNab6ciKzJp3xjT9WGDmbYMY9h7f2xEuwyyyEw0NQ7JI5UBaI38h5jLr7
    NuYmLQeTMghA8+lfwDmBvkqvm2Iv3/683mrO6c+HI7RyMp2Qfc+5FqYKjRl5wt3f
    FI/RV7AYgFaaYYOci6fadHLxOkLOi+9YTD+hXyxRt3geHEeMBD/pALrSUGPJ/xjV
    OBfiGH7GfifzgCa9vrAewL2moT4m0clzLSvFcIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520486574; bh=AYdMOq
    RpLb3Lf4xqS/PkcP/fS75vIqYJXQs1/51u3Jk=; b=uD/Tc+1PqVBUdYNX2Yb/LN
    w8JRBWOTBIpzlOuCIh9gTVgqh6EjRiju8esjNnzpus4BJ5LSHBugAq+BN5GThoiN
    0IMU5J0byoB51XJ2wk1v+CO+2LDWWYazq4K3Mx2Rhe8eHyZUz+P8wvZeu/1ulrVr
    3AZnovlWbOOsg1SixJc3fqwkldSDz5WwovE8Znoq8nejb0FoyGgjudRhiImPTw7l
    Ac5aMj2OUKPvbJRjTYU8KC663xAkcJCZyT0uOD9Rd1OEtwQ0vvuRbjmEVxXN+qdY
    UJ6hYqcTpfafV/Cn+4MHEn3WqBgcswzQym6susf1QLGn5B0hzHDzpaKEbOnioWnQ
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=kxDQiorC x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=kxDQiorC x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966445AbeCHFWh (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 00:22:37 -0500
Received: from mail-bl2nam02on0095.outbound.protection.outlook.com ([104.47.38.95]:56636
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966608AbeCHFIE (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:08:04 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Benjamin Coddington <bcodding@redhat.com>,
        "J . Bruce Fields" <bfields@redhat.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 099/101] nfsd4: permit layoutget of
 executable-only files
Thread-Topic: [PATCH AUTOSEL for 4.4 099/101] nfsd4: permit layoutget of
 executable-only files
Thread-Index: AQHTtpqhcDRlgrrwEUOso8UHent96Q==
Date: Thu, 8 Mar 2018 05:02:16 +0000
Message-ID: <20180308050023.8548-99-alexander.levin@microsoft.com>
References: <20180308050023.8548-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308050023.8548-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0727;20:LSyFQCsjMQQeNXfKgh58d+WeD7ncxshb5e6LkP3eSHUh9lDrOvM88y8+sqNDxNRnDmN1X2cYHjzRmT18dYLziRx+fUkEYMyQTDCD+a8uGyndxGzVOWV9n21w4VPP+oAOX1aysGCDeJtAvTLq1hRLGqY86Fw4DTi2GoRR/RINW/E=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e44d2edd-c1d1-4848-1d91-08d584b28dac
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0727;
x-ms-traffictypediagnostic: DM5PR2101MB0727:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0727074D3A8EC871DD96DDBFFBDF0@DM5PR2101MB0727.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231220)(944501244)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB0727;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0727;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(39380400002)(396003)(366004)(376002)(346002)(199004)(189003)(81156014)(4326008)(97736004)(105586002)(2906002)(6666003)(8676002)(26005)(10290500003)(76176011)(186003)(110136005)(22452003)(7736002)(54906003)(25786009)(2950100002)(3280700002)(305945005)(81166006)(2900100001)(8936002)(59450400001)(102836004)(6506007)(68736007)(106356001)(10090500001)(1076002)(6512007)(86362001)(3846002)(2501003)(14454004)(478600001)(99286004)(72206003)(6116002)(3660700001)(5250100002)(53936002)(107886003)(6436002)(5660300001)(316002)(6486002)(36756003)(86612001)(66066001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0727;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: to/Qbwp3L1zwsSa1vsPx32SKudKsSq01bMWezjNtp4HuY1CA/RTPjBkbkpXILLsI4SMj/eF1V8T6kYl2HEwQJk4tLyIKRvQoFpHhmknAAuDUR6qcBsDVVfMDr+A812hLRHzB6eJcr7riFYeJgByTDT13JgVi0I2F9URXIYPrJhIanMld9HzNLut3sZyppi/gxI9QbaRRVX0VlVuz2TTa9z4nC99Kj6MMaS4+iAX+q/xm2Mh6njRj/4pwUBhmeS/nEUfAfBiD0L19+9Th4XrXGk5HPOEpAqt3frEub9zbGHfATo08ZasTAF2bWJMbarccq40NjACXbJVJLVcdsWdeMQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e44d2edd-c1d1-4848-1d91-08d584b28dac
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 05:02:16.8492
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0727
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
index 209dbfc50cd4..bfbee8ddf978 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -1245,14 +1245,14 @@ nfsd4_layoutget(struct svc_rqst *rqstp,
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
