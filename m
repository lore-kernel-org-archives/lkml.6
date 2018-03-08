Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1025811-1520488295-2-13127723507293336636
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
    t=1520488294; b=KQQsNohphSEyZBCOF7YR3eBqiz3lFcFVxgcmK1DxXxBYycd
    xEf0gExFq0v9Fvmvj7OdG8OTVw7TkKAlyQIUC3lhj3LY6+zMidUyHawsNQ/6U8JA
    MBiIxZ+Oh6/dozkA0v0dEtkmX79YmNHSEWvBXHVd2g03UGtVO0bK73s5j/UgjNCd
    tNDL62Gg2a3hVKPgPr8vO9C8DYJ2R9TTx6oRbo5yP9GRBBcf6uQaME0BCNLT62LP
    vBRxsHhjTnWkx6/odLtBtsukqxbLdh2LPXnClr+8Of8ddIw1v1bojlRYK25ovS/C
    qw2ViHkGz+NECZoP8RnxW5m3aR3Jf5timFFvI6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520488294; bh=5n4vc+
    rCfFQnRl7EWCfL6I9zCf0UlI2Dqyr3FAOWOJo=; b=EfRq52uDEhFlvv8TTFxaKB
    b0QVcZb/kkT/+Oh9/3y/RN7iyNzTtPAB5Uum+URgVEvgUPzKSKjgiqeRIyC4QIjQ
    lTf5ud2iv5WxucP1y4zEg8qrMb2NmBBtNGSIr9gHajNanqFpdfTkngpwqJ5utUA6
    OtFm75yxXPIwCVkQDQRQCvBUFzfqna4UEzO1xK3eykglQUMJyIV9/SyQe1jQG8o6
    aW88IJvd/tylnc8ECLZbfXJdXmNVBt4W9tO5mFmt/KwooCl9Lq6uPfhUK+QE+tS8
    aQDVpuXxBXNllJTcDg+KAarjXppLtgTOveNfBMZGDF7J3Yd3CKTO/daHGfapXrXw
    ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=OZsOO+bn x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=OZsOO+bn x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965680AbeCHFvS (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 00:51:18 -0500
Received: from mail-co1nam03on0138.outbound.protection.outlook.com ([104.47.40.138]:9600
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935308AbeCHFEQ (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:04:16 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Erez Shitrit <erezsh@mellanox.com>,
        Leon Romanovsky <leon@kernel.org>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 171/190] IB/ipoib: Avoid memory leak if the SA
 returns a different DGID
Thread-Topic: [PATCH AUTOSEL for 4.9 171/190] IB/ipoib: Avoid memory leak if
 the SA returns a different DGID
Thread-Index: AQHTtppUSW6FhYKI0UK+wRaVXifRyQ==
Date: Thu, 8 Mar 2018 05:00:08 +0000
Message-ID: <20180308045810.8041-171-alexander.levin@microsoft.com>
References: <20180308045810.8041-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045810.8041-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0919;7:gJs3u3qui9zjEvW9Mv3/Uc3kN0sqIG3zM1q2wBYbmJJmKjNv3s6pUmCHu8twCo4arz5o0IuM0914h9N7k7kS3SQGlbYN58/RqTw0uMsDMYxcXHQ9doz9hEUIFlwxLoMQ7gkJtxw6kXwD0Mpqn4fSBs7mggQ2x8QGDaSXuklJ/47RCx5f/pm1k+XmCrsHZ+7WhrNklK8cjEN1lZNjibRV8wCNlSLuWudkAucutCPeDp0/KdFZfZLSYbimLv1hyrqj;20:9Ma584D2XmhWYvm6U2eWnrCM8+cshsCNtHlJsQIJnApSAiiXXvTgqu5LbQ8HjF/bZ6k4GCxpVPYNH2Vvo3hct95OLTJ20pPPivw/UUf5glsPjCpWwZRB0Ua84MnugC26EG/XcuuowvwbqECzbBUdn5j+DiCkiwNr5fRdr2WmrAM=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3140406e-bdbe-4ebe-2d24-08d584b2098a
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0919;
x-ms-traffictypediagnostic: DM5PR2101MB0919:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB09198A26E0E385375282802EFBDF0@DM5PR2101MB0919.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231220)(944501244)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB0919;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0919;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(396003)(366004)(39380400002)(39860400002)(199004)(189003)(3846002)(305945005)(2501003)(26005)(6116002)(7736002)(186003)(2906002)(316002)(3660700001)(5250100002)(8936002)(4326008)(86362001)(575784001)(76176011)(107886003)(25786009)(5660300001)(10090500001)(66066001)(10290500003)(22452003)(3280700002)(36756003)(86612001)(1076002)(478600001)(68736007)(110136005)(14454004)(54906003)(99286004)(6666003)(2950100002)(106356001)(6512007)(2900100001)(59450400001)(6436002)(6506007)(97736004)(102836004)(53936002)(72206003)(81156014)(6486002)(81166006)(8676002)(105586002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0919;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: nzN4Wu4nXLadhAce32xQRulGjkgR77AKL8GLiK/4gWjpMyuvlsaWPnp+S+3u0I+iq0xb0QpDYDGDeF284S7DODThpC9K3gwzVDfMcCGrTnNa6PBvQ51rWEsOGYWsTOx6emgF2lnw8aIbBZYYtfU7MdgoAVjh3RF6LUiblSVbxMMFmFkviCDGcdBOYrsdYYBF3F/e2vuVllYgXmIt3+iKDuF7RJ52qt27u7K2aYjNxFk1mB1WP0hIIFAlctBHD6XofgeOmlhew3hzo1Z/TrZN0CJGnGYZ/wVoUwHqw97PQrmCNHYOOoIGB/fyd9xg+fYuCsVMHn1zxA6BNkxw2hzYog==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3140406e-bdbe-4ebe-2d24-08d584b2098a
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 05:00:08.2722
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0919
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
index 183db0cd849e..ab31cfd9cafd 100644
--- a/drivers/infiniband/ulp/ipoib/ipoib_main.c
+++ b/drivers/infiniband/ulp/ipoib/ipoib_main.c
@@ -799,6 +799,22 @@ static void path_rec_completion(int status,
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
