Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3891247-1521497726-2-14723593054874459860
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
    t=1521497725; b=BeEXWpm1541Q1w+mf8n3eDNm2xZbQoQmHRPWhSnLzAKABS7
    TZSJXCUhMD4QQZh++r5ZKjIuFPs+bojQXuslJ7mamK3oRzMvNPAHXyHPdVOexBVi
    z1So1enfmj+CYWoH0QYdNTHN4WcJPetCTB4+eOe6d9nxVuBi/gY9Hih+gCNSvejo
    pOPWAg144uIlAbjiCqhuf2kRz3IIUlhsuzOTcPGgOvpAzAxmIFahM/K/VSTRwKY0
    3Hv99rkcH1tyxRANA+8y5Z/zl7eSGBgQ1D3EetiKBofar0kMoHwe9LuWshSaWqwG
    t3lrjWNO6/NwZiXmCcj9UfJGPK1QZuu+UE/vSfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521497725; bh=cnwdbr
    nULd+RLM49JtzZXW0HvuKMDNB+7EpGf8k5Eb4=; b=wVXERb7GSwVIaErYlXxgNM
    z9tnut/dHRiiydEKwnZoXebryzPKt8scwYfHIGo1vnPOlykTuM0/XgPw1lYbg5tD
    tjKZ3o6bowETY2V2JgvEPU3JTequI+OTpNCbpvOY4Z6DBvA/CAUhJ2uAz2mRLTNL
    YiWTL0pBCH5eK6HYmvold5zP4ZZCGT87pQO74XpWT6ijgxD6kGXyptSffo4/JzmW
    Wy5To87T0DjvaFNSOoyYXe8Rr0GsN86fT/oYj6sos/3TIu1LMb3AI+BuBFfy/PlZ
    thyhL1GqXtAZe9bTcOAaqFLkRw5P4NC4T+ccQPGMSNZmRxXHlpE6Bzz1m2APR/ww
    ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=kyuHr+x7 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduheelucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejieehudenucevlhhushhtvghrufhiiigvpeefle;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=kyuHr+x7 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduheelucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejieehudenucevlhhushhtvghrufhiiigvpeefle;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934190AbeCSWPV (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 18:15:21 -0400
Received: from mail-bl2nam02on0123.outbound.protection.outlook.com ([104.47.38.123]:41056
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934029AbeCSPuE (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 11:50:04 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Parav Pandit <parav@mellanox.com>,
        Leon Romanovsky <leon@kernel.org>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 108/124] RDMA/cma: Fix rdma_cm path querying
 for RoCE
Thread-Topic: [PATCH AUTOSEL for 4.15 108/124] RDMA/cma: Fix rdma_cm path
 querying for RoCE
Thread-Index: AQHTv5nMxcZYJiVuY0Wn0BbexGCJaw==
Date: Mon, 19 Mar 2018 15:49:01 +0000
Message-ID: <20180319154645.11350-108-alexander.levin@microsoft.com>
References: <20180319154645.11350-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319154645.11350-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1109;7:5CJ0+KymKqxwWAUFRaAMHFaz37fMm51LuFi15hvcYoW8yeAJT0n37dLahwfswudAHbZuS+0H/dPpDeC9WqYGNqdiVi8QJQuv7gfUH8nzl+iSri2BkWVyQNN+7W6G7fHjtwcdgI/u8zsgXrOipXtNP2szRuKuQUpctnSBq39smXKAobTfAojrLo6fV3RXOFXGImONki5SBpcTcEhS2nBgcYAc7NWHdfbv8aa0Bl3OjAOWJ0ZKrBXQjNzTXQe0xcM0;20:ZyyFJE2oazTtOdLY6ndy8Tn/augvh78XINdhtV3c4PJQ5IBv/b7IEFg5fVR4Mtg5Zw+m8bw/LBgNzzGn4ZXedhR5WY4Ngg2t3aoNl+4UksUe1nDDp7yBvIVF37VClu6BfKQk32Ya5r3dJck8uT82umtXUH7/1wrapWzanDKROJQ=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 302f137e-95d9-4881-5309-08d58db10a30
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1109;
x-ms-traffictypediagnostic: DM5PR2101MB1109:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1109611A196A1072A6692433FBD40@DM5PR2101MB1109.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB1109;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1109;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(366004)(396003)(39860400002)(39380400002)(376002)(346002)(199004)(189003)(81166006)(10290500003)(107886003)(81156014)(106356001)(6506007)(8676002)(3846002)(36756003)(8936002)(97736004)(6116002)(1076002)(102836004)(68736007)(6666003)(3280700002)(2950100002)(3660700001)(478600001)(72206003)(2906002)(14454004)(76176011)(66066001)(6512007)(5250100002)(10090500001)(2501003)(53936002)(6486002)(6436002)(26005)(316002)(22452003)(305945005)(7736002)(4326008)(25786009)(86362001)(86612001)(5660300001)(2900100001)(99286004)(54906003)(186003)(105586002)(110136005)(22906009)(217873001)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1109;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: 0KItQKqpf8zcQMk+j8OsKT68NS1ztnYPdvR/JzM7g8nQFfxB/DwGZbRNznFvPWD8ory8aOZvf/9Z86gZR06/zz5wlnJQUDySYKAIM4+3cYgPjEw/P7JN5VklY6OBU/QTW+mnc+O4GP8IFE9UqJzLXid7tBINW29YsgDDbBWbseXQQCL7Bb+47L4wl9i+73q1eMRimZLQaqn45sBXrdOvkXJ32m9uz78JtnlJUvrSO7Kbe9d1jV8LCwAg3f5v/wPyQ2D20K3EHJEyWTxMFTEwUnx8l+XL6dJCqdJ5d5LIJ4B0IF67aSvMcyYK69gO6hRWHKVsWNFTTYQ/7Ozs7LGLvw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 302f137e-95d9-4881-5309-08d58db10a30
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:49:01.1815
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1109
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Parav Pandit <parav@mellanox.com>

[ Upstream commit 89838118a515847d3e5c904d2e022779a7173bec ]

The 'if' logic in ucma_query_path was broken with OPA was introduced
and started to treat RoCE paths as as OPA paths. Invert the logic
of the 'if' so only OPA paths are treated as OPA paths.

Otherwise the path records returned to rdma_cma users are mangled
when in RoCE mode.

Fixes: 57520751445b ("IB/SA: Add OPA path record type")
Signed-off-by: Parav Pandit <parav@mellanox.com>
Reviewed-by: Mark Bloch <markb@mellanox.com>
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/infiniband/core/ucma.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/core/ucma.c b/drivers/infiniband/core/ucma.=
c
index c8b3a45e9edc..25c100ee7d93 100644
--- a/drivers/infiniband/core/ucma.c
+++ b/drivers/infiniband/core/ucma.c
@@ -904,13 +904,14 @@ static ssize_t ucma_query_path(struct ucma_context *c=
tx,
=20
 		resp->path_data[i].flags =3D IB_PATH_GMP | IB_PATH_PRIMARY |
 					   IB_PATH_BIDIRECTIONAL;
-		if (rec->rec_type =3D=3D SA_PATH_REC_TYPE_IB) {
-			ib_sa_pack_path(rec, &resp->path_data[i].path_rec);
-		} else {
+		if (rec->rec_type =3D=3D SA_PATH_REC_TYPE_OPA) {
 			struct sa_path_rec ib;
=20
 			sa_convert_path_opa_to_ib(&ib, rec);
 			ib_sa_pack_path(&ib, &resp->path_data[i].path_rec);
+
+		} else {
+			ib_sa_pack_path(rec, &resp->path_data[i].path_rec);
 		}
 	}
=20
--=20
2.14.1
