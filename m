Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3205673-1521475017-2-6265516541670650588
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
    t=1521475016; b=sRoxDA7+LsW3xcAyVTUiLz43h5FTQrPmGCBqQcSwsWg76nL
    FP0T1y0VkeEpUVFfRmjQAkr50u/SwyqKCvhXF+0OohwYXT257XPL+BiDkKzLo1er
    VKs0xfE5F6ijQNXjbF9s43sK8jehc7uSNGwwW/dSPi+RQmUNO2I3gaAtZnVFpSG5
    FdlWRFB1q7+h4Fk4gdU+QZv0wwxkH7GIeS1nRj22iMemoGTM9aM+ANI84MPMvJLI
    TbC9nEZ2ddEwjmr7vdhQAmU7Vvsz/yrizb5qF2aLG2qT9jMNYoMZ5LSAlPqOAsFV
    brOn77E55ORUtjFbk7WL4n5MYIliolpZ6cSaptA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521475016; bh=cnwdbr
    nULd+RLM49JtzZXW0HvuKMDNB+7EpGf8k5Eb4=; b=X5s4P1Xx6IU4DhI9Sp3t7+
    hLBZ3DnM23qDJ+8htw5FIloLfvxTOPYOuRFy5A0PwEymOByJ7hkUg37Q+xB9dla7
    TsRGV+AAg+XLCmxSZIR1jA+m6ynZTfKea8NLp6XiDhhpl4/QSPHHTeb9JBpW/GWg
    egc5yohcgKqFVtmQAGyuMMf/pEvNj9pA91HTSmxzsW+9VdIhItsfmP3rxmwcwCU1
    RE8ALNL5v2qAR5V8V1T+EBnWhnR09BqRkrUAzhEdKnziS75JHX4cqX2ea9tyU9LS
    Ws2ESox5FngDD2o9Ps53Ejbi3LEw2tk1czRG2jj/E8lG3AghCxb2raLRh/e2txCw
    ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=PjahdyK/ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdekvdculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepjeehleehnecuvehluhhsthgvrhfuihiivgepgedv;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=PjahdyK/ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdekvdculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepjeehleehnecuvehluhhsthgvrhfuihiivgepgedv;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934023AbeCSP4y (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 11:56:54 -0400
Received: from mail-sn1nam01on0113.outbound.protection.outlook.com ([104.47.32.113]:22624
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934589AbeCSP4o (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 11:56:44 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Parav Pandit <parav@mellanox.com>,
        Leon Romanovsky <leon@kernel.org>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 81/97] RDMA/cma: Fix rdma_cm path querying
 for RoCE
Thread-Topic: [PATCH AUTOSEL for 4.14 81/97] RDMA/cma: Fix rdma_cm path
 querying for RoCE
Thread-Index: AQHTv5rRkyz+bk3n90uarOlrBnMMHw==
Date: Mon, 19 Mar 2018 15:56:18 +0000
Message-ID: <20180319155411.12348-81-alexander.levin@microsoft.com>
References: <20180319155411.12348-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155411.12348-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1064;7:gxwj064nlsSfGBM3+xJU0K0UTA9ZbGKaUOYp6RnNKMsLUWEtxsdJsyieXkrKgxhZV2Er8IoLZ0139GqUymiYnIeEqJvGXxpXfhjaQVxbNPsaINJMwf089vXb5pr4rqgaKTVb2wkXxiOL56k5zB0EfHWhqsFYz4ghbyHdY5KZf+7YcjQqNCLfSaOkw/rgsPCr0DapqugZOBWIB1t/vje8i7UCE2rKNldeWrmB7Uaec0uefJbcLrsR+P1xOHgMKF3c;20:Ww/gIHcRTaNAOO2JiOKqXsn4J8W7jtRE6GCOYfRIXnxO128dUZ787+4GcOs3+yHGeSPS73+67kwxA/Kag0vWNHtHibHJUdwpiH2+Ywc8LUf18maYD4vYAttuIJTfg0iCUPcFwlZ/9Zn0wteAkBXKmhciZOwj60zbcZrRvP+9t+w=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 18e71f99-fc97-42c3-cf5a-08d58db20161
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1064;
x-ms-traffictypediagnostic: DM5PR2101MB1064:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1064BF7156A59D9254FB5F78FBD40@DM5PR2101MB1064.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB1064;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1064;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(366004)(39380400002)(376002)(346002)(199004)(189003)(1076002)(106356001)(316002)(36756003)(76176011)(8936002)(81156014)(81166006)(22452003)(8676002)(3660700001)(2906002)(2900100001)(97736004)(305945005)(7736002)(53936002)(3280700002)(5660300001)(99286004)(107886003)(2501003)(5250100002)(6666003)(2950100002)(10290500003)(25786009)(72206003)(3846002)(478600001)(54906003)(6116002)(4326008)(105586002)(14454004)(110136005)(6512007)(6506007)(10090500001)(102836004)(66066001)(68736007)(186003)(86612001)(6486002)(26005)(6436002)(86362001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1064;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: SQWPsV+kpBlDJ97xm3mxxjQryUkQToUQRYnVAMkhvxlXfel2AGa2NYnsZLXWSkfm+j56C59dOuibpSesvSvvtEkJOyPC+iJiGJ9iFLsmRRD52Sf4eLIrahHQ9vH4qWV/73lqvCT+dqvY4kXOksadRubjw0SsB0R7NSo/ar+4BrLGDcnjzoic9/7p5rAtz36m+FJY5VrhoXStYJSS2BSkXo64oJSG5nEg3kcZDzx2tkGlP5CSz7KFu8hRqWCm+A47BTyGdLsUK6Bk+s0nKOSGKaQ8CiXeqQYbzCUvpPKhubWDQ5C7yd9v+vsFvNLBAW8yQHidTJBreUZbxPZ1amNcHQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18e71f99-fc97-42c3-cf5a-08d58db20161
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:56:18.1707
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1064
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
