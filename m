Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3384037-1521480809-2-13542157306457268685
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
    t=1521480809; b=l8pVyUT6sfXpf3VRCElGixGj/7C2FXplWZlE/6kRsPsMscw
    pSQ5DXfX12LFrxi16gSYoHKnl5LiIUwQk82he9urhLXGyLKXqg3Lc5IDVc3v1luM
    5SpmvWx4oJJDPHSxSC8w4VG2ypVDVTpbvKE1PFrAQxAgBzXBWjZ3zaqZMZBRbxEx
    Q++HFx1q0w2RYVDdoW7ntoPL69a7Qwh2ZWdJ0XrnXB7cUsrri05QN49+9Zja/v/e
    XDSwYtO7imB4LxTHGFj8PmtOxYNfUCVdhtXXyPPoSuQ6D49C3NuKXlPJBWzOPeUl
    MA1nTsif7Iu51rauPZPT/uK4V4A04yXigQlyzng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521480809; bh=APcVnQ
    p4jvXiOZEN4bURoH4pdelmNRR0JcwAiGwkktM=; b=YpmDqGAJLpNh6BOWclIgpT
    R2COCCmLAJniyaoV1MM7m4tP6J8dlAo4Fy+AfJeJ3JN5meLZqup7BH3MYx/lCBnL
    OsoaZMKOmquARTFgpTFnuv5gmPacJBCKxDb9J7tWGuJzstsFMT9QoGyJ4ULJ+XHQ
    ML3Lqw5DBtVnHTyiXhtXVJCjy2cgwC0jk0RNnLK3qzj08xHd4bzJQ1yO2CC2kB4h
    BZ9SngSv0585cLbPUJx7OLkm4mSPRoHopzEluF0GOUcBQY5/SOsxgpjbVXcnoI4v
    JERt0fEgj5IZmQPamQtWh4NXwxLgbWFA1QRp9OG716VsaQSeW0OwPL8Kh2K0WxHA
    ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=bE3wBi/P x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutddvucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejjeekvdenucevlhhushhtvghrufhiiigvpeehfe;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=bE3wBi/P x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutddvucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejjeekvdenucevlhhushhtvghrufhiiigvpeehfe;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966092AbeCSRdF (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 13:33:05 -0400
Received: from mail-co1nam03on0114.outbound.protection.outlook.com ([104.47.40.114]:10656
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965951AbeCSQGz (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:06:55 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Trond Myklebust <trond.myklebust@primarydata.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 019/167] NFSv4.1: Work around a Linux server
 bug...
Thread-Topic: [PATCH AUTOSEL for 4.4 019/167] NFSv4.1: Work around a Linux
 server bug...
Thread-Index: AQHTv5wjjkYAlRmUtkGSws06I+NoXQ==
Date: Mon, 19 Mar 2018 16:05:45 +0000
Message-ID: <20180319160513.16384-19-alexander.levin@microsoft.com>
References: <20180319160513.16384-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319160513.16384-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1093;7:LJQmx6Le/83+0ivs+qnbl05PPRs91MU5p9D2LYmqh8pNJ4IeuR2vh6jOZu1Pu5DZ24Pqofjvm9lIikGcgkQBRFEr5dA0rPbISjN8iz1AcSxfwkbgZAHbs2avttA2YHgXzUsBsIxonhC1VtC69b4tCnNvLd7O7A/NoSaEpUY9aaOtpWYgsnWkalpgMxgExMF+hLg9ZfF23Vaj/HSBiYHp8yxfHmDe1c19mhmWwneWvk+F4KTCvNj9MMWa0vA7We6N;20:DR+FRizS8BP24nTGxI/AYc388ruk1IlVb1W+sCeFJ94GOPBrxxw6EjkhgGaNfpbxTDj1m2IgRIQTeiUjg34OqBmRQXqb8Hup5dOCw2/FrItV3s3WywGeZ/Lyi8gjQauje8dV9pl/K6v+jeN+dJhaI8wY1LvVfjJlZBcPQ78+mKM=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3d2ba16e-a694-4ddb-2880-08d58db36c20
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1093;
x-ms-traffictypediagnostic: DM5PR2101MB1093:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1093D391D372813096E6CF8EFBD40@DM5PR2101MB1093.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(158342451672863)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB1093;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1093;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(39380400002)(366004)(39860400002)(346002)(189003)(199004)(10290500003)(68736007)(478600001)(110136005)(72206003)(36756003)(99286004)(97736004)(10090500001)(305945005)(7736002)(6666003)(76176011)(107886003)(2950100002)(6436002)(86612001)(6486002)(4326008)(54906003)(186003)(3660700001)(25786009)(26005)(2906002)(53936002)(5250100002)(2501003)(81166006)(81156014)(2900100001)(86362001)(5660300001)(8936002)(1076002)(8676002)(3846002)(3280700002)(6116002)(66066001)(316002)(59450400001)(6506007)(14454004)(106356001)(6512007)(22452003)(105586002)(102836004)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1093;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: oYvleQlYdC4BRs3LXfvlzFShFteBjfKXOQP5kitBe+c5BcU4AUKiBXCMgWXw0jZBD4KDYFCLc8cWXO2Keo1T02L7JlzMkydWh8h3q60zp79m64+gD/uHueQY52jwhBX3pMA0un6zXCK6Q+tR38M0/vGcT39dOAv8oXJHmQ/SudY5uIl4vCzvnktjbuegiQdHItw1V7hgCpl/vZE1U3Ma9Gqzqle3fqZTLy8VmHU4eMN6Xq0uRbAg9KqAHNGmKF4VoP6If5YhxvmAPklaibAQyH+Cye1QbAWwKWissysiIHMLztEYlB6s/NOqX1H+N+Xrml7VKK0Aqj3mlFT+Bfnkwg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d2ba16e-a694-4ddb-2880-08d58db36c20
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:05:45.3307
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1093
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Trond Myklebust <trond.myklebust@primarydata.com>

[ Upstream commit f4b23de3dda1536590787c9e5c3d16b8738ab108 ]

It turns out the Linux server has a bug in its implementation of
supattr_exclcreat; it returns the set of all attributes, whether
or not they are supported by minor version 1.
In order to avoid a regression, we therefore apply the supported_attrs
as a mask on top of whatever the server sent us.

Reported-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
Signed-off-by: Trond Myklebust <trond.myklebust@primarydata.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 fs/nfs/nfs4proc.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index bcfddfc7a1f4..0f397e62de5a 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -3025,6 +3025,7 @@ static int _nfs4_server_capabilities(struct nfs_serve=
r *server, struct nfs_fh *f
 		.rpc_resp =3D &res,
 	};
 	int status;
+	int i;
=20
 	bitmask[0] =3D FATTR4_WORD0_SUPPORTED_ATTRS |
 		     FATTR4_WORD0_FH_EXPIRE_TYPE |
@@ -3090,8 +3091,13 @@ static int _nfs4_server_capabilities(struct nfs_serv=
er *server, struct nfs_fh *f
 		server->cache_consistency_bitmask[0] &=3D FATTR4_WORD0_CHANGE|FATTR4_WOR=
D0_SIZE;
 		server->cache_consistency_bitmask[1] &=3D FATTR4_WORD1_TIME_METADATA|FAT=
TR4_WORD1_TIME_MODIFY;
 		server->cache_consistency_bitmask[2] =3D 0;
+
+		/* Avoid a regression due to buggy server */
+		for (i =3D 0; i < ARRAY_SIZE(res.exclcreat_bitmask); i++)
+			res.exclcreat_bitmask[i] &=3D res.attr_bitmask[i];
 		memcpy(server->exclcreat_bitmask, res.exclcreat_bitmask,
 			sizeof(server->exclcreat_bitmask));
+
 		server->acl_bitmask =3D res.acl_bitmask;
 		server->fh_expire_type =3D res.fh_expire_type;
 	}
--=20
2.14.1
