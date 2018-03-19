Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3114250-1521474454-2-2858197554312445490
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: AXB_X_FF_SEZ_S 3.299, BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521474453; b=ZkSsiYFa863bcLbWxJA8LUopmAZIIRGP6P5Jwwdw99sM7Ww
    4HwKWbACAgJ1cEslBBBOxZXg0IVFUmqrTVR6WFGY1GI2kBAXGJbvau/OyNC7GxKj
    YOSPDKAVEW3gPfA6wzv7bdxVQFXol+eq/OEEp17tEVcM+0BfN7CXtSzoBSJC4TxK
    SO8c2v42F3ctgs6OJ+LqWJVrzqGhHxwliyb69xPeLQ3DAPW9JwJwh2kcaOWFePyf
    ZrhYEX/ExX7FTe3H07mp30xkxUCOwSRYbCPAqf3ElNiHp0OsHyPDvx9r+L+++0SW
    rqGvkvYhR/ykEwZ//AKnsBs989KMqO3nhmNwQwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521474453; bh=LmlgI3
    ERoHForxhvXBQpNWCB0MpPjg4boE1bVbTI0Y4=; b=UpTBEfeWExJAjLGZrsuHbW
    mLiQuOV3TjaucizhU+JUtGGGUS6wAzP4VzZANB+Q1hQ+Ceojo7qlBnxn4O0bBI05
    OsTVi3x3ANDZESrTBsxCDbaxpaulIM1cxxH6RinncFkGWAoCe+5eWjkx9oKX20Y4
    xbykUetQw4UGkNzqArjslXOkQ96QOoan8aHnnJRWtbGDqWWBGcP2sMr4Zr7WTDiP
    3JNjwuF/CtHE8l5kwYGJQZp7zdTx0QJ20N5/cOSOryIZnMH8MsEcI/w4dXqwH3Bw
    54qfo1n/zwpBi3HZ4Ocq7wH9Gd0uDatB2jy6mE6vAyCC8gaEwCgyAh0fIBHO1Rkg
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=j/xwVT9g x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdejleculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepjeeltdehnecuvehluhhsthgvrhfuihiivgepie;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=j/xwVT9g x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdejleculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepjeeltdehnecuvehluhhsthgvrhfuihiivgepie;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933422AbeCSPrb (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 11:47:31 -0400
Received: from mail-by2nam01hn0237.outbound.protection.outlook.com ([104.47.34.237]:14336
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933323AbeCSPr1 (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 11:47:27 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Maor Gottlieb <maorg@mellanox.com>,
        Leon Romanovsky <leon@kernel.org>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 020/124] IB/mlx5: Report inner RSS capability
Thread-Topic: [PATCH AUTOSEL for 4.15 020/124] IB/mlx5: Report inner RSS
 capability
Thread-Index: AQHTv5mQOJjLs4CsOUSBkfw8fuF7Ag==
Date: Mon, 19 Mar 2018 15:47:19 +0000
Message-ID: <20180319154645.11350-20-alexander.levin@microsoft.com>
References: <20180319154645.11350-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319154645.11350-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0728;7:QmQnGA16CdZJWoy6U/wY1u9cN58i2GQU0sI1r/HK/TP2+x94BX2pxCTf3iqOt3SA8yR2h6FZad1cX1eRJtiq0pjKlebO9Pi+jWEpopUQFAj1pthf32VINEB3bBLsFikQ5gDYVs7hMHFLbq/9edQ+tIYanfQ7R39+a3DxFFIpQlQ3INj1pzTO0BPQkYnGuTogbT1S73i4fhYoKC3vQbBZwMqgH+OPNBlsMU+1okt0r6g7Mkxls4CHyy5gnNPVn/CU;20:m10T+NivTA5ulvNC8b1d8a3abznIXgtvhm0V0i5I8nGZBkKNjetNbpMhrriPOLwcrvcWdEpnT+NNyanb4gaMx7yDbQKZwHElHlYcccMVcRVbOiEJhtcfkWI1TxAhps1Fj1S43soMFsg4c+smfHSP4hCH7WTE8MWTLQhvxJSdXZg=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3c0c6dc3-ba7e-4192-5ab5-08d58db0b43b
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0728;
x-ms-traffictypediagnostic: DM5PR2101MB0728:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0728542F0EE42557AD37D82EFBD40@DM5PR2101MB0728.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0728;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0728;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:SPM;SFS:(10019020)(376002)(39860400002)(396003)(346002)(39380400002)(366004)(199004)(189003)(10290500003)(26005)(6666003)(305945005)(68736007)(186003)(59450400001)(25786009)(4326008)(102836004)(66066001)(6506007)(8676002)(2900100001)(5660300001)(7736002)(2950100002)(81166006)(10090500001)(81156014)(97736004)(5250100002)(3280700002)(2501003)(76176011)(316002)(8936002)(478600001)(53936002)(99286004)(86612001)(72206003)(107886003)(110136005)(54906003)(6512007)(14454004)(6436002)(22452003)(3660700001)(3846002)(6116002)(6486002)(106356001)(1076002)(36756003)(2906002)(105586002)(86362001)(22906009)(143363002);DIR:OUT;SFP:1501;SCL:5;SRVR:DM5PR2101MB0728;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: 9t0ykqZRyYwdepsX5VT47RbWp0P/BXSwlOZF6swyXQoRYxdjZanG/KWEOtQEAIML2kmxK90pFrpew3ppx6b4wGmV3maTr2ys9H+ud5hQskX0jPFmalL/onRLlFiFP3RfvTpGSU/Um54r6gNYL8hO2OqLPrFMvM+zVkss0O4R5fE9D2oH4M3yAsjDcaDD40xX0Wy+AioC+ZDTHqVgt9fkitIF5PZFpq49cfwpBJR6XcewvjW0pWVJhbNuFUgm9JDMoxBGUh0DGlWTHRu0usJEIAoRpudIFMkSsSXl/WPkEjMEiVuXVwGvhJIXMpodJ4TtjDwU9lcLZn0kENOpQiYO4R2quHtfVVCTKuran8Beb+/KIH7eSlfPLdGf199BwCntg4Mk5fNGQwkRH//EJgirH5mqOPBUbN1VVnuOLDd+LpO4psZrrKiX1aoZ4/dyuy+R3i/gM+Ps/q1/JS2njkkA3vTKoNt3d93FFDtb82IRMwbmQperQ/c/tl4P74ZscwxX
spamdiagnosticoutput: 1:22
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c0c6dc3-ba7e-4192-5ab5-08d58db0b43b
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:47:19.5935
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0728
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Maor Gottlieb <maorg@mellanox.com>

[ Upstream commit 4e2b53a5cb5a8243284dd7ec4980d2dc556e79f0 ]

Add missing inner RSS support capability as part of
the RSS supported fields.

In addition change MLX5_RX_HASH_INNER to 1UL << 31 in
order to define it as unsigned.

Fixes: 309fa3470fca ("IB/mlx5: Add support for RSS on the inner packet")
Signed-off-by: Maor Gottlieb <maorg@mellanox.com>
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/infiniband/hw/mlx5/main.c | 3 ++-
 include/uapi/rdma/mlx5-abi.h      | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5=
/main.c
index 262c1aa2e028..f8b06102cc5d 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -682,7 +682,8 @@ static int mlx5_ib_query_device(struct ib_device *ibdev=
,
 						MLX5_RX_HASH_SRC_PORT_TCP |
 						MLX5_RX_HASH_DST_PORT_TCP |
 						MLX5_RX_HASH_SRC_PORT_UDP |
-						MLX5_RX_HASH_DST_PORT_UDP;
+						MLX5_RX_HASH_DST_PORT_UDP |
+						MLX5_RX_HASH_INNER;
 			resp.response_length +=3D sizeof(resp.rss_caps);
 		}
 	} else {
diff --git a/include/uapi/rdma/mlx5-abi.h b/include/uapi/rdma/mlx5-abi.h
index a33e0517d3fd..062d14f07b61 100644
--- a/include/uapi/rdma/mlx5-abi.h
+++ b/include/uapi/rdma/mlx5-abi.h
@@ -307,7 +307,7 @@ enum mlx5_rx_hash_fields {
 	MLX5_RX_HASH_SRC_PORT_UDP	=3D 1 << 6,
 	MLX5_RX_HASH_DST_PORT_UDP	=3D 1 << 7,
 	/* Save bits for future fields */
-	MLX5_RX_HASH_INNER		=3D 1 << 31
+	MLX5_RX_HASH_INNER		=3D (1UL << 31),
 };
=20
 struct mlx5_ib_create_qp_rss {
--=20
2.14.1
