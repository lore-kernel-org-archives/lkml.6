Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3827995-1521496148-2-14467303087473065747
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
    t=1521496147; b=E8XgYlg0HCTiwxsnURfKRwK0rlW5kBgqktHFM2jjwLfLiOK
    Wovcd4et6MFjjBDfyUMXosD5wBpUUqSO58UQwGcPJ0UB/xU4s36bnKu4/J+3+pim
    Gl9btVp5oIlMmXHw07qMftKE7o4qzS6ASibRvJF2ewXkpCG48WE2RhDKPIWhQp3q
    QpGkI7ti9EqdjKW90CFUaUvUCqDAW64I3IB+XPwLVyY0t2tN6kdYRkVxomE1RGIJ
    pl2ezoaw6vYYVtMIgpBR9pWgP3wwo+oF/hIIeJ6oQd3PV6c9Ili4Qr8ISM6I5cd/
    f6pPV47p0+PspQwXD4GVHAepeUqtyOzVl0AsRnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521496147; bh=Gyybn4
    Mr7HOIbjz8uaP25zQnhhUrpt5D6X0JJ9N0td0=; b=NiwBFEkev7nkK6x32P86do
    Jc5RyZ/j48+ap6u1N/HisX4YILsMwbDfvQg96sSygBClpgxjcOd3m63U0rAqPgAh
    DqOLFlRpZ3kBbDMVg4V3wNVQwtk6prxeumgNZZ0jMpzlLqlDM8pObS3acXlTp7d8
    lhVkm0+4PN7cFYLuP8atd3dLk1VHrZNebFO4i0iI9S8e66avMEEbjbJUjT3N1E4w
    tLmkoAOca0GKMl3wQXe4tXPB7U/Skhdmbs/hdAF48BjHO9mY+xkD72sSWLZfPaLM
    2AMLATJFVuJ9iXzxmtkG6nlIZtv6GvhWrSsz/Thtf51haw7AE9lq9VH9fEG06+tA
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=oPRc4F+2 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduheegucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeektddvheenucevlhhushhtvghrufhiiigvpedt;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=oPRc4F+2 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduheegucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeektddvheenucevlhhushhtvghrufhiiigvpedt;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964916AbeCSP6K (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 11:58:10 -0400
Received: from mail-co1nam03on0117.outbound.protection.outlook.com ([104.47.40.117]:30064
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S964890AbeCSP6G (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 11:58:06 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Amir Goldstein <amir73il@gmail.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 007/281] ovl: persistent inode numbers for
 upper hardlinks
Thread-Topic: [PATCH AUTOSEL for 4.9 007/281] ovl: persistent inode numbers
 for upper hardlinks
Thread-Index: AQHTv5sMxQ6J5iymHEOiE0C0BfEgSQ==
Date: Mon, 19 Mar 2018 15:57:57 +0000
Message-ID: <20180319155742.13731-7-alexander.levin@microsoft.com>
References: <20180319155742.13731-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155742.13731-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0933;7:OQBVNDwvmzkWhZZA1vKk/QDZ6DYZ3vrIQTi8901YQMR5evCebfZrh2Q2hz8D3cMfzu3DftU9h9xPwR0h4PFXSTgo19Xxzh2Stqw2zHPvOsc6Xl10Nm9FNLfjrF5WQYm1MA/BIXQvuSYiDs2z0ptXWTyhuokE0VVcHt3mxKHtygGXCkpN6H+3wpuN1+j8dqSnl0kCzH/NrHtEt9k6/5beKI1btMGRpwrUj1PiuyuYC7BkaAjM3ovIJ5HfPOCQR9JK;20:+VbUc9/UmS6Dg2JJoUb2uoguM2YVHbxem/3wh/Njse8QVlsDQPUq6juT1K59wliO+RAiUv7BhgmpZmapm7Y/T4Li4ehlMWTxh3Te8m4t8jSx9YYfgCjAB/e5zDoKcR8mHn6ujIOGVp/7bdTIAgcLJpZd4NxJEfYuzmM8x4WlI+Y=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 389f4d8c-24b9-4de2-d1de-08d58db22f3f
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0933;
x-ms-traffictypediagnostic: DM5PR2101MB0933:
x-microsoft-antispam-prvs: <DM5PR2101MB093361C17A21F211023FB1E6FBD40@DM5PR2101MB0933.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231221)(944501300)(52105095)(6055026)(61426038)(61427038)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB0933;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0933;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(396003)(39380400002)(366004)(346002)(376002)(199004)(189003)(2501003)(72206003)(1076002)(66066001)(10290500003)(99286004)(10090500001)(7736002)(14454004)(6116002)(5660300001)(2906002)(97736004)(6346003)(102836004)(22452003)(86612001)(3660700001)(186003)(2900100001)(25786009)(478600001)(5250100002)(26005)(39060400002)(6486002)(6436002)(81156014)(81166006)(36756003)(4326008)(86362001)(76176011)(6512007)(8936002)(106356001)(3846002)(53936002)(105586002)(3280700002)(305945005)(68736007)(110136005)(2950100002)(54906003)(8676002)(107886003)(316002)(6506007)(59450400001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0933;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: IYHrt9kAkVJj8MLvHIasJB0wWoPa0myujeolcKk8fvoPE+soAYNz5W+YRwSomBQkNU0lNA/SZTAjZIl/n2jP1BCBp8fwDHOLj2jenwIkUEp9WdrmNiEdGhlpHECzEKSNgapnB9HAtaCIV+9x7CXIumO2jIf+XS9F7GksJe+aIRpe/BpvSN/hDQE7cVdP5gRAg7DI5ES13/UvWjsD9S3wTFDs//oXd8gSy1Wj936e6DxHgi9WSqU500TpQdwamRWHDRYVuXjbvk++I0AFf5mTiQG6vvIOLBHNW8BZ2INk/EYwAqJMXLSp53HdSnBjQOhaSPBvZzs73E9qdpJn7HVHiw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 389f4d8c-24b9-4de2-d1de-08d58db22f3f
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:57:57.7478
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0933
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Amir Goldstein <amir73il@gmail.com>

[ Upstream commit 5b6c9053fb38a66fd5c6177fcf5022b24767811a ]

An upper type non directory dentry that is a copy up target
should have a reference to its lower copy up origin.

There are three ways for an upper type dentry to be instantiated:
1. A lower type dentry that is being copied up
2. An entry that is found in upper dir by ovl_lookup()
3. A negative dentry is hardlinked to an upper type dentry

In the first case, the lower reference is set before copy up.
In the second case, the lower reference is found by ovl_lookup().
In the last case of hardlinked upper dentry, it is not easy to
update the lower reference of the negative dentry.  Instead,
drop the newly hardlinked negative dentry from dcache and let
the next access call ovl_lookup() to find its lower reference.

This makes sure that the inode number reported by stat(2) after
the hardlink is created is the same inode number that will be
reported by stat(2) after mount cycle, which is the inode number
of the lower copy up origin of the hardlink source.

NOTE that this does not fix breaking of lower hardlinks on copy
up, but only fixes the case of lower nlink =3D=3D 1, whose upper copy
up inode is hardlinked in upper dir.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 fs/overlayfs/dir.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
index 306b6c161840..8546384a5fdf 100644
--- a/fs/overlayfs/dir.c
+++ b/fs/overlayfs/dir.c
@@ -180,6 +180,9 @@ static void ovl_instantiate(struct dentry *dentry, stru=
ct inode *inode,
 		inc_nlink(inode);
 	}
 	d_instantiate(dentry, inode);
+	/* Force lookup of new upper hardlink to find its lower */
+	if (hardlink)
+		d_drop(dentry);
 }
=20
 static int ovl_create_upper(struct dentry *dentry, struct inode *inode,
--=20
2.14.1
