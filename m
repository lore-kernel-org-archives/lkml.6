Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3891247-1521496790-2-14370327222994305405
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521496789; b=hcDt+U/Hxf6hnZWEdoBtdtW8eaPEvX+H2XmzT1WFyzZs2ZR
    StdyhUK6gNSfmGPD5BLt1QaMX/N6cFJX6gbgyAfgjP9jfX6U7lcty6wi/oKK2J4k
    hQ6JV6Tr0ABOJayCXFUoDcFw6qrlYtuKB06+Wgn+4jQuY0XGvXusygWD2PRTVaQ5
    qBXDkyy4M+8P10ng165yy+YJ4rkzLWCGpGy5f3u22nLRirN+DmFAhpUMQMRUoqOq
    7iVDYp3XB6DQ9GwRKxO3yfBIPQexw6ES3ciOWmcXyV97nqFBykJ/2ihIoqhHPipJ
    OvFyQnnzhNSWyzqHpXlB6vHOI/TWtTu8o5HrmFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521496789; bh=V33r+Y
    /8W3TCKLqpG87jREKU8LZ6S8E5n2zvQQlYVuk=; b=M7pXKQV8kvmZbrFwKojdlO
    67cC/yVCF7OWUymTm2dO/HBpGlQ4RqNvnMRDzgLqt/4WFcsTL85KTSqlE5ZO/y/f
    j5hlGs44yc+zmcrQklSlIz+etRHloKKbFixN7nLALvS14ObUGXre6AXtBcDPDCkF
    CCdsHoeT+9c/8dYQZS8tFL0baCqH8kkYJ6oYWq6ZEHgmSplW7qtZtVtBvvId4byT
    hVYuRjyUnQtOACjKfvrM3Czk+a477NHTQxHLD28YKK6Uow7uNyIJzR8K3ft7Liu/
    vYkMbRP5ImX8LOJ/iC9fxEiZIyukq6q+7ig+hapCPNoUjFxqKtkTmR8/LpT2eJ0A
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=J1GXaB87 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduheeiucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeeludeikeenucevlhhushhtvghrufhiiigvpeehhe;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=J1GXaB87 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduheeiucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeeludeikeenucevlhhushhtvghrufhiiigvpeehhe;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934565AbeCSV7a (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 17:59:30 -0400
Received: from mail-dm3nam03on0127.outbound.protection.outlook.com ([104.47.41.127]:29856
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934475AbeCSP4G (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 11:56:06 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Daniel Jurgens <danielj@mellanox.com>,
        Leon Romanovsky <leon@kernel.org>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 60/97] net/mlx5: Fix race for multiple RoCE
 enable
Thread-Topic: [PATCH AUTOSEL for 4.14 60/97] net/mlx5: Fix race for multiple
 RoCE enable
Thread-Index: AQHTv5q/fGIyyEnzcEGLEhkIReGkSg==
Date: Mon, 19 Mar 2018 15:55:48 +0000
Message-ID: <20180319155411.12348-60-alexander.levin@microsoft.com>
References: <20180319155411.12348-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155411.12348-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0807;7:V4YcztM9pZc7SoRXh75VMjUscGtfbtag1NFadnLw9bbmdSKvE5Hv5IuLiyAZxXt9OxV5mRo7LPGzS/cUTFwIPgaDVD+VooG3pxbR+rmo5gEcy5MWTw3WwtY3a3ZCpoPUaIIfVWbKL6BW+ctaurvkNa12/QdcpV00nUpVunX0JPnFCLulP8mMjA6HtDahURKzTRFSTfM+ylQ3pw+wqrrGRZsB6EH616lGMrdg+bwnLiXNqBM8yU/+MxF1b9pw2Nqm;20:RDl2QiFQSupYk2D+t8iLg6d40NfSOla4ZzQ5wbcYZuDoNP8PyinOIcXUmCu1SNSPV5lw+By85WicLu9gubLUR6/n/0i0x1Y6mZm4PgXGMxJzwo6Y39vpjWHlGa2KnSLrjghc2G+M8GnenTauiKmIvellNJBHHrs3TF2GWUI1SrE=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 33224ab8-93be-426c-c84e-08d58db1e884
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0807;
x-ms-traffictypediagnostic: DM5PR2101MB0807:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB08070F501CDC40990B7AB401FBD40@DM5PR2101MB0807.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231221)(944501300)(52105095)(3002001)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0807;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0807;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(366004)(396003)(39380400002)(39860400002)(199004)(189003)(26005)(10290500003)(305945005)(6666003)(68736007)(186003)(102836004)(4326008)(25786009)(66066001)(6506007)(8676002)(59450400001)(2900100001)(5660300001)(7736002)(2950100002)(81166006)(10090500001)(81156014)(97736004)(2501003)(5250100002)(3280700002)(316002)(76176011)(478600001)(8936002)(99286004)(53936002)(575784001)(36756003)(86612001)(72206003)(107886003)(110136005)(54906003)(6512007)(14454004)(6436002)(22452003)(3660700001)(3846002)(6486002)(6116002)(106356001)(1076002)(105586002)(2906002)(86362001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0807;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: FUma1sqgojBdCMNT/5RBQV2vufSl6vM1eBT27Yb+oAzPzEkj4Uq93fw5hDvXUm1yJ0D+2g5qS9K2UDBkH2sMVqDNJ3pZZ2hlfxLj66QlXlb0gqQ6SZiy5dg/ud98s2uM87ePNicf3h3SUfFZp3VjEDfTgDiYjrDPfyLAcxUL7dD4Xg1k7ihuZ07aaVPTkwgwXljfyw+rONVhRPY0BzVMYM8K1lmLiQ/C8OOFpVAm/txfooOWSFbuMGOQ7jDl2vyEH1lXcBJT1jX9G5iQUA4uHXB8CIh7RiJ+Pg8887K6jOxwQpvRyzoKZX6mfaTgcxEyDk4MndjWWcWAi+sa5lL7/w==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33224ab8-93be-426c-c84e-08d58db1e884
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:55:48.9760
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0807
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Daniel Jurgens <danielj@mellanox.com>

[ Upstream commit 734dc065fc41f6143ff88225aa5d335cb1e0f6aa ]

There are two potential problems with the existing implementation.

1. Enable and disable can race after the atomic operations.
2. If a command fails the refcount is left in an inconsistent state.

Introduce a lock and perform error checking.

Fixes: a6f7d2aff623 ("net/mlx5: Add support for multiple RoCE enable")
Signed-off-by: Daniel Jurgens <danielj@mellanox.com>
Reviewed-by: Parav Pandit <parav@mellanox.com>
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/vport.c | 33 ++++++++++++++++++++-=
----
 include/linux/mlx5/driver.h                     |  2 +-
 2 files changed, 28 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/vport.c b/drivers/net/=
ethernet/mellanox/mlx5/core/vport.c
index a1296a62497d..71153c0f1605 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/vport.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/vport.c
@@ -36,6 +36,9 @@
 #include <linux/mlx5/vport.h>
 #include "mlx5_core.h"
=20
+/* Mutex to hold while enabling or disabling RoCE */
+static DEFINE_MUTEX(mlx5_roce_en_lock);
+
 static int _mlx5_query_vport_state(struct mlx5_core_dev *mdev, u8 opmod,
 				   u16 vport, u32 *out, int outlen)
 {
@@ -998,17 +1001,35 @@ static int mlx5_nic_vport_update_roce_state(struct m=
lx5_core_dev *mdev,
=20
 int mlx5_nic_vport_enable_roce(struct mlx5_core_dev *mdev)
 {
-	if (atomic_inc_return(&mdev->roce.roce_en) !=3D 1)
-		return 0;
-	return mlx5_nic_vport_update_roce_state(mdev, MLX5_VPORT_ROCE_ENABLED);
+	int err =3D 0;
+
+	mutex_lock(&mlx5_roce_en_lock);
+	if (!mdev->roce.roce_en)
+		err =3D mlx5_nic_vport_update_roce_state(mdev, MLX5_VPORT_ROCE_ENABLED);
+
+	if (!err)
+		mdev->roce.roce_en++;
+	mutex_unlock(&mlx5_roce_en_lock);
+
+	return err;
 }
 EXPORT_SYMBOL_GPL(mlx5_nic_vport_enable_roce);
=20
 int mlx5_nic_vport_disable_roce(struct mlx5_core_dev *mdev)
 {
-	if (atomic_dec_return(&mdev->roce.roce_en) !=3D 0)
-		return 0;
-	return mlx5_nic_vport_update_roce_state(mdev, MLX5_VPORT_ROCE_DISABLED);
+	int err =3D 0;
+
+	mutex_lock(&mlx5_roce_en_lock);
+	if (mdev->roce.roce_en) {
+		mdev->roce.roce_en--;
+		if (mdev->roce.roce_en =3D=3D 0)
+			err =3D mlx5_nic_vport_update_roce_state(mdev, MLX5_VPORT_ROCE_DISABLED=
);
+
+		if (err)
+			mdev->roce.roce_en++;
+	}
+	mutex_unlock(&mlx5_roce_en_lock);
+	return err;
 }
 EXPORT_SYMBOL_GPL(mlx5_nic_vport_disable_roce);
=20
diff --git a/include/linux/mlx5/driver.h b/include/linux/mlx5/driver.h
index 8f9fc6e5539a..bb6e3afe9dcb 100644
--- a/include/linux/mlx5/driver.h
+++ b/include/linux/mlx5/driver.h
@@ -794,7 +794,7 @@ struct mlx5_core_dev {
 	struct mlx5e_resources  mlx5e_res;
 	struct {
 		struct mlx5_rsvd_gids	reserved_gids;
-		atomic_t                roce_en;
+		u32			roce_en;
 	} roce;
 #ifdef CONFIG_MLX5_FPGA
 	struct mlx5_fpga_device *fpga;
--=20
2.14.1
