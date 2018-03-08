Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-966195-1520486687-2-13496171868988373543
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
    t=1520486687; b=ttkQSRCU2AS0uopTDcyMeddnkD4XMYnyf3if9UmuumyHPpG
    PngayASU3EvrwiWh3KaCxSGCe9fuz+hkb1pr5rI0z0yj+wkJqgJNqVI2k0IH6vSP
    iXZA62OcItSAEoELnM+ZV0iVFAq9H1d7BTXV+kOYSf+fFWCURuiSjv1h0AZLYb6S
    mwjhTsFJmivYzQKH1kL2Ch3P7KJw58UDV2n61/RjHaqd8IaSQwoW1CgukKYhchzD
    v/EueBka1Kn2vH+z7k1NCqwiNx00MTFBSIdRvOTY5z3AWbooxcWFFZnlKGClYfmB
    2m7gfm9LOYVRVqJf63O5eUspSMl4IJgP0cY48Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520486687; bh=wc3tOS
    WQTNOeHpWsnQ8tBU4K23xbDn2OgUrHqOuOTjk=; b=V9qzJkrmDKBIJs3N1DJ1EP
    6KBpGO5fwjHof0Ptx6V94WQeECTfrzpEc6GhtHTsTRdMoOw+mezVD4RSLZgOuH9L
    gFyrgqpk7923edKhKRCW60X01sG/+bQUyyg6ik3rW7MXGNmAFaQlGSZmRg9sv+El
    mPdS7nR/iAJs73urlLhn+rOgRKgzlmHNnsR9dwIOd5jTJTaRJK8mjhgWHcW4zL81
    eafJKYE9M978QLQNIHe4fPNw+yDkMGHHuHvss7Li+srNEEZh4iauM80rcTRheSY1
    5goJsCV43ssg2V62/UMnLQIG+dsKa5LSx5/xiDgt36erhXA+Cjm3NOFhj48rNdMw
    ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=AuLIwkO9 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=AuLIwkO9 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966276AbeCHFHu (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 00:07:50 -0500
Received: from mail-bn3nam01on0110.outbound.protection.outlook.com ([104.47.33.110]:54752
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966608AbeCHFHX (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:07:23 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Erez Shitrit <erezsh@mellanox.com>,
        Leon Romanovsky <leon@kernel.org>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 088/101] IB/ipoib: Avoid memory leak if the SA
 returns a different DGID
Thread-Topic: [PATCH AUTOSEL for 4.4 088/101] IB/ipoib: Avoid memory leak if
 the SA returns a different DGID
Thread-Index: AQHTtpqek4FLvBHC80yIOxSZU5gw9g==
Date: Thu, 8 Mar 2018 05:02:11 +0000
Message-ID: <20180308050023.8548-88-alexander.levin@microsoft.com>
References: <20180308050023.8548-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308050023.8548-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1077;7:3o/jTpB5j5Zdus599OVNoe1ufZWj7ddx0nFIjlWXR7pA/QJwHxJ/ufUPy3KJ+6+0Tx1qv5aEZYZedLwSvdMKDDyruU0tp4O6jw6R2v+6aOntV71aNVTpjjL+ykI3kpbsJ8pEMHLZi94WUNT6pIOU9gZJM8JQiZBV8G2HW22jEEaHDBNHs1NFHVnI2+d0JZqLuYyDDJorzHGexTcZl83nYLEWPkuEZ9lwNqBm+WDyvVSpFlwiqI96gShqlOPV1b26;20:bElpNa0kJHHFF5v6U8vNwQhnSUettxtrjjZs5Rs+mbb/QyP5ieGZhmYIMF+CTPXCIII6BwhAMNMSe9/4HYSkLa0Qj/QTpBQo2gpQ0sSLccWa6Av9sPCldfT/6LFdIwZz6NMI7z+p8M0aotfvlW4fxb4gReA+L1CkyO9h5e5DCzs=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2c3dd742-0e6f-4de0-a01b-08d584b27699
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1077;
x-ms-traffictypediagnostic: DM5PR2101MB1077:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB10774253763C6854BE5FADD6FBDF0@DM5PR2101MB1077.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231220)(944501244)(52105095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB1077;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1077;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(376002)(346002)(39380400002)(396003)(39860400002)(199004)(189003)(86362001)(102836004)(6506007)(59450400001)(22452003)(2950100002)(186003)(68736007)(26005)(106356001)(105586002)(66066001)(6666003)(86612001)(3846002)(3280700002)(2900100001)(25786009)(53936002)(5660300001)(2906002)(3660700001)(10090500001)(6512007)(1076002)(4326008)(6116002)(305945005)(110136005)(107886003)(54906003)(2501003)(5250100002)(8676002)(8936002)(81156014)(81166006)(14454004)(76176011)(7736002)(72206003)(10290500003)(478600001)(6486002)(6436002)(99286004)(36756003)(97736004)(316002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1077;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: fH89EU3A+D6WDuWHlVaAwV5APstkY52Z0/pEFXgZ89E4wJQB89kuILnJxQgNtNzfdDBI6BzfmodilJyzpIPHkv6F1Zpiudu+LKVGNYxB1oIewMBYK1z67syMxM/tCdP4qN77jqDwtAxjv5tJcXioMokfOHgx/c2+iZ+6xNP/VCckJnm4fQgatMl0SRBsb6DWEKzProeT/Mc+BqY60NgWs/uQC1MCdlXjot4SH77BkOnUumDqwVmT6eSSJYWh6VavJTXhF4wyiUgxo7IQLYMS4BO5e4PVaxGIC4br5eoQoTkSUmxT6DGy5Yawur5RJXWADmx1iVB91PsbZTxfZINYAQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c3dd742-0e6f-4de0-a01b-08d584b27699
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 05:02:11.8216
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1077
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
index bad76eed06b3..f34aaef07fea 100644
--- a/drivers/infiniband/ulp/ipoib/ipoib_main.c
+++ b/drivers/infiniband/ulp/ipoib/ipoib_main.c
@@ -724,6 +724,22 @@ static void path_rec_completion(int status,
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
