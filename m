Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3907919-1521498955-2-14626036210055820859
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES ensvda, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521498955; b=ZTVk7DWi0GuIzQTtV4x3dLOxfS6roeqiOQITvWrySdgBL4n
    voUbX9pnVD39dGdHfHrQuIC+icgO6N6LVfSa5esSiZ+IaejONH5n1nN0Ye5UF7g2
    dJUT8owXi91d1Bj6eY9w7+0YVmsmAYPtMgUzSPdJEC5jd7pZD1i+E7XEwDwNOx+I
    5KcnSdUFz/mhSDrUom28R+pVLbZA4XSfLjLUYTdLx1HPEtkpYZtJqpyBLhqHMaSm
    OhmfiDnQjp83SljTvYW4SqiEpBr0lXby6hoCTtQtvwK8ym5myLCtKelq/njk67Ea
    gS4gEIjr30v55KkRuNSP9BZXuIBAdHc/ouL6QYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521498955; bh=9OxTur
    e3RU6qcavdy3MH6JVkU9TjDHKiRj6zIDTsh8Y=; b=c6Ut2GgtFPZTJdC+kbblKd
    CWq4iBBeTVFn8zdgasS9i0QAuDomH3NPvHMxsxCO8rD9rU9H91klFGxEYwgBNKa/
    IV1g0hWBE0kiJWh4+k2GgO/9eFJnrwwgO1FnBacvlTmIDUZBwjjzcCb9f+vHv7gh
    h0HVE9ZOoqUryOlnU6E630lwcgi9Zov90XpWVRrlbRo11rZ2s8RftEKGxdBuibnb
    nZKI+1ZyaC6W2inzOiO+RIggDghdmfBco0ppnCpwc4xxuwcKogZkN4avohW+A/d5
    jmXp2MNmyUg38zVq0BYx/jms64/eShg7E80tC5z4fkwYI/F4Eb/j19ztXBjun7WA
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=guir5MjJ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduieegucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejtdefgeenucevlhhushhtvghrufhiiigvpedvvd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=guir5MjJ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduieegucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejtdefgeenucevlhhushhtvghrufhiiigvpedvvd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S972485AbeCSWc0 (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 18:32:26 -0400
Received: from mail-by2nam01on0119.outbound.protection.outlook.com ([104.47.34.119]:13392
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933710AbeCSPsD (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 11:48:03 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Leon Romanovsky <leonro@mellanox.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 031/124] RDMA/cma: Mark end of CMA ID
 messages
Thread-Topic: [PATCH AUTOSEL for 4.15 031/124] RDMA/cma: Mark end of CMA ID
 messages
Thread-Index: AQHTv5mWT1Bx/CuM7UWXcGlu5zoV1A==
Date: Mon, 19 Mar 2018 15:47:30 +0000
Message-ID: <20180319154645.11350-31-alexander.levin@microsoft.com>
References: <20180319154645.11350-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319154645.11350-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1030;7:ZtPlF4hl2X4BMTyB1utiKguBL7ZQC5HhgSeOE/4w9iDXYfTuaHT80rf77i2Xzv8eM8jSAGlXIYyx594IhuvCpGX+00AqqMj1F44h8lGjZNYl4IBRuIj6ZBoJyY81j1CzugKPQPG7Tf2M6TEsogAPIjO8pkOqGyFFmf3dGKcI3v0oW9hXrTmgcxNt+lRucOi2NSIqKwenZlDhA/0ceIZ0jvl75UFgMDzTc3ZJTSW0Kz19FfpXAwkaFFSRGmDiap3p;20:PuBJ5R93HjKUwGCDCsHCMMhPyxIs1ETglCwprD9ottDMIh09h8zN/ZVSFAtml1rph8nr/e08aXgnfnF464gSBX9MKUGrinolONBELU7j8EKh2g3ZPLgeEI7jnDIdVfWiEcutb0FDb14cLI5pgvxz4u1PBxva8VOSF7YTeRuy6D0=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7b502628-7455-4495-4cb2-08d58db0cbed
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1030;
x-ms-traffictypediagnostic: DM5PR2101MB1030:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB10304FDE030F5C460CE914B6FBD40@DM5PR2101MB1030.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231221)(944501300)(52105095)(3002001)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB1030;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1030;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(396003)(39380400002)(366004)(346002)(376002)(199004)(189003)(2501003)(6486002)(5250100002)(478600001)(86612001)(102836004)(1076002)(97736004)(575784001)(99286004)(72206003)(6436002)(2906002)(107886003)(66066001)(10090500001)(81166006)(6116002)(81156014)(305945005)(8676002)(86362001)(7736002)(68736007)(54906003)(110136005)(26005)(3846002)(105586002)(3280700002)(316002)(53936002)(8936002)(186003)(76176011)(2900100001)(6506007)(36756003)(10290500003)(2950100002)(22452003)(25786009)(5660300001)(106356001)(3660700001)(15650500001)(4326008)(14454004)(6512007)(6666003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1030;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: q+jphdOMYZWFNkdDqGB47ufnngJfJgpvl3poXVr4XKKMiZnx+Y8ZTZyIlzgJAZEftbN0zVw+O81YQo9UKJcFa8oIP/IxavD3QbRcWP/B95CMGlZTslFDwnAPEfoDbcvko+tPC6tNP39eEwcoas0pd/dYVUeTXsSfAEx/jHeAeAUvQrsOR8eFZfiMlrkzKkqppcnXIcK3ZrTxNhyShr13rKf34cAJ6pZ8tMTzWIpAAuUnYqcclA1E5VzM6T9M96wYBnPGy0m2iJi5SwxCmscr30HQM7VD1VA2G4fXCa+Jpcr4mCu76uD5fTycR839Z8AA14LirmCF22k/yi70+8MzDg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b502628-7455-4495-4cb2-08d58db0cbed
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:47:30.9544
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1030
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Leon Romanovsky <leonro@mellanox.com>

[ Upstream commit e48e5e198fb6ec77c91047a694022f0fefa45292 ]

The commit 1a1c116f3dcf ("RDMA/netlink: Simplify the put_msg and put_attr")
removes nlmsg_len calculation in ibnl_put_attr causing netlink messages and
caused to miss source and destination addresses.

Fixes: 1a1c116f3dcf ("RDMA/netlink: Simplify the put_msg and put_attr")
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/infiniband/core/cma.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
index 6294a7001d33..9db13a00c3d9 100644
--- a/drivers/infiniband/core/cma.c
+++ b/drivers/infiniband/core/cma.c
@@ -4444,6 +4444,7 @@ static int cma_get_id_stats(struct sk_buff *skb, stru=
ct netlink_callback *cb)
 			id_stats->qp_type	=3D id->qp_type;
=20
 			i_id++;
+			nlmsg_end(skb, nlh);
 		}
=20
 		cb->args[1] =3D 0;
--=20
2.14.1
