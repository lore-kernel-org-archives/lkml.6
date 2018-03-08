Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1171329-1520492470-2-13090051792078737674
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
    t=1520492469; b=V541OABdzeDHVWkqCsQkWjSTmUXd8qCgrDmYHuM5mXznZx+
    KHmiL+gEiURL3YRgBf3DlC6wEQElPDoVUwNrS8dcM7YY5FGIWcBKwh0ma1AFA9vF
    FHyKtmbU1CuAXKoi9Sz/uz6m16AZIpp4165XwIWW0KTmwurHE6Hr/WtrGYF92WNW
    PK09FS73E9mRmIVdvHbtzIiJMixSH9Nvg21fxEfH3LlisYy+Fe5I7VDJyNZK2sEG
    joBvN1JBdKqlNSALkZq8C1d0aLNYJScDklALysJWJqTAbPCk4spYbZFAWE1Iuf4v
    7V6JEKnTHzRqV04poBadIrin/33YSkHONtXyoRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520492469; bh=m2R0QK
    gstth67NIfFra5SyKiWsAMnBBryvBx4/9DcYY=; b=XtL/lq/1JcQsyIuE9wBF5H
    aZwc6x1Q//uJF77fgkoQAhS+Sbb5k+FBHJB+MXxDb1gOigUJYfin3sTm6+54IL1D
    zp0Uc6qyDbDn0nN2mm1i3FWFh8Nk85YC4q7rEYTrH/4rwvucuKysAqlUO+85ZaVz
    Qiu/2giFOaiAPaciQTTEyGDgYB6PJKVTdn7g2AGdngWKlSoPO9bxLlC9sYU8ZKbi
    PKP7okvMsg8j7V5YYHT4FPRwI8PkrHouONQ1vvtxVblHyO7UJR4mNQHJR1ba1QK3
    Ggr1Jyj3UauaXC3dRQFcTBIr6ekFucnYo0qSNSk7lLOk7pfW3AXFxCE+oTueiFPA
    ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=B2Rcd5Oq x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=B2Rcd5Oq x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934988AbeCHHBI (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 02:01:08 -0500
Received: from mail-bn3nam01on0119.outbound.protection.outlook.com ([104.47.33.119]:51237
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934929AbeCHE5Q (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 7 Mar 2018 23:57:16 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Erez Shitrit <erezsh@mellanox.com>,
        Leon Romanovsky <leon@kernel.org>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 41/78] IB/ipoib: Avoid memory leak if the SA
 returns a different DGID
Thread-Topic: [PATCH AUTOSEL for 4.15 41/78] IB/ipoib: Avoid memory leak if
 the SA returns a different DGID
Thread-Index: AQHTtpnMM7/qZGL5cEmZ+BXpF5d9iA==
Date: Thu, 8 Mar 2018 04:56:19 +0000
Message-ID: <20180308045525.7662-41-alexander.levin@microsoft.com>
References: <20180308045525.7662-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045525.7662-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1079;7:+M3DoQHEcB3RGW/LNm7gDToclWyDT/5iYb5lM5uSBkv2xtAAdr4PMaZjUG20YA3OkDcTq7/lpoj58oArYcbgT5HwMnvOU+MQHgqZvqUarQCHHcizAXiGGv6xkk8Dj4ms0NFYT5yKYw6v/h9affkr2HzX4uwykCk25SiiB2pAjOq3MEohV6OlpI2iXEiQTlVZFa/q7kffmZlUcDeFMxKh/xI1A/OWI4nyuJCycw2sx0PM+zjckqwx7iQQgIKKsvTU;20:K8hIkPBpAks10d4wLZTN53xXQIcKQHKxIik1o2erThzJUtnn33B2shJF60JpEvU+0kgVHIvWy9+kAxWl1+a/Iux8lnVkIcgCsCDUM+XsKbb4aP2DOpIYGaLOlq9BOWk0sPh1AZ1S9XMqiwEADk9sE41+VtRz37yTgTfRi1eenOU=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c136afe5-c03d-436c-99c2-08d584b10c06
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1079;
x-ms-traffictypediagnostic: DM5PR2101MB1079:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1079B2F66A932CD2266179E4FBDF0@DM5PR2101MB1079.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(3231220)(944501244)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123564045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011);SRVR:DM5PR2101MB1079;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1079;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(39860400002)(39380400002)(396003)(346002)(366004)(189003)(199004)(36756003)(107886003)(4326008)(97736004)(2906002)(2950100002)(1076002)(6666003)(105586002)(7736002)(186003)(3660700001)(5660300001)(106356001)(305945005)(6512007)(3280700002)(25786009)(14454004)(86362001)(86612001)(81156014)(10090500001)(76176011)(26005)(99286004)(66066001)(102836004)(110136005)(81166006)(72206003)(54906003)(5250100002)(478600001)(59450400001)(10290500003)(6116002)(2501003)(8936002)(68736007)(53936002)(6506007)(6486002)(8676002)(6436002)(3846002)(22452003)(316002)(2900100001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1079;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: BUJrC5ve2VdvbQrLIBJQkWcBNUPABfjAxc1yFQpbKMR2iAhsyLEdkHwcdtvFgv1EdYI4PB+kStO14ZTJkOl3Cgf7ut1C31fKDjR0AgThUtYzznUtOhbg6YHjBd4Pac0LDw58Ro2VzlB5a08XUW1Wby5g+RxopBTdJfVL3a/OjJh1gUrkBkILI2RX3qpSZGg8QcMvaju19JurAsWrAZdHpEMpH4vkbNJ3A87FkfvgNDQgqTAxxd5uK1zGNGux3suGcViY+CR5NVGc7s9Vg2xG5TMJk+3oDgRbperBQ1w7Le2clICQHM/Lp8kYMXioigk0fX1r/STts/J9vnFUHmDsJw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c136afe5-c03d-436c-99c2-08d584b10c06
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:56:19.5225
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1079
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Erez Shitrit <erezsh@mellanox.com>

[ Upstream commit 439000892ee17a9c92f1e4297818790ef8bb4ced ]

The ipoib path database is organized around DGIDs from the LLADDR, but the
SA is free to return a different GID when asked for path. This causes a
bug because the SA's modified DGID is copied into the database key, even
though it is no longer the correct lookup key, causing a memory leak and
other malfunctions.

Ensure the database key does not change after the SA query completes.

Demonstration of the bug is as  follows
ipoib wants to send to GID fe80:0000:0000:0000:0002:c903:00ef:5ee2, it
creates new record in the DB with that gid as a key, and issues a new
request to the SM.
Now, the SM from some reason returns path-record with other SGID (for
example, 2001:0000:0000:0000:0002:c903:00ef:5ee2 that contains the local
subnet prefix) now ipoib will overwrite the current entry with the new
one, and if new request to the original GID arrives ipoib  will not find
it in the DB (was overwritten) and will create new record that in its
turn will also be overwritten by the response from the SM, and so on
till the driver eats all the device memory.

Signed-off-by: Erez Shitrit <erezsh@mellanox.com>
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/infiniband/ulp/ipoib/ipoib_main.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/infiniband/ulp/ipoib/ipoib_main.c b/drivers/infiniband=
/ulp/ipoib/ipoib_main.c
index c35c28015f8e..160c5d9bca4c 100644
--- a/drivers/infiniband/ulp/ipoib/ipoib_main.c
+++ b/drivers/infiniband/ulp/ipoib/ipoib_main.c
@@ -775,6 +775,22 @@ static void path_rec_completion(int status,
 	spin_lock_irqsave(&priv->lock, flags);
=20
 	if (!IS_ERR_OR_NULL(ah)) {
+		/*
+		 * pathrec.dgid is used as the database key from the LLADDR,
+		 * it must remain unchanged even if the SA returns a different
+		 * GID to use in the AH.
+		 */
+		if (memcmp(pathrec->dgid.raw, path->pathrec.dgid.raw,
+			   sizeof(union ib_gid))) {
+			ipoib_dbg(
+				priv,
+				"%s got PathRec for gid %pI6 while asked for %pI6\n",
+				dev->name, pathrec->dgid.raw,
+				path->pathrec.dgid.raw);
+			memcpy(pathrec->dgid.raw, path->pathrec.dgid.raw,
+			       sizeof(union ib_gid));
+		}
+
 		path->pathrec =3D *pathrec;
=20
 		old_ah   =3D path->ah;
--=20
2.14.1
