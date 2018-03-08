Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1131037-1520491445-2-12824558125841448595
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
    t=1520491444; b=T3ppGLYmVqdsCCbV5zIZ6jRFaUZcaQDZo2RL8xt/BDT6RU2
    lmuZInK4mfMyeZ7KjAgyxMu+0ji7J2BN6ohub7F6VFnunqofGtpiQ1MqrX0T14lQ
    xlX19r5xc2UdreOyFtfFZB5KX4gHrj/u+5k0iI+e50K5ERd1mNW1XqSpZW7rImdF
    0WfNJpmH5QaubevY42KR4BcX3Ixw+m38/Q2UnyeEB4VIAhhml+PnFBDW6aUkTRyl
    tMP/hZY0Fpf4Pzps9l8blYZejuaDIbDqQnyQN4pI5ipBvTCYHQ8+TIXl17B5cj8q
    TwDjihgcd/bTfbD6w12biT745Vnv8kGOq7P4QDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520491444; bh=ZDsPA8
    MFOqQMPTtrH+tyb6h1t34qhwuthoeUxMNNbcQ=; b=aRW68MXFxPBsMD8ol07atF
    M5NnBdE4NQeUxQ//e88KOZgndLItDlPTI9s87LDCU25QIiiHkrps3TotWgEVi+dv
    k37gqDk5oJD+DTQga+8IL8uMxBacSRGCdZP1s2bbhhcWdAbud1jXK+VN/E/9nM9D
    kwOzmmPAf/+Z0FCJnyX6bH+cW5Y2d4dP1IGO4D5XdY0wv5agqPXVnq/pHyXGTWbV
    7qRmErdD9KViLeGDnWEWtQoWbNn0aA70fFQTbU1nf9z6BcP8D82/ieMcrbfTE+nm
    Z4/7pA7OuXxpEgzt4TMdY0JIjyyqoTKEfCPVmC4oqvhtW8Zmk7yQ1HppaEc9TbEg
    ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=c95ui//S x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=c95ui//S x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751588AbeCHGne (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 01:43:34 -0500
Received: from mail-sn1nam01on0102.outbound.protection.outlook.com ([104.47.32.102]:61147
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965225AbeCHE66 (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 7 Mar 2018 23:58:58 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Erez Shitrit <erezsh@mellanox.com>,
        Leon Romanovsky <leon@kernel.org>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 36/67] IB/ipoib: Avoid memory leak if the SA
 returns a different DGID
Thread-Topic: [PATCH AUTOSEL for 4.14 36/67] IB/ipoib: Avoid memory leak if
 the SA returns a different DGID
Thread-Index: AQHTtpoACoC/5KiOg0e+RWWe8okAZw==
Date: Thu, 8 Mar 2018 04:57:47 +0000
Message-ID: <20180308045641.7814-36-alexander.levin@microsoft.com>
References: <20180308045641.7814-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045641.7814-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1015;7:VeL7jM7Yx/EGraKoTzxXVqdIvcRyDnxKmwO3yyF9s+Gi/lCDl3GMXUOrj8S/FUJy9DM8mMtTIieEbep9cEwlTEG7LNTIOrch9izxlJW5cc3APVuprjedksOwZdQp0tdkoZ3LXOJL8zXjLSEbnofxIQ0qK8ad5+sWLuZCeRr1iodQmRrlH2qgPGf0+svnS+hehdYbR08IXZ/oCgNyS+LxKEH2/qo8/2ZwVPHEuYEJ72aKOjlePadgnsNXQ1Hk23ca;20:iLGCJiY4wZep/QKWZRrKWg1yWhZT0NoVKw1lxJ0y3R0EgDCz06xkoz/jEkPTg6GrCqlar5X0M84uT4lWiqDhDRER2Qy17DhO47Ak2M3g6QVwXQks/ggzfGNtPVh3uCIO7LlMgIlnrgb0josGEtjDTsWQJ3RzXWrsYOKd4qjU1f8=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b5488110-0aa0-4421-c322-08d584b14b8c
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1015;
x-ms-traffictypediagnostic: DM5PR2101MB1015:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB101575A783197D14421BF653FBDF0@DM5PR2101MB1015.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231220)(944501244)(52105095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB1015;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1015;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(366004)(39860400002)(39380400002)(346002)(189003)(199004)(6116002)(53936002)(1076002)(107886003)(3846002)(3660700001)(10090500001)(6666003)(2950100002)(2906002)(6512007)(99286004)(8936002)(6486002)(76176011)(6506007)(68736007)(59450400001)(316002)(110136005)(81156014)(81166006)(8676002)(54906003)(3280700002)(2900100001)(6436002)(97736004)(72206003)(25786009)(10290500003)(86612001)(4326008)(305945005)(7736002)(66066001)(22452003)(478600001)(5660300001)(86362001)(14454004)(106356001)(36756003)(102836004)(5250100002)(105586002)(26005)(2501003)(186003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1015;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: JQ8X9Uzp39jiD5oIu1P7dWeRRGvmVfaDsgqen09ErqXqYKuMJowwsRJ9JpJFbFU7+/Rj+FKGBAE0UFTonFVt4HoQfbIumJf2ujitGTviS4+31lovSDZn8Mg+W8g1/RMDm+K5yoqVkXf1BNC39xnVxYKjBr8x8pTwzNwkKlAyURPHupqwHCfWpX+6vb6tEltQdZhFykFh2zpSe0uBkkBHZSlwFXBg4/48vqnQSBvLgtgOMrGdBdyKgGiFUzVgOvlWe4hS49Qw4LcVLj2Ll/gp94YWhXNfYT3kMoiQ5QLlnPdsd3vPdXHHfD3QEeD9IDzYrnkSZsk87V9NHkfTvv0WoQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5488110-0aa0-4421-c322-08d584b14b8c
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:57:47.3198
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1015
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
index dcc77014018d..a47a7944d650 100644
--- a/drivers/infiniband/ulp/ipoib/ipoib_main.c
+++ b/drivers/infiniband/ulp/ipoib/ipoib_main.c
@@ -776,6 +776,22 @@ static void path_rec_completion(int status,
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
