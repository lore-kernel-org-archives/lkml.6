Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3230508-1521475764-2-17164075368808193806
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
    t=1521475763; b=xCfxv+7IAZdCwmoNMVZSjAyqkv5nxB7pZ4yBYjtWXvAGtlc
    I4eEP2dWi39ip+jihttHHyFnQFd9JRWnN+q4V4eYnPM5rEAVzkgNs7XjCnJr4X8Y
    NqTuyGnvCXQJLNcspeamNEX/DaKKTqwjwf2qcQN9RkaQGLsoF6bUGLF4tDLpzg6b
    qjrPpUG4EJew2HxFCIV86ae9P/sAevNVmHssArBEaSTOTi0A8JU+f2P6So0oiK88
    7CnAv7lUTdl/fZ4jQazhXKbTQfuYwP+uCkYirifg6dDykfbkeQdvDndkPwxWxFB6
    JYapYC7uLtTachzuqpz/hGqI6GEoga3Yd0ZG0pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521475763; bh=FZ67R+
    tGJRvPoou4U7njEzLXvAfbBRavtMsTKXenW8g=; b=dnrApf0pBOUhlC+XQjhNbu
    TStiCnCClwELu+ukHPswZfSdnobiIs9mTbqfp4wgpGgRTnf/xUsoH7IFiQg8+412
    xUQ2vziC8ooUk9/NAekdQ36w6vJoVoRb3s6B0iHHcPFPS3G4/TNH1R1+GXoEznWK
    Z5W2B9O1Hr9ju1lj8QallPRRRv+HUI3R/3177mkuDNllatgr5VaaKrtPQGKByfNR
    KN2MuXV9a6nr2c61R4+7463Fnuc0ajzl9QGJjvh9qvHVgc3Ne2+7k3v+H+QLJGND
    BCYV3JEyvnRwE6uEFsvuRHv2FBMq0lMG667u61+AS7VkFZSbU2/pW/d6Ror9OM6w
    ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=MtdyAh2E x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdekgeculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepkeeftddvnecuvehluhhsthgvrhfuihiivgepkedt;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=MtdyAh2E x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdekgeculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepkeeftddvnecuvehluhhsthgvrhfuihiivgepkedt;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966423AbeCSQJQ (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 12:09:16 -0400
Received: from mail-cys01nam02on0124.outbound.protection.outlook.com ([104.47.37.124]:59524
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966388AbeCSQJD (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:09:03 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Tariq Toukan <tariqt@mellanox.com>,
        "kernel-team@fb.com" <kernel-team@fb.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 064/167] net/mlx5: Tolerate
 irq_set_affinity_hint() failures
Thread-Topic: [PATCH AUTOSEL for 4.4 064/167] net/mlx5: Tolerate
 irq_set_affinity_hint() failures
Thread-Index: AQHTv5xEfZGoEgS9ZE+f/Ar/Lz4tXw==
Date: Mon, 19 Mar 2018 16:06:41 +0000
Message-ID: <20180319160513.16384-64-alexander.levin@microsoft.com>
References: <20180319160513.16384-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319160513.16384-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0965;7:/kgkYEj21+WsqVM9f2aYX0njxKHJGQhacWKanVmKCpo70wmG7vMo7sayxQXykCYMa8gFgqM28CPM5XNRnu/3a/bWDK+tI3hj1FVkxbHUKxYumuGfHuwEXvIcMbGlUXIUIhD+KKNIIVfFcG8OklPNlyTSW9jJunP85zMF4RDFbmZxdslyHekiu3L25ptSvP+ZGrJry0fg9nbz12lFWOUgJnPa1H5lO6ahINMiKeoYLGypApCJL1F7GgJfF9U54mVD;20:dKdR9oRI8tS7mNxC1gR12oKjrmketU6dt2BBr1GPQkDE5nTlLrS+M3BtwtZSC+K4IjaVTgiqaRGtgws/b0fyRDRG+ja9N8XIFVxNejlzVQJv3O4O7GSTA2Lm1bPdyk2vsewtAYdp1ao0CJ9OflI2XAWK5q+SaKjA3ObaLrY9H2E=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1bd8eceb-4c01-4b6e-a603-08d58db3b76e
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0965;
x-ms-traffictypediagnostic: DM5PR2101MB0965:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB09655508582A2BDDEFE1A06BFBD40@DM5PR2101MB0965.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(67672495146484);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0965;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0965;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(396003)(39860400002)(376002)(39380400002)(189003)(199004)(25786009)(7736002)(6506007)(86362001)(575784001)(86612001)(10090500001)(478600001)(53936002)(6666003)(6512007)(36756003)(2950100002)(8936002)(110136005)(54906003)(105586002)(14454004)(107886003)(72206003)(10290500003)(316002)(102836004)(2501003)(59450400001)(5250100002)(99286004)(22452003)(305945005)(6436002)(6486002)(1076002)(76176011)(26005)(4326008)(186003)(97736004)(106356001)(3660700001)(3846002)(6116002)(5660300001)(68736007)(2900100001)(8676002)(81166006)(81156014)(3280700002)(2906002)(66066001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0965;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: Elqc+9975RgYMrGmsxUpjQVIFPvUCI0/zZcEcrg+raOjs5F4LK8wqTnwdwhWkc0Fu7+ZsDykpmNmNDXbf0MYcvfMyCor095e/U+x2AEyeqGjR+E7JGZcYI5wzKbz6Et2ubbay/qE2ukOTeNDS0c/w3bCAQRVUHaCUsNe3Qky0S9aSGO47zXwhDdKgWD42ZS/0aUGKEoHqi1MYPY9/wHjT57XKXlJ2Fe02fpowbnWMMeBwPcAYF3WPn1fWzcN5MIviVCwF/O703oJZaG3sXhCqnhFCw3mOEZzKSkUZdiqVMzHsFM42d3C95cD7hXyQUtiV9rrw2LzQoNwZBNHDfmyog==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bd8eceb-4c01-4b6e-a603-08d58db3b76e
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:06:41.3884
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0965
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Tariq Toukan <tariqt@mellanox.com>

[ Upstream commit b665d98edc9ab295169be2fc5bb4e89a46de0a1a ]

Add tolerance to failures of irq_set_affinity_hint().
Its role is to give hints that optimizes performance,
and should not block the driver load.

In non-SMP systems, functionality is not available as
there is a single core, and all these calls definitely
fail.  Hence, do not call the function and avoid the
warning prints.

Fixes: db058a186f98 ("net/mlx5_core: Set irq affinity hints")
Signed-off-by: Tariq Toukan <tariqt@mellanox.com>
Cc: kernel-team@fb.com
Signed-off-by: Saeed Mahameed <saeedm@mellanox.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/main.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/main.c b/drivers/net/e=
thernet/mellanox/mlx5/core/main.c
index f5c1f4acc57b..2aa42dd321e9 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/main.c
@@ -513,7 +513,6 @@ static int mlx5_irq_set_affinity_hint(struct mlx5_core_=
dev *mdev, int i)
 	struct mlx5_priv *priv  =3D &mdev->priv;
 	struct msix_entry *msix =3D priv->msix_arr;
 	int irq                 =3D msix[i + MLX5_EQ_VEC_COMP_BASE].vector;
-	int err;
=20
 	if (!zalloc_cpumask_var(&priv->irq_info[i].mask, GFP_KERNEL)) {
 		mlx5_core_warn(mdev, "zalloc_cpumask_var failed");
@@ -523,18 +522,12 @@ static int mlx5_irq_set_affinity_hint(struct mlx5_cor=
e_dev *mdev, int i)
 	cpumask_set_cpu(cpumask_local_spread(i, priv->numa_node),
 			priv->irq_info[i].mask);
=20
-	err =3D irq_set_affinity_hint(irq, priv->irq_info[i].mask);
-	if (err) {
-		mlx5_core_warn(mdev, "irq_set_affinity_hint failed,irq 0x%.4x",
-			       irq);
-		goto err_clear_mask;
-	}
+#ifdef CONFIG_SMP
+	if (irq_set_affinity_hint(irq, priv->irq_info[i].mask))
+		mlx5_core_warn(mdev, "irq_set_affinity_hint failed, irq 0x%.4x", irq);
+#endif
=20
 	return 0;
-
-err_clear_mask:
-	free_cpumask_var(priv->irq_info[i].mask);
-	return err;
 }
=20
 static void mlx5_irq_clear_affinity_hint(struct mlx5_core_dev *mdev, int i=
)
--=20
2.14.1
