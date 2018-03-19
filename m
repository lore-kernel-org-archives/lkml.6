Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3891259-1521498172-2-2020250804547989357
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
    t=1521498172; b=BkYyakSo1Cr0hVVqGn5ZJ8+yAukg9IBgR0VTXRpvqOIWMbM
    3hqbjigEbZYRfaCWKjUJmbOYeqH+a/vG+i24sZ2zYB+k0Q966rPYWDa9liw3FCjR
    ZejczLEAIbCHaMUq1i2UCINVYHTSxqSOLC8menkxyqDQxXYXBcyhTwkIjKRYJwNg
    72/U4U0AiPMSY/bFvxJUzDOC52Xd4S3Q1HSW83TQGWuNIzTbsl3G5QliZTFMSpOw
    LpftL5JKWJQm5/DvX3PDcxjLBux+9oFU9vs68YM7fASHNQVijA48wDKRMZXY0jfq
    ofbFmqRnwX0+mfGY3tNwy5dU6G6dlf2DShJcfSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521498172; bh=Ahiaz9
    i6fzTpas/YQ+xSoWtdmuNq//CFzvpdHXIidhA=; b=k7oJnoT3YT4koaegG4O+a3
    scUJitF+HGYkkQHXW214mqVFu6ISdra0XUxtyeQhLp+4mran5kb7GKX082s8K7ND
    1dHUrpCtk8KKIY8TZuS3qjsXom8bLYt4i68HCQMjm5bTyms329+BS8RCzJ3zEJlU
    +EeHu2/cvPu/VLgOihwjF1Yx/PSpGhkg6Yy3rsHnCniVhp3X1x+Mw/bVSxVT0qUc
    7mOu7K+vjqkwsfyGVCmkHT1BgB6R8bnnIQKDRPQi3JsDW16mq2l7opvL4wf/1sfS
    7Aw6JDYNTYfFRKrR37vmWMxiD5rpCTaPWdlQRXPF8gu5HhKcSaaQsG02lXbX1I8w
    ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=M9MHGi5v x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduieduucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeeludejfeenucevlhhushhtvghrufhiiigvpeegie;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=M9MHGi5v x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduieduucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeeludejfeenucevlhhushhtvghrufhiiigvpeegie;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933898AbeCSWWq (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 18:22:46 -0400
Received: from mail-cys01nam02on0096.outbound.protection.outlook.com ([104.47.37.96]:43108
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933893AbeCSPtK (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 11:49:10 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Daniel Jurgens <danielj@mellanox.com>,
        Leon Romanovsky <leon@kernel.org>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 076/124] net/mlx5: Fix race for multiple RoCE
 enable
Thread-Topic: [PATCH AUTOSEL for 4.15 076/124] net/mlx5: Fix race for multiple
 RoCE enable
Thread-Index: AQHTv5m2xN1gO816y0qKNSPtUgeeqA==
Date: Mon, 19 Mar 2018 15:48:23 +0000
Message-ID: <20180319154645.11350-76-alexander.levin@microsoft.com>
References: <20180319154645.11350-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319154645.11350-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0919;7:iMX//SJrK03y6RCoWf1anWZ0l3miAyS8zzDGes35bdXNo+MT0o0MOxhS5F3GI0ISHkFlNyitB+qKfR+hsvMGR6hs4ZGI9FglftRsf4nohV+yQ2Kvwg1HFFGAnRSu19RVp45rLYcUMxt0Yu3DpifFgPDDBaSmXyNs9dY7A7d/yxgINg5xyHgAIN9dGKLnQSx/P+74Y3wVgRn7WiQLcg7SvgA2rvtiNnFYH5cBfyqeKDH4/jr7x05Jv5JEF3n3Pd7z;20:mj6jKFxpun1ykWEUQ+vJvfhZLTaRyDeADMgyseWkK9+tVNqSExxrRQQR9S0WYHcFO1O9ffRnwwv5F3tEtcWiI6IYZGs9lYXJyCOLz+rqSTfitV3Vlt6DUB5TwDlx/9vtFGIoYsoBi3XMS4G4ToRYEErx79w1NuFXVJ5QLBfsCxI=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: eacf3f75-f6a4-4612-ec8f-08d58db0ed63
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0919;
x-ms-traffictypediagnostic: DM5PR2101MB0919:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB09195A41B0AE7B8B1B0C6DA5FBD40@DM5PR2101MB0919.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0919;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0919;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(366004)(39860400002)(396003)(39380400002)(346002)(199004)(189003)(6512007)(5250100002)(106356001)(99286004)(102836004)(2501003)(6116002)(59450400001)(1076002)(3846002)(186003)(10090500001)(76176011)(6486002)(25786009)(316002)(26005)(22452003)(68736007)(6436002)(2900100001)(54906003)(2950100002)(6666003)(72206003)(81156014)(3660700001)(4326008)(7736002)(110136005)(305945005)(478600001)(3280700002)(6506007)(97736004)(81166006)(8676002)(10290500003)(575784001)(66066001)(2906002)(86362001)(105586002)(8936002)(53936002)(36756003)(14454004)(86612001)(5660300001)(107886003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0919;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: DanCEzCvD8p/AmYCc4EJLaDVCDGxYaUkJWRQ6RkQpZxJjWhyadCIzHkms7/hY8fY2Y+XxheHxvHZSfAr1iEw4PduVKoQS0f4oHijwVBPn3OG47YXAP+1ZctH4BgqTaAHrIoj7lSfc0sChs3V6/7K/j4vggh9+Dy82diI2+H7M9jLVR0oH/0dPFwbOIq5KBe3wdFw4nH8qoQQZCTHt0LfOtihZZT1R5KQQLkPKmKrqoGG066n2qKpcK6c50ixsNa6zRnjgUwV6refs9eixLAngkzeMrMCrYKuS/VnR2aXTVNDwCHlBUyXew/1sl6f2nmGiFxQncchR6SFEtkJ/utHBw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eacf3f75-f6a4-4612-ec8f-08d58db0ed63
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:48:23.5212
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0919
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
index b82c4ae92411..31d6dd4df472 100644
--- a/include/linux/mlx5/driver.h
+++ b/include/linux/mlx5/driver.h
@@ -826,7 +826,7 @@ struct mlx5_core_dev {
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
